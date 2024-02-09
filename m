Return-Path: <linux-fsdevel+bounces-10932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7284F48B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F86E1C254B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176762E40F;
	Fri,  9 Feb 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NymLM4rr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HCdjr2Zd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NymLM4rr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HCdjr2Zd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75F2DF7D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477778; cv=none; b=Zb+CW3zrcilOkWoNDsfwC28iBG+DmFhGYjBBt5ygDZi6dET18Z63/F40UD5i/HYCPzKdGT+XiKAiPnjKAesuceRxDryzAwvfrP9fFY1H/ukl3p5lHxmtEyxsHJOrpW+KOqH0hsoviVL/NFxz+WL5YVp8IAymCcPas1qwigdicYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477778; c=relaxed/simple;
	bh=oWHjGJDx2qPGIzf2FOZ+ir335vkCevM39rmr26B0Ick=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7B1kdepMRcVBYZ0GVOxKl2kcZIL3zB3XV8TnVl89QixCQUE7V2yz1bTzWLCJ2CGUc7dfpjKVqLwr5MeL8WpLs2TBVcMQqiqnNwHVtO0KD9d36UR7E7rNokrQz43hSA//7V3kZ4UXnsD+//8bqrJoWgvg4naIm8ekVL1SJhI5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NymLM4rr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HCdjr2Zd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NymLM4rr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HCdjr2Zd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85BEF22062;
	Fri,  9 Feb 2024 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F32loJOi8iZSOXugKhUAJ0di0f4H6ECm5wl3COxl7j8=;
	b=NymLM4rrSVAmyhYpm0YIaYyESE4xwmplZDzZvP36os3EWQtPpNPqpjxSAZ++fmNZD0OcNN
	HEruUT5dCdHAFRyNg/r5pCVaSQbVlm3mG1vWLz7GVLPo/yE1ToP73GD+D27A6mpXwCBmiY
	FvrcQXQUXwwG90AvZHk0tkKi0LpDnPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F32loJOi8iZSOXugKhUAJ0di0f4H6ECm5wl3COxl7j8=;
	b=HCdjr2Zdc4KzlmxicqTaa37rwGHHjMKrjdOESRcuWXV4xBywVIC0J+HOS8zkHHV4HeAIYS
	xoFieZ4pEWu3isBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F32loJOi8iZSOXugKhUAJ0di0f4H6ECm5wl3COxl7j8=;
	b=NymLM4rrSVAmyhYpm0YIaYyESE4xwmplZDzZvP36os3EWQtPpNPqpjxSAZ++fmNZD0OcNN
	HEruUT5dCdHAFRyNg/r5pCVaSQbVlm3mG1vWLz7GVLPo/yE1ToP73GD+D27A6mpXwCBmiY
	FvrcQXQUXwwG90AvZHk0tkKi0LpDnPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F32loJOi8iZSOXugKhUAJ0di0f4H6ECm5wl3COxl7j8=;
	b=HCdjr2Zdc4KzlmxicqTaa37rwGHHjMKrjdOESRcuWXV4xBywVIC0J+HOS8zkHHV4HeAIYS
	xoFieZ4pEWu3isBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AE6A139E7;
	Fri,  9 Feb 2024 11:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 21n/HQ4LxmUpNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Feb 2024 11:22:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 306F5A0809; Fri,  9 Feb 2024 12:22:54 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH] quota: Detect loops in quota tree
