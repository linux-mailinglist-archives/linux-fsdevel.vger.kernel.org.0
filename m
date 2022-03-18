Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82514DDBEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 15:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiCROrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiCROrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:47:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A6105AB9;
        Fri, 18 Mar 2022 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YdUS3osx6EN9u7UkLwXVPQspZtyi3Zv9WDYl9TKxUlo=; b=VF7oJ6fxI2hfVSgsfs+uXv1fNx
        OhBPkY3czbmhIbmB1UntPbhAvFPfQXUX3PhOW8Sj7AU2scGH0Y32C5Jj9yahcqXYbKW0mlrVYHfBp
        G45hNKsC9VKpA656HBw2DcPobeO2kDwlJ8/8mJ95NyNUHtAb5Ed7WyTAGXPQUKQQD3gJmjEFfI6OR
        goO46u7U70wiqxVpw3OaK0ZliZ2t/8h6PpIgrKWrOBUwYz1cF0IhMxMy5UY57azaVKsYFGca5CJ1D
        OU3/W/DWhs178xTtcM6ViuwdUp0oXSP7xTUvCiQmCdwx9KCQJAwcYhT7K1wjkViN42HIgg335ywHt
        SfZLzxHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVDrS-0081a0-PR; Fri, 18 Mar 2022 14:45:51 +0000
Date:   Fri, 18 Mar 2022 14:45:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjSbHp6B9a1G3tuQ@casper.infradead.org>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster>
 <YjSTq4roN/LJ7Xsy@bfoster>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vQ4HEjhWuFe4e0zu"
Content-Disposition: inline
In-Reply-To: <YjSTq4roN/LJ7Xsy@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vQ4HEjhWuFe4e0zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 18, 2022 at 10:14:03AM -0400, Brian Foster wrote:
> So I'm not clear on where we're at with this patch vs. something that
> moves (or drops) the wb wait loop vs. the wait and set thing (which
> seems more invasive and longer term), but FWIW.. this patch survived
> over 10k iterations of the reproducer test yesterday (the problem
> typically reproduces in ~1k or so iterations on average) and an
> overnight fstests run without regression.

Excellent!  I'm going to propose these two patches for -rc1 (I don't
think we want to be playing with this after -rc8).  I agree the
wait-and-set approach is a little further out.

(patches attached)

--vQ4HEjhWuFe4e0zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-filemap-Remove-use-of-wait-bookmarks.patch"

From db81b2f1ce3dc6aa902beb8b3e45a5972cf85737 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Thu, 17 Mar 2022 12:12:49 -0400
Subject: [PATCH 1/2] filemap: Remove use of wait bookmarks

