Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FACA3C4238
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhGLDum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhGLDul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:50:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C6FC0613DD;
        Sun, 11 Jul 2021 20:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VUoFFES+MyX2ydoKEt/DR9LLbb03jHDkt5vlqFuG18M=; b=EaYuP+9RIjdTcMQEVpB0dzikS8
        dpM0XnGVSt8+h1OMmOCrFsRIbvgDd33HD+H4Sv75O4vNxhGmkcV/88Ar/7ODugB/VJUJO7Mt3RjmF
        zBog97CLINvSyLAhFQpMVTQZ3bcZK8qd6NR0x4rNpn58/HKQIwPq+2kHoHgKNNB1vtzY8nIQd+Htg
        mZzzBeNRaeTKPsPYTesCKq9MGN+uNMA///KinS0CFeRhcCIZI8gEAj6T7RkGhXypQJc99sHYChdMj
        dh1f6+ByN2jayBrLmfcSRnQN0b8aWRKTJ5BSLl/CIS8gRozGsA1y+k9QG77VWk84hIrBeQ+k10Jng
        RDbezWCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mu7-00GpXm-J1; Mon, 12 Jul 2021 03:47:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 074/137] mm/writeback: Add folio_account_redirty()
Date:   Mon, 12 Jul 2021 04:05:58 +0100
Message-Id: <20210712030701.4000097-75-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h |  6 +++++-
 mm/page-writeback.c       | 32 +++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index eda9cc778ef6..50cb6e25ab9e 100644
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
index a2a6b4b169c6..593b4f4f5f22 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1084,7 +1084,7 @@ static void wb_update_write_bandwidth(struct bdi_writeback *wb,
 	 * write_bandwidth = ---------------------------------------------------
 	 *                                          period
 	 *
-	 * @written may have decreased due to account_page_redirty().
+	 * @written may have decreased due to folio_account_redirty().
 	 * Avoid underflowing @bw calculation.
 	 */
 	bw = written - min(written, wb->written_stamp);
@@ -2527,30 +2527,36 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 }
 EXPORT_SYMBOL(filemap_dirty_folio);
 
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

