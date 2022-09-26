Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2595EAA95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiIZPXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiIZPW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319B861D3;
        Mon, 26 Sep 2022 07:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D76F60E03;
        Mon, 26 Sep 2022 14:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DB9C43142;
        Mon, 26 Sep 2022 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201330;
        bh=c00ZDDW+B0pUszcq+LinAbqT2PUYhRoYKjPc+EgbToQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHDLqspUZ0b0yDuhjOv4xVnTBWg9IYhSrCcDzIQcGXfEG8w18UUAMBi8qxFlzR5Gj
         k1bUv6JFeZWkEChirf59QA3upUIKamaTMQcCe86v5kCk25p63sSEVl0uBMwPeIHlXT
         Aktj4QMaDTZ7brPER3P8AqkxiZKX+PN2vubLUpgLt7q6UHYzrU0Mhqvtv2SSabvbIl
         iJCUuUx0UB82H/9/ObqFnWXiB0HDahHcrOv5UfMBFeec1wCPZTnBc6nhjHWBWTAMpF
         uND7kTgmlckX8b1hWl1Wf4zRqpLpATWbRyTa/bJMPE3D85OvP4pjpTxFds/Jz7LL1O
         9mrf5QnpuskBw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 03/30] fs: rename current get acl method
Date:   Mon, 26 Sep 2022 16:08:00 +0200
Message-Id: <20220926140827.142806-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31097; i=brauner@kernel.org; h=from:subject; bh=c00ZDDW+B0pUszcq+LinAbqT2PUYhRoYKjPc+EgbToQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbrILOsNev1pnwqTIUInPzTe3Jl4WYkrjvsF6k+ls1tID 3BHrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSt5/hf8DneeVqIe2bQmxXtV/Jlm h5/W+T5e6NajxbTl+ccK3kWSsjw8lLpctnxljlHjsx5zezqpaBf+NRu8+Mi9j8Bc+4TMg6zAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

The current inode operation for getting posix acls takes an inode
argument but various filesystems (e.g., 9p, cifs, overlayfs) need access
to the dentry. In contrast to the ->set_acl() inode operation we cannot
simply extend ->get_acl() to take a dentry argument. The ->get_acl()
inode operation is called from:

acl_permission_check()
-> check_acl()
   -> get_acl()

which is part of generic_permission() which in turn is part of
inode_permission(). Both generic_permission() and inode_permission() are
called in the ->permission() handler of various filesystems (e.g.,
overlayfs). So simply passing a dentry argument to ->get_acl() would
amount to also having to pass a dentry argument to ->permission(). We
should avoid this unnecessary change.

So instead of extending the existing inode operation rename it from
->get_acl() to ->get_inode_acl() and add a ->get_acl() method later that
passes a dentry argument and which filesystems that need access to the
dentry can implement instead of ->get_inode_acl(). Filesystems like cifs
which allow setting and getting posix acls but not using them for
permission checking during lookup can simply not implement
->get_inode_acl().

This is intended to be a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Suggested-by/Inspired-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---

Notes:
    /* v2 */
    unchanged

 Documentation/filesystems/locking.rst |  4 ++--
 Documentation/filesystems/porting.rst |  4 ++--
 Documentation/filesystems/vfs.rst     |  2 +-
 fs/9p/vfs_inode_dotl.c                |  4 ++--
 fs/bad_inode.c                        |  2 +-
 fs/btrfs/inode.c                      |  6 +++---
 fs/ceph/dir.c                         |  2 +-
 fs/ceph/inode.c                       |  2 +-
 fs/erofs/inode.c                      |  6 +++---
 fs/erofs/namei.c                      |  2 +-
 fs/ext2/file.c                        |  2 +-
 fs/ext2/namei.c                       |  4 ++--
 fs/ext4/file.c                        |  2 +-
 fs/ext4/namei.c                       |  4 ++--
 fs/f2fs/file.c                        |  2 +-
 fs/f2fs/namei.c                       |  4 ++--
 fs/fuse/dir.c                         |  4 ++--
 fs/gfs2/inode.c                       |  4 ++--
 fs/jffs2/dir.c                        |  2 +-
 fs/jffs2/file.c                       |  2 +-
 fs/jfs/file.c                         |  2 +-
 fs/jfs/namei.c                        |  2 +-
 fs/namei.c                            |  2 +-
 fs/nfs/nfs3proc.c                     |  4 ++--
 fs/ntfs3/file.c                       |  2 +-
 fs/ntfs3/namei.c                      |  4 ++--
 fs/ocfs2/file.c                       |  4 ++--
 fs/ocfs2/namei.c                      |  2 +-
 fs/orangefs/inode.c                   |  2 +-
 fs/orangefs/namei.c                   |  2 +-
 fs/overlayfs/dir.c                    |  2 +-
 fs/overlayfs/inode.c                  |  4 ++--
 fs/posix_acl.c                        | 27 ++++++++++++++-------------
 fs/reiserfs/file.c                    |  2 +-
 fs/reiserfs/namei.c                   |  4 ++--
 fs/xfs/xfs_iops.c                     |  6 +++---
 include/linux/fs.h                    |  6 +++---
 37 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 4bb2627026ec..1cd2930e54ee 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -70,7 +70,7 @@ prototypes::
 	const char *(*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int, unsigned int);
