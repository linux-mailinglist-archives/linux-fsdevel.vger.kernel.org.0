Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC61B11D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDTQk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgDTQkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2278C02C444
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so10932550wrb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qz7MuNPVCvdbh+ZgEThp7mjF9Pplt5mjBACsV2Ifvtc=;
        b=K1G7eFDXR8+bd8feOEN5wKPIxBcLxmgtB8SGFkgRhNmhf9uC7HIz7CtPG9aPipRt9R
         2zX+Nd6GXdLK9hMzj9VlxgbB/swXBYHtIfYejLl2RLLJYJOceI9oG5ut2AvQRSTlYHkq
         FMJsIudaFuY5Py/vkAWHUwAB+wnqBANE1mGHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qz7MuNPVCvdbh+ZgEThp7mjF9Pplt5mjBACsV2Ifvtc=;
        b=oNPq4VoR+FyxDLkNoHwen5fr2qGF+p/Kg8msgc1kXixbTXMueMw2UDNjtL6UjzlW+q
         3kpIX50c6E61oLaYFbgG7aiOfjc7EGddNPTfs7DWNO4a7WeHff4dqudeUCe2oRgaK4kX
         fDjWtL8KJYAXT2z90idZrjpmQcCzASfehe4yiWtpFqmiGNAdNJbjnypUSShWQOXtiVDb
         MR7rE0jHsJdP4q8/cZiQ0H6muv1XTL2dp2J9qdtj097RQwRAnk/Zx46upEjVYjFJW/8S
         BPxZ2VM7atBtvuQTQlkLwXJ5+J0MUnUrOwkErkC4YXsmSO1FYqaC0+1cUsTC94L0Db8I
         zFEQ==
X-Gm-Message-State: AGi0PuZP71ErYQi1/D94hXUqixalWMy5nuhQpmlwCo647FmeiD477wQm
        w92/ajnBxHAga2iOAze8AbyhWw==
X-Google-Smtp-Source: APiQypJ46sCa572uZJrphnwyHy7Rjzw5rXzM57WaOIuFA/N+L96n/8/uJquKHxtoDeg4c8lVTw9Nvw==
X-Received: by 2002:adf:9cc8:: with SMTP id h8mr18844072wre.167.1587400136409;
        Mon, 20 Apr 2020 09:28:56 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 36sm14882wrc.35.2020.04.20.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:28:55 -0700 (PDT)
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
Subject: [PATCH v3 5/7] bcm-vk: add bcm_vk UAPI
Date:   Mon, 20 Apr 2020 09:28:07 -0700
Message-Id: <20200420162809.17529-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420162809.17529-1-scott.branden@broadcom.com>
References: <20200420162809.17529-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add user space api for bcm-vk driver.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
new file mode 100644
index 000000000000..783087b7c31f
--- /dev/null
+++ b/include/uapi/linux/misc/bcm_vk.h
@@ -0,0 +1,99 @@
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
+#define BCM_VK_MAX_FILENAME 64
+
+struct vk_image {
+	__u32 type; /* Type of image */
+#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
+#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
+	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
+};
+
+struct vk_reset {
+	__u32 arg1;
+	__u32 arg2;
+};
+
+#define VK_MAGIC		0x5e
+
+/* Load image to Valkyrie */
+#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
+
+/* Send Reset to Valkyrie */
+#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
+
+/*
+ * message block - basic unit in the message where a message's size is always
+ *		   N x sizeof(basic_block)
+ */
+struct vk_msg_blk {
+	__u8 function_id;
+#define VK_FID_TRANS_BUF	5
+#define VK_FID_SHUTDOWN		8
+	__u8 size;
+	__u16 trans_id; /* transport id, queue & msg_id */
+	__u32 context_id;
+	__u32 args[2];
+#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
+#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
+#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
+#define VK_CMD_MASK		0x0f00 /* command mask */
+};
+
+#define VK_BAR_FWSTS			0x41c
+#define VK_BAR_COP_FWSTS		0x428
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
+#define VK_FWSTS_MASK			0xffffffff
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
+#define VK_FWSTS_RESET_REASON_MASK	(0xf << VK_FWSTS_RESET_REASON_SHIFT)
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
+#define VK_FWSTS_RESET_UNKNOWN		(0xf << VK_FWSTS_RESET_REASON_SHIFT)
+
+#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
-- 
2.17.1

