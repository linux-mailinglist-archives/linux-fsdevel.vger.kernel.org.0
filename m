Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A77EDCE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfKDKwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:46614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbfKDKwK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B09BB200;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 31B941E4A92; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/7] quota: Make dquot_disable() work without quota inodes
Date:   Mon,  4 Nov 2019 11:51:54 +0100
Message-Id: <20191104105207.1530-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quota on and quota off are protected by s_umount semaphore held in
exclusive mode since commit 7d6cd73d33b6 "quota: Hold s_umount in
exclusive mode when enabling / disabling quotas". This makes it
impossible for dquot_disable() to race with other enabling or disabling
of quotas. Simplify the cleanup done by dquot_disable() based on this
fact and also remove some stale comments. As a bonus this cleanup makes
dquot_disable() properly handle a case when there are no quota inodes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 73 ++++++++++++++++++++++----------------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3e4cf0d10955..4c3da4ea31bc 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2162,14 +2162,29 @@ int dquot_file_open(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL(dquot_file_open);
 
+static void vfs_cleanup_quota_inode(struct super_block *sb, int type)
+{
+	struct quota_info *dqopt = sb_dqopt(sb);
+	struct inode *inode = dqopt->files[type];
+
+	if (!inode)
+		return;
+	if (!(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
+		inode_lock(inode);
+		inode->i_flags &= ~S_NOQUOTA;
+		inode_unlock(inode);
+	}
+	dqopt->files[type] = NULL;
+	iput(inode);
+}
+
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
  */
 int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 {
-	int cnt, ret = 0;
+	int cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
-	struct inode *toputinode[MAXQUOTAS];
 
 	/* s_umount should be held in exclusive mode */
 	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
@@ -2191,7 +2206,6 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 		return 0;
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		toputinode[cnt] = NULL;
 		if (type != -1 && cnt != type)
 			continue;
 		if (!sb_has_quota_loaded(sb, cnt))
@@ -2211,8 +2225,7 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 				dqopt->flags &=	~dquot_state_flag(
 							DQUOT_SUSPENDED, cnt);
 				spin_unlock(&dq_state_lock);
-				iput(dqopt->files[cnt]);
-				dqopt->files[cnt] = NULL;
+				vfs_cleanup_quota_inode(sb, cnt);
 				continue;
 			}
 			spin_unlock(&dq_state_lock);
@@ -2234,10 +2247,6 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 		if (dqopt->ops[cnt]->free_file_info)
 			dqopt->ops[cnt]->free_file_info(sb, cnt);
 		put_quota_format(dqopt->info[cnt].dqi_format);
-
-		toputinode[cnt] = dqopt->files[cnt];
-		if (!sb_has_quota_loaded(sb, cnt))
-			dqopt->files[cnt] = NULL;
 		dqopt->info[cnt].dqi_flags = 0;
 		dqopt->info[cnt].dqi_igrace = 0;
 		dqopt->info[cnt].dqi_bgrace = 0;
@@ -2259,32 +2268,22 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 	 * must also discard the blockdev buffers so that we see the
 	 * changes done by userspace on the next quotaon() */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		/* This can happen when suspending quotas on remount-ro... */
-		if (toputinode[cnt] && !sb_has_quota_loaded(sb, cnt)) {
-			inode_lock(toputinode[cnt]);
-			toputinode[cnt]->i_flags &= ~S_NOQUOTA;
-			truncate_inode_pages(&toputinode[cnt]->i_data, 0);
-			inode_unlock(toputinode[cnt]);
-			mark_inode_dirty_sync(toputinode[cnt]);
+		if (!sb_has_quota_loaded(sb, cnt) && dqopt->files[cnt]) {
+			inode_lock(dqopt->files[cnt]);
+			truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
+			inode_unlock(dqopt->files[cnt]);
 		}
 	if (sb->s_bdev)
 		invalidate_bdev(sb->s_bdev);
 put_inodes:
+	/* We are done when suspending quotas */
+	if (flags & DQUOT_SUSPENDED)
+		return 0;
+
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (toputinode[cnt]) {
-			/* On remount RO, we keep the inode pointer so that we
-			 * can reenable quota on the subsequent remount RW. We
-			 * have to check 'flags' variable and not use sb_has_
-			 * function because another quotaon / quotaoff could
-			 * change global state before we got here. We refuse
-			 * to suspend quotas when there is pending delete on
-			 * the quota file... */
-			if (!(flags & DQUOT_SUSPENDED))
-				iput(toputinode[cnt]);
-			else if (!toputinode[cnt]->i_nlink)
-				ret = -EBUSY;
-		}
-	return ret;
+		if (!sb_has_quota_loaded(sb, cnt))
+			vfs_cleanup_quota_inode(sb, cnt);
+	return 0;
 }
 EXPORT_SYMBOL(dquot_disable);
 
@@ -2330,20 +2329,6 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
 	return 0;
 }
 
-static void vfs_cleanup_quota_inode(struct super_block *sb, int type)
-{
-	struct quota_info *dqopt = sb_dqopt(sb);
-	struct inode *inode = dqopt->files[type];
-
-	if (!(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
-		inode_lock(inode);
-		inode->i_flags &= ~S_NOQUOTA;
-		inode_unlock(inode);
-	}
-	dqopt->files[type] = NULL;
-	iput(inode);
-}
-
 int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	unsigned int flags)
 {
-- 
2.16.4

