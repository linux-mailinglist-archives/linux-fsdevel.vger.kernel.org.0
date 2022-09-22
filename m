Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806EB5E66AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiIVPR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIVPR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:17:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09386EEEBD
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F473B83838
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CF2C43470;
        Thu, 22 Sep 2022 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859870;
        bh=zTCWdBIYj3UTZTYmqeXgIE4fWMpccYkOyUYLaTOMruM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBDboKsRFOMpTmzH72N03Sio3Klb7HItFqKFf0eEy7eS/+ZD3ZCCEizoFGsdex/2y
         IAb6m2636iRAQjEbZDRLC0kcVwLoWTpLw1YcdGmO905NEYeChB01sXG2N0ssXc9kcp
         yDJG0CYVDG+uhrL306v2nQ+KrfRpsfTbCa0VHZFtvXzyaJ5TOI4a3Z8FyUl9/H6fbz
         xK1DOpqTTsMwQc8NzRiUgEtxrCAEPFzSNPgMMj3Av5GE3XYDnLToxOMLJc7RGrKPNZ
         6iUIno8w9w8i4Y8sXCr6WQrTTqsUiObLeQZansfwYcZ/jnqn81onf/AACdNe/C8bsa
         66dYmk2rAEX3Q==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 01/29] fs: pass dentry to set acl method
Date:   Thu, 22 Sep 2022 17:16:59 +0200
Message-Id: <20220922151728.1557914-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=50444; i=brauner@kernel.org; h=from:subject; bh=zTCWdBIYj3UTZTYmqeXgIE4fWMpccYkOyUYLaTOMruM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1JRlcFT9NZTouFyysnXPp6BZNmztporXCy7uKq2ICV30 i/VyRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES05Rn+p9SfusLef+zUdMOrB6Zc+c 1ipnj6p9vxo6cVxOR7V186ysvI0HHt9cM1/6fv5/jh5brum5sen+CJsPIfmmxyWqWzrtybwQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Since some filesystem rely on the dentry being available to them when
setting posix acls (e.g., 9p and cifs) they cannot rely on set acl inode
operation. But since ->set_acl() is required in order to use the generic
posix acl xattr handlers filesystems that do not implement this inode
operation cannot use the handler and need to implement their own
dedicated posix acl handlers.

Update the ->set_acl() inode method to take a dentry argument. This
allows all filesystems to rely on ->set_acl().

As far as I can tell all codepaths can be switched to rely on the dentry
instead of just the inode. Note that the original motivation for passing
the dentry separate from the inode instead of just the dentry in the
xattr handlers was because of security modules that call
security_d_instantiate(). This hook is called during
d_instantiate_new(), d_add(), __d_instantiate_anon(), and
d_splice_alias() to initialize the inode's security context and possibly
to set security.* xattrs. Since this only affects security.* xattrs this
is completely irrelevant for posix acls.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/bad_inode.c                |  2 +-
 fs/btrfs/acl.c                |  3 ++-
 fs/btrfs/ctree.h              |  2 +-
 fs/btrfs/inode.c              |  2 +-
 fs/ceph/acl.c                 |  3 ++-
 fs/ceph/inode.c               |  2 +-
 fs/ceph/super.h               |  2 +-
 fs/ext2/acl.c                 |  3 ++-
 fs/ext2/acl.h                 |  2 +-
 fs/ext2/inode.c               |  2 +-
 fs/ext4/acl.c                 |  3 ++-
 fs/ext4/acl.h                 |  2 +-
 fs/ext4/inode.c               |  2 +-
 fs/f2fs/acl.c                 |  4 ++-
 fs/f2fs/acl.h                 |  2 +-
 fs/f2fs/file.c                |  2 +-
 fs/fuse/acl.c                 |  3 ++-
 fs/fuse/fuse_i.h              |  2 +-
 fs/gfs2/acl.c                 |  3 ++-
 fs/gfs2/acl.h                 |  2 +-
 fs/gfs2/inode.c               |  2 +-
 fs/jffs2/acl.c                |  3 ++-
 fs/jffs2/acl.h                |  2 +-
 fs/jffs2/fs.c                 |  2 +-
 fs/jfs/acl.c                  |  3 ++-
 fs/jfs/file.c                 |  2 +-
 fs/jfs/jfs_acl.h              |  2 +-
 fs/ksmbd/smb2pdu.c            |  4 +--
 fs/ksmbd/smbacl.c             |  4 +--
 fs/ksmbd/vfs.c                | 15 +++++------
 fs/ksmbd/vfs.h                |  4 +--
 fs/nfs/nfs3_fs.h              |  2 +-
 fs/nfs/nfs3acl.c              |  3 ++-
 fs/nfsd/nfs2acl.c             |  4 +--
 fs/nfsd/nfs3acl.c             |  4 +--
 fs/nfsd/vfs.c                 |  4 +--
 fs/ntfs3/file.c               |  2 +-
 fs/ntfs3/ntfs_fs.h            |  4 +--
 fs/ntfs3/xattr.c              |  9 ++++---
 fs/ocfs2/acl.c                |  3 ++-
 fs/ocfs2/acl.h                |  2 +-
 fs/orangefs/acl.c             | 47 +++--------------------------------
 fs/orangefs/inode.c           | 45 +++++++++++++++++++++++++++------
 fs/orangefs/orangefs-kernel.h |  9 ++++---
 fs/orangefs/orangefs-utils.c  | 12 ++++++---
 fs/posix_acl.c                | 18 ++++++++------
 fs/reiserfs/acl.h             |  6 ++---
 fs/reiserfs/inode.c           |  2 +-
 fs/reiserfs/xattr_acl.c       |  9 ++++---
 fs/xfs/xfs_acl.c              |  3 ++-
 fs/xfs/xfs_acl.h              |  2 +-
 fs/xfs/xfs_iops.c             | 10 +++++---
 include/linux/fs.h            |  2 +-
 include/linux/posix_acl.h     |  8 +++---
 mm/shmem.c                    |  2 +-
 55 files changed, 163 insertions(+), 140 deletions(-)

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 12b8fdcc445b..bc67beab5f16 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -154,7 +154,7 @@ static int bad_inode_tmpfile(struct user_namespace *mnt_userns,
 }
 
 static int bad_inode_set_acl(struct user_namespace *mnt_userns,
-			     struct inode *inode, struct posix_acl *acl,
+			     struct dentry *dentry, struct posix_acl *acl,
 			     int type)
 {
 	return -EIO;
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index 548d6a5477b4..1e47b3ec3989 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -110,10 +110,11 @@ int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 	return ret;
 }
 
