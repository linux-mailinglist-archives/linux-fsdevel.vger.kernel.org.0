Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697C6224254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGQRoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgGQRnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469F6C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so6887565pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ye5MMqp75FSC0nZmUKJZpPyaOqOv72KYmvLAzdzwzgM=;
        b=cARyOXDEMA9HsSOs8Z9kzh/i4ez2+EXz2dzr7L7FLrV5aSV0ahHPqlAQp6fKKttHFJ
         dnf/naRxMY3RaFe7uPzBaJusxDyTdYsF+CSt4drFPiYdrFIVi3y2ecXpt0igUbZAKJ9R
         XimKVxgwlmf3RL9uVLspdDjEAeIety4B8iTog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ye5MMqp75FSC0nZmUKJZpPyaOqOv72KYmvLAzdzwzgM=;
        b=dpVuM/lPYWknmmOLgjHHO3/wqOLoycGcJtcX0TZuZ1kRNySwaYkW9Hvchn73OrowH4
         HvIj0XUYHP649wD6sl6KW2DRF5/IStImTFuIASE4Mgr7lu/whif/Afd8v9AUNN1HCHsY
         1WB6GMau3LCQ2g3NDYtGpp3asd6ylOqK4rzw7OwOAP/vENaKUDEfPdtRTuH2ACumwDVq
         9luq/OaSmSSTMy4hO14FnHJAttCL0BG7M4yYBw7g+Y+5nmH1uv0q63VqMHZmr20wFIop
         12BXXATxxEp+6R2iQd3i+cV6HdX6VTmYTb+FRR3mK259HXAbQ4gwc8nvOcVCX2c/ycLn
         rsfw==
X-Gm-Message-State: AOAM5303ptM57CpBVVFlkLZvOeH9+c3/UhJ4LrTkc5o0F3M6K+amclSV
        RB08Kx8lJlA50cvGw9n0Q9hxXg==
X-Google-Smtp-Source: ABdhPJyMpkg/XpQgl4LGIixhC0XGQB++DRj286YuOcuzc3dBmPZ8Aqb5h9uMGBKVbDgbhC6/zwYl5A==
X-Received: by 2002:a17:90a:2465:: with SMTP id h92mr10365958pje.26.1595007802805;
        Fri, 17 Jul 2020 10:43:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22sm8307638pfe.48.2020.07.17.10.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
Date:   Fri, 17 Jul 2020 10:43:01 -0700
Message-Id: <20200717174309.1164575-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for refactoring kernel_read_file*(), remove the redundant
"size" argument which is not needed: it can be included in the return
code, with callers adjusted. (VFS reads already cannot be larger than
INT_MAX.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/main.c |  8 ++++----
 fs/kernel_read_file.c               | 20 +++++++++-----------
 include/linux/kernel_read_file.h    |  8 ++++----
 kernel/kexec_file.c                 | 13 ++++++-------
 kernel/module.c                     |  7 +++----
 security/integrity/digsig.c         |  5 +++--
 security/integrity/ima/ima_fs.c     |  5 +++--
 7 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index d4a413ea48ce..ea419c7d3d34 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -462,7 +462,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 					     size_t in_size,
 					     const void *in_buffer))
 {
-	loff_t size;
+	size_t size;
 	int i, len;
 	int rc = -ENOENT;
 	char *path;
@@ -494,10 +494,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		fw_priv->size = 0;
 
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, &buffer,
-						       &size, msize,
+		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
 						       READING_FIRMWARE);
-		if (rc) {
+		if (rc < 0) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
 					 path, rc);
@@ -506,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 					 path);
 			continue;
 		}
