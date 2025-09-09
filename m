Return-Path: <linux-fsdevel+bounces-60676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0D8B4FFD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD821C615FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4B350830;
	Tue,  9 Sep 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QF4H/oQx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hRXfZzTI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QF4H/oQx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hRXfZzTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DA352077
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429085; cv=none; b=ldzzJp1HZBtDf5dQXZqI6pD4oLgSHxw0GrMrImZAIcWL21WIhcGWzQ1iSJFzkUI+34hnGT41Gtggf0OLFIebDu2wN4t4Adclu5NYoOCewAZXN2Qt3z2uBYSc0sDnbP8T2lrip9SQZ1GdjbNi5GSUobmsVIp+I7hXkxuXqUgyraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429085; c=relaxed/simple;
	bh=46UqWDQRkZpwgSjm5VySOk/noI/2Uej40VGIdrzM438=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx32KP2KZoFbFVP8crlzTmiB9B9BBiCYNGEXWZJLIuOHftekz4sbCxdEJuJHfIbd9LfRK3LUZxAiAhyQSBkMR3xsJ7DqdwuQaN/l7wEQsUlst++2KDHWendLwzqfT+3jWKnhaRpGdrWNUHA1RWacFPrUPJp3IymAQoAqHQXJvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QF4H/oQx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hRXfZzTI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QF4H/oQx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hRXfZzTI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0446D5F979;
	Tue,  9 Sep 2025 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=np/zGDfXineCX3ey5OUejzOmOlNUdJfTVbz8XDeprH8=;
	b=QF4H/oQxaCTloF89h+KZypY7oFtqAFougzqzdLL7+E6zS5A0xttrsr3TEMktK0uSiGzEDv
	+cWsT6ZzAivqUh8wETBGmbkaX84YEGXzig6TXgc46Vql7GJI5zE6hLDbdtdI9liTNElVnn
	3PpqOojU+65+MUrL+JegL4ATzGJJdrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=np/zGDfXineCX3ey5OUejzOmOlNUdJfTVbz8XDeprH8=;
	b=hRXfZzTIgDnub+uFeX9T7YEu9J007q0wFydmUbIjJuGfrxEXRcQi5RN9CYRSjyDzCr+us/
	D5DsUWQjCLv8VkCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="QF4H/oQx";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hRXfZzTI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=np/zGDfXineCX3ey5OUejzOmOlNUdJfTVbz8XDeprH8=;
	b=QF4H/oQxaCTloF89h+KZypY7oFtqAFougzqzdLL7+E6zS5A0xttrsr3TEMktK0uSiGzEDv
	+cWsT6ZzAivqUh8wETBGmbkaX84YEGXzig6TXgc46Vql7GJI5zE6hLDbdtdI9liTNElVnn
	3PpqOojU+65+MUrL+JegL4ATzGJJdrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=np/zGDfXineCX3ey5OUejzOmOlNUdJfTVbz8XDeprH8=;
	b=hRXfZzTIgDnub+uFeX9T7YEu9J007q0wFydmUbIjJuGfrxEXRcQi5RN9CYRSjyDzCr+us/
	D5DsUWQjCLv8VkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E49A813ABD;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jHtJN009wGicdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 14:44:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E632A0A6A; Tue,  9 Sep 2025 16:44:29 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/4] writeback: Avoid contention on wb->list_lock when switching inodes
Date: Tue,  9 Sep 2025 16:44:02 +0200
Message-ID: <20250909144400.2901-5-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909143734.30801-1-jack@suse.cz>
References: <20250909143734.30801-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5203; i=jack@suse.cz; h=from:subject; bh=46UqWDQRkZpwgSjm5VySOk/noI/2Uej40VGIdrzM438=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBowD0xs1JSsL4MTXjAjyIbGwsN16D2GI1Fa8xBw 73vM/D2qYGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMA9MQAKCRCcnaoHP2RA 2ebUCAC821Z9swF+YtMeAF0rIZcmqGI3GV/n7aCnGLqZ2CK4z2hUnwprfQ5hC8PsgAK/9Cb9Hfn YTHdHlRer+OBIrgxqRTuWh7UW5/GvyViW1+vck4ASBFt3fRO6ddxmCG8aLE0NN+0NTQkUpfyQ/C TgTxwMNxSrfgTIF01Ias2TmWU4wqZpdhNPJAow9RkAx0APLx05BFgTbEMjakPTZ+ajkwq7BpQYu iN7lkxbBwne8z8sHxF8nO/X9jSby3FIeHsxtk1APOxbTyBvxG0I5z4IoOIAyqbklSebhmnk1DTs 3W+rVQKLUK075SzzqNZQ5PEe/kRFZlKnmrrZk1FN6Z9wEcUj
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0446D5F979
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

