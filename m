Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2142EED28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 06:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbhAHFeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 00:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbhAHFeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 00:34:22 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3799C061285
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 21:33:05 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t16so5852910pfh.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 21:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=98Z4ectXH1REB58k02Mn1amE7f3KfVW7xatcwz+e4fE=;
        b=Gr8ToxvYwY22MpaSPnvv+xNTlF/MwvGK1jay3/KQp6rUMoMTvKtxUxD+fc0e3NyuJ8
         o+cKsoUpxojpTgUHAomzIjQbNqfHVgzRePkld2+cs3rxMTsLKygVVuDBTGTVTkv/7RUH
         A8cpF9U6c3PRllLLLAn3+rq892JeKIN7FGREU7e9y/RdFftBINpJBgXteA+zKow1enF5
         LiYwKQ9Yqv9yh2E1d/xtg7uonuUqM6Ob/TcInfIIyoUzagaRIPp12hiiGc16g7fPqtGc
         /UI3GE1GT62eFxi/gDJtYKPs+7OXz85Vsmzqzg6OykKSj1TQbbo+WMZTNm0z45ZRAoIs
         T7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=98Z4ectXH1REB58k02Mn1amE7f3KfVW7xatcwz+e4fE=;
        b=NM3rB3Iox2JVschlwneg8yql7V+SDJVRrdgAqllvLnddcOyGMDwqYyXgkBdcxtp/FZ
         XPPZoC87GAEZrpMdXarfUKhzuBUnUO/M4zfF8iJ6kfyJPGP5Syr/HwfddyOjh3DXgiN+
         zQcpFmHhZCQanHibp/2aeaS2vfPdS6Bgiw6PsLbwadJknuxLRJGACEM7LAxTrbG4gOxp
         aZeFy0G0/hy42YcR5ZqGGreCJRSa/TsVNd7T2JCuxOEPnEwSstesgUtB3t1cGKbvvzG5
         9nCcm8dy5XLeSN/8pJXLmDyowTVSBUZRVYBOcxjalFuCXOTUibrvm7MrB4D8sqfFYLrA
         4L0g==
X-Gm-Message-State: AOAM531BDgdPwKk0tpW49iDizSPu4Ocv39SnXSIo4lS9as2EdW0P5a6y
        DywJwJRTgOHsW7NkZGIUV3+gGDLmBZsTqhyR4g==
X-Google-Smtp-Source: ABdhPJxfehStPEkJ3pUnpGoIAn6powT/fnb9r1MZcIuc+Bkv40QUK2XLdEFie9F8fMw6kxFJ4XcRsrnRfBWhIxZZAw==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a62:1a56:0:b029:19d:b6eb:291a with
 SMTP id a83-20020a621a560000b029019db6eb291amr2047387pfa.10.1610083985027;
 Thu, 07 Jan 2021 21:33:05 -0800 (PST)
Date:   Thu,  7 Jan 2021 21:32:57 -0800
In-Reply-To: <20210108053259.726613-1-lokeshgidra@google.com>
Message-Id: <20210108053259.726613-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20210108053259.726613-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v14 2/4] fs: add LSM-supporting anon-inode interface
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Daniel Colascione <dancol@google.com>

This change adds a new function, anon_inode_getfd_secure, that creates
anonymous-node file with individual non-S_PRIVATE inode to which security
modules can apply policy. Existing callers continue using the original
singleton-inode kind of anonymous-inode file. We can transition anonymous
inode users to the new kind of anonymous inode in individual patches for
the sake of bisection and review.

The new function accepts an optional context_inode parameter that callers
can use to provide additional contextual information to security modules.
For example, in case of userfaultfd, the created inode is a 'logical child'
of the context_inode (userfaultfd inode of the parent process) in the sense
that it provides the security context required during creation of the child
process' userfaultfd inode.

Signed-off-by: Daniel Colascione <dancol@google.com>

[LG: Delete obsolete comments to alloc_anon_inode()]
[LG: Add context_inode description in comments to anon_inode_getfd_secure()]
[LG: Remove definition of anon_inode_getfile_secure() as there are no callers]
[LG: Make __anon_inode_getfile() static]
[LG: Use correct error cast in __anon_inode_getfile()]
[LG: Fix error handling in __anon_inode_getfile()]

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/anon_inodes.c            | 150 ++++++++++++++++++++++++++----------
 fs/libfs.c                  |   5 --
 include/linux/anon_inodes.h |   5 ++
 3 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..023337d65a03 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,61 +55,79 @@ static struct file_system_type anon_inode_fs_type = {
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
+	const struct inode *context_inode)
 {
-	struct file *file;
+	struct inode *inode;
+	const struct qstr qname = QSTR_INIT(name, strlen(name));
+	int error;
+
+	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return inode;
+	inode->i_flags &= ~S_PRIVATE;
+	error =	security_inode_init_security_anon(inode, &qname, context_inode);
+	if (error) {
+		iput(inode);
+		return ERR_PTR(error);
+	}
+	return inode;
+}
 
