Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D664215D072
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 04:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBND1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 22:27:00 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:59254 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgBND07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:26:59 -0500
Received: by mail-pj1-f73.google.com with SMTP id ie20so4907725pjb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qmc32O47mLrX2+XyhMVdXZr4iejtzZNLfPrmboXtlaE=;
        b=uh3VLcrbun/qMQhu4nd1+eaGYqgMlEQPowqmIpbEdcA4ykyJngLFyTS8qPWPXiBr8B
         jgBpWhsjyfOXzmzeoPJ6vygOHofOvCU37iUMxOdgcWuDGbkg+j4ZCqf4/j4tRY/5QnEp
         QOw/JMfyoXkZbjj5azMFroP00me5MntgbGZR86zqNsqCpJXHrrcFhVhqmRn6a6s6i1/1
         6Z43cc/a8I9EiVxeMz3PJF5xblpyxW69rKhQ/RPxa4aJVel6lgKQvwsU/qK0p7VW3nJz
         TXWVPaHWMlTGJWpvk1pJSVFdCKWs6yTgnJZXT8zewrJVEXFAaM0GZtnY7zuH+lYqjDuG
         s1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qmc32O47mLrX2+XyhMVdXZr4iejtzZNLfPrmboXtlaE=;
        b=KUGe2LgFLs+DrvYixMItHdrdrYY1FDpF8ExKqo0agAJahiigEdGhcw8Uqy/IaFO1JP
         lvz+3mGMNDfBOqFOkjNqasLY4Szoqo6whOQcqYMpPzz4ADR6Df+7rs4sI929a4UjgMj6
         1MW/AlTdVeecPi9L8HETlPjn0hLCqhsx/ZhZdVyxFAFq7roqZpwddRCTsV21h+xjB0Nz
         GsMtLplhtnRDDFRj3G5r0XMkC5WfOwQlJGzUL01IzW2kry8VMeI3eLS+xazaiD6F7hKX
         udqjGxEa+2IzykNM5wNNKBfv/hxUdzJv59BGCw1jSRhljfXoQQRe0vTYBmbdPcadl5Jm
         njhA==
X-Gm-Message-State: APjAAAXSRfBNDSFDzpW3ZZDdEZMaQlzqc/Ggcim3CGf8ezXiAqyUkgKA
        NIUQkskIBkvwUS1OMvHpWh84zHiwhzY=
X-Google-Smtp-Source: APXvYqz0S5IBOrFMOS6B4Vp9EU70qYgr/Lf58sD/J+YQva9G7ILZsp/jlA90GOgvk0ZhdGV6Z5A3FJL+DLs=
X-Received: by 2002:a63:36c2:: with SMTP id d185mr1267436pga.59.1581650818137;
 Thu, 13 Feb 2020 19:26:58 -0800 (PST)
Date:   Thu, 13 Feb 2020 19:26:33 -0800
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200214032635.75434-2-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 1/3] Add a new LSM-supporting anonymous inode interface
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change adds two new functions, anon_inode_getfile_secure and
anon_inode_getfd_secure, that create anonymous-node files with
individual non-S_PRIVATE inodes to which security modules can apply
policy. Existing callers continue using the original singleton-inode
kind of anonymous-inode file. We can transition anonymous inode users
to the new kind of anonymous inode in individual patches for the sake
of bisection and review.

