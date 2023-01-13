Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541AB6695FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjAMLxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbjAMLw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81915F35
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 934AD616B3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6F1C433F2;
        Fri, 13 Jan 2023 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610610;
        bh=D6AnRAQc+G50IcJY7XMQpLPBb6J1igu9+8ivzZgkjrA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bjRgIVk/wcfmsnIdwOB7XzR+R/b8rXbCd3Qn8lFOTmnlIjVwkme6DwXTX5l2hRZb9
         5BVUk+I6TX1Ia5sj/UI5/mFPjQMvgo2LHEXPGLwBdNE9BWj9Zea4n2Bu/GHJ8zVeVD
         aApQqrw1uIlTVhbTYGcqVLX1GXxUXf1tQ8cJvCfdSrFbz01RWpbSPj9abbt09qzwnl
         DSnzvyXSHxYhtd81iq8B5FQt7ffuzSeQBieAglVrJFe0LftRysY3FZ4YvHFcsnlvvr
         RcChFVpPPVyGA0HX87G31XZGoZ05/ZKDhJkQthg632rure2pvFk6JfxfnqVkCE1KTn
         0d8phxvB4Cmig==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:25 +0100
Subject: [PATCH 17/25] fs: port inode_init_owner() to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-17-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=55240; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D6AnRAQc+G50IcJY7XMQpLPBb6J1igu9+8ivzZgkjrA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA1+EJi2cM+d8/0SWaKJ3qz7VkpfnXe4km9xQN+tHb6V
 p25d6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIngkjw5U7jKLZf8ULrws08Yaes6
 j8vqtaPGf9Nj9loZTp5TtlrzEy3ODeI2EyUVz86oGSwgeX4pUvzTRy170+z2vaK5HTO2/YswEA
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
 arch/powerpc/platforms/cell/spufs/inode.c |  4 ++--
 fs/9p/vfs_inode.c                         |  2 +-
 fs/bfs/dir.c                              |  2 +-
 fs/btrfs/btrfs_inode.h                    |  2 +-
 fs/btrfs/inode.c                          | 30 ++++++++++--------------
 fs/btrfs/ioctl.c                          |  7 +++---
 fs/btrfs/tests/btrfs-tests.c              |  2 +-
 fs/ext2/ialloc.c                          |  2 +-
 fs/ext4/ext4.h                            |  8 +++----
 fs/ext4/ialloc.c                          |  5 ++--
 fs/ext4/namei.c                           | 26 ++++++++-------------
 fs/f2fs/f2fs.h                            |  2 +-
 fs/f2fs/file.c                            |  5 ++--
 fs/f2fs/namei.c                           | 38 +++++++++++++------------------
 fs/hfsplus/inode.c                        |  2 +-
 fs/hugetlbfs/inode.c                      |  2 +-
 fs/inode.c                                | 14 +++++++-----
 fs/jfs/jfs_inode.c                        |  2 +-
 fs/minix/bitmap.c                         |  2 +-
 fs/nilfs2/inode.c                         |  2 +-
 fs/ntfs3/inode.c                          |  3 +--
 fs/ocfs2/dlmfs/dlmfs.c                    |  4 ++--
 fs/ocfs2/namei.c                          |  2 +-
 fs/omfs/inode.c                           |  2 +-
 fs/overlayfs/dir.c                        |  2 +-
 fs/ramfs/inode.c                          |  2 +-
 fs/reiserfs/namei.c                       |  2 +-
 fs/sysv/ialloc.c                          |  2 +-
 fs/ubifs/dir.c                            |  2 +-
 fs/udf/ialloc.c                           |  2 +-
 fs/ufs/ialloc.c                           |  2 +-
 fs/xfs/xfs_inode.c                        | 23 +++++++++++--------
 fs/xfs/xfs_inode.h                        |  8 +++----
 fs/xfs/xfs_iops.c                         | 35 ++++++++++++----------------
 fs/xfs/xfs_qm.c                           |  2 +-
 fs/xfs/xfs_symlink.c                      |  5 ++--
 fs/xfs/xfs_symlink.h                      |  2 +-
 fs/zonefs/super.c                         |  2 +-
 include/linux/fs.h                        |  2 +-
 kernel/bpf/inode.c                        |  2 +-
 mm/shmem.c                                |  2 +-
 41 files changed, 124 insertions(+), 143 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index f07d76d77b79..cfaa8bfb0f95 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -237,7 +237,7 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 	if (!inode)
 		return -ENOSPC;
 
-	inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode | S_IFDIR);
 	ctx = alloc_spu_context(SPUFS_I(dir)->i_gang); /* XXX gang */
 	SPUFS_I(inode)->i_ctx = ctx;
 	if (!ctx) {
@@ -468,7 +468,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out;
 
 	ret = 0;
-	inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode | S_IFDIR);
 	gang = alloc_spu_gang();
 	SPUFS_I(inode)->i_ctx = NULL;
 	SPUFS_I(inode)->i_gang = gang;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index a714df142d05..4344e7a7865f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -260,7 +260,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 {
 	int err = 0;
 
-	inode_init_owner(&init_user_ns, inode, NULL, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_blocks = 0;
 	inode->i_rdev = rdev;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index fa3e66bc9be3..040d5140e426 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -96,7 +96,7 @@ static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	}
 	set_bit(ino, info->si_imap);
 	info->si_freei--;
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_blocks = 0;
 	inode->i_op = &bfs_file_inops;
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 195c09e20609..7c1527fcc7b3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -469,7 +469,7 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_new_inode_args *args);
 void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
-struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
+struct inode *btrfs_new_subvol_inode(struct mnt_idmap *idmap,
 				     struct inode *dir);
  void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *state,
 			        u32 bits);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5251547fdf0b..8d74d042c626 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6727,13 +6727,12 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 static int btrfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
 	if (!inode)
 		return -ENOMEM;
-	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode_init_owner(idmap, inode, dir, mode);
 	inode->i_op = &btrfs_special_inode_operations;
 	init_special_inode(inode, inode->i_mode, rdev);
 	return btrfs_create_common(dir, dentry, inode);
@@ -6742,13 +6741,12 @@ static int btrfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 static int btrfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
 	if (!inode)
 		return -ENOMEM;
-	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode_init_owner(idmap, inode, dir, mode);
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 	inode->i_mapping->a_ops = &btrfs_aops;
@@ -6842,13 +6840,12 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 static int btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
 	if (!inode)
 		return -ENOMEM;
-	inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
+	inode_init_owner(idmap, inode, dir, S_IFDIR | mode);
 	inode->i_op = &btrfs_dir_inode_operations;
 	inode->i_fop = &btrfs_dir_file_operations;
 	return btrfs_create_common(dir, dentry, inode);
@@ -8805,7 +8802,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	return ret;
 }
 
-struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
+struct inode *btrfs_new_subvol_inode(struct mnt_idmap *idmap,
 				     struct inode *dir)
 {
 	struct inode *inode;
@@ -8816,7 +8813,7 @@ struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 		 * Subvolumes don't inherit the sgid bit or the parent's gid if
 		 * the parent's sgid bit is set. This is probably a bug.
 		 */
-		inode_init_owner(mnt_userns, inode, NULL,
+		inode_init_owner(idmap, inode, NULL,
 				 S_IFDIR | (~current_umask() & S_IRWXUGO));
 		inode->i_op = &btrfs_dir_inode_operations;
 		inode->i_fop = &btrfs_dir_file_operations;
@@ -9292,14 +9289,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	return ret;
 }
 
-static struct inode *new_whiteout_inode(struct user_namespace *mnt_userns,
+static struct inode *new_whiteout_inode(struct mnt_idmap *idmap,
 					struct inode *dir)
 {
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
 	if (inode) {
-		inode_init_owner(mnt_userns, inode, dir,
+		inode_init_owner(idmap, inode, dir,
 				 S_IFCHR | WHITEOUT_MODE);
 		inode->i_op = &btrfs_special_inode_operations;
 		init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
@@ -9307,7 +9304,7 @@ static struct inode *new_whiteout_inode(struct user_namespace *mnt_userns,
 	return inode;
 }
 
-static int btrfs_rename(struct user_namespace *mnt_userns,
+static int btrfs_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
@@ -9379,7 +9376,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		filemap_flush(old_inode->i_mapping);
 
 	if (flags & RENAME_WHITEOUT) {
-		whiteout_args.inode = new_whiteout_inode(mnt_userns, old_dir);
+		whiteout_args.inode = new_whiteout_inode(idmap, old_dir);
 		if (!whiteout_args.inode)
 			return -ENOMEM;
 		ret = btrfs_new_inode_prepare(&whiteout_args, &trans_num_items);
@@ -9550,7 +9547,6 @@ static int btrfs_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
 			 struct dentry *old_dentry, struct inode *new_dir,
 			 struct dentry *new_dentry, unsigned int flags)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int ret;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
@@ -9560,7 +9556,7 @@ static int btrfs_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
 		ret = btrfs_rename_exchange(old_dir, old_dentry, new_dir,
 					    new_dentry);
 	else
-		ret = btrfs_rename(mnt_userns, old_dir, old_dentry, new_dir,
+		ret = btrfs_rename(idmap, old_dir, old_dentry, new_dir,
 				   new_dentry, flags);
 
 	btrfs_btree_balance_dirty(BTRFS_I(new_dir)->root->fs_info);
@@ -9763,7 +9759,6 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
@@ -9789,7 +9784,7 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	inode = new_inode(dir->i_sb);
 	if (!inode)
 		return -ENOMEM;
-	inode_init_owner(mnt_userns, inode, dir, S_IFLNK | S_IRWXUGO);
+	inode_init_owner(idmap, inode, dir, S_IFLNK | S_IRWXUGO);
 	inode->i_op = &btrfs_symlink_inode_operations;
 	inode_nohighmem(inode);
 	inode->i_mapping->a_ops = &btrfs_aops;
@@ -10097,7 +10092,6 @@ static int btrfs_permission(struct mnt_idmap *idmap,
 static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			 struct file *file, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
@@ -10113,7 +10107,7 @@ static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	inode = new_inode(dir->i_sb);
 	if (!inode)
 		return -ENOMEM;
-	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode_init_owner(idmap, inode, dir, mode);
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 	inode->i_mapping->a_ops = &btrfs_aops;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 80c7feb30770..7c6bb1ff41b3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -578,7 +578,7 @@ static unsigned int create_subvol_num_items(struct btrfs_qgroup_inherit *inherit
 	return num_items;
 }
 
-static noinline int create_subvol(struct user_namespace *mnt_userns,
+static noinline int create_subvol(struct mnt_idmap *idmap,
 				  struct inode *dir, struct dentry *dentry,
 				  struct btrfs_qgroup_inherit *inherit)
 {
@@ -623,7 +623,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	if (ret < 0)
 		goto out_root_item;
 
-	new_inode_args.inode = btrfs_new_subvol_inode(mnt_userns, dir);
+	new_inode_args.inode = btrfs_new_subvol_inode(idmap, dir);
 	if (!new_inode_args.inode) {
 		ret = -ENOMEM;
 		goto out_anon_dev;
@@ -962,7 +962,6 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct dentry *dentry;
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, namelen);
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 
 	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
@@ -995,7 +994,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (snap_src)
 		error = create_snapshot(snap_src, dir, dentry, readonly, inherit);
 	else
-		error = create_subvol(mnt_userns, dir, dentry, inherit);
+		error = create_subvol(idmap, dir, dentry, inherit);
 
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 181469fc0bb3..ca09cf9afce8 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -64,7 +64,7 @@ struct inode *btrfs_new_test_inode(void)
 	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
 	BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
 	BTRFS_I(inode)->location.offset = 0;
-	inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, S_IFREG);
 
 	return inode;
 }
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 78b8686d9a4a..a4e1d7a9c544 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -545,7 +545,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 		inode->i_uid = current_fsuid();
 		inode->i_gid = dir->i_gid;
 	} else
-		inode_init_owner(&init_user_ns, inode, dir, mode);
+		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d5008754cc2..43e26e6f6e42 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2845,7 +2845,7 @@ extern int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 
 /* ialloc.c */
 extern int ext4_mark_inode_used(struct super_block *sb, int ino);
-extern struct inode *__ext4_new_inode(struct user_namespace *, handle_t *,
+extern struct inode *__ext4_new_inode(struct mnt_idmap *, handle_t *,
 				      struct inode *, umode_t,
 				      const struct qstr *qstr, __u32 goal,
 				      uid_t *owner, __u32 i_flags,
@@ -2853,11 +2853,11 @@ extern struct inode *__ext4_new_inode(struct user_namespace *, handle_t *,
 				      int nblocks);
 
 #define ext4_new_inode(handle, dir, mode, qstr, goal, owner, i_flags)          \
-	__ext4_new_inode(&init_user_ns, (handle), (dir), (mode), (qstr),       \
+	__ext4_new_inode(&nop_mnt_idmap, (handle), (dir), (mode), (qstr),      \
 			 (goal), (owner), i_flags, 0, 0, 0)
-#define ext4_new_inode_start_handle(mnt_userns, dir, mode, qstr, goal, owner, \
+#define ext4_new_inode_start_handle(idmap, dir, mode, qstr, goal, owner, \
 				    type, nblocks)		    \
-	__ext4_new_inode((mnt_userns), NULL, (dir), (mode), (qstr), (goal), (owner), \
+	__ext4_new_inode((idmap), NULL, (dir), (mode), (qstr), (goal), (owner), \
 			 0, (type), __LINE__, (nblocks))
 
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 63f9bb6e8851..1024b0c02431 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -921,7 +921,7 @@ static int ext4_xattr_credits_for_new_inode(struct inode *dir, mode_t mode,
  * For other inodes, search forward from the parent directory's block
  * group to find a free inode.
  */
-struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
+struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 			       handle_t *handle, struct inode *dir,
 			       umode_t mode, const struct qstr *qstr,
 			       __u32 goal, uid_t *owner, __u32 i_flags,
@@ -943,6 +943,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 	ext4_group_t flex_group;
 	struct ext4_group_info *grp = NULL;
 	bool encrypt = false;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	/* Cannot create files in a deleted directory */
 	if (!dir || !dir->i_nlink)
@@ -975,7 +976,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		inode_fsuid_set(inode, mnt_userns);
 		inode->i_gid = dir->i_gid;
 	} else
-		inode_init_owner(mnt_userns, inode, dir, mode);
+		inode_init_owner(idmap, inode, dir, mode);
 
 	if (ext4_has_feature_project(sb) &&
 	    ext4_test_inode_flag(dir, EXT4_INODE_PROJINHERIT))
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 74a2c3eae066..d10a508d95cd 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2795,7 +2795,6 @@ static int ext4_add_nondir(handle_t *handle,
 static int ext4_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, credits, retries = 0;
@@ -2807,7 +2806,7 @@ static int ext4_create(struct mnt_idmap *idmap, struct inode *dir,
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
-	inode = ext4_new_inode_start_handle(mnt_userns, dir, mode, &dentry->d_name,
+	inode = ext4_new_inode_start_handle(idmap, dir, mode, &dentry->d_name,
 					    0, NULL, EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
@@ -2831,7 +2830,6 @@ static int ext4_create(struct mnt_idmap *idmap, struct inode *dir,
 static int ext4_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, credits, retries = 0;
@@ -2843,7 +2841,7 @@ static int ext4_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
-	inode = ext4_new_inode_start_handle(mnt_userns, dir, mode, &dentry->d_name,
+	inode = ext4_new_inode_start_handle(idmap, dir, mode, &dentry->d_name,
 					    0, NULL, EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
@@ -2866,7 +2864,6 @@ static int ext4_mknod(struct mnt_idmap *idmap, struct inode *dir,
 static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			struct file *file, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, retries = 0;
@@ -2876,7 +2873,7 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		return err;
 
 retry:
-	inode = ext4_new_inode_start_handle(mnt_userns, dir, mode,
+	inode = ext4_new_inode_start_handle(idmap, dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
 			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
@@ -2978,7 +2975,6 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 static int ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, err2 = 0, credits, retries = 0;
@@ -2993,7 +2989,7 @@ static int ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
-	inode = ext4_new_inode_start_handle(mnt_userns, dir, S_IFDIR | mode,
+	inode = ext4_new_inode_start_handle(idmap, dir, S_IFDIR | mode,
 					    &dentry->d_name,
 					    0, NULL, EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
@@ -3346,7 +3342,6 @@ static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
 static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, len = strlen(symname);
@@ -3375,7 +3370,7 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
 retry:
-	inode = ext4_new_inode_start_handle(mnt_userns, dir, S_IFLNK|S_IRWXUGO,
+	inode = ext4_new_inode_start_handle(idmap, dir, S_IFLNK|S_IRWXUGO,
 					    &dentry->d_name, 0, NULL,
 					    EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
@@ -3725,7 +3720,7 @@ static void ext4_update_dir_count(handle_t *handle, struct ext4_renament *ent)
 	}
 }
 
-static struct inode *ext4_whiteout_for_rename(struct user_namespace *mnt_userns,
+static struct inode *ext4_whiteout_for_rename(struct mnt_idmap *idmap,
 					      struct ext4_renament *ent,
 					      int credits, handle_t **h)
 {
@@ -3740,7 +3735,7 @@ static struct inode *ext4_whiteout_for_rename(struct user_namespace *mnt_userns,
 	credits += (EXT4_MAXQUOTAS_TRANS_BLOCKS(ent->dir->i_sb) +
 		    EXT4_XATTR_TRANS_BLOCKS + 4);
 retry:
-	wh = ext4_new_inode_start_handle(mnt_userns, ent->dir,
+	wh = ext4_new_inode_start_handle(idmap, ent->dir,
 					 S_IFCHR | WHITEOUT_MODE,
 					 &ent->dentry->d_name, 0, NULL,
 					 EXT4_HT_DIR, credits);
@@ -3768,7 +3763,7 @@ static struct inode *ext4_whiteout_for_rename(struct user_namespace *mnt_userns,
  * while new_{dentry,inode) refers to the destination dentry/inode
  * This comes from rename(const char *oldpath, const char *newpath)
  */
-static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
@@ -3856,7 +3851,7 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			goto release_bh;
 		}
 	} else {
-		whiteout = ext4_whiteout_for_rename(mnt_userns, &old, credits, &handle);
+		whiteout = ext4_whiteout_for_rename(idmap, &old, credits, &handle);
 		if (IS_ERR(whiteout)) {
 			retval = PTR_ERR(whiteout);
 			goto release_bh;
@@ -4168,7 +4163,6 @@ static int ext4_rename2(struct mnt_idmap *idmap,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int err;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(old_dir->i_sb))))
@@ -4187,7 +4181,7 @@ static int ext4_rename2(struct mnt_idmap *idmap,
 					 new_dir, new_dentry);
 	}
 
-	return ext4_rename(mnt_userns, old_dir, old_dentry, new_dir, new_dentry, flags);
+	return ext4_rename(idmap, old_dir, old_dentry, new_dir, new_dentry, flags);
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cf0217d36402..9a3ffa39ad30 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3505,7 +3505,7 @@ void f2fs_handle_failed_inode(struct inode *inode);
 int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set);
 struct dentry *f2fs_get_parent(struct dentry *child);
-int f2fs_get_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+int f2fs_get_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		     struct inode **new_inode);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 96dd5cb2f49c..1d514515a6e7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2040,7 +2040,8 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 {
 	struct inode *inode = file_inode(filp);
-	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
@@ -2097,7 +2098,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		goto out;
 	}
 
-	ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
+	ret = f2fs_get_tmpfile(idmap, pinode, &fi->cow_inode);
 	iput(pinode);
 	if (ret) {
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 938032cbc1a8..d8e01bbbf27f 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -202,7 +202,7 @@ static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
 		file_set_hot(inode);
 }
 
-static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
+static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 						struct inode *dir, umode_t mode,
 						const char *name)
 {
@@ -225,7 +225,7 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 
 	nid_free = true;
 
-	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode_init_owner(idmap, inode, dir, mode);
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
@@ -336,7 +336,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	nid_t ino = 0;
@@ -351,7 +350,7 @@ static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(mnt_userns, dir, mode, dentry->d_name.name);
+	inode = f2fs_new_inode(idmap, dir, mode, dentry->d_name.name);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -663,7 +662,6 @@ static const char *f2fs_get_link(struct dentry *dentry,
 static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	size_t len = strlen(symname);
@@ -684,7 +682,7 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO, NULL);
+	inode = f2fs_new_inode(idmap, dir, S_IFLNK | S_IRWXUGO, NULL);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -744,7 +742,6 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 static int f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	int err;
@@ -756,7 +753,7 @@ static int f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode, NULL);
+	inode = f2fs_new_inode(idmap, dir, S_IFDIR | mode, NULL);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -800,7 +797,6 @@ static int f2fs_rmdir(struct inode *dir, struct dentry *dentry)
 static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	int err = 0;
@@ -814,7 +810,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
+	inode = f2fs_new_inode(idmap, dir, mode, NULL);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -841,7 +837,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			  struct file *file, umode_t mode, bool is_whiteout,
 			  struct inode **new_inode)
 {
@@ -853,7 +849,7 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
+	inode = f2fs_new_inode(idmap, dir, mode, NULL);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -914,7 +910,6 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 static int f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			struct file *file, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	int err;
 
@@ -923,28 +918,28 @@ static int f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (!f2fs_is_checkpoint_ready(sbi))
 		return -ENOSPC;
 
-	err = __f2fs_tmpfile(mnt_userns, dir, file, mode, false, NULL);
+	err = __f2fs_tmpfile(idmap, dir, file, mode, false, NULL);
 
 	return finish_open_simple(file, err);
 }
 
-static int f2fs_create_whiteout(struct user_namespace *mnt_userns,
+static int f2fs_create_whiteout(struct mnt_idmap *idmap,
 				struct inode *dir, struct inode **whiteout)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
 		return -EIO;
 
-	return __f2fs_tmpfile(mnt_userns, dir, NULL,
+	return __f2fs_tmpfile(idmap, dir, NULL,
 				S_IFCHR | WHITEOUT_MODE, true, whiteout);
 }
 
-int f2fs_get_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+int f2fs_get_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		     struct inode **new_inode)
 {
-	return __f2fs_tmpfile(mnt_userns, dir, NULL, S_IFREG, false, new_inode);
+	return __f2fs_tmpfile(idmap, dir, NULL, S_IFREG, false, new_inode);
 }
 
-static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			struct dentry *old_dentry, struct inode *new_dir,
 			struct dentry *new_dentry, unsigned int flags)
 {
@@ -984,7 +979,7 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	}
 
 	if (flags & RENAME_WHITEOUT) {
-		err = f2fs_create_whiteout(mnt_userns, old_dir, &whiteout);
+		err = f2fs_create_whiteout(idmap, old_dir, &whiteout);
 		if (err)
 			return err;
 	}
@@ -1305,7 +1300,6 @@ static int f2fs_rename2(struct mnt_idmap *idmap,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int err;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
@@ -1324,7 +1318,7 @@ static int f2fs_rename2(struct mnt_idmap *idmap,
 	 * VFS has already handled the new dentry existence case,
 	 * here, we just deal with "RENAME_NOREPLACE" as regular rename.
 	 */
-	return f2fs_rename(mnt_userns, old_dir, old_dentry,
+	return f2fs_rename(idmap, old_dir, old_dentry,
 					new_dir, new_dentry, flags);
 }
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c9ce69728a53..abb91f5fae92 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -390,7 +390,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 		return NULL;
 
 	inode->i_ino = sbi->next_cnid++;
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	set_nlink(inode, 1);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e1acab15e70d..0ce1cc4c2add 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -980,7 +980,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
 		inode->i_ino = get_next_ino();
-		inode_init_owner(&init_user_ns, inode, dir, mode);
+		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
diff --git a/fs/inode.c b/fs/inode.c
index 346d9199ad08..413b7380a089 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2279,20 +2279,22 @@ EXPORT_SYMBOL(init_special_inode);
 
 /**
  * inode_init_owner - Init uid,gid,mode for new inode according to posix standards
- * @mnt_userns:	User namespace of the mount the inode was created from
+ * @idmap: idmap of the mount the inode was created from
  * @inode: New inode
  * @dir: Directory inode
  * @mode: mode of the new inode
  *
- * If the inode has been created through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions
+ * If the inode has been created through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions
  * and initializing i_uid and i_gid. On non-idmapped mounts or if permission
- * checking is to be performed on the raw inode simply passs init_user_ns.
+ * checking is to be performed on the raw inode simply pass @nop_mnt_idmap.
  */
-void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
+void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
 		      const struct inode *dir, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	inode_fsuid_set(inode, mnt_userns);
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
index 59379089e939..9e1f02767201 100644
--- a/fs/jfs/jfs_inode.c
+++ b/fs/jfs/jfs_inode.c
@@ -64,7 +64,7 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
 		goto fail_put;
 	}
 
-	inode_init_owner(&init_user_ns, inode, parent, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, parent, mode);
 	/*
 	 * New inodes need to save sane values on disk when
 	 * uid & gid mount options are used
diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index 9115948c624e..724d8191a310 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -252,7 +252,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode, int *error)
 		iput(inode);
 		return NULL;
 	}
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = j;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_blocks = 0;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 7044bfff00dd..1310d2d5feb3 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -364,7 +364,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 	ii->i_bh = bh;
 
 	atomic64_inc(&root->inodes_count);
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = ino;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 2a9347e747e5..8ce2616b087f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1192,7 +1192,6 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap,
 				struct ntfs_fnd *fnd)
 {
 	int err;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	const struct qstr *name = &dentry->d_name;
@@ -1308,7 +1307,7 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap,
 		goto out3;
 	}
 	inode = &ni->vfs_inode;
-	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode_init_owner(idmap, inode, dir, mode);
 	mode = inode->i_mode;
 
 	inode->i_atime = inode->i_mtime = inode->i_ctime = ni->i_crtime =
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 80146869eac9..ba26c5567cff 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -336,7 +336,7 @@ static struct inode *dlmfs_get_root_inode(struct super_block *sb)
 
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode_init_owner(&init_user_ns, inode, NULL, mode);
+		inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inc_nlink(inode);
 
@@ -359,7 +359,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
 		return NULL;
 
 	inode->i_ino = get_next_ino();
-	inode_init_owner(&init_user_ns, inode, parent, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, parent, mode);
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 
 	ip = DLMFS_I(inode);
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 13433e774e3d..892d83576dae 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -198,7 +198,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
 	mode = mode_strip_sgid(&init_user_ns, dir, mode);
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	status = dquot_initialize(inode);
 	if (status)
 		return ERR_PTR(status);
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 2a0e83236c01..c4c79e07efc7 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -48,7 +48,7 @@ struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
 		goto fail;
 
 	inode->i_ino = new_block;
-	inode_init_owner(&init_user_ns, inode, NULL, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_mapping->a_ops = &omfs_aops;
 
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 17d509156215..fc25fb95d5fc 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -641,7 +641,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	inode->i_state |= I_CREATING;
 	spin_unlock(&inode->i_lock);
 
-	inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
 	attr.mode = inode->i_mode;
 
 	err = ovl_create_or_link(dentry, inode, &attr, false);
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index ba14f18bd1e5..5ba580c78835 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -61,7 +61,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode_init_owner(&init_user_ns, inode, dir, mode);
+		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 		inode->i_mapping->a_ops = &ram_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		mapping_set_unevictable(inode->i_mapping);
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index f80b4a6ecf51..42d2c20e1345 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -616,7 +616,7 @@ static int new_inode_init(struct inode *inode, struct inode *dir, umode_t mode)
 	 * the quota init calls have to know who to charge the quota to, so
 	 * we have to set uid and gid here
 	 */
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	return dquot_initialize(inode);
 }
 
diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
index 50df794a3c1f..e732879036ab 100644
--- a/fs/sysv/ialloc.c
+++ b/fs/sysv/ialloc.c
@@ -163,7 +163,7 @@ struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
 	*sbi->s_sb_fic_count = cpu_to_fs16(sbi, count);
 	fs16_add(sbi, sbi->s_sb_total_free_inodes, -1);
 	dirty_sb(sb);
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = fs16_to_cpu(sbi, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_blocks = 0;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 832e6adf9a92..1e92c1730c16 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -95,7 +95,7 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	 */
 	inode->i_flags |= S_NOCMTIME;
 
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
 			 current_time(inode);
 	inode->i_mapping->nrpages = 0;
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index b5d611cee749..e78a859d13e3 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -105,7 +105,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 		mutex_unlock(&sbi->s_alloc_mutex);
 	}
 
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_UID_SET))
 		inode->i_uid = sbi->s_uid;
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_GID_SET))
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 7e3e08c0166f..06bd84d555bd 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -289,7 +289,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	ufs_mark_sb_dirty(sb);
 
 	inode->i_ino = cg * uspi->s_ipg + bit;
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_blocks = 0;
 	inode->i_generation = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index d354ea2b74f9..f6e27224bd59 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -777,7 +777,7 @@ xfs_inode_inherit_flags2(
  */
 int
 xfs_init_new_inode(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct xfs_trans	*tp,
 	struct xfs_inode	*pip,
 	xfs_ino_t		ino,
@@ -788,6 +788,7 @@ xfs_init_new_inode(
 	bool			init_xattrs,
 	struct xfs_inode	**ipp)
 {
+	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct inode		*dir = pip ? VFS_I(pip) : NULL;
 	struct xfs_mount	*mp = tp->t_mountp;
 	struct xfs_inode	*ip;
@@ -827,7 +828,7 @@ xfs_init_new_inode(
 		inode->i_gid = dir->i_gid;
 		inode->i_mode = mode;
 	} else {
-		inode_init_owner(mnt_userns, inode, dir, mode);
+		inode_init_owner(idmap, inode, dir, mode);
 	}
 
 	/*
@@ -946,7 +947,7 @@ xfs_bumplink(
 
 int
 xfs_create(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	xfs_inode_t		*dp,
 	struct xfs_name		*name,
 	umode_t			mode,
@@ -954,6 +955,7 @@ xfs_create(
 	bool			init_xattrs,
 	xfs_inode_t		**ipp)
 {
+	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	int			is_dir = S_ISDIR(mode);
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_inode	*ip = NULL;
@@ -1020,7 +1022,7 @@ xfs_create(
 	 */
 	error = xfs_dialloc(&tp, dp->i_ino, mode, &ino);
 	if (!error)
-		error = xfs_init_new_inode(mnt_userns, tp, dp, ino, mode,
+		error = xfs_init_new_inode(idmap, tp, dp, ino, mode,
 				is_dir ? 2 : 1, rdev, prid, init_xattrs, &ip);
 	if (error)
 		goto out_trans_cancel;
@@ -1102,11 +1104,12 @@ xfs_create(
 
 int
 xfs_create_tmpfile(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct xfs_inode	*dp,
 	umode_t			mode,
 	struct xfs_inode	**ipp)
 {
+	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_inode	*ip = NULL;
 	struct xfs_trans	*tp = NULL;
@@ -1144,7 +1147,7 @@ xfs_create_tmpfile(
 
 	error = xfs_dialloc(&tp, dp->i_ino, mode, &ino);
 	if (!error)
-		error = xfs_init_new_inode(mnt_userns, tp, dp, ino, mode,
+		error = xfs_init_new_inode(idmap, tp, dp, ino, mode,
 				0, 0, prid, false, &ip);
 	if (error)
 		goto out_trans_cancel;
@@ -2709,7 +2712,7 @@ xfs_cross_rename(
  */
 static int
 xfs_rename_alloc_whiteout(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct xfs_name		*src_name,
 	struct xfs_inode	*dp,
 	struct xfs_inode	**wip)
@@ -2718,7 +2721,7 @@ xfs_rename_alloc_whiteout(
 	struct qstr		name;
 	int			error;
 
-	error = xfs_create_tmpfile(mnt_userns, dp, S_IFCHR | WHITEOUT_MODE,
+	error = xfs_create_tmpfile(idmap, dp, S_IFCHR | WHITEOUT_MODE,
 				   &tmpfile);
 	if (error)
 		return error;
@@ -2750,7 +2753,7 @@ xfs_rename_alloc_whiteout(
  */
 int
 xfs_rename(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct xfs_inode	*src_dp,
 	struct xfs_name		*src_name,
 	struct xfs_inode	*src_ip,
@@ -2782,7 +2785,7 @@ xfs_rename(
 	 * appropriately.
 	 */
 	if (flags & RENAME_WHITEOUT) {
-		error = xfs_rename_alloc_whiteout(mnt_userns, src_name,
+		error = xfs_rename_alloc_whiteout(idmap, src_name,
 						  target_dp, &wip);
 		if (error)
 			return error;
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index fa780f08dc89..69d21e42c10a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -473,18 +473,18 @@ int		xfs_release(struct xfs_inode *ip);
 void		xfs_inactive(struct xfs_inode *ip);
 int		xfs_lookup(struct xfs_inode *dp, const struct xfs_name *name,
 			   struct xfs_inode **ipp, struct xfs_name *ci_name);
-int		xfs_create(struct user_namespace *mnt_userns,
+int		xfs_create(struct mnt_idmap *idmap,
 			   struct xfs_inode *dp, struct xfs_name *name,
 			   umode_t mode, dev_t rdev, bool need_xattr,
 			   struct xfs_inode **ipp);
-int		xfs_create_tmpfile(struct user_namespace *mnt_userns,
+int		xfs_create_tmpfile(struct mnt_idmap *idmap,
 			   struct xfs_inode *dp, umode_t mode,
 			   struct xfs_inode **ipp);
 int		xfs_remove(struct xfs_inode *dp, struct xfs_name *name,
 			   struct xfs_inode *ip);
 int		xfs_link(struct xfs_inode *tdp, struct xfs_inode *sip,
 			 struct xfs_name *target_name);
-int		xfs_rename(struct user_namespace *mnt_userns,
+int		xfs_rename(struct mnt_idmap *idmap,
 			   struct xfs_inode *src_dp, struct xfs_name *src_name,
 			   struct xfs_inode *src_ip, struct xfs_inode *target_dp,
 			   struct xfs_name *target_name,
@@ -515,7 +515,7 @@ void		xfs_lock_two_inodes(struct xfs_inode *ip0, uint ip0_mode,
 xfs_extlen_t	xfs_get_extsz_hint(struct xfs_inode *ip);
 xfs_extlen_t	xfs_get_cowextsz_hint(struct xfs_inode *ip);
 
-int xfs_init_new_inode(struct user_namespace *mnt_userns, struct xfs_trans *tp,
+int xfs_init_new_inode(struct mnt_idmap *idmap, struct xfs_trans *tp,
 		struct xfs_inode *pip, xfs_ino_t ino, umode_t mode,
 		xfs_nlink_t nlink, dev_t rdev, prid_t prid, bool init_xattrs,
 		struct xfs_inode **ipp);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1323ac546e5f..94c2f4aa675a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -162,12 +162,12 @@ xfs_create_need_xattr(
 
 STATIC int
 xfs_generic_create(
-	struct user_namespace	*mnt_userns,
-	struct inode	*dir,
-	struct dentry	*dentry,
-	umode_t		mode,
-	dev_t		rdev,
-	struct file	*tmpfile)	/* unnamed file */
+	struct mnt_idmap	*idmap,
+	struct inode		*dir,
+	struct dentry		*dentry,
+	umode_t			mode,
+	dev_t			rdev,
+	struct file		*tmpfile)	/* unnamed file */
 {
 	struct inode	*inode;
 	struct xfs_inode *ip = NULL;
@@ -196,11 +196,11 @@ xfs_generic_create(
 		goto out_free_acl;
 
 	if (!tmpfile) {
-		error = xfs_create(mnt_userns, XFS_I(dir), &name, mode, rdev,
+		error = xfs_create(idmap, XFS_I(dir), &name, mode, rdev,
 				xfs_create_need_xattr(dir, default_acl, acl),
 				&ip);
 	} else {
-		error = xfs_create_tmpfile(mnt_userns, XFS_I(dir), mode, &ip);
+		error = xfs_create_tmpfile(idmap, XFS_I(dir), mode, &ip);
 	}
 	if (unlikely(error))
 		goto out_free_acl;
@@ -261,8 +261,7 @@ xfs_vn_mknod(
 	umode_t			mode,
 	dev_t			rdev)
 {
-	return xfs_generic_create(mnt_idmap_owner(idmap), dir, dentry, mode,
-				  rdev, NULL);
+	return xfs_generic_create(idmap, dir, dentry, mode, rdev, NULL);
 }
 
 STATIC int
@@ -273,8 +272,7 @@ xfs_vn_create(
 	umode_t			mode,
 	bool			flags)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, NULL);
+	return xfs_generic_create(idmap, dir, dentry, mode, 0, NULL);
 }
 
 STATIC int
@@ -284,8 +282,7 @@ xfs_vn_mkdir(
 	struct dentry		*dentry,
 	umode_t			mode)
 {
-	return xfs_generic_create(mnt_idmap_owner(idmap), dir, dentry,
-				  mode | S_IFDIR, 0, NULL);
+	return xfs_generic_create(idmap, dir, dentry, mode | S_IFDIR, 0, NULL);
 }
 
 STATIC struct dentry *
@@ -407,7 +404,6 @@ xfs_vn_symlink(
 	struct dentry		*dentry,
 	const char		*symname)
 {
-	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct inode	*inode;
 	struct xfs_inode *cip = NULL;
 	struct xfs_name	name;
@@ -420,7 +416,7 @@ xfs_vn_symlink(
 	if (unlikely(error))
 		goto out;
 
-	error = xfs_symlink(mnt_userns, XFS_I(dir), &name, symname, mode, &cip);
+	error = xfs_symlink(idmap, XFS_I(dir), &name, symname, mode, &cip);
 	if (unlikely(error))
 		goto out;
 
@@ -453,7 +449,6 @@ xfs_vn_rename(
 	struct dentry		*ndentry,
 	unsigned int		flags)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode	*new_inode = d_inode(ndentry);
 	int		omode = 0;
 	int		error;
@@ -476,7 +471,7 @@ xfs_vn_rename(
 	if (unlikely(error))
 		return error;
 
-	return xfs_rename(mnt_userns, XFS_I(odir), &oname,
+	return xfs_rename(idmap, XFS_I(odir), &oname,
 			  XFS_I(d_inode(odentry)), XFS_I(ndir), &nname,
 			  new_inode ? XFS_I(new_inode) : NULL, flags);
 }
@@ -1103,9 +1098,7 @@ xfs_vn_tmpfile(
 	struct file		*file,
 	umode_t			mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	int err = xfs_generic_create(mnt_userns, dir, file->f_path.dentry, mode, 0, file);
+	int err = xfs_generic_create(idmap, dir, file->f_path.dentry, mode, 0, file);
 
 	return finish_open_simple(file, err);
 }
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index ff53d40a2dae..a7303a9aa405 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -787,7 +787,7 @@ xfs_qm_qino_alloc(
 
 		error = xfs_dialloc(&tp, 0, S_IFREG, &ino);
 		if (!error)
-			error = xfs_init_new_inode(&init_user_ns, tp, NULL, ino,
+			error = xfs_init_new_inode(&nop_mnt_idmap, tp, NULL, ino,
 					S_IFREG, 1, 0, 0, false, ipp);
 		if (error) {
 			xfs_trans_cancel(tp);
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 8389f3ef88ef..24cf0a16bf35 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -144,13 +144,14 @@ xfs_readlink(
 
 int
 xfs_symlink(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct xfs_inode	*dp,
 	struct xfs_name		*link_name,
 	const char		*target_path,
 	umode_t			mode,
 	struct xfs_inode	**ipp)
 {
+	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_trans	*tp = NULL;
 	struct xfs_inode	*ip = NULL;
@@ -231,7 +232,7 @@ xfs_symlink(
 	 */
 	error = xfs_dialloc(&tp, dp->i_ino, S_IFLNK, &ino);
 	if (!error)
-		error = xfs_init_new_inode(mnt_userns, tp, dp, ino,
+		error = xfs_init_new_inode(idmap, tp, dp, ino,
 				S_IFLNK | (mode & ~S_IFMT), 1, 0, prid,
 				false, &ip);
 	if (error)
diff --git a/fs/xfs/xfs_symlink.h b/fs/xfs/xfs_symlink.h
index 2586b7e393f3..d1ca1ce62a93 100644
--- a/fs/xfs/xfs_symlink.h
+++ b/fs/xfs/xfs_symlink.h
@@ -7,7 +7,7 @@
 
 /* Kernel only symlink definitions */
 
-int xfs_symlink(struct user_namespace *mnt_userns, struct xfs_inode *dp,
+int xfs_symlink(struct mnt_idmap *idmap, struct xfs_inode *dp,
 		struct xfs_name *link_name, const char *target_path,
 		umode_t mode, struct xfs_inode **ipp);
 int xfs_readlink_bmap_ilocked(struct xfs_inode *ip, char *link);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index df3c139c7d0e..371964ed09dc 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1405,7 +1405,7 @@ static void zonefs_init_dir_inode(struct inode *parent, struct inode *inode,
 	struct super_block *sb = parent->i_sb;
 
 	inode->i_ino = bdev_nr_zones(sb->s_bdev) + type + 1;
-	inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
+	inode_init_owner(&nop_mnt_idmap, inode, parent, S_IFDIR | 0555);
 	inode->i_op = &zonefs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 635ce7a7740f..c1d698923d15 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2014,7 +2014,7 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 /*
  * VFS file helper functions.
  */
-void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
+void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
 umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index d4fa74bdf80c..9948b542a470 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -122,7 +122,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 	inode->i_mtime = inode->i_atime;
 	inode->i_ctime = inode->i_atime;
 
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
 	return inode;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index ed0fa9ed0a3b..028675cd97d4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2343,7 +2343,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
 	inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = ino;
-		inode_init_owner(&init_user_ns, inode, dir, mode);
+		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_generation = get_random_u32();

-- 
2.34.1

