Return-Path: <linux-fsdevel+bounces-79391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HqxA3E/qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:19:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08155201362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE5B630908B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE53BED68;
	Wed,  4 Mar 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGfT70+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C253BE163
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633127; cv=none; b=Wih72pjwt4NXvaI/m3L5rbIDo5SCGDS+yxqcmNqePgfcJcUaclTCIAkDzldyr9mmNhBpsFiosWB5QFyEzFBSFt7aJaWjtEjoy8cbNlxEDTGM15uWsPZ+nddui7NRfP0w7/VVq0tmfe/Ep0BDUnan6VNVXH8n78Lbst1D6mEYWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633127; c=relaxed/simple;
	bh=AraPL1OSKmpaH5gBSzGDcSXdXyc3fxEPDz/pg/7wBf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIHUkfTShWTgYrLEdMHP77duMRPzybMuKfvS2hiYd9VXu9EZnXphvj6/4HNQDTbphxAcA04wQ/MqpE0doJUDSk4mkal6xL5+IPI4BHXaZOlyqxIsnToGsmVInKs2DH8TO+V4GNDAbEzMQkb8hwHBBYYGfv8BrstEsh2aK+Reag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGfT70+k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N4Tp7WhbfGOl0t4/xOo3zAKE6foV1oI7IVqrxuvvXk=;
	b=HGfT70+k/deeBYA8aKcjxsemXaQtGF4MU0TpPMGtNOyJJkVDmBGMM+wmQUWofjJJTRcWh6
	X+YBQIaIa+yj38B/XfIDv8wKNyOXXM8UR37++GEhOtwK4Sh3+nFBmFjwV18i4Vf3Zkfgq0
	BN3Aj2V3qUQkbikWQoXn2WJt8huztpc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-bCa3m24RPL-M1HIdJBC1hw-1; Wed,
 04 Mar 2026 09:05:18 -0500
X-MC-Unique: bCa3m24RPL-M1HIdJBC1hw-1
X-Mimecast-MFC-AGG-ID: bCa3m24RPL-M1HIdJBC1hw_1772633116
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95C8419560B0;
	Wed,  4 Mar 2026 14:05:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A4BB18002A6;
	Wed,  4 Mar 2026 14:05:11 +0000 (UTC)
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
Subject: [RFC PATCH 14/17] iov_iter: Remove ITER_FOLIOQ
Date: Wed,  4 Mar 2026 14:03:21 +0000
Message-ID: <20260304140328.112636-15-dhowells@redhat.com>
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
X-Rspamd-Queue-Id: 08155201362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79391-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,samba.org:email,manguebit.org:email]
X-Rspamd-Action: no action

Remove ITER_FOLIOQ as it's no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/iov_iter.h   |  65 +---------
 include/linux/uio.h        |  12 --
 lib/iov_iter.c             | 235 +---------------------------------
 lib/scatterlist.c          |  67 +---------
 lib/tests/kunit_iov_iter.c | 256 -------------------------------------
 5 files changed, 5 insertions(+), 630 deletions(-)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index e0c129a3ca63..4b47454c5ca8 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -10,7 +10,6 @@
 
 #include <linux/uio.h>
 #include <linux/bvec.h>
-#include <linux/folio_queue.h>
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
 			     void *priv, void *priv2);
@@ -194,62 +193,6 @@ size_t iterate_bvecq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 	return progress;
 }
 
-/*
- * Handle ITER_FOLIOQ.
- */
-static __always_inline
-size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		      iov_step_f step)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	unsigned int slot = iter->folioq_slot;
-	size_t progress = 0, skip = iter->iov_offset;
-
-	if (slot == folioq_nr_slots(folioq)) {
-		/* The iterator may have been extended. */
-		folioq = folioq->next;
-		slot = 0;
-	}
-
-	do {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t part, remain = 0, consumed;
-		size_t fsize;
-		void *base;
-
-		if (!folio)
-			break;
-
-		fsize = folioq_folio_size(folioq, slot);
-		if (skip < fsize) {
-			base = kmap_local_folio(folio, skip);
-			part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
-			remain = step(base, progress, part, priv, priv2);
-			kunmap_local(base);
-			consumed = part - remain;
-			len -= consumed;
-			progress += consumed;
-			skip += consumed;
-		}
-		if (skip >= fsize) {
-			skip = 0;
-			slot++;
-			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-		if (remain)
-			break;
-	} while (len);
-
-	iter->folioq_slot = slot;
-	iter->folioq = folioq;
-	iter->iov_offset = skip;
-	iter->count -= progress;
-	return progress;
-}
-
 /*
  * Handle ITER_XARRAY.
  */
