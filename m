Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A376695FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbjAMLxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241501AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E743D1DA
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86A9CB8211C
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4AAC43398;
        Fri, 13 Jan 2023 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610597;
        bh=1rGLfatwuf7JnXWZcSABoKhWAdIbIeaX8LLiZEdb960=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pRwGcjgneJDDvOJE1kKOxJT2B6ogEYqf2ONpVy+fpxmz2xsWpXs8o1I77gA8VHFDY
         ymdOMHzN10RCugDytTycevu6B2lQxrcm0GIYHcNQqAcLnCiyj5qmNwmlMlTlU/6EEU
         RWS8tuNvu32mpWT90wFY2npA2sKQrjoIEgEQJYHVi9158/nC85QBROXJdFuC88qGoi
         ausUpLq3EHEIkq5dQTaKBalr/Sa4hj+hutFHvO/aVP21XIedqoGjIGOhcQAToaZeYO
         LX5548xjzpzeeZcK2Xw/d5PJ6FGelmqici/5+6YLaisdwGo2e05zZmOMHP1sKgfOEj
         NMqauBfIiwn5A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:17 +0100
Subject: [PATCH 09/25] fs: port ->rename() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-9-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=35278; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1rGLfatwuf7JnXWZcSABoKhWAdIbIeaX8LLiZEdb960=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2q25R/KuPdXz7G27ZTph914H9kwhJszxv/rYM5Ufn/
 khqFjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8D2X4p7lhFueRT/2P6g0OTfKL0u
 Ba6ezuLva944lAfc3273uSzjL8d2QtmBewhTVo5dl+NomWZXYXNHWFHDoFzrOqfnhg8C+LDwA=
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
 drivers/android/binderfs.c            | 4 ++--
 fs/9p/v9fs.h                          | 2 +-
 fs/9p/vfs_inode.c                     | 4 ++--
 fs/affs/affs.h                        | 2 +-
 fs/affs/namei.c                       | 2 +-
 fs/afs/dir.c                          | 4 ++--
 fs/bad_inode.c                        | 2 +-
 fs/bfs/dir.c                          | 2 +-
 fs/btrfs/inode.c                      | 3 ++-
 fs/ceph/dir.c                         | 2 +-
 fs/cifs/cifsfs.h                      | 2 +-
 fs/cifs/inode.c                       | 2 +-
 fs/coda/dir.c                         | 2 +-
 fs/debugfs/inode.c                    | 2 +-
 fs/ecryptfs/inode.c                   | 2 +-
 fs/exfat/namei.c                      | 2 +-
 fs/ext2/namei.c                       | 2 +-
 fs/ext4/namei.c                       | 3 ++-
 fs/f2fs/namei.c                       | 3 ++-
 fs/fat/namei_msdos.c                  | 2 +-
 fs/fat/namei_vfat.c                   | 2 +-
 fs/fuse/dir.c                         | 2 +-
 fs/gfs2/inode.c                       | 2 +-
 fs/hfs/dir.c                          | 2 +-
 fs/hfsplus/dir.c                      | 2 +-
 fs/hostfs/hostfs_kern.c               | 2 +-
 fs/hpfs/namei.c                       | 2 +-
 fs/jffs2/dir.c                        | 4 ++--
 fs/jfs/namei.c                        | 2 +-
 fs/kernfs/dir.c                       | 2 +-
 fs/libfs.c                            | 2 +-
 fs/minix/namei.c                      | 2 +-
 fs/namei.c                            | 2 +-
 fs/nfs/dir.c                          | 2 +-
 fs/nfs/internal.h                     | 2 +-
 fs/nilfs2/namei.c                     | 2 +-
 fs/ntfs3/namei.c                      | 2 +-
 fs/ocfs2/namei.c                      | 2 +-
 fs/omfs/dir.c                         | 2 +-
 fs/orangefs/namei.c                   | 2 +-
 fs/overlayfs/dir.c                    | 2 +-
 fs/reiserfs/namei.c                   | 2 +-
 fs/sysv/namei.c                       | 2 +-
 fs/ubifs/dir.c                        | 2 +-
 fs/udf/namei.c                        | 2 +-
 fs/ufs/namei.c                        | 2 +-
 fs/vboxsf/dir.c                       | 2 +-
 fs/xfs/xfs_iops.c                     | 3 ++-
 include/linux/fs.h                    | 4 ++--
 mm/shmem.c                            | 6 +++---
 52 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 9605928c11b5..c63890845d95 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -64,7 +64,7 @@ prototypes::
 	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
 	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
