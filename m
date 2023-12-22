Return-Path: <linux-fsdevel+bounces-6799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECE81CBD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207AE1F2674B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CD2E629;
	Fri, 22 Dec 2023 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1fWeY1tU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164942D794;
	Fri, 22 Dec 2023 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=o5H/XSwme7xEQtHV3m+ZJ3LCmsROSQ4hprrOJy3ayZQ=; b=1fWeY1tUuYOLXS4fYxt9eNpkZL
	uPDqWxlQRvE8go0ce8UcYudxrGF1l7Hsi2GJtUTlfsjpr+mucLE+tfcAIVoKgfxQNTLFBiMF7r/DY
	p038ichTWr69GTwEoBsSaNQuiXLmrhkToyxTmt+UC6O7wN0TyO8qBzkZeaUvRE0kPxYvKDXxGxOYW
	qHtxgdaRB9TK1g1hTe9EdhIoxKGVVqmmdo87DBp/9uLtiOOZj6aPO9zZLjWLCNCMR4p2Qcq3bJU/Y
	QrtkzDepUlCDu+3TMC/L214GlcREtVp+DAjwQOMC012XRtoSbmzTX27ToGjrv8hTtpiMxBwlg65sf
	8wjZTjvw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh8w-006BVk-2h;
	Fri, 22 Dec 2023 15:08:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 11/17] writeback: Use the folio_batch queue iterator
Date: Fri, 22 Dec 2023 16:08:21 +0100
Message-Id: <20231222150827.1329938-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231222150827.1329938-1-hch@lst.de>
References: <20231222150827.1329938-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Instead of keeping our own local iterator variable, use the one just
added to folio_batch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d62bc3498ed975..47457895891221 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2429,13 +2429,21 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 	return true;
 }
 
-static void writeback_get_batch(struct address_space *mapping,
+static struct folio *writeback_get_folio(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	folio_batch_release(&wbc->fbatch);
-	cond_resched();
-	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
-			wbc_to_tag(wbc), &wbc->fbatch);
+	struct folio *folio;
+
+	folio = folio_batch_next(&wbc->fbatch);
+	if (!folio) {
+		folio_batch_release(&wbc->fbatch);
+		cond_resched();
+		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
+				wbc_to_tag(wbc), &wbc->fbatch);
+		folio = folio_batch_next(&wbc->fbatch);
+	}
+
+	return folio;
 }
 
 /**
@@ -2475,7 +2483,6 @@ int write_cache_pages(struct address_space *mapping,
 {
 	int error;
 	pgoff_t end;		/* Inclusive */
-	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2491,18 +2498,12 @@ int write_cache_pages(struct address_space *mapping,
 	wbc->err = 0;
 
 	for (;;) {
-		struct folio *folio;
+		struct folio *folio = writeback_get_folio(mapping, wbc);
 		unsigned long nr;
 
-		if (i == wbc->fbatch.nr) {
-			writeback_get_batch(mapping, wbc);
-			i = 0;
-		}
-		if (wbc->fbatch.nr == 0)
+		if (!folio)
 			break;
 
-		folio = wbc->fbatch.folios[i++];
-
 		folio_lock(folio);
 		if (!folio_prepare_writeback(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


