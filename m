Return-Path: <linux-fsdevel+bounces-60672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C28B4FFCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FFAB7AAC8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950B34F490;
	Tue,  9 Sep 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rL0FYiwq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwWBGYx2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rL0FYiwq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwWBGYx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7314A07
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429073; cv=none; b=bU561glxAH9gK+/PBVG+Tfh/FoZVGvnyHRYBI6J6OXfBzlP/aKKilf7bxXE0lTyLevH18O+P+k9A6mGodzHnJLscXXfANeZZNfAf6lI55dmQ7PUnAPQjpCHdvXHxFRsZ+d0HNCG55WbeffCOokufavp5ZIJzD5V451OCKr67WLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429073; c=relaxed/simple;
	bh=Oiet7v9PMz1KHe3LlIGWG06AfUItm1n+udem/SIBJmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR8bQldBV/8W4ZTyKFG8D6xoxd6p4pzyq/EJwR4X0a/IjPmIKxKHLFvGXAHodN+u3B7J5t1TKf3/LCRVlfKmDTzKpsYqKAwjePOy+gRybazSko+j6i4J6cg0E7JSCsMx6Wr2W3RZfoV7qOGCy9U3oLZrBRNymrLDiVURlndzUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rL0FYiwq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwWBGYx2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rL0FYiwq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwWBGYx2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3FB137265;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtRQAmEEIwA+W/HZTPf0FZf8drp3bjQdQThnZJ+SuKE=;
	b=rL0FYiwq3yI5wRPc9jAN7ySaOXWHaslZeRWNgv5BcbhYj1EXZC0Vg+PZRTvqQY8ih6g0Kk
	pJshgGc+/ACMVs76D3o9dJDFu3TDohv3MgeoCInxjNlVkUZt3h2Gke/qWWAWroNB7kZPvv
	AZIH2Znz1KfoZ85h2Y38RznQtPQviuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtRQAmEEIwA+W/HZTPf0FZf8drp3bjQdQThnZJ+SuKE=;
	b=DwWBGYx2GQ2HSdkp6u5con+uU+QMDgGtRDtwpKLIqkfqafqpcVXzae+BBEKobdU3jot7sY
	ZizKf+LqYX3o2PCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rL0FYiwq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DwWBGYx2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtRQAmEEIwA+W/HZTPf0FZf8drp3bjQdQThnZJ+SuKE=;
	b=rL0FYiwq3yI5wRPc9jAN7ySaOXWHaslZeRWNgv5BcbhYj1EXZC0Vg+PZRTvqQY8ih6g0Kk
	pJshgGc+/ACMVs76D3o9dJDFu3TDohv3MgeoCInxjNlVkUZt3h2Gke/qWWAWroNB7kZPvv
	AZIH2Znz1KfoZ85h2Y38RznQtPQviuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtRQAmEEIwA+W/HZTPf0FZf8drp3bjQdQThnZJ+SuKE=;
	b=DwWBGYx2GQ2HSdkp6u5con+uU+QMDgGtRDtwpKLIqkfqafqpcVXzae+BBEKobdU3jot7sY
	ZizKf+LqYX3o2PCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E393813ABB;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vvYoN009wGiYdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 14:44:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85A5DA0AB7; Tue,  9 Sep 2025 16:44:29 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/4] writeback: Add tracepoint to track pending inode switches
Date: Tue,  9 Sep 2025 16:44:05 +0200
Message-ID: <20250909144400.2901-8-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909143734.30801-1-jack@suse.cz>
References: <20250909143734.30801-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=jack@suse.cz; h=from:subject; bh=Oiet7v9PMz1KHe3LlIGWG06AfUItm1n+udem/SIBJmg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBowD0zs4Rkf1dYyGW1kQOuPmJo4DRmIg+dOSnpl gB2E85v8wWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMA9MwAKCRCcnaoHP2RA 2eiAB/90HA51xNtRYXstICqenQjphCY1E+i8AjWaapl+QvgAOSsv6m7b+x/y1O65llaK/XoeAG9 ATQP6JRRIp3a5NFrD2YnsZONzGPRfoiZD2dxyaX7XCqGwUDaJi1hP3/i8fNlLSs2Ww9x0fcDex8 xmCB1ifWX1nt4tjUXMFr1PLJiI42d1Qphc5/QtLrT3r06iawRSvjiRHQ2+7McaEXJRh2grRm8fQ /dvs7nTkD5EXl4dV/QRFwINpGUsdqGqjFBX4SJyHZpy7sJWXFaFFUppesVVxow3iT2WGRqZMf7B sWvtwHzypdKzDSLJQ96NjoJVTL8yGySgngHg29yqK7iVxqa0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F3FB137265
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.01

Add trace_inode_switch_wbs_queue tracepoint to allow insight into how
many inodes are queued to switch their bdi_writeback structure.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                |  4 ++++
 include/trace/events/writeback.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7765c3deccd6..094b78ce6d72 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -658,6 +658,8 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (!isw->new_wb)
 		goto out_free;
 
+	trace_inode_switch_wbs_queue(inode->i_wb, isw->new_wb, 1);
+
 	if (!inode_prepare_wbs_switch(inode, isw->new_wb))
 		goto out_free;
 
@@ -752,6 +754,8 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		return restart;
 	}
 
+	trace_inode_switch_wbs_queue(wb, isw->new_wb, nr);
+
 	/*
 	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
 	 * the RCU protected stat update paths to grab the i_page
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..c08aff044e80 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -213,6 +213,35 @@ TRACE_EVENT(inode_foreign_history,
 	)
 );
 
+TRACE_EVENT(inode_switch_wbs_queue,
+
+	TP_PROTO(struct bdi_writeback *old_wb, struct bdi_writeback *new_wb,
+		 unsigned int count),
+
+	TP_ARGS(old_wb, new_wb, count),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(ino_t,		old_cgroup_ino)
+		__field(ino_t,		new_cgroup_ino)
+		__field(unsigned int,	count)
+	),
+
+	TP_fast_assign(
+		strscpy_pad(__entry->name, bdi_dev_name(old_wb->bdi), 32);
+		__entry->old_cgroup_ino	= __trace_wb_assign_cgroup(old_wb);
+		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
+		__entry->count		= count;
+	),
+
+	TP_printk("bdi %s: old_cgroup_ino=%lu new_cgroup_ino=%lu count=%u",
+		__entry->name,
+		(unsigned long)__entry->old_cgroup_ino,
+		(unsigned long)__entry->new_cgroup_ino,
+		__entry->count
+	)
+);
+
 TRACE_EVENT(inode_switch_wbs,
 
 	TP_PROTO(struct inode *inode, struct bdi_writeback *old_wb,
-- 
2.51.0


