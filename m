Return-Path: <linux-fsdevel+bounces-61038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F59B54A09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE401CC54C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8B2EB85C;
	Fri, 12 Sep 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H3cs9eFv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g8MZmtgQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H3cs9eFv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g8MZmtgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E62EBB93
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673546; cv=none; b=j3obTZ3BI6Y9VqT1axK3QMGnClYPF9e5biqldySE97tikfRvr6jRugd0mT4qcO2fvkmjsoQc1EF7+uWgurHC3TkENVhW/r12i+fnqubgCtAqU70HH3yOvyOh2GaHz03CEBFMDj90dlDckS+l9FK10DHSLfUolyjITEcc4xqGr/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673546; c=relaxed/simple;
	bh=8EbJnBVqLRlQkDIUhqFC0klnpUNru+bC1tkpALLfjbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4aGo1BaR63xEhWc/etOp4UDp9qfwwe5xHH3W4OC5vGp624/5nXPrkgoiZyT/5TjSv9gxfet/8lRmeEblbGR5UuKIvzx6D0yjHyHCOhdbBb2rqPX901e4KU0cQiZsCOOgtqykFC/t+H0KPOzqz5fxGVE9CY1KkQNS1xS0wf/LT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H3cs9eFv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g8MZmtgQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H3cs9eFv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g8MZmtgQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83E6B3ECA7;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeO5jZm5mAJb4SXBU0lhfRJ3leuxFZpfFPDgnV9U0BI=;
	b=H3cs9eFv1ygmeY0M4y0iJBs/f69VSmnh7Arw97GrARc+GCypCjpma0vCt/DvFOfp4csbpO
	1Y6VtKlEinDKYw2YcJulIGYn4/F8I8bE5zZi5OuW+acmy6/+6NDCzkjLNQU3OYZVeFmVQf
	21Ecy8wdeI+mmM2mTrGqLz43b7BLu8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeO5jZm5mAJb4SXBU0lhfRJ3leuxFZpfFPDgnV9U0BI=;
	b=g8MZmtgQt05XIADEF4nJoDtfkcQva6+0RJRXV3z72siicFfqcr56yNDFJgvivq+i99xmH4
	cV+CmDaZI6FRb9DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeO5jZm5mAJb4SXBU0lhfRJ3leuxFZpfFPDgnV9U0BI=;
	b=H3cs9eFv1ygmeY0M4y0iJBs/f69VSmnh7Arw97GrARc+GCypCjpma0vCt/DvFOfp4csbpO
	1Y6VtKlEinDKYw2YcJulIGYn4/F8I8bE5zZi5OuW+acmy6/+6NDCzkjLNQU3OYZVeFmVQf
	21Ecy8wdeI+mmM2mTrGqLz43b7BLu8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeO5jZm5mAJb4SXBU0lhfRJ3leuxFZpfFPDgnV9U0BI=;
	b=g8MZmtgQt05XIADEF4nJoDtfkcQva6+0RJRXV3z72siicFfqcr56yNDFJgvivq+i99xmH4
	cV+CmDaZI6FRb9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76DCD13ADB;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6boCHTr4w2glWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 10:38:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 29341A0A6A; Fri, 12 Sep 2025 12:38:50 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 4/4] writeback: Add tracepoint to track pending inode switches
Date: Fri, 12 Sep 2025 12:38:38 +0200
Message-ID: <20250912103840.4844-8-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912103522.2935-1-jack@suse.cz>
References: <20250912103522.2935-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=jack@suse.cz; h=from:subject; bh=8EbJnBVqLRlQkDIUhqFC0klnpUNru+bC1tkpALLfjbw=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDIO/zAOmsso8rXkr9WWabu2zYq35m1Kcj7Tu78wf/O1E 3pXPb3KOxmNWRgYORhkxRRZVkde1L42z6hra6iGDMwgViaQKQxcnAIwEe1U9t8suyYqtX/+FMWn 01x0c5Gy29e2lGsq9WqZVxYG2W+O95x4/6/tfe6r12KaPlRqJPIFyx7Q5HN+up2Z60d5W1Q3W8f 1OdbSkm8vhM3/uHeDvZ50hVvNH8kD+4SkDmf4sTYqeXpnNIkHWSRlJwskHP7C6L2Y3bvBfzJvyu POeQfdfm3qqby2bGdY6KmlMyoPFfs2iEzOzwrgeFt2UuXImSA5QfuHyyNqjKOinqscXNgkW8rbZ 2Te5DD/cMY89ednVuYaryqXPHFP/uOL77M+zezz2Z6ikuoaF3tKwPR0yqInJ1fM++O8T4rloZFr D9enAL/qv/sYOnYW3+IK4PBYfWS+gfBBdb6JZhXdfk19AA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Add trace_inode_switch_wbs_queue tracepoint to allow insight into how
many inodes are queued to switch their bdi_writeback structure.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                |  2 ++
 include/trace/events/writeback.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 22fe313ae0d3..fad8ddfa622b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -668,6 +668,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	isw->inodes[0] = inode;
 
+	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
 	wb_queue_isw(new_wb, isw);
 	return;
 
@@ -753,6 +754,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		return restart;
 	}
 
+	trace_inode_switch_wbs_queue(wb, new_wb, nr);
 	wb_queue_isw(new_wb, isw);
 
 	return restart;
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


