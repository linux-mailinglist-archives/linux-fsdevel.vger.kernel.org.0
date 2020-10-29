Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5621629F559
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJ2TeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgJ2TeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E11C0613D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m3kX9V2viinw8plXiDNypMDhWT98QwXvBE2VVZQYm9o=; b=doC9htAOcjqC5YmMj3f1l9fEap
        Yw01mYv9o8B6B3qb9NBzrw+7KgXRToZ8s6yVfYwM0dsNwWxTtvZnkWp2mnB8VxPpL/xiha4WVIv0+
        SQM1fQlGcIXsPhoNsKbJ2gREyyBkbjc/l5HVrBXJtBCPVaj+J9irUeRlXnE5nJXI/rRvmTm3PcXTa
        rx/MhfqFeTzdZelRtjZFDxcAZy7G9p1s6Zox+D7DdFRZ+pYNOv/ShiuqAGOX6thgpuXd4cKC6b0yt
        md6Ymd+SyowMmar9IJ0jJeSrPPTLp/RQNLddGd1P1U04YVQVfrZQP+YmQ7gQ+O8JL1JXIGutPRuyA
        5RwiUBqA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgX-0007bf-0C; Thu, 29 Oct 2020 19:34:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/19] mm/filemap: Change calling convention for gfbr_ functions
Date:   Thu, 29 Oct 2020 19:33:52 +0000
Message-Id: <20201029193405.29125-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

gfbr_update_page() would prefer to have mapping passed to it than filp,
as would gfbr_create_page().  That makes gfbr_read_page() retrieve
the file pointer from the iocb.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7bc791b47a68..1bfd87d85bfd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2176,9 +2176,10 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
-static struct page *gfbr_read_page(struct kiocb *iocb, struct file *filp,
+static struct page *gfbr_read_page(struct kiocb *iocb,
 		struct address_space *mapping, struct page *page)
 {
+	struct file *filp = iocb->ki_filp;
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
 
@@ -2228,11 +2229,10 @@ static struct page *gfbr_read_page(struct kiocb *iocb, struct file *filp,
 	return page;
 }
 
-static struct page *gfbr_update_page(struct kiocb *iocb, struct file *filp,
-		struct iov_iter *iter, struct page *page, loff_t pos,
-		loff_t count)
+static struct page *gfbr_update_page(struct kiocb *iocb,
+		struct address_space *mapping, struct iov_iter *iter,
+		struct page *page, loff_t pos, loff_t count)
 {
-	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
 	int error;
 
@@ -2293,13 +2293,12 @@ static struct page *gfbr_update_page(struct kiocb *iocb, struct file *filp,
 		return page;
 	}
 
-	return gfbr_read_page(iocb, filp, mapping, page);
+	return gfbr_read_page(iocb, mapping, page);
 }
 
-static struct page *gfbr_create_page(struct kiocb *iocb, struct iov_iter *iter)
+static struct page *gfbr_create_page(struct kiocb *iocb,
+		struct address_space *mapping, struct iov_iter *iter)
 {
-	struct file *filp = iocb->ki_filp;
-	struct address_space *mapping = filp->f_mapping;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	struct page *page;
 	int error;
@@ -2318,7 +2317,7 @@ static struct page *gfbr_create_page(struct kiocb *iocb, struct iov_iter *iter)
 		return error != -EEXIST ? ERR_PTR(error) : NULL;
 	}
 
-	return gfbr_read_page(iocb, filp, mapping, page);
+	return gfbr_read_page(iocb, mapping, page);
 }
 
 static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
@@ -2349,7 +2348,7 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	if (nr_got)
 		goto got_pages;
 
-	pages[0] = gfbr_create_page(iocb, iter);
+	pages[0] = gfbr_create_page(iocb, mapping, iter);
 	err = PTR_ERR_OR_ZERO(pages[0]);
 	if (!IS_ERR_OR_NULL(pages[0]))
 		nr_got = 1;
@@ -2383,7 +2382,7 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 				break;
 			}
 
-			page = gfbr_update_page(iocb, filp, iter, page,
+			page = gfbr_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
 				for (j = i + 1; j < nr_got; j++)
-- 
2.28.0

