Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB331F5C84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgFJUOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbgFJUN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AAAC03E96B;
        Wed, 10 Jun 2020 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8oTHXpm3xPlps0OwnngRdhhKJXP6EXpNLFH5ObgyZ7o=; b=p1lQmGyIS9CTWJbiLSn5Y7tEvB
        doha4YwSyCdse2a3ltulJxNlhPz+N6U99HYPReSzMLL7vu8yXgoRt/mH8niT2M4E0e7EkTTbIE/IB
        1J2GoiF/6hjPCv7/oMmiVSc5FXC+IH3F8q8NoBWnTIA2AxHapiwrzUJ01RGoolEr6aa0B5fwJQ5p0
        R16ZaUbZZibpcb53+DFHS+nw9cKB7DKUoi5PGPHMvUJB5qri9bbWhx/KIiPDMIKZGCDhnPdXBFEQY
        Gnz9EXs8Ytzd88/NoCmgbq3coU7ewtGbKCkBmarxwDOjgdGDZz23W/9IW4nxOUYaFsaLVGaQGDKJo
        MlyQE2gg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003So-7g; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC v6 00/51] Large pages in the page cache
Date:   Wed, 10 Jun 2020 13:12:54 -0700
Message-Id: <20200610201345.13273-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Another fortnight, another dump of my current large pages work.
I've squished a lot of bugs this time.  xfstests is much happier now,
running for 1631 seconds and getting as far as generic/086.  This patchset
is getting a little big, so I'm going to try to get some bits of it
upstream soon (the bits that make sense regardless of whether the rest
of this is merged).

It's now based on linus' master (6f630784cc0d), and you can get it from
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
 - Fix arc/arm/arm64/mips/powerpc/space flush_dcache_page() to
   support THPs natively
 - Actually create large pages for sufficiently large writes
 - Copy in larger chunks for write() in iomap
 - More bug fixing

v6:
 - Improved debug output for large pages (will send to Andrew soon)
 - Make compound_nr() more efficient (will send to Andrew soon)
 - Renamed hpage_nr_pages() to thp_nr_pages()
 - Added thp_head()
 - Set the THP_SUPPORT flag in shmfs
 - Change zero_user_segments() to call flush_dcache_page() once for the
   head page instead of once for each subpage.  The architectures listed
   above need to be fixed.
 - Fix shmem & truncate to call zero_user_segment() with the head page
 - Fix page_is_mergeable() for THPs
 - Fix a bug in iomap_iop_set_range_uptodate() where I was assuming that
   the offset was block-aligned
 - Fix a few more places that assume unsigned int is large enough to hold
   offset/length within a page
 - Fix doing writeback of a page after discarding its iop due to a partial
   truncate
 - Convert the iomap write paths more comprehensively.  That's now four
   separate patches
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

Matthew Wilcox (Oracle) (49):
  mm: Print head flags in dump_page
  mm: Print the inode number in dump_page
  mm: Print hashed address of struct page
  mm: Move PageDoubleMap bit
  mm: Simplify PageDoubleMap with PF_SECOND policy
  mm: Store compound_nr as well as compound_order
  mm: Move page-flags include to top of file
  mm: Add thp_order
  mm: Add thp_size
  mm: Replace hpage_nr_pages with thp_nr_pages
  mm: Add thp_head
  mm: Introduce offset_in_thp
  mm: Support arbitrary THP sizes
  fs: Add a filesystem flag for THPs
  fs: Do not update nr_thps for mappings which support THPs
  fs: Introduce i_blocks_per_page
  fs: Make page_mkwrite_check_truncate thp-aware
  mm: Support THPs in zero_user_segments
  mm: Zero the head page, not the tail page
  block: Add bio_for_each_thp_segment_all
  block: Support THPs in page_is_mergeable
  iomap: Support arbitrarily many blocks per page
  iomap: Support THPs in iomap_adjust_read_range
  iomap: Support THPs in invalidatepage
  iomap: Support THPs in read paths
  iomap: Convert iomap_write_end types
  iomap: Change calling convention for zeroing
  iomap: Change iomap_write_begin calling convention
  iomap: Support THPs in write paths
  iomap: Inline data shouldn't see THPs
  iomap: Handle tail pages in iomap_page_mkwrite
  xfs: Support THPs
  mm: Make prep_transhuge_page return its argument
  mm: Add __page_cache_alloc_order
  mm: Allow THPs to be added to the page cache
  mm: Allow THPs to be removed from the page cache
  mm: Remove page fault assumption of compound page size
  mm: Remove assumptions of THP size
  mm: Avoid splitting THPs
  mm: Fix truncation for pages of arbitrary size
  mm: Handle truncates that split THPs
  mm: Support storing shadow entries for THPs
  mm: Support retrieving tail pages from the page cache
  mm: Support tail pages in wait_for_stable_page
  mm: Add DEFINE_READAHEAD
  mm: Make page_cache_readahead_unbounded take a readahead_control
  mm: Make __do_page_cache_readahead take a readahead_control
  mm: Allow PageReadahead to be set on head pages
  mm: Add THP readahead

William Kucharski (1):
  mm: Align THP mappings for non-DAX

 block/bio.c                |   2 +-
 drivers/nvdimm/btt.c       |   4 +-
 drivers/nvdimm/pmem.c      |   6 +-
 fs/dax.c                   |  13 +-
 fs/ext4/verity.c           |   4 +-
 fs/f2fs/verity.c           |   4 +-
 fs/inode.c                 |   2 +
 fs/iomap/buffered-io.c     | 250 +++++++++++++++++++------------------
 fs/jfs/jfs_metapage.c      |   2 +-
 fs/xfs/xfs_aops.c          |   4 +-
 fs/xfs/xfs_super.c         |   2 +-
 include/linux/bio.h        |  13 ++
 include/linux/bvec.h       |  23 ++++
 include/linux/dax.h        |   3 +-
 include/linux/fs.h         |  28 +----
 include/linux/highmem.h    |  11 +-
 include/linux/huge_mm.h    |  65 ++++++++--
 include/linux/mm.h         |  46 +++----
 include/linux/mm_inline.h  |   6 +-
 include/linux/mm_types.h   |   1 +
 include/linux/page-flags.h |  46 ++-----
 include/linux/pagemap.h    | 102 ++++++++++++---
 mm/compaction.c            |   2 +-
 mm/debug.c                 |  23 ++--
 mm/filemap.c               | 101 +++++++++------
 mm/gup.c                   |   2 +-
 mm/highmem.c               |  62 ++++++++-
 mm/huge_memory.c           |  38 +++---
 mm/hugetlb.c               |   2 +-
 mm/internal.h              |  17 +--
 mm/memcontrol.c            |  10 +-
 mm/memory.c                |   7 +-
 mm/memory_hotplug.c        |   7 +-
 mm/mempolicy.c             |   2 +-
 mm/migrate.c               |  16 +--
 mm/mlock.c                 |   9 +-
 mm/page-writeback.c        |   1 +
 mm/page_alloc.c            |   5 +-
 mm/page_io.c               |   4 +-
 mm/page_vma_mapped.c       |   6 +-
 mm/readahead.c             | 145 ++++++++++++++++-----
 mm/rmap.c                  |  18 +--
 mm/shmem.c                 |  39 ++----
 mm/swap.c                  |  16 +--
 mm/swap_state.c            |   6 +-
 mm/swapfile.c              |   2 +-
 mm/truncate.c              |  70 ++++++++++-
 mm/vmscan.c                |  12 +-
 48 files changed, 795 insertions(+), 464 deletions(-)

-- 
2.26.2
