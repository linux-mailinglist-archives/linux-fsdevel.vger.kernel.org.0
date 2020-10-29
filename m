Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46E729DD5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbgJ2Ahl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:37:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60953 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbgJ2Afv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:51 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvup-0008Ep-Bf; Thu, 29 Oct 2020 00:35:43 +0000
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
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 18/34] namei: prepare for idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:36 +0100
Message-Id: <20201029003252.2128653-19-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The various vfs_*() helpers are called by filesystems or by the vfs itself to
perform core operations create, link, mkdir, mknod, rename, rmdir, tmpfile and
unlink. Add a set of helpers that handle idmapped mounts. If the inode is
accessed through an idmapped mount it is mapped according to the mount's user
namespace. Afterwards the checks and operations are identical to non-idmapped
mounts. If the initial user namespace is passed all mapping operations are a
nop so non-idmapped mounts will not see a change in behavior and will also not
see any performance impact. It also means that the non-idmapped-mount aware
helpers can be implemented on top of their idmapped-mount aware counterparts by
passing the initial user namespace.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c               | 229 +++++++++++++++++++++++++++------------
 fs/overlayfs/overlayfs.h |   2 +-
 include/linux/fs.h       |  32 +++++-
 3 files changed, 192 insertions(+), 71 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 781f11795a22..a8a3de936cfc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2835,10 +2835,10 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
-int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		bool want_excl)
+int vfs_mapped_create(struct user_namespace *user_ns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, bool want_excl)
 {
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 	if (error)
 		return error;
 
@@ -2854,6 +2854,13 @@ int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		fsnotify_create(dir, dentry);
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_create);
+
+int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+		bool want_excl)
+{
+	return vfs_mapped_create(&init_user_ns, dir, dentry, mode, want_excl);
+}
 EXPORT_SYMBOL(vfs_create);
 
 int vfs_mkobj(struct dentry *dentry, umode_t mode,
@@ -3313,7 +3320,9 @@ static int do_open(struct nameidata *nd,
 	return error;
 }
 
-struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
+struct dentry *vfs_mapped_tmpfile(struct user_namespace *user_ns,
+				  struct dentry *dentry, umode_t mode,
+				  int open_flag)
 {
 	struct dentry *child = NULL;
 	struct inode *dir = dentry->d_inode;
@@ -3321,7 +3330,7 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
 	int error;
 
 	/* we want directory to be writable */
-	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = mapped_inode_permission(user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		goto out_err;
 	error = -EOPNOTSUPP;
@@ -3350,12 +3359,19 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
 	dput(child);
 	return ERR_PTR(error);
 }
+EXPORT_SYMBOL(vfs_mapped_tmpfile);
+
+struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
+{
+	return vfs_mapped_tmpfile(&init_user_ns, dentry, mode, open_flag);
+}
 EXPORT_SYMBOL(vfs_tmpfile);
 
 static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
 		struct file *file)
 {
+	struct user_namespace *user_ns;
 	struct dentry *child;
 	struct path path;
 	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
@@ -3364,7 +3380,8 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	error = mnt_want_write(path.mnt);
 	if (unlikely(error))
 		goto out;
-	child = vfs_tmpfile(path.dentry, op->mode, op->open_flag);
+	user_ns = mnt_user_ns(path.mnt);
+	child = vfs_mapped_tmpfile(user_ns, path.dentry, op->mode, op->open_flag);
 	error = PTR_ERR(child);
 	if (IS_ERR(child))
 		goto out2;
@@ -3576,10 +3593,11 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 }
 EXPORT_SYMBOL(user_path_create);
 
-int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+int vfs_mapped_mknod(struct user_namespace *user_ns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 
 	if (error)
 		return error;
@@ -3604,6 +3622,12 @@ int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 		fsnotify_create(dir, dentry);
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_mknod);
+
+int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	return vfs_mapped_mknod(&init_user_ns, dir, dentry, mode, dev);
+}
 EXPORT_SYMBOL(vfs_mknod);
 
 static int may_mknod(umode_t mode)
