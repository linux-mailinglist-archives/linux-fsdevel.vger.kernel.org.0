Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1A15A010
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBLEUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:20:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLESq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sck9dfI+dXScVPBWaYwW3jbiuxvqUXtQqMv4jzviG9g=; b=gpfAype3Necc2KDV9z7TZtCn3l
        lakh8t9W5r3L5nSf9lwDius+Zr15DFh8+ItvwIazI/b2jWLpbrsJJ0HGy1zxYLBBQWnHGXl7csYip
        2YJklSvyCXwgSwpEb+kBFV2nfP7nyYkDxHlMhd5bDqUr9nmKDI525fu2We0lxx16Xd2DEc/WX8rA2
        RTJ/XH+PnVrVsHl0ZRyOElG4go51Avsu2xSs5BUaosZ+pmy3GwCXxLaFNVuedmOV31b9mHOGzBPX5
        7Cghy9bJMQ8YJrt8+Ikumu79Ei3Cwop2ISZvSLr8OnJG5/2SF0bRJ4k33uQvlqgzKteGDBzPrWO9l
        C7JaPcbw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006mJ-FR; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/25] Large pages in the page cache
Date:   Tue, 11 Feb 2020 20:18:20 -0800
Message-Id: <20200212041845.25879-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This patch set does not pass xfstests.  Test at your own risk.  It is
based on the readahead patchset which I posted yesterday.

The principal idea here is that a large part of the overhead in dealing
with individual pages is that there's just so darned many of them.  We
would be better off dealing with fewer, larger pages, even if they don't
get to be the size necessary for the CPU to use a larger TLB entry.

The first five patches are more or less random cleanups which I came
across while working on this patchset ... Andrew, if you want to just
take those into your tree, it'd probably be a good thing.

hpage_nr_pages() is adapted to handle arbitrary order pages.  I also
add thp_order() and thp_size() for legibility.  Then the patches tear
through the page cache fixing the places which assume pages are either
PMD_SIZE or PAGE_SIZE.  After that, I tackle the iomap buffered I/O path,
removing the assumptions of PAGE_SIZE there.

Finally, we get to actually allocating large pages in the readahead code.
We gradually grow the page size that is allocated, so we don't just
jump straight from order-0 to order-9 pages, but gradually get there
through order-2, order-4, order-6, order-8 and order-9 (on x86; other
architectures will have a different PMD_ORDER).

In some testing, I've seen the code go as far as order-6.  Right now it
falls over on an earlier xfstest when it discovers a delayed allocation
extent in an inode which is being removed at unmount.

Matthew Wilcox (Oracle) (24):
  mm: Use vm_fault error code directly
  mm: Optimise find_subpage for !THP
  mm: Use VM_BUG_ON_PAGE in clear_page_dirty_for_io
  mm: Unexport find_get_entry
  mm: Fix documentation of FGP flags
  mm: Allow hpages to be arbitrary order
  mm: Introduce thp_size
  mm: Introduce thp_order
  fs: Add a filesystem flag for large pages
  fs: Introduce i_blocks_per_page
  fs: Make page_mkwrite_check_truncate thp-aware
  mm: Add file_offset_of_ helpers
  fs: Add zero_user_large
  iomap: Support arbitrarily many blocks per page
  iomap: Support large pages in iomap_adjust_read_range
  iomap: Support large pages in read paths
  iomap: Support large pages in write paths
  iomap: Inline data shouldn't see large pages
  xfs: Support large pages
  mm: Make prep_transhuge_page return its argument
  mm: Add __page_cache_alloc_order
  mm: Allow large pages to be added to the page cache
  mm: Allow large pages to be removed from the page cache
  mm: Add large page readahead

William Kucharski (1):
  mm: Align THP mappings for non-DAX

 drivers/net/ethernet/ibm/ibmveth.c |   2 -
 drivers/nvdimm/btt.c               |   4 +-
 drivers/nvdimm/pmem.c              |   3 +-
 fs/iomap/buffered-io.c             | 111 ++++++++++++++++-------------
 fs/jfs/jfs_metapage.c              |   2 +-
 fs/xfs/xfs_aops.c                  |   4 +-
 fs/xfs/xfs_super.c                 |   2 +-
 include/linux/fs.h                 |   1 +
 include/linux/highmem.h            |  22 ++++++
 include/linux/huge_mm.h            |  21 +++---
 include/linux/mm.h                 |   2 +
 include/linux/pagemap.h            |  78 ++++++++++++++++----
 mm/filemap.c                       |  67 +++++++++++------
 mm/huge_memory.c                   |  14 ++--
 mm/internal.h                      |   2 +-
 mm/page-writeback.c                |   2 +-
 mm/page_io.c                       |   2 +-
 mm/page_vma_mapped.c               |   4 +-
 mm/readahead.c                     |  98 +++++++++++++++++++++++--
 19 files changed, 322 insertions(+), 119 deletions(-)

-- 
2.25.0