-	struct posix_acl * (*get_acl)(struct inode *, int, bool);
+	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
@@ -103,7 +103,7 @@ readlink:	no
 get_link:	no
 setattr:	exclusive
 permission:	no (may not block if called in rcu-walk mode)
-get_acl:	no
+get_inode_acl:	no
 getattr:	no
 listxattr:	no
 fiemap:		no
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index aee9aaf9f3df..93592ff0b3d8 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -462,8 +462,8 @@ ERR_PTR(...).
 argument; instead of passing IPERM_FLAG_RCU we add MAY_NOT_BLOCK into mask.
 
 generic_permission() has also lost the check_acl argument; ACL checking
-has been taken to VFS and filesystems need to provide a non-NULL ->i_op->get_acl
-to read an ACL from disk.
+has been taken to VFS and filesystems need to provide a non-NULL
+->i_op->get_inode_acl to read an ACL from disk.
 
 ---
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6cd6953e175b..4fc6f1e23012 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -432,7 +432,7 @@ As of kernel 2.6.22, the following members are defined:
 		const char *(*get_link) (struct dentry *, struct inode *,
 					 struct delayed_call *);
 		int (*permission) (struct user_namespace *, struct inode *, int);
-		struct posix_acl * (*get_acl)(struct inode *, int, bool);
+		struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 		int (*setattr) (struct user_namespace *, struct dentry *, struct iattr *);
 		int (*getattr) (struct user_namespace *, const struct path *, struct kstat *, u32, unsigned int);
 		ssize_t (*listxattr) (struct dentry *, char *, size_t);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5cfa4b4f070f..0d1a7f2c579d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -983,14 +983,14 @@ const struct inode_operations v9fs_dir_inode_operations_dotl = {
 	.getattr = v9fs_vfs_getattr_dotl,
 	.setattr = v9fs_vfs_setattr_dotl,
 	.listxattr = v9fs_listxattr,
-	.get_acl = v9fs_iop_get_acl,
+	.get_inode_acl = v9fs_iop_get_acl,
 };
 
 const struct inode_operations v9fs_file_inode_operations_dotl = {
 	.getattr = v9fs_vfs_getattr_dotl,
 	.setattr = v9fs_vfs_setattr_dotl,
 	.listxattr = v9fs_listxattr,
-	.get_acl = v9fs_iop_get_acl,
+	.get_inode_acl = v9fs_iop_get_acl,
 };
 
 const struct inode_operations v9fs_symlink_inode_operations_dotl = {
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index bc67beab5f16..524406b838ff 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -177,7 +177,7 @@ static const struct inode_operations bad_inode_ops =
 	.setattr	= bad_inode_setattr,
 	.listxattr	= bad_inode_listxattr,
 	.get_link	= bad_inode_get_link,
-	.get_acl	= bad_inode_get_acl,
+	.get_inode_acl	= bad_inode_get_acl,
 	.fiemap		= bad_inode_fiemap,
 	.update_time	= bad_inode_update_time,
 	.atomic_open	= bad_inode_atomic_open,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 29884b729ca3..27b836693570 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11441,7 +11441,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 	.mknod		= btrfs_mknod,
 	.listxattr	= btrfs_listxattr,
 	.permission	= btrfs_permission,
-	.get_acl	= btrfs_get_acl,
+	.get_inode_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 	.tmpfile        = btrfs_tmpfile,
@@ -11494,7 +11494,7 @@ static const struct inode_operations btrfs_file_inode_operations = {
 	.listxattr      = btrfs_listxattr,
 	.permission	= btrfs_permission,
 	.fiemap		= btrfs_fiemap,
-	.get_acl	= btrfs_get_acl,
+	.get_inode_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 	.fileattr_get	= btrfs_fileattr_get,
@@ -11505,7 +11505,7 @@ static const struct inode_operations btrfs_special_inode_operations = {
 	.setattr	= btrfs_setattr,
 	.permission	= btrfs_permission,
 	.listxattr	= btrfs_listxattr,
-	.get_acl	= btrfs_get_acl,
+	.get_inode_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 };
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index e7e2ebac330d..6c7026cc8988 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2033,7 +2033,7 @@ const struct inode_operations ceph_dir_iops = {
 	.getattr = ceph_getattr,
 	.setattr = ceph_setattr,
 	.listxattr = ceph_listxattr,
-	.get_acl = ceph_get_acl,
+	.get_inode_acl = ceph_get_acl,
 	.set_acl = ceph_set_acl,
 	.mknod = ceph_mknod,
 	.symlink = ceph_symlink,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a23fc1e90f66..c43d289f74a5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -126,7 +126,7 @@ const struct inode_operations ceph_file_iops = {
 	.setattr = ceph_setattr,
 	.getattr = ceph_getattr,
 	.listxattr = ceph_listxattr,
-	.get_acl = ceph_get_acl,
+	.get_inode_acl = ceph_get_acl,
 	.set_acl = ceph_set_acl,
 };
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 95a403720e8c..f8dccc9167fe 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -379,7 +379,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 const struct inode_operations erofs_generic_iops = {
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
-	.get_acl = erofs_get_acl,
+	.get_inode_acl = erofs_get_acl,
 	.fiemap = erofs_fiemap,
 };
 
@@ -387,12 +387,12 @@ const struct inode_operations erofs_symlink_iops = {
 	.get_link = page_get_link,
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
-	.get_acl = erofs_get_acl,
+	.get_inode_acl = erofs_get_acl,
 };
 
 const struct inode_operations erofs_fast_symlink_iops = {
 	.get_link = simple_get_link,
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
-	.get_acl = erofs_get_acl,
+	.get_inode_acl = erofs_get_acl,
 };
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index fd75506799c4..bc38a92c90db 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -237,6 +237,6 @@ const struct inode_operations erofs_dir_iops = {
 	.lookup = erofs_lookup,
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
-	.get_acl = erofs_get_acl,
+	.get_inode_acl = erofs_get_acl,
 	.fiemap = erofs_fiemap,
 };
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index eb97aa3d700e..6b4bebe982ca 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -200,7 +200,7 @@ const struct inode_operations ext2_file_inode_operations = {
 	.listxattr	= ext2_listxattr,
 	.getattr	= ext2_getattr,
 	.setattr	= ext2_setattr,
-	.get_acl	= ext2_get_acl,
+	.get_inode_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.fiemap		= ext2_fiemap,
 	.fileattr_get	= ext2_fileattr_get,
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 5fd9a22d2b70..c38dbdbc7013 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -427,7 +427,7 @@ const struct inode_operations ext2_dir_inode_operations = {
 	.listxattr	= ext2_listxattr,
 	.getattr	= ext2_getattr,
 	.setattr	= ext2_setattr,
-	.get_acl	= ext2_get_acl,
+	.get_inode_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.tmpfile	= ext2_tmpfile,
 	.fileattr_get	= ext2_fileattr_get,
@@ -438,6 +438,6 @@ const struct inode_operations ext2_special_inode_operations = {
 	.listxattr	= ext2_listxattr,
 	.getattr	= ext2_getattr,
 	.setattr	= ext2_setattr,
-	.get_acl	= ext2_get_acl,
+	.get_inode_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 };
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 109d07629f81..aaf1d9c8b997 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -934,7 +934,7 @@ const struct inode_operations ext4_file_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_file_getattr,
 	.listxattr	= ext4_listxattr,
-	.get_acl	= ext4_get_acl,
+	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap		= ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 3a31b662f661..f7adc4b46f93 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4181,7 +4181,7 @@ const struct inode_operations ext4_dir_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
-	.get_acl	= ext4_get_acl,
+	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap         = ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
@@ -4192,6 +4192,6 @@ const struct inode_operations ext4_special_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
-	.get_acl	= ext4_get_acl,
+	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 };
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d5523625f590..adbc783c57e5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -999,7 +999,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 const struct inode_operations f2fs_file_inode_operations = {
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
-	.get_acl	= f2fs_get_acl,
+	.get_inode_acl	= f2fs_get_acl,
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bf00d5057abb..eef19990d34d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1376,7 +1376,7 @@ const struct inode_operations f2fs_dir_inode_operations = {
 	.tmpfile	= f2fs_tmpfile,
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
-	.get_acl	= f2fs_get_acl,
+	.get_inode_acl	= f2fs_get_acl,
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
@@ -1394,7 +1394,7 @@ const struct inode_operations f2fs_symlink_inode_operations = {
 const struct inode_operations f2fs_special_inode_operations = {
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
-	.get_acl	= f2fs_get_acl,
+	.get_inode_acl	= f2fs_get_acl,
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 };
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b585b04e815e..14a15fd7a5ec 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1917,7 +1917,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
-	.get_acl	= fuse_get_acl,
+	.get_inode_acl	= fuse_get_acl,
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
@@ -1939,7 +1939,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
-	.get_acl	= fuse_get_acl,
+	.get_inode_acl	= fuse_get_acl,
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f2bc97c6862f..3e525825f667 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2142,7 +2142,7 @@ static const struct inode_operations gfs2_file_iops = {
 	.getattr = gfs2_getattr,
 	.listxattr = gfs2_listxattr,
 	.fiemap = gfs2_fiemap,
-	.get_acl = gfs2_get_acl,
+	.get_inode_acl = gfs2_get_acl,
 	.set_acl = gfs2_set_acl,
 	.update_time = gfs2_update_time,
 	.fileattr_get = gfs2_fileattr_get,
@@ -2164,7 +2164,7 @@ static const struct inode_operations gfs2_dir_iops = {
 	.getattr = gfs2_getattr,
 	.listxattr = gfs2_listxattr,
 	.fiemap = gfs2_fiemap,
-	.get_acl = gfs2_get_acl,
+	.get_inode_acl = gfs2_get_acl,
 	.set_acl = gfs2_set_acl,
 	.update_time = gfs2_update_time,
 	.atomic_open = gfs2_atomic_open,
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index c0aabbcbfd58..f399b390b5f6 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -62,7 +62,7 @@ const struct inode_operations jffs2_dir_inode_operations =
 	.rmdir =	jffs2_rmdir,
 	.mknod =	jffs2_mknod,
 	.rename =	jffs2_rename,
-	.get_acl =	jffs2_get_acl,
+	.get_inode_acl =	jffs2_get_acl,
 	.set_acl =	jffs2_set_acl,
 	.setattr =	jffs2_setattr,
 	.listxattr =	jffs2_listxattr,
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index ba86acbe12d3..3cf71befa475 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -64,7 +64,7 @@ const struct file_operations jffs2_file_operations =
 
 const struct inode_operations jffs2_file_inode_operations =
 {
-	.get_acl =	jffs2_get_acl,
+	.get_inode_acl =	jffs2_get_acl,
 	.set_acl =	jffs2_set_acl,
 	.setattr =	jffs2_setattr,
 	.listxattr =	jffs2_listxattr,
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index e3eb9c36751f..88663465aecd 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -133,7 +133,7 @@ const struct inode_operations jfs_file_inode_operations = {
 	.fileattr_get	= jfs_fileattr_get,
 	.fileattr_set	= jfs_fileattr_set,
 #ifdef CONFIG_JFS_POSIX_ACL
-	.get_acl	= jfs_get_acl,
+	.get_inode_acl	= jfs_get_acl,
 	.set_acl	= jfs_set_acl,
 #endif
 };
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 9db4f5789c0e..b50afaf7966f 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1525,7 +1525,7 @@ const struct inode_operations jfs_dir_inode_operations = {
 	.fileattr_get	= jfs_fileattr_get,
 	.fileattr_set	= jfs_fileattr_set,
 #ifdef CONFIG_JFS_POSIX_ACL
-	.get_acl	= jfs_get_acl,
+	.get_inode_acl	= jfs_get_acl,
 	.set_acl	= jfs_set_acl,
 #endif
 };
diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..7636c63b77d2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -297,7 +297,7 @@ static int check_acl(struct user_namespace *mnt_userns,
 		acl = get_cached_acl_rcu(inode, ACL_TYPE_ACCESS);
 	        if (!acl)
 	                return -EAGAIN;
-		/* no ->get_acl() calls in RCU mode... */
+		/* no ->get_inode_acl() calls in RCU mode... */
 		if (is_uncached_acl(acl))
 			return -ECHILD;
 	        return posix_acl_permission(mnt_userns, inode, acl, mask);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1597eef40d54..bcfb117bdac9 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -997,7 +997,7 @@ static const struct inode_operations nfs3_dir_inode_operations = {
 	.setattr	= nfs_setattr,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
-	.get_acl	= nfs3_get_acl,
+	.get_inode_acl	= nfs3_get_acl,
 	.set_acl	= nfs3_set_acl,
 #endif
 };
@@ -1008,7 +1008,7 @@ static const struct inode_operations nfs3_file_inode_operations = {
 	.setattr	= nfs_setattr,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
-	.get_acl	= nfs3_get_acl,
+	.get_inode_acl	= nfs3_get_acl,
 	.set_acl	= nfs3_set_acl,
 #endif
 };
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index ee5101e6bd68..c5e4a886593d 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1255,7 +1255,7 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.setattr	= ntfs3_setattr,
 	.listxattr	= ntfs_listxattr,
 	.permission	= ntfs_permission,
-	.get_acl	= ntfs_get_acl,
+	.get_inode_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
 };
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bc22cc321a74..053cc0e0f8b5 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -367,7 +367,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.mknod		= ntfs_mknod,
 	.rename		= ntfs_rename,
 	.permission	= ntfs_permission,
-	.get_acl	= ntfs_get_acl,
+	.get_inode_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.setattr	= ntfs3_setattr,
 	.getattr	= ntfs_getattr,
@@ -379,7 +379,7 @@ const struct inode_operations ntfs_special_inode_operations = {
 	.setattr	= ntfs3_setattr,
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
-	.get_acl	= ntfs_get_acl,
+	.get_inode_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 };
 // clang-format on
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 9c67edd215d5..af900aaa9275 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2712,7 +2712,7 @@ const struct inode_operations ocfs2_file_iops = {
 	.permission	= ocfs2_permission,
 	.listxattr	= ocfs2_listxattr,
 	.fiemap		= ocfs2_fiemap,
-	.get_acl	= ocfs2_iop_get_acl,
+	.get_inode_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
 	.fileattr_get	= ocfs2_fileattr_get,
 	.fileattr_set	= ocfs2_fileattr_set,
@@ -2722,7 +2722,7 @@ const struct inode_operations ocfs2_special_file_iops = {
 	.setattr	= ocfs2_setattr,
 	.getattr	= ocfs2_getattr,
 	.permission	= ocfs2_permission,
-	.get_acl	= ocfs2_iop_get_acl,
+	.get_inode_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
 };
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 961d1cf54388..c5ffded7ac92 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2916,7 +2916,7 @@ const struct inode_operations ocfs2_dir_iops = {
 	.permission	= ocfs2_permission,
 	.listxattr	= ocfs2_listxattr,
 	.fiemap         = ocfs2_fiemap,
-	.get_acl	= ocfs2_iop_get_acl,
+	.get_inode_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
 	.fileattr_get	= ocfs2_fileattr_get,
 	.fileattr_set	= ocfs2_fileattr_set,
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 825872d8d377..8974b0fbf00d 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -975,7 +975,7 @@ static int orangefs_fileattr_set(struct user_namespace *mnt_userns,
 
 /* ORANGEFS2 implementation of VFS inode operations for files */
 static const struct inode_operations orangefs_file_inode_operations = {
-	.get_acl = orangefs_get_acl,
+	.get_inode_acl = orangefs_get_acl,
 	.set_acl = orangefs_set_acl,
 	.setattr = orangefs_setattr,
 	.getattr = orangefs_getattr,
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 600e8eee541f..75c1a3dcf68c 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -430,7 +430,7 @@ static int orangefs_rename(struct user_namespace *mnt_userns,
 /* ORANGEFS implementation of VFS inode operations for directories */
 const struct inode_operations orangefs_dir_inode_operations = {
 	.lookup = orangefs_lookup,
-	.get_acl = orangefs_get_acl,
+	.get_inode_acl = orangefs_get_acl,
 	.set_acl = orangefs_set_acl,
 	.create = orangefs_create,
 	.unlink = orangefs_unlink,
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..7bece7010c00 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1311,7 +1311,7 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 0fbcb590af84..ecb51c249466 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -721,7 +721,7 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
@@ -741,7 +741,7 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 };
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 97b368b15289..5b857f59535b 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -63,7 +63,7 @@ struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type)
 	if (acl == ACL_DONT_CACHE) {
 		struct posix_acl *ret;
 
-		ret = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
+		ret = inode->i_op->get_inode_acl(inode, type, LOOKUP_RCU);
 		if (!IS_ERR(ret))
 			acl = ret;
 	}
@@ -132,24 +132,24 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	 * current value of the ACL will not be ACL_NOT_CACHED and so our own
 	 * sentinel will not be set; another task will update the cache.  We
 	 * could wait for that other task to complete its job, but it's easier
-	 * to just call ->get_acl to fetch the ACL ourself.  (This is going to
-	 * be an unlikely race.)
+	 * to just call ->get_inode_acl to fetch the ACL ourself.  (This is
+	 * going to be an unlikely race.)
 	 */
 	cmpxchg(p, ACL_NOT_CACHED, sentinel);
 
 	/*
-	 * Normally, the ACL returned by ->get_acl will be cached.
+	 * Normally, the ACL returned by ->get_inode_acl will be cached.
 	 * A filesystem can prevent that by calling
-	 * forget_cached_acl(inode, type) in ->get_acl.
+	 * forget_cached_acl(inode, type) in ->get_inode_acl.
 	 *
 	 * If the filesystem doesn't have a get_acl() function at all, we'll
 	 * just create the negative cache entry.
 	 */
-	if (!inode->i_op->get_acl) {
+	if (!inode->i_op->get_inode_acl) {
 		set_cached_acl(inode, type, NULL);
 		return NULL;
 	}
-	acl = inode->i_op->get_acl(inode, type, false);
+	acl = inode->i_op->get_inode_acl(inode, type, false);
 
 	if (IS_ERR(acl)) {
 		/*
@@ -1044,7 +1044,8 @@ posix_acl_from_xattr_kgid(struct user_namespace *mnt_userns,
  * Filesystems that store POSIX ACLs in the unaltered uapi format should use
  * posix_acl_from_xattr() when reading them from the backing store and
  * converting them into the struct posix_acl VFS format. The helper is
- * specifically intended to be called from the ->get_acl() inode operation.
+ * specifically intended to be called from the ->get_inode_acl() inode
+ * operation.
  *
  * The posix_acl_from_xattr() function will map the raw {g,u}id values stored
  * in ACL_{GROUP,USER} entries into the filesystem idmapping in @fs_userns. The
@@ -1052,11 +1053,11 @@ posix_acl_from_xattr_kgid(struct user_namespace *mnt_userns,
  * correct k{g,u}id_t. The returned struct posix_acl can be cached.
  *
  * Note that posix_acl_from_xattr() does not take idmapped mounts into account.
- * If it did it calling is from the ->get_acl() inode operation would return
- * POSIX ACLs mapped according to an idmapped mount which would mean that the
- * value couldn't be cached for the filesystem. Idmapped mounts are taken into
- * account on the fly during permission checking or right at the VFS -
- * userspace boundary before reporting them to the user.
+ * If it did it calling is from the ->get_inode_acl() inode operation would
+ * return POSIX ACLs mapped according to an idmapped mount which would mean
+ * that the value couldn't be cached for the filesystem. Idmapped mounts are
+ * taken into account on the fly during permission checking or right at the VFS
+ * - userspace boundary before reporting them to the user.
  *
  * Return: Allocated struct posix_acl on success, NULL for a valid header but
  *         without actual POSIX ACL entries, or ERR_PTR() encoded error code.
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 6e228bfbe7ef..467d13da198f 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -256,7 +256,7 @@ const struct inode_operations reiserfs_file_inode_operations = {
 	.setattr = reiserfs_setattr,
 	.listxattr = reiserfs_listxattr,
 	.permission = reiserfs_permission,
-	.get_acl = reiserfs_get_acl,
+	.get_inode_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
 	.fileattr_get = reiserfs_fileattr_get,
 	.fileattr_set = reiserfs_fileattr_set,
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 3d7a35d6a18b..4d428e8704bc 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1659,7 +1659,7 @@ const struct inode_operations reiserfs_dir_inode_operations = {
 	.setattr = reiserfs_setattr,
 	.listxattr = reiserfs_listxattr,
 	.permission = reiserfs_permission,
-	.get_acl = reiserfs_get_acl,
+	.get_inode_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
 	.fileattr_get = reiserfs_fileattr_get,
 	.fileattr_set = reiserfs_fileattr_set,
@@ -1683,6 +1683,6 @@ const struct inode_operations reiserfs_special_inode_operations = {
 	.setattr = reiserfs_setattr,
 	.listxattr = reiserfs_listxattr,
 	.permission = reiserfs_permission,
-	.get_acl = reiserfs_get_acl,
+	.get_inode_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
 };
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ebc55195fa91..af9f8162bed9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1089,7 +1089,7 @@ xfs_vn_tmpfile(
 }
 
 static const struct inode_operations xfs_inode_operations = {
-	.get_acl		= xfs_get_acl,
+	.get_inode_acl		= xfs_get_acl,
 	.set_acl		= xfs_set_acl,
 	.getattr		= xfs_vn_getattr,
 	.setattr		= xfs_vn_setattr,
@@ -1116,7 +1116,7 @@ static const struct inode_operations xfs_dir_inode_operations = {
 	.rmdir			= xfs_vn_unlink,
 	.mknod			= xfs_vn_mknod,
 	.rename			= xfs_vn_rename,
-	.get_acl		= xfs_get_acl,
+	.get_inode_acl		= xfs_get_acl,
 	.set_acl		= xfs_set_acl,
 	.getattr		= xfs_vn_getattr,
 	.setattr		= xfs_vn_setattr,
@@ -1143,7 +1143,7 @@ static const struct inode_operations xfs_dir_ci_inode_operations = {
 	.rmdir			= xfs_vn_unlink,
 	.mknod			= xfs_vn_mknod,
 	.rename			= xfs_vn_rename,
-	.get_acl		= xfs_get_acl,
+	.get_inode_acl		= xfs_get_acl,
 	.set_acl		= xfs_set_acl,
 	.getattr		= xfs_vn_getattr,
 	.setattr		= xfs_vn_setattr,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bfb4522a4a6d..11cddd040578 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -560,8 +560,8 @@ struct posix_acl;
 #define ACL_NOT_CACHED ((void *)(-1))
 /*
  * ACL_DONT_CACHE is for stacked filesystems, that rely on underlying fs to
- * cache the ACL.  This also means that ->get_acl() can be called in RCU mode
- * with the LOOKUP_RCU flag.
+ * cache the ACL.  This also means that ->get_inode_acl() can be called in RCU
+ * mode with the LOOKUP_RCU flag.
  */
 #define ACL_DONT_CACHE ((void *)(-3))
 
@@ -2138,7 +2138,7 @@ struct inode_operations {
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct user_namespace *, struct inode *, int);
-	struct posix_acl * (*get_acl)(struct inode *, int, bool);
+	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
-- 
2.34.1

