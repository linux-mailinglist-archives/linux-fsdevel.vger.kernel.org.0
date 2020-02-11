Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7803D158784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBKBDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:03:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgBKBDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pH5LFtlmOrFfMRG0qpJp1Yog2+5WC4QJAZDPBwZZUFQ=; b=WYDhnMYb2Tl4xEYpfY2Ku86VXL
        FI/V0kmlpCs1KHRO35xmh+JKDrQMAEC2a25oQ9BygbUIHc0PYTN7FG/TumtQJ+kUp1O3OHsdm2haz
        hhEkhbx7SOE6j08H5VRVSHsnGE+ExUvbUQojTzl55uokP3eAI6x7olxu2lddAMOmqOny931og4gai
        VgiCC9cKCaXR15L83kZWcgQeZ0a5wsc3LFjHAjj0kTRlTOW+lLChKb6KWREqxkWZaagtfhYE9EiFR
        wECqSjkjhjQbWw5xKUEDD5X8x+mDovm6ZDsjY7BYvt+CQ33FjwZUVX3fAQDKwOducVwUJV4OnKGzp
        HTa7QHMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Jxu-0001nh-AM; Tue, 11 Feb 2020 01:03:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 01/13] mm: Fix the return type of __do_page_cache_readahead
Date:   Mon, 10 Feb 2020 17:03:36 -0800
Message-Id: <20200211010348.6872-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211010348.6872-1-willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

ra_submit() which is a wrapper around __do_page_cache_readahead() already
returns an unsigned long, and the 'nr_to_read' parameter is an unsigned
long, so fix __do_page_cache_readahead() to return an unsigned long,
even though I'm pretty sure we're not going to readahead more than 2^32
pages ever.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h  | 2 +-
 mm/readahead.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..41b93c4b3ab7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,7 +49,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
+extern unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size);
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..6bf73ef33b7e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -152,7 +152,7 @@ static int read_pages(struct address_space *mapping, struct file *filp,
  *
  * Returns the number of pages requested, or the maximum amount of I/O allowed.
  */
-unsigned int __do_page_cache_readahead(struct address_space *mapping,
+unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
@@ -161,7 +161,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
-	unsigned int nr_pages = 0;
+	unsigned long nr_pages = 0;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 
-- 
2.25.0

