Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4346CC6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbhLHE1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22426C0698D5
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PRh0VjIPJ/xdMLO8RLWdCCSHILXWRHuUOZvS3c2PDV4=; b=s97Po3qmIMWLOvQDRaqmMdsAs0
        XR/0Vf2i8cLRnwljdB4wuLGg+s3w2/e1Xjnr6RC7VJmHL9whKiJcaKGFXMD90JPld+IAhuJH8wzJO
        NP8UchXQyG78QbxcL8wy/Yg4wOlB8A0Jg0ztwZYK0tK3UMr3XvB3DoWypdkU/FTKcyFlWgRNLtnck
        i/5O008ECD51WMWj3fz7oyn36xy36mMdfqC6Fe+LDzDP8JebbHStijG9Giu2jIhasyBnzn9nJMRnf
        vNJnMQ+K5gqYb9BxguUDhBlvIOogRkyV0zA1dcZX/ottrv6pWiinRtyDYwVGDn9+q6pJVCgA8i69O
        8clIHFQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU7-0084cK-0S; Wed, 08 Dec 2021 04:23:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 39/48] filemap: Convert filemap_read() to use a folio
Date:   Wed,  8 Dec 2021 04:22:47 +0000
Message-Id: <20211208042256.1923824-40-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We know the pagevec always contains folios, but use page_folio() anyway
instead of casting.  Removes a few calls to legacy functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index fb3cdb7aeffc..91399027b349 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2668,30 +2668,26 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			mark_page_accessed(pvec.pages[0]);
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-			size_t page_size = thp_size(page);
-			size_t offset = iocb->ki_pos & (page_size - 1);
+			struct folio *folio = page_folio(pvec.pages[i]);
+			size_t fsize = folio_size(folio);
+			size_t offset = iocb->ki_pos & (fsize - 1);
 			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
-					     page_size - offset);
+					     fsize - offset);
 			size_t copied;
 
-			if (end_offset < page_offset(page))
+			if (end_offset < folio_pos(folio))
 				break;
 			if (i > 0)
-				mark_page_accessed(page);
+				folio_mark_accessed(folio);
 			/*
-			 * If users can be writing to this page using arbitrary
-			 * virtual addresses, take care about potential aliasing
-			 * before reading the page on the kernel side.
+			 * If users can be writing to this folio using arbitrary
+			 * virtual addresses, take care of potential aliasing
+			 * before reading the folio on the kernel side.
 			 */
-			if (writably_mapped) {
-				int j;
-
-				for (j = 0; j < thp_nr_pages(page); j++)
-					flush_dcache_page(page + j);
-			}
+			if (writably_mapped)
+				flush_dcache_folio(folio);
 
-			copied = copy_page_to_iter(page, offset, bytes, iter);
+			copied = copy_folio_to_iter(folio, offset, bytes, iter);
 
 			already_read += copied;
 			iocb->ki_pos += copied;
-- 
2.33.0

