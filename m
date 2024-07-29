Return-Path: <linux-fsdevel+bounces-24481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278093FAFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AA51F22F4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939C15F32D;
	Mon, 29 Jul 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QW4tN+nd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E99186E5B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270145; cv=none; b=IDPCX5pcvqMeoD3QdqkYkBMD64jI2WKA3R2Ca4/HGV9c8IxMfYrLasQpZ1RVS2yCCyNZXN1cOfYpWgXp8mYiOgEE/I93FihDGnCQzoJUEbaq++AByoo/XKcjBD7kOe3NmWBP7bNyRcKc+BGGdghp4BOWrHo5Pp3H628Gh73pj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270145; c=relaxed/simple;
	bh=3bxoxFG7GqjsyMNCXbXWCTYmjOmo+QyeSZCbNHoIb48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+L3c3WFOOVHQQ1HMp+Q1DEr3pkrBVY9mW7FsKgKWttgTEMuWZbFjuoj0lERoKyz/RxAttMXazLKFXtzSF9VNp7oRS30iMQFidvGqmNpWy0ODOBKZpGt4YfNrNiLLDIsKzIZnBzUKxYToUp2CwF2vfzPUBmA7pvZhzWgIWGFJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QW4tN+nd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nB3sAzXHskSLDfEutz1t67sHV2tAcmv/Y/MUHVeGl4I=;
	b=QW4tN+ndzvlZiYQKtAP+r06JrVOPFNZgnqpAOYgAzCDdYAwfO98JHribHTAA4LnzdOL3Ro
	Bfwk+ibhiPdGq4vEpxwPT/JSwjuWMW9ITsLB16oMrhKHMTov+Ku9rdSE2D0yGXKIbQE183
	wQ1U5undd92IQfVqz4GMka3rxCcCoAI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-XK8z_u20Mhuf2bs7TwiSNg-1; Mon,
 29 Jul 2024 12:22:16 -0400
X-MC-Unique: XK8z_u20Mhuf2bs7TwiSNg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D5A61955D54;
	Mon, 29 Jul 2024 16:22:13 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7FE119560AA;
	Mon, 29 Jul 2024 16:22:07 +0000 (UTC)
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
Subject: [PATCH 16/24] netfs: Simplify the writeback code
Date: Mon, 29 Jul 2024 17:19:45 +0100
Message-ID: <20240729162002.3436763-17-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Use the new folio_queue structures to simplify the writeback code.  The
problem with referring to the i_pages xarray directly is that we may have
gaps in the sequence of folios we're writing from that we need to skip when
we're removing the writeback mark from the folios we're writing back from.

At the moment the code tries to deal with this by carefully tracking the
gaps in each writeback stream (eg. write to server and write to cache) and
divining when there's a gap that spans folios (something that's not helped
by folios not being a consistent size).

Instead, the folio_queue buffer contains pointers only the folios we're
dealing with, has them in ascending order and indicates a gap by placing
non-consequitive folios next to each other.  This makes it possible to
track where we need to clean up to by just keeping track of where we've
processed to on each stream and taking the minimum.

