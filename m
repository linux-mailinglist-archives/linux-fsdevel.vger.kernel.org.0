Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41AB298640
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422306AbgJZEqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:46:46 -0400
Received: from casper.infradead.org ([90.155.50.34]:60150 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420397AbgJZEqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TvkNUGXQnu6homFCzqrBDp2K7EKV5Qz0vG6C5SIadzM=; b=GoZMtAwShbDz/UdPB7GONHqlxS
        16xcp7dbelp88o4XGj7mXnDm270KD3vGPMpulzzCsqzyfkCA8RM6oAzU2HCmfOyVmap9SVjKrUQpt
        owJDpEy3NGPbcEKsXBt8vlvKdCgXdjnflRd0oXWaqptg5gsYbeIxSXF0iIfO+CqG4xYY2LKRytFMP
        SppNmlCQl2XQl8JVkd8kxzkXFiG2zV5SHHWcLdjXdA33dzwahfWhMmYtv5FA5bN4vRxs49iSdyzhf
        L2Mr4x1tgag3UIFvMaYRMYfJPMhefabcTO624uv6plWPIscJWAq8TMIR7lrj5lFkBS8OmTE89rZBc
        Rsoi7k+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWttc-0006aV-5n; Mon, 26 Oct 2020 04:14:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 09/12] mm: Pass pvec directly to find_get_entries
Date:   Mon, 26 Oct 2020 04:14:05 +0000
Message-Id: <20201026041408.25230-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers of find_get_entries() use a pvec, so pass it directly
instead of manipulating it in the caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  3 +--
 mm/filemap.c            | 21 +++++++++------------
 mm/shmem.c              |  5 ++---
 mm/swap.c               |  4 +---
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5b425f666bc5..f0bbe29de732 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -450,8 +450,7 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 }
 
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, unsigned int nr_entries, struct page **entries,
-		pgoff_t *indices);
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6ed2422426d2..e0fa943011d8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1898,14 +1898,12 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
  * @end:	The final page index (inclusive).
- * @nr_entries:	The maximum number of entries
- * @entries:	Where the resulting entries are placed
+ * @pvec:	Where the resulting entries are placed.
  * @indices:	The cache indices corresponding to the entries in @entries
  *
- * find_get_entries() will search for and return a group of up to
- * @nr_entries entries in the mapping.  The entries are placed at
- * @entries.  find_get_entries() takes a reference against any actual
- * pages it returns.
+ * find_get_entries() will search for and return a batch of entries in
+ * the mapping.  The entries are placed in @pvec.  find_get_entries()
+ * takes a reference on any actual pages it returns.
  *
  * The search returns a group of mapping-contiguous page cache entries
  * with ascending indexes.  There may be holes in the indices due to
@@ -1922,15 +1920,12 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
  * Return: the number of pages and shadow entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, unsigned int nr_entries, struct page **entries,
-		pgoff_t *indices)
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
 	unsigned int ret = 0;
-
-	if (!nr_entries)
-		return 0;
+	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
 	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
@@ -1945,11 +1940,13 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		}
 
 		indices[ret] = xas.xa_index;
-		entries[ret] = page;
+		pvec->pages[ret] = page;
 		if (++ret == nr_entries)
 			break;
 	}
 	rcu_read_unlock();
+
+	pvec->nr = ret;
 	return ret;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 27b93b738ea0..7880a245ac32 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -965,9 +965,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		pvec.nr = find_get_entries(mapping, index, end - 1,
-				PAGEVEC_SIZE, pvec.pages, indices);
-		if (!pvec.nr) {
+		if (!find_get_entries(mapping, index, end - 1, &pvec,
+				indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
 				break;
diff --git a/mm/swap.c b/mm/swap.c
index 31653152f55d..0c5659c05e6e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1099,9 +1099,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
 		pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
-				    pvec->pages, indices);
-	return pagevec_count(pvec);
+	return find_get_entries(mapping, start, end, pvec, indices);
 }
 
 /**
-- 
2.28.0

