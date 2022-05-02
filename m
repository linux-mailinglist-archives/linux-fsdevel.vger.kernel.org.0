Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180C8516A7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383396AbiEBF7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiEBF7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:59:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12D1FA5D
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aFtXLkxvKW3WaOUzPH0fgzx0TPYNNNK7eiVaMOAvKZA=; b=TdbfngsfZhsUA1rt24DQFqLLLl
        uL0wEBN7WVVvXyvlQmXIfHW5UoPXkLFFJz1kRcU524Wl1M4hPUp74GadXACORI4ZAVqvinoLFzrDT
        lm5VYPKBsVBItPXzTxBMkgNDwAuuprcUHrq5J4GDuZQbkjR3QwQkgq5MLk7u8TpR780+ACrQh0I4U
        IIM0gEAqIFJ8ZgqDEyXcBKK2Y2UIBRsAS3Pw4z08uOyk0ph0BuH6C7n4X7mrcIo9OUkMkCbvQVl8I
        6/ECon0nDovxOGn8usN6T9ktPdWLeYsINyxEuLZg+K3Xr7EuvDUu3Xm7kyWCS9/0iX+XQY9/K74+g
        35l1qf1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2f-00EZVW-2f; Mon, 02 May 2022 05:56:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/26] iomap: Convert to release_folio
Date:   Mon,  2 May 2022 06:55:50 +0100
Message-Id: <20220502055614.3473032-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

Change all the filesystems which used iomap_releasepage to use the
new function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c         |  2 +-
 fs/iomap/buffered-io.c | 22 ++++++++++------------
 fs/iomap/trace.h       |  2 +-
 fs/xfs/xfs_aops.c      |  2 +-
 fs/zonefs/super.c      |  2 +-
 include/linux/iomap.h  |  2 +-
 6 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 1016631bcbdc..3d6c5c5eb4f1 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -768,7 +768,7 @@ static const struct address_space_operations gfs2_aops = {
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
 	.dirty_folio = filemap_dirty_folio,
-	.releasepage = iomap_releasepage,
+	.release_folio = iomap_release_folio,
 	.invalidate_folio = iomap_invalidate_folio,
 	.bmap = gfs2_bmap,
 	.direct_IO = noop_direct_IO,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2de087ac87b6..8532f0e2e2d6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -452,25 +452,23 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 }
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
-int
-iomap_releasepage(struct page *page, gfp_t gfp_mask)
+bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	struct folio *folio = page_folio(page);
-
-	trace_iomap_releasepage(folio->mapping->host, folio_pos(folio),
+	trace_iomap_release_folio(folio->mapping->host, folio_pos(folio),
 			folio_size(folio));
 
 	/*
-	 * mm accommodates an old ext3 case where clean pages might not have had
-	 * the dirty bit cleared. Thus, it can send actual dirty pages to
-	 * ->releasepage() via shrink_active_list(); skip those here.
+	 * mm accommodates an old ext3 case where clean folios might
+	 * not have had the dirty bit cleared.  Thus, it can send actual
+	 * dirty folios to ->release_folio() via shrink_active_list();
+	 * skip those here.
 	 */
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
-		return 0;
+		return false;
 	iomap_page_release(folio);
-	return 1;
+	return true;
 }
-EXPORT_SYMBOL_GPL(iomap_releasepage);
+EXPORT_SYMBOL_GPL(iomap_release_folio);
 
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 {
@@ -1483,7 +1481,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * Skip the page if it's fully outside i_size, e.g. due to a
 		 * truncate operation that's in progress. We must redirty the
 		 * page so that reclaim stops reclaiming it. Otherwise
-		 * iomap_vm_releasepage() is called on it and gets confused.
+		 * iomap_release_folio() is called on it and gets confused.
 		 *
 		 * Note that the end_index is unsigned long.  If the given
 		 * offset is greater than 16TB on a 32-bit system then if we
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index a6689a563c6e..d48868fc40d7 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -80,7 +80,7 @@ DEFINE_EVENT(iomap_range_class, name,	\
 	TP_PROTO(struct inode *inode, loff_t off, u64 len),\
 	TP_ARGS(inode, off, len))
 DEFINE_RANGE_EVENT(iomap_writepage);
-DEFINE_RANGE_EVENT(iomap_releasepage);
+DEFINE_RANGE_EVENT(iomap_release_folio);
 DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a9c4bb500d53..2acbfc6925dd 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -568,7 +568,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.readahead		= xfs_vm_readahead,
 	.writepages		= xfs_vm_writepages,
 	.dirty_folio		= filemap_dirty_folio,
-	.releasepage		= iomap_releasepage,
+	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.bmap			= xfs_vm_bmap,
 	.direct_IO		= noop_direct_IO,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index c3a38f711b24..b1a428f860b3 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -197,7 +197,7 @@ static const struct address_space_operations zonefs_file_aops = {
 	.writepage		= zonefs_writepage,
 	.writepages		= zonefs_writepages,
 	.dirty_folio		= filemap_dirty_folio,
-	.releasepage		= iomap_releasepage,
+	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.migratepage		= iomap_migrate_page,
 	.is_partially_uptodate	= iomap_is_partially_uptodate,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5b2aa45ddda3..0d674695b6d3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -228,7 +228,7 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
-int iomap_releasepage(struct page *page, gfp_t gfp_mask);
+bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 #ifdef CONFIG_MIGRATION
 int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
-- 
2.34.1

