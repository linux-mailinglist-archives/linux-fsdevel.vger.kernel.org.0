Return-Path: <linux-fsdevel+bounces-79387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPzrLJU9qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:11:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2E2010E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83432306BCF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD083B3C1D;
	Wed,  4 Mar 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry1Mg2XG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867C3B3C0B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633100; cv=none; b=YOjOM5srFUsxXeQv5dgnQyveA1I6ZJ1vps6QqqQu9/S/k2P1HvsQUjAn1qYziLPhPB35CinFOIp1aX8Jw25+3OKiPyd7JXFNBbPUd2boEtmdVbJTZiB0qBZeLamqoJ+bVA1taSup+Wbz5255wSJyCsPqX/8IUCoppsVVkK//JYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633100; c=relaxed/simple;
	bh=2rdQGmwDv+4ZvKsJsD9dN/dkw0EPvwyVFsjnaypRM1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLR642uvGTwdfCF+cGJeakkBYqP/Ix0s6cMvpS4G1FRkXD3mYwLDZ9VWFo8e0sXlXEga57bIX+efNdQPA1YvjewtOA2OYS1H257dAnuxeRKMmblY9TpDabsU4372VAg+hdLlIy2Aefu4f6WZ5nwHo/ESzOXbMCaeDY5LrTpa9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ry1Mg2XG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/32zjPwW5+8v0xgqozoFU8ltEyXQ6LKPVMQ2OlUvXVw=;
	b=Ry1Mg2XGq2cvpJGYapeZ0c3EwdkIcGwLnneDMH3k3A5Rp1LjlvVwPMoOKnQntUSHk8eHOF
	oVQqM0FV1zQKTGxOcj+bu2Wc7x9GA1Bar6W2lk4VnHLs/xWsYISXKCSodIsw1VonnuUDZP
	BitqMbuu2DqUdz40z2vYfbtDGsupmX4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-sqiE3qcGNMi_1fet9-ZxPg-1; Wed,
 04 Mar 2026 09:04:52 -0500
X-MC-Unique: sqiE3qcGNMi_1fet9-ZxPg-1
X-Mimecast-MFC-AGG-ID: sqiE3qcGNMi_1fet9-ZxPg_1772633090
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1F2718002D6;
	Wed,  4 Mar 2026 14:04:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDEAB1800756;
	Wed,  4 Mar 2026 14:04:43 +0000 (UTC)
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
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>
Subject: [RFC PATCH 10/17] netfs: Switch to using bvecq rather than folio_queue and rolling_buffer
Date: Wed,  4 Mar 2026 14:03:17 +0000
Message-ID: <20260304140328.112636-11-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 63F2E2010E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79387-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,batch.nr:url,talpey.com:email,samba.org:email,linux.dev:email,infradead.org:email,manguebit.org:email]
X-Rspamd-Action: no action

Switch netfslib to using bvecq, a segmented bio_vec[] queue, instead of the
folio_queue and rolling_buffer constructs, to keep track of the regions of
memory it is performing I/O upon.  Each bvecq struct in the chain is marked
with the starting file position of that sequence so that discontiguities
can be handled (the contents of each individual bvecq must be contiguous).

For buffered I/O, the folios are added to the queue as the operation
proceeds, much as it does now with folio_queues.  For unbuffered/direct
I/O, the iterator is extracted into the queue up front.

The bvecq structs are marked with information as to how the regions
contained therein should be disposed of (unlock-only, free, unpin).

When setting up a subrequest, netfslib will furnish it with a slice of the
main buffer queue as a pointer to starting bvecq, slot and offset and, for
the moment, an ITER_BVECQ iterator is set to cover the slice in
subreq->io_iter.

Notes on the implementation:

 (1) This patch uses the concept of a 'bvecq position', which is a tuple of
     { bvecq, slot, offset }.  This is lighter weight than using a full
     iov_iter, though that would also suffice.  If not NULL, the position
     also holds a reference on the bvecq it is pointing to.  This is
     probably overkill as only the hindmost position (that of collection)
     needs to hold a reference.

 (2) There are three positions on the netfs_io_request struct.  Not all are
     used by every request type.

     Firstly, there's ->load_cursor, which is used by buffered read and
     write to point to the next slot to have a folio inserted into it
     (either loaded from the readahead_control or from writeback_iter()).

     Secondly, there's ->dispatch_cursor, which is used to provide the
     position in the buffer from which we start dispatching a subrequest.

     Thirdly, there's the ->collect_cursor, which is used by the collection
     routines to point to the next memory region to be cleaned up.

 (3) There are two positions on the netfs_io_subrequest struct.

     Firstly, there's ->dispatch_pos, which indicates the position from
     which a subrequest's buffer begins.  This is used as the base of the
     position from which to retry (advanced by ->transfer).

     Secondly, there's ->content, which is normally the same as
     ->dispatch_pos but if the bvecq chain got duplicated or the content
     got copied, then this will point to that and will that will be
     disposed of on retry.

 (4) Maintenance of the position structs is done with helper functions,
     such as bvecq_pos_attach() to hide the refcounting.

 (5) When sending a write to the cache, the bvecq will be duplicated and
     the ends rounded up/down to the backing file's DIO block alignment.

 (6) bvec_slice() is used to select a slice of the source buffer and assign
     it to a subrequest.  The source buffer position is advanced.

 (7) netfs_extract_iter() is used by unbuffered/direct I/O API functions to
     decant a chunk of the iov_iter supplied by the VFS into a bvecq chain
     - and to label the bvecqs with appropriate disposal information
     (e.g. unpin, free, nothing).

There are further options that can be explored in the future:

 (1) Allow the provision of a duplicated bvecq chain for just that region
     so that the filesystem can add bits on either end (such as adding
     protocol headers and trailers and gluing several things together into
     a compound operation).

 (2) If a filesystem supports vectored/sparse read and write ops, it can be
     given a chain with discontiguities in it to perform in a single op
     (Ceph, for example, can do this).

 (3) Because each bvecq notes the start file position of the regions
     contained therein, there's no need to translate the info in the
     bio_vec into folio pointers in order to unlock the page after I/O.
     Instead, the inode's pagecache can be iterated over and the xarray
     marks cleared en masse.

 (4) Make MSG_SPLICE_PAGES handling read the disposal info in the bvecq and
     use that to indicate how it should get rid of the stuff it pasted into
     a sk_buff.

 (5) If a bounce buffer is needed (encryption, for example), the bounce
     buffer can be held in a bvecq and sliced up instead of the main buffer
     queue.

 (6) Get rid of subreq->io_iter and move the iov_iter stuff down into the
     filesystem.  The I/O iterators are normally only needed transitorily,
     and the one currently in netfs_io_subrequest is unnecessary most of
     the time.

folio_queue and rolling_buffer will be removed in a follow up patch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c           |  13 ---
 fs/netfs/Makefile            |   1 -
 fs/netfs/buffered_read.c     | 153 ++++++++++++++++++++++-----------
 fs/netfs/direct_read.c       |  73 ++++++----------
 fs/netfs/direct_write.c      |  72 +++++++++-------
 fs/netfs/internal.h          |  10 +--
 fs/netfs/iterator.c          |   2 +
 fs/netfs/misc.c              |  20 +----
 fs/netfs/objects.c           |  16 ++--
 fs/netfs/read_collect.c      |  83 +++++++++++-------
 fs/netfs/read_pgpriv2.c      |  68 ++++++++++-----
 fs/netfs/read_retry.c        |  59 ++++++++-----
 fs/netfs/read_single.c       |  18 ++--
 fs/netfs/stats.c             |   4 +-
 fs/netfs/write_collect.c     |  40 +++++----
 fs/netfs/write_issue.c       | 162 +++++++++++++++++++++++++----------
 fs/netfs/write_retry.c       |  45 ++++++----
 include/linux/netfs.h        |  26 +++---
 include/trace/events/netfs.h |  46 +++++-----
 19 files changed, 530 insertions(+), 381 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index eaf47851c65f..2c3edc91a5b0 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -648,7 +648,6 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 	struct netfs_cache_resources *cres = &wreq->cache_resources;
 	struct cachefiles_object *object = cachefiles_cres_object(cres);
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
 	const struct cred *saved_cred;
 	size_t off, pre, post, len = subreq->len;
 	loff_t start = subreq->start;
@@ -672,18 +671,6 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 		iov_iter_advance(&subreq->io_iter, pre);
 	}
 
-	/* We also need to end on the cache granularity boundary */
-	if (start + len == wreq->i_size) {
-		size_t part = len % CACHEFILES_DIO_BLOCK_SIZE;
-		size_t need = CACHEFILES_DIO_BLOCK_SIZE - part;
-
-		if (part && stream->submit_extendable_to >= need) {
-			len += need;
-			subreq->len += need;
-			subreq->io_iter.count += need;
-		}
-	}
-
 	post = len & (CACHEFILES_DIO_BLOCK_SIZE - 1);
 	if (post) {
 		len -= post;
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index e1f12ecb5abf..0621e6870cbd 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -15,7 +15,6 @@ netfs-y := \
 	read_pgpriv2.o \
 	read_retry.o \
 	read_single.o \
-	rolling_buffer.o \
 	write_collect.o \
 	write_issue.o \
 	write_retry.o
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 88a0d801525f..d5d5a7520cbe 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -54,6 +54,28 @@ static void netfs_rreq_expand(struct netfs_io_request *rreq,
 	}
 }
 
