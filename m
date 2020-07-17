Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5EE22423E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGQRnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgGQRn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CDCC08C5CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s189so7013079pgc.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QC67MGZb1qtgaOMgqpDPbLq9AEJZBpSh9Y2HP0utLo4=;
        b=UrY0x4LrC81ISM2Au0rm/OacxSg5b0Vx0i9IChEpyF3f8MHn1J5GwhXwOX2wYwOJvN
         z59U86OZBhoJtP8RAOeNBGOBFXuYG6VJlJM0KTLzUjLwq0JEXJGNYouRogaN5GbjYc1u
         iT6l2XlZwJLWj1I330SqqB4271oMAYiDQrxXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QC67MGZb1qtgaOMgqpDPbLq9AEJZBpSh9Y2HP0utLo4=;
        b=ZVuKlOzd+oyxOkmXHyTKPCMPAe0qGtl+NGF0JOsI1Lyol9GdpFHdgB79O6X+8Ak+Ua
         Sbnx1ucCFwOGo7CN6KM94YOl6ujLiTntfHSDJmXTsztK2pzOVvaKZ8NDdcfDNwWEE2GV
         pyuRoiGPEF8UnmgcBrfQ0te9oa3ONgst+mPkl7eRCINL2lOLhniIkrkdrSJyRye6583p
         YvSXVJJTQEX6oWKXPIBwELXwB5S0oXSGTMqg4Q38p8BEqSqZ6KnciT2usNF4wPkCnaT7
         dsL78dVLtT/QMj8Xa8+iGPu/u9Pb7dpxh0NFmZuiOrsmH+y3MGL/90sQDrM6wQh2/5jV
         HWwA==
X-Gm-Message-State: AOAM530On489ZxGs0Key0kVM2L311tpMyHGqHVU3sXBiEnSkVRaBFEw2
        1Gmb+vawdHA7I4f4hbRqizDKxA==
X-Google-Smtp-Source: ABdhPJyKd3T1PtlTIStbLe8IXLkXREWNFIDEcyjJrMxw+rf8dOM89Lnf4kk31Fxva2m5LutA64xU2Q==
X-Received: by 2002:a62:347:: with SMTP id 68mr8657676pfd.185.1595007807126;
        Fri, 17 Jul 2020 10:43:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l126sm8438895pfd.202.2020.07.17.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:24 -0700 (PDT)
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
Subject: [PATCH 13/13] fs/kernel_file_read: Add "offset" arg for partial reads
Date:   Fri, 17 Jul 2020 10:43:08 -0700
Message-Id: <20200717174309.1164575-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To perform partial reads, callers of kernel_read_file*() must have a
non-NULL file_size argument and a preallocated buffer. The new "offset"
argument can then be used to seek to specific locations in the file to
fill the buffer to, at most, "buf_size" per call.

