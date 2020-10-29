Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146EA29DE12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbgJ2Aoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:44:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60711 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732129AbgJ2Afo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:44 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvue-0008Ep-Dl; Thu, 29 Oct 2020 00:35:32 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 12/34] xattr: handle idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:30 +0100
Message-Id: <20201029003252.2128653-13-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.pizza>

When interacting with extended attributes the vfs verifies that the
caller is privileged over the inode with which the extended attribute is
associated. Add helpers to handle extended attributes on idmapped
mounts. If the inode is accessed through an idmapped mount we need to
map it according to the mount's user namespace. Afterwards the checks
are identical to non-idmapped mounts.
This patch adds helpers to get, set, and remove extended attributes on
idmapped mounts. The four helpers vfs_mapped_getxattr(),
vfs_mapped_setxattr(), __vfs_mapped_removexattr(), and
vfs_mapped_removexattr() are either used directly by the vfs (e.g.
vfs_mapped_getxattr_alloc()) or by the filesystems targeted in this
first interation.

If the initial user namespace is passed all operations are a nop so
non-idmapped mounts will not see a change in behavior and will also not
see any performance impact. It also means that the non-idmapped-mount
aware helpers can be implemented on top of their idmapped-mount aware
counterparts by passing the initial user namespace.

Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/xattr.c            | 252 +++++++++++++++++++++++++++++-------------
 include/linux/xattr.h |  23 ++++
 2 files changed, 196 insertions(+), 79 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 96ff53b42251..cdda2baeb9f7 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -83,7 +83,8 @@ xattr_resolve_name(struct inode *inode, const char **name)
  * because different namespaces have very different rules.
  */
 static int
-xattr_permission(struct inode *inode, const char *name, int mask)
+xattr_permission(struct user_namespace *user_ns, struct inode *inode,
+		 const char *name, int mask)
 {
 	/*
 	 * We can never set or remove an extended attribute on a read-only
@@ -127,11 +128,11 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
-		    (mask & MAY_WRITE) && !inode_owner_or_capable(inode))
+		    (mask & MAY_WRITE) && !mapped_inode_owner_or_capable(user_ns, inode))
 			return -EPERM;
 	}
 
-	return inode_permission(inode, mask);
+	return mapped_inode_permission(user_ns, inode, mask);
 }
 
 /*
@@ -161,9 +162,10 @@ xattr_supported_namespace(struct inode *inode, const char *prefix)
 }
 EXPORT_SYMBOL(xattr_supported_namespace);
 
-int
-__vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
-	       const void *value, size_t size, int flags)
+static int
+__vfs_mapped_setxattr(struct user_namespace *user_ns, struct dentry *dentry,
+		  struct inode *inode, const char *name, const void *value,
+		  size_t size, int flags)
 {
 	const struct xattr_handler *handler;
 
@@ -174,7 +176,14 @@ __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 		return -EOPNOTSUPP;
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	return handler->set(handler, dentry, inode, name, value, size, flags);
+	return xattr_handler_set(handler, user_ns, dentry, inode, name, value, size, flags);
+}
+
+int
+__vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
+	       const void *value, size_t size, int flags)
+{
+	return __vfs_mapped_setxattr(&init_user_ns, dentry, inode, name, value, size, flags);
 }
 EXPORT_SYMBOL(__vfs_setxattr);
 
@@ -182,6 +191,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  __vfs_setxattr_noperm - perform setxattr operation without performing
  *  permission checks.
  *
+ *  @user_ns - user namespace of the mount
  *  @dentry - object to perform setxattr on
  *  @name - xattr name to set
  *  @value - value to set @name to
@@ -194,8 +204,10 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  is executed. It also assumes that the caller will make the appropriate
  *  permission checks.
  */
-int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags)
+static int
+__vfs_mapped_setxattr_noperm(struct user_namespace *user_ns,
+			     struct dentry *dentry, const char *name,
+			     const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = -EAGAIN;
@@ -205,7 +217,7 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	if (issec)
 		inode->i_flags &= ~S_NOSEC;
 	if (inode->i_opflags & IOP_XATTR) {
-		error = __vfs_setxattr(dentry, inode, name, value, size, flags);
+		error = __vfs_mapped_setxattr(user_ns, dentry, inode, name, value, size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
 			security_inode_post_setxattr(dentry, name, value,
@@ -231,27 +243,23 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	return error;
 }
 
-/**
- * __vfs_setxattr_locked - set an extended attribute while holding the inode
- * lock
- *
- *  @dentry: object to perform setxattr on
- *  @name: xattr name to set
- *  @value: value to set @name to
- *  @size: size of @value
- *  @flags: flags to pass into filesystem operations
- *  @delegated_inode: on return, will contain an inode pointer that
- *  a delegation was broken on, NULL if none.
- */
-int
-__vfs_setxattr_locked(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags,
-		struct inode **delegated_inode)
+int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags)
+{
+	return __vfs_mapped_setxattr_noperm(&init_user_ns, dentry, name, value,
+					    size, flags);
+}
+
+static int
+__vfs_mapped_setxattr_locked(struct user_namespace *user_ns,
+			     struct dentry *dentry, const char *name,
+			     const void *value, size_t size, int flags,
+			     struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_WRITE);
+	error = xattr_permission(user_ns, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -263,16 +271,37 @@ __vfs_setxattr_locked(struct dentry *dentry, const char *name,
 	if (error)
 		goto out;
 
-	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
+	error = __vfs_mapped_setxattr_noperm(user_ns, dentry, name, value, size, flags);
 
 out:
 	return error;
 }
+
+/**
+ * __vfs_setxattr_locked - set an extended attribute while holding the inode
+ * lock
+ *
+ *  @dentry: object to perform setxattr on
+ *  @name: xattr name to set
+ *  @value: value to set @name to
+ *  @size: size of @value
+ *  @flags: flags to pass into filesystem operations
+ *  @delegated_inode: on return, will contain an inode pointer that
+ *  a delegation was broken on, NULL if none.
+ */
+int
+__vfs_setxattr_locked(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags,
+		struct inode **delegated_inode)
+{
+	return __vfs_mapped_setxattr_locked(&init_user_ns, dentry, name, value,
+					    size, flags, delegated_inode);
+}
 EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
 
 int
-vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags)
+vfs_mapped_setxattr(struct user_namespace *user_ns, struct dentry *dentry,
+		const char *name, const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -280,8 +309,8 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
-	    &delegated_inode);
+	error = __vfs_mapped_setxattr_locked(user_ns, dentry, name, value, size,
+					     flags, &delegated_inode);
 	inode_unlock(inode);
 
 	if (delegated_inode) {
@@ -291,6 +320,14 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	}
 	return error;
 }
+EXPORT_SYMBOL_GPL(vfs_mapped_setxattr);
+
+int
+vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+		size_t size, int flags)
+{
+	return vfs_mapped_setxattr(&init_user_ns, dentry, name, value, size, flags);
+}
 EXPORT_SYMBOL_GPL(vfs_setxattr);
 
 static ssize_t
