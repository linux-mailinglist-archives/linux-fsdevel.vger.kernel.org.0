Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183C04DB9D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 21:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348324AbiCPVBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiCPVA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:00:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D46561;
        Wed, 16 Mar 2022 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sOdzF9Go4WuFzgSYlmGs/O7tK/QVTlLx/FEyh04e9I0=; b=CsFQP33tR7gS027q7yjFh8G5s8
        EHohWk+16wbZthEnoUJtsJlqWMrD++E//O6os3Wknwzg/4PTGzG8R4/aMN/OlnoT3BKY97sZ0dv7Z
        QLIsgHpj5NBzs1840p8TtehnS7cOI/r+SoENsUeFpfTe+K5+uPFnkE4bYSxoww8cYe4Vxy+y02AZ7
        FBJ1JCpptCyTJ59iGrizQ+Z7PEhKFg2VMGbuCqFVwfEPpN3G0R39NcoXQxAEwjBsmTN+Kxe0fDWAE
        7j1YTdx6C3oGnkbF4bjq/1+cFxO655clhYqSOUAQ+cOBFfkvKVOZa6d4d42BHlCZkBLdn/8vZuzuP
        619XB6Zg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUak7-006NE6-Kj; Wed, 16 Mar 2022 20:59:39 +0000
Date:   Wed, 16 Mar 2022 20:59:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjJPu/3tYnuKK888@casper.infradead.org>
References: <YjDj3lvlNJK/IPiU@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjDj3lvlNJK/IPiU@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:07:10PM -0400, Brian Foster wrote:
> What seems to happen is that the majority of the fsync calls end up
> waiting on writeback of a particular page, the wakeup of the writeback
> bit on that page wakes a task that immediately resets PG_writeback on
> the page such that N other folio_wait_writeback() waiters see the bit
> still set and immediately place themselves back onto the tail of the
> wait queue.  Meanwhile the waker task spins in the WQ_FLAG_BOOKMARK loop
> in folio_wake_bit() (backing off the lock for a cycle or so in each
> iteration) only to find the same bunch of tasks in the queue. This
> process repeats for a long enough amount of time to trigger the soft
> lockup warning. I've confirmed this spinning behavior with a tracepoint
> in the bookmark loop that indicates we're stuck for many hundreds of
> thousands of iterations (at least) of this loop when the soft lockup
> warning triggers.

[...]

> I've run a few quick experiments to try and corroborate this analysis.
> The problem goes away completely if I either back out the loop change in
> folio_wait_writeback() or bump WAITQUEUE_WALK_BREAK_CNT to something
> like 128 (i.e. greater than the total possible number of waiter tasks in
> this test). I've also played a few games with bookmark behavior mostly
> out of curiosity, but usually end up introducing other problems like
> missed wakeups, etc.

As I recall, the bookmark hack was introduced in order to handle
lock_page() problems.  It wasn't really supposed to handle writeback,
but nobody thought it would cause any harm (and indeed, it didn't at the
time).  So how about we only use bookmarks for lock_page(), since
lock_page() usually doesn't have the multiple-waker semantics that
writeback has?

(this is more in the spirit of "minimal patch" -- I think initialising
the bookmark should be moved to folio_unlock()).

diff --git a/mm/filemap.c b/mm/filemap.c
index b2728eb52407..9ee3c5f1f489 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1146,26 +1146,28 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void folio_wake_bit(struct folio *folio, int bit_nr)
+static void folio_wake_bit(struct folio *folio, int bit_nr,
+		wait_queue_entry_t *bookmark)
 {
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
+	if (bookmark) {
+		bookmark->flags = 0;
+		bookmark->private = NULL;
+		bookmark->func = NULL;
+		INIT_LIST_HEAD(&bookmark->entry);
+	}
 
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
+	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, bookmark);
 
-	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
+	while (bookmark && (bookmark->flags & WQ_FLAG_BOOKMARK)) {
 		/*
 		 * Take a breather from holding the lock,
 		 * allow pages that finish wake up asynchronously
@@ -1175,7 +1177,7 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 		spin_unlock_irqrestore(&q->lock, flags);
 		cpu_relax();
 		spin_lock_irqsave(&q->lock, flags);
-		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
+		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, bookmark);
 	}
 
 	/*
@@ -1204,7 +1206,7 @@ static void folio_wake(struct folio *folio, int bit)
 {
 	if (!folio_test_waiters(folio))
 		return;
-	folio_wake_bit(folio, bit);
+	folio_wake_bit(folio, bit, NULL);
 }
 
 /*
@@ -1554,12 +1556,15 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
  */
 void folio_unlock(struct folio *folio)
 {
+	wait_queue_entry_t bookmark;
+
 	/* Bit 7 allows x86 to check the byte's sign bit */
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
-		folio_wake_bit(folio, PG_locked);
+		folio_wake_bit(folio, PG_locked, &bookmark);
 }
 EXPORT_SYMBOL(folio_unlock);
 
@@ -1578,7 +1583,7 @@ void folio_end_private_2(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
 	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
-	folio_wake_bit(folio, PG_private_2);
+	folio_wake_bit(folio, PG_private_2, NULL);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_private_2);
