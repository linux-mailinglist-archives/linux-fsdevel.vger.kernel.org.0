Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D834AFE64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiBIUXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6770E046F02
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TrhzrI6l1CteZYMwO3WiLejLQyjybQaTA3AA2dGAD0E=; b=MHus4pX2XBITL5bX8OF6fIc846
        dOXetK347nsVsCDN1GkelnZT/9uqVU3JXx23/WnlugXnWMkN3X3s8cr6HLyBVGqjc/DDISRYzP7eY
        r2kTAAcelkccAZWVxJP7Q8EBVvyk5KKxww9+xdZR4lpv0Jx/wBO1XbIROFv+rNgE7jMnqe8pJc6KH
        zyH5VZl6rK5ffXH3FIB0HawoX3vlgkvUulQ0h/0gl9hruenil+I03FnzYBm7enN55x6PXF1+aTup+
        B4yZ7AceLgFmY4Omov+DAb1ni6r3gmaGZxlrrfi2t9DT3oNcGdE7NZ2Y7tTp8yuHimTPLH5FfV6Jl
        uWsSBa3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTx-008ctX-4v; Wed, 09 Feb 2022 20:22:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 51/56] mm: Convert swap_set_page_dirty() to swap_dirty_folio()
Date:   Wed,  9 Feb 2022 20:22:10 +0000
Message-Id: <20220209202215.2055748-52-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  2 +-
 mm/page_io.c         | 18 ++++++++++--------
 mm/swap_state.c      |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1d38d9475c4d..65a37e555124 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -427,7 +427,7 @@ extern int swap_writepage(struct page *page, struct writeback_control *wbc);
 extern void end_swap_bio_write(struct bio *bio);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	bio_end_io_t end_write_func);
-extern int swap_set_page_dirty(struct page *page);
+bool swap_dirty_folio(struct address_space *mapping, struct folio *folio);
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
diff --git a/mm/page_io.c b/mm/page_io.c
index 24c975fb4e21..8f20f4dad289 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -438,19 +438,21 @@ int swap_readpage(struct page *page, bool synchronous)
 	return ret;
 }
 
-int swap_set_page_dirty(struct page *page)
+bool swap_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	struct swap_info_struct *sis = page_swap_info(page);
+	struct swap_info_struct *sis = swp_swap_info(folio_swap_entry(folio));
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct address_space *mapping = sis->swap_file->f_mapping;
-		const struct address_space_operations *aops = mapping->a_ops;
+		const struct address_space_operations *aops;
+
+		mapping = sis->swap_file->f_mapping;
+		aops = mapping->a_ops;
 
-		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
+		VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
 		if (aops->dirty_folio)
-			return aops->dirty_folio(mapping, page_folio(page));
-		return aops->set_page_dirty(page);
+			return aops->dirty_folio(mapping, folio);
+		return aops->set_page_dirty(&folio->page);
 	} else {
-		return __set_page_dirty_no_writeback(page);
+		return __set_page_dirty_no_writeback(&folio->page);
 	}
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..4772afd08101 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -30,7 +30,7 @@
  */
 static const struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
-	.set_page_dirty	= swap_set_page_dirty,
+	.dirty_folio	= swap_dirty_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
-- 
2.34.1

