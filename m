Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E268418D074
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCTOWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:22:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCTOWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=a3v6yDLu6YVVgdwzNLLzwkeJ8vT0YawbuKhMcViKfm0=; b=o94Py0hrY2AL21Hit1xuWJSO58
        b3uQ1Vvk04RTNAbcWTzolol1KMnng7zWbWv52EwLbpj1XBoup/RzOPmz1V4raWQ3pQCrBs21nHaNv
        dSNdUhpaDb8IOqTtc4tFiAITtcpZcFzqXjDMxerSgduKkfq7dtKNERhluzZ501Bh1NXH4HGBOL4ef
        d4Yai/iczKhLrrO/a8Da2lhxeCUpzll/39IQrofVoeps/R8GaqM/3g8EdQ80KvS4tJMiqhp4s1TwF
        g8FvwkzVXA7iGAStYHVgrJYN2/YmMDewTTgjZakUAsdlUcUqIm2D6OngLFKzrNCvt3WKyGA9zzGwm
        UoY/5d1g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFIXh-0000hn-CY; Fri, 20 Mar 2020 14:22:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v9 08/25] mm: rename readahead loop variable to 'i'
Date:   Fri, 20 Mar 2020 07:22:14 -0700
Message-Id: <20200320142231.2402-9-willy@infradead.org>
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

Change the type of page_idx to unsigned long, and rename it -- it's
just a loop counter, not a page index.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8a65d6bd97e0..7ce320854bad 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -163,13 +163,13 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	struct page *page;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
-	int page_idx;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = filp,
 	};
+	unsigned long i;
 
 	if (isize == 0)
 		return;
@@ -179,8 +179,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = index + page_idx;
+	for (i = 0; i < nr_to_read; i++) {
+		pgoff_t page_offset = index + i;
 
 		if (page_offset > end_index)
 			break;
@@ -201,7 +201,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
-		if (page_idx == nr_to_read - lookahead_size)
+		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
 	}
-- 
2.25.1

