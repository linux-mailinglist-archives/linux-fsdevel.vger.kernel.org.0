Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE353E4023
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhHIGgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhHIGgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F91C0613CF;
        Sun,  8 Aug 2021 23:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bYExG7/lvyv3at3oag7aMrtKKF2jDFAiW9Ean+Kl3no=; b=P8rmfuLkadkeLjqQ50zoMl0N0S
        KctM8PnPPrL4686wJTYfNAyWILrhkbGoukiR8j/6R8b4uEubyNx+jIpBXYxbBJ69ipgoui+/9y2e6
        WAlwkBu8rpGwdxwKjH2UcSdVPKkBGC7rixLob8kf6L9J+6ehK2PY0UvlF89MfjfirIkQnbRe3MHYq
        zb4g9JZ231xdX5n+Qq1m349PlB0IGmVui5NAtHoq1vNhg/X2OonHiBe2f5DtnpbL09DO/dxtsnUpG
        n00yGrI13pvr98Eu2vv+2R2Nle7DB/umPScGxSqR6Pj0vaKp/wgaA3neK5AottWZka5dYwK/Nrm2d
        Oarv8u+Q==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyqr-00Ahw4-GZ; Mon, 09 Aug 2021 06:33:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 25/30] iomap: pass an iomap_iter to various buffered I/O helpers
Date:   Mon,  9 Aug 2021 08:12:39 +0200
Message-Id: <20210809061244.1196573-26-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the iomap_iter structure instead of individual parameters to
various internal helpers for buffered I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 137 ++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 71 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5ab464937d4886..cfeec6b0ed2293 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,10 +205,11 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static loff_t iomap_read_inline_data(struct inode *inode, struct page *page,
-		const struct iomap *iomap)
+static loff_t iomap_read_inline_data(struct iomap_iter *iter,
+		struct page *page)
 {
-	size_t size = i_size_read(inode) - iomap->offset;
+	struct iomap *iomap = iomap_iter_srcmap(iter);
+	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
 	void *addr;
 
@@ -223,7 +224,7 @@ static loff_t iomap_read_inline_data(struct inode *inode, struct page *page,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (poff > 0)
-		iomap_page_create(inode, page);
+		iomap_page_create(iter->inode, page);
 
 	addr = kmap_local_page(page) + poff;
 	memcpy(addr, iomap->inline_data, size);
@@ -233,12 +234,14 @@ static loff_t iomap_read_inline_data(struct inode *inode, struct page *page,
 	return PAGE_SIZE - poff;
 }
 
-static inline bool iomap_block_needs_zeroing(struct inode *inode,
-		struct iomap *iomap, loff_t pos)
+static inline bool iomap_block_needs_zeroing(struct iomap_iter *iter,
+		loff_t pos)
 {
-	return iomap->type != IOMAP_MAPPED ||
-		(iomap->flags & IOMAP_F_NEW) ||
-		pos >= i_size_read(inode);
+	struct iomap *srcmap = iomap_iter_srcmap(iter);
+
+	return srcmap->type != IOMAP_MAPPED ||
+		(srcmap->flags & IOMAP_F_NEW) ||
+		pos >= i_size_read(iter->inode);
 }
 
 static loff_t iomap_readpage_iter(struct iomap_iter *iter,
@@ -254,8 +257,7 @@ static loff_t iomap_readpage_iter(struct iomap_iter *iter,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE)
-		return min(iomap_read_inline_data(iter->inode, page, iomap),
-						  length);
+		return min(iomap_read_inline_data(iter, page), length);
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(iter->inode, page);
@@ -263,7 +265,7 @@ static loff_t iomap_readpage_iter(struct iomap_iter *iter,
 	if (plen == 0)
 		goto done;
 
-	if (iomap_block_needs_zeroing(iter->inode, iomap, pos)) {
+	if (iomap_block_needs_zeroing(iter, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		goto done;
@@ -538,12 +540,12 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 	return submit_bio_wait(&bio);
 }
 
-static int
-__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
-		struct page *page, struct iomap *srcmap)
+static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
+		unsigned len, int flags, struct page *page)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
-	loff_t block_size = i_blocksize(inode);
+	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	struct iomap_page *iop = iomap_page_create(iter->inode, page);
+	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
 	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
@@ -553,7 +555,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	ClearPageError(page);
 
 	do {
-		iomap_adjust_read_range(inode, iop, &block_start,
+		iomap_adjust_read_range(iter->inode, iop, &block_start,
 				block_end - block_start, &poff, &plen);
 		if (plen == 0)
 			break;
@@ -563,7 +565,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		    (to <= poff || to >= poff + plen))
 			continue;
 
-		if (iomap_block_needs_zeroing(inode, srcmap, block_start)) {
+		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
 				return -EIO;
 			zero_user_segments(page, poff, from, to, poff + plen);
@@ -579,55 +581,54 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
-static int iomap_write_begin_inline(struct inode *inode,
-		struct page *page, struct iomap *srcmap)
+static int iomap_write_begin_inline(struct iomap_iter *iter,
+		struct page *page)
 {
 	int ret;
 
 	/* needs more work for the tailpacking case; disable for now */
-	if (WARN_ON_ONCE(srcmap->offset != 0))
+	if (WARN_ON_ONCE(iomap_iter_srcmap(iter)->offset != 0))
 		return -EIO;
-	ret = iomap_read_inline_data(inode, page, srcmap);
+	ret = iomap_read_inline_data(iter, page);
 	if (ret < 0)
 		return ret;
 	return 0;
 }
 
-static int
-iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
+static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
+		unsigned flags, struct page **pagep)
 {
-	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
+	struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct page *page;
 	int status = 0;
 
-	BUG_ON(pos + len > iomap->offset + iomap->length);
-	if (srcmap != iomap)
+	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
+	if (srcmap != &iter->iomap)
 		BUG_ON(pos + len > srcmap->offset + srcmap->length);
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
 	if (page_ops && page_ops->page_prepare) {
-		status = page_ops->page_prepare(inode, pos, len);
+		status = page_ops->page_prepare(iter->inode, pos, len);
 		if (status)
 			return status;
 	}
 
-	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
-			AOP_FLAG_NOFS);
+	page = grab_cache_page_write_begin(iter->inode->i_mapping,
+				pos >> PAGE_SHIFT, AOP_FLAG_NOFS);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		status = iomap_write_begin_inline(inode, page, srcmap);
-	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
+		status = iomap_write_begin_inline(iter, page);
+	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(inode, pos, len, flags, page,
-				srcmap);
+		status = __iomap_write_begin(iter, pos, len, flags, page);
 
 	if (unlikely(status))
 		goto out_unlock;
@@ -638,11 +639,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 out_unlock:
 	unlock_page(page);
 	put_page(page);
-	iomap_write_failed(inode, pos, len);
+	iomap_write_failed(iter->inode, pos, len);
 
 out_no_page:
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, 0, NULL);
+		page_ops->page_done(iter->inode, pos, 0, NULL);
 	return status;
 }
 
@@ -669,9 +670,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
-		struct iomap *iomap, loff_t pos, size_t copied)
+static size_t iomap_write_end_inline(struct iomap_iter *iter, struct page *page,
+		loff_t pos, size_t copied)
 {
+	struct iomap *iomap = &iter->iomap;
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
@@ -682,26 +684,26 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 	memcpy(iomap_inline_data(iomap, pos), addr, copied);
 	kunmap_local(addr);
 
-	mark_inode_dirty(inode);
+	mark_inode_dirty(iter->inode);
 	return copied;
 }
 
 /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
-static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
-		size_t copied, struct page *page, struct iomap *iomap,
-		struct iomap *srcmap)
+static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
+		size_t copied, struct page *page)
 {
-	const struct iomap_page_ops *page_ops = iomap->page_ops;
-	loff_t old_size = inode->i_size;
+	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
+	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	loff_t old_size = iter->inode->i_size;
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
+		ret = iomap_write_end_inline(iter, page, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
-				page, NULL);
+		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
+				copied, page, NULL);
 	} else {
-		ret = __iomap_write_end(inode, pos, len, copied, page);
+		ret = __iomap_write_end(iter->inode, pos, len, copied, page);
 	}
 
 	/*
@@ -710,26 +712,24 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * preferably after I/O completion so that no stale data is exposed.
 	 */
 	if (pos + ret > old_size) {
-		i_size_write(inode, pos + ret);
-		iomap->flags |= IOMAP_F_SIZE_CHANGED;
+		i_size_write(iter->inode, pos + ret);
+		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 	}
 	unlock_page(page);
 
 	if (old_size < pos)
