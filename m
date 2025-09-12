Return-Path: <linux-fsdevel+bounces-61034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D80B54A04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE457A7A73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27F2EBB8C;
	Fri, 12 Sep 2025 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F4FyzSVD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDIzRWkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D032EA73B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673534; cv=none; b=t+dZUakGKQGlwJHLYkYJ0hz3KDWNG7Xi92fnZu/Lmj4VQswxpK46VmJ3RuVtPug2uBnxKhobEPg4+W01kI4Bg0fI2B/n1mVNNO+Zz98glLn0nKVt7y7Wv/Aat7bIdMKKWxUxgf+Cz0x3dtNCqiBIAMh6OmGp7t498nGCjmVOUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673534; c=relaxed/simple;
	bh=h2feX496ua/MyNEI5V70dEpudQCOM8w4KNph3fzz27o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHNapZhQffx9HQCR4CGQbVuEJTZ535SUZsEYk/x4d4PTgFCogvHspysKHrQtxh3yngRQZUFxwp1oSirU/jJkyRCaimh6GmJUTih03yNZ3pyJRKWJuRgIJdZK2pM56UhWqRmPbepP83LJEnMMXhVpyudYjFBVYOy/MaPfINpLrMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F4FyzSVD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDIzRWkN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A0EB38AD7;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SgsAsppn3uvLih3YDLvF2bg7rOv5xLTQMgSqq6pamY=;
	b=F4FyzSVDDSDOqunaGOu9d/06f1VtAwfIXZJ+Gs2b+wDIy48FzszFyL2RzCUED6EQnEH/BA
	7WrlEm9oriJ9JES+ATSjZINWss1e4mJ9UZULTEqLStMXW1fhvU3lbcp2cqQ3uouKwJA0gs
	Cy1GFhZrKTOG5Gf6TaLm5rem43YGwmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SgsAsppn3uvLih3YDLvF2bg7rOv5xLTQMgSqq6pamY=;
	b=qDIzRWkN1BtEmTqsh1t3R+MdQgfE+8fIps2xM+pFQlyMNbSBv+D6ihsiJ31ghF/Zflcoue
	nRGalDkzI2DvxfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A5CF1398D;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qn70GTr4w2ggWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 10:38:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10A3EA08F9; Fri, 12 Sep 2025 12:38:50 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/4] writeback: Avoid contention on wb->list_lock when switching inodes
Date: Fri, 12 Sep 2025 12:38:35 +0200
Message-ID: <20250912103840.4844-5-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912103522.2935-1-jack@suse.cz>
References: <20250912103522.2935-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10073; i=jack@suse.cz; h=from:subject; bh=h2feX496ua/MyNEI5V70dEpudQCOM8w4KNph3fzz27o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBow/gwG28wTG6MTV+OoCfJYz8SjQmN1w0Wzcx6Z GLwn9jONs2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMP4MAAKCRCcnaoHP2RA 2X6+CACyT8GmIKq0KPT8IRrIuDcMjb1fxYDDidINjJncs6b5OIbQ4L9o6R1Esg8Pqq001ssuugA KdCok9UUtNpWdHgl7PSrBdnEo5p4DQVHmA7EUqR5SbYLKN1pkI+dvBKi3e6/4bABu5w1XIJfNkx TDlGyHhoZGOhtH2+kDMZmmzD/P6ThabTICc9+gjltIzNNnSjb/zTUvxav0pOldWKCSbA3naOdrl euUMDWw1HzbMDD8UhNE/p/2LJ1//dcc0TBXk/jadYjpwpBrY73Znxe61VmdBjdY37op7hif1tok ESEIux0lD9s4FJ9wj6Ap2cG7c4pxU2jZZVIoSLtHOveg0H8e
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7A0EB38AD7
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

There can be multiple inode switch works that are trying to switch
inodes to / from the same wb. This can happen in particular if some
cgroup exits which owns many (thousands) inodes and we need to switch
them all. In this case several inode_switch_wbs_work_fn() instances will
be just spinning on the same wb->list_lock while only one of them makes
forward progress. This wastes CPU cycles and quickly leads to softlockup
reports and unusable system.

