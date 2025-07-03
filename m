Return-Path: <linux-fsdevel+bounces-53778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B06AF6CD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6091C2278D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551C2D0C7A;
	Thu,  3 Jul 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2BGFeaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F052D0275;
	Thu,  3 Jul 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531298; cv=none; b=UpVuKv+KYxWw0EKIeheL9agymHQXQ1fSgN+aQ1kN/cZhNNiI0ZN4WjwKy8aYFcGkcqNn0zx56xb6v+dk2BZc2LoYpmGwcwgWfOVxxqUWjyBKkiTGiiTeUEJD3M99Dt1dLVGyPzpSUqwzpCrd5dWhBvO2zWk45drK9qLz0vF7ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531298; c=relaxed/simple;
	bh=N47N8ntkIkecYxies9CMase2EGW/VAk6Z3CeW0b8YGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOiixE8s0BlkdmFUD/Xkoy4QfJnRqFyLxul5xzdBD7e+Scoawz6QVw4q16m/thIJ/Z/yg323pfrcp+1Y1OR4j0Vc8B7E1YJXCBHJwoJsMg01Lc8rpwuRdwRpmn7ygou6Tn14CMEAI2GGmq9l8aGlzMPSDpdWL71ApwP2PNxgavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2BGFeaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F7C4CEE3;
	Thu,  3 Jul 2025 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751531298;
	bh=N47N8ntkIkecYxies9CMase2EGW/VAk6Z3CeW0b8YGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2BGFeaZ01K05/+J81chx3XGuGoX9CIp3yG1XIvYfH/jf5Nyeq37cfYiAbkNrCveM
	 K1Da+cKAV8axTrlknqNvHkHBuC18KSZaESbvigDCjtDp3acJyHkKf6ZjuAJR92Or8N
	 VPzAdwhFXzs0W10YR6S5VkdFThnLOuR7fXvLWHyLiP4i4vfHsIXZyUlYmzhBlPXUNu
	 AizFZ/co0ADR6aa8BRw4Uikmb+oJFGbYuiWX6QR4VhegZ0JjbbtcR6XGCEObxgBMEQ
	 ldpEIgckCQgu2l3b80h+wn8kkEBTy1/jXnXcf0qv8D9gsm1kBSI5Xl1Mtgeb6kBRbY
	 +TZoxcIYfjLAQ==
Date: Thu, 3 Jul 2025 10:28:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250703-restlaufzeit-baurecht-9ed44552b481@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250702-stagnation-dackel-294bb4cd9f3d@brauner>
 <CAOQ4uximwjYabeO=-ktMtnzMsx6KXBs=pUsgNno=_qgpQnpHCA@mail.gmail.com>
 <20250702183750.GW10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2ky3vyxthovjcnor"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702183750.GW10009@frogsfrogsfrogs>


--2ky3vyxthovjcnor
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 02, 2025 at 11:37:50AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 02, 2025 at 03:43:28PM +0200, Amir Goldstein wrote:
> > On Wed, Jul 2, 2025 at 2:40 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > Er... "fsx_fileattr" is the struct that the system call uses?
> > > >
> > > > That's a little confusing considering that xfs already has a
> > > > xfs_fill_fsxattr function that actually fills a struct fileattr.
> > > > That could be renamed xfs_fill_fileattr.
> > > >
> > > > I dunno.  There's a part of me that would really rather that the
> > > > file_getattr and file_setattr syscalls operate on a struct file_attr.
> > >
> > > Agreed, I'm pretty sure I suggested this during an earlier review. Fits
> > > in line with struct mount_attr and others. Fwiw, struct fileattr (the
> > > kernel internal thing) should've really been struct file_kattr or struct
> > > kernel_file_attr. This is a common pattern now:
> > >
> > > struct mount_attr vs struct mount_kattr
> > >
> > > struct clone_args vs struct kernel_clone_kargs
> > >
> > > etc.
> > >file_attr
> > 
> > I can see the allure, but we have a long history here with fsxattr,
> > so I think it serves the users better to reference this history with
> > fsxattr64.
> 
> <shrug> XFS has a long history with 'struct fsxattr' (the structure you
> passed to XFS_IOC_FSGETXATTR) but the rest of the kernel needn't be so
> fixated upon the historical name.  ext4/f2fs/overlay afaict are just
> going along for the ride.
> 
> IOWs I like brauner's struct file_attr and struct file_kattr
> suggestions.
> 
> > That, and also, avoid the churn of s/fileattr/file_kattr/
> > If you want to do this renaming, please do it in the same PR
> > because I don't like the idea of having both file_attr and fileattr
> > in the tree for an unknown period.
> 
> But yeah, that ought to be a treewide change done at the same time.