@@ -3626,6 +3650,7 @@ static int may_mknod(umode_t mode)
 static long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		unsigned int dev)
 {
+	struct user_namespace *user_ns;
 	struct dentry *dentry;
 	struct path path;
 	int error;
@@ -3644,18 +3669,22 @@ static long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (error)
 		goto out;
+
+	user_ns = mnt_user_ns(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(path.dentry->d_inode,dentry,mode,true);
+			error = vfs_mapped_create(user_ns, path.dentry->d_inode,
+						  dentry, mode, true);
 			if (!error)
 				ima_post_path_mknod(dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
-			error = vfs_mknod(path.dentry->d_inode,dentry,mode,
-					new_decode_dev(dev));
+			error = vfs_mapped_mknod(user_ns, path.dentry->d_inode,
+						 dentry, mode, new_decode_dev(dev));
 			break;
 		case S_IFIFO: case S_IFSOCK:
-			error = vfs_mknod(path.dentry->d_inode,dentry,mode,0);
+			error = vfs_mapped_mknod(user_ns, path.dentry->d_inode,
+						 dentry, mode, 0);
 			break;
 	}
 out:
@@ -3678,9 +3707,10 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 	return do_mknodat(AT_FDCWD, filename, mode, dev);
 }
 
-int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+int vfs_mapped_mkdir(struct user_namespace *user_ns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode)
 {
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 	unsigned max_links = dir->i_sb->s_max_links;
 
 	if (error)
@@ -3702,6 +3732,12 @@ int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		fsnotify_mkdir(dir, dentry);
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_mkdir);
+
+int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	return vfs_mapped_mkdir(&init_user_ns, dir, dentry, mode);
+}
 EXPORT_SYMBOL(vfs_mkdir);
 
 static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
@@ -3719,8 +3755,11 @@ static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 	if (!IS_POSIXACL(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
-	if (!error)
-		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
+	if (!error) {
+		struct user_namespace *user_ns;
+		user_ns = mnt_user_ns(path.mnt);
+		error = vfs_mapped_mkdir(user_ns, path.dentry->d_inode, dentry, mode);
+	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -3739,9 +3778,10 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 	return do_mkdirat(AT_FDCWD, pathname, mode);
 }
 
-int vfs_rmdir(struct inode *dir, struct dentry *dentry)
+int vfs_mapped_rmdir(struct user_namespace *user_ns, struct inode *dir,
+		     struct dentry *dentry)
 {
-	int error = may_delete(&init_user_ns, dir, dentry, 1);
+	int error = may_delete(user_ns, dir, dentry, 1);
 
 	if (error)
 		return error;
@@ -3777,10 +3817,17 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 		d_delete(dentry);
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_rmdir);
+
+int vfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	return vfs_mapped_rmdir(&init_user_ns, dir, dentry);
+}
 EXPORT_SYMBOL(vfs_rmdir);
 
 long do_rmdir(int dfd, struct filename *name)
 {
+	struct user_namespace *user_ns;
 	int error = 0;
 	struct dentry *dentry;
 	struct path path;
@@ -3821,7 +3868,8 @@ long do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit3;
-	error = vfs_rmdir(path.dentry->d_inode, dentry);
+	user_ns = mnt_user_ns(path.mnt);
+	error = vfs_mapped_rmdir(user_ns, path.dentry->d_inode, dentry);
 exit3:
 	dput(dentry);
 exit2:
@@ -3842,28 +3890,11 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 	return do_rmdir(AT_FDCWD, getname(pathname));
 }
 
-/**
- * vfs_unlink - unlink a filesystem object
- * @dir:	parent directory
- * @dentry:	victim
- * @delegated_inode: returns victim inode, if the inode is delegated.
- *
- * The caller must hold dir->i_mutex.
- *
- * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
- * return a reference to the inode in delegated_inode.  The caller
- * should then break the delegation on that inode and retry.  Because
- * breaking a delegation may take a long time, the caller should drop
- * dir->i_mutex before doing so.
- *
- * Alternatively, a caller may pass NULL for delegated_inode.  This may
- * be appropriate for callers that expect the underlying filesystem not
- * to be NFS exported.
- */
-int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegated_inode)
+int vfs_mapped_unlink(struct user_namespace *user_ns, struct inode *dir,
+		      struct dentry *dentry, struct inode **delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
-	int error = may_delete(&init_user_ns, dir, dentry, 0);
+	int error = may_delete(user_ns, dir, dentry, 0);
 
 	if (error)
 		return error;
@@ -3899,6 +3930,30 @@ int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegate
 
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_unlink);
+
+/**
+ * vfs_unlink - unlink a filesystem object
+ * @dir:	parent directory
+ * @dentry:	victim
+ * @delegated_inode: returns victim inode, if the inode is delegated.
+ *
+ * The caller must hold dir->i_mutex.
+ *
+ * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
+ * return a reference to the inode in delegated_inode.  The caller
+ * should then break the delegation on that inode and retry.  Because
+ * breaking a delegation may take a long time, the caller should drop
+ * dir->i_mutex before doing so.
+ *
+ * Alternatively, a caller may pass NULL for delegated_inode.  This may
+ * be appropriate for callers that expect the underlying filesystem not
+ * to be NFS exported.
+ */
+int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegated_inode)
+{
+	return vfs_mapped_unlink(&init_user_ns, dir, dentry, delegated_inode);
+}
 EXPORT_SYMBOL(vfs_unlink);
 
 /*
@@ -3934,6 +3989,8 @@ long do_unlinkat(int dfd, struct filename *name)
 	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		struct user_namespace *user_ns;
+
 		/* Why not before? Because we want correct error value */
 		if (last.name[last.len])
 			goto slashes;