Note that the I/O iterator is always rounded up to the end of the folio,
even if that is beyond the EOF position, so that the cache can do DIO from
the page.  The excess space is cleared, though mmapped writes clobber it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c     | 146 ++++++-----------------------------
 fs/netfs/write_issue.c       |  36 +++++----
 include/linux/netfs.h        |   1 -
 include/trace/events/netfs.h |  33 +-------
 4 files changed, 45 insertions(+), 171 deletions(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 801a130a0ce1..0116b336fa07 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -15,15 +15,11 @@
 
 /* Notes made in the collector */
 #define HIT_PENDING		0x01	/* A front op was still pending */
-#define SOME_EMPTY		0x02	/* One of more streams are empty */
-#define ALL_EMPTY		0x04	/* All streams are empty */
-#define MAYBE_DISCONTIG		0x08	/* A front op may be discontiguous (rounded to PAGE_SIZE) */
-#define NEED_REASSESS		0x10	/* Need to loop round and reassess */
-#define REASSESS_DISCONTIG	0x20	/* Reassess discontiguity if contiguity advances */
-#define MADE_PROGRESS		0x40	/* Made progress cleaning up a stream or the folio set */
-#define BUFFERED		0x80	/* The pagecache needs cleaning up */
-#define NEED_RETRY		0x100	/* A front op requests retrying */
-#define SAW_FAILURE		0x200	/* One stream or hit a permanent failure */
+#define NEED_REASSESS		0x02	/* Need to loop round and reassess */
+#define MADE_PROGRESS		0x04	/* Made progress cleaning up a stream or the folio set */
+#define BUFFERED		0x08	/* The pagecache needs cleaning up */
+#define NEED_RETRY		0x10	/* A front op requests retrying */
+#define SAW_FAILURE		0x20	/* One stream or hit a permanent failure */
 
 /*
  * Successful completion of write of a folio to the server and/or cache.  Note
@@ -78,10 +74,10 @@ int netfs_folio_written_back(struct folio *folio)
  * Unlock any folios we've finished with.
  */
 static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
-					  unsigned long long collected_to,
 					  unsigned int *notes)
 {
 	struct folio_queue *folioq = wreq->buffer;
+	unsigned long long collected_to = wreq->collected_to;
 	unsigned int slot = wreq->buffer_head_slot;
 
 	if (slot >= folioq_nr_slots(folioq)) {
@@ -110,12 +106,6 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 
 		trace_netfs_collect_folio(wreq, folio, fend, collected_to);
 
-		if (fpos + fsize > wreq->contiguity) {
-			trace_netfs_collect_contig(wreq, fpos + fsize,
-						   netfs_contig_trace_unlock);
-			wreq->contiguity = fpos + fsize;
-		}
-
 		/* Unlock any folio we've transferred all of. */
 		if (collected_to < fend)
 			break;
@@ -373,7 +363,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *front, *remove;
 	struct netfs_io_stream *stream;
-	unsigned long long collected_to;
+	unsigned long long collected_to, issued_to;
 	unsigned int notes;
 	int s;
 
@@ -382,28 +372,21 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_collect);
 
 reassess_streams:
+	issued_to = atomic64_read(&wreq->issued_to);
 	smp_rmb();
 	collected_to = ULLONG_MAX;
-	if (wreq->origin == NETFS_WRITEBACK)
-		notes = ALL_EMPTY | BUFFERED | MAYBE_DISCONTIG;
-	else if (wreq->origin == NETFS_WRITETHROUGH)
-		notes = ALL_EMPTY | BUFFERED;
+	if (wreq->origin == NETFS_WRITEBACK ||
+	    wreq->origin == NETFS_WRITETHROUGH)
+		notes = BUFFERED;
 	else
-		notes = ALL_EMPTY;
+		notes = 0;
 
 	/* Remove completed subrequests from the front of the streams and
 	 * advance the completion point on each stream.  We stop when we hit
 	 * something that's in progress.  The issuer thread may be adding stuff
 	 * to the tail whilst we're doing this.
-	 *
-	 * We must not, however, merge in discontiguities that span whole
-	 * folios that aren't under writeback.  This is made more complicated
-	 * by the folios in the gap being of unpredictable sizes - if they even
-	 * exist - but we don't want to look them up.
 	 */
 	for (s = 0; s < NR_IO_STREAMS; s++) {
-		loff_t rstart, rend;
-
 		stream = &wreq->io_streams[s];
 		/* Read active flag before list pointers */
 		if (!smp_load_acquire(&stream->active))
@@ -415,26 +398,10 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			//_debug("sreq [%x] %llx %zx/%zx",
 			//       front->debug_index, front->start, front->transferred, front->len);
 
-			/* Stall if there may be a discontinuity. */
-			rstart = round_down(front->start, PAGE_SIZE);
-			if (rstart > wreq->contiguity) {
-				if (wreq->contiguity > stream->collected_to) {
-					trace_netfs_collect_gap(wreq, stream,
-								wreq->contiguity, 'D');
-					stream->collected_to = wreq->contiguity;
-				}
-				notes |= REASSESS_DISCONTIG;
-				break;
+			if (stream->collected_to < front->start) {
+				trace_netfs_collect_gap(wreq, stream, issued_to, 'F');
+				stream->collected_to = front->start;
 			}
-			rend = round_up(front->start + front->len, PAGE_SIZE);
-			if (rend > wreq->contiguity) {
-				trace_netfs_collect_contig(wreq, rend,
-							   netfs_contig_trace_collect);
-				wreq->contiguity = rend;
-				if (notes & REASSESS_DISCONTIG)
-					notes |= NEED_REASSESS;
-			}
-			notes &= ~MAYBE_DISCONTIG;
 
 			/* Stall if the front is still undergoing I/O. */
 			if (test_bit(NETFS_SREQ_IN_PROGRESS, &front->flags)) {
@@ -476,15 +443,6 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			front = list_first_entry_or_null(&stream->subrequests,
 							 struct netfs_io_subrequest, rreq_link);
 			stream->front = front;
-			if (!front) {
-				unsigned long long jump_to = atomic64_read(&wreq->issued_to);
-
-				if (stream->collected_to < jump_to) {
-					trace_netfs_collect_gap(wreq, stream, jump_to, 'A');
-					stream->collected_to = jump_to;
-				}
-			}
-
 			spin_unlock_bh(&wreq->lock);
 			netfs_put_subrequest(remove, false,
 					     notes & SAW_FAILURE ?
@@ -492,10 +450,13 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 					     netfs_sreq_trace_put_done);
 		}
 
-		if (front)
-			notes &= ~ALL_EMPTY;
-		else
-			notes |= SOME_EMPTY;
+		/* If we have an empty stream, we need to jump it forward
+		 * otherwise the collection point will never advance.
+		 */
+		if (!front && issued_to > stream->collected_to) {
+			trace_netfs_collect_gap(wreq, stream, issued_to, 'E');
+			stream->collected_to = issued_to;
+		}
 
 		if (stream->collected_to < collected_to)
 			collected_to = stream->collected_to;
@@ -504,36 +465,6 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	if (collected_to != ULLONG_MAX && collected_to > wreq->collected_to)
 		wreq->collected_to = collected_to;
 
-	/* If we have an empty stream, we need to jump it forward over any gap
-	 * otherwise the collection point will never advance.
-	 *
-	 * Note that the issuer always adds to the stream with the lowest
-	 * so-far submitted start, so if we see two consecutive subreqs in one
-	 * stream with nothing between then in another stream, then the second
-	 * stream has a gap that can be jumped.
-	 */
-	if (notes & SOME_EMPTY) {
-		unsigned long long jump_to = wreq->start + READ_ONCE(wreq->submitted);
-
-		for (s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->active &&
-			    stream->front &&
-			    stream->front->start < jump_to)
-				jump_to = stream->front->start;
-		}
-
-		for (s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->active &&
-			    !stream->front &&
-			    stream->collected_to < jump_to) {
-				trace_netfs_collect_gap(wreq, stream, jump_to, 'B');
-				stream->collected_to = jump_to;
-			}
-		}
-	}
-
 	for (s = 0; s < NR_IO_STREAMS; s++) {
 		stream = &wreq->io_streams[s];
 		if (stream->active)
@@ -544,43 +475,14 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 
 	/* Unlock any folios that we have now finished with. */
 	if (notes & BUFFERED) {
-		unsigned long long clean_to = min(wreq->collected_to, wreq->contiguity);
-
-		if (wreq->cleaned_to < clean_to)
-			netfs_writeback_unlock_folios(wreq, clean_to, &notes);
+		if (wreq->cleaned_to < wreq->collected_to)
+			netfs_writeback_unlock_folios(wreq, &notes);
 	} else {
 		wreq->cleaned_to = wreq->collected_to;
 	}
 
 	// TODO: Discard encryption buffers
 
-	/* If all streams are discontiguous with the last folio we cleared, we
-	 * may need to skip a set of folios.
-	 */
-	if ((notes & (MAYBE_DISCONTIG | ALL_EMPTY)) == MAYBE_DISCONTIG) {
-		unsigned long long jump_to = ULLONG_MAX;
-
-		for (s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->active && stream->front &&
-			    stream->front->start < jump_to)
-				jump_to = stream->front->start;
-		}
-
-		trace_netfs_collect_contig(wreq, jump_to, netfs_contig_trace_jump);
-		wreq->contiguity = jump_to;
-		wreq->cleaned_to = jump_to;
-		wreq->collected_to = jump_to;
-		for (s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->collected_to < jump_to)
-				stream->collected_to = jump_to;
-		}
-		//cond_resched();
-		notes |= MADE_PROGRESS;
-		goto reassess_streams;
-	}
-
 	if (notes & NEED_RETRY)
 		goto need_retry;
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 520be44d132e..10ff2bd290cb 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -105,7 +105,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ictx));
 
