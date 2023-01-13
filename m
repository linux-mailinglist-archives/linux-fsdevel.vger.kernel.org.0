Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065EB66960C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbjAMLxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbjAMLw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98123DBCF
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E060B82121
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3778C43398;
        Fri, 13 Jan 2023 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610616;
        bh=Fhx2XS2hFX01is1iJykDsw5dFnA8Istc/f1v5M6rK5o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DKfowGiwtk14cIqtI0yTztDknMMTF7W1gC0uP/jPOF9QQDl2I0i+pIWrGUTpTbggq
         1eiEnDE4FFG4HjlqPbfzWqttMIjEoUW7ugKLccOKsgP/adECyRUCBptXzOxHPjaAme
         Dkps/5Y4kl2RPMt9TTuZyHci44tKDUq6l0w2UtGj2/q/QuGxJ/nC9m9yGV/KB/0PFn
         ve/tFW9735a562E/zK3Et9Nk/cktRXQSSY4GzH3bP8bKROkoeubSKD+jw4LCe6yCHA
         GleHmlo6EH+Ra18RD/2LDmT8+PTzcCXzhy+b2IsXvC1biODLghW5OYLPICkC/21seO
         3NFw3QF4BnK6w==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:29 +0100
Subject: [PATCH 21/25] fs: port i_{g,u}id_{needs_}update() to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-21-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=11907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Fhx2XS2hFX01is1iJykDsw5dFnA8Istc/f1v5M6rK5o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA15yi2w8HT27DeOwZvPfU2U9irrVZE+Zb4nikdVe8Ht
 6qdrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyrYKR4XrVQuUf9+edEYhl/cM8m0
 GIpbkmv4KnQfbgKV+XTRmL1jEyHHOa/oR/xRTrdUcqpnflcv6VPPn+ut39Wxc+L+Xuf3jkKT8A
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
 fs/attr.c                         |  4 ++--
 fs/ext4/inode.c                   |  9 ++++-----
 fs/f2fs/file.c                    | 13 ++++++-------
 fs/quota/dquot.c                  |  4 ++--
 fs/xfs/xfs_iops.c                 |  4 ++--
 include/linux/fs.h                | 24 ++++++++++++++++--------
 include/linux/quotaops.h          |  5 ++---
 security/integrity/evm/evm_main.c |  5 ++---
 8 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 2cadd055dbf2..bbb9118c6c8b 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -311,8 +311,8 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	unsigned int ia_valid = attr->ia_valid;
 
-	i_uid_update(mnt_userns, attr, inode);
-	i_gid_update(mnt_userns, attr, inode);
+	i_uid_update(idmap, attr, inode);
+	i_gid_update(idmap, attr, inode);
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8b9b1cb6e3ab..be664dc9b991 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5442,7 +5442,6 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	int orphan = 0;
 	const unsigned int ia_valid = attr->ia_valid;
 	bool inc_ivers = true;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
@@ -5473,8 +5472,8 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			return error;
 	}
 
