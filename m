Return-Path: <linux-fsdevel+bounces-37529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF59F3B5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EB816E200
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445221D5AC6;
	Mon, 16 Dec 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbVsZoXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946EC1DB933
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381753; cv=none; b=n0FshZR/ee2cyvFKcV5wCab0Xo/IQGVMOXlGJaTMrmKzfnMMjYi21cj9BVEP4IeV4ilNBhtt+0k573LNX5XUOP0HKvm841J8Xwh79Mos6ZdoY+H0NTGBLxS4EVDa7P9Toc1sSgskw1GUxjsLrG0wSc//vPmX9XmmTaaj6dXWh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381753; c=relaxed/simple;
	bh=dH5LBAhM7KpFHGNA8z/P/yHL7nPDacPfBFontFbOVwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u31h61IKcadPdfOnhkPkdLN5tsx5MUyKLDXIBDoDNvr6pOM8KgaRhFiQFvQoivS1iiJUMzi6xYffL2qRl2uMfulGfLFapCyvcGSGFCVBP0XE0mmmuScO3DIAPDsRKoC9/Kag6qnSyYWELl3aC7j3c/yM/PlotdCAxteR64CI67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbVsZoXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPfC0fsyqwiQ/Nm7AGMJCD8a0JPVdzid/EdeuP5WUHI=;
	b=TbVsZoXjE3+VZYuRzGR2AENvRUdXc8z5vERTWM/XGT/Cv4ef/5dXqlzbST43tMM2eBleDj
	r2TwaV5zc0kGyYmR6wmOYuI71QWAmS4+JdVSraZKOWDuaxLAZnsJlQtFRG/wbdo4iobPUl
	7Q/DLCDt3jOisB5SskvQyHFej2nw77Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-Yzw9N0RbMMmZNM2WN265uA-1; Mon,
 16 Dec 2024 15:42:21 -0500
X-MC-Unique: Yzw9N0RbMMmZNM2WN265uA-1
X-Mimecast-MFC-AGG-ID: Yzw9N0RbMMmZNM2WN265uA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABF821955F41;
	Mon, 16 Dec 2024 20:42:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BF8A19560AD;
	Mon, 16 Dec 2024 20:42:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/32] netfs: Abstract out a rolling folio buffer implementation
Date: Mon, 16 Dec 2024 20:40:55 +0000
Message-ID: <20241216204124.3752367-6-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

A rolling buffer is a series of folios held in a list of folio_queues.  New
folios and folio_queue structs may be inserted at the head simultaneously
with spent ones being removed from the tail without the need for locking.

The rolling buffer includes an iov_iter and it has to be careful managing
this as the list of folio_queues is extended such that an oops doesn't
incurred because the iterator was pointing to the end of a folio_queue
segment that got appended to and then removed.

We need to use the mechanism twice, once for read and once for write, and,
in future patches, we will use a second rolling buffer to handle bounce
buffering for content encryption.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/Makefile              |   1 +
 fs/netfs/buffered_read.c       | 119 ++++-------------
 fs/netfs/direct_read.c         |  14 +-
 fs/netfs/direct_write.c        |  10 +-
 fs/netfs/internal.h            |   4 -
 fs/netfs/misc.c                | 147 ---------------------
 fs/netfs/objects.c             |   2 +-
 fs/netfs/read_pgpriv2.c        |  32 ++---
 fs/netfs/read_retry.c          |   2 +-
 fs/netfs/rolling_buffer.c      | 226 +++++++++++++++++++++++++++++++++
 fs/netfs/write_collect.c       |  19 +--
 fs/netfs/write_issue.c         |  26 ++--
 include/linux/netfs.h          |  10 +-
 include/linux/rolling_buffer.h |  61 +++++++++
 include/trace/events/netfs.h   |   2 +
 15 files changed, 375 insertions(+), 300 deletions(-)
 create mode 100644 fs/netfs/rolling_buffer.c
 create mode 100644 include/linux/rolling_buffer.h

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index d08b0bfb6756..7492c4aa331e 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -13,6 +13,7 @@ netfs-y := \
 	read_collect.o \
 	read_pgpriv2.o \
 	read_retry.o \
+	rolling_buffer.o \
 	write_collect.o \
 	write_issue.o
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ec04d5628d8..db874fea8794 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -63,37 +63,6 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
 	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
 }
 