Instead of running several inode_switch_wbs_work_fn() instances in
parallel switching to the same wb and contending on wb->list_lock, run
just one work item per wb and manage a queue of isw items switching to
this wb.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                | 100 ++++++++++++++++++++-----------
 include/linux/backing-dev-defs.h |   4 ++
 include/linux/writeback.h        |   2 +
 mm/backing-dev.c                 |   5 ++
 4 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..f2265aa9b4c2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -368,7 +368,8 @@ static struct bdi_writeback *inode_to_wb_and_lock_list(struct inode *inode)
 }
 
 struct inode_switch_wbs_context {
-	struct rcu_work		work;
+	/* List of queued switching contexts for the wb */
+	struct llist_node	list;
 
 	/*
 	 * Multiple inodes can be switched at once.  The switching procedure
@@ -378,7 +379,6 @@ struct inode_switch_wbs_context {
 	 * array embedded into struct inode_switch_wbs_context.  Otherwise
 	 * an inode could be left in a non-consistent state.
 	 */
-	struct bdi_writeback	*new_wb;
 	struct inode		*inodes[];
 };
 
@@ -486,13 +486,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	return switched;
 }
 
-static void inode_switch_wbs_work_fn(struct work_struct *work)
+static void process_inode_switch_wbs_work(struct bdi_writeback *new_wb,
+					  struct inode_switch_wbs_context *isw)
 {
-	struct inode_switch_wbs_context *isw =
-		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
 	struct backing_dev_info *bdi = inode_to_bdi(isw->inodes[0]);
 	struct bdi_writeback *old_wb = isw->inodes[0]->i_wb;
-	struct bdi_writeback *new_wb = isw->new_wb;
 	unsigned long nr_switched = 0;
 	struct inode **inodep;
 
@@ -543,6 +541,39 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	atomic_dec(&isw_nr_in_flight);
 }
 
+void inode_switch_wbs_work_fn(struct work_struct *work)
+{
+	struct bdi_writeback *new_wb = container_of(work, struct bdi_writeback,
+						    switch_work);
+	struct inode_switch_wbs_context *isw, *next_isw;
+	struct llist_node *list;
+
+	/*
+	 * Grab out reference to wb so that it cannot get freed under us
+	 * after we process all the isw items.
+	 */
+	wb_get(new_wb);
+	while (1) {
+		list = llist_del_all(&new_wb->switch_wbs_ctxs);
+		/* Nothing to do? */
+		if (!list) {
+			wb_put(new_wb);
+			return;
+		}
+		/*
+		 * In addition to synchronizing among switchers, I_WB_SWITCH
+		 * tells the RCU protected stat update paths to grab the i_page
+		 * lock so that stat transfer can synchronize against them.
+		 * Let's continue after I_WB_SWITCH is guaranteed to be
+		 * visible.
+		 */
+		synchronize_rcu();
+
+		llist_for_each_entry_safe(isw, next_isw, list, list)
+			process_inode_switch_wbs_work(new_wb, isw);
+	}
+}
+
 static bool inode_prepare_wbs_switch(struct inode *inode,
 				     struct bdi_writeback *new_wb)
 {
@@ -572,6 +603,13 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	return true;
 }
 
+static void wb_queue_isw(struct bdi_writeback *wb,
+			 struct inode_switch_wbs_context *isw)
+{
+	if (llist_add(&isw->list, &wb->switch_wbs_ctxs))
+		queue_work(isw_wq, &wb->switch_work);
+}
+
 /**
  * inode_switch_wbs - change the wb association of an inode
  * @inode: target inode
@@ -585,6 +623,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
+	struct bdi_writeback *new_wb = NULL;
 
 	/* noop if seems to be already in progress */
 	if (inode->i_state & I_WB_SWITCH)
@@ -609,40 +648,34 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (!memcg_css)
 		goto out_free;
 
-	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
 	css_put(memcg_css);
-	if (!isw->new_wb)
+	if (!new_wb)
 		goto out_free;
 
-	if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+	if (!inode_prepare_wbs_switch(inode, new_wb))
 		goto out_free;
 
 	isw->inodes[0] = inode;
 
-	/*
-	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
-	 * the RCU protected stat update paths to grab the i_page
-	 * lock so that stat transfer can synchronize against them.
-	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
-	 */
-	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
-	queue_rcu_work(isw_wq, &isw->work);
+	wb_queue_isw(new_wb, isw);
 	return;
 
 out_free:
 	atomic_dec(&isw_nr_in_flight);
