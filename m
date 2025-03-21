Return-Path: <linux-fsdevel+bounces-44722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9535BA6BF6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5113B8464
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582922D4E9;
	Fri, 21 Mar 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwAAoJ3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640122B8BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573672; cv=none; b=Z0RuYkQmZoiogOvfcIqTR4ys4pvq3j06Hl0q2XkMyNO3M065I0smSq+DG6v+C0FL0rkzeiK+jmVv8LDiS7mvjiMuQRVMAJPamxacd1WIvlly1rwkHQfGG9eBsS0Y2PxyeZwc1YuCH8qcMCuDXUCX834N0gGNFc1i1lTsiveusOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573672; c=relaxed/simple;
	bh=l2b1GcwPJAEPhOwxBQ1cF95qrnUO7ROHoDw/IdBu/Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAdiWRyJ63lz8eMWTlge3wiv6tXf8bGMHJIuU2SUgzkfp+GAUD/0jTtgBd7MKRHWanBA7i8isjzl17zsJ2zsMA1tAHpd3SPH11Tw6hLLTVg3erakkiTajekh4dVWO5smMHPvZuDMhCGKBSe7961C3ilW1v1ghTqOk1pHoYBUmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwAAoJ3z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNZpwpQRDsQTXPWBbnZ/kr6+Jl8CRL/WggEaD7n3AVo=;
	b=FwAAoJ3zaLEAQ2HP+gli8gYtUvqiOagWljh6dxU3Vex9/0h4TWlqoT/c1pKVinnaN8Vj/7
	7xHtXhUK8COobbdZ4sIJVn/dZWzG9BO214hMHMXax6IeEYDZLLSgExJwOx4KDpFej7lwDX
	HlZ3B5GGycY4TZfX8MGKZjz3sX5rhLY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-JD6l5jh6OGyM8ciJnzstOA-1; Fri,
 21 Mar 2025 12:14:26 -0400
X-MC-Unique: JD6l5jh6OGyM8ciJnzstOA-1
X-Mimecast-MFC-AGG-ID: JD6l5jh6OGyM8ciJnzstOA_1742573665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A39031809CA5;
	Fri, 21 Mar 2025 16:14:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FA2B19373C4;
	Fri, 21 Mar 2025 16:14:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [RFC PATCH 2/4] iov_iter: Add an iterator-of-iterators
Date: Fri, 21 Mar 2025 16:14:02 +0000
Message-ID: <20250321161407.3333724-3-dhowells@redhat.com>
In-Reply-To: <20250321161407.3333724-1-dhowells@redhat.com>
References: <20250321161407.3333724-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new I/O iterator type, ITER_ITERLIST, that allows iteration over a
series of I/O iterators, provided the iterators are all the same direction
(all ITER_SOURCE or all ITER_DEST) and none of them are themselves
ITER_ITERLIST (this function is recursive).

To make reversion possible, I've added an 'orig_count' member into the
iov_iter struct so that reversion of an ITER_ITERLIST can know when to go
move backwards through the iter list.  It might make more sense to make the
iterator list element, say:

	struct itervec {
		struct iov_iter iter;
		size_t orig_count;
	};

rather than expanding struct iov_iter itself and have iov_iter_iterlist()
set vec[i].orig_count from vec[i].iter->count.

Also, for the moment, I've only permitted its use with source iterators
(eg. sendmsg).

To use this, you allocate an array of iterators and point the list iterator
at it, e.g.:

	struct iov_iter iters[3];
	struct msghdr msg;

	iov_iter_bvec(&iters[0], ITER_SOURCE, &head_bv, 1,
		      sizeof(marker) + head->iov_len);
	iov_iter_xarray(&iters[1], ITER_SOURCE, xdr->pages,
			xdr->page_fpos, xdr->page_len);
	iov_iter_kvec(&iters[2], ITER_SOURCE, &tail_kv, 1,
		      tail->iov_len);
	iov_iter_iterlist(&msg.msg_iter, ITER_SOURCE, iters, 3, size);

This can be used by network filesystem protocols, such as sunrpc, to glue a
header and a trailer on to some data to form a message and then dump the
entire message onto the socket in a single go.

