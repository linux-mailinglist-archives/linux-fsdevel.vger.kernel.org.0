Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8ACE9EE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfJ3P1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:27:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34721 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfJ3P1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:27:38 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsG-0003Xz-Or; Wed, 30 Oct 2019 16:27:04 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsF-0005n4-R5; Wed, 30 Oct 2019 16:27:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 01/10] quota: Make inode optional
Date:   Wed, 30 Oct 2019 16:26:53 +0100
Message-Id: <20191030152702.14269-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030152702.14269-1-s.hauer@pengutronix.de>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To add support for filesystems which do not store quota informations in
an inode make the inode optional.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/dquot.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..59f31735fe79 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2313,11 +2313,11 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 
 	if (!fmt)
 		return -ESRCH;
-	if (!S_ISREG(inode->i_mode)) {
+	if (inode && !S_ISREG(inode->i_mode)) {
 		error = -EACCES;
 		goto out_fmt;
 	}
-	if (IS_RDONLY(inode)) {
+	if (inode && IS_RDONLY(inode)) {
 		error = -EROFS;
 		goto out_fmt;
 	}
@@ -2352,7 +2352,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 		invalidate_bdev(sb->s_bdev);
 	}
 
-	if (!(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
+	if (inode && !(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
 		/* We don't want quota and atime on quota files (deadlocks
 		 * possible) Also nobody should write to the file - we use
 		 * special IO operations which ignore the immutable bit. */
@@ -2367,9 +2367,13 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 	}
 
 	error = -EIO;
-	dqopt->files[type] = igrab(inode);
-	if (!dqopt->files[type])
-		goto out_file_flags;
+
+	if (inode) {
+		dqopt->files[type] = igrab(inode);
+		if (!dqopt->files[type])
+			goto out_file_flags;
+	}
+
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_file_init;
@@ -2397,11 +2401,14 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 	return error;
 out_file_init:
 	dqopt->files[type] = NULL;
-	iput(inode);
+	if (inode)
+		iput(inode);
 out_file_flags:
-	inode_lock(inode);
-	inode->i_flags &= ~S_NOQUOTA;
-	inode_unlock(inode);
+	if (inode) {
+		inode_lock(inode);
+		inode->i_flags &= ~S_NOQUOTA;
+		inode_unlock(inode);
+	}
 out_fmt:
 	put_quota_format(fmt);
 
@@ -2800,8 +2807,10 @@ int dquot_get_state(struct super_block *sb, struct qc_state *state)
 			tstate->flags |= QCI_LIMITS_ENFORCED;
 		tstate->spc_timelimit = mi->dqi_bgrace;
 		tstate->ino_timelimit = mi->dqi_igrace;
-		tstate->ino = dqopt->files[type]->i_ino;
-		tstate->blocks = dqopt->files[type]->i_blocks;
+		if (dqopt->files[type]) {
+			tstate->ino = dqopt->files[type]->i_ino;
+			tstate->blocks = dqopt->files[type]->i_blocks;
+		}
 		tstate->nextents = 1;	/* We don't know... */
 		spin_unlock(&dq_data_lock);
 	}
-- 
2.24.0.rc1