+static void netfs_clear_to_ra_end(struct netfs_io_request *rreq,
+				  struct readahead_control *ractl)
+{
+	struct folio_batch batch;
+
+	folio_batch_init(&batch);
+
+	for (;;) {
+		batch.nr = __readahead_batch(ractl, (struct page **)batch.folios,
+					     PAGEVEC_SIZE);
+		if (!batch.nr)
+			break;
+		for (int i = 0; i < batch.nr; i++) {
+			struct folio *folio = batch.folios[i];
+
+			trace_netfs_folio(folio, netfs_folio_trace_zero_ra);
+			folio_zero_segment(folio, 0, folio_size(folio));
+		}
+		folio_batch_release(&batch);
+	}
+}
+
 /*
  * Begin an operation, and fetch the stored zero point value from the cookie if
  * available.
@@ -82,14 +104,16 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
 					   struct readahead_control *ractl)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	ssize_t extracted;
 	size_t rsize = subreq->len;
 
 	if (subreq->source == NETFS_DOWNLOAD_FROM_SERVER)
-		rsize = umin(rsize, rreq->io_streams[0].sreq_max_len);
+		rsize = umin(rsize, stream->sreq_max_len);
 
 	if (ractl) {
 		/* If we don't have sufficient folios in the rolling buffer,
-		 * extract a folioq's worth from the readahead region at a time
+		 * extract a bvecq's worth from the readahead region at a time
 		 * into the buffer.  Note that this acquires a ref on each page
 		 * that we will need to release later - but we don't want to do
 		 * that until after we've started the I/O.
@@ -100,8 +124,8 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
 		while (rreq->submitted < subreq->start + rsize) {
 			ssize_t added;
 
-			added = rolling_buffer_load_from_ra(&rreq->buffer, ractl,
-							    &put_batch);
+			added = bvecq_load_from_ra(&rreq->load_cursor, ractl,
+						   &put_batch);
 			if (added < 0)
 				return added;
 			rreq->submitted += added;
@@ -109,21 +133,16 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
 		folio_batch_release(&put_batch);
 	}
 
-	subreq->len = rsize;
-	if (unlikely(rreq->io_streams[0].sreq_max_segs)) {
-		size_t limit = netfs_limit_iter(&rreq->buffer.iter, 0, rsize,
-						rreq->io_streams[0].sreq_max_segs);
-
-		if (limit < rsize) {
-			subreq->len = limit;
-			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
-		}
+	bvecq_pos_attach(&subreq->dispatch_pos, &rreq->dispatch_cursor);
+	extracted = bvecq_slice(&rreq->dispatch_cursor, subreq->len,
+				stream->sreq_max_segs, &subreq->nr_segs);
+	if (extracted < 0)
+		return extracted;
+	if (extracted < rsize) {
+		subreq->len = extracted;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
 	}
 
-	subreq->io_iter	= rreq->buffer.iter;
-
-	iov_iter_truncate(&subreq->io_iter, subreq->len);
-	rolling_buffer_advance(&rreq->buffer, subreq->len);
 	return subreq->len;
 }
 
@@ -188,8 +207,13 @@ static void netfs_queue_read(struct netfs_io_request *rreq,
 }
 
 static void netfs_issue_read(struct netfs_io_request *rreq,
-			     struct netfs_io_subrequest *subreq)
+			     struct netfs_io_subrequest *subreq,
+			     struct readahead_control *ractl)
 {
+	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
 	switch (subreq->source) {
 	case NETFS_DOWNLOAD_FROM_SERVER:
 		rreq->netfs_ops->issue_read(subreq);
@@ -198,11 +222,14 @@ static void netfs_issue_read(struct netfs_io_request *rreq,
 		netfs_read_cache_to_pagecache(rreq, subreq);
 		break;
 	default:
-		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		bvecq_zero(&rreq->dispatch_cursor, subreq->len);
+		subreq->transferred = subreq->len;
 		subreq->error = 0;
 		iov_iter_zero(subreq->len, &subreq->io_iter);
 		subreq->transferred = subreq->len;
 		netfs_read_subreq_terminated(subreq);
+		if (ractl)
+			netfs_clear_to_ra_end(rreq, ractl);
 		break;
 	}
 }
@@ -220,6 +247,11 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 	ssize_t size = rreq->len;
 	int ret = 0;
 
+	_enter("R=%08x", rreq->debug_id);
+
+	bvecq_pos_attach(&rreq->dispatch_cursor, &rreq->load_cursor);
+	bvecq_pos_attach(&rreq->collect_cursor, &rreq->dispatch_cursor);
+
 	do {
 		struct netfs_io_subrequest *subreq;
 		enum netfs_io_source source = NETFS_SOURCE_UNKNOWN;
@@ -234,6 +266,9 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 		subreq->start	= start;
 		subreq->len	= size;
 
+		rreq->io_streams[0].sreq_max_len = MAX_RW_COUNT;
+		rreq->io_streams[0].sreq_max_segs = INT_MAX;
+
 		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
 		subreq->source = source;
 		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
@@ -307,7 +342,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 		start += slice;
 
 		netfs_queue_read(rreq, subreq, size <= 0);
-		netfs_issue_read(rreq, subreq);
+		netfs_issue_read(rreq, subreq, ractl);
 		cond_resched();
 	} while (size > 0);
 
@@ -319,6 +354,9 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 
 	/* Defer error return as we may need to wait for outstanding I/O. */
 	cmpxchg(&rreq->error, 0, ret);
+
+	bvecq_pos_detach(&rreq->load_cursor);
+	bvecq_pos_detach(&rreq->dispatch_cursor);
 }
 
 /**
@@ -362,7 +400,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	netfs_rreq_expand(rreq, ractl);
 
 	rreq->submitted = rreq->start;
-	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
+	if (bvecq_buffer_init(&rreq->load_cursor, rreq->debug_id) < 0)
 		goto cleanup_free;
 	netfs_read_to_pagecache(rreq, ractl);
 
@@ -374,20 +412,19 @@ void netfs_readahead(struct readahead_control *ractl)
 EXPORT_SYMBOL(netfs_readahead);
 
 /*
- * Create a rolling buffer with a single occupying folio.
+ * Create a buffer queue with a single occupying folio.
  */
-static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct folio *folio,
-					unsigned int rollbuf_flags)
+static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct folio *folio)
 {
-	ssize_t added;
+	struct bvecq *bq;
+	size_t fsize = folio_size(folio);
 
-	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
+	if (bvecq_buffer_init(&rreq->load_cursor, rreq->debug_id) < 0)
 		return -ENOMEM;
 
-	added = rolling_buffer_append(&rreq->buffer, folio, rollbuf_flags);
-	if (added < 0)
-		return added;
-	rreq->submitted = rreq->start + added;
+	bq = rreq->load_cursor.bvecq;
+	bvec_set_folio(&bq->bv[bq->nr_segs++], folio, fsize, 0);
+	rreq->submitted = rreq->start + fsize;
 	return 0;
 }
 
@@ -400,11 +437,11 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	struct address_space *mapping = folio->mapping;
 	struct netfs_folio *finfo = netfs_folio_info(folio);
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
-	struct folio *sink = NULL;
-	struct bio_vec *bvec;
+	struct bvecq *bq = NULL;
+	struct page *sink = NULL;
 	unsigned int from = finfo->dirty_offset;
 	unsigned int to = from + finfo->dirty_len;
-	unsigned int off = 0, i = 0;
+	unsigned int off = 0;
 	size_t flen = folio_size(folio);
 	size_t nr_bvec = flen / PAGE_SIZE + 2;
 	size_t part;
@@ -429,38 +466,47 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	 * end get copied to, but the middle is discarded.
 	 */
 	ret = -ENOMEM;
-	bvec = kmalloc_objs(*bvec, nr_bvec);
-	if (!bvec)
+	bq = netfs_alloc_bvecq(nr_bvec, GFP_KERNEL);
+	if (!bq)
 		goto discard;
+	rreq->load_cursor.bvecq = bq;
 
-	sink = folio_alloc(GFP_KERNEL, 0);
-	if (!sink) {
-		kfree(bvec);
+	sink = alloc_page(GFP_KERNEL);
+	if (!sink)
 		goto discard;
-	}
 
 	trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
 
-	rreq->direct_bv = bvec;
-	rreq->direct_bv_count = nr_bvec;
+	for (struct bvecq *p = bq; p; p = p->next)
+		p->free = true;
+
 	if (from > 0) {
-		bvec_set_folio(&bvec[i++], folio, from, 0);
+		folio_get(folio);
+		bvec_set_folio(&bq->bv[bq->nr_segs++], folio, from, 0);
 		off = from;
 	}
 	while (off < to) {
-		part = min_t(size_t, to - off, PAGE_SIZE);
-		bvec_set_folio(&bvec[i++], sink, part, 0);
+		if (bvecq_is_full(bq))
+			bq = bq->next;
+		part = umin(to - off, PAGE_SIZE);
+		get_page(sink);
+		bvec_set_page(&bq->bv[bq->nr_segs++], sink, part, 0);
 		off += part;
 	}
-	if (to < flen)
-		bvec_set_folio(&bvec[i++], folio, flen - to, to);
-	iov_iter_bvec(&rreq->buffer.iter, ITER_DEST, bvec, i, rreq->len);
+	if (to < flen) {
+		if (bvecq_is_full(bq))
+			bq = bq->next;
+		folio_get(folio);
+		bvec_set_folio(&bq->bv[bq->nr_segs++], folio, flen - to, to);
+	}
+
+	dump_bvecq(bq);
+
 	rreq->submitted = rreq->start + flen;
 
 	netfs_read_to_pagecache(rreq, NULL);
 