Date: Fri,  9 Feb 2024 12:22:50 +0100
Message-Id: <20240209112250.10894-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10135; i=jack@suse.cz; h=from:subject; bh=oWHjGJDx2qPGIzf2FOZ+ir335vkCevM39rmr26B0Ick=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlxgsJTMv44EFrbhK464ZWbIUwswi7u20ZWuDpJY9p ILTtYACJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcYLCQAKCRCcnaoHP2RA2UtACA CGqvoyJ459arBmTFR7IUSwapJrobC186HkueWGzM7xDFPLIx4WNcv4ECcEZrL2QhhhsjSyEne+sEni Lxfj8m5alaG5EIxzlqPBf9yvZefKs+5i2wHs1jjv+EbHOFrd7Vbl8nClmi05uWV6lmf3lM01kR9KRq xP+358/8cxenWWA2hXPPQBAF8MfNyxAqkJuBr6MyRfDTwpv848sLyUjw4QU/4kiPqMfHU+QScL838Y ueS5o2R9AS9PGRya40eIzl0NIfuTy+1VbKod9kmdOg2PArkZnbGR64HP9S+DD7zkbaegMuYe7XWWBs p6G9NfIkd05/F9R1IEGJO9kKtSFu2T
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ********
X-Spam-Score: 8.80
X-Spamd-Result: default: False [8.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Syzbot has found that when it creates corrupted quota files where the
quota tree contains a loop, we will deadlock when tryling to insert a
dquot. Add loop detection into functions traversing the quota tree.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/quota_tree.c | 126 +++++++++++++++++++++++++++++++-----------
 fs/quota/quota_v2.c   |  15 +++--
 2 files changed, 104 insertions(+), 37 deletions(-)

I plan to merge this fix into my tree.

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 0f1493e0f6d0..bc8e7e16b164 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -21,6 +21,12 @@ MODULE_AUTHOR("Jan Kara");
 MODULE_DESCRIPTION("Quota trie support");
 MODULE_LICENSE("GPL");
 
+/*
+ * Maximum quota tree depth we support. Only to limit recursion when working
+ * with the tree.
+ */
+#define MAX_QTREE_DEPTH 6
+
 #define __QUOTA_QT_PARANOIA
 
 static int __get_index(struct qtree_mem_dqinfo *info, qid_t id, int depth)
@@ -327,27 +333,36 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 
 /* Insert reference to structure into the trie */
 static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
-			  uint *treeblk, int depth)
+			  uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0, newson = 0, newact = 0;
 	__le32 *ref;
 	uint newblk;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	if (!*treeblk) {
+	if (!blks[depth]) {
 		ret = get_free_dqblk(info);
 		if (ret < 0)
 			goto out_buf;
-		*treeblk = ret;
+		for (i = 0; i < depth; i++)
+			if (ret == blks[i]) {
+				quota_error(dquot->dq_sb,
+					"Free block already used in tree: block %u",
+					ret);
+				ret = -EIO;
+				goto out_buf;
+			}
+		blks[depth] = ret;
 		memset(buf, 0, info->dqi_usable_bs);
 		newact = 1;
 	} else {
-		ret = read_blk(info, *treeblk, buf);
+		ret = read_blk(info, blks[depth], buf);
 		if (ret < 0) {
 			quota_error(dquot->dq_sb, "Can't read tree quota "
-				    "block %u", *treeblk);
+				    "block %u", blks[depth]);
 			goto out_buf;
 		}
 	}
@@ -357,8 +372,20 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			     info->dqi_blocks - 1);
 	if (ret)
 		goto out_buf;
-	if (!newblk)
+	if (!newblk) {
 		newson = 1;
+	} else {
+		for (i = 0; i <= depth; i++)
+			if (newblk == blks[i]) {
+				quota_error(dquot->dq_sb,
+					"Cycle in quota tree detected: block %u index %u",
+					blks[depth],
+					get_index(info, dquot->dq_id, depth));
+				ret = -EIO;
+				goto out_buf;
+			}
+	}
+	blks[depth + 1] = newblk;
 	if (depth == info->dqi_qtree_depth - 1) {
 #ifdef __QUOTA_QT_PARANOIA
 		if (newblk) {
@@ -370,16 +397,16 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			goto out_buf;
 		}
 #endif
-		newblk = find_free_dqentry(info, dquot, &ret);
+		blks[depth + 1] = find_free_dqentry(info, dquot, &ret);
 	} else {
-		ret = do_insert_tree(info, dquot, &newblk, depth+1);
+		ret = do_insert_tree(info, dquot, blks, depth + 1);
 	}
 	if (newson && ret >= 0) {
 		ref[get_index(info, dquot->dq_id, depth)] =
-							cpu_to_le32(newblk);
-		ret = write_blk(info, *treeblk, buf);
+						cpu_to_le32(blks[depth + 1]);
+		ret = write_blk(info, blks[depth], buf);
 	} else if (newact && ret < 0) {
-		put_free_dqblk(info, buf, *treeblk);
+		put_free_dqblk(info, buf, blks[depth]);
 	}
 out_buf:
 	kfree(buf);
@@ -390,7 +417,7 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
 				 struct dquot *dquot)
 {
-	int tmp = QT_TREEOFF;
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
 
 #ifdef __QUOTA_QT_PARANOIA
 	if (info->dqi_blocks <= QT_TREEOFF) {
@@ -398,7 +425,11 @@ static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
 		return -EIO;
 	}
 #endif
-	return do_insert_tree(info, dquot, &tmp, 0);
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return do_insert_tree(info, dquot, blks, 0);
 }
 
 /*
@@ -511,19 +542,20 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 
 /* Remove reference to dquot from tree */
 static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
-		       uint *blk, int depth)
+		       uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0;
 	uint newblk;
 	__le32 *ref = (__le32 *)buf;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	ret = read_blk(info, *blk, buf);
+	ret = read_blk(info, blks[depth], buf);
 	if (ret < 0) {
 		quota_error(dquot->dq_sb, "Can't read quota data block %u",
-			    *blk);
+			    blks[depth]);
 		goto out_buf;
 	}
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
@@ -532,29 +564,38 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 	if (ret)
 		goto out_buf;
 
+	for (i = 0; i <= depth; i++)
+		if (newblk == blks[i]) {
+			quota_error(dquot->dq_sb,
+				"Cycle in quota tree detected: block %u index %u",
+				blks[depth],
+				get_index(info, dquot->dq_id, depth));
+			ret = -EIO;
+			goto out_buf;
+		}
 	if (depth == info->dqi_qtree_depth - 1) {
 		ret = free_dqentry(info, dquot, newblk);
-		newblk = 0;
+		blks[depth + 1] = 0;
 	} else {
-		ret = remove_tree(info, dquot, &newblk, depth+1);
+		blks[depth + 1] = newblk;
+		ret = remove_tree(info, dquot, blks, depth + 1);
 	}
