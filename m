Return-Path: <linux-fsdevel+bounces-79382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCSBGrw9qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:12:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B80FC2010FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C35531622BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619073A8759;
	Wed,  4 Mar 2026 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdR/55bA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71223A453C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633064; cv=none; b=Ij6xwjBstuPp6bOwlljdJNWbrS9RpPf7EGNR4hktBcMK1WQr9BK3hsaZG3LzzF9E7+4DUpvNrMTSOZ6Qd0NMmZxwb+zLkDi566ZgFgvx5lvgNyIx3pyVUQ90ejYCR4XD+k4c/E/lC6hXMTuu+3iKOMnjmiA6gKHMS9zkXrcw5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633064; c=relaxed/simple;
	bh=fhxmx95adimTD53DyedtuQh+G0VSgQOTmjXFqNYxsXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAZ7Wqq1ixOhtMhUTnvH7LSpGWopvStKNz/6M7OP5PPyMlfgZv9XKZzbVj27j71xL7CYpKpQlAnXHbKYy9xr0C3+Zq0mmQYbgngCzkDYP/6unXrcHC0aXA2UUeZIDfAFusXcHDVT/oJx0whudurMZ+MVlkTCe41NblnKjYjuF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdR/55bA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwj1qm8DtfCWlyDlMnhAgLU1H+XG527VwwgLx5fdbTg=;
	b=GdR/55bACG+moXIdimqUjWKYJ3a3/b1hGOveMyBN5tM5B5cp0H+NHjhd4w2vkoJQ8Id64s
	zoYZOEKlTgLyKnwjYHhYgNocXZLTSIf3lCuvtTpjYnHUlSUNKN2JUaAAg6eRSyAcxNhjc6
	lW/m0BGMqiqTGyBIjWAfAzfQjVLBsMU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-rLD8wUqXNHeOQFPvs9Owtg-1; Wed,
 04 Mar 2026 09:04:18 -0500
X-MC-Unique: rLD8wUqXNHeOQFPvs9Owtg-1
X-Mimecast-MFC-AGG-ID: rLD8wUqXNHeOQFPvs9Owtg_1772633055
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9A26180049D;
	Wed,  4 Mar 2026 14:04:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56A1E1958DC7;
	Wed,  4 Mar 2026 14:04:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 05/17] netfs: Add some tools for managing bvecq chains
Date: Wed,  4 Mar 2026 14:03:12 +0000
Message-ID: <20260304140328.112636-6-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: B80FC2010FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79382-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,linux.dev:email]
X-Rspamd-Action: no action

Provide a selection of tools for managing bvec queue chains.  This
includes:

 (1) Allocation, prepopulation, expansion, shortening and refcounting of
     bvecqs and bvecq chains.

     This can be used to do things like creating an encryption buffer in
     cifs or a directory content buffer in afs.  The memory segments will
     be appropriate disposed off according to the flags on the bvecq.

 (2) Management of a bvecq chain as a rolling buffer and the management of
     positions within it.

 (3) Loading folios, slicing chains and clearing content.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/Makefile            |   1 +
 fs/netfs/bvecq.c             | 634 +++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |  87 +++++
 fs/netfs/stats.c             |   4 +-
 include/linux/netfs.h        |  24 ++
 include/trace/events/netfs.h |  24 ++
 6 files changed, 773 insertions(+), 1 deletion(-)
 create mode 100644 fs/netfs/bvecq.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index b43188d64bd8..e1f12ecb5abf 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -3,6 +3,7 @@
 netfs-y := \
 	buffered_read.o \
 	buffered_write.o \
+	bvecq.o \
 	direct_read.o \
 	direct_write.o \
 	iterator.o \
diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
new file mode 100644
index 000000000000..e223beb6661b
--- /dev/null
+++ b/fs/netfs/bvecq.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Buffering helpers for bvec queues
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include "internal.h"
+
+void dump_bvecq(const struct bvecq *bq)
+{
+	int b = 0;
+
+	for (; bq; bq = bq->next, b++) {
+		int skipz = 0;
+
+		pr_notice("BQ[%u] %u/%u fp=%llx\n", b, bq->nr_segs, bq->max_segs, bq->fpos);
+		for (int s = 0; s < bq->nr_segs; s++) {
+			const struct bio_vec *bv = &bq->bv[s];
+
+			if (!bv->bv_page && !bv->bv_len && skipz < 2) {
+				skipz = 1;
+				continue;
+			}
+			if (skipz == 1)
+				pr_notice("BQ[%u:00-%02u] ...\n", b, s - 1);
+			skipz = 2;
+			pr_notice("BQ[%u:%02u] %10lx %04x %04x %u\n",
+				  b, s,
+				  bv->bv_page ? page_to_pfn(bv->bv_page) : 0,
+				  bv->bv_offset, bv->bv_len,
+				  bv->bv_page ? page_count(bv->bv_page) : 0);
+		}
+	}
+}
+
+/*
+ * Allocate a single bvecq chain element and initialise the header.
+ */
+struct bvecq *netfs_alloc_one_bvecq(size_t nr_slots, gfp_t gfp)
+{
+	struct bvecq *bq;
+	const size_t max_size = 512;
+	const size_t max_segs = (max_size - sizeof(*bq)) / sizeof(bq->__bv[0]);
+	size_t part = umin(nr_slots, max_segs);
+	size_t size = roundup_pow_of_two(struct_size(bq, __bv, part));
+
+	bq = kmalloc(size, gfp);
+	if (bq) {
+		*bq = (struct bvecq) {
+			.ref		= REFCOUNT_INIT(1),
+			.bv		= bq->__bv,
+			.inline_bv	= true,
+			.max_segs	= (size - sizeof(*bq)) / sizeof(bq->__bv[0]),
+		};
+		netfs_stat(&netfs_n_bvecq);
+	}
+	return bq;
+}
+
+/**
+ * netfs_alloc_bvecq - Allocate an unpopulated bvec queue
+ * @nr_slots: Number of slots to allocate
+ * @gfp: The allocation constraints.
+ *
+ * Allocate a chain of bvecq buffers providing at least the requested
+ * cumulative number of slots.
+ */
+struct bvecq *netfs_alloc_bvecq(size_t nr_slots, gfp_t gfp)
+{
+	struct bvecq *head = NULL, *tail = NULL;
+
+	_enter("%zu", nr_slots);
+
+	for (;;) {
+		struct bvecq *bq;
+
+		bq = netfs_alloc_one_bvecq(nr_slots, gfp);
+		if (!bq)
+			goto oom;
+
+		if (tail) {
+			tail->next = bq;
+			bq->prev = tail;
+		} else {
+			head = bq;
+		}
+		tail = bq;
+		if (tail->max_segs >= nr_slots)
+			break;
+		nr_slots -= tail->max_segs;
+	}
+
+	return head;
+oom:
+	netfs_free_bvecq_buffer(head);
+	return NULL;
+}
+EXPORT_SYMBOL(netfs_alloc_bvecq);
+
+/**
+ * netfs_alloc_bvecq_buffer - Allocate buffer space into a bvec queue
+ * @size: Target size of the buffer (can be 0 for an empty buffer)
+ * @pre_slots: Number of preamble slots to set aside
+ * @gfp: The allocation constraints.
+ */
+struct bvecq *netfs_alloc_bvecq_buffer(size_t size, unsigned int pre_slots, gfp_t gfp)
+{
+	struct bvecq *head = NULL, *tail = NULL, *p = NULL;
+	size_t count = DIV_ROUND_UP(size, PAGE_SIZE);
+
+	_enter("%zx,%zx,%u", size, count, pre_slots);
+
+	do {
+		struct page **pages;
+		int want, got;
+
+		p = netfs_alloc_one_bvecq(umin(count, 32 - 3), gfp);
+		if (!p)
+			goto oom;
+
+		p->free = true;
+
+		if (tail) {
+			tail->next = p;
+			p->prev = tail;
+		} else {
+			head = p;
+		}
+		tail = p;
+		if (!count)
+			break;
+
+		pages = (struct page **)&p->bv[p->max_segs];
+		pages -= p->max_segs - pre_slots;
+
+		want = umin(count, p->max_segs - pre_slots);
+		got = alloc_pages_bulk(gfp, want, pages);
+		if (got < want) {
+			for (int i = 0; i < got; i++)
+				__free_page(pages[i]);
+			goto oom;
+		}
+
+		tail->nr_segs = pre_slots + got;
+		for (int i = 0; i < got; i++) {
+			int j = pre_slots + i;
+
+			set_page_count(pages[i], 1);
+			bvec_set_page(&tail->bv[j], pages[i], PAGE_SIZE, 0);
+		}
+
+		count -= got;
+		pre_slots = 0;
+	} while (count > 0);
+
+	return head;
+oom:
+	netfs_free_bvecq_buffer(head);
+	return NULL;
+}
+EXPORT_SYMBOL(netfs_alloc_bvecq_buffer);
+
+/**
+ * netfs_expand_bvecq_buffer - Allocate buffer space into a bvec queue
+ * @mapping: Address space to set on the folio (or NULL).
+ * @_buffer: Pointer to the folio queue to add to (may point to a NULL; updated).
+ * @_cur_size: Current size of the buffer (updated).
+ * @size: Target size of the buffer.
+ * @gfp: The allocation constraints.
+ */
+int netfs_expand_bvecq_buffer(struct bvecq **_buffer, size_t *_cur_size, ssize_t size, gfp_t gfp)
+{
+	struct bvecq *tail = *_buffer, *p;
+	const size_t max_segs = 32;
+
+	size = round_up(size, PAGE_SIZE);
+	if (*_cur_size >= size)
+		return 0;
+
+	if (tail)
+		while (tail->next)
+			tail = tail->next;
+
+	do {
+		struct page *page;
+		int order = 0;
+
+		if (!tail || bvecq_is_full(tail)) {
+			p = netfs_alloc_one_bvecq(max_segs, gfp);
+			if (!p)
+				return -ENOMEM;
+			if (tail) {
+				tail->next = p;
+				p->prev = tail;
+			} else {
+				*_buffer = p;
+			}
+			tail = p;
+		}
+
+		if (size - *_cur_size > PAGE_SIZE)
+			order = umin(ilog2(size - *_cur_size) - PAGE_SHIFT,
+				     MAX_PAGECACHE_ORDER);
+
+		page = alloc_pages(gfp | __GFP_COMP, order);
+		if (!page && order > 0)
+			page = alloc_pages(gfp | __GFP_COMP, 0);
+		if (!page)
+			return -ENOMEM;
+
+		bvec_set_page(&p->bv[p->nr_segs++], page, PAGE_SIZE << order, 0);
+		*_cur_size += PAGE_SIZE << order;
+	} while (*_cur_size < size);
+
+	return 0;
+}
+EXPORT_SYMBOL(netfs_expand_bvecq_buffer);
+
+static void netfs_bvecq_free_seg(struct bvecq *bq, unsigned int seg)
+{
+	if (!bq->free ||
+	    !bq->bv[seg].bv_page)
+		return;
+
+	if (bq->unpin)
+		unpin_user_page(bq->bv[seg].bv_page);
+	else
+		__free_page(bq->bv[seg].bv_page);
+}
+
+/**
+ * netfs_free_bvecq_buffer - Free a bvec queue
+ * @bq: The start of the folio queue to free
+ *
+ * Free up a chain of bvecqs and the pages it points to.
+ */
+void netfs_free_bvecq_buffer(struct bvecq *bq)
+{
+	struct bvecq *next;
+
+	for (; bq; bq = next) {
+		for (int seg = 0; seg < bq->nr_segs; seg++)
+			netfs_bvecq_free_seg(bq, seg);
+		next = bq->next;
+		netfs_stat_d(&netfs_n_bvecq);
+		kfree(bq);
+	}
+}
+EXPORT_SYMBOL(netfs_free_bvecq_buffer);
+
+/**
+ * netfs_put_bvecq - Put a bvec queue
+ * @bq: The start of the folio queue to free
+ *
+ * Put the ref(s) on the nodes in a bvec queue, freeing up the node and the
+ * page fragments it points to as the refcounts become zero.
+ */
+void netfs_put_bvecq(struct bvecq *bq)
+{
+	struct bvecq *next;
+
+	for (; bq; bq = next) {
+		if (!refcount_dec_and_test(&bq->ref))
+			break;
+		for (int seg = 0; seg < bq->nr_segs; seg++)
+			netfs_bvecq_free_seg(bq, seg);
+		next = bq->next;
+		netfs_stat_d(&netfs_n_bvecq);
+		kfree(bq);
+	}
+}
+EXPORT_SYMBOL(netfs_put_bvecq);
+
+/**
+ * netfs_shorten_bvecq_buffer - Shorten a bvec queue buffer
+ * @bq: The start of the buffer to shorten
+ * @seg: The slot to start from
+ * @size: The size to retain
+ *
+ * Shorten the content of a bvec queue down to the minimum number of segments,
+ * starting at the specified segment, to retain the specified size.  An error
+ * will be reported if the bvec queue is undersized.
+ */
+int netfs_shorten_bvecq_buffer(struct bvecq *bq, unsigned int seg, size_t size)
+{
+	ssize_t retain = size;
+
+	/* Skip through the segments we want to keep. */
+	for (; bq; bq = bq->next) {
+		for (; seg < bq->nr_segs; seg++) {
+			retain -= bq->bv[seg].bv_len;
+			if (retain < 0)
+				goto found;
+		}
+		seg = 0;
+	}
+	if (WARN_ON_ONCE(retain > 0))
+		return -EMSGSIZE;
+	return 0;
+
+found:
+	/* Shorten the entry to be retained and clean the rest of this bvecq. */
+	bq->bv[seg].bv_len += retain;
+	seg++;
+	for (int i = seg; i < bq->nr_segs; i++)
+		netfs_bvecq_free_seg(bq, i);
+	bq->nr_segs = seg;
+
+	/* Free the queue tail. */
+	netfs_free_bvecq_buffer(bq->next);
+	bq->next = NULL;
+	return 0;
+}
+
+/*
+ * Initialise a rolling buffer.  We allocate an empty bvecq struct to so that
+ * the pointers can be independently driven by the producer and the consumer.
+ */
+int bvecq_buffer_init(struct bvecq_pos *pos, unsigned int rreq_id)
+{
+	struct bvecq *bq;
+
+	bq = netfs_alloc_bvecq(14, GFP_NOFS);
+	if (!bq)
+		return -ENOMEM;
+
+	pos->bvecq  = bq; /* Comes with a ref. */
+	pos->slot   = 0;
+	pos->offset = 0;
+	return 0;
+}
+
+/*
+ * Add a new segment on to the rolling buffer; either because the previous one
+ * is full or because we have a discontiguity to contend with.
+ */
+int bvecq_buffer_make_space(struct bvecq_pos *pos)
+{
+	struct bvecq *bq, *head = pos->bvecq;
+
+	bq = netfs_alloc_bvecq(14, GFP_NOFS);
+	if (!bq)
+		return -ENOMEM;
+	bq->prev = head;
+
+	pos->bvecq = netfs_get_bvecq(bq);
+	pos->slot = 0;
+	pos->offset = 0;
+
+	/* Make sure the initialisation is stored before the next pointer.
+	 *
+	 * [!] NOTE: After we set head->next, the consumer is at liberty to
+	 * immediately delete the old head.
+	 */
+	smp_store_release(&head->next, bq);
+	netfs_put_bvecq(head);
+	return 0;
+}
+
+/*
+ * Advance a bvecq position by the given amount of data.
+ */
+void bvecq_pos_advance(struct bvecq_pos *pos, size_t amount)
+{
+	struct bvecq *bq = pos->bvecq;
+	unsigned int slot = pos->slot;
+	size_t offset = pos->offset;
+
+	if (slot >= bq->nr_segs) {
+		bq = bq->next;
+		slot = 0;
+	}
+
+	while (amount) {
+		const struct bio_vec *bv = &bq->bv[slot];
+		size_t part = umin(bv->bv_len - offset, amount);
+
+		if (likely(part < bv->bv_len)) {
+			offset += part;
+			break;
+		}
+		amount -= part;
+		offset = 0;
+		slot++;
+		if (slot >= bq->nr_segs) {
+			if (!bq->next)
+				break;
+			bq = bq->next;
+			slot = 0;
+		}
+	}
+
+	pos->slot   = slot;
+	pos->offset = offset;
+	bvecq_pos_move(pos, bq);
+}
+
+/*
+ * Clear memory fragments pointed to by a bvec queue, advancing the position.
+ */
+ssize_t bvecq_zero(struct bvecq_pos *pos, size_t amount)
+{
+	struct bvecq *bq = pos->bvecq;
+	unsigned int slot = pos->slot;
+	ssize_t cleared = 0;
+	size_t offset = pos->offset;
+
+	if (WARN_ON_ONCE(!bq))
+		return 0;
+
+	if (slot >= bq->nr_segs) {
+		bq = bq->next;
+		if (WARN_ON_ONCE(!bq))
+			return 0;
+		slot = 0;
+	}
+
+	do {
+		const struct bio_vec *bv = &bq->bv[slot];
+
+		if (offset < bv->bv_len) {
+			size_t part = umin(amount - cleared, bv->bv_len - offset);
+
+			memzero_page(bv->bv_page, bv->bv_offset + offset, part);
+
+			offset += part;
+			cleared += part;
+		}
+
+		if (offset >= bv->bv_len) {
+			offset = 0;
+			slot++;
+			if (slot >= bq->nr_segs) {
+				if (!bq->next)
+					break;
+				bq = bq->next;
+				slot = 0;
+			}
+		}
+	} while (cleared < amount);
+
+	bvecq_pos_move(pos, bq);
+	pos->slot = slot;
+	pos->offset = offset;
+	return cleared;
+}
+
+/*
+ * Determine the size and number of segments that can be obtained the next
+ * slice of bvec queue up to the maximum size and segment count specified.  The
+ * position cursor is updated to the end of the slice.
+ */
+size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
+		   unsigned int max_segs, unsigned int *_nr_segs)
+{
+	struct bvecq *bq;
+	unsigned int slot = pos->slot, nsegs = 0;
+	size_t size = 0;
+	size_t offset = pos->offset;
+
+	bq = pos->bvecq;
+	for (;;) {
+		for (; slot < bq->nr_segs; slot++) {
+			const struct bio_vec *bvec = &bq->bv[slot];
+
+			if (offset < bvec->bv_len && bvec->bv_page) {
+				size_t part = umin(bvec->bv_len - offset, max_size);
+
+				size += part;
+				offset += part;
+				max_size -= part;
+				nsegs++;
+				if (!max_size || nsegs >= max_segs)
+					goto out;
+			}
+			offset = 0;
+		}
+
+		/* pos->bvecq isn't allowed to go NULL as the queue may get
+		 * extended and we would lose our place.
+		 */
+		if (!bq->next)
+			break;
+		slot = 0;
+		bq = bq->next;
+	}
+
+out:
+	*_nr_segs = nsegs;
+	if (slot == bq->nr_segs && bq->next) {
+		bq = bq->next;
+		slot = 0;
+		offset = 0;
+	}
+	bvecq_pos_move(pos, bq);
+	pos->slot = slot;
+	pos->offset = offset;
+	return size;
+}
+
+/*
+ * Extract page fragments from a bvec queue position into another bvecq, which
+ * we allocate.  The position is advanced.
+ */
+ssize_t bvecq_extract(struct bvecq_pos *pos, size_t amount,
+		      unsigned int max_segs, struct bvecq **to)
+{
+	struct bvecq_pos tmp_pos;
+	struct bvecq *src, *dst = NULL;
+	unsigned int slot = pos->slot, nsegs;
+	ssize_t extracted = 0;
+	size_t offset = pos->offset;
+
+	*to = NULL;
+	if (!max_segs)
+		max_segs = UINT_MAX;
+
+	bvecq_pos_attach(&tmp_pos, pos);
+	amount = bvecq_slice(&tmp_pos, amount, max_segs, &nsegs);
+	bvecq_pos_detach(&tmp_pos);
+	if (nsegs == 0)
+		return -EIO;
+
+	dst = netfs_alloc_bvecq(nsegs, GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+	*to = dst;
+
+	/* Transcribe the segments */
+	src = pos->bvecq;
+	for (;;) {
+		for (; slot < src->nr_segs; slot++) {
+			const struct bio_vec *sv = &src->bv[slot];
+			struct bio_vec *dv = &dst->bv[dst->nr_segs];
+
+			_debug("EXTR sl=%x off=%zx am=%zx p=%lx",
+			       slot, offset, amount, page_to_pfn(sv->bv_page));
+
+			if (offset < sv->bv_len && sv->bv_page) {
+				size_t part = umin(sv->bv_len - offset, amount);
+
+				bvec_set_page(dv, sv->bv_page, part,
+					      sv->bv_offset + offset);
+				extracted += part;
+				amount -= part;
+				offset += part;
+				trace_netfs_bv_slot(dst, dst->nr_segs);
+				dst->nr_segs++;
+				if (bvecq_is_full(dst))
+					dst = dst->next;
+				if (nsegs >= max_segs)
+					goto out;
+				if (amount == 0)
+					goto out;
+			}
+			offset = 0;
+		}
+
+		/* pos->bvecq isn't allowed to go NULL as the queue may get
+		 * extended and we would lose our place.
+		 */
+		if (!src->next)
+			break;
+		slot = 0;
+		src = src->next;
+	}
+
+out:
+	if (slot == src->nr_segs && src->next) {
+		src = src->next;
+		slot = 0;
+		offset = 0;
+	}
+	bvecq_pos_move(pos, src);
+	pos->slot = slot;
+	pos->offset = offset;
+	return extracted;
+}
+
+/*
+ * Decant part of the list of folios to read onto a bvecq.  The list must be
+ * pre-seeded with a bvecq object.
+ */
+ssize_t bvecq_load_from_ra(struct bvecq_pos *pos,
+			   struct readahead_control *ractl,
+			   struct folio_batch *put_batch)
+{
+	struct folio **folios;
+	struct bvecq *bq = pos->bvecq;
+	unsigned int space;
+	ssize_t loaded = 0;
+	int nr;
+
+	if (bvecq_is_full(bq)) {
+		bq = netfs_alloc_bvecq(14, GFP_NOFS);
+		if (!bq)
+			return -ENOMEM;
+		bq->prev = pos->bvecq;
+	}
+
+	space = bq->max_segs - bq->nr_segs;
+
+	folios = (struct folio **)(bq->bv + bq->max_segs);
+	folios -= space;
+
+	nr = __readahead_batch(ractl, (struct page **)folios, space);
+
+	_enter("%u/%u %u/%u", bq->nr_segs, bq->max_segs, nr, space);
+
+	bq->fpos = folio_pos(folios[0]);
+
+	for (int i = 0; i < nr; i++) {
+		struct folio *folio = folios[i];
+		size_t len = folio_size(folio);
+
+		loaded += len;
+		bvec_set_folio(&bq->bv[bq->nr_segs + i], folio, len, 0);
+
+		trace_netfs_folio(folio, netfs_folio_trace_read);
+		if (!folio_batch_add(put_batch, folio))
+			folio_batch_release(put_batch);
+	}
+
+	/* Update the counter after setting the slots. */
+	smp_store_release(&bq->nr_segs, bq->nr_segs + nr);
+
+	if (bq != pos->bvecq) {
+		/* Write the next pointer after initialisation. */
+		smp_store_release(&pos->bvecq->next, bq);
+		bvecq_pos_move(pos, bq);
+	}
+	return loaded;
+}
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d436e20d3418..89ebeb49e969 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -33,6 +33,92 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 			 loff_t pos, size_t copied);
 