@@ -361,8 +304,6 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_kvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_bvecq(iter))
 		return iterate_bvecq(iter, len, priv, priv2, step);
-	if (iov_iter_is_folioq(iter))
-		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
 	return iterate_discard(iter, len, priv, priv2, step);
@@ -397,8 +338,8 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
  * buffer is presented in segments, which for kernel iteration are broken up by
  * physical pages and mapped, with the mapped address being presented.
  *
- * [!] Note This will only handle BVEC, KVEC, BVECQ, FOLIOQ, XARRAY and
- * DISCARD-type iterators; it will not handle UBUF or IOVEC-type iterators.
+ * [!] Note This will only handle BVEC, KVEC, BVECQ, XARRAY and DISCARD-type
+ * iterators; it will not handle UBUF or IOVEC-type iterators.
  *
  * A step functions, @step, must be provided, one for handling mapped kernel
  * addresses and the other is given user addresses which have the potential to
@@ -427,8 +368,6 @@ size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_kvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_bvecq(iter))
 		return iterate_bvecq(iter, len, priv, priv2, step);
-	if (iov_iter_is_folioq(iter))
-		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
 	return iterate_discard(iter, len, priv, priv2, step);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index aa50d348dfcc..e84a0c4f28c6 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,7 +11,6 @@
 #include <uapi/linux/uio.h>
 
 struct page;
-struct folio_queue;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -26,7 +25,6 @@ enum iter_type {
 	ITER_IOVEC,
 	ITER_BVEC,
 	ITER_KVEC,
-	ITER_FOLIOQ,
 	ITER_BVECQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
@@ -69,7 +67,6 @@ struct iov_iter {
 				const struct iovec *__iov;
 				const struct kvec *kvec;
 				const struct bio_vec *bvec;
-				const struct folio_queue *folioq;
 				const struct bvecq *bvecq;
 				struct xarray *xarray;
 				void __user *ubuf;
@@ -79,7 +76,6 @@ struct iov_iter {
 	};
 	union {
 		unsigned long nr_segs;
-		u8 folioq_slot;
 		u16 bvecq_slot;
 		loff_t xarray_start;
 	};
@@ -148,11 +144,6 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_DISCARD;
 }
 
-static inline bool iov_iter_is_folioq(const struct iov_iter *i)
-{
-	return iov_iter_type(i) == ITER_FOLIOQ;
-}
-
 static inline bool iov_iter_is_bvecq(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_BVECQ;
@@ -303,9 +294,6 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
-void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
-			  const struct folio_queue *folioq,
-			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_bvec_queue(struct iov_iter *i, unsigned int direction,
 			 const struct bvecq *bvecq,
 			 unsigned int first_slot, unsigned int offset, size_t count);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index df8d037894b1..d5a4f5e5a107 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -538,39 +538,6 @@ static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
 	i->__iov = iov;
 }
 
-static void iov_iter_folioq_advance(struct iov_iter *i, size_t size)
-{
-	const struct folio_queue *folioq = i->folioq;
-	unsigned int slot = i->folioq_slot;
-
-	if (!i->count)
-		return;
-	i->count -= size;
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		slot = 0;
-	}
-
-	size += i->iov_offset; /* From beginning of current segment. */
-	do {
-		size_t fsize = folioq_folio_size(folioq, slot);
-
-		if (likely(size < fsize))
-			break;
-		size -= fsize;
-		slot++;
-		if (slot >= folioq_nr_slots(folioq) && folioq->next) {
-			folioq = folioq->next;
-			slot = 0;
-		}
-	} while (size);
-
-	i->iov_offset = size;
-	i->folioq_slot = slot;
-	i->folioq = folioq;
-}
-
 static void iov_iter_bvecq_advance(struct iov_iter *i, size_t by)
 {
 	const struct bvecq *bq = i->bvecq;
@@ -616,8 +583,6 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_iovec_advance(i, size);
 	} else if (iov_iter_is_bvec(i)) {
 		iov_iter_bvec_advance(i, size);
-	} else if (iov_iter_is_folioq(i)) {
-		iov_iter_folioq_advance(i, size);
 	} else if (iov_iter_is_bvecq(i)) {
 		iov_iter_bvecq_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
@@ -626,32 +591,6 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 }
 EXPORT_SYMBOL(iov_iter_advance);
 
