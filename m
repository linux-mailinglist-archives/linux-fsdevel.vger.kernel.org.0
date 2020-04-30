Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64471BF6E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 13:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgD3LeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgD3LeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:34:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D9C035494;
        Thu, 30 Apr 2020 04:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dyL6CCvk+6z2bvZF+me9CZLQe+A3yK/IUAfcG9BA9aA=; b=nkeJRNcZDFtWI/Wyf48nt+KWKw
        z/HOtayvUc3ToTXSmrm0t6WugyUzCnabW9uu8iM3q90NThDLJaQbqs4SkXrPAHb4fLlYucPremGru
        i8OiVdFxkbSp0dAyTMBd/AZRAE0cllim3Iu0W4E5RrvJODzyoy1WLm8T+hSq20O6GKQ8ZV/Wxi2pW
        SzDrnd8P5eFJS6lktSTRW37rKgaXeWyplJi8yHmCqtdKbdo6j4fR2FzmsqQ49xRLd8TegDbE95bDm
        E3WLE8lWEs4U4c7rTSGJ7USbaHjprELm5gSr5M5RcM7zhRcwqrjKZmlsu5hCbimV71Wb2ZsIkIR3A
        gGE8pwlA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jU7SJ-0004av-FS; Thu, 30 Apr 2020 11:34:15 +0000
Date:   Thu, 30 Apr 2020 04:34:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/25] Large pages in the page cache
Message-ID: <20200430113415.GW29705@bombadil.infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:36:32AM -0700, Matthew Wilcox wrote:
> This patch set does not pass xfstests.  Test at your own risk.  It is
> based on the readahead rewrite which is in Andrew's tree.  The large
> pages somehow manage to fall off the LRU, so the test VM quickly runs
> out of memory and freezes.

Kirill was right; that was not exactly the bug.  It did lead to the
realisation that this could be avoided by simply not splitting the page
if the filesystem knows how to write back large pages.  So this is
the current diff.

I just hit the bug in clear_inode() that i_data.nrpages is not 0, so
there's clearly at least one remaining problem to fix (and I suspect
about half a dozen).

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 184c8b516543..d511504d07af 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -235,7 +235,7 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	blk_status_t rc;
 
 	if (op_is_write(op))
-		rc = pmem_do_write(pmem, page, 0, sector, tmp_size(page));
+		rc = pmem_do_write(pmem, page, 0, sector, thp_size(page));
 	else
 		rc = pmem_do_read(pmem, page, 0, sector, thp_size(page));
 	/*
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7eb54f5c403b..ce978ed4f0cd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -116,6 +116,11 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+static inline bool mapping_large_pages(struct address_space *mapping)
+{
+	return mapping->host->i_sb->s_type->fs_flags & FS_LARGE_PAGES;
+}
+
 void release_pages(struct page **pages, int nr);
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ebaf649aa28d..e78686b628ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2654,7 +2654,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 int total_mapcount(struct page *page)
 {
-	int i, compound, ret;
+	int i, compound, nr, ret;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -2662,16 +2662,17 @@ int total_mapcount(struct page *page)
 		return atomic_read(&page->_mapcount) + 1;
 
 	compound = compound_mapcount(page);
+	nr = compound_nr(page);
 	if (PageHuge(page))
 		return compound;
 	ret = compound;
-	for (i = 0; i < HPAGE_PMD_NR; i++)
+	for (i = 0; i < nr; i++)
 		ret += atomic_read(&page[i]._mapcount) + 1;
 	/* File pages has compound_mapcount included in _mapcount */
 	if (!PageAnon(page))
-		return ret - compound * HPAGE_PMD_NR;
+		return ret - compound * nr;
 	if (PageDoubleMap(page))
-		ret -= HPAGE_PMD_NR;
+		ret -= nr;
 	return ret;
 }
 
diff --git a/mm/readahead.c b/mm/readahead.c
index e2493189e832..ac16e96a8828 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -458,7 +458,7 @@ static bool page_cache_readahead_order(struct readahead_control *rac,
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
 
-	if (!(mapping->host->i_sb->s_type->fs_flags & FS_LARGE_PAGES))
+	if (!mapping_large_pages(mapping))
 		return false;
 
 	limit = min(limit, index + ra->size - 1);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868fc4926..51e6c135575d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1271,9 +1271,10 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
+		} else if (PageTransHuge(page)) {
 			/* Split file THP */
-			if (split_huge_page_to_list(page, page_list))
+			if (!mapping_large_pages(mapping) &&
+			    split_huge_page_to_list(page, page_list))
 				goto keep_locked;
 		}
 

