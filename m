Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC201653C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 01:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgBTAsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 19:48:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36004 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgBTAsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so1007159pgu.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MCnc7lIWYjCyOM/3eUwsK77pJjRdrQHPG+GhI2DPtOU=;
        b=iRWHPF4ZxnvlZs+BPBJTKw5+kW68aECGGTAzv+JtpeB/RwX8M734IfDoYVGoNPk9F4
         VmtB9RXFMaXFNiYpqLN8V3xETnXZBktVcU7NO+/YUMNsmOPqCOXxw9UHsWVgXYgsziFx
         UKfQ//Feovjz4wGRg9goWtbJLBqZfrJ3YZQ6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MCnc7lIWYjCyOM/3eUwsK77pJjRdrQHPG+GhI2DPtOU=;
        b=CcpP7xGPBlYUe9QS9iQV181RFo8voxULulCmPsrBw2CsDDNB4kAFHAl/d/Shq0dVZN
         fqnbNQ3TpVRP0g497dkMbotiCdL/C949lIIUyp2sM9FTq2BS1A8iWAO+leq0dCyp0I++
         RvqzCYl+yeMhXwLZHgD+UmS8IQjyk7SJ9UXyL1LicPDIpCz7QacuDG/FS8Hf8JeiWFbG
         UMT1HTdAjjLEB7272RTciw/re81wy1XNZwkIFbknti4enbyOHmTYA+nf23A0Tme2dF+w
         0Zxf5LKljqrGZoiYP77FynlUVUIVAmWlR/cumLq7d2jQ2nbNSEOP5XXDeyjC1tk7by3+
         VPEg==
X-Gm-Message-State: APjAAAVncnholakdpvK4PCyudN5mPu+r09oNkLmOyi82Mge/lRQuioo/
        LViuj7FR7Rhcpdbe+k/vUHPEDg==
X-Google-Smtp-Source: APXvYqyPmPeQJdr9Oa52QoVxIdceLP7MLylnFV/IINfia5v++zGBusoLcQHbou1xSZoghCPOQ3Iu3w==
X-Received: by 2002:a63:ae0a:: with SMTP id q10mr30424929pgf.178.1582159719593;
        Wed, 19 Feb 2020 16:48:39 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:38 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 0/7] firmware: add partial read support in request_firmware_into_buf
Date:   Wed, 19 Feb 2020 16:48:18 -0800
Message-Id: <20200220004825.23372-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds partial read support in request_firmware_into_buf.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also in this patch series is the addition of a new Broadcom VK driver
utilizing the new request_firmware_into_buf enhanced API.

Scott Branden (7):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  firmware: test partial file reads of request_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   49 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   42 +
 drivers/misc/bcm-vk/Makefile                  |   11 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  357 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1197 +++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1359 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  210 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  273 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  327 ++++
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |   77 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   15 +
 include/uapi/linux/misc/bcm_vk.h              |  117 ++
 lib/test_firmware.c                           |  139 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 21 files changed, 4305 insertions(+), 37 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

