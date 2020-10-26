Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7329955D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789833AbgJZSbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:44 -0400
Received: from casper.infradead.org ([90.155.50.34]:47264 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789826AbgJZSbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZzeFSLAO40TxLydcpOE3O7s3Oskz6AtV+3Pr15iF2TA=; b=Ay+s3tLzhdLyeHihn2GmT5uh1Q
        3Y3duLhYXjTN+5M86MGrYHRoJuk4CmS6+YtzInoiKGlIfjZnaT5o0+AIRfkM/L11h4eeNjy0WgIxe
        oAk8UXQCUa+/YGLYz4LXhnYG0b6tTK+xqixPP6KwkuYjZ02kWxhqZt7SVpn9CA7dp+tnrMh5hYEv/
        xpv3YOZTXajJAEzRyst2hrTXZtcsdLW1V25tNeGRE7KAsHo37w7H8OHeH0DcBXMQg/tNzaUnxIB0U
        7f92AMKsbiDtN6lOx0+LKPq61YX8tlAyv+LBjlNAXUJzpb3Bm/TjPNUBhZtsiHbtOnJ/Zd7/eFuVG
        q16xsF+g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HS-0002jj-RG; Mon, 26 Oct 2020 18:31:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] mm/truncate: Make invalidate_inode_pages2_range work with THPs
Date:   Mon, 26 Oct 2020 18:31:32 +0000
Message-Id: <20201026183136.10404-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're going to unmap a THP, we have to be sure to unmap the entire
page, not just the part of it which lies after the search index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 27cf411ae51f..30653b2717d3 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -652,6 +652,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	while (find_get_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
+			pgoff_t count;
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
@@ -664,27 +665,22 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 			}
 
 			lock_page(page);
-			WARN_ON(page_to_index(page) != index);
 			if (page->mapping != mapping) {
 				unlock_page(page);
 				continue;
 			}
 			wait_on_page_writeback(page);
+			count = thp_nr_pages(page);
+			index = page->index + count - 1;
 			if (page_mapped(page)) {
 				if (!did_range_unmap) {
-					/*
-					 * Zap the rest of the file in one hit.
-					 */
-					unmap_mapping_pages(mapping, index,
-						(1 + end - index), false);
+					/* Zap the rest of the file */
+					count = max(count,
+							end - page->index + 1);
 					did_range_unmap = 1;
-				} else {
-					/*
-					 * Just zap this page
-					 */
-					unmap_mapping_pages(mapping, index,
-								1, false);
 				}
+				unmap_mapping_pages(mapping, page->index,
+						count, false);
 			}
 			BUG_ON(page_mapped(page));
 			ret2 = do_launder_page(mapping, page);
-- 
2.28.0

