Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1D2B33E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgKOKjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:39:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgKOKjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:39:21 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFR5-0000Kt-E4; Sun, 15 Nov 2020 10:39:07 +0000
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
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 18/39] namei: prepare for idmapped mounts
Date:   Sun, 15 Nov 2020 11:36:57 +0100
Message-Id: <20201115103718.298186-19-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The various vfs_*() helpers are called by filesystems or by the vfs itself
to perform core operations create, link, mkdir, mknod, rename, rmdir,
tmpfile and unlink. Enable them to handle idmapped mounts. If the inode is
accessed through an idmapped mount it is mapped according to the mount's
user namespace.
Afterwards the checks and operations are identical to non-idmapped mounts.
If the initial user namespace is passed all mapping operations are a nop so
non-idmapped mounts will not see a change in behavior and will also not see
any performance impact.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.
---
 drivers/base/devtmpfs.c  |   8 +--
 fs/cachefiles/namei.c    |  10 ++--
 fs/ecryptfs/inode.c      |  22 ++++----
 fs/init.c                |  12 ++---
 fs/namei.c               | 108 +++++++++++++++++++++++++--------------
 fs/nfsd/nfs4recover.c    |   6 +--
 fs/nfsd/vfs.c            |  19 ++++---
 fs/overlayfs/dir.c       |   4 +-
 fs/overlayfs/overlayfs.h |  20 ++++----
 include/linux/fs.h       |  25 +++++----
 ipc/mqueue.c             |   2 +-
 net/unix/af_unix.c       |   2 +-
 12 files changed, 144 insertions(+), 94 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 2e0c3cdb4184..fd4e86c58111 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -162,7 +162,7 @@ static int dev_mkdir(const char *name, umode_t mode)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	err = vfs_mkdir(d_inode(path.dentry), dentry, mode);
