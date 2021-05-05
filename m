Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DBA37471E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhEERou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbhEERnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:43:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE72FC06123B;
        Wed,  5 May 2021 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tntI/BWH7jiCZdi1d9Ln7aAQ15+XDFARCY4IlqxeH/I=; b=J2gdrZ7sYOp5BWmGpoLAxW3V83
        fWbdcyZoczY4M/1Zb4GVZlRTLT6vSj/J7ke5v+eLyufj/7F8grrILefykLFQkX+CzcwZpmxe0p+ku
        P+4e8ydGSkA0+VoBVahGzq5PhxfF6o2UO2OLK+TGBKdeNIl2qPFcM09+0Lq3gEpybimXVM9J1FR4m
        7U+PYELfv7LaVj1XXp648k+vT4GhoA8vom+6GbR5bc1XJCt3h2Zi9Ock4VgEPK4jkVwOxZEfjocI1
        cydAnFRUc2KyVRykNKrPVN5DT2EsYqtxDz7X2zuSCtcuBUv2s9ZP5pjBqW4TeX+HmOqc8b4x1njq9
        mKHyrB0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leL5r-000dGS-J2; Wed, 05 May 2021 17:14:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 84/96] iomap: Convert iomap_page_release to take a folio
Date:   Wed,  5 May 2021 16:06:16 +0100
Message-Id: <20210505150628.111735-85-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_page_release() was also assuming that it was being passed a
head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 94d33b0a96ff..9f2d0df0837c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -59,18 +59,18 @@ iomap_page_create(struct inode *inode, struct folio *folio)
 	return iop;
 }
 
-static void
-iomap_page_release(struct page *page)
+static void iomap_page_release(struct folio *folio)
 {
-	struct iomap_page *iop = detach_page_private(page);
-	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
+	struct iomap_page *iop = folio_detach_private(folio);
+	unsigned int nr_blocks = i_blocks_per_folio(folio->mapping->host,
+							folio);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
-			PageUptodate(page));
+			folio_uptodate(folio));
 	kfree(iop);
 }
 
@@ -456,6 +456,8 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 int
 iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
+	struct folio *folio = page_folio(page);
+
 	trace_iomap_releasepage(page->mapping->host, page_offset(page),
 			PAGE_SIZE);
 
@@ -466,7 +468,7 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 	 */
 	if (PageDirty(page) || PageWriteback(page))
 		return 0;
-	iomap_page_release(page);
+	iomap_page_release(folio);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(iomap_releasepage);
@@ -474,6 +476,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
+	struct folio *folio = page_folio(page);
+
 	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
 	/*
@@ -483,7 +487,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	if (offset == 0 && len == PAGE_SIZE) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
-		iomap_page_release(page);
+		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
-- 
2.30.2

