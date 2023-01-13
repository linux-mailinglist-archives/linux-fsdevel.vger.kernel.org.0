Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9346695F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbjAMLxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjAMLw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B79321B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB8F7B8212D
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72459C433F2;
        Fri, 13 Jan 2023 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610614;
        bh=ie/q/hD9M2b7kQRaKMH/F1yIcmnmuTu+x+GfCilWxmw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uL65JjIAEUcwp3E1hBYre7T7scxovM6Sidwcea94TDkrm+kj2aMbuz0XqjUVeAzjy
         WPHDoaFAncwKGj135NGcJTvC4rHV8Wv+WBIy1cYcwLfS5+QsCJlEjC9DkyCxiu+F9C
         oUbefuVDl6vxfmFoWyYnLWRop1vYI4M7/9X51CRKPNBB+Fwl3Lj16cEBXo2Dr5xakk
         BuTZTzJVO/8Gh66K8Cy6zFC9rXevrFAfbukEM3cX04fvZKRVVveyWdaKZ2bAeNKBHt
         +1mF0dwz4sCzdV1XBJPx84u06qe4qYSV+7SXXg33iG4eNIB15YPr2OSIY4FZ6ksN2y
         VdCFea8U2ENEw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:28 +0100
Subject: [PATCH 20/25] quota: port to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-20-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=9662; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ie/q/hD9M2b7kQRaKMH/F1yIcmnmuTu+x+GfCilWxmw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA3Z3/Ph21LV7O79zx2zjMsFTSKOv4/fcfTuWgHx1BCf
 RTufdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkdz7D/6I97FbuNxWmLNpn0fzxzF
 WNnvJzLOwLWRZyFRS7HpjTqcDI8J7/w3LVjUe37X474dLCNO9wg9p+zULbtQtPLWGU3X5anBkA
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
 fs/ext2/inode.c          | 9 ++++-----
 fs/ext4/inode.c          | 4 ++--
 fs/f2fs/file.c           | 4 ++--
 fs/f2fs/recovery.c       | 2 +-
 fs/jfs/file.c            | 4 ++--
 fs/ocfs2/file.c          | 3 +--
 fs/quota/dquot.c         | 3 ++-
 fs/reiserfs/inode.c      | 4 ++--
 fs/zonefs/super.c        | 2 +-
 include/linux/quotaops.h | 7 ++++---
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index fb7fdadefd3d..26f135e7ffce 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1621,7 +1621,6 @@ int ext2_getattr(struct mnt_idmap *idmap, const struct path *path,
 int ext2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *iattr)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	int error;
 
@@ -1629,14 +1628,14 @@ int ext2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		return error;
 
