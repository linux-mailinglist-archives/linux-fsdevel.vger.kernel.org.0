Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3FD669619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbjAMLw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241401AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5510C3D5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C48FC61557
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05093C433F0;
        Fri, 13 Jan 2023 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610592;
        bh=NA9ISE7iTRzEMfo9Znfse/RAro9pg9mucUWN2U9eJ0M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aqVNlgW53dA6Ef5cGBZbUMYp9L5nVbEUm+7P56usVL8tLD23Ukb6eDeYZcVMa/liF
         IwXG0zFZ3XsDMItbupNQvoObFd0r+oCTrLL4xf5xeh3cWV0taKsVXPL45gY00KA2jA
         +n0GMor06T1bez/QfAbE8xflzpF7n2kLfJy1l8nnuJzeqCMNmRy9yK4HgsWp3M+iY7
         fcWbQgfsaBvuA6bUGzCw7O4vpGGkaMHhcpFDgRt9c//yY/dPPdoEULfzvlMU9jYPoI
         ADaaVEXqDF04VNSCNm0+buR5UAspYvpf3Hsmj4lT0bd9wAX2b5ctCxbBFwoX9ORR3S
         sFLIEN5aytNXg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:14 +0100
Subject: [PATCH 06/25] fs: port ->symlink() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-6-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=31595; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NA9ISE7iTRzEMfo9Znfse/RAro9pg9mucUWN2U9eJ0M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA16dn9exUOpvWcfpgs/uK8qWT3hkG1pq/+h7fHKinN6
 vW0fdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykfA3D/9AHKnqL+GVs9x7yOmsnmN
 Yq3F3N+vXFlUM8TExZi4MNDBkZfvxXfr9x9jRdw9rZMvIOq74KnFPpm8vsnKDIHfkh9u4KJgA=
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
 fs/9p/vfs_inode_dotl.c                | 2 +-
 fs/affs/affs.h                        | 2 +-
 fs/affs/namei.c                       | 2 +-
 fs/afs/dir.c                          | 4 ++--
 fs/autofs/root.c                      | 4 ++--
 fs/bad_inode.c                        | 2 +-
 fs/btrfs/inode.c                      | 3 ++-
 fs/ceph/dir.c                         | 2 +-
 fs/cifs/cifsfs.h                      | 2 +-
 fs/cifs/link.c                        | 2 +-
 fs/coda/dir.c                         | 2 +-
 fs/configfs/configfs_internal.h       | 2 +-
 fs/configfs/symlink.c                 | 2 +-
 fs/ecryptfs/inode.c                   | 2 +-
 fs/ext2/namei.c                       | 2 +-
 fs/ext4/namei.c                       | 3 ++-
 fs/f2fs/namei.c                       | 3 ++-
 fs/fuse/dir.c                         | 2 +-
 fs/gfs2/inode.c                       | 4 ++--
 fs/hfsplus/dir.c                      | 2 +-
 fs/hostfs/hostfs_kern.c               | 2 +-
 fs/hpfs/namei.c                       | 2 +-
 fs/hugetlbfs/inode.c                  | 2 +-
 fs/jffs2/dir.c                        | 4 ++--
 fs/jfs/namei.c                        | 2 +-
 fs/minix/namei.c                      | 2 +-
 fs/namei.c                            | 5 +++--
 fs/nfs/dir.c                          | 2 +-
 fs/nfs/internal.h                     | 2 +-
 fs/nilfs2/namei.c                     | 2 +-
 fs/ntfs3/namei.c                      | 3 ++-
 fs/ocfs2/namei.c                      | 2 +-
 fs/orangefs/namei.c                   | 2 +-
 fs/overlayfs/dir.c                    | 2 +-
 fs/ramfs/inode.c                      | 2 +-
 fs/reiserfs/namei.c                   | 2 +-
 fs/sysv/namei.c                       | 2 +-
 fs/ubifs/dir.c                        | 2 +-
 fs/udf/namei.c                        | 2 +-
 fs/ufs/namei.c                        | 2 +-
 fs/vboxsf/dir.c                       | 2 +-
 fs/xfs/xfs_iops.c                     | 3 ++-
 include/linux/fs.h                    | 2 +-
 kernel/bpf/inode.c                    | 2 +-
 mm/shmem.c                            | 2 +-
 48 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 77830854ec67..2e656b651574 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -60,7 +60,7 @@ prototypes::
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct inode *,struct dentry *,const char *);
+	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
 	int (*mkdir) (struct inode *,struct dentry *,umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
 	int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6cf8d7d239b0..5a1195cf34ba 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -425,7 +425,7 @@ As of kernel 2.6.22, the following members are defined:
 		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
-		int (*symlink) (struct user_namespace *, struct inode *,struct dentry *,const char *);
+		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
 		int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,umode_t);
 		int (*rmdir) (struct inode *,struct dentry *);
 		int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,umode_t,dev_t);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 693afb66c0c1..401c0b63d5bb 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1300,7 +1300,7 @@ static int v9fs_vfs_mkspecial(struct inode *dir, struct dentry *dentry,
 
 /**
  * v9fs_vfs_symlink - helper function to create symlinks
- * @mnt_userns: The user namespace of the mount
+ * @idmap: idmap of the mount
  * @dir: directory inode containing symlink
  * @dentry: dentry for symlink
  * @symname: symlink data
@@ -1310,7 +1310,7 @@ static int v9fs_vfs_mkspecial(struct inode *dir, struct dentry *dentry,
  */
 
 static int
-v9fs_vfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+v9fs_vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		 struct dentry *dentry, const char *symname)
 {
 	p9_debug(P9_DEBUG_VFS, " %lu,%pd,%s\n",
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 6f651d5757a5..d3245221ddd4 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -688,7 +688,7 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 }
 
 static int
-v9fs_vfs_symlink_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, const char *symname)
 {
 	int err;
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 31a56a461c9f..f9f986a2c509 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -174,7 +174,7 @@ extern int	affs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
 extern int	affs_link(struct dentry *olddentry, struct inode *dir,
 			  struct dentry *dentry);
-extern int	affs_symlink(struct user_namespace *mnt_userns,
+extern int	affs_symlink(struct mnt_idmap *idmap,
 			struct inode *dir, struct dentry *dentry,
 			const char *symname);
 extern int	affs_rename2(struct user_namespace *mnt_userns,
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 661852c95c5a..1d7f7232964d 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -313,7 +313,7 @@ affs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 int
-affs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+affs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	     struct dentry *dentry, const char *symname)
 {
 	struct super_block	*sb = dir->i_sb;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a70495fd0886..a936aa8191b2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -36,7 +36,7 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry);
 static int afs_unlink(struct inode *dir, struct dentry *dentry);
 static int afs_link(struct dentry *from, struct inode *dir,
 		    struct dentry *dentry);
-static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *content);
 static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
@@ -1760,7 +1760,7 @@ static const struct afs_operation_ops afs_symlink_operation = {
 /*
  * create a symlink in an AFS filesystem
  */
-static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *content)
 {
 	struct afs_operation *op;
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index ca03c1cae2be..bf0029cef304 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -11,7 +11,7 @@
 #include "autofs_i.h"
 
 static int autofs_dir_permission(struct user_namespace *, struct inode *, int);
-static int autofs_dir_symlink(struct user_namespace *, struct inode *,
+static int autofs_dir_symlink(struct mnt_idmap *, struct inode *,
 			      struct dentry *, const char *);
 static int autofs_dir_unlink(struct inode *, struct dentry *);
 static int autofs_dir_rmdir(struct inode *, struct dentry *);
@@ -563,7 +563,7 @@ static int autofs_dir_permission(struct user_namespace *mnt_userns,
 	return generic_permission(mnt_userns, inode, mask);
 }
 
-static int autofs_dir_symlink(struct user_namespace *mnt_userns,
+static int autofs_dir_symlink(struct mnt_idmap *idmap,
 			      struct inode *dir, struct dentry *dentry,
 			      const char *symname)
 {
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 8712fc1b3ff1..2d3ca4b5628f 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -51,7 +51,7 @@ static int bad_inode_unlink(struct inode *dir, struct dentry *dentry)
 	return -EIO;
 }
 
-static int bad_inode_symlink(struct user_namespace *mnt_userns,
+static int bad_inode_symlink(struct mnt_idmap *idmap,
 			     struct inode *dir, struct dentry *dentry,
 			     const char *symname)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3621e9a131d1..f4879dd92035 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9758,9 +9758,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 	return ret;
 }
 
-static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index cf4f70e558de..114375efa2f7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -912,7 +912,7 @@ static int ceph_create(struct mnt_idmap *idmap, struct inode *dir,
 	return ceph_mknod(mnt_userns, dir, dentry, mode, 0);
 }
 
-static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *dest)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 0d4b3bfa1c3a..52256b751c75 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -124,7 +124,7 @@ extern struct vfsmount *cifs_dfs_d_automount(struct path *path);
 /* Functions related to symlinks */
 extern const char *cifs_get_link(struct dentry *, struct inode *,
 			struct delayed_call *);
-extern int cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
+extern int cifs_symlink(struct mnt_idmap *idmap, struct inode *inode,
 			struct dentry *direntry, const char *symname);
 
 #ifdef CONFIG_CIFS_XATTR
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index bd374feeccaa..0ff9eab697a2 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -568,7 +568,7 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 }
 
 int
-cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
+cifs_symlink(struct mnt_idmap *idmap, struct inode *inode,
 	     struct dentry *direntry, const char *symname)
 {
 	int rc = -EOPNOTSUPP;
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 480bca167928..b8e82bc0071f 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -228,7 +228,7 @@ static int coda_link(struct dentry *source_de, struct inode *dir_inode,
 }
 
 
-static int coda_symlink(struct user_namespace *mnt_userns,
+static int coda_symlink(struct mnt_idmap *idmap,
 			struct inode *dir_inode, struct dentry *de,
 			const char *symname)
 {
diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index a94493ed3146..e710a1782382 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -91,7 +91,7 @@ extern const struct inode_operations configfs_root_inode_operations;
 extern const struct inode_operations configfs_symlink_inode_operations;
 extern const struct dentry_operations configfs_dentry_ops;
 
-extern int configfs_symlink(struct user_namespace *mnt_userns,
+extern int configfs_symlink(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    const char *symname);
 extern int configfs_unlink(struct inode *dir, struct dentry *dentry);
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 0623c3edcfb9..91db306dfeec 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -137,7 +137,7 @@ static int get_target(const char *symname, struct path *path,
 }
 
 
-int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, const char *symname)
 {
 	int ret;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index afc49ab46c5f..692320ee079d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -456,7 +456,7 @@ static int ecryptfs_unlink(struct inode *dir, struct dentry *dentry)
 	return ecryptfs_do_unlink(dir, dentry, d_inode(dentry));
 }
 
-static int ecryptfs_symlink(struct user_namespace *mnt_userns,
+static int ecryptfs_symlink(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    const char *symname)
 {
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 1d4d807e0934..72d9a3111001 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -154,7 +154,7 @@ static int ext2_mknod (struct user_namespace * mnt_userns, struct inode * dir,
 	return err;
 }
 
-static int ext2_symlink (struct user_namespace * mnt_userns, struct inode * dir,
+static int ext2_symlink (struct mnt_idmap * idmap, struct inode * dir,
 	struct dentry * dentry, const char * symname)
 {
 	struct super_block * sb = dir->i_sb;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0bb43e4a28d5..11d9c1d1fc56 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3340,9 +3340,10 @@ static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
 	return err;
 }
 
-static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, len = strlen(symname);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index aacf4e2764d2..5ef5ed50ce80 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -660,9 +660,10 @@ static const char *f2fs_get_link(struct dentry *dentry,
 	return link;
 }
 
-static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	size_t len = strlen(symname);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b74824686229..179d8a33e13e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -841,7 +841,7 @@ static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
 }
 
-static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *entry, const char *link)
 {
 	struct fuse_mount *fm = get_fuse_mount(dir);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f58b13a2d895..830049759b07 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1207,7 +1207,7 @@ static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
 
 /**
  * gfs2_symlink - Create a symlink
- * @mnt_userns: User namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @dir: The directory to create the symlink in
  * @dentry: The dentry to put the symlink in
  * @symname: The thing which the link points to
@@ -1215,7 +1215,7 @@ static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
  * Returns: errno
  */
 
-static int gfs2_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int gfs2_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
 	unsigned int size;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 2ce051fb2d14..36927ca6b1f5 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -434,7 +434,7 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 	return res;
 }
 
-static int hfsplus_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int hfsplus_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, const char *symname)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index d6174206a123..e78f53e60dcd 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -658,7 +658,7 @@ static int hostfs_unlink(struct inode *ino, struct dentry *dentry)
 	return err;
 }
 
-static int hostfs_symlink(struct user_namespace *mnt_userns, struct inode *ino,
+static int hostfs_symlink(struct mnt_idmap *idmap, struct inode *ino,
 			  struct dentry *dentry, const char *to)
 {
 	char *file;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index f6cbd4a4b94d..c5f0aec11457 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -292,7 +292,7 @@ static int hpfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int hpfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int hpfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symlink)
 {
 	const unsigned char *name = dentry->d_name.name;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7ffcf4b18685..170c99cb3095 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1064,7 +1064,7 @@ static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
 	return finish_open_simple(file, 0);
 }
 
-static int hugetlbfs_symlink(struct user_namespace *mnt_userns,
+static int hugetlbfs_symlink(struct mnt_idmap *idmap,
 			     struct inode *dir, struct dentry *dentry,
 			     const char *symname)
 {
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 7494563f04fa..51433fef9d2b 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -30,7 +30,7 @@ static struct dentry *jffs2_lookup (struct inode *,struct dentry *,
 				    unsigned int);
 static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
 static int jffs2_unlink (struct inode *,struct dentry *);
-static int jffs2_symlink (struct user_namespace *, struct inode *,
+static int jffs2_symlink (struct mnt_idmap *, struct inode *,
 			  struct dentry *, const char *);
 static int jffs2_mkdir (struct user_namespace *, struct inode *,struct dentry *,
 			umode_t);
@@ -279,7 +279,7 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 
 /***********************************************************************/
 
-static int jffs2_symlink (struct user_namespace *mnt_userns, struct inode *dir_i,
+static int jffs2_symlink (struct mnt_idmap *idmap, struct inode *dir_i,
 			  struct dentry *dentry, const char *target)
 {
 	struct jffs2_inode_info *f, *dir_f;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 9d06479e549e..e7d65581db75 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -869,7 +869,7 @@ static int jfs_link(struct dentry *old_dentry,
  * an intermediate result whose length exceeds PATH_MAX [XPG4.2]
 */
 
-static int jfs_symlink(struct user_namespace *mnt_userns, struct inode *dip,
+static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 		       struct dentry *dentry, const char *name)
 {
 	int rc;
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index b8621cf9c933..0a07410a1a27 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -71,7 +71,7 @@ static int minix_create(struct mnt_idmap *idmap, struct inode *dir,
 	return minix_mknod(&init_user_ns, dir, dentry, mode, 0);
 }
 
-static int minix_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int minix_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
 	int err = -ENAMETOOLONG;
diff --git a/fs/namei.c b/fs/namei.c
index f356719c2413..24ad4a8963df 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4394,8 +4394,9 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, const char *oldname)
 {
 	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	int error = may_create(mnt_userns, dir, dentry);
+	int error;
 
+	error = may_create(mnt_userns, dir, dentry);
 	if (error)
 		return error;
 
@@ -4406,7 +4407,7 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	error = dir->i_op->symlink(mnt_userns, dir, dentry, oldname);
+	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a54337c181fe..5ae3ed47c388 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2524,7 +2524,7 @@ EXPORT_SYMBOL_GPL(nfs_unlink);
  * now have a new file handle and can instantiate an in-core NFS inode
  * and move the raw page into its mapping.
  */
-int nfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, const char *symname)
 {
 	struct page *page;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 988a1553286f..33ec2c2a52de 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -390,7 +390,7 @@ int nfs_mkdir(struct user_namespace *, struct inode *, struct dentry *,
 	      umode_t);
 int nfs_rmdir(struct inode *, struct dentry *);
 int nfs_unlink(struct inode *, struct dentry *);
-int nfs_symlink(struct user_namespace *, struct inode *, struct dentry *,
+int nfs_symlink(struct mnt_idmap *, struct inode *, struct dentry *,
 		const char *);
 int nfs_link(struct dentry *, struct inode *, struct dentry *);
 int nfs_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t,
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 4be5d9d34003..d6cd71bb91e0 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -125,7 +125,7 @@ nilfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int nilfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int nilfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
 	struct nilfs_transaction_info ti;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 8e46372a7ab7..be6a00a07004 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -184,9 +184,10 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 /*
  * ntfs_symlink - inode_operations::symlink
  */
-static int ntfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	u32 size = strlen(symname);
 	struct inode *inode;
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c931ddb41e94..dedb37a88345 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1784,7 +1784,7 @@ static int ocfs2_create_symlink_data(struct ocfs2_super *osb,
 	return status;
 }
 
-static int ocfs2_symlink(struct user_namespace *mnt_userns,
+static int ocfs2_symlink(struct mnt_idmap *idmap,
 			 struct inode *dir,
 			 struct dentry *dentry,
 			 const char *symname)
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index a47e73f564e4..59866be48329 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -216,7 +216,7 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
-static int orangefs_symlink(struct user_namespace *mnt_userns,
+static int orangefs_symlink(struct mnt_idmap *idmap,
 		         struct inode *dir,
 			 struct dentry *dentry,
 			 const char *symname)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fc3726586722..272906ec9512 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -677,7 +677,7 @@ static int ovl_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return ovl_create_object(dentry, mode, rdev, NULL);
 }
 
-static int ovl_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int ovl_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *link)
 {
 	return ovl_create_object(dentry, S_IFLNK, 0, link);
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 77fd43f847ab..f97b8856cebf 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -125,7 +125,7 @@ static int ramfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	return ramfs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
 }
 
-static int ramfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
 	struct inode *inode;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index c1b91a965640..062e05f1b961 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1099,7 +1099,7 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-static int reiserfs_symlink(struct user_namespace *mnt_userns,
+static int reiserfs_symlink(struct mnt_idmap *idmap,
 			    struct inode *parent_dir, struct dentry *dentry,
 			    const char *symname)
 {
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index f862fb8584c0..c277c0a8f6b2 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -67,7 +67,7 @@ static int sysv_create(struct mnt_idmap *idmap, struct inode *dir,
 	return sysv_mknod(&init_user_ns, dir, dentry, mode, 0);
 }
 
-static int sysv_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int sysv_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
 	int err = -ENAMETOOLONG;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 43a1d9c0e9e0..325c5693fb5f 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1141,7 +1141,7 @@ static int ubifs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int ubifs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
 	struct inode *inode;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 91921a3838fa..f2c3ee7ebe1b 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -881,7 +881,7 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int udf_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *symname)
 {
 	struct inode *inode = udf_new_inode(dir, S_IFLNK | 0777);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 6904ce95a143..cb3d9bee6626 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -106,7 +106,7 @@ static int ufs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int ufs_symlink (struct user_namespace * mnt_userns, struct inode * dir,
+static int ufs_symlink (struct mnt_idmap * idmap, struct inode * dir,
 	struct dentry * dentry, const char * symname)
 {
 	struct super_block * sb = dir->i_sb;
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 0a9e76c87066..95d54cb5221d 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -430,7 +430,7 @@ static int vboxsf_dir_rename(struct user_namespace *mnt_userns,
 	return err;
 }
 
-static int vboxsf_dir_symlink(struct user_namespace *mnt_userns,
+static int vboxsf_dir_symlink(struct mnt_idmap *idmap,
 			      struct inode *parent, struct dentry *dentry,
 			      const char *symname)
 {
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 969074864328..4f9fcd0cf8ba 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -401,11 +401,12 @@ xfs_vn_unlink(
 
 STATIC int
 xfs_vn_symlink(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct dentry		*dentry,
 	const char		*symname)
 {
+	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct inode	*inode;
 	struct xfs_inode *cip = NULL;
 	struct xfs_name	name;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fddfacf2583a..4bde68e15d5c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2143,7 +2143,7 @@ struct inode_operations {
 		       umode_t, bool);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct user_namespace *, struct inode *,struct dentry *,
+	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
 			const char *);
 	int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,
 		      umode_t);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4f841e16779e..32c8f695e0b5 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -382,7 +382,7 @@ bpf_lookup(struct inode *dir, struct dentry *dentry, unsigned flags)
 	return simple_lookup(dir, dentry, flags);
 }
 
-static int bpf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int bpf_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *target)
 {
 	char *link = kstrdup(target, GFP_USER | __GFP_NOWARN);
diff --git a/mm/shmem.c b/mm/shmem.c
index 8c2969494bc5..38b973f116d8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3124,7 +3124,7 @@ static int shmem_rename2(struct user_namespace *mnt_userns,
 	return 0;
 }
 
-static int shmem_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
 	int error;

-- 
2.34.1

