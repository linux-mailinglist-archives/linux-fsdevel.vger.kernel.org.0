Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9B1650B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBSVBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:01:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgBSVBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5C4JK8zE1Pp00Cum/3ZRIGcaAr7KiKxwr8qbHzzStqE=; b=XHx3/nz7M4KGJeYMjVh5+2kl3y
        vAU/Yp8bBwlAjCEzM1kKgagYjqMowAxWy16/KX3wWDba7Z4mH7P+kKYv6Vvx7ZL9X8S6pzJAXqge2
        Hi/vA2PlELq4lKbnQJj4gucjv6JU+KNaCS2iK0ay1TXfLs6v0ZEnMHfNS3rCgoZ+NuCqxG0F6yARR
        7qKi019VALOU+T+5tip6Dfo/bQvcnqMMdgiV7IrBiRQSjYM6lIhdDm10A29M290ggEeav7ulfzwKA
        CIU1nNjkhSMUvBPOoZ6VVGkQPF3XTO8xonKYsMItkEcrM1p0W+kMXoZw/eGGO9niPYihFZqg29xiF
        vTEzBmkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSu-0008Te-Vo; Wed, 19 Feb 2020 21:01:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v7 07/24] mm: rename readahead loop variable to 'i'
Date:   Wed, 19 Feb 2020 13:00:46 -0800
Message-Id: <20200219210103.32400-8-willy@infradead.org>
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

Change the type of page_idx to unsigned long, and rename it -- it's
just a loop counter, not a page index.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 mm/readahead.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 096cf9020648..8a25fc7e2bf2 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -163,7 +163,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	struct page *page;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
-	int page_idx;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	struct readahead_control rac = {
@@ -171,6 +170,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		.file = filp,
 		._nr_pages = 0,
 	};
+	unsigned long i;
 
 	if (isize == 0)
 		return;
@@ -180,8 +180,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = index + page_idx;
+	for (i = 0; i < nr_to_read; i++) {
+		pgoff_t page_offset = index + i;
 
 		if (page_offset > end_index)
 			break;
@@ -202,7 +202,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
-		if (page_idx == nr_to_read - lookahead_size)
+		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
 	}
-- 
2.25.0

