Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E11F0359
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 01:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgFEXBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 19:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgFEXAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:00:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7424C08C5C7
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 16:00:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so4264365plo.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNH51z2pPdYRKwbT0lKGpbh9OQTXpy9Fw+Gpw3I+u0g=;
        b=N107Dl1RD0A3r3XNDCFxKEOnLytpj5szJrmkWJyy0+1+HLK/Vd95oWyHhobXtawPrM
         09iUhw6Zg8t6/4388rg46y69u2gn3QUQr2vWAjn2XLEwb3WL+uqHb8QXQjETSM1EGiFB
         SH4dkymS5RiUeOjlB/mEd1QgGQCQlerHfPO58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNH51z2pPdYRKwbT0lKGpbh9OQTXpy9Fw+Gpw3I+u0g=;
        b=Ce51TN8lrHF//EA/0G0tkWhHsDwcxn7Vus1nXTf8gYJSRuUp/XKJij81up3QB/E/5L
         jL+5+A2c+a/UGqqTs8mt4l4OUH4UnTyTUQQKoX+kZJDWBWeSJDcQfAiA+Gt+VkvQb3Lr
         jpenHUprBHowqwHsur44IbNFRNsggkBNNAwarGNjNcexUoq5thFzqZI5Pr4cyMESEQ6/
         iFLgvWO+oKnATK2doMyqDfSu3Fe8K4673dC47H4mDRCZ0ytt3Fkro3ySJ2EPjsSq1mN+
         KtPcAy1tpIhj8hSSp5MBkn0E3THGQ2ikbJsqh/XgRWuQe8eQNlxJf1SYbWpSVnC5fhMD
         SNUQ==
X-Gm-Message-State: AOAM532zv4lV2Ky76uJxhhBoBMyGIfgFUZrOb9yKLOB/564nFgOZmoGF
        S8meLNTD1q/yadVAoiB0KxIGIg==
X-Google-Smtp-Source: ABdhPJwBzexMDGEkU4DIDyOA+icqxKjPI8ibktJna8AbKmzNohV6dFv2TZUE4DM2zAkQLMqLD5PflA==
X-Received: by 2002:a17:90a:4495:: with SMTP id t21mr5409327pjg.185.1591398013314;
        Fri, 05 Jun 2020 16:00:13 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b140sm568974pfb.119.2020.06.05.16.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:00:12 -0700 (PDT)
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
Subject: [PATCH v6 1/8] fs: introduce kernel_pread_file* support
Date:   Fri,  5 Jun 2020 15:59:52 -0700
Message-Id: <20200605225959.12424-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605225959.12424-1-scott.branden@broadcom.com>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kernel_pread_file* support to kernel to allow for partial read
of files with an offset into the file.  Existing kernel_read_file
functions call new kernel_pread_file functions with offset=0 and
opt=KERNEL_PREAD_WHOLE.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c          | 95 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h | 29 ++++++++++++++
 2 files changed, 103 insertions(+), 21 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index de90a66587ab..e5c241c07b75 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -925,10 +925,15 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t pos, loff_t max_size,
+		      enum kernel_pread_opt opt,
+		      enum kernel_read_file_id id)
+{
+	loff_t alloc_size;
+	loff_t buf_pos;
+	loff_t read_end;
+	loff_t i_size;
 	ssize_t bytes = 0;
 	int ret;
 
@@ -948,21 +953,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+
+	/* Default read to end of file */
+	read_end = i_size;
+
+	/* Allow reading partial portion of file */
+	if ((opt == KERNEL_PREAD_PART) &&
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
@@ -970,14 +985,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
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
 
@@ -993,10 +1010,20 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file(file, buf, size, 0, max_size,
+				 KERNEL_PREAD_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size, loff_t pos,
+				loff_t max_size,
+				enum kernel_pread_opt opt,
+				enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -1008,15 +1035,24 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, pos, max_size, opt, id);
 	fput(file);
 	return ret;
 }
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path(path, buf, size, 0, max_size,
+					   KERNEL_PREAD_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
-				      enum kernel_read_file_id id)
+extern int kernel_pread_file_from_path_initns(const char *path, void **buf,
+					      loff_t *size, loff_t pos,
+					      loff_t max_size,
+					      enum kernel_pread_opt opt,
+					      enum kernel_read_file_id id)
 {
 	struct file *file;
 	struct path root;
@@ -1034,14 +1070,24 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, pos, max_size, opt, id);
 	fput(file);
 	return ret;
 }
+
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path_initns(path, buf, size, 0, max_size,
+						  KERNEL_PREAD_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size, loff_t pos,
+			      loff_t max_size,
+			      enum kernel_pread_opt opt,
+			      enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
@@ -1049,11 +1095,18 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_pread_file(f.file, buf, size, pos, max_size, opt, id);
 out:
 	fdput(f);
 	return ret;
 }
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_fd(fd, buf, size, 0, max_size,
+					 KERNEL_PREAD_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
 #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fce4b8867224..76d463e4a628 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3048,12 +3048,41 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
+/**
+ * enum kernel_pread_opt - options to control pread file loading behaviour
+ *
+ * @KERNEL_PREAD_WHOLE: Only Allow reading of whole file.
+ * @KERNEL_PREAD_PART: Allow reading part of file.
+ */
+enum kernel_pread_opt {
+	KERNEL_PREAD_WHOLE = 0,
+	KERNEL_PREAD_PART = BIT(0),
+};
+
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t pos, loff_t max_size,
+		      enum kernel_pread_opt opt,
+		      enum kernel_read_file_id id);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size, loff_t pos,
+				loff_t max_size,
+				enum kernel_pread_opt opt,
+				enum kernel_read_file_id id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+int kernel_pread_file_from_path_initns(const char *path, void **buf,
+				       loff_t *size, loff_t pos,
+				       loff_t max_size,
+				       enum kernel_pread_opt opt,
+				       enum kernel_read_file_id id);
 extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
 					     enum kernel_read_file_id);
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+			      loff_t pos, loff_t max_size,
+			      enum kernel_pread_opt opt,
+			      enum kernel_read_file_id id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.17.1

