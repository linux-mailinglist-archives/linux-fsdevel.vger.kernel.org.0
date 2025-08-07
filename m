Return-Path: <linux-fsdevel+bounces-57001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267FB1DA37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD05C3B2F00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033926A08F;
	Thu,  7 Aug 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnNc4/a7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592A265CC2
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577818; cv=none; b=ea5dD7vPsnbVSFZ7/e4Ae1NZRVd7kMSBOPZH+8r1zR+E0kJfUavx9oC/vyXz58wF0+GTqv2s9hOf4DNNHrNByVulR5QZlJDf+YHN0qBZ32c89W5v3n6ynCXOHKx0Nad4s03OuU+ZCIvdb7MExZt1ALomTh2rh8WAjdeMvPfs01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577818; c=relaxed/simple;
	bh=heNHLnyisHFn/tnvnBeLbxw+k1R7qBjYuJ+bB43Z9gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka6n0DNgNBVZMsQC5gsPH0rrUKSXZQ7iZGBSdusIxDuq1PL/cgX1Y/i84SoQHkqJwijWObU6AjG0dSMs9S2Ib92+9WMIwbnTJev2CVdV2kXTD5YIlQ83KC+Pi9IFPtiyIp9yO78Rn5BExRDjIenpxPTNRKMgI5BY4FF/+T0mJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnNc4/a7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754577816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qY7biOZG7+PCCaiuNAC9zxegZq8x+2X/aJDQ6Va10fU=;
	b=cnNc4/a7v11HSIxpO5s4MazZCjLySlAJymCgHV7lIiHjFMeP/LhO3nlQ7gdTxhh/J+ui3Z
	wCGIlFSJ+DxBNkSdRRXaM5m19siLbSZ4UFrFcjbOPWcboXVrgozh34PXvrw1KHfKevpj12
	NILdwXpVTiEsuBx1xXxU3L4V37SH6dI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-vlBoCs35OIuMC2q-41lKzw-1; Thu,
 07 Aug 2025 10:43:29 -0400
X-MC-Unique: vlBoCs35OIuMC2q-41lKzw-1
X-Mimecast-MFC-AGG-ID: vlBoCs35OIuMC2q-41lKzw_1754577807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 262E9180035D;
	Thu,  7 Aug 2025 14:43:27 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2E71180035C;
	Thu,  7 Aug 2025 14:43:25 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v4 3/7] iomap: optional zero range dirty folio processing
Date: Thu,  7 Aug 2025 10:47:06 -0400
Message-ID: <20250807144711.564137-4-bfoster@redhat.com>
In-Reply-To: <20250807144711.564137-1-bfoster@redhat.com>
References: <20250807144711.564137-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The only way zero range can currently process unwritten mappings
with dirty pagecache is to check whether the range is dirty before
mapping lookup and then flush when at least one underlying mapping
is unwritten. This ordering is required to prevent iomap lookup from
racing with folio writeback and reclaim.

Since zero range can skip ranges of unwritten mappings that are
clean in cache, this operation can be improved by allowing the
filesystem to provide a set of dirty folios that require zeroing. In
turn, rather than flush or iterate file offsets, zero range can
iterate on folios in the batch and advance over clean or uncached
ranges in between.

Add a folio_batch in struct iomap and provide a helper for
filesystems to populate the batch at lookup time. Update the folio
lookup path to return the next folio in the batch, if provided, and
advance the iter if the folio starts beyond the current offset.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 89 +++++++++++++++++++++++++++++++++++++++---
 fs/iomap/iter.c        |  6 +++
 include/linux/iomap.h  |  4 ++
 3 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 01721f10cf6e..a08a341c6f5b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -758,6 +758,28 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
+	if (iter->fbatch) {
+		struct folio *folio = folio_batch_next(iter->fbatch);
+
+		if (!folio)
+			return NULL;
+
+		/*
+		 * The folio mapping generally shouldn't have changed based on
+		 * fs locks, but be consistent with filemap lookup and retry
+		 * the iter if it does.
+		 */
+		folio_lock(folio);
+		if (unlikely(folio->mapping != iter->inode->i_mapping)) {
+			iter->iomap.flags |= IOMAP_F_STALE;
+			folio_unlock(folio);
+			return NULL;
+		}
+
+		folio_get(folio);
+		return folio;
+	}
+
 	if (write_ops && write_ops->get_folio)
 		return write_ops->get_folio(iter, pos, len);
 	return iomap_get_folio(iter, pos, len);
