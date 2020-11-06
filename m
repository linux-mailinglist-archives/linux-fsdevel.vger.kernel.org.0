Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5342A98E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 16:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgKFP4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 10:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgKFP4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:56:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C0C0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 07:56:40 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q19so1073106pls.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=K1tKoG3gV3mvaGumxi+ncw/ywOUYroypjPAyFUGu9Nk=;
        b=jVcvCNyiv2ekGvZP1xq6eEzynrjZKEm6F9bVVR1vjTG0wQS7fufyRih438mqK7Kkiq
         KLOAWvUZ424CkL4A2tfOOif3hxB+InetxFxBpaTDUwz8fxbU5gz4gQON7mQDB8YIiQ7/
         KTx6P8k8hOZXBok4bKAXalbY5qtdO9U3UjDqWBDKQw9o1gu4P4bT4B8huyjSTfbBkfkr
         630T8LxaWzDI9OXCo4Idi9mA+B93K0DKxNkJbSp7FucfAzBdS0ijNTk2M5JhesxbNg4c
         /E00PdkrTeQLC2Vp+HTGygyYrsb266mOD8C82hVwlXiSj1gUQBA5dduyX8jwUwkibToo
         p17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K1tKoG3gV3mvaGumxi+ncw/ywOUYroypjPAyFUGu9Nk=;
        b=Qr/ZOfishiFl/S/Z9OLtG+2j6641OygsRTcditjSBQtoBjPm3v2QMjZOXFGB7ZYrEN
         rkFpTBt5UOt4slHTk0kJZr1b6/AxEapUdQSH6sYDuSIu66RPhjZJt+neV9wxCh8I1VTb
         o6i3O6JS910RpFxDQbWhXgxYUGRQU4NVng11smLxiixIDyr+BAXppZFmyKGZy7sNiDuY
         QvFStoRRYnPvkhhc+3mradcwCt3nCRde+uoyFQ9Gwt+C4jegT50l1EXnhj+SICAfIbsW
         BHUudMzysiviEuavOHS5AnI0F+PVvYc/xqRDZkSE9WxL9AE+g+pd2iWGLYESTmqtv0ML
         BsjQ==
X-Gm-Message-State: AOAM531bmyDCTT/yMthtGRX63tpsEyKj7RzHh9mtl3vqDZSJu82KDnTz
        lHCQdlk+IpGhWJpcVZ7oVxHVSHADqcaoVg0PSQ==
X-Google-Smtp-Source: ABdhPJzX+ldB9eUktF4RkQHal7CBcp/KfbU1CDRzz6KLrtL0sFJ7Ou3GJqSABQ5cCfYWJNptJ/pSJtiBHJMeeqthrA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:3d0f:: with SMTP id
 h15mr218382pjc.234.1604678199465; Fri, 06 Nov 2020 07:56:39 -0800 (PST)
Date:   Fri,  6 Nov 2020 07:56:24 -0800
In-Reply-To: <20201106155626.3395468-1-lokeshgidra@google.com>
Message-Id: <20201106155626.3395468-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 2/4] fs: add LSM-supporting anon-inode interface
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org, Daniel Colascione <dancol@google.com>
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

[Delete obsolete comments to alloc_anon_inode()]
[Add context_inode description in comments to anon_inode_getfd_secure()]
[Remove definition of anon_inode_getfile_secure() as there are no callers]
[Make __anon_inode_getfile() static]
[Use correct error cast in __anon_inode_getfile()]
[Fix error handling in __anon_inode_getfile()]

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/anon_inodes.c            | 150 ++++++++++++++++++++++++++----------
 fs/libfs.c                  |   5 --
 include/linux/anon_inodes.h |   5 ++
 3 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..f4b35aaed7b2 100644
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
+ * reuse the singleton anon inode, and call the anon_init_security_anon() LSM
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
index fc34361c1489..51c19c72e563 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1212,11 +1212,6 @@ static int anon_set_page_dirty(struct page *page)
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
2.29.1.341.ge80a0c044ae-goog

