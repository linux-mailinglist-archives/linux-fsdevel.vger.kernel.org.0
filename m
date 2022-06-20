Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3F551EE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiFTOfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245638AbiFTOeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993FBBE32
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B85BBCE1382
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4889EC3411B;
        Mon, 20 Jun 2022 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733012;
        bh=3iiAhMJJp6kLFkbixbF93I+dD6b/kXr3s0ILEWprESc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXkh9Tb18BtRX9zfhpSrsNPMtVuHhc3/Z3F9jY7DlHEu6nOeAyO2kaB5IzfbY9Crf
         p/Sab2efBTKozfLMH4qS6CjEKKVJQLbN69kOCnPv/MSezOg1oREdr5HMBoBERi4/74
         VteM869skRbkKw02QbaRlCmQ667wSEN+Rv9BO/fWUslzafffGDTVCyVVAQ0UM/iSKM
         L2xgthk7Tq7/6Ax3POAHFeMOX10BrldsvFL6sHXmwOoQn4XuABhAKKqjUPDuS0IiaC
         tUjA5oXe4XNi9ltuJleE2d1d5zZ8gCDC6xJv6qtcbXphjvVD7Pleb3F5q4w3YvM9+j
         VjOHiGUz1uFsQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/8] fs: port to iattr ownership update helpers
Date:   Mon, 20 Jun 2022 15:49:44 +0200
Message-Id: <20220620134947.2772863-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620134947.2772863-1-brauner@kernel.org>
References: <20220620134947.2772863-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8910; h=from:subject; bh=3iiAhMJJp6kLFkbixbF93I+dD6b/kXr3s0ILEWprESc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHrzTCHRb2Lsq6AaL5Essc60r4rHCqaZRDaYeoa12xcd O+jTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBFrCYa/gk1HE88YTlaNiM6cued6Rs Dj998/buPfnXVO7mm2vnBmGcM/TWN/W53s9MZ4yy6J60ueh6nnL/ocpZZ6SfvMjrJ0x3N8AA==
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

Earlier we introduce tiny new helpers to abstract ownership update and
remove code duplications. This converts all filesystems supporting
idmapped mounts to make use of these new helpers.

For now we always pass the initial idmapping which makes the idmapping
functions these helpers call nops.

This is done because we currently always pass the actual value to be
written to i_{g,u}id via struct iattr. While this allowed us to treat
the {g,u}id values in struct iattr as values that can be directly
written to inode->i_{g,u}id it also increases the potential for
confusion for filesystems.

Now that we are about to introduce dedicated types to prevent this
confusion we will ultimately only map the value from the idmapped mount
into a filesystem value that can be written to inode->i_{g,u}id when the
filesystem actually updates the inode. So pass down the initial
idmapping until we finished that conversion.

No functional changes intended.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/attr.c                         |  6 ++----
 fs/ext2/inode.c                   |  4 ++--
 fs/ext4/inode.c                   | 10 ++++------
 fs/f2fs/file.c                    | 18 ++++++------------
 fs/quota/dquot.c                  |  4 ++--
 fs/xfs/xfs_iops.c                 |  8 ++++----
 include/linux/quotaops.h          |  6 +++---
 security/integrity/evm/evm_main.c |  4 ++--
 8 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index dbe996b0dedf..2e180dd9460f 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -242,10 +242,8 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
 {
 	unsigned int ia_valid = attr->ia_valid;
 
-	if (ia_valid & ATTR_UID)
-		inode->i_uid = attr->ia_uid;
-	if (ia_valid & ATTR_GID)
-		inode->i_gid = attr->ia_gid;
+	i_uid_update(&init_user_ns, attr, inode);
+	i_gid_update(&init_user_ns, attr, inode);
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index e6b932219803..6dc66ab97d20 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1684,8 +1684,8 @@ int ext2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (error)
 			return error;
 	}
