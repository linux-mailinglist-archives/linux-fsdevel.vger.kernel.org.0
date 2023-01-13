Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40E6695F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbjAMLwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbjAMLwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7ACE0B0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A446155D
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531CAC433F1;
        Fri, 13 Jan 2023 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610590;
        bh=W0h1VlKCU6TOT77/n4atXrXuqkwnGSMEERgCUW2xXFw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=crj7cez9tEjrJTmeHYczMrMuPkY2AZIYahynbV/M5jor2vbT9C5KQ0tp5+BEZAKbX
         ZKb3fa4Xt7NUgQ/5TKCd0Cqh52X3ycOJyHe/WUHkTITM5HOOEcCj2Y3rgIwpw/hZW/
         zwcDrzQckscU1wQRFHe5XiLPee0NJya5OJgD8ghc/gcaFBRO7WlIjjtSds7RdaBpeI
         kuugsNfU0HUZZ31Q35p6vZwL3frJXssQvliNyWeo46I6nG4GQUdq9AWsG+Y+rS5kK4
         4jmBBFJmDzxO3GtJDM3QFTGM6EUaj/ozVXjgNcVfBEQmFY/V6gh+5aPM85B/wiJVbI
         f36N/PYQ4VXYA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:13 +0100
Subject: [PATCH 05/25] fs: port ->create() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-5-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=35774; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W0h1VlKCU6TOT77/n4atXrXuqkwnGSMEERgCUW2xXFw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA1S2b6D53amhHGncujc9wUdDBN2xqU+Z4lZWGG5LrWo
 it2po5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIvihgZtnRI1fxdV63XdvUjx+pZDl
 Fyh5zb9er+ifEyHV1ZEmvpw/Df+UkNX0+P1IIXVucYWxz3+bw/d75iQ2pRYCGT3OSTWsuZAA==
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
 fs/9p/vfs_inode_dotl.c                | 5 +++--
 fs/affs/affs.h                        | 2 +-
 fs/affs/namei.c                       | 2 +-
 fs/afs/dir.c                          | 4 ++--
 fs/bad_inode.c                        | 2 +-
 fs/bfs/dir.c                          | 2 +-
 fs/btrfs/inode.c                      | 3 ++-
 fs/ceph/dir.c                         | 3 ++-
 fs/cifs/cifsfs.h                      | 2 +-
 fs/cifs/dir.c                         | 2 +-
 fs/coda/dir.c                         | 2 +-
 fs/ecryptfs/inode.c                   | 2 +-
 fs/efivarfs/inode.c                   | 2 +-
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
 fs/minix/namei.c                      | 4 ++--
 fs/namei.c                            | 8 +++++---
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
 fs/ubifs/dir.c                        | 2 +-
 fs/udf/namei.c                        | 2 +-
 fs/ufs/namei.c                        | 2 +-
 fs/vboxsf/dir.c                       | 2 +-
 fs/xfs/xfs_iops.c                     | 3 ++-
 include/linux/fs.h                    | 2 +-
 ipc/mqueue.c                          | 2 +-
 mm/shmem.c                            | 2 +-
 54 files changed, 71 insertions(+), 62 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 556a23af1edf..77830854ec67 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -56,7 +56,7 @@ inode_operations
 
 prototypes::
 
-	int (*create) (struct inode *,struct dentry *,umode_t, bool);
+	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, bool);
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 09184d98fc8c..6cf8d7d239b0 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -421,7 +421,7 @@ As of kernel 2.6.22, the following members are defined:
 .. code-block:: c
 
 	struct inode_operations {
-		int (*create) (struct user_namespace *, struct inode *,struct dentry *, umode_t, bool);
+		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t, bool);
 		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ee47b2bb3712..693afb66c0c1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -672,7 +672,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 
 /**
  * v9fs_vfs_create - VFS hook to create a regular file
- * @mnt_userns: The user namespace of the mount
+ * @idmap: idmap of the mount
  * @dir: The parent directory
  * @dentry: The name of file to be created
  * @mode: The UNIX file mode to set
@@ -684,7 +684,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
  */
 
 static int