+		size = rc;
 		dev_dbg(device, "Loading firmware from %s\n", path);
 		if (decompress) {
 			dev_dbg(device, "f/w decompressing %s\n",
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 54d972d4befc..dc28a8def597 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -5,7 +5,7 @@
 #include <linux/security.h>
 #include <linux/vmalloc.h>
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
+int kernel_read_file(struct file *file, void **buf,
 		     loff_t max_size, enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
@@ -29,7 +29,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -59,8 +59,6 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	}
 
 	ret = security_kernel_post_read_file(file, *buf, i_size, id);
-	if (!ret)
-		*size = pos;
 
 out_free:
 	if (ret < 0) {
@@ -72,11 +70,11 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 out:
 	allow_write_access(file);
-	return ret;
+	return ret == 0 ? pos : ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+int kernel_read_file_from_path(const char *path, void **buf,
 			       loff_t max_size, enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -89,14 +87,14 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_read_file(file, buf, max_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
 int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
+				      loff_t max_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -115,13 +113,13 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_read_file(file, buf, max_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -130,7 +128,7 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_read_file(f.file, buf, max_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 78cf3d7dc835..0ca0bdbed1bd 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -36,16 +36,16 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 }
 
 int kernel_read_file(struct file *file,
-		     void **buf, loff_t *size, loff_t max_size,
+		     void **buf, loff_t max_size,
 		     enum kernel_read_file_id id);
 int kernel_read_file_from_path(const char *path,
-			       void **buf, loff_t *size, loff_t max_size,
+			       void **buf, loff_t max_size,
 			       enum kernel_read_file_id id);
 int kernel_read_file_from_path_initns(const char *path,
-				      void **buf, loff_t *size, loff_t max_size,
+				      void **buf, loff_t max_size,
 				      enum kernel_read_file_id id);
 int kernel_read_file_from_fd(int fd,
-			     void **buf, loff_t *size, loff_t max_size,
+			     void **buf, loff_t max_size,
 			     enum kernel_read_file_id id);
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1358069ce9e9..a201bbb19158 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -220,13 +220,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 {
 	int ret;
 	void *ldata;
-	loff_t size;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
-				       &size, INT_MAX, READING_KEXEC_IMAGE);
-	if (ret)
+				       INT_MAX, READING_KEXEC_IMAGE);
+	if (ret < 0)
 		return ret;
-	image->kernel_buf_len = size;
+	image->kernel_buf_len = ret;
 
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
@@ -243,11 +242,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-					       &size, INT_MAX,
+					       INT_MAX,
 					       READING_KEXEC_INITRAMFS);
-		if (ret)
+		if (ret < 0)
 			goto out;
-		image->initrd_buf_len = size;
+		image->initrd_buf_len = ret;
 	}
 
 	if (cmdline_len) {
diff --git a/kernel/module.c b/kernel/module.c
index e9765803601b..b6fd4f51cc30 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3988,7 +3988,6 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
 	struct load_info info = { };
-	loff_t size;
 	void *hdr = NULL;
 	int err;
 
@@ -4002,12 +4001,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
-	err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX,
+	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX,
 				       READING_MODULE);
-	if (err)
+	if (err < 0)
 		return err;
 	info.hdr = hdr;
-	info.len = size;
+	info.len = err;
 
 	return load_module(&info, uargs, flags);
 }
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f8869be45d8f..97661ffabc4e 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -171,16 +171,17 @@ int __init integrity_add_key(const unsigned int id, const void *data,
 int __init integrity_load_x509(const unsigned int id, const char *path)
 {
 	void *data = NULL;
-	loff_t size;
+	size_t size;
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, &size, 0,
+	rc = kernel_read_file_from_path(path, &data, 0,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
 	}
+	size = rc;
 
 	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e13ffece3726..9ba145d3d6d9 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -275,7 +275,7 @@ static ssize_t ima_read_policy(char *path)
 {
 	void *data = NULL;
 	char *datap;
-	loff_t size;
+	size_t size;
 	int rc, pathlen = strlen(path);
 
 	char *p;
@@ -284,11 +284,12 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, &size, 0, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, 0, READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
 	}
+	size = rc;
 
 	datap = data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
-- 
2.25.1

