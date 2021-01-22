Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8E30082E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbhAVQFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbhAVQD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:03:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A20C06174A;
        Fri, 22 Jan 2021 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Nbi5ZwqvpfNoyWg2clLlXNPhBFB3kJ+6Hvh4lIGwZ/E=; b=iRAzJ6JycFyFh3zYptXJb8DWFa
        fXTvgDs25OJfwxkakbLiNU+B64KYHyJkDMuvor2E36MnBIhTElJYZDwj2G0VS+Cno1LIkBEx937XS
        ESDbNnW19ZqAuhRUHTaof/xEJDooyADFWMiabiNX+wFYKIEzz0Pijv/q7gjpWgSFBUaVNWQxMbsVk
        NXYxEgVL/tQs15xAYQW6VnOhH6ip6vo6TYJ6k3WBespUcvSO5e0LLFR1SGy013kBxmXjhm80OPUEK
        i8W4DtNb0hmSOYYzKn/Hkr0n1D1SmG2ivnytn8eVyCsH9c3sno6kru34FrkaHTgo4hr3XlXMZkPUB
        aMyw2yUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2ysu-000w6U-BR; Fri, 22 Jan 2021 16:02:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v5 01/18] mm/filemap: Rename generic_file_buffered_read subfunctions
Date:   Fri, 22 Jan 2021 16:01:23 +0000
Message-Id: <20210122160140.223228-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The recent split of generic_file_buffered_read() created some very
long function names which are hard to distinguish from each other.
Rename as follows:

generic_file_buffered_read_readpage -> filemap_read_page
generic_file_buffered_read_pagenotuptodate -> filemap_update_page
generic_file_buffered_read_no_cached_page -> filemap_create_page
generic_file_buffered_read_get_pages -> filemap_get_pages

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/filemap.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bb28dd6d9e22a..afc0f674f2242 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2191,11 +2191,8 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
-static struct page *
-generic_file_buffered_read_readpage(struct kiocb *iocb,
-				    struct file *filp,
-				    struct address_space *mapping,
-				    struct page *page)
+static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
+		struct address_space *mapping, struct page *page)
 {
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
@@ -2246,12 +2243,9 @@ generic_file_buffered_read_readpage(struct kiocb *iocb,
 	return page;
 }
 
-static struct page *
-generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
-					   struct file *filp,
-					   struct iov_iter *iter,
-					   struct page *page,
-					   loff_t pos, loff_t count)
+static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
+		struct iov_iter *iter, struct page *page, loff_t pos,
+		loff_t count)
 {
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
@@ -2314,12 +2308,11 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 		return page;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	return filemap_read_page(iocb, filp, mapping, page);
 }
 
-static struct page *
-generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
-					  struct iov_iter *iter)
+static struct page *filemap_create_page(struct kiocb *iocb,
+		struct iov_iter *iter)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2330,10 +2323,6 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOIO)
 		return ERR_PTR(-EAGAIN);
 
-	/*
-	 * Ok, it wasn't cached, so we need to create a new
-	 * page..
-	 */
 	page = page_cache_alloc(mapping);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
@@ -2345,13 +2334,11 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 		return error != -EEXIST ? ERR_PTR(error) : NULL;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	return filemap_read_page(iocb, filp, mapping, page);
 }
 
-static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
-						struct iov_iter *iter,
-						struct page **pages,
-						unsigned int nr)
+static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned int nr)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2378,7 +2365,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 	if (nr_got)
 		goto got_pages;
 
-	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
+	pages[0] = filemap_create_page(iocb, iter);
 	err = PTR_ERR_OR_ZERO(pages[0]);
 	if (!IS_ERR_OR_NULL(pages[0]))
 		nr_got = 1;
@@ -2412,8 +2399,8 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 				break;
 			}
 
-			page = generic_file_buffered_read_pagenotuptodate(iocb,
-					filp, iter, page, pg_pos, pg_count);
+			page = filemap_update_page(iocb, filp, iter, page,
+					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
 				for (j = i + 1; j < nr_got; j++)
 					put_page(pages[j]);
@@ -2492,8 +2479,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		i = 0;
-		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
-							     pages, nr_pages);
+		pg_nr = filemap_get_pages(iocb, iter, pages, nr_pages);
 		if (pg_nr < 0) {
 			error = pg_nr;
 			break;
-- 
2.29.2