[!] Note: I'm not entirely sure that this is a good idea: the problem is
    that it's reasonably common practice to copy an iterator by direct
    assignment - and that works for the existing iterators... but not this
    one.  With the iterator-of-iterators, the list of iterators has to be
    modified if we recurse.  It's probably fine just for calling sendmsg()
    from network filesystems, but I'm not 100% sure of that.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/uio.h |  15 +++++
 lib/iov_iter.c      | 158 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 8ada84e85447..59a586333e1b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,6 +29,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_ITERLIST,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +72,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct iov_iterlist *iterlist;
 			};
 			size_t count;
 		};
@@ -82,6 +84,11 @@ struct iov_iter {
 	};
 };
 
+struct iov_iterlist {
+	struct iov_iter	iter;
+	size_t		orig_count;
+};
+
 typedef __u16 uio_meta_flags_t;
 
 struct uio_meta {
@@ -149,6 +156,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_iterlist(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_ITERLIST;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -302,6 +314,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_iterlist(struct iov_iter *i, unsigned int direction,
+		       struct iov_iterlist *iterlist, unsigned long nr_segs,
+		       size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 33a8746e593e..1d9190abfeb5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -578,6 +578,19 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_folioq_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
 		i->count -= size;
+	} else if (iov_iter_is_iterlist(i)) {
+		i->count -= size;
+		for (;;) {
+			size_t part = umin(size, i->iterlist->iter.count);
+
+			if (part > 0)
+				iov_iter_advance(&i->iterlist->iter, part);
+			size -= part;
+			if (!size)
+				break;
+			i->iterlist++;
+			i->nr_segs--;
+		}
 	}
 }
 EXPORT_SYMBOL(iov_iter_advance);
@@ -608,6 +621,23 @@ static void iov_iter_folioq_revert(struct iov_iter *i, size_t unroll)
 	i->folioq = folioq;
 }
 
