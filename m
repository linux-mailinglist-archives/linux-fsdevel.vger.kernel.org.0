Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE4929F55C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgJ2TeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJ2TeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F74C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/n41mDNN8SRDTuHLwr+ITcPUNk1MPlDk+yJjScFNfLA=; b=g0vNUxW0T6MxqaqqEh+HadhWEZ
        +OV4xwepyUQjVS4tvFfVvJxH3GRpbKulJXVI440cSz7IJtl2G5khv3kgAHg4JI7gh3nz4Qe1qlv6m
        2WNKqubJTSqbmT+OFXx+9cn9mk8AzjLUmQ2UVlIjw/xNl6m4ZCADn/VvgJLnW2o9AAV+7OIkA7IYb
        UUonl2o+ZxMNxC0yB4Q1OJxQew8HS40zTkm5xhWahODZRoby6bpoDW79RwQQQDsl5UvZgQXKsZzPx
        wvGiwdfcTRDdG0m9EY+2WXyAXjd7F+GpunIdkS9tQGUcxEDLDlJwxza9z+BeyCuIfRohi+Uyqj2jV
        sodeo9Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgZ-0007cd-9Z; Thu, 29 Oct 2020 19:34:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 14/19] mm/filemap: Inline __wait_on_page_locked_async into caller
Date:   Thu, 29 Oct 2020 19:34:00 +0000
Message-Id: <20201029193405.29125-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
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
index 87f89e5dd64e..211a7c1fab3f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1328,36 +1328,6 @@ int wait_on_page_bit_killable(struct page *page, int bit_nr)
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
@@ -1525,7 +1495,28 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
 
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

