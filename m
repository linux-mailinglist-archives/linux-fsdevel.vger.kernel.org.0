Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304066961F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbjAMLwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjAMLwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F629E09F
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 834B3B82128
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA474C433D2;
        Fri, 13 Jan 2023 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610587;
        bh=NPRz37ZBBXsIO5ynEhOF/3Wp0mQ6sp/xLOtZO4KMqe4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sRYvGLy4skRMFjdRyd9YOtf/El4wmuSEUtoSwGkO2f05s+tB5sq08hJVbMFRu9Ve3
         20borRelki9cuW/nLYC7aeDzcpE48HE/VYHNERvs4w+QL2GYrQIH7fzi0QJSPC9YGf
         j47jHw8xX7dEIOmxPlD6LGo8Z83pJSc2E732Kl9qoGSQlpF7baXHEiWUG1mS6r8sR6
         di3Q30fJpyR/bwQZhWZ4eXakDgIiTjLr5q1I21c3BtVcyU1RLgIgF4wrapZqBA/9KH
         AAFZMWgAMvwCMz6BY3GPriJtbI9awCwA9PsD69AF5Kq5WM0jLQoho88teGe6zZlwqG
         dbPQNP4TmgTEg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:11 +0100
Subject: [PATCH 03/25] fs: port ->setattr() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-3-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=103015; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NPRz37ZBBXsIO5ynEhOF/3Wp0mQ6sp/xLOtZO4KMqe4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA1MT7nLq/q47Hn094IHgYZHa1dv/6912JS3ov6nWGBe
 2V/rjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIms1mX4p2zykuX7A9FVN2XveB8/Pd
 HVldf5F/t6+7aN+zpWfOdbupThf3ZOaGunwVN2eZ5NCzOUn/t0xJ2a4u5tVuy29ov1cbXtjAA=
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
 Documentation/filesystems/locking.rst     |  2 +-
 Documentation/filesystems/vfs.rst         |  2 +-
 arch/powerpc/platforms/cell/spufs/inode.c |  4 ++--
 fs/9p/acl.c                               |  2 +-
 fs/9p/v9fs_vfs.h                          |  2 +-
 fs/9p/vfs_inode.c                         |  8 ++++----
 fs/9p/vfs_inode_dotl.c                    |  8 ++++----
 fs/adfs/adfs.h                            |  2 +-
 fs/adfs/inode.c                           |  4 ++--
 fs/affs/affs.h                            |  2 +-
 fs/affs/inode.c                           |  6 +++---
 fs/afs/inode.c                            |  2 +-
 fs/afs/internal.h                         |  2 +-
 fs/attr.c                                 | 32 ++++++++++++++++---------------
 fs/bad_inode.c                            |  2 +-
 fs/btrfs/inode.c                          |  9 +++++----
 fs/ceph/inode.c                           |  4 ++--
 fs/ceph/super.h                           |  2 +-
 fs/cifs/cifsfs.h                          |  2 +-
 fs/cifs/inode.c                           | 10 +++++-----
 fs/coda/coda_linux.h                      |  2 +-
 fs/coda/inode.c                           |  2 +-
 fs/configfs/configfs_internal.h           |  2 +-
 fs/configfs/inode.c                       |  4 ++--
 fs/debugfs/inode.c                        |  4 ++--
 fs/ecryptfs/inode.c                       |  6 +++---
 fs/exfat/exfat_fs.h                       |  2 +-
 fs/exfat/file.c                           |  6 +++---
 fs/ext2/ext2.h                            |  2 +-
 fs/ext2/inode.c                           |  7 ++++---
 fs/ext4/ext4.h                            |  2 +-
 fs/ext4/inode.c                           |  7 ++++---
 fs/f2fs/f2fs.h                            |  2 +-
 fs/f2fs/file.c                            | 10 ++++++----
 fs/fat/fat.h                              |  2 +-
 fs/fat/file.c                             | 11 ++++++-----
 fs/fuse/dir.c                             |  4 ++--
 fs/gfs2/inode.c                           |  8 ++++----
 fs/hfs/hfs_fs.h                           |  2 +-
 fs/hfs/inode.c                            |  6 +++---
 fs/hfsplus/inode.c                        |  6 +++---
 fs/hostfs/hostfs_kern.c                   |  6 +++---
 fs/hpfs/hpfs_fn.h                         |  2 +-
 fs/hpfs/inode.c                           |  6 +++---
 fs/hugetlbfs/inode.c                      |  6 +++---
 fs/jffs2/fs.c                             |  4 ++--
 fs/jffs2/os-linux.h                       |  2 +-
 fs/jfs/file.c                             | 10 +++++-----
 fs/jfs/jfs_inode.h                        |  2 +-
 fs/kernfs/inode.c                         |  6 +++---
 fs/kernfs/kernfs-internal.h               |  2 +-
 fs/libfs.c                                | 10 +++++-----
 fs/minix/file.c                           |  6 +++---
 fs/nfs/inode.c                            |  2 +-
 fs/nfs/namespace.c                        |  4 ++--
 fs/nfsd/nfsproc.c                         |  2 +-
 fs/nilfs2/inode.c                         |  6 +++---
 fs/nilfs2/nilfs.h                         |  2 +-
 fs/ntfs/inode.c                           |  6 +++---
 fs/ntfs/inode.h                           |  2 +-
 fs/ntfs3/file.c                           |  8 ++++----
 fs/ntfs3/ntfs_fs.h                        |  4 +++-
 fs/ocfs2/dlmfs/dlmfs.c                    |  6 +++---
 fs/ocfs2/file.c                           |  7 ++++---
 fs/ocfs2/file.h                           |  2 +-
 fs/omfs/file.c                            |  6 +++---
 fs/orangefs/inode.c                       |  6 +++---
 fs/orangefs/orangefs-kernel.h             |  2 +-
 fs/overlayfs/inode.c                      |  6 +++---
 fs/overlayfs/overlayfs.h                  |  2 +-
 fs/proc/base.c                            |  6 +++---
 fs/proc/generic.c                         |  6 +++---
 fs/proc/internal.h                        |  2 +-
 fs/proc/proc_sysctl.c                     |  6 +++---
 fs/ramfs/file-nommu.c                     |  8 ++++----
 fs/reiserfs/inode.c                       | 10 +++++-----
 fs/reiserfs/reiserfs.h                    |  2 +-
 fs/reiserfs/xattr.c                       |  4 ++--
 fs/sysv/file.c                            |  6 +++---
 fs/ubifs/file.c                           |  4 ++--
 fs/ubifs/ubifs.h                          |  2 +-
 fs/udf/file.c                             |  6 +++---
 fs/ufs/inode.c                            |  6 +++---
 fs/ufs/ufs.h                              |  2 +-
 fs/vboxsf/utils.c                         |  2 +-
 fs/vboxsf/vfsmod.h                        |  2 +-
 fs/xfs/xfs_file.c                         |  2 +-
 fs/xfs/xfs_iops.c                         | 29 ++++++++++++++--------------
 fs/xfs/xfs_iops.h                         |  2 +-
 fs/xfs/xfs_pnfs.c                         |  2 +-
 fs/zonefs/super.c                         |  8 ++++----
 include/linux/evm.h                       |  4 ++--
 include/linux/fs.h                        |  9 ++++-----
 include/linux/nfs_fs.h                    |  2 +-
 include/linux/security.h                  |  4 ++--
 mm/secretmem.c                            |  4 ++--
 mm/shmem.c                                |  6 +++---
 net/socket.c                              |  4 ++--
 security/integrity/evm/evm_main.c         |  7 ++++---
 security/integrity/evm/evm_secfs.c        |  2 +-
 security/security.c                       |  4 ++--
 101 files changed, 257 insertions(+), 245 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 36fa2a83d714..04ad02dcd269 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -71,7 +71,7 @@ prototypes::
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int, unsigned int);
 	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
-	int (*setattr) (struct dentry *, struct iattr *);
+	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
 	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start, u64 len);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2c15e7053113..894e2a5c3603 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -436,7 +436,7 @@ As of kernel 2.6.22, the following members are defined:
 					 struct delayed_call *);
 		int (*permission) (struct user_namespace *, struct inode *, int);
 		struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
-		int (*setattr) (struct user_namespace *, struct dentry *, struct iattr *);
+		int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
 		int (*getattr) (struct user_namespace *, const struct path *, struct kstat *, u32, unsigned int);
 		ssize_t (*listxattr) (struct dentry *, char *, size_t);
 		void (*update_time)(struct inode *, struct timespec *, int);
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index dbcfe361831a..f07d76d77b79 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -92,7 +92,7 @@ spufs_new_inode(struct super_block *sb, umode_t mode)
 }
 
 static int
-spufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+spufs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	      struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -100,7 +100,7 @@ spufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    (attr->ia_size != inode->i_size))
 		return -EINVAL;
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index c397c51f80d9..9848a245fa6f 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -225,7 +225,7 @@ int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 			 * FIXME should we update ctime ?
 			 * What is the following setxattr update the mode ?
 			 */
-			v9fs_vfs_setattr_dotl(&init_user_ns, dentry, &iattr);
+			v9fs_vfs_setattr_dotl(&nop_mnt_idmap, dentry, &iattr);
 		}
 		break;
 	case ACL_TYPE_DEFAULT:
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index bc417da7e9c1..75106b9f293d 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -60,7 +60,7 @@ void v9fs_inode2stat(struct inode *inode, struct p9_wstat *stat);
 int v9fs_uflags2omode(int uflags, int extended);
 
 void v9fs_blank_wstat(struct p9_wstat *wstat);
-int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
+int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct iattr *iattr);
 int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
 			 int datasync);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 27a04a226d97..d8cd3f17bbf3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1060,13 +1060,13 @@ v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 /**
  * v9fs_vfs_setattr - set file metadata
- * @mnt_userns: The user namespace of the mount
+ * @idmap: idmap of the mount
  * @dentry: file whose metadata to set
  * @iattr: metadata assignment structure
  *
  */
 