-	if (isw->new_wb)
-		wb_put(isw->new_wb);
+	if (new_wb)
+		wb_put(new_wb);
 	kfree(isw);
 }
 
-static bool isw_prepare_wbs_switch(struct inode_switch_wbs_context *isw,
+static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
+				   struct inode_switch_wbs_context *isw,
 				   struct list_head *list, int *nr)
 {
 	struct inode *inode;
 
 	list_for_each_entry(inode, list, i_io_list) {
-		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+		if (!inode_prepare_wbs_switch(inode, new_wb))
 			continue;
 
 		isw->inodes[*nr] = inode;
@@ -666,6 +699,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
+	struct bdi_writeback *new_wb;
 	int nr;
 	bool restart = false;
 
@@ -678,12 +712,12 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	for (memcg_css = wb->memcg_css->parent; memcg_css;
 	     memcg_css = memcg_css->parent) {
-		isw->new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
-		if (isw->new_wb)
+		new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
+		if (new_wb)
 			break;
 	}
-	if (unlikely(!isw->new_wb))
-		isw->new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
+	if (unlikely(!new_wb))
+		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
 	spin_lock(&wb->list_lock);
@@ -695,27 +729,21 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	 * bandwidth restrictions, as writeback of inode metadata is not
 	 * accounted for.
 	 */
-	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
+	restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_attached, &nr);
 	if (!restart)
-		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
+		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
+						 &nr);
 	spin_unlock(&wb->list_lock);
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
 		atomic_dec(&isw_nr_in_flight);
-		wb_put(isw->new_wb);
+		wb_put(new_wb);
 		kfree(isw);
 		return restart;
 	}
 
-	/*
-	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
-	 * the RCU protected stat update paths to grab the i_page
-	 * lock so that stat transfer can synchronize against them.
-	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
-	 */
-	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
-	queue_rcu_work(isw_wq, &isw->work);
+	wb_queue_isw(new_wb, isw);
 
 	return restart;
 }
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..c5c9d89c73ed 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -152,6 +152,10 @@ struct bdi_writeback {
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
 	struct list_head b_attached;	/* attached inodes, protected by list_lock */
 	struct list_head offline_node;	/* anchored at offline_cgwbs */
+	struct work_struct switch_work;	/* work used to perform inode switching
+					 * to this wb */
+	struct llist_head switch_wbs_ctxs;	/* queued contexts for
+						 * writeback switching */
 
 	union {
 		struct work_struct release_work;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a2848d731a46..15a4bc4ab819 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -265,6 +265,8 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 		bio_associate_blkg_from_css(bio, wbc->wb->blkcg_css);
 }
 
+void inode_switch_wbs_work_fn(struct work_struct *work);
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static inline void inode_attach_wb(struct inode *inode, struct folio *folio)
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..0beaca6bacf7 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -633,6 +633,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_exit(wb);
 	bdi_put(bdi);
 	WARN_ON_ONCE(!list_empty(&wb->b_attached));
+	WARN_ON_ONCE(work_pending(&wb->switch_work));
 	call_rcu(&wb->rcu, cgwb_free_rcu);
 }
 
@@ -709,6 +710,8 @@ static int cgwb_create(struct backing_dev_info *bdi,
 	wb->memcg_css = memcg_css;
 	wb->blkcg_css = blkcg_css;
 	INIT_LIST_HEAD(&wb->b_attached);
+	INIT_WORK(&wb->switch_work, inode_switch_wbs_work_fn);
+	init_llist_head(&wb->switch_wbs_ctxs);
 	INIT_WORK(&wb->release_work, cgwb_release_workfn);
 	set_bit(WB_registered, &wb->state);
 	bdi_get(bdi);
@@ -839,6 +842,8 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	if (!ret) {
 		bdi->wb.memcg_css = &root_mem_cgroup->css;
 		bdi->wb.blkcg_css = blkcg_root_css;
+		INIT_WORK(&bdi->wb.switch_work, inode_switch_wbs_work_fn);
+		init_llist_head(&bdi->wb.switch_wbs_ctxs);
 	}
 	return ret;
 }
-- 
2.51.0


