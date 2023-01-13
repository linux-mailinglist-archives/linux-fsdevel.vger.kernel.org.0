Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D15669612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjAMLxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbjAMLwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FE63D5C3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44379B82121
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA20C433F2;
        Fri, 13 Jan 2023 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610601;
        bh=STIKGX/kr3fVTHPG8Zq697nFpeEKi4GhU8MrF8E5gvc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tZjwD6trGjGIks5ZZdf8vkYzcmc5ZP0x1U6YQ4O2CuHZc4BxNiUeqGI5AiSdFjiEq
         bQIvJ9xCjZUQXj3/Hom/RYu9x0tZ2trfKCzOxJ8+r/fgzEVxI3TaQXnQnTfW9U9Szp
         3D6WcI1lRvN8btWMbRy1Z78DJwCbvkGZhh4KPZNkICEmP3ZDAlZBXK0Ru4C9w72WMa
         NG2I8qK8VyUQhuhwrhbXUCScPhbj+IZe4Fw63/NBAKLwcYWbYFOHh6EmiC1enXRDqX
         4cIAx0kOFsx8ilvTDUJiykCTbzPYsRF4k+jJbzVtmwocGukwldlF7grfZI6oMMD+Lh
         7IziygqVoOdIQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:20 +0100
Subject: [PATCH 12/25] fs: port ->set_acl() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-12-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=52033; i=brauner@kernel.org;
 h=from:subject:message-id; bh=STIKGX/kr3fVTHPG8Zq697nFpeEKi4GhU8MrF8E5gvc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA3+qPr+bGRVX53n2noHl+fpf4NWFh49fi13yzTjhmd7
 euav6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIuxvD/6z+dUznGX2rnu3fce9Wwd
 eqMKbe43VZ36aLuh580Lhm5lKG/zlXJybFVewoNdlyLUupNnRbXlz9Iqf7RRWVkxcuLFy3mQMA
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
 Documentation/filesystems/vfs.rst |  2 +-
 fs/9p/acl.c                       |  2 +-
 fs/9p/acl.h                       |  2 +-
 fs/bad_inode.c                    |  2 +-
 fs/btrfs/acl.c                    |  3 ++-
 fs/btrfs/acl.h                    |  2 +-
 fs/btrfs/inode.c                  |  3 +--
 fs/ceph/acl.c                     |  2 +-
 fs/ceph/inode.c                   |  2 +-
 fs/ceph/super.h                   |  2 +-
 fs/cifs/cifsacl.c                 |  2 +-
 fs/cifs/cifsproto.h               |  2 +-
 fs/ecryptfs/inode.c               |  4 ++--
 fs/ext2/acl.c                     |  2 +-
 fs/ext2/acl.h                     |  2 +-
 fs/ext2/inode.c                   |  2 +-
 fs/ext4/acl.c                     |  3 ++-
 fs/ext4/acl.h                     |  2 +-
 fs/ext4/inode.c                   |  2 +-
 fs/f2fs/acl.c                     |  3 ++-
 fs/f2fs/acl.h                     |  2 +-
 fs/f2fs/file.c                    |  2 +-
 fs/fuse/acl.c                     |  2 +-
 fs/fuse/fuse_i.h                  |  2 +-
 fs/gfs2/acl.c                     |  2 +-
 fs/gfs2/acl.h                     |  2 +-
 fs/gfs2/inode.c                   |  2 +-
 fs/jffs2/acl.c                    |  2 +-
 fs/jffs2/acl.h                    |  2 +-
 fs/jffs2/fs.c                     |  2 +-
 fs/jfs/acl.c                      |  2 +-
 fs/jfs/file.c                     |  2 +-
 fs/jfs/jfs_acl.h                  |  2 +-
 fs/ksmbd/smb2pdu.c                | 11 +++++++----
 fs/ksmbd/smbacl.c                 |  6 +++---
 fs/ksmbd/vfs.c                    | 16 ++++++++--------
 fs/ksmbd/vfs.h                    |  6 +++---
 fs/nfs/nfs3_fs.h                  |  2 +-
 fs/nfs/nfs3acl.c                  |  2 +-
 fs/nfsd/nfs2acl.c                 |  4 ++--
 fs/nfsd/nfs3acl.c                 |  4 ++--
 fs/nfsd/vfs.c                     |  4 ++--
 fs/ntfs3/file.c                   |  2 +-
 fs/ntfs3/ntfs_fs.h                |  4 ++--
 fs/ntfs3/xattr.c                  |  8 +++++---
 fs/ocfs2/acl.c                    |  2 +-
 fs/ocfs2/acl.h                    |  2 +-
 fs/orangefs/acl.c                 |  2 +-
 fs/orangefs/inode.c               |  2 +-
 fs/orangefs/orangefs-kernel.h     |  2 +-
 fs/overlayfs/inode.c              |  2 +-
 fs/overlayfs/overlayfs.h          |  6 +++---
 fs/posix_acl.c                    | 39 +++++++++++++++++++++------------------
 fs/reiserfs/acl.h                 |  2 +-
 fs/reiserfs/xattr_acl.c           |  4 ++--
 fs/xattr.c                        |  2 +-
 fs/xfs/xfs_acl.c                  |  3 ++-
 fs/xfs/xfs_acl.h                  |  2 +-
 fs/xfs/xfs_iops.c                 |  2 +-
 include/linux/fs.h                |  2 +-
 include/linux/posix_acl.h         | 16 ++++++++--------
 mm/shmem.c                        |  2 +-
 62 files changed, 122 insertions(+), 111 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 056e446c70e0..19afe53f7060 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -444,7 +444,7 @@ As of kernel 2.6.22, the following members are defined:
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umode_t);
 		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
