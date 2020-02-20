Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDF1653CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 01:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBTAtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 19:49:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41572 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgBTAsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so816884plr.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 16:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vtLdxE8NcgG4MaYSVKSLjU81B48Np5rgOoIwwUUSx2g=;
        b=f/CTdWEquUN7TQwz9tokFrNs2KRc6CSwUWqF32/piX+QxpgcLNjdkwpGcAUQfE7IZB
         9aH0Xf9gvg+8cupvMcT4Mqp6EiySd4CGWd7ePOe5AMF3RPQxHfsjHJAnNHmqkVJiR9nD
         qKT4mHCLU08sRbZKsDgSdB8sw0RapSRSzYEHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vtLdxE8NcgG4MaYSVKSLjU81B48Np5rgOoIwwUUSx2g=;
        b=F+mJXfIdhXHXoW+B/o6TQWb9qY/430EFQHQPp++gYNIQuTe0kHI5jaZnZy6OjgHOaE
         UOpxGCshk78C6fkQ+qg4y4nLSydwuFjGp/q40yIY+ibFS/mweJPB6KFDF++0kRbv/b0e
         N3sXRDQUBxfLoUetafilVDHTUDgPkOQ4JuNdosCsEQ/D3O2as9KJV541rIJe3oJhELez
         AJX+ckQ2xKklW2aX9WGNDtsNi/NXoAOLRQoMZf+c0YCdDN3t59YsKY41wyn+zLDlA7K5
         sZ3pZQNz1AVLICphpdPTwxOJ6FG0ZwZTo5LbbYZc3XBCLKkQcH+fws7vH/ytwC0yFPv+
         k5lg==
X-Gm-Message-State: APjAAAXYlc+MsPPw7SvRgHEGiYwY1Jat6XcPX1IMZzog7WYxS3htRKuN
        p5fIC67oYg3A31ngLrMf8Ww4Sg==
X-Google-Smtp-Source: APXvYqyQhnBgZfEfDeor8jMZwe/TeRkFjgJPIiK1yWrU4BH8ZhHPRYAx41tqvFlNzTKcIPmGuZ5m3w==
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr29360073plb.123.1582159733096;
        Wed, 19 Feb 2020 16:48:53 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:52 -0800 (PST)
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
Subject: [PATCH v2 5/7] bcm-vk: add bcm_vk UAPI
Date:   Wed, 19 Feb 2020 16:48:23 -0800
Message-Id: <20200220004825.23372-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220004825.23372-1-scott.branden@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add user space api for bcm-vk driver.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 include/uapi/linux/misc/bcm_vk.h | 117 +++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
new file mode 100644
index 000000000000..56a2178e06f5
--- /dev/null
+++ b/include/uapi/linux/misc/bcm_vk.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#ifndef __UAPI_LINUX_MISC_BCM_VK_H
+#define __UAPI_LINUX_MISC_BCM_VK_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct vk_image {
+	__u32 type;     /* Type of image */
+#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
+#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
+	char filename[64]; /* Filename of image */
+};
+
+/* default firmware images names */
+#define VK_BOOT1_DEF_VALKYRIE_FILENAME	"vk-boot1.bin"
+#define VK_BOOT2_DEF_VALKYRIE_FILENAME	"vk-boot2.bin"
+
+#define VK_BOOT1_DEF_VIPER_FILENAME	"vp-boot1.bin"
+#define VK_BOOT2_DEF_VIPER_FILENAME	"vp-boot2.bin"
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
+#define VK_BAR_FWSTS			0x41C
+/* VK_FWSTS definitions */
+#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
+#define VK_FWSTS_RELOCATION_EXIT	BIT(1)
+#define VK_FWSTS_INIT_START		BIT(2)
+#define VK_FWSTS_ARCH_INIT_DONE		BIT(3)
+#define VK_FWSTS_PRE_KNL1_INIT_DONE	BIT(4)
+#define VK_FWSTS_PRE_KNL2_INIT_DONE	BIT(5)
+#define VK_FWSTS_POST_KNL_INIT_DONE	BIT(6)
+#define VK_FWSTS_INIT_DONE		BIT(7)
+#define VK_FWSTS_APP_INIT_START		BIT(8)
+#define VK_FWSTS_APP_INIT_DONE		BIT(9)
+#define VK_FWSTS_MASK			0xFFFFFFFF
+#define VK_FWSTS_READY			(VK_FWSTS_INIT_START | \
+					 VK_FWSTS_ARCH_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL1_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL2_INIT_DONE | \
+					 VK_FWSTS_POST_KNL_INIT_DONE | \
+					 VK_FWSTS_INIT_DONE | \
+					 VK_FWSTS_APP_INIT_START | \
+					 VK_FWSTS_APP_INIT_DONE)
+/* Deinit */
+#define VK_FWSTS_APP_DEINIT_START	BIT(23)
+#define VK_FWSTS_APP_DEINIT_DONE	BIT(24)
+#define VK_FWSTS_DRV_DEINIT_START	BIT(25)
+#define VK_FWSTS_DRV_DEINIT_DONE	BIT(26)
+#define VK_FWSTS_RESET_DONE		BIT(27)
+#define VK_FWSTS_DEINIT_TRIGGERED	(VK_FWSTS_APP_DEINIT_START | \
+					 VK_FWSTS_APP_DEINIT_DONE  | \
+					 VK_FWSTS_DRV_DEINIT_START | \
+					 VK_FWSTS_DRV_DEINIT_DONE)
+/* Last nibble for reboot reason */
+#define VK_FWSTS_RESET_REASON_SHIFT	28
+#define VK_FWSTS_RESET_REASON_MASK	(0xF << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_SYS_PWRUP	(0x0 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_MBOX_DB		(0x1 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_M7_WDOG		(0x2 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_TEMP		(0x3 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_FLR		(0x4 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_HOT		(0x5 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_WARM		(0x6 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_COLD		(0x7 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L1		(0x8 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L0		(0x9 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_UNKNOWN		(0xF << VK_FWSTS_RESET_REASON_SHIFT)
+
+#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
-- 
2.17.1

