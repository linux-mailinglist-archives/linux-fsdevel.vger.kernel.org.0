Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB32D551EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiFTOfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242283AbiFTOeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5320BC6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6461B80EA6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7801DC3411C;
        Mon, 20 Jun 2022 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733019;
        bh=O+7w+qGf6ueflSHEMGBDY1oRvAUVzPFEsEM4uZeLT5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcHznTeTAet7jDN16htXQkWGy3eJMW21/8DDiBnVbbFNp6Y+5TpG3RXvT3COexe/7
         /V/TbWs77ggl1RwucU165KRcQpbVPE0hPQq/LZy7RODZGYGewyluQRZCrGvU8WgDfE
         QAs5YMWZhzrwkiBX3EL00GR7pymKOBdiSEpC0/MBCcfrHO6B3fTPiMhB+9TmqeAmvj
         V2fD/eH+Hiy5i+aFsg8Z1HJuOvO86Qm8oAwVf+GobT/muMWIWWJBYIu74w/CY6ctEB
         6d8SfzZL6WM8FQxA7+M7ZQrSYir46Y/QGoQpMW392bt0MkUD7YCiunJnX8oq2Jkt1v
         /I0QmgDBTkq5w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 8/8] attr: port attribute changes to new types
Date:   Mon, 20 Jun 2022 15:49:47 +0200
Message-Id: <20220620134947.2772863-9-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620134947.2772863-1-brauner@kernel.org>
References: <20220620134947.2772863-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25803; h=from:subject; bh=O+7w+qGf6ueflSHEMGBDY1oRvAUVzPFEsEM4uZeLT5I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHr3afv5Ey+WbSrZZP71stTmdN+Du9hn3vhp5yYZo5U7 NdhAv6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiHgyMDL1zCn+9kPi9e+WjjqqCIp /j81XtA/oKv01YurFG+czRXh+Gf+pHSzqn62gzXX3OwHhUdDOrSfhdkU1hOfNPmPr0mhoWMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we introduced new infrastructure to increase the type safety
for filesystems supporting idmapped mounts port the first part of the
vfs over to them.

This ports the attribute changes codepaths to rely on the new better
helpers using a dedicated type.

Before this change we used to take a shortcut and place the actual
values that would be written to inode->i_{g,u}id into struct iattr. This
had the advantage that we moved idmappings mostly out of the picture
early on but it made reasoning about changes more difficult than it
should be.

The filesystem was never explicitly told that it dealt with an idmapped
mount. The transition to the value that needed to be stored in
inode->i_{g,u}id appeared way too early and increased the probability of
bugs in various codepaths.

We know place the same value in struct iattr no matter if this is an
idmapped mount or not. The vfs will only deal with type safe
kmnt{g,u}id_t. This makes it massively safer to perform permission
checks as the type will tell us what checks we need to perform and what
helpers we need to use. Any fileystem raising FS_ALLOW_IDMAP can't
simply write ia_mnt{g,u}id to inode->i_{g,u}id since they are different
types. Instead they need to use the dedicated kmnt{g,u}id_to_k{g,u}id()
helpers that map the kmnt{g,u}id into the filesystem.

The other nice effect is that filesystems like overlayfs don't need to
care about idmappings explicitly anymore and can simply set up struct
iattr accordingly.