-/*
- * Decant the list of folios to read into a rolling buffer.
- */
-static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
-					struct folio_queue *folioq,
-					struct folio_batch *put_batch)
-{
-	unsigned int order, nr;
-	size_t size = 0;
-
-	nr = __readahead_batch(rreq->ractl, (struct page **)folioq->vec.folios,
-			       ARRAY_SIZE(folioq->vec.folios));
-	folioq->vec.nr = nr;
-	for (int i = 0; i < nr; i++) {
-		struct folio *folio = folioq_folio(folioq, i);
-
-		trace_netfs_folio(folio, netfs_folio_trace_read);
-		order = folio_order(folio);
-		folioq->orders[i] = order;
-		size += PAGE_SIZE << order;
-
-		if (!folio_batch_add(put_batch, folio))
-			folio_batch_release(put_batch);
-	}
-
-	for (int i = nr; i < folioq_nr_slots(folioq); i++)
-		folioq_clear(folioq, i);
-
-	return size;
-}
-
 /*
  * netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
  * @subreq: The subrequest to be set up
@@ -128,18 +97,12 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 
 		folio_batch_init(&put_batch);
 		while (rreq->submitted < subreq->start + rsize) {
-			struct folio_queue *tail = rreq->buffer_tail, *new;
-			size_t added;
-
-			new = netfs_folioq_alloc(rreq->debug_id, GFP_NOFS,
-						 netfs_trace_folioq_alloc_read_prep);
-			if (!new)
-				return -ENOMEM;
-			new->prev = tail;
-			tail->next = new;
-			rreq->buffer_tail = new;
-			added = netfs_load_buffer_from_ra(rreq, new, &put_batch);
-			rreq->iter.count += added;
+			ssize_t added;
+
+			added = rolling_buffer_load_from_ra(&rreq->buffer, rreq->ractl,
+							    &put_batch);
+			if (added < 0)
+				return added;
 			rreq->submitted += added;
 		}
 		folio_batch_release(&put_batch);
@@ -147,7 +110,7 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 
 	subreq->len = rsize;
 	if (unlikely(rreq->io_streams[0].sreq_max_segs)) {
-		size_t limit = netfs_limit_iter(&rreq->iter, 0, rsize,
+		size_t limit = netfs_limit_iter(&rreq->buffer.iter, 0, rsize,
 						rreq->io_streams[0].sreq_max_segs);
 
 		if (limit < rsize) {
@@ -156,20 +119,16 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 		}
 	}
 
-	subreq->io_iter	= rreq->iter;
+	subreq->io_iter	= rreq->buffer.iter;
 
 	if (iov_iter_is_folioq(&subreq->io_iter)) {
-		if (subreq->io_iter.folioq_slot >= folioq_nr_slots(subreq->io_iter.folioq)) {
-			subreq->io_iter.folioq = subreq->io_iter.folioq->next;
-			subreq->io_iter.folioq_slot = 0;
-		}
 		subreq->curr_folioq = (struct folio_queue *)subreq->io_iter.folioq;
 		subreq->curr_folioq_slot = subreq->io_iter.folioq_slot;
 		subreq->curr_folio_order = subreq->curr_folioq->orders[subreq->curr_folioq_slot];
 	}
 
 	iov_iter_truncate(&subreq->io_iter, subreq->len);
-	iov_iter_advance(&rreq->iter, subreq->len);
+	rolling_buffer_advance(&rreq->buffer, subreq->len);
 	return subreq->len;
 }
 
@@ -352,34 +311,6 @@ static int netfs_wait_for_read(struct netfs_io_request *rreq)
 	return ret;
 }
 
-/*
- * Set up the initial folioq of buffer folios in the rolling buffer and set the
- * iterator to refer to it.
- */
-static int netfs_prime_buffer(struct netfs_io_request *rreq)
-{
-	struct folio_queue *folioq;
-	struct folio_batch put_batch;
-	size_t added;
-
-	folioq = netfs_folioq_alloc(rreq->debug_id, GFP_KERNEL,
-				    netfs_trace_folioq_alloc_read_prime);
-	if (!folioq)
-		return -ENOMEM;
-
-	rreq->buffer = folioq;
-	rreq->buffer_tail = folioq;
-	rreq->submitted = rreq->start;
-	iov_iter_folio_queue(&rreq->iter, ITER_DEST, folioq, 0, 0, 0);
-
-	folio_batch_init(&put_batch);
-	added = netfs_load_buffer_from_ra(rreq, folioq, &put_batch);
-	folio_batch_release(&put_batch);
-	rreq->iter.count += added;
-	rreq->submitted += added;
-	return 0;
-}
-
 /**
  * netfs_readahead - Helper to manage a read request
  * @ractl: The description of the readahead request
@@ -419,7 +350,8 @@ void netfs_readahead(struct readahead_control *ractl)
 	netfs_rreq_expand(rreq, ractl);
 
 	rreq->ractl = ractl;
-	if (netfs_prime_buffer(rreq) < 0)
+	rreq->submitted = rreq->start;
+	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
 		goto cleanup_free;
 	netfs_read_to_pagecache(rreq);
 
@@ -435,22 +367,18 @@ EXPORT_SYMBOL(netfs_readahead);
 /*
  * Create a rolling buffer with a single occupying folio.
  */
-static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct folio *folio)
+static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct folio *folio,
+					unsigned int rollbuf_flags)
 {
-	struct folio_queue *folioq;
+	ssize_t added;
 
-	folioq = netfs_folioq_alloc(rreq->debug_id, GFP_KERNEL,
-				    netfs_trace_folioq_alloc_read_sing);
-	if (!folioq)
+	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
 		return -ENOMEM;
 
-	folioq_append(folioq, folio);
-	BUG_ON(folioq_folio(folioq, 0) != folio);
-	BUG_ON(folioq_folio_order(folioq, 0) != folio_order(folio));
-	rreq->buffer = folioq;
-	rreq->buffer_tail = folioq;
-	rreq->submitted = rreq->start + rreq->len;
-	iov_iter_folio_queue(&rreq->iter, ITER_DEST, folioq, 0, 0, rreq->len);
+	added = rolling_buffer_append(&rreq->buffer, folio, rollbuf_flags);
+	if (added < 0)
+		return added;
+	rreq->submitted = rreq->start + added;
 	rreq->ractl = (struct readahead_control *)1UL;
 	return 0;
 }
