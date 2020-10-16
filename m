Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738DE29092F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410443AbgJPQEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410445AbgJPQEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6388BC0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eXIZ/2X0EY8JcIBfJAYRGkfxW4dL9sFOoP0NZnrF17k=; b=L+qGRwq93bTXE6spF7zzaJWnYg
        yU56B8yP3RpbfnQfb9WduyrO2aXz8wf3JXpJoYCLg2GelXRJ53wYcA/LeDMkI5VrtdOOsSW1i4e76
        Fzp4no1EbmYxz0TMYJ0Ti3gS0VtN/rYBedprHGLCzxdgMBiI1BE1Gaux0bG+sUBIjGg1qtxSDEFjs
        T3TKXNtzDhmWzMcuhaMUrOzVc066oLFCErTThPD7XRVEbgMPYro1ONQ2qGxpK80hT3KojTq8VSkHS
        fNAaN2DwsNIoCA4MwdnNA5ln3RQOlp5PDIXk+QiiGRYbYzhUdePN8sUQbosFRpDD/2M2hs53AbEHD
        qbw4sXTA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDl-0004sO-Rw; Fri, 16 Oct 2020 16:04:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 04/18] mm/filemap: Inline wait_on_page_read into its one caller
Date:   Fri, 16 Oct 2020 17:04:29 +0100
Message-Id: <20201016160443.18685-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Having this code inline helps the function read more easily.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 95b68ec1f22c..0ef06d515532 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2834,18 +2834,6 @@ EXPORT_SYMBOL(filemap_page_mkwrite);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 
-static struct page *wait_on_page_read(struct page *page)
-{
-	if (!IS_ERR(page)) {
-		wait_on_page_locked(page);
-		if (!PageUptodate(page)) {
-			put_page(page);
-			page = ERR_PTR(-EIO);
-		}
-	}
-	return page;
-}
-
 static struct page *do_read_cache_page(struct address_space *mapping,
 				pgoff_t index,
 				int (*filler)(void *, struct page *),
@@ -2876,7 +2864,10 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			err = mapping->a_ops->readpage(data, page);
 		if (err == AOP_UPDATED_PAGE) {
 			unlock_page(page);
-			goto out;
+		} else if (!err) {
+			wait_on_page_locked(page);
+			if (!PageUptodate(page))
+				err = -EIO;
 		}
 
 		if (err < 0) {
@@ -2884,9 +2875,6 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			return ERR_PTR(err);
 		}
 
-		page = wait_on_page_read(page);
-		if (IS_ERR(page))
-			return page;
 		goto out;
 	}
 	if (PageUptodate(page))
-- 
2.28.0

