Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFFCEDCEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfKDKwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:46620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfKDKwL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B66BB201;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2EA9A1E4A8D; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/7] quota: Drop dquot_enable()
Date:   Mon,  4 Nov 2019 11:51:53 +0100
Message-Id: <20191104105207.1530-5-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now dquot_enable() has only two internal callers and both of them just
need to update quota flags and don't need most of checks. Just drop
dquot_enable() and fold necessary functionality into the two calling
places.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c         | 61 +++++++++++++-----------------------------------
 include/linux/quotaops.h |  2 --
 2 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 0ddcbce596f8..3e4cf0d10955 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2493,41 +2493,6 @@ int dquot_quota_on(struct super_block *sb, int type, int format_id,
 }
 EXPORT_SYMBOL(dquot_quota_on);
 
-/*
- * More powerful function for turning on quotas allowing setting
- * of individual quota flags
- */
-int dquot_enable(struct inode *inode, int type, int format_id,
-		 unsigned int flags)
-{
-	struct super_block *sb = inode->i_sb;
-
-	/* Just unsuspend quotas? */
-	BUG_ON(flags & DQUOT_SUSPENDED);
-	/* s_umount should be held in exclusive mode */
-	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
-		up_read(&sb->s_umount);
-
-	if (!flags)
-		return 0;
-	/* Just updating flags needed? */
-	if (sb_has_quota_loaded(sb, type)) {
-		if (flags & DQUOT_USAGE_ENABLED &&
-		    sb_has_quota_usage_enabled(sb, type))
-			return -EBUSY;
-		if (flags & DQUOT_LIMITS_ENABLED &&
-		    sb_has_quota_limits_enabled(sb, type))
-			return -EBUSY;
-		spin_lock(&dq_state_lock);
-		sb_dqopt(sb)->flags |= dquot_state_flag(flags, type);
-		spin_unlock(&dq_state_lock);
-		return 0;
-	}
-
-	return dquot_load_quota_inode(inode, type, format_id, flags);
-}
-EXPORT_SYMBOL(dquot_enable);
-
 /*
  * This function is used when filesystem needs to initialize quotas
  * during mount time.
@@ -2574,13 +2539,17 @@ static int dquot_quota_enable(struct super_block *sb, unsigned int flags)
 		if (!(flags & qtype_enforce_flag(type)))
 			continue;
 		/* Can't enforce without accounting */
-		if (!sb_has_quota_usage_enabled(sb, type))
-			return -EINVAL;
-		ret = dquot_enable(dqopt->files[type], type,
-				   dqopt->info[type].dqi_fmt_id,
-				   DQUOT_LIMITS_ENABLED);
-		if (ret < 0)
+		if (!sb_has_quota_usage_enabled(sb, type)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+		if (sb_has_quota_limits_enabled(sb, type)) {
+			ret = -EBUSY;
 			goto out_err;
+		}
+		spin_lock(&dq_state_lock);
+		dqopt->flags |= dquot_state_flag(DQUOT_LIMITS_ENABLED, type);
+		spin_unlock(&dq_state_lock);
 	}
 	return 0;
 out_err:
@@ -2630,10 +2599,12 @@ static int dquot_quota_disable(struct super_block *sb, unsigned int flags)
 out_err:
 	/* Backout enforcement disabling we already did */
 	for (type--; type >= 0; type--)  {
-		if (flags & qtype_enforce_flag(type))
-			dquot_enable(dqopt->files[type], type,
-				     dqopt->info[type].dqi_fmt_id,
-				     DQUOT_LIMITS_ENABLED);
+		if (flags & qtype_enforce_flag(type)) {
+			spin_lock(&dq_state_lock);
+			dqopt->flags |=
+				dquot_state_flag(DQUOT_LIMITS_ENABLED, type);
+			spin_unlock(&dq_state_lock);
+		}
 	}
 	return ret;
 }
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 0ce9da5a1a93..6b8ebc8d715e 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -87,8 +87,6 @@ int dquot_mark_dquot_dirty(struct dquot *dquot);
 
 int dquot_file_open(struct inode *inode, struct file *file);
 
-int dquot_enable(struct inode *inode, int type, int format_id,
-	unsigned int flags);
 int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	unsigned int flags);
 int dquot_load_quota_inode(struct inode *inode, int type, int format_id,
-- 
2.16.4

