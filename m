Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A486695F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbjAMLww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7BCE0ED
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 366ECB820EB
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C084C433F0;
        Fri, 13 Jan 2023 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610588;
        bh=uSfSs8Z2gUnJ8tUnAPFS3xKp3ndLzv8sDl4mllb9aBY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=c3EqRmtkX4brBd9NSRveWGmHZTvIt1LNKTlSJ7R0zk38VJEcHPoDROwkvrUZZKAWi
         Y50S5edjzYRnYAfB+UyA+ftXVFgGXOTxjARmzx1IT/UHxzVrm5o8dlkeF9eN79PQ1i
         c6kIl3jIEBGYfVzDcWcKnykUpjZJWAm1C6e5A+ZHu81OV352bEy0vxHxqOXjs57zmH
         RaHWV7tOWYDPP2c3iMqcWZVzvRl9Ci1pLkk9/O098v6Jy9UWiHDc8HZhauBWDkpY8e
         UIkeZ27vyoq49yevVUmeX8nCRmqdUtSuEWufRiOny0p6uUDwKJNp0wS2efCTDwZ0a9
         iuJXA1V8Lst9g==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:12 +0100
Subject: [PATCH 04/25] fs: port ->getattr() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-4-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=69112; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uSfSs8Z2gUnJ8tUnAPFS3xKp3ndLzv8sDl4mllb9aBY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2qbtzNrny4WDZAMymY/bmb/1/Zf27CTuIfDEw9P6++
 qTK9o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ7Gxh+s/99ZDf15HVm9lefPmc28F
 xrmuHkEWZVOufo561LM/5772f4Z3lcY+uulqxnyzzK3nLvWnTqoMfhwP4Q2aYmPmOhqz41vAA=
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
 fs/9p/vfs_inode.c                     |  8 ++++----
 fs/9p/vfs_inode_dotl.c                |  6 +++---
 fs/afs/inode.c                        |  4 ++--
 fs/afs/internal.h                     |  2 +-
 fs/bad_inode.c                        |  2 +-
 fs/btrfs/inode.c                      |  4 ++--
 fs/ceph/inode.c                       |  4 ++--
 fs/ceph/super.h                       |  2 +-
 fs/cifs/cifsfs.h                      |  2 +-
 fs/cifs/inode.c                       |  4 ++--
 fs/coda/coda_linux.h                  |  2 +-
 fs/coda/inode.c                       |  4 ++--
 fs/ecryptfs/inode.c                   |  8 ++++----
 fs/erofs/inode.c                      |  4 ++--
 fs/erofs/internal.h                   |  2 +-
 fs/exfat/exfat_fs.h                   |  2 +-
 fs/exfat/file.c                       |  4 ++--
 fs/ext2/ext2.h                        |  2 +-
 fs/ext2/inode.c                       |  4 ++--
 fs/ext4/ext4.h                        |  4 ++--
 fs/ext4/inode.c                       |  8 ++++----
 fs/ext4/symlink.c                     |  4 ++--
 fs/f2fs/f2fs.h                        |  2 +-
 fs/f2fs/file.c                        |  4 ++--
 fs/f2fs/namei.c                       |  4 ++--
 fs/fat/fat.h                          |  2 +-
 fs/fat/file.c                         |  4 ++--
 fs/fuse/dir.c                         |  4 ++--
 fs/gfs2/inode.c                       |  6 +++---
 fs/hfsplus/hfsplus_fs.h               |  2 +-
 fs/hfsplus/inode.c                    |  4 ++--
 fs/kernfs/inode.c                     |  4 ++--
 fs/kernfs/kernfs-internal.h           |  2 +-
 fs/ksmbd/smb2pdu.c                    | 19 ++++++++++---------
 fs/ksmbd/smb_common.c                 |  4 ++--
 fs/ksmbd/vfs.c                        |  6 +++---
 fs/ksmbd/vfs.h                        |  2 +-
 fs/libfs.c                            |  8 ++++----
 fs/minix/inode.c                      |  4 ++--
 fs/minix/minix.h                      |  2 +-
 fs/nfs/inode.c                        |  4 ++--
 fs/nfs/namespace.c                    |  6 +++---
 fs/ntfs3/file.c                       |  4 ++--
 fs/ntfs3/ntfs_fs.h                    |  2 +-
 fs/ocfs2/file.c                       |  4 ++--
 fs/ocfs2/file.h                       |  2 +-
 fs/orangefs/inode.c                   |  4 ++--
 fs/orangefs/orangefs-kernel.h         |  2 +-
 fs/overlayfs/inode.c                  |  2 +-
 fs/overlayfs/overlayfs.h              |  2 +-
 fs/proc/base.c                        |  8 ++++----
 fs/proc/fd.c                          |  4 ++--
 fs/proc/generic.c                     |  4 ++--
 fs/proc/internal.h                    |  2 +-
 fs/proc/proc_net.c                    |  4 ++--
 fs/proc/proc_sysctl.c                 |  4 ++--
 fs/proc/root.c                        |  4 ++--
 fs/stat.c                             | 22 ++++++++++++----------
 fs/sysv/itree.c                       |  4 ++--
 fs/sysv/sysv.h                        |  2 +-
 fs/ubifs/dir.c                        |  4 ++--
 fs/ubifs/file.c                       |  4 ++--
 fs/ubifs/ubifs.h                      |  4 ++--
 fs/udf/symlink.c                      |  4 ++--
 fs/vboxsf/utils.c                     |  4 ++--
 fs/vboxsf/vfsmod.h                    |  2 +-
 fs/xfs/xfs_iops.c                     |  3 ++-
 include/linux/fs.h                    |  6 +++---
 include/linux/nfs_fs.h                |  2 +-
 mm/shmem.c                            |  4 ++--
 72 files changed, 152 insertions(+), 148 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 04ad02dcd269..556a23af1edf 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -72,7 +72,7 @@ prototypes::
 	int (*permission) (struct inode *, int, unsigned int);
 	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
