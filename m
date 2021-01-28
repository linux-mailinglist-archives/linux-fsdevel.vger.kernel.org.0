Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3092A306E24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhA1HHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhA1HGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45E9C061756;
        Wed, 27 Jan 2021 23:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q3S99dYrI+HNIR8LkIbmVJJwusWJ9ksF9u7WpcifTTw=; b=iCmVXN1+08Nwdhv4oYUpUMNhSZ
        ELVjX5cyKN6wtfM90wMAHxBE9jTOyamN3x8zxECu5oWHl2Ubl7DWG4o/DTDxugEgx+9DzUG0BMm3A
        mvZDugHvEsi7Zc4qKdQeFg2GNIkB+M71QKLHBn66BxR9b64/UuO3GOwfsBwQYKbs9272KhXmYd2sl
        hoSWW3jSN8qInCtK0yir8aPsJl9+ud0wkhMUq4IUWgxqTzQUWxUcHn7A2trdhGkc7PPlUR1kFhjti
        U0mc+rsoEe2wZ3EZ4Bx1uSYHuWGkhugEMoXfNgP0enQxW+ti7sVMhV+ifnfh7Nubh64PgvCqhl0bd
        YPVnWTeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51ML-00848w-8n; Thu, 28 Jan 2021 07:04:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 24/25] mm/filemap: Convert page wait queues to be folios
Date:   Thu, 28 Jan 2021 07:04:03 +0000
Message-Id: <20210128070404.1922318-25-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
 mm/filemap.c            | 40 +++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f59af1547e7b..f0a601f6d68c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -594,13 +594,13 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 
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
@@ -608,7 +608,7 @@ struct wait_page_queue {
 static inline bool wake_page_match(struct wait_page_queue *wait_page,
 				  struct wait_page_key *key)
 {
-	if (wait_page->page != key->page)
+	if (wait_page->folio != key->folio)
 	       return false;
 	key->page_match = 1;
 
diff --git a/mm/filemap.c b/mm/filemap.c
index a00030b2ef71..ff61f1f2ce2c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -991,11 +991,11 @@ EXPORT_SYMBOL(__page_cache_alloc);
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
@@ -1003,7 +1003,7 @@ void __init pagecache_init(void)
 	int i;
 
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
-		init_waitqueue_head(&page_wait_table[i]);
+		init_waitqueue_head(&folio_wait_table[i]);
 
 	page_writeback_init();
 }
@@ -1058,10 +1058,11 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
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
@@ -1095,12 +1096,12 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 
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
 
@@ -1192,7 +1193,7 @@ int sysctl_page_lock_unfairness = 5;
 static inline int wait_on_folio_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	wait_queue_head_t *q = folio_waitqueue(folio);
 	int unfairness = sysctl_page_lock_unfairness;
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
@@ -1212,7 +1213,7 @@ static inline int wait_on_folio_bit_common(struct folio *folio, int bit_nr,
 
 	init_wait(wait);
 	wait->func = wake_page_function;
-	wait_page.page = &folio->page;
+	wait_page.folio = folio;
 	wait_page.bit_nr = bit_nr;
 
 repeat:
@@ -1356,7 +1357,7 @@ EXPORT_SYMBOL(wait_on_folio_bit_killable);
  */
 int put_and_wait_on_page_locked(struct page *page, int state)
 {
-	wait_on_folio_bit_common(page_folio(page), PG_locked,
+	return wait_on_folio_bit_common(page_folio(page), PG_locked,
 				state, DROP);
 }
 
@@ -1369,12 +1370,13 @@ int put_and_wait_on_page_locked(struct page *page, int state)
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
@@ -1431,10 +1433,10 @@ EXPORT_SYMBOL(unlock_folio);
  */
 void unlock_page_fscache(struct page *page)
 {
-	page = compound_head(page);
-	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
-	clear_bit_unlock(PG_fscache, &page->flags);
-	wake_up_page_bit(page, PG_fscache);
+	struct folio *folio = page_folio(page);
+	VM_BUG_ON_FOLIO(!FolioPrivate2(folio), folio);
+	clear_bit_unlock(PG_fscache, &folio->page.flags);
+	wake_up_folio_bit(folio, PG_fscache);
 }
 EXPORT_SYMBOL(unlock_page_fscache);
 
@@ -1520,10 +1522,10 @@ EXPORT_SYMBOL_GPL(__lock_folio_killable);
 
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
2.29.2

