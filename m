Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558EE18FF62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCWUXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:23:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCWUXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WfxVIQbzH9o8gavebp1mRU1CPxrl55pCfYyCVUPCjeY=; b=WAduqKrvK3O4ABqQbm6B8cCfrr
        BM0h1F4JEcMf9f2AYJna3nmrEpIU7Mu7MHDSEwj3okoHPFka54dUZNcgQfh2J4a/l3vqeO0bhjN+q
        TdXYlsewLzwZv2iTWXBZwxPok23qc9V48jP5veQaBu71cgak+GaR6I05J32EsO7l757nJI1nKGshi
        phzR59jJDZa7/jo9rXQDQlRd/KXn71jZC0IktMAGGEgyz9yz1Uuv1B1gKkmh2wQKDtn8xaA+fac+6
        6XYmOyhZxnV8ZdsufmEy7074rJx8c2k5zCl1ghYReFDFTxRwl14iUvtbp5IOfBimf3Ce1Pwm/YRu1
        H72TYyLA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbB-0003VD-OW; Mon, 23 Mar 2020 20:23:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v10 12/25] mm: Move end_index check out of readahead loop
Date:   Mon, 23 Mar 2020 13:22:46 -0700
Message-Id: <20200323202259.13363-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323202259.13363-1-willy@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By reducing nr_to_read, we can eliminate this check from inside the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index d01531ef9f3c..998fdd23c0b1 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -167,8 +167,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
-	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
@@ -178,22 +176,26 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		._index = index,
 	};
 	unsigned long i;
+	pgoff_t end_index;	/* The last page we want to read */
 
 	if (isize == 0)
 		return;
 
-	end_index = ((isize - 1) >> PAGE_SHIFT);
+	end_index = (isize - 1) >> PAGE_SHIFT;
+	if (index > end_index)
+		return;
+	/* Don't read past the page containing the last byte of the file */
+	if (nr_to_read > end_index - index)
+		nr_to_read = end_index - index + 1;
 
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
 	for (i = 0; i < nr_to_read; i++) {
-		if (index + i > end_index)
-			break;
+		struct page *page = xa_load(&mapping->i_pages, index + i);
 
 		BUG_ON(index + i != rac._index + rac._nr_pages);
 
-		page = xa_load(&mapping->i_pages, index + i);
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch of
-- 
2.25.1