Why do you all hate me? ;)
See the appended patch.

--2ky3vyxthovjcnor
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-tree-wide-s-struct-fileattr-struct-file_kattr-g.patch"

From 3a5f5c281e7993342cf285285fa0a496d4fca2b7 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 3 Jul 2025 09:36:41 +0200
Subject: [PATCH] tree-wide: s/struct fileattr/struct file_kattr/g

Now that we expose struct file_attr as our uapi struct rename all the
internal struct to struct file_kattr to clearly communicate that it is a
kernel internal struct. This is similar to struct mount_{k}attr and
others.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/locking.rst |  4 ++--
 Documentation/filesystems/vfs.rst     |  4 ++--
 fs/bcachefs/fs.c                      |  4 ++--
 fs/btrfs/ioctl.c                      |  4 ++--
 fs/btrfs/ioctl.h                      |  6 ++---
 fs/ecryptfs/inode.c                   |  4 ++--
 fs/efivarfs/inode.c                   |  4 ++--
 fs/ext2/ext2.h                        |  4 ++--
 fs/ext2/ioctl.c                       |  4 ++--
 fs/ext4/ext4.h                        |  4 ++--
 fs/ext4/ioctl.c                       |  4 ++--
 fs/f2fs/f2fs.h                        |  4 ++--
 fs/f2fs/file.c                        |  4 ++--
 fs/file_attr.c                        | 34 +++++++++++++--------------
 fs/fuse/fuse_i.h                      |  4 ++--
 fs/fuse/ioctl.c                       |  4 ++--
 fs/gfs2/file.c                        |  4 ++--
 fs/gfs2/inode.h                       |  4 ++--
 fs/hfsplus/hfsplus_fs.h               |  4 ++--
 fs/hfsplus/inode.c                    |  4 ++--
 fs/jfs/ioctl.c                        |  4 ++--
 fs/jfs/jfs_inode.h                    |  4 ++--
 fs/nilfs2/ioctl.c                     |  4 ++--
 fs/nilfs2/nilfs.h                     |  4 ++--
 fs/ocfs2/ioctl.c                      |  4 ++--
 fs/ocfs2/ioctl.h                      |  4 ++--
 fs/orangefs/inode.c                   |  4 ++--
 fs/overlayfs/copy_up.c                |  4 ++--
 fs/overlayfs/inode.c                  | 12 +++++-----
 fs/overlayfs/overlayfs.h              | 10 ++++----
 fs/overlayfs/util.c                   |  2 +-
 fs/ubifs/ioctl.c                      |  4 ++--
 fs/ubifs/ubifs.h                      |  4 ++--
 fs/xfs/xfs_ioctl.c                    | 18 +++++++-------
 fs/xfs/xfs_ioctl.h                    |  4 ++--
 include/linux/fileattr.h              | 14 +++++------
 include/linux/fs.h                    |  6 ++---
 include/linux/lsm_hook_defs.h         |  4 ++--
 include/linux/security.h              |  8 +++----
 include/uapi/linux/fs.h               |  2 +-
 mm/shmem.c                            |  4 ++--
 security/security.c                   |  4 ++--
 security/selinux/hooks.c              |  4 ++--
 43 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 2e567e341c3b..2ff02653d7cc 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -87,8 +87,8 @@ prototypes::
 	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
 	int (*fileattr_set)(struct mnt_idmap *idmap,
-			    struct dentry *dentry, struct fileattr *fa);
-	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+			    struct dentry *dentry, struct file_kattr *fa);
+	int (*fileattr_get)(struct dentry *dentry, struct file_kattr *fa);
 	struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index fd32a9a17bfb..f2bbf4def123 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -515,8 +515,8 @@ As of kernel 2.6.22, the following members are defined:
 		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
 	        int (*set_acl)(struct mnt_idmap *, struct dentry *, struct posix_acl *, int);
 		int (*fileattr_set)(struct mnt_idmap *idmap,
-				    struct dentry *dentry, struct fileattr *fa);
-		int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+				    struct dentry *dentry, struct file_kattr *fa);
+		int (*fileattr_get)(struct dentry *dentry, struct file_kattr *fa);
 	        struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 	};
 
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 85d13f800165..7c4de887629c 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1619,7 +1619,7 @@ static const __maybe_unused unsigned bch_flags_to_xflags[] = {
 };
 
 static int bch2_fileattr_get(struct dentry *dentry,
-			     struct fileattr *fa)
+			     struct file_kattr *fa)
 {
 	struct bch_inode_info *inode = to_bch_ei(d_inode(dentry));
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
@@ -1682,7 +1682,7 @@ static int fssetxattr_inode_update_fn(struct btree_trans *trans,
 
 static int bch2_fileattr_set(struct mnt_idmap *idmap,
 			     struct dentry *dentry,
-			     struct fileattr *fa)
+			     struct file_kattr *fa)
 {
 	struct bch_inode_info *inode = to_bch_ei(d_inode(dentry));
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 913acef3f0a9..ffb28bfba4fa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -245,7 +245,7 @@ static int btrfs_check_ioctl_vol_args2_subvol_name(const struct btrfs_ioctl_vol_
  * Set flags/xflags from the internal inode flags. The remaining items of
  * fsxattr are zeroed.
  */
-int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int btrfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	const struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 
@@ -254,7 +254,7 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int btrfs_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa)
+		       struct dentry *dentry, struct file_kattr *fa)
 {
 	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 	struct btrfs_root *root = inode->root;
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index e08ea446cf48..ccf6bed9cc24 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -8,7 +8,7 @@
 struct file;
 struct dentry;
 struct mnt_idmap;
-struct fileattr;
+struct file_kattr;
 struct io_uring_cmd;
 struct btrfs_inode;
 struct btrfs_fs_info;
@@ -16,9 +16,9 @@ struct btrfs_ioctl_balance_args;
 
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int btrfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int btrfs_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa);
+		       struct dentry *dentry, struct file_kattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct btrfs_inode *inode);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 493d7f194956..d83416af17b4 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1124,13 +1124,13 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 	return rc;
 }
 
