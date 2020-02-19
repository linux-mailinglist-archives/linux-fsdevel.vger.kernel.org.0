Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15041650C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgBSVBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:01:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgBSVBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AKQIAD+CV6bMD4ebVqb2Pl7Yi9X7OosUM4taS8DkqDU=; b=QAyJRxkcJ0qFYdUlhIXy4+mSpF
        e5+qCIpSX5HiXDgrOQIQbQe1HOPpz2Eq8QNCgwjOEGmadMDjaO++xMzzSVceRCPuQAoc6Tl+d6V5e
        dmSrBTXyTNtKzG7+xtUdvS32EjUMteiGXgHVxylIBaDB9dhPAFdc2zEC22rL1/pS4OsWinJLNyOX/
        +njQ996NBx79dZL9hdWy9fCBPiaPlolOxfWoGCLPwZF7HU8EBfeNvMA+5LcUUK8VK3DSgdmhdAw0X
        oVN1tqUr/j6OUd1gHaHjhmNYvEfeKetTcxFduGgXVHo/yRIwZCqGYkYB99En66BZXa3brMBQVoGLJ
        KgnVVXsw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSv-0008Tu-3k; Wed, 19 Feb 2020 21:01:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 11/24] mm: Move end_index check out of readahead loop
Date:   Wed, 19 Feb 2020 13:00:50 -0800
Message-Id: <20200219210103.32400-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By reducing nr_to_read, we can eliminate this check from inside the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 07cdfbf00f4b..ace611f4bf05 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -166,8 +166,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
-	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
@@ -179,22 +177,27 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		._nr_pages = 0,
 	};
 	unsigned long i;
+	pgoff_t end_index;	/* The last page we want to read */
 
 	if (isize == 0)
 		return;
 
-	end_index = ((isize - 1) >> PAGE_SHIFT);
+	end_index = (isize - 1) >> PAGE_SHIFT;
+	if (index > end_index)
+		return;
+	if (index + nr_to_read < index)
+		nr_to_read = ULONG_MAX - index + 1;
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
2.25.0

