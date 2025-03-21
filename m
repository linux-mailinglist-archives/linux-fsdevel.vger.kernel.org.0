Return-Path: <linux-fsdevel+bounces-44723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F7A6BF6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8276A17D89F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE122D7A2;
	Fri, 21 Mar 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJRPsn4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92822D791
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573679; cv=none; b=I4gctieaBuTdD8/gsBC8qC/uoFoX9j/xBVtgycpqnJ0XXK9lKD7tOkbBHhr/hgpUcyvE8aV7NdQsNlyovJkBaRr6VQ5oIrYpwhFzDAe4FqJT7RPn144i8papeLnCx/v1nbwypdLt3iLcOALQn6ich+k4xS6eewO3fIQdRcNJQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573679; c=relaxed/simple;
	bh=GqaOwhB3Z9lrdXIil/wS6IEs78AoHI886w0ijBcF1Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/tCnuxCWBaDzyC2fmE87fiQQfzw85cuWoPUGxLujEs6p5xr6nTyaLZ9YWj/m3vvFR6j5zd7Cs+6cJ3suJeTXL5dtVQUaOclKCWfJAfrGHndGmPv1LOiKrlBRni+y9Ac2iFq6Jwz+BACJleL1XtjnayMpK2YndxdpNFagfJzMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJRPsn4Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO8vXcEEPHEwzKEymAYWWkxy3bveqdMiRNK7ViMq3/8=;
	b=SJRPsn4YJCCJUBS+WXq9nbZi2jcga9AUOxc4XHXjoLIY798b4Q0O52dFg8iwlmo5L06Np4
	BE2De9Y8tLqVWRd4t4JcEW/ftvBG5Pz1AvSGe5ESYdGWu4PxUsF9A5RFYzuyDFSD76WSqz
	XkhpcCZxrkZP4z9dJWqYC1FomXsUE/s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-J_hiXevqOZKYdauQ2n8oLw-1; Fri,
 21 Mar 2025 12:14:31 -0400
X-MC-Unique: J_hiXevqOZKYdauQ2n8oLw-1
X-Mimecast-MFC-AGG-ID: J_hiXevqOZKYdauQ2n8oLw_1742573670
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B541903081;
	Fri, 21 Mar 2025 16:14:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 075461955BFE;
	Fri, 21 Mar 2025 16:14:25 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] iov_iter: Add a scatterlist iterator type
Date: Fri, 21 Mar 2025 16:14:03 +0000
Message-ID: <20250321161407.3333724-4-dhowells@redhat.com>
In-Reply-To: <20250321161407.3333724-1-dhowells@redhat.com>
References: <20250321161407.3333724-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add an iterator type that can iterate over a scatterlist.  This can be used
as a bridge to help convert things that take scatterlists into things that
take I/O iterators.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/uio.h |  12 ++
 lib/iov_iter.c      | 315 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 321 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 59a586333e1b..0e50f4af6877 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -12,6 +12,7 @@
 
 struct page;
 struct folio_queue;
