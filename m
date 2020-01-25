Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1831E1492A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgAYBgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:36:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbgAYBf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7T6itBiApRciaky4TlalX8Xey/dXpsbhmN7GfbwBCQQ=; b=DxRonwa2QYlElfNBEWmAtkxGW5
        a+qzOqVyOnpV9ng+GGQLu0dCroxyHhTOmveg7eC6DPYkLIxXX8cmeb/FMB4JgbUIVbcM1s8zsJHlx
        hHP2ch0JRU0s3hlIHPqthqZLlaTIJebEuwN5Tie716V104obqf5kO+4Pf/E/4GJkaU8G6B4ryuEpB
        FZbpMjtvWW66ymbzqmCY2Lu194yftYGSOpuwn4fRHubL99p4uYEOkwdQC5TtSsS3U08Ml1/HghPRQ
        FLDcUkBZwuQOXcI+uaumyK8W903NxQ0PkGuO+Ps5MKk0jXA14bN0utjxBjZlgcyE4ArUykHJ+rpWq
        Ok4sC1tw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006VD-79; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] mm: Fix the return type of __do_page_cache_readahead
Date:   Fri, 24 Jan 2020 17:35:42 -0800
Message-Id: <20200125013553.24899-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
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
2.24.1

