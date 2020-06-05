Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC01F0343
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 01:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgFEXAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 19:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgFEXAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:00:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F36C08C5C4
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 16:00:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ga6so3250060pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6IOQhnINeRXTMEp588L7TpuSlWAtthgo8pJPrT+dHag=;
        b=Dmrrbc+recgD8e5AMN/BCTLy5ccUlTK2MC7rwQlOlF86Koa9ZP0RCaEl8gKBI8HCyJ
         BqY0N+IPu2tx5GuZIXcP5iK50+rIfHhm8cbNSD39W9y1j6PkGWIV6L83L5pkIkZC3tb7
         RL8cv3Tavf00q4remPzb72/VeCD1MyOHlmXgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6IOQhnINeRXTMEp588L7TpuSlWAtthgo8pJPrT+dHag=;
        b=O91ZtdW9OFlilaxl4Qlkl/4Q7hhjdwNVhS7oqqXjAI5Qj9CleeP4QXJypOO8GUdJz/
         VHSwQ1nKcJHrjyAswi/7ZxuqxnwrGMoGg732vOJd0fUHSiSjBfbQ/tmtlYPQ5vshIEl+
         p/EDFsaO4IV6IZGtaKKpPUB/Tw87WxDhCg4Z5zwkl8h4vt6ZHzGYULK77exna0G06Alo
         iT7zX/2fEXIr6pEESSzbZniys8ZJyBdlnFA8d42cpzww4RyuuXsn8ekHVxA+ixYofgla
         mUmaJvuStehYTMSyBYK30tB9lEKGOvelsWIY/7wBFGIH2AMH3nrxl7SYPPgW60KlTS5w
         3CMQ==
X-Gm-Message-State: AOAM533XYBHy+sQEOYQ+XnnG3UGWJ1O8SOlfJP4nhk/HSL0kQFEkIC3X
        DBlW0kCVgns2UdyTLQtKWk3Z8g==
X-Google-Smtp-Source: ABdhPJygqG+jk7Ot91mrwH3N/Bq6YN5N7hRpLKAhEc5LQzFkljxQcq6rvccd49GdwHGxUxMHVl3f9A==
X-Received: by 2002:a17:90a:8c12:: with SMTP id a18mr3957336pjo.198.1591398036980;
        Fri, 05 Jun 2020 16:00:36 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b140sm568974pfb.119.2020.06.05.16.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:00:36 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v6 8/8] ima: add FIRMWARE_PARTIAL_READ support
Date:   Fri,  5 Jun 2020 15:59:59 -0700
Message-Id: <20200605225959.12424-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605225959.12424-1-scott.branden@broadcom.com>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add FIRMWARE_PARTIAL_READ support for integrity
measurement on partial reads of firmware files.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/main.c |  6 +++++-
 fs/exec.c                           |  6 ++++--
 include/linux/fs.h                  |  1 +
 security/integrity/ima/ima_main.c   | 24 +++++++++++++++++++++++-
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 93e7fee42cd4..d0c42194af17 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -483,7 +483,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	/* Already populated data member means we're loading into a buffer */
 	if (!decompress && fw_priv->data) {
 		buffer = fw_priv->data;
-		id = READING_FIRMWARE_PREALLOC_BUFFER;
+		if (fw_priv->opt == KERNEL_PREAD_PART)
+			id = READING_FIRMWARE_PARTIAL_READ;
+		else
+			id = READING_FIRMWARE_PREALLOC_BUFFER;
+
 		msize = fw_priv->allocated_size;
 	}
 
diff --git a/fs/exec.c b/fs/exec.c
index e5c241c07b75..3fbc2fee909f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -968,7 +968,8 @@ int kernel_pread_file(struct file *file, void **buf, loff_t *size,
 		goto out;
 	}
 
-	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
+	if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+	    (id != READING_FIRMWARE_PREALLOC_BUFFER))
 		*buf = vmalloc(alloc_size);
 	if (!*buf) {
 		ret = -ENOMEM;
@@ -1000,7 +1001,8 @@ int kernel_pread_file(struct file *file, void **buf, loff_t *size,
 
 out_free:
 	if (ret < 0) {
-		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+		    (id != READING_FIRMWARE_PREALLOC_BUFFER)) {
 			vfree(*buf);
 			*buf = NULL;
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 76d463e4a628..3affcaa7c7b2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3020,6 +3020,7 @@ extern int do_pipe_flags(int *, int);
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
+	id(FIRMWARE_PARTIAL_READ, firmware)	\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 800fb3bba418..982debd59cc4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -609,6 +609,9 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	enum ima_hooks func;
+	u32 secid;
+
 	/*
 	 * READING_FIRMWARE_PREALLOC_BUFFER
 	 *
@@ -617,11 +620,27 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	 * of IMA's signature verification any more than when using two
 	 * buffers?
 	 */
-	return 0;
+	if (read_id != READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
+	if (!file) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
+
+	func = read_idmap[read_id] ?: FILE_CHECK;
+	security_task_getsecid(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PARTIAL_READ] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
@@ -648,6 +667,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
+	if (!file && read_id == READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-- 
2.17.1