-static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+static int ecryptfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
 }
 
 static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
-				 struct dentry *dentry, struct fileattr *fa)
+				 struct dentry *dentry, struct file_kattr *fa)
 {
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	int rc;
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 98a7299a9ee9..2891614abf8d 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -138,7 +138,7 @@ const struct inode_operations efivarfs_dir_inode_operations = {
 };
 
 static int
-efivarfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+efivarfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	unsigned int i_flags;
 	unsigned int flags = 0;
@@ -154,7 +154,7 @@ efivarfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 
 static int
 efivarfs_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa)
+		      struct dentry *dentry, struct file_kattr *fa)
 {
 	unsigned int i_flags = 0;
 
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 4025f875252a..cf97b76e9fd3 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -750,9 +750,9 @@ extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len);
 
 /* ioctl.c */
-extern int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+extern int ext2_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern int ext2_fileattr_set(struct mnt_idmap *idmap,
-			     struct dentry *dentry, struct fileattr *fa);
+			     struct dentry *dentry, struct file_kattr *fa);
 extern long ext2_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext2_compat_ioctl(struct file *, unsigned int, unsigned long);
 
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 44e04484e570..c3fea55b8efa 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -18,7 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/fileattr.h>
 
-int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int ext2_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct ext2_inode_info *ei = EXT2_I(d_inode(dentry));
 
@@ -28,7 +28,7 @@ int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int ext2_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa)
+		      struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct ext2_inode_info *ei = EXT2_I(inode);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..7d962e7f388a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3103,8 +3103,8 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
 int ext4_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa);
-int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+		      struct dentry *dentry, struct file_kattr *fa);
+int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern void ext4_reset_inode_seed(struct inode *inode);
 int ext4_update_overhead(struct super_block *sb, bool force);
 int ext4_force_shutdown(struct super_block *sb, u32 flags);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 5668a17458ae..84e3c73952d7 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -980,7 +980,7 @@ static long ext4_ioctl_group_add(struct file *file,
 	return err;
 }
 
-int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -997,7 +997,7 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int ext4_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa)
+		      struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	u32 flags = fa->flags;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9333a22b9a01..c78464792ceb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3615,9 +3615,9 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 						bool readonly, bool need_lock);
 int f2fs_precache_extents(struct inode *inode);
-int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int f2fs_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa);
+		      struct dentry *dentry, struct file_kattr *fa);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6bd3de64f2a8..90180ca22abd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3356,7 +3356,7 @@ static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 }
 #endif
 