-	        int (*set_acl)(struct user_namespace *, struct dentry *, struct posix_acl *, int);
+	        int (*set_acl)(struct mnt_idmap *, struct dentry *, struct posix_acl *, int);
 		int (*fileattr_set)(struct user_namespace *mnt_userns,
 				    struct dentry *dentry, struct fileattr *fa);
 		int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index cfd4545f2d02..ae278016ae95 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -151,7 +151,7 @@ struct posix_acl *v9fs_iop_get_acl(struct mnt_idmap *idmap,
 	return v9fs_get_cached_acl(d_inode(dentry), type);
 }
 
-int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int v9fs_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct posix_acl *acl, int type)
 {
 	int retval;
diff --git a/fs/9p/acl.h b/fs/9p/acl.h
index e0e58967d916..333cfcc281da 100644
--- a/fs/9p/acl.h
+++ b/fs/9p/acl.h
@@ -12,7 +12,7 @@ struct posix_acl *v9fs_iop_get_inode_acl(struct inode *inode, int type,
 				   bool rcu);
 struct posix_acl *v9fs_iop_get_acl(struct mnt_idmap *idmap,
 					  struct dentry *dentry, int type);
-int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int v9fs_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct posix_acl *acl, int type);
 int v9fs_acl_chmod(struct inode *inode, struct p9_fid *fid);
 int v9fs_set_create_acl(struct inode *inode, struct p9_fid *fid,
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 4bdf40b187ff..350ad3461129 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -153,7 +153,7 @@ static int bad_inode_tmpfile(struct mnt_idmap *idmap,
 	return -EIO;
 }
 
-static int bad_inode_set_acl(struct user_namespace *mnt_userns,
+static int bad_inode_set_acl(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct posix_acl *acl,
 			     int type)
 {
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index 3da1779e8b79..7a3ab7e4b163 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -110,10 +110,11 @@ int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 	return ret;
 }
 
-int btrfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int btrfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct posix_acl *acl, int type)
 {
 	int ret;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	umode_t old_mode = inode->i_mode;
 
diff --git a/fs/btrfs/acl.h b/fs/btrfs/acl.h
index 39bd36e6eeb7..a270e71ec05f 100644
--- a/fs/btrfs/acl.h
+++ b/fs/btrfs/acl.h
@@ -6,7 +6,7 @@
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
-int btrfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int btrfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct posix_acl *acl, int type);
 int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 		    struct posix_acl *acl, int type);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c10157a5a6f8..6a74767b12cb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5307,8 +5307,7 @@ static int btrfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		err = btrfs_dirty_inode(BTRFS_I(inode));
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(mnt_idmap_owner(idmap), dentry,
-					      inode->i_mode);
+			err = posix_acl_chmod(idmap, dentry, inode->i_mode);
 	}
 
 	return err;
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index c7e8dd5b58d4..59a05fd259f0 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -85,7 +85,7 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
-int ceph_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	int ret = 0, size = 0;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fcc84cc1d8f1..d9ae943423af 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2255,7 +2255,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	err = __ceph_setattr(inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&init_user_ns, dentry, attr->ia_mode);
+		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
 
 	return err;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 063dad749a07..51c6c10e0375 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1118,7 +1118,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 
 struct posix_acl *ceph_get_acl(struct inode *, int, bool);
-int ceph_set_acl(struct user_namespace *mnt_userns,
+int ceph_set_acl(struct mnt_idmap *idmap,
 		 struct dentry *dentry, struct posix_acl *acl, int type);
 int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 		       struct ceph_acl_sec_ctx *as_ctx);
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 1fae9b60e48f..9a2d390bd06f 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1738,7 +1738,7 @@ struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
 #endif
 }
 
-int cifs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int cifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 #if defined(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) && defined(CONFIG_CIFS_POSIX)
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index aeae6544cdd8..b8a47704a6ef 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -227,7 +227,7 @@ extern struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *,
 				const struct cifs_fid *, u32 *, u32);
 extern struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
 				      struct dentry *dentry, int type);