@@ -518,7 +446,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	}
 	if (to < flen)
 		bvec_set_folio(&bvec[i++], folio, flen - to, to);
-	iov_iter_bvec(&rreq->iter, ITER_DEST, bvec, i, rreq->len);
+	iov_iter_bvec(&rreq->buffer.iter, ITER_DEST, bvec, i, rreq->len);
 	rreq->submitted = rreq->start + flen;
 
 	netfs_read_to_pagecache(rreq);
@@ -586,7 +514,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
 	/* Set up the output buffer */
-	ret = netfs_create_singular_buffer(rreq, folio);
+	ret = netfs_create_singular_buffer(rreq, folio, 0);
 	if (ret < 0)
 		goto discard;
 
@@ -743,7 +671,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
 
 	/* Set up the output buffer */
-	ret = netfs_create_singular_buffer(rreq, folio);
+	ret = netfs_create_singular_buffer(rreq, folio, 0);
 	if (ret < 0)
 		goto error_put;
 
@@ -808,11 +736,10 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	trace_netfs_read(rreq, start, flen, netfs_read_trace_prefetch_for_write);
 
 	/* Set up the output buffer */
-	ret = netfs_create_singular_buffer(rreq, folio);
+	ret = netfs_create_singular_buffer(rreq, folio, NETFS_ROLLBUF_PAGECACHE_MARK);
 	if (ret < 0)
 		goto error_put;
 
