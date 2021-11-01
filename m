Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A1442226
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKAVBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAVBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:01:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D300C061714;
        Mon,  1 Nov 2021 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SY0k+0X/MIdMh+Ee2kdkHjsdASr522NeEF8FMPYe7hE=; b=A4QG249WK6jocKj7ZpYPjeQz5a
        RmhGRGwD/O7rhP5yH68r9Qya8FIdGmCktTsCPptIhOqms84T7tlOcakSKlASafVGbgczYVSPmmyeD
        s2ctWlJxQuo3xVTSRvCX7C4QTZsvasMAbY+ad5ADoetUhSRXUV6yOza2e2NI9oks4nyaZ9hfN0bGb
        vJBH7m5gjEcMMAcnfIXEDqXYzHGPzR8InIz8EFDzNmSfMRa4V3Z+wQDNDMk3jafLIgllGU/ZpvlZs
        cv/b/Br/gjSqh13n8UWw1hAfhNJFZugizWePCGO5+6kx74K//pUJokxIyZodKDwPqOVmWBY0lEmFh
        YYd7M34w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheK0-0040tQ-K9; Mon, 01 Nov 2021 20:55:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 09/21] iomap: Pass the iomap_page into iomap_set_range_uptodate
Date:   Mon,  1 Nov 2021 20:39:17 +0000
Message-Id: <20211101203929.954622-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All but one caller already has the iomap_page, so we can avoid getting
it again.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e9a60520e769..e171eb2ebc5d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -134,11 +134,9 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
-static void
-iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
+static void iomap_iop_set_range_uptodate(struct page *page,
+		struct iomap_page *iop, unsigned off, unsigned len)
 {
-	struct folio *folio = page_folio(page);
-	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = page->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
@@ -151,14 +149,14 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void
-iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
+static void iomap_set_range_uptodate(struct page *page,
+		struct iomap_page *iop, unsigned off, unsigned len)
 {
 	if (PageError(page))
 		return;
 
-	if (page_has_private(page))
-		iomap_iop_set_range_uptodate(page, off, len);
+	if (iop)
+		iomap_iop_set_range_uptodate(page, iop, off, len);
 	else
 		SetPageUptodate(page);
 }
@@ -174,7 +172,8 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 		ClearPageUptodate(page);
 		SetPageError(page);
 	} else {
-		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
+		iomap_set_range_uptodate(page, iop, bvec->bv_offset,
+						bvec->bv_len);
 	}
 
 	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
@@ -204,6 +203,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 		struct page *page)
 {
 	struct folio *folio = page_folio(page);
+	struct iomap_page *iop;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -220,13 +220,15 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (poff > 0)
-		iomap_page_create(iter->inode, folio);
+		iop = iomap_page_create(iter->inode, folio);
+	else
+		iop = to_iomap_page(folio);
 
 	addr = kmap_local_page(page) + poff;
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(page, iop, poff, PAGE_SIZE - poff);
 	return PAGE_SIZE - poff;
 }
 
@@ -264,7 +266,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		zero_user(page, poff, plen);
-		iomap_set_range_uptodate(page, poff, plen);
+		iomap_set_range_uptodate(page, iop, poff, plen);
 		goto done;
 	}
 
@@ -578,7 +580,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(page, poff, plen);
+		iomap_set_range_uptodate(page, iop, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -653,6 +655,8 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	flush_dcache_page(page);
 
 	/*
@@ -668,7 +672,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, iop, offset_in_page(pos), len);
 	__set_page_dirty_nobuffers(page);
 	return copied;
 }
-- 
2.33.0

