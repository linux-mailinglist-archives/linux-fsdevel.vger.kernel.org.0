Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30492E9EDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJ3P1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:27:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39095 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfJ3P1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:27:06 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsG-0003Y0-Ol; Wed, 30 Oct 2019 16:27:04 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsF-0005n6-Rl; Wed, 30 Oct 2019 16:27:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 02/10] quota: Pass sb to vfs_load_quota_inode()
Date:   Wed, 30 Oct 2019 16:26:54 +0100
Message-Id: <20191030152702.14269-3-s.hauer@pengutronix.de>
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

As a preparation to support filesystems that do not store quota files in
an inode pass the superblock to vfs_load_quota_inode(). With this we no
longer have to get the superblock from the inode and thus the inode
could be NULL.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/dquot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 59f31735fe79..bbe3be21ff43 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2303,11 +2303,11 @@ EXPORT_SYMBOL(dquot_quota_off);
  * Helper function to turn quotas on when we already have the inode of
  * quota file and no quota information is loaded.
  */
-static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
+static int vfs_load_quota_inode(struct super_block *sb, struct inode *inode,
+				int type, int format_id,
 	unsigned int flags)
 {
 	struct quota_format_type *fmt = find_quota_format(format_id);
-	struct super_block *sb = inode->i_sb;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int error;
 
@@ -2443,7 +2443,7 @@ int dquot_resume(struct super_block *sb, int type)
 		spin_unlock(&dq_state_lock);
 
 		flags = dquot_generic_flag(flags, cnt);
-		ret = vfs_load_quota_inode(inode, cnt,
+		ret = vfs_load_quota_inode(sb, inode, cnt,
 				dqopt->info[cnt].dqi_fmt_id, flags);
 		iput(inode);
 	}
@@ -2462,7 +2462,7 @@ int dquot_quota_on(struct super_block *sb, int type, int format_id,
 	if (path->dentry->d_sb != sb)
 		error = -EXDEV;
 	else
-		error = vfs_load_quota_inode(d_inode(path->dentry), type,
+		error = vfs_load_quota_inode(sb, d_inode(path->dentry), type,
 					     format_id, DQUOT_USAGE_ENABLED |
 					     DQUOT_LIMITS_ENABLED);
 	return error;
@@ -2500,7 +2500,7 @@ int dquot_enable(struct inode *inode, int type, int format_id,
 		return 0;
 	}
 
-	return vfs_load_quota_inode(inode, type, format_id, flags);
+	return vfs_load_quota_inode(sb, inode, type, format_id, flags);
 }
 EXPORT_SYMBOL(dquot_enable);
 
@@ -2525,7 +2525,7 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
 
 	error = security_quota_on(dentry);
 	if (!error)
-		error = vfs_load_quota_inode(d_inode(dentry), type, format_id,
+		error = vfs_load_quota_inode(sb, d_inode(dentry), type, format_id,
 				DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 out:
-- 
2.24.0.rc1

