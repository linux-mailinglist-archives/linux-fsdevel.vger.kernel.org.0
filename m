Return-Path: <linux-fsdevel+bounces-11654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E25855A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019C0B2725E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AA1C29B;
	Thu, 15 Feb 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjdPwyrd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60291BDFA;
	Thu, 15 Feb 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979053; cv=none; b=BowhPFKl5yczNLsd0rdeQezP4a1/ed/OSgfc9DYKZ8uF3B4NmsuPtc4zjWlWEWl1dy1c0H6TIkA/v0aRp76170ZxR2kHrU/Uw4IKjd+X8mFwoeOTsYzMeTdwuheHh5+useEG7+lGcMtTT2cY1KTwYJEU+TBERImMWpAor3Kaw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979053; c=relaxed/simple;
	bh=f70EuXWutIsxPHOsAOj2R3FRoouerXZKSWOODgm5yo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Es2Uy+i8VXePiwUO8a/72GuAIMooIRs8POse/ngxu26UUa7h/ZEraXio14NaZVKv252aV6VyTr9xXKVhtKB50ZGR5rck6hO90qndLzq+2j1c/OM2kWIbKPrJy/no2s6S3bGdH5qA9BGsqYVprZabiFHY1ySgMQkzCAzt/JYAJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QjdPwyrd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OECBbDLIiwPC3FYe8tkqoQZRVMW91GpPrLleij5hqbk=; b=QjdPwyrdAWQtgMvuz6HvA9OaPL
	+rJ+zC0xNw3KqgNiPdHKWpsrHoOXbjtlmCwBr7OU/IJ+LBKj7D8ZbteSOhfRdHIZyYpNZ5gZ6POcu
	2gsFFj8UgqwQHL6YprBdHZYIvZKHpnFb0SA/DISEiWAY7XU/3S/k+DBBLCBM5OaV8EDFTY8qgZcFi
	1ci70GwBs3EQTYtReC0VoeEPJXxMJksS0IR23qonnVZvPnPOydv/NWt/cN0V2T4GNZsUqQ1Y/ei3t
	H+8lJCxYF4Q6V78mLVu52f3+FjyjDVtOG5//o7xN5BMjEk56XY/2OrNgp/bDZeuoxnAkCQj/BqJfY
	W9MdGamA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVNB-0000000F72u-2aI7;
	Thu, 15 Feb 2024 06:37:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 13/14] writeback: add a writeback iterator
Date: Thu, 15 Feb 2024 07:36:48 +0100
Message-Id: <20240215063649.2164017-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Refactor the code left in write_cache_pages into an iterator that the
file system can call to get the next folio for a writeback operation:

	struct folio *folio = NULL;

	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
		error = <do per-folio writeback>;
	}

The twist here is that the error value is passed by reference, so that
the iterator can restore it when breaking out of the loop.

Handling of the magic AOP_WRITEPAGE_ACTIVATE value stays outside the
iterator and needs is just kept in the write_cache_pages legacy wrapper.
in preparation for eventually killing it off.