-static void iov_iter_folioq_revert(struct iov_iter *i, size_t unroll)
-{
-	const struct folio_queue *folioq = i->folioq;
-	unsigned int slot = i->folioq_slot;
-
-	for (;;) {
-		size_t fsize;
-
-		if (slot == 0) {
-			folioq = folioq->prev;
-			slot = folioq_nr_slots(folioq);
-		}
-		slot--;
-
-		fsize = folioq_folio_size(folioq, slot);
-		if (unroll <= fsize) {
-			i->iov_offset = fsize - unroll;
-			break;
-		}
-		unroll -= fsize;
-	}
-
-	i->folioq_slot = slot;
-	i->folioq = folioq;
-}
-
 static void iov_iter_bvecq_revert(struct iov_iter *i, size_t unroll)
 {
 	const struct bvecq *bq = i->bvecq;
@@ -709,9 +648,6 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			}
 			unroll -= n;
 		}
-	} else if (iov_iter_is_folioq(i)) {
-		i->iov_offset = 0;
-		iov_iter_folioq_revert(i, unroll);
 	} else if (iov_iter_is_bvecq(i)) {
 		i->iov_offset = 0;
 		iov_iter_bvecq_revert(i, unroll);
@@ -744,8 +680,6 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 	}
 	if (!i->count)
 		return 0;
-	if (unlikely(iov_iter_is_folioq(i)))
-		return umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
 	if (unlikely(iov_iter_is_bvecq(i)))
 		return min(i->count, i->bvecq->bv[i->bvecq_slot].bv_len - i->iov_offset);
 	return i->count;
@@ -784,36 +718,6 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
-/**
- * iov_iter_folio_queue - Initialise an I/O iterator to use the folios in a folio queue
- * @i: The iterator to initialise.
- * @direction: The direction of the transfer.
- * @folioq: The starting point in the folio queue.
- * @first_slot: The first slot in the folio queue to use
- * @offset: The offset into the folio in the first slot to start at
- * @count: The size of the I/O buffer in bytes.
- *
- * Set up an I/O iterator to either draw data out of the pages attached to an
- * inode or to inject data into those pages.  The pages *must* be prevented
- * from evaporation, either by taking a ref on them or locking them by the
- * caller.
- */
-void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
-			  const struct folio_queue *folioq, unsigned int first_slot,
-			  unsigned int offset, size_t count)
-{
-	BUG_ON(direction & ~1);
-	*i = (struct iov_iter) {
-		.iter_type = ITER_FOLIOQ,
-		.data_source = direction,
-		.folioq = folioq,
-		.folioq_slot = first_slot,
-		.count = count,
-		.iov_offset = offset,
-	};
-}
-EXPORT_SYMBOL(iov_iter_folio_queue);
-
 /**
  * iov_iter_bvec_queue - Initialise an I/O iterator to use a segmented bvec queue
  * @i: The iterator to initialise.
@@ -982,9 +886,6 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	if (iov_iter_is_bvec(i))
 		return iov_iter_alignment_bvec(i);
 
-	/* With both xarray and folioq types, we're dealing with whole folios. */
-	if (iov_iter_is_folioq(i))
-		return i->iov_offset | i->count;
 	if (iov_iter_is_bvecq(i))
 		return iov_iter_alignment_bvecq(i);
 	if (iov_iter_is_xarray(i))
@@ -1039,65 +940,6 @@ static int want_pages_array(struct page ***res, size_t size,
 	return count;
 }
 
