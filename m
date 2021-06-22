Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB73B050B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhFVMrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhFVMrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:47:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EBC061574;
        Tue, 22 Jun 2021 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OWIsA1Oit7AQXXLQ5DXe0Hy/Xxwav/wEFlQgYMMIN1Y=; b=G1Lp55yzTa9cQIl2/6sE2mITaV
        pPwapSmb2GcIflMAPBApwO9X3pNNt/7TwLF6+ISsVo/LxoyovDsYPoKAAMsksL1Hie+WbfYxAWzBZ
        RREY8TKK7OXwE/p1CWHLanSUz6nqnJw6YdUcNH5tg1p2Nya5yLnk5tNEuu1lLGCvu6grpBOjFJjHF
        CWCDDqoVJk762gBnF/Mv/2Xp/xW4XxrkieWiCrz2enuxBDXNV+oXLsfds6RcJwl7gXvlE4vLGPJMp
        ZTE3NBq5xNByuxkrX49+cXvDeMb7sYZQkg7HIjEpVQqVARt8SvYvR5rJKf2R6tqdr92Tgg3pMv7v8
        sCsFFtXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfjr-00EIDJ-K4; Tue, 22 Jun 2021 12:43:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/46] mm/writeback: Add folio_account_redirty()
Date:   Tue, 22 Jun 2021 13:15:37 +0100
Message-Id: <20210622121551.3398730-33-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Account the number of pages in the folio that we're redirtying.
Turn account_page_dirty() into a wrapper around it.  Also turn
the comment on folio_account_redirty() into kernel-doc and
edit it slightly so it makes sense to its potential callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/writeback.h |  6 +++++-
 mm/page-writeback.c       | 32 +++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index aa372f6d2b55..9883dbf8b763 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -399,7 +399,11 @@ void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
-void account_page_redirty(struct page *page);
+void folio_account_redirty(struct folio *folio);
+static inline void account_page_redirty(struct page *page)
+{
+	folio_account_redirty(page_folio(page));
+}
 
 void sb_mark_inode_writeback(struct inode *inode);
 void sb_clear_inode_writeback(struct inode *inode);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 5fc1137d2c86..d10c7ad4229b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1089,7 +1089,7 @@ static void wb_update_write_bandwidth(struct bdi_writeback *wb,
 	 * write_bandwidth = ---------------------------------------------------
 	 *                                          period
 	 *
-	 * @written may have decreased due to account_page_redirty().
+	 * @written may have decreased due to folio_account_redirty().
 	 * Avoid underflowing @bw calculation.
 	 */
 	bw = written - min(written, wb->written_stamp);
@@ -2529,30 +2529,36 @@ int __set_page_dirty_nobuffers(struct page *page)
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
-/*
- * Call this whenever redirtying a page, to de-account the dirty counters
- * (NR_DIRTIED, WB_DIRTIED, tsk->nr_dirtied), so that they match the written
- * counters (NR_WRITTEN, WB_WRITTEN) in long term. The mismatches will lead to
- * systematic errors in balanced_dirty_ratelimit and the dirty pages position
- * control.
+/**
+ * folio_account_redirty - Manually account for redirtying a page.
+ * @folio: The folio which is being redirtied.
+ *
+ * Most filesystems should call folio_redirty_for_writepage() instead
+ * of this fuction.  If your filesystem is doing writeback outside the
+ * context of a writeback_control(), it can call this when redirtying
+ * a folio, to de-account the dirty counters (NR_DIRTIED, WB_DIRTIED,
+ * tsk->nr_dirtied), so that they match the written counters (NR_WRITTEN,
+ * WB_WRITTEN) in long term. The mismatches will lead to systematic errors
+ * in balanced_dirty_ratelimit and the dirty pages position control.
  */
-void account_page_redirty(struct page *page)
+void folio_account_redirty(struct folio *folio)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 
 	if (mapping && mapping_can_writeback(mapping)) {
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
 		struct wb_lock_cookie cookie = {};
+		unsigned nr = folio_nr_pages(folio);
 
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
-		current->nr_dirtied--;
-		dec_node_page_state(page, NR_DIRTIED);
-		dec_wb_stat(wb, WB_DIRTIED);
+		current->nr_dirtied -= nr;
+		node_stat_mod_folio(folio, NR_DIRTIED, -nr);
+		wb_stat_mod(wb, WB_DIRTIED, -nr);
 		unlocked_inode_to_wb_end(inode, &cookie);
 	}
 }
-EXPORT_SYMBOL(account_page_redirty);
+EXPORT_SYMBOL(folio_account_redirty);
 
 /*
  * When a writepage implementation decides that it doesn't want to write this
-- 
2.30.2

