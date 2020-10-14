Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E328DCE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgJNJU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbgJNJUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484ACC0F26F1;
        Tue, 13 Oct 2020 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bpmz/m3iXeUk23W+8MMxf9WSox2EZIuxPCrXIX5P4lY=; b=gFatcmt45Yz9HQXA6+8PQzqSET
        4Gz04kVe8F6sUR6iuXkTL46htFS73/cIwxf531hY/wkhpI+vGMIhhrSXen6fh41NGOKIY/tul7HQk
        lzVgf1FzIQnX+aAVlXuqPM5MpzBC4ZHCsROAI2kDldXwRy7Ijvx0nGMlqehv6E0oTKAaH+KAKjAxx
        kITWsrJuvbtX4TqD61FJLyzYzr3tmPngIGxy/oWTl7tZt37YKAa6GP19wEYyZp4LPlbxZPXch+nTx
        XvouAM8dl8+qnqjfa80i4r5g/g6bt8tdjlI5HBio5tJGImaRAkDzX1EXltww0gBwP1WLYLjvrfdkd
        vTMLibqw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX57-0005jA-Py; Wed, 14 Oct 2020 03:04:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 10/14] iomap: Handle THPs when writing to pages
Date:   Wed, 14 Oct 2020 04:03:53 +0100
Message-Id: <20201014030357.21898-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we come across a THP that is not uptodate when writing to the page
cache, this must be due to a readahead error, so behave the same way as
readpage and split it.  Make sure to flush the right page after completing
the write.  We still only copy up to a page boundary, so there's no need
to flush multiple pages at this time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 397795db3ce5..0a1fe7d1a27c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -682,12 +682,19 @@ static ssize_t iomap_write_begin(struct inode *inode, loff_t pos, loff_t len,
 			return status;
 	}
 
+retry:
 	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
 			AOP_FLAG_NOFS);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
 	}
+	if (PageTransCompound(page) && !PageUptodate(page)) {
+		if (iomap_split_page(inode, page) == AOP_TRUNCATED_PAGE) {
+			put_page(page);
+			goto retry;
+		}
+	}
 	page = thp_head(page);
 	offset = offset_in_thp(page, pos);
 	if (len > thp_size(page) - offset)
@@ -724,6 +731,7 @@ iomap_set_page_dirty(struct page *page)
 	struct address_space *mapping = page_mapping(page);
 	int newly_dirty;
 
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	if (unlikely(!mapping))
 		return !TestSetPageDirty(page);
 
@@ -746,7 +754,9 @@ EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
-	flush_dcache_page(page);
+	size_t offset = offset_in_thp(page, pos);
+
+	flush_dcache_page(page + offset / PAGE_SIZE);
 
 	/*
 	 * The blocks that were entirely written will now be uptodate, so we
@@ -761,7 +771,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, offset, len);
 	iomap_set_page_dirty(page);
 	return copied;
 }
@@ -837,6 +847,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
+		/*
+		 * XXX: We don't know what size page we'll find in the
+		 * page cache, so only copy up to a regular page boundary.
+		 */
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_count(i));
@@ -867,7 +881,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		offset = offset_in_thp(page, pos);
 
 		if (mapping_writably_mapped(inode->i_mapping))
-			flush_dcache_page(page);
+			flush_dcache_page(page + offset / PAGE_SIZE);
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
-- 
2.28.0

