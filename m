Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA765669628
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjAMLxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbjAMLw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E214035
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9938EB8212B
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D183C433F1;
        Fri, 13 Jan 2023 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610605;
        bh=8IlOQytjxdOF8+wnjK4vm+2NdEZnwRNjrWtVcEfGO5w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UejZE4VWOOgGGSG2+DJzpZlea3CvXFtYvlpuCysYVelbqhgFt2tFtC1ZA/fnO8lOv
         Dx8rjOJtDM8gkHkhUUIto2PzKbxjzjreDm92TH/lDuGMFliEkpYr2lr/S9So3Z8+Xg
         pL4YnlPdhhRDRoDSrxG3rd0ahGE24fCaAwQo9N+ThSotKUhegCgBfVJDOixu/gSwtC
         MjRM9wooe8MEeGlLOFzlLKzgVhVzMvxL6js0O7WGfhf3HvfLeoYTAk3jT0tNFnPBbU
         C01b6D4orjvwwKbjRPs8VaIVXHU4Np1ynjKctOF2cqmQ8NI6oOa+yugxQOpNqHcip9
         2Y7IrVZ5xfshQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:22 +0100
Subject: [PATCH 14/25] fs: port ->permission() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-14-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=155332; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8IlOQytjxdOF8+wnjK4vm+2NdEZnwRNjrWtVcEfGO5w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA02eTqjj+fn/Nac2a9j3VPlDpsUBPVuF9i+tk2+58/y
 TfuLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyajMjw44Ew0Vf4ibfCZp8udH1sN
 Ln2epMXIcjly288m5f4ufzexcy/He41jhp6Ym/aw5fZK8Tku1b0yjo/MGfP0Q1UvT3cbUdkzgA
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
 Documentation/filesystems/locking.rst     |   2 +-
 Documentation/filesystems/vfs.rst         |   2 +-
 fs/afs/internal.h                         |   2 +-
 fs/afs/security.c                         |   2 +-
 fs/attr.c                                 |   7 +-
 fs/autofs/root.c                          |   6 +-
 fs/bad_inode.c                            |   2 +-
 fs/btrfs/inode.c                          |   4 +-
 fs/btrfs/ioctl.c                          |  51 ++++-----
 fs/cachefiles/xattr.c                     |  10 +-
 fs/ceph/inode.c                           |   4 +-
 fs/ceph/super.h                           |   2 +-
 fs/cifs/cifsfs.c                          |   4 +-
 fs/coda/coda_linux.h                      |   2 +-
 fs/coda/dir.c                             |   2 +-
 fs/coda/pioctl.c                          |   4 +-
 fs/configfs/symlink.c                     |   2 +-
 fs/ecryptfs/inode.c                       |   6 +-
 fs/exec.c                                 |   5 +-
 fs/exportfs/expfs.c                       |   4 +-
 fs/fuse/dir.c                             |   6 +-
 fs/gfs2/file.c                            |   2 +-
 fs/gfs2/inode.c                           |  24 ++---
 fs/gfs2/inode.h                           |   2 +-
 fs/hostfs/hostfs_kern.c                   |   4 +-
 fs/init.c                                 |   4 +-
 fs/inode.c                                |   2 +-
 fs/internal.h                             |   4 +-
 fs/kernfs/inode.c                         |   4 +-
 fs/kernfs/kernfs-internal.h               |   2 +-
 fs/ksmbd/smb2pdu.c                        |  71 +++++++------
 fs/ksmbd/smbacl.c                         |  15 +--
 fs/ksmbd/vfs.c                            | 101 +++++++++---------
 fs/ksmbd/vfs.h                            |  24 ++---
 fs/ksmbd/vfs_cache.c                      |   2 +-
 fs/namei.c                                | 166 +++++++++++++++---------------
 fs/nfs/dir.c                              |   4 +-
 fs/nfsd/nfsfh.c                           |   2 +-
 fs/nfsd/vfs.c                             |  14 +--
 fs/nilfs2/inode.c                         |   4 +-
 fs/nilfs2/nilfs.h                         |   2 +-
 fs/ntfs3/ntfs_fs.h                        |   2 +-
 fs/ntfs3/xattr.c                          |   4 +-
 fs/ocfs2/file.c                           |   4 +-
 fs/ocfs2/file.h                           |   2 +-
 fs/ocfs2/refcounttree.c                   |   4 +-
 fs/open.c                                 |   6 +-
 fs/orangefs/inode.c                       |   4 +-
 fs/orangefs/orangefs-kernel.h             |   2 +-
 fs/overlayfs/export.c                     |   4 +-
 fs/overlayfs/file.c                       |   6 +-
 fs/overlayfs/inode.c                      |  10 +-
 fs/overlayfs/namei.c                      |   6 +-
 fs/overlayfs/overlayfs.h                  |  10 +-
 fs/overlayfs/ovl_entry.h                  |   5 -
 fs/overlayfs/readdir.c                    |   4 +-
 fs/overlayfs/util.c                       |   5 +-
 fs/posix_acl.c                            |   4 +-
 fs/proc/base.c                            |   8 +-
 fs/proc/fd.c                              |   4 +-
 fs/proc/fd.h                              |   2 +-
 fs/proc/proc_sysctl.c                     |   2 +-
 fs/reiserfs/xattr.c                       |   4 +-
 fs/reiserfs/xattr.h                       |   2 +-
 fs/remap_range.c                          |   5 +-
 fs/xattr.c                                |  60 ++++++-----
 include/linux/fs.h                        |  23 +++--
 include/linux/lsm_hook_defs.h             |   2 +-
 include/linux/namei.h                     |   6 +-
 include/linux/nfs_fs.h                    |   2 +-
 include/linux/security.h                  |   8 +-
 include/linux/xattr.h                     |  12 +--
 ipc/mqueue.c                              |   2 +-
 kernel/bpf/inode.c                        |   2 +-
 kernel/cgroup/cgroup.c                    |   2 +-
 security/apparmor/domain.c                |   2 +-
 security/commoncap.c                      |   5 +-
 security/integrity/evm/evm_crypto.c       |   6 +-
 security/integrity/evm/evm_main.c         |   4 +-
 security/integrity/ima/ima_appraise.c     |   2 +-
 security/integrity/ima/ima_template_lib.c |   2 +-
 security/security.c                       |   4 +-
 security/selinux/hooks.c                  |   4 +-
 security/smack/smack_lsm.c                |   4 +-
 84 files changed, 422 insertions(+), 421 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index fb23ffc0792c..d2750085a1f5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -69,7 +69,7 @@ prototypes::
 	int (*readlink) (struct dentry *, char __user *,int);
 	const char *(*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int, unsigned int);
+	int (*permission) (struct mnt_idmap *, struct inode *, int, unsigned int);
 	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
 	int (*getattr) (struct mnt_idmap *, const struct path *, struct kstat *, u32, unsigned int);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index bf5cc9809b65..c53f30251a66 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -434,7 +434,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*readlink) (struct dentry *, char __user *,int);
 		const char *(*get_link) (struct dentry *, struct inode *,
 					 struct delayed_call *);
-		int (*permission) (struct user_namespace *, struct inode *, int);
+		int (*permission) (struct mnt_idmap *, struct inode *, int);
 		struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 		int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
 		int (*getattr) (struct mnt_idmap *, const struct path *, struct kstat *, u32, unsigned int);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d5e7cd465593..e3375b2a0ff3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1387,7 +1387,7 @@ extern void afs_cache_permit(struct afs_vnode *, struct key *, unsigned int,
 extern struct key *afs_request_key(struct afs_cell *);
 extern struct key *afs_request_key_rcu(struct afs_cell *);
 extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_t *);
-extern int afs_permission(struct user_namespace *, struct inode *, int);
+extern int afs_permission(struct mnt_idmap *, struct inode *, int);
 extern void __exit afs_clean_up_permit_cache(void);
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 7c6a63a30394..6a7744c9e2a2 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -395,7 +395,7 @@ int afs_check_permit(struct afs_vnode *vnode, struct key *key,
  * - AFS ACLs are attached to directories only, and a file is controlled by its
  *   parent directory's ACL
  */
-int afs_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int afs_permission(struct mnt_idmap *idmap, struct inode *inode,
 		   int mask)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
diff --git a/fs/attr.c b/fs/attr.c
index 39d35621e57b..48897e036ce9 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -324,10 +324,11 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 }
 EXPORT_SYMBOL(setattr_copy);
 