-int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int btrfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct posix_acl *acl, int type)
 {
 	int ret;
+	struct inode *inode = d_inode(dentry);
 	umode_t old_mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9ef162dbd4bc..24bed1d89460 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3941,7 +3941,7 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 /* acl.c */
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
-int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int btrfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct posix_acl *acl, int type);
 int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 		    struct posix_acl *acl, int type);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ad250892028d..29884b729ca3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5262,7 +5262,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 		err = btrfs_dirty_inode(inode);
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
+			err = posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
 	}
 
 	return err;
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index f4fc8e0b847c..c7e8dd5b58d4 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -85,13 +85,14 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
-int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ceph_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	int ret = 0, size = 0;
 	const char *name = NULL;
 	char *value = NULL;
 	struct iattr newattrs;
+	struct inode *inode = d_inode(dentry);
 	struct timespec64 old_ctime = inode->i_ctime;
 	umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 42351d7a0dd6..a23fc1e90f66 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2254,7 +2254,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	err = __ceph_setattr(inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
+		err = posix_acl_chmod(&init_user_ns, dentry, attr->ia_mode);
 
 	return err;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 40630e6f691c..50e57a1fa32f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1117,7 +1117,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);
 
 struct posix_acl *ceph_get_acl(struct inode *, int, bool);
 int ceph_set_acl(struct user_namespace *mnt_userns,
-		 struct inode *inode, struct posix_acl *acl, int type);
+		 struct dentry *dentry, struct posix_acl *acl, int type);
 int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 		       struct ceph_acl_sec_ctx *as_ctx);
 void ceph_init_inode_acls(struct inode *inode,
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index bf298967c5b8..440d5f1e9d47 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -219,11 +219,12 @@ __ext2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
  * inode->i_mutex: down
  */
 int
-ext2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+ext2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	     struct posix_acl *acl, int type)
 {
 	int error;
 	int update_mode = 0;
+	struct inode *inode = d_inode(dentry);
 	umode_t mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
index 925ab6287d35..3841becb94ff 100644
--- a/fs/ext2/acl.h
+++ b/fs/ext2/acl.h
@@ -56,7 +56,7 @@ static inline int ext2_acl_count(size_t size)
 
 /* acl.c */
 extern struct posix_acl *ext2_get_acl(struct inode *inode, int type, bool rcu);
-extern int ext2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+extern int ext2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 			struct posix_acl *acl, int type);
 extern int ext2_init_acl (struct inode *, struct inode *);
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 918ab2f9e4c0..e97e77be64f3 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1652,7 +1652,7 @@ int ext2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 	setattr_copy(&init_user_ns, inode, iattr);
 	if (iattr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
 	mark_inode_dirty(inode);
 
 	return error;
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 57e82e25f8e2..a9f89539aeee 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -225,12 +225,13 @@ __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
 }
 
 int
-ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+ext4_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	     struct posix_acl *acl, int type)
 {
 	handle_t *handle;
 	int error, credits, retries = 0;
 	size_t acl_size = acl ? ext4_acl_size(acl->a_count) : 0;
+	struct inode *inode = d_inode(dentry);
 	umode_t mode = inode->i_mode;
 	int update_mode = 0;
 
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 3219669732bf..09c4a8a3b716 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -56,7 +56,7 @@ static inline int ext4_acl_count(size_t size)
 
 /* acl.c */
 struct posix_acl *ext4_get_acl(struct inode *inode, int type, bool rcu);
-int ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ext4_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..73c8af3f0268 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5540,7 +5540,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		ext4_orphan_del(NULL, inode);
 
 	if (!error && (ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
+		rc = posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
 
 err_out:
 	if  (error)
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index eaa240b21f07..cf353e8c30e3 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -276,9 +276,11 @@ static int __f2fs_set_acl(struct user_namespace *mnt_userns,
 	return error;
 }
 
-int f2fs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int f2fs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
+	struct inode *inode = d_inode(dentry);
+
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index a26e33cab4ff..ea2bbb3f264b 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -34,7 +34,7 @@ struct f2fs_acl_header {
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 
 extern struct posix_acl *f2fs_get_acl(struct inode *, int, bool);
-extern int f2fs_set_acl(struct user_namespace *, struct inode *,
+extern int f2fs_set_acl(struct user_namespace *, struct dentry *,
 			struct posix_acl *, int);
 extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
 							struct page *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ce4905a073b3..d5523625f590 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -978,7 +978,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	__setattr_copy(mnt_userns, inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
-		err = posix_acl_chmod(mnt_userns, inode, f2fs_get_inode_mode(inode));
+		err = posix_acl_chmod(mnt_userns, dentry, f2fs_get_inode_mode(inode));
 
 		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 			if (!err)
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 337cb29a8dd5..8edd0f313515 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -53,9 +53,10 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
-int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
+	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
 	int ret;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 488b460e046f..ca9b6eb5fd4e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1266,7 +1266,7 @@ extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
 
 struct posix_acl;
 struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu);
-int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 
 /* readdir.c */
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 734d1f05d823..3dcde4912413 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -109,9 +109,10 @@ int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	return error;
 }
 
-int gfs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int gfs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
+	struct inode *inode = d_inode(dentry);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	bool need_unlock = false;
diff --git a/fs/gfs2/acl.h b/fs/gfs2/acl.h
index cd180ca7c959..b8de8c148f5c 100644
--- a/fs/gfs2/acl.h
+++ b/fs/gfs2/acl.h
@@ -13,7 +13,7 @@
 
 extern struct posix_acl *gfs2_get_acl(struct inode *inode, int type, bool rcu);
 extern int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
-extern int gfs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+extern int gfs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 			struct posix_acl *acl, int type);
 
 #endif /* __ACL_DOT_H__ */
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c8ec876f33ea..f2bc97c6862f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1990,7 +1990,7 @@ static int gfs2_setattr(struct user_namespace *mnt_userns,
 	else {
 		error = gfs2_setattr_simple(inode, attr);
 		if (!error && attr->ia_valid & ATTR_MODE)
-			error = posix_acl_chmod(&init_user_ns, inode,
+			error = posix_acl_chmod(&init_user_ns, dentry,
 						inode->i_mode);
 	}
 
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index e945e3484788..8bb58ce5c06c 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -229,10 +229,11 @@ static int __jffs2_set_acl(struct inode *inode, int xprefix, struct posix_acl *a
 	return rc;
 }
 
-int jffs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int jffs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct posix_acl *acl, int type)
 {
 	int rc, xprefix;
+	struct inode *inode = d_inode(dentry);
 
 	switch (type) {
 	case ACL_TYPE_ACCESS:
diff --git a/fs/jffs2/acl.h b/fs/jffs2/acl.h
index 9d9fb7cf093e..ca36a6eca594 100644
--- a/fs/jffs2/acl.h
+++ b/fs/jffs2/acl.h
@@ -28,7 +28,7 @@ struct jffs2_acl_header {
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 
 struct posix_acl *jffs2_get_acl(struct inode *inode, int type, bool rcu);
-int jffs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int jffs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct posix_acl *acl, int type);
 extern int jffs2_init_acl_pre(struct inode *, struct inode *, umode_t *);
 extern int jffs2_init_acl_post(struct inode *);
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 39cec28096a7..66af51c41619 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -202,7 +202,7 @@ int jffs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	rc = jffs2_do_setattr(inode, iattr);
 	if (!rc && (iattr->ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+		rc = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
 
 	return rc;
 }
diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index a653f34c6e26..3b667eccc73b 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -94,12 +94,13 @@ static int __jfs_set_acl(tid_t tid, struct inode *inode, int type,
 	return rc;
 }
 
-int jfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int jfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct posix_acl *acl, int type)
 {
 	int rc;
 	tid_t tid;
 	int update_mode = 0;
+	struct inode *inode = d_inode(dentry);
 	umode_t mode = inode->i_mode;
 
 	tid = txBegin(inode->i_sb, 0);
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 332dc9ac47a9..e3eb9c36751f 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -123,7 +123,7 @@ int jfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE)
-		rc = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+		rc = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
 	return rc;
 }
 
diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
index 3de40286d31f..f0704a25835f 100644
--- a/fs/jfs/jfs_acl.h
+++ b/fs/jfs/jfs_acl.h
@@ -8,7 +8,7 @@
 #ifdef CONFIG_JFS_POSIX_ACL
 
 struct posix_acl *jfs_get_acl(struct inode *inode, int type, bool rcu);
-int jfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int jfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct posix_acl *acl, int type);
 int jfs_init_acl(tid_t, struct inode *, struct inode *);
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 19412ac701a6..19a273b8da65 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2952,7 +2952,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct inode *inode = d_inode(path.dentry);
 
 		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(user_ns,
-							   inode,
+							   path.dentry,
 							   d_inode(path.dentry->d_parent));
 		if (posix_acl_rc)
 			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
@@ -2968,7 +2968,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc) {
 				if (posix_acl_rc)
 					ksmbd_vfs_set_init_posix_acl(user_ns,
-								     inode);
+								     path.dentry);
 
 				if (test_share_config_flag(work->tcon->share_conf,
 							   KSMBD_SHARE_FLAG_ACL_XATTR)) {
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 3781bca2c8fc..ae318fcbef9f 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1384,14 +1384,14 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	ksmbd_vfs_remove_acl_xattrs(user_ns, path->dentry);
 	/* Update posix acls */
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && fattr.cf_dacls) {
-		rc = set_posix_acl(user_ns, inode,
+		rc = set_posix_acl(user_ns, path->dentry,
 				   ACL_TYPE_ACCESS, fattr.cf_acls);
 		if (rc < 0)
 			ksmbd_debug(SMB,
 				    "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
 				    rc);
 		if (S_ISDIR(inode->i_mode) && fattr.cf_dacls) {
-			rc = set_posix_acl(user_ns, inode,
+			rc = set_posix_acl(user_ns, path->dentry,
 					   ACL_TYPE_DEFAULT, fattr.cf_dacls);
 			if (rc)
 				ksmbd_debug(SMB,
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 78d01033604c..430962dd2efa 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1814,10 +1814,11 @@ void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
 }
 
 int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
-				 struct inode *inode)
+				 struct dentry *dentry)
 {
 	struct posix_acl_state acl_state;
 	struct posix_acl *acls;
+	struct inode *inode = d_inode(dentry);
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
@@ -1846,14 +1847,13 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 		return -ENOMEM;
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
-	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
+	rc = set_posix_acl(user_ns, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
 			    rc);
 	else if (S_ISDIR(inode->i_mode)) {
 		posix_state_to_acl(&acl_state, acls->a_entries);
-		rc = set_posix_acl(user_ns, inode, ACL_TYPE_DEFAULT,
-				   acls);
+		rc = set_posix_acl(user_ns, dentry, ACL_TYPE_DEFAULT, acls);
 		if (rc < 0)
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
@@ -1864,10 +1864,11 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 }
 
 int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
-				struct inode *inode, struct inode *parent_inode)
+				struct dentry *dentry, struct inode *parent_inode)
 {
 	struct posix_acl *acls;
 	struct posix_acl_entry *pace;
+	struct inode *inode = d_inode(dentry);
 	int rc, i;
 
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
@@ -1885,12 +1886,12 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 		}
 	}
 
-	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
+	rc = set_posix_acl(user_ns, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
 			    rc);
 	if (S_ISDIR(inode->i_mode)) {
-		rc = set_posix_acl(user_ns, inode, ACL_TYPE_DEFAULT,
+		rc = set_posix_acl(user_ns, dentry, ACL_TYPE_DEFAULT,
 				   acls);
 		if (rc < 0)
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 70da4c0ba7ad..4b9ac1ad18f8 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -158,8 +158,8 @@ int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
-				 struct inode *inode);
+				 struct dentry *dentry);
 int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
-				struct inode *inode,
+				struct dentry *dentry,
 				struct inode *parent_inode);
 #endif /* __KSMBD_VFS_H__ */
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index 03a4e679fd99..df9ca56db347 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -12,7 +12,7 @@
  */
 #ifdef CONFIG_NFS_V3_ACL
 extern struct posix_acl *nfs3_get_acl(struct inode *inode, int type, bool rcu);
-extern int nfs3_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+extern int nfs3_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 			struct posix_acl *acl, int type);
 extern int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 		struct posix_acl *dfacl);
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 93de0b58647a..22890d97a9e4 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -255,10 +255,11 @@ int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 
 }
 