The new functions accept an optional context_inode parameter that
callers can use to provide additional contextual information to
security modules, e.g., indicating that one anonymous struct file is a
logical child of another, allowing a security model to propagate
security information from one to the other.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/anon_inodes.c            | 196 ++++++++++++++++++++++++++++--------
 fs/userfaultfd.c            |   4 +-
 include/linux/anon_inodes.h |  13 +++
 include/linux/lsm_hooks.h   |   9 ++
 include/linux/security.h    |   4 +
 security/security.c         |  10 ++
 6 files changed, 191 insertions(+), 45 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..114a04fc1db4 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,75 +55,135 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-/**
- * anon_inode_getfile - creates a new file instance by hooking it up to an
- *                      anonymous inode, and a dentry that describe the "class"
- *                      of the file
- *
- * @name:    [in]    name of the "class" of the new file
- * @fops:    [in]    file operations for the new file
- * @priv:    [in]    private data for the new file (will be file's private_data)
- * @flags:   [in]    flags
- *
- * Creates a new file by hooking it on a single inode. This is useful for files
- * that do not need to have a full-fledged inode in order to operate correctly.
- * All the files created with anon_inode_getfile() will share a single inode,
- * hence saving memory and avoiding code duplication for the file/inode/dentry
- * setup.  Returns the newly created file* or an error pointer.
- */
-struct file *anon_inode_getfile(const char *name,
-				const struct file_operations *fops,
-				void *priv, int flags)
+static struct inode *anon_inode_make_secure_inode(
+	const char *name,
+	const struct inode *context_inode,
+	const struct file_operations *fops)
+{
+	struct inode *inode;
+	const struct qstr qname = QSTR_INIT(name, strlen(name));
+	int error;
+
+	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return ERR_PTR(PTR_ERR(inode));
+	inode->i_flags &= ~S_PRIVATE;
+	error =	security_inode_init_security_anon(
+		inode, &qname, fops, context_inode);
+	if (error) {
+		iput(inode);
+		return ERR_PTR(error);
+	}
+	return inode;
+}
+
+struct file *_anon_inode_getfile(const char *name,
+				 const struct file_operations *fops,
+				 void *priv, int flags,
+				 const struct inode *context_inode,
+				 bool secure)
 {
+	struct inode *inode;
 	struct file *file;
 
-	if (IS_ERR(anon_inode_inode))
-		return ERR_PTR(-ENODEV);
+	if (secure) {
+		inode =	anon_inode_make_secure_inode(
+			name, context_inode, fops);
+		if (IS_ERR(inode))
+			return ERR_PTR(PTR_ERR(inode));
+	} else {
+		inode =	anon_inode_inode;
+		if (IS_ERR(inode))
+			return ERR_PTR(-ENODEV);
+		/*
+		 * We know the anon_inode inode count is always
+		 * greater than zero, so ihold() is safe.
+		 */
+		ihold(inode);
+	}
 
-	if (fops->owner && !try_module_get(fops->owner))
-		return ERR_PTR(-ENOENT);
+	if (fops->owner && !try_module_get(fops->owner)) {
+		file = ERR_PTR(-ENOENT);
+		goto err;
+	}
 
-	/*
-	 * We know the anon_inode inode count is always greater than zero,
-	 * so ihold() is safe.
-	 */
-	ihold(anon_inode_inode);
-	file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
+	file = alloc_file_pseudo(inode, anon_inode_mnt, name,
 				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file))
 		goto err;
 
-	file->f_mapping = anon_inode_inode->i_mapping;
+	file->f_mapping = inode->i_mapping;
 
 	file->private_data = priv;
 
 	return file;
 
 err:
-	iput(anon_inode_inode);
+	iput(inode);
 	module_put(fops->owner);
 	return file;
 }
