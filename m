Return-Path: <linux-fsdevel+bounces-10584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F484C7C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA30028356B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB382374A;
	Wed,  7 Feb 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZdRocTA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5br5iwIj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZdRocTA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5br5iwIj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048012232E
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298935; cv=none; b=G0iBxed2Ak10otPDJZ8+DuS2Wq1oB1GTo3oeqNDjTZ4gHiCYDj/i4UPk3FDiluWxaAUGavA7TDa4XIF4O3/zKxlHWEM+7QTdCCarB0yayHR4j/AHh6UHxGGYvRhMDEhnvfP4e5pGLR4gfxFbY2TyHfnNyzxZgfYA4WqjcgGsoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298935; c=relaxed/simple;
	bh=l2b1repUtkuVUEEu9sIAen8PZONLPaSOjaEWXTAgElM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfcHj9UoBvNahz7MPz7tg+8fC3aJmtY9nWISVWGauadV8PItaaq9DLL/E1KU3XkCwhR9XH2WbzL1dRV9hOKOfaXm1CvhRROdlA7u8jNRRsp9YJEcERVtDVkLOD/q9l8RKKmFXXbVNqqJ/xnxdsUYWmGFmbhu0syicMlUKfrvqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZdRocTA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5br5iwIj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZdRocTA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5br5iwIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D27322175;
	Wed,  7 Feb 2024 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh1Z38mOGI5OiVSbnGwxgHBST6MJYuMY+hd96wNm2hA=;
	b=MZdRocTAej+2MvNEZ5Fd1bHhTSphMPD/6/glaKtOShZW1rXk2jKcd2H9bIqX1daLm6W+f+
	IJHdmrHc53yVQt7ZmEK/WfK2VExXyxjvKrnRSG3jmDMy+Mn06OsggQOtOZQKwnHDH9e12i
	7X6SkTpawPNLgVu0+v5ymMYkAc55PoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh1Z38mOGI5OiVSbnGwxgHBST6MJYuMY+hd96wNm2hA=;
	b=5br5iwIjc8PNT0PoAhmF+ggRq9J5ey89mBjhh5BoYy6ovFogewMFF1f0t3FGAwwm5qaQLN
	LaxL68WaDnDI8pBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh1Z38mOGI5OiVSbnGwxgHBST6MJYuMY+hd96wNm2hA=;
	b=MZdRocTAej+2MvNEZ5Fd1bHhTSphMPD/6/glaKtOShZW1rXk2jKcd2H9bIqX1daLm6W+f+
	IJHdmrHc53yVQt7ZmEK/WfK2VExXyxjvKrnRSG3jmDMy+Mn06OsggQOtOZQKwnHDH9e12i
	7X6SkTpawPNLgVu0+v5ymMYkAc55PoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh1Z38mOGI5OiVSbnGwxgHBST6MJYuMY+hd96wNm2hA=;
	b=5br5iwIjc8PNT0PoAhmF+ggRq9J5ey89mBjhh5BoYy6ovFogewMFF1f0t3FGAwwm5qaQLN
	LaxL68WaDnDI8pBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E3F313A43;
	Wed,  7 Feb 2024 09:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XftFC3NQw2V7UwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 09:42:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC35EA0807; Wed,  7 Feb 2024 10:42:10 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] quota: Fix rcu annotations of inode dquot pointers
