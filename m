Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12890669620
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbjAMLxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69963BEB0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553416156A
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B145EC433D2;
        Fri, 13 Jan 2023 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610598;
        bh=zZ7GXiiJuepLg6KuVSDnAVsR/Z5lsPnCkFI6JGaDgb8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=djXNc6M9JURoxQmxXZLLYmiekr7cq1x7FjfEMN5/7yS8YLSG40RLqO9dKnDy08f7m
         mmsaAodm6/ollz8AkQBwaw+IzHSetKtccEDGEm3bkgBw5huLqKjIy1nQf4PHEHKd3M
         u2NvmpbVBkwiMOwaQfTT6eymCqvXnEK1B+TYCvYRSnKX+e5p8ctFldLO6zTOHLG9py
         mnpoIQrxWyzru4mEEd0w6JM+fMVoZKXm9jHHRnDwKsC7rKc2YvEs/cLp4NMOVHownQ
         888ZQGipsPYbM3VRq3eTWjgfDw5smzI9LS1naNd7y/zr804uQqKfEfHOVuX3mTsr7T
         ZLthHqZ/sCvHg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:18 +0100
Subject: [PATCH 10/25] fs: port ->tmpfile() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-10-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=11149; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zZ7GXiiJuepLg6KuVSDnAVsR/Z5lsPnCkFI6JGaDgb8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2q/Zd59GtkiufTtOsn9nM1VH4S2BYRz2v2+6zZWtEV
 ZpYLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyroLhf56mVL7szfU2DkJvXreaGf
 3b7vsr+PTDuoMdjquYHH2UbjL8j3/nGVU9+dhHjdOl5pX56YHnj7iIGMXw/N+bekPnfqolHwA=
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
 Documentation/filesystems/locking.rst | 2 +-
 Documentation/filesystems/vfs.rst     | 2 +-
 fs/bad_inode.c                        | 2 +-
 fs/btrfs/inode.c                      | 3 ++-
 fs/ext2/namei.c                       | 2 +-
 fs/ext4/namei.c                       | 3 ++-
 fs/f2fs/namei.c                       | 3 ++-
 fs/fuse/dir.c                         | 2 +-
 fs/hugetlbfs/inode.c                  | 2 +-
 fs/minix/namei.c                      | 2 +-
 fs/namei.c                            | 2 +-
 fs/ramfs/inode.c                      | 2 +-
 fs/ubifs/dir.c                        | 2 +-
 fs/udf/namei.c                        | 2 +-
 fs/xfs/xfs_iops.c                     | 4 +++-
 include/linux/fs.h                    | 2 +-
 mm/shmem.c                            | 2 +-
 17 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c63890845d95..429b8e4a6284 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -79,7 +79,7 @@ prototypes::
 	int (*atomic_open)(struct inode *, struct dentry *,
 				struct file *, unsigned open_flag,
 				umode_t create_mode);