-static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
+static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr)
 {
 	int retval, use_dentry = 0;
@@ -1077,7 +1077,7 @@ static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
 	struct p9_wstat wstat;
 
 	p9_debug(P9_DEBUG_VFS, "\n");
-	retval = setattr_prepare(&init_user_ns, dentry, iattr);
+	retval = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (retval)
 		return retval;
 
@@ -1135,7 +1135,7 @@ static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
 
 	v9fs_invalidate_inode_attr(inode);
 
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index f806b3f11649..dfe6b4017bd0 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -529,13 +529,13 @@ static int v9fs_mapped_iattr_valid(int iattr_valid)
 
 /**
  * v9fs_vfs_setattr_dotl - set file metadata
- * @mnt_userns: The user namespace of the mount
+ * @idmap: idmap of the mount
  * @dentry: file whose metadata to set
  * @iattr: metadata assignment structure
  *
  */
 
-int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
+int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct iattr *iattr)
 {
 	int retval, use_dentry = 0;
@@ -548,7 +548,7 @@ int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
 
 	p9_debug(P9_DEBUG_VFS, "\n");
 
-	retval = setattr_prepare(&init_user_ns, dentry, iattr);
+	retval = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (retval)
 		return retval;
 
@@ -597,7 +597,7 @@ int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
 		truncate_setsize(inode, iattr->ia_size);
 
 	v9fs_invalidate_inode_attr(inode);
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	mark_inode_dirty(inode);
 	if (iattr->ia_valid & ATTR_MODE) {
 		/* We also want to update ACL when we update mode bits */
diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 06b7c92343ad..223f0283d20f 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -144,7 +144,7 @@ struct adfs_discmap {
 /* Inode stuff */
 struct inode *adfs_iget(struct super_block *sb, struct object_info *obj);
 int adfs_write_inode(struct inode *inode, struct writeback_control *wbc);
-int adfs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+int adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *attr);
 
 /* map.c */
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index ee22278b0cfc..c3ac613d0975 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -294,7 +294,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
  * later.
  */
 int
-adfs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -302,7 +302,7 @@ adfs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 	unsigned int ia_valid = attr->ia_valid;
 	int error;
 	
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 
 	/*
 	 * we can't change the UID or GID of any file -
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index bfa89e131ead..8c98e2644a5e 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -185,7 +185,7 @@ extern int	affs_rename2(struct user_namespace *mnt_userns,
 /* inode.c */
 
 extern struct inode		*affs_new_inode(struct inode *dir);
-extern int			 affs_notify_change(struct user_namespace *mnt_userns,
+extern int			 affs_notify_change(struct mnt_idmap *idmap,
 					struct dentry *dentry, struct iattr *attr);
 extern void			 affs_evict_inode(struct inode *inode);
 extern struct inode		*affs_iget(struct super_block *sb,
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 2352a75bd9d6..27f77a52c5c8 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -216,7 +216,7 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 int
-affs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+affs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -224,7 +224,7 @@ affs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	pr_debug("notify_change(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		goto out;
 
@@ -250,7 +250,7 @@ affs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		affs_truncate(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 
 	if (attr->ia_valid & ATTR_MODE)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 6d3a3dbe4928..f001cf1750ec 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -870,7 +870,7 @@ static const struct afs_operation_ops afs_setattr_operation = {
 /*
  * set the attributes of an inode
  */
-int afs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int afs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr)
 {
 	const unsigned int supported =
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index fd8567b98e2b..e2a23efc91b6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1172,7 +1172,7 @@ extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
 extern int afs_getattr(struct user_namespace *mnt_userns, const struct path *,
 		       struct kstat *, u32, unsigned int);
-extern int afs_setattr(struct user_namespace *mnt_userns, struct dentry *, struct iattr *);
+extern int afs_setattr(struct mnt_idmap *idmap, struct dentry *, struct iattr *);
 extern void afs_evict_inode(struct inode *);
 extern int afs_drop_inode(struct inode *);
 
diff --git a/fs/attr.c b/fs/attr.c
index 023a3860568a..39d35621e57b 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -142,7 +142,7 @@ static bool chgrp_ok(struct user_namespace *mnt_userns,
 
 /**
  * setattr_prepare - check if attribute changes to a dentry are allowed
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	dentry to check
  * @attr:	attributes to change
  *
@@ -152,18 +152,19 @@ static bool chgrp_ok(struct user_namespace *mnt_userns,
  * SGID bit from mode if user is not allowed to set it. Also file capabilities
  * and IMA extended attributes are cleared if ATTR_KILL_PRIV is set.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply passs @nop_mnt_idmap.
  *
  * Should be called as the first thing in ->setattr implementations,
  * possibly after taking additional locks.
  */
-int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
+int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 		    struct iattr *attr)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
 
@@ -276,7 +277,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
 
 /**
  * setattr_copy - copy simple metadata updates into the generic inode
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:	the inode to be updated
  * @attr:	the new attributes
  *
@@ -289,19 +290,20 @@ EXPORT_SYMBOL(inode_newsize_ok);
  * Noticeably missing is inode size update, which is more complex
  * as it requires pagecache updates.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  *
  * The inode is not marked as dirty after this operation. The rationale is
  * that for "simple" filesystems, the struct inode is the inode storage.
  * The caller is free to mark the inode dirty afterwards if needed.
  */
-void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
+void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		  const struct iattr *attr)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	unsigned int ia_valid = attr->ia_valid;
 
 	i_uid_update(mnt_userns, attr, inode);
@@ -472,7 +474,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	    !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode)))
 		return -EOVERFLOW;
 
-	error = security_inode_setattr(mnt_userns, dentry, attr);
+	error = security_inode_setattr(idmap, dentry, attr);
 	if (error)
 		return error;
 	error = try_break_deleg(inode, delegated_inode);
@@ -480,9 +482,9 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		return error;
 
 	if (inode->i_op->setattr)
-		error = inode->i_op->setattr(mnt_userns, dentry, attr);
+		error = inode->i_op->setattr(idmap, dentry, attr);
 	else
-		error = simple_setattr(mnt_userns, dentry, attr);
+		error = simple_setattr(idmap, dentry, attr);
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 92737166203f..9cb95ff99047 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -102,7 +102,7 @@ static int bad_inode_getattr(struct user_namespace *mnt_userns,
 	return -EIO;
 }
 
-static int bad_inode_setattr(struct user_namespace *mnt_userns,
+static int bad_inode_setattr(struct mnt_idmap *idmap,
 			     struct dentry *direntry, struct iattr *attrs)
 {
 	return -EIO;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bcad9940154..36a897e5d8de 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5281,7 +5281,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	return ret;
 }
 
-static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+static int btrfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -5291,7 +5291,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	err = setattr_prepare(mnt_userns, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -5302,12 +5302,13 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	}
 
 	if (attr->ia_valid) {
-		setattr_copy(mnt_userns, inode, attr);
+		setattr_copy(idmap, inode, attr);
 		inode_inc_iversion(inode);
 		err = btrfs_dirty_inode(BTRFS_I(inode));
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
+			err = posix_acl_chmod(mnt_idmap_owner(idmap), dentry,
+					      inode->i_mode);
 	}
 
 	return err;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 23d05ec87fcc..358aadd4329a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2227,7 +2227,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 /*
  * setattr
  */
-int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -2240,7 +2240,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err != 0)
 		return err;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 30bdb391a0dc..a023a74b6650 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1043,7 +1043,7 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
 extern int ceph_permission(struct user_namespace *mnt_userns,
 			   struct inode *inode, int mask);
 extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
-extern int ceph_setattr(struct user_namespace *mnt_userns,
+extern int ceph_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct user_namespace *mnt_userns,
 			const struct path *path, struct kstat *stat,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 63a0ac2b9355..f93c295649df 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -74,7 +74,7 @@ extern int cifs_revalidate_mapping(struct inode *inode);
 extern int cifs_zap_mapping(struct inode *inode);
 extern int cifs_getattr(struct user_namespace *, const struct path *,
 			struct kstat *, u32, unsigned int);
-extern int cifs_setattr(struct user_namespace *, struct dentry *,
+extern int cifs_setattr(struct mnt_idmap *, struct dentry *,
 			struct iattr *);
 extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, u64 start,
 		       u64 len);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index f145a59af89b..653f05ce287a 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2752,7 +2752,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM)
 		attrs->ia_valid |= ATTR_FORCE;
 
-	rc = setattr_prepare(&init_user_ns, direntry, attrs);
+	rc = setattr_prepare(&nop_mnt_idmap, direntry, attrs);
 	if (rc < 0)
 		goto out;
 
@@ -2859,7 +2859,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
 	}
 
-	setattr_copy(&init_user_ns, inode, attrs);
+	setattr_copy(&nop_mnt_idmap, inode, attrs);
 	mark_inode_dirty(inode);
 
 	/* force revalidate when any of these times are set since some
@@ -2903,7 +2903,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM)
 		attrs->ia_valid |= ATTR_FORCE;
 
-	rc = setattr_prepare(&init_user_ns, direntry, attrs);
+	rc = setattr_prepare(&nop_mnt_idmap, direntry, attrs);
 	if (rc < 0)
 		goto cifs_setattr_exit;
 
@@ -3058,7 +3058,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
 	}
 
-	setattr_copy(&init_user_ns, inode, attrs);
+	setattr_copy(&nop_mnt_idmap, inode, attrs);
 	mark_inode_dirty(inode);
 
 cifs_setattr_exit:
@@ -3068,7 +3068,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 }
 
 int
-cifs_setattr(struct user_namespace *mnt_userns, struct dentry *direntry,
+cifs_setattr(struct mnt_idmap *idmap, struct dentry *direntry,
 	     struct iattr *attrs)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 9be281bbcc06..b762525eb5a2 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -51,7 +51,7 @@ int coda_permission(struct user_namespace *mnt_userns, struct inode *inode,
 int coda_revalidate_inode(struct inode *);
 int coda_getattr(struct user_namespace *, const struct path *, struct kstat *,
 		 u32, unsigned int);
-int coda_setattr(struct user_namespace *, struct dentry *, struct iattr *);
+int coda_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 
 /* this file:  helpers */
 char *coda_f2s(struct CodaFid *f);
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 2185328b65c7..8e5a431f7eb5 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -260,7 +260,7 @@ int coda_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	return err;
 }
 
-int coda_setattr(struct user_namespace *mnt_userns, struct dentry *de,
+int coda_setattr(struct mnt_idmap *idmap, struct dentry *de,
 		 struct iattr *iattr)
 {
 	struct inode *inode = d_inode(de);
diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index c0395363eab9..a94493ed3146 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -77,7 +77,7 @@ extern void configfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
-extern int configfs_setattr(struct user_namespace *mnt_userns,
+extern int configfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr);
 
 extern struct dentry *configfs_pin_fs(void);
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index b601610e9907..1c15edbe70ff 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -32,7 +32,7 @@ static const struct inode_operations configfs_inode_operations ={
 	.setattr	= configfs_setattr,
 };
 
-int configfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int configfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct iattr *iattr)
 {
 	struct inode * inode = d_inode(dentry);
@@ -60,7 +60,7 @@ int configfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 	/* attributes were changed atleast once in past */
 
-	error = simple_setattr(mnt_userns, dentry, iattr);
+	error = simple_setattr(idmap, dentry, iattr);
 	if (error)
 		return error;
 
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 2e8e112b1993..ac76e6c6ac56 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -42,7 +42,7 @@ static unsigned int debugfs_allow __ro_after_init = DEFAULT_DEBUGFS_ALLOW_BITS;
  * so that we can use the file mode as part of a heuristic to determine whether
  * to lock down individual files.
  */
-static int debugfs_setattr(struct user_namespace *mnt_userns,
+static int debugfs_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *ia)
 {
 	int ret;
@@ -52,7 +52,7 @@ static int debugfs_setattr(struct user_namespace *mnt_userns,
 		if (ret)
 			return ret;
 	}
-	return simple_setattr(&init_user_ns, dentry, ia);
+	return simple_setattr(&nop_mnt_idmap, dentry, ia);
 }
 
 static const struct inode_operations debugfs_file_inode_operations = {
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d2c5a8c55322..011b03e5c9df 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -873,7 +873,7 @@ ecryptfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 
 /**
  * ecryptfs_setattr
- * @mnt_userns: user namespace of the target mount
+ * @idmap: idmap of the target mount
  * @dentry: dentry handle to the inode to modify
  * @ia: Structure with flags of what to change and values
  *
@@ -884,7 +884,7 @@ ecryptfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
  * All other metadata changes will be passed right to the lower filesystem,
  * and we will just update our inode to look like the lower.
  */
-static int ecryptfs_setattr(struct user_namespace *mnt_userns,
+static int ecryptfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *ia)
 {
 	int rc = 0;
@@ -939,7 +939,7 @@ static int ecryptfs_setattr(struct user_namespace *mnt_userns,
 	}
 	mutex_unlock(&crypt_stat->cs_mutex);
 
-	rc = setattr_prepare(&init_user_ns, dentry, ia);
+	rc = setattr_prepare(&nop_mnt_idmap, dentry, ia);
 	if (rc)
 		goto out;
 	if (ia->ia_valid & ATTR_SIZE) {
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index bc6d21d7c5ad..7fd693a668c7 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -450,7 +450,7 @@ int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
 extern const struct file_operations exfat_file_operations;
 int __exfat_truncate(struct inode *inode);
 void exfat_truncate(struct inode *inode);
-int exfat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
 int exfat_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f5b29072775d..da61838f8842 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -242,7 +242,7 @@ int exfat_getattr(struct user_namespace *mnt_uerns, const struct path *path,
 	return 0;
 }
 
-int exfat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(dentry->d_sb);
@@ -266,7 +266,7 @@ int exfat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				ATTR_TIMES_SET);
 	}
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	attr->ia_valid = ia_valid;
 	if (error)
 		goto out;
@@ -293,7 +293,7 @@ int exfat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (attr->ia_valid & ATTR_SIZE)
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	exfat_truncate_atime(&inode->i_atime);
 
 	if (attr->ia_valid & ATTR_SIZE) {
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 28de11a22e5f..4a3e95406cce 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -753,7 +753,7 @@ extern struct inode *ext2_iget (struct super_block *, unsigned long);
 extern int ext2_write_inode (struct inode *, struct writeback_control *);
 extern void ext2_evict_inode(struct inode *);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
-extern int ext2_setattr (struct user_namespace *, struct dentry *, struct iattr *);
+extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
 extern int ext2_getattr (struct user_namespace *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern void ext2_set_inode_flags(struct inode *inode);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 69aed9e2359e..792b974a5beb 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1618,13 +1618,14 @@ int ext2_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	return 0;
 }
 
-int ext2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ext2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *iattr)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, iattr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (error)
 		return error;
 
@@ -1644,7 +1645,7 @@ int ext2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (error)
 			return error;
 	}
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	if (iattr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
 	mark_inode_dirty(inode);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 140e1eb300d1..056704d4ac9c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2976,7 +2976,7 @@ extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	__ext4_iget((sb), (ino), (flags), __func__, __LINE__)
 
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
-extern int  ext4_setattr(struct user_namespace *, struct dentry *,
+extern int  ext4_setattr(struct mnt_idmap *, struct dentry *,
 			 struct iattr *);
 extern u32  ext4_dio_alignment(struct inode *inode);
 extern int  ext4_getattr(struct user_namespace *, const struct path *,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..18fed4f5108d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5434,7 +5434,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
  *
  * Called with inode->i_rwsem down.
  */
-int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -5442,6 +5442,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	int orphan = 0;
 	const unsigned int ia_valid = attr->ia_valid;
 	bool inc_ivers = true;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
@@ -5454,7 +5455,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				  ATTR_GID | ATTR_TIMES_SET))))
 		return -EPERM;
 
-	error = setattr_prepare(mnt_userns, dentry, attr);
+	error = setattr_prepare(idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -5630,7 +5631,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!error) {
 		if (inc_ivers)
 			inode_inc_iversion(inode);
-		setattr_copy(mnt_userns, inode, attr);
+		setattr_copy(idmap, inode, attr);
 		mark_inode_dirty(inode);
 	}
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8953c3dc81a..55bd92d431e5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3471,7 +3471,7 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
 int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags);
-int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr);
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a6c401279886..6ce71c9c8d46 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -903,10 +903,11 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 }
 
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
-static void __setattr_copy(struct user_namespace *mnt_userns,
+static void __setattr_copy(struct mnt_idmap *idmap,
 			   struct inode *inode, const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	i_uid_update(mnt_userns, attr, inode);
 	i_gid_update(mnt_userns, attr, inode);
@@ -930,9 +931,10 @@ static void __setattr_copy(struct user_namespace *mnt_userns,
 #define __setattr_copy setattr_copy
 #endif
 
-int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	int err;
 
@@ -951,7 +953,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	err = setattr_prepare(mnt_userns, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -1023,7 +1025,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
 
-	__setattr_copy(mnt_userns, inode, attr);
+	__setattr_copy(idmap, inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
 		err = posix_acl_chmod(mnt_userns, dentry, f2fs_get_inode_mode(inode));
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index a415c02ede39..e38bd3a49f46 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -398,7 +398,7 @@ extern long fat_generic_ioctl(struct file *filp, unsigned int cmd,
 			      unsigned long arg);
 extern const struct file_operations fat_file_operations;
 extern const struct inode_operations fat_file_inode_operations;
-extern int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+extern int fat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *attr);
 extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
 extern int fat_getattr(struct user_namespace *mnt_userns,
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 8a6b493b5b5f..b762109a964f 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -90,13 +90,13 @@ static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 	 * out the RO attribute for checking by the security
 	 * module, just because it maps to a file mode.
 	 */
-	err = security_inode_setattr(file_mnt_user_ns(file),
+	err = security_inode_setattr(file_mnt_idmap(file),
 				     file->f_path.dentry, &ia);
 	if (err)
 		goto out_unlock_inode;
 
 	/* This MUST be done before doing anything irreversible... */
-	err = fat_setattr(file_mnt_user_ns(file), file->f_path.dentry, &ia);
+	err = fat_setattr(file_mnt_idmap(file), file->f_path.dentry, &ia);
 	if (err)
 		goto out_unlock_inode;
 
@@ -477,9 +477,10 @@ static int fat_allow_set_time(struct user_namespace *mnt_userns,
 /* valid file mode bits */
 #define FAT_VALID_MODE	(S_IFREG | S_IFDIR | S_IRWXUGO)
 
-int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int fat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid;
@@ -492,7 +493,7 @@ int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			attr->ia_valid &= ~TIMES_SET_FLAGS;
 	}
 
-	error = setattr_prepare(mnt_userns, dentry, attr);
+	error = setattr_prepare(idmap, dentry, attr);
 	attr->ia_valid = ia_valid;
 	if (error) {
 		if (sbi->options.quiet)
@@ -564,7 +565,7 @@ int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		fat_truncate_time(inode, &attr->ia_mtime, S_MTIME);
 	attr->ia_valid &= ~(ATTR_ATIME|ATTR_CTIME|ATTR_MTIME);
 
-	setattr_copy(mnt_userns, inode, attr);
+	setattr_copy(idmap, inode, attr);
 	mark_inode_dirty(inode);
 out:
 	return error;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cd1a071b625a..1633f7e9fc54 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1690,7 +1690,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -1837,7 +1837,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	return err;
 }
 
-static int fuse_setattr(struct user_namespace *mnt_userns, struct dentry *entry,
+static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 			struct iattr *attr)
 {
 	struct inode *inode = d_inode(entry);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 614db3055c02..0c8b64921c4c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1881,7 +1881,7 @@ int gfs2_permission(struct user_namespace *mnt_userns, struct inode *inode,
 
 static int __gfs2_setattr_simple(struct inode *inode, struct iattr *attr)
 {
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -1966,7 +1966,7 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
 
 /**
  * gfs2_setattr - Change attributes on an inode
- * @mnt_userns: User namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @dentry: The dentry which is changing
  * @attr: The structure describing the change
  *
@@ -1976,7 +1976,7 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
  * Returns: errno
  */
 
-static int gfs2_setattr(struct user_namespace *mnt_userns,
+static int gfs2_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -1996,7 +1996,7 @@ static int gfs2_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		goto error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		goto error;
 
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 68d0305880f7..49d02524e667 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -206,7 +206,7 @@ int hfs_write_begin(struct file *file, struct address_space *mapping,
 extern struct inode *hfs_new_inode(struct inode *, const struct qstr *, umode_t);
 extern void hfs_inode_write_fork(struct inode *, struct hfs_extent *, __be32 *, __be32 *);
 extern int hfs_write_inode(struct inode *, struct writeback_control *);
-extern int hfs_inode_setattr(struct user_namespace *, struct dentry *,
+extern int hfs_inode_setattr(struct mnt_idmap *, struct dentry *,
 			     struct iattr *);
 extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 			__be32 log_size, __be32 phys_size, u32 clump_size);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9c329a365e75..7817872a85e7 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -606,14 +606,14 @@ static int hfs_file_release(struct inode *inode, struct file *file)
  *     correspond to the same HFS file.
  */
 
-int hfs_inode_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry,
+	error = setattr_prepare(&nop_mnt_idmap, dentry,
 				attr); /* basic permission checks */
 	if (error)
 		return error;
@@ -653,7 +653,7 @@ int hfs_inode_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 						  current_time(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 840577a0c1e7..00b242f6574a 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -246,13 +246,13 @@ static int hfsplus_file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int hfsplus_setattr(struct user_namespace *mnt_userns,
+static int hfsplus_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -270,7 +270,7 @@ static int hfsplus_setattr(struct user_namespace *mnt_userns,
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 
 	return 0;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 277468783fee..f8742b7390b8 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -790,7 +790,7 @@ static int hostfs_permission(struct user_namespace *mnt_userns,
 	return err;
 }
 
-static int hostfs_setattr(struct user_namespace *mnt_userns,
+static int hostfs_setattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -800,7 +800,7 @@ static int hostfs_setattr(struct user_namespace *mnt_userns,
 
 	int fd = HOSTFS_I(inode)->fd;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -857,7 +857,7 @@ static int hostfs_setattr(struct user_namespace *mnt_userns,
 	    attr->ia_size != i_size_read(inode))
 		truncate_setsize(inode, attr->ia_size);
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index 167ec6884642..f5a2476c47bf 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -280,7 +280,7 @@ void hpfs_init_inode(struct inode *);
 void hpfs_read_inode(struct inode *);
 void hpfs_write_inode(struct inode *);
 void hpfs_write_inode_nolock(struct inode *);
-int hpfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
+int hpfs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 void hpfs_write_if_changed(struct inode *);
 void hpfs_evict_inode(struct inode *);
 
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 82208cc28ebd..e50e92a42432 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -257,7 +257,7 @@ void hpfs_write_inode_nolock(struct inode *i)
 	brelse(bh);
 }
 
-int hpfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int hpfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -275,7 +275,7 @@ int hpfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if ((attr->ia_valid & ATTR_SIZE) && attr->ia_size > inode->i_size)
 		goto out_unlock;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		goto out_unlock;
 
@@ -289,7 +289,7 @@ int hpfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		hpfs_truncate(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 
 	hpfs_write_inode(inode);
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 790d2727141a..b2f8884ed741 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -898,7 +898,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	return error;
 }
 
-static int hugetlbfs_setattr(struct user_namespace *mnt_userns,
+static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -907,7 +907,7 @@ static int hugetlbfs_setattr(struct user_namespace *mnt_userns,
 	unsigned int ia_valid = attr->ia_valid;
 	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -924,7 +924,7 @@ static int hugetlbfs_setattr(struct user_namespace *mnt_userns,
 		hugetlb_vmtruncate(inode, newsize);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 66af51c41619..28f7eea4c46d 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -190,13 +190,13 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	return 0;
 }
 
-int jffs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int jffs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int rc;
 
-	rc = setattr_prepare(&init_user_ns, dentry, iattr);
+	rc = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (rc)
 		return rc;
 
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 921d782583d6..8da19766c101 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -164,7 +164,7 @@ long jffs2_ioctl(struct file *, unsigned int, unsigned long);
 extern const struct inode_operations jffs2_symlink_inode_operations;
 
 /* fs.c */
-int jffs2_setattr (struct user_namespace *, struct dentry *, struct iattr *);
+int jffs2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
 int jffs2_do_setattr (struct inode *, struct iattr *);
 struct inode *jffs2_iget(struct super_block *, unsigned long);
 void jffs2_evict_inode (struct inode *);
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 88663465aecd..8cda5d811265 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -85,24 +85,24 @@ static int jfs_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-int jfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int jfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int rc;
 
-	rc = setattr_prepare(&init_user_ns, dentry, iattr);
+	rc = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (rc)
 		return rc;
 
-	if (is_quota_modification(mnt_userns, inode, iattr)) {
+	if (is_quota_modification(&init_user_ns, inode, iattr)) {
 		rc = dquot_initialize(inode);
 		if (rc)
 			return rc;
 	}
 	if ((iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    (iattr->ia_valid & ATTR_GID && !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		rc = dquot_transfer(mnt_userns, inode, iattr);
+		rc = dquot_transfer(&init_user_ns, inode, iattr);
 		if (rc)
 			return rc;
 	}
@@ -119,7 +119,7 @@ int jfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		jfs_truncate(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE)
diff --git a/fs/jfs/jfs_inode.h b/fs/jfs/jfs_inode.h
index 7de961a81862..6440935a9895 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -28,7 +28,7 @@ extern struct dentry *jfs_fh_to_parent(struct super_block *sb, struct fid *fid,
 	int fh_len, int fh_type);
 extern void jfs_set_inode_flags(struct inode *);
 extern int jfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-extern int jfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
+extern int jfs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 
 extern const struct address_space_operations jfs_aops;
 extern const struct inode_operations jfs_dir_inode_operations;
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index eac0f210299a..691869b1e9dd 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -107,7 +107,7 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	return ret;
 }
 
-int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -120,7 +120,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	root = kernfs_root(kn);
 	down_write(&root->kernfs_rwsem);
-	error = setattr_prepare(&init_user_ns, dentry, iattr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (error)
 		goto out;
 
@@ -129,7 +129,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		goto out;
 
 	/* this ignores size changes */
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 
 out:
 	up_write(&root->kernfs_rwsem);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 9046d9f39e63..0ccab5c997b6 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -129,7 +129,7 @@ extern const struct xattr_handler *kernfs_xattr_handlers[];
 void kernfs_evict_inode(struct inode *inode);
 int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask);
-int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *iattr);
 int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 		       const struct path *path, struct kstat *stat,
diff --git a/fs/libfs.c b/fs/libfs.c
index aada4e7c8713..0933726e3b6f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -509,7 +509,7 @@ EXPORT_SYMBOL(simple_rename);
 
 /**
  * simple_setattr - setattr for simple filesystem
- * @mnt_userns: user namespace of the target mount
+ * @idmap: idmap of the target mount
  * @dentry: dentry
  * @iattr: iattr structure
  *
@@ -522,19 +522,19 @@ EXPORT_SYMBOL(simple_rename);
  * on simple regular filesystems.  Anything that needs to change on-disk
  * or wire state on size changes needs its own setattr method.
  */
-int simple_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int simple_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(mnt_userns, dentry, iattr);
+	error = setattr_prepare(idmap, dentry, iattr);
 	if (error)
 		return error;
 
 	if (iattr->ia_valid & ATTR_SIZE)
 		truncate_setsize(inode, iattr->ia_size);
-	setattr_copy(mnt_userns, inode, iattr);
+	setattr_copy(idmap, inode, iattr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -1324,7 +1324,7 @@ static int empty_dir_getattr(struct user_namespace *mnt_userns,
 	return 0;
 }
 
-static int empty_dir_setattr(struct user_namespace *mnt_userns,
+static int empty_dir_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr)
 {
 	return -EPERM;
diff --git a/fs/minix/file.c b/fs/minix/file.c
index 6a7bd2d9eec0..0dd05d47724a 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -22,13 +22,13 @@ const struct file_operations minix_file_operations = {
 	.splice_read	= generic_file_splice_read,
 };
 
-static int minix_setattr(struct user_namespace *mnt_userns,
+static int minix_setattr(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -42,7 +42,7 @@ static int minix_setattr(struct user_namespace *mnt_userns,
 		minix_truncate(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e98ee7599eeb..d31ea0a1ebd6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -606,7 +606,7 @@ EXPORT_SYMBOL_GPL(nfs_fhget);
 #define NFS_VALID_ATTRS (ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_SIZE|ATTR_ATIME|ATTR_ATIME_SET|ATTR_MTIME|ATTR_MTIME_SET|ATTR_FILE|ATTR_OPEN)
 
 int
-nfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index b0ef7e7ddb30..971132dfc93a 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -220,11 +220,11 @@ nfs_namespace_getattr(struct user_namespace *mnt_userns,
 }
 
 static int
-nfs_namespace_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+nfs_namespace_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct iattr *attr)
 {
 	if (NFS_FH(d_inode(dentry))->size != 0)
-		return nfs_setattr(mnt_userns, dentry, attr);
+		return nfs_setattr(idmap, dentry, attr);
 	return -EACCES;
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a5570cf75f3f..35cab9a65c17 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -93,7 +93,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		if (delta < 0)
 			delta = -delta;
 		if (delta < MAX_TOUCH_TIME_ERROR &&
-		    setattr_prepare(&init_user_ns, fhp->fh_dentry, iap) != 0) {
+		    setattr_prepare(&nop_mnt_idmap, fhp->fh_dentry, iap) != 0) {
 			/*
 			 * Turn off ATTR_[AM]TIME_SET but leave ATTR_[AM]TIME.
 			 * This will cause notify_change to set these times
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 232dd7b6cca1..30b145ff1a8d 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -949,7 +949,7 @@ void nilfs_evict_inode(struct inode *inode)
 	 */
 }
 
-int nilfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int nilfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *iattr)
 {
 	struct nilfs_transaction_info ti;
@@ -957,7 +957,7 @@ int nilfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	struct super_block *sb = inode->i_sb;
 	int err;
 
-	err = setattr_prepare(&init_user_ns, dentry, iattr);
+	err = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (err)
 		return err;
 
@@ -972,7 +972,7 @@ int nilfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		nilfs_truncate(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE) {
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index aecda4fc95f5..7bac8e515ace 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -271,7 +271,7 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode);
 extern void nilfs_update_inode(struct inode *, struct buffer_head *, int);
 extern void nilfs_truncate(struct inode *);
 extern void nilfs_evict_inode(struct inode *);
-extern int nilfs_setattr(struct user_namespace *, struct dentry *,
+extern int nilfs_setattr(struct mnt_idmap *, struct dentry *,
 			 struct iattr *);
 extern void nilfs_write_failed(struct address_space *mapping, loff_t to);
 int nilfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 08c659332e26..e6fc5f7cb1d7 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2865,7 +2865,7 @@ void ntfs_truncate_vfs(struct inode *vi) {
 
 /**
  * ntfs_setattr - called from notify_change() when an attribute is being changed
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	dentry whose attributes to change
  * @attr:	structure describing the attributes and the changes
  *
@@ -2878,14 +2878,14 @@ void ntfs_truncate_vfs(struct inode *vi) {
  *
  * Called with ->i_mutex held.
  */
-int ntfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	struct inode *vi = d_inode(dentry);
 	int err;
 	unsigned int ia_valid = attr->ia_valid;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
 		goto out;
 	/* We do not support NTFS ACLs yet. */
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 6f78ee00f57f..147ef4ddb691 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -289,7 +289,7 @@ extern int ntfs_show_options(struct seq_file *sf, struct dentry *root);
 extern int ntfs_truncate(struct inode *vi);
 extern void ntfs_truncate_vfs(struct inode *vi);
 
-extern int ntfs_setattr(struct user_namespace *mnt_userns,
+extern int ntfs_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr);
 
 extern int __ntfs_write_inode(struct inode *vi, int sync);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index e5399ebc3a2b..3303b6c88680 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -657,7 +657,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 /*
  * ntfs3_setattr - inode_operations::setattr
  */
-int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -676,7 +676,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		ia_valid = attr->ia_valid;
 	}
 
-	err = setattr_prepare(mnt_userns, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		goto out;
 
@@ -704,10 +704,10 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		inode->i_size = newsize;
 	}
 
-	setattr_copy(mnt_userns, inode, attr);
+	setattr_copy(idmap, inode, attr);
 
 	if (mode != inode->i_mode) {
-		err = ntfs_acl_chmod(mnt_userns, dentry);
+		err = ntfs_acl_chmod(mnt_idmap_owner(idmap), dentry);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0e051c5595a2..870733297122 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -494,8 +494,10 @@ extern const struct file_operations ntfs_dir_operations;
 /* Globals from file.c */
 int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
-int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
+void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
+			 CLST len);
 int ntfs_file_open(struct inode *inode, struct file *file);
 int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 8b2020f92b5f..2d907ac86409 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -188,18 +188,18 @@ static int dlmfs_file_release(struct inode *inode,
  * We do ->setattr() just to override size changes.  Our size is the size
  * of the LVB and nothing else.
  */
-static int dlmfs_file_setattr(struct user_namespace *mnt_userns,
+static int dlmfs_file_setattr(struct mnt_idmap *idmap,
 			      struct dentry *dentry, struct iattr *attr)
 {
 	int error;
 	struct inode *inode = d_inode(dentry);
 
 	attr->ia_valid &= ~ATTR_SIZE;
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 5c60b6bc85bf..e157deb68d38 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1111,9 +1111,10 @@ static int ocfs2_extend_file(struct inode *inode,
 	return ret;
 }
 
-int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int status = 0, size_change;
 	int inode_locked = 0;
 	struct inode *inode = d_inode(dentry);
@@ -1142,7 +1143,7 @@ int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!(attr->ia_valid & OCFS2_VALID_ATTRS))
 		return 0;
 
-	status = setattr_prepare(&init_user_ns, dentry, attr);
+	status = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (status)
 		return status;
 
@@ -1265,7 +1266,7 @@ int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 
 	status = ocfs2_mark_inode_dirty(handle, inode, bh);
diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
index 71db8f3aa027..76020b348df2 100644
--- a/fs/ocfs2/file.h
+++ b/fs/ocfs2/file.h
@@ -49,7 +49,7 @@ int ocfs2_extend_no_holes(struct inode *inode, struct buffer_head *di_bh,
 			  u64 new_i_size, u64 zero_to);
 int ocfs2_zero_extend(struct inode *inode, struct buffer_head *di_bh,
 		      loff_t zero_to);
-int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
 int ocfs2_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		  struct kstat *stat, u32 request_mask, unsigned int flags);
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 3a5b4b88a583..0101f1f87b56 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -337,13 +337,13 @@ const struct file_operations omfs_file_operations = {
 	.splice_read = generic_file_splice_read,
 };
 
-static int omfs_setattr(struct user_namespace *mnt_userns,
+static int omfs_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -356,7 +356,7 @@ static int omfs_setattr(struct user_namespace *mnt_userns,
 		omfs_truncate(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4df560894386..011892b23b5e 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -822,7 +822,7 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 		ORANGEFS_I(inode)->attr_uid = current_fsuid();
 		ORANGEFS_I(inode)->attr_gid = current_fsgid();
 	}
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	spin_unlock(&inode->i_lock);
 	mark_inode_dirty(inode);
 
@@ -846,13 +846,13 @@ int __orangefs_setattr_mode(struct dentry *dentry, struct iattr *iattr)
 /*
  * Change attributes of an object referenced by dentry.
  */
-int orangefs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int orangefs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct iattr *iattr)
 {
 	int ret;
 	gossip_debug(GOSSIP_INODE_DEBUG, "__orangefs_setattr: called on %pd\n",
 	    dentry);
-	ret = setattr_prepare(&init_user_ns, dentry, iattr);
+	ret = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (ret)
 	        goto out;
 	ret = __orangefs_setattr_mode(dentry, iattr);
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 6e0cc01b3a14..142abd37cdda 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -362,7 +362,7 @@ struct inode *orangefs_new_inode(struct super_block *sb,
 
 int __orangefs_setattr(struct inode *, struct iattr *);
 int __orangefs_setattr_mode(struct dentry *dentry, struct iattr *iattr);
-int orangefs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
+int orangefs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 
 int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		     struct kstat *stat, u32 request_mask, unsigned int flags);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ee6dfa577c93..8796a0feb34f 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -19,7 +19,7 @@
 #include "overlayfs.h"
 
 
-int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr)
 {
 	int err;
@@ -28,7 +28,7 @@ int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	struct dentry *upperdentry;
 	const struct cred *old_cred;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -677,7 +677,7 @@ int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
 		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
 
-		err = ovl_setattr(&init_user_ns, dentry, &iattr);
+		err = ovl_setattr(&nop_mnt_idmap, dentry, &iattr);
 		if (err)
 			return err;
 	}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ff89454b07fc..4cd435aabbb4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -597,7 +597,7 @@ int ovl_set_nlink_lower(struct dentry *dentry);
 unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 			   struct dentry *upperdentry,
 			   unsigned int fallback);
-int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr);
 int ovl_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..92166c33395d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -685,7 +685,7 @@ static bool proc_fd_access_allowed(struct inode *inode)
 	return allowed;
 }
 
-int proc_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int proc_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	int error;
@@ -694,11 +694,11 @@ int proc_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (attr->ia_valid & ATTR_MODE)
 		return -EPERM;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 587b91d9d998..4464ad6a2283 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -115,18 +115,18 @@ static bool pde_subdir_insert(struct proc_dir_entry *dir,
 	return true;
 }
 
-static int proc_notify_change(struct user_namespace *mnt_userns,
+static int proc_notify_change(struct mnt_idmap *idmap,
 			      struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct proc_dir_entry *de = PDE(inode);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, iattr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (error)
 		return error;
 
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	mark_inode_dirty(inode);
 
 	proc_set_user(de, inode->i_uid, inode->i_gid);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index b701d0207edf..6eb921670fc6 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -164,7 +164,7 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
 extern const struct dentry_operations pid_dentry_operations;
 extern int pid_getattr(struct user_namespace *, const struct path *,
 		       struct kstat *, u32, unsigned int);
-extern int proc_setattr(struct user_namespace *, struct dentry *,
+extern int proc_setattr(struct mnt_idmap *, struct dentry *,
 			struct iattr *);
 extern void proc_pid_evict_inode(struct proc_inode *);
 extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 48f2d60bd78a..daba911972ec 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -827,7 +827,7 @@ static int proc_sys_permission(struct user_namespace *mnt_userns,
 	return error;
 }
 
-static int proc_sys_setattr(struct user_namespace *mnt_userns,
+static int proc_sys_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -836,11 +836,11 @@ static int proc_sys_setattr(struct user_namespace *mnt_userns,
 	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		return -EPERM;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index cb240eac5036..5bf74c2f6042 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -22,7 +22,7 @@
 #include <linux/uaccess.h>
 #include "internal.h"
 
-static int ramfs_nommu_setattr(struct user_namespace *, struct dentry *, struct iattr *);
+static int ramfs_nommu_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
 						   unsigned long addr,
 						   unsigned long len,
@@ -158,7 +158,7 @@ static int ramfs_nommu_resize(struct inode *inode, loff_t newsize, loff_t size)
  * handle a change of attributes
  * - we're specifically interested in a change of size
  */
-static int ramfs_nommu_setattr(struct user_namespace *mnt_userns,
+static int ramfs_nommu_setattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, struct iattr *ia)
 {
 	struct inode *inode = d_inode(dentry);
@@ -166,7 +166,7 @@ static int ramfs_nommu_setattr(struct user_namespace *mnt_userns,
 	int ret = 0;
 
 	/* POSIX UID/GID verification for setting inode attributes */
-	ret = setattr_prepare(&init_user_ns, dentry, ia);
+	ret = setattr_prepare(&nop_mnt_idmap, dentry, ia);
 	if (ret)
 		return ret;
 
@@ -186,7 +186,7 @@ static int ramfs_nommu_setattr(struct user_namespace *mnt_userns,
 		}
 	}
 
-	setattr_copy(&init_user_ns, inode, ia);
+	setattr_copy(&nop_mnt_idmap, inode, ia);
  out:
 	ia->ia_valid = old_ia_valid;
 	return ret;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c7d1fa526dea..35b9b8ec1cbe 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3262,21 +3262,21 @@ static ssize_t reiserfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int reiserfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid;
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
 	/* must be turned off for recursive notify_change calls */
 	ia_valid = attr->ia_valid &= ~(ATTR_KILL_SUID|ATTR_KILL_SGID);
 
-	if (is_quota_modification(mnt_userns, inode, attr)) {
+	if (is_quota_modification(&init_user_ns, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
@@ -3359,7 +3359,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		reiserfs_write_unlock(inode->i_sb);
 		if (error)
 			goto out;
-		error = dquot_transfer(mnt_userns, inode, attr);
+		error = dquot_transfer(&init_user_ns, inode, attr);
 		reiserfs_write_lock(inode->i_sb);
 		if (error) {
 			journal_end(&th);
@@ -3398,7 +3398,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	if (!error) {
-		setattr_copy(&init_user_ns, inode, attr);
+		setattr_copy(&nop_mnt_idmap, inode, attr);
 		mark_inode_dirty(inode);
 	}
 
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 3aa928ec527a..9a4a7f7897fe 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3100,7 +3100,7 @@ static inline void reiserfs_update_sd(struct reiserfs_transaction_handle *th,
 }
 
 void sd_attrs_to_i_attrs(__u16 sd_attrs, struct inode *inode);
-int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int reiserfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct iattr *attr);
 
 int __reiserfs_write_begin(struct page *page, unsigned from, unsigned len);
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 8b2d52443f41..af6137f53cf8 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -352,7 +352,7 @@ static int chown_one_xattr(struct dentry *dentry, void *data)
 	 * ATTR_MODE is set.
 	 */
 	attrs->ia_valid &= (ATTR_UID|ATTR_GID);
-	err = reiserfs_setattr(&init_user_ns, dentry, attrs);
+	err = reiserfs_setattr(&nop_mnt_idmap, dentry, attrs);
 	attrs->ia_valid = ia_valid;
 
 	return err;
@@ -597,7 +597,7 @@ reiserfs_xattr_set_handle(struct reiserfs_transaction_handle *th,
 		inode_lock_nested(d_inode(dentry), I_MUTEX_XATTR);
 		inode_dio_wait(d_inode(dentry));
 
-		err = reiserfs_setattr(&init_user_ns, dentry, &newattrs);
+		err = reiserfs_setattr(&nop_mnt_idmap, dentry, &newattrs);
 		inode_unlock(d_inode(dentry));
 	} else
 		update_ctime(inode);
diff --git a/fs/sysv/file.c b/fs/sysv/file.c
index 90e00124ea07..50eb92557a0f 100644
--- a/fs/sysv/file.c
+++ b/fs/sysv/file.c
@@ -29,13 +29,13 @@ const struct file_operations sysv_file_operations = {
 	.splice_read	= generic_file_splice_read,
 };
 
-static int sysv_setattr(struct user_namespace *mnt_userns,
+static int sysv_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -48,7 +48,7 @@ static int sysv_setattr(struct user_namespace *mnt_userns,
 		sysv_truncate(inode);
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index f2353dd676ef..e666337df02c 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1258,7 +1258,7 @@ static int do_setattr(struct ubifs_info *c, struct inode *inode,
 	return err;
 }
 
-int ubifs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
 	int err;
@@ -1267,7 +1267,7 @@ int ubifs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	dbg_gen("ino %lu, mode %#x, ia_valid %#x",
 		inode->i_ino, inode->i_mode, attr->ia_valid);
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
 		return err;
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 478bbbb5382f..9b66e762950b 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2020,7 +2020,7 @@ int ubifs_calc_dark(const struct ubifs_info *c, int spc);
 
 /* file.c */
 int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
-int ubifs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
 int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 5c659e23e578..2efbbbaa2da7 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -256,14 +256,14 @@ const struct file_operations udf_file_operations = {
 	.llseek			= generic_file_llseek,
 };
 
-static int udf_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+static int udf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = inode->i_sb;
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -286,7 +286,7 @@ static int udf_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (attr->ia_valid & ATTR_MODE)
 		udf_update_extra_perms(inode, attr->ia_mode);
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a873de7dec1c..a4246c83a8cd 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1212,14 +1212,14 @@ static int ufs_truncate(struct inode *inode, loff_t size)
 	return err;
 }
 
-int ufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ufs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -1229,7 +1229,7 @@ int ufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			return error;
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 550f7c5a3636..6b499180643b 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -123,7 +123,7 @@ extern struct inode *ufs_iget(struct super_block *, unsigned long);
 extern int ufs_write_inode (struct inode *, struct writeback_control *);
 extern int ufs_sync_inode (struct inode *);
 extern void ufs_evict_inode (struct inode *);
-extern int ufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+extern int ufs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *attr);
 
 /* namei.c */
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index e1db0f3f7e5e..046b5a3bf314 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -256,7 +256,7 @@ int vboxsf_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	return 0;
 }
 
-int vboxsf_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vboxsf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct iattr *iattr)
 {
 	struct vboxsf_inode *sf_i = VBOXSF_I(d_inode(dentry));
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 9047befa66c5..7de5a0a4e285 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -100,7 +100,7 @@ int vboxsf_inode_revalidate(struct dentry *dentry);
 int vboxsf_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		   struct kstat *kstat, u32 request_mask,
 		   unsigned int query_flags);
-int vboxsf_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int vboxsf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct iattr *iattr);
 struct shfl_string *vboxsf_path_from_dentry(struct vboxsf_sbi *sbi,
 					    struct dentry *dentry);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 595a5bcf46b9..d06c0cc62f61 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1047,7 +1047,7 @@ xfs_file_fallocate(
 
 		iattr.ia_valid = ATTR_SIZE;
 		iattr.ia_size = new_size;
-		error = xfs_vn_setattr_size(file_mnt_user_ns(file),
+		error = xfs_vn_setattr_size(file_mnt_idmap(file),
 					    file_dentry(file), &iattr);
 		if (error)
 			goto out_unlock;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 515318dfbc38..ba764205bd3a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -627,7 +627,7 @@ xfs_vn_getattr(
 
 static int
 xfs_vn_change_ok(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
 	struct iattr		*iattr)
 {
@@ -639,7 +639,7 @@ xfs_vn_change_ok(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	return setattr_prepare(mnt_userns, dentry, iattr);
+	return setattr_prepare(idmap, dentry, iattr);
 }
 
 /*
@@ -650,7 +650,7 @@ xfs_vn_change_ok(
  */
 static int
 xfs_setattr_nonsize(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
 	struct xfs_inode	*ip,
 	struct iattr		*iattr)
@@ -664,6 +664,7 @@ xfs_setattr_nonsize(
 	kgid_t			gid = GLOBAL_ROOT_GID;
 	struct xfs_dquot	*udqp = NULL, *gdqp = NULL;
 	struct xfs_dquot	*old_udqp = NULL, *old_gdqp = NULL;
+	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 
 	ASSERT((mask & ATTR_SIZE) == 0);
 
@@ -730,7 +731,7 @@ xfs_setattr_nonsize(
 		old_gdqp = xfs_qm_vop_chown(tp, ip, &ip->i_gdquot, gdqp);
 	}
 
-	setattr_copy(mnt_userns, inode, iattr);
+	setattr_copy(idmap, inode, iattr);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	XFS_STATS_INC(mp, xs_ig_attrchg);
@@ -779,7 +780,7 @@ xfs_setattr_nonsize(
  */
 STATIC int
 xfs_setattr_size(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
 	struct xfs_inode	*ip,
 	struct iattr		*iattr)
@@ -812,7 +813,7 @@ xfs_setattr_size(
 		 * Use the regular setattr path to update the timestamps.
 		 */
 		iattr->ia_valid &= ~ATTR_SIZE;
-		return xfs_setattr_nonsize(mnt_userns, dentry, ip, iattr);
+		return xfs_setattr_nonsize(idmap, dentry, ip, iattr);
 	}
 
 	/*
@@ -956,7 +957,7 @@ xfs_setattr_size(
 	}
 
 	ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
-	setattr_copy(mnt_userns, inode, iattr);
+	setattr_copy(idmap, inode, iattr);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	XFS_STATS_INC(mp, xs_ig_attrchg);
@@ -977,7 +978,7 @@ xfs_setattr_size(
 
 int
 xfs_vn_setattr_size(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
 	struct iattr		*iattr)
 {
@@ -986,15 +987,15 @@ xfs_vn_setattr_size(
 
 	trace_xfs_setattr(ip);
 
-	error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
+	error = xfs_vn_change_ok(idmap, dentry, iattr);
 	if (error)
 		return error;
-	return xfs_setattr_size(mnt_userns, dentry, ip, iattr);
+	return xfs_setattr_size(idmap, dentry, ip, iattr);
 }
 
 STATIC int
 xfs_vn_setattr(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct dentry		*dentry,
 	struct iattr		*iattr)
 {
@@ -1014,14 +1015,14 @@ xfs_vn_setattr(
 			return error;
 		}
 
-		error = xfs_vn_setattr_size(mnt_userns, dentry, iattr);
+		error = xfs_vn_setattr_size(idmap, dentry, iattr);
 		xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
 	} else {
 		trace_xfs_setattr(ip);
 
-		error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
+		error = xfs_vn_change_ok(idmap, dentry, iattr);
 		if (!error)
-			error = xfs_setattr_nonsize(mnt_userns, dentry, ip, iattr);
+			error = xfs_setattr_nonsize(idmap, dentry, ip, iattr);
 	}
 
 	return error;
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index e570dcb5df8d..7f84a0843b24 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -13,7 +13,7 @@ extern const struct file_operations xfs_dir_file_operations;
 
 extern ssize_t xfs_vn_listxattr(struct dentry *, char *data, size_t size);
 
-int xfs_vn_setattr_size(struct user_namespace *mnt_userns,
+int xfs_vn_setattr_size(struct mnt_idmap *idmap,
 		struct dentry *dentry, struct iattr *vap);
 
 int xfs_inode_init_security(struct inode *inode, struct inode *dir,
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 38d23f0e703a..23d16186e1a3 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -322,7 +322,7 @@ xfs_fs_commit_blocks(
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 	if (update_isize) {
 		i_size_write(inode, iattr->ia_size);
 		ip->i_disk_size = iattr->ia_size;
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 2c53fbb8d918..df3c139c7d0e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -600,7 +600,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 	return ret;
 }
 
-static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
+static int zonefs_inode_setattr(struct mnt_idmap *idmap,
 				struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -609,7 +609,7 @@ static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
 
-	ret = setattr_prepare(&init_user_ns, dentry, iattr);
+	ret = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (ret)
 		return ret;
 
@@ -626,7 +626,7 @@ static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
 	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    ((iattr->ia_valid & ATTR_GID) &&
 	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		ret = dquot_transfer(mnt_userns, inode, iattr);
+		ret = dquot_transfer(&init_user_ns, inode, iattr);
 		if (ret)
 			return ret;
 	}
@@ -637,7 +637,7 @@ static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
 			return ret;
 	}
 
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
 
 	return 0;
 }
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 7a9ee2157f69..1f8f806dd0d1 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -21,7 +21,7 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     void *xattr_value,
 					     size_t xattr_value_len,
 					     struct integrity_iint_cache *iint);
-extern int evm_inode_setattr(struct user_namespace *mnt_userns,
+extern int evm_inode_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr);
 extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct user_namespace *mnt_userns,
@@ -90,7 +90,7 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 }
 #endif
 
-static inline int evm_inode_setattr(struct user_namespace *mnt_userns,
+static inline int evm_inode_setattr(struct mnt_idmap *idmap,
 				    struct dentry *dentry, struct iattr *attr)
 {
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7aa302d2ce39..24e378e2835f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2152,8 +2152,7 @@ struct inode_operations {
 		      umode_t,dev_t);
 	int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
-	int (*setattr) (struct user_namespace *, struct dentry *,
-			struct iattr *);
+	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
 	int (*getattr) (struct user_namespace *, const struct path *,
 			struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
@@ -3313,7 +3312,7 @@ extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
 extern int dcache_readdir(struct file *, struct dir_context *);
-extern int simple_setattr(struct user_namespace *, struct dentry *,
+extern int simple_setattr(struct mnt_idmap *, struct dentry *,
 			  struct iattr *);
 extern int simple_getattr(struct user_namespace *, const struct path *,
 			  struct kstat *, u32, unsigned int);
@@ -3368,9 +3367,9 @@ extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
 int may_setattr(struct user_namespace *mnt_userns, struct inode *inode,
 		unsigned int ia_valid);
-int setattr_prepare(struct user_namespace *, struct dentry *, struct iattr *);
+int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);
 extern int inode_newsize_ok(const struct inode *, loff_t offset);
-void setattr_copy(struct user_namespace *, struct inode *inode,
+void setattr_copy(struct mnt_idmap *, struct inode *inode,
 		  const struct iattr *attr);
 
 extern int file_update_time(struct file *file);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index d92fdfd2444c..7c9628dc61a3 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -405,7 +405,7 @@ extern int nfs_clear_invalid_mapping(struct address_space *mapping);
 extern bool nfs_mapping_need_revalidate_inode(struct inode *inode);
 extern int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
 extern int nfs_revalidate_mapping_rcu(struct inode *inode);
-extern int nfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
+extern int nfs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 extern void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr, struct nfs_fattr *);
 extern void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr);
 extern struct nfs_open_context *get_nfs_open_context(struct nfs_open_context *ctx);
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f7de..1ba1f4e70b50 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -356,7 +356,7 @@ int security_inode_readlink(struct dentry *dentry);
 int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 			       bool rcu);
 int security_inode_permission(struct inode *inode, int mask);
-int security_inode_setattr(struct user_namespace *mnt_userns,
+int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr);
 int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct user_namespace *mnt_userns,
@@ -862,7 +862,7 @@ static inline int security_inode_permission(struct inode *inode, int mask)
 	return 0;
 }
 
-static inline int security_inode_setattr(struct user_namespace *mnt_userns,
+static inline int security_inode_setattr(struct mnt_idmap *idmap,
 					 struct dentry *dentry,
 					 struct iattr *attr)
 {
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 04c3ac9448a1..afcf46e99cda 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -162,7 +162,7 @@ const struct address_space_operations secretmem_aops = {
 	.migrate_folio	= secretmem_migrate_folio,
 };
 
-static int secretmem_setattr(struct user_namespace *mnt_userns,
+static int secretmem_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -175,7 +175,7 @@ static int secretmem_setattr(struct user_namespace *mnt_userns,
 	if ((ia_valid & ATTR_SIZE) && inode->i_size)
 		ret = -EINVAL;
 	else
-		ret = simple_setattr(mnt_userns, dentry, iattr);
+		ret = simple_setattr(idmap, dentry, iattr);
 
 	filemap_invalidate_unlock(mapping);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb..6976df4e78b6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1082,7 +1082,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	return 0;
 }
 
-static int shmem_setattr(struct user_namespace *mnt_userns,
+static int shmem_setattr(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
@@ -1091,7 +1091,7 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	bool update_mtime = false;
 	bool update_ctime = true;
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -1129,7 +1129,7 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 		}
 	}
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(&nop_mnt_idmap, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(&init_user_ns, dentry, inode->i_mode);
 	if (!error && update_ctime) {
diff --git a/net/socket.c b/net/socket.c
index 888cd618a968..6234b07a056f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -589,10 +589,10 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 	return used;
 }
 
-static int sockfs_setattr(struct user_namespace *mnt_userns,
+static int sockfs_setattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct iattr *iattr)
 {
-	int err = simple_setattr(&init_user_ns, dentry, iattr);
+	int err = simple_setattr(&nop_mnt_idmap, dentry, iattr);
 
 	if (!err && (iattr->ia_valid & ATTR_UID)) {
 		struct socket *sock = SOCKET_I(d_inode(dentry));
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index f02e609460e2..e5a6a3bb1209 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -779,10 +779,11 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
-static int evm_attr_change(struct user_namespace *mnt_userns,
+static int evm_attr_change(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	unsigned int ia_valid = attr->ia_valid;
 
 	if (!i_uid_needs_update(mnt_userns, attr, inode) &&
@@ -800,7 +801,7 @@ static int evm_attr_change(struct user_namespace *mnt_userns,
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
  */
-int evm_inode_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
@@ -827,7 +828,7 @@ int evm_inode_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return 0;
 
 	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
-	    !evm_attr_change(mnt_userns, dentry, attr))
+	    !evm_attr_change(idmap, dentry, attr))
 		return 0;
 
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 8a9db7dfca7e..9b907c2fee60 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -228,7 +228,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 		newattrs.ia_valid = ATTR_MODE;
 		inode = evm_xattrs->d_inode;
 		inode_lock(inode);
-		err = simple_setattr(&init_user_ns, evm_xattrs, &newattrs);
+		err = simple_setattr(&nop_mnt_idmap, evm_xattrs, &newattrs);
 		inode_unlock(inode);
 		if (!err)
 			err = count;
diff --git a/security/security.c b/security/security.c
index d1571900a8c7..fceab8e0ff87 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1354,7 +1354,7 @@ int security_inode_permission(struct inode *inode, int mask)
 	return call_int_hook(inode_permission, 0, inode, mask);
 }
 
-int security_inode_setattr(struct user_namespace *mnt_userns,
+int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
 	int ret;
@@ -1364,7 +1364,7 @@ int security_inode_setattr(struct user_namespace *mnt_userns,
 	ret = call_int_hook(inode_setattr, 0, dentry, attr);
 	if (ret)
 		return ret;
-	return evm_inode_setattr(mnt_userns, dentry, attr);
+	return evm_inode_setattr(idmap, dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 

-- 
2.34.1

