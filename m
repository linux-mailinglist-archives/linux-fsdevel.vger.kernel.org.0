Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5553DE13
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351678AbiFETjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351630AbiFETjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1D4DF50;
        Sun,  5 Jun 2022 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OKfTT3lHI1ZyVlt5mIkzU0UCspOZGM/nu3wRRwSA884=; b=oCy+OeGRtDxhYjiC1O/zCFlM1E
        +GLKQJ/W+sccDPBLjY3er2VqLfMCEOwVG2399jOMHXumUU9OHGAIixEoQOi/SpN3be9JrXvF16w/v
        Exl+YnA2i8gI7xqdnzTxw1MPX9mIztUvT6d28MoZlCWW9XP6JT+0/LaRG5ZBAyAOHPy4t3LVhruNY
        x/DFbMg1kb2C6BevSb31Bs4yqYOuNyGLM6eCChRa6QwSRaO+Gdj3Xk/rAclmb0Oonj5FrYQ2yaWx0
        x0PkYd/DRK5vRnOuPNzfMMOJ4i8jB1fSoAiI39Kk4myb97CWXL7S1aAlZ72vXZPLnBJ7fQi0obEck
        +vvpE4IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5R-009wsd-5Z; Sun, 05 Jun 2022 19:38:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 08/10] vmscan: Add check_move_unevictable_folios()
Date:   Sun,  5 Jun 2022 20:38:52 +0100
Message-Id: <20220605193854.2371230-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605193854.2371230-1-willy@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the guts of check_move_unevictable_pages() over to use folios
and add check_move_unevictable_pages() as a wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  3 ++-
 mm/vmscan.c          | 55 ++++++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0c0fed1b348f..8672a7123ccd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -438,7 +438,8 @@ static inline bool node_reclaim_enabled(void)
 	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
 }
 
-extern void check_move_unevictable_pages(struct pagevec *pvec);
+void check_move_unevictable_folios(struct folio_batch *fbatch);
+void check_move_unevictable_pages(struct pagevec *pvec);
 
 extern void kswapd_run(int nid);
 extern void kswapd_stop(int nid);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..5222c5ad600a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4790,45 +4790,56 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 }
 #endif
 
+void check_move_unevictable_pages(struct pagevec *pvec)
+{
+	struct folio_batch fbatch;
+	unsigned i;
+
+	for (i = 0; i < pvec->nr; i++) {
+		struct page *page = pvec->pages[i];
+
+		if (PageTransTail(page))
+			continue;
+		folio_batch_add(&fbatch, page_folio(page));
+	}
+	check_move_unevictable_folios(&fbatch);
+}
+EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
+
 /**
- * check_move_unevictable_pages - check pages for evictability and move to
- * appropriate zone lru list
- * @pvec: pagevec with lru pages to check
+ * check_move_unevictable_folios - Move evictable folios to appropriate zone
+ * lru list
+ * @fbatch: Batch of lru folios to check.
  *
- * Checks pages for evictability, if an evictable page is in the unevictable
+ * Checks folios for evictability, if an evictable folio is in the unevictable
  * lru list, moves it to the appropriate evictable lru list. This function
- * should be only used for lru pages.
+ * should be only used for lru folios.
  */
-void check_move_unevictable_pages(struct pagevec *pvec)
+void check_move_unevictable_folios(struct folio_batch *fbatch)
 {
 	struct lruvec *lruvec = NULL;
 	int pgscanned = 0;
 	int pgrescued = 0;
 	int i;
 
-	for (i = 0; i < pvec->nr; i++) {
-		struct page *page = pvec->pages[i];
-		struct folio *folio = page_folio(page);
-		int nr_pages;
-
-		if (PageTransTail(page))
-			continue;
+	for (i = 0; i < fbatch->nr; i++) {
+		struct folio *folio = fbatch->folios[i];
+		int nr_pages = folio_nr_pages(folio);
 
-		nr_pages = thp_nr_pages(page);
 		pgscanned += nr_pages;
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
+		/* block memcg migration while the folio moves between lrus */
+		if (!folio_test_clear_lru(folio))
 			continue;
 
 		lruvec = folio_lruvec_relock_irq(folio, lruvec);
-		if (page_evictable(page) && PageUnevictable(page)) {
-			del_page_from_lru_list(page, lruvec);
-			ClearPageUnevictable(page);
-			add_page_to_lru_list(page, lruvec);
+		if (folio_evictable(folio) && folio_test_unevictable(folio)) {
+			lruvec_del_folio(lruvec, folio);
+			folio_clear_unevictable(folio);
+			lruvec_add_folio(lruvec, folio);
 			pgrescued += nr_pages;
 		}
-		SetPageLRU(page);
+		folio_set_lru(folio);
 	}
 
 	if (lruvec) {
@@ -4839,4 +4850,4 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 	}
 }
-EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
+EXPORT_SYMBOL_GPL(check_move_unevictable_folios);
-- 
2.35.1