-	folioq_mark2(rreq->buffer, 0);
 	netfs_read_to_pagecache(rreq);
 	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index b1a66a6e6bc2..a3f23adbae0f 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -25,7 +25,7 @@ static void netfs_prepare_dio_read_iterator(struct netfs_io_subrequest *subreq)
 	subreq->len = rsize;
 
 	if (unlikely(rreq->io_streams[0].sreq_max_segs)) {
-		size_t limit = netfs_limit_iter(&rreq->iter, 0, rsize,
+		size_t limit = netfs_limit_iter(&rreq->buffer.iter, 0, rsize,
 						rreq->io_streams[0].sreq_max_segs);
 
 		if (limit < rsize) {
@@ -36,9 +36,9 @@ static void netfs_prepare_dio_read_iterator(struct netfs_io_subrequest *subreq)
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
-	subreq->io_iter	= rreq->iter;
+	subreq->io_iter	= rreq->buffer.iter;
 	iov_iter_truncate(&subreq->io_iter, subreq->len);
-	iov_iter_advance(&rreq->iter, subreq->len);
+	iov_iter_advance(&rreq->buffer.iter, subreq->len);
 }
 
 /*
@@ -199,15 +199,15 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	 * the request.
 	 */
 	if (user_backed_iter(iter)) {
-		ret = netfs_extract_user_iter(iter, rreq->len, &rreq->iter, 0);
+		ret = netfs_extract_user_iter(iter, rreq->len, &rreq->buffer.iter, 0);
 		if (ret < 0)
 			goto out;
-		rreq->direct_bv = (struct bio_vec *)rreq->iter.bvec;
+		rreq->direct_bv = (struct bio_vec *)rreq->buffer.iter.bvec;
 		rreq->direct_bv_count = ret;
 		rreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
-		rreq->len = iov_iter_count(&rreq->iter);
+		rreq->len = iov_iter_count(&rreq->buffer.iter);
 	} else {
-		rreq->iter = *iter;
+		rreq->buffer.iter = *iter;
 		rreq->len = orig_count;
 		rreq->direct_bv_unpin = false;
 		iov_iter_advance(iter, orig_count);
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 173e8b5e6a93..eded8afaa60b 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -68,19 +68,17 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		 * request.
 		 */
 		if (async || user_backed_iter(iter)) {
-			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
+			n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
 			if (n < 0) {
 				ret = n;
 				goto out;
 			}
-			wreq->direct_bv = (struct bio_vec *)wreq->iter.bvec;
+			wreq->direct_bv = (struct bio_vec *)wreq->buffer.iter.bvec;
 			wreq->direct_bv_count = n;
 			wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
 		} else {
-			wreq->iter = *iter;
+			wreq->buffer.iter = *iter;
 		}
-
-		wreq->io_iter = wreq->iter;
 	}
 
 	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
@@ -92,7 +90,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
 	if (async)
 		wreq->iocb = iocb;
-	wreq->len = iov_iter_count(&wreq->io_iter);
+	wreq->len = iov_iter_count(&wreq->buffer.iter);
 	wreq->cleanup = netfs_cleanup_dio_write;
 	ret = netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
 	if (ret < 0) {
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 01b013f558f7..ccd9058acb61 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -60,10 +60,6 @@ static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
  */
 struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq,
 					    enum netfs_folioq_trace trace);
-int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
-			      bool needs_put);
-struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq);
-void netfs_clear_buffer(struct netfs_io_request *rreq);
 void netfs_reset_iter(struct netfs_io_subrequest *subreq);
 
 /*
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index afe032551de5..4249715f4171 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,153 +8,6 @@
 #include <linux/swap.h>
 #include "internal.h"
 
-/**
- * netfs_folioq_alloc - Allocate a folio_queue struct
- * @rreq_id: Associated debugging ID for tracing purposes
- * @gfp: Allocation constraints
- * @trace: Trace tag to indicate the purpose of the allocation
- *
- * Allocate, initialise and account the folio_queue struct and log a trace line
- * to mark the allocation.
- */
-struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
-				       unsigned int /*enum netfs_folioq_trace*/ trace)
-{
-	static atomic_t debug_ids;
-	struct folio_queue *fq;
-
-	fq = kmalloc(sizeof(*fq), gfp);
-	if (fq) {
-		netfs_stat(&netfs_n_folioq);
-		folioq_init(fq, rreq_id);
-		fq->debug_id = atomic_inc_return(&debug_ids);
-		trace_netfs_folioq(fq, trace);
-	}
-	return fq;
-}
-EXPORT_SYMBOL(netfs_folioq_alloc);
-
-/**
- * netfs_folioq_free - Free a folio_queue struct
- * @folioq: The object to free
- * @trace: Trace tag to indicate which free
- *
- * Free and unaccount the folio_queue struct.
- */
-void netfs_folioq_free(struct folio_queue *folioq,
-		       unsigned int /*enum netfs_trace_folioq*/ trace)
-{
-	trace_netfs_folioq(folioq, trace);
-	netfs_stat_d(&netfs_n_folioq);
-	kfree(folioq);
-}
-EXPORT_SYMBOL(netfs_folioq_free);
-
-/*
- * Make sure there's space in the rolling queue.
- */
-struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq,
-					    enum netfs_folioq_trace trace)
-{
-	struct folio_queue *tail = rreq->buffer_tail, *prev;
-	unsigned int prev_nr_slots = 0;
-
-	if (WARN_ON_ONCE(!rreq->buffer && tail) ||
-	    WARN_ON_ONCE(rreq->buffer && !tail))
-		return ERR_PTR(-EIO);
-
-	prev = tail;
-	if (prev) {
-		if (!folioq_full(tail))
-			return tail;
-		prev_nr_slots = folioq_nr_slots(tail);
-	}
-
-	tail = netfs_folioq_alloc(rreq->debug_id, GFP_NOFS, trace);
-	if (!tail)
-		return ERR_PTR(-ENOMEM);
-	tail->prev = prev;
-	if (prev)
-		/* [!] NOTE: After we set prev->next, the consumer is entirely
-		 * at liberty to delete prev.
-		 */
-		WRITE_ONCE(prev->next, tail);
-
-	rreq->buffer_tail = tail;
-	if (!rreq->buffer) {
-		rreq->buffer = tail;
-		iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE, tail, 0, 0, 0);
-	} else {
-		/* Make sure we don't leave the master iterator pointing to a
-		 * block that might get immediately consumed.
-		 */
-		if (rreq->io_iter.folioq == prev &&
-		    rreq->io_iter.folioq_slot == prev_nr_slots) {
-			rreq->io_iter.folioq = tail;
-			rreq->io_iter.folioq_slot = 0;
-		}
-	}
-	rreq->buffer_tail_slot = 0;
-	return tail;
-}
-
-/*
- * Append a folio to the rolling queue.
- */
-int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
-			      bool needs_put)
-{
-	struct folio_queue *tail;
-	unsigned int slot, order = folio_order(folio);
-
-	tail = netfs_buffer_make_space(rreq, netfs_trace_folioq_alloc_append_folio);
-	if (IS_ERR(tail))
-		return PTR_ERR(tail);
-
-	rreq->io_iter.count += PAGE_SIZE << order;
-
-	slot = folioq_append(tail, folio);
-	/* Store the counter after setting the slot. */
-	smp_store_release(&rreq->buffer_tail_slot, slot);
-	return 0;
-}
-
-/*
- * Delete the head of a rolling queue.
- */
-struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq)
-{
-	struct folio_queue *head = wreq->buffer, *next = head->next;
-
-	if (next)
-		next->prev = NULL;
-	netfs_folioq_free(head, netfs_trace_folioq_delete);
-	wreq->buffer = next;
-	return next;
-}
-
-/*
- * Clear out a rolling queue.
- */
-void netfs_clear_buffer(struct netfs_io_request *rreq)
-{
-	struct folio_queue *p;
-
-	while ((p = rreq->buffer)) {
-		rreq->buffer = p->next;
-		for (int slot = 0; slot < folioq_count(p); slot++) {
-			struct folio *folio = folioq_folio(p, slot);
-			if (!folio)
-				continue;
-			if (folioq_is_marked(p, slot)) {
-				trace_netfs_folio(folio, netfs_folio_trace_put);
-				folio_put(folio);
-			}
-		}
-		netfs_folioq_free(p, netfs_trace_folioq_clear);
-	}
-}
-
 /*
  * Reset the subrequest iterator to refer just to the region remaining to be
  * read.  The iterator may or may not have been advanced by socket ops or
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 31e388ec6e48..5cdddaf1f978 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -143,7 +143,7 @@ static void netfs_free_request(struct work_struct *work)
 		}
 		kvfree(rreq->direct_bv);
 	}
-	netfs_clear_buffer(rreq);
+	rolling_buffer_clear(&rreq->buffer);
 
 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 54d5004fec18..9eee5af6b327 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -34,8 +34,9 @@ void netfs_pgpriv2_mark_copy_to_cache(struct netfs_io_subrequest *subreq,
  * [DEPRECATED] Cancel PG_private_2 on all marked folios in the event of an
  * unrecoverable error.
  */