-extern int cifs_set_acl(struct user_namespace *mnt_userns,
+extern int cifs_set_acl(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct posix_acl *acl, int type);
 extern int set_cifs_acl(struct cifs_ntsd *, __u32, struct inode *,
 				const char *, int);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 8487ac0cc239..b62351b7ad6a 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1129,7 +1129,7 @@ static struct posix_acl *ecryptfs_get_acl(struct mnt_idmap *idmap,
 			   posix_acl_xattr_name(type));
 }
 
-static int ecryptfs_set_acl(struct user_namespace *mnt_userns,
+static int ecryptfs_set_acl(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct posix_acl *acl,
 			    int type)
 {
@@ -1137,7 +1137,7 @@ static int ecryptfs_set_acl(struct user_namespace *mnt_userns,
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	struct inode *lower_inode = d_inode(lower_dentry);
 
-	rc = vfs_set_acl(&init_user_ns, lower_dentry,
+	rc = vfs_set_acl(&nop_mnt_idmap, lower_dentry,
 			 posix_acl_xattr_name(type), acl);
 	if (!rc)
 		fsstack_copy_attr_all(d_inode(dentry), lower_inode);
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index 440d5f1e9d47..f20953c7ec65 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -219,7 +219,7 @@ __ext2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
  * inode->i_mutex: down
  */
 int
-ext2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+ext2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	     struct posix_acl *acl, int type)
 {
 	int error;
diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
index 3841becb94ff..4a8443a2b8ec 100644
--- a/fs/ext2/acl.h
+++ b/fs/ext2/acl.h
@@ -56,7 +56,7 @@ static inline int ext2_acl_count(size_t size)
 
 /* acl.c */
 extern struct posix_acl *ext2_get_acl(struct inode *inode, int type, bool rcu);
-extern int ext2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+extern int ext2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			struct posix_acl *acl, int type);
 extern int ext2_init_acl (struct inode *, struct inode *);
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index bbc9941dbb43..fb7fdadefd3d 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1647,7 +1647,7 @@ int ext2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	if (iattr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
+		error = posix_acl_chmod(&nop_mnt_idmap, dentry, inode->i_mode);
 	mark_inode_dirty(inode);
 
 	return error;
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index a9f89539aeee..05139feb7282 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -225,9 +225,10 @@ __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
 }
 
 int
-ext4_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+ext4_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	     struct posix_acl *acl, int type)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	int error, credits, retries = 0;
 	size_t acl_size = acl ? ext4_acl_size(acl->a_count) : 0;
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 09c4a8a3b716..0c5a79c3b5d4 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -56,7 +56,7 @@ static inline int ext4_acl_count(size_t size)
 
 /* acl.c */
 struct posix_acl *ext4_get_acl(struct inode *inode, int type, bool rcu);
-int ext4_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ext4_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d60eab65319d..3aae0be8c91e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5643,7 +5643,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		ext4_orphan_del(NULL, inode);
 
 	if (!error && (ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
+		rc = posix_acl_chmod(idmap, dentry, inode->i_mode);
 
 err_out:
 	if  (error)
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index c1c74aa658ae..6ced63bce4e4 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -276,9 +276,10 @@ static int __f2fs_set_acl(struct user_namespace *mnt_userns,
 	return error;
 }
 
-int f2fs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int f2fs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index ea2bbb3f264b..94ebfbfbdc6f 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -34,7 +34,7 @@ struct f2fs_acl_header {
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 
 extern struct posix_acl *f2fs_get_acl(struct inode *, int, bool);
-extern int f2fs_set_acl(struct user_namespace *, struct dentry *,
+extern int f2fs_set_acl(struct mnt_idmap *, struct dentry *,
 			struct posix_acl *, int);
 extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
 							struct page *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 267507ff16cc..a5e936a6225a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1028,7 +1028,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	__setattr_copy(idmap, inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
-		err = posix_acl_chmod(mnt_userns, dentry, f2fs_get_inode_mode(inode));
+		err = posix_acl_chmod(idmap, dentry, f2fs_get_inode_mode(inode));
 
 		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 			if (!err)
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index a4850aee2639..4eb9adefa914 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -53,7 +53,7 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
-int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c673faefdcb9..570941be0fd0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1269,7 +1269,7 @@ extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
 
 struct posix_acl;
 struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu);
-int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 
 /* readdir.c */
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 3dcde4912413..e2a79d7e5605 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -109,7 +109,7 @@ int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	return error;
 }
 
-int gfs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int gfs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/gfs2/acl.h b/fs/gfs2/acl.h
index b8de8c148f5c..d4deb2b19959 100644
--- a/fs/gfs2/acl.h
+++ b/fs/gfs2/acl.h
@@ -13,7 +13,7 @@
 
 extern struct posix_acl *gfs2_get_acl(struct inode *inode, int type, bool rcu);
 extern int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
-extern int gfs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+extern int gfs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			struct posix_acl *acl, int type);
 
 #endif /* __ACL_DOT_H__ */
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f4af55807808..0818d4e25d75 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2007,7 +2007,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
 	else {
 		error = gfs2_setattr_simple(inode, attr);
 		if (!error && attr->ia_valid & ATTR_MODE)
-			error = posix_acl_chmod(&init_user_ns, dentry,
+			error = posix_acl_chmod(&nop_mnt_idmap, dentry,
 						inode->i_mode);
 	}
 
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 8bb58ce5c06c..672eaf51a66d 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -229,7 +229,7 @@ static int __jffs2_set_acl(struct inode *inode, int xprefix, struct posix_acl *a
 	return rc;
 }
 
-int jffs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int jffs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct posix_acl *acl, int type)
 {
 	int rc, xprefix;
diff --git a/fs/jffs2/acl.h b/fs/jffs2/acl.h
index ca36a6eca594..e976b8cb82cf 100644
--- a/fs/jffs2/acl.h
+++ b/fs/jffs2/acl.h
@@ -28,7 +28,7 @@ struct jffs2_acl_header {
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 
 struct posix_acl *jffs2_get_acl(struct inode *inode, int type, bool rcu);
-int jffs2_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int jffs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct posix_acl *acl, int type);
 extern int jffs2_init_acl_pre(struct inode *, struct inode *, umode_t *);
 extern int jffs2_init_acl_post(struct inode *);
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 28f7eea4c46d..09174898efd0 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -202,7 +202,7 @@ int jffs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	rc = jffs2_do_setattr(inode, iattr);
 	if (!rc && (iattr->ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
+		rc = posix_acl_chmod(&nop_mnt_idmap, dentry, inode->i_mode);
 
 	return rc;
 }
diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 3b667eccc73b..25b78dd82099 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -94,7 +94,7 @@ static int __jfs_set_acl(tid_t tid, struct inode *inode, int type,
 	return rc;
 }
 
-int jfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int jfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct posix_acl *acl, int type)
 {
 	int rc;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 8cda5d811265..c2cfb8033b1f 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -123,7 +123,7 @@ int jfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE)
-		rc = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
+		rc = posix_acl_chmod(&nop_mnt_idmap, dentry, inode->i_mode);
 	return rc;
 }
 
diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
index f0704a25835f..f892e54d0fcd 100644
--- a/fs/jfs/jfs_acl.h
+++ b/fs/jfs/jfs_acl.h
@@ -8,7 +8,7 @@
 #ifdef CONFIG_JFS_POSIX_ACL
 
 struct posix_acl *jfs_get_acl(struct inode *inode, int type, bool rcu);
-int jfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int jfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct posix_acl *acl, int type);
 int jfs_init_acl(tid_t, struct inode *, struct inode *);
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index ba8146f39adb..50d049bb84de 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2512,6 +2512,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
 	struct file *filp = NULL;
+	struct mnt_idmap *idmap = NULL;
 	struct user_namespace *user_ns = NULL;
 	struct kstat stat;
 	struct create_context *context;
@@ -2765,7 +2766,8 @@ int smb2_open(struct ksmbd_work *work)
 		rc = 0;
 	} else {
 		file_present = true;
-		user_ns = mnt_user_ns(path.mnt);
+		idmap = mnt_idmap(path.mnt);
+		user_ns = mnt_idmap_owner(idmap);
 	}
 	if (stream_name) {
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
@@ -2864,7 +2866,8 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		created = true;
-		user_ns = mnt_user_ns(path.mnt);
+		idmap = mnt_idmap(path.mnt);
+		user_ns = mnt_idmap_owner(idmap);
 		if (ea_buf) {
 			if (le32_to_cpu(ea_buf->ccontext.DataLength) <
 			    sizeof(struct smb2_ea_info)) {
@@ -2957,7 +2960,7 @@ int smb2_open(struct ksmbd_work *work)
 		int posix_acl_rc;
 		struct inode *inode = d_inode(path.dentry);
 
-		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(user_ns,
+		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(idmap,
 							   path.dentry,
 							   d_inode(path.dentry->d_parent));
 		if (posix_acl_rc)
@@ -2973,7 +2976,7 @@ int smb2_open(struct ksmbd_work *work)
 			rc = smb2_create_sd_buffer(work, req, &path);
 			if (rc) {
 				if (posix_acl_rc)
-					ksmbd_vfs_set_init_posix_acl(user_ns,
+					ksmbd_vfs_set_init_posix_acl(idmap,
 								     path.dentry);
 
 				if (test_share_config_flag(work->tcon->share_conf,
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 6490342bbb38..6e144880eeff 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1384,17 +1384,17 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	newattrs.ia_valid |= ATTR_MODE;
 	newattrs.ia_mode = (inode->i_mode & ~0777) | (fattr.cf_mode & 0777);
 
-	ksmbd_vfs_remove_acl_xattrs(user_ns, path->dentry);
+	ksmbd_vfs_remove_acl_xattrs(idmap, path->dentry);
 	/* Update posix acls */
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && fattr.cf_dacls) {
-		rc = set_posix_acl(user_ns, path->dentry,
+		rc = set_posix_acl(idmap, path->dentry,
 				   ACL_TYPE_ACCESS, fattr.cf_acls);
 		if (rc < 0)
 			ksmbd_debug(SMB,
 				    "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
 				    rc);
 		if (S_ISDIR(inode->i_mode) && fattr.cf_dacls) {
-			rc = set_posix_acl(user_ns, path->dentry,
+			rc = set_posix_acl(idmap, path->dentry,
 					   ACL_TYPE_DEFAULT, fattr.cf_dacls);
 			if (rc)
 				ksmbd_debug(SMB,
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index cf60e62d6e73..21f420d21b3e 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1305,7 +1305,7 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 	return dent;
 }
 
-int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
+int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 				struct dentry *dentry)
 {
 	char *name, *xattr_list = NULL;
@@ -1328,7 +1328,7 @@ int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
 			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1) ||
 		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
 			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1)) {
-			err = vfs_remove_acl(user_ns, dentry, name);
+			err = vfs_remove_acl(idmap, dentry, name);
 			if (err)
 				ksmbd_debug(SMB,
 					    "remove acl xattr failed : %s\n", name);
@@ -1830,7 +1830,7 @@ void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
 	locks_delete_block(flock);
 }
 
-int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
+int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry)
 {
 	struct posix_acl_state acl_state;
@@ -1864,13 +1864,13 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 		return -ENOMEM;
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
-	rc = set_posix_acl(user_ns, dentry, ACL_TYPE_ACCESS, acls);
+	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
 			    rc);
 	else if (S_ISDIR(inode->i_mode)) {
 		posix_state_to_acl(&acl_state, acls->a_entries);
-		rc = set_posix_acl(user_ns, dentry, ACL_TYPE_DEFAULT, acls);
+		rc = set_posix_acl(idmap, dentry, ACL_TYPE_DEFAULT, acls);
 		if (rc < 0)
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
@@ -1880,7 +1880,7 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 	return rc;
 }
 
-int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
+int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 				struct dentry *dentry, struct inode *parent_inode)
 {
 	struct posix_acl *acls;
@@ -1903,12 +1903,12 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 		}
 	}
 
-	rc = set_posix_acl(user_ns, dentry, ACL_TYPE_ACCESS, acls);
+	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
 			    rc);
 	if (S_ISDIR(inode->i_mode)) {
-		rc = set_posix_acl(user_ns, dentry, ACL_TYPE_DEFAULT,
+		rc = set_posix_acl(idmap, dentry, ACL_TYPE_DEFAULT,
 				   acls);
 		if (rc < 0)
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 619304b08a7f..1f8c5ac03041 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -141,7 +141,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 void ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
 void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
-int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
+int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 				struct dentry *dentry);
 int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
 			       struct dentry *dentry);
@@ -159,9 +159,9 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
-int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
+int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry);
-int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
+int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 				struct dentry *dentry,
 				struct inode *parent_inode);
 #endif /* __KSMBD_VFS_H__ */
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index df9ca56db347..4fa37dc038b5 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -12,7 +12,7 @@
  */
 #ifdef CONFIG_NFS_V3_ACL
 extern struct posix_acl *nfs3_get_acl(struct inode *inode, int type, bool rcu);
-extern int nfs3_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+extern int nfs3_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			struct posix_acl *acl, int type);
 extern int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 		struct posix_acl *dfacl);
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 74d11e3c4205..1247f544a440 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -255,7 +255,7 @@ int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 
 }
 
-int nfs3_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int nfs3_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	struct posix_acl *orig = acl, *dfacl = NULL, *alloc;
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 1457f59f447a..995cb2c90b1a 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -113,11 +113,11 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_ACCESS,
+	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_ACCESS,
 			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_DEFAULT,
+	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_DEFAULT,
 			      argp->acl_default);
 	if (error)
 		goto out_drop_lock;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 647108138e8a..887803735e2a 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -103,11 +103,11 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_ACCESS,
