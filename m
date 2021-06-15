Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37D73A8674
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFOQ3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFOQ3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:29:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A60FC061574;
        Tue, 15 Jun 2021 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ni0lZG4NrJxWArg/rUblSxqicDPaIUFQ5m3rKpK2hmI=; b=sznkCQX2Jjvrrng8Nv4rMsO7H0
        5GJuQztCkBdOdoOZEO4YkXV2zgSnjTwyymCvMkV7yPFmBIwCnfJ32dAPCxx9nDCqP1NhBe4+GQT0L
        9pYEmM4iBMwBtlkdJSkLr0s0cl1T3K9ej9TxAH+dkFCc3xN5mhZ2lrlY2foA1wovJM0DEIFqzKYCf
        ke0Is9FY7zJfynfDoc7z+PIWh4C42sU4mHoJhci+NvSt7Zuz/MDZfJdovEjAfg/fCJYqQoDvAbkWc
        skCTTfO2eLuqV246kZA13SXROrOdEzFWGqbFjFshkrNes/8MJo9nl+ocooPsYT6cpIqoGqJQOP3j1
        bMnbE88Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltBsd-0070RT-GY; Tue, 15 Jun 2021 16:25:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5/6] fs: Remove noop_set_page_dirty()
Date:   Tue, 15 Jun 2021 17:23:41 +0100
Message-Id: <20210615162342.1669332-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615162342.1669332-1-willy@infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use __set_page_dirty_no_writeback() instead.  This will set the dirty
bit on the page, which will be used to avoid calling set_page_dirty()
in the future.  It will have no effect on actually writing the page
back, as the pages are not on any LRU lists.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/dax/device.c |  2 +-
 fs/ext2/inode.c      |  2 +-
 fs/ext4/inode.c      |  2 +-
 fs/fuse/dax.c        |  2 +-
 fs/libfs.c           | 16 ----------------
 fs/xfs/xfs_aops.c    |  2 +-
 include/linux/fs.h   |  1 -
 7 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index db92573c94e8..dd8222a42808 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -337,7 +337,7 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 }
 
 static const struct address_space_operations dev_dax_aops = {
-	.set_page_dirty		= noop_set_page_dirty,
+	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.invalidatepage		= noop_invalidatepage,
 };
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index bf41f579ed3e..dadb121beb22 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -992,7 +992,7 @@ const struct address_space_operations ext2_nobh_aops = {
 static const struct address_space_operations ext2_dax_aops = {
 	.writepages		= ext2_dax_writepages,
 	.direct_IO		= noop_direct_IO,
-	.set_page_dirty		= noop_set_page_dirty,
+	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.invalidatepage		= noop_invalidatepage,
 };
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f44800361a38..6dd58c14ef1f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3701,7 +3701,7 @@ static const struct address_space_operations ext4_da_aops = {
 static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
 	.direct_IO		= noop_direct_IO,
-	.set_page_dirty		= noop_set_page_dirty,
+	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.bmap			= ext4_bmap,
 	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= ext4_iomap_swap_activate,
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ff99ab2a3c43..515ad0895345 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1329,7 +1329,7 @@ bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi)
 static const struct address_space_operations fuse_dax_file_aops  = {
 	.writepages	= fuse_dax_writepages,
 	.direct_IO	= noop_direct_IO,
-	.set_page_dirty	= noop_set_page_dirty,
+	.set_page_dirty	= __set_page_dirty_no_writeback,
 	.invalidatepage	= noop_invalidatepage,
 };
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 3fdd89b156d6..51b4de3b3447 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1171,22 +1171,6 @@ int noop_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 }
 EXPORT_SYMBOL(noop_fsync);
 
-int noop_set_page_dirty(struct page *page)
-{
-	/*
-	 * Unlike __set_page_dirty_no_writeback that handles dirty page
-	 * tracking in the page object, dax does all dirty tracking in
-	 * the inode address_space in response to mkwrite faults. In the
-	 * dax case we only need to worry about potentially dirty CPU
-	 * caches, not dirty page cache pages to write back.
-	 *
-	 * This callback is defined to prevent fallback to
-	 * __set_page_dirty_buffers() in set_page_dirty().
-	 */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(noop_set_page_dirty);
-
 void noop_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int length)
 {
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a335d79dcff8..cb4e0fcf4c76 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -575,7 +575,7 @@ const struct address_space_operations xfs_address_space_operations = {
 const struct address_space_operations xfs_dax_aops = {
 	.writepages		= xfs_dax_writepages,
 	.direct_IO		= noop_direct_IO,
-	.set_page_dirty		= noop_set_page_dirty,
+	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= xfs_iomap_swapfile_activate,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ef5c1d93994c..9dfd1e15b0e1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3416,7 +3416,6 @@ extern int simple_rename(struct user_namespace *, struct inode *,
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
-extern int noop_set_page_dirty(struct page *page);
 extern void noop_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int length);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
-- 
2.30.2

