Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670E255344B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbiFUOPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350916AbiFUOPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A9E1FCE4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 07:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF4B361653
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D775C341C7;
        Tue, 21 Jun 2022 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655820921;
        bh=zHpFbVwQ9mHYqLNPNkPrTOlWepN854+uKfDIMSLCdR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtoO5y1RzvLFqHmijc1ur1m4Ol1F1luwVQnP+HP+r3iaMAHQa+5aC7UT148ghM7w4
         RoMk21s9IbKkUTQbEUqrUnPN+zps+Cm0p73BPxSMm9hCy2R7vLG4Of+TBtDBh+AgQF
         jD9/lHaTvwAi4xvW9sNTEJBR2/5+7BQG++nHukAeo5e/pihb0pnhlhnzKvJITZNSps
         lS5jVye9rRTycVXJVJffxF413VrnwSu/ajYqMEAfvZ+E9jIORtZTvUuJFWdZCKurph
         Z+VXaov/R6puWSy3H6JuJ8hQb3Ly9Wlq0ox/i01D9zRsvb3GWQBc880LXQQtDDq7hH
         fQNS9C/zDb37w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 6/8] quota: port quota helpers mount ids
Date:   Tue, 21 Jun 2022 16:14:52 +0200
Message-Id: <20220621141454.2914719-7-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621141454.2914719-1-brauner@kernel.org>
References: <20220621141454.2914719-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9845; h=from:subject; bh=zHpFbVwQ9mHYqLNPNkPrTOlWepN854+uKfDIMSLCdR8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtvBQhfsPymqniet8d21PdNbSar9zpWnJXvG1rm8qSqcmT 79zh7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIjgeMDM+Fw99yxGtZmr9wLv9c5C Ft1C/hY2LnEvX9XULfVNN/jQz/y2XY6pxNPBesCrwpxc/I8thtV4jo67QDPKs3fZ4S5lfJCQA=
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

Port the is_quota_modification() and dqout_transfer() helper to type
safe vfs{g,u}id_t. Since these helpers are only called by a few
filesystems don't introduce a new helper but simply extend the existing
helpers to pass down the mount's idmapping.

Note, that this is a non-functional change, i.e. nothing will have
happened here or at the end of this series to how quota are done! This
a change necessary because we will at the end of this series make
ownership changes easier to reason about by keeping the original value
in struct iattr for both non-idmapped and idmapped mounts.

For now we always pass the initial idmapping which makes the idmapping
functions these helpers call nops.

This is done because we currently always pass the actual value to be
written to i_{g,u}id via struct iattr. While this allowed us to treat
the {g,u}id values in struct iattr as values that can be directly
written to inode->i_{g,u}id it also increases the potential for
confusion for filesystems.

Now that we are have dedicated types to prevent this confusion we will
ultimately only map the value from the idmapped mount into a filesystem
value that can be written to inode->i_{g,u}id when the filesystem
actually updates the inode. So pass down the initial idmapping until we
finished that conversion at which point we pass down the mount's
idmapping.

Since struct iattr uses an anonymous union with overlapping types as
supported by the C standard, filesystems that haven't converted to
ia_vfs{g,u}id won't see any difference and things will continue to work
as before. In other words, no functional changes intended with this
change.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
- Linus Torvalds <torvalds@linux-foundation.org>:
  - Rename s/kmnt{g,u}id_t/vfs{g,u}id_t/g
---
 fs/ext2/inode.c          | 4 ++--
 fs/ext4/inode.c          | 4 ++--
 fs/f2fs/file.c           | 4 ++--
 fs/f2fs/recovery.c       | 2 +-
 fs/jfs/file.c            | 4 ++--
 fs/ocfs2/file.c          | 2 +-
 fs/quota/dquot.c         | 3 ++-
 fs/reiserfs/inode.c      | 4 ++--
 fs/zonefs/super.c        | 2 +-
 include/linux/quotaops.h | 9 ++++++---
 10 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 6dc66ab97d20..593b79416e0e 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1679,14 +1679,14 @@ int ext2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		return error;
 
