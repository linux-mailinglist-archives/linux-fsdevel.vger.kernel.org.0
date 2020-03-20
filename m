Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9018CFEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCTOWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:22:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCTOWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pdWSzME62UL+uO1yH93k0e9uf35TIExoaTsL2owlX54=; b=nxesXJP7ft9mGfzchH1MIKZfLV
        ruJHCYKTXN+OH4e4bbMluolVkYWROV4AZIQi1/y4y0BsswAR7xTJBh4/mAgJHSz3vMNVcJw0rOgAe
        1nmdB9zdFZ88m/Ugpd8jOqsjJIo1VWXsbI9YX+TG9qH6ybYIITOR0/Vxp/bbYFK5RhpuTSaqr7i+E
        d15wyn5YBpKS1pep4G6KEJrCE/VtwNKG0xyY3ZOR49k4U22JiIX/i2cXRU33+C7ueKMc9G/JweZdZ
        pRHrXMvXfP58amDDUif7hgr19IlPklmnVQM5FjE4fTe33XaheOFzBFuJt3JoHAFbp2ZU/I4nx79BS
        rjLU7M6Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFIXh-0000iK-Jm; Fri, 20 Mar 2020 14:22:33 +0000
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
Subject: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Date:   Fri, 20 Mar 2020 07:22:18 -0700
Message-Id: <20200320142231.2402-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320142231.2402-1-willy@infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
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
 mm/readahead.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index d01531ef9f3c..a37b68f66233 100644
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
@@ -178,22 +176,29 @@ void __do_page_cache_readahead(struct address_space *mapping,
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
+	/* Avoid wrapping to the beginning of the file */
+	if (index + nr_to_read < index)
+		nr_to_read = ULONG_MAX - index + 1;
+	/* Don't read past the page containing the last byte of the file */
+	if (index + nr_to_read >= end_index)
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