Link: https://lore.kernel.org/lkml/CAHk-=win6+ahs1EwLkcq8apqLi_1wXFWbrPf340zYEhObpz4jA@mail.gmail.com [1]
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/attr.c                         | 67 +++++++++++++++----------------
 fs/ext2/inode.c                   |  8 ++--
 fs/ext4/inode.c                   | 12 +++---
 fs/f2fs/file.c                    | 16 ++++----
 fs/fat/file.c                     |  6 +--
 fs/jfs/file.c                     |  4 +-
 fs/ocfs2/file.c                   |  2 +-
 fs/open.c                         | 65 +++++++++++++++++++++++-------
 fs/overlayfs/copy_up.c            |  4 +-
 fs/overlayfs/overlayfs.h          | 12 +-----
 fs/quota/dquot.c                  | 14 +++++--
 fs/reiserfs/inode.c               |  4 +-
 fs/xfs/xfs_iops.c                 |  7 ++--
 fs/zonefs/super.c                 |  2 +-
 include/linux/fs.h                |  4 ++
 include/linux/quotaops.h          |  4 +-
 security/integrity/evm/evm_main.c |  4 +-
 17 files changed, 134 insertions(+), 101 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 88e2ca30d42e..20ff225a80d3 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -32,14 +32,15 @@
  */
 static bool chown_ok(struct user_namespace *mnt_userns,
 		     const struct inode *inode,
-		     kuid_t uid)
+		     kmntuid_t ia_mntuid)
 {
-	kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
-	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, inode->i_uid))
+	kmntuid_t kmntuid = i_uid_into_mntuid(mnt_userns, inode);
+	if (kuid_eq_kmntuid(current_fsuid(), kmntuid) &&
+	    kmntuid_eq(ia_mntuid, kmntuid))
 		return true;
 	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
 		return true;