-int nfs3_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int nfs3_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	struct posix_acl *orig = acl, *dfacl = NULL, *alloc;
+	struct inode *inode = d_inode(dentry);
 	int status;
 
 	if (S_ISDIR(inode->i_mode)) {
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 9edd3c1a30fb..c74b626cb1d8 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -113,11 +113,11 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
+	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_ACCESS,
 			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
+	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_DEFAULT,
 			      argp->acl_default);
 	if (error)
 		goto out_drop_lock;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 9446c6743664..61748c2322ac 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -103,11 +103,11 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
+	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_ACCESS,
 			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
+	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_DEFAULT,
 			      argp->acl_default);
 
 out_drop_lock:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..0cdcfab7ffb5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -457,12 +457,12 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			attr->na_seclabel->data, attr->na_seclabel->len);
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl)
 		attr->na_aclerr = set_posix_acl(&init_user_ns,
-						inode, ACL_TYPE_ACCESS,
+						dentry, ACL_TYPE_ACCESS,
 						attr->na_pacl);
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
 	    !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))
 		attr->na_aclerr = set_posix_acl(&init_user_ns,
-						inode, ACL_TYPE_DEFAULT,
+						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
 	inode_unlock(inode);
 	if (size_change)
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4f2ffc7ef296..ee5101e6bd68 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -802,7 +802,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(mnt_userns, inode, attr);
 
 	if (mode != inode->i_mode) {
-		err = ntfs_acl_chmod(mnt_userns, inode);
+		err = ntfs_acl_chmod(mnt_userns, dentry);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2c791222c4e2..a4d292809a33 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -843,7 +843,7 @@ int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
 /* globals from xattr.c */
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
 struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu);
-int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ntfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		  struct inode *dir);
@@ -852,7 +852,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 #define ntfs_set_acl NULL
 #endif
 
