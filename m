Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A731B11E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgDTQky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726743AbgDTQkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B6C061A41
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so12920389wrw.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y6BXvIfk0R/gZ0twMeBQX3iT31MGytnoVIMSO2j5UM0=;
        b=aum878dLf5/Y73XSxFsTat47TJHjOeeg6LINMRbsCZDiJlT48QPf0++SYSxzUx6CvN
         bP3h04KO1U856CbHH3qzKQxtE2Stix58x5qHJ4KxpWNlK7l9DFAVmhwM9jnbliYXnJmb
         VzRvCxVX2K9PVqBCJYdvPhCKFzQBjxMWyUR+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y6BXvIfk0R/gZ0twMeBQX3iT31MGytnoVIMSO2j5UM0=;
        b=NII65ZJWKB5tuI0GpFlA7UOqAFIQSCUvvtrAiRjYGyc6qqJzC19jXJc+RqPxjEDR17
         l2C2nSGflB7DDDzFeaJ/fu+n6I5dBPqkWVThtC6XOUUSc4akxnN/xx8qNZUDoAQAsClX
         DtpfThrAUQ28fg0PR2JmAunH7xyN8geJmdxISkEXAX234z+AcOx0H9p9PI6mmyNUMSK2
         d0PKD0vuujm3kCCrHxw9OVycJJo72BMnWSKtvllRVSTimUQzEHBsxNKgzn3hBHS1cYn4
         uLCsGRZntxLnRUwEWh33Z4NCAwoxctPLq2qIAScM8rPUyUtAqw8TWpbjzNhJg1eCGAs0
         3H1Q==
X-Gm-Message-State: AGi0PuaS3f1DIukUHZBQkFEvMwK/WQgk3bG1YjODvVAI4mGVW5B0Nxuj
        6zRuexYLeeyYlbC7lFgDyjfy1Q==
X-Google-Smtp-Source: APiQypK0GeQ9aWgjyRkEgInVfvj7aKu6g0F7ig6yHsVbodIn5FHUwC9TJ6Lfy8OKLglWlXCBO27LYw==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr19362693wrw.389.1587400108867;
        Mon, 20 Apr 2020 09:28:28 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 36sm14882wrc.35.2020.04.20.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:28:27 -0700 (PDT)
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
Subject: [PATCH v3 0/7] firmware: add partial read support in request_firmware_into_buf
Date:   Mon, 20 Apr 2020 09:28:02 -0700
Message-Id: <20200420162809.17529-1-scott.branden@broadcom.com>
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

Changes from v2:
 - remove unnecessary code and mutex locks in lib/test_firmware.c
 - remove VK_IOCTL_ACCESS_BAR support from driver and use pci sysfs instead
 - remove bitfields
 - remove Kconfig default m
 - adjust formatting and some naming based on feedback
 - fix error handling conditions
 - use appropriate return codes
 - use memcpy_toio instead of direct access to PCIE bar
 - 

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
 drivers/base/firmware_loader/main.c           |   52 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   41 +
 drivers/misc/bcm-vk/Makefile                  |   12 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  406 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1179 ++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_legacy.c           |   89 ++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1420 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  215 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  271 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  323 ++++
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |   96 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   20 +
 include/uapi/linux/misc/bcm_vk.h              |   99 ++
 lib/test_firmware.c                           |  144 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 22 files changed, 4487 insertions(+), 49 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_legacy.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