-v9fs_vfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 08ec5e7b628d..6f651d5757a5 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -211,7 +211,7 @@ int v9fs_open_to_dotl_flags(int flags)
 
 /**
  * v9fs_vfs_create_dotl - VFS hook to create files for 9P2000.L protocol.
- * @mnt_userns: The user namespace of the mount
+ * @idmap: The user namespace of the mount
  * @dir: directory inode that is being created
  * @dentry:  dentry that is being deleted
  * @omode: create permissions
@@ -219,9 +219,10 @@ int v9fs_open_to_dotl_flags(int flags)
  *
  */
 static int
-v9fs_vfs_create_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+v9fs_vfs_create_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t omode, bool excl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return v9fs_vfs_mknod_dotl(mnt_userns, dir, dentry, omode, 0);
 }
 
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 8c98e2644a5e..31a56a461c9f 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -167,7 +167,7 @@ extern const struct export_operations affs_export_ops;
 extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len);
 extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, unsigned int);
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
-extern int	affs_create(struct user_namespace *mnt_userns, struct inode *dir,
+extern int	affs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool);
 extern int	affs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 			struct dentry *dentry, umode_t mode);
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index bcab18956b4f..661852c95c5a 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -242,7 +242,7 @@ affs_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 int
-affs_create(struct user_namespace *mnt_userns, struct inode *dir,
+affs_create(struct mnt_idmap *idmap, struct inode *dir,
 	    struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b7c1f8c84b38..a70495fd0886 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -28,7 +28,7 @@ static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name, in
 				  loff_t fpos, u64 ino, unsigned dtype);
 static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
 			      loff_t fpos, u64 ino, unsigned dtype);
-static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl);
 static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, umode_t mode);
@@ -1630,7 +1630,7 @@ static const struct afs_operation_ops afs_create_operation = {
 /*
  * create a regular file on an AFS filesystem
  */
-static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct afs_operation *op;
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 63006ca5b581..8712fc1b3ff1 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -27,7 +27,7 @@ static const struct file_operations bad_file_ops =
 	.open		= bad_file_open,
 };
 
-static int bad_inode_create(struct user_namespace *mnt_userns,
+static int bad_inode_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    umode_t mode, bool excl)
 {
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index 34d4f68f786b..f9d4ce5fff9f 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -75,7 +75,7 @@ const struct file_operations bfs_dir_operations = {
 	.llseek		= generic_file_llseek,
 };
 
-static int bfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	int err;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8ba37e4c36fe..3621e9a131d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6739,9 +6739,10 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return btrfs_create_common(dir, dentry, inode);
 }
 
-static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int btrfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6c7026cc8988..cf4f70e558de 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -905,9 +905,10 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int ceph_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int ceph_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return ceph_mknod(mnt_userns, dir, dentry, mode, 0);
 }
 
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 6c42137f9499..0d4b3bfa1c3a 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -49,7 +49,7 @@ extern void cifs_sb_deactive(struct super_block *sb);
 /* Functions related to inodes */
 extern const struct inode_operations cifs_dir_inode_ops;
 extern struct inode *cifs_root_iget(struct super_block *);
-extern int cifs_create(struct user_namespace *, struct inode *,
+extern int cifs_create(struct mnt_idmap *, struct inode *,
 		       struct dentry *, umode_t, bool excl);
 extern int cifs_atomic_open(struct inode *, struct dentry *,
 			    struct file *, unsigned, umode_t);
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index ad4208bf1e32..bc78af260fc9 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -529,7 +529,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	return rc;
 }
 
-int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
+int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
 		struct dentry *direntry, umode_t mode, bool excl)
 {
 	int rc;
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 328d7a684b63..480bca167928 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -133,7 +133,7 @@ static inline void coda_dir_drop_nlink(struct inode *dir)
 }
 
 /* creation routines: create, mknod, mkdir, link, symlink */