-int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode);
+int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dentry);
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask);
 ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 7de8718c68a9..aafe98ee0b21 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -619,10 +619,10 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 /*
  * ntfs_set_acl - inode_operations::set_acl
  */
-int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ntfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
-	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, false);
+	return ntfs_set_acl_ex(mnt_userns, d_inode(dentry), acl, type, false);
 }
 
 /*
@@ -664,8 +664,9 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 /*
  * ntfs_acl_chmod - Helper for ntfs3_setattr().
  */
-int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
+int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dentry)
 {
+	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = inode->i_sb;
 
 	if (!(sb->s_flags & SB_POSIXACL))
@@ -674,7 +675,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
 
-	return posix_acl_chmod(mnt_userns, inode, inode->i_mode);
+	return posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
 }
 
 /*
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 23a72a423955..9f19cf9a5a9f 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -260,12 +260,13 @@ static int ocfs2_set_acl(handle_t *handle,
 	return ret;
 }
 
-int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		      struct posix_acl *acl, int type)
 {
 	struct buffer_head *bh = NULL;
 	int status, had_lock;
 	struct ocfs2_lock_holder oh;
+	struct inode *inode = d_inode(dentry);
 
 	had_lock = ocfs2_inode_lock_tracker(inode, &bh, 1, &oh);
 	if (had_lock < 0)
diff --git a/fs/ocfs2/acl.h b/fs/ocfs2/acl.h
index 95a57c888ab6..a897c4e41b26 100644
--- a/fs/ocfs2/acl.h
+++ b/fs/ocfs2/acl.h
@@ -17,7 +17,7 @@ struct ocfs2_acl_entry {
 };
 
 struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type, bool rcu);
-int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		      struct posix_acl *acl, int type);
 extern int ocfs2_acl_chmod(struct inode *, struct buffer_head *);
 extern int ocfs2_init_acl(handle_t *, struct inode *, struct inode *,
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 605e5a3506ec..c5da2091cefb 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -64,8 +64,7 @@ struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
-static int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl,
-			      int type)
+int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
 	int error = 0;
 	void *value = NULL;
@@ -119,12 +118,13 @@ static int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl,
 	return error;
 }
 
-int orangefs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int orangefs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		     struct posix_acl *acl, int type)
 {
 	int error;
 	struct iattr iattr;
 	int rc;
+	struct inode *inode = d_inode(dentry);
 
 	memset(&iattr, 0, sizeof iattr);
 
@@ -153,46 +153,7 @@ int orangefs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	rc = __orangefs_set_acl(inode, acl, type);
 
 	if (!rc && (iattr.ia_valid == ATTR_MODE))
-		rc = __orangefs_setattr(inode, &iattr);
+		rc = __orangefs_setattr_mode(dentry, &iattr);
 
 	return rc;
 }
-
-int orangefs_init_acl(struct inode *inode, struct inode *dir)
-{
-	struct posix_acl *default_acl, *acl;
-	umode_t mode = inode->i_mode;
-	struct iattr iattr;
-	int error = 0;
-
-	error = posix_acl_create(dir, &mode, &default_acl, &acl);
-	if (error)
-		return error;
-
-	if (default_acl) {
-		error = __orangefs_set_acl(inode, default_acl,
-					   ACL_TYPE_DEFAULT);
-		posix_acl_release(default_acl);
-	} else {
-		inode->i_default_acl = NULL;
-	}
-
-	if (acl) {
-		if (!error)
-			error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
-		posix_acl_release(acl);
-	} else {
-		inode->i_acl = NULL;
-	}
-
-	/* If mode of the inode was changed, then do a forcible ->setattr */
-	if (mode != inode->i_mode) {
-		memset(&iattr, 0, sizeof iattr);
-		inode->i_mode = mode;
-		iattr.ia_mode = mode;
-		iattr.ia_valid |= ATTR_MODE;
-		__orangefs_setattr(inode, &iattr);
-	}
-
-	return error;
-}
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7a8c0c6e698d..825872d8d377 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -828,15 +828,23 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 	spin_unlock(&inode->i_lock);
 	mark_inode_dirty(inode);
 
-	if (iattr->ia_valid & ATTR_MODE)
-		/* change mod on a file that has ACLs */
-		ret = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
-
 	ret = 0;
 out:
 	return ret;
 }
 
