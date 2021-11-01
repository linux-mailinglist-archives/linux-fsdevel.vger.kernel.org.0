Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14E344223B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhKAVFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAVFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:05:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A368FC061714;
        Mon,  1 Nov 2021 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=11slo8JST7WFtjePDn5GzJOvUSqFCENMy5XC+yDdEpc=; b=JphgnPqzegpOcRhljjVvTa6Mc0
        r9euR1qCnQ6HzuVRAMg3OXhUwJ0FzCjIwQHzvMQioWk/ppRwuj5Eg5U+ScgQf751Djhk3RURLboH1
        PiLxBqo7N35OnhQeStJgdFWms9E19C1NusQKbFLyqeud3kt6d2krMlrs6qHBNL+GynGlL8ODHMPZr
        slXb3Yt15ykZ9wdplQZbRsJSwLeSasEJrUA4IgqjJkn5bq5fJM/j9/Upom4BFPZQ37K7YU+JWtR/w
        EAxClpkkk3RY++Hbo/+u8dMniRoDCoXwytu6GRTdDmFkUa1Mm5sVLniSTfArXlca3EZDvFZXJfq5q
        3k/+VM2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhePB-00411g-5B; Mon, 01 Nov 2021 21:00:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 12/21] iomap: Convert iomap_read_inline_data to take a folio
Date:   Mon,  1 Nov 2021 20:39:20 +0000
Message-Id: <20211101203929.954622-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We still only support up to a single page of inline data (at least,
per call to iomap_read_inline_data()), but it can now be written into
the middle of a folio in case we decide to allocate a 16KiB page for
a file that's 8.1KiB in size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dea577380215..b5e77d9de4a7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -195,9 +195,8 @@ struct iomap_readpage_ctx {
 };
 
 static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
-		struct page *page)
+		struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
@@ -205,7 +204,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	size_t offset = offset_in_folio(folio, iomap->offset);
 	void *addr;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return PAGE_SIZE - poff;
 
 	if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
@@ -220,7 +219,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	else
 		iop = to_iomap_page(folio);
 
-	addr = kmap_local_page(page) + poff;
+	addr = kmap_local_folio(folio, offset);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
@@ -252,7 +251,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE)
-		return min(iomap_read_inline_data(iter, page), length);
+		return min(iomap_read_inline_data(iter, folio), length);
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(iter->inode, folio);
@@ -587,12 +586,13 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int ret;
 
 	/* needs more work for the tailpacking case; disable for now */
 	if (WARN_ON_ONCE(iomap_iter_srcmap(iter)->offset != 0))
 		return -EIO;
-	ret = iomap_read_inline_data(iter, page);
+	ret = iomap_read_inline_data(iter, folio);
 	if (ret < 0)
 		return ret;
 	return 0;
-- 
2.33.0

