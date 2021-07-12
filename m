Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC03C4269
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhGLD7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhGLD7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:59:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDB2C0613DD;
        Sun, 11 Jul 2021 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nU85zF1nDx72HhYeZDfb7+vVuafNLS+zF0KSCNOiAd0=; b=PWRyBcm0n3ra7pCnZlYfARcqto
        j93FoJJKrJC3o88WVvIJRe+g2NkNiDgd4kHaJ07dtps7IbSAkCKj0BU6MXtjQbrLQBOywCSQwgZ6x
        4Vio5NLO9rLVHQ/I+V6nAelXrTA0dEQk6FzZkp4Qs77/7qAVsIasvZwzEhRUfxE7714qyM7f5vH5A
        VISxu8MVMrfODuANfjEz2URDnAdstmheY6QZRDTYMYeIGcFYK+CAbhy0OocOYvsJja0dwQhOUnmdT
        JHGZ4aoawegWu3VG1fg8DOfGCn/VYELuTd3ZvTXgfaAZe7VMcGXl8+sAMY/BxvLXngusNBepZtS2c
        lapTUwZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n31-00GqDB-J8; Mon, 12 Jul 2021 03:56:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 093/137] iomap: Convert iomap_page_release to take a folio
Date:   Mon, 12 Jul 2021 04:06:17 +0100
Message-Id: <20210712030701.4000097-94-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 257b15019ab6..30a884cf6a36 100644
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

