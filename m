Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13427BF1BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 05:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442086AbjJJD6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 23:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442102AbjJJD6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:58:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020FBAF;
        Mon,  9 Oct 2023 20:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9931nhg2FnBqt/YdPpANRM0FFFt7P4pS9twc7+d2cis=; b=uK7CoStskG4DABGGOCMq6fPVs0
        V/inaVjtOHuxRfaPTPlQpGI7rMsgnr73KxSsKSiyzTGNH/qkQiWJh6VhXpg5MhSMAwxsJcfAST87r
        2N0AMlaE6vVCEB9hObYQYBW/kSz6W+FjI2Rn0tE7GN/GHFZWiKtIDnhAx1y4+9zTGcHLQqY4imPV+
        V8u+VpBjKRXqjnUUL9eWvx07zjy66ST4ynzoPXGVjUh6WqFmUzB7iyxeLKesrvc03FMgATpEKoObF
        dRsBqT9HFZB1izS56K+Z+mldKgEgPvGiAtlVayyYbpPrweMcVxzBEZhQ8s5oWKascFvgotZdufa1a
        k6GyaV2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qq3tF-002Hak-RS; Tue, 10 Oct 2023 03:58:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Bin Lai <sclaibin@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, akpm@linux-foundation.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] sched: Remove wait bookmarks
Date:   Tue, 10 Oct 2023 04:58:29 +0100
Message-Id: <20231010035829.544242-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231010035829.544242-1-willy@infradead.org>
References: <20231010032833.398033-1-robinlai@tencent.com>
 <20231010035829.544242-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no users of wait bookmarks left, so simplify the wait
code by removing them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/wait.h |  9 +++----
 kernel/sched/wait.c  | 60 ++++++++------------------------------------
 2 files changed, 13 insertions(+), 56 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5ec7739400f4..3473b663176f 100644
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
@@ -212,8 +211,6 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
 int __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
 void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
-void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
-		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 802d98cf2de3..51e38f5f4701 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -57,13 +57,6 @@ void remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry
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
@@ -78,21 +71,13 @@ EXPORT_SYMBOL(remove_wait_queue);
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
@@ -101,21 +86,11 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
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
@@ -125,20 +100,12 @@ static int __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int m
 			int nr_exclusive, int wake_flags, void *key)
 {
 	unsigned long flags;
-	wait_queue_entry_t bookmark;
-	int remaining = nr_exclusive;
+	int remaining;
 
-	bookmark.flags = 0;
-	bookmark.private = NULL;
-	bookmark.func = NULL;
-	INIT_LIST_HEAD(&bookmark.entry);
-
-	do {
-		spin_lock_irqsave(&wq_head->lock, flags);
-		remaining = __wake_up_common(wq_head, mode, remaining,
-						wake_flags, key, &bookmark);
-		spin_unlock_irqrestore(&wq_head->lock, flags);
-	} while (bookmark.flags & WQ_FLAG_BOOKMARK);
+	spin_lock_irqsave(&wq_head->lock, flags);
+	remaining = __wake_up_common(wq_head, mode, nr_exclusive, wake_flags,
+			key);
+	spin_unlock_irqrestore(&wq_head->lock, flags);
 
 	return nr_exclusive - remaining;
 }
@@ -171,23 +138,16 @@ void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode
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
@@ -233,7 +193,7 @@ EXPORT_SYMBOL_GPL(__wake_up_sync_key);
 void __wake_up_locked_sync_key(struct wait_queue_head *wq_head,
 			       unsigned int mode, void *key)
 {
-        __wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL);
+        __wake_up_common(wq_head, mode, 1, WF_SYNC, key);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked_sync_key);
 
-- 
2.40.1