-static int coda_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int coda_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *de, umode_t mode, bool excl)
 {
 	int error;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 7854b71c769f..afc49ab46c5f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -253,7 +253,7 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
  * Returns zero on success; non-zero on error condition
  */
 static int
-ecryptfs_create(struct user_namespace *mnt_userns,
+ecryptfs_create(struct mnt_idmap *idmap,
 		struct inode *directory_inode, struct dentry *ecryptfs_dentry,
 		umode_t mode, bool excl)
 {
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 617f3ad2485e..80369872815f 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -70,7 +70,7 @@ bool efivarfs_valid_name(const char *str, int len)
 	return uuid_is_valid(s);
 }
 
-static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode = NULL;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 5f995eba5dbb..f40cc11016ad 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -551,7 +551,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	return ret;
 }
 
-static int exfat_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index c056957221a2..1d4d807e0934 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -99,7 +99,7 @@ struct dentry *ext2_get_parent(struct dentry *child)
  * If the create succeeds, we fill in the inode information
  * with d_instantiate(). 
  */
-static int ext2_create (struct user_namespace * mnt_userns,
+static int ext2_create (struct mnt_idmap * idmap,
 			struct inode * dir, struct dentry * dentry,
 			umode_t mode, bool excl)
 {
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index dd28453d6ea3..0bb43e4a28d5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2792,9 +2792,10 @@ static int ext4_add_nondir(handle_t *handle,
  * If the create succeeds, we fill in the inode information
  * with d_instantiate().
  */
-static int ext4_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int ext4_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, credits, retries = 0;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e634529ab6ad..aacf4e2764d2 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -333,9 +333,10 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	return ERR_PTR(err);
 }
 
-static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	nid_t ino = 0;
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index efba301d68ae..353ca26b3ea4 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -261,7 +261,7 @@ static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 }
 
 /***** Create a file */
-static int msdos_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int msdos_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 21620054e1c4..de5ee606ae5f 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -756,7 +756,7 @@ static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
 	return ERR_PTR(err);
 }
 
-static int vfat_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int vfat_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b1d89ba2d4c7..b74824686229 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -796,7 +796,7 @@ static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return create_new_entry(fm, &args, dir, entry, mode);
 }
 
-static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *entry, umode_t mode, bool excl)
 {
 	return fuse_mknod(&init_user_ns, dir, entry, mode, 0);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 30ec02ab1d0e..f58b13a2d895 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -843,7 +843,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 /**
  * gfs2_create - Create a file
- * @mnt_userns: User namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @dir: The directory in which to create the file
  * @dentry: The dentry of the new file
  * @mode: The mode of the new file
@@ -852,7 +852,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
  * Returns: errno
  */
 
-static int gfs2_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int gfs2_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, excl);
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 527f6e46cbe8..17fd7c3914b0 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -189,7 +189,7 @@ static int hfs_dir_release(struct inode *inode, struct file *file)
  * a directory and return a corresponding inode, given the inode for
  * the directory and the name (and its length) of the new file.
  */
-static int hfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 84714bbccc12..2ce051fb2d14 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -517,7 +517,7 @@ static int hfsplus_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return res;
 }
 
-static int hfsplus_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int hfsplus_create(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode, bool excl)
 {
 	return hfsplus_mknod(&init_user_ns, dir, dentry, mode, 0);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index f8742b7390b8..d6174206a123 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -559,7 +559,7 @@ static int read_name(struct inode *ino, char *name)
 	return 0;
 }
 
-static int hostfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int hostfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 15fc63276caa..f6cbd4a4b94d 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -129,7 +129,7 @@ static int hpfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int hpfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	const unsigned char *name = dentry->d_name.name;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b2f8884ed741..7ffcf4b18685 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1043,7 +1043,7 @@ static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return retval;
 }
 