+	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
 	if (!err)
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
@@ -212,7 +212,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	err = vfs_mknod(d_inode(path.dentry), dentry, mode, dev->devt);
+	err = vfs_mknod(&init_user_ns, d_inode(path.dentry), dentry, mode, dev->devt);
 	if (!err) {
 		struct iattr newattrs;
 
@@ -242,7 +242,7 @@ static int dev_rmdir(const char *name)
 		return PTR_ERR(dentry);
 	if (d_really_is_positive(dentry)) {
 		if (d_inode(dentry)->i_private == &thread)
-			err = vfs_rmdir(d_inode(parent.dentry), dentry);
+			err = vfs_rmdir(&init_user_ns, d_inode(parent.dentry), dentry);
 		else
 			err = -EPERM;
 	} else {
@@ -330,7 +330,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 			inode_lock(d_inode(dentry));
 			notify_change(&init_user_ns, dentry, &newattrs, NULL);
 			inode_unlock(d_inode(dentry));
-			err = vfs_unlink(d_inode(parent.dentry), dentry, NULL);
+			err = vfs_unlink(&init_user_ns, d_inode(parent.dentry), dentry, NULL);
 			if (!err || err == -ENOENT)
 				deleted = 1;
 		}
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7b987de0babe..ae01fac0a80c 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -311,7 +311,7 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 			cachefiles_io_error(cache, "Unlink security error");
 		} else {
 			trace_cachefiles_unlink(object, rep, why);
-			ret = vfs_unlink(d_inode(dir), rep, NULL);
+			ret = vfs_unlink(&init_user_ns, d_inode(dir), rep, NULL);
 
 			if (preemptive)
 				cachefiles_mark_object_buried(cache, rep, why);
@@ -413,8 +413,10 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
 		struct renamedata rd = {
+			.old_user_ns	= &init_user_ns,
 			.old_dir	= d_inode(dir),
 			.old_dentry	= rep,
+			.new_user_ns	= &init_user_ns,
 			.new_dir	= d_inode(cache->graveyard),
 			.new_dentry	= grave,
 		};
@@ -566,7 +568,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			if (ret < 0)
 				goto create_error;
 			start = jiffies;
-			ret = vfs_mkdir(d_inode(dir), next, 0);
+			ret = vfs_mkdir(&init_user_ns, d_inode(dir), next, 0);
 			cachefiles_hist(cachefiles_mkdir_histogram, start);
 			if (!key)
 				trace_cachefiles_mkdir(object, next, ret);
@@ -602,7 +604,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			if (ret < 0)
 				goto create_error;
 			start = jiffies;
-			ret = vfs_create(d_inode(dir), next, S_IFREG, true);
+			ret = vfs_create(&init_user_ns, d_inode(dir), next, S_IFREG, true);
 			cachefiles_hist(cachefiles_create_histogram, start);
 			trace_cachefiles_create(object, next, ret);
 			if (ret < 0)
@@ -796,7 +798,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = security_path_mkdir(&path, subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
-		ret = vfs_mkdir(d_inode(dir), subdir, 0700);
+		ret = vfs_mkdir(&init_user_ns, d_inode(dir), subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 838949ede439..42066c5613ca 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -141,7 +141,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	else if (d_unhashed(lower_dentry))
 		rc = -EINVAL;
 	else
-		rc = vfs_unlink(lower_dir_inode, lower_dentry, NULL);
+		rc = vfs_unlink(&init_user_ns, lower_dir_inode, lower_dentry, NULL);
 	if (rc) {
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
@@ -180,7 +180,8 @@ ecryptfs_do_create(struct inode *directory_inode,
 
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_create(d_inode(lower_dir_dentry), lower_dentry, mode, true);
+	rc = vfs_create(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry,
+			mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
@@ -190,7 +191,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	inode = __ecryptfs_get_inode(d_inode(lower_dentry),
 				     directory_inode->i_sb);
 	if (IS_ERR(inode)) {
-		vfs_unlink(d_inode(lower_dir_dentry), lower_dentry, NULL);
+		vfs_unlink(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry, NULL);
 		goto out_lock;
 	}
 	fsstack_copy_attr_times(directory_inode, d_inode(lower_dir_dentry));
@@ -436,8 +437,8 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 	dget(lower_old_dentry);
 	dget(lower_new_dentry);
 	lower_dir_dentry = lock_parent(lower_new_dentry);
-	rc = vfs_link(lower_old_dentry, d_inode(lower_dir_dentry),
-		      lower_new_dentry, NULL);
+	rc = vfs_link(lower_old_dentry, &init_user_ns,
+		      d_inode(lower_dir_dentry), lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
@@ -481,7 +482,7 @@ static int ecryptfs_symlink(struct inode *dir, struct dentry *dentry,
 						  strlen(symname));
 	if (rc)
 		goto out_lock;
-	rc = vfs_symlink(d_inode(lower_dir_dentry), lower_dentry,
+	rc = vfs_symlink(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry,
 			 encoded_symname);
 	kfree(encoded_symname);
 	if (rc || d_really_is_negative(lower_dentry))
@@ -507,7 +508,7 @@ static int ecryptfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_mkdir(d_inode(lower_dir_dentry), lower_dentry, mode);
+	rc = vfs_mkdir(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry, mode);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
@@ -541,7 +542,7 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 	else if (d_unhashed(lower_dentry))
 		rc = -EINVAL;
 	else
-		rc = vfs_rmdir(lower_dir_inode, lower_dentry);
+		rc = vfs_rmdir(&init_user_ns, lower_dir_inode, lower_dentry);
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
 		fsstack_copy_attr_times(dir, lower_dir_inode);
@@ -563,7 +564,8 @@ ecryptfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_mknod(d_inode(lower_dir_dentry), lower_dentry, mode, dev);
+	rc = vfs_mknod(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry,
+		       mode, dev);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
@@ -621,8 +623,10 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_lock;
 	}
 
+	rd.old_user_ns	= &init_user_ns;
 	rd.old_dir	= d_inode(lower_old_dir_dentry);
 	rd.old_dentry	= lower_old_dentry;
+	rd.new_user_ns	= &init_user_ns;
 	rd.new_dir	= d_inode(lower_new_dir_dentry);
 	rd.new_dentry	= lower_new_dentry;
 	rc = vfs_rename(&rd);
diff --git a/fs/init.c b/fs/init.c
index 2b4842f4802b..76f493600030 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -160,8 +160,8 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 		mode &= ~current_umask();
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
-		error = vfs_mknod(path.dentry->d_inode, dentry, mode,
-				  new_decode_dev(dev));
+		error = vfs_mknod(&init_user_ns, path.dentry->d_inode, dentry,
+				  mode, new_decode_dev(dev));
 	done_path_create(&path, dentry);
 	return error;
 }
@@ -190,8 +190,8 @@ int __init init_link(const char *oldname, const char *newname)
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry,
-			 NULL);
+	error = vfs_link(old_path.dentry, &init_user_ns, 
+			 new_path.dentry->d_inode, new_dentry, NULL);
 out_dput:
 	done_path_create(&new_path, new_dentry);
 out:
@@ -210,7 +210,7 @@ int __init init_symlink(const char *oldname, const char *newname)
 		return PTR_ERR(dentry);
 	error = security_path_symlink(&path, dentry, oldname);
 	if (!error)
-		error = vfs_symlink(path.dentry->d_inode, dentry, oldname);
+		error = vfs_symlink(&init_user_ns, path.dentry->d_inode, dentry, oldname);
 	done_path_create(&path, dentry);
 	return error;
 }
@@ -233,7 +233,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
-		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
+		error = vfs_mkdir(&init_user_ns, path.dentry->d_inode, dentry, mode);
 	done_path_create(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 0a2450de83bb..b91bf923d22c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2820,10 +2820,10 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
-int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		bool want_excl)
+int vfs_create(struct user_namespace *user_ns, struct inode *dir,
+	       struct dentry *dentry, umode_t mode, bool want_excl)
 {
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 	if (error)
 		return error;
 
@@ -3298,7 +3298,8 @@ static int do_open(struct nameidata *nd,
 	return error;
 }
 
-struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
+struct dentry *vfs_tmpfile(struct user_namespace *user_ns,
+			   struct dentry *dentry, umode_t mode, int open_flag)
 {
 	struct dentry *child = NULL;
 	struct inode *dir = dentry->d_inode;
@@ -3306,7 +3307,7 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
 	int error;
 
 	/* we want directory to be writable */
-	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		goto out_err;
 	error = -EOPNOTSUPP;
@@ -3341,6 +3342,7 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
 		struct file *file)
 {
+	struct user_namespace *user_ns;
 	struct dentry *child;
 	struct path path;
 	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
@@ -3349,7 +3351,8 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	error = mnt_want_write(path.mnt);
 	if (unlikely(error))
 		goto out;
-	child = vfs_tmpfile(path.dentry, op->mode, op->open_flag);
+	user_ns = mnt_user_ns(path.mnt);
+	child = vfs_tmpfile(user_ns, path.dentry, op->mode, op->open_flag);
 	error = PTR_ERR(child);
 	if (IS_ERR(child))
 		goto out2;
@@ -3561,10 +3564,11 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 }
 EXPORT_SYMBOL(user_path_create);
 
-int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+int vfs_mknod(struct user_namespace *user_ns, struct inode *dir,
+	      struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 
 	if (error)
 		return error;
@@ -3611,6 +3615,7 @@ static int may_mknod(umode_t mode)
 static long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		unsigned int dev)
 {
+	struct user_namespace *user_ns;
 	struct dentry *dentry;
 	struct path path;
 	int error;
@@ -3629,18 +3634,22 @@ static long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (error)
 		goto out;
+
+	user_ns = mnt_user_ns(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(path.dentry->d_inode,dentry,mode,true);
+			error = vfs_create(user_ns, path.dentry->d_inode,
+					   dentry, mode, true);
 			if (!error)
 				ima_post_path_mknod(dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
-			error = vfs_mknod(path.dentry->d_inode,dentry,mode,
-					new_decode_dev(dev));
+			error = vfs_mknod(user_ns, path.dentry->d_inode, dentry,
+					  mode, new_decode_dev(dev));
 			break;
 		case S_IFIFO: case S_IFSOCK:
-			error = vfs_mknod(path.dentry->d_inode,dentry,mode,0);
+			error = vfs_mknod(user_ns, path.dentry->d_inode, dentry,
+					  mode, 0);
 			break;
 	}
 out:
@@ -3663,9 +3672,10 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 	return do_mknodat(AT_FDCWD, filename, mode, dev);
 }
 
-int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+int vfs_mkdir(struct user_namespace *user_ns, struct inode *dir,
+	      struct dentry *dentry, umode_t mode)
 {
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 	unsigned max_links = dir->i_sb->s_max_links;
 
 	if (error)
@@ -3704,8 +3714,11 @@ static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 	if (!IS_POSIXACL(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
-	if (!error)
-		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
+	if (!error) {
+		struct user_namespace *user_ns;
+		user_ns = mnt_user_ns(path.mnt);
+		error = vfs_mkdir(user_ns, path.dentry->d_inode, dentry, mode);
+	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -3724,9 +3737,10 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 	return do_mkdirat(AT_FDCWD, pathname, mode);
 }
 
-int vfs_rmdir(struct inode *dir, struct dentry *dentry)
+int vfs_rmdir(struct user_namespace *user_ns, struct inode *dir,
+		     struct dentry *dentry)
 {
-	int error = may_delete(&init_user_ns, dir, dentry, 1);
+	int error = may_delete(user_ns, dir, dentry, 1);
 
 	if (error)
 		return error;
@@ -3766,6 +3780,7 @@ EXPORT_SYMBOL(vfs_rmdir);
 
 long do_rmdir(int dfd, struct filename *name)
 {
+	struct user_namespace *user_ns;
 	int error = 0;
 	struct dentry *dentry;
 	struct path path;
@@ -3806,7 +3821,8 @@ long do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit3;
-	error = vfs_rmdir(path.dentry->d_inode, dentry);
+	user_ns = mnt_user_ns(path.mnt);
+	error = vfs_rmdir(user_ns, path.dentry->d_inode, dentry);
 exit3:
 	dput(dentry);
 exit2:
@@ -3845,10 +3861,11 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.
  */
-int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegated_inode)
+int vfs_unlink(struct user_namespace *user_ns, struct inode *dir,
+	       struct dentry *dentry, struct inode **delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
-	int error = may_delete(&init_user_ns, dir, dentry, 0);
+	int error = may_delete(user_ns, dir, dentry, 0);
 
 	if (error)
 		return error;
@@ -3919,6 +3936,8 @@ long do_unlinkat(int dfd, struct filename *name)
 	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		struct user_namespace *user_ns;
+
 		/* Why not before? Because we want correct error value */
 		if (last.name[last.len])
 			goto slashes;
@@ -3929,7 +3948,8 @@ long do_unlinkat(int dfd, struct filename *name)
 		error = security_path_unlink(&path, dentry);
 		if (error)
 			goto exit2;
-		error = vfs_unlink(path.dentry->d_inode, dentry, &delegated_inode);
+		user_ns = mnt_user_ns(path.mnt);
+		error = vfs_unlink(user_ns, path.dentry->d_inode, dentry, &delegated_inode);
 exit2:
 		dput(dentry);
 	}
@@ -3978,9 +3998,10 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
 	return do_unlinkat(AT_FDCWD, getname(pathname));
 }
 
-int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
+int vfs_symlink(struct user_namespace *user_ns, struct inode *dir,
+		struct dentry *dentry, const char *oldname)
 {
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(user_ns, dir, dentry);
 
 	if (error)
 		return error;
@@ -4018,8 +4039,12 @@ static long do_symlinkat(const char __user *oldname, int newdfd,
 		goto out_putname;
 
 	error = security_path_symlink(&path, dentry, from->name);
-	if (!error)
-		error = vfs_symlink(path.dentry->d_inode, dentry, from->name);
+	if (!error) {
+		struct user_namespace *user_ns;
+		user_ns = mnt_user_ns(path.mnt);
+		error = vfs_symlink(user_ns, path.dentry->d_inode, dentry,
+				    from->name);
+	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -4044,6 +4069,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
 /**
  * vfs_link - create a new link
  * @old_dentry:	object to be linked
+ * @user_ns:	the user namespace of the mount
  * @dir:	new parent
  * @new_dentry:	where to create the new link
  * @delegated_inode: returns inode needing a delegation break
@@ -4060,7 +4086,9 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.
  */
-int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry, struct inode **delegated_inode)
+int vfs_link(struct dentry *old_dentry, struct user_namespace *user_ns,
+	     struct inode *dir, struct dentry *new_dentry,
+	     struct inode **delegated_inode)
 {
 	struct inode *inode = old_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4069,7 +4097,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(&init_user_ns, dir, new_dentry);
+	error = may_create(user_ns, dir, new_dentry);
 	if (error)
 		return error;
 
@@ -4086,7 +4114,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	 * be writen back improperly if their true value is unknown to
 	 * the vfs.
 	 */
-	if (HAS_UNMAPPED_ID(&init_user_ns, inode))
+	if (HAS_UNMAPPED_ID(user_ns, inode))
 		return -EPERM;
 	if (!dir->i_op->link)
 		return -EPERM;
@@ -4133,6 +4161,7 @@ EXPORT_SYMBOL(vfs_link);
 static int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	      const char __user *newname, int flags)
 {
+	struct user_namespace *user_ns;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
 	struct inode *delegated_inode = NULL;
@@ -4174,7 +4203,9 @@ static int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry, &delegated_inode);
+	user_ns = mnt_user_ns(new_path.mnt);
+	error = vfs_link(old_path.dentry, user_ns, new_path.dentry->d_inode,
+			 new_dentry, &delegated_inode);
 out_dput:
 	done_path_create(&new_path, new_dentry);
 	if (delegated_inode) {
@@ -4208,8 +4239,10 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 
 /**
  * vfs_rename - rename a filesystem object
+ * @old_user_ns: user namespace the old inode is accessed from
  * @old_dir:	parent of source
  * @old_dentry:	source
+ * @new_user_ns: user namespace the old inode is accessed from
  * @new_dir:	parent of destination
  * @new_dentry:	destination
  * @delegated_inode: returns an inode needing a delegation break
@@ -4259,7 +4292,6 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 int vfs_rename(struct renamedata *rd)
 {
 	int error;
-	struct user_namespace *user_ns = &init_user_ns;
 	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
 	struct dentry *old_dentry = rd->old_dentry,
 		      *new_dentry = rd->new_dentry;
@@ -4275,19 +4307,19 @@ int vfs_rename(struct renamedata *rd)
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
@@ -4301,12 +4333,12 @@ int vfs_rename(struct renamedata *rd)
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(&init_user_ns, source, MAY_WRITE);
+			error = inode_permission(rd->old_user_ns, source, MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(&init_user_ns, target, MAY_WRITE);
+			error = inode_permission(rd->new_user_ns, target, MAY_WRITE);
 			if (error)
 				return error;
 		}
@@ -4497,8 +4529,10 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 
 	rd.old_dir	   = old_path.dentry->d_inode;
 	rd.old_dentry	   = old_dentry;
+	rd.old_user_ns	   = mnt_user_ns(old_path.mnt);
 	rd.new_dir	   = new_path.dentry->d_inode;
 	rd.new_dentry	   = new_dentry;
+	rd.new_user_ns	   = mnt_user_ns(new_path.mnt);
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 186fa2c2c6ba..891395c6c7d3 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -233,7 +233,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	status = vfs_mkdir(d_inode(dir), dentry, S_IRWXU);
+	status = vfs_mkdir(&init_user_ns, d_inode(dir), dentry, S_IRWXU);
 out_put:
 	dput(dentry);
 out_unlock:
@@ -353,7 +353,7 @@ nfsd4_unlink_clid_dir(char *name, int namlen, struct nfsd_net *nn)
 	status = -ENOENT;
 	if (d_really_is_negative(dentry))
 		goto out;
-	status = vfs_rmdir(d_inode(dir), dentry);
+	status = vfs_rmdir(&init_user_ns, d_inode(dir), dentry);
 out:
 	dput(dentry);
 out_unlock:
@@ -443,7 +443,7 @@ purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	status = vfs_rmdir(d_inode(parent), child);
+	status = vfs_rmdir(&init_user_ns, d_inode(parent), child);
 	if (status)
 		printk("failed to remove client recovery directory %pd\n",
 				child);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 3d7a8cd61098..49837c995377 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1245,12 +1245,12 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	host_err = 0;
 	switch (type) {
 	case S_IFREG:
-		host_err = vfs_create(dirp, dchild, iap->ia_mode, true);
+		host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
 		if (!host_err)
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
-		host_err = vfs_mkdir(dirp, dchild, iap->ia_mode);
+		host_err = vfs_mkdir(&init_user_ns, dirp, dchild, iap->ia_mode);
 		if (!host_err && unlikely(d_unhashed(dchild))) {
 			struct dentry *d;
 			d = lookup_one_len(dchild->d_name.name,
@@ -1278,7 +1278,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
-		host_err = vfs_mknod(dirp, dchild, iap->ia_mode, rdev);
+		host_err = vfs_mknod(&init_user_ns, dirp, dchild,
+				     iap->ia_mode, rdev);
 		break;
 	default:
 		printk(KERN_WARNING "nfsd: bad file type %o in nfsd_create\n",
@@ -1476,7 +1477,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(dirp))
 		iap->ia_mode &= ~current_umask();
 
-	host_err = vfs_create(dirp, dchild, iap->ia_mode, true);
+	host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
 	if (host_err < 0) {
 		fh_drop_write(fhp);
 		goto out_nfserr;
@@ -1600,7 +1601,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (IS_ERR(dnew))
 		goto out_nfserr;
 
-	host_err = vfs_symlink(d_inode(dentry), dnew, path);
+	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
@@ -1668,7 +1669,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
 		goto out_dput;
-	host_err = vfs_link(dold, dirp, dnew, NULL);
+	host_err = vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
 	if (!host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
@@ -1788,8 +1789,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out_dput_old;
 	} else {
 		struct renamedata rd = {
+			.old_user_ns	= &init_user_ns,
 			.old_dir	= fdir,
 			.old_dentry	= odentry,
+			.new_user_ns	= &init_user_ns,
 			.new_dir	= tdir,
 			.new_dentry	= ndentry,
 		};
@@ -1879,9 +1882,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 
 	if (type != S_IFDIR) {
 		nfsd_close_cached_files(rdentry);
-		host_err = vfs_unlink(dirp, rdentry, NULL);
+		host_err = vfs_unlink(&init_user_ns, dirp, rdentry, NULL);
 	} else {
-		host_err = vfs_rmdir(dirp, rdentry);
+		host_err = vfs_rmdir(&init_user_ns, dirp, rdentry);
 	}
 
 	if (!host_err)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a1794c838b78..fa6e3fde9a26 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -821,9 +821,9 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 		goto out_dput_upper;
 
 	if (is_dir)
-		err = vfs_rmdir(dir, upper);
+		err = vfs_rmdir(&init_user_ns, dir, upper);
 	else
-		err = vfs_unlink(dir, upper, NULL);
+		err = vfs_unlink(&init_user_ns, dir, upper, NULL);
 	ovl_dir_modified(dentry->d_parent, ovl_type_origin(dentry));
 
 	/*
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 73da8710b0f0..0249ea876dc3 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -121,7 +121,7 @@ static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr ox)
 
 static inline int ovl_do_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_rmdir(dir, dentry);
+	int err = vfs_rmdir(&init_user_ns, dir, dentry);
 
 	pr_debug("rmdir(%pd2) = %i\n", dentry, err);
 	return err;
@@ -129,7 +129,7 @@ static inline int ovl_do_rmdir(struct inode *dir, struct dentry *dentry)
 
 static inline int ovl_do_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_unlink(dir, dentry, NULL);
+	int err = vfs_unlink(&init_user_ns, dir, dentry, NULL);
 
 	pr_debug("unlink(%pd2) = %i\n", dentry, err);
 	return err;
@@ -138,7 +138,7 @@ static inline int ovl_do_unlink(struct inode *dir, struct dentry *dentry)
 static inline int ovl_do_link(struct dentry *old_dentry, struct inode *dir,
 			      struct dentry *new_dentry)
 {
-	int err = vfs_link(old_dentry, dir, new_dentry, NULL);
+	int err = vfs_link(old_dentry, &init_user_ns, dir, new_dentry, NULL);
 
 	pr_debug("link(%pd2, %pd2) = %i\n", old_dentry, new_dentry, err);
 	return err;
@@ -147,7 +147,7 @@ static inline int ovl_do_link(struct dentry *old_dentry, struct inode *dir,
 static inline int ovl_do_create(struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(dir, dentry, mode, true);
+	int err = vfs_create(&init_user_ns, dir, dentry, mode, true);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
@@ -156,7 +156,7 @@ static inline int ovl_do_create(struct inode *dir, struct dentry *dentry,
 static inline int ovl_do_mkdir(struct inode *dir, struct dentry *dentry,
 			       umode_t mode)
 {
-	int err = vfs_mkdir(dir, dentry, mode);
+	int err = vfs_mkdir(&init_user_ns, dir, dentry, mode);
 	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
 }
@@ -164,7 +164,7 @@ static inline int ovl_do_mkdir(struct inode *dir, struct dentry *dentry,
 static inline int ovl_do_mknod(struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev)
 {
-	int err = vfs_mknod(dir, dentry, mode, dev);
+	int err = vfs_mknod(&init_user_ns, dir, dentry, mode, dev);
 
 	pr_debug("mknod(%pd2, 0%o, 0%o) = %i\n", dentry, mode, dev, err);
 	return err;
@@ -173,7 +173,7 @@ static inline int ovl_do_mknod(struct inode *dir, struct dentry *dentry,
 static inline int ovl_do_symlink(struct inode *dir, struct dentry *dentry,
 				 const char *oldname)
 {
-	int err = vfs_symlink(dir, dentry, oldname);
+	int err = vfs_symlink(&init_user_ns, dir, dentry, oldname);
 
 	pr_debug("symlink(\"%s\", %pd2) = %i\n", oldname, dentry, err);
 	return err;
@@ -213,8 +213,10 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 {
 	int err;
 	struct renamedata rd = {
+		.old_user_ns	= &init_user_ns,
 		.old_dir 	= olddir,
 		.old_dentry 	= olddentry,
+		.new_user_ns	= &init_user_ns,
 		.new_dir 	= newdir,
 		.new_dentry 	= newdentry,
 		.flags 		= flags,
@@ -231,14 +233,14 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 
 static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_whiteout(dir, dentry);
+	int err = vfs_whiteout(&init_user_ns, dir, dentry);
 	pr_debug("whiteout(%pd2) = %i\n", dentry, err);
 	return err;
 }
 
 static inline struct dentry *ovl_do_tmpfile(struct dentry *dentry, umode_t mode)
 {
-	struct dentry *ret = vfs_tmpfile(dentry, mode, 0);
+	struct dentry *ret = vfs_tmpfile(&init_user_ns, dentry, mode, 0);
 	int err = PTR_ERR_OR_ZERO(ret);
 
 	pr_debug("tmpfile(%pd2, 0%o) = %i\n", dentry, mode, err);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 22c0ab9d0fcf..f29909139838 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1749,17 +1749,20 @@ extern bool inode_owner_or_capable(struct user_namespace *user_ns, const struct
 /*
  * VFS helper functions..
  */
-extern int vfs_create(struct inode *, struct dentry *, umode_t, bool);
-extern int vfs_mkdir(struct inode *, struct dentry *, umode_t);
-extern int vfs_mknod(struct inode *, struct dentry *, umode_t, dev_t);
-extern int vfs_symlink(struct inode *, struct dentry *, const char *);
-extern int vfs_link(struct dentry *, struct inode *, struct dentry *, struct inode **);
-extern int vfs_rmdir(struct inode *, struct dentry *);
-extern int vfs_unlink(struct inode *, struct dentry *, struct inode **);
+extern int vfs_create(struct user_namespace *, struct inode *, struct dentry *, umode_t, bool);
+extern int vfs_mkdir(struct user_namespace *, struct inode *, struct dentry *, umode_t);
+extern int vfs_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t, dev_t);
+extern int vfs_symlink(struct user_namespace *, struct inode *, struct dentry *, const char *);
+extern int vfs_link(struct dentry *, struct user_namespace *, struct inode *,
+		    struct dentry *, struct inode **);
+extern int vfs_rmdir(struct user_namespace *, struct inode *, struct dentry *);
+extern int vfs_unlink(struct user_namespace *, struct inode *, struct dentry *, struct inode **);
 
 struct renamedata {
+	struct user_namespace *old_user_ns;
 	struct inode *old_dir;
 	struct dentry *old_dentry;
+	struct user_namespace *new_user_ns;
 	struct inode *new_dir;
 	struct dentry *new_dentry;
 	struct inode **delegated_inode;
@@ -1768,12 +1771,14 @@ struct renamedata {
 
 extern int vfs_rename(struct renamedata *);
 
-static inline int vfs_whiteout(struct inode *dir, struct dentry *dentry)
+static inline int vfs_whiteout(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *dentry)
 {
-	return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	return vfs_mknod(user_ns, dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 
-extern struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode,
+extern struct dentry *vfs_tmpfile(struct user_namespace *user_ns,
+				  struct dentry *dentry, umode_t mode,
 				  int open_flag);
 
 int vfs_mkobj(struct dentry *, umode_t,
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 693f01fe1216..8b8c300854db 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -965,7 +965,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 		err = -ENOENT;
 	} else {
 		ihold(inode);
-		err = vfs_unlink(d_inode(dentry->d_parent), dentry, NULL);
+		err = vfs_unlink(&init_user_ns, d_inode(dentry->d_parent), dentry, NULL);
 	}
 	dput(dentry);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f568526d4a02..b4987805e5e5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -996,7 +996,7 @@ static int unix_mknod(const char *sun_path, umode_t mode, struct path *res)
 	 */
 	err = security_path_mknod(&path, dentry, mode, 0);
 	if (!err) {
-		err = vfs_mknod(d_inode(path.dentry), dentry, mode, 0);
+		err = vfs_mknod(&init_user_ns, d_inode(path.dentry), dentry, mode, 0);
 		if (!err) {
 			res->mnt = mntget(path.mnt);
 			res->dentry = dget(dentry);
-- 
2.29.2