-	if (sink)
-		folio_put(sink);
+	put_page(sink);
 
 	ret = netfs_wait_for_read(rreq);
 	if (ret >= 0) {
@@ -472,6 +518,8 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	return ret < 0 ? ret : 0;
 
 discard:
+	if (sink)
+		put_page(sink);
 	netfs_put_failed_request(rreq);
 alloc_error:
 	folio_unlock(folio);
@@ -522,7 +570,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
 	/* Set up the output buffer */
-	ret = netfs_create_singular_buffer(rreq, folio, 0);
+	ret = netfs_create_singular_buffer(rreq, folio);
 	if (ret < 0)
 		goto discard;
 
@@ -679,7 +727,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
 
 	/* Set up the output buffer */
-	ret = netfs_create_singular_buffer(rreq, folio, 0);
+	ret = netfs_create_singular_buffer(rreq, folio);
 	if (ret < 0)
 		goto error_put;
 
@@ -744,9 +792,10 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	trace_netfs_read(rreq, start, flen, netfs_read_trace_prefetch_for_write);
 
 	/* Set up the output buffer */
-	ret = netfs_create_singular_buffer(rreq, folio, NETFS_ROLLBUF_PAGECACHE_MARK);
+	ret = netfs_create_singular_buffer(rreq, folio);
 	if (ret < 0)
 		goto error_put;
+	rreq->load_cursor.bvecq->free = true;
 
 	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a498ee8d6674..c8704c4a95a9 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -16,31 +16,6 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
-static void netfs_prepare_dio_read_iterator(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	size_t rsize;
-
-	rsize = umin(subreq->len, rreq->io_streams[0].sreq_max_len);
-	subreq->len = rsize;
-
-	if (unlikely(rreq->io_streams[0].sreq_max_segs)) {
-		size_t limit = netfs_limit_iter(&rreq->buffer.iter, 0, rsize,
-						rreq->io_streams[0].sreq_max_segs);
-
-		if (limit < rsize) {
-			subreq->len = limit;
-			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
-		}
-	}
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-
-	subreq->io_iter	= rreq->buffer.iter;
-	iov_iter_truncate(&subreq->io_iter, subreq->len);
-	iov_iter_advance(&rreq->buffer.iter, subreq->len);
-}
-
 /*
  * Perform a read to a buffer from the server, slicing up the region to be read
  * according to the network rsize.
@@ -52,9 +27,10 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 	ssize_t size = rreq->len;
 	int ret = 0;
 
+	bvecq_pos_attach(&rreq->dispatch_cursor, &rreq->load_cursor);
+
 	do {
 		struct netfs_io_subrequest *subreq;
-		ssize_t slice;
 
 		subreq = netfs_alloc_subrequest(rreq);
 		if (!subreq) {
@@ -90,16 +66,24 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 			}
 		}
 
-		netfs_prepare_dio_read_iterator(subreq);
-		slice = subreq->len;
-		size -= slice;
-		start += slice;
-		rreq->submitted += slice;
+		bvecq_pos_attach(&subreq->dispatch_pos, &rreq->dispatch_cursor);
+		bvecq_pos_attach(&subreq->content, &rreq->dispatch_cursor);
+		subreq->len = bvecq_slice(&rreq->dispatch_cursor,
+					  umin(size, stream->sreq_max_len),
+					  stream->sreq_max_segs,
+					  &subreq->nr_segs);
+
+		size -= subreq->len;
+		start += subreq->len;
+		rreq->submitted += subreq->len;
 		if (size <= 0) {
 			smp_wmb(); /* Write lists before ALL_QUEUED. */
 			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 		}
 
+		iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
+				    subreq->content.slot, subreq->content.offset, subreq->len);
+
 		rreq->netfs_ops->issue_read(subreq);
 
 		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
@@ -115,6 +99,7 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		netfs_wake_collector(rreq);
 	}
 
+	bvecq_pos_detach(&rreq->dispatch_cursor);
 	return ret;
 }
 
@@ -198,25 +183,15 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	 * buffer for ourselves as the caller's iterator will be trashed when
 	 * we return.
 	 *
-	 * In such a case, extract an iterator to represent as much of the the
-	 * output buffer as we can manage.  Note that the extraction might not
-	 * be able to allocate a sufficiently large bvec array and may shorten
-	 * the request.
+	 * Extract a buffer queue to represent as much of the output buffer as
+	 * we can manage.  The fragments are extracted into a bvecq which will
+	 * have sufficient nodes allocated to hold all the data, though this
+	 * may end up truncated if ENOMEM is encountered.
 	 */
-	if (user_backed_iter(iter)) {
-		ret = netfs_extract_user_iter(iter, rreq->len, &rreq->buffer.iter, 0);
-		if (ret < 0)
-			goto error_put;
-		rreq->direct_bv = (struct bio_vec *)rreq->buffer.iter.bvec;
-		rreq->direct_bv_count = ret;
-		rreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
-		rreq->len = iov_iter_count(&rreq->buffer.iter);
-	} else {
-		rreq->buffer.iter = *iter;
-		rreq->len = orig_count;
-		rreq->direct_bv_unpin = false;
-		iov_iter_advance(iter, orig_count);
-	}
+	ret = netfs_extract_iter(iter, rreq->len, INT_MAX, iocb->ki_pos,
+				 &rreq->load_cursor.bvecq, 0);
+	if (ret < 0)
+		goto error_put;
 
 	// TODO: Set up bounce buffer if needed
 
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index dd1451bf7543..bb224d837b78 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -73,7 +73,11 @@ static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
 	spin_unlock(&wreq->lock);
 
 	wreq->transferred += subreq->transferred;
-	iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+	if (subreq->transferred < subreq->len) {
+		bvecq_pos_detach(&wreq->dispatch_cursor);
+		bvecq_pos_transfer(&wreq->dispatch_cursor, &subreq->dispatch_pos);
+		bvecq_pos_advance(&wreq->dispatch_cursor, subreq->transferred);
+	}
 
 	stream->collected_to = subreq->start + subreq->transferred;
 	wreq->collected_to = stream->collected_to;
@@ -99,6 +103,9 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 
 	_enter("%llx", wreq->len);
 
+	bvecq_pos_attach(&wreq->dispatch_cursor, &wreq->load_cursor);
+	bvecq_pos_attach(&wreq->collect_cursor, &wreq->dispatch_cursor);
+
 	if (wreq->origin == NETFS_DIO_WRITE)
 		inode_dio_begin(wreq->inode);
 
@@ -121,16 +128,19 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 			break;
 		}
 
-		iov_iter_truncate(&subreq->io_iter, wreq->len - wreq->transferred);
+		bvecq_pos_attach(&subreq->dispatch_pos, &wreq->dispatch_cursor);
+		subreq->len = bvecq_slice(&wreq->dispatch_cursor, stream->sreq_max_len,
+					  stream->sreq_max_segs, &subreq->nr_segs);
+		bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+
+		iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
+				    subreq->content.bvecq, subreq->content.slot,
+				    subreq->content.offset,
+				    subreq->len);
+
 		if (!iov_iter_count(&subreq->io_iter))
 			break;
 
-		subreq->len = netfs_limit_iter(&subreq->io_iter, 0,
-					       stream->sreq_max_len,
-					       stream->sreq_max_segs);
-		iov_iter_truncate(&subreq->io_iter, subreq->len);
-		stream->submit_extendable_to = subreq->len;
-
 		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 		stream->issue_write(subreq);
 
@@ -167,8 +177,15 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		 */
 		subreq->error = -EAGAIN;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-		if (subreq->transferred > 0)
-			iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+
+		bvecq_pos_detach(&subreq->content);
+		bvecq_pos_detach(&wreq->dispatch_cursor);
+		bvecq_pos_transfer(&wreq->dispatch_cursor, &subreq->dispatch_pos);
+
+		if (subreq->transferred > 0) {
+			wreq->transferred += subreq->transferred;
+			bvecq_pos_advance(&wreq->dispatch_cursor, subreq->transferred);
+		}
 
 		if (stream->source == NETFS_UPLOAD_TO_SERVER &&
 		    wreq->netfs_ops->retry_request)
@@ -177,7 +194,6 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
 		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
-		subreq->io_iter		= wreq->buffer.iter;
 		subreq->start		= wreq->start + wreq->transferred;
 		subreq->len		= wreq->len   - wreq->transferred;
 		subreq->transferred	= 0;
@@ -192,6 +208,8 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		netfs_stat(&netfs_n_wh_retry_write_subreq);
 	}
 
+	bvecq_pos_detach(&wreq->dispatch_cursor);
+	bvecq_pos_detach(&wreq->load_cursor);
 	netfs_unbuffered_write_done(wreq);
 	_leave(" = %d", ret);
 	return ret;
@@ -210,12 +228,12 @@ static void netfs_unbuffered_write_async(struct work_struct *work)
  * encrypted file.  This can also be used for direct I/O writes.
  */
 ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
-						  struct netfs_group *netfs_group)
+					   struct netfs_group *netfs_group)
 {
 	struct netfs_io_request *wreq;
 	unsigned long long start = iocb->ki_pos;
 	unsigned long long end = start + iov_iter_count(iter);
-	ssize_t ret, n;
+	ssize_t ret;
 	size_t len = iov_iter_count(iter);
 	bool async = !is_sync_kiocb(iocb);
 
@@ -249,25 +267,17 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		 * allocate a sufficiently large bvec array and may shorten the
 		 * request.
 		 */
-		if (user_backed_iter(iter)) {
-			n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
-			if (n < 0) {
-				ret = n;
-				goto error_put;
-			}
-			wreq->direct_bv = (struct bio_vec *)wreq->buffer.iter.bvec;
-			wreq->direct_bv_count = n;
-			wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
-		} else {
-			/* If this is a kernel-generated async DIO request,
-			 * assume that any resources the iterator points to
-			 * (eg. a bio_vec array) will persist till the end of
-			 * the op.
-			 */
-			wreq->buffer.iter = *iter;
-		}
+		ssize_t n = netfs_extract_iter(iter, len, INT_MAX, iocb->ki_pos,
+					       &wreq->load_cursor.bvecq, 0);
 
-		wreq->len = iov_iter_count(&wreq->buffer.iter);
+		if (n < 0) {
+			ret = n;
+			goto error_put;
+		}
+		wreq->len = n;
+		_debug("dio-write %zx/%zx %u/%u",
+		       n, len, wreq->load_cursor.bvecq->nr_segs,
+		       wreq->load_cursor.bvecq->max_segs);
 	}
 
 	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 89ebeb49e969..19d1e31b840b 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -7,7 +7,6 @@
 
 #include <linux/slab.h>
 #include <linux/seq_file.h>
-#include <linux/folio_queue.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
 #include <linux/fscache-cache.h>
@@ -151,9 +150,8 @@ static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
 /*
  * misc.c
  */
-struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq,
-					    enum netfs_folioq_trace trace);
-void netfs_reset_iter(struct netfs_io_subrequest *subreq);
+struct bvecq *netfs_buffer_make_space(struct netfs_io_request *rreq,
+				      enum netfs_bvecq_trace trace);
 void netfs_wake_collector(struct netfs_io_request *rreq);
 void netfs_subreq_clear_in_progress(struct netfs_io_subrequest *subreq);
 void netfs_wait_for_in_progress_stream(struct netfs_io_request *rreq,
@@ -251,7 +249,6 @@ extern atomic_t netfs_n_wh_retry_write_req;
 extern atomic_t netfs_n_wh_retry_write_subreq;
 extern atomic_t netfs_n_wb_lock_skip;
 extern atomic_t netfs_n_wb_lock_wait;
-extern atomic_t netfs_n_folioq;
 extern atomic_t netfs_n_bvecq;
 
 int netfs_stats_show(struct seq_file *m, void *v);
@@ -289,8 +286,7 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 			 struct netfs_io_stream *stream,
 			 loff_t start);
 void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq,
-			 struct iov_iter *source);
+			 struct netfs_io_subrequest *subreq);
 void netfs_issue_write(struct netfs_io_request *wreq,
 		       struct netfs_io_stream *stream);
 size_t netfs_advance_write(struct netfs_io_request *wreq,
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index faf4f0a3b33d..2b0a511d6db7 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -135,6 +135,7 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_se
 }
 EXPORT_SYMBOL_GPL(netfs_extract_iter);
 
+#if 0
 /**
  * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
  * @orig: The original iterator
@@ -370,3 +371,4 @@ size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 	BUG();
 }
 EXPORT_SYMBOL(netfs_limit_iter);
+#endif
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 6df89c92b10b..ab142cbaad35 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,7 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+#if 0
 /**
  * netfs_alloc_folioq_buffer - Allocate buffer space into a folio queue
  * @mapping: Address space to set on the folio (or NULL).
@@ -103,24 +104,7 @@ void netfs_free_folioq_buffer(struct folio_queue *fq)
 	folio_batch_release(&fbatch);
 }
 EXPORT_SYMBOL(netfs_free_folioq_buffer);
-
-/*
- * Reset the subrequest iterator to refer just to the region remaining to be
- * read.  The iterator may or may not have been advanced by socket ops or
- * extraction ops to an extent that may or may not match the amount actually
- * read.
- */
-void netfs_reset_iter(struct netfs_io_subrequest *subreq)
-{
-	struct iov_iter *io_iter = &subreq->io_iter;
-	size_t remain = subreq->len - subreq->transferred;
-
-	if (io_iter->count > remain)
-		iov_iter_advance(io_iter, io_iter->count - remain);
-	else if (io_iter->count < remain)
-		iov_iter_revert(io_iter, remain - io_iter->count);
-	iov_iter_truncate(&subreq->io_iter, remain);
-}
+#endif
 
 /**
  * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index b8c4918d3dcd..c92cdbad04de 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -119,7 +119,6 @@ static void netfs_free_request_rcu(struct rcu_head *rcu)
 static void netfs_deinit_request(struct netfs_io_request *rreq)
 {
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
-	unsigned int i;
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
 
@@ -134,16 +133,9 @@ static void netfs_deinit_request(struct netfs_io_request *rreq)
 		rreq->netfs_ops->free_request(rreq);
 	if (rreq->cache_resources.ops)
 		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
-	if (rreq->direct_bv) {
-		for (i = 0; i < rreq->direct_bv_count; i++) {
-			if (rreq->direct_bv[i].bv_page) {
-				if (rreq->direct_bv_unpin)
-					unpin_user_page(rreq->direct_bv[i].bv_page);
-			}
-		}
-		kvfree(rreq->direct_bv);
-	}
-	rolling_buffer_clear(&rreq->buffer);
+	bvecq_pos_detach(&rreq->load_cursor);
+	bvecq_pos_detach(&rreq->dispatch_cursor);
+	bvecq_pos_detach(&rreq->collect_cursor);
 
 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
@@ -236,6 +228,8 @@ static void netfs_free_subrequest(struct netfs_io_subrequest *subreq)
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	if (rreq->netfs_ops->free_subrequest)
 		rreq->netfs_ops->free_subrequest(subreq);
+	bvecq_pos_detach(&subreq->dispatch_pos);
+	bvecq_pos_detach(&subreq->content);
 	mempool_free(subreq, rreq->netfs_ops->subrequest_pool ?: &netfs_subrequest_pool);
 	netfs_stat_d(&netfs_n_rh_sreq);
 	netfs_put_request(rreq, netfs_rreq_trace_put_subreq);
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 137f0e28a44c..3b5978832369 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -27,9 +27,13 @@
  */
 static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
 {
-	netfs_reset_iter(subreq);
-	WARN_ON_ONCE(subreq->len - subreq->transferred != iov_iter_count(&subreq->io_iter));
-	iov_iter_zero(iov_iter_count(&subreq->io_iter), &subreq->io_iter);
+	struct iov_iter iter;
+
+	iov_iter_bvec_queue(&iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+	iov_iter_advance(&iter, subreq->transferred);
+	iov_iter_zero(subreq->len, &iter);
+
 	if (subreq->start + subreq->transferred >= subreq->rreq->i_size)
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 }
@@ -40,11 +44,11 @@ static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
  * dirty and let writeback handle it.
  */
 static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
-				    struct folio_queue *folioq,
+				    struct bvecq *bvecq,
 				    int slot)
 {
 	struct netfs_folio *finfo;
-	struct folio *folio = folioq_folio(folioq, slot);
+	struct folio *folio = page_folio(bvecq->bv[slot].bv_page);
 
 	if (unlikely(folio_pos(folio) < rreq->abandon_to)) {
 		trace_netfs_folio(folio, netfs_folio_trace_abandon);
@@ -75,7 +79,7 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 			trace_netfs_folio(folio, netfs_folio_trace_read_done);
 		}
 
-		folioq_clear(folioq, slot);
+		bvecq->bv[slot].bv_page = NULL;
 	} else {
 		// TODO: Use of PG_private_2 is deprecated.
 		if (test_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags))
@@ -91,7 +95,7 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 		folio_unlock(folio);
 	}
 
-	folioq_clear(folioq, slot);
+	bvecq->bv[slot].bv_page = NULL;
 }
 
 /*
@@ -100,18 +104,24 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 static void netfs_read_unlock_folios(struct netfs_io_request *rreq,
 				     unsigned int *notes)
 {
-	struct folio_queue *folioq = rreq->buffer.tail;
+	struct bvecq *bvecq = rreq->collect_cursor.bvecq;
 	unsigned long long collected_to = rreq->collected_to;
-	unsigned int slot = rreq->buffer.first_tail_slot;
+	unsigned int slot = rreq->collect_cursor.slot;
 
 	if (rreq->cleaned_to >= rreq->collected_to)
 		return;
 
 	// TODO: Begin decryption
 
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = rolling_buffer_delete_spent(&rreq->buffer);
-		if (!folioq) {
+	if (slot >= bvecq->nr_segs) {
+		/* We need to be very careful - the cleanup can catch the
+		 * dispatcher, which could lead to us having nothing left in
+		 * the queue, causing the front and back pointers to end up on
+		 * different tracks.  To avoid this, we must always keep at
+		 * least one segment in the queue.
+		 */
+		bvecq = bvecq_buffer_delete_spent(&rreq->collect_cursor);
+		if (!bvecq) {
 			rreq->front_folio_order = 0;
 			return;
 		}