+	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_ACCESS,
 			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(&init_user_ns, fh->fh_dentry, ACL_TYPE_DEFAULT,
+	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_DEFAULT,
 			      argp->acl_default);
 
 out_drop_lock:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 371d7f03fe2d..66517ad6ac13 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -542,12 +542,12 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_labelerr = security_inode_setsecctx(dentry,
 			attr->na_seclabel->data, attr->na_seclabel->len);
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl)
-		attr->na_aclerr = set_posix_acl(&init_user_ns,
+		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_ACCESS,
 						attr->na_pacl);
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
 	    !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))
-		attr->na_aclerr = set_posix_acl(&init_user_ns,
+		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
 	inode_unlock(inode);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 33299e4f931e..181d5677ccd1 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -707,7 +707,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	setattr_copy(idmap, inode, attr);
 
 	if (mode != inode->i_mode) {
-		err = ntfs_acl_chmod(mnt_idmap_owner(idmap), dentry);
+		err = ntfs_acl_chmod(idmap, dentry);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 41cd797b3c96..9d45a259695c 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -859,7 +859,7 @@ unsigned long ntfs_names_hash(const u16 *name, size_t len, const u16 *upcase,
 /* globals from xattr.c */
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
 struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu);
-int ntfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		  struct inode *dir);
@@ -868,7 +868,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 #define ntfs_set_acl NULL
 #endif
 
-int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dentry);
+int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry);
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask);
 ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 616df209feea..370effca6b2c 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -652,9 +652,11 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 /*
  * ntfs_set_acl - inode_operations::set_acl
  */
