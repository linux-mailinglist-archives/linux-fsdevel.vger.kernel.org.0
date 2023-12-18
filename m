Return-Path: <linux-fsdevel+bounces-6376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38981758A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D01E1C24CDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6657146B;
	Mon, 18 Dec 2023 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DfogWbTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB642378;
	Mon, 18 Dec 2023 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9E46P8RBBTh6OS7XsshX1gEfzWzF0rjfwCHf/2TCoS8=; b=DfogWbTovC+MaOjnIwtN1k+ufe
	43Ts4mac1JK2rDHqW2s9mobtENbKUfR9BFoKwLFg1BcjgMQ/GLdPgjocsslPLAvmryBkB+L6aBzFd
	4f2bI16jaiAJ26Qxe8VT2ft+yHYcDpYUO4wZZ0CHOua1wdkZm/mH7Yml1PKCixNZ4/egD9MPx9yG5
	v8SBQAHvbwgiAd3NzfUQUr96kLLHmE17pRAuOmQu3Y0G9xI54rO+mUK3+sHk+j57wTC5j5rMCEMXx
	+wxkIw4M6tuiC9vd/QjEMHqBqbxQtz1uRFx2lutS1EQnjOZt5+jkyHdqmKI58AU1hOHa774zf+XRm
	vMF4vlvQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfH-00BEQj-3D;
	Mon, 18 Dec 2023 15:36:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] writeback: Simplify the loops in write_cache_pages()
Date: Mon, 18 Dec 2023 16:35:45 +0100
Message-Id: <20231218153553.807799-10-hch@lst.de>
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

Collapse the two nested loops into one.  This is needed as a step
towards turning this into an iterator.

Note that this drops the "index <= end" check in the previous outer loop
and just relies on filemap_get_folios_tag() to return 0 entries when
index > end.  This actually has a subtle implication when end == -1
because then the returned index will be -1 as well and thus if there is
page present on index -1, we could be looping indefinitely. But as the
comment in filemap_get_folios_tag documents this as already broken anyway
we should not worry about it here either.  The fix for that would
probably a change to the filemap_get_folios_tag() calling convention.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: updated the commit log based on feedback from Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 94 ++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2a004c0b9bdfbf..c7983ea3040be4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2473,6 +2473,7 @@ int write_cache_pages(struct address_space *mapping,
 {
 	int error;
 	pgoff_t end;		/* Inclusive */
+	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2487,63 +2488,60 @@ int write_cache_pages(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (wbc->index <= end) {
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
+		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 
-			error = writepage(folio, wbc, data);
-			nr = folio_nr_pages(folio);
-			wbc->nr_to_write -= nr;
+		error = writepage(folio, wbc, data);
+		nr = folio_nr_pages(folio);
+		wbc->nr_to_write -= nr;
 
-			/*
-			 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return
-			 * value.  Eventually all instances should just unlock
-			 * the folio themselves and return 0;
-			 */
-			if (error == AOP_WRITEPAGE_ACTIVATE) {
-				folio_unlock(folio);
-				error = 0;
-			}
-		
-			if (error && !wbc->err)
-				wbc->err = error;
+		/*
+		 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
+		 * Eventually all instances should just unlock the folio
+		 * themselves and return 0;
+		 */
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		}
 
-			/*
-			 * For integrity sync  we have to keep going until we
-			 * have written all the folios we tagged for writeback
-			 * prior to entering this loop, even if we run past
-			 * wbc->nr_to_write or encounter errors.  This is
-			 * because the file system may still have state to clear
-			 * for each folio.   We'll eventually return the first
-			 * error encountered.
-			 *
-			 * For background writeback just push done_index past
-			 * this folio so that we can just restart where we left
-			 * off and media errors won't choke writeout for the
-			 * entire file.
-			 */
-			if (wbc->sync_mode == WB_SYNC_NONE &&
-			    (wbc->err || wbc->nr_to_write <= 0)) {
-				writeback_finish(mapping, wbc,
-						folio->index + nr);
-				return error;
-			}
+		if (error && !wbc->err)
+			wbc->err = error;
+
+		/*
+		 * For integrity sync  we have to keep going until we have
+		 * written all the folios we tagged for writeback prior to
+		 * entering this loop, even if we run past wbc->nr_to_write or
+		 * encounter errors.  This is because the file system may still
+		 * have state to clear for each folio.   We'll eventually return
+		 * the first error encountered.
+		 *
+		 * For background writeback just push done_index past this folio
+		 * so that we can just restart where we left off and media
+		 * errors won't choke writeout for the entire file.
+		 */
+		if (wbc->sync_mode == WB_SYNC_NONE &&
+		    (wbc->err || wbc->nr_to_write <= 0)) {
+			writeback_finish(mapping, wbc, folio->index + nr);
+			return error;
 		}
 	}
 
-- 
2.39.2


