Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4D99FDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404167AbfHVTZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:25:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39360 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391933AbfHVTZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so4233416pgi.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jz2ghwx5qv2altb0zVDRFuIygzeFnhPan3KDnlmOiBU=;
        b=EAdf6Vqc4HQThIh/aoLjYnCu6AHwTdu5kT/QHkQRbcNdYXQig/8FDFv+bH8JceQaFx
         koy5Hli2upgjVLtanVMXfGpVnEzWCwXHgrfT9IKsnkPHvFW+AtD/ztx0fuhjmMwPRqkU
         OZRVEhpYGem3TqzDqsj+2v0SGyro0vmBn+Y7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jz2ghwx5qv2altb0zVDRFuIygzeFnhPan3KDnlmOiBU=;
        b=WOaeDpJW0FXd7NSULvruY+y03DFXnXXFMbPLHXoXmy11fV+9TxImsamNc+Nw8yS9Lr
         +UoJagaUxCLUj2JjXVUlydMjpngp1ol7J9RHPVqiowwgGImB+w0+kPs8DC/b29D22Fcy
         zEBzPZYmH0poGcYPyVRYg9k4kWbs4yquvVMl5lil9sR/oZ4/VEBrW6rjRgFmvFEWErcH
         hlAxjcSKXjePvhgrxk5NcvSAEdktA8zVUT7dACyBGFdHHglRPvbW0Jpvee7/hO/WGem+
         ArHeEk+XuUDj/BFBJqrCXLrWE3ScZ57hTQFTkULHXMFbGC4qbfgIR77oOAFfjqdh/ZFz
         67lw==
X-Gm-Message-State: APjAAAWwtRWruc6mftOl7kKWrzPYo6swpUe1cfsF8ZOhbWbCejrjO54d
        hBXrcP63O7w7lE4PjcB8NpE1+Q==
X-Google-Smtp-Source: APXvYqzv5agk/or4pXD/BnwTtdnrIRYMTRBYojPtfOvr278i+LPfLS2omYoyMQz20ye8nD4Gx2l6vA==
X-Received: by 2002:a62:f20a:: with SMTP id m10mr828130pfh.95.1566501908828;
        Thu, 22 Aug 2019 12:25:08 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:08 -0700 (PDT)
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
Subject: [PATCH 1/7] fs: introduce kernel_pread_file* support
Date:   Thu, 22 Aug 2019 12:24:45 -0700
Message-Id: <20190822192451.5983-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822192451.5983-1-scott.branden@broadcom.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kernel_pread_file* support to kernel to allow for partial read
of files with an offset into the file.  Existing kernel_read_file
functions call new kernel_pread_file functions with offset=0 and
flags=KERNEL_PREAD_FLAG_WHOLE.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c          | 77 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h | 15 +++++++++
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f7f6a140856a..21da8683e2c2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -893,10 +893,14 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t pos, loff_t max_size, unsigned int flags,
+		      enum kernel_read_file_id id)
+{
+	loff_t alloc_size;
+	loff_t buf_pos;
+	loff_t read_end;
+	loff_t i_size;
 	ssize_t bytes = 0;
 	int ret;
 
@@ -916,21 +920,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+
+	/* Default read to end of file */
+	read_end = i_size;
+
+	/* Allow reading partial portion of file */
+	if ((flags & KERNEL_PREAD_FLAG_PART) &&
+	    (i_size > (pos + max_size)))
+		read_end = pos + max_size;
+
+	alloc_size = read_end - pos;
+	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
 
 	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
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
@@ -938,14 +952,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
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
 
@@ -961,10 +977,20 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file);
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file(file, buf, size, 0, max_size,
+				 KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size, loff_t pos,
+				loff_t max_size, unsigned int flags,
+				enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -976,14 +1002,23 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, pos, max_size, flags, id);
 	fput(file);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file_from_path);
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path(path, buf, size, 0, max_size,
+					   KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size, loff_t pos,
+			      loff_t max_size, unsigned int flags,
+			      enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
@@ -991,11 +1026,19 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_pread_file(f.file, buf, size, pos, max_size, flags, id);
 out:
 	fdput(f);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file_from_fd);
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_fd(fd, buf, size, 0, max_size,
+					 KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 997a530ff4e9..a257e98acc89 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2933,10 +2933,25 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
+/* Flags used by kernel_pread_file functions */
+#define KERNEL_PREAD_FLAG_WHOLE	0x0000 /* Only Allow reading of whole file */
+#define KERNEL_PREAD_FLAG_PART	0x0001 /* Allow reading part of file */
+
+extern int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+			     loff_t pos, loff_t max_size, unsigned int flags,
+			     enum kernel_read_file_id id);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
+extern int kernel_pread_file_from_path(const char *path, void **buf,
+				       loff_t *size, loff_t pos,
+				       loff_t max_size, unsigned int flags,
+				       enum kernel_read_file_id id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+extern int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+				    loff_t pos, loff_t max_size,
+				    unsigned int flags,
+				    enum kernel_read_file_id id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.17.1

