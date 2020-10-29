Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E25829F563
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgJ2TeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgJ2TeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WKx2KmhhcuRAZfmxd4Yn/rz7noB6w4aBxf/AcKdOaQA=; b=lxGnL+AQeRmL3QGNzMU1QfXWrx
        VgTsRmAuLPj/ZStrR1BVz9vkhPUyttBDL9f5RriNS3MjUqqEeYFpyCs557gYBVEyZaRCUP/4K/idO
        hdN1JcWlneeRa4n52NCb6c3Cz7t5da3eqIjXL1J79kkp/JyGjFCZhcz6JF4+pVvb/8ZElxGl1qDHW
        UPlkICcUDozLL2VX6Q2Pg0aNqQnyICSsvoI8D42q1+6E6RMYUX47bQWiXmIHCnlN/8zB8iGMtmDHn
        gVaPYOaPQplJkTk1+P4Rugm4l6go4IRjf6Jp7247mwUbug5kAtGqs2w8rindvY6jNsWR9iHj3pDBk
        6V3T1dLA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDga-0007cv-0u; Thu, 29 Oct 2020 19:34:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/19] mm/readahead: Switch to page_cache_ra_order
Date:   Thu, 29 Oct 2020 19:34:03 +0000
Message-Id: <20201029193405.29125-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_page_cache_ra() was being exposed for the benefit of
do_sync_mmap_readahead().  Switch it over to page_cache_ra_order()
partly because it's a better interface but mostly for the benefit of
the next patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c   | 2 +-
 mm/internal.h  | 4 ++--
 mm/readahead.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 211a7c1fab3f..ee4a4990bad3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2833,7 +2833,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
-	do_page_cache_ra(&ractl, ra->size, ra->async_size);
+	page_cache_ra_order(&ractl, ra, 0);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 1391e3239547..3ea43642b99d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,8 +49,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
-		unsigned long lookahead_size);
+void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
+		unsigned int order);
 void force_page_cache_ra(struct readahead_control *, struct file_ra_state *,
 		unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
diff --git a/mm/readahead.c b/mm/readahead.c
index dc9876104ee8..d280e8f2e834 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -246,7 +246,7 @@ EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
  */
-void do_page_cache_ra(struct readahead_control *ractl,
+static void do_page_cache_ra(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct inode *inode = ractl->mapping->host;
@@ -448,7 +448,7 @@ static inline int ra_alloc_page(struct readahead_control *ractl, pgoff_t index,
 	return err;
 }
 
-static void page_cache_ra_order(struct readahead_control *ractl,
+void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int new_order)
 {
 	struct address_space *mapping = ractl->mapping;
@@ -510,7 +510,7 @@ static void page_cache_ra_order(struct readahead_control *ractl,
 	do_page_cache_ra(ractl, ra->size, ra->async_size);
 }
 #else
-static void page_cache_ra_order(struct readahead_control *ractl,
+void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int order)
 {
 	do_page_cache_ra(ractl, ra->size, ra->async_size);
-- 
2.28.0

