Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC347216219
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 01:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGFXXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgGFXXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:23:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB1C08C5E2
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 16:23:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so36804639edz.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OrrJyKhfb1/SUBOQJ1Oa1Mb5s1s3F2Mf2Dq4BB+LINA=;
        b=gFhJ5n5ReJLpHrIubMBvm+rANW6VxtLsfZznVkI3igBH1J25jBbC59wBuiZlikeKi7
         NUIQFO9ISGMd419iDPtc5vial8wlzhzrcdGMlw4I/jcnmTb+MPn8VPT35DCgfcuNRnGT
         k4gleSmoK3+gzCRnhfol2njGSCPhwY0aMfm9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OrrJyKhfb1/SUBOQJ1Oa1Mb5s1s3F2Mf2Dq4BB+LINA=;
        b=G/Na/qi88BFV6kZUYWNsvfTFZnvkY32I2pVgFmtbXcNruRtmo1Hqt4e1eUVb0yT3KX
         a7JoSxKxyI2CiNGL3PeNteCYyNhBY2HiBsWwzMOX3n82Cdzg7UEuSaNl+6a3QCw95ntz
         aZwLWHvny8hIfM42xtAR/j5CXiFCIrTn1oquqHNIxwUMyTGZw9Nav7yb/AyxYbUQ/EyB
         ArMAgsli9sWz/WowhkCkr++CL1EY4DyrIhY3cfbcuUPe2IKzPI6oke5aYmYVW97Rg85m
         x+PdUZWZN20NlN3DiqITu9Z10vIAXxDrvZ5jm4AQQmIuIzRMoW21e375BaGX/z1SAI6A
         m8Iw==
X-Gm-Message-State: AOAM531VziT1+wVxEVjM9r+y6enCvIJaZfrYR8t1ALHMdKQT2wQO5fsu
        +YSoUhWl7qfFhdIXRAckbKRStQ==
X-Google-Smtp-Source: ABdhPJzNuazg5AqNDzn5kO4uc9IVBIDtx0FwOvDy0DHIbWZtoc6KvjBVVKLk9mD72xH7BvpIf3D3ig==
X-Received: by 2002:aa7:d8ca:: with SMTP id k10mr29303516eds.108.1594077822764;
        Mon, 06 Jul 2020 16:23:42 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i2sm4002567ejp.114.2020.07.06.16.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:23:42 -0700 (PDT)
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
Subject: [PATCH v10 2/9] fs: introduce kernel_pread_file* support
Date:   Mon,  6 Jul 2020 16:23:02 -0700
Message-Id: <20200706232309.12010-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706232309.12010-1-scott.branden@broadcom.com>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kernel_pread_file* support to kernel to allow for partial read
of files with an offset into the file.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c                        | 93 ++++++++++++++++++++++++--------
 include/linux/kernel_read_file.h | 17 ++++++
 2 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4ea87db5e4d5..e6a8a65f7478 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -928,10 +928,14 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t max_size, loff_t pos,
+		      enum kernel_read_file_id id)
+{
+	loff_t alloc_size;
+	loff_t buf_pos;
+	loff_t read_end;
+	loff_t i_size;
 	ssize_t bytes = 0;
 	int ret;
 
@@ -951,21 +955,32 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+
+	/* Default read to end of file */
+	read_end = i_size;
+
+	/* Allow reading partial portion of file */
+	if ((id == READING_FIRMWARE_PARTIAL_READ) &&
+	    (i_size > (pos + max_size)))
+		read_end = pos + max_size;
+
+	alloc_size = read_end - pos;
+	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
 
-	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
+	if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+	    (id != READING_FIRMWARE_PREALLOC_BUFFER))
+		*buf = vmalloc(alloc_size);
 	if (!*buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+	buf_pos = 0;
+	while (pos < read_end) {
+		bytes = kernel_read(file, *buf + buf_pos, read_end - pos, &pos);
 		if (bytes < 0) {
 			ret = bytes;
 			goto out_free;
@@ -973,20 +988,23 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 		if (bytes == 0)
 			break;
+
+		buf_pos += bytes;
 	}
 
-	if (pos != i_size) {
+	if (pos != read_end) {
 		ret = -EIO;
 		goto out_free;
 	}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
 	if (!ret)
 		*size = pos;
 
 out_free:
 	if (ret < 0) {
-		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((id != READING_FIRMWARE_PARTIAL_READ) &&
+		    (id != READING_FIRMWARE_PREALLOC_BUFFER)) {
 			vfree(*buf);
 			*buf = NULL;
 		}
@@ -996,10 +1014,18 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file(file, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size,
+				loff_t max_size, loff_t pos,
+				enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -1011,15 +1037,22 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
 	fput(file);
 	return ret;
 }
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path(path, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
-				      enum kernel_read_file_id id)
+int kernel_pread_file_from_path_initns(const char *path, void **buf,
+				       loff_t *size,
+				       loff_t max_size, loff_t pos,
+				       enum kernel_read_file_id id)
 {
 	struct file *file;
 	struct path root;
@@ -1037,14 +1070,22 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
 	fput(file);
 	return ret;
 }
+
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path_initns(path, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+			      loff_t max_size, loff_t pos,
+			      enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
@@ -1052,11 +1093,17 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_pread_file(f.file, buf, size, max_size, pos, id);
 out:
 	fdput(f);
 	return ret;
 }
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_fd(fd, buf, size, max_size, 0, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
 #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 53f5ca41519a..f061ccb8d0b4 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -8,6 +8,7 @@
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
+	id(FIRMWARE_PARTIAL_READ, firmware)	\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
@@ -36,15 +37,31 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
+int kernel_pread_file(struct file *file,
+		      void **buf, loff_t *size, loff_t pos,
+		      loff_t max_size,
+		      enum kernel_read_file_id id);
 int kernel_read_file(struct file *file,
 		     void **buf, loff_t *size, loff_t max_size,
 		     enum kernel_read_file_id id);
+int kernel_pread_file_from_path(const char *path,
+				void **buf, loff_t *size, loff_t pos,
+				loff_t max_size,
+				enum kernel_read_file_id id);
 int kernel_read_file_from_path(const char *path,
 			       void **buf, loff_t *size, loff_t max_size,
 			       enum kernel_read_file_id id);
+int kernel_pread_file_from_path_initns(const char *path,
+				       void **buf, loff_t *size, loff_t pos,
+				       loff_t max_size,
+				       enum kernel_read_file_id id);
 int kernel_read_file_from_path_initns(const char *path,
 				      void **buf, loff_t *size, loff_t max_size,
 				      enum kernel_read_file_id id);
+int kernel_pread_file_from_fd(int fd,
+			      void **buf, loff_t *size, loff_t pos,
+			      loff_t max_size,
+			      enum kernel_read_file_id id);
 int kernel_read_file_from_fd(int fd,
 			     void **buf, loff_t *size, loff_t max_size,
 			     enum kernel_read_file_id id);
-- 
2.17.1

