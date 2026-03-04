Return-Path: <linux-fsdevel+bounces-79392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIMYFVBDqGlOrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:36:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C9201A15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF084322D653
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66693C3C1A;
	Wed,  4 Mar 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMfSk23B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE53C3BFD
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633136; cv=none; b=s9RSuMN/5buNVGrieVA/qy33UGjYXUCiS1ssegyufecyUh7EkPTL249vIO6Q9rbikmGB6XdBaO3vwDd9tiH5w/5fckzRg4pcDND7DN2iLw3saiUwtIxyWLN/+OvRj0154LF4P5Ey90aXttlPVXdgps0tZViNv4O+Wjxo7wK7UG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633136; c=relaxed/simple;
	bh=6VN1ewOcuiQK5sFqxXMsx+cstwSbHy0yDbBMJrRgEB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMq7mhV8WiafanfezoeHSY2McdpdDsjfJkrvRkXG5Huf+Ixeho9QD3d7aLreHdv6SHG5FgYI5zAHtq9hc3z+iWafDct0OD6cjUVP1Y/NX+7sIKPo7ycSrSPXh4pEgF6HqyB8cq4f3uDz2q6vRZpOxCKX2ypzD/DlZUjhIhilFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMfSk23B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fumhdzYIPGpYClcZxtDZtPkHXmqIkbTlOkkeMqUNdFc=;
	b=QMfSk23ByRKPkytzOlVN8Tmg2M2OJeQGQsN5CX9fs4r/kCSHu38MGhRRAZAhw0w+GRlZLL
	8FyJOsS9dYU6Bh8oK+6AaFldsTqnPG1Y4qOHUEOSrDHaJ8axUMWYtnWmzXXaPZ0bdKlbUY
	pJtHaB5YYFaK/lBi8ivStPjvZv5LkD8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-gLQBuz0gPWGkeC--3rlcNg-1; Wed,
 04 Mar 2026 09:05:25 -0500
X-MC-Unique: gLQBuz0gPWGkeC--3rlcNg-1
X-Mimecast-MFC-AGG-ID: gLQBuz0gPWGkeC--3rlcNg_1772633123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 638FF19560B0;
	Wed,  4 Mar 2026 14:05:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54CA230001A1;
	Wed,  4 Mar 2026 14:05:18 +0000 (UTC)
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
	Steve French <sfrench@samba.org>
Subject: [RFC PATCH 15/17] netfs: Remove folio_queue and rolling_buffer
Date: Wed,  4 Mar 2026 14:03:22 +0000
Message-ID: <20260304140328.112636-16-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: A74C9201A15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79392-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,manguebit.org:email,samba.org:email]
X-Rspamd-Action: no action

Remove folio_queue and rolling_buffer as they're no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 Documentation/core-api/folio_queue.rst | 209 ------------------
 Documentation/core-api/index.rst       |   1 -
 fs/netfs/iterator.c                    | 149 -------------
 fs/netfs/rolling_buffer.c              | 222 -------------------
 include/linux/folio_queue.h            | 282 -------------------------
 include/linux/rolling_buffer.h         |  61 ------
 6 files changed, 924 deletions(-)
 delete mode 100644 Documentation/core-api/folio_queue.rst
 delete mode 100644 fs/netfs/rolling_buffer.c
 delete mode 100644 include/linux/folio_queue.h
 delete mode 100644 include/linux/rolling_buffer.h