-	if (is_quota_modification(inode, iattr)) {
+	if (is_quota_modification(&init_user_ns, inode, iattr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
 	}
 	if (i_uid_needs_update(&init_user_ns, iattr, inode) ||
 	    i_gid_needs_update(&init_user_ns, iattr, inode)) {
-		error = dquot_transfer(inode, iattr);
+		error = dquot_transfer(&init_user_ns, inode, iattr);
 		if (error)
 			return error;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 05d932f81c53..72f08c184768 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5350,7 +5350,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		return error;
 
-	if (is_quota_modification(inode, attr)) {
+	if (is_quota_modification(&init_user_ns, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
@@ -5374,7 +5374,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 * counts xattr inode references.
 		 */
 		down_read(&EXT4_I(inode)->xattr_sem);
-		error = dquot_transfer(inode, attr);
+		error = dquot_transfer(&init_user_ns, inode, attr);
 		up_read(&EXT4_I(inode)->xattr_sem);
 
 		if (error) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a35d6b12bd63..02b2d56d4edc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -915,7 +915,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (err)
 		return err;
 
-	if (is_quota_modification(inode, attr)) {
+	if (is_quota_modification(&init_user_ns, inode, attr)) {
 		err = f2fs_dquot_initialize(inode);
 		if (err)
 			return err;
@@ -923,7 +923,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (i_uid_needs_update(&init_user_ns, attr, inode) ||
 	    i_gid_needs_update(&init_user_ns, attr, inode)) {
 		f2fs_lock_op(F2FS_I_SB(inode));
-		err = dquot_transfer(inode, attr);
+		err = dquot_transfer(&init_user_ns, inode, attr);
 		if (err) {
 			set_sbi_flag(F2FS_I_SB(inode),
 					SBI_QUOTA_NEED_REPAIR);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 3cb7f8a43b4d..8e5a089f1ac8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -266,7 +266,7 @@ static int recover_quota_data(struct inode *inode, struct page *page)
 	if (!attr.ia_valid)
 		return 0;
 
-	err = dquot_transfer(inode, &attr);
+	err = dquot_transfer(&init_user_ns, inode, &attr);
 	if (err)
 		set_sbi_flag(F2FS_I_SB(inode), SBI_QUOTA_NEED_REPAIR);
 	return err;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 1d732fd223d4..c18569b9895d 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -95,14 +95,14 @@ int jfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (rc)
 		return rc;
 
-	if (is_quota_modification(inode, iattr)) {
+	if (is_quota_modification(&init_user_ns, inode, iattr)) {
 		rc = dquot_initialize(inode);
 		if (rc)
 			return rc;
 	}
 	if ((iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    (iattr->ia_valid & ATTR_GID && !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		rc = dquot_transfer(inode, iattr);
+		rc = dquot_transfer(&init_user_ns, inode, iattr);
 		if (rc)
 			return rc;
 	}
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 7497cd592258..0e09cd8911da 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1146,7 +1146,7 @@ int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (status)
 		return status;
 
-	if (is_quota_modification(inode, attr)) {
+	if (is_quota_modification(&init_user_ns, inode, attr)) {
 		status = dquot_initialize(inode);
 		if (status)
 			return status;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6cec2bfbf51b..df9af1ce2851 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2085,7 +2085,8 @@ EXPORT_SYMBOL(__dquot_transfer);
 /* Wrapper for transferring ownership of an inode for uid/gid only
  * Called from FSXXX_setattr()
  */
-int dquot_transfer(struct inode *inode, struct iattr *iattr)
+int dquot_transfer(struct user_namespace *mnt_userns, struct inode *inode,
+		   struct iattr *iattr)
 {
 	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct dquot *dquot;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 0cffe054b78e..1e89e76972a0 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3284,7 +3284,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	/* must be turned off for recursive notify_change calls */
 	ia_valid = attr->ia_valid &= ~(ATTR_KILL_SUID|ATTR_KILL_SGID);
 
-	if (is_quota_modification(inode, attr)) {
+	if (is_quota_modification(&init_user_ns, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
 			return error;
@@ -3367,7 +3367,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		reiserfs_write_unlock(inode->i_sb);
 		if (error)
 			goto out;
-		error = dquot_transfer(inode, attr);
+		error = dquot_transfer(&init_user_ns, inode, attr);
 		reiserfs_write_lock(inode->i_sb);
 		if (error) {
 			journal_end(&th);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 053299758deb..dd422b1d7320 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -616,7 +616,7 @@ static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
 	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
 	    ((iattr->ia_valid & ATTR_GID) &&
 	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		ret = dquot_transfer(inode, iattr);
+		ret = dquot_transfer(&init_user_ns, inode, iattr);
 		if (ret)
 			return ret;
 	}
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 61ee34861ca2..0342ff6584fd 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -20,7 +20,8 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
 }
 
 /* i_mutex must being held */
-static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
+static inline bool is_quota_modification(struct user_namespace *mnt_userns,
+					 struct inode *inode, struct iattr *ia)
 {
 	return ((ia->ia_valid & ATTR_SIZE) ||
 		i_uid_needs_update(&init_user_ns, ia, inode) ||
@@ -115,7 +116,8 @@ int dquot_set_dqblk(struct super_block *sb, struct kqid id,
 		struct qc_dqblk *di);
 
 int __dquot_transfer(struct inode *inode, struct dquot **transfer_to);
-int dquot_transfer(struct inode *inode, struct iattr *iattr);
+int dquot_transfer(struct user_namespace *mnt_userns, struct inode *inode,
+		   struct iattr *iattr);
 
 static inline struct mem_dqinfo *sb_dqinfo(struct super_block *sb, int type)
 {
@@ -234,7 +236,8 @@ static inline void dquot_free_inode(struct inode *inode)
 {
 }
 
-static inline int dquot_transfer(struct inode *inode, struct iattr *iattr)
+static inline int dquot_transfer(struct user_namespace *mnt_userns,
+				 struct inode *inode, struct iattr *iattr)
 {
 	return 0;
 }
-- 
2.34.1

