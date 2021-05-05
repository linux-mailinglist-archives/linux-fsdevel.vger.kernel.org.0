Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C7373F7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhEEQWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhEEQWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:22:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC48C061574;
        Wed,  5 May 2021 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BnJk0gPMnxZFsHC5CI5cmUpF74846hkGlFBAZthABx8=; b=ArLijlqlgvX1QLjJ23z4tXK22x
        jG/eCZ7Q9w3J/MxVMSfew/Oiqdkx5AbAT2vZ2j5ssjChLJapB/gwv0WpCT/iJJLT618sSwy3mBh8+
        SDvGaQ80DGnzZVPCbS8+J8yPke9LUqtPWa7c9m1Qa+nnoYsRX9Gk06fypxlNQkTNNCgpfvXRVlFj0
        cjUHQUcf37pkGPMjUDtTxOKelGRaEjdyihjl/2SXRp57k278ph134VdGDl1dXJjo38B99YVjbo/Ww
        mgIjmMAbFMQHI8ZWUthtNdSEuehrQo+2x9t6Au9TA3S6QpyjE3qj1eNiHHfkNwH5NVXTilMTWTKju
        Tb43E+jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKFX-000a0v-Ux; Wed, 05 May 2021 16:19:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 64/96] mm/writeback: Add folio_cancel_dirty
Date:   Wed,  5 May 2021 16:05:56 +0100
Message-Id: <20210505150628.111735-65-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 0beb94071a15..5ed887d51d07 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1996,13 +1996,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
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
index a5933bcb5f00..53a1b925f54e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -847,6 +847,17 @@ static inline void account_page_cleaned(struct page *page,
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
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 261eb64387a9..57b39e2d46ac 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2655,28 +2655,28 @@ EXPORT_SYMBOL(set_page_dirty_lock);
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

