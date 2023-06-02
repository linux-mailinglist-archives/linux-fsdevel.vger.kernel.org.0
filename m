Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2C720BE1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjFBWY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFBWYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:24:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0A9D;
        Fri,  2 Jun 2023 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5WkUXUai2QzTLlts672Sdv2nVGg5BRD8bnOo/7S20j0=; b=v3GeLnbGiewAuhFslvyJ8eR6xV
        GxkFftGrM3UmXtCLBYTEPyfmbFv8ChRbrik4DOpTsz9KA5uMpTHxm2Cwkvv6MIq9ZMZuoeBGOf4dK
        qSk8ZtZi6GVtDlx/P7J2mUiiPOng4WEBcCiXkRXa9QBbaf+e+xYaQCXRsbnQ0AAmzBgdeSI9qK7+n
        /W5rlqgeJ3tRh3X5+eQHxSpYDRfasZ0pbvpzBPdDwtKIDXAl/ZZ/3N0hfzAF0NQYL+QpbIhGbXVVH
        YvV+G/xiQ/A2tHRgQPMc4iV0wD4ZDzXnF668WDs4J3iHzRN0botpHTYTFnKfAp/L4Vak55rzQeD0M
        6WWDbE9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5DCQ-009aPO-Vs; Fri, 02 Jun 2023 22:24:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 4/7] filemap: Add fgp_t typedef
Date:   Fri,  2 Jun 2023 23:24:41 +0100
Message-Id: <20230602222445.2284892-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230602222445.2284892-1-willy@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similarly to gfp_t, define fgp_t as its own type to prevent various
misuses and confusion.  Move the documentation to the definition of the
type insted of burying it in the __filemap_get_folio() documentation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/file.c         |  6 +++---
 fs/f2fs/compress.c      |  2 +-
 fs/f2fs/f2fs.h          |  2 +-
 fs/iomap/buffered-io.c  |  2 +-
 include/linux/pagemap.h | 48 +++++++++++++++++++++++++++++++----------
 mm/filemap.c            | 19 ++--------------
 mm/folio-compat.c       |  2 +-
 7 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f649647392e0..4bbbbdafb472 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -876,9 +876,9 @@ static int prepare_uptodate_page(struct inode *inode,
 	return 0;
 }
 
-static unsigned int get_prepare_fgp_flags(bool nowait)
+static fgp_t get_prepare_fgp_flags(bool nowait)
 {
-	unsigned int fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
+	fgp_t fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
 
 	if (nowait)
 		fgp_flags |= FGP_NOWAIT;
@@ -910,7 +910,7 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 	int i;
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
-	unsigned int fgp_flags = get_prepare_fgp_flags(nowait);
+	fgp_t fgp_flags = get_prepare_fgp_flags(nowait);
 	int err = 0;
 	int faili;
 
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 11653fa79289..ee358f5f2a86 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1019,7 +1019,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	struct address_space *mapping = cc->inode->i_mapping;
 	struct page *page;
 	sector_t last_block_in_bio;
-	unsigned fgp_flag = FGP_LOCK | FGP_WRITE | FGP_CREAT;
+	fgp_t fgp_flag = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
 	int i, ret;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d211ee89c158..a03c3df75f7c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2715,7 +2715,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 
 static inline struct page *f2fs_pagecache_get_page(
 				struct address_space *mapping, pgoff_t index,
-				int fgp_flags, gfp_t gfp_mask)
+				fgp_t fgp_flags, gfp_t gfp_mask)
 {
 	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET))
 		return NULL;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2054b85c9d9b..30d53b50ee0f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -467,7 +467,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  */
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
 {
-	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
+	fgp_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..7ab57a2bb576 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -497,22 +497,48 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 pgoff_t page_cache_prev_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan);
 
-#define FGP_ACCESSED		0x00000001
-#define FGP_LOCK		0x00000002
-#define FGP_CREAT		0x00000004
-#define FGP_WRITE		0x00000008
-#define FGP_NOFS		0x00000010
-#define FGP_NOWAIT		0x00000020
-#define FGP_FOR_MMAP		0x00000040
-#define FGP_STABLE		0x00000080
+/**
+ * typedef fgp_t - Flags for getting folios from the page cache.
+ *
+ * Most users of the page cache will not need to use these flags;
+ * there are convenience functions such as filemap_get_folio() and
+ * filemap_lock_folio().  For users which need more control over exactly
+ * what is done with the folios, these flags to __filemap_get_folio()
+ * are available.
+ *
+ * * %FGP_ACCESSED - The folio will be marked accessed.
+ * * %FGP_LOCK - The folio is returned locked.
+ * * %FGP_CREAT - If no folio is present then a new folio is allocated,
+ *   added to the page cache and the VM's LRU list.  The folio is
+ *   returned locked.
+ * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
+ *   folio is already in cache.  If the folio was allocated, unlock it
+ *   before returning so the caller can do the same dance.
+ * * %FGP_WRITE - The folio will be written to by the caller.
+ * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
+ * * %FGP_NOWAIT - Don't block on the folio lock.
+ * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
+ *   implementation.
+ */
+typedef unsigned int __bitwise fgp_t;
+
+#define FGP_ACCESSED		((__force fgp_t)0x00000001)
+#define FGP_LOCK		((__force fgp_t)0x00000002)
+#define FGP_CREAT		((__force fgp_t)0x00000004)
+#define FGP_WRITE		((__force fgp_t)0x00000008)
+#define FGP_NOFS		((__force fgp_t)0x00000010)
+#define FGP_NOWAIT		((__force fgp_t)0x00000020)
+#define FGP_FOR_MMAP		((__force fgp_t)0x00000040)
+#define FGP_STABLE		((__force fgp_t)0x00000080)
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp);
+		fgp_t fgp_flags, gfp_t gfp);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp);
+		fgp_t fgp_flags, gfp_t gfp);
 
 /**
  * filemap_get_folio - Find and get a folio.
@@ -586,7 +612,7 @@ static inline struct page *find_get_page(struct address_space *mapping,
 }
 
 static inline struct page *find_get_page_flags(struct address_space *mapping,
-					pgoff_t offset, int fgp_flags)
+					pgoff_t offset, fgp_t fgp_flags)
 {
 	return pagecache_get_page(mapping, offset, fgp_flags, 0);
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index b4c9bd368b7e..eb89a815f2f8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1887,30 +1887,15 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Looks up the page cache entry at @mapping & @index.
  *
- * @fgp_flags can be zero or more of these flags:
- *
- * * %FGP_ACCESSED - The folio will be marked accessed.
- * * %FGP_LOCK - The folio is returned locked.
- * * %FGP_CREAT - If no page is present then a new page is allocated using
- *   @gfp and added to the page cache and the VM's LRU list.
- *   The page is returned locked and with an increased refcount.
- * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
- *   page is already in cache.  If the page was allocated, unlock it before
- *   returning so the caller can do the same dance.
- * * %FGP_WRITE - The page will be written to by the caller.
- * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
- * * %FGP_NOWAIT - Don't get blocked by page lock.
- * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
- *
  * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
  * if the %GFP flags specified for %FGP_CREAT are atomic.
  *
- * If there is a page cache page, it is returned with an increased refcount.
+ * If this function returns a folio, it is returned with an increased refcount.
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp)
+		fgp_t fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index c6f056c20503..ae1a737d2533 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(add_to_page_cache_lru);
 
 noinline
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp)
+		fgp_t fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
 
-- 
2.39.2

