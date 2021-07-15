Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC33C9848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbhGOFWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbhGOFWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:22:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71FC06175F;
        Wed, 14 Jul 2021 22:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yjcEYbnvFGiVk+7puh1H29FSvNpW0YK7ifZztKTx7lg=; b=FQxNhg7Wn0LNyLYKbKRdKOfilp
        /AW4j46ohSUsNlXkocsnQLLGMkm7l6LoNe3yq5kbSweuE++WQ/HK4mTx+1kyQFjOJMp9Br8KnDdJT
        hQ+adeSK5OgiS5rRHfjqBdNzyidQjo9gQEQUu5KL6B/Uv3uxnjedVKDBpiSauJau7lvlRxeBj/Vao
        4RLsF52P7NIcwyQOLEox4mhmZHBViypmXPnvRR+4aadcNDLRANtRll2QpurnfUqNTumfeZN6mSkoT
        2f4jcmh9/xejER8ZFwtHaqp7fjAKafdVPYNzd82XV7whgJ6Qd/ZS3dhpOc4W2JTtPcZglDSULvEKk
        ZqsK5DXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tlM-0030h0-7z; Thu, 15 Jul 2021 05:18:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v14 126/138] mm/filemap: Return only head pages from find_get_entries
Date:   Thu, 15 Jul 2021 04:36:52 +0100
Message-Id: <20210715033704.692967-127-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers now expect head (and base) pages, and can handle multiple
head pages in a single batch, so make find_get_entries() behave that way.
Also take the opportunity to make it use the pagevec infrastructure
instead of open-coding how pvecs behave.  This has the side-effect of
being able to append to a pagevec with existing contents, although we
don't make use of that functionality anywhere yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 40 ++++++++++------------------------------
 mm/internal.h           |  2 ++
 3 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 842d130fd6d3..bf8e978a48f2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -502,8 +502,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 1c0c2663c57d..20434d7bdad8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1955,49 +1955,29 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  * the mapping.  The entries are placed in @pvec.  find_get_entries()
  * takes a reference on any actual pages it returns.
  *
- * The search returns a group of mapping-contiguous page cache entries
- * with ascending indexes.  There may be holes in the indices due to
- * not-present pages.
+ * The entries have ascending indexes.  The indices may not be consecutive
+ * due to not-present entries or THPs.
  *
  * Any shadow entries of evicted pages, or swap entries from
  * shmem/tmpfs, are included in the returned array.
  *
- * If it finds a Transparent Huge Page, head or tail, find_get_entries()
- * stops at that page: the caller is likely to have a better way to handle
- * the compound page as a whole, and then skip its extent, than repeatedly
- * calling find_get_entries() to return all its tails.
- *
- * Return: the number of pages and shadow entries which were found.
+ * Return: The number of entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
-	struct page *page;
-	unsigned int ret = 0;
-	unsigned nr_entries = PAGEVEC_SIZE;
+	struct folio *folio;
 
 	rcu_read_lock();
-	while ((page = &find_get_entry(&xas, end, XA_PRESENT)->page)) {
-		/*
-		 * Terminate early on finding a THP, to allow the caller to
-		 * handle it all at once; but continue if this is hugetlbfs.
-		 */
-		if (!xa_is_value(page) && PageTransHuge(page) &&
-				!PageHuge(page)) {
-			page = find_subpage(page, xas.xa_index);
-			nr_entries = ret + 1;
-		}
-
-		indices[ret] = xas.xa_index;
-		pvec->pages[ret] = page;
-		if (++ret == nr_entries)
+	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
+		indices[pvec->nr] = xas.xa_index;
+		if (!pagevec_add(pvec, &folio->page))
 			break;
 	}
 	rcu_read_unlock();
 
-	pvec->nr = ret;
-	return ret;
+	return pagevec_count(pvec);
 }
 
 /**
@@ -2016,8 +1996,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  * not returned.
  *
  * The entries have ascending indexes.  The indices may not be consecutive
- * due to not-present entries, THP pages, pages which could not be locked
- * or pages under writeback.
+ * due to not-present entries, THPs, pages which could not be locked or
+ * pages under writeback.
  *
  * Return: The number of entries which were found.
  */
diff --git a/mm/internal.h b/mm/internal.h
index 3c0c807eddc6..3e32064df18d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -70,6 +70,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
 
 /**
-- 
2.30.2