-static int hugetlbfs_create(struct user_namespace *mnt_userns,
+static int hugetlbfs_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    umode_t mode, bool excl)
 {
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index f399b390b5f6..7494563f04fa 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -24,7 +24,7 @@
 
 static int jffs2_readdir (struct file *, struct dir_context *);
 
-static int jffs2_create (struct user_namespace *, struct inode *,
+static int jffs2_create (struct mnt_idmap *, struct inode *,
 		         struct dentry *, umode_t, bool);
 static struct dentry *jffs2_lookup (struct inode *,struct dentry *,
 				    unsigned int);
@@ -160,7 +160,7 @@ static int jffs2_readdir(struct file *file, struct dir_context *ctx)
 /***********************************************************************/
 
 
-static int jffs2_create(struct user_namespace *mnt_userns, struct inode *dir_i,
+static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct jffs2_raw_inode *ri;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index a38d14eed047..9d06479e549e 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -59,7 +59,7 @@ static inline void free_ea_wmap(struct inode *inode)
  * RETURN:	Errors from subroutines
  *
  */
-static int jfs_create(struct user_namespace *mnt_userns, struct inode *dip,
+static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
 		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	int rc = 0;
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8afdc408ca4f..b8621cf9c933 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -65,10 +65,10 @@ static int minix_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	return finish_open_simple(file, error);
 }
 
-static int minix_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int minix_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return minix_mknod(mnt_userns, dir, dentry, mode, 0);
+	return minix_mknod(&init_user_ns, dir, dentry, mode, 0);
 }
 
 static int minix_symlink(struct user_namespace *mnt_userns, struct inode *dir,
diff --git a/fs/namei.c b/fs/namei.c
index 3e727efed860..f356719c2413 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3115,7 +3115,7 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = dir->i_op->create(mnt_userns, dir, dentry, mode, want_excl);
+	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -3322,6 +3322,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
 				  bool got_write)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *mnt_userns;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
@@ -3370,7 +3371,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	 */
 	if (unlikely(!got_write))
 		open_flag &= ~O_TRUNC;
-	mnt_userns = mnt_user_ns(nd->path.mnt);
+	idmap = mnt_idmap(nd->path.mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
@@ -3413,7 +3415,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 		}
 
-		error = dir_inode->i_op->create(mnt_userns, dir_inode, dentry,
+		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
 						mode, open_flag & O_EXCL);
 		if (error)
 			goto out_dput;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea1ceffa1d3a..a54337c181fe 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2296,7 +2296,7 @@ EXPORT_SYMBOL_GPL(nfs_instantiate);
  * that the operation succeeded on the server, but an error in the
  * reply path made it appear to have failed.
  */
-int nfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct iattr attr;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ae7d4a8c728c..988a1553286f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -384,7 +384,7 @@ extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
-int nfs_create(struct user_namespace *, struct inode *, struct dentry *,
+int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
 	       umode_t, bool);
 int nfs_mkdir(struct user_namespace *, struct inode *, struct dentry *,
 	      umode_t);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 23899e0ae850..4be5d9d34003 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -72,7 +72,7 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
  * If the create succeeds, we fill in the inode information
  * with d_instantiate().
  */
-static int nilfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int nilfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index c8db35e2ae17..8e46372a7ab7 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -94,9 +94,10 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 /*
  * ntfs_create - inode_operations::create
  */
-static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFREG | mode,
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 2d907ac86409..812ff62e6560 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -451,7 +451,7 @@ static int dlmfs_mkdir(struct user_namespace * mnt_userns,
 	return status;
 }
 
-static int dlmfs_create(struct user_namespace *mnt_userns,
+static int dlmfs_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
 			umode_t mode,
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index a8fd51afb794..c931ddb41e94 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -658,7 +658,7 @@ static int ocfs2_mkdir(struct user_namespace *mnt_userns,
 	return ret;
 }
 
-static int ocfs2_create(struct user_namespace *mnt_userns,
+static int ocfs2_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
 			umode_t mode,
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index c219f91f44e9..28590755c1d3 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -285,7 +285,7 @@ static int omfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return omfs_add_node(dir, dentry, mode | S_IFDIR);
 }
 
-static int omfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int omfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	return omfs_add_node(dir, dentry, mode | S_IFREG);
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 75c1a3dcf68c..a47e73f564e4 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -15,7 +15,7 @@
 /*
  * Get a newly allocated inode to go with a negative dentry.
  */
-static int orangefs_create(struct user_namespace *mnt_userns,
+static int orangefs_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
 			umode_t mode,
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f61e37f4c8ff..fc3726586722 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -655,7 +655,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	return err;
 }
 
-static int ovl_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int ovl_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index b3257e852820..77fd43f847ab 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -119,7 +119,7 @@ static int ramfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return retval;
 }
 
-static int ramfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int ramfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
 	return ramfs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 0b8aa99749f1..c1b91a965640 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -620,7 +620,7 @@ static int new_inode_init(struct inode *inode, struct inode *dir, umode_t mode)
 	return dquot_initialize(inode);
 }
 
-static int reiserfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int reiserfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, bool excl)
 {
 	int retval;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index af6137f53cf8..7f5ca335b97b 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -66,7 +66,7 @@
 static int xattr_create(struct inode *dir, struct dentry *dentry, int mode)
 {
 	BUG_ON(!inode_is_locked(dir));
-	return dir->i_op->create(&init_user_ns, dir, dentry, mode, true);
+	return dir->i_op->create(&nop_mnt_idmap, dir, dentry, mode, true);
 }
 #endif
 
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index b2e6abc06a2d..f862fb8584c0 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -61,7 +61,7 @@ static int sysv_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int sysv_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int sysv_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	return sysv_mknod(&init_user_ns, dir, dentry, mode, 0);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index b034f66c6ea8..43a1d9c0e9e0 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -283,7 +283,7 @@ static int ubifs_prepare_create(struct inode *dir, struct dentry *dentry,
 	return fscrypt_setup_filename(dir, &dentry->d_name, 0, nm);
 }
 
-static int ubifs_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7c95c549dd64..91921a3838fa 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -606,7 +606,7 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 	return 0;
 }
 