diff --git a/Documentation/core-api/folio_queue.rst b/Documentation/core-api/folio_queue.rst
deleted file mode 100644
index b7628896d2b6..000000000000
--- a/Documentation/core-api/folio_queue.rst
+++ /dev/null
@@ -1,209 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-===========
-Folio Queue
-===========
-
-:Author: David Howells <dhowells@redhat.com>
-
-.. Contents:
-
- * Overview
- * Initialisation
- * Adding and removing folios
- * Querying information about a folio
- * Querying information about a folio_queue
- * Folio queue iteration
- * Folio marks
- * Lockless simultaneous production/consumption issues
-
-
-Overview
-========
-
-The folio_queue struct forms a single segment in a segmented list of folios
-that can be used to form an I/O buffer.  As such, the list can be iterated over
-using the ITER_FOLIOQ iov_iter type.
-
-The publicly accessible members of the structure are::
-
-	struct folio_queue {
-		struct folio_queue *next;
-		struct folio_queue *prev;
-		...
-	};
-
-A pair of pointers are provided, ``next`` and ``prev``, that point to the
-segments on either side of the segment being accessed.  Whilst this is a
-doubly-linked list, it is intentionally not a circular list; the outward
-sibling pointers in terminal segments should be NULL.
-
-Each segment in the list also stores:
-
- * an ordered sequence of folio pointers,
- * the size of each folio and
- * three 1-bit marks per folio,
-
-but these should not be accessed directly as the underlying data structure may
-change, but rather the access functions outlined below should be used.
-
-The facility can be made accessible by::
-
-	#include <linux/folio_queue.h>
-
-and to use the iterator::
-
-	#include <linux/uio.h>
-
-
-Initialisation
-==============
-
-A segment should be initialised by calling::
-
-	void folioq_init(struct folio_queue *folioq);
-
-with a pointer to the segment to be initialised.  Note that this will not
-necessarily initialise all the folio pointers, so care must be taken to check
-the number of folios added.
-
-
-Adding and removing folios
-==========================
-
-Folios can be set in the next unused slot in a segment struct by calling one
-of::
-
-	unsigned int folioq_append(struct folio_queue *folioq,
-				   struct folio *folio);
-
-	unsigned int folioq_append_mark(struct folio_queue *folioq,
-					struct folio *folio);
-
-Both functions update the stored folio count, store the folio and note its
-size.  The second function also sets the first mark for the folio added.  Both
-functions return the number of the slot used.  [!] Note that no attempt is made
-to check that the capacity wasn't overrun and the list will not be extended
-automatically.
-
-A folio can be excised by calling::
-
-	void folioq_clear(struct folio_queue *folioq, unsigned int slot);
-
-This clears the slot in the array and also clears all the marks for that folio,
-but doesn't change the folio count - so future accesses of that slot must check
-if the slot is occupied.
-
-
-Querying information about a folio
-==================================
-
-Information about the folio in a particular slot may be queried by the
-following function::
-
-	struct folio *folioq_folio(const struct folio_queue *folioq,
-				   unsigned int slot);
-
-If a folio has not yet been set in that slot, this may yield an undefined
-pointer.  The size of the folio in a slot may be queried with either of::
-
-	unsigned int folioq_folio_order(const struct folio_queue *folioq,
-					unsigned int slot);
-
-	size_t folioq_folio_size(const struct folio_queue *folioq,
-				 unsigned int slot);
-
-The first function returns the size as an order and the second as a number of
-bytes.
-
-
-Querying information about a folio_queue
-========================================
-
-Information may be retrieved about a particular segment with the following
-functions::
-
-	unsigned int folioq_nr_slots(const struct folio_queue *folioq);
-
-	unsigned int folioq_count(struct folio_queue *folioq);
-
-	bool folioq_full(struct folio_queue *folioq);
-
-The first function returns the maximum capacity of a segment.  It must not be
-assumed that this won't vary between segments.  The second returns the number
-of folios added to a segments and the third is a shorthand to indicate if the
-segment has been filled to capacity.
-
-Not that the count and fullness are not affected by clearing folios from the
-segment.  These are more about indicating how many slots in the array have been
-initialised, and it assumed that slots won't get reused, but rather the segment
-will get discarded as the queue is consumed.
-
-
-Folio marks
-===========
-
-Folios within a queue can also have marks assigned to them.  These marks can be
-used to note information such as if a folio needs folio_put() calling upon it.
-There are three marks available to be set for each folio.
-
-The marks can be set by::
-
-	void folioq_mark(struct folio_queue *folioq, unsigned int slot);
-	void folioq_mark2(struct folio_queue *folioq, unsigned int slot);
-
-Cleared by::
-
-	void folioq_unmark(struct folio_queue *folioq, unsigned int slot);
-	void folioq_unmark2(struct folio_queue *folioq, unsigned int slot);
-
-And the marks can be queried by::
-
-	bool folioq_is_marked(const struct folio_queue *folioq, unsigned int slot);
-	bool folioq_is_marked2(const struct folio_queue *folioq, unsigned int slot);
-
-The marks can be used for any purpose and are not interpreted by this API.
-
-
-Folio queue iteration
-=====================
-
-A list of segments may be iterated over using the I/O iterator facility using
-an ``iov_iter`` iterator of ``ITER_FOLIOQ`` type.  The iterator may be
-initialised with::
-
-	void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
-				  const struct folio_queue *folioq,
-				  unsigned int first_slot, unsigned int offset,
-				  size_t count);
-
-This may be told to start at a particular segment, slot and offset within a
-queue.  The iov iterator functions will follow the next pointers when advancing
-and prev pointers when reverting when needed.
-
-
-Lockless simultaneous production/consumption issues
-===================================================
-
-If properly managed, the list can be extended by the producer at the head end
-and shortened by the consumer at the tail end simultaneously without the need
-to take locks.  The ITER_FOLIOQ iterator inserts appropriate barriers to aid
-with this.
-
-Care must be taken when simultaneously producing and consuming a list.  If the
-last segment is reached and the folios it refers to are entirely consumed by
-the IOV iterators, an iov_iter struct will be left pointing to the last segment
-with a slot number equal to the capacity of that segment.  The iterator will
-try to continue on from this if there's another segment available when it is
-used again, but care must be taken lest the segment got removed and freed by
-the consumer before the iterator was advanced.
-
-It is recommended that the queue always contain at least one segment, even if
-that segment has never been filled or is entirely spent.  This prevents the
-head and tail pointers from collapsing.
-
-
-API Function Reference
-======================
-
-.. kernel-doc:: include/linux/folio_queue.h
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 13769d5c40bf..16c529a33ac4 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -39,7 +39,6 @@ Library functionality that is used throughout the kernel.
    kref
    cleanup
    assoc_array