Date: Wed,  7 Feb 2024 10:42:04 +0100
Message-Id: <20240207094210.17065-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240207093810.6579-1-jack@suse.cz>
References: <20240207093810.6579-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8287; i=jack@suse.cz; h=from:subject; bh=l2b1repUtkuVUEEu9sIAen8PZONLPaSOjaEWXTAgElM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlw1Bs2W+oRPWUY3vaTZh2wudybNTsLXhvv8zDrQKG h0FSEMSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcNQbAAKCRCcnaoHP2RA2faTB/ 0XNxW2S9y+1X/d62uygJiA6mn8S7G5pzU9KScElCG9HD+jjcpRGp33i2+U1m4sDOqo7ZRQqaB/MivE ZPZ41pX2QdMN8BAvj5qS8ubSYXRGgHrobfcotXxqzfiydFlFAHJ5VXrcSShqEV4fmiA6rrhZe9K9Dy Ft2NrGO0gSxBsJ6ZatzgD5JG3b+/n47vEthtdhItQ3z1ZxwjL/Yg7Ia/TEjuvZdow5O2eQ8M8EStVt s9x8CFBMG4vfI5H31iSxwt9riN2zd4SpnTif+r+u0bE48nGtUhX1WvOIm6aAxIPTfRhHOuZsAVcgZ1 CHeC5DOOhTZY772Vy2wzBDYZO7Pom8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **********
X-Spam-Score: 10.00
X-Spam-Flag: NO

Dquot pointers in i_dquot array in the inode are protected by
dquot_srcu. Annotate the array pointers with __rcu, perform the locked
dereferences with srcu_dereference_check() instead of plain reads, and
set the array elements with rcu_assign_pointer().

Fixes: b9ba6f94b238 ("quota: remove dqptr_sem")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402061900.rTuYDlo6-lkp@intel.com/
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index cafe65a03f6d..3a16867a6fbd 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -399,7 +399,7 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 EXPORT_SYMBOL(dquot_mark_dquot_dirty);
 
 /* Dirtify all the dquots - this can block when journalling */
-static inline int mark_all_dquot_dirty(struct dquot * const *dquots)
+static inline int mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
 {
 	int ret, err, cnt;
 	struct dquot *dquot;
@@ -1000,14 +1000,15 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 }
 EXPORT_SYMBOL(dqget);
 
-static inline struct dquot **i_dquot(struct inode *inode)
+static inline struct dquot __rcu **i_dquot(struct inode *inode)
 {
-	return inode->i_sb->s_op->get_dquots(inode);
+	/* Force __rcu for now until filesystems are fixed */
+	return (struct dquot __rcu **)inode->i_sb->s_op->get_dquots(inode);
 }
 
 static int dqinit_needed(struct inode *inode, int type)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1097,14 +1098,16 @@ static void remove_dquot_ref(struct super_block *sb, int type)
 		 */
 		spin_lock(&dq_data_lock);
 		if (!IS_NOQUOTA(inode)) {
-			struct dquot **dquots = i_dquot(inode);
-			struct dquot *dquot = dquots[type];
+			struct dquot __rcu **dquots = i_dquot(inode);
+			struct dquot *dquot = srcu_dereference_check(
+				dquots[type], &dquot_srcu,
+				lockdep_is_held(&dq_data_lock));
 
 #ifdef CONFIG_QUOTA_DEBUG
 			if (unlikely(inode_get_rsv_space(inode) > 0))
 				reserved = 1;
 #endif
-			dquots[type] = NULL;
+			rcu_assign_pointer(dquots[type], NULL);
 			if (dquot)
 				dqput(dquot);
 		}