-int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -3380,7 +3380,7 @@ int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int f2fs_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa)
+		      struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	u32 fsflags = fa->flags, mask = F2FS_SETTABLE_FS_FL;
diff --git a/fs/file_attr.c b/fs/file_attr.c
index 21d6a0607345..17745c89e2be 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -17,7 +17,7 @@
  * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
  * other fields are zeroed.
  */
-void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
+void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 {
 	memset(fa, 0, sizeof(*fa));
 	fa->fsx_valid = true;
@@ -47,7 +47,7 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
  * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
  * All other fields are zeroed.
  */
-void fileattr_fill_flags(struct fileattr *fa, u32 flags)
+void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 {
 	memset(fa, 0, sizeof(*fa));
 	fa->flags_valid = true;
@@ -78,7 +78,7 @@ EXPORT_SYMBOL(fileattr_fill_flags);
  *
  * Return: 0 on success, or a negative error on failure.
  */
-int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
@@ -94,7 +94,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
 
-static void fileattr_to_file_attr(const struct fileattr *fa,
+static void fileattr_to_file_attr(const struct file_kattr *fa,
 				  struct file_attr *fattr)
 {
 	__u32 mask = FS_XFLAGS_MASK;
@@ -114,7 +114,7 @@ static void fileattr_to_file_attr(const struct fileattr *fa,
  *
  * Return: 0 on success, or -EFAULT on failure.
  */
-int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
+int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
 	__u32 mask = FS_XFLAGS_MASK;
@@ -134,7 +134,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
 static int file_attr_to_fileattr(const struct file_attr *fattr,
-				 struct fileattr *fa)
+				 struct file_kattr *fa)
 {
 	__u32 mask = FS_XFLAGS_MASK;
 
@@ -150,7 +150,7 @@ static int file_attr_to_fileattr(const struct file_attr *fattr,
 	return 0;
 }
 
-static int copy_fsxattr_from_user(struct fileattr *fa,
+static int copy_fsxattr_from_user(struct file_kattr *fa,
 				  struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
@@ -179,8 +179,8 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
  * Note: must be called with inode lock held.
  */
 static int fileattr_set_prepare(struct inode *inode,
-			      const struct fileattr *old_ma,
-			      struct fileattr *fa)
+			      const struct file_kattr *old_ma,
+			      struct file_kattr *fa)
 {
 	int err;
 
@@ -263,10 +263,10 @@ static int fileattr_set_prepare(struct inode *inode,
  * Return: 0 on success, or a negative error on failure.
  */
 int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
-		     struct fileattr *fa)
+		     struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
-	struct fileattr old_ma = {};
+	struct file_kattr old_ma = {};
 	int err;
 
 	if (!inode->i_op->fileattr_set)
@@ -308,7 +308,7 @@ EXPORT_SYMBOL(vfs_fileattr_set);
 
 int ioctl_getflags(struct file *file, unsigned int __user *argp)
 {
-	struct fileattr fa = { .flags_valid = true }; /* hint only */
+	struct file_kattr fa = { .flags_valid = true }; /* hint only */
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
@@ -324,7 +324,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct fileattr fa;
+	struct file_kattr fa;
 	unsigned int flags;
 	int err;
 
@@ -345,7 +345,7 @@ EXPORT_SYMBOL(ioctl_setflags);
 
 int ioctl_fsgetxattr(struct file *file, void __user *argp)
 {
-	struct fileattr fa = { .fsx_valid = true }; /* hint only */
+	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
@@ -362,7 +362,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct fileattr fa;
+	struct file_kattr fa;
 	int err;
 
 	err = copy_fsxattr_from_user(&fa, argp);
@@ -387,7 +387,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct fileattr fa;
+	struct file_kattr fa;
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
@@ -442,7 +442,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct fileattr fa;
+	struct file_kattr fa;
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b54f4f57789f..501f64ceeab3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1486,9 +1486,9 @@ void fuse_dax_cancel_work(struct fuse_conn *fc);
 long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg);
-int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa);
+		      struct dentry *dentry, struct file_kattr *fa);
 
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index f2692f7d5932..57032eadca6c 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -502,7 +502,7 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
 	fuse_file_release(inode, ff, O_RDONLY, NULL, S_ISDIR(inode->i_mode));
 }
 
-int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct fuse_file *ff;
@@ -542,7 +542,7 @@ int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int fuse_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa)
+		      struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct fuse_file *ff;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fd1147aa3891..65f4371f428c 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -155,7 +155,7 @@ static inline u32 gfs2_gfsflags_to_fsflags(struct inode *inode, u32 gfsflags)
 	return fsflags;
 }
 
-int gfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int gfs2_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -276,7 +276,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 }
 
 int gfs2_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa)
+		      struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	u32 fsflags = fa->flags, gfsflags = 0;
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index eafe123617e6..dd970e644fe0 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -107,9 +107,9 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset);
 extern const struct file_operations gfs2_file_fops_nolock;
 extern const struct file_operations gfs2_dir_fops_nolock;
 
