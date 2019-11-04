Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529E0EDCEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfKDKwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:46592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728310AbfKDKwJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65201B1D8;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 25F6B1E4809; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/7] quota: Rename vfs_load_quota_inode() to dquot_load_quota_inode()
Date:   Mon,  4 Nov 2019 11:51:51 +0100
Message-Id: <20191104105207.1530-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename vfs_load_quota_inode() to dquot_load_quota_inode() to be
consistent with naming of other functions used for enabling quota
accounting from filesystems. Also export the function and add some
sanity checks to assure filesystems are calling the function properly.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c         | 19 +++++++++++++------
 include/linux/quotaops.h |  2 ++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index ecdae91029ed..0ddcbce596f8 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2351,6 +2351,12 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int error;
 
+	/* Just unsuspend quotas? */
+	BUG_ON(flags & DQUOT_SUSPENDED);
+	/* s_umount should be held in exclusive mode */
+	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
+		up_read(&sb->s_umount);
+
 	if (!fmt)
 		return -ESRCH;
 	if (!sb->s_op->quota_write || !sb->s_op->quota_read ||
@@ -2417,10 +2423,10 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 EXPORT_SYMBOL(dquot_load_quota_sb);
 
 /*
- * Helper function to turn quotas on when we already have the inode of
- * quota file and no quota information is loaded.
+ * More powerful function for turning on quotas on given quota inode allowing
+ * setting of individual quota flags
  */
-static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
+int dquot_load_quota_inode(struct inode *inode, int type, int format_id,
 	unsigned int flags)
 {
 	int err;
@@ -2433,6 +2439,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 		vfs_cleanup_quota_inode(inode->i_sb, type);
 	return err;
 }
+EXPORT_SYMBOL(dquot_load_quota_inode);
 
 /* Reenable quotas on remount RW */
 int dquot_resume(struct super_block *sb, int type)
@@ -2479,7 +2486,7 @@ int dquot_quota_on(struct super_block *sb, int type, int format_id,
 	if (path->dentry->d_sb != sb)
 		error = -EXDEV;
 	else
-		error = vfs_load_quota_inode(d_inode(path->dentry), type,
+		error = dquot_load_quota_inode(d_inode(path->dentry), type,
 					     format_id, DQUOT_USAGE_ENABLED |
 					     DQUOT_LIMITS_ENABLED);
 	return error;
@@ -2517,7 +2524,7 @@ int dquot_enable(struct inode *inode, int type, int format_id,
 		return 0;
 	}
 
-	return vfs_load_quota_inode(inode, type, format_id, flags);
+	return dquot_load_quota_inode(inode, type, format_id, flags);
 }
 EXPORT_SYMBOL(dquot_enable);
 
@@ -2542,7 +2549,7 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
 
 	error = security_quota_on(dentry);
 	if (!error)
-		error = vfs_load_quota_inode(d_inode(dentry), type, format_id,
+		error = dquot_load_quota_inode(d_inode(dentry), type, format_id,
 				DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 out:
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 2625766bcfe7..0ce9da5a1a93 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -91,6 +91,8 @@ int dquot_enable(struct inode *inode, int type, int format_id,
 	unsigned int flags);
 int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	unsigned int flags);
+int dquot_load_quota_inode(struct inode *inode, int type, int format_id,
+	unsigned int flags);
 int dquot_quota_on(struct super_block *sb, int type, int format_id,
 	const struct path *path);
 int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
-- 
2.16.4

