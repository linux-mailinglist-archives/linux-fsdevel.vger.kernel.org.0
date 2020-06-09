Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7B1F49B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 00:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgFIW53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 18:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgFIW5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:57:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA257C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 15:57:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so217420pfd.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhKodXafnqLJk+aH5Hxa5zCb8c2nq9PYG1JmfapgHFE=;
        b=VUp4QVO/DaLqlmRzPCPAy0xho6fXQ2qiMkMM8YEv5P8oWzFeK3ty32NlRSdulaz/dy
         cGZr6YOfTjt6hYZVkNf5GzogEFzde52IxYgdHRl1gxC1JbKwHQWMYXgHG2CXHcrl4oAE
         iYXauEg53tojwMQS0YMfVpEIZ3niNPGQiuXAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhKodXafnqLJk+aH5Hxa5zCb8c2nq9PYG1JmfapgHFE=;
        b=lIWd5jYY0LmonsrbI4rxLSLHTCkfYPHlX1tL77u9FlHI6YgshxdalZ1lMgjO+9gPb7
         TK1stF+sxNH39ZACkk7W9CS8z58XT/ELE8XzWYK7NX+Sc3TTxLln74wS2skd3PKt9VIh
         qlv6ijI56vjM8hZ9dvR/nyu1BRVgWIWJQKxhXfa77xBwJc90qPNfh1YWA8lisfrJvWq1
         TRXx/2G2diUB+meCa2LqojojzOhTyrIqtxOc7adOUIeYN4GFMPdyrznVWHKAPtW/dNwM
         63V5dN+Kf5Gj8cKBrWifqVGOQZWlJKthJ97utzeAGXk0EXRNCWt64nEA4s90PLvnqYjN
         KjVA==
X-Gm-Message-State: AOAM531oSPD7ubRUZZ95c0qgZohczWMjijZwTHhdZDjaKbe3IjDnHBJt
        p7QMw4YhqfLJdrG1n8kZu1/8kA==
X-Google-Smtp-Source: ABdhPJzunrBENd8Gt6Atjck/9sEOv5kmJocCR172m7pZyT7iDNxK1yUwX+CwbRU4PIabfOkGcTJ08A==
X-Received: by 2002:a62:fc52:: with SMTP id e79mr91278pfh.5.1591743431293;
        Tue, 09 Jun 2020 15:57:11 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm9104978pgs.29.2020.06.09.15.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:57:10 -0700 (PDT)
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
Subject: [PATCH v8 1/8] fs: introduce kernel_pread_file* support
Date:   Tue,  9 Jun 2020 15:56:49 -0700
Message-Id: <20200609225656.18663-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609225656.18663-1-scott.branden@broadcom.com>
References: <20200609225656.18663-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kernel_pread_file* support to kernel to allow for partial read
of files with an offset into the file.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c          | 93 ++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h | 15 ++++++++
 2 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7b7cbb180785..c557b4b31d0f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -927,10 +927,14 @@ struct file *open_exec(const char *name)
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
 
@@ -950,21 +954,32 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
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
@@ -972,20 +987,23 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
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
@@ -995,10 +1013,18 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
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
@@ -1010,15 +1036,22 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
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
@@ -1036,14 +1069,22 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
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
@@ -1051,11 +1092,17 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 951862b1211b..ab715559cf3c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3012,6 +3012,7 @@ extern int do_pipe_flags(int *, int);
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
+	id(FIRMWARE_PARTIAL_READ, firmware)	\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
@@ -3040,12 +3041,26 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t pos, loff_t max_size,
+		      enum kernel_read_file_id id);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size, loff_t pos,
+				loff_t max_size,
+				enum kernel_read_file_id id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+int kernel_pread_file_from_path_initns(const char *path, void **buf,
+				       loff_t *size, loff_t pos,
+				       loff_t max_size,
+				       enum kernel_read_file_id id);
 extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
 					     enum kernel_read_file_id);
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+			      loff_t pos, loff_t max_size,
+			      enum kernel_read_file_id id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.17.1

