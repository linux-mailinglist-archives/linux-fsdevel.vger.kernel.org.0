Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B008B99FEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404375AbfHVTZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:25:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44433 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404319AbfHVTZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so4224278pgl.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/tIfWiDT7rhi/abpdmQcXHDvll3scxVbBQp4igt8ciU=;
        b=bqniYupzhzFo73B02qXJRg6LDQw9VxDM0+7esSTGT6Ps6bYVMkEekcpx31lkcFmWkv
         7SNJN6qVa3moqhjKAOIFDDCoSXg40jxDKh07tXdmszoHWAyUwJ3p9Ul7phjSkTMOoPf9
         DRDocSsYUeMKoF7drMnUNK+sSXyjh1FDCJvoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/tIfWiDT7rhi/abpdmQcXHDvll3scxVbBQp4igt8ciU=;
        b=GtAEA0qPkFO+vs18Wz41VhsKq29q6Rgjr9w/NPprwoxZRpYcZ5pzTEwavGoCgeziD6
         A4P7t80SNXmKnT2M6PwFuNqdcMI9Wh7e0QkZvIfXxwa06rQAP8aAbKZY0sGl/YKL0zvF
         JyamynHOBvFXGfXBw7LUAnav/01QuNScpqM6aumjw9Au8TvUVnquSgS/DHJzJXdKPfcB
         BVrewdVB8Y1nUkWs0Mgmq8nFN3A0c/VYkxRJgWpXvIzmGIpzVGsi8AvMRpTU0Jsth41E
         6XELWxJcnys0NERddMK2bwRBIabL8T2VTeqvUWOigg+cwwqip0aYJXA1GcFR4czh2dDj
         Omnw==
X-Gm-Message-State: APjAAAX0xEP2VuCC5k0J76NG66ykTTYcU1I7+2lL4wB3gVzIRXtLmK2d
        CEHAaSn8KkI+Z/DW6qmi+Q9ebQ==
X-Google-Smtp-Source: APXvYqxvyPhjwJ4w7bJbI1T+twRUXk2u+vaBSyJc6vQBeCbOiTrbirkMaygnOedgYeGUk6QXZ7Wf7A==
X-Received: by 2002:a17:90a:2767:: with SMTP id o94mr1264139pje.25.1566501918992;
        Thu, 22 Aug 2019 12:25:18 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:18 -0700 (PDT)
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
Subject: [PATCH 5/7] bcm-vk: add bcm_vk UAPI
Date:   Thu, 22 Aug 2019 12:24:49 -0700
Message-Id: <20190822192451.5983-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822192451.5983-1-scott.branden@broadcom.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add user space api for bcm-vk driver.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 include/uapi/linux/misc/bcm_vk.h | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
new file mode 100644
index 000000000000..df7dfd7f0702
--- /dev/null
+++ b/include/uapi/linux/misc/bcm_vk.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/*
+ * Copyright(c) 2018 Broadcom
+ */
+
+#ifndef __UAPI_LINUX_MISC_BCM_VK_H
+#define __UAPI_LINUX_MISC_BCM_VK_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct vk_metadata {
+	/* struct version, always backwards compatible */
+	__u32 version;
+
+	/* Version 0 fields */
+	__u32 card_status;
+#define VK_CARD_STATUS_FASTBOOT_READY BIT(0)
+#define VK_CARD_STATUS_FWLOADER_READY BIT(1)
+
+	__u32 firmware_version;
+	__u32 fw_status;
+	/* End version 0 fields */
+
+	__u64 reserved[14];
+	/* Total of 16*u64 for all versions */
+};
+
+struct vk_image {
+	__u32 type;     /* Type of image */
+#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
+#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
+	char filename[64]; /* Filename of image */
+};
+
+/* default firmware images names */
+#define VK_BOOT1_DEF_FILENAME	    "vk-boot1.bin"
+#define VK_BOOT2_DEF_FILENAME	    "vk-boot2.bin"
+
+struct vk_access {
+	__u8 barno;     /* BAR number to use */
+	__u8 type;      /* Type of access */
+#define VK_ACCESS_READ 0
+#define VK_ACCESS_WRITE 1
+	__u32 len;      /* length of data */
+	__u64 offset;   /* offset in BAR */
+	__u32 *data;    /* where to read/write data to */
+};
+
+struct vk_reset {
+	__u32 arg1;
+	__u32 arg2;
+};
+
+#define VK_MAGIC              0x5E
+
+/* Get metadata from Valkyrie (firmware version, card status, etc) */
+#define VK_IOCTL_GET_METADATA _IOR(VK_MAGIC, 0x1, struct vk_metadata)
+
+/* Load image to Valkyrie */
+#define VK_IOCTL_LOAD_IMAGE   _IOW(VK_MAGIC, 0x2, struct vk_image)
+
+/* Read data from Valkyrie */
+#define VK_IOCTL_ACCESS_BAR   _IOWR(VK_MAGIC, 0x3, struct vk_access)
+
+/* Send Reset to Valkyrie */
+#define VK_IOCTL_RESET        _IOW(VK_MAGIC, 0x4, struct vk_reset)
+
+/*
+ * message block - basic unit in the message where a message's size is always
+ *		   N x sizeof(basic_block)
+ */
+struct vk_msg_blk {
+	__u8 function_id;
+#define VK_FID_TRANS_BUF 5
+#define VK_FID_SHUTDOWN  8
+	__u8 size;
+	__u16 queue_id:4;
+	__u16 msg_id:12;
+	__u32 context_id;
+	__u32 args[2];
+#define VK_CMD_PLANES_MASK 0x000F /* number of planes to up/download */
+#define VK_CMD_UPLOAD      0x0400 /* memory transfer to vk */
+#define VK_CMD_DOWNLOAD    0x0500 /* memory transfer from vk */
+#define VK_CMD_MASK        0x0F00 /* command mask */
+};
+
+#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
-- 
2.17.1

