Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E446466961D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbjAMLx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbjAMLw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50EFCC7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D0C3616A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6750CC433F1;
        Fri, 13 Jan 2023 11:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610608;
        bh=MCYSXj9w6VgO6DVaUyMXRdk9xhINsH6u0bj2YHXorUA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=foGI73WdWpsgAbmnu9GBTBsExbH1TCBP/CvDbVj9Qb72V3wKQYEpGPF8CEpa4XKI7
         5QEBR5tsQ9eEcc0Uo8+R4JfOjYNXidAQf7hJY3x2txP/aroSVaHUCpuVCEihqWYRSV
         lXenep5VnB0cv0pdVvOspfKF7Tw2pVRk9vdol2zTkpfJb8PyazjPGxVIBUkvb2xVBc
         uHFt9zO0ObV+Vb9SjlLFN/9bwKebaC/zMf1FYB/YwpVMEQUaXWxWiUg2/Z13s1lhQm
         oOZXfpAFB/cMKDZWwzBUeUnK8UX9yo9A3gl+3GP6UHWUCpKi988M7RBJ0S3bfECPyZ
         jSJCymX8l8T0Q==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:24 +0100
Subject: [PATCH 16/25] fs: port acl to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-16-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=43490; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MCYSXj9w6VgO6DVaUyMXRdk9xhINsH6u0bj2YHXorUA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2O0cz+NO9wtN9GlYXaH9smr7Vfsqx9alUNR6vGVJvl
 a/du6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiImxkjQ9uSyPqfua+bqvWC9Nyen1
 HjiY/fZMsoKbV02ef23rcWNxgZfjbOn/Nqr/dLp9Pt0a82azz9935n8M9HTTrSP2LcNvMvYgUA
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
 fs/9p/acl.c                           |  2 +-
 fs/btrfs/acl.c                        |  3 +--
 fs/ceph/acl.c                         |  2 +-
 fs/ext2/acl.c                         |  2 +-
 fs/ext4/acl.c                         |  3 +--
 fs/gfs2/acl.c                         |  2 +-
 fs/jffs2/acl.c                        |  2 +-
 fs/jfs/acl.c                          |  2 +-
 fs/namei.c                            | 33 ++++++++++++++++----------------
 fs/ntfs3/inode.c                      |  5 +++--
 fs/ntfs3/namei.c                      | 18 +++++++-----------
 fs/ntfs3/ntfs_fs.h                    |  4 ++--
 fs/ntfs3/xattr.c                      | 14 ++++++--------
 fs/ocfs2/acl.c                        |  2 +-
 fs/orangefs/acl.c                     |  2 +-
 fs/posix_acl.c                        | 36 +++++++++++++++++------------------
 fs/reiserfs/xattr_acl.c               |  2 +-
 fs/xfs/xfs_acl.c                      |  3 +--
 include/linux/evm.h                   | 14 +++++++-------
 include/linux/ima.h                   | 10 +++++-----
 include/linux/lsm_hook_defs.h         |  6 +++---
 include/linux/posix_acl.h             |  4 ++--
 include/linux/security.h              | 12 ++++++------
 security/integrity/evm/evm_main.c     | 12 ++++++------
 security/integrity/ima/ima_appraise.c |  2 +-
 security/security.c                   | 20 +++++++++----------
 security/selinux/hooks.c              |  6 +++---
 security/smack/smack_lsm.c            | 12 ++++++------
 28 files changed, 114 insertions(+), 121 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index ae278016ae95..33036305b4fd 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -206,7 +206,7 @@ int v9fs_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			struct iattr iattr = {};
 			struct posix_acl *acl_mode = acl;
 
