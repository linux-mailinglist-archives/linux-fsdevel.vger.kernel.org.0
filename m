Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC746CC6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbhLHE1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244185AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D53C061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FUlAUp7w5xOWEu0PBG82mMLCrwUhe7kQ/xncNJzLm7U=; b=DMjJSFYmluQlnIkBFHPWvaW/RB
        QxqgFCqgI6c3NhA8TNGyRGJNIK6BrYGeKi0OVz5nC1mCMdAJB2ydtcTMCGw6qTqjhB4SAGc/v3tnH
        e7BkZc4soBQwtzDPUjnFJ1dq9KyClXXV8jfpKYwJ5SNhV9rguJfYhXiCmDZKARvyq+oAg42AeVUNb
        e6Tm2vjQR3eeaOLk5AWKuZa2AJA2Sy9wjt7LTyNbdTZkUVoJ9cIS+XoK9j07I0fpNhwpOYtbz9nPu
        oxbmMJbEz/SZAddCuat0VwV33ETMY40O/rP73Ft0E5u/PZ0hSOAhDLHOYE4FajiyoYylLcRXYrVF0
        O4tYchDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU1-0084Wj-Ki; Wed, 08 Dec 2021 04:23:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/48] fs/writeback: Convert inode_switch_wbs_work_fn to folios
Date:   Wed,  8 Dec 2021 04:22:10 +0000
Message-Id: <20211208042256.1923824-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This gets the statistics correct by modifying the counters by the
number of pages in the folio instead of by 1.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fs-writeback.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 67f0e88eed01..4f680f848c8b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -372,7 +372,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
 {
 	struct address_space *mapping = inode->i_mapping;
 	XA_STATE(xas, &mapping->i_pages, 0);
-	struct page *page;
+	struct folio *folio;
 	bool switched = false;
 
 	spin_lock(&inode->i_lock);
@@ -389,21 +389,23 @@ static bool inode_do_switch_wbs(struct inode *inode,
 
 	/*
 	 * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
-	 * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
-	 * pages actually under writeback.
+	 * to possibly dirty folios while PAGECACHE_TAG_WRITEBACK points to
+	 * folios actually under writeback.
 	 */
-	xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
-		if (PageDirty(page)) {
-			dec_wb_stat(old_wb, WB_RECLAIMABLE);
-			inc_wb_stat(new_wb, WB_RECLAIMABLE);
+	xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
+		if (folio_test_dirty(folio)) {
+			long nr = folio_nr_pages(folio);
+			wb_stat_mod(old_wb, WB_RECLAIMABLE, -nr);
+			wb_stat_mod(new_wb, WB_RECLAIMABLE, nr);
 		}
 	}
 
 	xas_set(&xas, 0);
-	xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_WRITEBACK) {
-		WARN_ON_ONCE(!PageWriteback(page));
-		dec_wb_stat(old_wb, WB_WRITEBACK);
-		inc_wb_stat(new_wb, WB_WRITEBACK);
+	xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_WRITEBACK) {
+		long nr = folio_nr_pages(folio);
+		WARN_ON_ONCE(!folio_test_writeback(folio));
+		wb_stat_mod(old_wb, WB_WRITEBACK, -nr);
+		wb_stat_mod(new_wb, WB_WRITEBACK, nr);
 	}
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
-- 
2.33.0