+struct scatterlist;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -30,6 +31,7 @@ enum iter_type {
 	ITER_XARRAY,
 	ITER_DISCARD,
 	ITER_ITERLIST,
+	ITER_SCATTERLIST,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -46,6 +48,7 @@ struct iov_iter {
 	bool nofault;
 	bool data_source;
 	size_t iov_offset;
+	size_t orig_count;
 	/*
 	 * Hack alert: overlay ubuf_iovec with iovec + count, so
 	 * that the members resolve correctly regardless of the type
@@ -73,11 +76,13 @@ struct iov_iter {
 				struct xarray *xarray;
 				void __user *ubuf;
 				struct iov_iterlist *iterlist;
+				struct scatterlist *sglist;
 			};
 			size_t count;
 		};
 	};
 	union {
+		struct scatterlist *sglist_head;
 		unsigned long nr_segs;
 		u8 folioq_slot;
 		loff_t xarray_start;
@@ -161,6 +166,11 @@ static inline bool iov_iter_is_iterlist(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_ITERLIST;
 }
 
+static inline bool iov_iter_is_scatterlist(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_SCATTERLIST;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -317,6 +327,8 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *
 void iov_iter_iterlist(struct iov_iter *i, unsigned int direction,
 		       struct iov_iterlist *iterlist, unsigned long nr_segs,
 		       size_t count);
+void iov_iter_scatterlist(struct iov_iter *i, unsigned int direction,
+			  struct scatterlist *sglist, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1d9190abfeb5..ed9859af3c5d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -562,6 +562,26 @@ static void iov_iter_folioq_advance(struct iov_iter *i, size_t size)
 	i->folioq = folioq;
 }
 
+static void iov_iter_scatterlist_advance(struct iov_iter *i, size_t size)
+{
+	struct scatterlist *sg;
+
+	if (!i->count)
+		return;
+	i->count -= size;
+
+	size += i->iov_offset;
+
+	for (sg = i->sglist; sg; sg_next(sg)) {
+		if (likely(size < sg->length))
+			break;
+		size -= sg->length;
+	}
+	WARN_ON(!sg && size > 0);
+	i->iov_offset = size;
+	i->sglist = sg;
+}
+
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
@@ -591,6 +611,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 			i->iterlist++;
 			i->nr_segs--;
 		}
+	} else if (iov_iter_is_scatterlist(i)) {
+		iov_iter_scatterlist_advance(i, size);
 	}
 }
 EXPORT_SYMBOL(iov_iter_advance);
@@ -638,6 +660,15 @@ static void iov_iter_revert_iterlist(struct iov_iter *i, size_t unroll)
 	}
 }
 
+static void iov_iter_revert_scatterlist(struct iov_iter *i)
+{
+	size_t skip = i->orig_count - i->count;
+
+	i->sglist = i->sglist_head;
+	i->count = i->orig_count;
+	iov_iter_advance(i, skip);
+}
+
 void iov_iter_revert(struct iov_iter *i, size_t unroll)
 {
 	if (!unroll)
@@ -649,6 +680,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	if (unlikely(iov_iter_is_iterlist(i)))
 		return iov_iter_revert_iterlist(i, unroll);
+	if (unlikely(iov_iter_is_scatterlist(i)))
+		return iov_iter_revert_scatterlist(i);
 	if (unroll <= i->iov_offset) {
 		i->iov_offset -= unroll;
 		return;
@@ -706,6 +739,8 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 	if (unlikely(iov_iter_is_folioq(i)))
 		return !i->count ? 0 :
 			umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
+	if (unlikely(iov_iter_is_scatterlist(i)))
+		return !i->sglist ? 0 : umin(i->count, i->sglist->length - i->iov_offset);
 	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
@@ -856,6 +891,33 @@ void iov_iter_iterlist(struct iov_iter *iter, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_iterlist);
 
+/**
+ * iov_iter_scatterlist - Initialise an I/O iterator for a scatterlist chain
+ * @iter: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @sglist: The head of the scatterlist
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator that walks over a scatterlist.  Because scatterlists
+ * can be chained and have no back pointers, reversion requires starting again
+ * at the beginning and counting forwards.
+ */
+void iov_iter_scatterlist(struct iov_iter *iter, unsigned int direction,
+			  struct scatterlist *sglist, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*iter = (struct iov_iter){
+		.iter_type	= ITER_SCATTERLIST,
+		.data_source	= direction,
+		.sglist		= sglist,
+		.sglist_head	= sglist,
+		.iov_offset	= 0,
+		.count		= count,
+		.orig_count	= count,
+	};
+}
+EXPORT_SYMBOL(iov_iter_scatterlist);
+
 static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 				   unsigned len_mask)
 {
@@ -994,6 +1056,26 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 	return res;
 }
 
+static unsigned long iov_iter_alignment_scatterlist(const struct iov_iter *i)
+{
+	struct scatterlist *sg;
+	unsigned skip = i->iov_offset;
+	unsigned res = 0;
+	size_t size = i->count;
+
+	for (sg = i->sglist; sg; sg = sg_next(sg)) {
+		size_t len = sg->length - skip;
+		res |= (unsigned long)sg->offset + skip;
+		if (len > size)
+			len = size;
+		res |= len;
+		size -= len;
+		skip = 0;
+	} while (size);
+
+	return res;
+}
+
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
 	if (likely(iter_is_ubuf(i))) {
@@ -1024,6 +1106,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 			align |= iov_iter_alignment(&i->iterlist[j].iter);
 		return align;
 	}
+	if (iov_iter_is_scatterlist(i))
+		return iov_iter_alignment_scatterlist(i);
 
 	return 0;
 }
@@ -1058,13 +1142,8 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_gap_alignment);
 
