Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59216F19A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 22:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgBYVsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 16:48:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgBYVsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WiFEUIefG63/61aNx/2cgoSMrFF7Zi6b++Gf/UDmxNI=; b=hHF5tUr4B5IR4ue1Z8PPPkBMiz
        s0ldawlP5MFOL44KPu1D0LyLJBtVLvQsESU/f8WX8ZV0Cjoh5ddin2VAm2hkQm20/1i76hQGSaRKW
        Wst8Vz0C8dFoL8XB58LOIk9QF3HgbfzOBoOKvT3CLZoXCfYnA8hoBgecTjTNifKeLK6ruZIVLcbbd
        m3eQ3Bu8ZcTrqzUrBwjU6tqSBGNLskSySkHssjrGC1irjzzyZPY4e+JpxyiCk7nPBCbNtj++p1Y9A
        a0j5LZzth6NAHIJ96tT7KETFHlYMJ3krk+5zoG4wn8z1szwi5VpsdHl2HZE8PJQSP21WW5I0TPzYj
        48lrDngA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6i4H-0007pn-7F; Tue, 25 Feb 2020 21:48:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 09/25] mm: Remove 'page_offset' from readahead loop
Date:   Tue, 25 Feb 2020 13:48:22 -0800
Message-Id: <20200225214838.30017-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
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
2.25.0

