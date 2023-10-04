Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05787B85D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbjJDQxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243509AbjJDQxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC49B;
        Wed,  4 Oct 2023 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wx30M72VT+hJbOrAJeEy9IuygKjiZCeaf/wYxmq+w0o=; b=VIQWZrcE6oEY3co/PM//ME4nfa
        BtOcRyfUcLSgcqVeWTd40a6YYpq9zruZ2EDbrJbmBafh8zsH7eeVm0d385zTV7lvkjwYpIuH1gXmc
        /7xMagbzbtAlndSsVr7ws4+bR9mH8HrlwlIaqPukYXoRXMB7076uS4Oqi+3nabQ9AQNj6vDba2iYI
        XHcX5iFBH8JvdaVdpO0L18ek+zaY3OlnI35kE36eSbs96v7DxPJ62EXK++7d2ng/dqibc/kOKzwGd
        +Tn+IMnQYAyWHEnPgL4SxTUd1C1Sc0g2Gjfl2etMmn4Ex8NFsX3RKo2oo+ZBxXlqrqnJCJTi8B3WE
        9n78tXEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57g-004SGG-Sx; Wed, 04 Oct 2023 16:53:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 16/17] mm: Make __end_folio_writeback() return void
Date:   Wed,  4 Oct 2023 17:53:16 +0100
Message-Id: <20231004165317.1061855-17-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231004165317.1061855-1-willy@infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than check the result of test-and-clear, just check that we have
the writeback bit set at the start.  This wouldn't catch every case, but
it's good enough (and enables the next patch).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c        |  9 +++++++--
 mm/internal.h       |  2 +-
 mm/page-writeback.c | 38 ++++++++++++++++----------------------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3dad2615af41..ddcced4638b5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1595,9 +1595,15 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
 /**
  * folio_end_writeback - End writeback against a folio.
  * @folio: The folio.
+ *
+ * The folio must actually be under writeback.
+ *
+ * Context: May be called from process or interrupt context.
  */
 void folio_end_writeback(struct folio *folio)
 {
+	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
+
 	/*
 	 * folio_test_clear_reclaim() could be used here but it is an
 	 * atomic operation and overkill in this particular case. Failing
@@ -1617,8 +1623,7 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake().
 	 */
 	folio_get(folio);
-	if (!__folio_end_writeback(folio))
-		BUG();
+	__folio_end_writeback(folio);
 
 	smp_mb__after_atomic();
 	folio_wake(folio, PG_writeback);
diff --git a/mm/internal.h b/mm/internal.h
index 30cf724ddbce..ccb08dd9b5ec 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -105,7 +105,7 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
-bool __folio_end_writeback(struct folio *folio);
+void __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b8d3d7040a50..410b53e888e3 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2940,11 +2940,10 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
 	spin_unlock_irqrestore(&wb->work_lock, flags);
 }
 
-bool __folio_end_writeback(struct folio *folio)
+void __folio_end_writeback(struct folio *folio)
 {
 	long nr = folio_nr_pages(folio);
 	struct address_space *mapping = folio_mapping(folio);
-	bool ret;
 
 	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
@@ -2953,19 +2952,16 @@ bool __folio_end_writeback(struct folio *folio)
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
-		ret = folio_test_clear_writeback(folio);
-		if (ret) {
-			__xa_clear_mark(&mapping->i_pages, folio_index(folio),
-						PAGECACHE_TAG_WRITEBACK);
-			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
-				struct bdi_writeback *wb = inode_to_wb(inode);
-
-				wb_stat_mod(wb, WB_WRITEBACK, -nr);
-				__wb_writeout_add(wb, nr);
-				if (!mapping_tagged(mapping,
-						    PAGECACHE_TAG_WRITEBACK))
-					wb_inode_writeback_end(wb);
-			}
+		folio_test_clear_writeback(folio);
+		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
+					PAGECACHE_TAG_WRITEBACK);
+		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
+			struct bdi_writeback *wb = inode_to_wb(inode);
+
+			wb_stat_mod(wb, WB_WRITEBACK, -nr);
+			__wb_writeout_add(wb, nr);
+			if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+				wb_inode_writeback_end(wb);
 		}
 
 		if (mapping->host && !mapping_tagged(mapping,
@@ -2974,15 +2970,13 @@ bool __folio_end_writeback(struct folio *folio)
 
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
-		ret = folio_test_clear_writeback(folio);
-	}
-	if (ret) {
-		lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-		node_stat_mod_folio(folio, NR_WRITTEN, nr);
+		folio_test_clear_writeback(folio);
 	}
+
+	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+	node_stat_mod_folio(folio, NR_WRITTEN, nr);
 	folio_memcg_unlock(folio);
-	return ret;
 }
 
 bool __folio_start_writeback(struct folio *folio, bool keep_write)
-- 
2.40.1