-	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
+	int (*getattr) (struct mnt_idmap *, const struct path *, struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start, u64 len);
 	void (*update_time)(struct inode *, struct timespec *, int);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 894e2a5c3603..09184d98fc8c 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -437,7 +437,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*permission) (struct user_namespace *, struct inode *, int);
 		struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 		int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
-		int (*getattr) (struct user_namespace *, const struct path *, struct kstat *, u32, unsigned int);
+		int (*getattr) (struct mnt_idmap *, const struct path *, struct kstat *, u32, unsigned int);
 		ssize_t (*listxattr) (struct dentry *, char *, size_t);
 		void (*update_time)(struct inode *, struct timespec *, int);
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d8cd3f17bbf3..ee47b2bb3712 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1018,7 +1018,7 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 /**
  * v9fs_vfs_getattr - retrieve file metadata
- * @mnt_userns: The user namespace of the mount
+ * @idmap: idmap of the mount
  * @path: Object to query
  * @stat: metadata structure to populate
  * @request_mask: Mask of STATX_xxx flags indicating the caller's interests
@@ -1027,7 +1027,7 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
  */
 
 static int
-v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
@@ -1038,7 +1038,7 @@ v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 		return 0;
 	}
 	fid = v9fs_fid_lookup(dentry);
@@ -1051,7 +1051,7 @@ v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		return PTR_ERR(st);
 
 	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
-	generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 
 	p9stat_free(st);
 	kfree(st);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index dfe6b4017bd0..08ec5e7b628d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -450,7 +450,7 @@ static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
 }
 
 static int