+static void iov_iter_revert_iterlist(struct iov_iter *i, size_t unroll)
+{
+	for (;;) {
+		struct iov_iterlist *il = i->iterlist;
+
+		size_t part = umin(unroll, il->orig_count - il->iter.count);
+
+		if (part > 0)
+			iov_iter_revert(&il->iter, part);
+		unroll -= part;
+		if (!unroll)
+			break;
+		i->iterlist--;
+		i->nr_segs++;
+	}
+}
+
 void iov_iter_revert(struct iov_iter *i, size_t unroll)
 {
 	if (!unroll)
@@ -617,6 +647,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	i->count += unroll;
 	if (unlikely(iov_iter_is_discard(i)))
 		return;
+	if (unlikely(iov_iter_is_iterlist(i)))
+		return iov_iter_revert_iterlist(i, unroll);
 	if (unroll <= i->iov_offset) {
 		i->iov_offset -= unroll;
 		return;
@@ -663,6 +695,8 @@ EXPORT_SYMBOL(iov_iter_revert);
  */
 size_t iov_iter_single_seg_count(const struct iov_iter *i)
 {
+	if (iov_iter_is_iterlist(i))
+		i = &i->iterlist->iter;
 	if (i->nr_segs > 1) {
 		if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
 			return min(i->count, iter_iov(i)->iov_len - i->iov_offset);
@@ -787,6 +821,41 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
+/**
+ * iov_iter_iterlist - Initialise an I/O iterator that is a list of iterators
+ * @iter: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @iterlist: The list of iterators
+ * @nr_segs: The number of elements in the list
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator that walks over an array of other iterators.  It's
+ * only available as a source iterator (for WRITE) and none of the iterators in
+ * the array can be of ITER_ITERLIST type to prevent infinite recursion.
+ */
+void iov_iter_iterlist(struct iov_iter *iter, unsigned int direction,
+		       struct iov_iterlist *iterlist, unsigned long nr_segs,
+		       size_t count)
+{
+	unsigned long i;
+
+	BUG_ON(direction != WRITE);
+	for (i = 0; i < nr_segs; i++) {
+		BUG_ON(iterlist[i].iter.iter_type == ITER_ITERLIST);
+		BUG_ON(iterlist[i].iter.data_source != direction);
+		iterlist[i].orig_count = iterlist[i].iter.count;
+	}
+
+	*iter = (struct iov_iter){
+		.iter_type	= ITER_ITERLIST,
+		.data_source	= true,
+		.count		= count,
+		.iterlist	= iterlist,
+		.nr_segs	= nr_segs,
+	};
+}
+EXPORT_SYMBOL(iov_iter_iterlist);
+
 static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 				   unsigned len_mask)
 {
@@ -947,6 +1016,15 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
 
+	if (iov_iter_is_iterlist(i)) {
+		unsigned long align = 0;
+		unsigned int j;
+
+		for (j = 0; j < i->nr_segs; j++)
+			align |= iov_iter_alignment(&i->iterlist[j].iter);
+		return align;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(iov_iter_alignment);
@@ -1206,6 +1284,18 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		return iter_folioq_get_pages(i, pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
+	if (iov_iter_is_iterlist(i)) {
+		ssize_t size;
+
+		while (!i->iterlist->iter.count) {
+			i->iterlist++;
+			i->nr_segs--;
+		}
+		size = __iov_iter_get_pages_alloc(&i->iterlist->iter,
+						  pages, maxsize, maxpages, start);
+		i->count -= size;
+		return size;
+	}
 	return -EFAULT;
 }
 
@@ -1274,6 +1364,21 @@ static int bvec_npages(const struct iov_iter *i, int maxpages)
 	return npages;
 }
 
+static int iterlist_npages(const struct iov_iter *i, int maxpages)
+{
+	const struct iov_iterlist *p;
+	ssize_t size = i->count;
+	int npages = 0;
+
+	for (p = i->iterlist; size; p++) {
+		size -= p->iter.count;
+		npages += iov_iter_npages(&p->iter, maxpages - npages);
+		if (unlikely(npages >= maxpages))
+			return maxpages;
+	}
+	return npages;
+}
+
 int iov_iter_npages(const struct iov_iter *i, int maxpages)
 {
 	if (unlikely(!i->count))
@@ -1298,6 +1403,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
 		return min(npages, maxpages);
 	}
+	if (iov_iter_is_iterlist(i))
+		return iterlist_npages(i, maxpages);
 	return 0;
 }
 EXPORT_SYMBOL(iov_iter_npages);
@@ -1309,11 +1416,14 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 		return new->bvec = kmemdup(new->bvec,
 				    new->nr_segs * sizeof(struct bio_vec),
 				    flags);
-	else if (iov_iter_is_kvec(new) || iter_is_iovec(new))
+	if (iov_iter_is_kvec(new) || iter_is_iovec(new))
 		/* iovec and kvec have identical layout */
 		return new->__iov = kmemdup(new->__iov,
 				   new->nr_segs * sizeof(struct iovec),
 				   flags);
+	if (WARN_ON_ONCE(iov_iter_is_iterlist(old)))
+		/* Don't allow dup'ing of iterlist as the cleanup is complicated */
+		return NULL;
 	return NULL;
 }
 EXPORT_SYMBOL(dup_iter);
@@ -1924,6 +2034,23 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_xarray_pages(i, pages, maxsize,
 						     maxpages, extraction_flags,
 						     offset0);
+	if (iov_iter_is_iterlist(i)) {
+		ssize_t size;
+
+		while (i->nr_segs && !i->iterlist->iter.count) {
+			i->iterlist++;
+			i->nr_segs--;
+		}
+		if (!i->nr_segs) {
+			WARN_ON_ONCE(i->count);
+			return 0;
+		}
+		size = iov_iter_extract_pages(&i->iterlist->iter,
+					      pages, maxsize, maxpages,
+					      extraction_flags, offset0);
+		i->count -= size;
+		return size;
+	}
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
@@ -1994,6 +2121,33 @@ size_t iterate_discard(struct iov_iter *iter, size_t len, void *priv, void *priv
 	return progress;
 }
 
+/*
+ * Handle iteration over ITER_ITERLIST.
+ */
+static size_t iterate_iterlist(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+			       iov_ustep_f ustep, iov_step_f step)
+{
+	struct iov_iterlist *p = iter->iterlist;
+	size_t progress = 0;
+
+	do {
+		size_t consumed;
+
+		consumed = iterate_and_advance2(&p->iter, len, priv, priv2, ustep, step);
+
+		len -= consumed;
+		progress += consumed;
+		if (p->iter.count)
+			break;
+		p++;
+	} while (len);
+
+	iter->nr_segs -= p - iter->iterlist;
+	iter->iterlist = p;
+	iter->count -= progress;
+	return progress;
+}
+
 /*
  * Out of line iteration for iterator types that don't need such fast handling.
  */
@@ -2004,6 +2158,8 @@ size_t __iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_discard(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
+	if (iov_iter_is_iterlist(iter))
+		return iterate_iterlist(iter, len, priv, priv2, ustep, step);
 	WARN_ON(1);
 	return 0;
 }


