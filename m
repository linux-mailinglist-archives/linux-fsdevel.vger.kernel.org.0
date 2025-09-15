Return-Path: <linux-fsdevel+bounces-61426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B8B58027
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5089D3A3B71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715233EB1B;
	Mon, 15 Sep 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjavrPa1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hhfAkb6x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VlBpkTRV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gj1Tve6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECD32BF44
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949201; cv=none; b=bAfNjA8KH91P3WIRYMLTBpRZbG1AJvqh3bn0R8ROeLGK1C6bUZqyVkyks//ZiB6sOHgQLIqFOQxVAI7ltKNl/3hGhk4pdNFfCNfBzQHYHIMqABxthvWhnR0Vw2vEwO1qC0dOooO4BwVpzF1FJTD9H3chIviaoNcYt81p2vfYQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949201; c=relaxed/simple;
	bh=3IQtJm7mMS1Uo12dh23cyk5e3NgioMFfSDoTlzxwp3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax9T5I8bpKS1I21U8VqEnSobTWKux/IQqmRdZ62xIBN87rDAaAHb5PhZmWDjgLcDxx+LiOIiIIFhS00IH5Ds02+tPZ9511MJkOGVSOQEQ0jzVtrQp22C+L6Xwbc3JWMOEi/JWL7A/NDxpAEROlcgbfxHUHzuB02yisnQDVR0aD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjavrPa1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hhfAkb6x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VlBpkTRV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gj1Tve6H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E36651F45B;
	Mon, 15 Sep 2025 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757949198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SM04c3QTg7sbF+DmVDu8U26IY5Hco7mj11iLk2ezn+0=;
	b=sjavrPa16XdZpEhsUFnBumByv38eoJkDlURL7A+NJb79EUeBCwThelr7TYUgUQk2/vK+38
	awTWx3zrdqcaDVbxL3/0KBJLW15+8CndcpIrTagIEXDw8oIhkXj8mWGSj8vjClt4qNVtXG
	oB332MoHgP1EZhrI1sMNjb5eJsVZxws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757949198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SM04c3QTg7sbF+DmVDu8U26IY5Hco7mj11iLk2ezn+0=;
	b=hhfAkb6xQtw6SKoNZioWbmOSQbjjB2prB0unKkGnUe6VIjSx/Gv2DpLofFN1L5VaUp0/4C
	YUhsvBXoFp8BOqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757949197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SM04c3QTg7sbF+DmVDu8U26IY5Hco7mj11iLk2ezn+0=;
	b=VlBpkTRVh7cINAz5wGckiQvlQPvYYsx62xquF6DaLAW1Qeo0Wl0+y54LRAvwl6GwK3n5z8
	Pzab9e3ggjs5ja6uDCbAc00vAItvV/i7dLOl9X/J1dq+4b66LuxeFrwjoGJWVyPKybh2Kc
	/20D96zns+19XvKN19DrADgENebeW6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757949197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SM04c3QTg7sbF+DmVDu8U26IY5Hco7mj11iLk2ezn+0=;
	b=Gj1Tve6HksnE02rwkQ0zHkV+/MlY7zsqXH8dr1mmM95Eh0gambjxwkjDgUAoFj8RzG6r1T
	sT6Sbf2cA/TOQ1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4A961368D;
	Mon, 15 Sep 2025 15:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RijjMw0tyGjrcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 15:13:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9037DA0A06; Mon, 15 Sep 2025 17:13:17 +0200 (CEST)
Date: Mon, 15 Sep 2025 17:13:17 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/4] writeback: Avoid lockups when switching inodes
Message-ID: <3jfmu376jyk75l3jl5aopygfslbjj4omieavbtyugivxoe5kex@cv34s24fuzae>
References: <20250912103522.2935-1-jack@suse.cz>
 <20250915-anlegen-biegung-546ecc3b96a5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tzlytyesm7ilxap6"
Content-Disposition: inline
In-Reply-To: <20250915-anlegen-biegung-546ecc3b96a5@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80


--tzlytyesm7ilxap6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 15-09-25 14:50:46, Christian Brauner wrote:
> On Fri, 12 Sep 2025 12:38:34 +0200, Jan Kara wrote:
> > This patch series addresses lockups reported by users when systemd unit reading
> > lots of files from a filesystem mounted with lazytime mount option exits. See
> > patch 3 for more details about the reproducer.
> > 
> > There are two main issues why switching many inodes between wbs:
> > 
> > 1) Multiple workers will be spawned to do the switching but they all contend
> > on the same wb->list_lock making all the parallelism pointless and just
> > wasting time.
> > 
> > [...]
> 
> Applied to the vfs-6.18.writeback branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.writeback branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.

Thanks Christian! I'm attaching a new version of the patch 1/4 which
addresses Tejun's minor comments. It would be nice if you can replace it in
your tree. Thanks.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--tzlytyesm7ilxap6
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-writeback-Avoid-contention-on-wb-list_lock-when-swit.patch"

From c88933809024ebc8ad164aebe02237186614a25f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 9 Apr 2025 17:12:59 +0200
Subject: [PATCH] writeback: Avoid contention on wb->list_lock when switching
 inodes

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

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                | 99 ++++++++++++++++++++------------
 include/linux/backing-dev-defs.h |  4 ++
 include/linux/writeback.h        |  2 +
 mm/backing-dev.c                 |  5 ++
 4 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..e87612a40cb0 100644
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
+static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
+				     struct inode_switch_wbs_context *isw)
 {
-	struct inode_switch_wbs_context *isw =
-		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
 	struct backing_dev_info *bdi = inode_to_bdi(isw->inodes[0]);
 	struct bdi_writeback *old_wb = isw->inodes[0]->i_wb;
-	struct bdi_writeback *new_wb = isw->new_wb;
 	unsigned long nr_switched = 0;
 	struct inode **inodep;
 
@@ -543,6 +541,38 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
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
+		if (!list)
+			break;
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
+			process_inode_switch_wbs(new_wb, isw);
+	}
+	wb_put(new_wb);
+}
+
 static bool inode_prepare_wbs_switch(struct inode *inode,
 				     struct bdi_writeback *new_wb)
 {
@@ -572,6 +602,13 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
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
@@ -585,6 +622,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
+	struct bdi_writeback *new_wb = NULL;
 
 	/* noop if seems to be already in progress */
 	if (inode->i_state & I_WB_SWITCH)
@@ -609,40 +647,34 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
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
@@ -666,6 +698,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
+	struct bdi_writeback *new_wb;
 	int nr;
 	bool restart = false;
 
@@ -678,12 +711,12 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
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
@@ -695,27 +728,21 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
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


--tzlytyesm7ilxap6--

