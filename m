Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526AB45A1CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhKWLqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236453AbhKWLqN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:46:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C98561039;
        Tue, 23 Nov 2021 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667786;
        bh=/kcNzYvf44u9u6nKC5M438Tq1IDdQhIplftJQ+xej3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJDJgy8ObbS13Doh1oBl4B9DkK6HPIkk6U+IO1noQuMqQoMcEmeSDvezASd/J0DdI
         Ok5x5QO7TSGVwKlDuAYHg++5mEEUDvvOjPf3gWRSwm1RTRYaNKRRzgo/LGfP7LiWOp
         A+ravUtbuRv67mXlmpImV8Z/xER46+D53lf/8AhTLFmLk364L+mP92HoCsXgsEyMGs
         p8ZnSRXYlXyS/5Em0qAEjd6jUhiTcpeJpC7LOr2j5d4pbdCsanH+SGaU5Qb5A6RXmO
         YLcbAyzbZmKCyUjT6ouwI8kRrzsFTbgXHAL+oq/GFG7YtcC2Xi9vGK0TT0cNhUgAp8
         Y7kPeh9R/8tMA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 10/10] fs: support mapped mounts of mapped filesystems
Date:   Tue, 23 Nov 2021 12:42:27 +0100
Message-Id: <20211123114227.3124056-11-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13433; h=from:subject; bh=oGtcaWBZHTIgpD3YrR7T+bB0JU2/pqPsg5oP0ktEGEs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVym2P5yzuPgZ7sfcXHvY53KVXWhL711ve57xcc2N2NP Loh73FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR0oWMDGdtbh3SeN5jtLiAXbp0Ps cKo1+1ZtOfpsv3VrEo+Nq/O8LwP3n3Ms1XyfefGsUpfQg6q1n0cn6+tevhFXuVHNMfN26q5AIA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

In previous patches we added new and modified existing helpers to handle
idmapped mounts of filesystems mounted with an idmapping. In this final
patch we convert all relevant places in the vfs to actually pass the
filesystem's idmapping into these helpers.

With this the vfs is in shape to handle idmapped mounts of filesystems
mounted with an idmapping. Note that this is just the generic
infrastructure. Actually adding support for idmapped mounts to a
filesystem mountable with an idmapping is follow-up work.

In this patch we extend the definition of an idmapped mount from a mount
that that has the initial idmapping attached to it to a mount that has
an idmapping attached to it which is not the same as the idmapping the
filesystem was mounted with.

As before we do not allow the initial idmapping to be attached to a
mount. In addition this patch prevents that the idmapping the filesystem
was mounted with can be attached to a mount created based on this
filesystem.

This has multiple reasons and advantages. First, attaching the initial
idmapping or the filesystem's idmapping doesn't make much sense as in
both cases the values of the i_{g,u}id and other places where k{g,u}ids
are used do not change. Second, a user that really wants to do this for
whatever reason can just create a separate dedicated identical idmapping
to attach to the mount. Third, we can continue to use the initial
idmapping as an indicator that a mount is not idmapped allowing us to
continue to keep passing the initial idmapping into the mapping helpers
to tell them that something isn't an idmapped mount even if the
filesystem is mounted with an idmapping.

Apart from the generic places in the vfs the only other place we need to
change is xfs since it makes use of mapped_fs{g,u}id() directly.
Technically, this isn't even required since xfs doesn't support being
mounted with an idmapping but it is cleaner to convert it properly.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c       | 36 ++++++++++++++++++++++++------------
 fs/open.c            |  7 ++++---
 fs/posix_acl.c       |  8 ++++----
 fs/xfs/xfs_inode.c   |  4 ++--
 fs/xfs/xfs_symlink.c |  2 +-
 include/linux/fs.h   | 17 +++++++++--------
 security/commoncap.c |  9 ++++-----
 7 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7d7b80b375a4..92f551b0469c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -561,7 +561,7 @@ static void free_vfsmnt(struct mount *mnt)
 	struct user_namespace *mnt_userns;
 
 	mnt_userns = mnt_user_ns(&mnt->mnt);
-	if (mnt_userns != &init_user_ns)
+	if (!initial_mapping(mnt_userns))
 		put_user_ns(mnt_userns);
 	kfree_const(mnt->mnt_devname);
 #ifdef CONFIG_SMP
