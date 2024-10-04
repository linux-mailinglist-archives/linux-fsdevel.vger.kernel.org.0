Return-Path: <linux-fsdevel+bounces-30997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B312599062F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613982815D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD925217911;
	Fri,  4 Oct 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSg1bg/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF7217330
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052449; cv=none; b=JZaYucs/pd61ua7hAYWLP/l0cQ6e7rbeQxy5tPNZO5dhnxn048hPFULmQeqW/s00cvfpflwaTunmvt9L/l8RchL9F7G7fjHK8WsDIKRHGUxpKThpi7NFy+gznM3P0kJo3HZ5GB7tLX1MMbB8bxeT+8/QGIBPLGE1gDWz0VB5G6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052449; c=relaxed/simple;
	bh=dg/JlRn0H+tthLm9axveuXLsy7nnpjo7rpM9hSESaPQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=IMZl5tI/rjQl76UCQMizWU3PTydxNO9jJfoo+lEb7uqGX9+e4kNh9NkTKKi+dfZmSdXOC9qLnzzePM9k1+lCVEbqltbX4w/V7KH6K3kpEfI2TB8+bsdIgDufXw1mvW+K1wPK3tOdNcjI/YwuTg2zVbo/Oet08bA4mRaelf02RYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSg1bg/R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728052446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f1XZvlT7o8oSbF4HuhkqAPlXh5kAhT6DviPjd2xOrk0=;
	b=OSg1bg/R0R9+ZwuVJQU0oo5pUuP+3FvB3Di0cfQbmXPfh26rt5eLZJ4NvgW2jcO89RJ50D
	GInjMe/RLrzJvXhhRn5/RIoV0hhFyfEM4jDaTB1O6trmJZ6y/Ch2FB2f9vmR4CJ45j7HQF
	jx0PFjEu8ToQ8cEMz3Lr7yLzSQqXYVY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-MgEqM_UkMWi8Y9TB9fcswg-1; Fri,
 04 Oct 2024 10:34:03 -0400
X-MC-Unique: MgEqM_UkMWi8Y9TB9fcswg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E41501955F10;
	Fri,  4 Oct 2024 14:34:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E21AF1955E93;
	Fri,  4 Oct 2024 14:33:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: In readahead, put the folio refs as soon extracted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3771537.1728052438.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Oct 2024 15:33:58 +0100
Message-ID: <3771538.1728052438@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

netfslib currently defers dropping the ref on the folios it obtains during
readahead to after it has started I/O on the basis that we can do it whils=
t
we wait for the I/O to complete, but this runs the risk of the I/O
collection racing with this in future.

Furthermore, Matthew Wilcox strongly suggests that the refs should be
dropped immediately, as readahead_folio() does (netfslib is using
__readahead_batch() which doesn't drop the refs).

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c     |   47 ++++++++++++-------------------------=
------
 fs/netfs/read_collect.c      |    2 +
 include/trace/events/netfs.h |    1 =

 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..af46a598f4d7 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -67,7 +67,8 @@ static int netfs_begin_cache_read(struct netfs_io_reques=
t *rreq, struct netfs_in
  * Decant the list of folios to read into a rolling buffer.
  */
 static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
-					struct folio_queue *folioq)
+					struct folio_queue *folioq,
+					struct folio_batch *put_batch)
 {
 	unsigned int order, nr;
 	size_t size =3D 0;
@@ -82,6 +83,9 @@ static size_t netfs_load_buffer_from_ra(struct netfs_io_=
request *rreq,
 		order =3D folio_order(folio);
 		folioq->orders[i] =3D order;
 		size +=3D PAGE_SIZE << order;
+
+		if (!folio_batch_add(put_batch, folio))
+			folio_batch_release(put_batch);
 	}
 =

 	for (int i =3D nr; i < folioq_nr_slots(folioq); i++)
@@ -120,6 +124,9 @@ static ssize_t netfs_prepare_read_iterator(struct netf=
s_io_subrequest *subreq)
 		 * that we will need to release later - but we don't want to do
 		 * that until after we've started the I/O.
 		 */
+		struct folio_batch put_batch;
+
+		folio_batch_init(&put_batch);
 		while (rreq->submitted < subreq->start + rsize) {
 			struct folio_queue *tail =3D rreq->buffer_tail, *new;
 			size_t added;
@@ -132,10 +139,11 @@ static ssize_t netfs_prepare_read_iterator(struct ne=
tfs_io_subrequest *subreq)
 			new->prev =3D tail;
 			tail->next =3D new;
 			rreq->buffer_tail =3D new;
-			added =3D netfs_load_buffer_from_ra(rreq, new);
+			added =3D netfs_load_buffer_from_ra(rreq, new, &put_batch);
 			rreq->iter.count +=3D added;
 			rreq->submitted +=3D added;
 		}
+		folio_batch_release(&put_batch);
 	}
 =

 	subreq->len =3D rsize;
