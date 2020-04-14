Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87071A8264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438782AbgDNPUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405595AbgDNPCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:02:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB470C03C1A6;
        Tue, 14 Apr 2020 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yWCBnvZVE3mmN89bJgz6VBayzBfFVIn+l+u0xcbyIA0=; b=rxsNXTI6N2R0/LpKQ7BNJg/gk2
        0yITPvDQDE2V8Dr6ZRvEscnLB9UyPimRkq7PGGSDZFqBRRMVYBwmYQ3r+ycynfXwu/lgRI0dGhBNs
        ymS2j79bQT9lAHH0g6CTRq1NfdxAeCeciwVyd+AuVXoR3NFXfIsLiQ5A3uwDHFFTO7n9ie4HqhDoi
        Ijz4vD2rdHIKI4P2DRmChWKXUwX9cc7srwuVYhhuDfRZFAtxtSPdLfrSyFhOdwKx0YdBjzmW+tW/6
        +6ZfJDgCHOkIuQww7hF+NBUYzMi2pL2NIKfESk9JbsvFstHJagzoq1clFanhIz8jF/5g4eC66mzoy
        uDt3EiFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jON5A-0006OX-0c; Tue, 14 Apr 2020 15:02:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 09/25] mm: Remove 'page_offset' from readahead loop
Date:   Tue, 14 Apr 2020 08:02:17 -0700
Message-Id: <20200414150233.24495-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414150233.24495-1-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the page_offset variable with 'index + i'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 7ce320854bad..ddc63d3b07b8 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -180,12 +180,10 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (i = 0; i < nr_to_read; i++) {
-		pgoff_t page_offset = index + i;
-
-		if (page_offset > end_index)
+		if (index + i > end_index)
 			break;
 
-		page = xa_load(&mapping->i_pages, page_offset);
+		page = xa_load(&mapping->i_pages, index + i);
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch of
@@ -199,7 +197,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
+		page->index = index + i;
 		list_add(&page->lru, &page_pool);
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-- 
2.25.1

