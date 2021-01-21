Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B849B2FE093
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbhAUEZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbhAUEXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:23:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35769C061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w0fvMxQ182GKATQJ+sHCjBhDyZ2s2tnv5DEs8GhrDzY=; b=jT2F7DnFjoq8+QcRzsL+w+D76r
        ND9x7c1jLioBJefSyTNG1cBvxsWENvkAsKEiwWeRSeQqeEVtgTxLuZLyftTR2dsM9QhLhdAsWLNw0
        UlcEBNVNwfOubImaxno877yRRuxLc4S0abskuFGGfH53pfoAp9WGyj+8r8z/OCfha1zQ2BVTQvQRc
        mhEQ9p7cIDDeAvwnVvZgShyrpD41ORcXcYmFwNTLBb4k0+cNiLel06WvfyA3CU3n1bAJnI3fzzW8e
        06LtNXshL5vO26JJkHsDAxaT6LGQ8XSnyFweVSttWf+mku2F/ivILOcQVbB5x+3z7njRE6Gt4NX7I
        fzNffweQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RSw-00GbMo-C3; Thu, 21 Jan 2021 04:21:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 07/18] mm/filemap: Inline __wait_on_page_locked_async into caller
Date:   Thu, 21 Jan 2021 04:16:05 +0000
Message-Id: <20210121041616.3955703-8-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The previous patch removed wait_on_page_locked_async(), so inline
__wait_on_page_locked_async into __lock_page_async().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 53 ++++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index abbfa44d7c18a..076a97dcacf1e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1342,36 +1342,6 @@ int wait_on_page_bit_killable(struct page *page, int bit_nr)
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
@@ -1539,7 +1509,28 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
 
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
2.29.2

