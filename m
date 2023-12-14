Return-Path: <linux-fsdevel+bounces-6066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB3181316D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EE91F22292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649D5645F;
	Thu, 14 Dec 2023 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFp/hA0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B46F136;
	Thu, 14 Dec 2023 05:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Rss8E0TEJ5ZWP+w65Q90ToBr5MzQatBIEX9ecM3F1aY=; b=SFp/hA0fghmYHxPZK8RDs0mSUs
	2dvs2+f6lfbzUR4ZepQ8+lOvHkqOAptEtwte/LyANyBKUX+HZd6mcog/IExGHXKJfcdRoQzhSEDVK
	9gl9L8NnOfFLsnDEvkTsvZZbvnfcHT60084SRlecI7C6UAQf90dwmCWmioA0g1syVyRezuHE2J+eF
	21bWWbXPoewfgvDtZgt262UOaoMZWqrFo31EMV17CZ/D0kysdzJ+M4j1lDjO8XJ42vlch6Vq549hE
	9UltZjPeJfE+jhxELs1O90Wb3pPSZRv3o+5Fg2ZUJ9i5WA/JSVcNZOnJTj+4nH5Fs+BxSmPDf0wae
	I2w0fc9g==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDljF-000N9J-2g;
	Thu, 14 Dec 2023 13:26:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 07/11] writeback: Factor writeback_iter_init() out of write_cache_pages()
Date: Thu, 14 Dec 2023 14:25:40 +0100
Message-Id: <20231214132544.376574-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214132544.376574-1-hch@lst.de>
References: <20231214132544.376574-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Make it return the first folio in the batch so that we can use it
in a typical for() pattern.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 47 +++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2243a0d1b2d3c7..8c220c6a7f824d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2429,6 +2429,28 @@ static bool should_writeback_folio(struct address_space *mapping,
 	return true;
 }
 
+static struct folio *writeback_iter_init(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	if (wbc->range_cyclic) {
+		wbc->index = mapping->writeback_index; /* prev offset */
+		wbc->end = -1;
+	} else {
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
+		wbc->end = wbc->range_end >> PAGE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			wbc->range_whole = 1;
+	}
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, wbc->end);
+
+	wbc->done_index = wbc->index;
+	folio_batch_init(&wbc->fbatch);
+	wbc->err = 0;
+
+	return writeback_get_next(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2464,31 +2486,14 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
+	struct folio *folio;
 	int error;
 
-	if (wbc->range_cyclic) {
-		wbc->index = mapping->writeback_index; /* prev offset */
-		wbc->end = -1;
-	} else {
-		wbc->index = wbc->range_start >> PAGE_SHIFT;
-		wbc->end = wbc->range_end >> PAGE_SHIFT;
-		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			wbc->range_whole = 1;
-	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, wbc->index, wbc->end);
-
-	wbc->done_index = wbc->index;
-	folio_batch_init(&wbc->fbatch);
-	wbc->err = 0;
-
-	for (;;) {
-		struct folio *folio = writeback_get_next(mapping, wbc);
+	for (folio = writeback_iter_init(mapping, wbc);
+	     folio;
+	     folio = writeback_get_next(mapping, wbc)) {
 		unsigned long nr;
 
-		if (!folio)
-			break;
-
 		wbc->done_index = folio->index;
 
 		folio_lock(folio);
-- 
2.39.2


