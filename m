Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25643365A54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhDTNjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 09:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhDTNjh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:39:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3089761026;
        Tue, 20 Apr 2021 13:39:02 +0000 (UTC)
Date:   Tue, 20 Apr 2021 15:38:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fsnotify path hooks
Message-ID: <20210420133859.kjkxnbtllmfrcm4g@wittgenstein>
References: <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz>
 <20210409104546.37i6h2i4ga2xakvp@wittgenstein>
 <CAOQ4uxi-BG9-XLmQ0uLp0vb_woF=M0EUasLDJG-zHd66PFuKGw@mail.gmail.com>
 <20210420114154.mwjj7reyntzjkvnw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210420114154.mwjj7reyntzjkvnw@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:41:59PM +0200, Christian Brauner wrote:
> On Tue, Apr 20, 2021 at 09:01:09AM +0300, Amir Goldstein wrote:
> > > One thing, whatever you end up passing to vfs_create() please make sure
> > > to retrieve mnt_userns once so permission checking and object creation
> > > line-up:
> > >
> > > int vfs_create(struct vfsmount *mnt, struct inode *dir,
> > >                struct dentry *dentry, umode_t mode, bool want_excl)
> > > {
> > >         struct user_namespace *mnt_userns;
> > >
> > >         mnt_userns = mnt_user_ns(mnt);
> > >
> > >         int error = may_create(mnt_userns, dir, dentry);
> > >         if (error)
> > >                 return error;
> > >
> > >         if (!dir->i_op->create)
> > >                 return -EACCES; /* shouldn't it be ENOSYS? */
> > >         mode &= S_IALLUGO;
> > >         mode |= S_IFREG;
> > >         error = security_inode_create(dir, dentry, mode);
> > >         if (error)
> > >                 return error;
> > >         error = dir->i_op->create(mnt_userns, dir, dentry, mode, want_excl);
> > >         if (!error)
> > >                 fsnotify_create(mnt, dir, dentry);
> > >         return error;
> > > }
> > >
> > 
> > Christian,
> > 
> > What is the concern here?
> > Can mnt_user_ns() change under us?
> > I am asking because Al doesn't like both mnt_userns AND path to
> > be passed to do_tuncate() => notify_change()
> > So I will need to retrieve mnt_userns again inside notify_change()
> > after it had been used for security checks in do_open().
> > Would that be acceptable to you?
> 
> The mnt_userns can't change once a mnt has been idmapped and it can
> never change if the mount is visible in the filesystem already. The only
> case we've been worried about and why we did it this way is when you
> have a caller do fd = open_tree(OPEN_TREE_CLONE) and then share that
> unattached fd with multiple processes
> T1: mkdirat(fd, "dir1", 0755);
> T2: mount_setattr(fd, "",); /* changes idmapping */
> That case isn't a problem if the mnt_userns is only retrieved once for
> permission checking and operating on the inode. I think with your
> changes that still shouldn't be an issue though since the vfs_*()
> helpers encompass the permission checking anyway and for notify_change,
> we could simply add a mnt_userns field to struct iattr and pass it down.

So I mean something along those lines. I converted a few callers to
illustrate this and I hope Al doesn't kill me. Please note that this
won't compile since I haven't converted all callers. I can give you a
full patch though if you think that is ok:

---
 drivers/base/devtmpfs.c   |  6 ++++--
 fs/attr.c                 | 16 ++++++++--------
 fs/cachefiles/interface.c | 10 ++++++++--
 fs/ecryptfs/inode.c       | 12 ++++++++++--
 fs/inode.c                |  7 ++++---
 include/linux/fs.h        |  3 ++-
 6 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 653c8c6ac7a7..323a549c62e3 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -221,8 +221,9 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 		newattrs.ia_uid = uid;
 		newattrs.ia_gid = gid;
 		newattrs.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID;
+		newattrs.mnt_userns = &init_user_ns;
 		inode_lock(d_inode(dentry));