-	if (i_uid_needs_update(mnt_userns, attr, inode) ||
-	    i_gid_needs_update(mnt_userns, attr, inode)) {
+	if (i_uid_needs_update(idmap, attr, inode) ||
+	    i_gid_needs_update(idmap, attr, inode)) {
 		handle_t *handle;
 
 		/* (user+group)*(old+new) structure, inode write (sb,
@@ -5500,8 +5499,8 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		}
 		/* Update corresponding info in inode so that everything is in
 		 * one transaction */
-		i_uid_update(mnt_userns, attr, inode);
-		i_gid_update(mnt_userns, attr, inode);
+		i_uid_update(idmap, attr, inode);
+		i_gid_update(idmap, attr, inode);
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 262c831e3450..577c1613b6cf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -909,8 +909,8 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 	unsigned int ia_valid = attr->ia_valid;
 	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
-	i_uid_update(mnt_userns, attr, inode);
-	i_gid_update(mnt_userns, attr, inode);
+	i_uid_update(idmap, attr, inode);
+	i_gid_update(idmap, attr, inode);
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
@@ -934,7 +934,6 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	int err;
 
@@ -970,8 +969,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (err)
 			return err;
 	}
-	if (i_uid_needs_update(mnt_userns, attr, inode) ||
-	    i_gid_needs_update(mnt_userns, attr, inode)) {
+	if (i_uid_needs_update(idmap, attr, inode) ||
+	    i_gid_needs_update(idmap, attr, inode)) {
 		f2fs_lock_op(F2FS_I_SB(inode));
 		err = dquot_transfer(idmap, inode, attr);
 		if (err) {
@@ -984,8 +983,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * update uid/gid under lock_op(), so that dquot and inode can
 		 * be updated atomically.
 		 */
-		i_uid_update(mnt_userns, attr, inode);
-		i_gid_update(mnt_userns, attr, inode);
+		i_uid_update(idmap, attr, inode);
+		i_gid_update(idmap, attr, inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 		f2fs_unlock_op(F2FS_I_SB(inode));
 	}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6ae106c0f146..207434a854f3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2097,7 +2097,7 @@ int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 	if (!dquot_active(inode))
 		return 0;
 
-	if (i_uid_needs_update(mnt_userns, iattr, inode)) {
+	if (i_uid_needs_update(idmap, iattr, inode)) {
 		kuid_t kuid = from_vfsuid(mnt_userns, i_user_ns(inode),
 					  iattr->ia_vfsuid);
 
@@ -2111,7 +2111,7 @@ int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 		}
 		transfer_to[USRQUOTA] = dquot;
 	}
-	if (i_gid_needs_update(mnt_userns, iattr, inode)) {
+	if (i_gid_needs_update(idmap, iattr, inode)) {
 		kgid_t kgid = from_vfsgid(mnt_userns, i_user_ns(inode),
 					  iattr->ia_vfsgid);
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 94c2f4aa675a..c6284fb9e136 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -720,12 +720,12 @@ xfs_setattr_nonsize(
 	 * also.
 	 */
 	if (XFS_IS_UQUOTA_ON(mp) &&
-	    i_uid_needs_update(mnt_userns, iattr, inode)) {
+	    i_uid_needs_update(idmap, iattr, inode)) {
 		ASSERT(udqp);
 		old_udqp = xfs_qm_vop_chown(tp, ip, &ip->i_udquot, udqp);
 	}
 	if (XFS_IS_GQUOTA_ON(mp) &&
-	    i_gid_needs_update(mnt_userns, iattr, inode)) {
+	    i_gid_needs_update(idmap, iattr, inode)) {
 		ASSERT(xfs_has_pquotino(mp) || !XFS_IS_PQUOTA_ON(mp));
 		ASSERT(gdqp);
 		old_gdqp = xfs_qm_vop_chown(tp, ip, &ip->i_gdquot, gdqp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 696540a86183..3611d459bf88 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1647,7 +1647,7 @@ static inline vfsuid_t i_uid_into_vfsuid(struct user_namespace *mnt_userns,
 
 /**
  * i_uid_needs_update - check whether inode's i_uid needs to be updated
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @attr: the new attributes of @inode
  * @inode: the inode to update
  *
@@ -1656,10 +1656,12 @@ static inline vfsuid_t i_uid_into_vfsuid(struct user_namespace *mnt_userns,
  *
  * Return: true if @inode's i_uid field needs to be updated, false if not.
  */
-static inline bool i_uid_needs_update(struct user_namespace *mnt_userns,
+static inline bool i_uid_needs_update(struct mnt_idmap *idmap,
 				      const struct iattr *attr,
 				      const struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	return ((attr->ia_valid & ATTR_UID) &&
 		!vfsuid_eq(attr->ia_vfsuid,
 			   i_uid_into_vfsuid(mnt_userns, inode)));
@@ -1667,17 +1669,19 @@ static inline bool i_uid_needs_update(struct user_namespace *mnt_userns,
 
 /**
  * i_uid_update - update @inode's i_uid field
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @attr: the new attributes of @inode
  * @inode: the inode to update
  *
  * Safely update @inode's i_uid field translating the vfsuid of any idmapped
  * mount into the filesystem kuid.
  */
-static inline void i_uid_update(struct user_namespace *mnt_userns,
+static inline void i_uid_update(struct mnt_idmap *idmap,
 				const struct iattr *attr,
 				struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	if (attr->ia_valid & ATTR_UID)
 		inode->i_uid = from_vfsuid(mnt_userns, i_user_ns(inode),
 					   attr->ia_vfsuid);
@@ -1699,7 +1703,7 @@ static inline vfsgid_t i_gid_into_vfsgid(struct user_namespace *mnt_userns,
 
 /**
  * i_gid_needs_update - check whether inode's i_gid needs to be updated
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @attr: the new attributes of @inode
  * @inode: the inode to update
  *
@@ -1708,10 +1712,12 @@ static inline vfsgid_t i_gid_into_vfsgid(struct user_namespace *mnt_userns,
  *
  * Return: true if @inode's i_gid field needs to be updated, false if not.
  */
-static inline bool i_gid_needs_update(struct user_namespace *mnt_userns,
+static inline bool i_gid_needs_update(struct mnt_idmap *idmap,
 				      const struct iattr *attr,
 				      const struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	return ((attr->ia_valid & ATTR_GID) &&
 		!vfsgid_eq(attr->ia_vfsgid,
 			   i_gid_into_vfsgid(mnt_userns, inode)));
@@ -1719,17 +1725,19 @@ static inline bool i_gid_needs_update(struct user_namespace *mnt_userns,
 
 /**
  * i_gid_update - update @inode's i_gid field
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @attr: the new attributes of @inode
  * @inode: the inode to update
  *
  * Safely update @inode's i_gid field translating the vfsgid of any idmapped
  * mount into the filesystem kgid.
  */
-static inline void i_gid_update(struct user_namespace *mnt_userns,
+static inline void i_gid_update(struct mnt_idmap *idmap,
 				const struct iattr *attr,
 				struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	if (attr->ia_valid & ATTR_GID)
 		inode->i_gid = from_vfsgid(mnt_userns, i_user_ns(inode),
 					   attr->ia_vfsgid);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 5f6744b3ceac..11a4becff3a9 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -23,10 +23,9 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
 static inline bool is_quota_modification(struct mnt_idmap *idmap,
 					 struct inode *inode, struct iattr *ia)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return ((ia->ia_valid & ATTR_SIZE) ||
-		i_uid_needs_update(mnt_userns, ia, inode) ||
-		i_gid_needs_update(mnt_userns, ia, inode));
+		i_uid_needs_update(idmap, ia, inode) ||
+		i_gid_needs_update(idmap, ia, inode));
 }
 
 #if defined(CONFIG_QUOTA)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 4e5adddb3577..cf24c5255583 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -783,11 +783,10 @@ static int evm_attr_change(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	unsigned int ia_valid = attr->ia_valid;
 
-	if (!i_uid_needs_update(mnt_userns, attr, inode) &&
-	    !i_gid_needs_update(mnt_userns, attr, inode) &&
+	if (!i_uid_needs_update(idmap, attr, inode) &&
+	    !i_gid_needs_update(idmap, attr, inode) &&
 	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
 		return 0;
 

-- 
2.34.1

