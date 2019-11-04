Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A21EDCE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfKDKwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:46590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfKDKwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64D46B1D2;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 22F4E1E4852; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/7] quota: Simplify dquot_resume()
Date:   Mon,  4 Nov 2019 11:51:50 +0100
Message-Id: <20191104105207.1530-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We already have quota inode loaded when resuming quotas. Use
vfs_load_quota() to avoid some pointless churn with the quota inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9e8eb6e71675..ecdae91029ed 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2438,7 +2438,6 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 int dquot_resume(struct super_block *sb, int type)
 {
 	struct quota_info *dqopt = sb_dqopt(sb);
-	struct inode *inode;
 	int ret = 0, cnt;
 	unsigned int flags;
 
@@ -2452,8 +2451,6 @@ int dquot_resume(struct super_block *sb, int type)
 		if (!sb_has_quota_suspended(sb, cnt))
 			continue;
 
-		inode = dqopt->files[cnt];
-		dqopt->files[cnt] = NULL;
 		spin_lock(&dq_state_lock);
 		flags = dqopt->flags & dquot_state_flag(DQUOT_USAGE_ENABLED |
 							DQUOT_LIMITS_ENABLED,
@@ -2462,9 +2459,10 @@ int dquot_resume(struct super_block *sb, int type)
 		spin_unlock(&dq_state_lock);
 
 		flags = dquot_generic_flag(flags, cnt);
-		ret = vfs_load_quota_inode(inode, cnt,
-				dqopt->info[cnt].dqi_fmt_id, flags);
-		iput(inode);
+		ret = dquot_load_quota_sb(sb, cnt, dqopt->info[cnt].dqi_fmt_id,
+					  flags);
+		if (ret < 0)
+			vfs_cleanup_quota_inode(sb, type);
 	}
 
 	return ret;
-- 
2.16.4

