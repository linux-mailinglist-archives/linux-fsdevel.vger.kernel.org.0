Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397BD2500FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgHXPZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgHXPRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:17:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526EC061575;
        Mon, 24 Aug 2020 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EnhOr651fYG//wVSSI2lABo+UhZFOxuqGW2PFxxTzF8=; b=udgs60rQFoUDneH6c+cOnxYloe
        oP2a2dWBv33jQrN/PrdqpCym621ma9scUuR8om7YiIO8QqKMEr8jXHJDDXf4A+j9dOcecTa7CAJRY
        qTzNmzkVcIq/ORNZaKLOQk9wNnfLBllsEJX59nQ/7/4FR1f/LzW5IkcJ3qpJ/k+nKWwUKg7eFH+ko
        EFxsIJFDg5er5xfChA9HgBSodRIVTTwUS7u9GLfQVIry20YBBhVxKNurwfEYpumD60GgPcdmOt/08
        rllwFwgX+ekgdSz1i3SPpC/nEbn+G09/J3Ew4w+qnOE0kUEvCLwyV6hBgXD5Dsfc3DMg8gyUJIPJN
        HcO2EHtg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEDW-0004Ca-QM; Mon, 24 Aug 2020 15:17:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] mm: Zero the head page, not the tail page
Date:   Mon, 24 Aug 2020 16:16:52 +0100
Message-Id: <20200824151700.16097-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824151700.16097-1-willy@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the head page to zero_user_segment(), not the tail page, and adjust
the byte offsets appropriately.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c    | 7 +++++++
 mm/truncate.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 271548ca20f3..77982149b437 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -958,11 +958,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		struct page *page = NULL;
 		shmem_getpage(inode, start - 1, &page, SGP_READ);
 		if (page) {
+			struct page *head = thp_head(page);
 			unsigned int top = PAGE_SIZE;
 			if (start > end) {
 				top = partial_end;
 				partial_end = 0;
 			}
+			if (head != page) {
+				unsigned int diff = start - 1 - head->index;
+				partial_start += diff << PAGE_SHIFT;
+				top += diff << PAGE_SHIFT;
+				page = head;
+			}
 			zero_user_segment(page, partial_start, top);
 			set_page_dirty(page);
 			unlock_page(page);
diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..152974888124 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -374,12 +374,19 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	if (partial_start) {
 		struct page *page = find_lock_page(mapping, start - 1);
 		if (page) {
+			struct page *head = thp_head(page);
 			unsigned int top = PAGE_SIZE;
 			if (start > end) {
 				/* Truncation within a single page */
 				top = partial_end;
 				partial_end = 0;
 			}
+			if (head != page) {
+				unsigned int diff = start - 1 - head->index;
+				partial_start += diff << PAGE_SHIFT;
+				top += diff << PAGE_SHIFT;
+				page = head;
+			}
 			wait_on_page_writeback(page);
 			zero_user_segment(page, partial_start, top);
 			cleancache_invalidate_page(mapping, page);
-- 
2.28.0

