Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2069E6695F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjAMLw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCB39F85
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D53161697
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A745AC433F2;
        Fri, 13 Jan 2023 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610593;
        bh=y49vbiKF+gv8mvx9NO7rXuoRQQLMCONXulJoMzbCrbE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NkhRCv/YM+sRd6CTdL8AcDbOKuCO0NFpRfhRNliQ1phk9ajNGc/UjzBV7FxQ+zHcv
         z2/pl3bxVEZkAFPb6eeUgpyZe/qfwlcTW6VZP3aJss0d2JW6ihaRF5w+LOlEDdzrPJ
         coNps6WjHR7py0DdTV/Ns+0bp/KAeuqjbnV7bv1wvOLVxK33egUAwWcKQHg69dGEha
         X99smf61bnj1R2O16gGj49npSaVNGx2rWG/X3o4VNr/X/cvR/LAbZIc4SRsnp7ZcHh
         o/OKOU26lqwtvkmxtAckE7joghEqzNFU6/4whverrZbU+/l1DxFSc6W3Q/Uj7ylDiU
         5S2LclFYXoSeA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:15 +0100
Subject: [PATCH 07/25] fs: port ->mkdir() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-7-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=36269; i=brauner@kernel.org;
 h=from:subject:message-id; bh=y49vbiKF+gv8mvx9NO7rXuoRQQLMCONXulJoMzbCrbE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2aUNMcnla7QnYdR6n1as6/vVo7K4sva6zZ++pOzd02
 owLNjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImwtDL8z5baslflX7bFgfqNnv+OLW
 Z53/C55OI2f4Yp0nJ+r8/2XGD4K6en5Zyauso7IauhQkVWffe7lhUW07a2MOVls3GWzWJlBwA=
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
 fs/9p/vfs_inode.c                     | 4 ++--
 fs/9p/vfs_inode_dotl.c                | 4 ++--
 fs/affs/affs.h                        | 2 +-
 fs/affs/namei.c                       | 2 +-
 fs/afs/dir.c                          | 4 ++--
 fs/autofs/root.c                      | 4 ++--
 fs/bad_inode.c                        | 2 +-
 fs/btrfs/inode.c                      | 3 ++-
 fs/ceph/dir.c                         | 2 +-
 fs/cifs/cifsfs.h                      | 2 +-
 fs/cifs/inode.c                       | 2 +-
 fs/coda/dir.c                         | 2 +-
 fs/configfs/dir.c                     | 2 +-
 fs/ecryptfs/inode.c                   | 2 +-
 fs/exfat/namei.c                      | 2 +-
 fs/ext2/namei.c                       | 2 +-
 fs/ext4/namei.c                       | 3 ++-
 fs/f2fs/namei.c                       | 3 ++-
 fs/fat/namei_msdos.c                  | 2 +-
 fs/fat/namei_vfat.c                   | 2 +-
 fs/fuse/dir.c                         | 2 +-
 fs/gfs2/inode.c                       | 4 ++--
 fs/hfs/dir.c                          | 2 +-
 fs/hfsplus/dir.c                      | 2 +-
 fs/hostfs/hostfs_kern.c               | 2 +-
 fs/hpfs/namei.c                       | 2 +-
 fs/hugetlbfs/inode.c                  | 2 +-
 fs/jffs2/dir.c                        | 4 ++--
 fs/jfs/namei.c                        | 2 +-
 fs/kernfs/dir.c                       | 2 +-
 fs/minix/namei.c                      | 2 +-
 fs/namei.c                            | 2 +-
 fs/nfs/dir.c                          | 2 +-
 fs/nfs/internal.h                     | 2 +-
 fs/nilfs2/namei.c                     | 2 +-
 fs/ntfs3/namei.c                      | 3 ++-
 fs/ocfs2/dlmfs/dlmfs.c                | 2 +-
 fs/ocfs2/namei.c                      | 2 +-
 fs/omfs/dir.c                         | 2 +-
 fs/orangefs/namei.c                   | 2 +-
 fs/overlayfs/dir.c                    | 2 +-
 fs/ramfs/inode.c                      | 2 +-
 fs/reiserfs/namei.c                   | 2 +-
 fs/reiserfs/xattr.c                   | 2 +-
 fs/sysv/namei.c                       | 2 +-
 fs/tracefs/inode.c                    | 2 +-
 fs/ubifs/dir.c                        | 2 +-
 fs/udf/namei.c                        | 2 +-
 fs/ufs/namei.c                        | 2 +-
 fs/vboxsf/dir.c                       | 2 +-
 fs/xfs/xfs_iops.c                     | 6 +++---
 include/linux/fs.h                    | 2 +-
 kernel/bpf/inode.c                    | 2 +-
 mm/shmem.c                            | 2 +-
 security/apparmor/apparmorfs.c        | 2 +-
 57 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 2e656b651574..ac7871ff1e3c 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -61,7 +61,7 @@ prototypes::
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct inode *,struct dentry *,umode_t);
+	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
 	int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
 	int (*rename) (struct inode *, struct dentry *,
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 5a1195cf34ba..daf9593b3754 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -426,7 +426,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
 		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
-		int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,umode_t);
+		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 		int (*rmdir) (struct inode *,struct dentry *);
 		int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,umode_t,dev_t);
 		int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 401c0b63d5bb..ba9e68bd3589 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -704,14 +704,14 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 
 /**
  * v9fs_vfs_mkdir - VFS mkdir hook to create a directory
- * @mnt_userns: The user namespace of the mount
+ * @idmap: idmap of the mount
  * @dir:  inode that is being unlinked
  * @dentry: dentry that is being unlinked
  * @mode: mode for new directory
  *
  */
 