The original problem of the overly long list of waiters on a
locked page was solved properly by commit 9a1ea439b16b ("mm:
put_and_wait_on_page_locked() while page is migrated").  In
the meantime, using bookmarks for the writeback bit can cause
livelocks, so we need to stop using them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b2728eb52407..bb8ec585dea8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1151,32 +1151,13 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	wait_queue_head_t *q = folio_waitqueue(folio);
 	struct wait_page_key key;
 	unsigned long flags;
-	wait_queue_entry_t bookmark;
 
 	key.folio = folio;
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
 
-	bookmark.flags = 0;
-	bookmark.private = NULL;
-	bookmark.func = NULL;
-	INIT_LIST_HEAD(&bookmark.entry);
-
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
-
-	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
-		/*
-		 * Take a breather from holding the lock,
-		 * allow pages that finish wake up asynchronously
-		 * to acquire the lock and remove themselves
-		 * from wait queue
-		 */
-		spin_unlock_irqrestore(&q->lock, flags);
-		cpu_relax();
-		spin_lock_irqsave(&q->lock, flags);
-		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
-	}
+	__wake_up_locked_key(q, TASK_NORMAL, &key);
 
 	/*
 	 * It is possible for other pages to have collided on the waitqueue
-- 
2.34.1


--vQ4HEjhWuFe4e0zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-sched-Remove-wait-bookmarks.patch"

From 4eda97c0c8374f948a08c28265f019517d369a4c Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Fri, 18 Mar 2022 10:39:49 -0400
Subject: [PATCH 2/2] sched: Remove wait bookmarks

There are no users of wait bookmarks left, so simplify the wait
code by removing them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/wait.h |  9 +++----
 kernel/sched/wait.c  | 58 +++++++-------------------------------------
 2 files changed, 12 insertions(+), 55 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 851e07da2583..69aa9d5767e7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -19,10 +19,9 @@ int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int
 /* wait_queue_entry::flags */
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
-#define WQ_FLAG_BOOKMARK	0x04
-#define WQ_FLAG_CUSTOM		0x08
-#define WQ_FLAG_DONE		0x10
-#define WQ_FLAG_PRIORITY	0x20
+#define WQ_FLAG_CUSTOM		0x04
+#define WQ_FLAG_DONE		0x08
+#define WQ_FLAG_PRIORITY	0x10
 
 /*
  * A single wait-queue entry structure:
@@ -211,8 +210,6 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
 
 void __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
-void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
-		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index eca38107b32f..e09f5c177662 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -58,13 +58,6 @@ void remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry
 }
 EXPORT_SYMBOL(remove_wait_queue);
 
-/*
- * Scan threshold to break wait queue walk.
- * This allows a waker to take a break from holding the
- * wait queue lock during the wait queue walk.
- */
-#define WAITQUEUE_WALK_BREAK_CNT 64
-
 /*
  * The core wakeup function. Non-exclusive wakeups (nr_exclusive == 0) just
  * wake everything up. If it's an exclusive wakeup (nr_exclusive == small +ve
@@ -79,21 +72,13 @@ EXPORT_SYMBOL(remove_wait_queue);
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
 static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
-			int nr_exclusive, int wake_flags, void *key,
-			wait_queue_entry_t *bookmark)
+			int nr_exclusive, int wake_flags, void *key)
 {
 	wait_queue_entry_t *curr, *next;
-	int cnt = 0;
 
 	lockdep_assert_held(&wq_head->lock);
 
-	if (bookmark && (bookmark->flags & WQ_FLAG_BOOKMARK)) {
-		curr = list_next_entry(bookmark, entry);
-
-		list_del(&bookmark->entry);
-		bookmark->flags = 0;
-	} else
-		curr = list_first_entry(&wq_head->head, wait_queue_entry_t, entry);
+	curr = list_first_entry(&wq_head->head, wait_queue_entry_t, entry);
 
 	if (&curr->entry == &wq_head->head)
 		return nr_exclusive;
@@ -102,21 +87,11 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 		unsigned flags = curr->flags;
 		int ret;
 
-		if (flags & WQ_FLAG_BOOKMARK)
-			continue;
-
 		ret = curr->func(curr, mode, wake_flags, key);
 		if (ret < 0)
 			break;
 		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 			break;
-
-		if (bookmark && (++cnt > WAITQUEUE_WALK_BREAK_CNT) &&
-				(&next->entry != &wq_head->head)) {
-			bookmark->flags = WQ_FLAG_BOOKMARK;
-			list_add_tail(&bookmark->entry, &next->entry);
-			break;
-		}
 	}
 
 	return nr_exclusive;
@@ -126,19 +101,11 @@ static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int
 			int nr_exclusive, int wake_flags, void *key)
 {
 	unsigned long flags;
-	wait_queue_entry_t bookmark;
 
-	bookmark.flags = 0;
-	bookmark.private = NULL;
-	bookmark.func = NULL;
-	INIT_LIST_HEAD(&bookmark.entry);
-
-	do {
-		spin_lock_irqsave(&wq_head->lock, flags);
-		nr_exclusive = __wake_up_common(wq_head, mode, nr_exclusive,
-						wake_flags, key, &bookmark);
-		spin_unlock_irqrestore(&wq_head->lock, flags);
-	} while (bookmark.flags & WQ_FLAG_BOOKMARK);
+	spin_lock_irqsave(&wq_head->lock, flags);
+	nr_exclusive = __wake_up_common(wq_head, mode, nr_exclusive,
+					wake_flags, key);
+	spin_unlock_irqrestore(&wq_head->lock, flags);
 }
 
 /**
@@ -163,23 +130,16 @@ EXPORT_SYMBOL(__wake_up);
  */
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr)
 {
-	__wake_up_common(wq_head, mode, nr, 0, NULL, NULL);
+	__wake_up_common(wq_head, mode, nr, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked);
 
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key)
 {
-	__wake_up_common(wq_head, mode, 1, 0, key, NULL);
+	__wake_up_common(wq_head, mode, 1, 0, key);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked_key);
 
-void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
-		unsigned int mode, void *key, wait_queue_entry_t *bookmark)
-{
-	__wake_up_common(wq_head, mode, 1, 0, key, bookmark);
-}
-EXPORT_SYMBOL_GPL(__wake_up_locked_key_bookmark);
-
 /**
  * __wake_up_sync_key - wake up threads blocked on a waitqueue.
  * @wq_head: the waitqueue
@@ -225,7 +185,7 @@ EXPORT_SYMBOL_GPL(__wake_up_sync_key);
 void __wake_up_locked_sync_key(struct wait_queue_head *wq_head,
 			       unsigned int mode, void *key)
 {
-        __wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL);
+        __wake_up_common(wq_head, mode, 1, WF_SYNC, key);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked_sync_key);
 
-- 
2.34.1


--vQ4HEjhWuFe4e0zu--
