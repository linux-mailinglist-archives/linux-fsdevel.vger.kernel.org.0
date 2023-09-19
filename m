Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6887A58BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjISEwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjISEvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D7F12E;
        Mon, 18 Sep 2023 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+YBw7XPXspc4BRLBjqz7GsBiioMj9hvjismckYKmXec=; b=ppqszN0mwK3zh8tqbJY6MTDvp5
        1CXrtZ4Q5igFYGx08wqB2yE98fW3BmAfa/tahG6/6/qv9PAL2aa1qXz11Q9wixYhw6OxTnNX+fHvx
        ByRhoZvIe7OJqxH05vG0XbFwaGiIPhGEuPNuSDZF/76Ymv3o5RIHS6WaKbEHyAu3Y68KPLr25svdz
        1Yo/gYYlS00JhJNZX8N+9jcTanYB+r+TAN6/bm4YfQneF/p5g45HTNdCMB1Qp0rdr9Pv8dm1xOG76
        kOJUy7xcIIenqEGYDUjfx2QfJGRFEmU0j8CaZb9v3TQa4rLAjp5NuBDiDXpipKitTDq81NA45aTIg
        AKVLYGeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi3-00FFku-Fy; Tue, 19 Sep 2023 04:51:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 11/26] nilfs2: Convert nilfs_copy_page() to nilfs_copy_folio()
Date:   Tue, 19 Sep 2023 05:51:20 +0100
Message-Id: <20230919045135.3635437-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both callers already have a folio, so pass it in and use it directly.
Removes a lot of hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/page.c | 50 +++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 1c075bd906c9..696215d899bf 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -184,30 +184,32 @@ void nilfs_page_bug(struct page *page)
 }
 
 /**
- * nilfs_copy_page -- copy the page with buffers
- * @dst: destination page
- * @src: source page
- * @copy_dirty: flag whether to copy dirty states on the page's buffer heads.
+ * nilfs_copy_folio -- copy the folio with buffers
+ * @dst: destination folio
+ * @src: source folio
+ * @copy_dirty: flag whether to copy dirty states on the folio's buffer heads.
  *
- * This function is for both data pages and btnode pages.  The dirty flag
- * should be treated by caller.  The page must not be under i/o.
- * Both src and dst page must be locked
+ * This function is for both data folios and btnode folios.  The dirty flag
+ * should be treated by caller.  The folio must not be under i/o.
+ * Both src and dst folio must be locked
  */
-static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
+static void nilfs_copy_folio(struct folio *dst, struct folio *src,
+		bool copy_dirty)
 {
 	struct buffer_head *dbh, *dbufs, *sbh;
 	unsigned long mask = NILFS_BUFFER_INHERENT_BITS;
 
-	BUG_ON(PageWriteback(dst));
+	BUG_ON(folio_test_writeback(dst));
 
-	sbh = page_buffers(src);
-	if (!page_has_buffers(dst))
-		create_empty_buffers(dst, sbh->b_size, 0);
+	sbh = folio_buffers(src);
+	dbh = folio_buffers(dst);
+	if (!dbh)
+		dbh = folio_create_empty_buffers(dst, sbh->b_size, 0);
 
 	if (copy_dirty)
 		mask |= BIT(BH_Dirty);
 
-	dbh = dbufs = page_buffers(dst);
+	dbufs = dbh;
 	do {
 		lock_buffer(sbh);
 		lock_buffer(dbh);
@@ -218,16 +220,16 @@ static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
 		dbh = dbh->b_this_page;
 	} while (dbh != dbufs);
 
-	copy_highpage(dst, src);
+	folio_copy(dst, src);
 
-	if (PageUptodate(src) && !PageUptodate(dst))
-		SetPageUptodate(dst);
-	else if (!PageUptodate(src) && PageUptodate(dst))
-		ClearPageUptodate(dst);
-	if (PageMappedToDisk(src) && !PageMappedToDisk(dst))
-		SetPageMappedToDisk(dst);
-	else if (!PageMappedToDisk(src) && PageMappedToDisk(dst))
-		ClearPageMappedToDisk(dst);
+	if (folio_test_uptodate(src) && !folio_test_uptodate(dst))
+		folio_mark_uptodate(dst);
+	else if (!folio_test_uptodate(src) && folio_test_uptodate(dst))
+		folio_clear_uptodate(dst);
+	if (folio_test_mappedtodisk(src) && !folio_test_mappedtodisk(dst))
+		folio_set_mappedtodisk(dst);
+	else if (!folio_test_mappedtodisk(src) && folio_test_mappedtodisk(dst))
+		folio_clear_mappedtodisk(dst);
 
 	do {
 		unlock_buffer(sbh);
@@ -269,7 +271,7 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 			NILFS_PAGE_BUG(&folio->page,
 				       "found empty page in dat page cache");
 
-		nilfs_copy_page(&dfolio->page, &folio->page, 1);
+		nilfs_copy_folio(dfolio, folio, true);
 		filemap_dirty_folio(folio_mapping(dfolio), dfolio);
 
 		folio_unlock(dfolio);
@@ -314,7 +316,7 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 		if (!IS_ERR(dfolio)) {
 			/* overwrite existing folio in the destination cache */
 			WARN_ON(folio_test_dirty(dfolio));
-			nilfs_copy_page(&dfolio->page, &folio->page, 0);
+			nilfs_copy_folio(dfolio, folio, false);
 			folio_unlock(dfolio);
 			folio_put(dfolio);
 			/* Do we not need to remove folio from smap here? */
-- 
2.40.1

