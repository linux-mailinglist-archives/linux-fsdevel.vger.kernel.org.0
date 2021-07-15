Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7853CADE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhGOU3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhGOU3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:29:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A9C061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=g0o7Cuq8kb/CSOO/bLXZOffqZaroMfg4j0pCL7GsUjY=; b=vE3R9YJXheuI3NpHCOkpoGZ3XV
        oTpD67wqikh6G1ojEldc1H2SKs+ccbYEghAvxeSanrPV5DGcoRXRJ6fBsDtS2XNVgj9Gff/m7eGlO
        Z/DDfH848Ul+oYfWp5OWz1IQV+r4n8QeY1t9m2VboB+psCY5eiG0Y7jq5C0v904XlMARanYezk7M/
        +Fp8lgHGrJyshqHb+lGuWKqg36K2SKyZsrQLNZtml5s/o19LFpXamIE2JNlVySdy6/n9I9xQ+FkTF
        vVcn5/4w1fOXMelpHwMoRsWHxanLBygE/fxpv/NENjkXlbn4WY2xfS6kcjbLbF5olW/IEdLfyljbd
        COfl7flg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47ty-003pIv-6a; Thu, 15 Jul 2021 20:24:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 23/39] mm/writeback: Add folio_cancel_dirty()
Date:   Thu, 15 Jul 2021 21:00:14 +0100
Message-Id: <20210715200030.899216-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h      |  7 -------
 include/linux/pagemap.h | 11 +++++++++++
 mm/page-writeback.c     | 16 ++++++++--------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 481019481d10..07ba22351d15 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2005,13 +2005,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
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
index 665ba6a67385..a4d0aeaf884d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -786,6 +786,17 @@ static inline void account_page_cleaned(struct page *page,
 {
 	return folio_account_cleaned(page_folio(page), mapping, wb);
 }
+void __folio_cancel_dirty(struct folio *folio);
+static inline void folio_cancel_dirty(struct folio *folio)
+{
+	/* Avoid atomic ops, locking, etc. when not actually needed. */
+	if (folio_test_dirty(folio))
+		__folio_cancel_dirty(folio);
+}
+static inline void cancel_dirty_page(struct page *page)
+{
+	folio_cancel_dirty(page_folio(page));
+}
 
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 792a83bd3917..0854ef768d06 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2640,28 +2640,28 @@ EXPORT_SYMBOL(set_page_dirty_lock);
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
+		folio_memcg_lock(folio);
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
-		if (TestClearPageDirty(page))
-			account_page_cleaned(page, mapping, wb);
+		if (folio_test_clear_dirty(folio))
+			folio_account_cleaned(folio, mapping, wb);
 
 		unlocked_inode_to_wb_end(inode, &cookie);
-		unlock_page_memcg(page);
+		folio_memcg_unlock(folio);
 	} else {
-		ClearPageDirty(page);
+		folio_clear_dirty(folio);
 	}
 }
-EXPORT_SYMBOL(__cancel_dirty_page);
+EXPORT_SYMBOL(__folio_cancel_dirty);
 
 /*
  * Clear a page's dirty flag, while caring for dirty memory accounting.
-- 
2.30.2

