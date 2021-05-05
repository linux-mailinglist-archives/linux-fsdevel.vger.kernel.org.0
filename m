Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF08373EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhEEPyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhEEPyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:54:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4B1C061574;
        Wed,  5 May 2021 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=//OZUZ3SsIacRa4QbrEsdejD5ba7FHxM1Qz1ZvA8ftU=; b=sqnO2i8O9CgWgQrmP1rAE7QlTD
        Z7ad+85cscftUt57TbwY9uTEhjJiJ9IOYsH05d9TSLdYUwNlFhC8FYxnXeXYQ2zGYckPlfcVM1Ulh
        Fb+xsc6E6RXP/UDAwmCpz4uCYhCdtFndp6vQFfRhKvgtaDVJgQqfflqDiXhXfZ9S/gesqXerJ+JbI
        ICJlxpBCFJvxNkjJJ7NPgni87GfymupHiBG8aH4rhF9EFaFIHEplI/qgf0Npd71YmMfAQFDo6R2JW
        418zE3EGcf63gvrnTzh9kQKgHA+CuNXykVYfA5D4cTZ/fWdsn5ZesYrLOXQKVp+LjNj0MdHHL86bP
        qepYEYAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJnP-000WzY-Ch; Wed, 05 May 2021 15:51:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 36/96] mm/filemap: Add folio_wake_bit
Date:   Wed,  5 May 2021 16:05:28 +0100
Message-Id: <20210505150628.111735-37-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index ab66e637eb5a..f5cb6464fe37 100644
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
+		folio_clear_waiters_flag(folio);
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