@@ -965,6 +965,7 @@ static struct mount *skip_mnt_tree(struct mount *p)
 struct vfsmount *vfs_create_mount(struct fs_context *fc)
 {
 	struct mount *mnt;
+	struct user_namespace *fs_userns;
 
 	if (!fc->root)
 		return ERR_PTR(-EINVAL);
@@ -982,6 +983,10 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
 	mnt->mnt_parent		= mnt;
 
+	fs_userns = mnt->mnt.mnt_sb->s_user_ns;
+	if (!initial_mapping(fs_userns))
+		mnt->mnt.mnt_userns = get_user_ns(fs_userns);
+
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
 	unlock_mount_hash();
@@ -1072,7 +1077,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
-	if (mnt->mnt.mnt_userns != &init_user_ns)
+	if (!initial_mapping(mnt->mnt.mnt_userns))
 		mnt->mnt.mnt_userns = get_user_ns(mnt->mnt.mnt_userns);
 	mnt->mnt.mnt_sb = sb;
 	mnt->mnt.mnt_root = dget(root);
@@ -3927,10 +3932,18 @@ static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
 static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 {
 	struct vfsmount *m = &mnt->mnt;
+	struct user_namespace *fs_userns = m->mnt_sb->s_user_ns;
 
 	if (!kattr->mnt_userns)
 		return 0;
 
+	/*
+	 * Creating an idmapped mount with the filesystem wide idmapping
+	 * doesn't make sense so block that. We don't allow mushy semantics.
+	 */
+	if (kattr->mnt_userns == fs_userns)
+		return -EINVAL;
+
 	/*
 	 * Once a mount has been idmapped we don't allow it to change its
 	 * mapping. It makes things simpler and callers can just create
@@ -3943,12 +3956,8 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
 		return -EINVAL;
 
-	/* Don't yet support filesystem mountable in user namespaces. */
-	if (m->mnt_sb->s_user_ns != &init_user_ns)
-		return -EINVAL;
-
 	/* We're not controlling the superblock. */
-	if (!capable(CAP_SYS_ADMIN))
+	if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* Mount has already been visible in the filesystem hierarchy. */
@@ -4133,13 +4142,16 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	}
 
 	/*
-	 * The init_user_ns is used to indicate that a vfsmount is not idmapped.
-	 * This is simpler than just having to treat NULL as unmapped. Users
-	 * wanting to idmap a mount to init_user_ns can just use a namespace
-	 * with an identity mapping.
+	 * The initial idmapping cannot be used to create an idmapped
+	 * mount. Attaching the initial idmapping doesn't make much sense
+	 * as it is an identity mapping. A user can just create a dedicated
+	 * identity mapping to achieve the same result. We also use the
+	 * initial idmapping as an indicator of a mount that is not
+	 * idmapped. It can simply be passed into helpers that are aware of
+	 * idmapped mounts as a convenient shortcut.
 	 */
 	mnt_userns = container_of(ns, struct user_namespace, ns);
-	if (mnt_userns == &init_user_ns) {
+	if (initial_mapping(mnt_userns)) {
 		err = -EPERM;
 		goto out_fput;
 	}
diff --git a/fs/open.c b/fs/open.c
index 64f799d96356..fb17d58db89c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -640,7 +640,7 @@ SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 
 int chown_common(const struct path *path, uid_t user, gid_t group)
 {
-	struct user_namespace *mnt_userns;
+	struct user_namespace *mnt_userns, *fs_userns;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	int error;
@@ -652,8 +652,9 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	gid = make_kgid(current_user_ns(), group);
 
 	mnt_userns = mnt_user_ns(path->mnt);
-	uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
-	gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
+	fs_userns = i_user_ns(inode);
+	uid = mapped_kuid_user(mnt_userns, fs_userns, uid);
+	gid = mapped_kgid_user(mnt_userns, fs_userns, gid);
 
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index e45b3ffb6de1..edae00c5fb6d 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -375,8 +375,8 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
                                 break;
                         case ACL_USER:
 				uid = mapped_kuid_fs(mnt_userns,
-						      &init_user_ns,
-						      pa->e_uid);
+						     i_user_ns(inode),
+						     pa->e_uid);
 				if (uid_eq(uid, current_fsuid()))
                                         goto mask;
 				break;
@@ -390,8 +390,8 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
 				break;
                         case ACL_GROUP:
 				gid = mapped_kgid_fs(mnt_userns,
-						      &init_user_ns,
-						      pa->e_gid);
+						     i_user_ns(inode),
+						     pa->e_gid);
 				if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 7ac8247b5498..bafa3e1b3a79 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -977,7 +977,7 @@ xfs_create(
 	struct xfs_trans_res	*tres;
 	uint			resblks;
 	xfs_ino_t		ino;
-	struct user_namespace	*fs_userns = &init_user_ns;
+	struct user_namespace	*fs_userns = i_user_ns(VFS_I(dp));
 
 	trace_xfs_create(dp, name);
 
@@ -1134,7 +1134,7 @@ xfs_create_tmpfile(
 	struct xfs_trans_res	*tres;
 	uint			resblks;
 	xfs_ino_t		ino;
-	struct user_namespace	*fs_userns = &init_user_ns;
+	struct user_namespace	*fs_userns = i_user_ns(VFS_I(dp));
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index bf19c111771c..612a5c86cccb 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -163,7 +163,7 @@ xfs_symlink(
 	struct xfs_dquot	*pdqp = NULL;
 	uint			resblks;
 	xfs_ino_t		ino;
-	struct user_namespace	*fs_userns = &init_user_ns;
+	struct user_namespace	*fs_userns = i_user_ns(VFS_I(dp));
 
 	*ipp = NULL;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1780be923fa..87a71bf2c6b5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1641,7 +1641,7 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
 				    const struct inode *inode)
 {
-	return mapped_kuid_fs(mnt_userns, &init_user_ns, inode->i_uid);
+	return mapped_kuid_fs(mnt_userns, i_user_ns(inode), inode->i_uid);
 }
 
 /**
@@ -1655,7 +1655,7 @@ static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
 static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 				    const struct inode *inode)
 {
-	return mapped_kgid_fs(mnt_userns, &init_user_ns, inode->i_gid);
+	return mapped_kgid_fs(mnt_userns, i_user_ns(inode), inode->i_gid);
 }
 
 /**
@@ -1669,7 +1669,7 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 static inline void inode_fsuid_set(struct inode *inode,
 				   struct user_namespace *mnt_userns)
 {
-	inode->i_uid = mapped_fsuid(mnt_userns, &init_user_ns);
+	inode->i_uid = mapped_fsuid(mnt_userns, i_user_ns(inode));
 }
 
 /**
@@ -1683,7 +1683,7 @@ static inline void inode_fsuid_set(struct inode *inode,
 static inline void inode_fsgid_set(struct inode *inode,
 				   struct user_namespace *mnt_userns)
 {
-	inode->i_gid = mapped_fsgid(mnt_userns, &init_user_ns);
+	inode->i_gid = mapped_fsgid(mnt_userns, i_user_ns(inode));
 }
 
 /**
@@ -1704,10 +1704,10 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	kuid_t kuid;
 	kgid_t kgid;
 
-	kuid = mapped_fsuid(mnt_userns, &init_user_ns);
+	kuid = mapped_fsuid(mnt_userns, fs_userns);
 	if (!uid_valid(kuid))
 		return false;
-	kgid = mapped_fsgid(mnt_userns, &init_user_ns);
+	kgid = mapped_fsgid(mnt_userns, fs_userns);
 	if (!gid_valid(kgid))
 		return false;
 	return kuid_has_mapping(fs_userns, kuid) &&
@@ -2654,13 +2654,14 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
  * is_mapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
  *
- * If @mnt has an idmapping attached to it @mnt is mapped.
+ * If @mnt has an idmapping attached different from the
+ * filesystem's idmapping then @mnt is mapped.
  *
  * Return: true if mount is mapped, false if not.
  */
 static inline bool is_mapped_mnt(const struct vfsmount *mnt)
 {
-	return mnt_user_ns(mnt) != &init_user_ns;
+	return mnt_user_ns(mnt) != mnt->mnt_sb->s_user_ns;
 }
 
 extern long vfs_truncate(const struct path *, loff_t);
diff --git a/security/commoncap.c b/security/commoncap.c
index 77d319f62710..e9b71eefe97b 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -418,7 +418,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 	kroot = make_kuid(fs_ns, root);
 
 	/* If this is an idmapped mount shift the kuid. */
-	kroot = mapped_kuid_fs(mnt_userns, &init_user_ns, kroot);
+	kroot = mapped_kuid_fs(mnt_userns, fs_ns, kroot);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
@@ -555,13 +555,12 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (mnt_userns == &init_user_ns))
+	if (size == XATTR_CAPS_SZ_2 && (mnt_userns == fs_ns))
 		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
 			/* user is privileged, just write the v2 */
 			return size;
 
-	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns,
-				   &init_user_ns);
+	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns, fs_ns);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
@@ -702,7 +701,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	rootkuid = mapped_kuid_fs(mnt_userns, &init_user_ns, rootkuid);
+	rootkuid = mapped_kuid_fs(mnt_userns, fs_ns, rootkuid);
 	if (!rootid_owns_currentns(rootkuid))
 		return -ENODATA;
 
-- 
2.30.2

