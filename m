Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8D4AFE43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiBIUXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB0E040C8D
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=joYO8CNLYBNLe7gqOoh/8VvNMLcnkcDclvLHc86r3NM=; b=MTvoK0q6Hnc+YAiCXJVui9GNKc
        8/GoKFRR1xRu9SXGhsuwHa17K1t+ZYKjOw/w5q8aYK+/f8VWPOKotC9nXxfPSm6rc3s6eKRiH8T0R
        8GnOFxBvzkk2MFJ3JLQIr4CR4fxaGemXMitOh7hVAdDHeb4s2Obyf99JdepvWlGyRIM3+QHE071in
        4GK8dCZ26PdB+FGv60/JJ63wTlzinFK3yoL044XZfi40fiFa4Ft+abmjh9xRELNMNd+1WvwRvCxtb
        +1PwxBkTBEwCOSRhzkoDkhvCmNhYsUhtZnqq/p4E1ouriA0fOjNKLKcf1iFgfXVLx5iNrSmhA5Dyi
        ENJHd1uA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTu-008crD-4O; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 28/56] nfs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:47 +0000
Message-Id: <20220209202215.2055748-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Print the folio index instead of the pointer, since this is more
useful.  We also don't need to use page_file_mapping() as we do not
invalidate swapcache pages.  Since this is the only caller of
nfs_wb_page_cancel(), convert it to nfs_wb_folio_cancel().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/file.c          | 16 ++++++++--------
 fs/nfs/write.c         |  8 ++++----
 include/linux/nfs_fs.h |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 4d681683d13c..30c7d6f949c1 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -406,17 +406,17 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
  * - Called if either PG_private or PG_fscache is set on the page
  * - Caller holds page lock
  */
-static void nfs_invalidate_page(struct page *page, unsigned int offset,
-				unsigned int length)
+static void nfs_invalidate_folio(struct folio *folio, size_t offset,
+				size_t length)
 {
-	dfprintk(PAGECACHE, "NFS: invalidate_page(%p, %u, %u)\n",
-		 page, offset, length);
+	dfprintk(PAGECACHE, "NFS: invalidate_folio(%lu, %zu, %zu)\n",
+		 folio->index, offset, length);
 
-	if (offset != 0 || length < PAGE_SIZE)
+	if (offset != 0 || length < folio_size(folio))
 		return;
 	/* Cancel any unstarted writes on this page */
-	nfs_wb_page_cancel(page_file_mapping(page)->host, page);
-	wait_on_page_fscache(page);
+	nfs_wb_folio_cancel(folio->mapping->host, folio);
+	folio_wait_fscache(folio);
 }
 
 /*
@@ -520,7 +520,7 @@ const struct address_space_operations nfs_file_aops = {
 	.writepages = nfs_writepages,
 	.write_begin = nfs_write_begin,
 	.write_end = nfs_write_end,
-	.invalidatepage = nfs_invalidate_page,
+	.invalidate_folio = nfs_invalidate_folio,
 	.releasepage = nfs_release_page,
 	.direct_IO = nfs_direct_IO,
 #ifdef CONFIG_MIGRATION
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 987a187bd39a..58746afb97ab 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2049,21 +2049,21 @@ int nfs_wb_all(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(nfs_wb_all);
 
-int nfs_wb_page_cancel(struct inode *inode, struct page *page)
+int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 {
 	struct nfs_page *req;
 	int ret = 0;
 
-	wait_on_page_writeback(page);
+	folio_wait_writeback(folio);
 
 	/* blocking call to cancel all requests and join to a single (head)
 	 * request */
-	req = nfs_lock_and_join_requests(page);
+	req = nfs_lock_and_join_requests(&folio->page);
 
 	if (IS_ERR(req)) {
 		ret = PTR_ERR(req);
 	} else if (req) {
-		/* all requests from this page have been cancelled by
+		/* all requests from this folio have been cancelled by
 		 * nfs_lock_and_join_requests, so just remove the head
 		 * request from the inode / page_private pointer and
 		 * release it */
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 333ea05e2531..8826ac075c6f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -583,7 +583,7 @@ extern int  nfs_updatepage(struct file *, struct page *, unsigned int, unsigned
 extern int nfs_sync_inode(struct inode *inode);
 extern int nfs_wb_all(struct inode *inode);
 extern int nfs_wb_page(struct inode *inode, struct page *page);
-extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
+int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(bool never_fail);
 extern void nfs_commit_free(struct nfs_commit_data *data);
-- 
2.34.1