-	if (ret >= 0 && !newblk) {
-		int i;
+	if (ret >= 0 && !blks[depth + 1]) {
 		ref[get_index(info, dquot->dq_id, depth)] = cpu_to_le32(0);
 		/* Block got empty? */
 		for (i = 0; i < (info->dqi_usable_bs >> 2) && !ref[i]; i++)
 			;
 		/* Don't put the root block into the free block list */
 		if (i == (info->dqi_usable_bs >> 2)
-		    && *blk != QT_TREEOFF) {
-			put_free_dqblk(info, buf, *blk);
-			*blk = 0;
+		    && blks[depth] != QT_TREEOFF) {
+			put_free_dqblk(info, buf, blks[depth]);
+			blks[depth] = 0;
 		} else {
-			ret = write_blk(info, *blk, buf);
+			ret = write_blk(info, blks[depth], buf);
 			if (ret < 0)
 				quota_error(dquot->dq_sb,
 					    "Can't write quota tree block %u",
-					    *blk);
+					    blks[depth]);
 		}
 	}
 out_buf:
@@ -565,11 +606,15 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 /* Delete dquot from tree */
 int qtree_delete_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
 {
-	uint tmp = QT_TREEOFF;
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
 
 	if (!dquot->dq_off)	/* Even not allocated? */
 		return 0;
-	return remove_tree(info, dquot, &tmp, 0);
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return remove_tree(info, dquot, blks, 0);
 }
 EXPORT_SYMBOL(qtree_delete_dquot);
 
@@ -613,15 +658,17 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 
 /* Find entry for given id in the tree */
 static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
-				struct dquot *dquot, uint blk, int depth)
+				struct dquot *dquot, uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	loff_t ret = 0;
 	__le32 *ref = (__le32 *)buf;
+	uint blk;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	ret = read_blk(info, blk, buf);
+	ret = read_blk(info, blks[depth], buf);
 	if (ret < 0) {
 		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
 			    blk);
@@ -636,8 +683,19 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	if (ret)
 		goto out_buf;
 
+	/* Check for cycles in the tree */
+	for (i = 0; i <= depth; i++)
+		if (blk == blks[i]) {
+			quota_error(dquot->dq_sb,
+				"Cycle in quota tree detected: block %u index %u",
+				blks[depth],
+				get_index(info, dquot->dq_id, depth));
+			ret = -EIO;
+			goto out_buf;
+		}
+	blks[depth + 1] = blk;
 	if (depth < info->dqi_qtree_depth - 1)
-		ret = find_tree_dqentry(info, dquot, blk, depth+1);
+		ret = find_tree_dqentry(info, dquot, blks, depth + 1);
 	else
 		ret = find_block_dqentry(info, dquot, blk);
 out_buf:
@@ -649,7 +707,13 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 static inline loff_t find_dqentry(struct qtree_mem_dqinfo *info,
 				  struct dquot *dquot)
 {
-	return find_tree_dqentry(info, dquot, QT_TREEOFF, 0);
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
+
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return find_tree_dqentry(info, dquot, blks, 0);
 }
 
 int qtree_read_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index ae99e7b88205..7978ab671e0c 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -166,14 +166,17 @@ static int v2_read_file_info(struct super_block *sb, int type)
 		    i_size_read(sb_dqopt(sb)->files[type]));
 		goto out_free;
 	}
-	if (qinfo->dqi_free_blk >= qinfo->dqi_blocks) {
-		quota_error(sb, "Free block number too big (%u >= %u).",
-			    qinfo->dqi_free_blk, qinfo->dqi_blocks);
+	if (qinfo->dqi_free_blk && (qinfo->dqi_free_blk <= QT_TREEOFF ||
+	    qinfo->dqi_free_blk >= qinfo->dqi_blocks)) {
+		quota_error(sb, "Free block number %u out of range (%u, %u).",
+			    qinfo->dqi_free_blk, QT_TREEOFF, qinfo->dqi_blocks);
 		goto out_free;
 	}
-	if (qinfo->dqi_free_entry >= qinfo->dqi_blocks) {
-		quota_error(sb, "Block with free entry too big (%u >= %u).",
-			    qinfo->dqi_free_entry, qinfo->dqi_blocks);
+	if (qinfo->dqi_free_entry && (qinfo->dqi_free_entry <= QT_TREEOFF ||
+	    qinfo->dqi_free_entry >= qinfo->dqi_blocks)) {
+		quota_error(sb, "Block with free entry %u out of range (%u, %u).",
+			    qinfo->dqi_free_entry, QT_TREEOFF,
+			    qinfo->dqi_blocks);
 		goto out_free;
 	}
 	ret = 0;
-- 
2.35.3


