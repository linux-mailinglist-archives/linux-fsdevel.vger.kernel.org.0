Return-Path: <linux-fsdevel+bounces-6063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AF81316A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5282D1F22245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E205644D;
	Thu, 14 Dec 2023 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZ6CWZpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C410F;
	Thu, 14 Dec 2023 05:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zsw+wTmwL88dMqXlPcddKLu64UsXn5iiu6gG3sd2+gI=; b=JZ6CWZpvcy4fuseqmY16OrM6T8
	DbXX6t3lj9ucqim23WY1gzee/6CX0nKn2g1UGzhIl2Vjl8NqcFnlOjHFx+i9aShIaD+KleTN+MN9q
	X7T1cilqrP7e/fXlwM0bTTUjg9Iv4bOJiYqBzd7mvGl+LE8Uj5gfWVsCOyfKrYaFUuET31z4jAV7Y
	fm6r1Lcfc7Id7k+6JZ3terQhgtjm9suIj9kXItRzdauXLUZH0Z9wPJzul1PHW8hhpPBD0uiF9t3Cr
	hAI+CngOjGT9f/ip71qJ76kPXnqmTz2ydFkRfCHN+Umo8Ilu5I9VdRD4Zgntp4KrbwgzBzWBGx5uL
	kjRLq/yQ==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDlj5-000N3y-0Z;
	Thu, 14 Dec 2023 13:26:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 04/11] writeback: Simplify the loops in write_cache_pages()
Date: Thu, 14 Dec 2023 14:25:37 +0100
Message-Id: <20231214132544.376574-5-hch@lst.de>
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

Collapse the two nested loops into one.  This is needed as a step
towards turning this into an iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 98 ++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 5a3df8665ff4f9..2087d16115710e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2460,6 +2460,7 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
+	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2477,67 +2478,66 @@ int write_cache_pages(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (wbc->index <= wbc->end) {
-		int i;
-
-		writeback_get_batch(mapping, wbc);
+	for (;;) {
+		struct folio *folio;
+		unsigned long nr;
 
+		if (i == wbc->fbatch.nr) {
+			writeback_get_batch(mapping, wbc);
+			i = 0;
+		}
 		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < wbc->fbatch.nr; i++) {
-			struct folio *folio = wbc->fbatch.folios[i];
-			unsigned long nr;
+		folio = wbc->fbatch.folios[i++];
 
-			wbc->done_index = folio->index;
+		wbc->done_index = folio->index;
 
-			folio_lock(folio);
-			if (!should_writeback_folio(mapping, wbc, folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		folio_lock(folio);
+		if (!should_writeback_folio(mapping, wbc, folio)) {
+			folio_unlock(folio);
+			continue;
+		}
 
-			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
-			error = writepage(folio, wbc, data);
-			nr = folio_nr_pages(folio);
-			if (unlikely(error)) {
-				/*
-				 * Handle errors according to the type of
-				 * writeback. There's no need to continue for
-				 * background writeback. Just push done_index
-				 * past this page so media errors won't choke
-				 * writeout for the entire file. For integrity
-				 * writeback, we must process the entire dirty
-				 * set regardless of errors because the fs may
-				 * still have state to clear for each page. In
-				 * that case we continue processing and return
-				 * the first error.
-				 */
-				if (error == AOP_WRITEPAGE_ACTIVATE) {
-					folio_unlock(folio);
-					error = 0;
-				} else if (wbc->sync_mode != WB_SYNC_ALL) {
-					wbc->err = error;
-					wbc->done_index = folio->index + nr;
-					return writeback_finish(mapping,
-							wbc, true);
-				}
-				if (!wbc->err)
-					wbc->err = error;
-			}
+		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 
+		error = writepage(folio, wbc, data);
+		nr = folio_nr_pages(folio);
+		if (unlikely(error)) {
 			/*
-			 * We stop writing back only if we are not doing
-			 * integrity sync. In case of integrity sync we have to
-			 * keep going until we have written all the pages
-			 * we tagged for writeback prior to entering this loop.
+			 * Handle errors according to the type of
+			 * writeback. There's no need to continue for
+			 * background writeback. Just push done_index
+			 * past this page so media errors won't choke
+			 * writeout for the entire file. For integrity
+			 * writeback, we must process the entire dirty
+			 * set regardless of errors because the fs may
+			 * still have state to clear for each page. In
+			 * that case we continue processing and return
+			 * the first error.
 			 */
-			wbc->nr_to_write -= nr;
-			if (wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE)
+			if (error == AOP_WRITEPAGE_ACTIVATE) {
+				folio_unlock(folio);
+				error = 0;
+			} else if (wbc->sync_mode != WB_SYNC_ALL) {
+				wbc->err = error;
+				wbc->done_index = folio->index + nr;
 				return writeback_finish(mapping, wbc, true);
+			}
+			if (!wbc->err)
+				wbc->err = error;
 		}
+
+		/*
+		 * We stop writing back only if we are not doing
+		 * integrity sync. In case of integrity sync we have to
+		 * keep going until we have written all the pages
+		 * we tagged for writeback prior to entering this loop.
+		 */
+		wbc->nr_to_write -= nr;
+		if (wbc->nr_to_write <= 0 &&
+		    wbc->sync_mode == WB_SYNC_NONE)
+			return writeback_finish(mapping, wbc, true);
 	}
 
 	return writeback_finish(mapping, wbc, false);
-- 
2.39.2


