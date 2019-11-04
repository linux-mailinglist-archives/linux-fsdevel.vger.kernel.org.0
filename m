Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9909EDCE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfKDKwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:46586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbfKDKwJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65B4BB1F5;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2BD1C1E4A8C; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/7] fs: Use dquot_load_quota_inode() from filesystems
Date:   Mon,  4 Nov 2019 11:51:52 +0100
Message-Id: <20191104105207.1530-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use dquot_load_quota_inode from filesystems instead of dquot_enable().
In all three cases we want to load quota inode and never use the
function to update quota flags.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c  | 2 +-
 fs/f2fs/super.c  | 2 +-
 fs/ocfs2/super.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..1b947c95eff2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5835,7 +5835,7 @@ static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 	/* Don't account quota for quota files to avoid recursion */
 	qf_inode->i_flags |= S_NOQUOTA;
 	lockdep_set_quota_inode(qf_inode, I_DATA_SEM_QUOTA);
-	err = dquot_enable(qf_inode, type, format_id, flags);
+	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
 	if (err)
 		lockdep_set_quota_inode(qf_inode, I_DATA_SEM_NORMAL);
 	iput(qf_inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1443cee15863..91745d5b718d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1932,7 +1932,7 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 
 	/* Don't account quota for quota files to avoid recursion */
 	qf_inode->i_flags |= S_NOQUOTA;
-	err = dquot_enable(qf_inode, type, format_id, flags);
+	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
 	iput(qf_inode);
 	return err;
 }
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index c81e86c62380..05dd68ade293 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -926,8 +926,8 @@ static int ocfs2_enable_quotas(struct ocfs2_super *osb)
 			status = -ENOENT;
 			goto out_quota_off;
 		}
-		status = dquot_enable(inode[type], type, QFMT_OCFS2,
-				      DQUOT_USAGE_ENABLED);
+		status = dquot_load_quota_inode(inode[type], type, QFMT_OCFS2,
+						DQUOT_USAGE_ENABLED);
 		if (status < 0)
 			goto out_quota_off;
 	}
-- 
2.16.4

