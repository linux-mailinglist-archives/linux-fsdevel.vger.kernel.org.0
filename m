Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A611F0536
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 07:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgFFFHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 01:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgFFFHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 01:07:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FACC08C5C4
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 22:07:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e9so6121696pgo.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7w1pN6TotzpiP8sLo1RA7p/wzGRtcCXptjHTFNygcBg=;
        b=NGT8PX7IuxdZvUvnE+9nljMW33phBXq08GFl7NiLdp4D93EXGgpos4K81h9NlWK1hG
         5PutkZ1ZGL8Z2Xu66AFY4+EPs9Lbba6aYdHNZaivUor0C1sSPBh88zP98A52Et54gs9S
         is1pzLGrQffKx6ad6j5zvcZtMjhFcK+uh0CdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7w1pN6TotzpiP8sLo1RA7p/wzGRtcCXptjHTFNygcBg=;
        b=OxP7u7cJ7zFJSEES3aLaCBlIefgpVo9DAT3xYU5sMxRq7Y+tcRdfS0SIICpfH9rVtr
         7MiI+E2QZp6I7aH2jcsr9mw2D1K5HQlVfJGu62CCSo58ik4nUnPGy8dmtBBELAU7hql/
         KzVTKyL0QGh7kuwyL0sPvkfOpzk+I5wMqNswWIFtqANqd4esgyBYpvVpVQ4im7Hr1Jsd
         0fpib3rL3CiY0sa5N64agpgt0GfqVNzIbCHpnsNdXHGT9tTf2u9dMBFIcSHHk6Ku+hdc
         fyi11RIHqREc7iJt6ypiYrgd3Zmw/UNvXr9bWmhUDljJxzlM9IzNJzuEGH6gyPt54gX3
         HUYw==
X-Gm-Message-State: AOAM530a7raTVMaewaclc+ZK0v2x8SASARfgVyKmJln1Lbb5lQQQYGXh
        tvWbsQpPI33IuFjjzg+NZ+CqOQ==
X-Google-Smtp-Source: ABdhPJzkBAIGqCS+lOJr2U5KizL/ys0e8zYXSUIMTRAJ2mZmzJHn6qNrXl0+JbIGw2l5Kkz3LAyhDg==
X-Received: by 2002:a62:8454:: with SMTP id k81mr12522487pfd.140.1591420049341;
        Fri, 05 Jun 2020 22:07:29 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm1057636pfn.217.2020.06.05.22.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 22:07:28 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
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
Subject: [PATCH v7 8/8] ima: add FIRMWARE_PARTIAL_READ support
Date:   Fri,  5 Jun 2020 22:04:58 -0700
Message-Id: <20200606050458.17281-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200606050458.17281-1-scott.branden@broadcom.com>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
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
index 751f5ddc7538..06e2465d8d40 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -970,7 +970,8 @@ int kernel_pread_file(struct file *file, void **buf, loff_t *size,
 		goto out;
 	}
 
-	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
+	if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+	    (id != READING_FIRMWARE_PREALLOC_BUFFER))
 		*buf = vmalloc(alloc_size);
 	if (!*buf) {
 		ret = -ENOMEM;
@@ -1002,7 +1003,8 @@ int kernel_pread_file(struct file *file, void **buf, loff_t *size,
 
 out_free:
 	if (ret < 0) {
-		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+		    (id != READING_FIRMWARE_PREALLOC_BUFFER)) {
 			vfree(*buf);
 			*buf = NULL;
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index aee7600958ef..1180091d704d 100644
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
index 800fb3bba418..fc5134807acf 100644
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
 
+	if (read_id == READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-- 
2.17.1

