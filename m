Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112823A866A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFOQ2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOQ2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:28:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D049C061574;
        Tue, 15 Jun 2021 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=M7qquJRmQA0qY58TU1F+zDfrk5RMBtJYA/mRcQ8AlNo=; b=fCOKT0aAJm4ln4ee91ukcgB1vw
        RmpWAacns0RKJVfskKSxFhIbGp6L60GkB3jRHn6MapUT4eS43tje/yxbhPprsdiQgyroCu2GZh92O
        6+T2rFm23YuVGtrJyXF73CmZYvyXA/6rXf0LuxS08WhYv61/vHvYlv2yOg76FGR7yPJM17OpFTw1u
        h1hdXIVg+hvkIY9QwDAGcBironLTYEv3q2gCvNWx5kK6o5CEGKAo7bAIthjcGQeZxFlccp0XjIlRk
        pKRsNvNFsywYPCUws88JHvpMHmnbwYreQUwpUr9flN12uJnkPGivp0rbKNBwthKxytFoEsvYbbCfI
        Bv7Dqgwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltBry-0070OS-EB; Tue, 15 Jun 2021 16:24:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Date:   Tue, 15 Jun 2021 17:23:39 +0100
Message-Id: <20210615162342.1669332-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615162342.1669332-1-willy@infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only difference between iomap_set_page_dirty() and
__set_page_dirty_nobuffers() is that the latter includes a debugging
check that a !Uptodate page has private data.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c         |  2 +-
 fs/iomap/buffered-io.c | 27 +--------------------------
 fs/xfs/xfs_aops.c      |  2 +-
 fs/zonefs/super.c      |  2 +-
 include/linux/iomap.h  |  1 -
 5 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 50dd1771d00c..746b78c3a91d 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -784,7 +784,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepages = gfs2_writepages,
 	.readpage = gfs2_readpage,
 	.readahead = gfs2_readahead,
-	.set_page_dirty = iomap_set_page_dirty,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 	.releasepage = iomap_releasepage,
 	.invalidatepage = iomap_invalidatepage,
 	.bmap = gfs2_bmap,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2bf4778f2098..41da4f14c00b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -640,31 +640,6 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	return status;
 }
 
-int
-iomap_set_page_dirty(struct page *page)
-{
-	struct address_space *mapping = page_mapping(page);
-	int newly_dirty;
-
-	if (unlikely(!mapping))
-		return !TestSetPageDirty(page);
-
-	/*
-	 * Lock out page's memcg migration to keep PageDirty
-	 * synchronized with per-memcg dirty page counters.
-	 */
-	lock_page_memcg(page);
-	newly_dirty = !TestSetPageDirty(page);
-	if (newly_dirty)
-		__set_page_dirty(page, mapping, 0);
-	unlock_page_memcg(page);
-
-	if (newly_dirty)
-		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-	return newly_dirty;
-}
-EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
-
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
@@ -684,7 +659,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
 	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	iomap_set_page_dirty(page);
+	__set_page_dirty_nobuffers(page);
 	return copied;
 }
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 826caa6b4a5a..a335d79dcff8 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -561,7 +561,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.readahead		= xfs_vm_readahead,
 	.writepage		= xfs_vm_writepage,
 	.writepages		= xfs_vm_writepages,
-	.set_page_dirty		= iomap_set_page_dirty,
+	.set_page_dirty		= __set_page_dirty_nobuffers,
 	.releasepage		= iomap_releasepage,
 	.invalidatepage		= iomap_invalidatepage,
 	.bmap			= xfs_vm_bmap,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index cd145d318b17..3aacf016c7c2 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -185,7 +185,7 @@ static const struct address_space_operations zonefs_file_aops = {
 	.readahead		= zonefs_readahead,
 	.writepage		= zonefs_writepage,
 	.writepages		= zonefs_writepages,
-	.set_page_dirty		= iomap_set_page_dirty,
+	.set_page_dirty		= __set_page_dirty_nobuffers,
 	.releasepage		= iomap_releasepage,
 	.invalidatepage		= iomap_invalidatepage,
 	.migratepage		= iomap_migrate_page,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c87d0cb0de6d..479c1da3e221 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -159,7 +159,6 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
-int iomap_set_page_dirty(struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
-- 
2.30.2