@@ -818,6 +840,8 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	int status = 0;
 
 	len = min_not_zero(len, *plen);
+	*foliop = NULL;
+	*plen = 0;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -826,6 +850,15 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
+	/*
+	 * No folio means we're done with a batch. We still have range to
+	 * process so return and let the caller iterate and refill the batch.
+	 */
+	if (!folio) {
+		WARN_ON_ONCE(!iter->fbatch);
+		return 0;
+	}
+
 	/*
 	 * Now we have a locked folio, before we do anything with it we need to
 	 * check that the iomap we have cached is not stale. The inode extent
@@ -846,6 +879,21 @@ static int iomap_write_begin(struct iomap_iter *iter,
 		}
 	}
 
+	/*
+	 * The folios in a batch may not be contiguous. If we've skipped
+	 * forward, advance the iter to the pos of the current folio. If the
+	 * folio starts beyond the end of the mapping, it may have been trimmed
+	 * since the lookup for whatever reason. Return a NULL folio to
+	 * terminate the op.
+	 */
+	if (folio_pos(folio) > iter->pos) {
+		len = min_t(u64, folio_pos(folio) - iter->pos,
+				 iomap_length(iter));
+		status = iomap_iter_advance(iter, &len);
+		if (status || !len)
+			goto out_unlock;
+	}
+
 	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
 
 	if (srcmap->type == IOMAP_INLINE)
@@ -1390,6 +1438,12 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
+		/* a NULL folio means we're done with a folio batch */
+		if (!folio) {
+			status = iomap_iter_advance_full(iter);
+			break;
+		}
+
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
 
@@ -1411,6 +1465,26 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	return status;
 }
 
+loff_t
+iomap_fill_dirty_folios(
+	struct iomap_iter	*iter,
+	loff_t			offset,
+	loff_t			length)
+{
+	struct address_space	*mapping = iter->inode->i_mapping;
+	pgoff_t			start = offset >> PAGE_SHIFT;
+	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
+
+	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
+	if (!iter->fbatch)
+		return offset + length;
+	folio_batch_init(iter->fbatch);
+
+	filemap_get_folios_dirty(mapping, &start, end, iter->fbatch);
+	return (start << PAGE_SHIFT);
+}
+EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
+
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops,
@@ -1440,7 +1514,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	 * flushing on partial eof zeroing, special case it to zero the
 	 * unaligned start portion if already dirty in pagecache.
 	 */
-	if (off &&
+	if (!iter.fbatch && off &&
 	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
 		iter.len = plen;
 		while ((ret = iomap_iter(&iter, ops)) > 0)
@@ -1457,13 +1531,18 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	 * if dirty and the fs returns a mapping that might convert on
 	 * writeback.
 	 */
-	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
-					iter.pos, iter.pos + iter.len - 1);
+	range_dirty = filemap_range_needs_writeback(mapping, iter.pos,
+					iter.pos + iter.len - 1);
 	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
 
-		if (srcmap->type == IOMAP_HOLE ||
-		    srcmap->type == IOMAP_UNWRITTEN) {
+		if (WARN_ON_ONCE(iter.fbatch &&
+				 srcmap->type != IOMAP_UNWRITTEN))
+			return -EIO;
+
+		if (!iter.fbatch &&
+		    (srcmap->type == IOMAP_HOLE ||
+		     srcmap->type == IOMAP_UNWRITTEN)) {
 			s64 status;
 
 			if (range_dirty) {
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index cef77ca0c20b..66ca12aac57d 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -8,6 +8,12 @@
 
 static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 {
+	if (iter->fbatch) {
+		folio_batch_release(iter->fbatch);
+		kfree(iter->fbatch);
+		iter->fbatch = NULL;
+	}
+
 	iter->status = 0;
 	memset(&iter->iomap, 0, sizeof(iter->iomap));
 	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..cd0f573156d6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/mm_types.h>
 #include <linux/blkdev.h>
+#include <linux/pagevec.h>
 
 struct address_space;
 struct fiemap_extent_info;
@@ -241,6 +242,7 @@ struct iomap_iter {
 	unsigned flags;
 	struct iomap iomap;
 	struct iomap srcmap;
+	struct folio_batch *fbatch;
 	void *private;
 };
 
@@ -349,6 +351,8 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops);
+loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
+		loff_t length);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-- 
2.50.1