+/*
+ * bvecq.c
+ */
+struct bvecq *netfs_alloc_one_bvecq(size_t nr_slots, gfp_t gfp);
+int bvecq_buffer_init(struct bvecq_pos *pos, unsigned int rreq_id);
+int bvecq_buffer_make_space(struct bvecq_pos *pos);
+void bvecq_pos_advance(struct bvecq_pos *pos, size_t amount);
+ssize_t bvecq_zero(struct bvecq_pos *pos, size_t amount);
+size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
+		   unsigned int max_segs, unsigned int *_nr_segs);
+ssize_t bvecq_extract(struct bvecq_pos *pos, size_t amount,
+		      unsigned int max_segs, struct bvecq **to);
+ssize_t bvecq_load_from_ra(struct bvecq_pos *pos,
+			   struct readahead_control *ractl,
+			   struct folio_batch *put_batch);
+
+struct bvecq *netfs_get_bvecq(struct bvecq *bq);
+
+static inline void bvecq_pos_attach(struct bvecq_pos *pos, const struct bvecq_pos *at)
+{
+	*pos = *at;
+	netfs_get_bvecq(pos->bvecq);
+}
+
+static inline void bvecq_pos_detach(struct bvecq_pos *pos)
+{
+	netfs_put_bvecq(pos->bvecq);
+	pos->bvecq = NULL;
+	pos->slot = 0;
+	pos->offset = 0;
+}
+
+static inline void bvecq_pos_transfer(struct bvecq_pos *pos, struct bvecq_pos *from)
+{
+	*pos = *from;
+	from->bvecq = NULL;
+	from->slot = 0;
+	from->offset = 0;
+}
+
+static inline void bvecq_pos_move(struct bvecq_pos *pos, struct bvecq *to)
+{
+	struct bvecq *old = pos->bvecq;
+
+	if (old != to) {
+		pos->bvecq = netfs_get_bvecq(to);
+		netfs_put_bvecq(old);
+	}
+}
+
+static inline bool bvecq_buffer_step(struct bvecq_pos *pos)
+{
+	struct bvecq *bq = pos->bvecq;
+
+	pos->slot++;
+	pos->offset = 0;
+	if (pos->slot <= bq->nr_segs)
+		return true;
+	if (!bq->next)
+		return false;
+	bvecq_pos_move(pos, bq->next);
+	return true;
+}
+
+static inline struct bvecq *bvecq_buffer_delete_spent(struct bvecq_pos *pos)
+{
+	struct bvecq *spent = pos->bvecq;
+	/* Read the contents of the queue segment after the pointer to it. */
+	struct bvecq *next = smp_load_acquire(&spent->next);
+
+	if (!next)
+		return NULL;
+	next->prev = NULL;
+	spent->next = NULL;
+	netfs_put_bvecq(spent);
+	pos->bvecq = next; /* We take spent's ref */
+	pos->slot = 0;
+	pos->offset = 0;
+	return next;
+}
+
+static inline bool bvecq_is_full(const struct bvecq *bvecq)
+{
+	return bvecq->nr_segs >= bvecq->max_segs;
+}
+
 /*
  * main.c
  */