-int may_setattr(struct user_namespace *mnt_userns, struct inode *inode,
+int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid)
 {
 	int error;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) {
 		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -343,7 +344,7 @@ int may_setattr(struct user_namespace *mnt_userns, struct inode *inode,
 			return -EPERM;
 
 		if (!inode_owner_or_capable(mnt_userns, inode)) {
-			error = inode_permission(mnt_userns, inode, MAY_WRITE);
+			error = inode_permission(idmap, inode, MAY_WRITE);
 			if (error)
 				return error;
 		}
@@ -391,7 +392,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	error = may_setattr(mnt_userns, inode, ia_valid);
+	error = may_setattr(idmap, inode, ia_valid);
 	if (error)
 		return error;
 
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index cbc0da00a3cf..6baf90b08e0e 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -10,7 +10,7 @@
 
 #include "autofs_i.h"
 
-static int autofs_dir_permission(struct user_namespace *, struct inode *, int);
+static int autofs_dir_permission(struct mnt_idmap *, struct inode *, int);
 static int autofs_dir_symlink(struct mnt_idmap *, struct inode *,
 			      struct dentry *, const char *);
 static int autofs_dir_unlink(struct inode *, struct dentry *);
@@ -543,7 +543,7 @@ static struct dentry *autofs_lookup(struct inode *dir,
 	return NULL;
 }
 
-static int autofs_dir_permission(struct user_namespace *mnt_userns,
+static int autofs_dir_permission(struct mnt_idmap *idmap,
 				 struct inode *inode, int mask)
 {
 	if (mask & MAY_WRITE) {
@@ -560,7 +560,7 @@ static int autofs_dir_permission(struct user_namespace *mnt_userns,
 			return -EACCES;
 	}
 
-	return generic_permission(mnt_userns, inode, mask);
+	return generic_permission(idmap, inode, mask);
 }
 
 static int autofs_dir_symlink(struct mnt_idmap *idmap,
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 350ad3461129..db649487d58c 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -89,7 +89,7 @@ static int bad_inode_readlink(struct dentry *dentry, char __user *buffer,
 	return -EIO;
 }
 
-static int bad_inode_permission(struct user_namespace *mnt_userns,
+static int bad_inode_permission(struct mnt_idmap *idmap,
 				struct inode *inode, int mask)
 {
 	return -EIO;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6a74767b12cb..5251547fdf0b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10078,7 +10078,7 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
-static int btrfs_permission(struct user_namespace *mnt_userns,
+static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -10091,7 +10091,7 @@ static int btrfs_permission(struct user_namespace *mnt_userns,
 		if (BTRFS_I(inode)->flags & BTRFS_INODE_READONLY)
 			return -EACCES;
 	}
-	return generic_permission(mnt_userns, inode, mask);
+	return generic_permission(idmap, inode, mask);
 }
 
 static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f23d0d399b9f..80c7feb30770 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -898,10 +898,11 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
  *     nfs_async_unlink().
  */
 
-static int btrfs_may_delete(struct user_namespace *mnt_userns,
+static int btrfs_may_delete(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *victim, int isdir)
 {
 	int error;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (d_really_is_negative(victim))
 		return -ENOENT;
@@ -909,7 +910,7 @@ static int btrfs_may_delete(struct user_namespace *mnt_userns,
 	BUG_ON(d_inode(victim->d_parent) != dir);
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -933,16 +934,16 @@ static int btrfs_may_delete(struct user_namespace *mnt_userns,
 }
 
 /* copy of may_create in fs/namei.c() */
-static inline int btrfs_may_create(struct user_namespace *mnt_userns,
+static inline int btrfs_may_create(struct mnt_idmap *idmap,
 				   struct inode *dir, struct dentry *child)
 {
 	if (d_really_is_positive(child))
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	if (!fsuidgid_has_mapping(dir->i_sb, mnt_userns))
+	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
 		return -EOVERFLOW;
-	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -951,7 +952,7 @@ static inline int btrfs_may_create(struct user_namespace *mnt_userns,
  * inside this filesystem so it's quite a bit simpler.
  */
 static noinline int btrfs_mksubvol(const struct path *parent,
-				   struct user_namespace *mnt_userns,
+				   struct mnt_idmap *idmap,
 				   const char *name, int namelen,
 				   struct btrfs_root *snap_src,
 				   bool readonly,
@@ -961,18 +962,19 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct dentry *dentry;
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, namelen);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 
 	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (error == -EINTR)
 		return error;
 
-	dentry = lookup_one(mnt_userns, name, parent->dentry, namelen);
+	dentry = lookup_one(idmap, name, parent->dentry, namelen);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
 
-	error = btrfs_may_create(mnt_userns, dir, dentry);
+	error = btrfs_may_create(idmap, dir, dentry);
 	if (error)
 		goto out_dput;
 
@@ -1007,7 +1009,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 }
 
 static noinline int btrfs_mksnapshot(const struct path *parent,
-				   struct user_namespace *mnt_userns,
+				   struct mnt_idmap *idmap,
 				   const char *name, int namelen,
 				   struct btrfs_root *root,
 				   bool readonly,
@@ -1037,7 +1039,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
 
-	ret = btrfs_mksubvol(parent, mnt_userns, name, namelen,
+	ret = btrfs_mksubvol(parent, idmap, name, namelen,
 			     root, readonly, inherit);
 out:
 	if (snapshot_force_cow)
@@ -1240,13 +1242,14 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 }
 
 static noinline int __btrfs_ioctl_snap_create(struct file *file,
-				struct user_namespace *mnt_userns,
+				struct mnt_idmap *idmap,
 				const char *name, unsigned long fd, int subvol,
 				bool readonly,
 				struct btrfs_qgroup_inherit *inherit)
 {
 	int namelen;
 	int ret = 0;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (!S_ISDIR(file_inode(file)->i_mode))
 		return -ENOTDIR;
@@ -1268,7 +1271,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 	}
 
 	if (subvol) {
-		ret = btrfs_mksubvol(&file->f_path, mnt_userns, name,
+		ret = btrfs_mksubvol(&file->f_path, idmap, name,
 				     namelen, NULL, readonly, inherit);
 	} else {
 		struct fd src = fdget(fd);
@@ -1290,7 +1293,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			 */
 			ret = -EPERM;
 		} else {
-			ret = btrfs_mksnapshot(&file->f_path, mnt_userns,
+			ret = btrfs_mksnapshot(&file->f_path, idmap,
 					       name, namelen,
 					       BTRFS_I(src_inode)->root,
 					       readonly, inherit);
@@ -1317,7 +1320,7 @@ static noinline int btrfs_ioctl_snap_create(struct file *file,
 		return PTR_ERR(vol_args);
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
 
-	ret = __btrfs_ioctl_snap_create(file, file_mnt_user_ns(file),
+	ret = __btrfs_ioctl_snap_create(file, file_mnt_idmap(file),
 					vol_args->name, vol_args->fd, subvol,
 					false, NULL);
 
@@ -1377,7 +1380,7 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		}
 	}
 
-	ret = __btrfs_ioctl_snap_create(file, file_mnt_user_ns(file),
+	ret = __btrfs_ioctl_snap_create(file, file_mnt_idmap(file),
 					vol_args->name, vol_args->fd, subvol,
 					readonly, inherit);
 	if (ret)
@@ -1870,7 +1873,7 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	return ret;
 }
 
-static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
+static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				struct inode *inode,
 				struct btrfs_ioctl_ino_lookup_user_args *args)
 {
@@ -1962,7 +1965,7 @@ static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
-			ret = inode_permission(mnt_userns, temp_inode,
+			ret = inode_permission(idmap, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
 			if (ret) {
@@ -2101,7 +2104,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
 		return -EACCES;
 	}
 
-	ret = btrfs_search_path_in_tree_user(file_mnt_user_ns(file), inode, args);
+	ret = btrfs_search_path_in_tree_user(file_mnt_idmap(file), inode, args);
 
 	if (ret == 0 && copy_to_user(argp, args, sizeof(*args)))
 		ret = -EFAULT;
@@ -2335,7 +2338,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct btrfs_root *dest = NULL;
 	struct btrfs_ioctl_vol_args *vol_args = NULL;
 	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
-	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	char *subvol_name, *subvol_name_ptr = NULL;
 	int subvol_namelen;
 	int err = 0;
@@ -2428,7 +2431,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			 * anywhere in the filesystem the user wouldn't be able
 			 * to delete without an idmapped mount.
 			 */
-			if (old_dir != dir && mnt_userns != &init_user_ns) {
+			if (old_dir != dir && idmap != &nop_mnt_idmap) {
 				err = -EOPNOTSUPP;
 				goto free_parent;
 			}
@@ -2471,7 +2474,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto free_subvol_name;
-	dentry = lookup_one(mnt_userns, subvol_name, parent, subvol_namelen);
+	dentry = lookup_one(idmap, subvol_name, parent, subvol_namelen);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock_dir;
@@ -2513,13 +2516,13 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		if (root == dest)
 			goto out_dput;
 
-		err = inode_permission(mnt_userns, inode, MAY_WRITE | MAY_EXEC);
+		err = inode_permission(idmap, inode, MAY_WRITE | MAY_EXEC);
 		if (err)
 			goto out_dput;
 	}
 
 	/* check if subvolume may be deleted by a user */
-	err = btrfs_may_delete(mnt_userns, dir, dentry, 1);
+	err = btrfs_may_delete(idmap, dir, dentry, 1);
 	if (err)
 		goto out_dput;
 
@@ -2582,7 +2585,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		 * running and allows defrag on files open in read-only mode.
 		 */
 		if (!capable(CAP_SYS_ADMIN) &&
-		    inode_permission(&init_user_ns, inode, MAY_WRITE)) {
+		    inode_permission(&nop_mnt_idmap, inode, MAY_WRITE)) {
 			ret = -EPERM;
 			goto out;
 		}
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 00b087c14995..bcb6173943ee 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -65,7 +65,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
-		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
 				   buf, sizeof(struct cachefiles_xattr) + len, 0);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
@@ -108,7 +108,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 
 	xlen = cachefiles_inject_read_error();
 	if (xlen == 0)
-		xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
+		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, tlen);
 	if (xlen != tlen) {
 		if (xlen < 0)
 			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
@@ -150,7 +150,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0)
-		ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
+		ret = vfs_removexattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
 					   cachefiles_trace_remxattr_error);
@@ -207,7 +207,7 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
-		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
 				   buf, len, 0);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
@@ -249,7 +249,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 
 	xlen = cachefiles_inject_read_error();
 	if (xlen == 0)
-		xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, len);
+		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, len);
 	if (xlen != len) {
 		if (xlen < 0) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dentry), xlen,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d9ae943423af..a93e6f65a756 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2397,7 +2397,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
  * Check inode permissions.  We verify we have a valid value for
  * the AUTH cap, then call the generic handler.
  */
-int ceph_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
 	int err;
@@ -2408,7 +2408,7 @@ int ceph_permission(struct user_namespace *mnt_userns, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&init_user_ns, inode, mask);
+		err = generic_permission(&nop_mnt_idmap, inode, mask);
 	return err;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 51c6c10e0375..f5a936ccb3fc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1040,7 +1040,7 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
 {
 	return __ceph_do_getattr(inode, NULL, mask, force);
 }
-extern int ceph_permission(struct user_namespace *mnt_userns,
+extern int ceph_permission(struct mnt_idmap *idmap,
 			   struct inode *inode, int mask);
 extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
 extern int ceph_setattr(struct mnt_idmap *idmap,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 10e00c624922..2554c49a3d74 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -345,7 +345,7 @@ static long cifs_fallocate(struct file *file, int mode, loff_t off, loff_t len)
 	return -EOPNOTSUPP;
 }
 
-static int cifs_permission(struct user_namespace *mnt_userns,
+static int cifs_permission(struct mnt_idmap *idmap,
 			   struct inode *inode, int mask)
 {
 	struct cifs_sb_info *cifs_sb;
@@ -361,7 +361,7 @@ static int cifs_permission(struct user_namespace *mnt_userns,
 		on the client (above and beyond ACL on servers) for
 		servers which do not support setting and viewing mode bits,
 		so allowing client to check permissions is useful */
-		return generic_permission(&init_user_ns, inode, mask);
+		return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 static struct kmem_cache *cifs_inode_cachep;
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index cc69a0f15b41..dd6277d87afb 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -46,7 +46,7 @@ extern const struct file_operations coda_ioctl_operations;
 /* operations shared over more than one file */
 int coda_open(struct inode *i, struct file *f);
 int coda_release(struct inode *i, struct file *f);
-int coda_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int coda_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask);
 int coda_revalidate_inode(struct inode *);
 int coda_getattr(struct mnt_idmap *, const struct path *, struct kstat *,
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 7fdf8e37a1df..8450b1bd354b 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -73,7 +73,7 @@ static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, unsig
 }
 
 
-int coda_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int coda_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
 	int error;
diff --git a/fs/coda/pioctl.c b/fs/coda/pioctl.c
index cb9fd59a688c..36e35c15561a 100644
--- a/fs/coda/pioctl.c
+++ b/fs/coda/pioctl.c
@@ -24,7 +24,7 @@
 #include "coda_linux.h"
 
 /* pioctl ops */
-static int coda_ioctl_permission(struct user_namespace *mnt_userns,
+static int coda_ioctl_permission(struct mnt_idmap *idmap,
 				 struct inode *inode, int mask);
 static long coda_pioctl(struct file *filp, unsigned int cmd,
 			unsigned long user_data);
@@ -41,7 +41,7 @@ const struct file_operations coda_ioctl_operations = {
 };
 
 /* the coda pioctl inode ops */
-static int coda_ioctl_permission(struct user_namespace *mnt_userns,
+static int coda_ioctl_permission(struct mnt_idmap *idmap,
 				 struct inode *inode, int mask)
 {
 	return (mask & MAY_EXEC) ? -EACCES : 0;
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 91db306dfeec..69133ec1fac2 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -196,7 +196,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (dentry->d_inode || d_unhashed(dentry))
 		ret = -EEXIST;
 	else
-		ret = inode_permission(&init_user_ns, dir,
+		ret = inode_permission(&nop_mnt_idmap, dir,
 				       MAY_WRITE | MAY_EXEC);
 	if (!ret)
 		ret = type->ct_item_ops->allow_link(parent_item, target_item);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 133e6c13d9b8..57bc453415cd 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -864,10 +864,10 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 }
 
 static int
-ecryptfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
+ecryptfs_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
-	return inode_permission(&init_user_ns,
+	return inode_permission(&nop_mnt_idmap,
 				ecryptfs_inode_to_lower(inode), mask);
 }
 
@@ -1033,7 +1033,7 @@ ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
 		goto out;
 	}
 	inode_lock(lower_inode);
-	rc = __vfs_setxattr_locked(&init_user_ns, lower_dentry, name, value, size, flags, NULL);
+	rc = __vfs_setxattr_locked(&nop_mnt_idmap, lower_dentry, name, value, size, flags, NULL);
 	inode_unlock(lower_inode);
 	if (!rc && inode)
 		fsstack_copy_attr_all(inode, lower_inode);
diff --git a/fs/exec.c b/fs/exec.c
index ab913243a367..584d906a6c08 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1414,8 +1414,9 @@ EXPORT_SYMBOL(begin_new_exec);
 void would_dump(struct linux_binprm *bprm, struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
-	if (inode_permission(mnt_userns, inode, MAY_READ) < 0) {
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+	if (inode_permission(idmap, inode, MAY_READ) < 0) {
 		struct user_namespace *old, *user_ns;
 		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 3204bd33e4e8..ab88d33d106c 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -145,7 +145,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	if (err)
 		goto out_err;
 	dprintk("%s: found name: %s\n", __func__, nbuf);
-	tmp = lookup_one_unlocked(mnt_user_ns(mnt), nbuf, parent, strlen(nbuf));
+	tmp = lookup_one_unlocked(mnt_idmap(mnt), nbuf, parent, strlen(nbuf));
 	if (IS_ERR(tmp)) {
 		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
 		err = PTR_ERR(tmp);
@@ -524,7 +524,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		}
 
 		inode_lock(target_dir->d_inode);
-		nresult = lookup_one(mnt_user_ns(mnt), nbuf,
+		nresult = lookup_one(mnt_idmap(mnt), nbuf,
 				     target_dir, strlen(nbuf));
 		if (!IS_ERR(nresult)) {
 			if (unlikely(nresult->d_inode != result->d_inode)) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ca07660a76a8..6a4e1fb0a0ad 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1326,7 +1326,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
  * access request is sent.  Execute permission is still checked
  * locally based on file mode.
  */
-static int fuse_permission(struct user_namespace *mnt_userns,
+static int fuse_permission(struct mnt_idmap *idmap,
 			   struct inode *inode, int mask)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -1358,7 +1358,7 @@ static int fuse_permission(struct user_namespace *mnt_userns,
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(&init_user_ns, inode, mask);
+		err = generic_permission(&nop_mnt_idmap, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1366,7 +1366,7 @@ static int fuse_permission(struct user_namespace *mnt_userns,
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(&init_user_ns,
+				err = generic_permission(&nop_mnt_idmap,
 							 inode, mask);
 		}
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 62d6316e8066..bec75ed59c72 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -235,7 +235,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 		goto out;
 
 	if (!IS_IMMUTABLE(inode)) {
-		error = gfs2_permission(&init_user_ns, inode, MAY_WRITE);
+		error = gfs2_permission(&nop_mnt_idmap, inode, MAY_WRITE);
 		if (error)
 			goto out;
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0818d4e25d75..713efa3bb732 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -320,7 +320,7 @@ struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 	}
 
 	if (!is_root) {
-		error = gfs2_permission(&init_user_ns, dir, MAY_EXEC);
+		error = gfs2_permission(&nop_mnt_idmap, dir, MAY_EXEC);
 		if (error)
 			goto out;
 	}
@@ -350,7 +350,7 @@ static int create_ok(struct gfs2_inode *dip, const struct qstr *name,
 {
 	int error;
 
-	error = gfs2_permission(&init_user_ns, &dip->i_inode,
+	error = gfs2_permission(&nop_mnt_idmap, &dip->i_inode,
 				MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
@@ -960,7 +960,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink == 0)
 		goto out_gunlock;
 
-	error = gfs2_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	error = gfs2_permission(&nop_mnt_idmap, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		goto out_gunlock;
 
@@ -1078,7 +1078,7 @@ static int gfs2_unlink_ok(struct gfs2_inode *dip, const struct qstr *name,
 	if (IS_APPEND(&dip->i_inode))
 		return -EPERM;
 
-	error = gfs2_permission(&init_user_ns, &dip->i_inode,
+	error = gfs2_permission(&nop_mnt_idmap, &dip->i_inode,
 				MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
@@ -1504,7 +1504,7 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 			}
 		}
 	} else {
-		error = gfs2_permission(&init_user_ns, ndir,
+		error = gfs2_permission(&nop_mnt_idmap, ndir,
 					MAY_WRITE | MAY_EXEC);
 		if (error)
 			goto out_gunlock;
@@ -1541,7 +1541,7 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 	/* Check out the dir to be renamed */
 
 	if (dir_rename) {
-		error = gfs2_permission(&init_user_ns, d_inode(odentry),
+		error = gfs2_permission(&nop_mnt_idmap, d_inode(odentry),
 					MAY_WRITE);
 		if (error)
 			goto out_gunlock;
@@ -1705,13 +1705,13 @@ static int gfs2_exchange(struct inode *odir, struct dentry *odentry,
 		goto out_gunlock;
 
 	if (S_ISDIR(old_mode)) {
-		error = gfs2_permission(&init_user_ns, odentry->d_inode,
+		error = gfs2_permission(&nop_mnt_idmap, odentry->d_inode,
 					MAY_WRITE);
 		if (error)
 			goto out_gunlock;
 	}
 	if (S_ISDIR(new_mode)) {
-		error = gfs2_permission(&init_user_ns, ndentry->d_inode,
+		error = gfs2_permission(&nop_mnt_idmap, ndentry->d_inode,
 					MAY_WRITE);
 		if (error)
 			goto out_gunlock;
@@ -1841,7 +1841,7 @@ static const char *gfs2_get_link(struct dentry *dentry,
 
 /**
  * gfs2_permission
- * @mnt_userns: User namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: The inode
  * @mask: The mask to be tested
  *
@@ -1852,7 +1852,7 @@ static const char *gfs2_get_link(struct dentry *dentry,
  * Returns: errno
  */
 
-int gfs2_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
 	struct gfs2_inode *ip;
@@ -1872,7 +1872,7 @@ int gfs2_permission(struct user_namespace *mnt_userns, struct inode *inode,
 	if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
 		error = -EPERM;
 	else
-		error = generic_permission(&init_user_ns, inode, mask);
+		error = generic_permission(&nop_mnt_idmap, inode, mask);
 	if (gfs2_holder_initialized(&i_gh))
 		gfs2_glock_dq_uninit(&i_gh);
 
@@ -1992,7 +1992,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
 	if (error)
 		goto out;
 
-	error = may_setattr(&init_user_ns, inode, attr->ia_valid);
+	error = may_setattr(&nop_mnt_idmap, inode, attr->ia_valid);
 	if (error)
 		goto error;
 
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index bd0c64b65158..c8c5814e7295 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -99,7 +99,7 @@ extern int gfs2_inode_refresh(struct gfs2_inode *ip);
 
 extern struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 				  int is_root);
-extern int gfs2_permission(struct user_namespace *mnt_userns,
+extern int gfs2_permission(struct mnt_idmap *idmap,
 			   struct inode *inode, int mask);
 extern struct inode *gfs2_lookup_simple(struct inode *dip, const char *name);
 extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 65dfc7457034..c18bb50c31b6 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -763,7 +763,7 @@ static int hostfs_rename2(struct mnt_idmap *idmap,
 	return err;
 }
 
-static int hostfs_permission(struct user_namespace *mnt_userns,
+static int hostfs_permission(struct mnt_idmap *idmap,
 			     struct inode *ino, int desired)
 {
 	char *name;
@@ -786,7 +786,7 @@ static int hostfs_permission(struct user_namespace *mnt_userns,
 		err = access_file(name, r, w, x);
 	__putname(name);
 	if (!err)
-		err = generic_permission(&init_user_ns, ino, desired);
+		err = generic_permission(&nop_mnt_idmap, ino, desired);
 	return err;
 }
 
diff --git a/fs/init.c b/fs/init.c
index f43f1e78bf7a..9684406a8416 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -168,7 +168,6 @@ int __init init_link(const char *oldname, const char *newname)
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
 	struct mnt_idmap *idmap;
-	struct user_namespace *mnt_userns;
 	int error;
 
 	error = kern_path(oldname, 0, &old_path);
@@ -184,8 +183,7 @@ int __init init_link(const char *oldname, const char *newname)
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
 	idmap = mnt_idmap(new_path.mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
-	error = may_linkat(mnt_userns, &old_path);
+	error = may_linkat(idmap, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
diff --git a/fs/inode.c b/fs/inode.c
index 84b5da325ee8..346d9199ad08 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1893,7 +1893,7 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
 	/* Atime updates will likely cause i_uid and i_gid to be written
 	 * back improprely if their true value is unknown to the vfs.
 	 */
-	if (HAS_UNMAPPED_ID(mnt_user_ns(mnt), inode))
+	if (HAS_UNMAPPED_ID(mnt_idmap(mnt), inode))
 		return false;
 
 	if (IS_NOATIME(inode))
diff --git a/fs/internal.h b/fs/internal.h
index a803cc3cf716..a4996e86622f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -63,7 +63,7 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
-int may_linkat(struct user_namespace *mnt_userns, const struct path *link);
+int may_linkat(struct mnt_idmap *idmap, const struct path *link);
 int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
 int do_mkdirat(int dfd, struct filename *name, umode_t mode);
@@ -234,7 +234,7 @@ ssize_t do_getxattr(struct mnt_idmap *idmap,
 int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
 int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct xattr_ctx *ctx);
-int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
+int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode);
 
 #ifdef CONFIG_FS_POSIX_ACL
 int do_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 8e56526d40d8..af1a05470131 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -272,7 +272,7 @@ void kernfs_evict_inode(struct inode *inode)
 	kernfs_put(kn);
 }
 
-int kernfs_iop_permission(struct user_namespace *mnt_userns,
+int kernfs_iop_permission(struct mnt_idmap *idmap,
 			  struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
@@ -287,7 +287,7 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 
 	down_read(&root->kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	ret = generic_permission(&init_user_ns, inode, mask);
+	ret = generic_permission(&nop_mnt_idmap, inode, mask);
 	up_read(&root->kernfs_rwsem);
 
 	return ret;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 451bf26394e6..236c3a6113f1 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -127,7 +127,7 @@ extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
  */
 extern const struct xattr_handler *kernfs_xattr_handlers[];
 void kernfs_evict_inode(struct inode *inode);
-int kernfs_iop_permission(struct user_namespace *mnt_userns,
+int kernfs_iop_permission(struct mnt_idmap *idmap,
 			  struct inode *inode, int mask);
 int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *iattr);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 50d049bb84de..189f96a7e96f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2189,7 +2189,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 		       const struct path *path)
 {
-	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	char *attr_name = NULL, *value;
 	int rc = 0;
 	unsigned int next = 0;
@@ -2225,7 +2225,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 		value = (char *)&eabuf->name + eabuf->EaNameLength + 1;
 
 		if (!eabuf->EaValueLength) {
-			rc = ksmbd_vfs_casexattr_len(user_ns,
+			rc = ksmbd_vfs_casexattr_len(idmap,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
@@ -2233,7 +2233,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
-				rc = ksmbd_vfs_remove_xattr(user_ns,
+				rc = ksmbd_vfs_remove_xattr(idmap,
 							    path->dentry,
 							    attr_name);
 
@@ -2248,7 +2248,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* if the EA doesn't exist, just do nothing. */
 			rc = 0;
 		} else {
-			rc = ksmbd_vfs_setxattr(user_ns,
+			rc = ksmbd_vfs_setxattr(idmap,
 						path->dentry, attr_name, value,
 						le16_to_cpu(eabuf->EaValueLength), 0);
 			if (rc < 0) {
@@ -2278,7 +2278,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
 					       char *stream_name, int s_type)
 {
-	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	size_t xattr_stream_size;
 	char *xattr_stream_name;
 	int rc;
@@ -2294,7 +2294,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	fp->stream.size = xattr_stream_size;
 
 	/* Check if there is stream prefix in xattr space */
-	rc = ksmbd_vfs_casexattr_len(user_ns,
+	rc = ksmbd_vfs_casexattr_len(idmap,
 				     path->dentry,
 				     xattr_stream_name,
 				     xattr_stream_size);
@@ -2306,7 +2306,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
-	rc = ksmbd_vfs_setxattr(user_ns, path->dentry,
+	rc = ksmbd_vfs_setxattr(idmap, path->dentry,
 				xattr_stream_name, NULL, 0, 0);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
@@ -2315,7 +2315,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 
 static int smb2_remove_smb_xattrs(const struct path *path)
 {
-	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
@@ -2335,7 +2335,7 @@ static int smb2_remove_smb_xattrs(const struct path *path)
 		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
 		    !strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
 			     STREAM_PREFIX_LEN)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, path->dentry,
+			err = ksmbd_vfs_remove_xattr(idmap, path->dentry,
 						     name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n",
@@ -2382,7 +2382,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt),
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt),
 					    path->dentry, &da);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
@@ -2401,7 +2401,7 @@ static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
 				    KSMBD_SHARE_FLAG_STORE_DOS_ATTRS))
 		return;
 
-	rc = ksmbd_vfs_get_dos_attrib_xattr(mnt_user_ns(path->mnt),
+	rc = ksmbd_vfs_get_dos_attrib_xattr(mnt_idmap(path->mnt),
 					    path->dentry, &da);
 	if (rc > 0) {
 		fp->f_ci->m_fattr = cpu_to_le32(da.attr);
@@ -2830,7 +2830,7 @@ int smb2_open(struct ksmbd_work *work)
 		if (!file_present) {
 			daccess = cpu_to_le32(GENERIC_ALL_FLAGS);
 		} else {
-			rc = ksmbd_vfs_query_maximal_access(user_ns,
+			rc = ksmbd_vfs_query_maximal_access(idmap,
 							    path.dentry,
 							    &daccess);
 			if (rc)
@@ -2889,7 +2889,7 @@ int smb2_open(struct ksmbd_work *work)
 		 * is already granted.
 		 */
 		if (daccess & ~(FILE_READ_ATTRIBUTES_LE | FILE_READ_CONTROL_LE)) {
-			rc = inode_permission(user_ns,
+			rc = inode_permission(idmap,
 					      d_inode(path.dentry),
 					      may_flags);
 			if (rc)
@@ -2897,7 +2897,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = ksmbd_vfs_may_delete(user_ns,
+				rc = ksmbd_vfs_may_delete(idmap,
 							  path.dentry);
 				if (rc)
 					goto err_out;
@@ -3013,7 +3013,7 @@ int smb2_open(struct ksmbd_work *work)
 					}
 
 					rc = ksmbd_vfs_set_sd_xattr(conn,
-								    user_ns,
+								    idmap,
 								    path.dentry,
 								    pntsd,
 								    pntsd_size);
@@ -3209,7 +3209,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct create_context *mxac_ccontext;
 
 		if (maximal_access == 0)
-			ksmbd_vfs_query_maximal_access(user_ns,
+			ksmbd_vfs_query_maximal_access(idmap,
 						       path.dentry,
 						       &maximal_access);
 		mxac_ccontext = (struct create_context *)(rsp->Buffer +
@@ -3635,7 +3635,6 @@ static void unlock_dir(struct ksmbd_file *dir_fp)
 static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 {
 	struct mnt_idmap	*idmap = file_mnt_idmap(priv->dir_fp->filp);
-	struct user_namespace	*user_ns = mnt_idmap_owner(idmap);
 	struct kstat		kstat;
 	struct ksmbd_kstat	ksmbd_kstat;
 	int			rc;
@@ -3648,7 +3647,7 @@ static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 			return -EINVAL;
 
 		lock_dir(priv->dir_fp);
-		dent = lookup_one(user_ns, priv->d_info->name,
+		dent = lookup_one(idmap, priv->d_info->name,
 				  priv->dir_fp->filp->f_path.dentry,
 				  priv->d_info->name_len);
 		unlock_dir(priv->dir_fp);
@@ -3899,7 +3898,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	}
 
 	if (!(dir_fp->daccess & FILE_LIST_DIRECTORY_LE) ||
-	    inode_permission(file_mnt_user_ns(dir_fp->filp),
+	    inode_permission(file_mnt_idmap(dir_fp->filp),
 			     file_inode(dir_fp->filp),
 			     MAY_READ | MAY_EXEC)) {
 		pr_err("no right to enumerate directory (%pD)\n", dir_fp->filp);
@@ -4165,7 +4164,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	ssize_t buf_free_len, alignment_bytes, next_offset, rsp_data_cnt = 0;
 	struct smb2_ea_info_req *ea_req = NULL;
 	const struct path *path;
-	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
 
 	if (!(fp->daccess & FILE_READ_EA_LE)) {
 		pr_err("Not permitted to read ext attr : 0x%x\n",
@@ -4245,7 +4244,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		buf_free_len -= (offsetof(struct smb2_ea_info, name) +
 				name_len + 1);
 		/* bailout if xattr can't fit in buf_free_len */
-		value_len = ksmbd_vfs_getxattr(user_ns, path->dentry,
+		value_len = ksmbd_vfs_getxattr(idmap, path->dentry,
 					       name, &buf);
 		if (value_len <= 0) {
 			rc = -ENOENT;
@@ -5128,6 +5127,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 			     struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_file *fp;
+	struct mnt_idmap *idmap;
 	struct user_namespace *user_ns;
 	struct smb_ntsd *pntsd = (struct smb_ntsd *)rsp->Buffer, *ppntsd = NULL;
 	struct smb_fattr fattr = {{0}};
@@ -5175,13 +5175,14 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 	if (!fp)
 		return -ENOENT;
 
-	user_ns = file_mnt_user_ns(fp->filp);
+	idmap = file_mnt_idmap(fp->filp);
+	user_ns = mnt_idmap_owner(idmap);
 	inode = file_inode(fp->filp);
 	ksmbd_acls_fattr(&fattr, user_ns, inode);
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_ACL_XATTR))
-		ppntsd_size = ksmbd_vfs_get_sd_xattr(work->conn, user_ns,
+		ppntsd_size = ksmbd_vfs_get_sd_xattr(work->conn, idmap,
 						     fp->filp->f_path.dentry,
 						     &ppntsd);
 
@@ -5417,7 +5418,7 @@ int smb2_echo(struct ksmbd_work *work)
 
 static int smb2_rename(struct ksmbd_work *work,
 		       struct ksmbd_file *fp,
-		       struct user_namespace *user_ns,
+		       struct mnt_idmap *idmap,
 		       struct smb2_file_rename_info *file_info,
 		       struct nls_table *local_nls)
 {
@@ -5480,7 +5481,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		if (rc)
 			goto out;
 
-		rc = ksmbd_vfs_setxattr(user_ns,
+		rc = ksmbd_vfs_setxattr(idmap,
 					fp->filp->f_path.dentry,
 					xattr_stream_name,
 					NULL, 0, 0);
@@ -5620,7 +5621,6 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	struct file *filp;
 	struct inode *inode;
 	struct mnt_idmap *idmap;
-	struct user_namespace *user_ns;
 	int rc = 0;
 
 	if (!(fp->daccess & FILE_WRITE_ATTRIBUTES_LE))
@@ -5630,7 +5630,6 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	filp = fp->filp;
 	inode = file_inode(filp);
 	idmap = file_mnt_idmap(filp);
-	user_ns = mnt_idmap_owner(idmap);
 
 	if (file_info->CreationTime)
 		fp->create_time = le64_to_cpu(file_info->CreationTime);
@@ -5674,7 +5673,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 			XATTR_DOSINFO_ITIME;
 
-		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
+		rc = ksmbd_vfs_set_dos_attrib_xattr(idmap,
 						    filp->f_path.dentry, &da);
 		if (rc)
 			ksmbd_debug(SMB,
@@ -5785,7 +5784,7 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			   struct smb2_file_rename_info *rename_info,
 			   unsigned int buf_len)
 {
-	struct user_namespace *user_ns;
+	struct mnt_idmap *idmap;
 	struct ksmbd_file *parent_fp;
 	struct dentry *parent;
 	struct dentry *dentry = fp->filp->f_path.dentry;
@@ -5800,12 +5799,12 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			le32_to_cpu(rename_info->FileNameLength))
 		return -EINVAL;
 
-	user_ns = file_mnt_user_ns(fp->filp);
+	idmap = file_mnt_idmap(fp->filp);
 	if (ksmbd_stream_fd(fp))
 		goto next;
 
 	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
+	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
 	if (ret) {
 		dput(parent);
 		return ret;
@@ -5824,7 +5823,7 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 		ksmbd_fd_put(work, parent_fp);
 	}
 next:
-	return smb2_rename(work, fp, user_ns, rename_info,
+	return smb2_rename(work, fp, idmap, rename_info,
 			   work->conn->local_nls);
 }
 
@@ -7533,14 +7532,14 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 				   struct file_sparse *sparse)
 {
 	struct ksmbd_file *fp;
-	struct user_namespace *user_ns;
+	struct mnt_idmap *idmap;
 	int ret = 0;
 	__le32 old_fattr;
 
 	fp = ksmbd_lookup_fd_fast(work, id);
 	if (!fp)
 		return -ENOENT;
-	user_ns = file_mnt_user_ns(fp->filp);
+	idmap = file_mnt_idmap(fp->filp);
 
 	old_fattr = fp->f_ci->m_fattr;
 	if (sparse->SetSparse)
@@ -7553,13 +7552,13 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
 		struct xattr_dos_attrib da;
 
-		ret = ksmbd_vfs_get_dos_attrib_xattr(user_ns,
+		ret = ksmbd_vfs_get_dos_attrib_xattr(idmap,
 						     fp->filp->f_path.dentry, &da);
 		if (ret <= 0)
 			goto out;
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
-		ret = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
+		ret = ksmbd_vfs_set_dos_attrib_xattr(idmap,
 						     fp->filp->f_path.dentry, &da);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 6e144880eeff..31255290b435 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1002,13 +1002,13 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_ntsd *parent_pntsd = NULL;
 	struct smb_sid owner_sid, group_sid;
 	struct dentry *parent = path->dentry->d_parent;
-	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0, pdacl_size;
 	int rc = 0, num_aces, dacloffset, pntsd_type, pntsd_size, acl_len, aces_size;
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
-	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
+	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, idmap,
 					    parent, &parent_pntsd);
 	if (pntsd_size <= 0)
 		return -ENOENT;
@@ -1162,7 +1162,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, user_ns,
+		ksmbd_vfs_set_sd_xattr(conn, idmap,
 				       path->dentry, pntsd, pntsd_size);
 		kfree(pntsd);
 	}
@@ -1190,7 +1190,8 @@ bool smb_inherit_flags(int flags, bool is_dir)
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid)
 {
-	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
+	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct smb_ntsd *pntsd = NULL;
 	struct smb_acl *pdacl;
 	struct posix_acl *posix_acls;
@@ -1206,7 +1207,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	unsigned short ace_size;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
-	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
+	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, idmap,
 					    path->dentry, &pntsd);
 	if (pntsd_size <= 0 || !pntsd)
 		goto err_out;
@@ -1415,8 +1416,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
-		ksmbd_vfs_remove_sd_xattrs(user_ns, path->dentry);
-		ksmbd_vfs_set_sd_xattr(conn, user_ns,
+		ksmbd_vfs_remove_sd_xattrs(idmap, path->dentry);
+		ksmbd_vfs_set_sd_xattr(conn, idmap,
 				       path->dentry, pntsd, ntsd_len);
 	}
 
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 21f420d21b3e..98e07c9f9869 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -69,14 +69,14 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
  *
  * the reference count of @parent isn't incremented.
  */
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
+int ksmbd_vfs_lock_parent(struct mnt_idmap *idmap, struct dentry *parent,
 			  struct dentry *child)
 {
 	struct dentry *dentry;
 	int ret = 0;
 
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	dentry = lookup_one(user_ns, child->d_name.name, parent,
+	dentry = lookup_one(idmap, child->d_name.name, parent,
 			    child->d_name.len);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
@@ -96,20 +96,20 @@ int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
 	return ret;
 }
 
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns,
+int ksmbd_vfs_may_delete(struct mnt_idmap *idmap,
 			 struct dentry *dentry)
 {
 	struct dentry *parent;
 	int ret;
 
 	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
+	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
 	if (ret) {
 		dput(parent);
 		return ret;
 	}
 
-	ret = inode_permission(user_ns, d_inode(parent),
+	ret = inode_permission(idmap, d_inode(parent),
 			       MAY_EXEC | MAY_WRITE);
 
 	inode_unlock(d_inode(parent));
@@ -117,7 +117,7 @@ int ksmbd_vfs_may_delete(struct user_namespace *user_ns,
 	return ret;
 }
 
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess)
 {
 	struct dentry *parent;
@@ -125,26 +125,26 @@ int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
 
-	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_WRITE))
+	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_WRITE))
 		*daccess |= cpu_to_le32(WRITE_DAC | WRITE_OWNER | SYNCHRONIZE |
 				FILE_WRITE_DATA | FILE_APPEND_DATA |
 				FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES |
 				FILE_DELETE_CHILD);
 
-	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_READ))
+	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_READ))
 		*daccess |= FILE_READ_DATA_LE | FILE_READ_EA_LE;
 
-	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_EXEC))
+	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_EXEC))
 		*daccess |= FILE_EXECUTE_LE;
 
 	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
+	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
 	if (ret) {
 		dput(parent);
 		return ret;
 	}
 
-	if (!inode_permission(user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
+	if (!inode_permission(idmap, d_inode(parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
 
 	inode_unlock(d_inode(parent));
@@ -200,7 +200,6 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *user_ns;
 	struct path path;
 	struct dentry *dentry;
 	int err;
@@ -217,7 +216,6 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 	}
 
 	idmap = mnt_idmap(path.mnt);
-	user_ns = mnt_idmap_owner(idmap);
 	mode |= S_IFDIR;
 	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
 	if (err) {
@@ -225,7 +223,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 	} else if (d_unhashed(dentry)) {
 		struct dentry *d;
 
-		d = lookup_one(user_ns, dentry->d_name.name, dentry->d_parent,
+		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
 			       dentry->d_name.len);
 		if (IS_ERR(d)) {
 			err = PTR_ERR(d);
@@ -247,7 +245,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 	return err;
 }
 
-static ssize_t ksmbd_vfs_getcasexattr(struct user_namespace *user_ns,
+static ssize_t ksmbd_vfs_getcasexattr(struct mnt_idmap *idmap,
 				      struct dentry *dentry, char *attr_name,
 				      int attr_name_len, char **attr_value)
 {
@@ -264,7 +262,7 @@ static ssize_t ksmbd_vfs_getcasexattr(struct user_namespace *user_ns,
 		if (strncasecmp(attr_name, name, attr_name_len))
 			continue;
 
-		value_len = ksmbd_vfs_getxattr(user_ns,
+		value_len = ksmbd_vfs_getxattr(idmap,
 					       dentry,
 					       name,
 					       attr_value);
@@ -287,7 +285,7 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	ksmbd_debug(VFS, "read stream data pos : %llu, count : %zd\n",
 		    *pos, count);
 
-	v_len = ksmbd_vfs_getcasexattr(file_mnt_user_ns(fp->filp),
+	v_len = ksmbd_vfs_getcasexattr(file_mnt_idmap(fp->filp),
 				       fp->filp->f_path.dentry,
 				       fp->stream.name,
 				       fp->stream.size,
@@ -411,7 +409,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				  size_t count)
 {
 	char *stream_buf = NULL, *wbuf;
-	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
 	size_t size, v_len;
 	int err = 0;
 
@@ -424,7 +422,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		count = (*pos + count) - XATTR_SIZE_MAX;
 	}
 
-	v_len = ksmbd_vfs_getcasexattr(user_ns,
+	v_len = ksmbd_vfs_getcasexattr(idmap,
 				       fp->filp->f_path.dentry,
 				       fp->stream.name,
 				       fp->stream.size,
@@ -450,7 +448,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 
 	memcpy(&stream_buf[*pos], buf, count);
 
-	err = ksmbd_vfs_setxattr(user_ns,
+	err = ksmbd_vfs_setxattr(idmap,
 				 fp->filp->f_path.dentry,
 				 fp->stream.name,
 				 (void *)stream_buf,
@@ -586,7 +584,6 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *user_ns;
 	struct path path;
 	struct dentry *parent;
 	int err;
@@ -602,9 +599,8 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
 	}
 
 	idmap = mnt_idmap(path.mnt);
-	user_ns = mnt_idmap_owner(idmap);
 	parent = dget_parent(path.dentry);
-	err = ksmbd_vfs_lock_parent(user_ns, parent, path.dentry);
+	err = ksmbd_vfs_lock_parent(idmap, parent, path.dentry);
 	if (err) {
 		dput(parent);
 		path_put(&path);
@@ -744,7 +740,7 @@ static int __ksmbd_vfs_rename(struct ksmbd_work *work,
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	dst_dent = lookup_one(mnt_idmap_owner(dst_idmap), dst_name,
+	dst_dent = lookup_one(dst_idmap, dst_name,
 			      dst_dent_parent, strlen(dst_name));
 	err = PTR_ERR(dst_dent);
 	if (IS_ERR(dst_dent)) {
@@ -777,7 +773,6 @@ int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 			char *newname)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *user_ns;
 	struct path dst_path;
 	struct dentry *src_dent_parent, *dst_dent_parent;
 	struct dentry *src_dent, *trap_dent, *src_child;
@@ -806,8 +801,7 @@ int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 	dget(src_dent);
 	dget(dst_dent_parent);
 	idmap = file_mnt_idmap(fp->filp);
-	user_ns = mnt_idmap_owner(idmap);
-	src_child = lookup_one(user_ns, src_dent->d_name.name, src_dent_parent,
+	src_child = lookup_one(idmap, src_dent->d_name.name, src_dent_parent,
 			       src_dent->d_name.len);
 	if (IS_ERR(src_child)) {
 		err = PTR_ERR(src_child);
@@ -913,22 +907,22 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	return size;
 }
 
-static ssize_t ksmbd_vfs_xattr_len(struct user_namespace *user_ns,
+static ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
 				   struct dentry *dentry, char *xattr_name)
 {
-	return vfs_getxattr(user_ns, dentry, xattr_name, NULL, 0);
+	return vfs_getxattr(idmap, dentry, xattr_name, NULL, 0);
 }
 
 /**
  * ksmbd_vfs_getxattr() - vfs helper for smb get extended attributes value
- * @user_ns:	user namespace
+ * @idmap:	idmap
  * @dentry:	dentry of file for getting xattrs
  * @xattr_name:	name of xattr name to query
  * @xattr_buf:	destination buffer xattr value
  *
  * Return:	read xattr value length on success, otherwise error
  */
-ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
+ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   char *xattr_name, char **xattr_buf)
 {
@@ -936,7 +930,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
 	char *buf;
 
 	*xattr_buf = NULL;
-	xattr_len = ksmbd_vfs_xattr_len(user_ns, dentry, xattr_name);
+	xattr_len = ksmbd_vfs_xattr_len(idmap, dentry, xattr_name);
 	if (xattr_len < 0)
 		return xattr_len;
 
@@ -944,7 +938,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
 	if (!buf)
 		return -ENOMEM;
 
-	xattr_len = vfs_getxattr(user_ns, dentry, xattr_name,
+	xattr_len = vfs_getxattr(idmap, dentry, xattr_name,
 				 (void *)buf, xattr_len);
 	if (xattr_len > 0)
 		*xattr_buf = buf;
@@ -955,7 +949,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
 
 /**
  * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
- * @user_ns:	user namespace
+ * @idmap:	idmap of the relevant mount
  * @dentry:	dentry to set XATTR at
  * @name:	xattr name for setxattr
  * @value:	xattr value to set
@@ -964,13 +958,13 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
+int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 		       struct dentry *dentry, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags)
 {
 	int err;
 
-	err = vfs_setxattr(user_ns,
+	err = vfs_setxattr(idmap,
 			   dentry,
 			   attr_name,
 			   attr_value,
@@ -1080,19 +1074,18 @@ int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 	return ret;
 }
 
-int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
+int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, char *attr_name)
 {
-	return vfs_removexattr(user_ns, dentry, attr_name);
+	return vfs_removexattr(idmap, dentry, attr_name);
 }
 
 int ksmbd_vfs_unlink(struct mnt_idmap *idmap,
 		     struct dentry *dir, struct dentry *dentry)
 {
 	int err = 0;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
-	err = ksmbd_vfs_lock_parent(mnt_userns, dir, dentry);
+	err = ksmbd_vfs_lock_parent(idmap, dir, dentry);
 	if (err)
 		return err;
 	dget(dentry);
@@ -1339,7 +1332,7 @@ int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 	return err;
 }
 
-int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
+int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
 			       struct dentry *dentry)
 {
 	char *name, *xattr_list = NULL;
@@ -1359,7 +1352,7 @@ int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
 
 		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			err = ksmbd_vfs_remove_xattr(idmap, dentry, name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
 		}
@@ -1435,11 +1428,12 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 }
 
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
-			   struct user_namespace *user_ns,
+			   struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   struct smb_ntsd *pntsd, int len)
 {
 	int rc;
+	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
 	struct xattr_ntacl acl = {0};
 	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
@@ -1494,7 +1488,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 		goto out;
 	}
 
-	rc = ksmbd_vfs_setxattr(user_ns, dentry,
+	rc = ksmbd_vfs_setxattr(idmap, dentry,
 				XATTR_NAME_SD, sd_ndr.data,
 				sd_ndr.offset, 0);
 	if (rc < 0)
@@ -1509,11 +1503,12 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 }
 
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
-			   struct user_namespace *user_ns,
+			   struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd)
 {
 	int rc;
+	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct ndr n;
 	struct inode *inode = d_inode(dentry);
 	struct ndr acl_ndr = {0};
@@ -1521,7 +1516,7 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 	struct xattr_smb_acl *smb_acl = NULL, *def_smb_acl = NULL;
 	__u8 cmp_hash[XATTR_SD_HASH_SIZE] = {0};
 
-	rc = ksmbd_vfs_getxattr(user_ns, dentry, XATTR_NAME_SD, &n.data);
+	rc = ksmbd_vfs_getxattr(idmap, dentry, XATTR_NAME_SD, &n.data);
 	if (rc <= 0)
 		return rc;
 
@@ -1583,7 +1578,7 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 	return rc;
 }
 
-int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
+int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da)
 {
@@ -1594,7 +1589,7 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 	if (err)
 		return err;
 
-	err = ksmbd_vfs_setxattr(user_ns, dentry, XATTR_NAME_DOS_ATTRIBUTE,
+	err = ksmbd_vfs_setxattr(idmap, dentry, XATTR_NAME_DOS_ATTRIBUTE,
 				 (void *)n.data, n.offset, 0);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
@@ -1603,14 +1598,14 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 	return err;
 }
 
-int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
+int ksmbd_vfs_get_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da)
 {
 	struct ndr n;
 	int err;
 
-	err = ksmbd_vfs_getxattr(user_ns, dentry, XATTR_NAME_DOS_ATTRIBUTE,
+	err = ksmbd_vfs_getxattr(idmap, dentry, XATTR_NAME_DOS_ATTRIBUTE,
 				 (char **)&n.data);
 	if (err > 0) {
 		n.length = err;
@@ -1682,7 +1677,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
 		struct xattr_dos_attrib da;
 
-		rc = ksmbd_vfs_get_dos_attrib_xattr(mnt_idmap_owner(idmap), dentry, &da);
+		rc = ksmbd_vfs_get_dos_attrib_xattr(idmap, dentry, &da);
 		if (rc > 0) {
 			ksmbd_kstat->file_attributes = cpu_to_le32(da.attr);
 			ksmbd_kstat->create_time = da.create_time;
@@ -1694,7 +1689,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 	return 0;
 }
 
-ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
+ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len)
 {
@@ -1711,7 +1706,7 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 		if (strncasecmp(attr_name, name, attr_name_len))
 			continue;
 
-		value_len = ksmbd_vfs_xattr_len(user_ns, dentry, name);
+		value_len = ksmbd_vfs_xattr_len(idmap, dentry, name);
 		break;
 	}
 
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 1f8c5ac03041..9d676ab0cd25 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -71,10 +71,10 @@ struct ksmbd_kstat {
 	__le32			file_attributes;
 };
 
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
+int ksmbd_vfs_lock_parent(struct mnt_idmap *idmap, struct dentry *parent,
 			  struct dentry *child);
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns, struct dentry *dentry);
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+int ksmbd_vfs_may_delete(struct mnt_idmap *idmap, struct dentry *dentry);
+int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
@@ -102,19 +102,19 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 			       unsigned int *chunk_size_written,
 			       loff_t  *total_size_written);
 ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list);
-ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
+ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   char *xattr_name,
 			   char **xattr_buf);
-ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
+ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len);
-int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
+int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 		       struct dentry *dentry, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
-int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
+int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, char *attr_name);
 int ksmbd_vfs_kern_path(struct ksmbd_work *work,
 			char *name, unsigned int flags, struct path *path,
@@ -143,20 +143,20 @@ int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
 void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
 int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 				struct dentry *dentry);
-int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
+int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
 			       struct dentry *dentry);
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
-			   struct user_namespace *user_ns,
+			   struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   struct smb_ntsd *pntsd, int len);
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
-			   struct user_namespace *user_ns,
+			   struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd);
-int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
+int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
-int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
+int ksmbd_vfs_get_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 8489ff4d601a..8ffc89e62002 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -251,7 +251,7 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	filp = fp->filp;
 	if (ksmbd_stream_fd(fp) && (ci->m_flags & S_DEL_ON_CLS_STREAM)) {
 		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
-		err = ksmbd_vfs_remove_xattr(file_mnt_user_ns(filp),
+		err = ksmbd_vfs_remove_xattr(file_mnt_idmap(filp),
 					     filp->f_path.dentry,
 					     fp->stream.name);
 		if (err)
diff --git a/fs/namei.c b/fs/namei.c
index 34f020ae67ae..e483738b2661 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -373,7 +373,7 @@ static int acl_permission_check(struct user_namespace *mnt_userns,
 
 /**
  * generic_permission -  check for access rights on a Posix-like filesystem
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:	inode to check access rights for
  * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC,
  *		%MAY_NOT_BLOCK ...)
@@ -387,16 +387,17 @@ static int acl_permission_check(struct user_namespace *mnt_userns,
  * request cannot be satisfied (eg. requires blocking or too much complexity).
  * It would then be called again in ref-walk mode.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int generic_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
 		       int mask)
 {
 	int ret;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	/*
 	 * Do the basic permission checks.
@@ -441,7 +442,7 @@ EXPORT_SYMBOL(generic_permission);
 
 /**
  * do_inode_permission - UNIX permission checking
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:	inode to check permissions on
  * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC ...)
  *
@@ -450,19 +451,19 @@ EXPORT_SYMBOL(generic_permission);
  * flag in inode->i_opflags, that says "this has not special
  * permission function, use the fast case".
  */
-static inline int do_inode_permission(struct user_namespace *mnt_userns,
+static inline int do_inode_permission(struct mnt_idmap *idmap,
 				      struct inode *inode, int mask)
 {
 	if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
 		if (likely(inode->i_op->permission))
-			return inode->i_op->permission(mnt_userns, inode, mask);
+			return inode->i_op->permission(idmap, inode, mask);
 
 		/* This gets set once for the inode lifetime */
 		spin_lock(&inode->i_lock);
 		inode->i_opflags |= IOP_FASTPERM;
 		spin_unlock(&inode->i_lock);
 	}
-	return generic_permission(mnt_userns, inode, mask);
+	return generic_permission(idmap, inode, mask);
 }
 
 /**
@@ -487,7 +488,7 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 
 /**
  * inode_permission - Check for access rights to a given inode
- * @mnt_userns:	User namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:	Inode to check permission on
  * @mask:	Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
  *
@@ -497,7 +498,7 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
  *
  * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
  */
-int inode_permission(struct user_namespace *mnt_userns,
+int inode_permission(struct mnt_idmap *idmap,
 		     struct inode *inode, int mask)
 {
 	int retval;
@@ -518,11 +519,11 @@ int inode_permission(struct user_namespace *mnt_userns,
 		 * written back improperly if their true value is unknown
 		 * to the vfs.
 		 */
-		if (HAS_UNMAPPED_ID(mnt_userns, inode))
+		if (HAS_UNMAPPED_ID(idmap, inode))
 			return -EACCES;
 	}
 
-	retval = do_inode_permission(mnt_userns, inode, mask);
+	retval = do_inode_permission(idmap, inode, mask);
 	if (retval)
 		return retval;
 
@@ -1124,7 +1125,7 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
 
 /**
  * safe_hardlink_source - Check for safe hardlink conditions
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: the source inode to hardlink from
  *
  * Return false if at least one of the following conditions:
@@ -1135,7 +1136,7 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
  *
  * Otherwise returns true.
  */
-static bool safe_hardlink_source(struct user_namespace *mnt_userns,
+static bool safe_hardlink_source(struct mnt_idmap *idmap,
 				 struct inode *inode)
 {
 	umode_t mode = inode->i_mode;
@@ -1153,7 +1154,7 @@ static bool safe_hardlink_source(struct user_namespace *mnt_userns,
 		return false;
 
 	/* Hardlinking to unreadable or unwritable sources is dangerous. */
-	if (inode_permission(mnt_userns, inode, MAY_READ | MAY_WRITE))
+	if (inode_permission(idmap, inode, MAY_READ | MAY_WRITE))
 		return false;
 
 	return true;
@@ -1161,8 +1162,8 @@ static bool safe_hardlink_source(struct user_namespace *mnt_userns,
 
 /**
  * may_linkat - Check permissions for creating a hardlink
- * @mnt_userns:	user namespace of the mount the inode was found from
- * @link: the source to hardlink from
+ * @idmap: idmap of the mount the inode was found from
+ * @link:  the source to hardlink from
  *
  * Block hardlink when all of:
  *  - sysctl_protected_hardlinks enabled
@@ -1170,16 +1171,17 @@ static bool safe_hardlink_source(struct user_namespace *mnt_userns,
  *  - hardlink source is unsafe (see safe_hardlink_source() above)
  *  - not CAP_FOWNER in a namespace with the inode owner uid mapped
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply pass @nop_mnt_idmap.
  *
  * Returns 0 if successful, -ve on error.
  */
-int may_linkat(struct user_namespace *mnt_userns, const struct path *link)
+int may_linkat(struct mnt_idmap *idmap, const struct path *link)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = link->dentry->d_inode;
 
 	/* Inode writeback is not safe when the uid or gid are invalid. */
@@ -1193,7 +1195,7 @@ int may_linkat(struct user_namespace *mnt_userns, const struct path *link)
 	/* Source inode owner (or CAP_FOWNER) can hardlink all they like,
 	 * otherwise, it must be a safe source.
 	 */
-	if (safe_hardlink_source(mnt_userns, inode) ||
+	if (safe_hardlink_source(idmap, inode) ||
 	    inode_owner_or_capable(mnt_userns, inode))
 		return 0;
 
@@ -1704,15 +1706,15 @@ static struct dentry *lookup_slow(const struct qstr *name,
 	return res;
 }
 
-static inline int may_lookup(struct user_namespace *mnt_userns,
+static inline int may_lookup(struct mnt_idmap *idmap,
 			     struct nameidata *nd)
 {
 	if (nd->flags & LOOKUP_RCU) {
-		int err = inode_permission(mnt_userns, nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
+		int err = inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
 		if (err != -ECHILD || !try_to_unlazy(nd))
 			return err;
 	}
-	return inode_permission(mnt_userns, nd->inode, MAY_EXEC);
+	return inode_permission(idmap, nd->inode, MAY_EXEC);
 }
 
 static int reserve_stack(struct nameidata *nd, struct path *link)
@@ -2253,13 +2255,15 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
+		struct mnt_idmap *idmap;
 		struct user_namespace *mnt_userns;
 		const char *link;
 		u64 hash_len;
 		int type;
 
-		mnt_userns = mnt_user_ns(nd->path.mnt);
-		err = may_lookup(mnt_userns, nd);
+		idmap = mnt_idmap(nd->path.mnt);
+		mnt_userns = mnt_idmap_owner(idmap);
+		err = may_lookup(idmap, nd);
 		if (err)
 			return err;
 
@@ -2622,7 +2626,7 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_one_common(struct user_namespace *mnt_userns,
+static int lookup_one_common(struct mnt_idmap *idmap,
 			     const char *name, struct dentry *base, int len,
 			     struct qstr *this)
 {
@@ -2652,7 +2656,7 @@ static int lookup_one_common(struct user_namespace *mnt_userns,
 			return err;
 	}
 
-	return inode_permission(mnt_userns, base->d_inode, MAY_EXEC);
+	return inode_permission(idmap, base->d_inode, MAY_EXEC);
 }
 
 /**
@@ -2676,7 +2680,7 @@ struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(&init_user_ns, name, base, len, &this);
+	err = lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2703,7 +2707,7 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(&init_user_ns, name, base, len, &this);
+	err = lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2714,7 +2718,7 @@ EXPORT_SYMBOL(lookup_one_len);
 
 /**
  * lookup_one - filesystem helper to lookup single pathname component
- * @mnt_userns:	user namespace of the mount the lookup is performed from
+ * @idmap:	idmap of the mount the lookup is performed from
  * @name:	pathname component to lookup
  * @base:	base directory to lookup from
  * @len:	maximum length @len should be interpreted to
@@ -2724,7 +2728,7 @@ EXPORT_SYMBOL(lookup_one_len);
  *
  * The caller must hold base->i_mutex.
  */
-struct dentry *lookup_one(struct user_namespace *mnt_userns, const char *name,
+struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
 			  struct dentry *base, int len)
 {
 	struct dentry *dentry;
@@ -2733,7 +2737,7 @@ struct dentry *lookup_one(struct user_namespace *mnt_userns, const char *name,
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(mnt_userns, name, base, len, &this);
+	err = lookup_one_common(idmap, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2744,7 +2748,7 @@ EXPORT_SYMBOL(lookup_one);
 
 /**
  * lookup_one_unlocked - filesystem helper to lookup single pathname component
- * @mnt_userns:	idmapping of the mount the lookup is performed from
+ * @idmap:	idmap of the mount the lookup is performed from
  * @name:	pathname component to lookup
  * @base:	base directory to lookup from
  * @len:	maximum length @len should be interpreted to
@@ -2755,7 +2759,7 @@ EXPORT_SYMBOL(lookup_one);
  * Unlike lookup_one_len, it should be called without the parent
  * i_mutex held, and will take the i_mutex itself if necessary.
  */
-struct dentry *lookup_one_unlocked(struct user_namespace *mnt_userns,
+struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 				   const char *name, struct dentry *base,
 				   int len)
 {
@@ -2763,7 +2767,7 @@ struct dentry *lookup_one_unlocked(struct user_namespace *mnt_userns,
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_common(mnt_userns, name, base, len, &this);
+	err = lookup_one_common(idmap, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2777,7 +2781,7 @@ EXPORT_SYMBOL(lookup_one_unlocked);
 /**
  * lookup_one_positive_unlocked - filesystem helper to lookup single
  *				  pathname component
- * @mnt_userns:	idmapping of the mount the lookup is performed from
+ * @idmap:	idmap of the mount the lookup is performed from
  * @name:	pathname component to lookup
  * @base:	base directory to lookup from
  * @len:	maximum length @len should be interpreted to
@@ -2794,11 +2798,11 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  *
  * The helper should be called without i_mutex held.
  */
-struct dentry *lookup_one_positive_unlocked(struct user_namespace *mnt_userns,
+struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    const char *name,
 					    struct dentry *base, int len)
 {
-	struct dentry *ret = lookup_one_unlocked(mnt_userns, name, base, len);
+	struct dentry *ret = lookup_one_unlocked(idmap, name, base, len);
 
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		dput(ret);
@@ -2823,7 +2827,7 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
 struct dentry *lookup_one_len_unlocked(const char *name,
 				       struct dentry *base, int len)
 {
-	return lookup_one_unlocked(&init_user_ns, name, base, len);
+	return lookup_one_unlocked(&nop_mnt_idmap, name, base, len);
 }
 EXPORT_SYMBOL(lookup_one_len_unlocked);
 
@@ -2838,7 +2842,7 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
 struct dentry *lookup_positive_unlocked(const char *name,
 				       struct dentry *base, int len)
 {
-	return lookup_one_positive_unlocked(&init_user_ns, name, base, len);
+	return lookup_one_positive_unlocked(&nop_mnt_idmap, name, base, len);
 }
 EXPORT_SYMBOL(lookup_positive_unlocked);
 
@@ -2913,9 +2917,10 @@ EXPORT_SYMBOL(__check_sticky);
  * 11. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
+static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *victim, bool isdir)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_backing_inode(victim);
 	int error;
 
@@ -2932,7 +2937,7 @@ static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
 
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -2940,7 +2945,7 @@ static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
 
 	if (check_sticky(mnt_userns, dir, inode) || IS_APPEND(inode) ||
 	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) ||
-	    HAS_UNMAPPED_ID(mnt_userns, inode))
+	    HAS_UNMAPPED_ID(idmap, inode))
 		return -EPERM;
 	if (isdir) {
 		if (!d_is_dir(victim))
@@ -2965,7 +2970,7 @@ static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
  *  4. We should have write and exec permissions on dir
  *  5. We can't do it if dir is immutable (done in permission())
  */
-static inline int may_create(struct user_namespace *mnt_userns,
+static inline int may_create(struct mnt_idmap *idmap,
 			     struct inode *dir, struct dentry *child)
 {
 	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE);
@@ -2973,10 +2978,10 @@ static inline int may_create(struct user_namespace *mnt_userns,
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	if (!fsuidgid_has_mapping(dir->i_sb, mnt_userns))
+	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
 		return -EOVERFLOW;
 
-	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -3104,7 +3109,7 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 
-	error = may_create(mnt_userns, dir, dentry);
+	error = may_create(idmap, dir, dentry);
 	if (error)
 		return error;
 
@@ -3127,7 +3132,7 @@ int vfs_mkobj(struct dentry *dentry, umode_t mode,
 		void *arg)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
-	int error = may_create(&init_user_ns, dir, dentry);
+	int error = may_create(&nop_mnt_idmap, dir, dentry);
 	if (error)
 		return error;
 
@@ -3149,9 +3154,10 @@ bool may_open_dev(const struct path *path)
 		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
 }
 
-static int may_open(struct user_namespace *mnt_userns, const struct path *path,
+static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		    int acc_mode, int flag)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct dentry *dentry = path->dentry;
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -3185,7 +3191,7 @@ static int may_open(struct user_namespace *mnt_userns, const struct path *path,
 		break;
 	}
 
-	error = inode_permission(mnt_userns, inode, MAY_OPEN | acc_mode);
+	error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
 	if (error)
 		return error;
 
@@ -3231,7 +3237,7 @@ static inline int open_to_namei_flags(int flag)
 	return flag;
 }
 
-static int may_o_create(struct user_namespace *mnt_userns,
+static int may_o_create(struct mnt_idmap *idmap,
 			const struct path *dir, struct dentry *dentry,
 			umode_t mode)
 {
@@ -3239,10 +3245,10 @@ static int may_o_create(struct user_namespace *mnt_userns,
 	if (error)
 		return error;
 
-	if (!fsuidgid_has_mapping(dir->dentry->d_sb, mnt_userns))
+	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
 		return -EOVERFLOW;
 
-	error = inode_permission(mnt_userns, dir->dentry->d_inode,
+	error = inode_permission(idmap, dir->dentry->d_inode,
 				 MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
@@ -3378,7 +3384,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			open_flag &= ~O_TRUNC;
 		mode = vfs_prepare_mode(mnt_userns, dir->d_inode, mode, mode, mode);
 		if (likely(got_write))
-			create_error = may_o_create(mnt_userns, &nd->path,
+			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
 		else
 			create_error = -EROFS;
@@ -3559,7 +3565,7 @@ static int do_open(struct nameidata *nd,
 			return error;
 		do_truncate = true;
 	}
-	error = may_open(mnt_userns, &nd->path, acc_mode, open_flag);
+	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
 	if (!error)
@@ -3602,7 +3608,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 	int open_flag = file->f_flags;
 
 	/* we want directory to be writable */
-	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (!dir->i_op->tmpfile)
@@ -3618,7 +3624,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 	/* Don't check for other permissions, the inode was just created */
-	error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
+	error = may_open(idmap, &file->f_path, 0, file->f_flags);
 	if (error)
 		return error;
 	inode = file_inode(file);
@@ -3898,7 +3904,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
-	int error = may_create(mnt_userns, dir, dentry);
+	int error = may_create(idmap, dir, dentry);
 
 	if (error)
 		return error;
@@ -4029,7 +4035,7 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
 
-	error = may_create(mnt_userns, dir, dentry);
+	error = may_create(idmap, dir, dentry);
 	if (error)
 		return error;
 
@@ -4107,8 +4113,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	int error = may_delete(mnt_userns, dir, dentry, 1);
+	int error = may_delete(idmap, dir, dentry, 1);
 
 	if (error)
 		return error;
@@ -4237,9 +4242,8 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, struct inode **delegated_inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *target = dentry->d_inode;
-	int error = may_delete(mnt_userns, dir, dentry, 0);
+	int error = may_delete(idmap, dir, dentry, 0);
 
 	if (error)
 		return error;
@@ -4393,10 +4397,9 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
 int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, const char *oldname)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 
-	error = may_create(mnt_userns, dir, dentry);
+	error = may_create(idmap, dir, dentry);
 	if (error)
 		return error;
 
@@ -4487,7 +4490,6 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	     struct inode *dir, struct dentry *new_dentry,
 	     struct inode **delegated_inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = old_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
 	int error;
@@ -4495,7 +4497,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(mnt_userns, dir, new_dentry);
+	error = may_create(idmap, dir, new_dentry);
 	if (error)
 		return error;
 
@@ -4512,7 +4514,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	 * be writen back improperly if their true value is unknown to
 	 * the vfs.
 	 */
-	if (HAS_UNMAPPED_ID(mnt_userns, inode))
+	if (HAS_UNMAPPED_ID(idmap, inode))
 		return -EPERM;
 	if (!dir->i_op->link)
 		return -EPERM;
@@ -4560,7 +4562,6 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	      struct filename *new, int flags)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *mnt_userns;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
 	struct inode *delegated_inode = NULL;
@@ -4598,8 +4599,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
 	idmap = mnt_idmap(new_path.mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
-	error = may_linkat(mnt_userns, &old_path);
+	error = may_linkat(idmap, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
@@ -4701,26 +4701,24 @@ int vfs_rename(struct renamedata *rd)
 	bool new_is_dir = false;
 	unsigned max_links = new_dir->i_sb->s_max_links;
 	struct name_snapshot old_name;
-	struct user_namespace *old_mnt_userns = mnt_idmap_owner(rd->old_mnt_idmap),
-			      *new_mnt_userns = mnt_idmap_owner(rd->new_mnt_idmap);
 
 	if (source == target)
 		return 0;
 
-	error = may_delete(old_mnt_userns, old_dir, old_dentry, is_dir);
+	error = may_delete(rd->old_mnt_idmap, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
-		error = may_create(new_mnt_userns, new_dir, new_dentry);
+		error = may_create(rd->new_mnt_idmap, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(new_mnt_userns, new_dir,
+			error = may_delete(rd->new_mnt_idmap, new_dir,
 					   new_dentry, is_dir);
 		else
-			error = may_delete(new_mnt_userns, new_dir,
+			error = may_delete(rd->new_mnt_idmap, new_dir,
 					   new_dentry, new_is_dir);
 	}
 	if (error)
@@ -4735,13 +4733,13 @@ int vfs_rename(struct renamedata *rd)
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(old_mnt_userns, source,
+			error = inode_permission(rd->old_mnt_idmap, source,
 						 MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(new_mnt_userns, target,
+			error = inode_permission(rd->new_mnt_idmap, target,
 						 MAY_WRITE);
 			if (error)
 				return error;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 01eeae59599b..f8b8dae0df78 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3257,7 +3257,7 @@ static int nfs_execute_ok(struct inode *inode, int mask)
 	return ret;
 }
 
-int nfs_permission(struct user_namespace *mnt_userns,
+int nfs_permission(struct mnt_idmap *idmap,
 		   struct inode *inode,
 		   int mask)
 {
@@ -3308,7 +3308,7 @@ int nfs_permission(struct user_namespace *mnt_userns,
 	res = nfs_revalidate_inode(inode, NFS_INO_INVALID_MODE |
 						  NFS_INO_INVALID_OTHER);
 	if (res == 0)
-		res = generic_permission(&init_user_ns, inode, mask);
+		res = generic_permission(&nop_mnt_idmap, inode, mask);
 	goto out;
 }
 EXPORT_SYMBOL_GPL(nfs_permission);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8c52b6c9d31a..73c1bbdc99c3 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -40,7 +40,7 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
 		/* make sure parents give x permission to user */
 		int err;
 		parent = dget_parent(tdentry);
-		err = inode_permission(&init_user_ns,
+		err = inode_permission(&nop_mnt_idmap,
 				       d_inode(parent), MAY_EXEC);
 		if (err < 0) {
 			dput(parent);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 66517ad6ac13..ab4ee3509ce3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -583,7 +583,7 @@ int nfsd4_is_junction(struct dentry *dentry)
 		return 0;
 	if (!(inode->i_mode & S_ISVTX))
 		return 0;
-	if (vfs_getxattr(&init_user_ns, dentry, NFSD_JUNCTION_XATTR_NAME,
+	if (vfs_getxattr(&nop_mnt_idmap, dentry, NFSD_JUNCTION_XATTR_NAME,
 			 NULL, 0) <= 0)
 		return 0;
 	return 1;
@@ -2130,7 +2130,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 
 	inode_lock_shared(inode);
 
-	len = vfs_getxattr(&init_user_ns, dentry, name, NULL, 0);
+	len = vfs_getxattr(&nop_mnt_idmap, dentry, name, NULL, 0);
 
 	/*
 	 * Zero-length attribute, just return.
@@ -2157,7 +2157,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 		goto out;
 	}
 
-	len = vfs_getxattr(&init_user_ns, dentry, name, buf, len);
+	len = vfs_getxattr(&nop_mnt_idmap, dentry, name, buf, len);
 	if (len <= 0) {
 		kvfree(buf);
 		buf = NULL;
@@ -2268,7 +2268,7 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 	inode_lock(fhp->fh_dentry->d_inode);
 	fh_fill_pre_attrs(fhp);
 
-	ret = __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
+	ret = __vfs_removexattr_locked(&nop_mnt_idmap, fhp->fh_dentry,
 				       name, NULL);
 
 	fh_fill_post_attrs(fhp);
@@ -2295,7 +2295,7 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	inode_lock(fhp->fh_dentry->d_inode);
 	fh_fill_pre_attrs(fhp);
 
-	ret = __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
+	ret = __vfs_setxattr_locked(&nop_mnt_idmap, fhp->fh_dentry, name, buf,
 				    len, flags, NULL);
 	fh_fill_post_attrs(fhp);
 	inode_unlock(fhp->fh_dentry->d_inode);
@@ -2379,14 +2379,14 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 		return 0;
 
 	/* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
-	err = inode_permission(&init_user_ns, inode,
+	err = inode_permission(&nop_mnt_idmap, inode,
 			       acc & (MAY_READ | MAY_WRITE | MAY_EXEC));
 
 	/* Allow read access to binaries even when mode 111 */
 	if (err == -EACCES && S_ISREG(inode->i_mode) &&
 	     (acc == (NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE) ||
 	      acc == (NFSD_MAY_READ | NFSD_MAY_READ_IF_EXEC)))
-		err = inode_permission(&init_user_ns, inode, MAY_EXEC);
+		err = inode_permission(&nop_mnt_idmap, inode, MAY_EXEC);
 
 	return err? nfserrno(err) : 0;
 }
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 30b145ff1a8d..7044bfff00dd 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -988,7 +988,7 @@ int nilfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return err;
 }
 
-int nilfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
 		     int mask)
 {
 	struct nilfs_root *root = NILFS_I(inode)->i_root;
@@ -997,7 +997,7 @@ int nilfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 	    root->cno != NILFS_CPTREE_CURRENT_CNO)
 		return -EROFS; /* snapshot is not writable */
 
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index ff8ddc86ca08..8046490cd7fe 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -274,7 +274,7 @@ extern void nilfs_evict_inode(struct inode *);
 extern int nilfs_setattr(struct mnt_idmap *, struct dentry *,
 			 struct iattr *);
 extern void nilfs_write_failed(struct address_space *mapping, loff_t to);
-int nilfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
 		     int mask);
 int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh);
 extern int nilfs_inode_dirty(struct inode *);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 9d45a259695c..9b649a5b6beb 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -869,7 +869,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 #endif
 
 int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry);
-int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int ntfs_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask);
 ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 extern const struct xattr_handler *ntfs_xattr_handlers[];
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 370effca6b2c..42b8eec72ba0 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -716,7 +716,7 @@ int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry)
 /*
  * ntfs_permission - inode_operations::permission
  */
-int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int ntfs_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
 	if (ntfs_sb(inode->i_sb)->options->noacsrules) {
@@ -724,7 +724,7 @@ int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		return 0;
 	}
 
-	return generic_permission(mnt_userns, inode, mask);
+	return generic_permission(idmap, inode, mask);
 }
 
 /*
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 972a8333317f..7acc89f47a5a 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1335,7 +1335,7 @@ int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return err;
 }
 
-int ocfs2_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int ocfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 		     int mask)
 {
 	int ret, had_lock;
@@ -1361,7 +1361,7 @@ int ocfs2_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		dump_stack();
 	}
 
-	ret = generic_permission(&init_user_ns, inode, mask);
+	ret = generic_permission(&nop_mnt_idmap, inode, mask);
 
 	ocfs2_inode_unlock_tracker(inode, 0, &oh, had_lock);
 out:
diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
index ddc76aaffe79..8e53e4ac1120 100644
--- a/fs/ocfs2/file.h
+++ b/fs/ocfs2/file.h
@@ -53,7 +53,7 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
 int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask, unsigned int flags);
-int ocfs2_permission(struct user_namespace *mnt_userns,
+int ocfs2_permission(struct mnt_idmap *idmap,
 		     struct inode *inode,
 		     int mask);
 
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 623db358b1ef..5a656dc683f1 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4316,7 +4316,7 @@ static inline int ocfs2_may_create(struct inode *dir, struct dentry *child)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(&nop_mnt_idmap, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /**
@@ -4370,7 +4370,7 @@ static int ocfs2_vfs_reflink(struct dentry *old_dentry, struct inode *dir,
 	 * file.
 	 */
 	if (!preserve) {
-		error = inode_permission(&init_user_ns, inode, MAY_READ);
+		error = inode_permission(&nop_mnt_idmap, inode, MAY_READ);
 		if (error)
 			return error;
 	}
diff --git a/fs/open.c b/fs/open.c
index 60a81db586ef..94e2afb2c603 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -71,7 +71,6 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 long vfs_truncate(const struct path *path, loff_t length)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *mnt_userns;
 	struct inode *inode;
 	long error;
 
@@ -88,8 +87,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 		goto out;
 
 	idmap = mnt_idmap(path->mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
-	error = inode_permission(mnt_userns, inode, MAY_WRITE);
+	error = inode_permission(idmap, inode, MAY_WRITE);
 	if (error)
 		goto mnt_drop_write_and_out;
 
@@ -462,7 +460,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 			goto out_path_release;
 	}
 
-	res = inode_permission(mnt_user_ns(path.mnt), inode, mode | MAY_ACCESS);
+	res = inode_permission(mnt_idmap(path.mnt), inode, mode | MAY_ACCESS);
 	/* SuS v2 requires we report a read only fs too */
 	if (res || !(mode & S_IWOTH) || special_file(inode->i_mode))
 		goto out_path_release;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 328e49857242..11e21a0e65ce 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -890,7 +890,7 @@ int orangefs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return ret;
 }
 
-int orangefs_permission(struct user_namespace *mnt_userns,
+int orangefs_permission(struct mnt_idmap *idmap,
 			struct inode *inode, int mask)
 {
 	int ret;
@@ -905,7 +905,7 @@ int orangefs_permission(struct user_namespace *mnt_userns,
 	if (ret < 0)
 		return ret;
 
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags)
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index f1ac4bd03c8d..ce20d3443869 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -367,7 +367,7 @@ int orangefs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
 int orangefs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		     struct kstat *stat, u32 request_mask, unsigned int flags);
 
-int orangefs_permission(struct user_namespace *mnt_userns,
+int orangefs_permission(struct mnt_idmap *idmap,
 			struct inode *inode, int mask);
 
 int orangefs_update_time(struct inode *, struct timespec64 *, int);
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index a25bb3453dde..defd4e231ad2 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -392,8 +392,8 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	 */
 	take_dentry_name_snapshot(&name, real);
 	/*
-	 * No mnt_userns handling here: it's an internal lookup.  Could skip
-	 * permission checking altogether, but for now just use non-mnt_userns
+	 * No idmap handling here: it's an internal lookup.  Could skip
+	 * permission checking altogether, but for now just use non-idmap
 	 * transformed ids.
 	 */
 	this = lookup_one_len(name.name.name, connected, name.name.len);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c9d0c362c7ef..f69d5740c3c4 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -42,6 +42,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 {
 	struct inode *realinode = d_inode(realpath->dentry);
 	struct inode *inode = file_inode(file);
+	struct mnt_idmap *real_idmap;
 	struct user_namespace *real_mnt_userns;
 	struct file *realfile;
 	const struct cred *old_cred;
@@ -53,8 +54,9 @@ static struct file *ovl_open_realfile(const struct file *file,
 		acc_mode |= MAY_APPEND;
 
 	old_cred = ovl_override_creds(inode->i_sb);
-	real_mnt_userns = mnt_user_ns(realpath->mnt);
-	err = inode_permission(real_mnt_userns, realinode, MAY_OPEN | acc_mode);
+	real_idmap = mnt_idmap(realpath->mnt);
+	real_mnt_userns = mnt_idmap_owner(real_idmap);
+	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
 	} else {
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index a41a03fcf6bc..d906cf073fba 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -278,7 +278,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return err;
 }
 
-int ovl_permission(struct user_namespace *mnt_userns,
+int ovl_permission(struct mnt_idmap *idmap,
 		   struct inode *inode, int mask)
 {
 	struct inode *upperinode = ovl_inode_upper(inode);
@@ -298,7 +298,7 @@ int ovl_permission(struct user_namespace *mnt_userns,
 	 * Check overlay inode with the creds of task and underlying inode
 	 * with creds of mounter
 	 */
-	err = generic_permission(&init_user_ns, inode, mask);
+	err = generic_permission(&nop_mnt_idmap, inode, mask);
 	if (err)
 		return err;
 
@@ -310,7 +310,7 @@ int ovl_permission(struct user_namespace *mnt_userns,
 		/* Make sure mounter can read file for copy up later */
 		mask |= MAY_READ;
 	}
-	err = inode_permission(mnt_user_ns(realpath.mnt), realinode, mask);
+	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
 	revert_creds(old_cred);
 
 	return err;
@@ -361,7 +361,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
 		old_cred = ovl_override_creds(dentry->d_sb);
-		err = vfs_getxattr(mnt_user_ns(realpath.mnt), realdentry, name, NULL, 0);
+		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
 		revert_creds(old_cred);
 		if (err < 0)
 			goto out_drop_write;
@@ -403,7 +403,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 
 	ovl_i_path_real(inode, &realpath);
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(mnt_user_ns(realpath.mnt), realpath.dentry, name, value, size);
+	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
 	revert_creds(old_cred);
 	return res;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 46753134533a..cfb3420b7df0 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -204,7 +204,7 @@ static struct dentry *ovl_lookup_positive_unlocked(struct ovl_lookup_data *d,
 						   struct dentry *base, int len,
 						   bool drop_negative)
 {
-	struct dentry *ret = lookup_one_unlocked(mnt_user_ns(d->mnt), name, base, len);
+	struct dentry *ret = lookup_one_unlocked(mnt_idmap(d->mnt), name, base, len);
 
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		if (drop_negative && ret->d_lockref.count == 1) {
@@ -711,7 +711,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_one_positive_unlocked(ovl_upper_mnt_userns(ofs), name.name,
+	index = lookup_one_positive_unlocked(ovl_upper_mnt_idmap(ofs), name.name,
 					     ofs->indexdir, name.len);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
@@ -1182,7 +1182,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 		struct dentry *this;
 		struct dentry *lowerdir = poe->lowerstack[i].dentry;
 
-		this = lookup_one_positive_unlocked(mnt_user_ns(poe->lowerstack[i].layer->mnt),
+		this = lookup_one_positive_unlocked(mnt_idmap(poe->lowerstack[i].layer->mnt),
 						   name->name, lowerdir, name->len);
 		if (IS_ERR(this)) {
 			switch (PTR_ERR(this)) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8091b1914ea3..4d0b278f5630 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -218,7 +218,7 @@ static inline ssize_t ovl_do_getxattr(const struct path *path, const char *name,
 
 	WARN_ON(path->dentry->d_sb != path->mnt->mnt_sb);
 
-	err = vfs_getxattr(mnt_user_ns(path->mnt), path->dentry,
+	err = vfs_getxattr(mnt_idmap(path->mnt), path->dentry,
 			       name, value, size);
 	len = (value && err > 0) ? err : 0;
 
@@ -252,7 +252,7 @@ static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				  const char *name, const void *value,
 				  size_t size, int flags)
 {
-	int err = vfs_setxattr(ovl_upper_mnt_userns(ofs), dentry, name,
+	int err = vfs_setxattr(ovl_upper_mnt_idmap(ofs), dentry, name,
 			       value, size, flags);
 
 	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, %d) = %i\n",
@@ -270,7 +270,7 @@ static inline int ovl_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 static inline int ovl_do_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 				     const char *name)
 {
-	int err = vfs_removexattr(ovl_upper_mnt_userns(ofs), dentry, name);
+	int err = vfs_removexattr(ovl_upper_mnt_idmap(ofs), dentry, name);
 	pr_debug("removexattr(%pd2, \"%s\") = %i\n", dentry, name, err);
 	return err;
 }
@@ -341,7 +341,7 @@ static inline struct dentry *ovl_lookup_upper(struct ovl_fs *ofs,
 					      const char *name,
 					      struct dentry *base, int len)
 {
-	return lookup_one(ovl_upper_mnt_userns(ofs), name, base, len);
+	return lookup_one(ovl_upper_mnt_idmap(ofs), name, base, len);
 }
 
 static inline bool ovl_open_flags_need_copy_up(int flags)
@@ -601,7 +601,7 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr);
 int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags);
-int ovl_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int ovl_permission(struct mnt_idmap *idmap, struct inode *inode,
 		   int mask);
 int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index a6a9235c6168..fd11fe6d6d45 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -90,11 +90,6 @@ static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
 	return ofs->layers[0].mnt;
 }
 
-static inline struct user_namespace *ovl_upper_mnt_userns(struct ovl_fs *ofs)
-{
-	return mnt_user_ns(ovl_upper_mnt(ofs));
-}
-
 static inline struct mnt_idmap *ovl_upper_mnt_idmap(struct ovl_fs *ofs)
 {
 	return mnt_idmap(ovl_upper_mnt(ofs));
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 8cd2b9947de1..b6952b21a7ee 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -278,7 +278,7 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 		while (rdd->first_maybe_whiteout) {
 			p = rdd->first_maybe_whiteout;
 			rdd->first_maybe_whiteout = p->next_maybe_whiteout;
-			dentry = lookup_one(mnt_user_ns(path->mnt), p->name, dir, p->len);
+			dentry = lookup_one(mnt_idmap(path->mnt), p->name, dir, p->len);
 			if (!IS_ERR(dentry)) {
 				p->is_whiteout = ovl_is_whiteout(dentry);
 				dput(dentry);
@@ -480,7 +480,7 @@ static int ovl_cache_update_ino(const struct path *path, struct ovl_cache_entry
 			goto get;
 		}
 	}
-	this = lookup_one(mnt_user_ns(path->mnt), p->name, dir, p->len);
+	this = lookup_one(mnt_idmap(path->mnt), p->name, dir, p->len);
 	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
 		/* Mark a stale entry */
 		p->is_whiteout = true;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index bde291623c8c..48a3c3fee1b6 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -491,7 +491,8 @@ bool ovl_is_whiteout(struct dentry *dentry)
 struct file *ovl_path_open(const struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	struct user_namespace *real_mnt_userns = mnt_user_ns(path->mnt);
+	struct mnt_idmap *real_idmap = mnt_idmap(path->mnt);
+	struct user_namespace *real_mnt_userns = mnt_idmap_owner(real_idmap);
 	int err, acc_mode;
 
 	if (flags & ~(O_ACCMODE | O_LARGEFILE))
@@ -508,7 +509,7 @@ struct file *ovl_path_open(const struct path *path, int flags)
 		BUG();
 	}
 
-	err = inode_permission(real_mnt_userns, inode, acc_mode | MAY_OPEN);
+	err = inode_permission(real_idmap, inode, acc_mode | MAY_OPEN);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 678b86ec2b4c..1cd8c01508b8 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1085,7 +1085,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * We only care about restrictions the inode struct itself places upon
 	 * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
 	 */
-	error = may_write_xattr(mnt_userns, inode);
+	error = may_write_xattr(idmap, inode);
 	if (error)
 		goto out_inode_unlock;
 
@@ -1197,7 +1197,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * We only care about restrictions the inode struct itself places upon
 	 * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
 	 */
-	error = may_write_xattr(mnt_userns, inode);
+	error = may_write_xattr(idmap, inode);
 	if (error)
 		goto out_inode_unlock;
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index aa7ebee00746..5e0e0ccd47aa 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -727,7 +727,7 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
 }
 
 
-static int proc_pid_permission(struct user_namespace *mnt_userns,
+static int proc_pid_permission(struct mnt_idmap *idmap,
 			       struct inode *inode, int mask)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
@@ -753,7 +753,7 @@ static int proc_pid_permission(struct user_namespace *mnt_userns,
 
 		return -EPERM;
 	}
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 
@@ -3557,7 +3557,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
  * This function makes sure that the node is always accessible for members of
  * same thread group.
  */
-static int proc_tid_comm_permission(struct user_namespace *mnt_userns,
+static int proc_tid_comm_permission(struct mnt_idmap *idmap,
 				    struct inode *inode, int mask)
 {
 	bool is_same_tgroup;
@@ -3577,7 +3577,7 @@ static int proc_tid_comm_permission(struct user_namespace *mnt_userns,
 		return 0;
 	}
 
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index d9bda34c770d..f516c1a68094 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -325,13 +325,13 @@ static struct dentry *proc_lookupfd(struct inode *dir, struct dentry *dentry,
  * /proc/pid/fd needs a special permission handler so that a process can still
  * access /proc/self/fd after it has executed a setuid().
  */
-int proc_fd_permission(struct user_namespace *mnt_userns,
+int proc_fd_permission(struct mnt_idmap *idmap,
 		       struct inode *inode, int mask)
 {
 	struct task_struct *p;
 	int rv;
 
-	rv = generic_permission(&init_user_ns, inode, mask);
+	rv = generic_permission(&nop_mnt_idmap, inode, mask);
 	if (rv == 0)
 		return rv;
 
diff --git a/fs/proc/fd.h b/fs/proc/fd.h
index c5a921a06a0b..7e7265f7e06f 100644
--- a/fs/proc/fd.h
+++ b/fs/proc/fd.h
@@ -10,7 +10,7 @@ extern const struct inode_operations proc_fd_inode_operations;
 extern const struct file_operations proc_fdinfo_operations;
 extern const struct inode_operations proc_fdinfo_inode_operations;
 
-extern int proc_fd_permission(struct user_namespace *mnt_userns,
+extern int proc_fd_permission(struct mnt_idmap *idmap,
 			      struct inode *inode, int mask);
 
 static inline unsigned int proc_fd(struct inode *inode)
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7d111c46ca75..e89bd8f1368b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -798,7 +798,7 @@ static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 }
 
-static int proc_sys_permission(struct user_namespace *mnt_userns,
+static int proc_sys_permission(struct mnt_idmap *idmap,
 			       struct inode *inode, int mask)
 {
 	/*
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index f4300c73a192..06d810c72c52 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -941,7 +941,7 @@ static int xattr_mount_check(struct super_block *s)
 	return 0;
 }
 
-int reiserfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
+int reiserfs_permission(struct mnt_idmap *idmap, struct inode *inode,
 			int mask)
 {
 	/*
@@ -951,7 +951,7 @@ int reiserfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 	if (IS_PRIVATE(inode))
 		return 0;
 
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 static int xattr_hide_revalidate(struct dentry *dentry, unsigned int flags)
diff --git a/fs/reiserfs/xattr.h b/fs/reiserfs/xattr.h
index e47fde1182de..5868a4e990e3 100644
--- a/fs/reiserfs/xattr.h
+++ b/fs/reiserfs/xattr.h
@@ -16,7 +16,7 @@ int reiserfs_xattr_init(struct super_block *sb, int mount_flags);
 int reiserfs_lookup_privroot(struct super_block *sb);
 int reiserfs_delete_xattrs(struct inode *inode);
 int reiserfs_chown_xattrs(struct inode *inode, struct iattr *attrs);
-int reiserfs_permission(struct user_namespace *mnt_userns,
+int reiserfs_permission(struct mnt_idmap *idmap,
 			struct inode *inode, int mask);
 
 #ifdef CONFIG_REISERFS_FS_XATTR
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 41f60477bb41..87e5a47bee09 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -419,7 +419,8 @@ EXPORT_SYMBOL(vfs_clone_file_range);
 /* Check whether we are allowed to dedupe the destination file */
 static bool allow_file_dedupe(struct file *file)
 {
-	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = file_inode(file);
 
 	if (capable(CAP_SYS_ADMIN))
@@ -428,7 +429,7 @@ static bool allow_file_dedupe(struct file *file)
 		return true;
 	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), current_fsuid()))
 		return true;
-	if (!inode_permission(mnt_userns, inode, MAY_WRITE))
+	if (!inode_permission(idmap, inode, MAY_WRITE))
 		return true;
 	return false;
 }
diff --git a/fs/xattr.c b/fs/xattr.c
index e69a2935ef58..d056d9ac247a 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -82,7 +82,7 @@ xattr_resolve_name(struct inode *inode, const char **name)
 
 /**
  * may_write_xattr - check whether inode allows writing xattr
- * @mnt_userns:	User namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: the inode on which to set an xattr
  *
  * Check whether the inode allows writing xattrs. Specifically, we can never
@@ -94,13 +94,13 @@ xattr_resolve_name(struct inode *inode, const char **name)
  *
  * Return: On success zero is returned. On error a negative errno is returned.
  */
-int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode)
+int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode)
 {
 	if (IS_IMMUTABLE(inode))
 		return -EPERM;
 	if (IS_APPEND(inode))
 		return -EPERM;
-	if (HAS_UNMAPPED_ID(mnt_userns, inode))
+	if (HAS_UNMAPPED_ID(idmap, inode))
 		return -EPERM;
 	return 0;
 }
@@ -110,13 +110,15 @@ int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode)
  * because different namespaces have very different rules.
  */
 static int
-xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
+xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 		 const char *name, int mask)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	if (mask & MAY_WRITE) {
 		int ret;
 
-		ret = may_write_xattr(mnt_userns, inode);
+		ret = may_write_xattr(idmap, inode);
 		if (ret)
 			return ret;
 	}
@@ -152,7 +154,7 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
 			return -EPERM;
 	}
 
-	return inode_permission(mnt_userns, inode, mask);
+	return inode_permission(idmap, inode, mask);
 }
 
 /*
@@ -264,7 +266,7 @@ int __vfs_setxattr_noperm(struct user_namespace *mnt_userns,
  * __vfs_setxattr_locked - set an extended attribute while holding the inode
  * lock
  *
- *  @mnt_userns: user namespace of the mount of the target inode
+ *  @idmap: idmap of the mount of the target inode
  *  @dentry: object to perform setxattr on
  *  @name: xattr name to set
  *  @value: value to set @name to
@@ -274,14 +276,15 @@ int __vfs_setxattr_noperm(struct user_namespace *mnt_userns,
  *  a delegation was broken on, NULL if none.
  */
 int
-__vfs_setxattr_locked(struct user_namespace *mnt_userns, struct dentry *dentry,
+__vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *name, const void *value, size_t size,
 		      int flags, struct inode **delegated_inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(mnt_userns, inode, name, MAY_WRITE);
+	error = xattr_permission(idmap, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -303,9 +306,10 @@ __vfs_setxattr_locked(struct user_namespace *mnt_userns, struct dentry *dentry,
 EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
 
 int
-vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	     const char *name, const void *value, size_t size, int flags)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	const void  *orig_value = value;
@@ -320,7 +324,7 @@ vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_setxattr_locked(mnt_userns, dentry, name, value, size,
+	error = __vfs_setxattr_locked(idmap, dentry, name, value, size,
 				      flags, &delegated_inode);
 	inode_unlock(inode);
 
@@ -337,19 +341,19 @@ vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 EXPORT_SYMBOL_GPL(vfs_setxattr);
 
 static ssize_t
-xattr_getsecurity(struct user_namespace *mnt_userns, struct inode *inode,
+xattr_getsecurity(struct mnt_idmap *idmap, struct inode *inode,
 		  const char *name, void *value, size_t size)
 {
 	void *buffer = NULL;
 	ssize_t len;
 
 	if (!value || !size) {
-		len = security_inode_getsecurity(mnt_userns, inode, name,
+		len = security_inode_getsecurity(idmap, inode, name,
 						 &buffer, false);
 		goto out_noalloc;
 	}
 
-	len = security_inode_getsecurity(mnt_userns, inode, name, &buffer,
+	len = security_inode_getsecurity(idmap, inode, name, &buffer,
 					 true);
 	if (len < 0)
 		return len;
@@ -374,7 +378,7 @@ xattr_getsecurity(struct user_namespace *mnt_userns, struct inode *inode,
  * Returns the result of alloc, if failed, or the getxattr operation.
  */
 int
-vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
+vfs_getxattr_alloc(struct mnt_idmap *idmap, struct dentry *dentry,
 		   const char *name, char **xattr_value, size_t xattr_size,
 		   gfp_t flags)
 {
@@ -383,7 +387,7 @@ vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
 	char *value = *xattr_value;
 	int error;
 
-	error = xattr_permission(mnt_userns, inode, name, MAY_READ);
+	error = xattr_permission(idmap, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -427,13 +431,13 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 EXPORT_SYMBOL(__vfs_getxattr);
 
 ssize_t
-vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+vfs_getxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	     const char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(mnt_userns, inode, name, MAY_READ);
+	error = xattr_permission(idmap, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -444,7 +448,7 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!strncmp(name, XATTR_SECURITY_PREFIX,
 				XATTR_SECURITY_PREFIX_LEN)) {
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
-		int ret = xattr_getsecurity(mnt_userns, inode, suffix, value,
+		int ret = xattr_getsecurity(idmap, inode, suffix, value,
 					    size);
 		/*
 		 * Only overwrite the return value if a security module
@@ -503,21 +507,22 @@ EXPORT_SYMBOL(__vfs_removexattr);
  * __vfs_removexattr_locked - set an extended attribute while holding the inode
  * lock
  *
- *  @mnt_userns: user namespace of the mount of the target inode
+ *  @idmap: idmap of the mount of the target inode
  *  @dentry: object to perform setxattr on
  *  @name: name of xattr to remove
  *  @delegated_inode: on return, will contain an inode pointer that
  *  a delegation was broken on, NULL if none.
  */
 int
-__vfs_removexattr_locked(struct user_namespace *mnt_userns,
+__vfs_removexattr_locked(struct mnt_idmap *idmap,
 			 struct dentry *dentry, const char *name,
 			 struct inode **delegated_inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(mnt_userns, inode, name, MAY_WRITE);
+	error = xattr_permission(idmap, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -542,7 +547,7 @@ __vfs_removexattr_locked(struct user_namespace *mnt_userns,
 EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
 
 int
-vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		const char *name)
 {
 	struct inode *inode = dentry->d_inode;
@@ -551,7 +556,7 @@ vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_removexattr_locked(mnt_userns, dentry,
+	error = __vfs_removexattr_locked(idmap, dentry,
 					 name, &delegated_inode);
 	inode_unlock(inode);
 
@@ -605,7 +610,7 @@ int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return do_set_acl(idmap, dentry, ctx->kname->name,
 				  ctx->kvalue, ctx->size);
 
-	return vfs_setxattr(mnt_idmap_owner(idmap), dentry, ctx->kname->name,
+	return vfs_setxattr(idmap, dentry, ctx->kname->name,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
 
@@ -714,8 +719,7 @@ do_getxattr(struct mnt_idmap *idmap, struct dentry *d,
 	if (is_posix_acl_xattr(ctx->kname->name))
 		error = do_get_acl(idmap, d, kname, ctx->kvalue, ctx->size);
 	else
-		error = vfs_getxattr(mnt_idmap_owner(idmap), d, kname,
-				     ctx->kvalue, ctx->size);
+		error = vfs_getxattr(idmap, d, kname, ctx->kvalue, ctx->size);
 	if (error > 0) {
 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
 			error = -EFAULT;
@@ -894,7 +898,7 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
 	if (is_posix_acl_xattr(kname))
 		return vfs_remove_acl(idmap, d, kname);
 
-	return vfs_removexattr(mnt_idmap_owner(idmap), d, kname);
+	return vfs_removexattr(idmap, d, kname);
 }
 
 static int path_removexattr(const char __user *pathname,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 349f71650fa2..635ce7a7740f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1766,18 +1766,19 @@ static inline void inode_fsgid_set(struct inode *inode,
 /**
  * fsuidgid_has_mapping() - check whether caller's fsuid/fsgid is mapped
  * @sb: the superblock we want a mapping in
- * @mnt_userns: user namespace of the relevant mount
+ * @idmap: idmap of the relevant mount
  *
  * Check whether the caller's fsuid and fsgid have a valid mapping in the
  * s_user_ns of the superblock @sb. If the caller is on an idmapped mount map
- * the caller's fsuid and fsgid according to the @mnt_userns first.
+ * the caller's fsuid and fsgid according to the @idmap first.
  *
  * Return: true if fsuid and fsgid is mapped, false if not.
  */
 static inline bool fsuidgid_has_mapping(struct super_block *sb,
-					struct user_namespace *mnt_userns)
+					struct mnt_idmap *idmap)
 {
 	struct user_namespace *fs_userns = sb->s_user_ns;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	kuid_t kuid;
 	kgid_t kgid;
 
@@ -2134,7 +2135,7 @@ struct file_operations {
 struct inode_operations {
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
-	int (*permission) (struct user_namespace *, struct inode *, int);
+	int (*permission) (struct mnt_idmap *, struct inode *, int);
 	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
 
 	int (*readlink) (struct dentry *, char __user *,int);
@@ -2322,9 +2323,11 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
 
-static inline bool HAS_UNMAPPED_ID(struct user_namespace *mnt_userns,
+static inline bool HAS_UNMAPPED_ID(struct mnt_idmap *idmap,
 				   struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	return !vfsuid_valid(i_uid_into_vfsuid(mnt_userns, inode)) ||
 	       !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode));
 }
@@ -2902,16 +2905,16 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 
 int notify_change(struct mnt_idmap *, struct dentry *,
 		  struct iattr *, struct inode **);
-int inode_permission(struct user_namespace *, struct inode *, int);
-int generic_permission(struct user_namespace *, struct inode *, int);
+int inode_permission(struct mnt_idmap *, struct inode *, int);
+int generic_permission(struct mnt_idmap *, struct inode *, int);
 static inline int file_permission(struct file *file, int mask)
 {
-	return inode_permission(file_mnt_user_ns(file),
+	return inode_permission(file_mnt_idmap(file),
 				file_inode(file), mask);
 }
 static inline int path_permission(const struct path *path, int mask)
 {
-	return inode_permission(mnt_user_ns(path->mnt),
+	return inode_permission(mnt_idmap(path->mnt),
 				d_inode(path->dentry), mask);
 }
 int __check_sticky(struct user_namespace *mnt_userns, struct inode *dir,
@@ -3365,7 +3368,7 @@ extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
-int may_setattr(struct user_namespace *mnt_userns, struct inode *inode,
+int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);
 extern int inode_newsize_ok(const struct inode *, loff_t offset);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ed6cb2ac55fa..894f233083e3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -154,7 +154,7 @@ LSM_HOOK(int, 0, inode_remove_acl, struct user_namespace *mnt_userns,
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct user_namespace *mnt_userns,
 	 struct dentry *dentry)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct user_namespace *mnt_userns,
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
 	 struct inode *inode, const char *name, void **buffer, bool alloc)
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 00fee52df842..0d4531fd46e7 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -68,11 +68,11 @@ extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
-struct dentry *lookup_one(struct user_namespace *, const char *, struct dentry *, int);
-struct dentry *lookup_one_unlocked(struct user_namespace *mnt_userns,
+struct dentry *lookup_one(struct mnt_idmap *, const char *, struct dentry *, int);
+struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 				   const char *name, struct dentry *base,
 				   int len);
-struct dentry *lookup_one_positive_unlocked(struct user_namespace *mnt_userns,
+struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    const char *name,
 					    struct dentry *base, int len);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0cd89ebd4bb6..d6c119e31d7a 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -396,7 +396,7 @@ extern int nfs_getattr(struct mnt_idmap *, const struct path *,
 		       struct kstat *, u32, unsigned int);
 extern void nfs_access_add_cache(struct inode *, struct nfs_access_entry *, const struct cred *);
 extern void nfs_access_set_mask(struct nfs_access_entry *, u32);
-extern int nfs_permission(struct user_namespace *, struct inode *, int);
+extern int nfs_permission(struct mnt_idmap *, struct inode *, int);
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_attribute_cache_expired(struct inode *inode);
 extern int nfs_revalidate_inode(struct inode *inode, unsigned long flags);
diff --git a/include/linux/security.h b/include/linux/security.h
index 1ba1f4e70b50..d9cd7b2d16a2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -158,7 +158,7 @@ int cap_inode_removexattr(struct user_namespace *mnt_userns,
 int cap_inode_need_killpriv(struct dentry *dentry);
 int cap_inode_killpriv(struct user_namespace *mnt_userns,
 		       struct dentry *dentry);
-int cap_inode_getsecurity(struct user_namespace *mnt_userns,
+int cap_inode_getsecurity(struct mnt_idmap *idmap,
 			  struct inode *inode, const char *name, void **buffer,
 			  bool alloc);
 extern int cap_mmap_addr(unsigned long addr);
@@ -378,7 +378,7 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct user_namespace *mnt_userns,
 			    struct dentry *dentry);
-int security_inode_getsecurity(struct user_namespace *mnt_userns,
+int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
@@ -936,12 +936,12 @@ static inline int security_inode_killpriv(struct user_namespace *mnt_userns,
 	return cap_inode_killpriv(mnt_userns, dentry);
 }
 
-static inline int security_inode_getsecurity(struct user_namespace *mnt_userns,
+static inline int security_inode_getsecurity(struct mnt_idmap *idmap,
 					     struct inode *inode,
 					     const char *name, void **buffer,
 					     bool alloc)
 {
-	return cap_inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
+	return cap_inode_getsecurity(idmap, inode, name, buffer, alloc);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 2e7dd44926e4..b39d156e0098 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -56,25 +56,25 @@ struct xattr {
 };
 
 ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
-ssize_t vfs_getxattr(struct user_namespace *, struct dentry *, const char *,
+ssize_t vfs_getxattr(struct mnt_idmap *, struct dentry *, const char *,
 		     void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int __vfs_setxattr(struct user_namespace *, struct dentry *, struct inode *,
 		   const char *, const void *, size_t, int);
 int __vfs_setxattr_noperm(struct user_namespace *, struct dentry *,
 			  const char *, const void *, size_t, int);
-int __vfs_setxattr_locked(struct user_namespace *, struct dentry *,
+int __vfs_setxattr_locked(struct mnt_idmap *, struct dentry *,
 			  const char *, const void *, size_t, int,
 			  struct inode **);
-int vfs_setxattr(struct user_namespace *, struct dentry *, const char *,
+int vfs_setxattr(struct mnt_idmap *, struct dentry *, const char *,
 		 const void *, size_t, int);
 int __vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
-int __vfs_removexattr_locked(struct user_namespace *, struct dentry *,
+int __vfs_removexattr_locked(struct mnt_idmap *, struct dentry *,
 			     const char *, struct inode **);
-int vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
+int vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
-int vfs_getxattr_alloc(struct user_namespace *mnt_userns,
+int vfs_getxattr_alloc(struct mnt_idmap *idmap,
 		       struct dentry *dentry, const char *name,
 		       char **xattr_value, size_t size, gfp_t flags);
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 0031bd0337b2..0160e9f2b07c 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -887,7 +887,7 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
 	if ((oflag & O_ACCMODE) == (O_RDWR | O_WRONLY))
 		return -EINVAL;
 	acc = oflag2acc[oflag & O_ACCMODE];
-	return inode_permission(&init_user_ns, d_inode(dentry), acc);
+	return inode_permission(&nop_mnt_idmap, d_inode(dentry), acc);
 }
 
 static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index d7d14ce2a031..d4fa74bdf80c 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -559,7 +559,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
 static struct bpf_prog *__get_prog_inode(struct inode *inode, enum bpf_prog_type type)
 {
 	struct bpf_prog *prog;
-	int ret = inode_permission(&init_user_ns, inode, MAY_READ);
+	int ret = inode_permission(&nop_mnt_idmap, inode, MAY_READ);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c099cf3fa02d..935e8121b21e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5065,7 +5065,7 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
 	if (!inode)
 		return -ENOMEM;
 
-	ret = inode_permission(&init_user_ns, inode, MAY_WRITE);
+	ret = inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
 	iput(inode);
 	return ret;
 }
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 6dd3cc5309bf..a8da32fecbe7 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -313,7 +313,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 	d = bprm->file->f_path.dentry;
 
 	for (i = 0; i < attach->xattr_count; i++) {
-		size = vfs_getxattr_alloc(&init_user_ns, d, attach->xattrs[i],
+		size = vfs_getxattr_alloc(&nop_mnt_idmap, d, attach->xattrs[i],
 					  &value, value_size, GFP_KERNEL);
 		if (size >= 0) {
 			u32 index, perm;
diff --git a/security/commoncap.c b/security/commoncap.c
index 1164278b97fd..01b68f9311ca 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -377,7 +377,7 @@ static bool is_v3header(int size, const struct vfs_cap_data *cap)
  * by the integrity subsystem, which really wants the unconverted values -
  * so that's good.
  */
-int cap_inode_getsecurity(struct user_namespace *mnt_userns,
+int cap_inode_getsecurity(struct mnt_idmap *idmap,
 			  struct inode *inode, const char *name, void **buffer,
 			  bool alloc)
 {
@@ -391,6 +391,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 	struct vfs_ns_cap_data *nscap = NULL;
 	struct dentry *dentry;
 	struct user_namespace *fs_ns;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (strcmp(name, "capability") != 0)
 		return -EOPNOTSUPP;
@@ -398,7 +399,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 	dentry = d_find_any_alias(inode);
 	if (!dentry)
 		return -EINVAL;
-	size = vfs_getxattr_alloc(mnt_userns, dentry, XATTR_NAME_CAPS, &tmpbuf,
+	size = vfs_getxattr_alloc(idmap, dentry, XATTR_NAME_CAPS, &tmpbuf,
 				  sizeof(struct vfs_ns_cap_data), GFP_NOFS);
 	dput(dentry);
 	/* gcc11 complains if we don't check for !tmpbuf */
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index fa5ff13fa8c9..b202edc2ff65 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -265,7 +265,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 						    req_xattr_value_len);
 			continue;
 		}
-		size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr->name,
+		size = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
 					  &xattr_value, xattr_size, GFP_NOFS);
 		if (size == -ENOMEM) {
 			error = -ENOMEM;
@@ -274,7 +274,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (size < 0)
 			continue;
 
-		user_space_size = vfs_getxattr(&init_user_ns, dentry,
+		user_space_size = vfs_getxattr(&nop_mnt_idmap, dentry,
 					       xattr->name, NULL, 0);
 		if (user_space_size != size)
 			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
@@ -331,7 +331,7 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 		return 1;
 
 	/* Do this the hard way */
-	rc = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_EVM,
+	rc = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, XATTR_NAME_EVM,
 				(char **)&xattr_data, 0, GFP_NOFS);
 	if (rc <= 0) {
 		if (rc == -ENODATA)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index e5a6a3bb1209..45bcd08a9224 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -184,7 +184,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* if status is not PASS, try to check again - against -ENOMEM */
 
 	/* first need to know the sig type */
-	rc = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_EVM,
+	rc = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, XATTR_NAME_EVM,
 				(char **)&xattr_data, 0, GFP_NOFS);
 	if (rc <= 0) {
 		evm_status = INTEGRITY_FAIL;
@@ -453,7 +453,7 @@ static int evm_xattr_change(struct user_namespace *mnt_userns,
 	char *xattr_data = NULL;
 	int rc = 0;
 
-	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name, &xattr_data,
+	rc = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr_name, &xattr_data,
 				0, GFP_NOFS);
 	if (rc < 0) {
 		rc = 1;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ee6f7e237f2e..734a6818a545 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -225,7 +225,7 @@ int ima_read_xattr(struct dentry *dentry,
 {
 	int ret;
 
-	ret = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_IMA,
+	ret = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, XATTR_NAME_IMA,
 				 (char **)xattr_value, xattr_len, GFP_NOFS);
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 4564faae7d67..6cd0add524cd 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -598,7 +598,7 @@ int ima_eventevmsig_init(struct ima_event_data *event_data,
 	if (!event_data->file)
 		return 0;
 
-	rc = vfs_getxattr_alloc(&init_user_ns, file_dentry(event_data->file),
+	rc = vfs_getxattr_alloc(&nop_mnt_idmap, file_dentry(event_data->file),
 				XATTR_NAME_EVM, (char **)&xattr_data, 0,
 				GFP_NOFS);
 	if (rc <= 0 || xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
diff --git a/security/security.c b/security/security.c
index fceab8e0ff87..df7182fb1291 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1498,7 +1498,7 @@ int security_inode_killpriv(struct user_namespace *mnt_userns,
 	return call_int_hook(inode_killpriv, 0, mnt_userns, dentry);
 }
 
-int security_inode_getsecurity(struct user_namespace *mnt_userns,
+int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc)
 {
@@ -1511,7 +1511,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
+		rc = hp->hook.inode_getsecurity(idmap, inode, name, buffer, alloc);
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a9199..a32a814a694d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3383,7 +3383,7 @@ static int selinux_path_notify(const struct path *path, u64 mask,
  *
  * Permission check is handled by selinux_inode_getxattr hook.
  */
-static int selinux_inode_getsecurity(struct user_namespace *mnt_userns,
+static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 				     struct inode *inode, const char *name,
 				     void **buffer, bool alloc)
 {
@@ -6595,7 +6595,7 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
 	int len = 0;
-	len = selinux_inode_getsecurity(&init_user_ns, inode,
+	len = selinux_inode_getsecurity(&nop_mnt_idmap, inode,
 					XATTR_SELINUX_SUFFIX, ctx, true);
 	if (len < 0)
 		return len;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9a82a15685d1..15983032220a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1462,7 +1462,7 @@ static int smack_inode_remove_acl(struct user_namespace *mnt_userns,
 
 /**
  * smack_inode_getsecurity - get smack xattrs
- * @mnt_userns: active user namespace
+ * @idmap: idmap of the mount
  * @inode: the object
  * @name: attribute name
  * @buffer: where to put the result
@@ -1470,7 +1470,7 @@ static int smack_inode_remove_acl(struct user_namespace *mnt_userns,
  *
  * Returns the size of the attribute or an error code
  */
-static int smack_inode_getsecurity(struct user_namespace *mnt_userns,
+static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 				   struct inode *inode, const char *name,
 				   void **buffer, bool alloc)
 {

-- 
2.34.1

