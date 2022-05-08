Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41B51F192
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiEHUh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiEHUgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5E11C24
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=k63jQa9iMRPT02R7TYStvnmcS1iPXn7CcKbsGOfcxOM=; b=D/Pe2Ii+W+qHHn2J2m7ve55nOL
        HI7slviBVuWjXHeP03A2VcIqByZiOukf1FLlf1xx4nEGu6GpVAqINHuLxe//47cJmaElK5+veCRb/
        fhdKrzzTj6GmHnL+wKgn6QjwAZeGRu0g3TB9HImis2HQhOH3+eAcnNquprUfkeB5PYqypxC7pDg0l
        0jy/Fw7u65XbRRseBVHLG/i/qNiY0/dyEzfH97YkpAVOkG0X5tRgJ4IXpB0eAkQ6KkZy/OJLch4Fb
        2AvVX71i9vDa1pQrKjFBlgOXJnl4py8750Lmc2KxWyYrZfsAz/6aOlimkNTF63s6r3LTWBRYTL2tt
        21exx66g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaE-002o1x-OL; Sun, 08 May 2022 20:32:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/26] nfs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:36 +0100
Message-Id: <20220508203247.668791-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use folios throughout the release_folio paths.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/file.c    | 22 +++++++++++-----------
 fs/nfs/fscache.h | 14 +++++++-------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 4f6d1f90b87f..d764b3ce7905 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -415,19 +415,19 @@ static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 }
 
 /*
- * Attempt to release the private state associated with a page
- * - Called if either PG_private or PG_fscache is set on the page
- * - Caller holds page lock
- * - Return true (may release page) or false (may not)
+ * Attempt to release the private state associated with a folio
+ * - Called if either private or fscache flags are set on the folio
+ * - Caller holds folio lock
+ * - Return true (may release folio) or false (may not)
  */
-static int nfs_release_page(struct page *page, gfp_t gfp)
+static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 {
-	dfprintk(PAGECACHE, "NFS: release_page(%p)\n", page);
+	dfprintk(PAGECACHE, "NFS: release_folio(%p)\n", folio);
 
-	/* If PagePrivate() is set, then the page is not freeable */
-	if (PagePrivate(page))
-		return 0;
-	return nfs_fscache_release_page(page, gfp);
+	/* If the private flag is set, then the folio is not freeable */
+	if (folio_test_private(folio))
+		return false;
+	return nfs_fscache_release_folio(folio, gfp);
 }
 
 static void nfs_check_dirty_writeback(struct folio *folio,
@@ -522,7 +522,7 @@ const struct address_space_operations nfs_file_aops = {
 	.write_begin = nfs_write_begin,
 	.write_end = nfs_write_end,
 	.invalidate_folio = nfs_invalidate_folio,
-	.releasepage = nfs_release_page,
+	.release_folio = nfs_release_folio,
 	.direct_IO = nfs_direct_IO,
 #ifdef CONFIG_MIGRATION
 	.migratepage = nfs_migrate_page,
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 4e980cc04779..2a37af880978 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -48,14 +48,14 @@ extern void nfs_fscache_release_file(struct inode *, struct file *);
 extern int __nfs_fscache_read_page(struct inode *, struct page *);
 extern void __nfs_fscache_write_page(struct inode *, struct page *);
 
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
+static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
 {
-	if (PageFsCache(page)) {
+	if (folio_test_fscache(folio)) {
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
-		wait_on_page_fscache(page);
-		fscache_note_page_release(nfs_i_fscache(page->mapping->host));
-		nfs_inc_fscache_stats(page->mapping->host,
+		folio_wait_fscache(folio);
+		fscache_note_page_release(nfs_i_fscache(folio->mapping->host));
+		nfs_inc_fscache_stats(folio->mapping->host,
 				      NFSIOS_FSCACHE_PAGES_UNCACHED);
 	}
 	return true;
@@ -129,9 +129,9 @@ static inline void nfs_fscache_open_file(struct inode *inode,
 					 struct file *filp) {}
 static inline void nfs_fscache_release_file(struct inode *inode, struct file *file) {}
 
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
+static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
 {
-	return 1; /* True: may release page */
+	return true; /* may release folio */
 }
 static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
-- 
2.34.1

