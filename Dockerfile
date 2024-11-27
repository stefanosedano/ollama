# Start from an Ubuntu base image with NVIDIA CUDA
FROM nvidia/cuda:12.6.2-cudnn-devel-ubuntu22.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update Ubuntu packages and install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        curl \
        git \
        wget \
        ca-certificates \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libgdbm-dev \
        libdb5.3-dev \
       libbz2-dev \
        libexpat1-dev \
        liblzma-dev \
        tk-dev \
        libffi-dev 
#    wget && \
#    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
#    apt-get install -y nodejs && \
#    rm -rf /var/lib/apt/lists/*

# Download and install Python 3.12.0
RUN wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz && \
    tar -xvf Python-3.11.0.tgz && \
    cd Python-3.11.0 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.11.0 Python-3.11.0.tgz

# Create directories for both services
WORKDIR /app

#RUN pip3.11 install git+https://github.com/open-webui/open-webui.git 

RUN pip3.11 install open-webui

RUN curl -fsSL https://ollama.com/install.sh | sh 




# Expose necessary ports
EXPOSE 8080 11434

#RUN open-webui serve

# Set the startup script as the entrypoint
#ENTRYPOINT ["/bin/bash", "/app/start.sh"]