@@ -166,6 +252,7 @@ extern atomic_t netfs_n_wh_retry_write_subreq;
 extern atomic_t netfs_n_wb_lock_skip;
 extern atomic_t netfs_n_wb_lock_wait;
 extern atomic_t netfs_n_folioq;
+extern atomic_t netfs_n_bvecq;
 
 int netfs_stats_show(struct seq_file *m, void *v);
 
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index ab6b916addc4..84c2a4bcc762 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -48,6 +48,7 @@ atomic_t netfs_n_wh_retry_write_subreq;
 atomic_t netfs_n_wb_lock_skip;
 atomic_t netfs_n_wb_lock_wait;
 atomic_t netfs_n_folioq;
+atomic_t netfs_n_bvecq;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
@@ -90,9 +91,10 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_rh_retry_read_subreq),
 		   atomic_read(&netfs_n_wh_retry_write_req),
 		   atomic_read(&netfs_n_wh_retry_write_subreq));
-	seq_printf(m, "Objs   : rr=%u sr=%u foq=%u wsc=%u\n",
+	seq_printf(m, "Objs   : rr=%u sr=%u bq=%u foq=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
+		   atomic_read(&netfs_n_bvecq),
 		   atomic_read(&netfs_n_folioq),
 		   atomic_read(&netfs_n_wh_wstream_conflict));
 	seq_printf(m, "WbLock : skip=%u wait=%u\n",
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 72ee7d210a74..f360b25ceb31 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -17,12 +17,14 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/bvec.h>
 #include <linux/uio.h>
 #include <linux/rolling_buffer.h>
 
 enum netfs_sreq_ref_trace;
 typedef struct mempool mempool_t;
 struct folio_queue;
+struct bvecq;
 
 /**
  * folio_start_private_2 - Start an fscache write on a folio.  [DEPRECATED]
@@ -40,6 +42,16 @@ static inline void folio_start_private_2(struct folio *folio)
 	folio_set_private_2(folio);
 }
 
+/*
+ * Position in a bio_vec queue.  The bvecq holds a ref on the queue segment it
+ * points to.
+ */
+struct bvecq_pos {
+	struct bvecq		*bvecq;		/* The first bvecq */
+	unsigned int		offset;		/* The offset within the starting slot */
+	u16			slot;		/* The starting slot */
+};
+
 enum netfs_io_source {
 	NETFS_SOURCE_UNKNOWN,
 	NETFS_FILL_WITH_ZEROES,
@@ -462,6 +474,12 @@ int netfs_alloc_folioq_buffer(struct address_space *mapping,
 			      struct folio_queue **_buffer,
 			      size_t *_cur_size, ssize_t size, gfp_t gfp);
 void netfs_free_folioq_buffer(struct folio_queue *fq);
+void dump_bvecq(const struct bvecq *bq);
+struct bvecq *netfs_alloc_bvecq(size_t nr_slots, gfp_t gfp);
+struct bvecq *netfs_alloc_bvecq_buffer(size_t size, unsigned int pre_slots, gfp_t gfp);
+void netfs_free_bvecq_buffer(struct bvecq *bq);
+void netfs_put_bvecq(struct bvecq *bq);
+int netfs_shorten_bvecq_buffer(struct bvecq *bq, unsigned int seg, size_t size);
 
 /**
  * netfs_inode - Get the netfs inode context from the inode
@@ -552,4 +570,10 @@ static inline void netfs_wait_for_outstanding_io(struct inode *inode)
 	wait_var_event(&ictx->io_count, atomic_read(&ictx->io_count) == 0);
 }
 
+static inline struct bvecq *netfs_get_bvecq(struct bvecq *bq)
+{
+	refcount_inc(&bq->ref);
+	return bq;
+}
+
 #endif /* _LINUX_NETFS_H */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 2d366be46a1c..2523adc3ad85 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -778,6 +778,30 @@ TRACE_EVENT(netfs_folioq,
 		      __print_symbolic(__entry->trace, netfs_folioq_traces))
 	    );
 
+TRACE_EVENT(netfs_bv_slot,
+	    TP_PROTO(const struct bvecq *bq, int slot),
+
+	    TP_ARGS(bq, slot),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned long,		pfn)
+		    __field(unsigned int,		offset)
+		    __field(unsigned int,		len)
+		    __field(unsigned int,		slot)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->slot = slot;
+		    __entry->pfn = page_to_pfn(bq->bv[slot].bv_page);
+		    __entry->offset = bq->bv[slot].bv_offset;
+		    __entry->len = bq->bv[slot].bv_len;
+			   ),
+
+	    TP_printk("bq[%x] p=%lx %x-%x",
+		      __entry->slot,
+		      __entry->pfn, __entry->offset, __entry->offset + __entry->len)
+	    );
+
 #undef EM
 #undef E_
 #endif /* _TRACE_NETFS_H */


