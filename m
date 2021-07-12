Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5243C4282
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhGLEEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhGLEEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:04:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF61C0613DD;
        Sun, 11 Jul 2021 21:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ud7uvERwf05cBeuZnmOzMd1BoGSxpK6LFLaDstq02qE=; b=DrmUpeCzrVeUlu2U/1exLipbYh
        abMSjYsEjdku3fH0pdoHSBDZ8GwnAFirdSEqCeFOkuvPeb88PK+bONm7WpprNMGBGzCI40AsdctYa
        mhrDcIdbXKtg9UqwRVZNeDGFRFauk3hGxOMlye9+7maNSLQh/rvTnJZoobjIaayOCYU1W8G9hCt1b
        yTwJnp5Sx4nKmj5jmiTmycMvrMB4LqSoMZs/OMqQUn4o49S/SEjr6zKpIxn5IGMWmkSBxIuEYNtwb
        uULJaAbXN42XEOoK1rPby75DlIqmWt2Sqds7JltsM+dxlp18ZHNZv5KgIP2VREp7/nZNSF9evE4xT
        qVb+CzmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n7T-00GqZR-Bi; Mon, 12 Jul 2021 04:00:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 102/137] iomap: Convert iomap_read_inline_data to take a folio
Date:   Mon, 12 Jul 2021 04:06:26 +0100
Message-Id: <20210712030701.4000097-103-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline data is restricted to being less than a page in size, so we
don't need to handle multi-page folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1df401c6e55a..aec28781c773 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -194,24 +194,24 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
+static void iomap_read_inline_data(struct inode *inode, struct folio *folio,
 		struct iomap *iomap)
 {
 	size_t size = i_size_read(inode);
 	void *addr;
 
-	if (PageUptodate(page))
+	if (folio_uptodate(folio))
 		return;
 
-	BUG_ON(page->index);
+	BUG_ON(folio->index);
+	BUG_ON(folio_multi(folio));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
-	addr = kmap_atomic(page);
+	addr = kmap_local_folio(folio, 0);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - size);
-	kunmap_atomic(addr);
-	SetPageUptodate(page);
+	kunmap_local(addr);
+	folio_mark_uptodate(folio);
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -236,7 +236,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (iomap->type == IOMAP_INLINE) {
 		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, &folio->page, iomap);
+		iomap_read_inline_data(inode, folio, iomap);
 		return PAGE_SIZE;
 	}
 
@@ -614,7 +614,7 @@ static int iomap_write_begin(struct inode *inode, loff_t pos, size_t len,
 
 	page = folio_file_page(folio, pos >> PAGE_SHIFT);
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		iomap_read_inline_data(inode, folio, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
-- 
2.30.2

