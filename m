Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E49161A51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgBQSqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:46:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbgBQSqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7Dxhm80Fw42pmsWKiiJ2urXHPFwIoqKidnXP7wm+j3k=; b=h1IUDmbbrv0kbZmyB9xlf7gQNw
        iMrB/vhHv9BYzVoWzQPC+jK351aSsx/1tI7T9Gce4M/7CUHI/UIaRAFhGEbR3lwEirF55IcM+Vs+X
        Bm8uZ1XrLsfUdE2x3+ELxQ/rJ7ALniYcN2AVIpnvKZ3DyOHEGM8UXpMA4l0nuYVZZdFdJYUQfQLZn
        yfVyAvLe2FHaf+DmWFGGpf/QV3h664luosyXmbBh4lpibf+0zKbBPgIXClJKPrdEKmbfHgiDetLqU
        uVT0S1+epzjtcroqUq8aqdLWz0AR/IYP8HGUERcKOHeuIPPG7sSFsjIrEq8VQPInemww00PmubEW/
        78Ml4R8Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPL-000593-GV; Mon, 17 Feb 2020 18:46:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 05/19] mm: Remove 'page_offset' from readahead loop
Date:   Mon, 17 Feb 2020 10:45:48 -0800
Message-Id: <20200217184613.19668-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Eliminate the page_offset variable which was confusing with the
'offset' parameter and record the start of each consecutive run of
pages in the readahead_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3eca59c43a45..74791b96013f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -162,6 +162,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = filp,
+		._start = offset,
 		._nr_pages = 0,
 	};
 
@@ -175,12 +176,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		struct page *page;
-		pgoff_t page_offset = offset + page_idx;
 
-		if (page_offset > end_index)
+		if (offset > end_index)
 			break;
 
-		page = xa_load(&mapping->i_pages, page_offset);
+		page = xa_load(&mapping->i_pages, offset);
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch
@@ -196,16 +196,18 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
+		page->index = offset;
 		list_add(&page->lru, &page_pool);
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
+		offset++;
 		continue;
 read:
 		if (readahead_count(&rac))
 			read_pages(&rac, &page_pool, gfp_mask);
 		rac._nr_pages = 0;
+		rac._start = ++offset;
 	}
 
 	/*
-- 
2.25.0