-int ntfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	return ntfs_set_acl_ex(mnt_userns, d_inode(dentry), acl, type, false);
 }
 
@@ -697,7 +699,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 /*
  * ntfs_acl_chmod - Helper for ntfs3_setattr().
  */
-int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dentry)
+int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = inode->i_sb;
@@ -708,7 +710,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dentry)
 	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
 
-	return posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
+	return posix_acl_chmod(idmap, dentry, inode->i_mode);
 }
 
 /*
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 9f19cf9a5a9f..9809756a0d51 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -260,7 +260,7 @@ static int ocfs2_set_acl(handle_t *handle,
 	return ret;
 }
 
-int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ocfs2_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct posix_acl *acl, int type)
 {
 	struct buffer_head *bh = NULL;
diff --git a/fs/ocfs2/acl.h b/fs/ocfs2/acl.h
index a897c4e41b26..667c6f03fa60 100644
--- a/fs/ocfs2/acl.h
+++ b/fs/ocfs2/acl.h
@@ -17,7 +17,7 @@ struct ocfs2_acl_entry {
 };
 
 struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type, bool rcu);
-int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ocfs2_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct posix_acl *acl, int type);
 extern int ocfs2_acl_chmod(struct inode *, struct buffer_head *);
 extern int ocfs2_init_acl(handle_t *, struct inode *, struct inode *,
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index c5da2091cefb..6a81336142c0 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -118,7 +118,7 @@ int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	return error;
 }
 
-int orangefs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int orangefs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct posix_acl *acl, int type)
 {
 	int error;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 71cc7f11c7a0..1e41eeee18e1 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -839,7 +839,7 @@ int __orangefs_setattr_mode(struct dentry *dentry, struct iattr *iattr)
 	ret = __orangefs_setattr(inode, iattr);
 	/* change mode on a file that has ACLs */
 	if (!ret && (iattr->ia_valid & ATTR_MODE))