There can be multiple inode switch works that are trying to switch
inodes to / from the same wb. This can happen in particular if some
cgroup exits which owns many (thousands) inodes and we need to switch
them all. In this case several inode_switch_wbs_work_fn() instances will
be just spinning on the same wb->list_lock while only one of them makes
forward progress. This wastes CPU cycles and quickly leads to softlockup
reports and unusable system.

Instead of running several inode_switch_wbs_work_fn() instances in
parallel switching to the same wb and contending on wb->list_lock, run
just one instance and let the other isw items switching to this wb queue
behind the one being processed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                | 42 +++++++++++++++++++++++++++++---
 include/linux/backing-dev-defs.h |  5 +++-
 mm/backing-dev.c                 |  2 ++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..3f3e6efd5d78 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -369,6 +369,8 @@ static struct bdi_writeback *inode_to_wb_and_lock_list(struct inode *inode)
 
 struct inode_switch_wbs_context {
 	struct rcu_work		work;
+	/* List of queued switching contexts for new_wb */
+	struct list_head	list;
 
 	/*
 	 * Multiple inodes can be switched at once.  The switching procedure
@@ -486,10 +488,8 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	return switched;
 }
 
-static void inode_switch_wbs_work_fn(struct work_struct *work)
+static void process_inode_switch_wbs_work(struct inode_switch_wbs_context *isw)
 {
-	struct inode_switch_wbs_context *isw =
-		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
 	struct backing_dev_info *bdi = inode_to_bdi(isw->inodes[0]);
 	struct bdi_writeback *old_wb = isw->inodes[0]->i_wb;
 	struct bdi_writeback *new_wb = isw->new_wb;
@@ -539,10 +539,44 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	for (inodep = isw->inodes; *inodep; inodep++)
 		iput(*inodep);
 	wb_put(new_wb);
-	kfree(isw);
 	atomic_dec(&isw_nr_in_flight);
 }
 
+static void inode_switch_wbs_work_fn(struct work_struct *work)
+{
+	struct inode_switch_wbs_context *isw =
+		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
+	struct bdi_writeback *new_wb = isw->new_wb;
+	bool switch_running;
+
+	spin_lock_irq(&new_wb->work_lock);
+	switch_running = !list_empty(&new_wb->switch_wbs_ctxs);
+	list_add_tail(&isw->list, &new_wb->switch_wbs_ctxs);
+	spin_unlock_irq(&new_wb->work_lock);
+
+	/*
+	 * Let's leave the real work for the running worker since we'd just
+	 * contend with it on wb->list_lock anyway.
+	 */
+	if (switch_running)
+		return;
+
+	/* OK, we will be doing the switching work */
+	wb_get(new_wb);
+	spin_lock_irq(&new_wb->work_lock);
+	while (!list_empty(&new_wb->switch_wbs_ctxs)) {
+		isw = list_first_entry(&new_wb->switch_wbs_ctxs,
+				       struct inode_switch_wbs_context, list);
+		spin_unlock_irq(&new_wb->work_lock);
+		process_inode_switch_wbs_work(isw);
+		spin_lock_irq(&new_wb->work_lock);
+		list_del(&isw->list);
+		kfree(isw);
+	}
+	spin_unlock_irq(&new_wb->work_lock);
+	wb_put(new_wb);
+}
+
 static bool inode_prepare_wbs_switch(struct inode *inode,
 				     struct bdi_writeback *new_wb)
 {
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..f94fd458c248 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -136,7 +136,8 @@ struct bdi_writeback {
 	int dirty_exceeded;
 	enum wb_reason start_all_reason;
 
-	spinlock_t work_lock;		/* protects work_list & dwork scheduling */
+	spinlock_t work_lock;		/* protects work_list,
+					   dwork scheduling, and switch_wbs_ctxs */
 	struct list_head work_list;
 	struct delayed_work dwork;	/* work item used for writeback */
 	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
@@ -152,6 +153,8 @@ struct bdi_writeback {
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
 	struct list_head b_attached;	/* attached inodes, protected by list_lock */
 	struct list_head offline_node;	/* anchored at offline_cgwbs */
+	struct list_head switch_wbs_ctxs;	/* queued contexts for
+						 * writeback switching */
 
 	union {
 		struct work_struct release_work;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..ce0aa7d03cc5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -709,6 +709,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
 	wb->memcg_css = memcg_css;
 	wb->blkcg_css = blkcg_css;
 	INIT_LIST_HEAD(&wb->b_attached);
+	INIT_LIST_HEAD(&wb->switch_wbs_ctxs);
 	INIT_WORK(&wb->release_work, cgwb_release_workfn);
 	set_bit(WB_registered, &wb->state);
 	bdi_get(bdi);
@@ -839,6 +840,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	if (!ret) {
 		bdi->wb.memcg_css = &root_mem_cgroup->css;
 		bdi->wb.blkcg_css = blkcg_root_css;
+		INIT_LIST_HEAD(&bdi->wb.switch_wbs_ctxs);
 	}
 	return ret;
 }
-- 
2.51.0


