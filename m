Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0A0224258
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGQRoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgGQRnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B27C0619D8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so5747678pls.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yoa2gRg9p0BtDZ4KFmWdKCBfsnno2U2zYadIEvnl3rM=;
        b=Adt3o38LCFQ+j3BqLMHZQYrYU2DhD2CgAuRHj5PmBfJpDO1wNflCDVEBsOIwpNndoE
         JKdVBNXYjKiJ5fo4J3eyfgtMj3l5w4lJzv81GTI6/LsuuF8CMqpHuucNKwP2C4yUAMxH
         JNfL+adsL8K5pCeLNR9ZPAbYdyqrXiYk3O7NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yoa2gRg9p0BtDZ4KFmWdKCBfsnno2U2zYadIEvnl3rM=;
        b=riJznozO5bEc+CpLm1x+wgoA6Ij0t3zzup1Ol02TAlzs+8L/SAUPBs+Gc4YqQ2VlPv
         mO6g4KaBzn0NjnEkGDvb471NhiopDYUVgBwRSKFa+1PtoYIykwqgWR0sIXcvkxDNaFyT
         ius9x6lbRdThJKXFe0HFnR3l/qbjksdi/20cPV151aXt7NG+mvuQzh7i7/C+SmJVEI1y
         rM825IFa1cJlbqE2oyeq2SXeyUYQt4pLvr3ipdvULkm+gJE7v0d+5OrpycPwMas4LsPq
         iOFzDiTet37co8eDDN7av7ad55kMGAoSXWT0U/ZTjV04GAH7lDsptyTY4ZZQf7eCW2Jz
         TmBQ==
X-Gm-Message-State: AOAM530hkUvl9YzlcddTAT4aI1XpZMBiXEWzj2l8ZKvrQ8LzwWmWs8bh
        qFeK1E3b+52+UT+4A2hyquQ5hQ==
X-Google-Smtp-Source: ABdhPJwFTyE1bihKrjLjzdpHMU598VVm0pKHNWemXoHtPIjEVntHC4jS35stskPf0dKucRXMnvtL2Q==
X-Received: by 2002:a17:90a:a887:: with SMTP id h7mr11295575pjq.0.1595007801925;
        Fri, 17 Jul 2020 10:43:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m19sm8247431pgd.13.2020.07.17.10.43.15
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
Subject: [PATCH 07/13] fs/kernel_read_file: Switch buffer size arg to size_t
Date:   Fri, 17 Jul 2020 10:43:02 -0700
Message-Id: <20200717174309.1164575-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for further refactoring of kernel_read_file*(), rename
the "max_size" argument to the more accurate "buf_size", and correct
its type to size_t. Add kerndoc to explain the specifics of how the
arguments will be used. Note that with buf_size now size_t, it can no
longer be negative (and was never called with a negative value). Adjust
callers to use it as a "maximum size" when *buf is NULL.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernel_read_file.c            | 34 +++++++++++++++++++++++---------
 include/linux/kernel_read_file.h |  8 ++++----
 security/integrity/digsig.c      |  2 +-
 security/integrity/ima/ima_fs.c  |  2 +-
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index dc28a8def597..e21a76001fff 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -5,15 +5,31 @@
 #include <linux/security.h>
 #include <linux/vmalloc.h>
 
+/**
+ * kernel_read_file() - read file contents into a kernel buffer
+ *
+ * @file	file to read from
+ * @buf		pointer to a "void *" buffer for reading into (if
+ *		*@buf is NULL, a buffer will be allocated, and
+ *		@buf_size will be ignored)
+ * @buf_size	size of buf, if already allocated. If @buf not
+ *		allocated, this is the largest size to allocate.
+ * @id		the kernel_read_file_id identifying the type of
+ *		file contents being read (for LSMs to examine)
+ *
+ * Returns number of bytes read (no single read will be bigger
+ * than INT_MAX), or negative on error.
+ *
+ */
 int kernel_read_file(struct file *file, void **buf,
-		     loff_t max_size, enum kernel_read_file_id id)
+		     size_t buf_size, enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
 	void *allocated = NULL;
 	int ret;
 
-	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
+	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EINVAL;
 
 	ret = deny_write_access(file);
@@ -29,7 +45,7 @@ int kernel_read_file(struct file *file, void **buf,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
+	if (i_size > INT_MAX || i_size > buf_size) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -75,7 +91,7 @@ int kernel_read_file(struct file *file, void **buf,
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
 int kernel_read_file_from_path(const char *path, void **buf,
-			       loff_t max_size, enum kernel_read_file_id id)
+			       size_t buf_size, enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -87,14 +103,14 @@ int kernel_read_file_from_path(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, max_size, id);
+	ret = kernel_read_file(file, buf, buf_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
 int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t max_size,
+				      size_t buf_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -113,13 +129,13 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, max_size, id);
+	ret = kernel_read_file(file, buf, buf_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
+int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -128,7 +144,7 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, max_size, id);
+	ret = kernel_read_file(f.file, buf, buf_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 0ca0bdbed1bd..910039e7593e 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -36,16 +36,16 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 }
 
 int kernel_read_file(struct file *file,
-		     void **buf, loff_t max_size,
+		     void **buf, size_t buf_size,
 		     enum kernel_read_file_id id);
 int kernel_read_file_from_path(const char *path,
-			       void **buf, loff_t max_size,
+			       void **buf, size_t buf_size,
 			       enum kernel_read_file_id id);
 int kernel_read_file_from_path_initns(const char *path,
-				      void **buf, loff_t max_size,
+				      void **buf, size_t buf_size,
 				      enum kernel_read_file_id id);
 int kernel_read_file_from_fd(int fd,
-			     void **buf, loff_t max_size,
+			     void **buf, size_t buf_size,
 			     enum kernel_read_file_id id);
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 97661ffabc4e..04f779c4f5ed 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -175,7 +175,7 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, 0,
+	rc = kernel_read_file_from_path(path, &data, INT_MAX,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 9ba145d3d6d9..8695170d0e5c 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -284,7 +284,7 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, 0, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, INT_MAX, READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
-- 
2.25.1

