Return-Path: <linux-fsdevel+bounces-60544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE55B49228
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8813917D16F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657D330B50F;
	Mon,  8 Sep 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eqGCpEI6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s3BmCaxJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eqGCpEI6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s3BmCaxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED230AD18
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343361; cv=none; b=ScdN5Qlly+30Kcjy7UNihy7GIK74faM8fOYNGOGYkoRGhFKweTWlZI7fbqTWI/spDFqowuoZ1Ax8fBkPVyTR6WHfXdIbdVk+/0vW3xFEusNOfIP7PbyhZF3605f84gsrkjTcSNvb9awaksJzMJ3AzsvzEddAXGNemGj7FHeNjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343361; c=relaxed/simple;
	bh=AqpZrtZ/C6kg7z6v65Gg8uFkvtpcZsMaQwBJ8xfkrtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LStz1sdtQbDfr/Ce2ITmc+tU2wmcG6WZPVXoSyj/ONTYebdGcSMLtpIy8YGIjLIrH7kzcF/VVsiORaXlmGoAK7X8PVgVUlKRIy25Rj6BPE841yI+3141kKHLomdeVsscKOP/ZdVdAK6eCnbLQdADtn5c3VFnoQKXctWWFkKCkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eqGCpEI6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s3BmCaxJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eqGCpEI6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s3BmCaxJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BE2B276A0;
	Mon,  8 Sep 2025 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757343357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jRygZKc47ktPlJUoYPJf4VhF+n2fdylD3FWdVDZ3xrc=;
	b=eqGCpEI6zjbELPOULgTfUeGlY2iq4UXhKORyJFOFl9gLXPsmN7f0P7WjlCLuvL2dqjg0yf
	d6qxvMSEpj1dOSYiYOgMaQ1/PkoQqusiicsfnSqCUOTFy9M2LOJescTPDno5X+QOnHk1WA
	NATEin4c9ax+6lh97m/hZiMoYhx0MGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757343357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jRygZKc47ktPlJUoYPJf4VhF+n2fdylD3FWdVDZ3xrc=;
	b=s3BmCaxJEtpSs9KwcJdLD9xaBNai6Nq6/ikgYrqBhL2kkHgiJBsdLE6+CV4zVQ7oF7vRJh
	dlkeM5Rd8fJJPTAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757343357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jRygZKc47ktPlJUoYPJf4VhF+n2fdylD3FWdVDZ3xrc=;
	b=eqGCpEI6zjbELPOULgTfUeGlY2iq4UXhKORyJFOFl9gLXPsmN7f0P7WjlCLuvL2dqjg0yf
	d6qxvMSEpj1dOSYiYOgMaQ1/PkoQqusiicsfnSqCUOTFy9M2LOJescTPDno5X+QOnHk1WA
	NATEin4c9ax+6lh97m/hZiMoYhx0MGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757343357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jRygZKc47ktPlJUoYPJf4VhF+n2fdylD3FWdVDZ3xrc=;
	b=s3BmCaxJEtpSs9KwcJdLD9xaBNai6Nq6/ikgYrqBhL2kkHgiJBsdLE6+CV4zVQ7oF7vRJh
	dlkeM5Rd8fJJPTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90C1913ABA;
	Mon,  8 Sep 2025 14:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JjtSI33uvmg+VQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 14:55:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4AECBA0A2D; Mon,  8 Sep 2025 16:55:57 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] readahead: Add trace points
Date: Mon,  8 Sep 2025 16:55:34 +0200
Message-ID: <20250908145533.31528-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6269; i=jack@suse.cz; h=from:subject; bh=AqpZrtZ/C6kg7z6v65Gg8uFkvtpcZsMaQwBJ8xfkrtU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBovu5lqr1Fk1zYi3asDhW28hVAYB7ly6I64JbpK oEgE/DXACSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaL7uZQAKCRCcnaoHP2RA 2YSqB/9aesdkvRh9eBBWPOphDGmT71G1V032qSrFezPfC1ebg6pIQSc/C3YlXabbAxWfvXQX9m3 WMOfHhOjcI+MW4MG06ovA1epUSfwZiaHGB8i0xq03Dgh/AsHqoPfSl+Qvyh/FXeSh9d+bYZMc+x 9fw2RJxexIwUG4Y/msFXhKI7jtbdWNPxpZVl/TPFTg9w/Nhz/PDJN37oGVwU27+oBd1JMrhWQ5x +r3UfM0KV4QTTHPeKbg2gegCUSSJhLTeh8z035vQ1HqcfmUzEnUgMuj7M1oIzWM1y4bxl3nI/f7 Mn9e0flPQYuhMyRKAc75RKdA57VMd+PKb+S37kodQV1uBZC+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Add a couple of trace points to make debugging readahead logic easier.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/trace/events/readahead.h | 132 +++++++++++++++++++++++++++++++
 mm/readahead.c                   |   7 ++
 2 files changed, 139 insertions(+)
 create mode 100644 include/trace/events/readahead.h

I've added these when looking into how bs > page size interacts with readahead
code (and got bored with placing kprobes to dump info). I think they are useful
enough to warrant staying in the code...