@@ -127,13 +137,13 @@ static void netfs_read_unlock_folios(struct netfs_io_request *rreq,
 		if (*notes & COPY_TO_CACHE)
 			set_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
 
-		folio = folioq_folio(folioq, slot);
+		folio = page_folio(bvecq->bv[slot].bv_page);
 		if (WARN_ONCE(!folio_test_locked(folio),
 			      "R=%08x: folio %lx is not locked\n",
 			      rreq->debug_id, folio->index))
 			trace_netfs_folio(folio, netfs_folio_trace_not_locked);
 
-		order = folioq_folio_order(folioq, slot);
+		order = folio_order(folio);
 		rreq->front_folio_order = order;
 		fsize = PAGE_SIZE << order;
 		fpos = folio_pos(folio);
@@ -145,33 +155,32 @@ static void netfs_read_unlock_folios(struct netfs_io_request *rreq,
 		if (collected_to < fend)
 			break;
 
-		netfs_unlock_read_folio(rreq, folioq, slot);
+		netfs_unlock_read_folio(rreq, bvecq, slot);
 		WRITE_ONCE(rreq->cleaned_to, fpos + fsize);
 		*notes |= MADE_PROGRESS;
 
 		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
 
-		/* Clean up the head folioq.  If we clear an entire folioq, then
-		 * we can get rid of it provided it's not also the tail folioq
-		 * being filled by the issuer.
+		/* Clean up the head bvecq segment.  If we clear an entire
+		 * segment, then we can get rid of it provided it's not also
+		 * the tail segment being filled by the issuer.
 		 */
-		folioq_clear(folioq, slot);
 		slot++;
-		if (slot >= folioq_nr_slots(folioq)) {
-			folioq = rolling_buffer_delete_spent(&rreq->buffer);
-			if (!folioq)
+		if (slot >= bvecq->nr_segs) {
+			bvecq = bvecq_buffer_delete_spent(&rreq->collect_cursor);
+			if (!bvecq)
 				goto done;
 			slot = 0;
-			trace_netfs_folioq(folioq, netfs_trace_folioq_read_progress);
+			//trace_netfs_bvecq(bvecq, netfs_trace_folioq_read_progress);
 		}
 
 		if (fpos + fsize >= collected_to)
 			break;
 	}
 
-	rreq->buffer.tail = folioq;
+	bvecq_pos_move(&rreq->collect_cursor, bvecq);
 done:
-	rreq->buffer.first_tail_slot = slot;
+	rreq->collect_cursor.slot = slot;
 }
 
 /*
@@ -346,12 +355,14 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 
 	if (rreq->origin == NETFS_UNBUFFERED_READ ||
 	    rreq->origin == NETFS_DIO_READ) {
-		for (i = 0; i < rreq->direct_bv_count; i++) {
-			flush_dcache_page(rreq->direct_bv[i].bv_page);
-			// TODO: cifs marks pages in the destination buffer
-			// dirty under some circumstances after a read.  Do we
-			// need to do that too?
-			set_page_dirty(rreq->direct_bv[i].bv_page);
+		for (struct bvecq *bq = rreq->collect_cursor.bvecq; bq; bq = bq->next) {
+			for (i = 0; i < bq->nr_segs; i++) {
+				flush_dcache_page(bq->bv[i].bv_page);
+				// TODO: cifs marks pages in the destination buffer
+				// dirty under some circumstances after a read.  Do we
+				// need to do that too?
+				set_page_dirty(bq->bv[i].bv_page);
+			}
 		}
 	}
 
@@ -442,7 +453,15 @@ bool netfs_read_collection(struct netfs_io_request *rreq)
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_clear_subrequests(rreq);
-	netfs_unlock_abandoned_read_pages(rreq);
+	switch (rreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_FOR_WRITE:
+		netfs_unlock_abandoned_read_pages(rreq);
+		break;
+	default:
+		break;
+	}
 	if (unlikely(rreq->copy_to_cache))
 		netfs_pgpriv2_end_copy_to_cache(rreq);
 	return true;
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index a1489aa29f78..faf6a4fcdf26 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -19,6 +19,9 @@
 static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio *folio)
 {
 	struct netfs_io_stream *cache = &creq->io_streams[1];
+	struct bvecq *queue;
+	unsigned int slot;
+	size_t dio_size = PAGE_SIZE;
 	size_t fsize = folio_size(folio), flen = fsize;
 	loff_t fpos = folio_pos(folio), i_size;
 	bool to_eof = false;
@@ -48,17 +51,40 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 		to_eof = true;
 	}
 
+	flen = round_up(flen, dio_size);
+
 	_debug("folio %zx %zx", flen, fsize);
 
 	trace_netfs_folio(folio, netfs_folio_trace_store_copy);
 
-	/* Attach the folio to the rolling buffer. */
-	if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
-		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
-		return;
+
+	/* Institute a new bvec queue segment if the current one is full or if
+	 * we encounter a discontiguity.  The discontiguity break is important
+	 * when it comes to bulk unlocking folios by file range.
+	 */
+	queue = creq->load_cursor.bvecq;
+	if (bvecq_is_full(queue) ||
+	    (fpos != creq->last_end && creq->last_end > 0)) {
+		if (bvecq_buffer_make_space(&creq->load_cursor) < 0) {
+			clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
+			return;
+		}
+
+		queue = creq->load_cursor.bvecq;
+		queue->fpos = fpos;
+		if (fpos != creq->last_end)
+			queue->discontig = true;
 	}
 
-	cache->submit_extendable_to = fsize;
+	/* Attach the folio to the rolling buffer. */
+	slot = queue->nr_segs;
+	bvec_set_folio(&queue->bv[slot], folio, fsize, 0);
+	/* Order incrementing the slot counter after the slot is filled. */
+	smp_store_release(&queue->nr_segs, slot + 1);
+	creq->load_cursor.slot = slot + 1;
+	creq->load_cursor.offset = 0;
+	trace_netfs_bv_slot(queue, slot);
+
 	cache->submit_off = 0;
 	cache->submit_len = flen;
 
@@ -70,10 +96,9 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 	do {
 		ssize_t part;
 
-		creq->buffer.iter.iov_offset = cache->submit_off;
+		creq->dispatch_cursor.offset = cache->submit_off;
 
 		atomic64_set(&creq->issued_to, fpos + cache->submit_off);
-		cache->submit_extendable_to = fsize - cache->submit_off;
 		part = netfs_advance_write(creq, cache, fpos + cache->submit_off,
 					   cache->submit_len, to_eof);
 		cache->submit_off += part;
@@ -83,8 +108,7 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 			cache->submit_len -= part;
 	} while (cache->submit_len > 0);
 
-	creq->buffer.iter.iov_offset = 0;
-	rolling_buffer_advance(&creq->buffer, fsize);
+	bvecq_buffer_step(&creq->dispatch_cursor);
 	atomic64_set(&creq->issued_to, fpos + fsize);
 
 	if (flen < fsize)
@@ -110,6 +134,10 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	if (!creq->io_streams[1].avail)
 		goto cancel_put;
 
+	bvecq_buffer_init(&creq->load_cursor, creq->debug_id);
+	bvecq_pos_attach(&creq->dispatch_cursor, &creq->load_cursor);
+	bvecq_pos_attach(&creq->collect_cursor, &creq->dispatch_cursor);
+
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
 	trace_netfs_copy2cache(rreq, creq);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
@@ -170,22 +198,23 @@ void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq)
  */
 bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *creq)
 {
-	struct folio_queue *folioq = creq->buffer.tail;
+	struct bvecq *bq = creq->collect_cursor.bvecq;
 	unsigned long long collected_to = creq->collected_to;
-	unsigned int slot = creq->buffer.first_tail_slot;
+	unsigned int slot;
 	bool made_progress = false;
 
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = rolling_buffer_delete_spent(&creq->buffer);
+	if (bvecq_is_full(bq)) {
+		bq = bvecq_buffer_delete_spent(&creq->collect_cursor);
 		slot = 0;
 	}
+	slot = creq->collect_cursor.slot;
 
 	for (;;) {
 		struct folio *folio;
 		unsigned long long fpos, fend;
 		size_t fsize, flen;
 
-		folio = folioq_folio(folioq, slot);
+		folio = page_folio(bq->bv[slot].bv_page);
 		if (WARN_ONCE(!folio_test_private_2(folio),
 			      "R=%08x: folio %lx is not marked private_2\n",
 			      creq->debug_id, folio->index))
@@ -212,11 +241,11 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *creq)
 		 * we can get rid of it provided it's not also the tail folioq
 		 * being filled by the issuer.
 		 */
-		folioq_clear(folioq, slot);
+		bq->bv[slot].bv_page = NULL;
 		slot++;
-		if (slot >= folioq_nr_slots(folioq)) {
-			folioq = rolling_buffer_delete_spent(&creq->buffer);
-			if (!folioq)
+		if (slot >= bq->nr_segs) {
+			bq = bvecq_buffer_delete_spent(&creq->collect_cursor);
+			if (!bq)
 				goto done;
 			slot = 0;
 		}
@@ -225,8 +254,7 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *creq)
 			break;
 	}
 
-	creq->buffer.tail = folioq;
 done:
-	creq->buffer.first_tail_slot = slot;
+	creq->collect_cursor.slot = slot;
 	return made_progress;
 }
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 7793ba5e3e8f..68a5fece9012 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -12,6 +12,11 @@
 static void netfs_reissue_read(struct netfs_io_request *rreq,
 			       struct netfs_io_subrequest *subreq)
 {
+	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+	iov_iter_advance(&subreq->io_iter, subreq->transferred);
+
 	subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
@@ -27,6 +32,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	struct bvecq_pos dispatch_cursor = {};
 	struct list_head *next;
 
 	_enter("R=%x", rreq->debug_id);
@@ -48,7 +54,6 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
 				__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 				subreq->retry_count++;
-				netfs_reset_iter(subreq);
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 				netfs_reissue_read(rreq, subreq);
 			}
@@ -74,11 +79,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 
 	do {
 		struct netfs_io_subrequest *from, *to, *tmp;
-		struct iov_iter source;
 		unsigned long long start, len;
 		size_t part;
 		bool boundary = false, subreq_superfluous = false;
 
+		bvecq_pos_detach(&dispatch_cursor);
+
 		/* Go through the subreqs and find the next span of contiguous
 		 * buffer that we then rejig (cifs, for example, needs the
 		 * rsize renegotiating) and reissue.
@@ -111,9 +117,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		/* Determine the set of buffers we're going to use.  Each
 		 * subreq gets a subset of a single overall contiguous buffer.
 		 */
-		netfs_reset_iter(from);
-		source = from->io_iter;
-		source.count = len;
+		bvecq_pos_transfer(&dispatch_cursor, &from->dispatch_pos);
+		bvecq_pos_advance(&dispatch_cursor, from->transferred);
 
 		/* Work through the sublist. */
 		subreq = from;
@@ -129,10 +134,14 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 			subreq->retry_count++;
 
+			bvecq_pos_detach(&subreq->dispatch_pos);
+			bvecq_pos_detach(&subreq->content);
+
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 			/* Renegotiate max_len (rsize) */
 			stream->sreq_max_len = subreq->len;
+			stream->sreq_max_segs = INT_MAX;
 			if (rreq->netfs_ops->prepare_read &&
 			    rreq->netfs_ops->prepare_read(subreq) < 0) {
 				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
@@ -140,13 +149,13 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				goto abandon;
 			}
 
-			part = umin(len, stream->sreq_max_len);
-			if (unlikely(stream->sreq_max_segs))
-				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
+			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
+			part = bvecq_slice(&dispatch_cursor,
+					   umin(len, stream->sreq_max_len),
+					   stream->sreq_max_segs,
+					   &subreq->nr_segs);
 			subreq->len = subreq->transferred + part;
-			subreq->io_iter = source;
-			iov_iter_truncate(&subreq->io_iter, part);
-			iov_iter_advance(&source, part);
+
 			len -= part;
 			start += part;
 			if (!len) {
@@ -205,9 +214,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 			stream->sreq_max_len	= umin(len, rreq->rsize);
-			stream->sreq_max_segs	= 0;
-			if (unlikely(stream->sreq_max_segs))
-				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
+			stream->sreq_max_segs	= INT_MAX;
 
 			netfs_stat(&netfs_n_rh_download);
 			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
@@ -216,11 +223,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				goto abandon;
 			}
 
-			part = umin(len, stream->sreq_max_len);
+			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
+			part = bvecq_slice(&dispatch_cursor,
+					   umin(len, stream->sreq_max_len),
+					   stream->sreq_max_segs,
+					   &subreq->nr_segs);
 			subreq->len = subreq->transferred + part;
-			subreq->io_iter = source;
-			iov_iter_truncate(&subreq->io_iter, part);
-			iov_iter_advance(&source, part);
 
 			len -= part;
 			start += part;
@@ -234,6 +242,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 
 	} while (!list_is_head(next, &stream->subrequests));
 