+int __orangefs_setattr_mode(struct dentry *dentry, struct iattr *iattr)
+{
+	int ret;
+	struct inode *inode = d_inode(dentry);
+
+	ret = __orangefs_setattr(inode, iattr);
+	/* change mode on a file that has ACLs */
+	if (!ret && (iattr->ia_valid & ATTR_MODE))
+		ret = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
+	return ret;
+}
+
 /*
  * Change attributes of an object referenced by dentry.
  */
@@ -849,7 +857,7 @@ int orangefs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	ret = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (ret)
 	        goto out;
-	ret = __orangefs_setattr(d_inode(dentry), iattr);
+	ret = __orangefs_setattr_mode(dentry, iattr);
 	sync_inode_metadata(d_inode(dentry), 1);
 out:
 	gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_setattr: returning %d\n",
@@ -1097,8 +1105,9 @@ struct inode *orangefs_iget(struct super_block *sb,
  * Allocate an inode for a newly created file and insert it into the inode hash.
  */
 struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
-		int mode, dev_t dev, struct orangefs_object_kref *ref)
+		umode_t mode, dev_t dev, struct orangefs_object_kref *ref)
 {
+	struct posix_acl *acl = NULL, *default_acl = NULL;
 	unsigned long hash = orangefs_handle_hash(ref);
 	struct inode *inode;
 	int error;
@@ -1115,16 +1124,33 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	error = posix_acl_create(dir, &mode, &default_acl, &acl);
+	if (error)
+		goto out_iput;
+
 	orangefs_set_inode(inode, ref);
 	inode->i_ino = hash;	/* needed for stat etc */
 
-	error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
+	error = __orangefs_inode_getattr(inode, mode, ORANGEFS_GETATTR_NEW);
 	if (error)
 		goto out_iput;
 
 	orangefs_init_iops(inode);
 	inode->i_rdev = dev;
 
+	if (default_acl) {
+		error = __orangefs_set_acl(inode, default_acl,
+					   ACL_TYPE_DEFAULT);
+		if (error)
+			goto out_iput;
+	}
+
+	if (acl) {
+		error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
+		if (error)
+			goto out_iput;
+	}
+
 	error = insert_inode_locked4(inode, hash, orangefs_test_inode, ref);
 	if (error < 0)
 		goto out_iput;
@@ -1132,10 +1158,13 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	gossip_debug(GOSSIP_INODE_DEBUG,
 		     "Initializing ACL's for inode %pU\n",
 		     get_khandle_from_ino(inode));
-	orangefs_init_acl(inode, dir);
+	posix_acl_release(acl);
+	posix_acl_release(default_acl);
 	return inode;
 
 out_iput:
 	iput(inode);
+	posix_acl_release(acl);
+	posix_acl_release(default_acl);
 	return ERR_PTR(error);
 }
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index b5940ec1836a..6e44103223ab 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -103,13 +103,14 @@ enum orangefs_vfs_op_states {
 #define ORANGEFS_CACHE_CREATE_FLAGS 0
 #endif
 
-extern int orangefs_init_acl(struct inode *inode, struct inode *dir);
 extern const struct xattr_handler *orangefs_xattr_handlers[];
 
 extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu);
 extern int orangefs_set_acl(struct user_namespace *mnt_userns,
-			    struct inode *inode, struct posix_acl *acl,
+			    struct dentry *dentry, struct posix_acl *acl,
 			    int type);
+extern int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl,
+			      int type);
 
 /*
  * orangefs data structures
@@ -356,11 +357,12 @@ void fsid_key_table_finalize(void);
 vm_fault_t orangefs_page_mkwrite(struct vm_fault *);
 struct inode *orangefs_new_inode(struct super_block *sb,
 			      struct inode *dir,
-			      int mode,
+			      umode_t mode,
 			      dev_t dev,
 			      struct orangefs_object_kref *ref);
 
 int __orangefs_setattr(struct inode *, struct iattr *);
+int __orangefs_setattr_mode(struct dentry *dentry, struct iattr *iattr);
 int orangefs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 
 int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
@@ -422,6 +424,7 @@ int orangefs_inode_setxattr(struct inode *inode,
 #define ORANGEFS_GETATTR_SIZE 2
 
 int orangefs_inode_getattr(struct inode *, int);
+int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags);
 
 int orangefs_inode_check_changed(struct inode *inode);
 
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 46b7dcff18ac..2351a62a7b37 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -233,7 +233,7 @@ static int orangefs_inode_is_stale(struct inode *inode,
 	return 0;
 }
 
-int orangefs_inode_getattr(struct inode *inode, int flags)
+int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op;
@@ -368,8 +368,9 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	inode->i_ctime.tv_nsec = 0;
 
 	/* special case: mark the root inode as sticky */
-	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
-	    orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes);
+	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) | mode |
+	    orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes) |
+	    mode;
 
 	orangefs_inode->getattr_time = jiffies +
 	    orangefs_getattr_timeout_msecs*HZ/1000;
@@ -381,6 +382,11 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	return ret;
 }
 
+int orangefs_inode_getattr(struct inode *inode, int flags)
+{
+	return __orangefs_inode_getattr(inode, 0, flags);
+}
+
 int orangefs_inode_check_changed(struct inode *inode)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index b4f109875e79..97b368b15289 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -587,9 +587,10 @@ EXPORT_SYMBOL(__posix_acl_chmod);
  * performed on the raw inode simply passs init_user_ns.
  */
 int