-static void netfs_pgpriv2_cancel(struct folio_queue *folioq)
+static void netfs_pgpriv2_cancel(struct rolling_buffer *buffer)
 {
+	struct folio_queue *folioq = buffer->tail;
 	struct folio *folio;
 	int slot;
 
@@ -94,7 +95,7 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 	trace_netfs_folio(folio, netfs_folio_trace_store_copy);
 
 	/* Attach the folio to the rolling buffer. */
-	if (netfs_buffer_append_folio(wreq, folio, false) < 0)
+	if (rolling_buffer_append(&wreq->buffer, folio, 0) < 0)
 		return -ENOMEM;
 
 	cache->submit_extendable_to = fsize;
@@ -109,7 +110,7 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 	do {
 		ssize_t part;
 
-		wreq->io_iter.iov_offset = cache->submit_off;
+		wreq->buffer.iter.iov_offset = cache->submit_off;
 
 		atomic64_set(&wreq->issued_to, fpos + cache->submit_off);
 		cache->submit_extendable_to = fsize - cache->submit_off;
@@ -122,8 +123,8 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 			cache->submit_len -= part;
 	} while (cache->submit_len > 0);
 
-	wreq->io_iter.iov_offset = 0;
-	iov_iter_advance(&wreq->io_iter, fsize);
+	wreq->buffer.iter.iov_offset = 0;
+	rolling_buffer_advance(&wreq->buffer, fsize);
 	atomic64_set(&wreq->issued_to, fpos + fsize);
 
 	if (flen < fsize)
@@ -151,7 +152,7 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
 		goto couldnt_start;
 
 	/* Need the first folio to be able to set up the op. */
-	for (folioq = rreq->buffer; folioq; folioq = folioq->next) {
+	for (folioq = rreq->buffer.tail; folioq; folioq = folioq->next) {
 		if (folioq->marks3) {
 			slot = __ffs(folioq->marks3);
 			break;
@@ -198,7 +199,7 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
 	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
 	_leave(" = %d", error);
 couldnt_start:
-	netfs_pgpriv2_cancel(rreq->buffer);
+	netfs_pgpriv2_cancel(&rreq->buffer);
 }
 
 /*
@@ -207,13 +208,13 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
  */
 bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
 {
-	struct folio_queue *folioq = wreq->buffer;
+	struct folio_queue *folioq = wreq->buffer.tail;
 	unsigned long long collected_to = wreq->collected_to;
-	unsigned int slot = wreq->buffer_head_slot;
+	unsigned int slot = wreq->buffer.first_tail_slot;
 	bool made_progress = false;
 
 	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = netfs_delete_buffer_head(wreq);
+		folioq = rolling_buffer_delete_spent(&wreq->buffer);
 		slot = 0;
 	}
 
@@ -252,9 +253,9 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
 		folioq_clear(folioq, slot);
 		slot++;
 		if (slot >= folioq_nr_slots(folioq)) {
-			if (READ_ONCE(wreq->buffer_tail) == folioq)
-				break;
-			folioq = netfs_delete_buffer_head(wreq);
+			folioq = rolling_buffer_delete_spent(&wreq->buffer);
+			if (!folioq)
+				goto done;
 			slot = 0;
 		}
 
@@ -262,7 +263,8 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
 			break;
 	}
 
-	wreq->buffer = folioq;
-	wreq->buffer_head_slot = slot;
+	wreq->buffer.tail = folioq;
+done:
+	wreq->buffer.first_tail_slot = slot;
 	return made_progress;
 }
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 21b4a54e545e..0983234c2183 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -245,7 +245,7 @@ void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
 {
 	struct folio_queue *p;
 
-	for (p = rreq->buffer; p; p = p->next) {
+	for (p = rreq->buffer.tail; p; p = p->next) {
 		for (int slot = 0; slot < folioq_count(p); slot++) {
 			struct folio *folio = folioq_folio(p, slot);
 
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
new file mode 100644
index 000000000000..75d97af14b4a
--- /dev/null
+++ b/fs/netfs/rolling_buffer.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Rolling buffer helpers
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/bitops.h>
+#include <linux/pagemap.h>
+#include <linux/rolling_buffer.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+static atomic_t debug_ids;
+
+/**
+ * netfs_folioq_alloc - Allocate a folio_queue struct
+ * @rreq_id: Associated debugging ID for tracing purposes
+ * @gfp: Allocation constraints
+ * @trace: Trace tag to indicate the purpose of the allocation
+ *
+ * Allocate, initialise and account the folio_queue struct and log a trace line
+ * to mark the allocation.
+ */
+struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
+				       unsigned int /*enum netfs_folioq_trace*/ trace)
+{
+	struct folio_queue *fq;
+
+	fq = kmalloc(sizeof(*fq), gfp);
+	if (fq) {
+		netfs_stat(&netfs_n_folioq);
+		folioq_init(fq, rreq_id);
+		fq->debug_id = atomic_inc_return(&debug_ids);
+		trace_netfs_folioq(fq, trace);
+	}
+	return fq;
+}
+EXPORT_SYMBOL(netfs_folioq_alloc);
+
+/**
+ * netfs_folioq_free - Free a folio_queue struct
+ * @folioq: The object to free
+ * @trace: Trace tag to indicate which free
+ *
+ * Free and unaccount the folio_queue struct.
+ */
+void netfs_folioq_free(struct folio_queue *folioq,
+		       unsigned int /*enum netfs_trace_folioq*/ trace)
+{
+	trace_netfs_folioq(folioq, trace);
+	netfs_stat_d(&netfs_n_folioq);
+	kfree(folioq);
+}
+EXPORT_SYMBOL(netfs_folioq_free);
+
+/*
+ * Initialise a rolling buffer.  We allocate an empty folio queue struct to so
+ * that the pointers can be independently driven by the producer and the
+ * consumer.
+ */
+int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
+			unsigned int direction)
+{
+	struct folio_queue *fq;
+
+	fq = netfs_folioq_alloc(rreq_id, GFP_NOFS, netfs_trace_folioq_rollbuf_init);
+	if (!fq)
+		return -ENOMEM;
+
+	roll->head = fq;
+	roll->tail = fq;
+	iov_iter_folio_queue(&roll->iter, direction, fq, 0, 0, 0);
+	return 0;
+}
+
+/*
+ * Add another folio_queue to a rolling buffer if there's no space left.
+ */
+int rolling_buffer_make_space(struct rolling_buffer *roll)
+{
+	struct folio_queue *fq, *head = roll->head;
+
+	if (!folioq_full(head))
+		return 0;
+
+	fq = netfs_folioq_alloc(head->rreq_id, GFP_NOFS, netfs_trace_folioq_make_space);
+	if (!fq)
+		return -ENOMEM;
+	fq->prev = head;
+
+	roll->head = fq;
+	if (folioq_full(head)) {
+		/* Make sure we don't leave the master iterator pointing to a
+		 * block that might get immediately consumed.
+		 */
+		if (roll->iter.folioq == head &&
+		    roll->iter.folioq_slot == folioq_nr_slots(head)) {
+			roll->iter.folioq = fq;
+			roll->iter.folioq_slot = 0;
+		}
+	}
+
+	/* Make sure the initialisation is stored before the next pointer.
+	 *
+	 * [!] NOTE: After we set head->next, the consumer is at liberty to
+	 * immediately delete the old head.
+	 */
+	smp_store_release(&head->next, fq);
+	return 0;
+}
+
+/*
+ * Decant the list of folios to read into a rolling buffer.
+ */
+ssize_t rolling_buffer_load_from_ra(struct rolling_buffer *roll,
+				    struct readahead_control *ractl,
+				    struct folio_batch *put_batch)
+{
+	struct folio_queue *fq;
+	struct page **vec;
+	int nr, ix, to;
+	ssize_t size = 0;
+
+	if (rolling_buffer_make_space(roll) < 0)
+		return -ENOMEM;
+
+	fq = roll->head;
+	vec = (struct page **)fq->vec.folios;
+	nr = __readahead_batch(ractl, vec + folio_batch_count(&fq->vec),
+			       folio_batch_space(&fq->vec));
+	ix = fq->vec.nr;
+	to = ix + nr;
+	fq->vec.nr = to;
+	for (; ix < to; ix++) {
+		struct folio *folio = folioq_folio(fq, ix);
+		unsigned int order = folio_order(folio);
+
+		fq->orders[ix] = order;
+		size += PAGE_SIZE << order;
+		trace_netfs_folio(folio, netfs_folio_trace_read);
+		if (!folio_batch_add(put_batch, folio))
+			folio_batch_release(put_batch);
+	}
+	WRITE_ONCE(roll->iter.count, roll->iter.count + size);
+
+	/* Store the counter after setting the slot. */
+	smp_store_release(&roll->next_head_slot, to);
+
+	for (; ix < folioq_nr_slots(fq); ix++)
+		folioq_clear(fq, ix);
+
+	return size;
+}
+
+/*
+ * Append a folio to the rolling buffer.
+ */
+ssize_t rolling_buffer_append(struct rolling_buffer *roll, struct folio *folio,
+			      unsigned int flags)
+{
+	ssize_t size = folio_size(folio);
+	int slot;
+
+	if (rolling_buffer_make_space(roll) < 0)
+		return -ENOMEM;
+
+	slot = folioq_append(roll->head, folio);
+	if (flags & ROLLBUF_MARK_1)
+		folioq_mark(roll->head, slot);
+	if (flags & ROLLBUF_MARK_2)
+		folioq_mark2(roll->head, slot);
+
+	WRITE_ONCE(roll->iter.count, roll->iter.count + size);
+
+	/* Store the counter after setting the slot. */
+	smp_store_release(&roll->next_head_slot, slot);
+	return size;
+}
+
+/*
+ * Delete a spent buffer from a rolling queue and return the next in line.  We
+ * don't return the last buffer to keep the pointers independent, but return
+ * NULL instead.
+ */
+struct folio_queue *rolling_buffer_delete_spent(struct rolling_buffer *roll)
+{
+	struct folio_queue *spent = roll->tail, *next = READ_ONCE(spent->next);
+
+	if (!next)
+		return NULL;
+	next->prev = NULL;
+	netfs_folioq_free(spent, netfs_trace_folioq_delete);
+	roll->tail = next;
+	return next;
+}
+
+/*
+ * Clear out a rolling queue.  Folios that have mark 1 set are put.
+ */
+void rolling_buffer_clear(struct rolling_buffer *roll)
+{
+	struct folio_batch fbatch;
+	struct folio_queue *p;
+
+	folio_batch_init(&fbatch);
+
+	while ((p = roll->tail)) {
+		roll->tail = p->next;
+		for (int slot = 0; slot < folioq_count(p); slot++) {
+			struct folio *folio = folioq_folio(p, slot);
+
+			if (!folio)
+				continue;
+			if (folioq_is_marked(p, slot)) {
+				trace_netfs_folio(folio, netfs_folio_trace_put);
+				if (!folio_batch_add(&fbatch, folio))
+					folio_batch_release(&fbatch);
+			}
+		}
+
+		netfs_folioq_free(p, netfs_trace_folioq_clear);
+	}
+
+	folio_batch_release(&fbatch);
+}
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index ca3a11ed9b54..364c1f9d5815 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -83,9 +83,9 @@ int netfs_folio_written_back(struct folio *folio)
 static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 					  unsigned int *notes)
 {
-	struct folio_queue *folioq = wreq->buffer;
+	struct folio_queue *folioq = wreq->buffer.tail;
 	unsigned long long collected_to = wreq->collected_to;
-	unsigned int slot = wreq->buffer_head_slot;
+	unsigned int slot = wreq->buffer.first_tail_slot;
 
 	if (wreq->origin == NETFS_PGPRIV2_COPY_TO_CACHE) {
 		if (netfs_pgpriv2_unlock_copied_folios(wreq))
@@ -94,7 +94,9 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 	}
 
 	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = netfs_delete_buffer_head(wreq);
+		folioq = rolling_buffer_delete_spent(&wreq->buffer);
+		if (!folioq)
+			return;
 		slot = 0;
 	}
 
@@ -134,9 +136,9 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		folioq_clear(folioq, slot);
 		slot++;
 		if (slot >= folioq_nr_slots(folioq)) {
-			if (READ_ONCE(wreq->buffer_tail) == folioq)
-				break;
-			folioq = netfs_delete_buffer_head(wreq);
+			folioq = rolling_buffer_delete_spent(&wreq->buffer);
+			if (!folioq)
+				goto done;
 			slot = 0;
 		}
 
@@ -144,8 +146,9 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 			break;
 	}
 
-	wreq->buffer = folioq;
-	wreq->buffer_head_slot = slot;
+	wreq->buffer.tail = folioq;
+done:
+	wreq->buffer.first_tail_slot = slot;
 }
 
 /*
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 87e5cf4a0957..88ceba49ff69 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -107,6 +107,8 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	ictx = netfs_inode(wreq->inode);
 	if (is_buffered && netfs_is_cache_enabled(ictx))
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ictx));
+	if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE) < 0)
+		goto nomem;
 
 	wreq->cleaned_to = wreq->start;
 
@@ -129,6 +131,10 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	}
 
 	return wreq;
+nomem:
+	wreq->error = -ENOMEM;
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_failed);
+	return ERR_PTR(-ENOMEM);
 }
 
 /**
@@ -153,16 +159,15 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 				loff_t start)
 {
 	struct netfs_io_subrequest *subreq;
-	struct iov_iter *wreq_iter = &wreq->io_iter;
+	struct iov_iter *wreq_iter = &wreq->buffer.iter;
 
 	/* Make sure we don't point the iterator at a used-up folio_queue
 	 * struct being used as a placeholder to prevent the queue from
 	 * collapsing.  In such a case, extend the queue.
 	 */
 	if (iov_iter_is_folioq(wreq_iter) &&
-	    wreq_iter->folioq_slot >= folioq_nr_slots(wreq_iter->folioq)) {
-		netfs_buffer_make_space(wreq, netfs_trace_folioq_prep_write);
-	}
+	    wreq_iter->folioq_slot >= folioq_nr_slots(wreq_iter->folioq))
+		rolling_buffer_make_space(&wreq->buffer);
 
 	subreq = netfs_alloc_subrequest(wreq);
 	subreq->source		= stream->source;