-static int v9fs_vfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode)
 {
 	int err;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index d3245221ddd4..63389ba14806 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -357,14 +357,14 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 
 /**
  * v9fs_vfs_mkdir_dotl - VFS mkdir hook to create a directory
- * @mnt_userns: The user namespace of the mount
+ * @idmap: The idmap of the mount
  * @dir:  inode that is being unlinked
  * @dentry: dentry that is being unlinked
  * @omode: mode for new directory
  *
  */
 
-static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
+static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			       struct inode *dir, struct dentry *dentry,
 			       umode_t omode)
 {
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index f9f986a2c509..8f70a839c311 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -169,7 +169,7 @@ extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, unsi
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
 extern int	affs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool);
-extern int	affs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+extern int	affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode);
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
 extern int	affs_link(struct dentry *olddentry, struct inode *dir,
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 1d7f7232964d..e0300f0b6fc3 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -274,7 +274,7 @@ affs_create(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 int
-affs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	   struct dentry *dentry, umode_t mode)
 {
 	struct inode		*inode;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a936aa8191b2..c2ada2fc51b4 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -30,7 +30,7 @@ static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, int nl
 			      loff_t fpos, u64 ino, unsigned dtype);
 static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl);
-static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode);
 static int afs_rmdir(struct inode *dir, struct dentry *dentry);
 static int afs_unlink(struct inode *dir, struct dentry *dentry);
