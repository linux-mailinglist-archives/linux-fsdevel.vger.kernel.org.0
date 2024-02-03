Return-Path: <linux-fsdevel+bounces-10129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1496284843D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7282897EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026F50253;
	Sat,  3 Feb 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DB0SbFi6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC425024B;
	Sat,  3 Feb 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944348; cv=none; b=H0gDXq1kUhgeDU1XqWwVTNqpy7jdlAm0V+Unwd6Hgb5yUYYPKqxCP96xHFQic4w903fmEahlWFUWR87kWrh/HzFxdu7Ctx4bv85e7s2U1UPfBn8JC1JUbB/cAMJZf4f1sXYrWvrrhzBrlT0VwIkJ9gVoLXdd0VC5nxJpMa4geJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944348; c=relaxed/simple;
	bh=11+z648M91LOuAn70D5VUrpWYdA9g8PsbH50zJJGCu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5u+LLhxzZw3xdK+NeZSRWs/b/hzolAMeocimicWdKQ7wrA2a0LzGFDyb4rFClKj+IRsaAUVwldXxMbfLqvTG58MzEBAwhQj+CjBGG4rcruEtuFE+i/ozafOzENQjHenYLNjLXrc6YJioEkUx9cqZdVTK/2BaU5jZvnIFiNdP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DB0SbFi6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5NQ5foZwClGdjirNb4QF1J+mdWuoRYsiFuyY0APWPYw=; b=DB0SbFi6hUnk1R7j5iigmiLr5N
	wGakeqVDiyg/3UEtSiSGuXyTjawI0qc+3zilFXplt0yfm3V6765hxCRtqBaCEEbXRu6PmcijL0EwD
	ohFv1B6Ru53npud78X2mRjKDz+W8KfKClXbYz//sS9Rlej5EBI3FYmzdI0NGMiwddOLtapEwUWLxn
	xOakmAfp6pz1HZvZdZCjEVNJYQ8OON7wbu3bQautPLcydnJS0vvYHgPkMCCowSEe3fNMXKbop8vzO
	KCGYuP5WzsvA6ReigLFIw1MRl26nXVPe05zKKDjdM/xBnxIJJYynLn8OYg9q/pGoHyGTfCW9NxHyR
	jxtv/EuA==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACN-0000000Fk4w-1KJm;
	Sat, 03 Feb 2024 07:12:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] writeback: rework the loop termination condition in write_cache_pages
Date: Sat,  3 Feb 2024 08:11:39 +0100
Message-Id: <20240203071147.862076-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240203071147.862076-1-hch@lst.de>
References: <20240203071147.862076-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Rework the way we deal with the cleanup after the writepage call.

First handle the magic AOP_WRITEPAGE_ACTIVATE separately from real error
returns to get it out of the way of the actual error handling path.

The split the handling on intgrity vs non-integrity branches first,
and return early using a goto for the non-ingegrity early loop condition
to remove the need for the done and done_index local variables, and for
assigning the error to ret when we can just return error directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 84 ++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c7c494526bc650..88b2c4c111c01b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2396,13 +2396,12 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int ret = 0;
-	int done = 0;
 	int error;
 	struct folio_batch fbatch;
+	struct folio *folio;
 	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	pgoff_t done_index;
 	xa_mark_t tag;
 
 	folio_batch_init(&fbatch);
@@ -2419,8 +2418,7 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		tag = PAGECACHE_TAG_DIRTY;
 	}
-	done_index = index;
-	while (!done && (index <= end)) {
+	while (index <= end) {
 		int i;
 
 		nr_folios = filemap_get_folios_tag(mapping, &index, end,
@@ -2430,11 +2428,7 @@ int write_cache_pages(struct address_space *mapping,
 			break;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
-			unsigned long nr;
-
-			done_index = folio->index;
-
+			folio = fbatch.folios[i];
 			folio_lock(folio);
 
 			/*
@@ -2469,45 +2463,32 @@ int write_cache_pages(struct address_space *mapping,
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 			error = writepage(folio, wbc, data);
-			nr = folio_nr_pages(folio);
-			wbc->nr_to_write -= nr;
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
-					ret = error;
-					done_index = folio->index + nr;
-					done = 1;
-					break;
-				}
-				if (!ret)
-					ret = error;
+			wbc->nr_to_write -= folio_nr_pages(folio);
+
+			if (error == AOP_WRITEPAGE_ACTIVATE) {
+				folio_unlock(folio);
+				error = 0;
 			}
 
 			/*
-			 * We stop writing back only if we are not doing
-			 * integrity sync. In case of integrity sync we have to
-			 * keep going until we have written all the pages
-			 * we tagged for writeback prior to entering this loop.
+			 * For integrity writeback we have to keep going until
+			 * we have written all the folios we tagged for
+			 * writeback above, even if we run past wbc->nr_to_write
+			 * or encounter errors.
+			 * We stash away the first error we encounter in
+			 * wbc->saved_err so that it can be retrieved when we're
+			 * done.  This is because the file system may still have
+			 * state to clear for each folio.
+			 *
+			 * For background writeback we exit as soon as we run
+			 * past wbc->nr_to_write or encounter the first error.
 			 */
-			done_index = folio->index + nr;
-			if (wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE) {
-				done = 1;
-				break;
+			if (wbc->sync_mode == WB_SYNC_ALL) {
+				if (error && !ret)
+					ret = error;
+			} else {
+				if (error || wbc->nr_to_write <= 0)
+					goto done;
 			}
 		}
 		folio_batch_release(&fbatch);
@@ -2524,14 +2505,15 @@ int write_cache_pages(struct address_space *mapping,
 	 * of the file if we are called again, which can only happen due to
 	 * -ENOMEM from the file system.
 	 */
-	if (wbc->range_cyclic) {
-		if (done)
-			mapping->writeback_index = done_index;
-		else
-			mapping->writeback_index = 0;
-	}
-
+	if (wbc->range_cyclic)
+		mapping->writeback_index = 0;
 	return ret;
+
+done:
+	folio_batch_release(&fbatch);
+	if (wbc->range_cyclic)
+		mapping->writeback_index = folio->index + folio_nr_pages(folio);
+	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