diff --git a/include/trace/events/readahead.h b/include/trace/events/readahead.h
new file mode 100644
index 000000000000..992a6ce5c154
--- /dev/null
+++ b/include/trace/events/readahead.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM readahead
+
+#if !defined(_TRACE_FILEMAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_READAHEAD_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+
+TRACE_EVENT(do_page_cache_ra,
+	TP_PROTO(struct inode *inode, pgoff_t index, unsigned long nr_to_read,
+		 unsigned long lookahead_size),
+
+	TP_ARGS(inode, index, nr_to_read, lookahead_size),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(pgoff_t, index)
+		__field(unsigned long, nr_to_read)
+		__field(unsigned long, lookahead_size)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = inode->i_ino;
+		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->index = index;
+		__entry->nr_to_read = nr_to_read;
+		__entry->lookahead_size = lookahead_size;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx index=%lu nr_to_read=%lu lookahead_size=%lu",
+		MAJOR(__entry->s_dev), MINOR(__entry->s_dev), __entry->i_ino,
+		__entry->index, __entry->nr_to_read, __entry->lookahead_size
+	)
+);
+
+TRACE_EVENT(page_cache_ra_order,
+	TP_PROTO(struct inode *inode, pgoff_t index, struct file_ra_state *ra),
+
+	TP_ARGS(inode, index, ra),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(pgoff_t, index)
+		__field(unsigned int, order)
+		__field(unsigned int, size)
+		__field(unsigned int, async_size)
+		__field(unsigned int, ra_pages)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = inode->i_ino;
+		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->index = index;
+		__entry->order = ra->order;
+		__entry->size = ra->size;
+		__entry->async_size = ra->async_size;
+		__entry->ra_pages = ra->ra_pages;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx index=%lu order=%u size=%u async_size=%u ra_pages=%u",
+		MAJOR(__entry->s_dev), MINOR(__entry->s_dev), __entry->i_ino,
+		__entry->index, __entry->order, __entry->size,
+		__entry->async_size, __entry->ra_pages
+	)
+);
+
+DECLARE_EVENT_CLASS(page_cache_ra_op,
+	TP_PROTO(struct inode *inode, pgoff_t index, struct file_ra_state *ra,
+		 unsigned long req_count),
+
+	TP_ARGS(inode, index, ra, req_count),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(pgoff_t, index)
+		__field(unsigned int, order)
+		__field(unsigned int, size)
+		__field(unsigned int, async_size)
+		__field(unsigned int, ra_pages)
+		__field(unsigned int, mmap_miss)
+		__field(loff_t, prev_pos)
+		__field(unsigned long, req_count)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = inode->i_ino;
+		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->index = index;
+		__entry->order = ra->order;
+		__entry->size = ra->size;
+		__entry->async_size = ra->async_size;
+		__entry->ra_pages = ra->ra_pages;
+		__entry->mmap_miss = ra->mmap_miss;
+		__entry->prev_pos = ra->prev_pos;
+		__entry->req_count = req_count;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx index=%lu req_count=%lu order=%u size=%u async_size=%u ra_pages=%u mmap_miss=%u prev_pos=%lld",
+		MAJOR(__entry->s_dev), MINOR(__entry->s_dev), __entry->i_ino,
+		__entry->index, __entry->req_count, __entry->order,
+		__entry->size, __entry->async_size, __entry->ra_pages,
+		__entry->mmap_miss, __entry->prev_pos
+	)
+);
+
+DEFINE_EVENT(page_cache_ra_op, page_cache_sync_ra,
+	TP_PROTO(struct inode *inode, pgoff_t index, struct file_ra_state *ra,
+		 unsigned long req_count),
+	TP_ARGS(inode, index, ra, req_count)
+);
+
+DEFINE_EVENT(page_cache_ra_op, page_cache_async_ra,
+	TP_PROTO(struct inode *inode, pgoff_t index, struct file_ra_state *ra,
+		 unsigned long req_count),
+	TP_ARGS(inode, index, ra, req_count)
+);
+
+#endif /* _TRACE_FILEMAP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/readahead.c b/mm/readahead.c
index 406756d34309..210395fe1044 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -129,6 +129,9 @@
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/readahead.h>
+
 #include "internal.h"
 
 /*
@@ -314,6 +317,7 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 	loff_t isize = i_size_read(inode);
 	pgoff_t end_index;	/* The last page we want to read */
 
+	trace_do_page_cache_ra(inode, index, nr_to_read, lookahead_size);
 	if (isize == 0)
 		return;
 
@@ -470,6 +474,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	gfp_t gfp = readahead_gfp_mask(mapping);
 	unsigned int new_order = ra->order;
 
+	trace_page_cache_ra_order(mapping->host, start, ra);
 	if (!mapping_large_folio_support(mapping)) {
 		ra->order = 0;
 		goto fallback;
@@ -554,6 +559,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	unsigned long max_pages, contig_count;
 	pgoff_t prev_index, miss;
 
+	trace_page_cache_sync_ra(ractl->mapping->host, index, ra, req_count);
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -638,6 +644,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (folio_test_writeback(folio))
 		return;
 
+	trace_page_cache_async_ra(ractl->mapping->host, index, ra, req_count);
 	folio_clear_readahead(folio);
 
 	if (blk_cgroup_congested())
-- 
2.51.0