-v9fs_vfs_getattr_dotl(struct user_namespace *mnt_userns,
+v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 		      const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int flags)
 {
@@ -462,7 +462,7 @@ v9fs_vfs_getattr_dotl(struct user_namespace *mnt_userns,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 		return 0;
 	}
 	fid = v9fs_fid_lookup(dentry);
@@ -479,7 +479,7 @@ v9fs_vfs_getattr_dotl(struct user_namespace *mnt_userns,
 		return PTR_ERR(st);
 
 	v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
-	generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 	/* Change block size to what the server returned */
 	stat->blksize = st->st_blksize;
 
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index f001cf1750ec..0167e96e5198 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -737,7 +737,7 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 /*
  * read the attributes of an inode
  */
-int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -761,7 +761,7 @@ int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	do {
 		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
-		generic_fillattr(&init_user_ns, inode, stat);
+		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
 			stat->nlink -= 1;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e2a23efc91b6..d5e7cd465593 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1170,7 +1170,7 @@ extern struct inode *afs_iget(struct afs_operation *, struct afs_vnode_param *);
 extern struct inode *afs_root_iget(struct super_block *, struct key *);
 extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
-extern int afs_getattr(struct user_namespace *mnt_userns, const struct path *,
+extern int afs_getattr(struct mnt_idmap *idmap, const struct path *,
 		       struct kstat *, u32, unsigned int);
 extern int afs_setattr(struct mnt_idmap *idmap, struct dentry *, struct iattr *);
 extern void afs_evict_inode(struct inode *);
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 9cb95ff99047..63006ca5b581 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -95,7 +95,7 @@ static int bad_inode_permission(struct user_namespace *mnt_userns,
 	return -EIO;
 }
 
-static int bad_inode_getattr(struct user_namespace *mnt_userns,
+static int bad_inode_getattr(struct mnt_idmap *idmap,
 			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 36a897e5d8de..8ba37e4c36fe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9005,7 +9005,7 @@ int __init btrfs_init_cachep(void)
 	return -ENOMEM;
 }
 
-static int btrfs_getattr(struct user_namespace *mnt_userns,
+static int btrfs_getattr(struct mnt_idmap *idmap,
 			 const struct path *path, struct kstat *stat,
 			 u32 request_mask, unsigned int flags)
 {
@@ -9035,7 +9035,7 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
 
-	generic_fillattr(mnt_userns, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 358aadd4329a..fcc84cc1d8f1 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2445,7 +2445,7 @@ static int statx_to_caps(u32 want, umode_t mode)
  * Get all the attributes. If we have sufficient caps for the requested attrs,
  * then we can avoid talking to the MDS at all.
  */
-int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -2466,7 +2466,7 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a023a74b6650..063dad749a07 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1045,7 +1045,7 @@ extern int ceph_permission(struct user_namespace *mnt_userns,
 extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
 extern int ceph_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr);
-extern int ceph_getattr(struct user_namespace *mnt_userns,
+extern int ceph_getattr(struct mnt_idmap *idmap,
 			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags);
 void ceph_inode_shutdown(struct inode *inode);
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index f93c295649df..6c42137f9499 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -72,7 +72,7 @@ extern int cifs_revalidate_dentry(struct dentry *);
 extern int cifs_invalidate_mapping(struct inode *inode);
 extern int cifs_revalidate_mapping(struct inode *inode);
 extern int cifs_zap_mapping(struct inode *inode);
-extern int cifs_getattr(struct user_namespace *, const struct path *,
+extern int cifs_getattr(struct mnt_idmap *, const struct path *,
 			struct kstat *, u32, unsigned int);
 extern int cifs_setattr(struct mnt_idmap *, struct dentry *,
 			struct iattr *);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 653f05ce287a..aad6a40c9721 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2496,7 +2496,7 @@ int cifs_revalidate_dentry(struct dentry *dentry)
 	return cifs_revalidate_mapping(inode);
 }
 
-int cifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
@@ -2537,7 +2537,7 @@ int cifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			return rc;
 	}
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	stat->blksize = cifs_sb->ctx->bsize;
 	stat->ino = CIFS_I(inode)->uniqueid;
 
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index b762525eb5a2..cc69a0f15b41 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -49,7 +49,7 @@ int coda_release(struct inode *i, struct file *f);
 int coda_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask);
 int coda_revalidate_inode(struct inode *);
-int coda_getattr(struct user_namespace *, const struct path *, struct kstat *,
+int coda_getattr(struct mnt_idmap *, const struct path *, struct kstat *,
 		 u32, unsigned int);
 int coda_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 8e5a431f7eb5..d661e6cf17ac 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -251,12 +251,12 @@ static void coda_evict_inode(struct inode *inode)
 	coda_cache_clear_inode(inode);
 }
 
-int coda_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int coda_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	int err = coda_revalidate_inode(d_inode(path->dentry));
 	if (!err)
-		generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
+		generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
 	return err;
 }
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 011b03e5c9df..7854b71c769f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -972,7 +972,7 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 	return rc;
 }
 
-static int ecryptfs_getattr_link(struct user_namespace *mnt_userns,
+static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
 				 const struct path *path, struct kstat *stat,
 				 u32 request_mask, unsigned int flags)
 {
@@ -982,7 +982,7 @@ static int ecryptfs_getattr_link(struct user_namespace *mnt_userns,
 
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 						dentry->d_sb)->mount_crypt_stat;
-	generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 	if (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) {
 		char *target;
 		size_t targetsiz;
@@ -998,7 +998,7 @@ static int ecryptfs_getattr_link(struct user_namespace *mnt_userns,
 	return rc;
 }
 
-static int ecryptfs_getattr(struct user_namespace *mnt_userns,
+static int ecryptfs_getattr(struct mnt_idmap *idmap,
 			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int flags)
 {
@@ -1011,7 +1011,7 @@ static int ecryptfs_getattr(struct user_namespace *mnt_userns,
 	if (!rc) {
 		fsstack_copy_attr_all(d_inode(dentry),
 				      ecryptfs_inode_to_lower(d_inode(dentry)));
-		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 		stat->blocks = lower_stat.blocks;
 	}
 	return rc;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d3b8736fa124..a194e8ee5861 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -353,7 +353,7 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 	return inode;
 }
 
-int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
 		  unsigned int query_flags)
 {
@@ -366,7 +366,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
-	generic_fillattr(mnt_userns, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	return 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index bb8501c0ff5b..e05ae61069e8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -494,7 +494,7 @@ extern const struct inode_operations erofs_symlink_iops;
 extern const struct inode_operations erofs_fast_symlink_iops;
 
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
-int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
 		  unsigned int query_flags);
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 7fd693a668c7..1bf16abe3c84 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -452,7 +452,7 @@ int __exfat_truncate(struct inode *inode);
 void exfat_truncate(struct inode *inode);
 int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
-int exfat_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
 		  unsigned int query_flags);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index da61838f8842..1fdb0a64b91d 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -226,14 +226,14 @@ void exfat_truncate(struct inode *inode)
 	mutex_unlock(&sbi->s_lock);
 }
 
-int exfat_getattr(struct user_namespace *mnt_uerns, const struct path *path,
+int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
 		  unsigned int query_flags)
 {
 	struct inode *inode = d_backing_inode(path->dentry);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	exfat_truncate_atime(&stat->atime);
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = ei->i_crtime.tv_sec;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 4a3e95406cce..9ca0fda28928 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -754,7 +754,7 @@ extern int ext2_write_inode (struct inode *, struct writeback_control *);
 extern void ext2_evict_inode(struct inode *);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
-extern int ext2_getattr (struct user_namespace *, const struct path *,
+extern int ext2_getattr (struct mnt_idmap *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern void ext2_set_inode_flags(struct inode *inode);
 extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 792b974a5beb..bbc9941dbb43 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1592,7 +1592,7 @@ int ext2_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return __ext2_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
 }
 
-int ext2_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ext2_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -1614,7 +1614,7 @@ int ext2_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	return 0;
 }
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 056704d4ac9c..b5e325434c5a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2979,11 +2979,11 @@ extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct mnt_idmap *, struct dentry *,
 			 struct iattr *);
 extern u32  ext4_dio_alignment(struct inode *inode);
-extern int  ext4_getattr(struct user_namespace *, const struct path *,
+extern int  ext4_getattr(struct mnt_idmap *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern void ext4_evict_inode(struct inode *);
 extern void ext4_clear_inode(struct inode *);
-extern int  ext4_file_getattr(struct user_namespace *, const struct path *,
+extern int  ext4_file_getattr(struct mnt_idmap *, const struct path *,
 			      struct kstat *, u32, unsigned int);
 extern int  ext4_sync_inode(handle_t *, struct inode *);
 extern void ext4_dirty_inode(struct inode *, int);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 18fed4f5108d..d60eab65319d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5669,7 +5669,7 @@ u32 ext4_dio_alignment(struct inode *inode)
 	return 1; /* use the iomap defaults */
 }
 
-int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -5726,18 +5726,18 @@ int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(mnt_userns, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	return 0;
 }
 
-int ext4_file_getattr(struct user_namespace *mnt_userns,
+int ext4_file_getattr(struct mnt_idmap *idmap,
 		      const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	u64 delalloc_blocks;
 
-	ext4_getattr(mnt_userns, path, stat, request_mask, query_flags);
+	ext4_getattr(idmap, path, stat, request_mask, query_flags);
 
 	/*
 	 * If there is inline data in the inode, the inode will normally not
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 3d3ed3c38f56..75bf1f88843c 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -55,12 +55,12 @@ static const char *ext4_encrypted_get_link(struct dentry *dentry,
 	return paddr;
 }
 
-static int ext4_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
+static int ext4_encrypted_symlink_getattr(struct mnt_idmap *idmap,
 					  const struct path *path,
 					  struct kstat *stat, u32 request_mask,
 					  unsigned int query_flags)
 {
-	ext4_getattr(mnt_userns, path, stat, request_mask, query_flags);
+	ext4_getattr(idmap, path, stat, request_mask, query_flags);
 
 	return fscrypt_symlink_getattr(path, stat);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 55bd92d431e5..d6b13b03d75f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3469,7 +3469,7 @@ void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
 int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
-int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags);
 int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6ce71c9c8d46..267507ff16cc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -837,7 +837,7 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 	return false;
 }
 
-int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -892,7 +892,7 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(mnt_userns, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 
 	/* we need to show initial sectors used for inline_data/dentries */
 	if ((S_ISREG(inode->i_mode) && f2fs_has_inline_data(inode)) ||
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 30baa0e2a21c..e634529ab6ad 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1342,12 +1342,12 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	return target;
 }
 
-static int f2fs_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
+static int f2fs_encrypted_symlink_getattr(struct mnt_idmap *idmap,
 					  const struct path *path,
 					  struct kstat *stat, u32 request_mask,
 					  unsigned int query_flags)
 {
-	f2fs_getattr(mnt_userns, path, stat, request_mask, query_flags);
+	f2fs_getattr(idmap, path, stat, request_mask, query_flags);
 
 	return fscrypt_symlink_getattr(path, stat);
 }
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index e38bd3a49f46..e3b690b48e3e 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -401,7 +401,7 @@ extern const struct inode_operations fat_file_inode_operations;
 extern int fat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *attr);
 extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
-extern int fat_getattr(struct user_namespace *mnt_userns,
+extern int fat_getattr(struct mnt_idmap *idmap,
 		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int flags);
 extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
diff --git a/fs/fat/file.c b/fs/fat/file.c
index b762109a964f..32c04fdf7275 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -395,13 +395,13 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	fat_flush_inodes(inode->i_sb, inode, NULL);
 }
 
-int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 
-	generic_fillattr(mnt_userns, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->blksize = sbi->cluster_size;
 
 	if (sbi->options.nfs == FAT_NFS_NOSTALE_RO) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1633f7e9fc54..b1d89ba2d4c7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1156,7 +1156,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 		forget_all_cached_acls(inode);
 		err = fuse_do_getattr(inode, stat, file);
 	} else if (stat) {
-		generic_fillattr(&init_user_ns, inode, stat);
+		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		stat->mode = fi->orig_i_mode;
 		stat->ino = fi->orig_ino;
 	}
@@ -1900,7 +1900,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	return ret;
 }
 
-static int fuse_getattr(struct user_namespace *mnt_userns,
+static int fuse_getattr(struct mnt_idmap *idmap,
 			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags)
 {
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0c8b64921c4c..30ec02ab1d0e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2022,7 +2022,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
 
 /**
  * gfs2_getattr - Read out an inode's attributes
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @path: Object to query
  * @stat: The inode's stats
  * @request_mask: Mask of STATX_xxx flags indicating the caller's interests
@@ -2037,7 +2037,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
  * Returns: errno
  */
 
-static int gfs2_getattr(struct user_namespace *mnt_userns,
+static int gfs2_getattr(struct mnt_idmap *idmap,
 			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags)
 {
@@ -2066,7 +2066,7 @@ static int gfs2_getattr(struct user_namespace *mnt_userns,
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 
 	if (gfs2_holder_initialized(&gh))
 		gfs2_glock_dq_uninit(&gh);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 6aa919e59483..d5f3ce0f8dad 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -481,7 +481,7 @@ void hfsplus_inode_write_fork(struct inode *inode,
 			      struct hfsplus_fork_raw *fork);
 int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd);
 int hfsplus_cat_write_inode(struct inode *inode);
-int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 		    struct kstat *stat, u32 request_mask,
 		    unsigned int query_flags);
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 00b242f6574a..ff98c1250d7c 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -276,7 +276,7 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
-int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 		    struct kstat *stat, u32 request_mask,
 		    unsigned int query_flags)
 {
@@ -298,7 +298,7 @@ int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	stat->attributes_mask |= STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE |
 				 STATX_ATTR_NODUMP;
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	return 0;
 }
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 691869b1e9dd..8e56526d40d8 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -181,7 +181,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		set_nlink(inode, kn->dir.subdirs + 2);
 }
 
-int kernfs_iop_getattr(struct user_namespace *mnt_userns,
+int kernfs_iop_getattr(struct mnt_idmap *idmap,
 		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags)
 {
@@ -191,7 +191,7 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 
 	down_read(&root->kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	up_read(&root->kernfs_rwsem);
 
 	return 0;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 0ccab5c997b6..451bf26394e6 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -131,7 +131,7 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask);
 int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *iattr);
-int kernfs_iop_getattr(struct user_namespace *mnt_userns,
+int kernfs_iop_getattr(struct mnt_idmap *idmap,
 		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f787f66b329c..ba8146f39adb 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3631,7 +3631,8 @@ static void unlock_dir(struct ksmbd_file *dir_fp)
 
 static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 {
-	struct user_namespace	*user_ns = file_mnt_user_ns(priv->dir_fp->filp);
+	struct mnt_idmap	*idmap = file_mnt_idmap(priv->dir_fp->filp);
+	struct user_namespace	*user_ns = mnt_idmap_owner(idmap);
 	struct kstat		kstat;
 	struct ksmbd_kstat	ksmbd_kstat;
 	int			rc;
@@ -3665,7 +3666,7 @@ static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 		ksmbd_kstat.kstat = &kstat;
 		if (priv->info_level != FILE_NAMES_INFORMATION)
 			ksmbd_vfs_fill_dentry_attrs(priv->work,
-						    user_ns,
+						    idmap,
 						    dent,
 						    &ksmbd_kstat);
 
@@ -4331,7 +4332,7 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	}
 
 	basic_info = (struct smb2_file_basic_info *)rsp->Buffer;
-	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
 			 &stat);
 	basic_info->CreationTime = cpu_to_le64(fp->create_time);
 	time = ksmbd_UnixTimeToNT(stat.atime);
@@ -4372,7 +4373,7 @@ static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
 	struct kstat stat;
 
 	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
+	generic_fillattr(file_mnt_idmap(fp->filp), inode, &stat);
 
 	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
 	delete_pending = ksmbd_inode_pending_delete(fp);
@@ -4426,7 +4427,7 @@ static int get_file_all_info(struct ksmbd_work *work,
 		return PTR_ERR(filename);
 
 	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
+	generic_fillattr(file_mnt_idmap(fp->filp), inode, &stat);
 
 	ksmbd_debug(SMB, "filename = %s\n", filename);
 	delete_pending = ksmbd_inode_pending_delete(fp);
@@ -4503,7 +4504,7 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	int buf_free_len;
 	struct smb2_query_info_req *req = ksmbd_req_buf_next(work);
 
-	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
 			 &stat);
 	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
 
@@ -4594,7 +4595,7 @@ static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
 	struct smb2_file_internal_info *file_info;
 	struct kstat stat;
 
-	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
 			 &stat);
 	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
 	file_info->IndexNumber = cpu_to_le64(stat.ino);
@@ -4620,7 +4621,7 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
 
 	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
+	generic_fillattr(file_mnt_idmap(fp->filp), inode, &stat);
 
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
 	time = ksmbd_UnixTimeToNT(stat.atime);
@@ -4681,7 +4682,7 @@ static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
 	struct smb2_file_comp_info *file_info;
 	struct kstat stat;
 
-	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+	generic_fillattr(file_mnt_idmap(fp->filp), file_inode(fp->filp),
 			 &stat);
 
 	file_info = (struct smb2_file_comp_info *)rsp->Buffer;
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 2a4fbbd55b91..fa2b54df6ee6 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -307,7 +307,7 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 {
 	int i, rc = 0;
 	struct ksmbd_conn *conn = work->conn;
-	struct user_namespace *user_ns = file_mnt_user_ns(dir->filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(dir->filp);
 
 	for (i = 0; i < 2; i++) {
 		struct kstat kstat;
@@ -333,7 +333,7 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 
 			ksmbd_kstat.kstat = &kstat;
 			ksmbd_vfs_fill_dentry_attrs(work,
-						    user_ns,
+						    idmap,
 						    dentry,
 						    &ksmbd_kstat);
 			rc = fn(conn, info_level, d_info, &ksmbd_kstat);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 5b284dd61056..cf60e62d6e73 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1657,14 +1657,14 @@ void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat)
 }
 
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
-				struct user_namespace *user_ns,
+				struct mnt_idmap *idmap,
 				struct dentry *dentry,
 				struct ksmbd_kstat *ksmbd_kstat)
 {
 	u64 time;
 	int rc;
 
-	generic_fillattr(user_ns, d_inode(dentry), ksmbd_kstat->kstat);
+	generic_fillattr(idmap, d_inode(dentry), ksmbd_kstat->kstat);
 
 	time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
 	ksmbd_kstat->create_time = time;
@@ -1682,7 +1682,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
 		struct xattr_dos_attrib da;
 
-		rc = ksmbd_vfs_get_dos_attrib_xattr(user_ns, dentry, &da);
+		rc = ksmbd_vfs_get_dos_attrib_xattr(mnt_idmap_owner(idmap), dentry, &da);
 		if (rc > 0) {
 			ksmbd_kstat->file_attributes = cpu_to_le32(da.attr);
 			ksmbd_kstat->create_time = da.create_time;
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 0c9b04ae5fbf..619304b08a7f 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -135,7 +135,7 @@ int ksmbd_vfs_unlink(struct mnt_idmap *idmap, struct dentry *dir,
 		     struct dentry *dentry);
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
-				struct user_namespace *user_ns,
+				struct mnt_idmap *idmap,
 				struct dentry *dentry,
 				struct ksmbd_kstat *ksmbd_kstat);
 void ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
diff --git a/fs/libfs.c b/fs/libfs.c
index 0933726e3b6f..aae36b224508 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -28,12 +28,12 @@
 
 #include "internal.h"
 
-int simple_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int simple_getattr(struct mnt_idmap *idmap, const struct path *path,
 		   struct kstat *stat, u32 request_mask,
 		   unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	stat->blocks = inode->i_mapping->nrpages << (PAGE_SHIFT - 9);
 	return 0;
 }
@@ -1315,12 +1315,12 @@ static struct dentry *empty_dir_lookup(struct inode *dir, struct dentry *dentry,
 	return ERR_PTR(-ENOENT);
 }
 
-static int empty_dir_getattr(struct user_namespace *mnt_userns,
+static int empty_dir_getattr(struct mnt_idmap *idmap,
 			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	return 0;
 }
 
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index da8bdd1712a7..e9fbb5303a22 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -654,13 +654,13 @@ static int minix_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return err;
 }
 
-int minix_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int minix_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct super_block *sb = path->dentry->d_sb;
 	struct inode *inode = d_inode(path->dentry);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	if (INODE_VERSION(inode) == MINIX_V1)
 		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
 	else
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 202173368025..e0b76defa85c 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -51,7 +51,7 @@ extern unsigned long minix_count_free_inodes(struct super_block *sb);
 extern int minix_new_block(struct inode * inode);
 extern void minix_free_block(struct inode *inode, unsigned long block);
 extern unsigned long minix_count_free_blocks(struct super_block *sb);
-extern int minix_getattr(struct user_namespace *, const struct path *,
+extern int minix_getattr(struct mnt_idmap *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern int minix_prepare_chunk(struct page *page, loff_t pos, unsigned len);
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d31ea0a1ebd6..7000c161c900 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -828,7 +828,7 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 	return reply_mask;
 }
 
-int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -908,7 +908,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	/* Only return attributes that were revalidated. */
 	stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 971132dfc93a..19d51ebf842c 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -208,14 +208,14 @@ struct vfsmount *nfs_d_automount(struct path *path)
 }
 
 static int
-nfs_namespace_getattr(struct user_namespace *mnt_userns,
+nfs_namespace_getattr(struct mnt_idmap *idmap,
 		      const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
 	if (NFS_FH(d_inode(path->dentry))->size != 0)
-		return nfs_getattr(mnt_userns, path, stat, request_mask,
+		return nfs_getattr(idmap, path, stat, request_mask,
 				   query_flags);
-	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
+	generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
 	return 0;
 }
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 3303b6c88680..33299e4f931e 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -70,7 +70,7 @@ static long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 /*
  * ntfs_getattr - inode_operations::getattr
  */
-int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -84,7 +84,7 @@ int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	stat->attributes_mask |= STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED;
 
-	generic_fillattr(mnt_userns, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 
 	stat->result_mask |= STATX_BTIME;
 	stat->btime = ni->i_crtime;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 870733297122..41cd797b3c96 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -492,7 +492,7 @@ bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;
 
 /* Globals from file.c */
-int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index e157deb68d38..972a8333317f 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1303,7 +1303,7 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return status;
 }
 
-int ocfs2_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -1318,7 +1318,7 @@ int ocfs2_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		goto bail;
 	}
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	/*
 	 * If there is inline data in the inode, the inode will normally not
 	 * have data blocks allocated (it may have an external xattr block).
diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
index 76020b348df2..ddc76aaffe79 100644
--- a/fs/ocfs2/file.h
+++ b/fs/ocfs2/file.h
@@ -51,7 +51,7 @@ int ocfs2_zero_extend(struct inode *inode, struct buffer_head *di_bh,
 		      loff_t zero_to);
 int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
-int ocfs2_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask, unsigned int flags);
 int ocfs2_permission(struct user_namespace *mnt_userns,
 		     struct inode *inode,
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 011892b23b5e..71cc7f11c7a0 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -866,7 +866,7 @@ int orangefs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 /*
  * Obtain attributes of an object given a dentry
  */
-int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int orangefs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		     struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	int ret;
@@ -879,7 +879,7 @@ int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	ret = orangefs_inode_getattr(inode,
 	    request_mask & STATX_SIZE ? ORANGEFS_GETATTR_SIZE : 0);
 	if (ret == 0) {
-		generic_fillattr(&init_user_ns, inode, stat);
+		generic_fillattr(&nop_mnt_idmap, inode, stat);
 
 		/* override block size reported to stat */
 		if (!(request_mask & STATX_SIZE))
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 142abd37cdda..064a52980283 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -364,7 +364,7 @@ int __orangefs_setattr(struct inode *, struct iattr *);
 int __orangefs_setattr_mode(struct dentry *dentry, struct iattr *iattr);
 int orangefs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 
-int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int orangefs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		     struct kstat *stat, u32 request_mask, unsigned int flags);
 
 int orangefs_permission(struct user_namespace *mnt_userns,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 8796a0feb34f..ad33253ed7e9 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -153,7 +153,7 @@ static void ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 	}
 }
 
-int ovl_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4cd435aabbb4..b6e17f631b53 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -599,7 +599,7 @@ unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 			   unsigned int fallback);
 int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr);
-int ovl_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags);
 int ovl_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		   int mask);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 92166c33395d..aa7ebee00746 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1959,14 +1959,14 @@ static struct inode *proc_pid_make_base_inode(struct super_block *sb,
 	return inode;
 }
 
-int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int pid_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 
 	stat->uid = GLOBAL_ROOT_UID;
 	stat->gid = GLOBAL_ROOT_GID;
@@ -3891,13 +3891,13 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 }
 
-static int proc_task_getattr(struct user_namespace *mnt_userns,
+static int proc_task_getattr(struct mnt_idmap *idmap,
 			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct task_struct *p = get_proc_task(inode);
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 
 	if (p) {
 		stat->nlink += get_nr_threads(p);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index fc46d6fe080c..d9bda34c770d 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -344,14 +344,14 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
 	return rv;
 }
 
-static int proc_fd_getattr(struct user_namespace *mnt_userns,
+static int proc_fd_getattr(struct mnt_idmap *idmap,
 			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	int rv = 0;
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 
 	/* If it's a directory, put the number of open fds there */
 	if (S_ISDIR(inode->i_mode)) {
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 4464ad6a2283..8379593fa4bb 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -134,7 +134,7 @@ static int proc_notify_change(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static int proc_getattr(struct user_namespace *mnt_userns,
+static int proc_getattr(struct mnt_idmap *idmap,
 			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int query_flags)
 {
@@ -147,7 +147,7 @@ static int proc_getattr(struct user_namespace *mnt_userns,
 		}
 	}
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	return 0;
 }
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 6eb921670fc6..9dda7e54b2d0 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,7 +162,7 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
  * base.c
  */
 extern const struct dentry_operations pid_dentry_operations;
-extern int pid_getattr(struct user_namespace *, const struct path *,
+extern int pid_getattr(struct mnt_idmap *, const struct path *,
 		       struct kstat *, u32, unsigned int);
 extern int proc_setattr(struct mnt_idmap *, struct dentry *,
 			struct iattr *);
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 856839b8ae8b..a0c0419872e3 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -299,7 +299,7 @@ static struct dentry *proc_tgid_net_lookup(struct inode *dir,
 	return de;
 }
 
-static int proc_tgid_net_getattr(struct user_namespace *mnt_userns,
+static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
 				 const struct path *path, struct kstat *stat,
 				 u32 request_mask, unsigned int query_flags)
 {
@@ -308,7 +308,7 @@ static int proc_tgid_net_getattr(struct user_namespace *mnt_userns,
 
 	net = get_proc_task_net(inode);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 
 	if (net != NULL) {
 		stat->nlink = net->proc_net->nlink;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index daba911972ec..7d111c46ca75 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -845,7 +845,7 @@ static int proc_sys_setattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static int proc_sys_getattr(struct user_namespace *mnt_userns,
+static int proc_sys_getattr(struct mnt_idmap *idmap,
 			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int query_flags)
 {
@@ -856,7 +856,7 @@ static int proc_sys_getattr(struct user_namespace *mnt_userns,
 	if (IS_ERR(head))
 		return PTR_ERR(head);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	if (table)
 		stat->mode = (stat->mode & S_IFMT) | table->mode;
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 3c2ee3eb1138..a86e65a608da 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -310,11 +310,11 @@ void __init proc_root_init(void)
 	register_filesystem(&proc_fs_type);
 }
 
-static int proc_root_getattr(struct user_namespace *mnt_userns,
+static int proc_root_getattr(struct mnt_idmap *idmap,
 			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
-	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
+	generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
 	stat->nlink = proc_root.nlink + nr_processes();
 	return 0;
 }
diff --git a/fs/stat.c b/fs/stat.c
index d6cc74ca8486..cb91bc7c9efd 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -27,7 +27,7 @@
 
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:	Inode to use as the source
  * @stat:	Where to fill in the attributes
  *
@@ -35,15 +35,17 @@
  * found on the VFS inode structure.  This is the default if no getattr inode
  * operation is supplied.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before filling in the
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before filling in the
  * uid and gid filds. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply passs @nop_mnt_idmap.
  */
-void generic_fillattr(struct user_namespace *mnt_userns, struct inode *inode,
+void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		      struct kstat *stat)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
 	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
 
@@ -97,7 +99,7 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
 int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
-	struct user_namespace *mnt_userns;
+	struct mnt_idmap *idmap;
 	struct inode *inode = d_backing_inode(path->dentry);
 
 	memset(stat, 0, sizeof(*stat));
@@ -122,12 +124,12 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
 				  STATX_ATTR_DAX);
 
-	mnt_userns = mnt_user_ns(path->mnt);
+	idmap = mnt_idmap(path->mnt);
 	if (inode->i_op->getattr)
-		return inode->i_op->getattr(mnt_userns, path, stat,
+		return inode->i_op->getattr(idmap, path, stat,
 					    request_mask, query_flags);
 
-	generic_fillattr(mnt_userns, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	return 0;
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 3b8567564e7e..b22764fe669c 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -441,11 +441,11 @@ static unsigned sysv_nblocks(struct super_block *s, loff_t size)
 	return res;
 }
 
-int sysv_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int sysv_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct super_block *s = path->dentry->d_sb;
-	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
+	generic_fillattr(&nop_mnt_idmap, d_inode(path->dentry), stat);
 	stat->blocks = (s->s_blocksize / 512) * sysv_nblocks(s, stat->size);
 	stat->blksize = s->s_blocksize;
 	return 0;
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index 99ddf033da4f..5e122a5673c1 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -141,7 +141,7 @@ extern struct inode *sysv_iget(struct super_block *, unsigned int);
 extern int sysv_write_inode(struct inode *, struct writeback_control *wbc);
 extern int sysv_sync_inode(struct inode *);
 extern void sysv_set_inode(struct inode *, dev_t);
-extern int sysv_getattr(struct user_namespace *, const struct path *,
+extern int sysv_getattr(struct mnt_idmap *, const struct path *,
 			struct kstat *, u32, unsigned int);
 extern int sysv_init_icache(void);
 extern void sysv_destroy_icache(void);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 0f29cf201136..b034f66c6ea8 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1631,7 +1631,7 @@ static int ubifs_rename(struct user_namespace *mnt_userns,
 	return do_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
 }
 
-int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	loff_t size;
@@ -1654,7 +1654,7 @@ int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 				STATX_ATTR_ENCRYPTED |
 				STATX_ATTR_IMMUTABLE);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	stat->blksize = UBIFS_BLOCK_SIZE;
 	stat->size = ui->ui_size;
 
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index e666337df02c..8cb5d76b301c 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1608,11 +1608,11 @@ static const char *ubifs_get_link(struct dentry *dentry,
 	return fscrypt_get_symlink(inode, ui->data, ui->data_len, done);
 }
 
-static int ubifs_symlink_getattr(struct user_namespace *mnt_userns,
+static int ubifs_symlink_getattr(struct mnt_idmap *idmap,
 				 const struct path *path, struct kstat *stat,
 				 u32 request_mask, unsigned int query_flags)
 {
-	ubifs_getattr(mnt_userns, path, stat, request_mask, query_flags);
+	ubifs_getattr(idmap, path, stat, request_mask, query_flags);
 
 	if (IS_ENCRYPTED(d_inode(path->dentry)))
 		return fscrypt_symlink_getattr(path, stat);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 9b66e762950b..1d2fdef6dfa0 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2027,8 +2027,8 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 /* dir.c */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 			      umode_t mode, bool is_xattr);
-int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path, struct kstat *stat,
-		  u32 request_mask, unsigned int flags);
+int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
+		  struct kstat *stat, u32 request_mask, unsigned int flags);
 int ubifs_check_dir_empty(struct inode *dir);
 
 /* xattr.c */
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index f3642f9c23f8..5cf763911aef 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -153,7 +153,7 @@ static int udf_symlink_filler(struct file *file, struct folio *folio)
 	return err;
 }
 
-static int udf_symlink_getattr(struct user_namespace *mnt_userns,
+static int udf_symlink_getattr(struct mnt_idmap *idmap,
 			       const struct path *path, struct kstat *stat,
 			       u32 request_mask, unsigned int flags)
 {
@@ -161,7 +161,7 @@ static int udf_symlink_getattr(struct user_namespace *mnt_userns,
 	struct inode *inode = d_backing_inode(dentry);
 	struct page *page;
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	page = read_mapping_page(inode->i_mapping, 0, NULL);
 	if (IS_ERR(page))
 		return PTR_ERR(page);
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 046b5a3bf314..dd0ae1188e87 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -231,7 +231,7 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 	return 0;
 }
 
-int vboxsf_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int vboxsf_getattr(struct mnt_idmap *idmap, const struct path *path,
 		   struct kstat *kstat, u32 request_mask, unsigned int flags)
 {
 	int err;
@@ -252,7 +252,7 @@ int vboxsf_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	if (err)
 		return err;
 
-	generic_fillattr(&init_user_ns, d_inode(dentry), kstat);
+	generic_fillattr(&nop_mnt_idmap, d_inode(dentry), kstat);
 	return 0;
 }
 
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 7de5a0a4e285..05973eb89d52 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -97,7 +97,7 @@ int vboxsf_stat(struct vboxsf_sbi *sbi, struct shfl_string *path,
 		struct shfl_fsobjinfo *info);
 int vboxsf_stat_dentry(struct dentry *dentry, struct shfl_fsobjinfo *info);
 int vboxsf_inode_revalidate(struct dentry *dentry);
-int vboxsf_getattr(struct user_namespace *mnt_userns, const struct path *path,
+int vboxsf_getattr(struct mnt_idmap *idmap, const struct path *path,
 		   struct kstat *kstat, u32 request_mask,
 		   unsigned int query_flags);
 int vboxsf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ba764205bd3a..737211879a09 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -549,12 +549,13 @@ xfs_stat_blksize(
 
 STATIC int
 xfs_vn_getattr(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	const struct path	*path,
 	struct kstat		*stat,
 	u32			request_mask,
 	unsigned int		query_flags)
 {
+	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct inode		*inode = d_inode(path->dentry);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 24e378e2835f..0214aee3324e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2153,7 +2153,7 @@ struct inode_operations {
 	int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
 	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
-	int (*getattr) (struct user_namespace *, const struct path *,
+	int (*getattr) (struct mnt_idmap *, const struct path *,
 			struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
@@ -3261,7 +3261,7 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
-void generic_fillattr(struct user_namespace *, struct inode *, struct kstat *);
+void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
@@ -3314,7 +3314,7 @@ extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
 extern int dcache_readdir(struct file *, struct dir_context *);
 extern int simple_setattr(struct mnt_idmap *, struct dentry *,
 			  struct iattr *);
-extern int simple_getattr(struct user_namespace *, const struct path *,
+extern int simple_getattr(struct mnt_idmap *, const struct path *,
 			  struct kstat *, u32, unsigned int);
 extern int simple_statfs(struct dentry *, struct kstatfs *);
 extern int simple_open(struct inode *inode, struct file *file);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 7c9628dc61a3..0cd89ebd4bb6 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -392,7 +392,7 @@ extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_post_op_update_inode(struct inode *inode, struct nfs_fattr *fattr);
 extern int nfs_post_op_update_inode_force_wcc(struct inode *inode, struct nfs_fattr *fattr);
 extern int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fattr *fattr);
-extern int nfs_getattr(struct user_namespace *, const struct path *,
+extern int nfs_getattr(struct mnt_idmap *, const struct path *,
 		       struct kstat *, u32, unsigned int);
 extern void nfs_access_add_cache(struct inode *, struct nfs_access_entry *, const struct cred *);
 extern void nfs_access_set_mask(struct nfs_access_entry *, u32);
diff --git a/mm/shmem.c b/mm/shmem.c
index 6976df4e78b6..ae259636af76 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1047,7 +1047,7 @@ void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
 
-static int shmem_getattr(struct user_namespace *mnt_userns,
+static int shmem_getattr(struct mnt_idmap *idmap,
 			 const struct path *path, struct kstat *stat,
 			 u32 request_mask, unsigned int query_flags)
 {
@@ -1068,7 +1068,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(&nop_mnt_idmap, inode, stat);
 
 	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;

-- 
2.34.1