-		notify_change(&init_user_ns, dentry, &newattrs, NULL);
+		notify_change(path, dentry, &newattrs, NULL);
 		inode_unlock(d_inode(dentry));
 
 		/* mark as kernel-created inode */
@@ -329,8 +330,9 @@ static int handle_remove(const char *nodename, struct device *dev)
 			newattrs.ia_mode = stat.mode & ~0777;
 			newattrs.ia_valid =
 				ATTR_UID|ATTR_GID|ATTR_MODE;
+			newattrs.mnt_userns = &init_user_ns;
 			inode_lock(d_inode(dentry));
-			notify_change(&init_user_ns, dentry, &newattrs, NULL);
+			notify_change(path, dentry, &newattrs, NULL);
 			inode_unlock(d_inode(dentry));
 			err = vfs_unlink(&init_user_ns, d_inode(parent.dentry),
 					 dentry, NULL);
diff --git a/fs/attr.c b/fs/attr.c
index 87ef39db1c34..59a9ed986e49 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -279,7 +279,7 @@ EXPORT_SYMBOL(setattr_copy);
  * permissions. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply passs init_user_ns.
  */
-int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+int notify_change(struct path *path, struct dentry *dentry,
 		  struct iattr *attr, struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
@@ -303,8 +303,8 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (IS_IMMUTABLE(inode))
 			return -EPERM;
 
-		if (!inode_owner_or_capable(mnt_userns, inode)) {
-			error = inode_permission(mnt_userns, inode, MAY_WRITE);
+		if (!inode_owner_or_capable(attr->mnt_userns, inode)) {
+			error = inode_permission(attr->mnt_userns, inode, MAY_WRITE);
 			if (error)
 				return error;
 		}
@@ -381,10 +381,10 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 	 * gids unless those uids & gids are being made valid.
 	 */
 	if (!(ia_valid & ATTR_UID) &&
-	    !uid_valid(i_uid_into_mnt(mnt_userns, inode)))
+	    !uid_valid(i_uid_into_mnt(attr->mnt_userns, inode)))
 		return -EOVERFLOW;
 	if (!(ia_valid & ATTR_GID) &&
-	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
+	    !gid_valid(i_gid_into_mnt(attr->mnt_userns, inode)))
 		return -EOVERFLOW;
 
 	error = security_inode_setattr(dentry, attr);
@@ -395,13 +395,13 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return error;
 
 	if (inode->i_op->setattr)
-		error = inode->i_op->setattr(mnt_userns, dentry, attr);
+		error = inode->i_op->setattr(attr->mnt_userns, dentry, attr);
 	else
-		error = simple_setattr(mnt_userns, dentry, attr);
+		error = simple_setattr(attr->mnt_userns, dentry, attr);
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
-		ima_inode_post_setattr(mnt_userns, dentry);
+		ima_inode_post_setattr(attr->mnt_userns, dentry);
 		evm_inode_post_setattr(dentry, ia_valid);
 	}
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 5efa6a3702c0..cede4b790694 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -429,6 +429,7 @@ static int cachefiles_check_consistency(struct fscache_operation *op)
  */
 static int cachefiles_attr_changed(struct fscache_object *_object)
 {
+	struct path path;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
@@ -460,6 +461,9 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	if (oi_size == ni_size)
 		return 0;
 
+	path.dentry = object->backer;
+	path.mnt = cache->mnt;
+
 	cachefiles_begin_secure(cache, &saved_cred);
 	inode_lock(d_inode(object->backer));
 
@@ -470,14 +474,16 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 		_debug("discard tail %llx", oi_size);
 		newattrs.ia_valid = ATTR_SIZE;
 		newattrs.ia_size = oi_size & PAGE_MASK;
-		ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
+		newattr.mnt_userns = &init_user_ns;
+		ret = notify_change(&path, object->backer, &newattrs, NULL);
 		if (ret < 0)
 			goto truncate_failed;
 	}
 
 	newattrs.ia_valid = ATTR_SIZE;
 	newattrs.ia_size = ni_size;