@@ -1332,7 +1332,7 @@ static const struct afs_operation_ops afs_mkdir_operation = {
 /*
  * create a directory on an AFS filesystem
  */
-static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct afs_operation *op;
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index bf0029cef304..cbc0da00a3cf 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -15,7 +15,7 @@ static int autofs_dir_symlink(struct mnt_idmap *, struct inode *,
 			      struct dentry *, const char *);
 static int autofs_dir_unlink(struct inode *, struct dentry *);
 static int autofs_dir_rmdir(struct inode *, struct dentry *);
-static int autofs_dir_mkdir(struct user_namespace *, struct inode *,
+static int autofs_dir_mkdir(struct mnt_idmap *, struct inode *,
 			    struct dentry *, umode_t);
 static long autofs_root_ioctl(struct file *, unsigned int, unsigned long);
 #ifdef CONFIG_COMPAT
@@ -720,7 +720,7 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	return 0;
 }
 
-static int autofs_dir_mkdir(struct user_namespace *mnt_userns,
+static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    umode_t mode)
 {
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 2d3ca4b5628f..6b6d20a41b60 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -58,7 +58,7 @@ static int bad_inode_symlink(struct mnt_idmap *idmap,
 	return -EIO;
 }
 
-static int bad_inode_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int bad_inode_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode)
 {
 	return -EIO;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f4879dd92035..d0a965cfeda4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6839,9 +6839,10 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	return err;
 }
 
-static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 114375efa2f7..af9ef4ba8d27 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -971,7 +971,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 52256b751c75..ab729c6007e8 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -59,7 +59,7 @@ extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
 extern int cifs_mknod(struct user_namespace *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
-extern int cifs_mkdir(struct user_namespace *, struct inode *, struct dentry *,
+extern int cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t);
 extern int cifs_rmdir(struct inode *, struct dentry *);
 extern int cifs_rename2(struct user_namespace *, struct inode *,
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index aad6a40c9721..ce4f086db2df 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1910,7 +1910,7 @@ cifs_posix_mkdir(struct inode *inode, struct dentry *dentry, umode_t mode,
 }
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
-int cifs_mkdir(struct user_namespace *mnt_userns, struct inode *inode,
+int cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
 	       struct dentry *direntry, umode_t mode)
 {
 	int rc = 0;
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index b8e82bc0071f..ff90117f1eec 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -166,7 +166,7 @@ static int coda_create(struct mnt_idmap *idmap, struct inode *dir,
 	return error;
 }
 
-static int coda_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *de, umode_t mode)
 {
 	struct inode *inode;
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ec6519e1ca3b..4afcbbe63e68 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1251,7 +1251,7 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 }
 EXPORT_SYMBOL(configfs_depend_item_unlocked);
 
-static int configfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode)
 {
 	int ret = 0;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 692320ee079d..6f9da8d138dc 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -495,7 +495,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	return rc;
 }
 
-static int ecryptfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode)
 {
 	int rc;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index f40cc11016ad..99e86caba544 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -834,7 +834,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 72d9a3111001..179a6a7b4845 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -225,7 +225,7 @@ static int ext2_link (struct dentry * old_dentry, struct inode * dir,
 	return err;
 }
 
-static int ext2_mkdir(struct user_namespace * mnt_userns,
+static int ext2_mkdir(struct mnt_idmap * idmap,
 	struct inode * dir, struct dentry * dentry, umode_t mode)
 {
 	struct inode * inode;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 11d9c1d1fc56..e5c54c30696e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2973,9 +2973,10 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	return err;
 }
 
-static int ext4_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, err2 = 0, credits, retries = 0;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5ef5ed50ce80..0ed2909696e2 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -741,9 +741,10 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	int err;
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 353ca26b3ea4..b98025f21d9b 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -339,7 +339,7 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 /***** Make a directory */
-static int msdos_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int msdos_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index de5ee606ae5f..f5f4caff75e2 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -844,7 +844,7 @@ static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int vfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int vfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 179d8a33e13e..d007e504f4c6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -819,7 +819,7 @@ static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *entry, umode_t mode)
 {
 	struct fuse_mkdir_in inarg;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 830049759b07..bb06eabd2fc3 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1229,7 +1229,7 @@ static int gfs2_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 /**
  * gfs2_mkdir - Make a directory
- * @mnt_userns: User namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @dir: The parent directory of the new one
  * @dentry: The dentry of the new directory
  * @mode: The mode of the new directory
@@ -1237,7 +1237,7 @@ static int gfs2_symlink(struct mnt_idmap *idmap, struct inode *dir,
  * Returns: errno
  */
 
-static int gfs2_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	unsigned dsize = gfs2_max_stuffed_size(GFS2_I(dir));
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 17fd7c3914b0..f8141c407d55 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -219,7 +219,7 @@ static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
  * in a directory, given the inode for the parent directory and the
  * name (and its length) of the new directory.
  */
-static int hfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 36927ca6b1f5..9a953bb62eac 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -523,7 +523,7 @@ static int hfsplus_create(struct mnt_idmap *idmap, struct inode *dir,
 	return hfsplus_mknod(&init_user_ns, dir, dentry, mode, 0);
 }
 
-static int hfsplus_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int hfsplus_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
 {
 	return hfsplus_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index e78f53e60dcd..f9369099125e 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -671,7 +671,7 @@ static int hostfs_symlink(struct mnt_idmap *idmap, struct inode *ino,
 	return err;
 }
 
-static int hostfs_mkdir(struct user_namespace *mnt_userns, struct inode *ino,
+static int hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
 			struct dentry *dentry, umode_t mode)
 {
 	char *file;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index c5f0aec11457..b44bc14e735b 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -20,7 +20,7 @@ static void hpfs_update_directory_times(struct inode *dir)
 	hpfs_write_inode_nolock(dir);
 }
 
-static int hpfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	const unsigned char *name = dentry->d_name.name;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 170c99cb3095..0f16a509c3d8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1033,7 +1033,7 @@ static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return 0;
 }
 
-static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode)
 {
 	int retval = hugetlbfs_mknod(&init_user_ns, dir, dentry,
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 51433fef9d2b..9158d8e1b762 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -32,7 +32,7 @@ static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
 static int jffs2_unlink (struct inode *,struct dentry *);
 static int jffs2_symlink (struct mnt_idmap *, struct inode *,
 			  struct dentry *, const char *);
-static int jffs2_mkdir (struct user_namespace *, struct inode *,struct dentry *,
+static int jffs2_mkdir (struct mnt_idmap *, struct inode *,struct dentry *,
 			umode_t);
 static int jffs2_rmdir (struct inode *,struct dentry *);
 static int jffs2_mknod (struct user_namespace *, struct inode *,struct dentry *,
@@ -442,7 +442,7 @@ static int jffs2_symlink (struct mnt_idmap *idmap, struct inode *dir_i,
 }
 
 
-static int jffs2_mkdir (struct user_namespace *mnt_userns, struct inode *dir_i,
+static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 		        struct dentry *dentry, umode_t mode)
 {
 	struct jffs2_inode_info *f, *dir_f;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index e7d65581db75..588dbd757293 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -192,7 +192,7 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
  * note:
  * EACCES: user needs search+write permission on the parent directory
  */
-static int jfs_mkdir(struct user_namespace *mnt_userns, struct inode *dip,
+static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
 		     struct dentry *dentry, umode_t mode)
 {
 	int rc = 0;
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 935ef8cb02b2..4f2d521bedab 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1200,7 +1200,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	return d_splice_alias(inode, dentry);
 }
 
-static int kernfs_iop_mkdir(struct user_namespace *mnt_userns,
+static int kernfs_iop_mkdir(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    umode_t mode)
 {
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 0a07410a1a27..bd5dcd528b9a 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -111,7 +111,7 @@ static int minix_link(struct dentry * old_dentry, struct inode * dir,
 	return add_nondir(dentry, inode);
 }
 
-static int minix_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	struct inode * inode;
diff --git a/fs/namei.c b/fs/namei.c
index 24ad4a8963df..7b543c523350 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4044,7 +4044,7 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		return -EMLINK;
 
-	error = dir->i_op->mkdir(mnt_userns, dir, dentry, mode);
+	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
 	return error;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5ae3ed47c388..91ad69a1776e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2352,7 +2352,7 @@ EXPORT_SYMBOL_GPL(nfs_mknod);
 /*
  * See comments for nfs_proc_create regarding failed operations.
  */
-int nfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+int nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode)
 {
 	struct iattr attr;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 33ec2c2a52de..93a97af3638a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -386,7 +386,7 @@ struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
 	       umode_t, bool);
-int nfs_mkdir(struct user_namespace *, struct inode *, struct dentry *,
+int nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
 	      umode_t);
 int nfs_rmdir(struct inode *, struct dentry *);
 int nfs_unlink(struct inode *, struct dentry *);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index d6cd71bb91e0..e0ef6ff0f35c 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -202,7 +202,7 @@ static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
 	return err;
 }
 
-static int nilfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int nilfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index be6a00a07004..f40ac46fa1d1 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -200,9 +200,10 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 /*
  * ntfs_mkdir- inode_operations::mkdir
  */
-static int ntfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFDIR | mode,
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 812ff62e6560..80146869eac9 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -402,7 +402,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
  * File creation. Allocate an inode, and we're done..
  */
 /* SMP-safe */
-static int dlmfs_mkdir(struct user_namespace * mnt_userns,
+static int dlmfs_mkdir(struct mnt_idmap * idmap,
 		       struct inode * dir,
 		       struct dentry * dentry,
 		       umode_t mode)
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index dedb37a88345..e1db6da2f70b 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -642,7 +642,7 @@ static int ocfs2_mknod_locked(struct ocfs2_super *osb,
 				    fe_blkno, suballoc_loc, suballoc_bit);
 }
 
-static int ocfs2_mkdir(struct user_namespace *mnt_userns,
+static int ocfs2_mkdir(struct mnt_idmap *idmap,
 		       struct inode *dir,
 		       struct dentry *dentry,
 		       umode_t mode)
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 28590755c1d3..34138f46f7e7 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -279,7 +279,7 @@ static int omfs_add_node(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
-static int omfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int omfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	return omfs_add_node(dir, dentry, mode | S_IFDIR);
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 59866be48329..9243c35fb478 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -305,7 +305,7 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
 	return ret;
 }
 
-static int orangefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode)
 {
 	struct orangefs_inode_s *parent = ORANGEFS_I(dir);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 272906ec9512..abdaa12e833d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -661,7 +661,7 @@ static int ovl_create(struct mnt_idmap *idmap, struct inode *dir,
 	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
 }
 
-static int ovl_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int ovl_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	return ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, NULL);
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index f97b8856cebf..1f0e9c8581cd 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -110,7 +110,7 @@ ramfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return error;
 }
 
-static int ramfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	int retval = ramfs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 062e05f1b961..149b3c9af275 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -784,7 +784,7 @@ static int reiserfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return retval;
 }
 
-static int reiserfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int reiserfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode)
 {
 	int retval;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 7f5ca335b97b..f4300c73a192 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -73,7 +73,7 @@ static int xattr_create(struct inode *dir, struct dentry *dentry, int mode)
 static int xattr_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	BUG_ON(!inode_is_locked(dir));
-	return dir->i_op->mkdir(&init_user_ns, dir, dentry, mode);
+	return dir->i_op->mkdir(&nop_mnt_idmap, dir, dentry, mode);
 }
 
 /*
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index c277c0a8f6b2..982caf4dec67 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -110,7 +110,7 @@ static int sysv_link(struct dentry * old_dentry, struct inode * dir,
 	return add_nondir(dentry, inode);
 }
 
-static int sysv_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	struct inode * inode;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index da85b3979195..57ac8aa4a724 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -67,7 +67,7 @@ static char *get_dname(struct dentry *dentry)
 	return name;
 }
 
-static int tracefs_syscall_mkdir(struct user_namespace *mnt_userns,
+static int tracefs_syscall_mkdir(struct mnt_idmap *idmap,
 				 struct inode *inode, struct dentry *dentry,
 				 umode_t mode)
 {
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 325c5693fb5f..042ddfbc1d82 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -979,7 +979,7 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int ubifs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index f2c3ee7ebe1b..9a360f286d1c 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -661,7 +661,7 @@ static int udf_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return udf_add_nondir(dentry, inode);
 }
 
-static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index cb3d9bee6626..5d6b05269cf4 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -166,7 +166,7 @@ static int ufs_link (struct dentry * old_dentry, struct inode * dir,
 	return error;
 }
 
-static int ufs_mkdir(struct user_namespace * mnt_userns, struct inode * dir,
+static int ufs_mkdir(struct mnt_idmap * idmap, struct inode * dir,
 	struct dentry * dentry, umode_t mode)
 {
 	struct inode * inode;
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 95d54cb5221d..4ec79548e9f0 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -301,7 +301,7 @@ static int vboxsf_dir_mkfile(struct mnt_idmap *idmap,
 	return vboxsf_dir_create(parent, dentry, mode, false, excl, NULL);
 }
 
-static int vboxsf_dir_mkdir(struct user_namespace *mnt_userns,
+static int vboxsf_dir_mkdir(struct mnt_idmap *idmap,
 			    struct inode *parent, struct dentry *dentry,
 			    umode_t mode)
 {
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 4f9fcd0cf8ba..df3d7f6dbd7d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -278,13 +278,13 @@ xfs_vn_create(
 
 STATIC int
 xfs_vn_mkdir(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct dentry		*dentry,
 	umode_t			mode)
 {
-	return xfs_generic_create(mnt_userns, dir, dentry, mode | S_IFDIR, 0,
-				  NULL);
+	return xfs_generic_create(mnt_idmap_owner(idmap), dir, dentry,
+				  mode | S_IFDIR, 0, NULL);
 }
 
 STATIC struct dentry *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4bde68e15d5c..f6b1f0ca261a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2145,7 +2145,7 @@ struct inode_operations {
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
 			const char *);
-	int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,
+	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,
 		      umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
 	int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 32c8f695e0b5..d7d14ce2a031 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -152,7 +152,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	dir->i_ctime = dir->i_mtime;
 }
 
-static int bpf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
diff --git a/mm/shmem.c b/mm/shmem.c
index 38b973f116d8..998e5873f029 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2970,7 +2970,7 @@ shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	return error;
 }
 
-static int shmem_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+static int shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	int error;
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 424b2c1e586d..db7a51acf9db 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1793,7 +1793,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 	return error;
 }
 
-static int ns_mkdir_op(struct user_namespace *mnt_userns, struct inode *dir,
+static int ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	struct aa_ns *ns, *parent;

-- 
2.34.1