+out:
+	bvecq_pos_detach(&dispatch_cursor);
 	return;
 
 	/* If we hit an error, fail all remaining incomplete subrequests */
@@ -250,6 +260,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 	}
+	goto out;
 }
 
 /*
@@ -278,13 +289,15 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
  */
 void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
 {
-	struct folio_queue *p;
+	struct bvecq *p;
 
-	for (p = rreq->buffer.tail; p; p = p->next) {
-		for (int slot = 0; slot < folioq_count(p); slot++) {
-			struct folio *folio = folioq_folio(p, slot);
+	for (p = rreq->collect_cursor.bvecq; p; p = p->next) {
+		if (!p->free)
+			continue;
+		for (int slot = 0; slot < p->nr_segs; slot++) {
+			if (p->bv[slot].bv_page) {
+				struct folio *folio = page_folio(p->bv[slot].bv_page);
 
-			if (folio && !folioq_is_marked2(p, slot)) {
 				trace_netfs_folio(folio, netfs_folio_trace_abandon);
 				folio_unlock(folio);
 			}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 8e6264f62a8f..0f49d6aab874 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -97,10 +97,15 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	if (!subreq)
 		return -ENOMEM;
 
-	subreq->source	= NETFS_SOURCE_UNKNOWN;
-	subreq->start	= 0;
-	subreq->len	= rreq->len;
-	subreq->io_iter	= rreq->buffer.iter;
+	subreq->source		= NETFS_SOURCE_UNKNOWN;
+	subreq->start		= 0;
+	subreq->len		= rreq->len;
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &rreq->dispatch_cursor);
+	bvecq_pos_attach(&subreq->content, &rreq->dispatch_cursor);
+
+	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
 
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
@@ -174,6 +179,10 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 
+	ret = netfs_extract_iter(iter, rreq->len, INT_MAX, 0, &rreq->dispatch_cursor.bvecq, 0);
+	if (ret < 0)
+		goto cleanup_free;
+
 	ret = netfs_single_begin_cache_read(rreq, ictx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 		goto cleanup_free;
@@ -181,7 +190,6 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	netfs_stat(&netfs_n_rh_read_single);
 	trace_netfs_read(rreq, 0, rreq->len, netfs_read_trace_read_single);
 
-	rreq->buffer.iter = *iter;
 	netfs_single_dispatch_read(rreq);
 
 	ret = netfs_wait_for_read(rreq);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 84c2a4bcc762..1dfb5667b931 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -47,7 +47,6 @@ atomic_t netfs_n_wh_retry_write_req;
 atomic_t netfs_n_wh_retry_write_subreq;
 atomic_t netfs_n_wb_lock_skip;
 atomic_t netfs_n_wb_lock_wait;
-atomic_t netfs_n_folioq;
 atomic_t netfs_n_bvecq;
 
 int netfs_stats_show(struct seq_file *m, void *v)
@@ -91,11 +90,10 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_rh_retry_read_subreq),
 		   atomic_read(&netfs_n_wh_retry_write_req),
 		   atomic_read(&netfs_n_wh_retry_write_subreq));
-	seq_printf(m, "Objs   : rr=%u sr=%u bq=%u foq=%u wsc=%u\n",
+	seq_printf(m, "Objs   : rr=%u sr=%u bq=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
 		   atomic_read(&netfs_n_bvecq),
-		   atomic_read(&netfs_n_folioq),
 		   atomic_read(&netfs_n_wh_wstream_conflict));
 	seq_printf(m, "WbLock : skip=%u wait=%u\n",
 		   atomic_read(&netfs_n_wb_lock_skip),
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 83eb3dc1adf8..ed11086346b0 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -111,12 +111,12 @@ int netfs_folio_written_back(struct folio *folio)
 static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 					  unsigned int *notes)
 {
-	struct folio_queue *folioq = wreq->buffer.tail;
+	struct bvecq *bvecq = wreq->collect_cursor.bvecq;
 	unsigned long long collected_to = wreq->collected_to;
-	unsigned int slot = wreq->buffer.first_tail_slot;
+	unsigned int slot = wreq->collect_cursor.slot;
 
-	if (WARN_ON_ONCE(!folioq)) {
-		pr_err("[!] Writeback unlock found empty rolling buffer!\n");
+	if (WARN_ON_ONCE(!bvecq)) {
+		pr_err("[!] Writeback unlock found empty buffer!\n");
 		netfs_dump_request(wreq);
 		return;
 	}
@@ -127,9 +127,15 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		return;
 	}
 
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = rolling_buffer_delete_spent(&wreq->buffer);
-		if (!folioq)
+	if (slot >= bvecq->nr_segs) {
+		/* We need to be very careful - the cleanup can catch the
+		 * dispatcher, which could lead to us having nothing left in
+		 * the queue, causing the front and back pointers to end up on
+		 * different tracks.  To avoid this, we must always keep at
+		 * least one segment in the queue.
+		 */
+		bvecq = bvecq_buffer_delete_spent(&wreq->collect_cursor);
+		if (!bvecq)
 			return;
 		slot = 0;
 	}
@@ -140,7 +146,7 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		unsigned long long fpos, fend;
 		size_t fsize, flen;
 
-		folio = folioq_folio(folioq, slot);
+		folio = page_folio(bvecq->bv[slot].bv_page);
 		if (WARN_ONCE(!folio_test_writeback(folio),
 			      "R=%08x: folio %lx is not under writeback\n",
 			      wreq->debug_id, folio->index))
@@ -163,15 +169,15 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		wreq->cleaned_to = fpos + fsize;
 		*notes |= MADE_PROGRESS;
 
-		/* Clean up the head folioq.  If we clear an entire folioq, then
-		 * we can get rid of it provided it's not also the tail folioq
+		/* Clean up the head bvecq.  If we clear an entire bvecq, then
+		 * we can get rid of it provided it's not also the tail bvecq
 		 * being filled by the issuer.
 		 */
-		folioq_clear(folioq, slot);
+		bvecq->bv[slot].bv_page = NULL;
 		slot++;
-		if (slot >= folioq_nr_slots(folioq)) {
-			folioq = rolling_buffer_delete_spent(&wreq->buffer);
-			if (!folioq)
+		if (slot >= bvecq->nr_segs) {
+			bvecq = bvecq_buffer_delete_spent(&wreq->collect_cursor);
+			if (!bvecq)
 				goto done;
 			slot = 0;
 		}
@@ -180,9 +186,8 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 			break;
 	}
 
-	wreq->buffer.tail = folioq;
 done:
-	wreq->buffer.first_tail_slot = slot;
+	wreq->collect_cursor.slot = slot;
 }
 
 /*
@@ -207,7 +212,8 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_collect);
 
 reassess_streams:
-	issued_to = atomic64_read(&wreq->issued_to);
+	/* Order reading the issued_to point before reading the queue it refers to. */
+	issued_to = atomic64_read_acquire(&wreq->issued_to);
 	smp_rmb();
 	collected_to = ULLONG_MAX;
 	if (wreq->origin == NETFS_WRITEBACK ||
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index fd4dc89d9d8d..5d4d8dbfe877 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -108,8 +108,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	ictx = netfs_inode(wreq->inode);
 	if (is_cacheable && netfs_is_cache_enabled(ictx))
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ictx));
-	if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE) < 0)
-		goto nomem;
 
 	wreq->cleaned_to = wreq->start;
 
@@ -132,9 +130,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	}
 
 	return wreq;
-nomem:
-	netfs_put_failed_request(wreq);
-	return ERR_PTR(-ENOMEM);
 }
 
 /**
@@ -159,21 +154,13 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 			 loff_t start)
 {
 	struct netfs_io_subrequest *subreq;
-	struct iov_iter *wreq_iter = &wreq->buffer.iter;
-
-	/* Make sure we don't point the iterator at a used-up folio_queue
-	 * struct being used as a placeholder to prevent the queue from
-	 * collapsing.  In such a case, extend the queue.
-	 */
-	if (iov_iter_is_folioq(wreq_iter) &&
-	    wreq_iter->folioq_slot >= folioq_nr_slots(wreq_iter->folioq))
-		rolling_buffer_make_space(&wreq->buffer);
 
 	subreq = netfs_alloc_subrequest(wreq);
 	subreq->source		= stream->source;
 	subreq->start		= start;
 	subreq->stream_nr	= stream->stream_nr;
-	subreq->io_iter		= *wreq_iter;
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &wreq->dispatch_cursor);
 
 	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
 
@@ -239,15 +226,15 @@ static void netfs_do_issue_write(struct netfs_io_stream *stream,
 }
 
 void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq,
-			 struct iov_iter *source)
+			 struct netfs_io_subrequest *subreq)
 {
-	size_t size = subreq->len - subreq->transferred;
-
 	// TODO: Use encrypted buffer
-	subreq->io_iter = *source;
-	iov_iter_advance(source, size);
-	iov_iter_truncate(&subreq->io_iter, size);
+	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+	iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
+			    subreq->content.bvecq, subreq->content.slot,
+			    subreq->content.offset,
+			    subreq->len);
+	iov_iter_advance(&subreq->io_iter, subreq->transferred);
 
 	subreq->retry_count++;
 	subreq->error = 0;
