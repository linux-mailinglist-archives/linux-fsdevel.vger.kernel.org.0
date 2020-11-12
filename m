Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850642B1065
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgKLV2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgKLV0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D05CC0613D4;
        Thu, 12 Nov 2020 13:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tg4uf1yPSb1+NPbluHkPZ5qPAwrm/1+z+EzXPXHIqqs=; b=BpevITKRE81lHU4Xrh0y8Vl+OI
        l9ohsaRmyZrdPCdtUCoOBe8qoUvtnPjPg0YwrQyc85XA2wJyQA5nMkHwzO5rlUXlV8oJ7BR1PJfVv
        6k4H+Cm4zf3g4C+q3bPj1HbmAG0cDBKBjmckvuQXrlfbST2of7GNfH/o1rY6RNaGYJubwa+pVlLAa
        51PDIqW2AMERRp0fcV8wHfRui3G9Vbn329LRn6xAaB0gHLlxt7dpjf1juQ0Fsf1Q+gN/Zx/1PSe2r
        duv4Z9ce/IKfCD2psNiIYSq9Fj+z2/o9rChPVFl33LMwOQ01y4pAy1UAD1d4uTGDBTSm4+lGnrHNp
        m4lgFH8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7D-0007H7-Uc; Thu, 12 Nov 2020 21:26:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 10/16] mm: Add an 'end' parameter to find_get_entries
Date:   Thu, 12 Nov 2020 21:26:35 +0000
Message-Id: <20201112212641.27837-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This simplifies the callers and leads to a more efficient implementation
since the XArray has this functionality already.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  4 ++--
 mm/filemap.c            |  9 +++++----
 mm/shmem.c              | 10 ++--------
 mm/swap.c               |  2 +-
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9f1f4ab9612a..c7c26a902743 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -449,8 +449,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 }
 
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-			  unsigned int nr_entries, struct page **entries,
-			  pgoff_t *indices);
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index f18c5074865d..b3b89a62ab1a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1870,6 +1870,7 @@ static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
  * find_get_entries - gang pagecache lookup
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
+ * @end:	The final page index (inclusive).
  * @nr_entries:	The maximum number of entries
  * @entries:	Where the resulting entries are placed
  * @indices:	The cache indices corresponding to the entries in @entries
@@ -1893,9 +1894,9 @@ static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
  *
  * Return: the number of pages and shadow entries which were found.
  */
-unsigned find_get_entries(struct address_space *mapping,
-			  pgoff_t start, unsigned int nr_entries,
-			  struct page **entries, pgoff_t *indices)
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
@@ -1905,7 +1906,7 @@ unsigned find_get_entries(struct address_space *mapping,
 		return 0;
 
 	rcu_read_lock();
-	while ((page = find_get_entry(&xas, ULONG_MAX, XA_PRESENT))) {
+	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
 		/*
 		 * Terminate early on finding a THP, to allow the caller to
 		 * handle it all at once; but continue if this is hugetlbfs.
diff --git a/mm/shmem.c b/mm/shmem.c
index a4aa762a55f8..7a62dc967d7d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -913,8 +913,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			struct page *page = pvec.pages[i];
 
 			index = indices[i];
-			if (index >= end)
-				break;
 
 			if (xa_is_value(page)) {
 				if (unfalloc)
@@ -967,9 +965,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		pvec.nr = find_get_entries(mapping, index,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE),
-				pvec.pages, indices);
+		pvec.nr = find_get_entries(mapping, index, end - 1,
+				PAGEVEC_SIZE, pvec.pages, indices);
 		if (!pvec.nr) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
@@ -982,9 +979,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			struct page *page = pvec.pages[i];
 
 			index = indices[i];
-			if (index >= end)
-				break;
-
 			if (xa_is_value(page)) {
 				if (unfalloc)
 					continue;
diff --git a/mm/swap.c b/mm/swap.c
index 29220174433b..39be55635ebd 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1102,7 +1102,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
 				pgoff_t start, unsigned nr_entries,
 				pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
-- 
2.28.0