- posix_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode,
+ posix_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dentry,
 		    umode_t mode)
 {
+	struct inode *inode = d_inode(dentry);
 	struct posix_acl *acl;
 	int ret = 0;
 
@@ -608,7 +609,7 @@ int
 	ret = __posix_acl_chmod(&acl, GFP_KERNEL, mode);
 	if (ret)
 		return ret;
-	ret = inode->i_op->set_acl(mnt_userns, inode, acl, ACL_TYPE_ACCESS);
+	ret = inode->i_op->set_acl(mnt_userns, dentry, acl, ACL_TYPE_ACCESS);
 	posix_acl_release(acl);
 	return ret;
 }
@@ -1138,9 +1139,11 @@ posix_acl_xattr_get(const struct xattr_handler *handler,
 }
 
 int
-set_posix_acl(struct user_namespace *mnt_userns, struct inode *inode,
+set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	      int type, struct posix_acl *acl)
 {
+	struct inode *inode = d_inode(dentry);
+
 	if (!IS_POSIXACL(inode))
 		return -EOPNOTSUPP;
 	if (!inode->i_op->set_acl)
@@ -1156,14 +1159,14 @@ set_posix_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		if (ret)
 			return ret;
 	}
-	return inode->i_op->set_acl(mnt_userns, inode, acl, type);
+	return inode->i_op->set_acl(mnt_userns, dentry, acl, type);
 }
 EXPORT_SYMBOL(set_posix_acl);
 
 static int
 posix_acl_xattr_set(const struct xattr_handler *handler,
 			   struct user_namespace *mnt_userns,
-			   struct dentry *unused, struct inode *inode,
+			   struct dentry *dentry, struct inode *inode,
 			   const char *name, const void *value, size_t size,
 			   int flags)
 {
@@ -1185,7 +1188,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
-	ret = set_posix_acl(mnt_userns, inode, handler->flags, acl);
+	ret = set_posix_acl(mnt_userns, dentry, handler->flags, acl);
 	posix_acl_release(acl);
 	return ret;
 }
@@ -1214,10 +1217,11 @@ const struct xattr_handler posix_acl_default_xattr_handler = {
 };
 EXPORT_SYMBOL_GPL(posix_acl_default_xattr_handler);
 
