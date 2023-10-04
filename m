Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F727B85D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbjJDQxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbjJDQxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38FCAB;
        Wed,  4 Oct 2023 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8+vjrjpTMU20NjTh21ymbSWyQ+A6oOAP0PoW8Flxz4A=; b=Kf1rS9d9vz2PJFuFKvV7rph0p1
        HCyHPGHA+FbW1KAMoLhpQu/T9u3tpDlH9vyzTv4mDkTX0yV9Dpe2uN3ldxUDZ+9/i+xmwogS5qTLX
        kqFEqo9od39oL/2d6fXstvwLvJTaE4kIBipi7WvWwrlGAP/Qsrxq0k8cweo7AhCb9Y7zHrF2PA72x
        D9qgc0osOC51gblLOkrYKh983huTeODe/DozdfPHgqA/F5MUrc8QAVjCmkZY6+l0ikP6FRn5y5JLs
        IxZNcoqdFknci4ZLy6qYxJXmgtgyvGn5D5UmxyUKH2SeMwDmUoeBQ4QZRdI8YDQgrgROf03t6vi4R
        La+kEGjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57h-004SGM-0x; Wed, 04 Oct 2023 16:53:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 17/17] mm: Use folio_xor_flags_has_waiters() in folio_end_writeback()
Date:   Wed,  4 Oct 2023 17:53:17 +0100
Message-Id: <20231004165317.1061855-18-willy@infradead.org>
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

Match how folio_unlock() works by combining the test for PG_waiters with
the clearing of PG_writeback.  This should have a small performance win,
and removes the last user of folio_wake().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c        | 15 +++------------
 mm/internal.h       |  2 +-
 mm/page-writeback.c |  9 ++++++---
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ddcced4638b5..56bfba546be7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1177,13 +1177,6 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void folio_wake(struct folio *folio, int bit)
-{
-	if (!folio_test_waiters(folio))
-		return;
-	folio_wake_bit(folio, bit);
-}
-
 /*
  * A choice of three behaviors for folio_wait_bit_common():
  */
@@ -1620,13 +1613,11 @@ void folio_end_writeback(struct folio *folio)
 	 * Writeback does not hold a folio reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
 	 * But here we must make sure that the folio is not freed and
-	 * reused before the folio_wake().
+	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
-	__folio_end_writeback(folio);
-
-	smp_mb__after_atomic();
-	folio_wake(folio, PG_writeback);
+	if (__folio_end_writeback(folio))
+		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
diff --git a/mm/internal.h b/mm/internal.h
index ccb08dd9b5ec..30cf724ddbce 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -105,7 +105,7 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
-void __folio_end_writeback(struct folio *folio);
+bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 410b53e888e3..c52514fe1d23 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2940,10 +2940,11 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
 	spin_unlock_irqrestore(&wb->work_lock, flags);
 }
 
-void __folio_end_writeback(struct folio *folio)
+bool __folio_end_writeback(struct folio *folio)
 {
 	long nr = folio_nr_pages(folio);
 	struct address_space *mapping = folio_mapping(folio);
+	bool ret;
 
 	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
@@ -2952,7 +2953,7 @@ void __folio_end_writeback(struct folio *folio)
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
-		folio_test_clear_writeback(folio);
+		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
 		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 					PAGECACHE_TAG_WRITEBACK);
 		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
@@ -2970,13 +2971,15 @@ void __folio_end_writeback(struct folio *folio)
 
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
-		folio_test_clear_writeback(folio);
+		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
 	}
 
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
 	node_stat_mod_folio(folio, NR_WRITTEN, nr);
 	folio_memcg_unlock(folio);
+
+	return ret;
 }
 
 bool __folio_start_writeback(struct folio *folio, bool keep_write)
-- 
2.40.1