-int gfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int gfs2_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int gfs2_fileattr_set(struct mnt_idmap *idmap,
-		      struct dentry *dentry, struct fileattr *fa);
+		      struct dentry *dentry, struct file_kattr *fa);
 void gfs2_set_inode_flags(struct inode *inode);
 
 #ifdef CONFIG_GFS2_FS_LOCKING_DLM
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 2f089bff0095..927db2b8b17c 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -489,9 +489,9 @@ int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 		    unsigned int query_flags);
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 		       int datasync);
-int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int hfsplus_fileattr_set(struct mnt_idmap *idmap,
-			 struct dentry *dentry, struct fileattr *fa);
+			 struct dentry *dentry, struct file_kattr *fa);
 
 /* ioctl.c */
 long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index f331e9574217..3ec0b33808c0 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -654,7 +654,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	return res;
 }
 
-int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
@@ -673,7 +673,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int hfsplus_fileattr_set(struct mnt_idmap *idmap,
-			 struct dentry *dentry, struct fileattr *fa)
+			 struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index f7bd7e8f5be4..563f148be8af 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -57,7 +57,7 @@ static long jfs_map_ext2(unsigned long flags, int from)
 	return mapped;
 }
 
-int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int jfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct jfs_inode_info *jfs_inode = JFS_IP(d_inode(dentry));
 	unsigned int flags = jfs_inode->mode2 & JFS_FL_USER_VISIBLE;
@@ -71,7 +71,7 @@ int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int jfs_fileattr_set(struct mnt_idmap *idmap,
-		     struct dentry *dentry, struct fileattr *fa)
+		     struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct jfs_inode_info *jfs_inode = JFS_IP(inode);
diff --git a/fs/jfs/jfs_inode.h b/fs/jfs/jfs_inode.h
index ea80661597ac..2c6c81c8cb9f 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -9,9 +9,9 @@ struct fid;
 
 extern struct inode *ialloc(struct inode *, umode_t);
 extern int jfs_fsync(struct file *, loff_t, loff_t, int);
-extern int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+extern int jfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern int jfs_fileattr_set(struct mnt_idmap *idmap,
-			    struct dentry *dentry, struct fileattr *fa);
+			    struct dentry *dentry, struct file_kattr *fa);
 extern long jfs_ioctl(struct file *, unsigned int, unsigned long);
 extern struct inode *jfs_iget(struct super_block *, unsigned long);
 extern int jfs_commit_inode(struct inode *, int);
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index a66d62a51f77..3288c3b4be9e 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -118,7 +118,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
  *
  * Return: always 0 as success.
  */
-int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int nilfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 
@@ -136,7 +136,7 @@ int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
  * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa)
+		       struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct nilfs_transaction_info ti;
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index cb6ed54accd7..f466daa39440 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -268,9 +268,9 @@ int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
 /* ioctl.c */
-int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *m);
+int nilfs_fileattr_get(struct dentry *dentry, struct file_kattr *m);
 int nilfs_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa);
+		       struct dentry *dentry, struct file_kattr *fa);
 long nilfs_ioctl(struct file *, unsigned int, unsigned long);
 long nilfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *, struct nilfs_argv *,
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 7ae96fb8807a..db14c92302a1 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -62,7 +62,7 @@ static inline int o2info_coherent(struct ocfs2_info_request *req)
 	return (!(req->ir_flags & OCFS2_INFO_FL_NON_COHERENT));
 }
 
