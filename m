Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264753C96D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhGOEEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhGOEEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:04:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE1C06175F;
        Wed, 14 Jul 2021 21:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iWNQ9RPanyCtO83E61CoH+Bq2Widrlq/+PJbQcDDZZ4=; b=IoykdM8/mBJecPspmr616eJ4oy
        igtNxyhwkrSitiyHCUISAr4b2W+P2kiDzgD9UYOyqfj9+JpxobjK/veI+DXhRPWcb66jAY33K1Ii1
        IDvc6uoeqzJms9dXLdsZyhFbFEKPzoWuXM9y7lTSxPwyhPmlUOGv8NXuJWlGpsBoWmo6KRUMVRfVa
        Axr6U0YHPzKgOlGikyoWT2FcaVQ3j6/eRy76HaOcBwWfTFFFwUTmh2j0WlgmnMc6RbcgMJgGj3DkN
        qTiT/ILW+IHFdTnptl2XpBgmkBMK4rUOn3kOQCRuXtAAvHZPHuED+Hi3jZvAU9Een/ycWYMS2jrHa
        HBnidRrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sYE-002vfE-7q; Thu, 15 Jul 2021 04:01:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v14 029/138] mm/filemap: Convert page wait queues to be folios
Date:   Thu, 15 Jul 2021 04:35:15 +0100
Message-Id: <20210715033704.692967-30-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reinforce that page flags are actually in the head page by changing the
type from page to folio.  Increases the size of cachefiles by two bytes,
but the kernel core is unchanged in size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/rdwr.c    | 16 ++++++++--------
 include/linux/pagemap.h |  8 ++++----
 mm/filemap.c            | 38 +++++++++++++++++++-------------------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 8ffc40e84a59..fcf4f3b72923 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -25,20 +25,20 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 	struct cachefiles_object *object;
 	struct fscache_retrieval *op = monitor->op;
 	struct wait_page_key *key = _key;
-	struct page *page = wait->private;
+	struct folio *folio = wait->private;
 
 	ASSERT(key);
 
 	_enter("{%lu},%u,%d,{%p,%u}",
 	       monitor->netfs_page->index, mode, sync,
-	       key->page, key->bit_nr);
+	       key->folio, key->bit_nr);
 
-	if (key->page != page || key->bit_nr != PG_locked)
+	if (key->folio != folio || key->bit_nr != PG_locked)
 		return 0;
 
-	_debug("--- monitor %p %lx ---", page, page->flags);
+	_debug("--- monitor %p %lx ---", folio, folio->flags);
 
