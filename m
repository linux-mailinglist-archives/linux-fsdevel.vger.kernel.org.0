Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB075151E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiD2R3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbiD2R3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10685A0BDD
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5tD+FSQ/nAMq2dGk2GcxZrL+cShNG6uIImA7c0IG2h8=; b=e6+UB+JcZ3y54lrLDg5xyEcvwX
        hr7s+TH9jw/GMzSM5c4kpRpNBAZsoUr27nAVDEg5rvw007RoAuJnhZ5v5i2efPU8aw/Q1hWiYGgsT
        FSjriE4kHlL9JG89kHWn80ITUu9hyyKuyNZhryQPXFsJsOh9CjGbUN518/GObaS3xVnnbLmKy46Mr
        BUXBMAfvnW6dDGUWuZjPUc/T+V8SS7zYgGjPoRis3Hph5wm4Kv/wCLy2kU9MMm5pp+9h8SMj2UJLw
        3Q589NdHQ3EpkCsdmdFCZrfNmr36DTiqmCgJDpZ7dAYuLaP287wXcS0sMHvO9nN6MkDMg90pjhZXs
        nvyNAoSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNZ-00CdZf-UK; Fri, 29 Apr 2022 17:26:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 31/69] mm/readahead: Convert page_cache_async_readahead to take a folio
Date:   Fri, 29 Apr 2022 18:25:18 +0100
Message-Id: <20220429172556.3011843-32-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

Removes a couple of calls to compound_head and saves a few bytes.
Also convert verity's read_file_data_page() to be folio-based.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

