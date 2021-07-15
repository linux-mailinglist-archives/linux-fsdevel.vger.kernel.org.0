Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB33C97C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhGOEzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhGOEzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:55:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F397C06175F;
        Wed, 14 Jul 2021 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jfV+zEEcnxJ+DhZND5z0SG4OalByev6yzYkbL0tn2hE=; b=Mbiqa3b13unsIR40ldZq0Wv31q
        GhVF3IC6VWivBgyQYDsumfpAE5Hd4xCz82pXZyt7FzbVIDwT0Xgg7z6VquhuUeaB+tUAFyWgmwtIJ
        djRYkNPtTMdY2FG+qZZM0+OBIBzwr+z79eTqZS9DgTstH9mDmZD36NqhOoAFcIntmiY13/+IRpHV+
        PLOYz7CHqWI0T89VzK5fKSyxwxofetXQwjP1oHy57xUa66OktDxq/M35z9Gi0p/SgDQLSbX7trkzt
        Nz3cQVG6dHozvyuvPZkeJxzKRkHXcJRXer0LA+ewvBHP2HvivQM3AhtZj2J2+xW3JPeivxYyPv2BI
        yfE0mY5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tL1-002yuv-V8; Thu, 15 Jul 2021 04:51:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 094/138] iomap: Convert iomap_page_release to take a folio
Date:   Thu, 15 Jul 2021 04:36:20 +0100
Message-Id: <20210715033704.692967-95-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index c15a0ac52a32..251ec45426aa 100644
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
+			folio_test_uptodate(folio));
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

