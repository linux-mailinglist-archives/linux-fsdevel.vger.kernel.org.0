Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691B7477E45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhLPVHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbhLPVHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB8C061574;
        Thu, 16 Dec 2021 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/GPw/t46DUAu+EQGlBQpIskJ8A1FQYCfjrZfF5LHiuc=; b=kgjXKLARbp5JVTJ4fihOCHpkaj
        Vnk/2HR/BXSnwlI3rPLY1gWEbHvNRjsQw1U0C3OCJEEO3ylwyY94GWkO5Yyx2hkUG9jhZAQfov8uW
        WArXqNTGRxQT/Hl+Kjdr0sLB5jxtOUM7T+H7om3wm45LgHWgDbEfxaLi9TpD79Q8X7r7BB3zcaasP
        azik2Y8DCZktlJM5bbc6y+zBoBCnMVv/1RTYZ8iA8KEZXPO0tr1MmFae0hRmZPdf8CQnJ5Q9U8p/3
        sB4Qn1+XM1jCPbQz+O5EYDdx2+j/Ye4WvecXQlNd29Z9RLHfXiccbdtgzkAKxjvj0m8P7UTPgzRkj
        M8nub+ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyC-00Fx44-8S; Thu, 16 Dec 2021 21:07:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 12/25] iomap: Convert iomap_read_inline_data to take a folio
Date:   Thu, 16 Dec 2021 21:07:02 +0000
Message-Id: <20211216210715.3801857-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 06ff80c05340..2ebea02780b8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -197,16 +197,15 @@ struct iomap_readpage_ctx {
 /**
  * iomap_read_inline_data - copy inline data into the page cache
  * @iter: iteration structure
- * @page: page to copy to
+ * @folio: folio to copy to
  *
- * Copy the inline data in @iter into @page and zero out the rest of the page.
+ * Copy the inline data in @iter into @folio and zero out the rest of the folio.
  * Only a single IOMAP_INLINE extent is allowed at the end of each file.
  * Returns zero for success to complete the read, or the usual negative errno.
  */
 static int iomap_read_inline_data(const struct iomap_iter *iter,
-		struct page *page)
+		struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
@@ -214,7 +213,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	size_t offset = offset_in_folio(folio, iomap->offset);
 	void *addr;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return 0;
 
 	if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
@@ -229,7 +228,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	else
 		iop = to_iomap_page(folio);
 
-	addr = kmap_local_page(page) + poff;
+	addr = kmap_local_folio(folio, offset);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
@@ -261,7 +260,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE)
-		return iomap_read_inline_data(iter, page);
+		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(iter->inode, folio);
@@ -597,10 +596,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct page *page)
 {
+	struct folio *folio = page_folio(page);
+
 	/* needs more work for the tailpacking case; disable for now */
 	if (WARN_ON_ONCE(iomap_iter_srcmap(iter)->offset != 0))
 		return -EIO;
-	return iomap_read_inline_data(iter, page);
+	return iomap_read_inline_data(iter, folio);
 }
 
 static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
-- 
2.33.0