@@ -3944,7 +4001,8 @@ long do_unlinkat(int dfd, struct filename *name)
 		error = security_path_unlink(&path, dentry);
 		if (error)
 			goto exit2;
-		error = vfs_unlink(path.dentry->d_inode, dentry, &delegated_inode);
+		user_ns = mnt_user_ns(path.mnt);
+		error = vfs_mapped_unlink(user_ns, path.dentry->d_inode, dentry, &delegated_inode);
 exit2:
 		dput(dentry);
 	}
@@ -3993,9 +4051,10 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
 	return do_unlinkat(AT_FDCWD, getname(pathname));
 }
 
-int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
+int vfs_mapped_symlink(struct user_namespace *user_ns, struct inode *dir,
+		       struct dentry *dentry, const char *oldname)
 {
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 
 	if (error)
 		return error;
@@ -4012,6 +4071,12 @@ int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 		fsnotify_create(dir, dentry);
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_symlink);
+
+int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
+{
+	return vfs_mapped_symlink(&init_user_ns, dir, dentry, oldname);
+}
 EXPORT_SYMBOL(vfs_symlink);
 
 static long do_symlinkat(const char __user *oldname, int newdfd,
@@ -4033,8 +4098,12 @@ static long do_symlinkat(const char __user *oldname, int newdfd,
 		goto out_putname;
 
 	error = security_path_symlink(&path, dentry, from->name);
-	if (!error)
-		error = vfs_symlink(path.dentry->d_inode, dentry, from->name);
+	if (!error) {
+		struct user_namespace *user_ns;
+		user_ns = mnt_user_ns(path.mnt);
+		error = vfs_mapped_symlink(user_ns, path.dentry->d_inode,
+					   dentry, from->name);
+	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -4057,8 +4126,9 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
 }
 
 /**
- * vfs_link - create a new link
+ * vfs_mapped_link - create a new link on an idmapped mount
  * @old_dentry:	object to be linked
+ * @user_ns:	the user namespace of the mount
  * @dir:	new parent
  * @new_dentry:	where to create the new link
  * @delegated_inode: returns inode needing a delegation break
@@ -4075,7 +4145,9 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.
  */
-int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry, struct inode **delegated_inode)
+int vfs_mapped_link(struct dentry *old_dentry, struct user_namespace *user_ns,
+		    struct inode *dir, struct dentry *new_dentry,
+		    struct inode **delegated_inode)
 {
 	struct inode *inode = old_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4084,7 +4156,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(&init_user_ns, dir, new_dentry);
+	error = may_create(user_ns, dir, new_dentry);
 	if (error)
 		return error;
 
@@ -4134,6 +4206,33 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 		fsnotify_link(dir, inode, new_dentry);
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_link);
+
+/**
+ * vfs_link - create a new link
+ * @old_dentry:	object to be linked
+ * @dir:	new parent
+ * @new_dentry:	where to create the new link
+ * @delegated_inode: returns inode needing a delegation break
+ *
+ * The caller must hold dir->i_mutex
+ *
+ * If vfs_link discovers a delegation on the to-be-linked file in need
+ * of breaking, it will return -EWOULDBLOCK and return a reference to the
+ * inode in delegated_inode.  The caller should then break the delegation
+ * and retry.  Because breaking a delegation may take a long time, the
+ * caller should drop the i_mutex before doing so.
+ *
+ * Alternatively, a caller may pass NULL for delegated_inode.  This may
+ * be appropriate for callers that expect the underlying filesystem not
+ * to be NFS exported.
+ */
+int vfs_link(struct dentry *old_dentry, struct inode *dir,
+	     struct dentry *new_dentry, struct inode **delegated_inode)
+{
+	return vfs_mapped_link(old_dentry, &init_user_ns, dir, new_dentry,
+			       delegated_inode);
+}
 EXPORT_SYMBOL(vfs_link);
 
 /*
@@ -4148,6 +4247,7 @@ EXPORT_SYMBOL(vfs_link);
 static int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	      const char __user *newname, int flags)
 {
+	struct user_namespace *user_ns;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
 	struct inode *delegated_inode = NULL;
@@ -4189,7 +4289,9 @@ static int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry, &delegated_inode);
+	user_ns = mnt_user_ns(new_path.mnt);
+	error = vfs_mapped_link(old_path.dentry, user_ns,
+				new_path.dentry->d_inode, new_dentry, &delegated_inode);
 out_dput:
 	done_path_create(&new_path, new_dentry);
 	if (delegated_inode) {
@@ -4221,19 +4323,9 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
-struct renamedata {
-	struct inode *old_dir;
-	struct dentry *old_dentry;
-	struct inode *new_dir;
-	struct dentry *new_dentry;
-	struct inode **delegated_inode;
-	unsigned int flags;
-} __randomize_layout;
-
-static int __vfs_rename(struct renamedata *rd)
+int vfs_mapped_rename(struct renamedata *rd)
 {
 	int error;
-	struct user_namespace *user_ns = &init_user_ns;
 	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
 	struct dentry *old_dentry = rd->old_dentry,
 		      *new_dentry = rd->new_dentry;
@@ -4249,19 +4341,19 @@ static int __vfs_rename(struct renamedata *rd)
 	if (source == target)
 		return 0;
 
-	error = may_delete(user_ns, old_dir, old_dentry, is_dir);
+	error = may_delete(rd->old_user_ns, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
-		error = may_create(user_ns, new_dir, new_dentry);
+		error = may_create(rd->new_user_ns, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(user_ns, new_dir, new_dentry, is_dir);
+			error = may_delete(rd->new_user_ns, new_dir, new_dentry, is_dir);
 		else
-			error = may_delete(user_ns, new_dir, new_dentry, new_is_dir);
+			error = may_delete(rd->new_user_ns, new_dir, new_dentry, new_is_dir);
 	}
 	if (error)
 		return error;
@@ -4275,12 +4367,12 @@ static int __vfs_rename(struct renamedata *rd)
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(source, MAY_WRITE);
+			error = mapped_inode_permission(rd->old_user_ns, source, MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(target, MAY_WRITE);
+			error = mapped_inode_permission(rd->new_user_ns, target, MAY_WRITE);
 			if (error)
 				return error;
 		}
@@ -4357,6 +4449,7 @@ static int __vfs_rename(struct renamedata *rd)
 
 	return error;
 }
+EXPORT_SYMBOL(vfs_mapped_rename);
 
 /**
  * vfs_rename - rename a filesystem object
@@ -4419,7 +4512,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		.delegated_inode = delegated_inode,
 		.flags		 = flags,
 	};
-	return __vfs_rename(&rd);
+	return vfs_mapped_rename(&rd);
 }
 EXPORT_SYMBOL(vfs_rename);
 
@@ -4535,11 +4628,13 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 
 	rd.old_dir	   = old_path.dentry->d_inode;
 	rd.old_dentry	   = old_dentry;
+	rd.old_user_ns	   = mnt_user_ns(old_path.mnt);
 	rd.new_dir	   = new_path.dentry->d_inode;
 	rd.new_dentry	   = new_dentry;
+	rd.new_user_ns	   = mnt_user_ns(new_path.mnt);
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
-	error = __vfs_rename(&rd);
+	error = vfs_mapped_rename(&rd);
 exit5:
 	dput(new_dentry);
 exit4:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..30ee48ddfaa2 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -224,7 +224,7 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 
 static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_whiteout(dir, dentry);
+	int err = vfs_whiteout(&init_user_ns, dir, dentry);
 	pr_debug("whiteout(%pd2) = %i\n", dentry, err);
 	return err;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e66852dee65d..f523b1db48c4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1784,21 +1784,47 @@ extern bool mapped_inode_owner_or_capable(struct user_namespace *ns,
  * VFS helper functions..
  */
 extern int vfs_create(struct inode *, struct dentry *, umode_t, bool);
+extern int vfs_mapped_create(struct user_namespace *, struct inode *, struct dentry *, umode_t, bool);
 extern int vfs_mkdir(struct inode *, struct dentry *, umode_t);
+extern int vfs_mapped_mkdir(struct user_namespace *, struct inode *, struct dentry *, umode_t);
 extern int vfs_mknod(struct inode *, struct dentry *, umode_t, dev_t);
+extern int vfs_mapped_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t, dev_t);
 extern int vfs_symlink(struct inode *, struct dentry *, const char *);
