Return-Path: <linux-fsdevel+bounces-60680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53458B50074
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE051C631C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D85352098;
	Tue,  9 Sep 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrXgAtEA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="flq8Xk8i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gsYCtBKS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9/CO1aeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D36350840
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429951; cv=none; b=ffL/J24v9MoYty9Z/kw3nkGe9LQnH1IKFyN0s28vZ0c7BJvthiR0leELQdCB8BGd1+XVVeVkmJZNYxYerATc1X+iKFj3XNvvHp2F/IHh1YaoO1tz3Q9GE8ib1g/+sS4DENGgn+uGLLDB+XQj6DncGkFqgxsa58eofjpenJCrecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429951; c=relaxed/simple;
	bh=hD1kfrGcVCzDZQIqP0Yp7aWTNgu351fNfU/0J6KfY9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPtYyweC/5pPnWbyqQQ1iyd7XrsLXPSGLydHvBbiSXEXXNSjx9UJCSQSCvfHAXcy9W1NHqZVoeR7wbjYcQeB5SzEuhS8rAuIrvphBDjlBJldyGTwZ204t4OlqaTio6FXvhEvWpT4Q1VUBJUezvQCZ7vzEhiji3Y26C6dbuSsATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrXgAtEA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=flq8Xk8i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gsYCtBKS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9/CO1aeY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF23129968;
	Tue,  9 Sep 2025 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lnmhDFmtTUNklZKT/bYXY+FmLkPcZdd1+5x3c6aX6AQ=;
	b=PrXgAtEAzSYtfqggMOBLcb66fXiCXG/4InJmPSzvu8JNN4FBMp5QJX87Vkmiyl09Xsna6s
	s9ubkRW8M/BsVKc+ieIXbOoXdcTD9uMdErO4t/oX3OQLcpOzmuvtQJ3MhKy+2/j4U5/eHP
	9XO5HPKCcvfsJONSQRHvDdNKd54HfXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lnmhDFmtTUNklZKT/bYXY+FmLkPcZdd1+5x3c6aX6AQ=;
	b=flq8Xk8imKLid5PFSCp9aezXvwRdua8+Sw7vGt9cP4O1siAcoOYpRT+euO8JTA5pVvu6NL
	MNK+NDSnAMZ/G0BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lnmhDFmtTUNklZKT/bYXY+FmLkPcZdd1+5x3c6aX6AQ=;
	b=gsYCtBKSWWno2wNT6L/s6XYzU3dPGTqJcUZlIEaG8I4m3FEUkATMI5+fSqS7fXvEXPJRq6
	jtEm/Tx9R4f6GXTeTzHiFVZFZIl5S/y0o/YFJXV4YtUV6bvBy1pXXbm6wr2X9/sqm2unmT
	n98gxz92/4jn+zE2itAwskHaRRZedfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lnmhDFmtTUNklZKT/bYXY+FmLkPcZdd1+5x3c6aX6AQ=;
	b=9/CO1aeY4F7D1VsH9KipkP0hoWiZgaDjX+DHHBW49rKyKbzsKdyxeBVe8AvoL7s+kS4UiR
	YOwPiqLyhbT6TlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC2E61388C;
	Tue,  9 Sep 2025 14:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /kJ+MbtAwGhyfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 14:59:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85909A0A2D; Tue,  9 Sep 2025 16:59:07 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2] readahead: Add trace points
Date: Tue,  9 Sep 2025 16:58:50 +0200
Message-ID: <20250909145849.5090-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6249; i=jack@suse.cz; h=from:subject; bh=hD1kfrGcVCzDZQIqP0Yp7aWTNgu351fNfU/0J6KfY9I=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBowECpU3aXE6Sd1IwPZLCHlVPvAWxwL7n3gxv+d qaX7h2xpLuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMBAqQAKCRCcnaoHP2RA 2fI/CAC6/M28K6eSp9AL4fHjXwojLDQU4T7Ta+vb0Q5BsyCPRpp5KQhI9lHbzUHxmIF8RZdAoxV qZWMMR9gk/roKK7i5FMLeqfrgAFID5dti6i7mytgbuNr57NbupmwxsUmsQiKKDVLCRG1CrU4ups e3FaRKwt2Oe4c3PMXeeexWPBbBjN0Nl84nd/Ack5XifX3QB0SJklikBFWAHEN1SNNB7sg4cumRj UsTo4Y+2oXhspVevBUMphBITAID1IwVhrbbCniEMJP+HMe5IlnadVUroYgEeYD7CrKakDeEZl4j mbl8T3P5faCKTdSrLtyG0tmmAGI0brjM1kkKrOGp1XfafSRU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Add a couple of trace points to make debugging readahead logic easier.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/trace/events/readahead.h | 132 +++++++++++++++++++++++++++++++
 mm/readahead.c                   |   8 ++
 2 files changed, 140 insertions(+)
 create mode 100644 include/trace/events/readahead.h

Changes since v1:
- moved tracepoint from do_page_cache_ra() to page_cache_ra_unbounded() as
  that is a more standard function.

diff --git a/include/trace/events/readahead.h b/include/trace/events/readahead.h
new file mode 100644
index 000000000000..0997ac5eceab
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
+TRACE_EVENT(page_cache_ra_unbounded,
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
index 406756d34309..3a4b5d58eeb6 100644
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
@@ -225,6 +228,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 */
 	unsigned int nofs = memalloc_nofs_save();
 
+	trace_page_cache_ra_unbounded(mapping->host, index, nr_to_read,
+				      lookahead_size);
 	filemap_invalidate_lock_shared(mapping);
 	index = mapping_align_index(mapping, index);
 
@@ -470,6 +475,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	gfp_t gfp = readahead_gfp_mask(mapping);
 	unsigned int new_order = ra->order;
 
+	trace_page_cache_ra_order(mapping->host, start, ra);
 	if (!mapping_large_folio_support(mapping)) {
 		ra->order = 0;
 		goto fallback;
@@ -554,6 +560,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	unsigned long max_pages, contig_count;
 	pgoff_t prev_index, miss;
 
+	trace_page_cache_sync_ra(ractl->mapping->host, index, ra, req_count);
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -638,6 +645,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (folio_test_writeback(folio))
 		return;
 
+	trace_page_cache_async_ra(ractl->mapping->host, index, ra, req_count);
 	folio_clear_readahead(folio);
 
 	if (blk_cgroup_congested())
-- 
2.51.0


