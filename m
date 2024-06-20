Return-Path: <linux-fsdevel+bounces-22023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD47910F39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C1E1F21711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4FE1CCCD6;
	Thu, 20 Jun 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdwkyEbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF91CCCAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904840; cv=none; b=mf8WrN9RwQwtdIepFyhPzVAS8NPumoQnnvpG4RMcpHhrtq9XwVCPYGPF/bYkRTQg2e8tb8cbmQmufGe2CKL2e04mtTkoYu84cpmeWL+zx7SXP0PLkmOH74fZskpk7GOi/sHmN/ilo4nDoABXJDtkEHNDX04g+MEBqD89XWORU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904840; c=relaxed/simple;
	bh=P8QP21UeNT/8vkiq9jUGMTFERmFdbWjIVKF7drIj6xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvYwD/jEMoOHG20TqMurr5Milhr1N5iwOf8LgmbbNdUP68PGOcg8z5HgN+HxD+LT3ynMZIw73Y8/4C+mmHUMxWDDLn3Tv3iyvj7+m2LqjqICqj0KkQ49C12XSbbpFFQur/SejVhQBxPy3wriXkkiDaMi4HPHajLbY6sa7hMulQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdwkyEbp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpXuiacqqpADs77iIW3OXqAQBVMt9Y77HehVEfYnBzw=;
	b=bdwkyEbpqn8M+Grr3vFL/OvdoGyaxyjo5mMjx8uLv9Y3Pp8jHXsqcKc48qv00aBOfgCGpd
	OsRZosDEs9zzkI0BJ1YxNNLS9Q2ORB4JRtP+JLlx7atz38EhLclwa1qd3OXEoFlnvVU6pY
	s1FpsPke0Yiedt/UbUBhXFX9Mfa9xsc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-rByF131_NGSi_kks8_YHFw-1; Thu,
 20 Jun 2024 13:33:54 -0400
X-MC-Unique: rByF131_NGSi_kks8_YHFw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 109B319560A3;
	Thu, 20 Jun 2024 17:33:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 083E51955E72;
	Thu, 20 Jun 2024 17:33:44 +0000 (UTC)
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
Subject: [PATCH 15/17] netfs: Simplify the writeback code
Date: Thu, 20 Jun 2024 18:31:33 +0100
Message-ID: <20240620173137.610345-16-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use the new sheaf structures to simplify the writeback code.  The problem
with referring to the i_pages xarray directly is that we may have gaps in
the sequence of folios we're writing from that we need to skip when we're
removing the writeback mark from the folios we're writing back from.

At the moment the code tries to deal with this by carefully tracking the
gaps in each writeback stream (eg. write to server and write to cache) and
divining when there's a gap that spans folios (something that's not helped
by folios not being a consistent size).

Instead, the sheaf buffer contains pointers only the folios we're dealing
with, has them in ascending order and indicates a gap by placing
non-consequitive folios next to each other.  This makes it possible to
track where we need to clean up to by just keeping track of where we've
processed to on each stream and taking the minimum.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c     | 148 ++++++-----------------------------
 fs/netfs/write_issue.c       |  10 +--
 include/linux/netfs.h        |   1 -
 include/trace/events/netfs.h |  33 +-------
 4 files changed, 31 insertions(+), 161 deletions(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 394761041b4a..5de059ea9f75 100644
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
 	struct sheaf *sheaf = wreq->buffer;
+	unsigned long long collected_to = wreq->collected_to;
 	unsigned int slot = wreq->buffer_head_slot;
 
 	if (slot >= sheaf_nr_slots(sheaf)) {
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
@@ -374,7 +364,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *front, *remove;
 	struct netfs_io_stream *stream;
-	unsigned long long collected_to;
+	unsigned long long collected_to, issued_to;
 	unsigned int notes;
 	int s;
 
@@ -383,28 +373,21 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
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
@@ -416,26 +399,10 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
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
@@ -477,15 +444,6 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
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
 			spin_unlock(&wreq->lock);
 			netfs_put_subrequest(remove, false,
 					     notes & SAW_FAILURE ?
@@ -493,11 +451,16 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
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
 
+		if (list_empty(&stream->subrequests))
+			stream->collected_to = issued_to;
 		if (stream->collected_to < collected_to)
 			collected_to = stream->collected_to;
 	}
@@ -505,36 +468,6 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
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
@@ -545,43 +478,14 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 
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
index 8c65ac7c5d62..fb92dd8160f3 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -105,7 +105,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ictx));
 
-	wreq->contiguity = wreq->start;
 	wreq->cleaned_to = wreq->start;
 	INIT_WORK(&wreq->work, netfs_write_collection_worker);
 
@@ -247,9 +246,6 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
 	if (!subreq)
 		return;
 	stream->construct = NULL;
-
-	if (subreq->start + subreq->len > wreq->start + wreq->submitted)
-		WRITE_ONCE(wreq->submitted, subreq->start + subreq->len - wreq->start);
 	netfs_do_issue_write(stream, subreq, &wreq->io_iter);
 }
 
@@ -463,9 +459,9 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 			break;
 		stream = &wreq->io_streams[choose_s];
 
+		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
 		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
 					   stream->submit_len, to_eof);
-		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
 		stream->submit_off += part;
 		stream->submit_max_len -= part;
 		if (part > stream->submit_len)
@@ -524,10 +520,10 @@ int netfs_writepages(struct address_space *mapping,
 	netfs_stat(&netfs_n_wh_writepages);
 
 	do {
-		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
+		_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_to));
 
 		/* It appears we don't have to handle cyclic writeback wrapping. */
-		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
+		WARN_ON_ONCE(wreq && folio_pos(folio) < atomic64_read(&wreq->issued_to));
 
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index dc980f107c37..b880687bb932 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -262,7 +262,6 @@ struct netfs_io_request {
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
-	unsigned long long	contiguity;	/* Tracking for gaps in the writeback sequence */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index db603a4e22cd..64238a64ae5f 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -512,33 +512,6 @@ TRACE_EVENT(netfs_collect,
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
@@ -610,7 +583,6 @@ TRACE_EVENT(netfs_collect_state,
 		    __field(unsigned int,	notes		)
 		    __field(unsigned long long,	collected_to	)
 		    __field(unsigned long long,	cleaned_to	)
-		    __field(unsigned long long,	contiguity	)
 			     ),
 
 	    TP_fast_assign(
@@ -618,12 +590,11 @@ TRACE_EVENT(netfs_collect_state,
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
 


