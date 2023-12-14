Return-Path: <linux-fsdevel+bounces-6068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54623813174
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F471F2221A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261556470;
	Thu, 14 Dec 2023 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D7Kg0BZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8A6114;
	Thu, 14 Dec 2023 05:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rO9jeRnP/+STXFpOLNVshKgFr5PxJQ0M9NIzpjYwpKk=; b=D7Kg0BZmQc0TuV5ZDIwkGWmB/U
	Zo/YYkysOcmLOYlozdFyDhxa/ft5aO9Cpo/k651xsSCKrfdaDuLo44vbjtNNrh2wJQ9+cchXfBLuq
	52wt6O1lBjWPFKacUOOT0H6TFOCL9zAmeCIUotwrsb6M0Ls/iKQoZdgpswJlT/0ecl/g6lqqJ1eTD
	GBt+L35/mOQ6ziE4gdB/7Px8A2gzSuvP4JaXARqb3q50wAVbCEFXdR0tscS9tuCrax0JCmgiAdGRp
	WH627gbw6OvYJO1pQ4KXk9boZ03t3PQWs9UTlHu/z27Y8n4kE/5UKpUwziRa5Zf4TxcquJiO/5XKV
	BTZpC1JA==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDljM-000NCz-2K;
	Thu, 14 Dec 2023 13:26:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 09/11] writeback: Factor writeback_iter_next() out of write_cache_pages()
Date: Thu, 14 Dec 2023 14:25:42 +0100
Message-Id: <20231214132544.376574-10-hch@lst.de>
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

Pull the post-processing of the writepage_t callback into a
separate function.  That means changing writeback_finish() to
return NULL, and writeback_get_next() to call writeback_finish()
when we naturally run out of folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 89 +++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b0accca1f4bfa7..4fae912f7a86e2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,7 +2360,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
-static int writeback_finish(struct address_space *mapping,
+static struct folio *writeback_finish(struct address_space *mapping,
 		struct writeback_control *wbc, bool done)
 {
 	folio_batch_release(&wbc->fbatch);
@@ -2375,7 +2375,7 @@ static int writeback_finish(struct address_space *mapping,
 	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = wbc->done_index;
 
-	return wbc->err;
+	return NULL;
 }
 
 static struct folio *writeback_get_next(struct address_space *mapping,
@@ -2437,7 +2437,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	for (;;) {
 		folio = writeback_get_next(mapping, wbc);
 		if (!folio)
-			return NULL;
+			return writeback_finish(mapping, wbc, false);
 		wbc->done_index = folio->index;
 
 		folio_lock(folio);
@@ -2472,6 +2472,47 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
+static struct folio *writeback_iter_next(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int error)
+{
+	unsigned long nr = folio_nr_pages(folio);
+
+	if (unlikely(error)) {
+		/*
+		 * Handle errors according to the type of writeback.
+		 * There's no need to continue for background writeback.
+		 * Just push done_index past this folio so media
+		 * errors won't choke writeout for the entire file.
+		 * For integrity writeback, we must process the entire
+		 * dirty set regardless of errors because the fs may
+		 * still have state to clear for each folio.  In that
+		 * case we continue processing and return the first error.
+		 */
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		} else if (wbc->sync_mode != WB_SYNC_ALL) {
+			wbc->err = error;
+			wbc->done_index = folio->index + nr;
+			return writeback_finish(mapping, wbc, true);
+		}
+		if (!wbc->err)
+			wbc->err = error;
+	}
+
+	/*
+	 * We stop writing back only if we are not doing integrity
+	 * sync. In case of integrity sync we have to keep going until
+	 * we have written all the folios we tagged for writeback prior
+	 * to entering this loop.
+	 */
+	wbc->nr_to_write -= nr;
+	if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
+		return writeback_finish(mapping, wbc, true);
+
+	return writeback_get_folio(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2512,49 +2553,11 @@ int write_cache_pages(struct address_space *mapping,
 
 	for (folio = writeback_iter_init(mapping, wbc);
 	     folio;
-	     folio = writeback_get_folio(mapping, wbc)) {
-		unsigned long nr;
-
+	     folio = writeback_iter_next(mapping, wbc, folio, error)) {
 		error = writepage(folio, wbc, data);
-		nr = folio_nr_pages(folio);
-		if (unlikely(error)) {
-			/*
-			 * Handle errors according to the type of
-			 * writeback. There's no need to continue for
-			 * background writeback. Just push done_index
-			 * past this page so media errors won't choke
-			 * writeout for the entire file. For integrity
-			 * writeback, we must process the entire dirty
-			 * set regardless of errors because the fs may
-			 * still have state to clear for each page. In
-			 * that case we continue processing and return
-			 * the first error.
-			 */
-			if (error == AOP_WRITEPAGE_ACTIVATE) {
-				folio_unlock(folio);
-				error = 0;
-			} else if (wbc->sync_mode != WB_SYNC_ALL) {
-				wbc->err = error;
-				wbc->done_index = folio->index + nr;
-				return writeback_finish(mapping, wbc, true);
-			}
-			if (!wbc->err)
-				wbc->err = error;
-		}
-
-		/*
-		 * We stop writing back only if we are not doing
-		 * integrity sync. In case of integrity sync we have to
-		 * keep going until we have written all the pages
-		 * we tagged for writeback prior to entering this loop.
-		 */
-		wbc->nr_to_write -= nr;
-		if (wbc->nr_to_write <= 0 &&
-		    wbc->sync_mode == WB_SYNC_NONE)
-			return writeback_finish(mapping, wbc, true);
 	}
 
-	return writeback_finish(mapping, wbc, false);
+	return wbc->err;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