-	if (IS_ERR(anon_inode_inode))
-		return ERR_PTR(-ENODEV);
+static struct file *__anon_inode_getfile(const char *name,
+					 const struct file_operations *fops,
+					 void *priv, int flags,
+					 const struct inode *context_inode,
+					 bool secure)
+{
+	struct inode *inode;
+	struct file *file;
 
 	if (fops->owner && !try_module_get(fops->owner))
 		return ERR_PTR(-ENOENT);
 
-	/*
-	 * We know the anon_inode inode count is always greater than zero,
-	 * so ihold() is safe.
-	 */
-	ihold(anon_inode_inode);
-	file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
+	if (secure) {
+		inode =	anon_inode_make_secure_inode(name, context_inode);
+		if (IS_ERR(inode)) {
+			file = ERR_CAST(inode);
+			goto err;
+		}
+	} else {
+		inode =	anon_inode_inode;
+		if (IS_ERR(inode)) {
+			file = ERR_PTR(-ENODEV);
+			goto err;
+		}
+		/*
+		 * We know the anon_inode inode count is always
+		 * greater than zero, so ihold() is safe.
+		 */
+		ihold(inode);
+	}
+
+	file = alloc_file_pseudo(inode, anon_inode_mnt, name,
 				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file))
-		goto err;
+		goto err_iput;
 
-	file->f_mapping = anon_inode_inode->i_mapping;
+	file->f_mapping = inode->i_mapping;
 
 	file->private_data = priv;
 
 	return file;
 
+err_iput:
+	iput(inode);
 err:
-	iput(anon_inode_inode);
 	module_put(fops->owner);
 	return file;
 }
-EXPORT_SYMBOL_GPL(anon_inode_getfile);
 
 /**
- * anon_inode_getfd - creates a new file instance by hooking it up to an
- *                    anonymous inode, and a dentry that describe the "class"
- *                    of the file
+ * anon_inode_getfile - creates a new file instance by hooking it up to an
+ *                      anonymous inode, and a dentry that describe the "class"
+ *                      of the file
  *
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
@@ -118,12 +136,23 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
  *
  * Creates a new file by hooking it on a single inode. This is useful for files
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
+	return __anon_inode_getfile(name, fops, priv, flags, NULL, false);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfile);
+
+static int __anon_inode_getfd(const char *name,
+			      const struct file_operations *fops,
+			      void *priv, int flags,
+			      const struct inode *context_inode,
+			      bool secure)
 {
 	int error, fd;
 	struct file *file;
@@ -133,7 +162,8 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		return error;
 	fd = error;
 
-	file = anon_inode_getfile(name, fops, priv, flags);
+	file = __anon_inode_getfile(name, fops, priv, flags, context_inode,
+				    secure);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_put_unused_fd;
@@ -146,8 +176,48 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 	put_unused_fd(fd);
 	return error;
 }
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
+ * Creates a new file by hooking it on a single inode. This is
+ * useful for files that do not need to have a full-fledged inode in
+ * order to operate correctly.  All the files created with
+ * anon_inode_getfd() will use the same singleton inode, reducing
+ * memory use and avoiding code duplication for the file/inode/dentry
+ * setup.  Returns a newly created file descriptor or an error code.
+ */
+int anon_inode_getfd(const char *name, const struct file_operations *fops,
+		     void *priv, int flags)
+{
+	return __anon_inode_getfd(name, fops, priv, flags, NULL, false);
+}
 EXPORT_SYMBOL_GPL(anon_inode_getfd);
 
+/**
+ * Like anon_inode_getfd(), but creates a new !S_PRIVATE anon inode rather than
+ * reuse the singleton anon inode, and calls the inode_init_security_anon() LSM
+ * hook. This allows the inode to have its own security context and for a LSM
+ * to reject creation of the inode.  An optional @context_inode argument is
+ * also added to provide the logical relationship with the new inode.  The LSM
+ * may use @context_inode in inode_init_security_anon(), but a reference to it
+ * is not held.
+ */
+int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
+			    void *priv, int flags,
+			    const struct inode *context_inode)
+{
+	return __anon_inode_getfd(name, fops, priv, flags, context_inode, true);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
+
 static int __init anon_inode_init(void)
 {
 	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
diff --git a/fs/libfs.c b/fs/libfs.c
index d1c3bade9f30..e52818fb276a 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1214,11 +1214,6 @@ static int anon_set_page_dirty(struct page *page)
 	return 0;
 };
 
-/*
- * A single inode exists for all anon_inode files. Contrary to pipes,
- * anon_inode inodes have no associated per-instance data, so we need
- * only allocate one of them.
- */
 struct inode *alloc_anon_inode(struct super_block *s)
 {
 	static const struct address_space_operations anon_aops = {
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index d0d7d96261ad..71881a2b6f78 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -10,12 +10,17 @@
 #define _LINUX_ANON_INODES_H
 
 struct file_operations;
+struct inode;
 
 struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags);
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags);
+int anon_inode_getfd_secure(const char *name,
+			    const struct file_operations *fops,
+			    void *priv, int flags,
+			    const struct inode *context_inode);
 
 #endif /* _LINUX_ANON_INODES_H */
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