@@ -264,8 +251,58 @@ void netfs_issue_write(struct netfs_io_request *wreq,
 
 	if (!subreq)
 		return;
+
+	/* If we have a write to the cache, we need to round out the first and
+	 * last entries (only those as the data will be on virtually contiguous
+	 * folios) to cache DIO boundaries.
+	 */
+	if (subreq->source == NETFS_WRITE_TO_CACHE) {
+		struct bvecq_pos tmp_pos;
+		struct bio_vec *bv;
+		struct bvecq *bq;
+		size_t dio_size = PAGE_SIZE;
+		size_t disp, len;
+		int ret;
+
+		bvecq_pos_attach(&tmp_pos, &subreq->dispatch_pos);
+		ret = bvecq_extract(&tmp_pos, subreq->len, INT_MAX, &subreq->content.bvecq);
+		bvecq_pos_detach(&tmp_pos);
+		if (ret < 0) {
+			netfs_write_subrequest_terminated(subreq, -ENOMEM);
+			return;
+		}
+
+		/* Round the first entry down. */
+		bq = subreq->content.bvecq;
+		bv = &bq->bv[0];
+		disp = bv->bv_offset & (dio_size - 1);
+		if (disp) {
+			bv->bv_offset -= disp;
+			bv->bv_len += disp;
+			bq->fpos -= disp;
+			subreq->start -= disp;
+			subreq->len += disp;
+		}
+
+		/* Round the end of the last entry up. */
+		while (bq->next)
+			bq = bq->next;
+		bv = &bq->bv[bq->nr_segs - 1];
+		len = round_up(bv->bv_len, dio_size - 1);
+		if (len > bv->bv_len) {
+			subreq->len += len - bv->bv_len;
+			bv->bv_len = len;
+		}
+	} else {
+		bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+	}
+
+	iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
+			    subreq->content.bvecq, subreq->content.slot,
+			    subreq->content.offset,
+			    subreq->len);
+
 	stream->construct = NULL;
-	subreq->io_iter.count = subreq->len;
 	netfs_do_issue_write(stream, subreq);
 }
 
@@ -302,7 +339,6 @@ size_t netfs_advance_write(struct netfs_io_request *wreq,
 	_debug("part %zx/%zx %zx/%zx", subreq->len, stream->sreq_max_len, part, len);
 	subreq->len += part;
 	subreq->nr_segs++;
-	stream->submit_extendable_to -= part;
 
 	if (subreq->len >= stream->sreq_max_len ||
 	    subreq->nr_segs >= stream->sreq_max_segs ||
@@ -326,16 +362,35 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	struct netfs_io_stream *stream;
 	struct netfs_group *fgroup; /* TODO: Use this with ceph */
 	struct netfs_folio *finfo;
-	size_t iter_off = 0;
+	struct bvecq *queue = wreq->load_cursor.bvecq;
+	unsigned int slot;
 	size_t fsize = folio_size(folio), flen = fsize, foff = 0;
 	loff_t fpos = folio_pos(folio), i_size;
 	bool to_eof = false, streamw = false;
 	bool debug = false;
+	int ret;
 
 	_enter("");
 
-	if (rolling_buffer_make_space(&wreq->buffer) < 0)
-		return -ENOMEM;
+	/* Institute a new bvec queue segment if the current one is full or if
+	 * we encounter a discontiguity.  The discontiguity break is important
+	 * when it comes to bulk unlocking folios by file range.
+	 */
+	if (bvecq_is_full(queue) ||
+	    (fpos != wreq->last_end && wreq->last_end > 0)) {
+		ret = bvecq_buffer_make_space(&wreq->load_cursor);
+		if (ret < 0) {
+			folio_unlock(folio);
+			return ret;
+		}
+
+		queue = wreq->load_cursor.bvecq;
+		queue->fpos = fpos;
+		if (fpos != wreq->last_end)
+			queue->discontig = true;
+		bvecq_pos_move(&wreq->dispatch_cursor, queue);
+		wreq->dispatch_cursor.slot = 0;
+	}
 
 	/* netfs_perform_write() may shift i_size around the page or from out
 	 * of the page to beyond it, but cannot move i_size into or through the
@@ -441,7 +496,12 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	}
 
 	/* Attach the folio to the rolling buffer. */
-	rolling_buffer_append(&wreq->buffer, folio, 0);
+	slot = queue->nr_segs;
+	bvec_set_folio(&queue->bv[slot], folio, flen, foff);
+	queue->nr_segs = slot + 1;
+	wreq->load_cursor.slot = slot + 1;
+	wreq->load_cursor.offset = 0;
+	trace_netfs_bv_slot(queue, slot);
 
 	/* Move the submission point forward to allow for write-streaming data
 	 * not starting at the front of the page.  We don't do write-streaming
@@ -487,14 +547,10 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 			break;
 		stream = &wreq->io_streams[choose_s];
 
-		/* Advance the iterator(s). */
-		if (stream->submit_off > iter_off) {
-			rolling_buffer_advance(&wreq->buffer, stream->submit_off - iter_off);
-			iter_off = stream->submit_off;
-		}
+		/* Advance the cursor. */
+		wreq->dispatch_cursor.offset = stream->submit_off;
 
 		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
-		stream->submit_extendable_to = fsize - stream->submit_off;
 		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
 					   stream->submit_len, to_eof);
 		stream->submit_off += part;
@@ -506,9 +562,9 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 			debug = true;
 	}
 
-	if (fsize > iter_off)
-		rolling_buffer_advance(&wreq->buffer, fsize - iter_off);
-	atomic64_set(&wreq->issued_to, fpos + fsize);
+	bvecq_buffer_step(&wreq->dispatch_cursor);
+	/* Order loading the queue before updating the issue_to point */
+	atomic64_set_release(&wreq->issued_to, fpos + fsize);
 
 	if (!debug)
 		kdebug("R=%x: No submit", wreq->debug_id);
@@ -576,6 +632,11 @@ int netfs_writepages(struct address_space *mapping,
 		goto couldnt_start;
 	}
 
+	if (bvecq_buffer_init(&wreq->load_cursor, wreq->debug_id) < 0)
+		goto nomem;
+	bvecq_pos_attach(&wreq->dispatch_cursor, &wreq->load_cursor);
+	bvecq_pos_attach(&wreq->collect_cursor, &wreq->dispatch_cursor);
+
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
@@ -600,12 +661,17 @@ int netfs_writepages(struct address_space *mapping,
 	netfs_end_issue_write(wreq);
 
 	mutex_unlock(&ictx->wb_lock);
+	bvecq_pos_detach(&wreq->load_cursor);
+	bvecq_pos_detach(&wreq->dispatch_cursor);
 	netfs_wake_collector(wreq);
 
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	_leave(" = %d", error);
 	return error;
 
+nomem:
+	error = -ENOMEM;
+	netfs_put_failed_request(wreq);
 couldnt_start:
 	netfs_kill_dirty_pages(mapping, wbc, folio);
 out:
@@ -647,8 +713,8 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			       struct folio *folio, size_t copied, bool to_page_end,
 			       struct folio **writethrough_cache)
 {
-	_enter("R=%x ic=%zu ws=%u cp=%zu tp=%u",
-	       wreq->debug_id, wreq->buffer.iter.count, wreq->wsize, copied, to_page_end);
+	_enter("R=%x ws=%u cp=%zu tp=%u",
+	       wreq->debug_id, wreq->wsize, copied, to_page_end);
 
 	if (!*writethrough_cache) {
 		if (folio_test_dirty(folio))
@@ -705,7 +771,7 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
  * @iter: Data to write.
  *
  * Write a monolithic, non-pagecache object back to the server and/or
- * the cache.
+ * the cache.  There's a maximum of one subrequest per stream.
  */
 int netfs_writeback_single(struct address_space *mapping,
 			   struct writeback_control *wbc,
@@ -729,10 +795,18 @@ int netfs_writeback_single(struct address_space *mapping,
 		ret = PTR_ERR(wreq);
 		goto couldnt_start;
 	}
-
-	wreq->buffer.iter = *iter;
 	wreq->len = iov_iter_count(iter);
 
+	ret = netfs_extract_iter(iter, wreq->len, INT_MAX, 0, &wreq->dispatch_cursor.bvecq, 0);
+	if (ret < 0)
+		goto cleanup_free;
+	if (ret < wreq->len) {
+		ret = -EIO;
+		goto cleanup_free;
+	}
+
+	bvecq_pos_attach(&wreq->collect_cursor, &wreq->dispatch_cursor);
+
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback_single);
 	netfs_stat(&netfs_n_wh_writepages);
@@ -752,11 +826,11 @@ int netfs_writeback_single(struct address_space *mapping,
 		subreq = stream->construct;
 		subreq->len = wreq->len;
 		stream->submit_len = subreq->len;
-		stream->submit_extendable_to = round_up(wreq->len, PAGE_SIZE);
 
 		netfs_issue_write(wreq, stream);
 	}
 
+	wreq->submitted = wreq->len;
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
 
@@ -772,6 +846,8 @@ int netfs_writeback_single(struct address_space *mapping,
 	_leave(" = %d", ret);
 	return ret;
 
+cleanup_free:
+	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 couldnt_start:
 	mutex_unlock(&ictx->wb_lock);
 	_leave(" = %d", ret);
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 29489a23a220..b9352bf45c4b 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -17,6 +17,7 @@
 static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				     struct netfs_io_stream *stream)
 {
+	struct bvecq_pos dispatch_cursor = {};
 	struct list_head *next;
 
 	_enter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
@@ -39,12 +40,8 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				struct iov_iter source;
-
-				netfs_reset_iter(subreq);
-				source = subreq->io_iter;
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_write(stream, subreq, &source);
+				netfs_reissue_write(stream, subreq);
 			}
 		}
 		return;
@@ -54,11 +51,12 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 	do {
 		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
-		struct iov_iter source;
 		unsigned long long start, len;
 		size_t part;
 		bool boundary = false;
 
+		bvecq_pos_detach(&dispatch_cursor);
+
 		/* Go through the stream and find the next span of contiguous
 		 * data that we then rejig (cifs, for example, needs the wsize
 		 * renegotiating) and reissue.
@@ -70,7 +68,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
-			return;
+			goto out;
 
 		list_for_each_continue(next, &stream->subrequests) {
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
@@ -85,9 +83,8 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		/* Determine the set of buffers we're going to use.  Each
 		 * subreq gets a subset of a single overall contiguous buffer.
 		 */
-		netfs_reset_iter(from);
-		source = from->io_iter;
-		source.count = len;
+		bvecq_pos_transfer(&dispatch_cursor, &from->dispatch_pos);
+		bvecq_pos_advance(&dispatch_cursor, from->transferred);
 
 		/* Work through the sublist. */
 		subreq = from;
@@ -100,14 +97,20 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
+			bvecq_pos_detach(&subreq->dispatch_pos);
+			bvecq_pos_detach(&subreq->content);
+
 			/* Renegotiate max_len (wsize) */
 			stream->sreq_max_len = len;
+			stream->sreq_max_segs = INT_MAX;
 			stream->prepare_write(subreq);
 
-			part = umin(len, stream->sreq_max_len);
-			if (unlikely(stream->sreq_max_segs))
-				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
-			subreq->len = part;
+			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
+			part = bvecq_slice(&dispatch_cursor,
+					   umin(len, stream->sreq_max_len),
+					   stream->sreq_max_segs,
+					   &subreq->nr_segs);
+			subreq->len = subreq->transferred + part;
 			subreq->transferred = 0;
 			len -= part;
 			start += part;
@@ -116,7 +119,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				boundary = true;
 
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_write(stream, subreq, &source);
+			netfs_reissue_write(stream, subreq);
 			if (subreq == to)
 				break;
 		}
@@ -173,8 +176,13 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 			stream->prepare_write(subreq);
 
-			part = umin(len, stream->sreq_max_len);
+			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
+			part = bvecq_slice(&dispatch_cursor,
+					   umin(len, stream->sreq_max_len),
+					   stream->sreq_max_segs,
+					   &subreq->nr_segs);
 			subreq->len = subreq->transferred + part;
+
 			len -= part;
 			start += part;
 			if (!len && boundary) {
@@ -182,13 +190,16 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				boundary = false;
 			}
 
-			netfs_reissue_write(stream, subreq, &source);
+			netfs_reissue_write(stream, subreq);
 			if (!len)
 				break;
 
 		} while (len);
 
 	} while (!list_is_head(next, &stream->subrequests));