-	int (*tmpfile) (struct user_namespace *, struct inode *,
+	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct fileattr *fa);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 263fcc57b71f..3fcadfcf4e3a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -442,7 +442,7 @@ As of kernel 2.6.22, the following members are defined:
 		void (*update_time)(struct inode *, struct timespec *, int);
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
-		int (*tmpfile) (struct user_namespace *, struct inode *, struct file *, umode_t);
+		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umode_t);
 		struct posix_acl * (*get_acl)(struct user_namespace *, struct dentry *, int);
 	        int (*set_acl)(struct user_namespace *, struct dentry *, struct posix_acl *, int);
 		int (*fileattr_set)(struct user_namespace *mnt_userns,
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 1e24ce889a15..4bdf40b187ff 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -146,7 +146,7 @@ static int bad_inode_atomic_open(struct inode *inode, struct dentry *dentry,
 	return -EIO;
 }
 
-static int bad_inode_tmpfile(struct user_namespace *mnt_userns,
+static int bad_inode_tmpfile(struct mnt_idmap *idmap,
 			     struct inode *inode, struct file *file,
 			     umode_t mode)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbb6790d0268..c10157a5a6f8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10095,9 +10095,10 @@ static int btrfs_permission(struct user_namespace *mnt_userns,
 	return generic_permission(mnt_userns, inode, mask);
 }
 
-static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			 struct file *file, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 8b5dfa46bcc8..81808e3d11c1 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -119,7 +119,7 @@ static int ext2_create (struct mnt_idmap * idmap,
 	return ext2_add_nondir(dentry, inode);
 }
 
-static int ext2_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int ext2_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			struct file *file, umode_t mode)
 {
 	struct inode *inode = ext2_new_inode(dir, mode, NULL);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index feb58508978e..74a2c3eae066 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2863,9 +2863,10 @@ static int ext4_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int ext4_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			struct file *file, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, retries = 0;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a87b9fcaf923..938032cbc1a8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -911,9 +911,10 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			struct file *file, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	int err;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c95d610fa63f..ca07660a76a8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -802,7 +802,7 @@ static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
 	return fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
 }
 
-static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			struct file *file, umode_t mode)
 {
 	struct fuse_conn *fc = get_fuse_conn(dir);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b37e29dc125d..e1acab15e70d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1050,7 +1050,7 @@ static int hugetlbfs_create(struct mnt_idmap *idmap,
 	return hugetlbfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
 }
 
-static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
+static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
 			     struct inode *dir, struct file *file,
 			     umode_t mode)
 {
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index aa308b12f40d..39ebe10d6a8b 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -52,7 +52,7 @@ static int minix_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return error;
 }
 
-static int minix_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int minix_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			 struct file *file, umode_t mode)
 {
 	int error;
diff --git a/fs/namei.c b/fs/namei.c
index 3be66e8b418f..34f020ae67ae 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3613,7 +3613,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 	file->f_path.mnt = parentpath->mnt;
 	file->f_path.dentry = child;
 	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
-	error = dir->i_op->tmpfile(mnt_userns, dir, file, mode);
+	error = dir->i_op->tmpfile(idmap, dir, file, mode);
 	dput(child);
 	if (error)
 		return error;
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 2ca68aa81895..ba14f18bd1e5 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -145,7 +145,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return error;
 }
 
-static int ramfs_tmpfile(struct user_namespace *mnt_userns,
+static int ramfs_tmpfile(struct mnt_idmap *idmap,
 			 struct inode *dir, struct file *file, umode_t mode)
 {
 	struct inode *inode;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index e11a2d76fb0e..832e6adf9a92 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -426,7 +426,7 @@ static void unlock_2_inodes(struct inode *inode1, struct inode *inode2)
 	mutex_unlock(&ubifs_inode(inode1)->ui_mutex);
 }
 
-static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int ubifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			 struct file *file, umode_t mode)
 {
 	struct dentry *dentry = file->f_path.dentry;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index c93b10513bab..bdba2206a678 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -625,7 +625,7 @@ static int udf_create(struct mnt_idmap *idmap, struct inode *dir,
 	return udf_add_nondir(dentry, inode);
 }
 
-static int udf_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+static int udf_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		       struct file *file, umode_t mode)
 {
 	struct inode *inode = udf_new_inode(dir, mode);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index fd0c62e0ddd2..43e746167d61 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1098,11 +1098,13 @@ xfs_vn_fiemap(
 
 STATIC int
 xfs_vn_tmpfile(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct file		*file,
 	umode_t			mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	int err = xfs_generic_create(mnt_userns, dir, file->f_path.dentry, mode, 0, file);
 
 	return finish_open_simple(file, err);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8d287bd2bf9b..4855fd071bf8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2162,7 +2162,7 @@ struct inode_operations {
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
-	int (*tmpfile) (struct user_namespace *, struct inode *,
+	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
 	struct posix_acl *(*get_acl)(struct user_namespace *, struct dentry *,
 				     int);
diff --git a/mm/shmem.c b/mm/shmem.c
index c9998c2220d3..ab289abe5827 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2946,7 +2946,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int
-shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	      struct file *file, umode_t mode)
 {
 	struct inode *inode;

-- 
2.34.1