Where possible, the LSM hooks can report whether a full file has been
read or not so that the contents can be reasoned about.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/main.c |  2 +-
 fs/kernel_read_file.c               | 78 ++++++++++++++++++++---------
 include/linux/kernel_read_file.h    |  8 +--
 kernel/kexec_file.c                 |  4 +-
 kernel/module.c                     |  2 +-
 security/integrity/digsig.c         |  2 +-
 security/integrity/ima/ima_fs.c     |  3 +-
 7 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 3439a533927c..fa540ca51961 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -494,7 +494,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		fw_priv->size = 0;
 
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
+		rc = kernel_read_file_from_path_initns(path, 0, &buffer, msize,
 						       NULL,
 						       READING_FIRMWARE);
 		if (rc < 0) {
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index d73bc3fa710a..90d255fbdd9b 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -9,6 +9,7 @@
  * kernel_read_file() - read file contents into a kernel buffer
  *
  * @file	file to read from
+ * @offset	where to start reading from (see below).
  * @buf		pointer to a "void *" buffer for reading into (if
  *		*@buf is NULL, a buffer will be allocated, and
  *		@buf_size will be ignored)
@@ -19,19 +20,31 @@
  * @id		the kernel_read_file_id identifying the type of
  *		file contents being read (for LSMs to examine)
  *
+ * @offset must be 0 unless both @buf and @file_size are non-NULL
+ * (i.e. the caller must be expecting to read partial file contents
+ * via an already-allocated @buf, in at most @buf_size chunks, and
+ * will be able to determine when the entire file was read by
+ * checking @file_size). This isn't a recommended way to read a
+ * file, though, since it is possible that the contents might
+ * change between calls to kernel_read_file().
+ *
  * Returns number of bytes read (no single read will be bigger
  * than INT_MAX), or negative on error.
  *
  */
-int kernel_read_file(struct file *file, void **buf,
+int kernel_read_file(struct file *file, loff_t offset, void **buf,
 		     size_t buf_size, size_t *file_size,
 		     enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
-	ssize_t bytes = 0;
+	size_t copied;
 	void *allocated = NULL;
+	bool whole_file;
 	int ret;
 
+	if (offset != 0 && (!*buf || !file_size))
+		return -EINVAL;
+
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EINVAL;
 
@@ -39,19 +52,27 @@ int kernel_read_file(struct file *file, void **buf,
 	if (ret)
 		return ret;
 
-	ret = security_kernel_read_file(file, id, true);
-	if (ret)
-		goto out;
-
 	i_size = i_size_read(file_inode(file));
 	if (i_size <= 0) {
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > INT_MAX || i_size > buf_size) {
+	/* The file is too big for sane activities. */
+	if (i_size > INT_MAX) {
+		ret = -EFBIG;
+		goto out;
+	}
+	/* The entire file cannot be read in one buffer. */
+	if (!file_size && offset == 0 && i_size > buf_size) {
 		ret = -EFBIG;
 		goto out;
 	}
+
+	whole_file = (offset == 0 && i_size <= buf_size);
+	ret = security_kernel_read_file(file, id, whole_file);
+	if (ret)
+		goto out;
+
 	if (file_size)
 		*file_size = i_size;
 
@@ -62,9 +83,14 @@ int kernel_read_file(struct file *file, void **buf,
 		goto out;
 	}
 
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+	pos = offset;
+	copied = 0;
+	while (copied < buf_size) {
+		ssize_t bytes;
+		size_t wanted = min_t(size_t, buf_size - copied,
+					      i_size - pos);
+
+		bytes = kernel_read(file, *buf + copied, wanted, &pos);
 		if (bytes < 0) {
 			ret = bytes;
 			goto out_free;
@@ -72,14 +98,17 @@ int kernel_read_file(struct file *file, void **buf,
 
 		if (bytes == 0)
 			break;
+		copied += bytes;
 	}
 
-	if (pos != i_size) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (whole_file) {
+		if (pos != i_size) {
+			ret = -EIO;
+			goto out_free;
+		}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+		ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	}
 
 out_free:
 	if (ret < 0) {
@@ -91,11 +120,11 @@ int kernel_read_file(struct file *file, void **buf,
 
 out:
 	allow_write_access(file);
-	return ret == 0 ? pos : ret;
+	return ret == 0 ? copied : ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf,
+int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
 			       size_t buf_size, size_t *file_size,
 			       enum kernel_read_file_id id)
 {
@@ -109,14 +138,15 @@ int kernel_read_file_from_path(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, buf_size, file_size, id);
+	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      size_t buf_size, size_t *file_size,
+int kernel_read_file_from_path_initns(const char *path, loff_t offset,
+				      void **buf, size_t buf_size,
+				      size_t *file_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -135,14 +165,14 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, buf_size, file_size, id);
+	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
-			     size_t *file_size,
+int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
+			     size_t buf_size, size_t *file_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -151,7 +181,7 @@ int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, buf_size, file_size, id);
+	ret = kernel_read_file(f.file, offset, buf, buf_size, file_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 023293eaf948..575ffa1031d3 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -35,19 +35,19 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
-int kernel_read_file(struct file *file,
+int kernel_read_file(struct file *file, loff_t offset,
 		     void **buf, size_t buf_size,
 		     size_t *file_size,
 		     enum kernel_read_file_id id);
-int kernel_read_file_from_path(const char *path,
+int kernel_read_file_from_path(const char *path, loff_t offset,
 			       void **buf, size_t buf_size,
 			       size_t *file_size,
 			       enum kernel_read_file_id id);
-int kernel_read_file_from_path_initns(const char *path,
+int kernel_read_file_from_path_initns(const char *path, loff_t offset,
 				      void **buf, size_t buf_size,
 				      size_t *file_size,
 				      enum kernel_read_file_id id);
-int kernel_read_file_from_fd(int fd,
+int kernel_read_file_from_fd(int fd, loff_t offset,
 			     void **buf, size_t buf_size,
 			     size_t *file_size,
 			     enum kernel_read_file_id id);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 7b0ecdc621aa..c340a14c4cb9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -221,7 +221,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	int ret;
 	void *ldata;
 
-	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
+	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
 				       INT_MAX, NULL, READING_KEXEC_IMAGE);
 	if (ret < 0)
 		return ret;
@@ -241,7 +241,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
+		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
 					       INT_MAX, NULL,
 					       READING_KEXEC_INITRAMFS);
 		if (ret < 0)
diff --git a/kernel/module.c b/kernel/module.c
index 90a4788dff9d..d353d1f67681 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4007,7 +4007,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
-	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX, NULL,
+	err = kernel_read_file_from_fd(fd, 0, &hdr, INT_MAX, NULL,
 				       READING_MODULE);
 	if (err < 0)
 		return err;
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 8a523dfd7fd7..0f518dcfde05 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -175,7 +175,7 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL,
+	rc = kernel_read_file_from_path(path, 0, &data, INT_MAX, NULL,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cff04083e598..4212423714ee 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -284,7 +284,8 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL, READING_POLICY);
+	rc = kernel_read_file_from_path(path, 0, &data, INT_MAX, NULL,
+					READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
-- 
2.25.1

