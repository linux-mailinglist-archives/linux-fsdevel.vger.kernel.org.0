Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E763370092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhD3Sej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3Sei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:34:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F5CC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Lo64Wz0ItxIZOO0RA1VMfGp2vft/aRbOjR+KN8CExy4=; b=dvgOjMaH/QKRWo3leuG/4e3fwp
        T7BWqJeSQU7y1azq9pDNIJZw12B1ZrXeObeDI5jEJGe7THChdhrA/iMK6OIY6LBMbXEeFY/unWiPY
        1tKBgxiSlJfU7pgwEr8lil9BUGJ6XJq1ix3SNmu7ZlHjpEcfaPDfX0TqH6WQaI0oBBRVOpLVHaiz/
        pl7ivnE2Bff71HCu2QXCWOd7vk+UtNyqadT8Id0y9soO/kax6kqxHXJh6x/I2XQegY5e8nrLVb3vu
        v1tfCn/amULkPvks0PktMz1rRJW3XqGWsOh4voqIRNMRjSAlGvFxDwB2W3np4qhJZhYco9v9dKxlI
        i4rRUMJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXvr-00BNxd-3L; Fri, 30 Apr 2021 18:32:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 28/31] mm/filemap: Add folio_wake_bit
Date:   Fri, 30 Apr 2021 19:07:37 +0100
Message-Id: <20210430180740.2707166-29-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert wake_up_page_bit() to folio_wake_bit().  All callers have a folio,
so use it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 mm/filemap.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 907a947ca21f..8b569a3d2d2a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1121,14 +1121,14 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void wake_up_page_bit(struct page *page, int bit_nr)
+static void folio_wake_bit(struct folio *folio, int bit_nr)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
 	struct wait_page_key key;
 	unsigned long flags;
 	wait_queue_entry_t bookmark;
 
-	key.page = page;
+	key.page = &folio->page;
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
 
@@ -1163,7 +1163,7 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	 * page waiters.
 	 */
 	if (!waitqueue_active(q) || !key.page_match) {
-		ClearPageWaiters(page);
+		folio_clear_waiters(folio);
 		/*
 		 * It's possible to miss clearing Waiters here, when we woke
 		 * our page waiters, but the hashed waitqueue has waiters for
@@ -1179,7 +1179,7 @@ static void folio_wake(struct folio *folio, int bit)
 {
 	if (!folio_waiters(folio))
 		return;
-	wake_up_page_bit(&folio->page, bit);
+	folio_wake_bit(folio, bit);
 }
 
 /*
@@ -1444,7 +1444,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
-		wake_up_page_bit(&folio->page, PG_locked);
+		folio_wake_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(folio_unlock);
 
@@ -1461,11 +1461,12 @@ EXPORT_SYMBOL(folio_unlock);
  */
 void end_page_private_2(struct page *page)
 {
-	page = compound_head(page);
-	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
-	clear_bit_unlock(PG_private_2, &page->flags);
-	wake_up_page_bit(page, PG_private_2);
-	put_page(page);
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!folio_private_2(folio), folio);
+	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
+	folio_wake_bit(folio, PG_private_2);
+	folio_put(folio);
 }
 EXPORT_SYMBOL(end_page_private_2);
 
-- 
2.30.2

