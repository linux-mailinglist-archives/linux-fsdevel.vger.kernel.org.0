Return-Path: <linux-fsdevel+bounces-6381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC18817599
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFAA1F2447A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8905740A7;
	Mon, 18 Dec 2023 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/KNWRHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA174097;
	Mon, 18 Dec 2023 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lOde0PGi4Z6M7IdLHCKfLkz19eMYDieJg9XbB+ncAEo=; b=n/KNWRHzl0Vuw7qwMs1UYzUUD+
	itAzOZiMXFPZCbTYFwBvFV2uQpY3ZdylXEIWixZXWjNKLUCXFSQ57YVIbXC8wJScFm28gORoCP+Yi
	hZWQK8/6AkPBsNn7WjAHENXCNj+5xS1xxxEnfprZO2gzyaxOtGqdUqb9VYPWGt+1/ebCeTj52bMkV
	eEWxwgWKuQvWNHrgQpzFNaQqNPqCqaSsXje3yLomMY4ATq2rL67xi0bZijgTq8eTBV2zniKCTgGjs
	6yp0+AJIT0zWHgTOFWE15g4u0wKKgOI7K7XRNoilnqCmsKHJwS2V/24atVv67qSQSUEtUNZH/UU0Z
	vEC8Dhsg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfZ-00BEZB-0p;
	Mon, 18 Dec 2023 15:36:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] writeback: Factor writeback_iter_next() out of write_cache_pages()
Date: Mon, 18 Dec 2023 16:35:50 +0100
Message-Id: <20231218153553.807799-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218153553.807799-1-hch@lst.de>
References: <20231218153553.807799-1-hch@lst.de>
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
 mm/page-writeback.c | 85 ++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9d37dd5e58ffb6..0771f19950081f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2449,8 +2449,10 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 
 	for (;;) {
 		folio = writeback_get_next(mapping, wbc);
-		if (!folio)
+		if (!folio) {
+			writeback_finish(mapping, wbc, 0);
 			return NULL;
+		}
 		folio_lock(folio);
 		if (likely(should_writeback_folio(mapping, wbc, folio)))
 			break;
@@ -2477,6 +2479,46 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
+static struct folio *writeback_iter_next(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int error)
+{
+	unsigned long nr = folio_nr_pages(folio);
+
+	wbc->nr_to_write -= nr;
+
+	/*
+	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
+	 * Eventually all instances should just unlock the folio themselves and
+	 * return 0;
+	 */
+	if (error == AOP_WRITEPAGE_ACTIVATE) {
+		folio_unlock(folio);
+		error = 0;
+	}
+
+	if (error && !wbc->err)
+		wbc->err = error;
+
+	/*
+	 * For integrity sync  we have to keep going until we have written all
+	 * the folios we tagged for writeback prior to entering the writeback
+	 * loop, even if we run past wbc->nr_to_write or encounter errors.
+	 * This is because the file system may still have state to clear for
+	 * each folio.   We'll eventually return the first error encountered.
+	 *
+	 * For background writeback just push done_index past this folio so that
+	 * we can just restart where we left off and media errors won't choke
+	 * writeout for the entire file.
+	 */
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    (wbc->err || wbc->nr_to_write <= 0)) {
+		writeback_finish(mapping, wbc, folio->index + nr);
+		return NULL;
+	}
+
+	return writeback_get_folio(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2517,47 +2559,10 @@ int write_cache_pages(struct address_space *mapping,
 
 	for (folio = writeback_iter_init(mapping, wbc);
 	     folio;
-	     folio = writeback_get_folio(mapping, wbc)) {
-		unsigned long nr;
-
+	     folio = writeback_iter_next(mapping, wbc, folio, error))
 		error = writepage(folio, wbc, data);
-		nr = folio_nr_pages(folio);
-		wbc->nr_to_write -= nr;
-
-		/*
-		 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
-		 * Eventually all instances should just unlock the folio
-		 * themselves and return 0;
-		 */
-		if (error == AOP_WRITEPAGE_ACTIVATE) {
-			folio_unlock(folio);
-			error = 0;
-		}
-
-		if (error && !wbc->err)
-			wbc->err = error;
 
-		/*
-		 * For integrity sync  we have to keep going until we have
-		 * written all the folios we tagged for writeback prior to
-		 * entering this loop, even if we run past wbc->nr_to_write or
-		 * encounter errors.  This is because the file system may still
-		 * have state to clear for each folio.   We'll eventually return
-		 * the first error encountered.
-		 *
-		 * For background writeback just push done_index past this folio
-		 * so that we can just restart where we left off and media
-		 * errors won't choke writeout for the entire file.
-		 */
-		if (wbc->sync_mode == WB_SYNC_NONE &&
-		    (wbc->err || wbc->nr_to_write <= 0)) {
-			writeback_finish(mapping, wbc, folio->index + nr);
-			return error;
-		}
-	}
-
-	writeback_finish(mapping, wbc, 0);
-	return 0;
+	return wbc->err;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


