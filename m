Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94748FC9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiAPMSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiAPMS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE3C061574;
        Sun, 16 Jan 2022 04:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FLQ8hTEx3kPzs6+4vpyjvLn3g8Qd/uBRVnCIZc5hTjc=; b=KBxjapCNRDOC2MCQv8cV1VL0HQ
        47jOANY2g855xMDwaaYDRhp6D9v/f4OboicCyykTBHs6Qg3LFfvMKCUx4RIh5ri1N9eGOg2H1RwIJ
        /+SsKNIoTzmrcMECHMFkfduKDG4ZoFkIMX3q9jHUUDlbyuP0t+JE7YRs3CkwwgCqXkqo0b9QAzsHM
        p7wEW+iUeO9bFmJIZRpKHzvNMwDLpfDNZJS/oSqVblAOcKUQB839bqD8iII2ZAOCpuoB1liFU1wN1
        B7tyFIirwZSZEEnJK185vxAWOZj/s/9TarkIpPFLjU5QkIjAA2vpakOu/WDroFOXc+duPI4X7WtLg
        stJhnfSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUn-W7; Sun, 16 Jan 2022 12:18:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/12] mm/readahead: Switch to page_cache_ra_order
Date:   Sun, 16 Jan 2022 12:18:20 +0000
Message-Id: <20220116121822.1727633-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
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
 mm/readahead.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index fe079b676ab7..8f076f0fd94f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2947,7 +2947,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
-	do_page_cache_ra(&ractl, ra->size, ra->async_size);
+	page_cache_ra_order(&ractl, ra, 0);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 26af8a5a5be3..dbc15201a9d4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -82,8 +82,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
-		unsigned long lookahead_size);
+void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
+		unsigned int order);
 void force_page_cache_ra(struct readahead_control *, unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read)
diff --git a/mm/readahead.c b/mm/readahead.c
index 5100eaf5b0ee..a20391d6a71b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
  */
-void do_page_cache_ra(struct readahead_control *ractl,
+static void do_page_cache_ra(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct inode *inode = ractl->mapping->host;
@@ -462,7 +462,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 	return err;
 }
 
-static void page_cache_ra_order(struct readahead_control *ractl,
+void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int new_order)
 {
 	struct address_space *mapping = ractl->mapping;
-- 
2.34.1