-int simple_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int simple_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		   struct posix_acl *acl, int type)
 {
 	int error;
+	struct inode *inode = d_inode(dentry);
 
 	if (type == ACL_TYPE_ACCESS) {
 		error = posix_acl_update_mode(mnt_userns, inode,
diff --git a/fs/reiserfs/acl.h b/fs/reiserfs/acl.h
index d9052b8ce6dd..29c503a06db4 100644
--- a/fs/reiserfs/acl.h
+++ b/fs/reiserfs/acl.h
@@ -49,9 +49,9 @@ static inline int reiserfs_acl_count(size_t size)
 
 #ifdef CONFIG_REISERFS_FS_POSIX_ACL
 struct posix_acl *reiserfs_get_acl(struct inode *inode, int type, bool rcu);
-int reiserfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int reiserfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		     struct posix_acl *acl, int type);
-int reiserfs_acl_chmod(struct inode *inode);
+int reiserfs_acl_chmod(struct dentry *dentry);
 int reiserfs_inherit_default_acl(struct reiserfs_transaction_handle *th,
 				 struct inode *dir, struct dentry *dentry,
 				 struct inode *inode);
@@ -63,7 +63,7 @@ int reiserfs_cache_default_acl(struct inode *dir);
 #define reiserfs_get_acl NULL
 #define reiserfs_set_acl NULL
 
-static inline int reiserfs_acl_chmod(struct inode *inode)
+static inline int reiserfs_acl_chmod(struct dentry *dentry)
 {
 	return 0;
 }
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index b9580a6515ee..c7d1fa526dea 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3404,7 +3404,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	if (!error && reiserfs_posixacl(inode->i_sb)) {
 		if (attr->ia_valid & ATTR_MODE)
-			error = reiserfs_acl_chmod(inode);
+			error = reiserfs_acl_chmod(dentry);
 	}
 
 out:
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index d6fcddc46f5b..966ba48e33ec 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -18,7 +18,7 @@ static int __reiserfs_set_acl(struct reiserfs_transaction_handle *th,
 
 
 int
-reiserfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+reiserfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	int error, error2;
@@ -26,6 +26,7 @@ reiserfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	size_t jcreate_blocks;
 	int size = acl ? posix_acl_xattr_size(acl->a_count) : 0;
 	int update_mode = 0;
+	struct inode *inode = d_inode(dentry);
 	umode_t mode = inode->i_mode;
 
 	/*
@@ -396,13 +397,15 @@ int reiserfs_cache_default_acl(struct inode *inode)
 /*
  * Called under i_mutex
  */
-int reiserfs_acl_chmod(struct inode *inode)
+int reiserfs_acl_chmod(struct dentry *dentry)
 {
+	struct inode *inode = d_inode(dentry);
+
 	if (IS_PRIVATE(inode))
 		return 0;
 	if (get_inode_sd_version(inode) == STAT_DATA_V1 ||
 	    !reiserfs_posixacl(inode->i_sb))
 		return 0;
 
-	return posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+	return posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
 }
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index b744c62052b6..a05f44eb8178 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -242,12 +242,13 @@ xfs_acl_set_mode(
 }
 
 int
-xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+xfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	    struct posix_acl *acl, int type)
 {
 	umode_t mode;
 	bool set_mode = false;
 	int error = 0;
+	struct inode *inode = d_inode(dentry);
 
 	if (!acl)
 		goto set_acl;
diff --git a/fs/xfs/xfs_acl.h b/fs/xfs/xfs_acl.h
index 263404d0bfda..dcd176149c7a 100644
--- a/fs/xfs/xfs_acl.h
+++ b/fs/xfs/xfs_acl.h
@@ -11,7 +11,7 @@ struct posix_acl;
 
 #ifdef CONFIG_XFS_POSIX_ACL
 extern struct posix_acl *xfs_get_acl(struct inode *inode, int type, bool rcu);
-extern int xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+extern int xfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		       struct posix_acl *acl, int type);
 extern int __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 void xfs_forget_acl(struct inode *inode, const char *name);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 45518b8c613c..ebc55195fa91 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -639,6 +639,7 @@ xfs_vn_change_ok(
 static int
 xfs_setattr_nonsize(
 	struct user_namespace	*mnt_userns,
+	struct dentry		*dentry,
 	struct xfs_inode	*ip,
 	struct iattr		*iattr)
 {
@@ -745,7 +746,7 @@ xfs_setattr_nonsize(
 	 * 	     Posix ACL code seems to care about this issue either.
 	 */
 	if (mask & ATTR_MODE) {
-		error = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
+		error = posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
 		if (error)
 			return error;
 	}
@@ -767,6 +768,7 @@ xfs_setattr_nonsize(
 STATIC int
 xfs_setattr_size(
 	struct user_namespace	*mnt_userns,
+	struct dentry		*dentry,
 	struct xfs_inode	*ip,
 	struct iattr		*iattr)
 {
@@ -798,7 +800,7 @@ xfs_setattr_size(
 		 * Use the regular setattr path to update the timestamps.
 		 */
 		iattr->ia_valid &= ~ATTR_SIZE;
-		return xfs_setattr_nonsize(mnt_userns, ip, iattr);
+		return xfs_setattr_nonsize(mnt_userns, dentry, ip, iattr);
 	}
 
 	/*
@@ -975,7 +977,7 @@ xfs_vn_setattr_size(
 	error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
 	if (error)
 		return error;
-	return xfs_setattr_size(mnt_userns, ip, iattr);
+	return xfs_setattr_size(mnt_userns, dentry, ip, iattr);
 }
 
 STATIC int
@@ -1007,7 +1009,7 @@ xfs_vn_setattr(
 
 		error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
 		if (!error)
-			error = xfs_setattr_nonsize(mnt_userns, ip, iattr);
+			error = xfs_setattr_nonsize(mnt_userns, dentry, ip, iattr);
 	}
 
 	return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..bfb4522a4a6d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2168,7 +2168,7 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct user_namespace *, struct inode *,
 			struct dentry *, umode_t);
-	int (*set_acl)(struct user_namespace *, struct inode *,
+	int (*set_acl)(struct user_namespace *, struct dentry *,
 		       struct posix_acl *, int);
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct fileattr *fa);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 7d1e604c1325..7b389901d581 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -69,20 +69,20 @@ extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
 extern int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t);
 
 extern struct posix_acl *get_posix_acl(struct inode *, int);
-extern int set_posix_acl(struct user_namespace *, struct inode *, int,
+extern int set_posix_acl(struct user_namespace *, struct dentry *, int,
 			 struct posix_acl *);
 
 struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type);
 struct posix_acl *posix_acl_clone(const struct posix_acl *acl, gfp_t flags);
 
 #ifdef CONFIG_FS_POSIX_ACL
-int posix_acl_chmod(struct user_namespace *, struct inode *, umode_t);
+int posix_acl_chmod(struct user_namespace *, struct dentry *, umode_t);
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
 		struct posix_acl **);
 int posix_acl_update_mode(struct user_namespace *, struct inode *, umode_t *,
 			  struct posix_acl **);
 
-extern int simple_set_acl(struct user_namespace *, struct inode *,
+extern int simple_set_acl(struct user_namespace *, struct dentry *,
 			  struct posix_acl *, int);
 extern int simple_acl_create(struct inode *, struct inode *);
 
@@ -101,7 +101,7 @@ static inline void cache_no_acl(struct inode *inode)
 }
 #else
 static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
-				  struct inode *inode, umode_t mode)
+				  struct dentry *dentry, umode_t mode)
 {
 	return 0;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 42e5888bf84d..817c08556c01 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1126,7 +1126,7 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 
 	setattr_copy(&init_user_ns, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
 	return error;
 }
 
-- 
2.34.1

