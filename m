Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1199FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391895AbfHVTZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:25:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37466 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391707AbfHVTZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so4239194pgp.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V6iaCvkOKV70LTF1R2QxVbxqJJklSryV7VrfrPuNBPI=;
        b=WM1U6q3fPx6VAdWuhVbasFSZ7o86MDefD/45MBjids0aZXHG3L567a42cBKkzs82Zy
         zepTPT7of9GWrAA3oxb/hR24FzE6TL1jBjFt/La5FVBTSo5fAU9pLUw8QsoTi8c39do6
         K6CLNpIF2TTudMamXSJHhT0QSIy/Gk+Qg06W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V6iaCvkOKV70LTF1R2QxVbxqJJklSryV7VrfrPuNBPI=;
        b=DjxUW/ww9ytmDc9XduqI8SfOZVIj8saFWA2x0ZPikeCju9AAzNr/vKXpmzuSBVxAZS
         Ld+ZeItwzKeYIeDKd1SMe6CriDKLI4v5t+ekOiCmeRV+5yj2XhVv52f52hXLEiZxub1u
         CS4xp93c0vzyVo+3Q29eF1p7qdjvj62I7Jd3uEMJVsQM5um/mRWHPjLmQqJrxTZK70Be
         p1bXhbU+Ne0nMAWPVfyiNOa/y3TcW3fWFOpKmvRCDcYFz5MoqyEB5jGV0tzDZ3UT7YQU
         l4qcOhZR8FGJ56ZBAK13IYbPNi+frx2oN/BzETmPQnlBIRu7zS2+yDatGNKon+vH7hjK
         +qQg==
X-Gm-Message-State: APjAAAU+qriKPRwY3tuDukcMrYOuDPIOhqCHOaFeTeqeY5Jz/RSIr3SF
        4rDV6NWvxgA24KVPnHO/V0ttUQ==
X-Google-Smtp-Source: APXvYqzSHf/VaI25XUU6JwgxHcTwum+eqwNg/nDEX2+Z4NtuYsQqfDBBgWEP7OESrOUbhgp0aExEbQ==
X-Received: by 2002:a62:7503:: with SMTP id q3mr859120pfc.151.1566501906434;
        Thu, 22 Aug 2019 12:25:06 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:05 -0700 (PDT)
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
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/7] firmware: add partial read support in request_firmware_into_buf
Date:   Thu, 22 Aug 2019 12:24:44 -0700
Message-Id: <20190822192451.5983-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds partial read support in request_firmware_into_buf.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also, no tests existed for existing request_firmware_into_buf kernel API.
Therefore tests have been created and submitted upstream here:
"[PATCH v2 0/2] firmware: selftest for request_firmware_into_buf"
https://lkml.org/lkml/2019/8/22/1367

The firmware selftests patches here require those patches to
be applied first in order for the firmware selftest patches in this
series to be valid.

Finally, in this patch series is the addition of a new Broadcom Valkyrie driver
utilizing the new request_firmware_into_buf enhanced API.

Scott Branden (7):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  selftests: firmware: Test partial file reads of
    request_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom Valkyrie driver
  MAINTAINERS: bcm-vk: Add maintainer for Broadcom Valkyrie Driver

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   49 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   16 +
 drivers/misc/bcm-vk/Makefile                  |    7 +
 drivers/misc/bcm-vk/README                    |   29 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  229 +++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1558 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              |  963 ++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  169 ++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  273 +++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |   77 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   15 +
 include/uapi/linux/misc/bcm_vk.h              |   88 +
 lib/test_firmware.c                           |  139 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 21 files changed, 3744 insertions(+), 37 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/README
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

