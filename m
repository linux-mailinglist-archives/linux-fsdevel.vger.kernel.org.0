Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933612A8924
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 22:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbgKEVdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 16:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbgKEVdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:33:35 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271ADC0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 13:33:34 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id r16so1652139pls.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2020 13:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AZ9CuApbWUuyKZjL7V5mL8MUZ1TwkboSp5kTlPzCu3s=;
        b=UmXaLViLtRlhTD4Oeu4GcPnE4zu/VgoYhWFG2sTKhVfu8SWcZUk1UynjvLf69yP59+
         +okdhFr5cnFo4oYl5KzvYe5qLtWcUf+Qk4cObjKcs20KopeYzXmOF5+lPMTYJb4NiXfO
         Y8knJuYlJMm85cE1c4FUHL2wVSsNgnbCTGOhOkA9LyUIej4Zvrwq63lGHFej4JoAPQxp
         hsxjkz6P8YNsVz+XHI+s9sZvCWbNHLRjNkohPL1YE/Z4lOQgIq532c2aqoyeeSNSTKI+
         s2jo669lud71fuCpCymlC6ZE+Gy67vvMLios70yxqF6ibtvb486uoDkophzY4D1BA6Tr
         9VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AZ9CuApbWUuyKZjL7V5mL8MUZ1TwkboSp5kTlPzCu3s=;
        b=ZjhOfkNdv7oepoHTq+D6tJ+yHc6JUj5O85/2oNEybNBGxc4XC4/WbOz/eVefixehzt
         X/v97DDkvvzduqww6o1iOMGL5npQrf4IsTjBPdEY9kcqadb+GZLHOZNfeSlQnpvTgne4
         /DIoqCgN0IPkqGlqql63WwPlJaw57BbM+gmGBm2CWvujLiXzbAUjlsi6bi6hLn6AusdU
         uiLIHp4I8tMhX02XiWWhNKOOB8f+CfJeP6K3kBhrfyMwBiAzpFhCvUWLzdEvjfnU2RQz
         XQFswMReo3xPXJx+iloZR2EB5imiF3koyHDTeB5W5mSsfCsri6fCdoua+TD+g0lvw0uP
         A25w==
X-Gm-Message-State: AOAM5335F4gt/X1OqCA5EfD0Hxk0ebexczLMgh6PFtxIU0OwDkXkeFUZ
        mt6a3Tkxwe/p3/k1+oEWk6wLcOqhFX281pVu5Q==
X-Google-Smtp-Source: ABdhPJxPrb7Pc+Ue/Z0N7yRtCd9V9izxBZE2KLTHjeOZx1BOFysU18j6xCTgm2beA0/htoZs2pXuRJGuqiZudB+Eqg==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:bb8b:: with SMTP id
 v11mr4353310pjr.57.1604612013631; Thu, 05 Nov 2020 13:33:33 -0800 (PST)
Date:   Thu,  5 Nov 2020 13:33:22 -0800
In-Reply-To: <20201105213324.3111570-1-lokeshgidra@google.com>
Message-Id: <20201105213324.3111570-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201105213324.3111570-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v11 2/4] fs: add LSM-supporting anon-inode interface
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

The new function accepts an optional context_inode parameter that
callers can use to provide additional contextual information to
security modules for granting/denying permission to create an anon inode
of the same type.

For example, in case of userfaultfd, the created inode is a
'logical child' of the context_inode (userfaultfd inode of the
parent process) in the sense that it provides the security context
required during creation of the child process' userfaultfd inode.

Signed-off-by: Daniel Colascione <dancol@google.com>

[Update comments to alloc_anon_inode()]
[Add context_inode description in comments to anon_inode_getfd_secure()]
[Remove definition of anon_inode_getfile_secure() as there are no callers]
[Make __anon_inode_getfile() static]
[Use correct error cast in __anon_inode_getfile()]
[Fix error handling in __anon_inode_getfile()]

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/anon_inodes.c            | 149 ++++++++++++++++++++++++++----------
 fs/libfs.c                  |   6 +-
 include/linux/anon_inodes.h |   5 ++
 3 files changed, 117 insertions(+), 43 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..fc935acb90d6 100644
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
@@ -146,8 +176,47 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
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
+ * reuse the singleton anon inode, and call the init_security_anon() LSM hook.
+ * This allows the inode to have its own security context and for a LSM to
+ * reject creation of the inode.  An optional @context_inode argument is also
+ * added to provide the logical relationship with the new inode.  The LSM may use
+ * @context_inode in init_security_anon(), but a reference to it is not held.
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
index fc34361c1489..5b12228ecc81 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1213,9 +1213,9 @@ static int anon_set_page_dirty(struct page *page)
 };
 
 /*
- * A single inode exists for all anon_inode files. Contrary to pipes,
- * anon_inode inodes have no associated per-instance data, so we need
- * only allocate one of them.
+ * A single inode exists for all anon_inode files, except for the secure ones.
+ * Contrary to pipes and secure anon_inode inodes, ordinary anon_inode inodes
+ * have no associated per-instance data, so we need only allocate one of them.
  */
 struct inode *alloc_anon_inode(struct super_block *s)
 {
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index d0d7d96261ad..6cf447cfceed 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -10,10 +10,15 @@
 #define _LINUX_ANON_INODES_H
 
 struct file_operations;
+struct inode;
 
 struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags);
+int anon_inode_getfd_secure(const char *name,
+			    const struct file_operations *fops,
+			    void *priv, int flags,
+			    const struct inode *context_inode);
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags);
 
-- 
2.29.1.341.ge80a0c044ae-goog