-static int udf_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int udf_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode = udf_new_inode(dir, mode);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 29d5a0e0c8f0..6904ce95a143 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -69,7 +69,7 @@ static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, unsi
  * If the create succeeds, we fill in the inode information
  * with d_instantiate(). 
  */
-static int ufs_create (struct user_namespace * mnt_userns,
+static int ufs_create (struct mnt_idmap * idmap,
 		struct inode * dir, struct dentry * dentry, umode_t mode,
 		bool excl)
 {
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index c4769a9396c5..0a9e76c87066 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -294,7 +294,7 @@ static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
 	return err;
 }
 
-static int vboxsf_dir_mkfile(struct user_namespace *mnt_userns,
+static int vboxsf_dir_mkfile(struct mnt_idmap *idmap,
 			     struct inode *parent, struct dentry *dentry,
 			     umode_t mode, bool excl)
 {
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 737211879a09..969074864328 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -266,12 +266,13 @@ xfs_vn_mknod(
 
 STATIC int
 xfs_vn_create(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct dentry		*dentry,
 	umode_t			mode,
 	bool			flags)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, NULL);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0214aee3324e..fddfacf2583a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2139,7 +2139,7 @@ struct inode_operations {
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
-	int (*create) (struct user_namespace *, struct inode *,struct dentry *,
+	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,
 		       umode_t, bool);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4b78095fe779..0031bd0337b2 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -608,7 +608,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 	return error;
 }
 
-static int mqueue_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int mqueue_create(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode, bool excl)
 {
 	return mqueue_create_attr(dentry, mode, NULL);
diff --git a/mm/shmem.c b/mm/shmem.c
index ae259636af76..8c2969494bc5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2982,7 +2982,7 @@ static int shmem_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return 0;
 }
 
-static int shmem_create(struct user_namespace *mnt_userns, struct inode *dir,
+static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
 	return shmem_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);

-- 
2.34.1

