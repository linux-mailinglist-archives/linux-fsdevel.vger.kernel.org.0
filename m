Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439202FA709
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbhARRGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406807AbhARRET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:04:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCB5C0613D6;
        Mon, 18 Jan 2021 09:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2oB1J7YPMqOqaptpQQF6LuJLozA0Blu+qF50Ou3wc1Y=; b=jwWXeT6uvhvwRd/0/yr6+snhwD
        wLTtpIvGcY/vg7Y9pfjmp2YljT7XGF7EwuX5A78Si46+/Jr6hUnTJFuODx40dnXPoljuSyXCfaERf
        vq8yK/k97dYZtggpr+BtE8rzSv+jh3HZ+Peo1++KA+EnRaUnR1DK9QpTDcqV3kXSTFmz2APAbbD/M
        9KTFvq2q1rji3WO5P5HbMQjI4wEoCwyyAQBNUx7PpQ3aTYZJG78lR1XWLOMv5fCuACmZmobPfXLsj
        +1r80vIx+6WDZT+0X0mSgr72VDaRDUDr/iitXpeLdXBJSf7XVhuSCpVk2gfiuAOs/NunXH/dYoiz5
        qjg0ensQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XwC-00D7Wy-0c; Mon, 18 Jan 2021 17:03:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/27] mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
Date:   Mon, 18 Jan 2021 17:01:45 +0000
Message-Id: <20210118170148.3126186-25-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers have a folio, so use it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4ece44f694f6..a2d9ee6e78ae 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1089,14 +1089,14 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void wake_up_page_bit(struct page *page, int bit_nr)
+static void wake_up_folio_bit(struct folio *folio, int bit_nr)
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
 
@@ -1131,7 +1131,7 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	 * page waiters.
 	 */
 	if (!waitqueue_active(q) || !key.page_match) {
-		ClearPageWaiters(page);
+		ClearFolioWaiters(folio);
 		/*
 		 * It's possible to miss clearing Waiters here, when we woke
 		 * our page waiters, but the hashed waitqueue has waiters for
@@ -1147,7 +1147,7 @@ static void wake_up_folio(struct folio *folio, int bit)
 {
 	if (!FolioWaiters(folio))
 		return;
-	wake_up_page_bit(&folio->page, bit);
+	wake_up_folio_bit(folio, bit);
 }
 
 /*
@@ -1447,7 +1447,7 @@ void unlock_folio(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	VM_BUG_ON_FOLIO(!FolioLocked(folio), folio);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio)))
-		wake_up_page_bit(&folio->page, PG_locked);
+		wake_up_folio_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(unlock_folio);
 
-- 
2.29.2