-			retval = posix_acl_update_mode(&init_user_ns, inode,
+			retval = posix_acl_update_mode(&nop_mnt_idmap, inode,
 						       &iattr.ia_mode,
 						       &acl_mode);
 			if (retval)
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index 7a3ab7e4b163..7427449a04a3 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -114,12 +114,11 @@ int btrfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct posix_acl *acl, int type)
 {
 	int ret;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	umode_t old_mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		ret = posix_acl_update_mode(mnt_userns, inode,
+		ret = posix_acl_update_mode(idmap, inode,
 					    &inode->i_mode, &acl);
 		if (ret)
 			return ret;
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 59a05fd259f0..6945a938d396 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -105,7 +105,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(&init_user_ns, inode,
+			ret = posix_acl_update_mode(&nop_mnt_idmap, inode,
 						    &new_mode, &acl);
 			if (ret)
 				goto out;
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index f20953c7ec65..82b17d7fc93f 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -228,7 +228,7 @@ ext2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		error = posix_acl_update_mode(&init_user_ns, inode, &mode,
+		error = posix_acl_update_mode(&nop_mnt_idmap, inode, &mode,
 					      &acl);
 		if (error)
 			return error;
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 05139feb7282..27fcbddfb148 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -228,7 +228,6 @@ int
 ext4_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	     struct posix_acl *acl, int type)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	int error, credits, retries = 0;
 	size_t acl_size = acl ? ext4_acl_size(acl->a_count) : 0;
@@ -250,7 +249,7 @@ ext4_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		return PTR_ERR(handle);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
-		error = posix_acl_update_mode(mnt_userns, inode, &mode, &acl);
+		error = posix_acl_update_mode(idmap, inode, &mode, &acl);
 		if (error)
 			goto out_stop;
 		if (mode != inode->i_mode)
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index e2a79d7e5605..a392aa0f041d 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -135,7 +135,7 @@ int gfs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	mode = inode->i_mode;
 	if (type == ACL_TYPE_ACCESS && acl) {
-		ret = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
+		ret = posix_acl_update_mode(&nop_mnt_idmap, inode, &mode, &acl);
 		if (ret)
 			goto unlock;
 	}
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 672eaf51a66d..888a7ceb6479 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -241,7 +241,7 @@ int jffs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (acl) {
 			umode_t mode;
 
-			rc = posix_acl_update_mode(&init_user_ns, inode, &mode,
+			rc = posix_acl_update_mode(&nop_mnt_idmap, inode, &mode,
 						   &acl);
 			if (rc)
 				return rc;
diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 25b78dd82099..fb96f872d207 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -106,7 +106,7 @@ int jfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	tid = txBegin(inode->i_sb, 0);
 	mutex_lock(&JFS_IP(inode)->commit_mutex);
 	if (type == ACL_TYPE_ACCESS && acl) {
-		rc = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
+		rc = posix_acl_update_mode(&nop_mnt_idmap, inode, &mode, &acl);
 		if (rc)
 			goto end_tx;
 		if (mode != inode->i_mode)
diff --git a/fs/namei.c b/fs/namei.c
index a88017266ee5..637f8bee7132 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -273,7 +273,7 @@ void putname(struct filename *name)
 
 /**
  * check_acl - perform ACL permission checking
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:	inode to check permissions on
  * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC ...)
  *
@@ -281,13 +281,13 @@ void putname(struct filename *name)
  * retrieve POSIX acls it needs to know whether it is called from a blocking or
  * non-blocking context and thus cares about the MAY_NOT_BLOCK bit.
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
-static int check_acl(struct user_namespace *mnt_userns,
+static int check_acl(struct mnt_idmap *idmap,
 		     struct inode *inode, int mask)
 {
 #ifdef CONFIG_FS_POSIX_ACL
@@ -300,14 +300,14 @@ static int check_acl(struct user_namespace *mnt_userns,
 		/* no ->get_inode_acl() calls in RCU mode... */
 		if (is_uncached_acl(acl))
 			return -ECHILD;
-	        return posix_acl_permission(mnt_userns, inode, acl, mask);
+	        return posix_acl_permission(idmap, inode, acl, mask);
 	}
 
 	acl = get_inode_acl(inode, ACL_TYPE_ACCESS);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl) {
-	        int error = posix_acl_permission(mnt_userns, inode, acl, mask);
+	        int error = posix_acl_permission(idmap, inode, acl, mask);
 	        posix_acl_release(acl);
 	        return error;
 	}
@@ -318,7 +318,7 @@ static int check_acl(struct user_namespace *mnt_userns,
 
 /**
  * acl_permission_check - perform basic UNIX permission checking
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @inode:	inode to check permissions on
  * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC ...)
  *
@@ -326,15 +326,16 @@ static int check_acl(struct user_namespace *mnt_userns,
  * function may retrieve POSIX acls it needs to know whether it is called from a
  * blocking or non-blocking context and thus cares about the MAY_NOT_BLOCK bit.
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
-static int acl_permission_check(struct user_namespace *mnt_userns,
+static int acl_permission_check(struct mnt_idmap *idmap,
 				struct inode *inode, int mask)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	unsigned int mode = inode->i_mode;
 	vfsuid_t vfsuid;
 
@@ -348,7 +349,7 @@ static int acl_permission_check(struct user_namespace *mnt_userns,
 
 	/* Do we have ACL's? */
 	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
-		int error = check_acl(mnt_userns, inode, mask);
+		int error = check_acl(idmap, inode, mask);
 		if (error != -EAGAIN)
 			return error;
 	}
@@ -402,7 +403,7 @@ int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
 	/*
 	 * Do the basic permission checks.
 	 */
-	ret = acl_permission_check(mnt_userns, inode, mask);
+	ret = acl_permission_check(idmap, inode, mask);
 	if (ret != -EACCES)
 		return ret;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 20b953871574..2a9347e747e5 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1185,13 +1185,14 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
  * 
  * NOTE: if fnd != NULL (ntfs_atomic_open) then @dir is locked
  */
-struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
+struct inode *ntfs_create_inode(struct mnt_idmap *idmap,
 				struct inode *dir, struct dentry *dentry,
 				const struct cpu_str *uni, umode_t mode,
 				dev_t dev, const char *symname, u32 size,
 				struct ntfs_fnd *fnd)
 {
 	int err;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	const struct qstr *name = &dentry->d_name;
@@ -1614,7 +1615,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
 	if (!S_ISLNK(mode) && (sb->s_flags & SB_POSIXACL)) {
-		err = ntfs_init_acl(mnt_userns, inode, dir);
+		err = ntfs_init_acl(idmap, inode, dir);
 		if (err)
 			goto out7;
 	} else
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 13731de39010..407fe92394e2 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -97,10 +97,9 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFREG | mode,
+	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode,
 				  0, NULL, 0, NULL);
 
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
@@ -114,10 +113,9 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, mode, rdev,
+	inode = ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev,
 				  NULL, 0, NULL);
 
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
@@ -188,11 +186,10 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	u32 size = strlen(symname);
 	struct inode *inode;
 
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFLNK | 0777,
+	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777,
 				  0, symname, size, NULL);
 
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
@@ -204,10 +201,9 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 static int ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFDIR | mode,
+	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode,
 				  0, NULL, 0, NULL);
 
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
@@ -419,13 +415,13 @@ static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
 
 	/*
 	 * Unfortunately I don't know how to get here correct 'struct nameidata *nd'
-	 * or 'struct user_namespace *mnt_userns'.
+	 * or 'struct mnt_idmap *idmap'.
 	 * See atomic_open in fs/namei.c.
 	 * This is why xfstest/633 failed.
-	 * Looks like ntfs_atomic_open must accept 'struct user_namespace *mnt_userns' as argument.
+	 * Looks like ntfs_atomic_open must accept 'struct mnt_idmap *idmap' as argument.
 	 */
 
-	inode = ntfs_create_inode(&init_user_ns, dir, dentry, uni, mode, 0,
+	inode = ntfs_create_inode(&nop_mnt_idmap, dir, dentry, uni, mode, 0,
 				  NULL, 0, fnd);
 	err = IS_ERR(inode) ? PTR_ERR(inode)
 			    : finish_open(file, dentry, ntfs_file_open);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 9b649a5b6beb..80072e5f96f7 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -708,7 +708,7 @@ int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2);
 int inode_write_data(struct inode *inode, const void *data, size_t bytes);
-struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
+struct inode *ntfs_create_inode(struct mnt_idmap *idmap,
 				struct inode *dir, struct dentry *dentry,
 				const struct cpu_str *uni, umode_t mode,
 				dev_t dev, const char *symname, u32 size,
@@ -861,7 +861,7 @@ unsigned long ntfs_names_hash(const u16 *name, size_t len, const u16 *upcase,
 struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu);
 int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
-int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
 		  struct inode *dir);
 #else
 #define ntfs_get_acl NULL
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 55ee27c96a4d..ff64302e87e5 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -578,7 +578,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu)
 	return ntfs_get_acl_ex(inode, type, 0);
 }
 