-	if (uid_eq(kuid, INVALID_UID) &&
+	if (kmntuid_eq(kmntuid, INVALID_KMNTUID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
@@ -58,21 +59,19 @@ static bool chown_ok(struct user_namespace *mnt_userns,
  * performed on the raw inode simply passs init_user_ns.
  */
 static bool chgrp_ok(struct user_namespace *mnt_userns,
-		     const struct inode *inode, kgid_t gid)
+		     const struct inode *inode, kmntgid_t ia_mntgid)
 {
-	kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
-	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode))) {
-		kgid_t mapped_gid;
-
-		if (gid_eq(gid, inode->i_gid))
+	kmntgid_t kmntgid = i_gid_into_mntgid(mnt_userns, inode);
+	kmntuid_t kmntuid = i_uid_into_mntuid(mnt_userns, inode);
+	if (kuid_eq_kmntuid(current_fsuid(), kmntuid)) {
+		if (kmntgid_eq(ia_mntgid, kmntgid))
 			return true;
-		mapped_gid = mapped_kgid_fs(mnt_userns, i_user_ns(inode), gid);
-		if (in_group_p(mapped_gid))
+		if (kmntgid_in_group_p(ia_mntgid))
 			return true;
 	}
 	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
 		return true;
-	if (gid_eq(kgid, INVALID_GID) &&
+	if (kmntgid_eq(ia_mntgid, INVALID_KMNTGID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
@@ -120,28 +119,29 @@ int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
 		goto kill_priv;
 
 	/* Make sure a caller can chown. */
-	if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, inode, attr->ia_uid))
+	if ((ia_valid & ATTR_UID) &&
+	    !chown_ok(mnt_userns, inode, attr->ia_mntuid))
 		return -EPERM;
 
 	/* Make sure caller can chgrp. */
-	if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, inode, attr->ia_gid))
+	if ((ia_valid & ATTR_GID) &&
+	    !chgrp_ok(mnt_userns, inode, attr->ia_mntgid))
 		return -EPERM;
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
-		kgid_t mapped_gid;
+		kmntgid_t kmntgid;
 
 		if (!inode_owner_or_capable(mnt_userns, inode))
 			return -EPERM;
 
 		if (ia_valid & ATTR_GID)
-			mapped_gid = mapped_kgid_fs(mnt_userns,
-						i_user_ns(inode), attr->ia_gid);
+			kmntgid = attr->ia_mntgid;
 		else
-			mapped_gid = i_gid_into_mnt(mnt_userns, inode);
+			kmntgid = i_gid_into_mntgid(mnt_userns, inode);
 
 		/* Also check the setgid bit! */
-		if (!in_group_p(mapped_gid) &&
+		if (!kmntgid_in_group_p(kmntgid) &&
 		    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
 			attr->ia_mode &= ~S_ISGID;
 	}
@@ -219,9 +219,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
  * setattr_copy must be called with i_mutex held.
  *
  * setattr_copy updates the inode's metadata with that specified
- * in attr on idmapped mounts. If file ownership is changed setattr_copy
- * doesn't map ia_uid and ia_gid. It will asssume the caller has already
- * provided the intended values. Necessary permission checks to determine
+ * in attr on idmapped mounts. Necessary permission checks to determine
  * whether or not the S_ISGID property needs to be removed are performed with
  * the correct idmapped mount permission helpers.
  * Noticeably missing is inode size update, which is more complex
@@ -242,8 +240,8 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
 {
 	unsigned int ia_valid = attr->ia_valid;
 
-	i_uid_update(&init_user_ns, attr, inode);
-	i_gid_update(&init_user_ns, attr, inode);
+	i_uid_update(mnt_userns, attr, inode);
+	i_gid_update(mnt_userns, attr, inode);
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
@@ -252,8 +250,8 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
-		if (!in_group_p(kgid) &&
+		kmntgid_t kmntgid = i_gid_into_mntgid(mnt_userns, inode);
+		if (!kmntgid_in_group_p(kmntgid) &&
 		    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
@@ -304,9 +302,6 @@ EXPORT_SYMBOL(may_setattr);
  * retry.  Because breaking a delegation may take a long time, the
  * caller should drop the i_mutex before doing so.
  *
- * If file ownership is changed notify_change() doesn't map ia_uid and
- * ia_gid. It will asssume the caller has already provided the intended values.
- *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.  Also, passing NULL is fine for callers holding
@@ -395,23 +390,25 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 	 * namespace of the superblock.
 	 */
 	if (ia_valid & ATTR_UID &&
-	    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
+	    !kmntuid_has_mapping(mnt_userns, inode->i_sb->s_user_ns,
+				 attr->ia_mntuid))
 		return -EOVERFLOW;
 	if (ia_valid & ATTR_GID &&
-	    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
+	    !kmntgid_has_mapping(mnt_userns, inode->i_sb->s_user_ns,
+				 attr->ia_mntgid))
 		return -EOVERFLOW;
 
 	/* Don't allow modifications of files with invalid uids or
 	 * gids unless those uids & gids are being made valid.
 	 */
 	if (!(ia_valid & ATTR_UID) &&
-	    !uid_valid(i_uid_into_mnt(mnt_userns, inode)))
+	    !kmntuid_valid(i_uid_into_mntuid(mnt_userns, inode)))
 		return -EOVERFLOW;
 	if (!(ia_valid & ATTR_GID) &&
-	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
+	    !kmntgid_valid(i_gid_into_mntgid(mnt_userns, inode)))
 		return -EOVERFLOW;
 
-	error = security_inode_setattr(&init_user_ns, dentry, attr);
+	error = security_inode_setattr(mnt_userns, dentry, attr);
 	if (error)
 		return error;
 	error = try_break_deleg(inode, delegated_inode);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 593b79416e0e..7a192e4e7fa9 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1679,14 +1679,14 @@ int ext2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		return error;
 
-	if (is_quota_modification(&init_user_ns, inode, iattr)) {
+	if (is_quota_modification(mnt_userns, inode, iattr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
 	}
-	if (i_uid_needs_update(&init_user_ns, iattr, inode) ||
-	    i_gid_needs_update(&init_user_ns, iattr, inode)) {
-		error = dquot_transfer(&init_user_ns, inode, iattr);
+	if (i_uid_needs_update(mnt_userns, iattr, inode) ||
+	    i_gid_needs_update(mnt_userns, iattr, inode)) {
+		error = dquot_transfer(mnt_userns, inode, iattr);
 		if (error)
 			return error;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 72f08c184768..3dcc1dd1f179 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5350,14 +5350,14 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		return error;
 
-	if (is_quota_modification(&init_user_ns, inode, attr)) {
+	if (is_quota_modification(mnt_userns, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
 	}
 
-	if (i_uid_needs_update(&init_user_ns, attr, inode) ||
-	    i_gid_needs_update(&init_user_ns, attr, inode)) {
+	if (i_uid_needs_update(mnt_userns, attr, inode) ||
+	    i_gid_needs_update(mnt_userns, attr, inode)) {
 		handle_t *handle;
 
 		/* (user+group)*(old+new) structure, inode write (sb,
@@ -5374,7 +5374,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 * counts xattr inode references.
 		 */
 		down_read(&EXT4_I(inode)->xattr_sem);
-		error = dquot_transfer(&init_user_ns, inode, attr);
+		error = dquot_transfer(mnt_userns, inode, attr);
 		up_read(&EXT4_I(inode)->xattr_sem);
 
 		if (error) {
@@ -5383,8 +5383,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 		/* Update corresponding info in inode so that everything is in
 		 * one transaction */
-		i_uid_update(&init_user_ns, attr, inode);
-		i_gid_update(&init_user_ns, attr, inode);
+		i_uid_update(mnt_userns, attr, inode);
+		i_gid_update(mnt_userns, attr, inode);
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 02b2d56d4edc..d66e37d80a2d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -861,8 +861,8 @@ static void __setattr_copy(struct user_namespace *mnt_userns,
 {
 	unsigned int ia_valid = attr->ia_valid;
 
-	i_uid_update(&init_user_ns, attr, inode);
-	i_gid_update(&init_user_ns, attr, inode);
+	i_uid_update(mnt_userns, attr, inode);
+	i_gid_update(mnt_userns, attr, inode);
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
@@ -915,15 +915,15 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (err)
 		return err;
 
-	if (is_quota_modification(&init_user_ns, inode, attr)) {
+	if (is_quota_modification(mnt_userns, inode, attr)) {
 		err = f2fs_dquot_initialize(inode);
 		if (err)
 			return err;
 	}
-	if (i_uid_needs_update(&init_user_ns, attr, inode) ||
-	    i_gid_needs_update(&init_user_ns, attr, inode)) {
+	if (i_uid_needs_update(mnt_userns, attr, inode) ||
+	    i_gid_needs_update(mnt_userns, attr, inode)) {
 		f2fs_lock_op(F2FS_I_SB(inode));
-		err = dquot_transfer(&init_user_ns, inode, attr);
+		err = dquot_transfer(mnt_userns, inode, attr);
 		if (err) {
 			set_sbi_flag(F2FS_I_SB(inode),
 					SBI_QUOTA_NEED_REPAIR);
@@ -934,8 +934,8 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 * update uid/gid under lock_op(), so that dquot and inode can
 		 * be updated atomically.
 		 */
-		i_uid_update(&init_user_ns, attr, inode);
-		i_gid_update(&init_user_ns, attr, inode);
+		i_uid_update(mnt_userns, attr, inode);
+		i_gid_update(mnt_userns, attr, inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 		f2fs_unlock_op(F2FS_I_SB(inode));
 	}
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 530f18173db2..473b02833d4f 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -90,7 +90,7 @@ static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 	 * out the RO attribute for checking by the security
 	 * module, just because it maps to a file mode.
 	 */
-	err = security_inode_setattr(&init_user_ns,
+	err = security_inode_setattr(file_mnt_user_ns(file),
 				     file->f_path.dentry, &ia);
 	if (err)
 		goto out_unlock_inode;
@@ -517,9 +517,9 @@ int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	if (((attr->ia_valid & ATTR_UID) &&
-	     (!uid_eq(attr->ia_uid, sbi->options.fs_uid))) ||
+	     (!kuid_eq_kmntuid(sbi->options.fs_uid, attr->ia_mntuid))) ||
 	    ((attr->ia_valid & ATTR_GID) &&
-	     (!gid_eq(attr->ia_gid, sbi->options.fs_gid))) ||
+	     (!kgid_eq_kmntgid(sbi->options.fs_gid, attr->ia_mntgid))) ||
 	    ((attr->ia_valid & ATTR_MODE) &&
 	     (attr->ia_mode & ~FAT_VALID_MODE)))
 		error = -EPERM;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index c18569b9895d..332dc9ac47a9 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -95,14 +95,14 @@ int jfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (rc)
 		return rc;
 
-	if (is_quota_modification(&init_user_ns, inode, iattr)) {
+	if (is_quota_modification(mnt_userns, inode, iattr)) {
 		rc = dquot_initialize(inode);
 		if (rc)
 			return rc;
 	}
 	if ((iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    (iattr->ia_valid & ATTR_GID && !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		rc = dquot_transfer(&init_user_ns, inode, iattr);
+		rc = dquot_transfer(mnt_userns, inode, iattr);
 		if (rc)
 			return rc;
 	}
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 0e09cd8911da..9c67edd215d5 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1146,7 +1146,7 @@ int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (status)
 		return status;
 
-	if (is_quota_modification(&init_user_ns, inode, attr)) {
+	if (is_quota_modification(mnt_userns, inode, attr)) {
 		status = dquot_initialize(inode);
 		if (status)
 			return status;
diff --git a/fs/open.c b/fs/open.c
index 1d57fbde2feb..d3fea687c846 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -663,6 +663,47 @@ SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
+
+/**
+ * setattr_uid - check and set uid attribute
+ * @mnt_userns:	user namespace of the mount
+ * @kuid: new inode owner
+ *
+ * Check whether @kuid can be mapped into the mount and if so, place it in
+ * @attr's ia_mntuid member.
+ *
+ * Return: true if kuid has a mapping in the mount, false if not.
+ */
+static inline bool setattr_uid(struct user_namespace *mnt_userns,
+			       struct iattr *attr, kuid_t kuid)
+{
+	if (!kuid_has_mapping(mnt_userns, kuid))
+		return false;
+	attr->ia_valid |= ATTR_UID;
+	attr->ia_mntuid = KMNTUIDT_INIT(kuid);
+	return true;
+}
+
+/**
+ * setattr_gid - check and set gid attribute
+ * @mnt_userns:	user namespace of the mount
+ * @knid: new inode owner
+ *
+ * Check whether @kgid can be mapped into the mount and if so, place it in
+ * @attr's ia_mntgid member.
+ *
+ * Return: true if kgid has a mapping in the mount, false if not.
+ */
+static inline bool setattr_gid(struct user_namespace *mnt_userns,
+			       struct iattr *attr, kgid_t kgid)
+{
+	if (!kgid_has_mapping(mnt_userns, kgid))
+		return false;
+	attr->ia_valid |= ATTR_GID;
+	attr->ia_mntgid = KMNTGIDT_INIT(kgid);
+	return true;
+}
+
 int chown_common(const struct path *path, uid_t user, gid_t group)
 {
 	struct user_namespace *mnt_userns, *fs_userns;
@@ -678,28 +719,22 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 
 	mnt_userns = mnt_user_ns(path->mnt);
 	fs_userns = i_user_ns(inode);
-	uid = mapped_kuid_user(mnt_userns, fs_userns, uid);
-	gid = mapped_kgid_user(mnt_userns, fs_userns, gid);
 
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
-	if (user != (uid_t) -1) {
-		if (!uid_valid(uid))
-			return -EINVAL;
-		newattrs.ia_valid |= ATTR_UID;
-		newattrs.ia_uid = uid;
-	}
-	if (group != (gid_t) -1) {
-		if (!gid_valid(gid))
-			return -EINVAL;
-		newattrs.ia_valid |= ATTR_GID;
-		newattrs.ia_gid = gid;
-	}
+	if ((user != (uid_t)-1) && !setattr_uid(mnt_userns, &newattrs, uid))
+		return -EINVAL;
+	if ((group != (gid_t)-1) && !setattr_gid(mnt_userns, &newattrs, gid))
+		return -EINVAL;
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |=
 			ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
 	inode_lock(inode);
-	error = security_path_chown(path, uid, gid);
+	/* Continue to send actual fs values, not the mount values. */
+	error = security_path_chown(
+		path,
+		kmntuid_to_kuid(mnt_userns, fs_userns, newattrs.ia_mntuid),
+		kmntgid_to_kgid(mnt_userns, fs_userns, newattrs.ia_mntgid));
 	if (!error)
 		error = notify_change(mnt_userns, path->dentry, &newattrs,
 				      &delegated_inode);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 714ec569d25b..1087e44bb4e1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -331,8 +331,8 @@ int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upperdentry,
 	if (!err) {
 		struct iattr attr = {
 			.ia_valid = ATTR_UID | ATTR_GID,
-			.ia_uid = stat->uid,
-			.ia_gid = stat->gid,
+			.ia_mntuid = KMNTUIDT_INIT(stat->uid),
+			.ia_mntgid = KMNTGIDT_INIT(stat->gid),
 		};
 		err = ovl_do_notify_change(ofs, upperdentry, &attr);
 	}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4f34b7e02eee..e22e20f4811a 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -139,17 +139,7 @@ static inline int ovl_do_notify_change(struct ovl_fs *ofs,
 				       struct dentry *upperdentry,
 				       struct iattr *attr)
 {
-	struct user_namespace *upper_mnt_userns = ovl_upper_mnt_userns(ofs);
-	struct user_namespace *fs_userns = i_user_ns(d_inode(upperdentry));
-
-	if (attr->ia_valid & ATTR_UID)
-		attr->ia_uid = mapped_kuid_user(upper_mnt_userns,
-						fs_userns, attr->ia_uid);
-	if (attr->ia_valid & ATTR_GID)
-		attr->ia_gid = mapped_kgid_user(upper_mnt_userns,
-						fs_userns, attr->ia_gid);
-
-	return notify_change(upper_mnt_userns, upperdentry, attr, NULL);
+	return notify_change(ovl_upper_mnt_userns(ofs), upperdentry, attr, NULL);
 }
 
 static inline int ovl_do_rmdir(struct ovl_fs *ofs,
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df9af1ce2851..8cb96f34fb63 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2096,8 +2096,11 @@ int dquot_transfer(struct user_namespace *mnt_userns, struct inode *inode,
 	if (!dquot_active(inode))
 		return 0;
 
-	if (i_uid_needs_update(&init_user_ns, iattr, inode)) {
-		dquot = dqget(sb, make_kqid_uid(iattr->ia_uid));
+	if (i_uid_needs_update(mnt_userns, iattr, inode)) {
+		kuid_t kuid = kmntuid_to_kuid(mnt_userns, i_user_ns(inode),
+					      iattr->ia_mntuid);
+
+		dquot = dqget(sb, make_kqid_uid(kuid));
 		if (IS_ERR(dquot)) {
 			if (PTR_ERR(dquot) != -ESRCH) {
 				ret = PTR_ERR(dquot);
@@ -2107,8 +2110,11 @@ int dquot_transfer(struct user_namespace *mnt_userns, struct inode *inode,
 		}
 		transfer_to[USRQUOTA] = dquot;
 	}
-	if (i_gid_needs_update(&init_user_ns, iattr, inode)) {
-		dquot = dqget(sb, make_kqid_gid(iattr->ia_gid));
+	if (i_gid_needs_update(mnt_userns, iattr, inode)) {
+		kgid_t kgid = kmntgid_to_kgid(mnt_userns, i_user_ns(inode),
+					      iattr->ia_mntgid);
+
+		dquot = dqget(sb, make_kqid_gid(kgid));
 		if (IS_ERR(dquot)) {
 			if (PTR_ERR(dquot) != -ESRCH) {
 				ret = PTR_ERR(dquot);
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 1e89e76972a0..1141053b96ed 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3284,7 +3284,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	/* must be turned off for recursive notify_change calls */
 	ia_valid = attr->ia_valid &= ~(ATTR_KILL_SUID|ATTR_KILL_SGID);
 
-	if (is_quota_modification(&init_user_ns, inode, attr)) {
+	if (is_quota_modification(mnt_userns, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
@@ -3367,7 +3367,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		reiserfs_write_unlock(inode->i_sb);
 		if (error)
 			goto out;
-		error = dquot_transfer(&init_user_ns, inode, attr);
+		error = dquot_transfer(mnt_userns, inode, attr);
 		reiserfs_write_lock(inode->i_sb);
 		if (error) {
 			journal_end(&th);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 31ec29565fb4..fb944721549b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -667,7 +667,8 @@ xfs_setattr_nonsize(
 		uint	qflags = 0;
 
 		if ((mask & ATTR_UID) && XFS_IS_UQUOTA_ON(mp)) {
-			uid = iattr->ia_uid;
+			uid = kmntuid_to_kuid(mnt_userns, i_user_ns(inode),
+					      iattr->ia_mntuid);
 			qflags |= XFS_QMOPT_UQUOTA;
 		} else {
 			uid = inode->i_uid;
@@ -705,12 +706,12 @@ xfs_setattr_nonsize(
 	 * also.
 	 */
 	if (XFS_IS_UQUOTA_ON(mp) &&
-	    i_uid_needs_update(&init_user_ns, iattr, inode)) {
+	    i_uid_needs_update(mnt_userns, iattr, inode)) {
 		ASSERT(udqp);
 		old_udqp = xfs_qm_vop_chown(tp, ip, &ip->i_udquot, udqp);
 	}
 	if (XFS_IS_GQUOTA_ON(mp) &&
-	    i_gid_needs_update(&init_user_ns, iattr, inode)) {
+	    i_gid_needs_update(mnt_userns, iattr, inode)) {
 		ASSERT(xfs_has_pquotino(mp) || !XFS_IS_PQUOTA_ON(mp));
 		ASSERT(gdqp);
 		old_gdqp = xfs_qm_vop_chown(tp, ip, &ip->i_gdquot, gdqp);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index dd422b1d7320..f5d8338967cb 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -616,7 +616,7 @@ static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
 	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    ((iattr->ia_valid & ATTR_GID) &&
 	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		ret = dquot_transfer(&init_user_ns, inode, iattr);
+		ret = dquot_transfer(mnt_userns, inode, iattr);
 		if (ret)
 			return ret;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 998ac36ea7b0..8de658aee1f9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -228,6 +228,10 @@ struct iattr {
 	 * are a dedicated type requiring the filesystem to use the dedicated
 	 * helpers. Other filesystem can continue to use ia_{g,u}id until they
 	 * have been ported.
+	 *
+	 * They always contain the same value. In other words FS_ALLOW_IDMAP
+	 * pass down the same value on idmapped mounts as they would on regular
+	 * mounts.
 	 */
 	union {
 		kuid_t		ia_uid;
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 0342ff6584fd..0d8625d71733 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -24,8 +24,8 @@ static inline bool is_quota_modification(struct user_namespace *mnt_userns,
 					 struct inode *inode, struct iattr *ia)
 {
 	return ((ia->ia_valid & ATTR_SIZE) ||
-		i_uid_needs_update(&init_user_ns, ia, inode) ||
-		i_gid_needs_update(&init_user_ns, ia, inode));
+		i_uid_needs_update(mnt_userns, ia, inode) ||
+		i_gid_needs_update(mnt_userns, ia, inode));
 }
 
 #if defined(CONFIG_QUOTA)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 7f4af5b58583..93e8bc047a73 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -761,8 +761,8 @@ static int evm_attr_change(struct user_namespace *mnt_userns,
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
 
-	if (!i_uid_needs_update(&init_user_ns, attr, inode) &&
-	    !i_gid_needs_update(&init_user_ns, attr, inode) &&
+	if (!i_uid_needs_update(mnt_userns, attr, inode) &&
+	    !i_gid_needs_update(mnt_userns, attr, inode) &&
 	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
 		return 0;
 
-- 
2.34.1

