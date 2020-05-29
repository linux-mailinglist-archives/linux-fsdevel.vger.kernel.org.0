Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553C01E7318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbgE2C7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407389AbgE2C6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF397C08C5C7;
        Thu, 28 May 2020 19:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wrwoH9/Ry8rPzpGiCmjHlx6XpKeT1oLXgd6VklLaZlE=; b=iITFd6WmT1wlquhM1sn6MrenT4
        PRnODHUW4DHJRc0UA537AYgWQK9/Kyb8afteWmQTgTN2ybKwsZaXZmyTDwBkZy1pU+TmBi0ybkIJj
        +wunOUkRJCHzBZFejpvguWhosgkJDx43ag2jq6DNNosYWr0fP50ybrzPQ7IGL6x0IXzqlzBRlrSRs
        vSa4HZf40Pkyfr4ioJMF0tX9lCVO584KF86HIjZHJoGqOVVPoKqI5P1pr7QGxuJSrZmtvEf+6QfB4
        p6gNZidmdK/cLvaOLUyz8ZqVv3GnHGSa8YAgT0cZQI0IUq0xpkvRekeVz2EbimdlRLv0gnwOgwfVk
        WHZjBjXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008Pf-J7; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/39] Large pages in the page cache
Date:   Thu, 28 May 2020 19:57:45 -0700
Message-Id: <20200529025824.32296-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This patchset gets a little further through xfstests than
v4 did.  It's still based on readahead_v11, and you can get it from
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-pagecache
if you'd rather see it there (this branch is force-pushed frequently)

The primary idea here is that a large part of the overhead in dealing
with individual pages is that there's just so darned many of them.
We would be better off dealing with fewer, larger pages, even if they
don't get to be the size necessary for the CPU to use a larger TLB entry.

The approach taken is to make THPs support arbitrary power-of-two sizes
(instead of just PMDs).  There's probably some tuning to be done to decide
what sizes are worth using, but we're a fair way from doing performance
work with this patchset yet.

TODO:
 - Rename hpage_nr_pages() to thp_count()
 - Maybe add a thp_mask()
 - Should flush_dcache_page() support THPs natively
 - Add Bill's SoB to all patches

v5:
 - Add a mapping AS_LARGE_PAGES flag to reduce the levels of indirection
   (Dave Chinner)
 - Change iomap_invalidate_page() to handle subpages of a THP being punched
 - Ensure we don't call page_cache_async_readahead() with a tail page
 - Revert to Bill's original patch for thp_get_unmapped_area() to allow
   for hardware page sizes other than PMD to be supported more easily
 - Remove a few more HPAGE_PMD_NR
 - Move shmem_punch_compound() to truncate.c and rename it to punch_thp()
 - Add support for page_private to punch_thp()

v4:
 - Fix thp_size typo
 - Fix the iomap page_mkwrite() path to operate on the head page, even
   though the vm_fault has a pointer to the tail page
 - Fix iomap_finish_ioend() to use bio_for_each_thp_segment_all()
 - Rework PageDoubleMap (see first two patches for details)
 - Fix page_cache_delete() to handle shadow entries being stored to a THP
 - Fix the assertion in pagecache_get_page() to handle tail pages
 - Change PageReadahead from NO_COMPOUND to ONLY_HEAD
 - Handle PageReadahead being set on head pages
 - Handle total_mapcount correctly (Kirill)
 - Pull the FS_LARGE_PAGES check out into mapping_large_pages()
 - Fix page size assumption in truncate_cleanup_page()
 - Avoid splitting large pages unnecessarily on truncate
 - Disable the page cache truncation introduced as part of the read-only
   THP patch set
 - Call compound_head() in iomap buffered write paths -- we retrieve a
   (potentially) tail page from the page cache and need to use that for
   flush_dcache_page(), but we expect to operate on a head page in most
   of the iomap code

Kirill A. Shutemov (1):
  mm: Fix total_mapcount assumption of page size

Matthew Wilcox (Oracle) (37):
  mm: Move PageDoubleMap bit
  mm: Simplify PageDoubleMap with PF_SECOND policy
  mm: Allow hpages to be arbitrary order
  mm: Introduce thp_size
  mm: Introduce thp_order
  mm: Introduce offset_in_thp
  fs: Add a filesystem flag for large pages
  fs: Do not update nr_thps for large page mappings
  fs: Introduce i_blocks_per_page
  fs: Make page_mkwrite_check_truncate thp-aware
  fs: Support THPs in zero_user_segments
  bio: Add bio_for_each_thp_segment_all
  iomap: Support arbitrarily many blocks per page
  iomap: Support large pages in iomap_adjust_read_range
  iomap: Support large pages in invalidatepage
  iomap: Support large pages in read paths
  iomap: Support large pages in write paths
  iomap: Inline data shouldn't see large pages
  iomap: Handle tail pages in iomap_page_mkwrite
  xfs: Support large pages
  mm: Make prep_transhuge_page return its argument
  mm: Add __page_cache_alloc_order
  mm: Allow large pages to be added to the page cache
  mm: Allow large pages to be removed from the page cache
  mm: Remove page fault assumption of compound page size
  mm: Remove assumptions of THP size
  mm: Avoid splitting large pages
  mm: Fix truncation for pages of arbitrary size
  mm: Handle truncates that split large pages
  mm: Support storing shadow entries for large pages
  mm: Support retrieving tail pages from the page cache
  mm: Support tail pages in wait_for_stable_page
  mm: Add DEFINE_READAHEAD
  mm: Make page_cache_readahead_unbounded take a readahead_control
  mm: Make __do_page_cache_readahead take a readahead_control
  mm: Allow PageReadahead to be set on head pages
  mm: Add large page readahead

William Kucharski (1):
  mm: Align THP mappings for non-DAX

 drivers/nvdimm/btt.c       |   4 +-
 drivers/nvdimm/pmem.c      |   6 +-
 fs/ext4/verity.c           |   4 +-
 fs/f2fs/verity.c           |   4 +-
 fs/inode.c                 |   2 +
 fs/iomap/buffered-io.c     | 127 ++++++++++++++++++--------------
 fs/jfs/jfs_metapage.c      |   2 +-
 fs/xfs/xfs_aops.c          |   4 +-
 fs/xfs/xfs_super.c         |   2 +-
 include/linux/bio.h        |  13 ++++
 include/linux/bvec.h       |  23 ++++++
 include/linux/fs.h         |  28 +------
 include/linux/highmem.h    |  15 +++-
 include/linux/huge_mm.h    |  25 +++++--
 include/linux/mm.h         |  97 +++++++++++++------------
 include/linux/page-flags.h |  46 ++++--------
 include/linux/pagemap.h    |  97 ++++++++++++++++++++++---
 mm/filemap.c               |  91 +++++++++++++++--------
 mm/highmem.c               |  62 +++++++++++++++-
 mm/huge_memory.c           |  38 +++++-----
 mm/internal.h              |  15 ++--
 mm/memory.c                |   7 +-
 mm/page-writeback.c        |   1 +
 mm/page_io.c               |   2 +-
 mm/page_vma_mapped.c       |   4 +-
 mm/readahead.c             | 145 ++++++++++++++++++++++++++++---------
 mm/rmap.c                  |  10 +--
 mm/shmem.c                 |  30 +-------
 mm/truncate.c              |  61 ++++++++++++++--
 mm/vmscan.c                |   5 +-
 30 files changed, 633 insertions(+), 337 deletions(-)

-- 
2.26.2