-		ret = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
+		ret = posix_acl_chmod(&nop_mnt_idmap, dentry, inode->i_mode);
 	return ret;
 }
 
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 064a52980283..f1ac4bd03c8d 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -106,7 +106,7 @@ enum orangefs_vfs_op_states {
 extern const struct xattr_handler *orangefs_xattr_handlers[];
 
 extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu);
-extern int orangefs_set_acl(struct user_namespace *mnt_userns,
+extern int orangefs_set_acl(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct posix_acl *acl,
 			    int type);
 int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3ea4fc54f469..f52d9304d7e4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -653,7 +653,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	return err;
 }
 
-int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct posix_acl *acl, int type)
 {
 	int err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 1e8b0be85e4b..0f2ac8402f10 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -284,13 +284,13 @@ static inline int ovl_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 static inline int ovl_do_set_acl(struct ovl_fs *ofs, struct dentry *dentry,
 				 const char *acl_name, struct posix_acl *acl)
 {
-	return vfs_set_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name, acl);
+	return vfs_set_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name, acl);
 }
 
 static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
 				    const char *acl_name)
 {
-	return vfs_remove_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name);
+	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
 }
 
 static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
@@ -623,7 +623,7 @@ static inline struct posix_acl *ovl_get_acl(struct mnt_idmap *idmap,
 {
 	return do_ovl_get_acl(idmap, d_inode(dentry), type, false, false);
 }
-int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct posix_acl *acl, int type);
 struct posix_acl *ovl_get_acl_path(const struct path *path,
 				   const char *acl_name, bool noperm);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 17e141a94671..678b86ec2b4c 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -591,18 +591,18 @@ EXPORT_SYMBOL(__posix_acl_chmod);
 /**
  * posix_acl_chmod - chmod a posix acl
  *
- * @mnt_userns:	user namespace of the mount @inode was found from
+ * @idmap:	idmap of the mount @inode was found from
  * @dentry:	dentry to check permissions on
  * @mode:	the new mode of @inode
  *
- * If the dentry has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the dentry has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply passs @nop_mnt_idmap.
  */
 int