-   folio_queue
    xarray
    maple_tree
    idr
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 5ae9279a2dfb..eda6e2ca02e7 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -134,152 +134,3 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_se
 	return extracted ?: ret;
 }
 EXPORT_SYMBOL_GPL(netfs_extract_iter);
-
-#if 0
-/*
- * Select the span of a bvec iterator we're going to use.  Limit it by both maximum
- * size and maximum number of segments.  Returns the size of the span in bytes.
- */
-static size_t netfs_limit_bvec(const struct iov_iter *iter, size_t start_offset,
-			       size_t max_size, size_t max_segs)
-{
-	const struct bio_vec *bvecs = iter->bvec;
-	unsigned int nbv = iter->nr_segs, ix = 0, nsegs = 0;
-	size_t len, span = 0, n = iter->count;
-	size_t skip = iter->iov_offset + start_offset;
-
-	if (WARN_ON(!iov_iter_is_bvec(iter)) ||
-	    WARN_ON(start_offset > n) ||
-	    n == 0)
-		return 0;
-
-	while (n && ix < nbv && skip) {
-		len = bvecs[ix].bv_len;
-		if (skip < len)
-			break;
-		skip -= len;
-		n -= len;
-		ix++;
-	}
-
-	while (n && ix < nbv) {
-		len = min3(n, bvecs[ix].bv_len - skip, max_size);
-		span += len;
-		nsegs++;
-		ix++;
-		if (span >= max_size || nsegs >= max_segs)
-			break;
-		skip = 0;
-		n -= len;
-	}
-
-	return min(span, max_size);
-}
-
-/*
- * Select the span of an xarray iterator we're going to use.  Limit it by both
- * maximum size and maximum number of segments.  It is assumed that segments
- * can be larger than a page in size, provided they're physically contiguous.
- * Returns the size of the span in bytes.
- */
-static size_t netfs_limit_xarray(const struct iov_iter *iter, size_t start_offset,
-				 size_t max_size, size_t max_segs)
-{
-	struct folio *folio;
-	unsigned int nsegs = 0;
-	loff_t pos = iter->xarray_start + iter->iov_offset;
-	pgoff_t index = pos / PAGE_SIZE;
-	size_t span = 0, n = iter->count;
-
-	XA_STATE(xas, iter->xarray, index);
-
-	if (WARN_ON(!iov_iter_is_xarray(iter)) ||
-	    WARN_ON(start_offset > n) ||
-	    n == 0)
-		return 0;
-	max_size = min(max_size, n - start_offset);
-
-	rcu_read_lock();
-	xas_for_each(&xas, folio, ULONG_MAX) {
-		size_t offset, flen, len;
-		if (xas_retry(&xas, folio))
-			continue;
-		if (WARN_ON(xa_is_value(folio)))
-			break;
-		if (WARN_ON(folio_test_hugetlb(folio)))
-			break;
-
-		flen = folio_size(folio);
-		offset = offset_in_folio(folio, pos);
-		len = min(max_size, flen - offset);
-		span += len;
-		nsegs++;
-		if (span >= max_size || nsegs >= max_segs)
-			break;
-	}
-
-	rcu_read_unlock();
-	return min(span, max_size);
-}
-
-/*
- * Select the span of a folio queue iterator we're going to use.  Limit it by
- * both maximum size and maximum number of segments.  Returns the size of the
- * span in bytes.
- */
-static size_t netfs_limit_folioq(const struct iov_iter *iter, size_t start_offset,
-				 size_t max_size, size_t max_segs)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	unsigned int nsegs = 0;
-	unsigned int slot = iter->folioq_slot;
-	size_t span = 0, n = iter->count;
-
-	if (WARN_ON(!iov_iter_is_folioq(iter)) ||
-	    WARN_ON(start_offset > n) ||
-	    n == 0)
-		return 0;
-	max_size = umin(max_size, n - start_offset);
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		slot = 0;
-	}
-
-	start_offset += iter->iov_offset;
-	do {
-		size_t flen = folioq_folio_size(folioq, slot);
-
-		if (start_offset < flen) {
-			span += flen - start_offset;
-			nsegs++;
-			start_offset = 0;
-		} else {
-			start_offset -= flen;
-		}
-		if (span >= max_size || nsegs >= max_segs)
-			break;
-
-		slot++;
-		if (slot >= folioq_nr_slots(folioq)) {
-			folioq = folioq->next;
-			slot = 0;
-		}
-	} while (folioq);
-
-	return umin(span, max_size);
-}
-
-size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
-			size_t max_size, size_t max_segs)
-{
-	if (iov_iter_is_folioq(iter))
-		return netfs_limit_folioq(iter, start_offset, max_size, max_segs);
-	if (iov_iter_is_bvec(iter))
-		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
-	if (iov_iter_is_xarray(iter))
-		return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
-	BUG();
-}
-EXPORT_SYMBOL(netfs_limit_iter);
-#endif
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
deleted file mode 100644
index a17fbf9853a4..000000000000
--- a/fs/netfs/rolling_buffer.c
+++ /dev/null
@@ -1,222 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Rolling buffer helpers
- *
- * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/bitops.h>
-#include <linux/pagemap.h>
-#include <linux/rolling_buffer.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-static atomic_t debug_ids;
-
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
-	struct folio_queue *fq;
-
-	fq = kmalloc_obj(*fq, gfp);
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
- * Initialise a rolling buffer.  We allocate an empty folio queue struct to so
- * that the pointers can be independently driven by the producer and the
- * consumer.
- */
-int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
-			unsigned int direction)
-{
-	struct folio_queue *fq;
-
-	fq = netfs_folioq_alloc(rreq_id, GFP_NOFS, netfs_trace_folioq_rollbuf_init);
-	if (!fq)
-		return -ENOMEM;
-
-	roll->head = fq;
-	roll->tail = fq;
-	iov_iter_folio_queue(&roll->iter, direction, fq, 0, 0, 0);
-	return 0;
-}
-
-/*
- * Add another folio_queue to a rolling buffer if there's no space left.
- */
-int rolling_buffer_make_space(struct rolling_buffer *roll)
-{
-	struct folio_queue *fq, *head = roll->head;
-
-	if (!folioq_full(head))
-		return 0;
-
-	fq = netfs_folioq_alloc(head->rreq_id, GFP_NOFS, netfs_trace_folioq_make_space);
-	if (!fq)
-		return -ENOMEM;
-	fq->prev = head;
-
-	roll->head = fq;
-	if (folioq_full(head)) {
-		/* Make sure we don't leave the master iterator pointing to a
-		 * block that might get immediately consumed.
-		 */
-		if (roll->iter.folioq == head &&
-		    roll->iter.folioq_slot == folioq_nr_slots(head)) {
-			roll->iter.folioq = fq;
-			roll->iter.folioq_slot = 0;
-		}
-	}
-
-	/* Make sure the initialisation is stored before the next pointer.
-	 *
-	 * [!] NOTE: After we set head->next, the consumer is at liberty to
-	 * immediately delete the old head.
-	 */
-	smp_store_release(&head->next, fq);
-	return 0;
-}
-
-/*
- * Decant the list of folios to read into a rolling buffer.
- */
-ssize_t rolling_buffer_load_from_ra(struct rolling_buffer *roll,
-				    struct readahead_control *ractl,
-				    struct folio_batch *put_batch)
-{
-	struct folio_queue *fq;
-	struct page **vec;
-	int nr, ix, to;
-	ssize_t size = 0;
-
-	if (rolling_buffer_make_space(roll) < 0)
-		return -ENOMEM;
-
-	fq = roll->head;
-	vec = (struct page **)fq->vec.folios;
-	nr = __readahead_batch(ractl, vec + folio_batch_count(&fq->vec),
-			       folio_batch_space(&fq->vec));
-	ix = fq->vec.nr;
-	to = ix + nr;
-	fq->vec.nr = to;
-	for (; ix < to; ix++) {
-		struct folio *folio = folioq_folio(fq, ix);
-		unsigned int order = folio_order(folio);
-
-		fq->orders[ix] = order;
-		size += PAGE_SIZE << order;
-		trace_netfs_folio(folio, netfs_folio_trace_read);
-		if (!folio_batch_add(put_batch, folio))
-			folio_batch_release(put_batch);
-	}
-	WRITE_ONCE(roll->iter.count, roll->iter.count + size);
-
-	/* Store the counter after setting the slot. */
-	smp_store_release(&roll->next_head_slot, to);
-	return size;
-}
-
-/*
- * Append a folio to the rolling buffer.
- */
-ssize_t rolling_buffer_append(struct rolling_buffer *roll, struct folio *folio,
-			      unsigned int flags)
-{
-	ssize_t size = folio_size(folio);
-	int slot;
-
-	if (rolling_buffer_make_space(roll) < 0)
-		return -ENOMEM;
-
-	slot = folioq_append(roll->head, folio);
-	if (flags & ROLLBUF_MARK_1)
-		folioq_mark(roll->head, slot);
-	if (flags & ROLLBUF_MARK_2)
-		folioq_mark2(roll->head, slot);
-
-	WRITE_ONCE(roll->iter.count, roll->iter.count + size);
-
-	/* Store the counter after setting the slot. */
-	smp_store_release(&roll->next_head_slot, slot);
-	return size;
-}
-
-/*
- * Delete a spent buffer from a rolling queue and return the next in line.  We
- * don't return the last buffer to keep the pointers independent, but return
- * NULL instead.
- */
-struct folio_queue *rolling_buffer_delete_spent(struct rolling_buffer *roll)
-{
-	struct folio_queue *spent = roll->tail, *next = READ_ONCE(spent->next);
-
-	if (!next)
-		return NULL;
-	next->prev = NULL;
-	netfs_folioq_free(spent, netfs_trace_folioq_delete);
-	roll->tail = next;
-	return next;
-}
-
-/*
- * Clear out a rolling queue.  Folios that have mark 1 set are put.
- */
-void rolling_buffer_clear(struct rolling_buffer *roll)
-{
-	struct folio_batch fbatch;
-	struct folio_queue *p;
-
-	folio_batch_init(&fbatch);
-
-	while ((p = roll->tail)) {
-		roll->tail = p->next;
-		for (int slot = 0; slot < folioq_count(p); slot++) {
-			struct folio *folio = folioq_folio(p, slot);
-
-			if (!folio)
-				continue;
-			if (folioq_is_marked(p, slot)) {
-				trace_netfs_folio(folio, netfs_folio_trace_put);
-				if (!folio_batch_add(&fbatch, folio))
-					folio_batch_release(&fbatch);
-			}
-		}
-
-		netfs_folioq_free(p, netfs_trace_folioq_clear);
-	}
-
-	folio_batch_release(&fbatch);
-}
diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
deleted file mode 100644
index adab609c972e..000000000000
--- a/include/linux/folio_queue.h
+++ /dev/null
@@ -1,282 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* Queue of folios definitions
- *
- * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * See:
- *
- *	Documentation/core-api/folio_queue.rst
- *
- * for a description of the API.
- */
-
-#ifndef _LINUX_FOLIO_QUEUE_H
-#define _LINUX_FOLIO_QUEUE_H
-
-#include <linux/pagevec.h>
-#include <linux/mm.h>
-
-/*
- * Segment in a queue of running buffers.  Each segment can hold a number of
- * folios and a portion of the queue can be referenced with the ITER_FOLIOQ
- * iterator.  The possibility exists of inserting non-folio elements into the
- * queue (such as gaps).
- *
- * Explicit prev and next pointers are used instead of a list_head to make it
- * easier to add segments to tail and remove them from the head without the
- * need for a lock.
- */
-struct folio_queue {
-	struct folio_batch	vec;		/* Folios in the queue segment */
-	u8			orders[PAGEVEC_SIZE]; /* Order of each folio */
-	struct folio_queue	*next;		/* Next queue segment or NULL */
-	struct folio_queue	*prev;		/* Previous queue segment of NULL */
-	unsigned long		marks;		/* 1-bit mark per folio */
-	unsigned long		marks2;		/* Second 1-bit mark per folio */
-#if PAGEVEC_SIZE > BITS_PER_LONG
-#error marks is not big enough
-#endif
-	unsigned int		rreq_id;
-	unsigned int		debug_id;
-};
-
-/**
- * folioq_init - Initialise a folio queue segment
- * @folioq: The segment to initialise
- * @rreq_id: The request identifier to use in tracelines.
- *
- * Initialise a folio queue segment and set an identifier to be used in traces.
- *
- * Note that the folio pointers are left uninitialised.
- */
-static inline void folioq_init(struct folio_queue *folioq, unsigned int rreq_id)
-{
-	folio_batch_init(&folioq->vec);
-	folioq->next = NULL;
-	folioq->prev = NULL;
-	folioq->marks = 0;
-	folioq->marks2 = 0;
-	folioq->rreq_id = rreq_id;
-	folioq->debug_id = 0;
-}
-
-/**
- * folioq_nr_slots: Query the capacity of a folio queue segment
- * @folioq: The segment to query
- *
- * Query the number of folios that a particular folio queue segment might hold.
- * [!] NOTE: This must not be assumed to be the same for every segment!
- */
-static inline unsigned int folioq_nr_slots(const struct folio_queue *folioq)
-{
-	return PAGEVEC_SIZE;
-}
-
-/**
- * folioq_count: Query the occupancy of a folio queue segment
- * @folioq: The segment to query
- *
- * Query the number of folios that have been added to a folio queue segment.
- * Note that this is not decreased as folios are removed from a segment.
- */
-static inline unsigned int folioq_count(struct folio_queue *folioq)
-{
-	return folio_batch_count(&folioq->vec);
-}
-
-/**
- * folioq_full: Query if a folio queue segment is full
- * @folioq: The segment to query
- *
- * Query if a folio queue segment is fully occupied.  Note that this does not
- * change if folios are removed from a segment.
- */
-static inline bool folioq_full(struct folio_queue *folioq)
-{
-	//return !folio_batch_space(&folioq->vec);
-	return folioq_count(folioq) >= folioq_nr_slots(folioq);
-}
-
-/**
- * folioq_is_marked: Check first folio mark in a folio queue segment
- * @folioq: The segment to query
- * @slot: The slot number of the folio to query
- *
- * Determine if the first mark is set for the folio in the specified slot in a
- * folio queue segment.
- */
-static inline bool folioq_is_marked(const struct folio_queue *folioq, unsigned int slot)
-{
-	return test_bit(slot, &folioq->marks);
-}
-
-/**
- * folioq_mark: Set the first mark on a folio in a folio queue segment
- * @folioq: The segment to modify
- * @slot: The slot number of the folio to modify
- *
- * Set the first mark for the folio in the specified slot in a folio queue
- * segment.
- */
-static inline void folioq_mark(struct folio_queue *folioq, unsigned int slot)
-{
-	set_bit(slot, &folioq->marks);
-}
-
-/**
- * folioq_unmark: Clear the first mark on a folio in a folio queue segment
- * @folioq: The segment to modify
- * @slot: The slot number of the folio to modify
- *
- * Clear the first mark for the folio in the specified slot in a folio queue
- * segment.
- */
-static inline void folioq_unmark(struct folio_queue *folioq, unsigned int slot)
-{
-	clear_bit(slot, &folioq->marks);
-}
-
-/**
- * folioq_is_marked2: Check second folio mark in a folio queue segment
- * @folioq: The segment to query
- * @slot: The slot number of the folio to query
- *
- * Determine if the second mark is set for the folio in the specified slot in a
- * folio queue segment.
- */
-static inline bool folioq_is_marked2(const struct folio_queue *folioq, unsigned int slot)
-{
-	return test_bit(slot, &folioq->marks2);
-}
-
-/**
- * folioq_mark2: Set the second mark on a folio in a folio queue segment
- * @folioq: The segment to modify
- * @slot: The slot number of the folio to modify
- *
- * Set the second mark for the folio in the specified slot in a folio queue
- * segment.
- */
-static inline void folioq_mark2(struct folio_queue *folioq, unsigned int slot)
-{
-	set_bit(slot, &folioq->marks2);
-}
-
-/**
- * folioq_unmark2: Clear the second mark on a folio in a folio queue segment
- * @folioq: The segment to modify
- * @slot: The slot number of the folio to modify
- *
- * Clear the second mark for the folio in the specified slot in a folio queue
- * segment.
- */
-static inline void folioq_unmark2(struct folio_queue *folioq, unsigned int slot)
-{
-	clear_bit(slot, &folioq->marks2);
-}
-
-/**
- * folioq_append: Add a folio to a folio queue segment
- * @folioq: The segment to add to
- * @folio: The folio to add
- *
- * Add a folio to the tail of the sequence in a folio queue segment, increasing
- * the occupancy count and returning the slot number for the folio just added.
- * The folio size is extracted and stored in the queue and the marks are left
- * unmodified.
- *
- * Note that it's left up to the caller to check that the segment capacity will
- * not be exceeded and to extend the queue.
- */
-static inline unsigned int folioq_append(struct folio_queue *folioq, struct folio *folio)
-{
-	unsigned int slot = folioq->vec.nr++;
-
-	folioq->vec.folios[slot] = folio;
-	folioq->orders[slot] = folio_order(folio);
-	return slot;
-}
-
-/**
- * folioq_append_mark: Add a folio to a folio queue segment
- * @folioq: The segment to add to
- * @folio: The folio to add
- *
- * Add a folio to the tail of the sequence in a folio queue segment, increasing
- * the occupancy count and returning the slot number for the folio just added.
- * The folio size is extracted and stored in the queue, the first mark is set
- * and and the second and third marks are left unmodified.
- *
- * Note that it's left up to the caller to check that the segment capacity will
- * not be exceeded and to extend the queue.
- */
-static inline unsigned int folioq_append_mark(struct folio_queue *folioq, struct folio *folio)
-{
-	unsigned int slot = folioq->vec.nr++;
-
-	folioq->vec.folios[slot] = folio;
-	folioq->orders[slot] = folio_order(folio);
-	folioq_mark(folioq, slot);
-	return slot;
-}
-
-/**
- * folioq_folio: Get a folio from a folio queue segment
- * @folioq: The segment to access
- * @slot: The folio slot to access
- *
- * Retrieve the folio in the specified slot from a folio queue segment.  Note
- * that no bounds check is made and if the slot hasn't been added into yet, the
- * pointer will be undefined.  If the slot has been cleared, NULL will be
- * returned.
- */
-static inline struct folio *folioq_folio(const struct folio_queue *folioq, unsigned int slot)
-{
-	return folioq->vec.folios[slot];
-}
-
-/**
- * folioq_folio_order: Get the order of a folio from a folio queue segment
- * @folioq: The segment to access
- * @slot: The folio slot to access
- *
- * Retrieve the order of the folio in the specified slot from a folio queue
- * segment.  Note that no bounds check is made and if the slot hasn't been
- * added into yet, the order returned will be 0.
- */
-static inline unsigned int folioq_folio_order(const struct folio_queue *folioq, unsigned int slot)
-{
-	return folioq->orders[slot];
-}
-
-/**
- * folioq_folio_size: Get the size of a folio from a folio queue segment
- * @folioq: The segment to access
- * @slot: The folio slot to access
- *
- * Retrieve the size of the folio in the specified slot from a folio queue
- * segment.  Note that no bounds check is made and if the slot hasn't been
- * added into yet, the size returned will be PAGE_SIZE.
- */
-static inline size_t folioq_folio_size(const struct folio_queue *folioq, unsigned int slot)
-{
-	return PAGE_SIZE << folioq_folio_order(folioq, slot);
-}
-
-/**
- * folioq_clear: Clear a folio from a folio queue segment
- * @folioq: The segment to clear
- * @slot: The folio slot to clear
- *
- * Clear a folio from a sequence in a folio queue segment and clear its marks.
- * The occupancy count is left unchanged.
- */
-static inline void folioq_clear(struct folio_queue *folioq, unsigned int slot)
-{
-	folioq->vec.folios[slot] = NULL;
-	folioq_unmark(folioq, slot);
-	folioq_unmark2(folioq, slot);
-}
-
-#endif /* _LINUX_FOLIO_QUEUE_H */
diff --git a/include/linux/rolling_buffer.h b/include/linux/rolling_buffer.h
deleted file mode 100644
index ac15b1ffdd83..000000000000
--- a/include/linux/rolling_buffer.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* Rolling buffer of folios
- *
- * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#ifndef _ROLLING_BUFFER_H
-#define _ROLLING_BUFFER_H
-
-#include <linux/folio_queue.h>
-#include <linux/uio.h>
-
-/*
- * Rolling buffer.  Whilst the buffer is live and in use, folios and folio
- * queue segments can be added to one end by one thread and removed from the
- * other end by another thread.  The buffer isn't allowed to be empty; it must
- * always have at least one folio_queue in it so that neither side has to
- * modify both queue pointers.
- *
- * The iterator in the buffer is extended as buffers are inserted.  It can be
- * snapshotted to use a segment of the buffer.
- */
-struct rolling_buffer {
-	struct folio_queue	*head;		/* Producer's insertion point */
-	struct folio_queue	*tail;		/* Consumer's removal point */
-	struct iov_iter		iter;		/* Iterator tracking what's left in the buffer */
-	u8			next_head_slot;	/* Next slot in ->head */
-	u8			first_tail_slot; /* First slot in ->tail */
-};
-
-/*
- * Snapshot of a rolling buffer.
- */
-struct rolling_buffer_snapshot {
-	struct folio_queue	*curr_folioq;	/* Queue segment in which current folio resides */
-	unsigned char		curr_slot;	/* Folio currently being read */
-	unsigned char		curr_order;	/* Order of folio */
-};
-
-/* Marks to store per-folio in the internal folio_queue structs. */
-#define ROLLBUF_MARK_1	BIT(0)
-#define ROLLBUF_MARK_2	BIT(1)
-
-int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
-			unsigned int direction);
-int rolling_buffer_make_space(struct rolling_buffer *roll);
-ssize_t rolling_buffer_load_from_ra(struct rolling_buffer *roll,
-				    struct readahead_control *ractl,
-				    struct folio_batch *put_batch);
-ssize_t rolling_buffer_append(struct rolling_buffer *roll, struct folio *folio,
-			      unsigned int flags);
-struct folio_queue *rolling_buffer_delete_spent(struct rolling_buffer *roll);
-void rolling_buffer_clear(struct rolling_buffer *roll);
-
-static inline void rolling_buffer_advance(struct rolling_buffer *roll, size_t amount)
-{
-	iov_iter_advance(&roll->iter, amount);
-}
-
-#endif /* _ROLLING_BUFFER_H */


