Return-Path: <linux-fsdevel+bounces-41597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37298A327BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D1B1888AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD820F08E;
	Wed, 12 Feb 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBf4RM1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498B20F095
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368506; cv=none; b=i02ZHwghnljOMOP34MIjyAVOA7lUkM/VLm4dUILcH3rEG98DMcIb/zyyEAd8tRuOT+EgvYPZLAsefB8q+GxKJqL0FybD7D9KbgzPwfZW1yAj7TlohGPwHSj+pGx4vOONaSALBFNZ9wL2L6UTXemdYHsQumd83eC3WsOn4bTssF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368506; c=relaxed/simple;
	bh=rwEBgOHjzdIWVTMxHwY3klIeR7M+3FswAjNOfvySSws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR28P4R/hQDwpym+6XXjbl8V55EgjhLYoBX2nCFI4HZZWr4nxRli/20Mzind+nBAOEo+9yTQRppmPPs1sMc31sx11ZgNHLBbS24e3x9I+ebWGvBX2YZ0cCaER9mJvEgJ1/pdIoYpIY4f/j7O7yeRudfhq31jEFe+TLP28mxZkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBf4RM1T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739368503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3SzcWtdPpdv1aq0sQTU9FnslcLrbZ/URTloW94mfa8=;
	b=dBf4RM1TkrCd5C4YQH9GXaHKj1zZaf17IOQu3QayPZvvx8EBnI3z1A+NQzPBzkagaK0QDr
	HxHPCuXAbDr/BqJCDs9OUxZD5xy6znpT2MdOtvcJ9qhl0WUf0HXEp4HCNpaaXDSTLyF0Sq
	4+A60/KUSnlZBaiomj6t6dYmT7BJWA4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-9bJ4ie9PPy6lj8BuBIjd8w-1; Wed,
 12 Feb 2025 08:54:59 -0500
X-MC-Unique: 9bJ4ie9PPy6lj8BuBIjd8w-1
X-Mimecast-MFC-AGG-ID: 9bJ4ie9PPy6lj8BuBIjd8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3ABC1956050;
	Wed, 12 Feb 2025 13:54:58 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E178D3001D10;
	Wed, 12 Feb 2025 13:54:57 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 10/10] iomap: rename iomap_iter processed field to status
Date: Wed, 12 Feb 2025 08:57:12 -0500
Message-ID: <20250212135712.506987-11-bfoster@redhat.com>
In-Reply-To: <20250212135712.506987-1-bfoster@redhat.com>
References: <20250212135712.506987-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The iter.processed field name is no longer appropriate now that
iomap operations do not return the number of bytes processed. Rename
the field to iter.status to reflect that a success or error code is
expected.

Also change the type to int as there is no longer a need for an s64.
This reduces the size of iomap_iter by 8 bytes due to a combination
of smaller type and reduction in structure padding. While here, fix
up the return types of various _iter() helpers to reflect the type
change.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/dax.c               | 28 +++++++++++++++-------------
 fs/iomap/buffered-io.c | 42 +++++++++++++++++++++---------------------
 fs/iomap/direct-io.c   |  2 +-
 fs/iomap/fiemap.c      |  6 +++---
 fs/iomap/iter.c        | 12 ++++++------
 fs/iomap/seek.c        |  8 ++++----
 fs/iomap/swapfile.c    |  4 ++--
 fs/iomap/trace.h       |  8 ++++----
 include/linux/iomap.h  |  7 +++----
 9 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 85dc5c5b8332..3712279e97b5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1258,7 +1258,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
-static s64 dax_unshare_iter(struct iomap_iter *iter)
+static int dax_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -1328,7 +1328,7 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 
 	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = dax_unshare_iter(&iter);
+		iter.status = dax_unshare_iter(&iter);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dax_file_unshare);
@@ -1356,12 +1356,12 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
 	return ret;
 }
 
-static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
+static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	u64 length = iomap_length(iter);
-	s64 ret;
+	int ret;
 
 	/* already zeroed?  we're done. */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