-static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
+static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 				    struct inode *inode, struct posix_acl *acl,
 				    int type, bool init_acl)
 {
@@ -597,7 +597,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 	case ACL_TYPE_ACCESS:
 		/* Do not change i_mode if we are in init_acl */
 		if (acl && !init_acl) {
-			err = posix_acl_update_mode(mnt_userns, inode, &mode,
+			err = posix_acl_update_mode(idmap, inode, &mode,
 						    &acl);
 			if (err)
 				return err;
@@ -655,9 +655,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	return ntfs_set_acl_ex(mnt_userns, d_inode(dentry), acl, type, false);
+	return ntfs_set_acl_ex(idmap, d_inode(dentry), acl, type, false);
 }
 
 /*
@@ -665,7 +663,7 @@ int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
  *
  * Called from ntfs_create_inode().
  */
-int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
 		  struct inode *dir)
 {
 	struct posix_acl *default_acl, *acl;
@@ -676,7 +674,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		return err;
 
 	if (default_acl) {
-		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
+		err = ntfs_set_acl_ex(idmap, inode, default_acl,
 				      ACL_TYPE_DEFAULT, true);
 		posix_acl_release(default_acl);
 	} else {
@@ -685,7 +683,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 
 	if (acl) {
 		if (!err)
-			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
+			err = ntfs_set_acl_ex(idmap, inode, acl,
 					      ACL_TYPE_ACCESS, true);
 		posix_acl_release(acl);
 	} else {
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 9809756a0d51..9fd03eaf15f8 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -274,7 +274,7 @@ int ocfs2_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (type == ACL_TYPE_ACCESS && acl) {
 		umode_t mode;
 
-		status = posix_acl_update_mode(&init_user_ns, inode, &mode,
+		status = posix_acl_update_mode(&nop_mnt_idmap, inode, &mode,
 					       &acl);
 		if (status)
 			goto unlock;
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 6a81336142c0..5aefb705bcc8 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -136,7 +136,7 @@ int orangefs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * and "mode" to the new desired value. It is up to
 		 * us to propagate the new mode back to the server...
 		 */
-		error = posix_acl_update_mode(&init_user_ns, inode,
+		error = posix_acl_update_mode(&nop_mnt_idmap, inode,
 					      &iattr.ia_mode, &acl);
 		if (error) {
 			gossip_err("%s: posix_acl_update_mode err: %d\n",
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 1cd8c01508b8..b6c3b5b19435 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -372,11 +372,12 @@ EXPORT_SYMBOL(posix_acl_from_mode);
  * by the acl. Returns -E... otherwise.
  */
 int
-posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
+posix_acl_permission(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct posix_acl *acl, int want)
 {
 	const struct posix_acl_entry *pa, *pe, *mask_obj;
 	struct user_namespace *fs_userns = i_user_ns(inode);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int found = 0;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
@@ -683,7 +684,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
 
 /**
  * posix_acl_update_mode  -  update mode in set_acl
- * @mnt_userns:	user namespace of the mount @inode was found from
+ * @idmap:	idmap of the mount @inode was found from
  * @inode:	target inode
  * @mode_p:	mode (pointer) for update
  * @acl:	acl pointer
@@ -695,18 +696,19 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  * As with chmod, clear the setgid bit if the caller is not in the owning group
  * or capable of CAP_FSETID (see inode_change_ok).
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
  * Called from set_acl inode operations.
  */
-int posix_acl_update_mode(struct user_namespace *mnt_userns,
+int posix_acl_update_mode(struct mnt_idmap *idmap,
 			  struct inode *inode, umode_t *mode_p,
 			  struct posix_acl **acl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	umode_t mode = inode->i_mode;
 	int error;
 
@@ -982,11 +984,10 @@ int simple_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct posix_acl *acl, int type)
 {
 	int error;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(mnt_userns, inode,
+		error = posix_acl_update_mode(idmap, inode,
 				&inode->i_mode, &acl);
 		if (error)
 			return error;
@@ -1018,10 +1019,12 @@ int simple_acl_create(struct inode *dir, struct inode *inode)
 	return 0;
 }
 
-static int vfs_set_acl_idmapped_mnt(struct user_namespace *mnt_userns,
+static int vfs_set_acl_idmapped_mnt(struct mnt_idmap *idmap,
 				    struct user_namespace *fs_userns,
 				    struct posix_acl *acl)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	for (int n = 0; n < acl->a_count; n++) {
 		struct posix_acl_entry *acl_e = &acl->a_entries[n];
 
@@ -1057,7 +1060,6 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	int acl_type;
 	int error;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	struct inode *delegated_inode = NULL;
 
@@ -1073,7 +1075,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * if this is a filesystem with a backing store - ultimately
 		 * translate them to backing store values.
 		 */
-		error = vfs_set_acl_idmapped_mnt(mnt_userns, i_user_ns(inode), kacl);
+		error = vfs_set_acl_idmapped_mnt(idmap, i_user_ns(inode), kacl);
 		if (error)
 			return error;
 	}
@@ -1089,7 +1091,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	error = security_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
+	error = security_inode_set_acl(idmap, dentry, acl_name, kacl);
 	if (error)
 		goto out_inode_unlock;
 
@@ -1135,7 +1137,6 @@ EXPORT_SYMBOL_GPL(vfs_set_acl);
 struct posix_acl *vfs_get_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	struct posix_acl *acl;
 	int acl_type, error;
@@ -1148,7 +1149,7 @@ struct posix_acl *vfs_get_acl(struct mnt_idmap *idmap,
 	 * The VFS has no restrictions on reading POSIX ACLs so calling
 	 * something like xattr_permission() isn't needed. Only LSMs get a say.
 	 */
-	error = security_inode_get_acl(mnt_userns, dentry, acl_name);
+	error = security_inode_get_acl(idmap, dentry, acl_name);
 	if (error)
 		return ERR_PTR(error);
 
@@ -1182,7 +1183,6 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	int acl_type;
 	int error;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	struct inode *delegated_inode = NULL;
 
@@ -1201,7 +1201,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	error = security_inode_remove_acl(mnt_userns, dentry, acl_name);
+	error = security_inode_remove_acl(idmap, dentry, acl_name);
 	if (error)
 		goto out_inode_unlock;
 
@@ -1217,7 +1217,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EOPNOTSUPP;
 	if (!error) {
 		fsnotify_xattr(dentry);
-		evm_inode_post_remove_acl(mnt_userns, dentry, acl_name);
+		evm_inode_post_remove_acl(idmap, dentry, acl_name);
 	}
 
 out_inode_unlock:
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index 186aeba6823c..138060452678 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -42,7 +42,7 @@ reiserfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	reiserfs_write_unlock(inode->i_sb);
 	if (error == 0) {
 		if (type == ACL_TYPE_ACCESS && acl) {
-			error = posix_acl_update_mode(&init_user_ns, inode,
+			error = posix_acl_update_mode(&nop_mnt_idmap, inode,
 						      &mode, &acl);
 			if (error)
 				goto unlock;
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index a2d2c117a076..791db7d9c849 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -245,7 +245,6 @@ int
 xfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	    struct posix_acl *acl, int type)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	umode_t mode;
 	bool set_mode = false;
 	int error = 0;
@@ -259,7 +258,7 @@ xfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		return error;
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(mnt_userns, inode, &mode, &acl);
+		error = posix_acl_update_mode(idmap, inode, &mode, &acl);
 		if (error)
 			return error;
 		set_mode = true;
diff --git a/include/linux/evm.h b/include/linux/evm.h
index e06aacd3e315..7dc1ee74169f 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -35,20 +35,20 @@ extern int evm_inode_removexattr(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
-static inline void evm_inode_post_remove_acl(struct user_namespace *mnt_userns,
+static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
 					     struct dentry *dentry,
 					     const char *acl_name)
 {
 	evm_inode_post_removexattr(dentry, acl_name);
 }
-extern int evm_inode_set_acl(struct user_namespace *mnt_userns,
+extern int evm_inode_set_acl(struct mnt_idmap *idmap,
 			     struct dentry *dentry, const char *acl_name,
 			     struct posix_acl *kacl);
-static inline int evm_inode_remove_acl(struct user_namespace *mnt_userns,
+static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
 				       struct dentry *dentry,
 				       const char *acl_name)
 {
-	return evm_inode_set_acl(mnt_userns, dentry, acl_name, NULL);
+	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
 }
 static inline void evm_inode_post_set_acl(struct dentry *dentry,
 					  const char *acl_name,
@@ -129,21 +129,21 @@ static inline void evm_inode_post_removexattr(struct dentry *dentry,
 	return;
 }
 
-static inline void evm_inode_post_remove_acl(struct user_namespace *mnt_userns,
+static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
 					     struct dentry *dentry,
 					     const char *acl_name)
 {
 	return;
 }
 
-static inline int evm_inode_set_acl(struct user_namespace *mnt_userns,
+static inline int evm_inode_set_acl(struct mnt_idmap *idmap,
 				    struct dentry *dentry, const char *acl_name,
 				    struct posix_acl *kacl)
 {
 	return 0;
 }
 
-static inline int evm_inode_remove_acl(struct user_namespace *mnt_userns,
+static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
 				       struct dentry *dentry,
 				       const char *acl_name)
 {
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6f470b658082..172b113a9864 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -187,14 +187,14 @@ extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
-extern int ima_inode_set_acl(struct user_namespace *mnt_userns,
+extern int ima_inode_set_acl(struct mnt_idmap *idmap,
 			     struct dentry *dentry, const char *acl_name,
 			     struct posix_acl *kacl);
-static inline int ima_inode_remove_acl(struct user_namespace *mnt_userns,
+static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
 				       struct dentry *dentry,
 				       const char *acl_name)
 {
-	return ima_inode_set_acl(mnt_userns, dentry, acl_name, NULL);
+	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
 }
 extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
@@ -217,7 +217,7 @@ static inline int ima_inode_setxattr(struct dentry *dentry,
 	return 0;
 }
 
-static inline int ima_inode_set_acl(struct user_namespace *mnt_userns,
+static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
 				    struct dentry *dentry, const char *acl_name,
 				    struct posix_acl *kacl)
 {
@@ -231,7 +231,7 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 
-static inline int ima_inode_remove_acl(struct user_namespace *mnt_userns,
+static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
 				       struct dentry *dentry,
 				       const char *acl_name)
 {
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f344c0e7387a..094b76dc7164 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -145,11 +145,11 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
-LSM_HOOK(int, 0, inode_set_acl, struct user_namespace *mnt_userns,
+LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
-LSM_HOOK(int, 0, inode_get_acl, struct user_namespace *mnt_userns,
+LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_remove_acl, struct user_namespace *mnt_userns,
+LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 0282758ba400..21cc29b8a9e8 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -79,7 +79,7 @@ struct posix_acl *posix_acl_clone(const struct posix_acl *acl, gfp_t flags);
 int posix_acl_chmod(struct mnt_idmap *, struct dentry *, umode_t);
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
 		struct posix_acl **);
-int posix_acl_update_mode(struct user_namespace *, struct inode *, umode_t *,
+int posix_acl_update_mode(struct mnt_idmap *, struct inode *, umode_t *,
 			  struct posix_acl **);
 
 int simple_set_acl(struct mnt_idmap *, struct dentry *,
@@ -91,7 +91,7 @@ void set_cached_acl(struct inode *inode, int type, struct posix_acl *acl);
 void forget_cached_acl(struct inode *inode, int type);
 void forget_all_cached_acls(struct inode *inode);
 int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
-int posix_acl_permission(struct user_namespace *, struct inode *,
+int posix_acl_permission(struct mnt_idmap *, struct inode *,
 			 const struct posix_acl *, int);
 
 static inline void cache_no_acl(struct inode *inode)
diff --git a/include/linux/security.h b/include/linux/security.h
index 474373e631df..5984d0d550b4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -361,12 +361,12 @@ int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags);
-int security_inode_set_acl(struct user_namespace *mnt_userns,
+int security_inode_set_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl);
-int security_inode_get_acl(struct user_namespace *mnt_userns,
+int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name);
-int security_inode_remove_acl(struct user_namespace *mnt_userns,
+int security_inode_remove_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name);
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
@@ -879,7 +879,7 @@ static inline int security_inode_setxattr(struct mnt_idmap *idmap,
 	return cap_inode_setxattr(dentry, name, value, size, flags);
 }
 
-static inline int security_inode_set_acl(struct user_namespace *mnt_userns,
+static inline int security_inode_set_acl(struct mnt_idmap *idmap,
 					 struct dentry *dentry,
 					 const char *acl_name,
 					 struct posix_acl *kacl)
@@ -887,14 +887,14 @@ static inline int security_inode_set_acl(struct user_namespace *mnt_userns,
 	return 0;
 }
 
-static inline int security_inode_get_acl(struct user_namespace *mnt_userns,
+static inline int security_inode_get_acl(struct mnt_idmap *idmap,
 					 struct dentry *dentry,
 					 const char *acl_name)
 {
 	return 0;
 }
 
-static inline int security_inode_remove_acl(struct user_namespace *mnt_userns,
+static inline int security_inode_remove_acl(struct mnt_idmap *idmap,
 					    struct dentry *dentry,
 					    const char *acl_name)
 {
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 99f7bd8af19a..4e5adddb3577 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -610,7 +610,7 @@ int evm_inode_removexattr(struct mnt_idmap *idmap,
 }
 
 #ifdef CONFIG_FS_POSIX_ACL
-static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
+static int evm_inode_set_acl_change(struct mnt_idmap *idmap,
 				    struct dentry *dentry, const char *name,
 				    struct posix_acl *kacl)
 {
@@ -622,14 +622,14 @@ static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
 	if (!kacl)
 		return 1;
 
-	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &kacl);
+	rc = posix_acl_update_mode(idmap, inode, &mode, &kacl);
 	if (rc || (inode->i_mode != mode))
 		return 1;
 
 	return 0;
 }
 #else
-static inline int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
+static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
 					   struct dentry *dentry,
 					   const char *name,
 					   struct posix_acl *kacl)
@@ -640,7 +640,7 @@ static inline int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
 
 /**
  * evm_inode_set_acl - protect the EVM extended attribute from posix acls
- * @mnt_userns: user namespace of the idmapped mount
+ * @idmap: idmap of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @acl_name: name of the posix acl
  * @kacl: pointer to the posix acls
@@ -649,7 +649,7 @@ static inline int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
  * and 'security.evm' xattr updated, unless the existing 'security.evm' is
  * valid.
  */
-int evm_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *acl_name, struct posix_acl *kacl)
 {
 	enum integrity_status evm_status;
@@ -678,7 +678,7 @@ int evm_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return 0;
 
 	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
-	    !evm_inode_set_acl_change(mnt_userns, dentry, acl_name, kacl))
+	    !evm_inode_set_acl_change(idmap, dentry, acl_name, kacl))
 		return 0;
 
 	if (evm_status != INTEGRITY_PASS_IMMUTABLE)
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 4078a9ad8531..555342d337f9 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -774,7 +774,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 	return result;
 }
 
-int ima_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
diff --git a/security/security.c b/security/security.c
index 7e7a12142854..4e1150c44ab7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1400,7 +1400,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 	return evm_inode_setxattr(idmap, dentry, name, value, size);
 }
 
-int security_inode_set_acl(struct user_namespace *mnt_userns,
+int security_inode_set_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl)
 {
@@ -1408,38 +1408,38 @@ int security_inode_set_acl(struct user_namespace *mnt_userns,
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_set_acl, 0, mnt_userns, dentry, acl_name,
+	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
 			    kacl);
 	if (ret)
 		return ret;
-	ret = ima_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
+	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
 	if (ret)
 		return ret;
-	return evm_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
+	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
 }
 
-int security_inode_get_acl(struct user_namespace *mnt_userns,
+int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_get_acl, 0, mnt_userns, dentry, acl_name);
+	return call_int_hook(inode_get_acl, 0, idmap, dentry, acl_name);
 }
 
-int security_inode_remove_acl(struct user_namespace *mnt_userns,
+int security_inode_remove_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name)
 {
 	int ret;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_remove_acl, 0, mnt_userns, dentry, acl_name);
+	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
 	if (ret)
 		return ret;
-	ret = ima_inode_remove_acl(mnt_userns, dentry, acl_name);
+	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
 	if (ret)
 		return ret;
-	return evm_inode_remove_acl(mnt_userns, dentry, acl_name);
+	return evm_inode_remove_acl(idmap, dentry, acl_name);
 }
 
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 706bb440f837..f32fa3359502 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3241,20 +3241,20 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 			    &ad);
 }
 
-static int selinux_inode_set_acl(struct user_namespace *mnt_userns,
+static int selinux_inode_set_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *acl_name,
 				 struct posix_acl *kacl)
 {
 	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 }
 
-static int selinux_inode_get_acl(struct user_namespace *mnt_userns,
+static int selinux_inode_get_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *acl_name)
 {
 	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
 }
 
-static int selinux_inode_remove_acl(struct user_namespace *mnt_userns,
+static int selinux_inode_remove_acl(struct mnt_idmap *idmap,
 				    struct dentry *dentry, const char *acl_name)
 {
 	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 306c921759f6..cfcbb748da25 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1394,14 +1394,14 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 
 /**
  * smack_inode_set_acl - Smack check for setting posix acls
- * @mnt_userns: the userns attached to the mnt this request came from
+ * @idmap: idmap of the mnt this request came from
  * @dentry: the object
  * @acl_name: name of the posix acl
  * @kacl: the posix acls
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_set_acl(struct user_namespace *mnt_userns,
+static int smack_inode_set_acl(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *acl_name,
 			       struct posix_acl *kacl)
 {
@@ -1418,13 +1418,13 @@ static int smack_inode_set_acl(struct user_namespace *mnt_userns,
 
 /**
  * smack_inode_get_acl - Smack check for getting posix acls
- * @mnt_userns: the userns attached to the mnt this request came from
+ * @idmap: idmap of the mnt this request came from
  * @dentry: the object
  * @acl_name: name of the posix acl
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_get_acl(struct user_namespace *mnt_userns,
+static int smack_inode_get_acl(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *acl_name)
 {
 	struct smk_audit_info ad;
@@ -1440,13 +1440,13 @@ static int smack_inode_get_acl(struct user_namespace *mnt_userns,
 
 /**
  * smack_inode_remove_acl - Smack check for getting posix acls
- * @mnt_userns: the userns attached to the mnt this request came from
+ * @idmap: idmap of the mnt this request came from
  * @dentry: the object
  * @acl_name: name of the posix acl
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_remove_acl(struct user_namespace *mnt_userns,
+static int smack_inode_remove_acl(struct mnt_idmap *idmap,
 				  struct dentry *dentry, const char *acl_name)
 {
 	struct smk_audit_info ad;

-- 
2.34.1