-	ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
+	newattr.mnt_userns = &init_user_ns;
+	ret = notify_change(&path, object->backer, &newattrs, NULL);
 
 truncate_failed:
 	inode_unlock(d_inode(object->backer));
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18e9285fbb4c..8347742087e0 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -867,10 +867,14 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 
 	rc = truncate_upper(dentry, &ia, &lower_ia);
 	if (!rc && lower_ia.ia_valid & ATTR_SIZE) {
+		struct path *lower_path;
 		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 
+		lower_path = ecryptfs_dentry_to_lower_path(dentry);
+		lower_ia.mnt_userns = mnt_user_ns(lower_path);
+
 		inode_lock(d_inode(lower_dentry));
-		rc = notify_change(&init_user_ns, lower_dentry,
+		rc = notify_change(lower_path, lower_dentry,
 				   &lower_ia, NULL);
 		inode_unlock(d_inode(lower_dentry));
 	}
@@ -906,6 +910,7 @@ static int ecryptfs_setattr(struct user_namespace *mnt_userns,
 	struct inode *inode;
 	struct inode *lower_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
+	struct path *lower_path;
 
 	crypt_stat = &ecryptfs_inode_to_private(d_inode(dentry))->crypt_stat;
 	if (!(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED)) {
@@ -977,8 +982,11 @@ static int ecryptfs_setattr(struct user_namespace *mnt_userns,
 	if (lower_ia.ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
 		lower_ia.ia_valid &= ~ATTR_MODE;
 
+	lower_path = ecryptfs_dentry_to_lower_path(dentry);
+	lower_ia.mnt_userns = mnt_user_ns(lower_path);
+
 	inode_lock(d_inode(lower_dentry));
-	rc = notify_change(&init_user_ns, lower_dentry, &lower_ia, NULL);
+	rc = notify_change(lower_path, lower_dentry, &lower_ia, NULL);
 	inode_unlock(d_inode(lower_dentry));
 out:
 	fsstack_copy_attr_all(inode, lower_inode);
diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..12a1531a6c52 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1906,17 +1906,18 @@ int dentry_needs_remove_privs(struct dentry *dentry)
 	return mask;
 }
 
-static int __remove_privs(struct user_namespace *mnt_userns,
+static int __remove_privs(struct file *file,
 			  struct dentry *dentry, int kill)
 {
 	struct iattr newattrs;
 
 	newattrs.ia_valid = ATTR_FORCE | kill;
+	newattrs.mnt_userns = file_mnt_user_ns(file);
 	/*
 	 * Note we call this on write, so notify_change will not
 	 * encounter any conflicting delegations:
 	 */
-	return notify_change(mnt_userns, dentry, &newattrs, NULL);
+	return notify_change(file->f_path, dentry, &newattrs, NULL);
 }
 
 /*
@@ -1943,7 +1944,7 @@ int file_remove_privs(struct file *file)
 	if (kill < 0)
 		return kill;
 	if (kill)
-		error = __remove_privs(file_mnt_user_ns(file), dentry, kill);
+		error = __remove_privs(file, dentry, kill);
 	if (!error)
 		inode_has_no_xattr(inode);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..d23bcedf5f92 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -234,6 +234,7 @@ struct iattr {
 	 * check for (ia_valid & ATTR_FILE), and not for (ia_file != NULL).
 	 */
 	struct file	*ia_file;
+	struct user_namespace *mnt_userns;
 };
 
 /*
@@ -2862,7 +2863,7 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 }
 #endif
 
-int notify_change(struct user_namespace *, struct dentry *,
+int notify_change(struct path *, struct dentry *,
 		  struct iattr *, struct inode **);
 int inode_permission(struct user_namespace *, struct inode *, int);
 int generic_permission(struct user_namespace *, struct inode *, int);
-- 
2.27.0