-int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int ocfs2_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int flags;
@@ -83,7 +83,7 @@ int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int ocfs2_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa)
+		       struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int flags = fa->flags;
diff --git a/fs/ocfs2/ioctl.h b/fs/ocfs2/ioctl.h
index 48a5fdfe87a1..4a1c2313b429 100644
--- a/fs/ocfs2/ioctl.h
+++ b/fs/ocfs2/ioctl.h
@@ -11,9 +11,9 @@
 #ifndef OCFS2_IOCTL_PROTO_H
 #define OCFS2_IOCTL_PROTO_H
 
-int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int ocfs2_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int ocfs2_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa);
+		       struct dentry *dentry, struct file_kattr *fa);
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 08a6f372a352..926d1659902d 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -887,7 +887,7 @@ int orangefs_update_time(struct inode *inode, int flags)
 	return __orangefs_setattr(inode, &iattr);
 }
 
-static int orangefs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+static int orangefs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	u64 val = 0;
 	int ret;
@@ -908,7 +908,7 @@ static int orangefs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 static int orangefs_fileattr_set(struct mnt_idmap *idmap,
-				 struct dentry *dentry, struct fileattr *fa)
+				 struct dentry *dentry, struct file_kattr *fa)
 {
 	u64 val = 0;
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 2c646b7076d0..74817e1ece19 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -171,8 +171,8 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
 			     const struct path *new)
 {
-	struct fileattr oldfa = { .flags_valid = true };
-	struct fileattr newfa = { .flags_valid = true };
+	struct file_kattr oldfa = { .flags_valid = true };
+	struct file_kattr newfa = { .flags_valid = true };
 	int err;
 
 	err = ovl_real_fileattr_get(old, &oldfa);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index cf3581dc1034..ecb9f2019395 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -610,7 +610,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  * Introducing security_inode_fileattr_get/set() hooks would solve this issue
  * properly.
  */
-static int ovl_security_fileattr(const struct path *realpath, struct fileattr *fa,
+static int ovl_security_fileattr(const struct path *realpath, struct file_kattr *fa,
 				 bool set)
 {
 	struct file *file;
@@ -637,7 +637,7 @@ static int ovl_security_fileattr(const struct path *realpath, struct fileattr *f
 	return err;
 }
 
-int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa)
+int ovl_real_fileattr_set(const struct path *realpath, struct file_kattr *fa)
 {
 	int err;
 
@@ -649,7 +649,7 @@ int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa)
 }
 
 int ovl_fileattr_set(struct mnt_idmap *idmap,
-		     struct dentry *dentry, struct fileattr *fa)
+		     struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct path upperpath;
@@ -697,7 +697,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 }
 
 /* Convert inode protection flags to fileattr flags */
-static void ovl_fileattr_prot_flags(struct inode *inode, struct fileattr *fa)
+static void ovl_fileattr_prot_flags(struct inode *inode, struct file_kattr *fa)
 {
 	BUILD_BUG_ON(OVL_PROT_FS_FLAGS_MASK & ~FS_COMMON_FL);
 	BUILD_BUG_ON(OVL_PROT_FSX_FLAGS_MASK & ~FS_XFLAG_COMMON);
@@ -712,7 +712,7 @@ static void ovl_fileattr_prot_flags(struct inode *inode, struct fileattr *fa)
 	}
 }
 
-int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
+int ovl_real_fileattr_get(const struct path *realpath, struct file_kattr *fa)
 {
 	int err;
 
@@ -723,7 +723,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
 	return vfs_fileattr_get(realpath->dentry, fa);
 }
 
-int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int ovl_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct path realpath;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8baaba0a3fe5..e19d91f22186 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -815,7 +815,7 @@ void ovl_copyattr(struct inode *to);
 
 void ovl_check_protattr(struct inode *inode, struct dentry *upper);
 int ovl_set_protattr(struct inode *inode, struct dentry *upper,
-		      struct fileattr *fa);
+		      struct file_kattr *fa);
 
 static inline void ovl_copyflags(struct inode *from, struct inode *to)
 {
@@ -847,11 +847,11 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 
 /* file.c */
 extern const struct file_operations ovl_file_operations;
-int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa);
-int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa);
-int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int ovl_real_fileattr_get(const struct path *realpath, struct file_kattr *fa);
+int ovl_real_fileattr_set(const struct path *realpath, struct file_kattr *fa);
+int ovl_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int ovl_fileattr_set(struct mnt_idmap *idmap,
-		     struct dentry *dentry, struct fileattr *fa);
+		     struct dentry *dentry, struct file_kattr *fa);
 struct ovl_file;
 struct ovl_file *ovl_file_alloc(struct file *realfile);
 void ovl_file_free(struct ovl_file *of);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index dcccb4b4a66c..607860f199a8 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -959,7 +959,7 @@ void ovl_check_protattr(struct inode *inode, struct dentry *upper)
 }
 
 int ovl_set_protattr(struct inode *inode, struct dentry *upper,
-		      struct fileattr *fa)
+		      struct file_kattr *fa)
 {
 	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
 	char buf[OVL_PROTATTR_MAX];
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 2c99349cf537..79536b2e3d7a 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -130,7 +130,7 @@ static int setflags(struct inode *inode, int flags)
 	return err;
 }
 
