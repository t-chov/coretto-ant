FROM amazonlinux:2
RUN yum -y update \
    && amazon-linux-extras enable corretto8 \
    && yum -y install java-1.8.0-amazon-corretto-devel wget tar \
    && yum clean all \
    && rm -rf /var/cache/yum/

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64
ENV ANT_VERSION=1.10.3
ENV ANT_HOME=/opt/ant

WORKDIR /tmp

RUN wget --no-check-certificate --no-cookies http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
    && tar -zvxf apache-ant-${ANT_VERSION}-bin.tar.gz -C /opt/ \
    && ln -s /opt/apache-ant-${ANT_VERSION} /opt/ant \
    && rm -f apache-ant-${ANT_VERSION}-bin.tar.gz

RUN update-alternatives --install "/usr/bin/ant" "ant" "/opt/ant/bin/ant" 1 && \
    update-alternatives --set "ant" "/opt/ant/bin/ant"

WORKDIR /root