-	wreq->contiguity = wreq->start;
 	wreq->cleaned_to = wreq->start;
 
 	wreq->io_streams[0].stream_nr		= 0;
@@ -156,6 +155,7 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 	subreq->source		= stream->source;
 	subreq->start		= start;
 	subreq->stream_nr	= stream->stream_nr;
+	subreq->io_iter		= wreq->io_iter;
 
 	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
 
@@ -211,22 +211,15 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
  * netfs_write_subrequest_terminated() when complete.
  */
 static void netfs_do_issue_write(struct netfs_io_stream *stream,
-				 struct netfs_io_subrequest *subreq,
-				 struct iov_iter *source)
+				 struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
-	size_t size = subreq->len - subreq->transferred;
 
 	_enter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
 
 	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 		return netfs_write_subrequest_terminated(subreq, subreq->error, false);
 
-	// TODO: Use encrypted buffer
-	subreq->io_iter = *source;
-	iov_iter_advance(source, size);
-	iov_iter_truncate(&subreq->io_iter, size);
-
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	stream->issue_write(subreq);
 }
@@ -235,8 +228,15 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct netfs_io_subrequest *subreq,
 			 struct iov_iter *source)
 {
+	size_t size = subreq->len - subreq->transferred;
+
+	// TODO: Use encrypted buffer
+	subreq->io_iter = *source;
+	iov_iter_advance(source, size);
+	iov_iter_truncate(&subreq->io_iter, size);
+
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_do_issue_write(stream, subreq, source);
+	netfs_do_issue_write(stream, subreq);
 }
 
 static void netfs_issue_write(struct netfs_io_request *wreq,
@@ -247,10 +247,8 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
 	if (!subreq)
 		return;
 	stream->construct = NULL;
-
-	if (subreq->start + subreq->len > wreq->start + wreq->submitted)
-		WRITE_ONCE(wreq->submitted, subreq->start + subreq->len - wreq->start);
-	netfs_do_issue_write(stream, subreq, &wreq->io_iter);
+	subreq->io_iter.count = subreq->len;
+	netfs_do_issue_write(stream, subreq);
 }
 
 /*
@@ -462,10 +460,11 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		if (choose_s < 0)
 			break;
 		stream = &wreq->io_streams[choose_s];
+		wreq->io_iter.iov_offset = stream->submit_off;
 
+		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
 		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
 					   stream->submit_len, to_eof);
-		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
 		stream->submit_off += part;
 		stream->submit_max_len -= part;
 		if (part > stream->submit_len)
@@ -476,6 +475,8 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 			debug = true;
 	}
 
+	wreq->io_iter.iov_offset = 0;
+	iov_iter_advance(&wreq->io_iter, fsize);
 	atomic64_set(&wreq->issued_to, fpos + fsize);
 
 	if (!debug)
@@ -524,10 +525,10 @@ int netfs_writepages(struct address_space *mapping,
 	netfs_stat(&netfs_n_wh_writepages);
 
 	do {
-		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
+		_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_to));
 
 		/* It appears we don't have to handle cyclic writeback wrapping. */
