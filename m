Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B73B04E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFVMop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFVMom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:44:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6878C061756;
        Tue, 22 Jun 2021 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=G4S7L0Dpiu1H1dLc+1cTRl3V6LAt9Zytt7j/Hzdp1+Y=; b=N8oG5COs1Pxx6k8LhqH1ZKc+mu
        yrKX8sJ4uyqJnnvDKZzkjgKcZ/E393XDJgmAmBvEItibdRh6iOPwYhJwsEBM6UTdawEDaSh9CLUKN
        9mxgRuM4faene8MMuPZJC7Yk5lIAfnviBr1U/td8hR1E5hSSUSle2+d0Ygf83v7l+Ii9cwxaJnziB
        VgV/P5QlzJ/oby5bDegGsiX0s7aXQLheeP+N1CTzYzPmx5gGrdph5SNEI6MaYZwoT6vYNzLGsdzR5
        Fukj8Ki7nwBHSU5+h9QKfiOXu1xG29XMy/5g36FewDLYHUKfZFNROXi0A8wPgPEHxlfc9CcuHVl1O
        pV72b6JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfiE-00EI51-QC; Tue, 22 Jun 2021 12:41:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/46] mm/writeback: Add folio_cancel_dirty()
Date:   Tue, 22 Jun 2021 13:15:35 +0100
Message-Id: <20210622121551.3398730-31-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn __cancel_dirty_page() into __folio_cancel_dirty() and add wrappers.
Move the prototypes into pagemap.h since this is page cache functionality.
Saves 44 bytes of kernel text in total; 33 bytes from __folio_cancel_dirty
and 11 from two callers of cancel_dirty_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  7 -------
 include/linux/pagemap.h | 11 +++++++++++
 mm/page-writeback.c     | 16 ++++++++--------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2ccf294afc3e..f0b0779c75cd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1988,13 +1988,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
-void __cancel_dirty_page(struct page *page);
-static inline void cancel_dirty_page(struct page *page)
-{
-	/* Avoid atomic ops, locking, etc. when not actually needed. */
-	if (PageDirty(page))
-		__cancel_dirty_page(page);
-}
 int clear_page_dirty_for_io(struct page *page);
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 084fca551e60..1dc8ab5651c3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -785,6 +785,17 @@ static inline void account_page_cleaned(struct page *page,
 {
 	return folio_account_cleaned(page_folio(page), mapping, wb);
 }
+void __folio_cancel_dirty(struct folio *folio);
+static inline void folio_cancel_dirty(struct folio *folio)
+{
+	/* Avoid atomic ops, locking, etc. when not actually needed. */
+	if (folio_dirty(folio))
+		__folio_cancel_dirty(folio);
+}
+static inline void cancel_dirty_page(struct page *page)
+{
+	folio_cancel_dirty(page_folio(page));
+}
 
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cf48ac5b85f6..a508c5629c15 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2642,28 +2642,28 @@ EXPORT_SYMBOL(set_page_dirty_lock);
  * page without actually doing it through the VM. Can you say "ext3 is
  * horribly ugly"? Thought you could.
  */
-void __cancel_dirty_page(struct page *page)
+void __folio_cancel_dirty(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping = folio_mapping(folio);
 
 	if (mapping_can_writeback(mapping)) {
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
 		struct wb_lock_cookie cookie = {};
 
-		lock_page_memcg(page);
+		lock_folio_memcg(folio);
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
-		if (TestClearPageDirty(page))
-			account_page_cleaned(page, mapping, wb);
+		if (folio_test_clear_dirty_flag(folio))
+			folio_account_cleaned(folio, mapping, wb);
 
 		unlocked_inode_to_wb_end(inode, &cookie);
-		unlock_page_memcg(page);
+		unlock_folio_memcg(folio);
 	} else {
-		ClearPageDirty(page);
+		folio_clear_dirty_flag(folio);
 	}
 }
-EXPORT_SYMBOL(__cancel_dirty_page);
+EXPORT_SYMBOL(__folio_cancel_dirty);
 
 /*
  * Clear a page's dirty flag, while caring for dirty memory accounting.
-- 
2.30.2