-	int (*rename) (struct inode *, struct dentry *,
+	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
 	int (*readlink) (struct dentry *, char __user *,int);
 	const char *(*get_link) (struct dentry *, struct inode *, struct delayed_call *);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index e2cb36f15ce4..263fcc57b71f 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -429,7 +429,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 		int (*rmdir) (struct inode *,struct dentry *);
 		int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
-		int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
+		int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
 			       struct inode *, struct dentry *, unsigned int);
 		int (*readlink) (struct dentry *, char __user *,int);
 		const char *(*get_link) (struct dentry *, struct inode *,
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 09b2ce7e4c34..348d63d1e3d3 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -352,7 +352,7 @@ static inline bool is_binderfs_control_device(const struct dentry *dentry)
 	return info->control_dentry == dentry;
 }
 
-static int binderfs_rename(struct user_namespace *mnt_userns,
+static int binderfs_rename(struct mnt_idmap *idmap,
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
@@ -361,7 +361,7 @@ static int binderfs_rename(struct user_namespace *mnt_userns,
 	    is_binderfs_control_device(new_dentry))
 		return -EPERM;
 
-	return simple_rename(&init_user_ns, old_dir, old_dentry, new_dir,
+	return simple_rename(idmap, old_dir, old_dentry, new_dir,
 			     new_dentry, flags);
 }
 
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 6acabc2e7dc9..f3f74d197b5d 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -151,7 +151,7 @@ extern struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 				      unsigned int flags);
 extern int v9fs_vfs_unlink(struct inode *i, struct dentry *d);
 extern int v9fs_vfs_rmdir(struct inode *i, struct dentry *d);
-extern int v9fs_vfs_rename(struct user_namespace *mnt_userns,
+extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 1a21b001f377..a714df142d05 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -908,7 +908,7 @@ int v9fs_vfs_rmdir(struct inode *i, struct dentry *d)
 
 /**
  * v9fs_vfs_rename - VFS hook to rename an inode
- * @mnt_userns: The user namespace of the mount
+ * @idmap: The idmap of the mount
  * @old_dir:  old dir inode
  * @old_dentry: old dentry
  * @new_dir: new dir inode
@@ -918,7 +918,7 @@ int v9fs_vfs_rmdir(struct inode *i, struct dentry *d)
  */
 
 int
-v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+v9fs_vfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		struct dentry *old_dentry, struct inode *new_dir,
 		struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 8f70a839c311..60685ec76d98 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -177,7 +177,7 @@ extern int	affs_link(struct dentry *olddentry, struct inode *dir,
 extern int	affs_symlink(struct mnt_idmap *idmap,
 			struct inode *dir, struct dentry *dentry,
 			const char *symname);
-extern int	affs_rename2(struct user_namespace *mnt_userns,
+extern int	affs_rename2(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags);
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index e0300f0b6fc3..d12ccfd2a83d 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -503,7 +503,7 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	return retval;
 }
 
-int affs_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+int affs_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
 		 struct dentry *old_dentry, struct inode *new_dir,
 		 struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c2ada2fc51b4..82690d1dd49a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -38,7 +38,7 @@ static int afs_link(struct dentry *from, struct inode *dir,
 		    struct dentry *dentry);
 static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *content);
-static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags);
 static bool afs_dir_release_folio(struct folio *folio, gfp_t gfp_flags);
@@ -1897,7 +1897,7 @@ static const struct afs_operation_ops afs_rename_operation = {
 /*
  * rename a file in an AFS filesystem and/or move it between directories
  */
-static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index d1b075b4dce8..1e24ce889a15 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -75,7 +75,7 @@ static int bad_inode_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return -EIO;
 }
 
-static int bad_inode_rename2(struct user_namespace *mnt_userns,
+static int bad_inode_rename2(struct mnt_idmap *idmap,
 			     struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry,
 			     unsigned int flags)
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index f9d4ce5fff9f..fa3e66bc9be3 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -199,7 +199,7 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 	return error;
 }
 
-static int bfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int bfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 438b5142be44..dbb6790d0268 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9547,10 +9547,11 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	return ret;
 }
 
-static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int btrfs_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
 			 struct dentry *old_dentry, struct inode *new_dir,
 			 struct dentry *new_dentry, unsigned int flags)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int ret;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 7ad56d5a63b3..0ced8b570e42 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1269,7 +1269,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int ceph_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 14bb46ab0874..b58cd737b21e 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -62,7 +62,7 @@ extern int cifs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 extern int cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t);
 extern int cifs_rmdir(struct inode *, struct dentry *);