- posix_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dentry,
+ posix_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry,
 		    umode_t mode)
 {
 	struct inode *inode = d_inode(dentry);
@@ -624,7 +624,7 @@ int
 	ret = __posix_acl_chmod(&acl, GFP_KERNEL, mode);
 	if (ret)
 		return ret;
-	ret = inode->i_op->set_acl(mnt_userns, dentry, acl, ACL_TYPE_ACCESS);
+	ret = inode->i_op->set_acl(idmap, dentry, acl, ACL_TYPE_ACCESS);
 	posix_acl_release(acl);
 	return ret;
 }
@@ -934,7 +934,7 @@ static ssize_t vfs_posix_acl_to_xattr(struct mnt_idmap *idmap,
 }
 
 int
-set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+set_posix_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	      int type, struct posix_acl *acl)
 {
 	struct inode *inode = d_inode(dentry);
@@ -946,7 +946,7 @@ set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(mnt_userns, inode))
+	if (!inode_owner_or_capable(mnt_idmap_owner(idmap), inode))
 		return -EPERM;
 
 	if (acl) {
@@ -954,7 +954,7 @@ set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (ret)
 			return ret;
 	}
-	return inode->i_op->set_acl(mnt_userns, dentry, acl, type);
+	return inode->i_op->set_acl(idmap, dentry, acl, type);
 }
 EXPORT_SYMBOL(set_posix_acl);
 
@@ -978,10 +978,11 @@ const struct xattr_handler posix_acl_default_xattr_handler = {
 };
 EXPORT_SYMBOL_GPL(posix_acl_default_xattr_handler);
 
-int simple_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int simple_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct posix_acl *acl, int type)
 {
 	int error;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 
 	if (type == ACL_TYPE_ACCESS) {
@@ -1041,7 +1042,7 @@ static int vfs_set_acl_idmapped_mnt(struct user_namespace *mnt_userns,
 
 /**
  * vfs_set_acl - set posix acls
- * @mnt_userns: user namespace of the mount
+ * @idmap: idmap of the mount
  * @dentry: the dentry based on which to set the posix acls
  * @acl_name: the name of the posix acl
  * @kacl: the posix acls in the appropriate VFS format
@@ -1051,11 +1052,12 @@ static int vfs_set_acl_idmapped_mnt(struct user_namespace *mnt_userns,
  *
  * Return: On success 0, on error negative errno.
  */
-int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		const char *acl_name, struct posix_acl *kacl)
 {
 	int acl_type;
 	int error;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	struct inode *delegated_inode = NULL;
 
@@ -1096,7 +1098,7 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		goto out_inode_unlock;
 
 	if (inode->i_opflags & IOP_XATTR)
-		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
+		error = set_posix_acl(idmap, dentry, acl_type, kacl);
 	else if (unlikely(is_bad_inode(inode)))
 		error = -EIO;
 	else
@@ -1167,7 +1169,7 @@ EXPORT_SYMBOL_GPL(vfs_get_acl);
 
 /**
  * vfs_remove_acl - remove posix acls
- * @mnt_userns: user namespace of the mount
+ * @idmap: idmap of the mount
  * @dentry: the dentry based on which to retrieve the posix acls
  * @acl_name: the name of the posix acl
  *
@@ -1175,11 +1177,12 @@ EXPORT_SYMBOL_GPL(vfs_get_acl);
  *
  * Return: On success 0, on error negative errno.
  */
-int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		   const char *acl_name)
 {
 	int acl_type;
 	int error;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	struct inode *delegated_inode = NULL;
 
@@ -1207,7 +1210,7 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		goto out_inode_unlock;
 
 	if (inode->i_opflags & IOP_XATTR)
-		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
+		error = set_posix_acl(idmap, dentry, acl_type, NULL);
 	else if (unlikely(is_bad_inode(inode)))
 		error = -EIO;
 	else
@@ -1246,7 +1249,7 @@ int do_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			return PTR_ERR(acl);
 	}
 
-	error = vfs_set_acl(mnt_idmap_owner(idmap), dentry, acl_name, acl);
+	error = vfs_set_acl(idmap, dentry, acl_name, acl);
 	posix_acl_release(acl);
 	return error;
 }
diff --git a/fs/reiserfs/acl.h b/fs/reiserfs/acl.h
index 29c503a06db4..2571b1a8be84 100644
--- a/fs/reiserfs/acl.h
+++ b/fs/reiserfs/acl.h
@@ -49,7 +49,7 @@ static inline int reiserfs_acl_count(size_t size)
 
 #ifdef CONFIG_REISERFS_FS_POSIX_ACL
 struct posix_acl *reiserfs_get_acl(struct inode *inode, int type, bool rcu);
-int reiserfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int reiserfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct posix_acl *acl, int type);
 int reiserfs_acl_chmod(struct dentry *dentry);
 int reiserfs_inherit_default_acl(struct reiserfs_transaction_handle *th,
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index 93fe414fed18..186aeba6823c 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -18,7 +18,7 @@ static int __reiserfs_set_acl(struct reiserfs_transaction_handle *th,
 
 
 int
-reiserfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+reiserfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	int error, error2;
@@ -407,5 +407,5 @@ int reiserfs_acl_chmod(struct dentry *dentry)
 	    !reiserfs_posixacl(inode->i_sb))
 		return 0;
 
-	return posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
+	return posix_acl_chmod(&nop_mnt_idmap, dentry, inode->i_mode);
 }
