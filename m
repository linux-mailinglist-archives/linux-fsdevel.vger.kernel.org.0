Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20951F156
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiEHUfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiEHUfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D166143
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4gNsbg7HBZABnzrWd9CyxUMO6izo5GFS0X6udbMF3eg=; b=hEviBW1FBN6hrfr4E7pejaI8r3
        ug/56emmNMtjSGEvbn+1/FS2Y++dEpJ3iwDlRy8NS46voWHlD4DcOlasAJ/VTP6aFyZEvtHv34wNu
        GIdwL6JAUOkp04p1U9KQEWk59BNyih3dadmjkoEK+SQ4qSAjiuixm5ck8ORZLsndHmSgXXG4pYvwb
        kbHdwLVX7K4mGG0Nau+A7vzndDFsdb1PUTXQ5chIII1BIwtasARKmooMQ3ZMEIpikZH7MHx2fNpop
        gsf0iE5msZ1AP7A93Fgk9FThwLAF/wS2PS6IlsZPawQRrTTsEbVNgTg7UH+phciwjc8wKgi8sWoAs
        HuwF2bLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnYh-002nkc-UF; Sun, 08 May 2022 20:31:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] mm/readahead: Convert page_cache_async_readahead to take a folio
Date:   Sun,  8 May 2022 21:31:10 +0100
Message-Id: <20220508203111.667840-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203111.667840-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203111.667840-1-willy@infradead.org>
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

Removes a couple of calls to compound_head and saves a few bytes.
Also convert verity's read_file_data_page() to be folio-based.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/relocation.c   |  5 +++--
 fs/btrfs/send.c         |  3 ++-
 fs/verity/enable.c      | 29 ++++++++++++++---------------
 include/linux/pagemap.h |  6 +++---
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fdc2c4b411f0..9ae06895ffc9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2967,8 +2967,9 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 		goto release_page;
 
 	if (PageReadahead(page))
-		page_cache_async_readahead(inode->i_mapping, ra, NULL, page,
-				   page_index, last_index + 1 - page_index);
+		page_cache_async_readahead(inode->i_mapping, ra, NULL,
+				page_folio(page), page_index,
+				last_index + 1 - page_index);
 
 	if (!PageUptodate(page)) {
 		btrfs_readpage(NULL, page);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7d1642937274..b327dbe0cbf5 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4986,7 +4986,8 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 
 		if (PageReadahead(page)) {
 			page_cache_async_readahead(inode->i_mapping, &sctx->ra,
-				NULL, page, index, last_index + 1 - index);
+						NULL, page_folio(page), index,
+						last_index + 1 - index);
 		}
 
 		if (!PageUptodate(page)) {
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 60a4372aa4d7..f75d2c010f36 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -18,27 +18,26 @@
  * Read a file data page for Merkle tree construction.  Do aggressive readahead,
  * since we're sequentially reading the entire file.
  */
-static struct page *read_file_data_page(struct file *filp, pgoff_t index,
+static struct page *read_file_data_page(struct file *file, pgoff_t index,
 					struct file_ra_state *ra,
 					unsigned long remaining_pages)
 {
-	struct page *page;
+	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, index);
+	struct folio *folio;
 
-	page = find_get_page_flags(filp->f_mapping, index, FGP_ACCESSED);
-	if (!page || !PageUptodate(page)) {
-		if (page)
-			put_page(page);
+	folio = __filemap_get_folio(ractl.mapping, index, FGP_ACCESSED, 0);
+	if (!folio || !folio_test_uptodate(folio)) {
+		if (folio)
+			folio_put(folio);
 		else
-			page_cache_sync_readahead(filp->f_mapping, ra, filp,
-						  index, remaining_pages);
-		page = read_mapping_page(filp->f_mapping, index, NULL);
-		if (IS_ERR(page))
-			return page;
+			page_cache_sync_ra(&ractl, remaining_pages);
+		folio = read_cache_folio(ractl.mapping, index, NULL, file);
+		if (IS_ERR(folio))
+			return &folio->page;
 	}
-	if (PageReadahead(page))
-		page_cache_async_readahead(filp->f_mapping, ra, filp, page,
-					   index, remaining_pages);
-	return page;
+	if (folio_test_readahead(folio))
+		page_cache_async_ra(&ractl, folio, remaining_pages);
+	return folio_file_page(folio, index);
 }
 
 static int build_merkle_tree_level(struct file *filp, unsigned int level,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 60657132080f..b70192f56454 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1242,7 +1242,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
  * @mapping: address_space which holds the pagecache and I/O vectors
  * @ra: file_ra_state which holds the readahead state
  * @file: Used by the filesystem for authentication.
- * @page: The page at @index which triggered the readahead call.
+ * @folio: The folio at @index which triggered the readahead call.
  * @index: Index of first page to be read.
  * @req_count: Total number of pages being read by the caller.
  *
@@ -1254,10 +1254,10 @@ void page_cache_sync_readahead(struct address_space *mapping,
 static inline
 void page_cache_async_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file,
-		struct page *page, pgoff_t index, unsigned long req_count)
+		struct folio *folio, pgoff_t index, unsigned long req_count)
 {
 	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
-	page_cache_async_ra(&ractl, page_folio(page), req_count);
+	page_cache_async_ra(&ractl, folio, req_count);
 }
 
 static inline struct folio *__readahead_folio(struct readahead_control *ractl)
-- 
2.34.1