-static int want_pages_array(struct page ***res, size_t size,
-			    size_t start, unsigned int maxpages)
+static int __want_pages_array(struct page ***res, unsigned int count)
 {
-	unsigned int count = DIV_ROUND_UP(size + start, PAGE_SIZE);
-
-	if (count > maxpages)
-		count = maxpages;
 	WARN_ON(!count);	// caller should've prevented that
 	if (!*res) {
 		*res = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
@@ -1074,6 +1153,16 @@ static int want_pages_array(struct page ***res, size_t size,
 	return count;
 }
 
+static int want_pages_array(struct page ***res, size_t size,
+			    size_t start, unsigned int maxpages)
+{
+	size_t count = DIV_ROUND_UP(size + start, PAGE_SIZE);
+
+	if (count > maxpages)
+		count = maxpages;
+	return __want_pages_array(res, count);
+}
+
 static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
 				     struct page ***ppages, size_t maxsize,
 				     unsigned maxpages, size_t *_start_offset)
@@ -1186,6 +1275,52 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	return maxsize;
 }
 
+static struct page *first_scatterlist_segment(const struct iov_iter *i,
+					      size_t *size, size_t *start)
+{
+	struct scatterlist *sg = i->sglist;
+	struct page *page;
+	size_t skip = i->iov_offset, len;
+
+	if (!sg)
+		return NULL;
+
+	len = sg->length - skip;
+	if (*size > len)
+		*size = len;
+	skip += sg->offset;
+	page = sg_page(sg) + skip / PAGE_SIZE;
+	*start = skip % PAGE_SIZE;
+	return page;
+}
+
+static ssize_t iter_scatterlist_get_pages(struct iov_iter *i,
+					  struct page ***pages, size_t maxsize,
+					  unsigned maxpages, size_t *start)
+{
+	struct page **p, *page;
+	unsigned int n;
+
+	page = first_scatterlist_segment(i, &maxsize, start);
+	if (!page)
+		return -EFAULT;
+	n = want_pages_array(pages, maxsize, *start, maxpages);
+	if (!n)
+		return -ENOMEM;
+	p = *pages;
+	for (int k = 0; k < n; k++)
+		get_page(p[k] = page + k);
+	maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
+	i->count -= maxsize;
+	i->iov_offset += maxsize;
+	if (i->iov_offset == i->bvec->bv_len) {
+		i->iov_offset = 0;
+		i->bvec++;
+		i->nr_segs--;
+	}
+	return maxsize;
+}
+
 /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
 static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 {
@@ -1296,6 +1431,8 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		i->count -= size;
 		return size;
 	}
+	if (iov_iter_is_scatterlist(i))
+		return iter_scatterlist_get_pages(i, pages, maxsize, maxpages, start);
 	return -EFAULT;
 }
 
@@ -1379,6 +1516,25 @@ static int iterlist_npages(const struct iov_iter *i, int maxpages)
 	return npages;
 }
 
+static int scatterlist_npages(const struct iov_iter *i, int maxpages)
+{
+	struct scatterlist *sg;
+	size_t skip = i->iov_offset, size = i->count;
+	int npages = 0;
+
+	for (sg = i->sglist; sg && size; sg = sg_next(sg)) {
+		unsigned offs = (sg->offset + skip) % PAGE_SIZE;
+		size_t len = umin(sg->length - skip, size);
+
+		size -= len;
+		npages += DIV_ROUND_UP(offs + len, PAGE_SIZE);
+		if (unlikely(npages > maxpages))
+			return maxpages;
+		skip = 0;
+	}
+	return npages;
+}
+
 int iov_iter_npages(const struct iov_iter *i, int maxpages)
 {
 	if (unlikely(!i->count))
@@ -1405,6 +1561,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	}
 	if (iov_iter_is_iterlist(i))
 		return iterlist_npages(i, maxpages);
+	if (iov_iter_is_scatterlist(i))
+		return scatterlist_npages(i, maxpages);
 	return 0;
 }
 EXPORT_SYMBOL(iov_iter_npages);
@@ -1792,6 +1950,107 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 	return maxsize;
 }
 
