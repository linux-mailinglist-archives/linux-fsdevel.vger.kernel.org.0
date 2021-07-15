Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F963C978A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhGOEiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhGOEiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:38:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B0C06175F;
        Wed, 14 Jul 2021 21:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nAVhJhPgs9JCo9GLJfkkyNHsB4kGgY5zRUqQ0AFIy8o=; b=A2cOKevTGGoSh+hykqhWlN50kO
        ucJk3k9+eWpKUMuItWU1RR/y8jNTBgBjBTIEJ8cjulz9bYHqxXFDYxzyh8SIY2IBfLQ1f1wkHsiXI
        yHpuIcwOtMFbgZPJoo1VJsoy5OyadcSOItzfEB39C0r6UjrRflLktKvorgoycQ5cmhpugqtnip5v2
        ojB76x0s2dXKh9WWPecrZDUOgoPt8p557S4RVIlCktu+cbdEtmT97Ec6lef3Y/lQOaHtZ6LFOlONe
        PUSMvdq4NseNh36gCv9mHT13GVJnGySGoI6pTnu3qrgBhYeE3i8KQj5X/AR3zDEtrxw7JrbPwM/Wp
        0oOf5Yng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3t49-002xp0-92; Thu, 15 Jul 2021 04:33:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 072/138] mm/writeback: Add folio_account_cleaned()
Date:   Thu, 15 Jul 2021 04:35:58 +0100
Message-Id: <20210715033704.692967-73-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get the statistics right; compound pages were being accounted as a
single page.  This didn't matter before now as no filesystem which
supported compound pages did writeback.  Also move the declaration
to filemap.h since this is part of the page cache.  Add a wrapper for
account_page_cleaned().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h      |  3 ---
 include/linux/pagemap.h |  7 +++++++
 mm/page-writeback.c     | 11 ++++++-----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 43c1b5731c7f..481019481d10 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,7 +39,6 @@ struct anon_vma_chain;
 struct file_ra_state;
 struct user_struct;
 struct writeback_control;
-struct bdi_writeback;
 struct pt_regs;
 
 extern int sysctl_page_lock_unfairness;
@@ -2003,8 +2002,6 @@ extern void do_invalidatepage(struct page *page, unsigned int offset,
 
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
-void account_page_cleaned(struct page *page, struct address_space *mapping,
-			  struct bdi_writeback *wb);
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3d88c17fedc9..665ba6a67385 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -779,6 +779,13 @@ static inline void __set_page_dirty(struct page *page,
 {
 	__folio_mark_dirty(page_folio(page), mapping, warn);
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
index bd97c461d499..792a83bd3917 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2453,14 +2453,15 @@ static void folio_account_dirtied(struct folio *folio,
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

