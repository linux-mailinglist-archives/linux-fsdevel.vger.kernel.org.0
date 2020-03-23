Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7573E18FEF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCWUXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:23:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCWUXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yWCBnvZVE3mmN89bJgz6VBayzBfFVIn+l+u0xcbyIA0=; b=MlxozusRJi0Z4Hoj/bZGAJFztH
        GlgKI82G0NG7WhlTpC4WWlrBvUEB5r++IluhCI9V08mkalhQC9RsC+pUhqYbBZ+2HfpgbWyHdiBNA
        hLBmArwC1OPSrO80PBTn4xplmWh1s87hoDR1/ek5kYYGMnR+/jbXA9Us3dz7gB8ANaulTpPZUo3l8
        SnIw1hysXy65IMNv2WrkbMoAqGdV0YkRwchiYg0t7iq4uOeL+l31kWqZ1AGBO1L+wT0c4BMLOjZGQ
        p//FhyIDd2OxuM8mOrhQAGEbU3fQZRd8151F9VG7tOALTONV9B2mO7+4aiswPhM4j2H/YXdnZkETC
        TGv1Ugew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbB-0003V1-LW; Mon, 23 Mar 2020 20:23:01 +0000
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
Subject: [PATCH v10 09/25] mm: Remove 'page_offset' from readahead loop
Date:   Mon, 23 Mar 2020 13:22:43 -0700
Message-Id: <20200323202259.13363-10-willy@infradead.org>
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