-	if ((iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)) ||
-	    (iattr->ia_valid & ATTR_GID && !gid_eq(iattr->ia_gid, inode->i_gid))) {
+	if (i_uid_needs_update(&init_user_ns, iattr, inode) ||
+	    i_gid_needs_update(&init_user_ns, iattr, inode)) {
 		error = dquot_transfer(inode, iattr);
 		if (error)
 			return error;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 84c0eb55071d..05d932f81c53 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5356,8 +5356,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			return error;
 	}
 
-	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
-	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
+	if (i_uid_needs_update(&init_user_ns, attr, inode) ||
+	    i_gid_needs_update(&init_user_ns, attr, inode)) {
 		handle_t *handle;
 
 		/* (user+group)*(old+new) structure, inode write (sb,
@@ -5383,10 +5383,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 		/* Update corresponding info in inode so that everything is in
 		 * one transaction */
-		if (attr->ia_valid & ATTR_UID)
-			inode->i_uid = attr->ia_uid;
-		if (attr->ia_valid & ATTR_GID)
-			inode->i_gid = attr->ia_gid;
+		i_uid_update(&init_user_ns, attr, inode);
+		i_gid_update(&init_user_ns, attr, inode);
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bd14cef1b08f..a35d6b12bd63 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -861,10 +861,8 @@ static void __setattr_copy(struct user_namespace *mnt_userns,
 {
 	unsigned int ia_valid = attr->ia_valid;
 
-	if (ia_valid & ATTR_UID)
-		inode->i_uid = attr->ia_uid;
-	if (ia_valid & ATTR_GID)
-		inode->i_gid = attr->ia_gid;
+	i_uid_update(&init_user_ns, attr, inode);
+	i_gid_update(&init_user_ns, attr, inode);
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
@@ -922,10 +920,8 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (err)
 			return err;
 	}
-	if ((attr->ia_valid & ATTR_UID &&
-		!uid_eq(attr->ia_uid, inode->i_uid)) ||
-		(attr->ia_valid & ATTR_GID &&
-		!gid_eq(attr->ia_gid, inode->i_gid))) {
+	if (i_uid_needs_update(&init_user_ns, attr, inode) ||
+	    i_gid_needs_update(&init_user_ns, attr, inode)) {
 		f2fs_lock_op(F2FS_I_SB(inode));
 		err = dquot_transfer(inode, attr);
 		if (err) {
@@ -938,10 +934,8 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 * update uid/gid under lock_op(), so that dquot and inode can
 		 * be updated atomically.
 		 */
-		if (attr->ia_valid & ATTR_UID)
-			inode->i_uid = attr->ia_uid;
-		if (attr->ia_valid & ATTR_GID)
-			inode->i_gid = attr->ia_gid;
+		i_uid_update(&init_user_ns, attr, inode);
+		i_gid_update(&init_user_ns, attr, inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 		f2fs_unlock_op(F2FS_I_SB(inode));
 	}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 09d1307959d0..6cec2bfbf51b 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2095,7 +2095,7 @@ int dquot_transfer(struct inode *inode, struct iattr *iattr)
 	if (!dquot_active(inode))
 		return 0;
 
-	if (iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)){
+	if (i_uid_needs_update(&init_user_ns, iattr, inode)) {
 		dquot = dqget(sb, make_kqid_uid(iattr->ia_uid));
 		if (IS_ERR(dquot)) {
 			if (PTR_ERR(dquot) != -ESRCH) {
@@ -2106,7 +2106,7 @@ int dquot_transfer(struct inode *inode, struct iattr *iattr)
 		}
 		transfer_to[USRQUOTA] = dquot;
 	}
-	if (iattr->ia_valid & ATTR_GID && !gid_eq(iattr->ia_gid, inode->i_gid)){
+	if (i_gid_needs_update(&init_user_ns, iattr, inode)) {
 		dquot = dqget(sb, make_kqid_gid(iattr->ia_gid));
 		if (IS_ERR(dquot)) {
 			if (PTR_ERR(dquot) != -ESRCH) {
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 29f5b8b8aca6..31ec29565fb4 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -704,13 +704,13 @@ xfs_setattr_nonsize(
 	 * didn't have the inode locked, inode's dquot(s) would have changed
 	 * also.
 	 */
-	if ((mask & ATTR_UID) && XFS_IS_UQUOTA_ON(mp) &&
-	    !uid_eq(inode->i_uid, iattr->ia_uid)) {
+	if (XFS_IS_UQUOTA_ON(mp) &&
+	    i_uid_needs_update(&init_user_ns, iattr, inode)) {
 		ASSERT(udqp);
 		old_udqp = xfs_qm_vop_chown(tp, ip, &ip->i_udquot, udqp);
 	}
-	if ((mask & ATTR_GID) && XFS_IS_GQUOTA_ON(mp) &&
-	    !gid_eq(inode->i_gid, iattr->ia_gid)) {
+	if (XFS_IS_GQUOTA_ON(mp) &&
+	    i_gid_needs_update(&init_user_ns, iattr, inode)) {
 		ASSERT(xfs_has_pquotino(mp) || !XFS_IS_PQUOTA_ON(mp));
 		ASSERT(gdqp);
 		old_gdqp = xfs_qm_vop_chown(tp, ip, &ip->i_gdquot, gdqp);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index a0f6668924d3..61ee34861ca2 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -22,9 +22,9 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
 /* i_mutex must being held */
 static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
 {
-	return (ia->ia_valid & ATTR_SIZE) ||
-		(ia->ia_valid & ATTR_UID && !uid_eq(ia->ia_uid, inode->i_uid)) ||
-		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
+	return ((ia->ia_valid & ATTR_SIZE) ||
+		i_uid_needs_update(&init_user_ns, ia, inode) ||
+		i_gid_needs_update(&init_user_ns, ia, inode));
 }
 
 #if defined(CONFIG_QUOTA)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cc88f02c7562..bcde6bc2a2ce 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -760,8 +760,8 @@ static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
 
-	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid)) &&
-	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
+	if (!i_uid_needs_update(&init_user_ns, attr, inode) &&
+	    !i_gid_needs_update(&init_user_ns, attr, inode) &&
 	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
 		return 0;
 
-- 
2.34.1