@@ -319,24 +356,17 @@ xattr_getsecurity(struct inode *inode, const char *name, void *value,
 	return len;
 }
 
-/*
- * vfs_getxattr_alloc - allocate memory, if necessary, before calling getxattr
- *
- * Allocate memory, if not already allocated, or re-allocate correct size,
- * before retrieving the extended attribute.
- *
- * Returns the result of alloc, if failed, or the getxattr operation.
- */
 ssize_t
-vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
-		   size_t xattr_size, gfp_t flags)
+vfs_mapped_getxattr_alloc(struct user_namespace *user_ns, struct dentry *dentry,
+		      const char *name, char **xattr_value, size_t xattr_size,
+		      gfp_t flags)
 {
 	const struct xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 	char *value = *xattr_value;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_READ);
+	error = xattr_permission(user_ns, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -361,6 +391,22 @@ vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
 	return error;
 }
 
+/*
+ * vfs_getxattr_alloc - allocate memory, if necessary, before calling getxattr
+ *
+ * Allocate memory, if not already allocated, or re-allocate correct size,
+ * before retrieving the extended attribute.
+ *
+ * Returns the result of alloc, if failed, or the getxattr operation.
+ */
+ssize_t
+vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
+		   size_t xattr_size, gfp_t flags)
+{
+	return vfs_mapped_getxattr_alloc(&init_user_ns, dentry, name, xattr_value,
+				     xattr_size, flags);
+}
+
 ssize_t
 __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	       void *value, size_t size)
@@ -377,12 +423,13 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 EXPORT_SYMBOL(__vfs_getxattr);
 
 ssize_t
-vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
+vfs_mapped_getxattr(struct user_namespace *user_ns, struct dentry *dentry,
+		const char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_READ);
+	error = xattr_permission(user_ns, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -405,6 +452,13 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
 nolsm:
 	return __vfs_getxattr(dentry, inode, name, value, size);
 }
+EXPORT_SYMBOL_GPL(vfs_mapped_getxattr);
+
+ssize_t
+vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
+{
+	return vfs_mapped_getxattr(&init_user_ns, dentry, name, value, size);
+}
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
 ssize_t
@@ -428,7 +482,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 EXPORT_SYMBOL_GPL(vfs_listxattr);
 
 int
