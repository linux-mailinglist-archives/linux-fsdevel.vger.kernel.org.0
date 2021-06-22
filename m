Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD873B04DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhFVMoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhFVMnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:43:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09FC061760;
        Tue, 22 Jun 2021 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=74EQ/Vh8HIeLSGmN5SFoIb07z2jpOw528IJHSUo/kAM=; b=SNvn81yzPAz475xvMiHpyJXjhA
        M7wvPR6T0UJaUFzQ9yHWAZ0KTJ4eGug0ZZ6YNywDso1CETHhfY1RXsFlclL4CUXkSy5iVw6IEonsJ
        DoERzuRXhnsxs8oah/dQ0uS3gI3FlEWMRENTFnuwF8GrY59L8HpxZC+syAYW0/jyTIJkiy3c5gidX
        NRoDLYvB0vYiELnqFUCAodoJSIhJo/i8nIrsybt/IqTVDOBNEL4w3voORc0PuFXq39VIM89OWNH4y
        da1x9HcnlPJ9V3+nIM8QROp0NNhAU3EQmmUh5lFiUro0uWTZhMOrB8ddqyEviDS5mZaNx4XUrr3WD
        +cGmEH8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfhe-00EI0i-9H; Tue, 22 Jun 2021 12:40:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/46] mm/writeback: Add folio_account_cleaned()
Date:   Tue, 22 Jun 2021 13:15:34 +0100
Message-Id: <20210622121551.3398730-30-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get the statistics right; compound pages were being accounted as a
single page.  Also move the declaration to filemap.h since this is
part of the page cache.  Add a wrapper for account_page_cleaned().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  3 ---
 include/linux/pagemap.h |  7 +++++++
 mm/page-writeback.c     | 11 ++++++-----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3c8dfcb56fa5..2ccf294afc3e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,7 +39,6 @@ struct anon_vma_chain;
 struct file_ra_state;
 struct user_struct;
 struct writeback_control;
-struct bdi_writeback;
 struct pt_regs;
 
 extern int sysctl_page_lock_unfairness;
@@ -1986,8 +1985,6 @@ extern void do_invalidatepage(struct page *page, unsigned int offset,
 
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
-void account_page_cleaned(struct page *page, struct address_space *mapping,
-			  struct bdi_writeback *wb);
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e6a9756293aa..084fca551e60 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -778,6 +778,13 @@ static inline void __set_page_dirty(struct page *page,
 {
 	__folio_mark_dirty((struct folio *)page, mapping, warn);
 }
+void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
+			  struct bdi_writeback *wb);
+static inline void account_page_cleaned(struct page *page,
+		struct address_space *mapping, struct bdi_writeback *wb)
+{
+	return folio_account_cleaned(page_folio(page), mapping, wb);
+}
 
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 64b989eff9f5..cf48ac5b85f6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2449,14 +2449,15 @@ static void folio_account_dirtied(struct folio *folio,
  *
  * Caller must hold lock_page_memcg().
  */
-void account_page_cleaned(struct page *page, struct address_space *mapping,
+void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
 			  struct bdi_writeback *wb)
 {
 	if (mapping_can_writeback(mapping)) {
-		dec_lruvec_page_state(page, NR_FILE_DIRTY);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		dec_wb_stat(wb, WB_RECLAIMABLE);
-		task_io_account_cancelled_write(PAGE_SIZE);
+		long nr = folio_nr_pages(folio);
+		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+		wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+		task_io_account_cancelled_write(folio_size(folio));
 	}
 }
 
-- 
2.30.2

