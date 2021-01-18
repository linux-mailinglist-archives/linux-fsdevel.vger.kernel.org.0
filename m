Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391482FA71E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406834AbhARRKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406778AbhARREQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:04:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B2C0613CF;
        Mon, 18 Jan 2021 09:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2qoQOefQjZT+2cBU0HKwV7AQGtpSse4IDI44+wTaQRY=; b=CFHhG92YpHczS4DCop1lhWMPQB
        IV6stWUPh0doznALnfwn3pJa7bsBbZV7RnCEZ/Sp9Tg8qhZrqCdI6eCWziLkerfGF/JA5qw7X9A72
        ficE7Yf/jZoPPm/w/uH00ULSV5c+jARgeJN1syeDe5DDbsTcG3pDuz/omofPeyNM7R5h79Vqq0kW9
        +ObHUmhJWC1QOY5KMvMp49fmWC7FRTBQw4N4fr4BJbTIgThKoWop2//EqQ9WjDOzEAZYEPJU81psI
        vJwJQ4GqJfMMKpTTmOEZCpIcKQSQ78GOD5PWwmsH7wh32ZYeGHzQQxEO1k4XGmblkA297BnIH6nUF
        2IE43X5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XwD-00D7XC-0o; Mon, 18 Jan 2021 17:03:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/27] mm: Convert test_clear_page_writeback to test_clear_folio_writeback
Date:   Mon, 18 Jan 2021 17:01:46 +0000
Message-Id: <20210118170148.3126186-26-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The one caller of test_clear_page_writeback() already has a folio, so make
it clear that test_clear_page_writeback() operates on the entire folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  2 +-
 mm/filemap.c               |  2 +-
 mm/page-writeback.c        | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ef0f68320917..b43601f5c338 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -594,7 +594,7 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
+int test_clear_folio_writeback(struct folio *folio);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
diff --git a/mm/filemap.c b/mm/filemap.c
index a2d9ee6e78ae..2b6caa0f9f93 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1476,7 +1476,7 @@ void end_folio_writeback(struct folio *folio)
 	 * reused before the wake_up_folio().
 	 */
 	get_folio(folio);
-	if (!test_clear_page_writeback(&folio->page))
+	if (!test_clear_folio_writeback(folio))
 		BUG();
 
 	smp_mb__after_atomic();
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 908fc7f60ae7..db8a99e4a3d2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2719,24 +2719,24 @@ int clear_page_dirty_for_io(struct page *page)
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-int test_clear_page_writeback(struct page *page)
+int test_clear_folio_writeback(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping = folio_mapping(folio);
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 	int ret;
 
-	memcg = lock_page_memcg(page);
-	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	memcg = lock_folio_memcg(folio);
+	lruvec = mem_cgroup_folio_lruvec(folio, folio_pgdat(folio));
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
-		ret = TestClearPageWriteback(page);
+		ret = TestClearFolioWriteback(folio);
 		if (ret) {
-			__xa_clear_mark(&mapping->i_pages, page_index(page),
+			__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 						PAGECACHE_TAG_WRITEBACK);
 			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
 				struct bdi_writeback *wb = inode_to_wb(inode);
@@ -2752,12 +2752,12 @@ int test_clear_page_writeback(struct page *page)
 
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
-		ret = TestClearPageWriteback(page);
+		ret = TestClearFolioWriteback(folio);
 	}
 	if (ret) {
 		dec_lruvec_state(lruvec, NR_WRITEBACK);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		inc_node_page_state(page, NR_WRITTEN);
+		dec_zone_folio_stat(folio, NR_ZONE_WRITE_PENDING);
+		inc_node_folio_stat(folio, NR_WRITTEN);
 	}
 	__unlock_page_memcg(memcg);
 	return ret;
-- 
2.29.2

