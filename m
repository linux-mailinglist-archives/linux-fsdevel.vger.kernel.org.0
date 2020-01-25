Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43421492BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgAYBgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:36:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgAYBfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U7hujabz41VV6VgB2q/wXDy+RPQPgZhvGCBmGp2dGHU=; b=f2COFivhr/4OzD5mRKQg71+cA0
        tFEHOMOSSQFweZ6l+XdNRsdQ4sltZZ0usSdvDS4BfCya8WnXVB+snxI+KhutGzkKNwGnL8xqhigDF
        Fqmr73B20Icvf/HkdGGA3iHXKa57rJXS6JUvKhRitLTdTrUvG6wdgpA/Uvd2VuXcnSs8TxsNVjS/+
        EUaKtmVNNtPuEHWHlVX2vc27MgaGb71YL7FYISSTQCU+79ZI0I2d6NdQpz5st1Epg3WdqAFqT4796
        5snIvDZJ1W+p+/KGqTIf0dCuJKpgls3wg+7OSJJNAnaRNjVfiPTUs/8i8/pXSiQJQgGMhOBPHJ/EQ
        I6waKDtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006Vx-Gc; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 10/12] f2fs: Convert from readpages to readahead
Date:   Fri, 24 Jan 2020 17:35:51 -0800
Message-Id: <20200125013553.24899-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in f2fs

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c              | 33 +++++++++++++--------------------
 include/trace/events/f2fs.h |  6 +++---
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a034cd0ce021..70bbcdfbd368 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1882,7 +1882,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
  * from read-ahead.
  */
 static int f2fs_mpage_readpages(struct address_space *mapping,
-			struct list_head *pages, struct page *page,
+			pgoff_t start, struct page *page,
 			unsigned nr_pages, bool is_readahead)
 {
 	struct bio *bio = NULL;
@@ -1901,15 +1901,10 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	map.m_may_create = false;
 
 	for (; nr_pages; nr_pages--) {
-		if (pages) {
-			page = list_last_entry(pages, struct page, lru);
+		if (is_readahead) {
+			page = readahead_page(mapping, start++);
 
 			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping,
-						  page_index(page),
-						  readahead_gfp_mask(mapping)))
-				goto next_page;
 		}
 
 		ret = f2fs_read_single_page(inode, page, nr_pages, &map, &bio,
@@ -1919,14 +1914,12 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			zero_user_segment(page, 0, PAGE_SIZE);
 			unlock_page(page);
 		}
-next_page:
-		if (pages)
+		if (is_readahead)
 			put_page(page);
 	}
-	BUG_ON(pages && !list_empty(pages));
 	if (bio)
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
-	return pages ? 0 : ret;
+	return ret;
 }
 
 static int f2fs_read_data_page(struct file *file, struct page *page)
@@ -1941,24 +1934,24 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
 		ret = f2fs_mpage_readpages(page_file_mapping(page),
-						NULL, page, 1, false);
+						0, page, 1, false);
 	return ret;
 }
 
-static int f2fs_read_data_pages(struct file *file,
+static unsigned f2fs_readahead(struct file *file,
 			struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages)
+			pgoff_t start, unsigned nr_pages)
 {
 	struct inode *inode = mapping->host;
-	struct page *page = list_last_entry(pages, struct page, lru);
 
-	trace_f2fs_readpages(inode, page, nr_pages);
+	trace_f2fs_readpages(inode, start, nr_pages);
 
 	/* If the file has inline data, skip readpages */
 	if (f2fs_has_inline_data(inode))
-		return 0;
+		return nr_pages;
 
-	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages, true);
+	f2fs_mpage_readpages(mapping, start, NULL, nr_pages, true);
+	return 0;
 }
 
 static int encrypt_one_page(struct f2fs_io_info *fio)
@@ -3265,7 +3258,7 @@ static void f2fs_swap_deactivate(struct file *file)
 
 const struct address_space_operations f2fs_dblock_aops = {
 	.readpage	= f2fs_read_data_page,
-	.readpages	= f2fs_read_data_pages,
+	.readahead	= f2fs_readahead,
 	.writepage	= f2fs_write_data_page,
 	.writepages	= f2fs_write_data_pages,
 	.write_begin	= f2fs_write_begin,
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1796ff99c3e9..35b5bb2188a3 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1368,9 +1368,9 @@ TRACE_EVENT(f2fs_writepages,
 
 TRACE_EVENT(f2fs_readpages,
 
-	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage),
+	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage),
 
-	TP_ARGS(inode, page, nrpage),
+	TP_ARGS(inode, start, nrpage),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1382,7 +1382,7 @@ TRACE_EVENT(f2fs_readpages,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->start	= page->index;
+		__entry->start	= start;
 		__entry->nrpage	= nrpage;
 	),
 
-- 
2.24.1