-__vfs_removexattr(struct dentry *dentry, const char *name)
+__vfs_mapped_removexattr(struct user_namespace *user_ns, struct dentry *dentry, const char *name)
 {
 	struct inode *inode = d_inode(dentry);
 	const struct xattr_handler *handler;
@@ -438,27 +492,26 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 		return PTR_ERR(handler);
 	if (!handler->set)
 		return -EOPNOTSUPP;
-	return handler->set(handler, dentry, inode, name, NULL, 0, XATTR_REPLACE);
+	return xattr_handler_set(handler, user_ns, dentry, inode, name, NULL, 0, XATTR_REPLACE);
 }
-EXPORT_SYMBOL(__vfs_removexattr);
+EXPORT_SYMBOL(__vfs_mapped_removexattr);
 
-/**
- * __vfs_removexattr_locked - set an extended attribute while holding the inode
- * lock
- *
- *  @dentry: object to perform setxattr on
- *  @name: name of xattr to remove
- *  @delegated_inode: on return, will contain an inode pointer that
- *  a delegation was broken on, NULL if none.
- */
 int
-__vfs_removexattr_locked(struct dentry *dentry, const char *name,
-		struct inode **delegated_inode)
+__vfs_removexattr(struct dentry *dentry, const char *name)
+{
+	return __vfs_mapped_removexattr(&init_user_ns, dentry, name);
+}
+EXPORT_SYMBOL(__vfs_removexattr);
+
+static int
+__vfs_mapped_removexattr_locked(struct user_namespace *user_ns,
+				struct dentry *dentry, const char *name,
+				struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_WRITE);
+	error = xattr_permission(user_ns, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -470,7 +523,7 @@ __vfs_removexattr_locked(struct dentry *dentry, const char *name,
 	if (error)
 		goto out;
 
-	error = __vfs_removexattr(dentry, name);
+	error = __vfs_mapped_removexattr(user_ns, dentry, name);
 
 	if (!error) {
 		fsnotify_xattr(dentry);
@@ -480,10 +533,27 @@ __vfs_removexattr_locked(struct dentry *dentry, const char *name,
 out:
 	return error;
 }
+
+/**
+ * __vfs_removexattr_locked - set an extended attribute while holding the inode
+ * lock
+ *
+ *  @dentry: object to perform setxattr on
+ *  @name: name of xattr to remove
+ *  @delegated_inode: on return, will contain an inode pointer that
+ *  a delegation was broken on, NULL if none.
+ */
+int
+__vfs_removexattr_locked(struct dentry *dentry, const char *name,
+			 struct inode **delegated_inode)
+{
+	return __vfs_mapped_removexattr_locked(&init_user_ns, dentry, name, delegated_inode);
+}
 EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
 
 int
-vfs_removexattr(struct dentry *dentry, const char *name)
+vfs_mapped_removexattr(struct user_namespace *user_ns, struct dentry *dentry,
+		       const char *name)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -491,7 +561,7 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
+	error = __vfs_mapped_removexattr_locked(user_ns, dentry, name, &delegated_inode);
 	inode_unlock(inode);
 
 	if (delegated_inode) {
@@ -502,14 +572,22 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(vfs_mapped_removexattr);
+
+int
+vfs_removexattr(struct dentry *dentry, const char *name)
+{
+	return vfs_mapped_removexattr(&init_user_ns, dentry, name);
+}
 EXPORT_SYMBOL_GPL(vfs_removexattr);
 
 /*
  * Extended attribute SET operations
  */
 static long
-setxattr(struct dentry *d, const char __user *name, const void __user *value,
-	 size_t size, int flags)
+setxattr(struct user_namespace *user_ns, struct dentry *d,
+	 const char __user *name, const void __user *value, size_t size,
+	 int flags)
 {
 	int error;
 	void *kvalue = NULL;
@@ -536,16 +614,16 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		}
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_from_user(&init_user_ns, kvalue, size);
+			posix_acl_fix_xattr_from_user(user_ns, kvalue, size);
 		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
-			error = cap_convert_nscap(&init_user_ns, d, &kvalue, size);
+			error = cap_convert_nscap(user_ns, d, &kvalue, size);
 			if (error < 0)
 				goto out;
 			size = error;
 		}
 	}
 
-	error = vfs_setxattr(d, kname, kvalue, size, flags);
+	error = vfs_mapped_setxattr(user_ns, d, kname, kvalue, size, flags);
 out:
 	kvfree(kvalue);
 
@@ -558,13 +636,17 @@ static int path_setxattr(const char __user *pathname,
 {
 	struct path path;
 	int error;
+
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = setxattr(path.dentry, name, value, size, flags);
+		struct user_namespace *user_ns;
+
+		user_ns = mnt_user_ns(path.mnt);
+		error = setxattr(user_ns, path.dentry, name, value, size, flags);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -600,7 +682,11 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = setxattr(f.file->f_path.dentry, name, value, size, flags);
+		struct user_namespace *user_ns;
+
+		user_ns = mnt_user_ns(f.file->f_path.mnt);
+		error = setxattr(user_ns, f.file->f_path.dentry, name, value,
+				 size, flags);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
@@ -612,7 +698,7 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
  */
 static ssize_t
 getxattr(struct dentry *d, const char __user *name, void __user *value,
-	 size_t size)
+	 size_t size, struct user_namespace *user_ns)
 {
 	ssize_t error;
 	void *kvalue = NULL;
@@ -632,11 +718,11 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
 			return -ENOMEM;
 	}
 
-	error = vfs_getxattr(d, kname, kvalue, size);
+	error = vfs_mapped_getxattr(user_ns, d, kname, kvalue, size);
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(&init_user_ns, kvalue, error);
+			posix_acl_fix_xattr_to_user(user_ns, kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
@@ -654,13 +740,15 @@ static ssize_t path_getxattr(const char __user *pathname,
 			     const char __user *name, void __user *value,
 			     size_t size, unsigned int lookup_flags)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	ssize_t error;
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
-	error = getxattr(path.dentry, name, value, size);
+	user_ns = mnt_user_ns(path.mnt);
+	error = getxattr(path.dentry, name, value, size, user_ns);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -684,13 +772,15 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
+	struct user_namespace *user_ns;
 	struct fd f = fdget(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
 		return error;
 	audit_file(f.file);
-	error = getxattr(f.file->f_path.dentry, name, value, size);
+	user_ns = mnt_user_ns(f.file->f_path.mnt);
+	error = getxattr(f.file->f_path.dentry, name, value, size, user_ns);
 	fdput(f);
 	return error;
 }
@@ -774,7 +864,7 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct dentry *d, const char __user *name)
+removexattr(struct user_namespace *user_ns, struct dentry *d, const char __user *name)
 {
 	int error;
 	char kname[XATTR_NAME_MAX + 1];
@@ -785,7 +875,7 @@ removexattr(struct dentry *d, const char __user *name)
 	if (error < 0)
 		return error;
 
-	return vfs_removexattr(d, kname);
+	return vfs_mapped_removexattr(user_ns, d, kname);
 }
 
 static int path_removexattr(const char __user *pathname,
@@ -799,7 +889,9 @@ static int path_removexattr(const char __user *pathname,
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = removexattr(path.dentry, name);
+		struct user_namespace *user_ns = mnt_user_ns(path.mnt);
+
+		error = removexattr(user_ns, path.dentry, name);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -832,7 +924,9 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = removexattr(f.file->f_path.dentry, name);
+		struct user_namespace *user_ns = mnt_user_ns(f.file->f_path.mnt);
+
+		error = removexattr(user_ns, f.file->f_path.dentry, name);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 908441e74f51..b2eeecdf6669 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/user_namespace.h>
 #include <uapi/linux/xattr.h>
 
 struct inode;
@@ -45,6 +46,19 @@ struct xattr_handler {
 #endif
 };
 
+static inline int xattr_handler_set(const struct xattr_handler *handler,
+			  struct user_namespace *user_ns, struct dentry *dentry,
+			  struct inode *inode, const char *name,
+			  const void *buffer, size_t size, int flags)
+{
+#ifdef CONFIG_IDMAP_MOUNTS
+	if (handler->set_mapped)
+		return handler->set_mapped(handler, user_ns, dentry, inode,
+					   name, buffer, size, flags);
+#endif
+	return handler->set(handler, dentry, inode, name, buffer, size, flags);
+}
+
 const char *xattr_full_name(const struct xattr_handler *, const char *);
 
 struct xattr {
@@ -55,18 +69,27 @@ struct xattr {
 
 ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
 ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
+ssize_t vfs_mapped_getxattr(struct user_namespace *user_ns, struct dentry *dentry,
+			const char *name, void *value, size_t size);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
 int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
 int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
+int vfs_mapped_setxattr(struct user_namespace *, struct dentry *, const char *, const void *, size_t, int);
 int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
 int __vfs_removexattr(struct dentry *, const char *);
+int __vfs_mapped_removexattr(struct user_namespace *, struct dentry *, const char *);
 int __vfs_removexattr_locked(struct dentry *, const char *, struct inode **);
 int vfs_removexattr(struct dentry *, const char *);
+int vfs_mapped_removexattr(struct user_namespace *user_ns, struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
 ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
 			   char **xattr_value, size_t size, gfp_t flags);
+ssize_t vfs_mapped_getxattr_alloc(struct user_namespace *user_ns,
+			      struct dentry *dentry, const char *name,
+			      char **xattr_value, size_t xattr_size,
+			      gfp_t flags);
 
 int xattr_supported_namespace(struct inode *inode, const char *prefix);
 
-- 
2.29.0

