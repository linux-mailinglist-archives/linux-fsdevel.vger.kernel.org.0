Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652666961E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbjAMLxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D03D1DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CE8561697
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB99C433F0;
        Fri, 13 Jan 2023 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610603;
        bh=ZvKta5lkR10Z5AB+z+8DrwDy0fvtqcE6eeF5KZvEGuM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VCrCfVlmoKl479Azsud1dpI55Crvmu9pq1enLRxxAY0lrhDrPniccuJhoBhMHYxkR
         2WH0JmPRoGfnk3Esj/hR2ITVXxTT2pI9A4LSiX9f4HP8px7mRfwOdJlxgz8KPWctzZ
         pEnltFhrZ8K9QzZMeg5rf2Awh5JbxqANGtbygpxuXlldU8yfrb9FuGQaHpPpfAV57y
         OsXnpk312wDUF8dMfCKcq66C33TDH9iHimLBJ3tc2iGsMK1nH7M1g6qraZ/y/WuN/p
         aMqI0DfO1LA6fGqDY+nXc0iRVLGahJrEYkyPKol9C1cfmikf1K4TK62utVdaP5OEvP
         7QrgRlR/Hkv+g==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:21 +0100
Subject: [PATCH 13/25] fs: port ->fileattr_set() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-13-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=25720; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZvKta5lkR10Z5AB+z+8DrwDy0fvtqcE6eeF5KZvEGuM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA1uefVozsyOpf+0dr3IPTDl5z2GN5pmlnPN2+INYvo7
 Y0SWdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk+gRGhgfvs1l/Rj302ODmWP1SaO
 uGXysM0xZ+9W39pNLoaNJ8zo6R4csRqQ/r9ddXJ7JoWJzm138yV1r6kLney7ke7G9et/fo8wEA
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
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     |  2 +-
 fs/btrfs/ioctl.c                      |  2 +-
 fs/btrfs/ioctl.h                      |  2 +-
 fs/ecryptfs/inode.c                   |  4 ++--
 fs/efivarfs/inode.c                   |  2 +-
 fs/ext2/ext2.h                        |  2 +-
 fs/ext2/ioctl.c                       |  2 +-
 fs/ext4/ext4.h                        |  2 +-
 fs/ext4/ioctl.c                       |  2 +-
 fs/f2fs/f2fs.h                        |  2 +-
 fs/f2fs/file.c                        |  2 +-
 fs/fuse/fuse_i.h                      |  2 +-
 fs/fuse/ioctl.c                       |  2 +-
 fs/gfs2/file.c                        |  2 +-
 fs/gfs2/inode.h                       |  2 +-
 fs/hfsplus/hfsplus_fs.h               |  2 +-
 fs/hfsplus/inode.c                    |  2 +-
 fs/ioctl.c                            | 16 ++++++++--------
 fs/jfs/ioctl.c                        |  2 +-
 fs/jfs/jfs_inode.h                    |  2 +-
 fs/nilfs2/ioctl.c                     |  2 +-
 fs/nilfs2/nilfs.h                     |  2 +-
 fs/ocfs2/ioctl.c                      |  2 +-
 fs/ocfs2/ioctl.h                      |  2 +-
 fs/orangefs/inode.c                   |  2 +-
 fs/overlayfs/inode.c                  |  4 ++--
 fs/overlayfs/overlayfs.h              |  2 +-
 fs/reiserfs/ioctl.c                   |  2 +-
 fs/reiserfs/reiserfs.h                |  2 +-
 fs/ubifs/ioctl.c                      |  2 +-
 fs/ubifs/ubifs.h                      |  2 +-
 fs/xfs/xfs_ioctl.c                    |  3 ++-
 fs/xfs/xfs_ioctl.h                    |  2 +-
 include/linux/fileattr.h              |  2 +-
 include/linux/fs.h                    |  2 +-
 mm/shmem.c                            |  2 +-
 37 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d42d7b8de2f5..fb23ffc0792c 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -81,7 +81,7 @@ prototypes::
 				umode_t create_mode);
 	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