-	if (!PageUptodate(page) && !PageError(page)) {
+	if (!folio_test_uptodate(folio) && !folio_test_error(folio)) {
 		/* unlocked, not uptodate and not erronous? */
 		_debug("page probably truncated");
 	}
@@ -107,7 +107,7 @@ static int cachefiles_read_reissue(struct cachefiles_object *object,
 	put_page(backpage2);
 
 	INIT_LIST_HEAD(&monitor->op_link);
-	add_page_wait_queue(backpage, &monitor->monitor);
+	folio_add_wait_queue(page_folio(backpage), &monitor->monitor);
 
 	if (trylock_page(backpage)) {
 		ret = -EIO;
@@ -294,7 +294,7 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
 	get_page(backpage);
 	monitor->back_page = backpage;
 	monitor->monitor.private = backpage;
-	add_page_wait_queue(backpage, &monitor->monitor);
+	folio_add_wait_queue(page_folio(backpage), &monitor->monitor);
 	monitor = NULL;
 
 	/* but the page may have been read before the monitor was installed, so
@@ -548,7 +548,7 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 		get_page(backpage);
 		monitor->back_page = backpage;
 		monitor->monitor.private = backpage;
-		add_page_wait_queue(backpage, &monitor->monitor);
+		folio_add_wait_queue(page_folio(backpage), &monitor->monitor);
 		monitor = NULL;
 
 		/* but the page may have been read before the monitor was
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7eb02baf6f9f..c8e74d67b01f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -629,13 +629,13 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 }
 
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
@@ -643,7 +643,7 @@ struct wait_page_queue {
 static inline bool wake_page_match(struct wait_page_queue *wait_page,
 				  struct wait_page_key *key)
 {
-	if (wait_page->page != key->page)
+	if (wait_page->folio != key->folio)
 	       return false;
 	key->page_match = 1;
 
@@ -803,7 +803,7 @@ int wait_on_page_private_2_killable(struct page *page);
 /*
  * Add an arbitrary waiter to a page's wait queue
  */
-extern void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter);
+void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter);
 
 /*
  * Fault everything in given userspace address range in.
diff --git a/mm/filemap.c b/mm/filemap.c
index a3ef9abcbcde..1ecaece68019 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1019,11 +1019,11 @@ EXPORT_SYMBOL(__page_cache_alloc);
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
@@ -1031,7 +1031,7 @@ void __init pagecache_init(void)
 	int i;
 
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
-		init_waitqueue_head(&page_wait_table[i]);
+		init_waitqueue_head(&folio_wait_table[i]);
 
 	page_writeback_init();
 }
@@ -1086,10 +1086,10 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 */
 	flags = wait->flags;
 	if (flags & WQ_FLAG_EXCLUSIVE) {
-		if (test_bit(key->bit_nr, &key->page->flags))
+		if (test_bit(key->bit_nr, &key->folio->flags))
 			return -1;
 		if (flags & WQ_FLAG_CUSTOM) {
-			if (test_and_set_bit(key->bit_nr, &key->page->flags))
+			if (test_and_set_bit(key->bit_nr, &key->folio->flags))
 				return -1;
 			flags |= WQ_FLAG_DONE;
 		}
@@ -1123,12 +1123,12 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 
 static void folio_wake_bit(struct folio *folio, int bit_nr)
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
 
@@ -1220,7 +1220,7 @@ int sysctl_page_lock_unfairness = 5;
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	wait_queue_head_t *q = folio_waitqueue(folio);
 	int unfairness = sysctl_page_lock_unfairness;
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
@@ -1240,7 +1240,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 
 	init_wait(wait);
 	wait->func = wake_page_function;
-	wait_page.page = &folio->page;
+	wait_page.folio = folio;
 	wait_page.bit_nr = bit_nr;
 
 repeat:
@@ -1389,23 +1389,23 @@ int put_and_wait_on_page_locked(struct page *page, int state)
 }
 
 /**
- * add_page_wait_queue - Add an arbitrary waiter to a page's wait queue
- * @page: Page defining the wait queue of interest
+ * folio_add_wait_queue - Add an arbitrary waiter to a folio's wait queue
+ * @folio: Folio defining the wait queue of interest
  * @waiter: Waiter to add to the queue
  *
- * Add an arbitrary @waiter to the wait queue for the nominated @page.
+ * Add an arbitrary @waiter to the wait queue for the nominated @folio.
  */
-void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter)
+void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
+	wait_queue_head_t *q = folio_waitqueue(folio);
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
 	__add_wait_queue_entry_tail(q, waiter);
-	SetPageWaiters(page);
+	folio_set_waiters(folio);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL_GPL(add_page_wait_queue);
+EXPORT_SYMBOL_GPL(folio_add_wait_queue);
 
 #ifndef clear_bit_unlock_is_negative_byte
 
@@ -1595,10 +1595,10 @@ EXPORT_SYMBOL_GPL(__folio_lock_killable);
 
 static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 {
-	struct wait_queue_head *q = page_waitqueue(&folio->page);
+	struct wait_queue_head *q = folio_waitqueue(folio);
 	int ret = 0;
 
-	wait->page = &folio->page;
+	wait->folio = folio;
 	wait->bit_nr = PG_locked;
 
 	spin_lock_irq(&q->lock);
-- 
2.30.2

