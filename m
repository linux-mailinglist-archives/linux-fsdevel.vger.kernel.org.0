Return-Path: <linux-fsdevel+bounces-6800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622E81CBD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5750FB2259F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0D2E827;
	Fri, 22 Dec 2023 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yfQSDflm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF02E643;
	Fri, 22 Dec 2023 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uhQwu0XzlF9g6tYMy5v46u1+umuzBvOukQsb3rulW5U=; b=yfQSDflmOsFoQUBv7S0oxf31Lt
	bA8UjbacePhce939zrO4Ir44tqLbrgyX1i5WWUPFn1Dh+11PMGev7lVY8wnZureYjbZsYuESrU/5W
	7r7TRMZJi1BVUw35tzYKJsGhRRphnMJlwuQRlfFG7hoKMPvs2RHHddSnKmZ5Zo6xy79keEUFELCWb
	di7aVlxzJVcxNMi/KVCgAn/kv4q2J3SRszZOCJqDD9t8X6NkbjyqzvwY30OmTwG+hrdVwHprkayFJ
	byFe+UZ+5u414GPfeJPQCofOizDxVA0C4ZgEqEEGUVbFOp5tujEidQTo2hVAYbvVDVsV6qignOnCn
	L7ZBVhGw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh8z-006BXA-0y;
	Fri, 22 Dec 2023 15:08:57 +0000
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
Subject: [PATCH 12/17] writeback: Factor writeback_iter_init() out of write_cache_pages()
Date: Fri, 22 Dec 2023 16:08:22 +0100
Message-Id: <20231222150827.1329938-13-hch@lst.de>
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

Make it return the first folio in the batch so that we can use it
in a typical for() pattern.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 47457895891221..f85145f330bb36 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2446,6 +2446,22 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
+static struct folio *writeback_iter_init(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	if (wbc->range_cyclic)
+		wbc->index = mapping->writeback_index; /* prev offset */
+	else
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, wbc_end(wbc));
+
+	wbc->err = 0;
+	folio_batch_init(&wbc->fbatch);
+	return writeback_get_folio(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2481,29 +2497,14 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
+	struct folio *folio;
 	int error;
-	pgoff_t end;		/* Inclusive */
 
-	if (wbc->range_cyclic) {
-		wbc->index = mapping->writeback_index; /* prev offset */
-		end = -1;
-	} else {
-		wbc->index = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
-	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, wbc->index, end);
-
-	folio_batch_init(&wbc->fbatch);
-	wbc->err = 0;
-
-	for (;;) {
-		struct folio *folio = writeback_get_folio(mapping, wbc);
+	for (folio = writeback_iter_init(mapping, wbc);
+	     folio;
+	     folio = writeback_get_folio(mapping, wbc)) {
 		unsigned long nr;
 
-		if (!folio)
-			break;
-
 		folio_lock(folio);
 		if (!folio_prepare_writeback(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