-EXPORT_SYMBOL_GPL(anon_inode_getfile);
 
 /**
- * anon_inode_getfd - creates a new file instance by hooking it up to an
- *                    anonymous inode, and a dentry that describe the "class"
- *                    of the file
+ * anon_inode_getfile_secure - creates a new file instance by hooking
+ *                             it up to a new anonymous inode and a
+ *                             dentry that describe the "class" of the
+ *                             file.  Make it possible to use security
+ *                             modules to control access to the
+ *                             new file.
  *
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
  * @priv:    [in]    private data for the new file (will be file's private_data)
- * @flags:   [in]    flags
+ * @flags:   [in]    flags for the file
+ * @anon_inode_flags: [in] flags for anon_inode*
+ *
+ * Creates a new file by hooking it on an unspecified inode. This is
+ * useful for files that do not need to have a full-fledged inode in
+ * order to operate correctly.  All the files created with
+ * anon_inode_getfile_secure() will have distinct inodes, avoiding
+ * code duplication for the file/inode/dentry setup.  Returns the
+ * newly created file* or an error pointer.
+ */
+struct file *anon_inode_getfile_secure(const char *name,
+				       const struct file_operations *fops,
+				       void *priv, int flags,
+				       const struct inode *context_inode)
+{
+	return _anon_inode_getfile(
+		name, fops, priv, flags, context_inode, true);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfile_secure);
+
+/**
+ * anon_inode_getfile - creates a new file instance by hooking it up
+ *                      to an anonymous inode and a dentry that
+ *                      describe the "class" of the file.
+ *
+ * @name:    [in]    name of the "class" of the new file
+ * @fops:    [in]    file operations for the new file
+ * @priv:    [in]    private data for the new file (will be file's private_data)
+ * @flags:   [in]    flags for the file
  *
- * Creates a new file by hooking it on a single inode. This is useful for files
+ * Creates a new file by hooking it on an unspecified inode. This is useful for files
  * that do not need to have a full-fledged inode in order to operate correctly.
- * All the files created with anon_inode_getfd() will share a single inode,
+ * All the files created with anon_inode_getfile() will share a single inode,
  * hence saving memory and avoiding code duplication for the file/inode/dentry
- * setup.  Returns new descriptor or an error code.
+ * setup.  Returns the newly created file* or an error pointer.
  */
-int anon_inode_getfd(const char *name, const struct file_operations *fops,
-		     void *priv, int flags)
+struct file *anon_inode_getfile(const char *name,
+				const struct file_operations *fops,
+				void *priv, int flags)
+{
+	return _anon_inode_getfile(name, fops, priv, flags, NULL, false);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfile);
+
+static int _anon_inode_getfd(const char *name,
+			     const struct file_operations *fops,
+			     void *priv, int flags,
+			     const struct inode *context_inode,
+			     bool secure)
 {
 	int error, fd;
 	struct file *file;
@@ -133,7 +193,8 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		return error;
 	fd = error;
 
-	file = anon_inode_getfile(name, fops, priv, flags);
+	file = _anon_inode_getfile(name, fops, priv, flags, context_inode,
+				   secure);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_put_unused_fd;
@@ -146,6 +207,57 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 	put_unused_fd(fd);
 	return error;
 }
+
+/**
+ * anon_inode_getfd_secure - creates a new file instance by hooking it
+ *                           up to a new anonymous inode and a dentry
+ *                           that describe the "class" of the file.
+ *                           Make it possible to use security modules
+ *                           to control access to the new file.
+ *
+ * @name:    [in]    name of the "class" of the new file
+ * @fops:    [in]    file operations for the new file
+ * @priv:    [in]    private data for the new file (will be file's private_data)
+ * @flags:   [in]    flags
+ *
+ * Creates a new file by hooking it on an unspecified inode. This is
+ * useful for files that do not need to have a full-fledged inode in
+ * order to operate correctly.  All the files created with
+ * anon_inode_getfile_secure() will have distinct inodes, avoiding
+ * code duplication for the file/inode/dentry setup.  Returns a newly
+ * created file descriptor or an error code.
+ */
+int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
+			    void *priv, int flags,
+			    const struct inode *context_inode)
+{
+	return _anon_inode_getfd(name, fops, priv, flags,
+				 context_inode, true);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
+
+/**
+ * anon_inode_getfd - creates a new file instance by hooking it up to
+ *                    an anonymous inode and a dentry that describe
+ *                    the "class" of the file
+ *
+ * @name:    [in]    name of the "class" of the new file
+ * @fops:    [in]    file operations for the new file
+ * @priv:    [in]    private data for the new file (will be file's private_data)
+ * @flags:   [in]    flags
+ *
+ * Creates a new file by hooking it on an unspecified inode. This is
+ * useful for files that do not need to have a full-fledged inode in
+ * order to operate correctly.  All the files created with
+ * anon_inode_getfile() will use the same singleton inode, reducing
+ * memory use and avoiding code duplication for the file/inode/dentry
+ * setup.  Returns a newly created file descriptor or an error code.
+ */
+int anon_inode_getfd(const char *name, const struct file_operations *fops,
+		     void *priv, int flags)
+{
+	return _anon_inode_getfd(name, fops, priv, flags, NULL, false);
+}
 EXPORT_SYMBOL_GPL(anon_inode_getfd);
 
 static int __init anon_inode_init(void)
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 37df7c9eedb1..07b0f6e03849 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1014,8 +1014,6 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 	}
 }
 