@@ -348,6 +356,7 @@ static int netfs_wait_for_read(struct netfs_io_request=
 *rreq)
 static int netfs_prime_buffer(struct netfs_io_request *rreq)
 {
 	struct folio_queue *folioq;
+	struct folio_batch put_batch;
 	size_t added;
 =

 	folioq =3D kmalloc(sizeof(*folioq), GFP_KERNEL);
@@ -360,39 +369,14 @@ static int netfs_prime_buffer(struct netfs_io_reques=
t *rreq)
 	rreq->submitted =3D rreq->start;
 	iov_iter_folio_queue(&rreq->iter, ITER_DEST, folioq, 0, 0, 0);
 =

-	added =3D netfs_load_buffer_from_ra(rreq, folioq);
+	folio_batch_init(&put_batch);
+	added =3D netfs_load_buffer_from_ra(rreq, folioq, &put_batch);
+	folio_batch_release(&put_batch);
 	rreq->iter.count +=3D added;
 	rreq->submitted +=3D added;
 	return 0;
 }
 =

-/*
- * Drop the ref on each folio that we inherited from the VM readahead cod=
e.  We
- * still have the folio locks to pin the page until we complete the I/O.
- *
- * Note that we can't just release the batch in each queue struct as we u=
se the
- * occupancy count in other places.
- */
-static void netfs_put_ra_refs(struct folio_queue *folioq)
-{
-	struct folio_batch fbatch;
-
-	folio_batch_init(&fbatch);
-	while (folioq) {
-		for (unsigned int slot =3D 0; slot < folioq_count(folioq); slot++) {
-			struct folio *folio =3D folioq_folio(folioq, slot);
-			if (!folio)
-				continue;
-			trace_netfs_folio(folio, netfs_folio_trace_read_put);
-			if (!folio_batch_add(&fbatch, folio))
-				folio_batch_release(&fbatch);
-		}
-		folioq =3D folioq->next;
-	}
-
-	folio_batch_release(&fbatch);
-}
-
 /**
  * netfs_readahead - Helper to manage a read request
  * @ractl: The description of the readahead request
@@ -436,9 +420,6 @@ void netfs_readahead(struct readahead_control *ractl)
 		goto cleanup_free;
 	netfs_read_to_pagecache(rreq);
 =

-	/* Release the folio refs whilst we're waiting for the I/O. */
-	netfs_put_ra_refs(rreq->buffer);
-
 	netfs_put_request(rreq, true, netfs_rreq_trace_put_return);
 	return;
 =

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b18c65ba5580..3cbb289535a8 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -77,6 +77,8 @@ static void netfs_unlock_read_folio(struct netfs_io_subr=
equest *subreq,
 			folio_unlock(folio);
 		}
 	}
+
+	folioq_clear(folioq, slot);
 }
 =

 /*
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 1d7c52821e55..69975c9c6823 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -172,7 +172,6 @@
 	EM(netfs_folio_trace_read,		"read")		\
 	EM(netfs_folio_trace_read_done,		"read-done")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
-	EM(netfs_folio_trace_read_put,		"read-put")	\
 	EM(netfs_folio_trace_read_unlock,	"read-unlock")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\