@@ -327,6 +332,9 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 
 	_enter("");
 
+	if (rolling_buffer_make_space(&wreq->buffer) < 0)
+		return -ENOMEM;
+
 	/* netfs_perform_write() may shift i_size around the page or from out
 	 * of the page to beyond it, but cannot move i_size into or through the
 	 * page since we have it locked.
@@ -431,7 +439,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	}
 
 	/* Attach the folio to the rolling buffer. */
-	netfs_buffer_append_folio(wreq, folio, false);
+	rolling_buffer_append(&wreq->buffer, folio, 0);
 
 	/* Move the submission point forward to allow for write-streaming data
 	 * not starting at the front of the page.  We don't do write-streaming
@@ -478,7 +486,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 
 		/* Advance the iterator(s). */
 		if (stream->submit_off > iter_off) {
-			iov_iter_advance(&wreq->io_iter, stream->submit_off - iter_off);
+			rolling_buffer_advance(&wreq->buffer, stream->submit_off - iter_off);
 			iter_off = stream->submit_off;
 		}
 
@@ -496,7 +504,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	}
 
 	if (fsize > iter_off)
-		iov_iter_advance(&wreq->io_iter, fsize - iter_off);
+		rolling_buffer_advance(&wreq->buffer, fsize - iter_off);
 	atomic64_set(&wreq->issued_to, fpos + fsize);
 
 	if (!debug)