-static const struct file_operations userfaultfd_fops;
-
 static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 				  struct userfaultfd_ctx *new,
 				  struct uffd_msg *msg)
@@ -1920,7 +1918,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
-static const struct file_operations userfaultfd_fops = {
+const struct file_operations userfaultfd_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= userfaultfd_show_fdinfo,
 #endif
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index d0d7d96261ad..67bd85d92dca 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -10,12 +10,25 @@
 #define _LINUX_ANON_INODES_H
 
 struct file_operations;
+struct inode;
+
+struct file *anon_inode_getfile_secure(const char *name,
+				       const struct file_operations *fops,
+				       void *priv, int flags,
+				       const struct inode *context_inode);
 
 struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags);
+
+int anon_inode_getfd_secure(const char *name,
+			    const struct file_operations *fops,
+			    void *priv, int flags,
+			    const struct inode *context_inode);
+
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags);
 
+
 #endif /* _LINUX_ANON_INODES_H */
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20d8cf194fb7..de5d37e388df 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -215,6 +215,10 @@
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
+ * @inode_init_security_anon:
+ *      Set up a secure anonymous inode.
+ *	Returns 0 on success. Returns -EPERM if	the security module denies
+ *	the creation of this inode.
  * @inode_create:
  *	Check permission to create a regular file.
  *	@dir contains inode structure of the parent of the new file.
@@ -1552,6 +1556,10 @@ union security_list_options {
 					const struct qstr *qstr,
 					const char **name, void **value,
 					size_t *len);
+	int (*inode_init_security_anon)(struct inode *inode,
+					const struct qstr *name,
+					const struct file_operations *fops,
+					const struct inode *context_inode);
 	int (*inode_create)(struct inode *dir, struct dentry *dentry,
 				umode_t mode);
 	int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
@@ -1884,6 +1892,7 @@ struct security_hook_heads {
 	struct hlist_head inode_alloc_security;
 	struct hlist_head inode_free_security;
 	struct hlist_head inode_init_security;
+	struct hlist_head inode_init_security_anon;
 	struct hlist_head inode_create;
 	struct hlist_head inode_link;
 	struct hlist_head inode_unlink;
diff --git a/include/linux/security.h b/include/linux/security.h
index 64b19f050343..8ea76af0be7a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -320,6 +320,10 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_inode_init_security_anon(struct inode *inode,
+				      const struct qstr *name,
+				      const struct file_operations *fops,
+				      const struct inode *context_inode);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len);
diff --git a/security/security.c b/security/security.c
index 565bc9b67276..d06f3969c030 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1033,6 +1033,16 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+int
+security_inode_init_security_anon(struct inode *inode,
+				  const struct qstr *name,
+				  const struct file_operations *fops,
+				  const struct inode *context_inode)
+{
+	return call_int_hook(inode_init_security_anon, 0, inode, name,
+			     fops, context_inode);
+}
+
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
-- 
2.25.0.265.gbab2e86ba0-goog