-int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+int ubifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	int flags = ubifs2ioctl(ubifs_inode(inode)->flags);
@@ -145,7 +145,7 @@ int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 int ubifs_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa)
+		       struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	int flags = fa->flags;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 256dbaeeb0de..5db45c9e26ee 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2073,9 +2073,9 @@ int ubifs_recover_size(struct ubifs_info *c, bool in_place);
 void ubifs_destroy_size_tree(struct ubifs_info *c);
 
 /* ioctl.c */
-int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int ubifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int ubifs_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa);
+		       struct dentry *dentry, struct file_kattr *fa);
 long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 void ubifs_set_inode_flags(struct inode *inode);
 #ifdef CONFIG_COMPAT
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d250f7f74e3b..6d573e736a67 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -444,7 +444,7 @@ static void
 xfs_fill_fsxattr(
 	struct xfs_inode	*ip,
 	int			whichfork,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, whichfork);
@@ -496,7 +496,7 @@ xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
 	void			__user *arg)
 {
-	struct fileattr		fa;
+	struct file_kattr		fa;
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
@@ -508,7 +508,7 @@ xfs_ioc_fsgetxattra(
 int
 xfs_fileattr_get(
 	struct dentry		*dentry,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
 
@@ -526,7 +526,7 @@ static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
@@ -582,7 +582,7 @@ xfs_ioctl_setattr_xflags(
 static void
 xfs_ioctl_setattr_prepare_dax(
 	struct xfs_inode	*ip,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct inode            *inode = VFS_I(ip);
@@ -642,7 +642,7 @@ xfs_ioctl_setattr_get_trans(
 static int
 xfs_ioctl_setattr_check_extsize(
 	struct xfs_inode	*ip,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_failaddr_t		failaddr;
@@ -684,7 +684,7 @@ xfs_ioctl_setattr_check_extsize(
 static int
 xfs_ioctl_setattr_check_cowextsize(
 	struct xfs_inode	*ip,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_failaddr_t		failaddr;
@@ -709,7 +709,7 @@ xfs_ioctl_setattr_check_cowextsize(
 static int
 xfs_ioctl_setattr_check_projid(
 	struct xfs_inode	*ip,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	if (!fa->fsx_valid)
 		return 0;
@@ -725,7 +725,7 @@ int
 xfs_fileattr_set(
 	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
-	struct fileattr		*fa)
+	struct file_kattr		*fa)
 {
 	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_ioctl.h b/fs/xfs/xfs_ioctl.h
index 12124946f347..f5a831e9de4a 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -17,13 +17,13 @@ xfs_ioc_swapext(
 extern int
 xfs_fileattr_get(
 	struct dentry		*dentry,
-	struct fileattr		*fa);
+	struct file_kattr		*fa);
 
 extern int
 xfs_fileattr_set(
 	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
-	struct fileattr		*fa);
+	struct file_kattr		*fa);
 
 extern long
 xfs_file_ioctl(
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index e2a2f4ae242d..f89dcfad3f8f 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -40,7 +40,7 @@
  * is handled by the VFS helpers, so filesystems are free to implement just one
  * or both of these sub-interfaces.
  */
-struct fileattr {
+struct file_kattr {
 	u32	flags;		/* flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
 	/* struct fsxattr: */
 	u32	fsx_xflags;	/* xflags field value (get/set) */
@@ -53,10 +53,10 @@ struct fileattr {
 	bool	fsx_valid:1;
 };
 
-int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa);
 
-void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
-void fileattr_fill_flags(struct fileattr *fa, u32 flags);
+void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags);
+void fileattr_fill_flags(struct file_kattr *fa, u32 flags);
 
 /**
  * fileattr_has_fsx - check for extended flags/attributes
@@ -65,16 +65,16 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags);
  * Return: true if any attributes are present that are not represented in
  * ->flags.
  */
-static inline bool fileattr_has_fsx(const struct fileattr *fa)
+static inline bool fileattr_has_fsx(const struct file_kattr *fa)
 {
 	return fa->fsx_valid &&
 		((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
 		 fa->fsx_projid != 0 ||	fa->fsx_cowextsize != 0);
 }
 
-int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
-		     struct fileattr *fa);
+		     struct file_kattr *fa);
 int ioctl_getflags(struct file *file, unsigned int __user *argp);
 int ioctl_setflags(struct file *file, unsigned int __user *argp);
 int ioctl_fsgetxattr(struct file *file, void __user *argp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..0c58617645ea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -80,7 +80,7 @@ struct fsnotify_mark_connector;
 struct fsnotify_sb_info;
 struct fs_context;
 struct fs_parameter_spec;
-struct fileattr;
+struct file_kattr;
 struct iomap_ops;
 
 extern void __init inode_init(void);
@@ -2254,8 +2254,8 @@ struct inode_operations {
 	int (*set_acl)(struct mnt_idmap *, struct dentry *,
 		       struct posix_acl *, int);
 	int (*fileattr_set)(struct mnt_idmap *idmap,
-			    struct dentry *dentry, struct fileattr *fa);
-	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+			    struct dentry *dentry, struct file_kattr *fa);
+	int (*fileattr_get)(struct dentry *dentry, struct file_kattr *fa);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 } ____cacheline_aligned;
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9600a4350e79..fd11fffdd3c3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,8 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
-LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
-LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
+LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct file_kattr *fa)
+LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct file_kattr *fa)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
diff --git a/include/linux/security.h b/include/linux/security.h
index 9ed0d0e0c81f..b95b5540c429 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -452,9 +452,9 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
 int security_inode_file_setattr(struct dentry *dentry,
-			      struct fileattr *fa);
+			      struct file_kattr *fa);
 int security_inode_file_getattr(struct dentry *dentry,
-			      struct fileattr *fa);
+			      struct file_kattr *fa);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -1057,13 +1057,13 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 { }
 
 static inline int security_inode_file_setattr(struct dentry *dentry,
-					      struct fileattr *fa)
+					      struct file_kattr *fa)
 {
 	return 0;
 }
 
 static inline int security_inode_file_getattr(struct dentry *dentry,
-					      struct fileattr *fa)
+					      struct file_kattr *fa)
 {
 	return 0;
 }
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 9663dbdda181..6e136c9c6a22 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -151,7 +151,7 @@ struct fsxattr {
 /*
  * Variable size structure for file_[sg]et_attr().
  *
- * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
+ * Note. This is alternative to the structure 'struct file_kattr'/'struct fsxattr'.
  * As this structure is passed to/from userspace with its size, this can
  * be versioned based on the size.
  */
diff --git a/mm/shmem.c b/mm/shmem.c
index 0c5fb4ffa03a..6311fe35c577 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4183,7 +4183,7 @@ static const char *shmem_get_link(struct dentry *dentry, struct inode *inode,
 
 #ifdef CONFIG_TMPFS_XATTR
 
-static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+static int shmem_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
 
@@ -4193,7 +4193,7 @@ static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 
 static int shmem_fileattr_set(struct mnt_idmap *idmap,
-			      struct dentry *dentry, struct fileattr *fa)
+			      struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
diff --git a/security/security.c b/security/security.c
index 711b4de40b8d..a5766cbf6f7c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2632,7 +2632,7 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
+int security_inode_file_setattr(struct dentry *dentry, struct file_kattr *fa)
 {
 	return call_int_hook(inode_file_setattr, dentry, fa);
 }
@@ -2647,7 +2647,7 @@ int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
+int security_inode_file_getattr(struct dentry *dentry, struct file_kattr *fa)
 {
 	return call_int_hook(inode_file_getattr, dentry, fa);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index be7aca2269fa..0dadce2267c1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3481,13 +3481,13 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 }
 
 static int selinux_inode_file_setattr(struct dentry *dentry,
-				      struct fileattr *fa)
+				      struct file_kattr *fa)
 {
 	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 }
 
 static int selinux_inode_file_getattr(struct dentry *dentry,
-				      struct fileattr *fa)
+				      struct file_kattr *fa)
 {
 	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
 }
-- 
2.47.2


--2ky3vyxthovjcnor--