-		pagecache_isize_extended(inode, old_size, pos);
+		pagecache_isize_extended(iter->inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, ret, page);
+		page_ops->page_done(iter->inode, pos, ret, page);
 	put_page(page);
 
 	if (ret < len)
-		iomap_write_failed(inode, pos, len);
+		iomap_write_failed(iter->inode, pos, len);
 	return ret;
 }
 
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct iomap *iomap = &iter->iomap;
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	ssize_t written = 0;
@@ -759,8 +759,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter->inode, pos, bytes, 0, &page,
-					   iomap, srcmap);
+		status = iomap_write_begin(iter, pos, bytes, 0, &page);
 		if (unlikely(status))
 			break;
 
@@ -769,8 +768,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 
-		status = iomap_write_end(iter->inode, pos, bytes, copied, page,
-					 iomap, srcmap);
+		status = iomap_write_end(iter, pos, bytes, copied, page);
 
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
@@ -838,13 +836,12 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct page *page;
 
-		status = iomap_write_begin(iter->inode, pos, bytes,
-				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
+		status = iomap_write_begin(iter, pos, bytes,
+				IOMAP_WRITE_F_UNSHARE, &page);
 		if (unlikely(status))
 			return status;
 
-		status = iomap_write_end(iter->inode, pos, bytes, bytes, page, iomap,
-				srcmap);
+		status = iomap_write_end(iter, pos, bytes, bytes, page);
 		if (WARN_ON_ONCE(status == 0))
 			return -EIO;
 
@@ -878,22 +875,21 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static s64 iomap_zero(struct inode *inode, loff_t pos, u64 length,
-		struct iomap *iomap, struct iomap *srcmap)
+static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 {
 	struct page *page;
 	int status;
 	unsigned offset = offset_in_page(pos);
 	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
 
-	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
+	status = iomap_write_begin(iter, pos, bytes, 0, &page);
 	if (status)
 		return status;
 
 	zero_user(page, offset, bytes);
 	mark_page_accessed(page);
 
-	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
+	return iomap_write_end(iter, pos, bytes, bytes, page);
 }
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
@@ -914,8 +910,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (IS_DAX(iter->inode))
 			bytes = dax_iomap_zero(pos, length, iomap);
 		else
-			bytes = iomap_zero(iter->inode, pos, length, iomap,
-					   srcmap);
+			bytes = __iomap_zero_iter(iter, pos, length);
 		if (bytes < 0)
 			return bytes;
 
-- 
2.30.2

