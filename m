Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845EE669614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbjAMLxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjAMLw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555401408E
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC171B8212B
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757D6C433F1;
        Fri, 13 Jan 2023 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610611;
        bh=kbb3PC2lnphek6z/M0eApqf0gxoLE+oF0nhxj827SA0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PmRM1PYl4gJS2am7dm/6yd6uak5TLGl5DAfeQWbbkMxDSb5WlPg8k5FXbpJnTem0Y
         KFJhcwttt6EUMIZ2ojkQcjZ0dBM3+hwEaYsOybcp4cCLp0AKLUz90151Ss0NuKhy2G
         sN5WN286KshHq0UcQNI1y+RwsIr4p7AqOFa/qykkb7GGA+qvODmHuzy3JFG03HFE7o
         auQ6M8/+0/UFokzKYnUyfccZzZk03/qPHUS8hRtfZ6923g4vr4lA+syvKE+vZEanNS
         IhR36EhuW4IDlULarpOL4Vu6Nqbn/5YHxFofwn/4mOQdthh/xkSVqLQmaXmxCMeehL
         mduX29eZ2XUPA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:26 +0100
Subject: [PATCH 18/25] fs: port inode_owner_or_capable() to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-18-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=22777; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kbb3PC2lnphek6z/M0eApqf0gxoLE+oF0nhxj827SA0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2e/CpQMmOH8/0QHj/Hj+91w1PepB/2crqR/9BwT+DL
 Pxr3O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSYcLwP+ve9dbZoqfnHL+Ud+3Zhd
 jjC2+FxhgsdrP2dDpiHR9huJuRoX+p9n9pkUMZJ7Ydab+j5RkjblMyRbr+t4C1cUoi97YWBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to struct mnt_idmap.

Last cycle we merged the necessary infrastructure in
256c8aed2b42 ("fs: introduce dedicated idmap type for mounts").
This is just the conversion to struct mnt_idmap.

Currently we still pass around the plain namespace that was attached to a
mount. This is in general pretty convenient but it makes it easy to
conflate namespaces that are relevant on the filesystem with namespaces
that are relevent on the mount level. Especially for non-vfs developers
without detailed knowledge in this area this can be a potential source for
bugs.

Once the conversion to struct mnt_idmap is done all helpers down to the
really low-level helpers will take a struct mnt_idmap argument instead of
two namespace arguments. This way it becomes impossible to conflate the two
eliminating the possibility of any bugs. All of the vfs and all filesystems
only operate on struct mnt_idmap.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/9p/acl.c              |  2 +-
 fs/attr.c                |  7 +++----
 fs/btrfs/ioctl.c         | 13 ++++++-------
 fs/crypto/policy.c       |  2 +-
 fs/ext2/ioctl.c          |  4 ++--
 fs/ext4/ioctl.c          | 18 +++++++++---------
 fs/f2fs/file.c           | 11 +++++------
 fs/f2fs/xattr.c          |  2 +-
 fs/fcntl.c               |  2 +-
 fs/inode.c               | 13 +++++++------
 fs/ioctl.c               |  2 +-
 fs/namei.c               |  5 ++---
 fs/overlayfs/file.c      |  4 +---
 fs/overlayfs/inode.c     |  2 +-
 fs/overlayfs/util.c      |  3 +--
 fs/posix_acl.c           |  2 +-
 fs/reiserfs/ioctl.c      |  2 +-
 fs/xattr.c               |  4 +---
 include/linux/fs.h       |  2 +-
 mm/madvise.c             |  2 +-
 mm/mincore.c             |  2 +-
 security/selinux/hooks.c |  5 ++---
 22 files changed, 50 insertions(+), 59 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 33036305b4fd..eed551d8555f 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -195,7 +195,7 @@ int v9fs_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto err_out;
 	}
 
-	if (!inode_owner_or_capable(&init_user_ns, inode)) {
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode)) {
 		retval = -EPERM;
 		goto err_out;
 	}
diff --git a/fs/attr.c b/fs/attr.c
index 1093db43ab9e..bd8d542e13b9 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -196,7 +196,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ia_valid & ATTR_MODE) {
 		vfsgid_t vfsgid;
 
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!inode_owner_or_capable(idmap, inode))
 			return -EPERM;
 
 		if (ia_valid & ATTR_GID)
