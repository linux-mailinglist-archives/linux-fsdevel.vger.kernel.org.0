Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986CE32E0C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCEE2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEE2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:28:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE74FC061574;
        Thu,  4 Mar 2021 20:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xwpBIqAEuLM6Zld1KeVwy1SyI/6FWtXxGIYJ0bk67Ms=; b=nZiEQlDA3UiHbQK+LAi8BPFS61
        pB+mHWU8LiaXKjDF3kxZeSTkTK3OkjP4umVg2cdiABFuLz6H45hnwPCd0a7ybRUwVsyHA1OIzANUT
        5Q2d/uFqBS1raiTwf8RvPqhUP7VGa6jAU6vtBF8Za/ihsNvQdLSZLKCarFURQFzlNWGxNao0bxhCh
        eG6rqCE1S/m/nstsiTogOdORYksqHAXQoQHAhzbOFgXwtEvgJe40VyiAUdoL6xPLtsvnUs3MrDkNa
        9y1pNasEG50jfZqfwtvdyp0yOl2S0mWayXvU4qK2tjHz8PFmnp9X1PXmxxwvSn7xOXabyy9fWkbYy
        APFybfzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI23F-00A4qX-PL; Fri, 05 Mar 2021 04:26:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 24/25] mm/filemap: Convert page wait queues to be folios
Date:   Fri,  5 Mar 2021 04:19:00 +0000
Message-Id: <20210305041901.2396498-25-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reinforce that if we're waiting for a bit in a struct page, that's
actually in the head page by changing the type from page to folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  6 +++---
 mm/filemap.c            | 30 ++++++++++++++++--------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6ee4bc843f98..2236f726bf01 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -611,13 +611,13 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 
 /* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
 struct wait_page_key {
-	struct page *page;
+	struct folio *folio;
 	int bit_nr;
 	int page_match;
 };
 
 struct wait_page_queue {
-	struct page *page;
+	struct folio *folio;
 	int bit_nr;
 	wait_queue_entry_t wait;
 };
@@ -625,7 +625,7 @@ struct wait_page_queue {
 static inline bool wake_page_match(struct wait_page_queue *wait_page,
 				  struct wait_page_key *key)
 {
-	if (wait_page->page != key->page)
+	if (wait_page->folio != key->folio)
 	       return false;
 	key->page_match = 1;
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 57f46ff2f230..1cdd565c69a6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -992,11 +992,11 @@ EXPORT_SYMBOL(__page_cache_alloc);
  */
 #define PAGE_WAIT_TABLE_BITS 8
 #define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
-static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;
+static wait_queue_head_t folio_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;
 
-static wait_queue_head_t *page_waitqueue(struct page *page)
+static wait_queue_head_t *folio_waitqueue(struct folio *folio)
 {
-	return &page_wait_table[hash_ptr(page, PAGE_WAIT_TABLE_BITS)];
+	return &folio_wait_table[hash_ptr(folio, PAGE_WAIT_TABLE_BITS)];
 }
 
 void __init pagecache_init(void)
@@ -1004,7 +1004,7 @@ void __init pagecache_init(void)
 	int i;
 
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
-		init_waitqueue_head(&page_wait_table[i]);
+		init_waitqueue_head(&folio_wait_table[i]);
 
 	page_writeback_init();
 }
@@ -1059,10 +1059,11 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 */
 	flags = wait->flags;
 	if (flags & WQ_FLAG_EXCLUSIVE) {
-		if (test_bit(key->bit_nr, &key->page->flags))
+		if (test_bit(key->bit_nr, &key->folio->page.flags))
 			return -1;
 		if (flags & WQ_FLAG_CUSTOM) {
-			if (test_and_set_bit(key->bit_nr, &key->page->flags))
+			if (test_and_set_bit(key->bit_nr,
+						&key->folio->page.flags))
 				return -1;
 			flags |= WQ_FLAG_DONE;
 		}
@@ -1096,12 +1097,12 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 
 static void wake_up_folio_bit(struct folio *folio, int bit_nr)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	wait_queue_head_t *q = folio_waitqueue(folio);
 	struct wait_page_key key;
 	unsigned long flags;
 	wait_queue_entry_t bookmark;
 
-	key.page = &folio->page;
+	key.folio = folio;
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
 
@@ -1193,7 +1194,7 @@ int sysctl_page_lock_unfairness = 5;
 static inline int wait_on_folio_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	wait_queue_head_t *q = folio_waitqueue(folio);
 	int unfairness = sysctl_page_lock_unfairness;
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
@@ -1213,7 +1214,7 @@ static inline int wait_on_folio_bit_common(struct folio *folio, int bit_nr,
 
 	init_wait(wait);
 	wait->func = wake_page_function;
-	wait_page.page = &folio->page;
+	wait_page.folio = folio;
 	wait_page.bit_nr = bit_nr;
 
 repeat:
@@ -1370,12 +1371,13 @@ int put_and_wait_on_page_locked(struct page *page, int state)
  */
 void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
+	struct folio *folio = page_folio(page);
+	wait_queue_head_t *q = folio_waitqueue(folio);
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
 	__add_wait_queue_entry_tail(q, waiter);
-	SetPageWaiters(page);
+	SetFolioWaiters(folio);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_page_wait_queue);
@@ -1503,10 +1505,10 @@ EXPORT_SYMBOL_GPL(__lock_folio_killable);
 
 int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait)
 {
-	struct wait_queue_head *q = page_waitqueue(&folio->page);
+	struct wait_queue_head *q = folio_waitqueue(folio);
 	int ret = 0;
 
-	wait->page = &folio->page;
+	wait->folio = folio;
 	wait->bit_nr = PG_locked;
 
 	spin_lock_irq(&q->lock);
-- 
2.30.0