-		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
+		WARN_ON_ONCE(wreq && folio_pos(folio) < atomic64_read(&wreq->issued_to));
 
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
@@ -671,6 +672,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 		part = netfs_advance_write(wreq, upload, start, len, false);
 		start += part;
 		len -= part;
+		iov_iter_advance(&wreq->io_iter, part);
 		if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 			trace_netfs_rreq(wreq, netfs_rreq_trace_wait_pause);
 			wait_on_bit(&wreq->flags, NETFS_RREQ_PAUSE, TASK_UNINTERRUPTIBLE);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f8ca28d476c3..c47753a24623 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -258,7 +258,6 @@ struct netfs_io_request {
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
-	unsigned long long	contiguity;	/* Tracking for gaps in the writeback sequence */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 8d14715422c0..065fa168f964 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -510,33 +510,6 @@ TRACE_EVENT(netfs_collect,
 		      __entry->start + __entry->len)
 	    );
 
-TRACE_EVENT(netfs_collect_contig,
-	    TP_PROTO(const struct netfs_io_request *wreq, unsigned long long to,
-		     enum netfs_collect_contig_trace type),
-
-	    TP_ARGS(wreq, to, type),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		wreq)
-		    __field(enum netfs_collect_contig_trace, type)
-		    __field(unsigned long long,		contiguity)
-		    __field(unsigned long long,		to)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->wreq	= wreq->debug_id;
-		    __entry->type	= type;
-		    __entry->contiguity	= wreq->contiguity;
-		    __entry->to		= to;
-			   ),
-
-	    TP_printk("R=%08x %llx -> %llx %s",
-		      __entry->wreq,
-		      __entry->contiguity,
-		      __entry->to,
-		      __print_symbolic(__entry->type, netfs_collect_contig_traces))
-	    );
-
 TRACE_EVENT(netfs_collect_sreq,
 	    TP_PROTO(const struct netfs_io_request *wreq,
 		     const struct netfs_io_subrequest *subreq),
@@ -608,7 +581,6 @@ TRACE_EVENT(netfs_collect_state,
 		    __field(unsigned int,	notes		)
 		    __field(unsigned long long,	collected_to	)
 		    __field(unsigned long long,	cleaned_to	)
-		    __field(unsigned long long,	contiguity	)
 			     ),
 
 	    TP_fast_assign(
@@ -616,12 +588,11 @@ TRACE_EVENT(netfs_collect_state,
 		    __entry->notes	= notes;
 		    __entry->collected_to = collected_to;
 		    __entry->cleaned_to	= wreq->cleaned_to;
-		    __entry->contiguity = wreq->contiguity;
 			   ),
 
-	    TP_printk("R=%08x cto=%llx fto=%llx ctg=%llx n=%x",
+	    TP_printk("R=%08x col=%llx cln=%llx n=%x",
 		      __entry->wreq, __entry->collected_to,
-		      __entry->cleaned_to, __entry->contiguity,
+		      __entry->cleaned_to,
 		      __entry->notes)
 	    );
 


