Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F4602AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJRL5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJRL5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCD9AEA2A;
        Tue, 18 Oct 2022 04:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB1961537;
        Tue, 18 Oct 2022 11:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1D5C433D7;
        Tue, 18 Oct 2022 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094244;
        bh=mZ/XLnPjB3eTw2ntN4x6fA1FQxwKsQlwP+x0bj4ipqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAgt95uxRtYl+3KrFtAMkyV5U4bcglbRkOyJWmcD/sAlidhkzUbDwShAr0WxYEnNJ
         afUGGShxX3IL/Z7bdeNxL2qMsl3jWOCghYiYoecj/Yha+jR4Okf9QhO73Lj+h4jtaG
         14U3w+imAEFjaG1tsXOVCQK/z+ADk1qRjjzG60YiUvilYdSyoSoSvjA1ZX3YtR2GU2
         +zNGjofFJSf3nqthuC8WUIt0TF8p5nCR0poklkJkJy9BW9HXcVSXOQrKoLX3kQG7ID
         KyV0Pbwb43Q739dfkzHppw+LNXfxi8SrOFLPTE+WNp9xfmeXjr9EIwd+MLfgb5RVPM
         ADS+HoYbXg88g==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 03/30] fs: rename current get acl method
Date:   Tue, 18 Oct 2022 13:56:33 +0200
Message-Id: <20221018115700.166010-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=40850; i=brauner@kernel.org; h=from:subject; bh=mZ/XLnPjB3eTw2ntN4x6fA1FQxwKsQlwP+x0bj4ipqs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVFVXTQ3kcXgwloxyRV7xA4JPFleX2Rje361MU+aWfiL +jcfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy/RHD/6In+1cU/7n4N6xhvscspb 9r2xyWLpqVVSKePn1pYsEr3ZWMDC+Mnpl2dvwSff9U78TNts8bTx8ycNT5/C9w5hNrM+9bq3gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
    
    /* v3 */
    unchanged
    
    /* v4 */
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    
    Christoph Hellwig <hch@lst.de>:
    - Also rename get_acl() to get_inode_acl().
    
    /* v5 */
    unchanged

 Documentation/filesystems/locking.rst |  4 +--
 Documentation/filesystems/porting.rst |  4 +--
 Documentation/filesystems/vfs.rst     |  2 +-
 fs/9p/vfs_inode_dotl.c                |  4 +--
 fs/bad_inode.c                        |  2 +-
 fs/btrfs/inode.c                      |  6 ++--
 fs/ceph/dir.c                         |  2 +-
 fs/ceph/inode.c                       |  2 +-
 fs/erofs/inode.c                      |  6 ++--
 fs/erofs/namei.c                      |  2 +-
 fs/ext2/file.c                        |  2 +-
 fs/ext2/namei.c                       |  4 +--
 fs/ext4/file.c                        |  2 +-
 fs/ext4/ialloc.c                      |  2 +-
 fs/ext4/namei.c                       |  4 +--
 fs/f2fs/file.c                        |  2 +-
 fs/f2fs/namei.c                       |  4 +--
 fs/fuse/dir.c                         |  4 +--
 fs/gfs2/inode.c                       |  4 +--
 fs/jffs2/dir.c                        |  2 +-
 fs/jffs2/file.c                       |  2 +-
 fs/jfs/file.c                         |  2 +-
 fs/jfs/namei.c                        |  2 +-
 fs/ksmbd/smb2pdu.c                    |  4 +--
 fs/ksmbd/smbacl.c                     |  2 +-
 fs/ksmbd/vfs.c                        |  4 +--
 fs/namei.c                            |  4 +--
 fs/nfs/nfs3acl.c                      |  6 ++--
 fs/nfs/nfs3proc.c                     |  4 +--
 fs/nfsd/nfs2acl.c                     |  4 +--
 fs/nfsd/nfs3acl.c                     |  4 +--
 fs/nfsd/nfs4acl.c                     |  4 +--
 fs/ntfs3/file.c                       |  2 +-
 fs/ntfs3/namei.c                      |  4 +--
 fs/ocfs2/file.c                       |  4 +--
 fs/ocfs2/namei.c                      |  2 +-
 fs/orangefs/inode.c                   |  2 +-
 fs/orangefs/namei.c                   |  2 +-
 fs/overlayfs/dir.c                    |  2 +-
 fs/overlayfs/inode.c                  |  6 ++--
 fs/posix_acl.c                        | 43 ++++++++++++++-------------
 fs/reiserfs/file.c                    |  2 +-
 fs/reiserfs/namei.c                   |  4 +--
 fs/reiserfs/xattr_acl.c               |  2 +-
 fs/xfs/xfs_iops.c                     |  6 ++--
 include/linux/fs.h                    |  6 ++--
 include/linux/posix_acl.h             |  2 +-
 47 files changed, 98 insertions(+), 97 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 8f737e76935c..0eebbbb299da 100644
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
@@ -104,7 +104,7 @@ readlink:	no
 get_link:	no
 setattr:	exclusive
 permission:	no (may not block if called in rcu-walk mode)