Heavily based on a for_each* based iterator from Matthew Wilcox.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/writeback.h |   4 +
 mm/page-writeback.c       | 192 ++++++++++++++++++++++----------------
 2 files changed, 118 insertions(+), 78 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index f67b3ea866a0fb..9845cb62e40b2d 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -82,6 +82,7 @@ struct writeback_control {
 	/* internal fields used by the ->writepages implementation: */
 	struct folio_batch fbatch;
 	pgoff_t index;
+	int saved_err;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
@@ -366,6 +367,9 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
+struct folio *writeback_iter(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int *error);
+
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fc421402f81881..3da4345f08a335 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2325,18 +2325,18 @@ void __init page_writeback_init(void)
 }
 
 /**
- * tag_pages_for_writeback - tag pages to be written by write_cache_pages
+ * tag_pages_for_writeback - tag pages to be written by writeback
  * @mapping: address space structure to write
  * @start: starting page index
  * @end: ending page index (inclusive)
  *
  * This function scans the page range from @start to @end (inclusive) and tags
- * all pages that have DIRTY tag set with a special TOWRITE tag. The idea is
- * that write_cache_pages (or whoever calls this function) will then use
- * TOWRITE tag to identify pages eligible for writeback.  This mechanism is
- * used to avoid livelocking of writeback by a process steadily creating new
- * dirty pages in the file (thus it is important for this function to be quick
- * so that it can tag pages faster than a dirtying process can create them).
+ * all pages that have DIRTY tag set with a special TOWRITE tag.  The caller
+ * can then use the TOWRITE tag to identify pages eligible for writeback.
+ * This mechanism is used to avoid livelocking of writeback by a process
+ * steadily creating new dirty pages in the file (thus it is important for this
+ * function to be quick so that it can tag pages faster than a dirtying process
+ * can create them).
  */
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end)
@@ -2434,69 +2434,68 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 }
 
 /**
- * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
+ * writeback_iter - iterate folio of a mapping for writeback
  * @mapping: address space structure to write
- * @wbc: subtract the number of written pages from *@wbc->nr_to_write
- * @writepage: function called for each page
- * @data: data passed to writepage function
+ * @wbc: writeback context
+ * @folio: previously iterated folio (%NULL to start)
+ * @error: in-out pointer for writeback errors (see below)
  *
- * If a page is already under I/O, write_cache_pages() skips it, even
- * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
- * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
- * and msync() need to guarantee that all the data which was dirty at the time
- * the call was made get new I/O started against them.  If wbc->sync_mode is
- * WB_SYNC_ALL then we were called for data integrity and we must wait for
- * existing IO to complete.
- *
- * To avoid livelocks (when other process dirties new pages), we first tag
- * pages which should be written back with TOWRITE tag and only then start
- * writing them. For data-integrity sync we have to be careful so that we do
- * not miss some pages (e.g., because some other process has cleared TOWRITE
- * tag we set). The rule we follow is that TOWRITE tag can be cleared only
- * by the process clearing the DIRTY tag (and submitting the page for IO).
- *
- * To avoid deadlocks between range_cyclic writeback and callers that hold
- * pages in PageWriteback to aggregate IO until write_cache_pages() returns,
- * we do not loop back to the start of the file. Doing so causes a page
- * lock/page writeback access order inversion - we should only ever lock
- * multiple pages in ascending page->index order, and looping back to the start
- * of the file violates that rule and causes deadlocks.
+ * This function returns the next folio for the writeback operation described by
+ * @wbc on @mapping and  should be called in a while loop in the ->writepages
+ * implementation.
  *
- * Return: %0 on success, negative error code otherwise
+ * To start the writeback operation, %NULL is passed in the @folio argument, and
+ * for every subsequent iteration the folio returned previously should be passed
+ * back in.
+ *
+ * If there was an error in the per-folio writeback inside the writeback_iter()
+ * loop, @error should be set to the error value.
+ *
+ * Once the writeback described in @wbc has finished, this function will return
+ * %NULL and if there was an error in any iteration restore it to @error.
+ *
+ * Note: callers should not manually break out of the loop using break or goto
+ * but must keep calling writeback_iter() until it returns %NULL.
+ *
+ * Return: the folio to write or %NULL if the loop is done.
  */