@@ -1416,7 +1416,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	int ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = dax_zero_iter(&iter, did_zero);
+		iter.status = dax_zero_iter(&iter, did_zero);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dax_zero_range);
@@ -1589,10 +1589,12 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		iomi.flags |= IOMAP_NOWAIT;
 
 	while ((ret = iomap_iter(&iomi, ops)) > 0) {
-		iomi.processed = dax_iomap_iter(&iomi, iter);
-		if (iomi.processed > 0)
-			iomi.processed = iomap_iter_advance(&iomi,
-							    &iomi.processed);
+		loff_t processed = dax_iomap_iter(&iomi, iter);
+		if (processed < 0)
+			iomi.status = processed;
+		else
+			iomi.status = iomap_iter_advance(&iomi,
+							 (u64 *) &processed);
 	}
 
 	done = iomi.pos - iocb->ki_pos;
@@ -1764,7 +1766,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	while ((error = iomap_iter(&iter, ops)) > 0) {
 		if (WARN_ON_ONCE(iomap_length(&iter) < PAGE_SIZE)) {
-			iter.processed = -EIO;	/* fs corruption? */
+			iter.status = -EIO;	/* fs corruption? */
 			continue;
 		}
 
@@ -1778,7 +1780,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 		if (!(ret & VM_FAULT_ERROR)) {
 			u64 length = PAGE_SIZE;
-			iter.processed = iomap_iter_advance(&iter, &length);
+			iter.status = iomap_iter_advance(&iter, &length);
 		}
 	}
 
@@ -1894,7 +1896,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		ret = dax_fault_iter(vmf, &iter, pfnp, &xas, &entry, true);
 		if (ret != VM_FAULT_FALLBACK) {
 			u64 length = PMD_SIZE;
-			iter.processed = iomap_iter_advance(&iter, &length);
+			iter.status = iomap_iter_advance(&iter, &length);
 		}
 	}
 
@@ -2084,7 +2086,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				min(src_iter.len, dst_iter.len), same);
 		if (status < 0)
 			return ret;
-		src_iter.processed = dst_iter.processed = status;
+		src_iter.status = dst_iter.status = status;
 	}
 	return ret;
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b5bd8b0c4ccd..0fa6ef1ac945 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -366,7 +366,7 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
-static loff_t iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_readpage_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -442,10 +442,10 @@ static loff_t iomap_readpage_iter(struct iomap_iter *iter,
 	return iomap_iter_advance(iter, &length);
 }
 
-static loff_t iomap_read_folio_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
-	loff_t ret;
+	int ret;
 
 	while (iomap_length(iter)) {
 		ret = iomap_readpage_iter(iter, ctx);
@@ -471,7 +471,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
@@ -490,10 +490,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
-static loff_t iomap_readahead_iter(struct iomap_iter *iter,
+static int iomap_readahead_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
-	loff_t ret;
+	int ret;
 
 	while (iomap_length(iter) > 0) {
 		if (ctx->cur_folio &&
@@ -543,7 +543,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.processed = iomap_readahead_iter(&iter, &ctx);
+		iter.status = iomap_readahead_iter(&iter, &ctx);
 
 	if (ctx.bio)
 		submit_bio(ctx.bio);
@@ -903,10 +903,10 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
-static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
+static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
 	ssize_t total_written = 0;
-	long status = 0;
+	int status = 0;
 	struct address_space *mapping = iter->inode->i_mapping;
 	size_t chunk = mapping_max_folio_size(mapping);
 	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
@@ -1026,7 +1026,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		iter.flags |= IOMAP_NOWAIT;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_write_iter(&iter, i);
+		iter.status = iomap_write_iter(&iter, i);
 
 	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
@@ -1260,7 +1260,7 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 }
 EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 
-static loff_t iomap_unshare_iter(struct iomap_iter *iter)
+static int iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
 	u64 bytes = iomap_length(iter);
@@ -1320,7 +1320,7 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 
 	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_unshare_iter(&iter);
+		iter.status = iomap_unshare_iter(&iter);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
@@ -1339,7 +1339,7 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 	return filemap_write_and_wait_range(mapping, i->pos, end);
 }
 
-static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
+static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	u64 bytes = iomap_length(iter);
 	int status;
@@ -1412,7 +1412,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
 		iter.len = plen;
 		while ((ret = iomap_iter(&iter, ops)) > 0)
-			iter.processed = iomap_zero_iter(&iter, did_zero);
+			iter.status = iomap_zero_iter(&iter, did_zero);
 
 		iter.len = len - (iter.pos - pos);
 		if (ret || !iter.len)
@@ -1431,20 +1431,20 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 
 		if (srcmap->type == IOMAP_HOLE ||
 		    srcmap->type == IOMAP_UNWRITTEN) {
-			s64 proc;
+			s64 status;
 
 			if (range_dirty) {
 				range_dirty = false;
-				proc = iomap_zero_iter_flush_and_stale(&iter);
+				status = iomap_zero_iter_flush_and_stale(&iter);
 			} else {
 				u64 length = iomap_length(&iter);
-				proc = iomap_iter_advance(&iter, &length);
+				status = iomap_iter_advance(&iter, &length);
 			}
-			iter.processed = proc;
+			iter.status = status;
 			continue;
 		}
 
-		iter.processed = iomap_zero_iter(&iter, did_zero);
+		iter.status = iomap_zero_iter(&iter, did_zero);
 	}
 	return ret;
 }