-extern int cifs_rename2(struct user_namespace *, struct inode *,
+extern int cifs_rename2(struct mnt_idmap *, struct inode *,
 			struct dentry *, struct inode *, struct dentry *,
 			unsigned int);
 extern int cifs_revalidate_file_attr(struct file *filp);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index ce4f086db2df..11cdc7cfe0ba 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2138,7 +2138,7 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 }
 
 int
-cifs_rename2(struct user_namespace *mnt_userns, struct inode *source_dir,
+cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	     struct dentry *source_dentry, struct inode *target_dir,
 	     struct dentry *target_dentry, unsigned int flags)
 {
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index ff90117f1eec..7fdf8e37a1df 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -295,7 +295,7 @@ static int coda_rmdir(struct inode *dir, struct dentry *de)
 }
 
 /* rename */
-static int coda_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int coda_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index ac76e6c6ac56..bf397f6a6a33 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -837,7 +837,7 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 
 	take_dentry_name_snapshot(&old_name, old_dentry);
 
-	error = simple_rename(&init_user_ns, d_inode(old_dir), old_dentry,
+	error = simple_rename(&nop_mnt_idmap, d_inode(old_dir), old_dentry,
 			      d_inode(new_dir), dentry, 0);
 	if (error) {
 		release_dentry_name_snapshot(&old_name);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 6a2052d234b2..cf85901d7a5d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -574,7 +574,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int
-ecryptfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		struct dentry *old_dentry, struct inode *new_dir,
 		struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 99e86caba544..02aab4c3a5f7 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1285,7 +1285,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 	return ret;
 }
 
-static int exfat_rename(struct user_namespace *mnt_userns,
+static int exfat_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 91219a6a5739..8b5dfa46bcc8 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -315,7 +315,7 @@ static int ext2_rmdir (struct inode * dir, struct dentry *dentry)
 	return err;
 }
 
-static int ext2_rename (struct user_namespace * mnt_userns,
+static int ext2_rename (struct mnt_idmap * idmap,
 			struct inode * old_dir, struct dentry * old_dentry,
 			struct inode * new_dir, struct dentry * new_dentry,
 			unsigned int flags)
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0aa190e03b86..feb58508978e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4162,11 +4162,12 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return retval;
 }
 
-static int ext4_rename2(struct user_namespace *mnt_userns,
+static int ext4_rename2(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int err;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(old_dir->i_sb))))
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 39f76a1d8b90..a87b9fcaf923 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1299,11 +1299,12 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return err;
 }
 
-static int f2fs_rename2(struct user_namespace *mnt_userns,
+static int f2fs_rename2(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int err;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index b98025f21d9b..2116c486843b 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -594,7 +594,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 }
 
 /***** Rename, a wrapper for rename_same_dir & rename_diff_dir */
-static int msdos_rename(struct user_namespace *mnt_userns,
+static int msdos_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index f5f4caff75e2..fceda1de4805 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1158,7 +1158,7 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 	goto out;
 }
 
-static int vfat_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int vfat_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
 			struct dentry *old_dentry, struct inode *new_dir,
 			struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f6aa799fb584..c95d610fa63f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -998,7 +998,7 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 	return err;
 }
 