@@ -211,7 +211,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	/* Check for setting the inode time. */
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!inode_owner_or_capable(idmap, inode))
 			return -EPERM;
 	}
 
@@ -328,7 +328,6 @@ int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid)
 {
 	int error;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) {
 		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -343,7 +342,7 @@ int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		if (IS_IMMUTABLE(inode))
 			return -EPERM;
 
-		if (!inode_owner_or_capable(mnt_userns, inode)) {
+		if (!inode_owner_or_capable(idmap, inode)) {
 			error = inode_permission(idmap, inode, MAY_WRITE);
 			if (error)
 				return error;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7c6bb1ff41b3..6affe071bdfd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1248,7 +1248,6 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 {
 	int namelen;
 	int ret = 0;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (!S_ISDIR(file_inode(file)->i_mode))
 		return -ENOTDIR;
@@ -1285,7 +1284,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			btrfs_info(BTRFS_I(file_inode(file))->root->fs_info,
 				   "Snapshot src from another FS");
 			ret = -EXDEV;
-		} else if (!inode_owner_or_capable(mnt_userns, src_inode)) {
+		} else if (!inode_owner_or_capable(idmap, src_inode)) {
 			/*
 			 * Subvolume creation is not restricted, but snapshots
 			 * are limited to own subvolumes only
@@ -1424,7 +1423,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	u64 flags;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
@@ -3909,7 +3908,7 @@ static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
 }
 
 static long _btrfs_ioctl_set_received_subvol(struct file *file,
-					    struct user_namespace *mnt_userns,
+					    struct mnt_idmap *idmap,
 					    struct btrfs_ioctl_received_subvol_args *sa)
 {
 	struct inode *inode = file_inode(file);
@@ -3921,7 +3920,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	int ret = 0;
 	int received_uuid_changed;
 
-	if (!inode_owner_or_capable(mnt_userns, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
@@ -4026,7 +4025,7 @@ static long btrfs_ioctl_set_received_subvol_32(struct file *file,
 	args64->rtime.nsec = args32->rtime.nsec;
 	args64->flags = args32->flags;
 
-	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), args64);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_idmap(file), args64);
 	if (ret)
 		goto out;
 
@@ -4060,7 +4059,7 @@ static long btrfs_ioctl_set_received_subvol(struct file *file,
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
-	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), sa);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_idmap(file), sa);
 
 	if (ret)
 		goto out;
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 893661b52376..fa09c925bda8 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -506,7 +506,7 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 		return -EFAULT;
 	policy.version = version;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index dbd7de812cc1..cc87d413eb43 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -66,7 +66,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT2_IOC_SETVERSION: {
 		__u32 generation;
 
-		if (!inode_owner_or_capable(&init_user_ns, inode))
+		if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
 			return -EPERM;
 		ret = mnt_want_write_file(filp);
 		if (ret)
@@ -99,7 +99,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
 			return -ENOTTY;
 
-		if (!inode_owner_or_capable(&init_user_ns, inode))
+		if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
 			return -EACCES;
 
 		if (get_user(rsv_window_size, (int __user *)arg))
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f49496087102..b0dc7212694e 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -358,12 +358,12 @@ void ext4_reset_inode_seed(struct inode *inode)
  * important fields of the inodes.
  *
  * @sb:         the super block of the filesystem
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:      the inode to swap with EXT4_BOOT_LOADER_INO
  *
  */
 static long swap_inode_boot_loader(struct super_block *sb,
-				struct user_namespace *mnt_userns,
+				struct mnt_idmap *idmap,
 				struct inode *inode)
 {
 	handle_t *handle;
@@ -393,7 +393,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	}
 
 	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
-	    !inode_owner_or_capable(mnt_userns, inode) ||
+	    !inode_owner_or_capable(idmap, inode) ||
 	    !capable(CAP_SYS_ADMIN)) {
 		err = -EPERM;
 		goto journal_err_out;
@@ -1217,7 +1217,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
-	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 
 	ext4_debug("cmd = %u, arg = %lu\n", cmd, arg);
 
@@ -1234,7 +1234,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		__u32 generation;
 		int err;
 
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!inode_owner_or_capable(idmap, inode))
 			return -EPERM;
 
 		if (ext4_has_metadata_csum(inode->i_sb)) {
@@ -1376,7 +1376,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_MIGRATE:
 	{
 		int err;
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!inode_owner_or_capable(idmap, inode))
 			return -EACCES;
 
 		err = mnt_want_write_file(filp);
@@ -1398,7 +1398,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_ALLOC_DA_BLKS:
 	{
 		int err;
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!inode_owner_or_capable(idmap, inode))
 			return -EACCES;
 
 		err = mnt_want_write_file(filp);
@@ -1417,7 +1417,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = mnt_want_write_file(filp);
 		if (err)
 			return err;
-		err = swap_inode_boot_loader(sb, mnt_userns, inode);
+		err = swap_inode_boot_loader(sb, idmap, inode);
 		mnt_drop_write_file(filp);
 		return err;
 	}
@@ -1542,7 +1542,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	{
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!inode_owner_or_capable(idmap, inode))
 			return -EACCES;
 		ext4_clear_inode_es(inode);
 		return 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1d514515a6e7..33e6334bc0c6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2041,14 +2041,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 {
 	struct inode *inode = file_inode(filp);
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
 	loff_t isize;
 	int ret;
 
-	if (!inode_owner_or_capable(mnt_userns, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
@@ -2138,10 +2137,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
-	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(mnt_userns, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
@@ -2170,10 +2169,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 static int f2fs_ioc_abort_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
-	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(mnt_userns, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 044b74322ec4..d92edbbdc30e 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -117,7 +117,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 	unsigned char old_advise = F2FS_I(inode)->i_advise;
 	unsigned char new_advise;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 146c9ab0cd4b..4c043b1b9b98 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -47,7 +47,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 
 	/* O_NOATIME can only be set by the owner or superuser */
 	if ((arg & O_NOATIME) && !(filp->f_flags & O_NOATIME))
-		if (!inode_owner_or_capable(file_mnt_user_ns(filp), inode))
+		if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
 			return -EPERM;
 
 	/* required for strict SunOS emulation */
diff --git a/fs/inode.c b/fs/inode.c
index 413b7380a089..0a86c316937e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2310,23 +2310,24 @@ EXPORT_SYMBOL(inode_init_owner);
 
 /**
  * inode_owner_or_capable - check current task permissions to inode
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: inode being checked
  *
  * Return true if current either has CAP_FOWNER in a namespace with the
  * inode owner uid mapped, or owns the file.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-bool inode_owner_or_capable(struct user_namespace *mnt_userns,
+bool inode_owner_or_capable(struct mnt_idmap *idmap,
 			    const struct inode *inode)
 {
 	vfsuid_t vfsuid;
 	struct user_namespace *ns;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
 	if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 2bf1bdaec2ee..5b2481cd4750 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -675,7 +675,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!inode->i_op->fileattr_set)
 		return -ENOIOCTLCMD;
 
-	if (!inode_owner_or_capable(mnt_idmap_owner(idmap), inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 
 	inode_lock(inode);
diff --git a/fs/namei.c b/fs/namei.c
index 637f8bee7132..48dd44251dda 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1197,7 +1197,7 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
 	 * otherwise, it must be a safe source.
 	 */
 	if (safe_hardlink_source(idmap, inode) ||
-	    inode_owner_or_capable(mnt_userns, inode))
+	    inode_owner_or_capable(idmap, inode))
 		return 0;
 
 	audit_log_path_denied(AUDIT_ANOM_LINK, "linkat");
@@ -3158,7 +3158,6 @@ bool may_open_dev(const struct path *path)
 static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		    int acc_mode, int flag)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct dentry *dentry = path->dentry;
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -3207,7 +3206,7 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 	}
 
 	/* O_NOATIME can only be set by the owner or superuser */
-	if (flag & O_NOATIME && !inode_owner_or_capable(mnt_userns, inode))
+	if (flag & O_NOATIME && !inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 
 	return 0;
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f69d5740c3c4..7c04f033aadd 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -43,7 +43,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct inode *realinode = d_inode(realpath->dentry);
 	struct inode *inode = file_inode(file);
 	struct mnt_idmap *real_idmap;
-	struct user_namespace *real_mnt_userns;
 	struct file *realfile;
 	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
@@ -55,12 +54,11 @@ static struct file *ovl_open_realfile(const struct file *file,
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	real_idmap = mnt_idmap(realpath->mnt);
-	real_mnt_userns = mnt_idmap_owner(real_idmap);
 	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
 	} else {
-		if (!inode_owner_or_capable(real_mnt_userns, realinode))
+		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index d906cf073fba..3ba3110243d1 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -667,7 +667,7 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EOPNOTSUPP;
 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
 		return -EPERM;
 
 	/*
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 48a3c3fee1b6..1166f7b22bc7 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -492,7 +492,6 @@ struct file *ovl_path_open(const struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct mnt_idmap *real_idmap = mnt_idmap(path->mnt);
-	struct user_namespace *real_mnt_userns = mnt_idmap_owner(real_idmap);
 	int err, acc_mode;
 
 	if (flags & ~(O_ACCMODE | O_LARGEFILE))
@@ -514,7 +513,7 @@ struct file *ovl_path_open(const struct path *path, int flags)
 		return ERR_PTR(err);
 
 	/* O_NOATIME is an optimization, don't fail if not permitted */
-	if (inode_owner_or_capable(real_mnt_userns, inode))
+	if (inode_owner_or_capable(real_idmap, inode))
 		flags |= O_NOATIME;
 
 	return dentry_open(path, flags, current_cred());
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index b6c3b5b19435..ea2620050b40 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -948,7 +948,7 @@ set_posix_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(mnt_idmap_owner(idmap), inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 
 	if (acl) {
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index 12800dfc11a9..6bf9b54e58ca 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -96,7 +96,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = put_user(inode->i_generation, (int __user *)arg);
 		break;
 	case REISERFS_IOC_SETVERSION:
-		if (!inode_owner_or_capable(&init_user_ns, inode)) {
+		if (!inode_owner_or_capable(&nop_mnt_idmap, inode)) {
 			err = -EPERM;
 			break;
 		}
diff --git a/fs/xattr.c b/fs/xattr.c
index 1cc1420eccce..80a6460b620c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -113,8 +113,6 @@ static int
 xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 		 const char *name, int mask)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
 	if (mask & MAY_WRITE) {
 		int ret;
 
@@ -150,7 +148,7 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
 		    (mask & MAY_WRITE) &&
-		    !inode_owner_or_capable(mnt_userns, inode))
+		    !inode_owner_or_capable(idmap, inode))
 			return -EPERM;
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1d698923d15..e6c76f308f5f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1939,7 +1939,7 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
-bool inode_owner_or_capable(struct user_namespace *mnt_userns,
+bool inode_owner_or_capable(struct mnt_idmap *idmap,
 			    const struct inode *inode);
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index a56a6d17e201..72297d5edab7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -329,7 +329,7 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&init_user_ns,
+	return inode_owner_or_capable(&nop_mnt_idmap,
 				      file_inode(vma->vm_file)) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
diff --git a/mm/mincore.c b/mm/mincore.c
index a085a2aeabd8..cd69b9db0081 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -168,7 +168,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(&init_user_ns,
+	return inode_owner_or_capable(&nop_mnt_idmap,
 				      file_inode(vma->vm_file)) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f32fa3359502..9a5bdfc21314 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3154,7 +3154,6 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
 	u32 newsid, sid = current_sid();
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int rc = 0;
 
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
@@ -3168,13 +3167,13 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	}
 
 	if (!selinux_initialized(&selinux_state))
-		return (inode_owner_or_capable(mnt_userns, inode) ? 0 : -EPERM);
+		return (inode_owner_or_capable(idmap, inode) ? 0 : -EPERM);
 
 	sbsec = selinux_superblock(inode->i_sb);
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	if (!inode_owner_or_capable(mnt_userns, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;

-- 
2.34.1