@@ -1464,7 +1464,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
+static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 		struct folio *folio)
 {
 	loff_t length = iomap_length(iter);
@@ -1500,7 +1500,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 	iter.pos = folio_pos(folio);
 	iter.len = ret;
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_folio_mkwrite_iter(&iter, folio);
+		iter.status = iomap_folio_mkwrite_iter(&iter, folio);
 
 	if (ret < 0)
 		goto out_unlock;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index cb0b0b0f07b3..178e7c818e2b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -711,7 +711,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	blk_start_plug(&plug);
 	while ((ret = iomap_iter(&iomi, ops)) > 0) {
-		iomi.processed = iomap_dio_iter(&iomi, dio);
+		iomi.status = iomap_dio_iter(&iomi, dio);
 
 		/*
 		 * We can only poll for single bio I/Os.
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 8a0d8b034218..6776b800bde7 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -39,7 +39,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 			iomap->length, flags);
 }
 
-static loff_t iomap_fiemap_iter(struct iomap_iter *iter,
+static int iomap_fiemap_iter(struct iomap_iter *iter,
 		struct fiemap_extent_info *fi, struct iomap *prev)
 {
 	u64 length = iomap_length(iter);
@@ -78,7 +78,7 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 		return ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_fiemap_iter(&iter, fi, &prev);
+		iter.status = iomap_fiemap_iter(&iter, fi, &prev);
 
 	if (prev.type != IOMAP_HOLE) {
 		ret = iomap_to_fiemap(fi, &prev, FIEMAP_EXTENT_LAST);
@@ -114,7 +114,7 @@ iomap_bmap(struct address_space *mapping, sector_t bno,
 	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		if (iter.iomap.type == IOMAP_MAPPED)
 			bno = iomap_sector(&iter.iomap, iter.pos) >> blkshift;
-		/* leave iter.processed unset to abort loop */
+		/* leave iter.status unset to abort loop */
 	}
 	if (ret)
 		return 0;
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 1e2e5c834582..d1ca6ceb6cac 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -9,7 +9,7 @@
 
 static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 {
-	iter->processed = 0;
+	iter->status = 0;
 	memset(&iter->iomap, 0, sizeof(iter->iomap));
 	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
 }
@@ -54,7 +54,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
  * function must be called in a loop that continues as long it returns a
  * positive value.  If 0 or a negative value is returned, the caller must not
  * return to the loop body.  Within a loop body, there are two ways to break out
- * of the loop body:  leave @iter.processed unchanged, or set it to a negative
+ * of the loop body:  leave @iter.status unchanged, or set it to a negative
  * errno.
  */
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
@@ -86,8 +86,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	}
 
 	/* detect old return semantics where this would advance */
-	if (WARN_ON_ONCE(iter->processed > 0))
-		iter->processed = -EIO;
+	if (WARN_ON_ONCE(iter->status > 0))
+		iter->status = -EIO;
 
 	/*
 	 * Use iter->len to determine whether to continue onto the next mapping.
@@ -96,8 +96,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	 * mapping has been marked stale and needs to be reprocessed.
 	 */
 	ret = (iter->len > 0) ? 1 : 0;