@@ -635,7 +643,7 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			       struct folio **writethrough_cache)
 {
 	_enter("R=%x ic=%zu ws=%u cp=%zu tp=%u",
-	       wreq->debug_id, wreq->iter.count, wreq->wsize, copied, to_page_end);
+	       wreq->debug_id, wreq->buffer.iter.count, wreq->wsize, copied, to_page_end);
 
 	if (!*writethrough_cache) {
 		if (folio_test_dirty(folio))
@@ -710,7 +718,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 		part = netfs_advance_write(wreq, upload, start, len, false);
 		start += part;
 		len -= part;
-		iov_iter_advance(&wreq->io_iter, part);
+		rolling_buffer_advance(&wreq->buffer, part);
 		if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 			trace_netfs_rreq(wreq, netfs_rreq_trace_wait_pause);
 			wait_on_bit(&wreq->flags, NETFS_RREQ_PAUSE, TASK_UNINTERRUPTIBLE);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5b2f427f8e3e..bd922f0936e3 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
+#include <linux/rolling_buffer.h>
 
 enum netfs_sreq_ref_trace;
 typedef struct mempool_s mempool_t;
@@ -238,10 +239,9 @@ struct netfs_io_request {
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
 	struct netfs_group	*group;		/* Writeback group being written back */
-	struct folio_queue	*buffer;	/* Head of I/O buffer */
-	struct folio_queue	*buffer_tail;	/* Tail of I/O buffer */
-	struct iov_iter		iter;		/* Unencrypted-side iterator */
-	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
+	struct rolling_buffer	buffer;		/* Unencrypted buffer */
+#define NETFS_ROLLBUF_PUT_MARK		ROLLBUF_MARK_1
+#define NETFS_ROLLBUF_PAGECACHE_MARK	ROLLBUF_MARK_2
 	void			*netfs_priv;	/* Private data for the netfs */
 	void			*netfs_priv2;	/* Private data for the netfs */
 	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-iter) */
@@ -259,8 +259,6 @@ struct netfs_io_request {
 	long			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
-	u8			buffer_head_slot; /* First slot in ->buffer */
-	u8			buffer_tail_slot; /* Next slot in ->buffer_tail */
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
diff --git a/include/linux/rolling_buffer.h b/include/linux/rolling_buffer.h
new file mode 100644
index 000000000000..ac15b1ffdd83
--- /dev/null
+++ b/include/linux/rolling_buffer.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Rolling buffer of folios
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _ROLLING_BUFFER_H
+#define _ROLLING_BUFFER_H
+
+#include <linux/folio_queue.h>
+#include <linux/uio.h>
+
+/*
+ * Rolling buffer.  Whilst the buffer is live and in use, folios and folio
+ * queue segments can be added to one end by one thread and removed from the
+ * other end by another thread.  The buffer isn't allowed to be empty; it must
+ * always have at least one folio_queue in it so that neither side has to
+ * modify both queue pointers.
+ *
+ * The iterator in the buffer is extended as buffers are inserted.  It can be
+ * snapshotted to use a segment of the buffer.
+ */
+struct rolling_buffer {
+	struct folio_queue	*head;		/* Producer's insertion point */
+	struct folio_queue	*tail;		/* Consumer's removal point */
+	struct iov_iter		iter;		/* Iterator tracking what's left in the buffer */
+	u8			next_head_slot;	/* Next slot in ->head */
+	u8			first_tail_slot; /* First slot in ->tail */
+};
+
+/*
+ * Snapshot of a rolling buffer.
+ */
+struct rolling_buffer_snapshot {
+	struct folio_queue	*curr_folioq;	/* Queue segment in which current folio resides */
+	unsigned char		curr_slot;	/* Folio currently being read */
+	unsigned char		curr_order;	/* Order of folio */
+};
+
+/* Marks to store per-folio in the internal folio_queue structs. */
+#define ROLLBUF_MARK_1	BIT(0)
+#define ROLLBUF_MARK_2	BIT(1)
+
+int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
+			unsigned int direction);
+int rolling_buffer_make_space(struct rolling_buffer *roll);
+ssize_t rolling_buffer_load_from_ra(struct rolling_buffer *roll,
+				    struct readahead_control *ractl,
+				    struct folio_batch *put_batch);
+ssize_t rolling_buffer_append(struct rolling_buffer *roll, struct folio *folio,
+			      unsigned int flags);
+struct folio_queue *rolling_buffer_delete_spent(struct rolling_buffer *roll);
+void rolling_buffer_clear(struct rolling_buffer *roll);
+
+static inline void rolling_buffer_advance(struct rolling_buffer *roll, size_t amount)
+{
+	iov_iter_advance(&roll->iter, amount);
+}
+
+#endif /* _ROLLING_BUFFER_H */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 50aa6745df95..2dfc9f716e3b 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -198,7 +198,9 @@
 	EM(netfs_trace_folioq_alloc_read_sing,	"alloc-r-sing")	\
 	EM(netfs_trace_folioq_clear,		"clear")	\
 	EM(netfs_trace_folioq_delete,		"delete")	\
+	EM(netfs_trace_folioq_make_space,	"make-space")	\
 	EM(netfs_trace_folioq_prep_write,	"prep-wr")	\
+	EM(netfs_trace_folioq_rollbuf_init,	"roll-init")	\
 	E_(netfs_trace_folioq_read_progress,	"r-progress")
 
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY


