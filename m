Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AE28C76F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgJMDAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 23:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgJMDAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:00:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC2EC0613D1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 20:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RVbxbYoOWjLwJdgW3Cb8bReeSeO0h546yKG6qIjspYY=; b=H3p/y2nwCsnwVAvyqNJcScmcXf
        7dbIMAax0AH1bYvGMIaeym0IhvhyT8hLJjADqB54QN3VnkHx/0uGoGBm8zuyl3RCFIr2lSfoOWkV7
        jalkTzG/hg1s6mJIBBtK5aO1puGN8Wfk3obKTdNYoPuuZeRmde8Uzf/l+o1wEKpuZrnQPS3SXkCJs
        vM3EYuMX9Lxt6yRXU07HEF0IGLvJ/aTkVvN8H4NxT2wLdEmceUUY7KeQ4FEmDXntbasDpo6SKS3fx
        8HIHW2qYBbBYm4Oh3MmYgDZqUX9uzlQ24cCLc/8rRkLSWgfri1sl7MA5BYd9LzLRzuNwSEaWokgtF
        qz172xuw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSAXq-00076E-Tx; Tue, 13 Oct 2020 03:00:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] mm: Inline __wait_on_page_locked_async into caller
Date:   Tue, 13 Oct 2020 04:00:08 +0100
Message-Id: <20201013030008.27219-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201013030008.27219-1-willy@infradead.org>
References: <20201013030008.27219-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The previous patch removed wait_on_page_locked_async(), so inline
__wait_on_page_locked_async into __lock_page_async().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 53 ++++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ac2dfa857568..a3c299d6a2b6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1224,36 +1224,6 @@ int wait_on_page_bit_killable(struct page *page, int bit_nr)
 }
 EXPORT_SYMBOL(wait_on_page_bit_killable);
 
-static int __wait_on_page_locked_async(struct page *page,
-				       struct wait_page_queue *wait, bool set)
-{
-	struct wait_queue_head *q = page_waitqueue(page);
-	int ret = 0;
-
-	wait->page = page;
-	wait->bit_nr = PG_locked;
-
-	spin_lock_irq(&q->lock);
-	__add_wait_queue_entry_tail(q, &wait->wait);
-	SetPageWaiters(page);
-	if (set)
-		ret = !trylock_page(page);
-	else
-		ret = PageLocked(page);
-	/*
-	 * If we were succesful now, we know we're still on the
-	 * waitqueue as we're still under the lock. This means it's
-	 * safe to remove and return success, we know the callback
-	 * isn't going to trigger.
-	 */
-	if (!ret)
-		__remove_wait_queue(q, &wait->wait);
-	else
-		ret = -EIOCBQUEUED;
-	spin_unlock_irq(&q->lock);
-	return ret;
-}
-
 /**
  * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
  * @page: The page to wait for.
@@ -1421,7 +1391,28 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
 
 int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 {
-	return __wait_on_page_locked_async(page, wait, true);
+	struct wait_queue_head *q = page_waitqueue(page);
+	int ret = 0;
+
+	wait->page = page;
+	wait->bit_nr = PG_locked;
+
+	spin_lock_irq(&q->lock);
+	__add_wait_queue_entry_tail(q, &wait->wait);
+	SetPageWaiters(page);
+	ret = !trylock_page(page);
+	/*
+	 * If we were succesful now, we know we're still on the
+	 * waitqueue as we're still under the lock. This means it's
+	 * safe to remove and return success, we know the callback
+	 * isn't going to trigger.
+	 */
+	if (!ret)
+		__remove_wait_queue(q, &wait->wait);
+	else
+		ret = -EIOCBQUEUED;
+	spin_unlock_irq(&q->lock);
+	return ret;
 }
 
 /*
-- 
2.28.0

