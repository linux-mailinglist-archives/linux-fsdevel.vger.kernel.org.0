Return-Path: <linux-fsdevel+bounces-43872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A5A5EDD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C485189EC80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA6525FA2F;
	Thu, 13 Mar 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Juq+lrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2891EE013;
	Thu, 13 Mar 2025 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853909; cv=none; b=ELnfth9Bd0QmRezF6GZPHDJc4oVulhZ/dmEncpJGDATuY9TlfHlodnfC7sw+rQNOPAcRGj1PZpg8KTWPYpByMTGprlKzdv+tYPBxy8yalME8L7Blgiu7g80GzfuV8JLMrvKd55i3V2tKCzwq4I9kn6LN0T/kwIxgBCjKjhE6FoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853909; c=relaxed/simple;
	bh=g4/K6gaP0syt5iLZomYtePZjB7AKXL2MAAMEgNHrpDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGqrNRnNNmpbocqZXmVidLDHx1/HrPmyUX59ApyRwfbFtuRPk6aK9fCBonx3zDAB5Av0biRbPc74u/pN/5zjdpRw38LFnAQ8Qcz4Nm8hhFsfdVwfNr8zuzFEtTEXUlcstPzb3z+OWvn6+IVRn4ecoyvbxbHtua7FrxNjh/GZS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1Juq+lrw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jrZs9WEq341HFyjMmgmQFBq+D9rAqTMpcEFhmRVau0E=; b=1Juq+lrw4oZNjLrixt7kwDDic8
	NVzbIRyJRcEWLgJJgFS5G0UIgWSMXgPtr9k7FeWC3YDfWNYqG8N3K18nnN4GabV4lVqZT9YlQNxiW
	MOjts7PWj5gjckNu8RdmP8JPg5UIs+J684//tiZYUvKzIB9VtrFrpWJv/gdKsnnsj7e2/CqXxH5Cd
	Q7w4yvg+WnHKOb56+MaGreClDxvPp9kKEWpGb5sV1rQyegallky4pa7KcYHa6cVRAWjMD8nW4kOwj
	GK9CN8LH8kajoG6DHWtIbYKRvNeUSFohMTd3WchpG7WP8xh65TZxe5riQWpLcdxiXROVInAD3MR8H
	DAg8ztWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdlq-0000000AWY3-3EZm;
	Thu, 13 Mar 2025 08:18:26 +0000
Date: Thu, 13 Mar 2025 01:18:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Message-ID: <Z9KU0gJwSW8IdPH2@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org>
 <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
 <Z9KC7UHOutY61C5K@infradead.org>
 <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
 <Z9KOItsOJykGzI-F@infradead.org>
 <157f42f1-1bad-4320-b708-2397ab773e34@oracle.com>
 <Z9KSsxIkUbEx5y2L@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9KSsxIkUbEx5y2L@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Something like this (untestested):

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5299f70428ef..3fa21445906a 100644
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
@@ -343,49 +336,53 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
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
+		if (atomic_hw) {
+			if (length != iter->len)
+				return -EINVAL;
+			bio_opf |= REQ_ATOMIC;
+		}
 
-	if (iomap->flags & IOMAP_F_SHARED)
-		dio->flags |= IOMAP_DIO_COW;
+		if (iomap->type == IOMAP_UNWRITTEN) {
+			dio->flags |= IOMAP_DIO_UNWRITTEN;
+			need_zeroout = true;
+		}
 
-	if (iomap->flags & IOMAP_F_NEW) {
-		need_zeroout = true;
-	} else if (iomap->type == IOMAP_MAPPED) {
-		/*
-		 * Use a FUA write if we need datasync semantics, this is a pure
-		 * data IO that doesn't require any metadata updates (including
-		 * after IO completion such as unwritten extent conversion) and
-		 * the underlying device either supports FUA or doesn't have
-		 * a volatile write cache. This allows us to avoid cache flushes
-		 * on IO completion. If we can't use writethrough and need to
-		 * sync, disable in-task completions as dio completion will
-		 * need to call generic_write_sync() which will do a blocking
-		 * fsync / cache flush call.
-		 */
-		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
-			use_fua = true;
-		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
-			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
+		if (iomap->flags & IOMAP_F_SHARED)
+			dio->flags |= IOMAP_DIO_COW;
+
+		if (iomap->flags & IOMAP_F_NEW) {
+			need_zeroout = true;
+		} else if (iomap->type == IOMAP_MAPPED) {
+			if (iomap_dio_can_use_fua(iomap, dio)) {
+				bio_opf |= REQ_FUA;
+			} else {
+				dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+				/*
+				 * Disable in-task completions if we can't use
+				 * writethrough and need to sync as the I/O
+				 * completion handler has to force a (blocking)
+				 * cache flush.
+				 */
+				if (dio->flags & IOMAP_DIO_NEED_SYNC)
+					dio->flags &= ~IOMAP_DIO_CALLER_COMP;
+			}
+		}
+	} else {
+		bio_opf |= REQ_OP_READ;
 	}
 
 	/*
@@ -407,7 +404,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	 * during completion processing.
 	 */
 	if (need_zeroout ||
-	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !use_fua) ||
+	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !(bio_opf & REQ_FUA)) ||
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
 		dio->flags &= ~IOMAP_DIO_CALLER_COMP;
 
@@ -428,8 +425,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
-
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;