+/*
+ * Count the number of virtually contiguous pages in a scatterlist iterator
+ * from the current point.
+ */
+static size_t count_scatterlist_contig_pages(const struct iov_iter *i,
+					     size_t maxpages, size_t maxsize)
+{
+	struct scatterlist *sg;
+	size_t npages = 0;
+	size_t skip = i->iov_offset, size = umin(i->count, maxsize);
+
+	for (sg = i->sglist; sg && size; sg = sg_next(sg)) {
+		size_t offs = (sg->offset + skip) % PAGE_SIZE;
+		size_t part = umin(sg->length - skip, size);
+
+		if (!part)
+			break;
+		size -= part;
+		npages += DIV_ROUND_UP(offs + part, PAGE_SIZE);
+		if (unlikely(npages > maxpages))
+			return maxpages;
+		if (((offs + part) % PAGE_SIZE) != 0)
+			break;
+		skip = 0;
+	}
+	return npages;
+}
+
+/*
+ * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
+ * not get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_scatterlist_pages(struct iov_iter *i,
+						  struct page ***pages, size_t maxsize,
+						  unsigned int maxpages,
+						  iov_iter_extraction_t extraction_flags,
+						  size_t *offset0)
+{
+	struct scatterlist *sg = i->sglist;
+	struct page **p;
+	size_t npages, skip, size = 0;
+	int nr = 0;
+
+	if (!sg)
+		return 0;
+
+	while (skip = i->iov_offset,
+	       skip == sg->length) {
+		sg = sg_next(sg);
+		i->sglist = sg;
+		i->iov_offset = 0;
+		if (!sg)
+			return 0;
+	}
+
+	npages = count_scatterlist_contig_pages(i, maxpages, maxsize);
+
+	maxpages = __want_pages_array(pages, npages);
+	if (!maxpages)
+		return -ENOMEM;
+	*offset0 = (sg->offset + skip) & ~PAGE_MASK;
+	p = *pages;
+
+	for (sg = i->sglist; sg; sg = sg_next(sg)) {
+		struct page *page = sg_page(sg);
+		size_t part = umin(sg->length - skip, maxsize);
+		size_t off = sg->offset + skip;
+
+		if (!part)
+			break;
+
+		page += off / PAGE_SIZE;
+		off %= PAGE_SIZE;
+
+		do {
+			size_t chunk = umin(part, PAGE_SIZE - off);
+
+			p[nr++] = page;
+			page++;
+			maxpages--;
+			maxsize -= chunk;
+			size += chunk;
+			skip += chunk;
+			part -= chunk;
+			off = 0;
+		} while (part && maxsize && maxpages);
+
+		if (((sg->offset + skip + part) % PAGE_SIZE) != 0)
+			break;
+		if (!maxsize || !maxpages) {
+			if (!part)
+				sg = sg_next(sg);
+			break;
+		}
+		skip = 0;
+	}
+
+	iov_iter_advance(i, size);
+	return size;
+}
+
 /*
  * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
  * This does not get references on the pages, nor does it get a pin on them.
@@ -2051,6 +2310,10 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		i->count -= size;
 		return size;
 	}
+	if (iov_iter_is_scatterlist(i))
+		return iov_iter_extract_scatterlist_pages(i, pages, maxsize,
+							  maxpages, extraction_flags,
+							  offset0);
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
@@ -2148,6 +2411,44 @@ static size_t iterate_iterlist(struct iov_iter *iter, size_t len, void *priv, vo
 	return progress;
 }
 
+/*
+ * Handle iteration over ITER_SCATTERLIST.
+ */
+static size_t iterate_scatterlist(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+				  iov_step_f step)
+{
+	struct scatterlist *sg = iter->sglist;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	do {
+		struct page *page = sg_page(sg);
+		size_t remain, consumed;
+		size_t offset = sg->offset + skip, part;
+		void *kaddr = kmap_local_page(page + offset / PAGE_SIZE);
+
+		part = min3(len,
+			   (size_t)(sg->length - skip),
+			   (size_t)(PAGE_SIZE - offset % PAGE_SIZE));
+		remain = step(kaddr + offset % PAGE_SIZE, progress, part, priv, priv2);
+		kunmap_local(kaddr);
+		consumed = part - remain;
+		len -= consumed;
+		progress += consumed;
+		skip += consumed;
+		if (skip >= sg->length) {
+			skip = 0;
+			sg = sg_next(sg);
+		}
+		if (remain)
+			break;
+	} while (len);
+
+	iter->sglist = sg;
+	iter->iov_offset = skip;
+	iter->count -= progress;
+	return progress;
+}
+
 /*
  * Out of line iteration for iterator types that don't need such fast handling.
  */
@@ -2160,6 +2461,8 @@ size_t __iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_xarray(iter, len, priv, priv2, step);
 	if (iov_iter_is_iterlist(iter))
 		return iterate_iterlist(iter, len, priv, priv2, ustep, step);
+	if (iov_iter_is_scatterlist(iter))
+		return iterate_scatterlist(iter, len, priv, priv2, step);
 	WARN_ON(1);
 	return 0;
 }