-static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
-				     struct page ***ppages, size_t maxsize,
-				     unsigned maxpages, size_t *_start_offset)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	struct page **pages;
-	unsigned int slot = iter->folioq_slot;
-	size_t extracted = 0, count = iter->count, iov_offset = iter->iov_offset;
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		slot = 0;
-		if (WARN_ON(iov_offset != 0))
-			return -EIO;
-	}
-
-	maxpages = want_pages_array(ppages, maxsize, iov_offset & ~PAGE_MASK, maxpages);
-	if (!maxpages)
-		return -ENOMEM;
-	*_start_offset = iov_offset & ~PAGE_MASK;
-	pages = *ppages;
-
-	for (;;) {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t offset = iov_offset, fsize = folioq_folio_size(folioq, slot);
-		size_t part = PAGE_SIZE - offset % PAGE_SIZE;
-
-		if (offset < fsize) {
-			part = umin(part, umin(maxsize - extracted, fsize - offset));
-			count -= part;
-			iov_offset += part;
-			extracted += part;
-
-			*pages = folio_page(folio, offset / PAGE_SIZE);
-			get_page(*pages);
-			pages++;
-			maxpages--;
-		}
-
-		if (maxpages == 0 || extracted >= maxsize)
-			break;
-
-		if (iov_offset >= fsize) {
-			iov_offset = 0;
-			slot++;
-			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	}
-
-	iter->count = count;
-	iter->iov_offset = iov_offset;
-	iter->folioq = folioq;
-	iter->folioq_slot = slot;
-	return extracted;
-}
-
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
 					  pgoff_t index, unsigned int nr_pages)
 {
@@ -1249,8 +1091,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		}
 		return maxsize;
 	}