-	int (*fileattr_set)(struct user_namespace *mnt_userns,
+	int (*fileattr_set)(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 19afe53f7060..bf5cc9809b65 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -445,7 +445,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umode_t);
 		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
 	        int (*set_acl)(struct mnt_idmap *, struct dentry *, struct posix_acl *, int);
-		int (*fileattr_set)(struct user_namespace *mnt_userns,
+		int (*fileattr_set)(struct mnt_idmap *idmap,
 				    struct dentry *dentry, struct fileattr *fa);
 		int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	};
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e348bd2ccde..f23d0d399b9f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -243,7 +243,7 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int btrfs_fileattr_set(struct user_namespace *mnt_userns,
+int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index 8a855d5ac2fa..d51b9a2f2f6e 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -6,7 +6,7 @@
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int btrfs_fileattr_set(struct user_namespace *mnt_userns,
+int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index b62351b7ad6a..133e6c13d9b8 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1110,13 +1110,13 @@ static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
 }
 
-static int ecryptfs_fileattr_set(struct user_namespace *mnt_userns,
+static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
 				 struct dentry *dentry, struct fileattr *fa)
 {
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	int rc;
 
-	rc = vfs_fileattr_set(&init_user_ns, lower_dentry, fa);
+	rc = vfs_fileattr_set(&nop_mnt_idmap, lower_dentry, fa);
 	fsstack_copy_attr_all(d_inode(dentry), d_inode(lower_dentry));
 
 	return rc;
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 80369872815f..b973a2c03dde 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -163,7 +163,7 @@ efivarfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 static int
-efivarfs_fileattr_set(struct user_namespace *mnt_userns,
+efivarfs_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa)
 {
 	unsigned int i_flags = 0;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 9ca0fda28928..5b52306e2e95 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -762,7 +762,7 @@ extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 /* ioctl.c */
 extern int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-extern int ext2_fileattr_set(struct user_namespace *mnt_userns,
+extern int ext2_fileattr_set(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct fileattr *fa);
 extern long ext2_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext2_compat_ioctl(struct file *, unsigned int, unsigned long);
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index e8340bf09b10..dbd7de812cc1 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -27,7 +27,7 @@ int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int ext2_fileattr_set(struct user_namespace *mnt_userns,
+int ext2_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b5e325434c5a..8d5008754cc2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3024,7 +3024,7 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 /* ioctl.c */
 extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
-int ext4_fileattr_set(struct user_namespace *mnt_userns,
+int ext4_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
 int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 extern void ext4_reset_inode_seed(struct inode *inode);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 8067ccda34e4..f49496087102 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -979,7 +979,7 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int ext4_fileattr_set(struct user_namespace *mnt_userns,
+int ext4_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d6b13b03d75f..cf0217d36402 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3477,7 +3477,7 @@ int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
 int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int f2fs_fileattr_set(struct user_namespace *mnt_userns,
+int f2fs_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a5e936a6225a..96dd5cb2f49c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3092,7 +3092,7 @@ int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int f2fs_fileattr_set(struct user_namespace *mnt_userns,
+int f2fs_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 570941be0fd0..ee084cead402 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1309,7 +1309,7 @@ long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg);
 int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int fuse_fileattr_set(struct user_namespace *mnt_userns,
+int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
 
 /* file.c */
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fcce94ace2c2..e50a18ee6cc6 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -467,7 +467,7 @@ int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return err;
 }
 
-int fuse_fileattr_set(struct user_namespace *mnt_userns,
+int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index eea5be4fbf0e..62d6316e8066 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -273,7 +273,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	return error;
 }
 
-int gfs2_fileattr_set(struct user_namespace *mnt_userns,
+int gfs2_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 0264d514dda7..bd0c64b65158 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -111,7 +111,7 @@ extern const struct file_operations gfs2_file_fops_nolock;
 extern const struct file_operations gfs2_dir_fops_nolock;
 
 extern int gfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-extern int gfs2_fileattr_set(struct user_namespace *mnt_userns,
+extern int gfs2_fileattr_set(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct fileattr *fa);
 extern void gfs2_set_inode_flags(struct inode *inode);
  
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index d5f3ce0f8dad..7ededcb720c1 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -487,7 +487,7 @@ int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 		       int datasync);
 int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int hfsplus_fileattr_set(struct user_namespace *mnt_userns,
+int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct fileattr *fa);
 
 /* ioctl.c */
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index ff98c1250d7c..c9ce69728a53 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -655,7 +655,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int hfsplus_fileattr_set(struct user_namespace *mnt_userns,
+int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 80ac36aea913..2bf1bdaec2ee 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -651,7 +651,7 @@ static int fileattr_set_prepare(struct inode *inode,
 
 /**
  * vfs_fileattr_set - change miscellaneous file attributes
- * @mnt_userns:	user namespace of the mount
+ * @idmap:	idmap of the mount
  * @dentry:	the object to change
  * @fa:		fileattr pointer
  *
@@ -665,7 +665,7 @@ static int fileattr_set_prepare(struct inode *inode,
  *
  * Return: 0 on success, or a negative error on failure.
  */
-int vfs_fileattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
@@ -675,7 +675,7 @@ int vfs_fileattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!inode->i_op->fileattr_set)
 		return -ENOIOCTLCMD;
 
-	if (!inode_owner_or_capable(mnt_userns, inode))
+	if (!inode_owner_or_capable(mnt_idmap_owner(idmap), inode))
 		return -EPERM;
 
 	inode_lock(inode);
@@ -693,7 +693,7 @@ int vfs_fileattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 		err = fileattr_set_prepare(inode, &old_ma, fa);
 		if (!err)
-			err = inode->i_op->fileattr_set(mnt_userns, dentry, fa);
+			err = inode->i_op->fileattr_set(idmap, dentry, fa);
 	}
 	inode_unlock(inode);
 
@@ -714,7 +714,7 @@ static int ioctl_getflags(struct file *file, unsigned int __user *argp)
 
 static int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
-	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct fileattr fa;
 	unsigned int flags;
@@ -725,7 +725,7 @@ static int ioctl_setflags(struct file *file, unsigned int __user *argp)
 		err = mnt_want_write_file(file);
 		if (!err) {
 			fileattr_fill_flags(&fa, flags);
-			err = vfs_fileattr_set(mnt_userns, dentry, &fa);
+			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
 		}
 	}
@@ -746,7 +746,7 @@ static int ioctl_fsgetxattr(struct file *file, void __user *argp)
 
 static int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
-	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct fileattr fa;
 	int err;
@@ -755,7 +755,7 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
 	if (!err) {
 		err = mnt_want_write_file(file);
 		if (!err) {
-			err = vfs_fileattr_set(mnt_userns, dentry, &fa);
+			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
 		}
 	}
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index 1e7b177ece60..ed7989bc2db1 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -70,7 +70,7 @@ int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int jfs_fileattr_set(struct user_namespace *mnt_userns,
+int jfs_fileattr_set(struct mnt_idmap *idmap,
 		     struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/jfs/jfs_inode.h b/fs/jfs/jfs_inode.h
index 6440935a9895..ea80661597ac 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -10,7 +10,7 @@ struct fid;
 extern struct inode *ialloc(struct inode *, umode_t);
 extern int jfs_fsync(struct file *, loff_t, loff_t, int);
 extern int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-extern int jfs_fileattr_set(struct user_namespace *mnt_userns,
+extern int jfs_fileattr_set(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 extern long jfs_ioctl(struct file *, unsigned int, unsigned long);
 extern struct inode *jfs_iget(struct super_block *, unsigned long);
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 87e1004b606d..91994b9955b5 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -128,7 +128,7 @@ int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 /**
  * nilfs_fileattr_set - ioctl to support chattr
  */
-int nilfs_fileattr_set(struct user_namespace *mnt_userns,
+int nilfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 7bac8e515ace..ff8ddc86ca08 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -242,7 +242,7 @@ extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
 /* ioctl.c */
 int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *m);
-int nilfs_fileattr_set(struct user_namespace *mnt_userns,
+int nilfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 long nilfs_ioctl(struct file *, unsigned int, unsigned long);
 long nilfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index afd54ec66103..811a6ea374bb 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -82,7 +82,7 @@ int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return status;
 }
 
-int ocfs2_fileattr_set(struct user_namespace *mnt_userns,
+int ocfs2_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/ocfs2/ioctl.h b/fs/ocfs2/ioctl.h
index 0297c8846945..48a5fdfe87a1 100644
--- a/fs/ocfs2/ioctl.h
+++ b/fs/ocfs2/ioctl.h
@@ -12,7 +12,7 @@
 #define OCFS2_IOCTL_PROTO_H
 
 int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int ocfs2_fileattr_set(struct user_namespace *mnt_userns,
+int ocfs2_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 1e41eeee18e1..328e49857242 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -944,7 +944,7 @@ static int orangefs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-static int orangefs_fileattr_set(struct user_namespace *mnt_userns,
+static int orangefs_fileattr_set(struct mnt_idmap *idmap,
 				 struct dentry *dentry, struct fileattr *fa)
 {
 	u64 val = 0;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index f52d9304d7e4..a41a03fcf6bc 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -757,10 +757,10 @@ int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa)
 	if (err)
 		return err;
 
-	return vfs_fileattr_set(mnt_user_ns(realpath->mnt), realpath->dentry, fa);
+	return vfs_fileattr_set(mnt_idmap(realpath->mnt), realpath->dentry, fa);
 }
 
-int ovl_fileattr_set(struct user_namespace *mnt_userns,
+int ovl_fileattr_set(struct mnt_idmap *idmap,
 		     struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0f2ac8402f10..8091b1914ea3 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -718,7 +718,7 @@ void ovl_aio_request_cache_destroy(void);
 int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa);
 int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa);
 int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int ovl_fileattr_set(struct user_namespace *mnt_userns,
+int ovl_fileattr_set(struct mnt_idmap *idmap,
 		     struct dentry *dentry, struct fileattr *fa);
 
 /* copy_up.c */
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index 4b86ecf5817e..12800dfc11a9 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -24,7 +24,7 @@ int reiserfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int reiserfs_fileattr_set(struct user_namespace *mnt_userns,
+int reiserfs_fileattr_set(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 9a4a7f7897fe..98e6f53c2fe0 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3407,7 +3407,7 @@ __u32 r5_hash(const signed char *msg, int len);
 
 /* prototypes from ioctl.c */
 int reiserfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int reiserfs_fileattr_set(struct user_namespace *mnt_userns,
+int reiserfs_fileattr_set(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct fileattr *fa);
 long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long reiserfs_compat_ioctl(struct file *filp,
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 71bcebe45f9c..67c5108abd89 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -144,7 +144,7 @@ int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-int ubifs_fileattr_set(struct user_namespace *mnt_userns,
+int ubifs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 1d2fdef6dfa0..9063b73536f8 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2085,7 +2085,7 @@ void ubifs_destroy_size_tree(struct ubifs_info *c);
 
 /* ioctl.c */
 int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int ubifs_fileattr_set(struct user_namespace *mnt_userns,
+int ubifs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 void ubifs_set_inode_flags(struct inode *inode);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 13f1b2add390..27c7876ff526 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1297,10 +1297,11 @@ xfs_ioctl_setattr_check_projid(
 
 int
 xfs_fileattr_set(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
 	struct fileattr		*fa)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
diff --git a/fs/xfs/xfs_ioctl.h b/fs/xfs/xfs_ioctl.h
index d4abba2c13c1..38be600b5e1e 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -49,7 +49,7 @@ xfs_fileattr_get(
 
 extern int
 xfs_fileattr_set(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
 	struct fileattr		*fa);
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 9e37e063ac69..47c05a9851d0 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -53,7 +53,7 @@ static inline bool fileattr_has_fsx(const struct fileattr *fa)
 }
 
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int vfs_fileattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct fileattr *fa);
 
 #endif /* _LINUX_FILEATTR_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 85d8e4bc7798..349f71650fa2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2168,7 +2168,7 @@ struct inode_operations {
 				     int);
 	int (*set_acl)(struct mnt_idmap *, struct dentry *,
 		       struct posix_acl *, int);
-	int (*fileattr_set)(struct user_namespace *mnt_userns,
+	int (*fileattr_set)(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 } ____cacheline_aligned;
diff --git a/mm/shmem.c b/mm/shmem.c
index ad768241147c..d2f27ddd481e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3229,7 +3229,7 @@ static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	return 0;
 }
 
-static int shmem_fileattr_set(struct user_namespace *mnt_userns,
+static int shmem_fileattr_set(struct mnt_idmap *idmap,
 			      struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);

-- 
2.34.1