diff --git a/fs/xattr.c b/fs/xattr.c
index adab9a70b536..e69a2935ef58 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -892,7 +892,7 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
 		return error;
 
 	if (is_posix_acl_xattr(kname))
-		return vfs_remove_acl(mnt_idmap_owner(idmap), d, kname);
+		return vfs_remove_acl(idmap, d, kname);
 
 	return vfs_removexattr(mnt_idmap_owner(idmap), d, kname);
 }
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index a05f44eb8178..a2d2c117a076 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -242,9 +242,10 @@ xfs_acl_set_mode(
 }
 
 int
-xfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+xfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	    struct posix_acl *acl, int type)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	umode_t mode;
 	bool set_mode = false;
 	int error = 0;
diff --git a/fs/xfs/xfs_acl.h b/fs/xfs/xfs_acl.h
index dcd176149c7a..bf7f960997d3 100644
--- a/fs/xfs/xfs_acl.h
+++ b/fs/xfs/xfs_acl.h
@@ -11,7 +11,7 @@ struct posix_acl;
 
 #ifdef CONFIG_XFS_POSIX_ACL
 extern struct posix_acl *xfs_get_acl(struct inode *inode, int type, bool rcu);
-extern int xfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+extern int xfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct posix_acl *acl, int type);
 extern int __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 void xfs_forget_acl(struct inode *inode, const char *name);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 43e746167d61..1323ac546e5f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -764,7 +764,7 @@ xfs_setattr_nonsize(
 	 * 	     Posix ACL code seems to care about this issue either.
 	 */
 	if (mask & ATTR_MODE) {
-		error = posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
+		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
 		if (error)
 			return error;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 31a714377ba2..85d8e4bc7798 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2166,7 +2166,7 @@ struct inode_operations {
 			struct file *, umode_t);
 	struct posix_acl *(*get_acl)(struct mnt_idmap *, struct dentry *,
 				     int);
-	int (*set_acl)(struct user_namespace *, struct dentry *,
+	int (*set_acl)(struct mnt_idmap *, struct dentry *,
 		       struct posix_acl *, int);
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct fileattr *fa);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 042ef62f9276..0282758ba400 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -69,20 +69,20 @@ extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
 extern int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t);
 
 extern struct posix_acl *get_posix_acl(struct inode *, int);
-int set_posix_acl(struct user_namespace *, struct dentry *, int,
+int set_posix_acl(struct mnt_idmap *, struct dentry *, int,
 		  struct posix_acl *);
 
 struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type);
 struct posix_acl *posix_acl_clone(const struct posix_acl *acl, gfp_t flags);
 
 #ifdef CONFIG_FS_POSIX_ACL
-int posix_acl_chmod(struct user_namespace *, struct dentry *, umode_t);
+int posix_acl_chmod(struct mnt_idmap *, struct dentry *, umode_t);
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
 		struct posix_acl **);
 int posix_acl_update_mode(struct user_namespace *, struct inode *, umode_t *,
 			  struct posix_acl **);
 
-int simple_set_acl(struct user_namespace *, struct dentry *,
+int simple_set_acl(struct mnt_idmap *, struct dentry *,
 		   struct posix_acl *, int);
 extern int simple_acl_create(struct inode *, struct inode *);
 
@@ -100,14 +100,14 @@ static inline void cache_no_acl(struct inode *inode)
 	inode->i_default_acl = NULL;
 }
 
-int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		const char *acl_name, struct posix_acl *kacl);
 struct posix_acl *vfs_get_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name);
-int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		   const char *acl_name);
 #else
-static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
+static inline int posix_acl_chmod(struct mnt_idmap *idmap,
 				  struct dentry *dentry, umode_t mode)
 {
 	return 0;
@@ -134,7 +134,7 @@ static inline void forget_all_cached_acls(struct inode *inode)
 {
 }
 
-static inline int vfs_set_acl(struct user_namespace *mnt_userns,
+static inline int vfs_set_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *name,
 			      struct posix_acl *acl)
 {
@@ -148,7 +148,7 @@ static inline struct posix_acl *vfs_get_acl(struct mnt_idmap *idmap,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline int vfs_remove_acl(struct user_namespace *mnt_userns,
+static inline int vfs_remove_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *acl_name)
 {
 	return -EOPNOTSUPP;
diff --git a/mm/shmem.c b/mm/shmem.c
index ab289abe5827..ad768241147c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1131,7 +1131,7 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
+		error = posix_acl_chmod(&nop_mnt_idmap, dentry, inode->i_mode);
 	if (!error && update_ctime) {
 		inode->i_ctime = current_time(inode);
 		if (update_mtime)

-- 
2.34.1

