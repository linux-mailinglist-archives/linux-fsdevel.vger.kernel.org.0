Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE30482BD6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jan 2022 17:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiABQTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 11:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiABQTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:19:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF443C061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=En0oSa/LnR9VLMM+5fg869TVjgVIB/J4D2K0fck/qmg=; b=GMmFJeENqpepvZS0C6o+GjZsCs
        vroauU1qz8nlE2sK7sVSDbDwqr5kMG9TygUKsxmD3SHmW6nRgtJISFVu3+LCN11ToqKHY3PhZDrkS
        akGC9Q5dTdgufI5EXGhWR01NsW2USkosya6eWUH0JoFbOBewLpSQpLlLmmDuDRHD5nXAKrDXJRzX2
        Ik1WRplBN0qyLIGfDudlbakioRIQAEMAlnqCcARVMGDHDz7OvHSFJJvuRt++QqlPcau2wASg5Tb7h
        gu1o56akDAA6O+3xXdoXIHUU+42aTMxqirEugC+IE7pv6ivKg9zIyPkYkam95mUWkCJ4xtR3JIgLr
        KacqcBXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n43a9-00C9k9-2k; Sun, 02 Jan 2022 16:19:41 +0000
Date:   Sun, 2 Jan 2022 16:19:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
Message-ID: <YdHQnSqA10iwhJ85@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
> This all passes xfstests with no new failures on both xfs and tmpfs.
> I intend to put all this into for-next tomorrow.

As a result of Christoph's review, here's the diff.  I don't
think it's worth re-posting the entire patch series.


diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 7d3494f7fb70..dda8d5868c81 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -18,6 +18,7 @@ struct page;
 struct folio;
 struct address_space;
 
+/* Layout must match folio_batch */
 struct pagevec {
 	unsigned char nr;
 	bool percpu_pvec_drained;
@@ -85,17 +86,22 @@ static inline void pagevec_release(struct pagevec *pvec)
  * struct folio_batch - A collection of folios.
  *
  * The folio_batch is used to amortise the cost of retrieving and
- * operating on a set of folios.  The order of folios in the batch is
- * not considered important.  Some users of the folio_batch store
- * "exceptional" entries in it which can be removed by calling
- * folio_batch_remove_exceptionals().
+ * operating on a set of folios.  The order of folios in the batch may be
+ * significant (eg delete_from_page_cache_batch()).  Some users of the
+ * folio_batch store "exceptional" entries in it which can be removed
+ * by calling folio_batch_remove_exceptionals().
  */
 struct folio_batch {
 	unsigned char nr;
-	unsigned char aux[3];
+	bool percpu_pvec_drained;
 	struct folio *folios[PAGEVEC_SIZE];
 };
 
+/* Layout must match pagevec */
+static_assert(sizeof(struct pagevec) == sizeof(struct folio_batch));
+static_assert(offsetof(struct pagevec, pages) ==
+		offsetof(struct folio_batch, folios));
+
 /**
  * folio_batch_init() - Initialise a batch of folios
  * @fbatch: The folio batch.
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 8479cf46b5b1..781d98d96611 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -150,7 +150,7 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
 static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
-	return copy_page_to_iter((struct page *)folio, offset, bytes, i);
+	return copy_page_to_iter(&folio->page, offset, bytes, i);
 }
 
 static __always_inline __must_check
diff --git a/mm/filemap.c b/mm/filemap.c
index 9b5b2d962c37..33077c264d79 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3451,45 +3451,12 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 	if (folio_test_uptodate(folio))
 		goto out;
 
-	/*
-	 * Page is not up to date and may be locked due to one of the following
-	 * case a: Page is being filled and the page lock is held
-	 * case b: Read/write error clearing the page uptodate status
-	 * case c: Truncation in progress (page locked)
-	 * case d: Reclaim in progress
-	 *
-	 * Case a, the page will be up to date when the page is unlocked.
-	 *    There is no need to serialise on the page lock here as the page
-	 *    is pinned so the lock gives no additional protection. Even if the
-	 *    page is truncated, the data is still valid if PageUptodate as
-	 *    it's a race vs truncate race.
-	 * Case b, the page will not be up to date
-	 * Case c, the page may be truncated but in itself, the data may still
-	 *    be valid after IO completes as it's a read vs truncate race. The
-	 *    operation must restart if the page is not uptodate on unlock but
-	 *    otherwise serialising on page lock to stabilise the mapping gives
-	 *    no additional guarantees to the caller as the page lock is
-	 *    released before return.
-	 * Case d, similar to truncation. If reclaim holds the page lock, it
-	 *    will be a race with remove_mapping that determines if the mapping
-	 *    is valid on unlock but otherwise the data is valid and there is
-	 *    no need to serialise with page lock.
-	 *
-	 * As the page lock gives no additional guarantee, we optimistically
-	 * wait on the page to be unlocked and check if it's up to date and
-	 * use the page if it is. Otherwise, the page lock is required to
-	 * distinguish between the different cases. The motivation is that we
-	 * avoid spurious serialisations and wakeups when multiple processes
-	 * wait on the same page for IO to complete.
-	 */
-	folio_wait_locked(folio);
-	if (folio_test_uptodate(folio))
-		goto out;
-
-	/* Distinguish between all the cases under the safety of the lock */
-	folio_lock(folio);
+	if (!folio_trylock(folio)) {
+		folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE);
+		goto repeat;
+	}
 
-	/* Case c or d, restart the operation */
+	/* Folio was truncated from mapping */
 	if (!folio->mapping) {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -3543,7 +3510,9 @@ EXPORT_SYMBOL(read_cache_folio);
 static struct page *do_read_cache_page(struct address_space *mapping,
 		pgoff_t index, filler_t *filler, void *data, gfp_t gfp)
 {
-	struct folio *folio = read_cache_folio(mapping, index, filler, data);
+	struct folio *folio;
+
+	folio = do_read_cache_folio(mapping, index, filler, data, gfp);
 	if (IS_ERR(folio))
 		return &folio->page;
 	return folio_file_page(folio, index);
diff --git a/mm/shmem.c b/mm/shmem.c
index 735404fdfcc3..6cd3af0addc1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -942,18 +942,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		index++;
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
+	partial_end = ((lend + 1) % PAGE_SIZE) != 0;
 	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_READ);
 	if (folio) {
-		bool same_page;
+		bool same_folio;
 
-		same_page = lend < folio_pos(folio) + folio_size(folio);
-		if (same_page)
+		same_folio = lend < folio_pos(folio) + folio_size(folio);
+		if (same_folio)
 			partial_end = false;
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio->index + folio_nr_pages(folio);
-			if (same_page)
+			if (same_folio)
 				end = folio->index;
 		}
 		folio_unlock(folio);
diff --git a/mm/truncate.c b/mm/truncate.c
index 336c8d099efa..749aac71fda5 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -350,8 +350,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
-	struct folio *	folio;
-	bool partial_end;
+	struct folio	*folio;
+	bool		partial_end;
 
 	if (mapping_empty(mapping))
 		goto out;
@@ -388,7 +388,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		cond_resched();
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
+	partial_end = ((lend + 1) % PAGE_SIZE) != 0;
 	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
 	if (folio) {
 		bool same_folio = lend < folio_pos(folio) + folio_size(folio);