-	if (iter->processed < 0)
-		ret = iter->processed;
+	if (iter->status < 0)
+		ret = iter->status;
 	else if (!advanced && !stale)
 		ret = 0;
 	iomap_iter_reset_iomap(iter);
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 83c687d6ccc0..04d7919636c1 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -10,7 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 
-static loff_t iomap_seek_hole_iter(struct iomap_iter *iter,
+static int iomap_seek_hole_iter(struct iomap_iter *iter,
 		loff_t *hole_pos)
 {
 	loff_t length = iomap_length(iter);
@@ -47,7 +47,7 @@ iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
 
 	iter.len = size - pos;
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_seek_hole_iter(&iter, &pos);
+		iter.status = iomap_seek_hole_iter(&iter, &pos);
 	if (ret < 0)
 		return ret;
 	if (iter.len) /* found hole before EOF */
@@ -56,7 +56,7 @@ iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
-static loff_t iomap_seek_data_iter(struct iomap_iter *iter,
+static int iomap_seek_data_iter(struct iomap_iter *iter,
 		loff_t *hole_pos)
 {
 	loff_t length = iomap_length(iter);
@@ -93,7 +93,7 @@ iomap_seek_data(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
 
 	iter.len = size - pos;
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_seek_data_iter(&iter, &pos);
+		iter.status = iomap_seek_data_iter(&iter, &pos);
 	if (ret < 0)
 		return ret;
 	if (iter.len) /* found data before EOF */
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 4395e46a4dc7..9ea185e58ca7 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -94,7 +94,7 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
  * swap only cares about contiguous page-aligned physical extents and makes no
  * distinction between written and unwritten extents.
  */
-static loff_t iomap_swapfile_iter(struct iomap_iter *iter,
+static int iomap_swapfile_iter(struct iomap_iter *iter,
 		struct iomap *iomap, struct iomap_swapfile_info *isi)
 {
 	u64 length = iomap_length(iter);
@@ -169,7 +169,7 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 		return ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
+		iter.status = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 4118a42cdab0..9eab2c8ac3c5 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -207,7 +207,7 @@ TRACE_EVENT(iomap_iter,
 		__field(u64, ino)
 		__field(loff_t, pos)
 		__field(u64, length)
-		__field(s64, processed)
+		__field(int, status)
 		__field(unsigned int, flags)
 		__field(const void *, ops)
 		__field(unsigned long, caller)
@@ -217,17 +217,17 @@ TRACE_EVENT(iomap_iter,
 		__entry->ino = iter->inode->i_ino;
 		__entry->pos = iter->pos;
 		__entry->length = iomap_length(iter);
-		__entry->processed = iter->processed;
+		__entry->status = iter->status;
 		__entry->flags = iter->flags;
 		__entry->ops = ops;
 		__entry->caller = caller;
 	),
-	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx processed %lld flags %s (0x%x) ops %ps caller %pS",
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx status %d flags %s (0x%x) ops %ps caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		   __entry->ino,
 		   __entry->pos,
 		   __entry->length,
-		   __entry->processed,
+		   __entry->status,
 		   __print_flags(__entry->flags, "|", IOMAP_FLAGS_STRINGS),
 		   __entry->flags,
 		   __entry->ops,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d832a540cc72..29b72a671104 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -213,9 +213,8 @@ struct iomap_ops {
  *	It is updated at the same time as @pos.
  * @iter_start_pos: The original start pos for the current iomap. Used for
  *	incremental iter advance.
- * @processed: The number of bytes the most recent iteration needs iomap_iter()
- *	to advance the iter, zero if the iter was already advanced, or a
- *	negative errno for an error during the operation.
+ * @status: Status of the most recent iteration. Zero on success or a negative
+ *	errno on error.
  * @flags: Zero or more of the iomap_begin flags above.
  * @iomap: Map describing the I/O iteration
  * @srcmap: Source map for COW operations
@@ -225,7 +224,7 @@ struct iomap_iter {
 	loff_t pos;
 	u64 len;
 	loff_t iter_start_pos;
-	s64 processed;
+	int status;
 	unsigned flags;
 	struct iomap iomap;
 	struct iomap srcmap;
-- 
2.48.1


