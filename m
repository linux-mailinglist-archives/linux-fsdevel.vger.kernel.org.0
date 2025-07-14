Return-Path: <linux-fsdevel+bounces-54884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3DB048B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6558D7A3B47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97525B305;
	Mon, 14 Jul 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNjZHtxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DF367
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525475; cv=none; b=rZtLcqMbRajlvwgmwa/XxUSQ1Eqd2zuguBAwKSAotpiwOALwhp/UVNDJsHCJ2OpQuQ2X5uJm7PBZ2Le+Psp0XrdxKxytsF0cG5j6UmmrCKqwtqcMslccrXMrhmh1kyARxsNfyQHXYm0J6SOEGs+P5uamhVHFxHJ7p3IWJB3vO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525475; c=relaxed/simple;
	bh=KhE5EaI1HF0gIfUeFDDtN4g3HTxp869R0zIjc5TC6jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EN0bu7ts87v5k77acbWw+IQ8WP34+J2TYcehjT4fKpMOszriAEjKsfFnKdL3vEZBSlWn6uYYLGaN4icztbfEzj5HNXSGjnFqo6mlaYZ4ZgJDYksGqEjhKm1REDTeQO4WUt8utf8nBtjm/QvG5zB3O4trl5NCRZVg14/TDIy+3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNjZHtxX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752525472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqHgUuQA1jBGiQ06v6mPe/43vp2nKpHbQvnd9LGBvkI=;
	b=DNjZHtxXTA3MeL6x5hpcaeL6CqhubNMv2lyTrrrAJe/3G2R1Y9xQVWuLdW+CFkk/qCPYd+
	7+zzVaxtVgLZfTsqbf0zJzJCx/ZEoym90IVYEAch4uYYWYpi9GGMZi9ol/jzK/zqiWJzla
	F9byfelq2ZOYd3QGnmNlnlASlDtQP74=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-qjtN3F3rNsmnCY0NqcX6Ag-1; Mon,
 14 Jul 2025 16:37:49 -0400
X-MC-Unique: qjtN3F3rNsmnCY0NqcX6Ag-1
X-Mimecast-MFC-AGG-ID: qjtN3F3rNsmnCY0NqcX6Ag_1752525468
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5839F1956089;
	Mon, 14 Jul 2025 20:37:47 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.43])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CA1819560A3;
	Mon, 14 Jul 2025 20:37:45 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v3 3/7] iomap: optional zero range dirty folio processing
Date: Mon, 14 Jul 2025 16:41:18 -0400
Message-ID: <20250714204122.349582-4-bfoster@redhat.com>
In-Reply-To: <20250714204122.349582-1-bfoster@redhat.com>
References: <20250714204122.349582-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

Add a folio_batch in struct iomap and provide a helper for fs' to
populate the batch at lookup time. Update the folio lookup path to
return the next folio in the batch, if provided, and advance the
iter if the folio starts beyond the current offset.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 89 +++++++++++++++++++++++++++++++++++++++---
 fs/iomap/iter.c        |  6 +++
 include/linux/iomap.h  |  4 ++
 3 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 38da2fa6e6b0..194e3cc0857f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -750,6 +750,28 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
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
 	if (folio_ops && folio_ops->get_folio)
 		return folio_ops->get_folio(iter, pos, len);
 	else
@@ -811,6 +833,8 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	int status = 0;
 
 	len = min_not_zero(len, *plen);
+	*foliop = NULL;
+	*plen = 0;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -819,6 +843,15 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
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
@@ -839,6 +872,21 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
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
@@ -1377,6 +1425,12 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
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
 
@@ -1398,6 +1452,26 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
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
 		const struct iomap_ops *ops, void *private)
@@ -1426,7 +1500,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	 * flushing on partial eof zeroing, special case it to zero the
 	 * unaligned start portion if already dirty in pagecache.
 	 */
-	if (off &&
+	if (!iter.fbatch && off &&
 	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
 		iter.len = plen;
 		while ((ret = iomap_iter(&iter, ops)) > 0)
@@ -1442,13 +1516,18 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
index 6ffc6a7b9ba5..89bd5951a6fd 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -9,6 +9,12 @@
 
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
index 522644d62f30..0b9b460b2873 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/mm_types.h>
 #include <linux/blkdev.h>
+#include <linux/pagevec.h>
 
 struct address_space;
 struct fiemap_extent_info;
@@ -239,6 +240,7 @@ struct iomap_iter {
 	unsigned flags;
 	struct iomap iomap;
 	struct iomap srcmap;
+	struct folio_batch *fbatch;
 	void *private;
 };
 
@@ -345,6 +347,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
+loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
+		loff_t length);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-- 
2.50.0


