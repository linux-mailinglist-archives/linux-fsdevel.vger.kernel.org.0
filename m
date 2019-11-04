Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69483EDCE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfKDKwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:46584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfKDKwJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 652ABB1DC;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1EBFA1E4218; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/7] quota: Factor out setup of quota inode
Date:   Mon,  4 Nov 2019 11:51:49 +0100
Message-Id: <20191104105207.1530-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out setting up of quota inode and eventual error cleanup from
vfs_load_quota_inode(). This will simplify situation for filesystems
that don't have any quota inodes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c         | 108 +++++++++++++++++++++++++++++------------------
 include/linux/quotaops.h |   2 +
 2 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..9e8eb6e71675 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2299,28 +2299,60 @@ EXPORT_SYMBOL(dquot_quota_off);
  *	Turn quotas on on a device
  */
 
-/*
- * Helper function to turn quotas on when we already have the inode of
- * quota file and no quota information is loaded.
- */
-static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
+static int vfs_setup_quota_inode(struct inode *inode, int type)
+{
+	struct super_block *sb = inode->i_sb;
+	struct quota_info *dqopt = sb_dqopt(sb);
+
+	if (!S_ISREG(inode->i_mode))
+		return -EACCES;
+	if (IS_RDONLY(inode))
+		return -EROFS;
+	if (sb_has_quota_loaded(sb, type))
+		return -EBUSY;
+
+	dqopt->files[type] = igrab(inode);
+	if (!dqopt->files[type])
+		return -EIO;
+	if (!(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
+		/* We don't want quota and atime on quota files (deadlocks
+		 * possible) Also nobody should write to the file - we use
+		 * special IO operations which ignore the immutable bit. */
+		inode_lock(inode);
+		inode->i_flags |= S_NOQUOTA;
+		inode_unlock(inode);
+		/*
+		 * When S_NOQUOTA is set, remove dquot references as no more
+		 * references can be added
+		 */
+		__dquot_drop(inode);
+	}
+	return 0;
+}
+
+static void vfs_cleanup_quota_inode(struct super_block *sb, int type)
+{
+	struct quota_info *dqopt = sb_dqopt(sb);
+	struct inode *inode = dqopt->files[type];
+
+	if (!(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
+		inode_lock(inode);
+		inode->i_flags &= ~S_NOQUOTA;
+		inode_unlock(inode);
+	}
+	dqopt->files[type] = NULL;
+	iput(inode);
+}
+
+int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	unsigned int flags)
 {
 	struct quota_format_type *fmt = find_quota_format(format_id);
-	struct super_block *sb = inode->i_sb;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int error;
 
 	if (!fmt)
 		return -ESRCH;
-	if (!S_ISREG(inode->i_mode)) {
-		error = -EACCES;
-		goto out_fmt;
-	}
-	if (IS_RDONLY(inode)) {
-		error = -EROFS;
-		goto out_fmt;
-	}
 	if (!sb->s_op->quota_write || !sb->s_op->quota_read ||
 	    (type == PRJQUOTA && sb->dq_op->get_projid == NULL)) {
 		error = -EINVAL;
@@ -2352,27 +2384,9 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 		invalidate_bdev(sb->s_bdev);
 	}
 
-	if (!(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
-		/* We don't want quota and atime on quota files (deadlocks
-		 * possible) Also nobody should write to the file - we use
-		 * special IO operations which ignore the immutable bit. */
-		inode_lock(inode);
-		inode->i_flags |= S_NOQUOTA;
-		inode_unlock(inode);
-		/*
-		 * When S_NOQUOTA is set, remove dquot references as no more
-		 * references can be added
-		 */
-		__dquot_drop(inode);
-	}
-
-	error = -EIO;
-	dqopt->files[type] = igrab(inode);
-	if (!dqopt->files[type])
-		goto out_file_flags;
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
-		goto out_file_init;
+		goto out_fmt;
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
@@ -2380,7 +2394,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 	INIT_LIST_HEAD(&dqopt->info[type].dqi_dirty_list);
 	error = dqopt->ops[type]->read_file_info(sb, type);
 	if (error < 0)
-		goto out_file_init;
+		goto out_fmt;
 	if (dqopt->flags & DQUOT_QUOTA_SYS_FILE) {
 		spin_lock(&dq_data_lock);
 		dqopt->info[type].dqi_flags |= DQF_SYS_FILE;
@@ -2395,18 +2409,30 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 		dquot_disable(sb, type, flags);
 
 	return error;
-out_file_init:
-	dqopt->files[type] = NULL;
-	iput(inode);
-out_file_flags:
-	inode_lock(inode);
-	inode->i_flags &= ~S_NOQUOTA;
-	inode_unlock(inode);
 out_fmt:
 	put_quota_format(fmt);
 
 	return error;
 }
+EXPORT_SYMBOL(dquot_load_quota_sb);
+
+/*
+ * Helper function to turn quotas on when we already have the inode of
+ * quota file and no quota information is loaded.
+ */
+static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
+	unsigned int flags)
+{
+	int err;
+
+	err = vfs_setup_quota_inode(inode, type);
+	if (err < 0)
+		return err;
+	err = dquot_load_quota_sb(inode->i_sb, type, format_id, flags);
+	if (err < 0)
+		vfs_cleanup_quota_inode(inode->i_sb, type);
+	return err;
+}
 
 /* Reenable quotas on remount RW */
 int dquot_resume(struct super_block *sb, int type)
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 185d94829701..2625766bcfe7 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -89,6 +89,8 @@ int dquot_file_open(struct inode *inode, struct file *file);
 
 int dquot_enable(struct inode *inode, int type, int format_id,
 	unsigned int flags);
+int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
+	unsigned int flags);
 int dquot_quota_on(struct super_block *sb, int type, int format_id,
 	const struct path *path);
 int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
-- 
2.16.4