+extern int vfs_mapped_symlink(struct user_namespace *, struct inode *, struct dentry *, const char *);
 extern int vfs_link(struct dentry *, struct inode *, struct dentry *, struct inode **);
+extern int vfs_mapped_link(struct dentry *, struct user_namespace *, struct inode *,
+		       struct dentry *, struct inode **);
 extern int vfs_rmdir(struct inode *, struct dentry *);
+extern int vfs_mapped_rmdir(struct user_namespace *, struct inode *, struct dentry *);
 extern int vfs_unlink(struct inode *, struct dentry *, struct inode **);
-extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *, struct inode **, unsigned int);
+extern int vfs_mapped_unlink(struct user_namespace *, struct inode *, struct dentry *, struct inode **);
+
+struct renamedata {
+	struct user_namespace *old_user_ns;
+	struct inode *old_dir;
+	struct dentry *old_dentry;
+	struct user_namespace *new_user_ns;
+	struct inode *new_dir;
+	struct dentry *new_dentry;
+	struct inode **delegated_inode;
+	unsigned int flags;
+} __randomize_layout;
+
+extern int vfs_rename(struct inode *, struct dentry *, struct inode *,
+		      struct dentry *, struct inode **, unsigned int);
+extern int vfs_mapped_rename(struct renamedata *);
 
-static inline int vfs_whiteout(struct inode *dir, struct dentry *dentry)
+static inline int vfs_whiteout(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *dentry)
 {
-	return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	return vfs_mapped_mknod(user_ns, dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 
 extern struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode,
 				  int open_flag);
+extern struct dentry *vfs_mapped_tmpfile(struct user_namespace *user_ns,
+				     struct dentry *dentry, umode_t mode,
+				     int open_flag);
 
 int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
-- 
2.29.0