+
+out:
+	bvecq_pos_detach(&dispatch_cursor);
 }
 
 /*
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b146aeaaf6c9..a48f03e85b6a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -19,12 +19,13 @@
 #include <linux/pagemap.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
-#include <linux/rolling_buffer.h>
 
 enum netfs_sreq_ref_trace;
 typedef struct mempool mempool_t;
-struct folio_queue;
-struct bvecq;
+struct readahead_control;
+struct netfs_io_request;
+struct netfs_io_subrequest;
+struct fscache_occupancy;
 
 /**
  * folio_start_private_2 - Start an fscache write on a folio.  [DEPRECATED]
@@ -147,7 +148,6 @@ struct netfs_io_stream {
 	unsigned int		sreq_max_segs;	/* 0 or max number of segments in an iterator */
 	unsigned int		submit_off;	/* Folio offset we're submitting from */
 	unsigned int		submit_len;	/* Amount of data left to submit */
-	unsigned int		submit_extendable_to; /* Amount I/O can be rounded up to */
 	void (*prepare_write)(struct netfs_io_subrequest *subreq);
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
 	/* Collection tracking */
@@ -187,6 +187,8 @@ struct netfs_io_subrequest {
 	struct netfs_io_request *rreq;		/* Supervising I/O request */
 	struct work_struct	work;
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
+	struct bvecq_pos	dispatch_pos;	/* Bookmark in the combined queue of the start */
+	struct bvecq_pos	content;	/* The (copied) content of the subrequest */
 	struct iov_iter		io_iter;	/* Iterator for this subrequest */
 	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
@@ -248,13 +250,13 @@ struct netfs_io_request {
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
 	struct netfs_group	*group;		/* Writeback group being written back */
-	struct rolling_buffer	buffer;		/* Unencrypted buffer */
-#define NETFS_ROLLBUF_PUT_MARK		ROLLBUF_MARK_1
-#define NETFS_ROLLBUF_PAGECACHE_MARK	ROLLBUF_MARK_2
+	struct bvecq_pos	collect_cursor;	/* Clear-up point of I/O buffer */
+	struct bvecq_pos	load_cursor;	/* Point at which new folios are loaded in */
+	struct bvecq_pos	dispatch_cursor; /* Point from which buffers are dispatched */
 	wait_queue_head_t	waitq;		/* Processor waiter */
 	void			*netfs_priv;	/* Private data for the netfs */
 	void			*netfs_priv2;	/* Private data for the netfs */
-	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-iter) */
+	unsigned long long	last_end;	/* End pos of last folio submitted */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
@@ -266,7 +268,6 @@ struct netfs_io_request {
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
-	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
 	unsigned int		rsize;		/* Maximum read size (0 for none) */
 	unsigned int		wsize;		/* Maximum write size (0 for none) */
@@ -275,7 +276,6 @@ struct netfs_io_request {
 	spinlock_t		lock;		/* Lock for queuing subreqs */
 	unsigned char		front_folio_order; /* Order (size) of front folio */
 	enum netfs_io_origin	origin;		/* Origin of the request */
-	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	refcount_t		ref;
 	unsigned long		flags;
 #define NETFS_RREQ_IN_PROGRESS		0	/* Unlocked when the request completes (has ref) */
@@ -466,12 +466,6 @@ void netfs_end_io_write(struct inode *inode);
 int netfs_start_io_direct(struct inode *inode);
 void netfs_end_io_direct(struct inode *inode);
 
-/* Miscellaneous APIs. */
-struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
-				       unsigned int trace /*enum netfs_folioq_trace*/);
-void netfs_folioq_free(struct folio_queue *folioq,
-		       unsigned int trace /*enum netfs_trace_folioq*/);
-
 /* Buffer wrangling helpers API. */
 int netfs_alloc_folioq_buffer(struct address_space *mapping,
 			      struct folio_queue **_buffer,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 2523adc3ad85..861dc7849067 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -212,7 +212,9 @@
 	EM(netfs_folio_trace_store_copy,	"store-copy")	\
 	EM(netfs_folio_trace_store_plus,	"store+")	\
 	EM(netfs_folio_trace_wthru,		"wthru")	\
-	E_(netfs_folio_trace_wthru_plus,	"wthru+")
+	EM(netfs_folio_trace_wthru_plus,	"wthru+")	\
+	EM(netfs_folio_trace_zero,		"zero")		\
+	E_(netfs_folio_trace_zero_ra,		"zero-ra")
 
 #define netfs_collect_contig_traces				\
 	EM(netfs_contig_trace_collect,		"Collect")	\
@@ -225,13 +227,13 @@
 	EM(netfs_trace_donate_to_next,		"to-next")	\
 	E_(netfs_trace_donate_to_deferred_next,	"defer-next")
 
-#define netfs_folioq_traces					\
-	EM(netfs_trace_folioq_alloc_buffer,	"alloc-buf")	\
-	EM(netfs_trace_folioq_clear,		"clear")	\
-	EM(netfs_trace_folioq_delete,		"delete")	\
-	EM(netfs_trace_folioq_make_space,	"make-space")	\
-	EM(netfs_trace_folioq_rollbuf_init,	"roll-init")	\
-	E_(netfs_trace_folioq_read_progress,	"r-progress")
+#define netfs_bvecq_traces					\
+	EM(netfs_trace_bvecq_alloc_buffer,	"alloc-buf")	\
+	EM(netfs_trace_bvecq_clear,		"clear")	\
+	EM(netfs_trace_bvecq_delete,		"delete")	\
+	EM(netfs_trace_bvecq_make_space,	"make-space")	\
+	EM(netfs_trace_bvecq_rollbuf_init,	"roll-init")	\
+	E_(netfs_trace_bvecq_read_progress,	"r-progress")
 
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
@@ -251,7 +253,7 @@ enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
 enum netfs_folio_trace { netfs_folio_traces } __mode(byte);
 enum netfs_collect_contig_trace { netfs_collect_contig_traces } __mode(byte);
 enum netfs_donate_trace { netfs_donate_traces } __mode(byte);
-enum netfs_folioq_trace { netfs_folioq_traces } __mode(byte);
+enum netfs_bvecq_trace { netfs_bvecq_traces } __mode(byte);
 
 #endif
 
@@ -275,7 +277,7 @@ netfs_sreq_ref_traces;
 netfs_folio_traces;
 netfs_collect_contig_traces;
 netfs_donate_traces;
-netfs_folioq_traces;
+netfs_bvecq_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -377,10 +379,10 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->len	= sreq->len;
 		    __entry->transferred = sreq->transferred;
 		    __entry->start	= sreq->start;
-		    __entry->slot	= sreq->io_iter.folioq_slot;
+		    __entry->slot	= sreq->dispatch_pos.slot;
 			   ),
 
-	    TP_printk("R=%08x[%x] %s %s f=%03x s=%llx %zx/%zx s=%u e=%d",
+	    TP_printk("R=%08x[%x] %s %s f=%03x s=%llx %zx/%zx qs=%u e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->what, netfs_sreq_traces),
@@ -755,27 +757,25 @@ TRACE_EVENT(netfs_collect_stream,
 		      __entry->collected_to, __entry->front)
 	    );
 
-TRACE_EVENT(netfs_folioq,
-	    TP_PROTO(const struct folio_queue *fq,
-		     enum netfs_folioq_trace trace),
+TRACE_EVENT(netfs_bvecq,
+	    TP_PROTO(const struct bvecq *bq,
+		     enum netfs_bvecq_trace trace),
 
-	    TP_ARGS(fq, trace),
+	    TP_ARGS(bq, trace),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq)
 		    __field(unsigned int,		id)
-		    __field(enum netfs_folioq_trace,	trace)
+		    __field(enum netfs_bvecq_trace,	trace)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->rreq	= fq ? fq->rreq_id : 0;
-		    __entry->id		= fq ? fq->debug_id : 0;
+		    __entry->id		= bq ? bq->priv : 0;
 		    __entry->trace	= trace;
 			   ),
 
-	    TP_printk("R=%08x fq=%x %s",
-		      __entry->rreq, __entry->id,
-		      __print_symbolic(__entry->trace, netfs_folioq_traces))
+	    TP_printk("fq=%x %s",
+		      __entry->id,
+		      __print_symbolic(__entry->trace, netfs_bvecq_traces))
 	    );
 
 TRACE_EVENT(netfs_bv_slot,