-int write_cache_pages(struct address_space *mapping,
-		      struct writeback_control *wbc, writepage_t writepage,
-		      void *data)
+struct folio *writeback_iter(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int *error)
 {
-	int ret = 0;
-	int error;
-	struct folio *folio;
-	pgoff_t end;		/* Inclusive */
-
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
+	if (!folio) {
+		folio_batch_init(&wbc->fbatch);
+		wbc->saved_err = *error = 0;
 
-	for (;;) {
-		folio = writeback_get_folio(mapping, wbc);
-		if (!folio)
-			break;
+		/*
+		 * For range cyclic writeback we remember where we stopped so
+		 * that we can continue where we stopped.
+		 *
+		 * For non-cyclic writeback we always start at the beginning of
+		 * the passed in range.
+		 */
+		if (wbc->range_cyclic)
+			wbc->index = mapping->writeback_index;
+		else
+			wbc->index = wbc->range_start >> PAGE_SHIFT;
 
-		error = writepage(folio, wbc, data);
+		/*
+		 * To avoid livelocks when other processes dirty new pages, we
+		 * first tag pages which should be written back and only then
+		 * start writing them.
+		 *
+		 * For data-integrity writeback we have to be careful so that we
+		 * do not miss some pages (e.g., because some other process has
+		 * cleared the TOWRITE tag we set).  The rule we follow is that
+		 * TOWRITE tag can be cleared only by the process clearing the
+		 * DIRTY tag (and submitting the page for I/O).
+		 */
+		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+			tag_pages_for_writeback(mapping, wbc->index,
+					wbc_end(wbc));
+	} else {
 		wbc->nr_to_write -= folio_nr_pages(folio);
 
-		if (error == AOP_WRITEPAGE_ACTIVATE) {
-			folio_unlock(folio);
-			error = 0;
-		}
+		WARN_ON_ONCE(*error > 0);
 
 		/*
 		 * For integrity writeback we have to keep going until we have
@@ -2510,33 +2509,70 @@ int write_cache_pages(struct address_space *mapping,
 		 * wbc->nr_to_write or encounter the first error.
 		 */
 		if (wbc->sync_mode == WB_SYNC_ALL) {
-			if (error && !ret)
-				ret = error;
+			if (*error && !wbc->saved_err)
+				wbc->saved_err = *error;
 		} else {
-			if (error || wbc->nr_to_write <= 0)
+			if (*error || wbc->nr_to_write <= 0)
 				goto done;
 		}
 	}
 
-	/*
-	 * For range cyclic writeback we need to remember where we stopped so
-	 * that we can continue there next time we are called.  If  we hit the
-	 * last page and there is more work to be done, wrap back to the start
-	 * of the file.
-	 *
-	 * For non-cyclic writeback we always start looking up at the beginning
-	 * of the file if we are called again, which can only happen due to
-	 * -ENOMEM from the file system.
-	 */
-	folio_batch_release(&wbc->fbatch);
-	if (wbc->range_cyclic)
-		mapping->writeback_index = 0;
-	return ret;
+	folio = writeback_get_folio(mapping, wbc);
+	if (!folio) {
+		/*
+		 * To avoid deadlocks between range_cyclic writeback and callers
+		 * that hold pages in PageWriteback to aggregate I/O until
+		 * the writeback iteration finishes, we do not loop back to the
+		 * start of the file.  Doing so causes a page lock/page
+		 * writeback access order inversion - we should only ever lock
+		 * multiple pages in ascending page->index order, and looping
+		 * back to the start of the file violates that rule and causes
+		 * deadlocks.
+		 */
+		if (wbc->range_cyclic)
+			mapping->writeback_index = 0;
+
+		/*
+		 * Return the first error we encountered (if there was any) to
+		 * the caller.
+		 */
+		*error = wbc->saved_err;
+	}
+	return folio;
 
 done:
 	if (wbc->range_cyclic)
 		mapping->writeback_index = folio->index + folio_nr_pages(folio);
 	folio_batch_release(&wbc->fbatch);
+	return NULL;
+}
+
+/**
+ * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
+ * @mapping: address space structure to write
+ * @wbc: subtract the number of written pages from *@wbc->nr_to_write
+ * @writepage: function called for each page
+ * @data: data passed to writepage function
+ *
+ * Return: %0 on success, negative error code otherwise
+ *
+ * Note: please use writeback_iter() instead.
+ */
+int write_cache_pages(struct address_space *mapping,
+		      struct writeback_control *wbc, writepage_t writepage,
+		      void *data)
+{
+	struct folio *folio = NULL;
+	int error;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		error = writepage(folio, wbc, data);
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		}
+	}
+
 	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
-- 
2.39.2