-static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
+static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 			struct dentry *oldent, struct inode *newdir,
 			struct dentry *newent, unsigned int flags)
 {
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index ed015ab66287..f4af55807808 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1766,7 +1766,7 @@ static int gfs2_exchange(struct inode *odir, struct dentry *odentry,
 	return error;
 }
 
-static int gfs2_rename2(struct user_namespace *mnt_userns, struct inode *odir,
+static int gfs2_rename2(struct mnt_idmap *idmap, struct inode *odir,
 			struct dentry *odentry, struct inode *ndir,
 			struct dentry *ndentry, unsigned int flags)
 {
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index f8141c407d55..3e1e3dcf0b48 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -280,7 +280,7 @@ static int hfs_remove(struct inode *dir, struct dentry *dentry)
  * new file/directory.
  * XXX: how do you handle must_be dir?
  */
-static int hfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 19caa2d953a7..56fb5f1312e7 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -529,7 +529,7 @@ static int hfsplus_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
 }
 
-static int hfsplus_rename(struct user_namespace *mnt_userns,
+static int hfsplus_rename(struct mnt_idmap *idmap,
 			  struct inode *old_dir, struct dentry *old_dentry,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index b7f512d2c669..65dfc7457034 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -734,7 +734,7 @@ static int hostfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int hostfs_rename2(struct user_namespace *mnt_userns,
+static int hostfs_rename2(struct mnt_idmap *idmap,
 			  struct inode *old_dir, struct dentry *old_dentry,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 8415137a064d..69fb40b2c99a 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -512,7 +512,7 @@ const struct address_space_operations hpfs_symlink_aops = {
 	.read_folio	= hpfs_symlink_read_folio
 };
 
-static int hpfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int hpfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 9e1110de6f0b..5075a0a6d594 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -37,7 +37,7 @@ static int jffs2_mkdir (struct mnt_idmap *, struct inode *,struct dentry *,
 static int jffs2_rmdir (struct inode *,struct dentry *);
 static int jffs2_mknod (struct mnt_idmap *, struct inode *,struct dentry *,
 			umode_t,dev_t);
-static int jffs2_rename (struct user_namespace *, struct inode *,
+static int jffs2_rename (struct mnt_idmap *, struct inode *,
 			 struct dentry *, struct inode *, struct dentry *,
 			 unsigned int);
 
@@ -762,7 +762,7 @@ static int jffs2_mknod (struct mnt_idmap *idmap, struct inode *dir_i,
 	return ret;
 }
 
-static int jffs2_rename (struct user_namespace *mnt_userns,
+static int jffs2_rename (struct mnt_idmap *idmap,
 			 struct inode *old_dir_i, struct dentry *old_dentry,
 			 struct inode *new_dir_i, struct dentry *new_dentry,
 			 unsigned int flags)
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 917c1237cf93..b29d68b5eec5 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1059,7 +1059,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
  *
  * FUNCTION:	rename a file or directory
  */
-static int jfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4f2d521bedab..e3181c3e1988 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1238,7 +1238,7 @@ static int kernfs_iop_rmdir(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
-static int kernfs_iop_rename(struct user_namespace *mnt_userns,
+static int kernfs_iop_rename(struct mnt_idmap *idmap,
 			     struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry,
 			     unsigned int flags)
diff --git a/fs/libfs.c b/fs/libfs.c
index aae36b224508..152405c00f89 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -473,7 +473,7 @@ int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL_GPL(simple_rename_exchange);
 
-int simple_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+int simple_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		  struct dentry *old_dentry, struct inode *new_dir,
 		  struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index b6b4b0a1608e..aa308b12f40d 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -184,7 +184,7 @@ static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 	return err;
 }
 
-static int minix_rename(struct user_namespace *mnt_userns,
+static int minix_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
diff --git a/fs/namei.c b/fs/namei.c
index 74c194c0ceab..3be66e8b418f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4786,7 +4786,7 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(new_mnt_userns, old_dir, old_dentry,
+	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
 				      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 19b4926b93cb..01eeae59599b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2642,7 +2642,7 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
  * If these conditions are met, we can drop the dentries before doing
  * the rename.
  */
-int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	       struct dentry *old_dentry, struct inode *new_dir,
 	       struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index d6df06d61f28..41468c21291d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -395,7 +395,7 @@ int nfs_symlink(struct mnt_idmap *, struct inode *, struct dentry *,
 int nfs_link(struct dentry *, struct inode *, struct dentry *);
 int nfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *, umode_t,
 	      dev_t);
-int nfs_rename(struct user_namespace *, struct inode *, struct dentry *,
+int nfs_rename(struct mnt_idmap *, struct inode *, struct dentry *,
 	       struct inode *, struct dentry *, unsigned int);
 
 #ifdef CONFIG_NFS_V4_2
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 9cc52d8fa022..c7024da8f1e2 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -340,7 +340,7 @@ static int nilfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int nilfs_rename(struct user_namespace *mnt_userns,
+static int nilfs_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 3cd1a18c6c02..13731de39010 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -233,7 +233,7 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 /*
  * ntfs_rename - inode_operations::rename
  */
-static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *dir,
+static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, u32 flags)
 {
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index e588009cb04e..13433e774e3d 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1194,7 +1194,7 @@ static void ocfs2_double_unlock(struct inode *inode1, struct inode *inode2)
 		ocfs2_inode_unlock(inode2, 1);
 }
 
-static int ocfs2_rename(struct user_namespace *mnt_userns,
+static int ocfs2_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir,
 			struct dentry *old_dentry,
 			struct inode *new_dir,
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 34138f46f7e7..82cf7e9a665f 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -370,7 +370,7 @@ static bool omfs_fill_chain(struct inode *dir, struct dir_context *ctx,
 	return true;
 }
 
-static int omfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int omfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 9243c35fb478..77518e248cf7 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -375,7 +375,7 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return ret;
 }
 
-static int orangefs_rename(struct user_namespace *mnt_userns,
+static int orangefs_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir,
 			struct dentry *old_dentry,
 			struct inode *new_dir,
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff18a6a16b01..17d509156215 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1075,7 +1075,7 @@ static int ovl_set_redirect(struct dentry *dentry, bool samedir)
 	return err;
 }
 
-static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
+static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		      struct dentry *old, struct inode *newdir,
 		      struct dentry *new, unsigned int flags)
 {
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 4c3da7ccca34..f80b4a6ecf51 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1311,7 +1311,7 @@ static void set_ino_in_dir_entry(struct reiserfs_dir_entry *de,
  * one path. If it holds 2 or more, it can get into endless waiting in
  * get_empty_nodes or its clones
  */
-static int reiserfs_rename(struct user_namespace *mnt_userns,
+static int reiserfs_rename(struct mnt_idmap *idmap,
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index e44c5f5f5b0c..ecd424461511 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -189,7 +189,7 @@ static int sysv_rmdir(struct inode * dir, struct dentry * dentry)
  * Anybody can rename anything with this: the permission checks are left to the
  * higher-level routines.
  */
-static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9f521a8edebf..e11a2d76fb0e 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1606,7 +1606,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	return err;
 }
 
-static int ubifs_rename(struct user_namespace *mnt_userns,
+static int ubifs_rename(struct mnt_idmap *idmap,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7ecfeaad41b1..c93b10513bab 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1073,7 +1073,7 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 /* Anybody can rename anything with this: the permission checks are left to the
  * higher-level routines.
  */
-static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 85afc26d559d..36154b5aca6d 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -243,7 +243,7 @@ static int ufs_rmdir (struct inode * dir, struct dentry *dentry)
 	return err;
 }
 
-static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 4ec79548e9f0..075f15c43c78 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -387,7 +387,7 @@ static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
 	return 0;
 }
 
-static int vboxsf_dir_rename(struct user_namespace *mnt_userns,
+static int vboxsf_dir_rename(struct mnt_idmap *idmap,
 			     struct inode *old_parent,
 			     struct dentry *old_dentry,
 			     struct inode *new_parent,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 249b0d8fcd84..fd0c62e0ddd2 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -446,13 +446,14 @@ xfs_vn_symlink(
 
 STATIC int
 xfs_vn_rename(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct inode		*odir,
 	struct dentry		*odentry,
 	struct inode		*ndir,
 	struct dentry		*ndentry,
 	unsigned int		flags)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode	*new_inode = d_inode(ndentry);
 	int		omode = 0;
 	int		error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a28117398e71..8d287bd2bf9b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2150,7 +2150,7 @@ struct inode_operations {
 	int (*rmdir) (struct inode *,struct dentry *);
 	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,
 		      umode_t,dev_t);
-	int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
+	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
 	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
 	int (*getattr) (struct mnt_idmap *, const struct path *,
@@ -3323,7 +3323,7 @@ extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
 extern int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
 				  struct inode *new_dir, struct dentry *new_dentry);
-extern int simple_rename(struct user_namespace *, struct inode *,
+extern int simple_rename(struct mnt_idmap *, struct inode *,
 			 struct dentry *, struct inode *, struct dentry *,
 			 unsigned int);
 extern void simple_recursive_removal(struct dentry *,
diff --git a/mm/shmem.c b/mm/shmem.c
index d66f75c5e85e..c9998c2220d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3045,7 +3045,7 @@ static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 	return shmem_unlink(dir, dentry);
 }
 
-static int shmem_whiteout(struct user_namespace *mnt_userns,
+static int shmem_whiteout(struct mnt_idmap *idmap,
 			  struct inode *old_dir, struct dentry *old_dentry)
 {
 	struct dentry *whiteout;
@@ -3078,7 +3078,7 @@ static int shmem_whiteout(struct user_namespace *mnt_userns,
  * it exists so that the VFS layer correctly free's it when it
  * gets overwritten.
  */
-static int shmem_rename2(struct user_namespace *mnt_userns,
+static int shmem_rename2(struct mnt_idmap *idmap,
 			 struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry,
 			 unsigned int flags)
@@ -3098,7 +3098,7 @@ static int shmem_rename2(struct user_namespace *mnt_userns,
 	if (flags & RENAME_WHITEOUT) {
 		int error;
 
-		error = shmem_whiteout(&init_user_ns, old_dir, old_dentry);
+		error = shmem_whiteout(&nop_mnt_idmap, old_dir, old_dentry);
 		if (error)
 			return error;
 	}

-- 
2.34.1