-	if (iov_iter_is_folioq(i))
-		return iter_folioq_get_pages(i, pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	WARN_ON_ONCE(iov_iter_is_bvecq(i));
@@ -1366,11 +1206,6 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return iov_npages(i, maxpages);
 	if (iov_iter_is_bvec(i))
 		return bvec_npages(i, maxpages);
-	if (iov_iter_is_folioq(i)) {
-		unsigned offset = i->iov_offset % PAGE_SIZE;
-		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
-		return min(npages, maxpages);
-	}
 	if (iov_iter_is_bvecq(i))
 		return iov_npages_bvecq(i, maxpages);
 	if (iov_iter_is_xarray(i)) {
@@ -1654,68 +1489,6 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 	i->nr_segs = state->nr_segs;
 }
 
-/*
- * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
- * not get references on the pages, nor does it get a pin on them.
- */
-static ssize_t iov_iter_extract_folioq_pages(struct iov_iter *i,
-					     struct page ***pages, size_t maxsize,
-					     unsigned int maxpages,
-					     iov_iter_extraction_t extraction_flags,
-					     size_t *offset0)
-{
-	const struct folio_queue *folioq = i->folioq;
-	struct page **p;
-	unsigned int nr = 0;
-	size_t extracted = 0, offset, slot = i->folioq_slot;
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		slot = 0;
-		if (WARN_ON(i->iov_offset != 0))
-			return -EIO;
-	}
-
-	offset = i->iov_offset & ~PAGE_MASK;
-	*offset0 = offset;
-
-	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
-	if (!maxpages)
-		return -ENOMEM;
-	p = *pages;
-
-	for (;;) {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t offset = i->iov_offset, fsize = folioq_folio_size(folioq, slot);
-		size_t part = PAGE_SIZE - offset % PAGE_SIZE;
-
-		if (offset < fsize) {
-			part = umin(part, umin(maxsize - extracted, fsize - offset));
-			i->count -= part;
-			i->iov_offset += part;
-			extracted += part;
-
-			p[nr++] = folio_page(folio, offset / PAGE_SIZE);
-		}
-
-		if (nr >= maxpages || extracted >= maxsize)
-			break;
-
-		if (i->iov_offset >= fsize) {
-			i->iov_offset = 0;
-			slot++;
-			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	}
-
-	i->folioq = folioq;
-	i->folioq_slot = slot;
-	return extracted;
-}
-
 /*
  * Extract a list of virtually contiguous pages from an ITER_BVECQ iterator.
  * This does not get references on the pages, nor does it get a pin on them.
@@ -2078,8 +1851,8 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
  *      added to the pages, but refs will not be taken.
  *      iov_iter_extract_will_pin() will return true.
  *
- *  (*) If the iterator is ITER_KVEC, ITER_BVEC, ITER_FOLIOQ or ITER_XARRAY, the
- *      pages are merely listed; no extra refs or pins are obtained.
+ *  (*) If the iterator is ITER_KVEC, ITER_BVEC, ITER_XARRAY, the pages are
+ *      merely listed; no extra refs or pins are obtained.
  *      iov_iter_extract_will_pin() will return 0.
  *
  * Note also:
@@ -2114,10 +1887,6 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_bvec_pages(i, pages, maxsize,
 						   maxpages, extraction_flags,
 						   offset0);
-	if (iov_iter_is_folioq(i))
-		return iov_iter_extract_folioq_pages(i, pages, maxsize,
-						     maxpages, extraction_flags,
-						     offset0);
 	if (iov_iter_is_bvecq(i))
 		return iov_iter_extract_bvecq_pages(i, pages, maxsize,
 						    maxpages, extraction_flags,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 61ca42ac53f3..84a6e2983f2a 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -11,7 +11,6 @@
 #include <linux/kmemleak.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
-#include <linux/folio_queue.h>
 
 /**
  * sg_nents - return total count of entries in scatterlist
@@ -1267,67 +1266,6 @@ static ssize_t extract_kvec_to_sg(struct iov_iter *iter,
 	return ret;
 }
 
-/*
- * Extract up to sg_max folios from an FOLIOQ-type iterator and add them to
- * the scatterlist.  The pages are not pinned.
- */
-static ssize_t extract_folioq_to_sg(struct iov_iter *iter,
-				   ssize_t maxsize,
-				   struct sg_table *sgtable,
-				   unsigned int sg_max,
-				   iov_iter_extraction_t extraction_flags)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
-	unsigned int slot = iter->folioq_slot;
-	ssize_t ret = 0;
-	size_t offset = iter->iov_offset;
-
-	BUG_ON(!folioq);
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		if (WARN_ON_ONCE(!folioq))
-			return 0;
-		slot = 0;
-	}
-
-	do {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t fsize = folioq_folio_size(folioq, slot);
-
-		if (offset < fsize) {
-			size_t part = umin(maxsize - ret, fsize - offset);
-
-			sg_set_page(sg, folio_page(folio, 0), part, offset);
-			sgtable->nents++;
-			sg++;
-			sg_max--;
-			offset += part;
-			ret += part;
-		}
-
-		if (offset >= fsize) {
-			offset = 0;
-			slot++;
-			if (slot >= folioq_nr_slots(folioq)) {
-				if (!folioq->next) {
-					WARN_ON_ONCE(ret < iter->count);
-					break;
-				}
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	} while (sg_max > 0 && ret < maxsize);
-
-	iter->folioq = folioq;
-	iter->folioq_slot = slot;
-	iter->iov_offset = offset;
-	iter->count -= ret;
-	return ret;
-}
-
 /*
  * Extract up to sg_max folios from an BVECQ-type iterator and add them to
  * the scatterlist.  The pages are not pinned.
@@ -1452,7 +1390,7 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
  * addition of @sg_max elements.
  *
  * The pages referred to by UBUF- and IOVEC-type iterators are extracted and
- * pinned; BVEC-, KVEC-, FOLIOQ- and XARRAY-type are extracted but aren't
+ * pinned; BVEC-, KVEC-, BVECQ- and XARRAY-type are extracted but aren't
  * pinned; DISCARD-type is not supported.
  *
  * No end mark is placed on the scatterlist; that's left to the caller.
@@ -1485,9 +1423,6 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 	case ITER_KVEC:
 		return extract_kvec_to_sg(iter, maxsize, sgtable, sg_max,
 					  extraction_flags);
-	case ITER_FOLIOQ:
-		return extract_folioq_to_sg(iter, maxsize, sgtable, sg_max,
-					    extraction_flags);
 	case ITER_BVECQ:
 		return extract_bvecq_to_sg(iter, maxsize, sgtable, sg_max,
 					   extraction_flags);
diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index 644a1b9eb2d3..7ab915f77732 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
-#include <linux/folio_queue.h>
 #include <kunit/test.h>
 
 MODULE_DESCRIPTION("iov_iter testing");
@@ -363,179 +362,6 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
-static void iov_kunit_destroy_folioq(void *data)
-{
-	struct folio_queue *folioq, *next;
-
-	for (folioq = data; folioq; folioq = next) {
-		next = folioq->next;
-		for (int i = 0; i < folioq_nr_slots(folioq); i++)
-			if (folioq_folio(folioq, i))
-				folio_put(folioq_folio(folioq, i));
-		kfree(folioq);
-	}
-}
-
-static void __init iov_kunit_load_folioq(struct kunit *test,
-					struct iov_iter *iter, int dir,
-					struct folio_queue *folioq,
-					struct page **pages, size_t npages)
-{
-	struct folio_queue *p = folioq;
-	size_t size = 0;
-	int i;
-
-	for (i = 0; i < npages; i++) {
-		if (folioq_full(p)) {
-			p->next = kzalloc_obj(struct folio_queue);
-			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p->next);
-			folioq_init(p->next, 0);
-			p->next->prev = p;
-			p = p->next;
-		}
-		folioq_append(p, page_folio(pages[i]));
-		size += PAGE_SIZE;
-	}
-	iov_iter_folio_queue(iter, dir, folioq, 0, 0, size);
-}
-
-static struct folio_queue *iov_kunit_create_folioq(struct kunit *test)
-{
-	struct folio_queue *folioq;
-
-	folioq = kzalloc_obj(struct folio_queue);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, folioq);
-	kunit_add_action_or_reset(test, iov_kunit_destroy_folioq, folioq);
-	folioq_init(folioq, 0);
-	return folioq;
-}
-
-/*
- * Test copying to a ITER_FOLIOQ-type iterator.
- */
-static void __init iov_kunit_copy_to_folioq(struct kunit *test)
-{
-	const struct kvec_test_range *pr;
-	struct iov_iter iter;
-	struct folio_queue *folioq;
-	struct page **spages, **bpages;
-	u8 *scratch, *buffer;
-	size_t bufsize, npages, size, copied;
-	int i, patt;
-
-	bufsize = 0x100000;
-	npages = bufsize / PAGE_SIZE;
-
-	folioq = iov_kunit_create_folioq(test);
-
-	scratch = iov_kunit_create_buffer(test, &spages, npages);
-	for (i = 0; i < bufsize; i++)
-		scratch[i] = pattern(i);
-
-	buffer = iov_kunit_create_buffer(test, &bpages, npages);
-	memset(buffer, 0, bufsize);
-
-	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
-
-	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		size = pr->to - pr->from;
-		KUNIT_ASSERT_LE(test, pr->to, bufsize);
-
-		iov_iter_folio_queue(&iter, READ, folioq, 0, 0, pr->to);
-		iov_iter_advance(&iter, pr->from);
-		copied = copy_to_iter(scratch + i, size, &iter);
-
-		KUNIT_EXPECT_EQ(test, copied, size);
-		KUNIT_EXPECT_EQ(test, iter.count, 0);
-		KUNIT_EXPECT_EQ(test, iter.iov_offset, pr->to % PAGE_SIZE);
-		i += size;
-		if (test->status == KUNIT_FAILURE)
-			goto stop;
-	}
-
-	/* Build the expected image in the scratch buffer. */
-	patt = 0;
-	memset(scratch, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
-		for (i = pr->from; i < pr->to; i++)
-			scratch[i] = pattern(patt++);
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
-stop:
-	KUNIT_SUCCEED(test);
-}
-
-/*
- * Test copying from a ITER_FOLIOQ-type iterator.
- */
-static void __init iov_kunit_copy_from_folioq(struct kunit *test)
-{
-	const struct kvec_test_range *pr;
-	struct iov_iter iter;
-	struct folio_queue *folioq;
-	struct page **spages, **bpages;
-	u8 *scratch, *buffer;
-	size_t bufsize, npages, size, copied;
-	int i, j;
-
-	bufsize = 0x100000;
-	npages = bufsize / PAGE_SIZE;
-
-	folioq = iov_kunit_create_folioq(test);
-
-	buffer = iov_kunit_create_buffer(test, &bpages, npages);
-	for (i = 0; i < bufsize; i++)
-		buffer[i] = pattern(i);
-
-	scratch = iov_kunit_create_buffer(test, &spages, npages);
-	memset(scratch, 0, bufsize);
-
-	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
-
-	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		size = pr->to - pr->from;
-		KUNIT_ASSERT_LE(test, pr->to, bufsize);
-
-		iov_iter_folio_queue(&iter, WRITE, folioq, 0, 0, pr->to);
-		iov_iter_advance(&iter, pr->from);
-		copied = copy_from_iter(scratch + i, size, &iter);
-
-		KUNIT_EXPECT_EQ(test, copied, size);
-		KUNIT_EXPECT_EQ(test, iter.count, 0);
-		KUNIT_EXPECT_EQ(test, iter.iov_offset, pr->to % PAGE_SIZE);
-		i += size;
-	}
-
-	/* Build the expected image in the main buffer. */
-	i = 0;
-	memset(buffer, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(j);
-			if (i >= bufsize)
-				goto stop;
-		}
-	}
-stop:
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
-	KUNIT_SUCCEED(test);
-}
-
 static void iov_kunit_destroy_bvecq(void *data)
 {
 	struct bvecq *bq, *next;
@@ -1028,85 +854,6 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
-/*
- * Test the extraction of ITER_FOLIOQ-type iterators.
- */
-static void __init iov_kunit_extract_pages_folioq(struct kunit *test)
-{
-	const struct kvec_test_range *pr;
-	struct folio_queue *folioq;
-	struct iov_iter iter;
-	struct page **bpages, *pagelist[8], **pages = pagelist;
-	ssize_t len;
-	size_t bufsize, size = 0, npages;
-	int i, from;
-
-	bufsize = 0x100000;
-	npages = bufsize / PAGE_SIZE;
-
-	folioq = iov_kunit_create_folioq(test);
-
-	iov_kunit_create_buffer(test, &bpages, npages);
-	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
-
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		from = pr->from;
-		size = pr->to - from;
-		KUNIT_ASSERT_LE(test, pr->to, bufsize);
-
-		iov_iter_folio_queue(&iter, WRITE, folioq, 0, 0, pr->to);
-		iov_iter_advance(&iter, from);
-
-		do {
-			size_t offset0 = LONG_MAX;
-
-			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-				pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
-
-			len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
-						     ARRAY_SIZE(pagelist), 0, &offset0);
-			KUNIT_EXPECT_GE(test, len, 0);
-			if (len < 0)
-				break;
-			KUNIT_EXPECT_LE(test, len, size);
-			KUNIT_EXPECT_EQ(test, iter.count, size - len);
-			if (len == 0)
-				break;
-			size -= len;
-			KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
-			KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
-
-			for (i = 0; i < ARRAY_SIZE(pagelist); i++) {
-				struct page *p;
-				ssize_t part = min_t(ssize_t, len, PAGE_SIZE - offset0);
-				int ix;
-
-				KUNIT_ASSERT_GE(test, part, 0);
-				ix = from / PAGE_SIZE;
-				KUNIT_ASSERT_LT(test, ix, npages);
-				p = bpages[ix];
-				KUNIT_EXPECT_PTR_EQ(test, pagelist[i], p);
-				KUNIT_EXPECT_EQ(test, offset0, from % PAGE_SIZE);
-				from += part;
-				len -= part;
-				KUNIT_ASSERT_GE(test, len, 0);
-				if (len == 0)
-					break;
-				offset0 = 0;
-			}
-
-			if (test->status == KUNIT_FAILURE)
-				goto stop;
-		} while (iov_iter_count(&iter) > 0);
-
-		KUNIT_EXPECT_EQ(test, size, 0);
-		KUNIT_EXPECT_EQ(test, iter.count, 0);
-	}
-
-stop:
-	KUNIT_SUCCEED(test);
-}
-
 /*
  * Test the extraction of ITER_XARRAY-type iterators.
  */
@@ -1191,15 +938,12 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
 	KUNIT_CASE(iov_kunit_copy_to_bvec),
 	KUNIT_CASE(iov_kunit_copy_from_bvec),
-	KUNIT_CASE(iov_kunit_copy_to_folioq),
-	KUNIT_CASE(iov_kunit_copy_from_folioq),
 	KUNIT_CASE(iov_kunit_copy_to_bvecq),
 	KUNIT_CASE(iov_kunit_copy_from_bvecq),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
-	KUNIT_CASE(iov_kunit_extract_pages_folioq),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
 	{}
 };