-	if (is_quota_modification(mnt_userns, inode, iattr)) {
+	if (is_quota_modification(&nop_mnt_idmap, inode, iattr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
 	}
-	if (i_uid_needs_update(mnt_userns, iattr, inode) ||
-	    i_gid_needs_update(mnt_userns, iattr, inode)) {
-		error = dquot_transfer(mnt_userns, inode, iattr);
+	if (i_uid_needs_update(&nop_mnt_idmap, iattr, inode) ||
+	    i_gid_needs_update(&nop_mnt_idmap, iattr, inode)) {
+		error = dquot_transfer(&nop_mnt_idmap, inode, iattr);
 		if (error)
 			return error;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3aae0be8c91e..8b9b1cb6e3ab 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5467,7 +5467,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		return error;
 
-	if (is_quota_modification(mnt_userns, inode, attr)) {
+	if (is_quota_modification(idmap, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
@@ -5491,7 +5491,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * counts xattr inode references.
 		 */
 		down_read(&EXT4_I(inode)->xattr_sem);
-		error = dquot_transfer(mnt_userns, inode, attr);
+		error = dquot_transfer(idmap, inode, attr);
 		up_read(&EXT4_I(inode)->xattr_sem);
 
 		if (error) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b1486bdc83fb..262c831e3450 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -965,7 +965,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (err)
 		return err;
 
-	if (is_quota_modification(mnt_userns, inode, attr)) {
+	if (is_quota_modification(idmap, inode, attr)) {
 		err = f2fs_dquot_initialize(inode);
 		if (err)
 			return err;
@@ -973,7 +973,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (i_uid_needs_update(mnt_userns, attr, inode) ||
 	    i_gid_needs_update(mnt_userns, attr, inode)) {
 		f2fs_lock_op(F2FS_I_SB(inode));
-		err = dquot_transfer(mnt_userns, inode, attr);
+		err = dquot_transfer(idmap, inode, attr);
 		if (err) {
 			set_sbi_flag(F2FS_I_SB(inode),
 					SBI_QUOTA_NEED_REPAIR);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 77fd453949b1..ac0149e0e98c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -266,7 +266,7 @@ static int recover_quota_data(struct inode *inode, struct page *page)
 	if (!attr.ia_valid)
 		return 0;
 
-	err = dquot_transfer(&init_user_ns, inode, &attr);
+	err = dquot_transfer(&nop_mnt_idmap, inode, &attr);
 	if (err)
 		set_sbi_flag(F2FS_I_SB(inode), SBI_QUOTA_NEED_REPAIR);
 	return err;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index c2cfb8033b1f..2ee35be49de1 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -95,14 +95,14 @@ int jfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (rc)
 		return rc;
 
-	if (is_quota_modification(&init_user_ns, inode, iattr)) {
+	if (is_quota_modification(&nop_mnt_idmap, inode, iattr)) {
 		rc = dquot_initialize(inode);
 		if (rc)
 			return rc;
 	}
 	if ((iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    (iattr->ia_valid & ATTR_GID && !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		rc = dquot_transfer(&init_user_ns, inode, iattr);
+		rc = dquot_transfer(&nop_mnt_idmap, inode, iattr);
 		if (rc)
 			return rc;
 	}
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 805a95e35f4c..efb09de4343d 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1114,7 +1114,6 @@ static int ocfs2_extend_file(struct inode *inode,
 int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int status = 0, size_change;
 	int inode_locked = 0;
 	struct inode *inode = d_inode(dentry);
@@ -1147,7 +1146,7 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (status)
 		return status;
 
-	if (is_quota_modification(mnt_userns, inode, attr)) {
+	if (is_quota_modification(&nop_mnt_idmap, inode, attr)) {
 		status = dquot_initialize(inode);
 		if (status)
 			return status;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f27faf5db554..6ae106c0f146 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2085,9 +2085,10 @@ EXPORT_SYMBOL(__dquot_transfer);
 /* Wrapper for transferring ownership of an inode for uid/gid only
  * Called from FSXXX_setattr()
  */
-int dquot_transfer(struct user_namespace *mnt_userns, struct inode *inode,
+int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 		   struct iattr *iattr)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct dquot *dquot;
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 35b9b8ec1cbe..d54cab854f60 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3276,7 +3276,7 @@ int reiserfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* must be turned off for recursive notify_change calls */
 	ia_valid = attr->ia_valid &= ~(ATTR_KILL_SUID|ATTR_KILL_SGID);
 
-	if (is_quota_modification(&init_user_ns, inode, attr)) {
+	if (is_quota_modification(&nop_mnt_idmap, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
@@ -3359,7 +3359,7 @@ int reiserfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		reiserfs_write_unlock(inode->i_sb);
 		if (error)
 			goto out;
-		error = dquot_transfer(&init_user_ns, inode, attr);
+		error = dquot_transfer(&nop_mnt_idmap, inode, attr);
 		reiserfs_write_lock(inode->i_sb);
 		if (error) {
 			journal_end(&th);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 371964ed09dc..cb29234fab7e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -626,7 +626,7 @@ static int zonefs_inode_setattr(struct mnt_idmap *idmap,
 	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    ((iattr->ia_valid & ATTR_GID) &&
 	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		ret = dquot_transfer(&init_user_ns, inode, iattr);
+		ret = dquot_transfer(&nop_mnt_idmap, inode, iattr);
 		if (ret)
 			return ret;
 	}
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 0d8625d71733..5f6744b3ceac 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -20,9 +20,10 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
 }
 
 /* i_mutex must being held */
-static inline bool is_quota_modification(struct user_namespace *mnt_userns,
+static inline bool is_quota_modification(struct mnt_idmap *idmap,
 					 struct inode *inode, struct iattr *ia)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return ((ia->ia_valid & ATTR_SIZE) ||
 		i_uid_needs_update(mnt_userns, ia, inode) ||
 		i_gid_needs_update(mnt_userns, ia, inode));
@@ -116,7 +117,7 @@ int dquot_set_dqblk(struct super_block *sb, struct kqid id,
 		struct qc_dqblk *di);
 
 int __dquot_transfer(struct inode *inode, struct dquot **transfer_to);
-int dquot_transfer(struct user_namespace *mnt_userns, struct inode *inode,
+int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 		   struct iattr *iattr);
 
 static inline struct mem_dqinfo *sb_dqinfo(struct super_block *sb, int type)
@@ -236,7 +237,7 @@ static inline void dquot_free_inode(struct inode *inode)
 {
 }
 
-static inline int dquot_transfer(struct user_namespace *mnt_userns,
+static inline int dquot_transfer(struct mnt_idmap *idmap,
 				 struct inode *inode, struct iattr *iattr)
 {
 	return 0;

-- 
2.34.1

