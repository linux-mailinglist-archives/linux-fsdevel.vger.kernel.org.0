Return-Path: <linux-fsdevel+bounces-43879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8EA5EE03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68224189D664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3493B260A58;
	Thu, 13 Mar 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEUDXEFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648341C6A;
	Thu, 13 Mar 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854508; cv=none; b=KwbqC8y5uiN5oc9HhJAaWF70wGy0KVWi9+ZB7xhuRg4+LEw6++qMTN5EWj44WuO6dcNO0eTgqNqnZmz5WQadZm9Vm1Wu/K/gAFseSio2QD5yOdxAbm3clUMZmlZdGMKwtj5FNC3Z6/KoZ6d+fCoSlSUssGyex+0ROoMtu2CRJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854508; c=relaxed/simple;
	bh=DvWuJfjmgUQumFhUBPHmnLuk6AHmzJ+//r0q3UIu1GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUglwr6dzKfXM82bMtkrOtqJPy1JPjrY/lsAZUqZGIKlHwWszmwUsB5l3j6QdXEdRaJNvN/DFeWB475y3S79Z3cJvpcimgFAakP1qclmoc032Dr6xI2fsVuzdLhDvRFJpYSk1Zu9+Da7EDTVRaDNo8+z6OYgu6BoX0rrdPd6vII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SEUDXEFx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b6KNOVUaxcdWmu5AUMxEucEw+/70bLXDtl+S2Y1dcw4=; b=SEUDXEFxiKYfgm29hwsFR0WbAu
	mnGn6iiaAQnulG5cZEuxZgQ1FT5vpPdqDp4Ubpb38wR5STF09c36/syvn8Z1Fed4dreLRAL5CYbCS
	q2ELCEAiqQEbVErDRX1x9nLSlJEHgchoK9nbI0SfvMNhYU4XLSDYB9/LAOlGqINdqeezSp9hXsuJi
	cVH95iWgTsBhruVXTsZFzybs6jewNoez+ltvda7A5LX9TQSMISpvhyzswpx3jI2FRon4isJDkX3K9
	nNASYT/uh/W9m1rYJsrwI0euP1mfe68Oai4vSRoRmXmemmPEYcXfaWWXQdhD0prU5cD1SLMAu6J7+
	YGiXEFhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdvW-0000000AY5G-0RFl;
	Thu, 13 Mar 2025 08:28:26 +0000
Date: Thu, 13 Mar 2025 01:28:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Message-ID: <Z9KXKolrBObAlL8y@infradead.org>
References: <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org>
 <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
 <Z9KC7UHOutY61C5K@infradead.org>
 <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
 <Z9KOItsOJykGzI-F@infradead.org>
 <157f42f1-1bad-4320-b708-2397ab773e34@oracle.com>
 <Z9KSsxIkUbEx5y2L@infradead.org>
 <Z9KU0gJwSW8IdPH2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9KU0gJwSW8IdPH2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 01:18:26AM -0700, Christoph Hellwig wrote:
> Something like this (untestested):

In fact this can be further simplified, as the clearing of
IOMAP_DIO_CALLER_COMP has duplicate logic, and only applies to writes.

So something like this would do even better:

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5299f70428ef..e9b03b9dae9e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -312,27 +312,20 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 }
 
 /*
- * Figure out the bio's operation flags from the dio request, the
- * mapping, and whether or not we want FUA.  Note that we can end up
- * clearing the WRITE_THROUGH flag in the dio request.
+ * Use a FUA write if we need datasync semantics and this is a pure data I/O
+ * that doesn't require any metadata updates (including after I/O completion
+ * such as unwritten extent conversion) and the underlying device either
+ * doesn't have a volatile write cache or supports FUA.
+ * This allows us to avoid cache flushes on I/O completion.
  */