@@ -1457,7 +1460,8 @@ static int inode_quota_active(const struct inode *inode)
 static int __dquot_initialize(struct inode *inode, int type)
 {
 	int cnt, init_needed = 0;
-	struct dquot **dquots, *got[MAXQUOTAS] = {};
+	struct dquot __rcu **dquots;
+	struct dquot *got[MAXQUOTAS] = {};
 	struct super_block *sb = inode->i_sb;
 	qsize_t rsv;
 	int ret = 0;
@@ -1532,7 +1536,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 		if (!got[cnt])
 			continue;
 		if (!dquots[cnt]) {
-			dquots[cnt] = got[cnt];
+			rcu_assign_pointer(dquots[cnt], got[cnt]);
 			got[cnt] = NULL;
 			/*
 			 * Make quota reservation system happy if someone
@@ -1540,12 +1544,16 @@ static int __dquot_initialize(struct inode *inode, int type)
 			 */
 			rsv = inode_get_rsv_space(inode);
 			if (unlikely(rsv)) {
+				struct dquot *dquot = srcu_dereference_check(
+					dquots[cnt], &dquot_srcu,
+					lockdep_is_held(&dq_data_lock));
+
 				spin_lock(&inode->i_lock);
 				/* Get reservation again under proper lock */
 				rsv = __inode_get_rsv_space(inode);
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquots[cnt]->dq_dqb.dqb_rsvspace += rsv;
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
+				dquot->dq_dqb.dqb_rsvspace += rsv;
+				spin_unlock(&dquot->dq_dqb_lock);
 				spin_unlock(&inode->i_lock);
 			}
 		}
@@ -1567,7 +1575,7 @@ EXPORT_SYMBOL(dquot_initialize);
 
 bool dquot_initialize_needed(struct inode *inode)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	int i;
 
 	if (!inode_quota_active(inode))
@@ -1592,13 +1600,14 @@ EXPORT_SYMBOL(dquot_initialize_needed);
 static void __dquot_drop(struct inode *inode)
 {
 	int cnt;
-	struct dquot **dquots = i_dquot(inode);
+	struct dquot __rcu **dquots = i_dquot(inode);
 	struct dquot *put[MAXQUOTAS];
 
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		put[cnt] = dquots[cnt];
-		dquots[cnt] = NULL;
+		put[cnt] = srcu_dereference_check(dquots[cnt], &dquot_srcu,
+					lockdep_is_held(&dq_data_lock));
+		rcu_assign_pointer(dquots[cnt], NULL);
 	}
 	spin_unlock(&dq_data_lock);
 	dqput_all(put);
@@ -1606,7 +1615,7 @@ static void __dquot_drop(struct inode *inode)
 
 void dquot_drop(struct inode *inode)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1679,7 +1688,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
@@ -1749,7 +1758,7 @@ int dquot_alloc_inode(struct inode *inode)
 {
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
@@ -1794,7 +1803,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
  */
 void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int cnt, index;
 
@@ -1836,7 +1845,7 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
  */
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int cnt, index;
 
@@ -1880,7 +1889,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
@@ -1937,7 +1946,7 @@ void dquot_free_inode(struct inode *inode)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	struct dquot *dquot;
 	int index;
 
@@ -1984,6 +1993,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t cur_space;
 	qsize_t rsv_space = 0;
 	qsize_t inode_usage = 1;
+	struct dquot __rcu **dquots;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
 	int cnt, index, ret = 0;
 	char is_valid[MAXQUOTAS] = {};
@@ -2016,6 +2026,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	}
 	cur_space = __inode_get_bytes(inode);
 	rsv_space = __inode_get_rsv_space(inode);
+	dquots = i_dquot(inode);
 	/*
 	 * Build the transfer_from list, check limits, and update usage in
 	 * the target structures.
@@ -2030,7 +2041,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 		if (!sb_has_quota_active(inode->i_sb, cnt))
 			continue;
 		is_valid[cnt] = 1;
-		transfer_from[cnt] = i_dquot(inode)[cnt];
+		transfer_from[cnt] = srcu_dereference_check(dquots[cnt],
+				&dquot_srcu, lockdep_is_held(&dq_data_lock));
 		ret = dquot_add_inodes(transfer_to[cnt], inode_usage,
 				       &warn_to[cnt]);
 		if (ret)
@@ -2069,7 +2081,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 						  rsv_space);
 			spin_unlock(&transfer_from[cnt]->dq_dqb_lock);
 		}
-		i_dquot(inode)[cnt] = transfer_to[cnt];
+		rcu_assign_pointer(dquots[cnt], transfer_to[cnt]);
 	}
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&dq_data_lock);
@@ -2080,8 +2092,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	 * mark_all_dquot_dirty().
 	 */
 	index = srcu_read_lock(&dquot_srcu);
-	mark_all_dquot_dirty(transfer_from);
-	mark_all_dquot_dirty(transfer_to);
+	mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
+	mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
 	srcu_read_unlock(&dquot_srcu, index);
 
 	flush_warnings(warn_to);
-- 
2.35.3