-get_acl:	no
+get_inode_acl:	no
 getattr:	no
 listxattr:	no
 fiemap:		no
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index df0dc37e6f58..d2d684ae7798 100644
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
index cbf3088617c7..cebede60db98 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -435,7 +435,7 @@ As of kernel 2.6.22, the following members are defined:
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
index bc9917d372ed..92737166203f 100644
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
index 312ba03c56ae..7a3076ccbab4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11288,7 +11288,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 	.mknod		= btrfs_mknod,
 	.listxattr	= btrfs_listxattr,
 	.permission	= btrfs_permission,
-	.get_acl	= btrfs_get_acl,
+	.get_inode_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 	.tmpfile        = btrfs_tmpfile,
@@ -11341,7 +11341,7 @@ static const struct inode_operations btrfs_file_inode_operations = {
 	.listxattr      = btrfs_listxattr,
 	.permission	= btrfs_permission,
 	.fiemap		= btrfs_fiemap,
-	.get_acl	= btrfs_get_acl,
+	.get_inode_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 	.fileattr_get	= btrfs_fileattr_get,
@@ -11352,7 +11352,7 @@ static const struct inode_operations btrfs_special_inode_operations = {
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
index ca8aef906dc1..31cd27843eca 100644
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
index ad2a82f2eb4c..2d571343deec 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -371,7 +371,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 const struct inode_operations erofs_generic_iops = {
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
-	.get_acl = erofs_get_acl,
+	.get_inode_acl = erofs_get_acl,
 	.fiemap = erofs_fiemap,
 };
 
@@ -379,12 +379,12 @@ const struct inode_operations erofs_symlink_iops = {
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
index 0dc34721080c..b64a108fac92 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -228,6 +228,6 @@ const struct inode_operations erofs_dir_iops = {
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
index 9125eab85146..c056957221a2 100644
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
index a7a597c727e6..7ac0a81bd371 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -955,7 +955,7 @@ const struct inode_operations ext4_file_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_file_getattr,
 	.listxattr	= ext4_listxattr,
-	.get_acl	= ext4_get_acl,
+	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap		= ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bc46684106..67a257a69758 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -870,7 +870,7 @@ static int ext4_xattr_credits_for_new_inode(struct inode *dir, mode_t mode,
 	struct super_block *sb = dir->i_sb;
 	int nblocks = 0;
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
-	struct posix_acl *p = get_acl(dir, ACL_TYPE_DEFAULT);
+	struct posix_acl *p = get_inode_acl(dir, ACL_TYPE_DEFAULT);
 
 	if (IS_ERR(p))
 		return PTR_ERR(p);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d5daaf41e1fc..b8a91d74fdd1 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4186,7 +4186,7 @@ const struct inode_operations ext4_dir_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
-	.get_acl	= ext4_get_acl,
+	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap         = ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
@@ -4197,6 +4197,6 @@ const struct inode_operations ext4_special_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
-	.get_acl	= ext4_get_acl,
+	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 };
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 122339482bdc..83df6f6173d3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1046,7 +1046,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 const struct inode_operations f2fs_file_inode_operations = {
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
-	.get_acl	= f2fs_get_acl,
+	.get_inode_acl	= f2fs_get_acl,
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a389772fd212..c227113b0f26 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1379,7 +1379,7 @@ const struct inode_operations f2fs_dir_inode_operations = {
 	.tmpfile	= f2fs_tmpfile,
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
-	.get_acl	= f2fs_get_acl,
+	.get_inode_acl	= f2fs_get_acl,
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
@@ -1397,7 +1397,7 @@ const struct inode_operations f2fs_symlink_inode_operations = {
 const struct inode_operations f2fs_special_inode_operations = {
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
-	.get_acl	= f2fs_get_acl,
+	.get_inode_acl	= f2fs_get_acl,
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 };
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bb97a384dc5d..25e6b0f7e73d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1935,7 +1935,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
-	.get_acl	= fuse_get_acl,
+	.get_inode_acl	= fuse_get_acl,
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
@@ -1957,7 +1957,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
-	.get_acl	= fuse_get_acl,
+	.get_inode_acl	= fuse_get_acl,
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 314b9ce70682..1371e067d2a7 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2149,7 +2149,7 @@ static const struct inode_operations gfs2_file_iops = {
 	.getattr = gfs2_getattr,
 	.listxattr = gfs2_listxattr,
 	.fiemap = gfs2_fiemap,
-	.get_acl = gfs2_get_acl,
+	.get_inode_acl = gfs2_get_acl,
 	.set_acl = gfs2_set_acl,
 	.update_time = gfs2_update_time,
 	.fileattr_get = gfs2_fileattr_get,
@@ -2171,7 +2171,7 @@ static const struct inode_operations gfs2_dir_iops = {
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
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2466edc57424..9306e10753f9 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2487,9 +2487,9 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
 	fattr->cf_dacls = NULL;
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
-		fattr->cf_acls = get_acl(inode, ACL_TYPE_ACCESS);
+		fattr->cf_acls = get_inode_acl(inode, ACL_TYPE_ACCESS);
 		if (S_ISDIR(inode->i_mode))
-			fattr->cf_dacls = get_acl(inode, ACL_TYPE_DEFAULT);
+			fattr->cf_dacls = get_inode_acl(inode, ACL_TYPE_DEFAULT);
 	}
 }
 
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index a1e05fe997fe..ab5c68cc0e13 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1289,7 +1289,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	}
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
-		posix_acls = get_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
+		posix_acls = get_inode_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
 		if (posix_acls && !found) {
 			unsigned int id = -1;
 
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 7dee8b78762d..93f65f01a4a6 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1375,7 +1375,7 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
 		return NULL;
 
-	posix_acls = get_acl(inode, acl_type);
+	posix_acls = get_inode_acl(inode, acl_type);
 	if (!posix_acls)
 		return NULL;
 
@@ -1884,7 +1884,7 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
 		return -EOPNOTSUPP;
 
-	acls = get_acl(parent_inode, ACL_TYPE_DEFAULT);
+	acls = get_inode_acl(parent_inode, ACL_TYPE_DEFAULT);
 	if (!acls)
 		return -ENOENT;
 	pace = acls->a_entries;
diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..1c80fd23cda2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -297,13 +297,13 @@ static int check_acl(struct user_namespace *mnt_userns,
 		acl = get_cached_acl_rcu(inode, ACL_TYPE_ACCESS);
 	        if (!acl)
 	                return -EAGAIN;
-		/* no ->get_acl() calls in RCU mode... */
+		/* no ->get_inode_acl() calls in RCU mode... */
 		if (is_uncached_acl(acl))
 			return -ECHILD;
 	        return posix_acl_permission(mnt_userns, inode, acl, mask);
 	}
 
-	acl = get_acl(inode, ACL_TYPE_ACCESS);
+	acl = get_inode_acl(inode, ACL_TYPE_ACCESS);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl) {
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 22890d97a9e4..74d11e3c4205 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -265,14 +265,14 @@ int nfs3_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (S_ISDIR(inode->i_mode)) {
 		switch(type) {
 		case ACL_TYPE_ACCESS:
-			alloc = get_acl(inode, ACL_TYPE_DEFAULT);
+			alloc = get_inode_acl(inode, ACL_TYPE_DEFAULT);
 			if (IS_ERR(alloc))
 				goto fail;
 			dfacl = alloc;
 			break;
 
 		case ACL_TYPE_DEFAULT:
-			alloc = get_acl(inode, ACL_TYPE_ACCESS);
+			alloc = get_inode_acl(inode, ACL_TYPE_ACCESS);
 			if (IS_ERR(alloc))
 				goto fail;
 			dfacl = acl;
@@ -313,7 +313,7 @@ nfs3_list_one_acl(struct inode *inode, int type, const char *name, void *data,
 	struct posix_acl *acl;
 	char *p = data + *result;
 
-	acl = get_acl(inode, type);
+	acl = get_inode_acl(inode, type);
 	if (IS_ERR_OR_NULL(acl))
 		return 0;
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2e7579626cf0..4bf208a0a8e9 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -998,7 +998,7 @@ static const struct inode_operations nfs3_dir_inode_operations = {
 	.setattr	= nfs_setattr,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
-	.get_acl	= nfs3_get_acl,
+	.get_inode_acl	= nfs3_get_acl,
 	.set_acl	= nfs3_set_acl,
 #endif
 };
@@ -1009,7 +1009,7 @@ static const struct inode_operations nfs3_file_inode_operations = {
 	.setattr	= nfs_setattr,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
-	.get_acl	= nfs3_get_acl,
+	.get_inode_acl	= nfs3_get_acl,
 	.set_acl	= nfs3_set_acl,
 #endif
 };
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index b1839638500c..c43c25a8da2e 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -55,7 +55,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 		goto out;
 
 	if (resp->mask & (NFS_ACL|NFS_ACLCNT)) {
-		acl = get_acl(inode, ACL_TYPE_ACCESS);
+		acl = get_inode_acl(inode, ACL_TYPE_ACCESS);
 		if (acl == NULL) {
 			/* Solaris returns the inode's minimum ACL. */
 			acl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
@@ -69,7 +69,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 	if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
 		/* Check how Solaris handles requests for the Default ACL
 		   of a non-directory! */
-		acl = get_acl(inode, ACL_TYPE_DEFAULT);
+		acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
 		if (IS_ERR(acl)) {
 			resp->status = nfserrno(PTR_ERR(acl));
 			goto fail;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index da4a0d09bd84..9daa621817d8 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -47,7 +47,7 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 	resp->mask = argp->mask;
 
 	if (resp->mask & (NFS_ACL|NFS_ACLCNT)) {
-		acl = get_acl(inode, ACL_TYPE_ACCESS);
+		acl = get_inode_acl(inode, ACL_TYPE_ACCESS);
 		if (acl == NULL) {
 			/* Solaris returns the inode's minimum ACL. */
 			acl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
@@ -61,7 +61,7 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 	if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
 		/* Check how Solaris handles requests for the Default ACL
 		   of a non-directory! */
-		acl = get_acl(inode, ACL_TYPE_DEFAULT);
+		acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
 		if (IS_ERR(acl)) {
 			resp->status = nfserrno(PTR_ERR(acl));
 			goto fail;
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index bb8e2f6d7d03..518203821790 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -135,7 +135,7 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 	unsigned int flags = 0;
 	int size = 0;
 
-	pacl = get_acl(inode, ACL_TYPE_ACCESS);
+	pacl = get_inode_acl(inode, ACL_TYPE_ACCESS);
 	if (!pacl)
 		pacl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
 
@@ -147,7 +147,7 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 
 	if (S_ISDIR(inode->i_mode)) {
 		flags = NFS4_ACL_DIR;
-		dpacl = get_acl(inode, ACL_TYPE_DEFAULT);
+		dpacl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
 		if (IS_ERR(dpacl)) {
 			error = PTR_ERR(dpacl);
 			goto rel_pacl;
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
index 9e61511de7a7..6eefd8b7868e 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -517,7 +517,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 		const struct cred *old_cred;
 
 		old_cred = ovl_override_creds(inode->i_sb);
-		acl = get_acl(realinode, type);
+		acl = get_inode_acl(realinode, type);
 		revert_creds(old_cred);
 	}
 	/*
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
index 58d97fd30af2..912faf932781 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -64,7 +64,7 @@ struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type)
 	if (acl == ACL_DONT_CACHE) {
 		struct posix_acl *ret;
 
-		ret = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
+		ret = inode->i_op->get_inode_acl(inode, type, LOOKUP_RCU);
 		if (!IS_ERR(ret))
 			acl = ret;
 	}
@@ -106,7 +106,7 @@ void forget_all_cached_acls(struct inode *inode)
 }
 EXPORT_SYMBOL(forget_all_cached_acls);
 
-struct posix_acl *get_acl(struct inode *inode, int type)
+struct posix_acl *get_inode_acl(struct inode *inode, int type)
 {
 	void *sentinel;
 	struct posix_acl **p;
@@ -114,7 +114,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 
 	/*
 	 * The sentinel is used to detect when another operation like
-	 * set_cached_acl() or forget_cached_acl() races with get_acl().
+	 * set_cached_acl() or forget_cached_acl() races with get_inode_acl().
 	 * It is guaranteed that is_uncached_acl(sentinel) is true.
 	 */
 
@@ -133,24 +133,24 @@ struct posix_acl *get_acl(struct inode *inode, int type)
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
-	 * If the filesystem doesn't have a get_acl() function at all, we'll
-	 * just create the negative cache entry.
+	 * If the filesystem doesn't have a get_inode_acl() function at all,
+	 * we'll just create the negative cache entry.
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
@@ -169,7 +169,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 		posix_acl_release(acl);
 	return acl;
 }
-EXPORT_SYMBOL(get_acl);
+EXPORT_SYMBOL(get_inode_acl);
 
 /*
  * Init a fresh posix_acl
@@ -600,7 +600,7 @@ int
 	if (!inode->i_op->set_acl)
 		return -EOPNOTSUPP;
 
-	acl = get_acl(inode, ACL_TYPE_ACCESS);
+	acl = get_inode_acl(inode, ACL_TYPE_ACCESS);
 	if (IS_ERR_OR_NULL(acl)) {
 		if (acl == ERR_PTR(-EOPNOTSUPP))
 			return 0;
@@ -630,7 +630,7 @@ posix_acl_create(struct inode *dir, umode_t *mode,
 	if (S_ISLNK(*mode) || !IS_POSIXACL(dir))
 		return 0;
 
-	p = get_acl(dir, ACL_TYPE_DEFAULT);
+	p = get_inode_acl(dir, ACL_TYPE_DEFAULT);
 	if (!p || p == ERR_PTR(-EOPNOTSUPP)) {
 		*mode &= ~current_umask();
 		return 0;
@@ -1045,7 +1045,8 @@ posix_acl_from_xattr_kgid(struct user_namespace *mnt_userns,
  * Filesystems that store POSIX ACLs in the unaltered uapi format should use
  * posix_acl_from_xattr() when reading them from the backing store and
  * converting them into the struct posix_acl VFS format. The helper is
- * specifically intended to be called from the ->get_acl() inode operation.
+ * specifically intended to be called from the ->get_inode_acl() inode
+ * operation.
  *
  * The posix_acl_from_xattr() function will map the raw {g,u}id values stored
  * in ACL_{GROUP,USER} entries into the filesystem idmapping in @fs_userns. The
@@ -1053,11 +1054,11 @@ posix_acl_from_xattr_kgid(struct user_namespace *mnt_userns,
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
@@ -1127,7 +1128,7 @@ posix_acl_xattr_get(const struct xattr_handler *handler,
 	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
 
-	acl = get_acl(inode, handler->flags);
+	acl = get_inode_acl(inode, handler->flags);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl == NULL)
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
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index 966ba48e33ec..93fe414fed18 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -372,7 +372,7 @@ int reiserfs_cache_default_acl(struct inode *inode)
 	if (IS_PRIVATE(inode))
 		return 0;
 
-	acl = get_acl(inode, ACL_TYPE_DEFAULT);
+	acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
 
 	if (acl && !IS_ERR(acl)) {
 		int size = reiserfs_acl_size(acl->a_count);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ab266ba65a84..712238305bc3 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1103,7 +1103,7 @@ xfs_vn_tmpfile(
 }
 
 static const struct inode_operations xfs_inode_operations = {
-	.get_acl		= xfs_get_acl,
+	.get_inode_acl		= xfs_get_acl,
 	.set_acl		= xfs_set_acl,
 	.getattr		= xfs_vn_getattr,
 	.setattr		= xfs_vn_setattr,
@@ -1130,7 +1130,7 @@ static const struct inode_operations xfs_dir_inode_operations = {
 	.rmdir			= xfs_vn_unlink,
 	.mknod			= xfs_vn_mknod,
 	.rename			= xfs_vn_rename,
-	.get_acl		= xfs_get_acl,
+	.get_inode_acl		= xfs_get_acl,
 	.set_acl		= xfs_set_acl,
 	.getattr		= xfs_vn_getattr,
 	.setattr		= xfs_vn_setattr,
@@ -1157,7 +1157,7 @@ static const struct inode_operations xfs_dir_ci_inode_operations = {
 	.rmdir			= xfs_vn_unlink,
 	.mknod			= xfs_vn_mknod,
 	.rename			= xfs_vn_rename,
-	.get_acl		= xfs_get_acl,
+	.get_inode_acl		= xfs_get_acl,
 	.set_acl		= xfs_set_acl,
 	.getattr		= xfs_vn_getattr,
 	.setattr		= xfs_vn_setattr,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3db0b23c6a55..2395e1388e2e 100644
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
 
@@ -2142,7 +2142,7 @@ struct inode_operations {
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct user_namespace *, struct inode *, int);
-	struct posix_acl * (*get_acl)(struct inode *, int, bool);
+	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index cd16a756cd1e..07e171b4428a 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -128,6 +128,6 @@ static inline void forget_all_cached_acls(struct inode *inode)
 }
 #endif /* CONFIG_FS_POSIX_ACL */
 
-struct posix_acl *get_acl(struct inode *inode, int type);
+struct posix_acl *get_inode_acl(struct inode *inode, int type);
 
 #endif  /* __LINUX_POSIX_ACL_H */
-- 
2.34.1