-static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic_hw)
+static inline bool iomap_dio_can_use_fua(const struct iomap *iomap,
+		struct iomap_dio *dio)
 {
-	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
-
-	if (!(dio->flags & IOMAP_DIO_WRITE))
-		return REQ_OP_READ;
-
-	opflags |= REQ_OP_WRITE;
-	if (use_fua)
-		opflags |= REQ_FUA;
-	else
-		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic_hw)
-		opflags |= REQ_ATOMIC;
-
-	return opflags;
+	if (iomap->flags & (IOMAP_F_SHARED | IOMAP_F_DIRTY))
+		return false;
+	if (!(dio->flags & IOMAP_DIO_WRITE_THROUGH))
+		return false;
+	return !bdev_write_cache(iomap->bdev) || bdev_fua(iomap->bdev);
 }
 
 static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
@@ -340,52 +333,59 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
 	const loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
-	blk_opf_t bio_opf;
+	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 	bool need_zeroout = false;
-	bool use_fua = false;
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 
-	if (atomic_hw && length != iter->len)
-		return -EINVAL;
-
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
 
-	if (iomap->type == IOMAP_UNWRITTEN) {
-		dio->flags |= IOMAP_DIO_UNWRITTEN;
-		need_zeroout = true;
-	}
+	if (dio->flags & IOMAP_DIO_WRITE) {
+		bio_opf |= REQ_OP_WRITE;
+
+		if (iter->flags & IOMAP_ATOMIC_HW) {
+			if (length != iter->len)
+				return -EINVAL;
+			bio_opf |= REQ_ATOMIC;
+		}
+
+		if (iomap->type == IOMAP_UNWRITTEN) {
+			dio->flags |= IOMAP_DIO_UNWRITTEN;
+			need_zeroout = true;
+		}
 
-	if (iomap->flags & IOMAP_F_SHARED)
-		dio->flags |= IOMAP_DIO_COW;
+		if (iomap->flags & IOMAP_F_SHARED)
+			dio->flags |= IOMAP_DIO_COW;
 
-	if (iomap->flags & IOMAP_F_NEW) {
-		need_zeroout = true;
-	} else if (iomap->type == IOMAP_MAPPED) {
+		if (iomap->flags & IOMAP_F_NEW) {
+			need_zeroout = true;
+		} else if (iomap->type == IOMAP_MAPPED) {
+			if (iomap_dio_can_use_fua(iomap, dio))
+				bio_opf |= REQ_FUA;
+			else
+				dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+		}
+	
 		/*
-		 * Use a FUA write if we need datasync semantics, this is a pure
-		 * data IO that doesn't require any metadata updates (including
-		 * after IO completion such as unwritten extent conversion) and
-		 * the underlying device either supports FUA or doesn't have
-		 * a volatile write cache. This allows us to avoid cache flushes
-		 * on IO completion. If we can't use writethrough and need to
-		 * sync, disable in-task completions as dio completion will
-		 * need to call generic_write_sync() which will do a blocking
-		 * fsync / cache flush call.
+		 * We can only do deferred completion for pure overwrites that
+		 * don't require additional I/O at completion time.
+		 *
+		 * This rules out writes that need zeroing or extent conversion,
+		 * extend the file size, or issue metadata I/O or cache flushes
+		 * during completion processing.
 		 */
-		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
-			use_fua = true;
-		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
+		if (need_zeroout || (pos >= i_size_read(inode)) ||
+		    ((dio->flags & IOMAP_DIO_NEED_SYNC) &&
+		     !(bio_opf & REQ_FUA)))
 			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
+	} else {
+		bio_opf |= REQ_OP_READ;
 	}
 
 	/*
@@ -399,18 +399,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (!iov_iter_count(dio->submit.iter))
 		goto out;
 
-	/*
-	 * We can only do deferred completion for pure overwrites that
-	 * don't require additional IO at completion. This rules out
-	 * writes that need zeroing or extent conversion, extend
-	 * the file size, or issue journal IO or cache flushes
-	 * during completion processing.
-	 */
-	if (need_zeroout ||
-	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !use_fua) ||
-	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
-		dio->flags &= ~IOMAP_DIO_CALLER_COMP;
-
 	/*
 	 * The rules for polled IO completions follow the guidelines as the
 	 * ones we set for inline and deferred completions. If none of those
@@ -428,8 +416,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
-
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
@@ -461,7 +447,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic_hw && n != length)) {
+		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out

