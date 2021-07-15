Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381E93CAD8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbhGOUHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346956AbhGOUG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:06:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CC2C061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=filxFTZwrg617ByI8S29lS/yP6GqUcSci2NVizMRGic=; b=oJEUxbJG80/ivIFVb8BvR7qcaj
        AcxnEfZLtx+U2eSux1Cr9fHOKHJYhLszagIs6UjY7RhQA2c81baY8G5yJ0vwTzmIKLA5mVLRJlk0d
        OIql/tNs5C1h140GhLWyPSxcCgl7vDiB1pXEuWEplvAmgNLYaXXd5Yocemx3KlFOjvDnohQTqEhHm
        Wf+X87GcSPRATPJAyRVdaDGyUAHHdIGUW/6A3abr04jWkPEhAi3+907O8iUV1HzHhWMsfkxh1l0+U
        asVxQLZdiILAe1/qbxhAh1v9om0Ga47+1D3qQLT47fzVIculgS9KiFskb/AmxOtjZ/ZXTe3Ysk76H
        OimVqCrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47X7-003lx5-3E; Thu, 15 Jul 2021 20:00:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v14c 00/39] Memory folios: Pagecache edition
Date:   Thu, 15 Jul 2021 20:59:51 +0100
Message-Id: <20210715200030.899216-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series is for human review.  The bots are going to complain
because it depends on the previous 50 folio patches which are now quite
well reviewed (thanks!)  It's almost identical to patches 51-89 of
folio v14 (added a few R-b tags and a couple of minor build fixes)

This set of patches are everything that needs to be done before I can
convert iomap to use folios.  It's probably also all or most of what
needs to be done before other filesystems can be converted to use folios.
So getting this into v5.15 will enable a lot of other work to start.

Matthew Wilcox (Oracle) (39):
  mm: Add folio_pfn()
  mm: Add folio_raw_mapping()
  mm: Add flush_dcache_folio()
  mm: Add kmap_local_folio()
  mm: Add arch_make_folio_accessible()
  mm: Add folio_young and folio_idle
  mm/swap: Add folio_activate()
  mm/swap: Add folio_mark_accessed()
  mm/rmap: Add folio_mkclean()
  mm/migrate: Add folio_migrate_mapping()
  mm/migrate: Add folio_migrate_flags()
  mm/migrate: Add folio_migrate_copy()
  mm/writeback: Rename __add_wb_stat() to wb_stat_mod()
  flex_proportions: Allow N events instead of 1
  mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
  mm/writeback: Add __folio_end_writeback()
  mm/writeback: Add folio_start_writeback()
  mm/writeback: Add folio_mark_dirty()
  mm/writeback: Add __folio_mark_dirty()
  mm/writeback: Convert tracing writeback_page_template to folios
  mm/writeback: Add filemap_dirty_folio()
  mm/writeback: Add folio_account_cleaned()
  mm/writeback: Add folio_cancel_dirty()
  mm/writeback: Add folio_clear_dirty_for_io()
  mm/writeback: Add folio_account_redirty()
  mm/writeback: Add folio_redirty_for_writepage()
  mm/filemap: Add i_blocks_per_folio()
  mm/filemap: Add folio_mkwrite_check_truncate()
  mm/filemap: Add readahead_folio()
  mm/workingset: Convert workingset_refault() to take a folio
  mm: Add folio_evictable()
  mm/lru: Convert __pagevec_lru_add_fn to take a folio
  mm/lru: Add folio_add_lru()
  mm/page_alloc: Add folio allocation functions
  mm/filemap: Add filemap_alloc_folio
  mm/filemap: Add filemap_add_folio()
  mm/filemap: Convert mapping_get_entry to return a folio
  mm/filemap: Add filemap_get_folio
  mm/filemap: Add FGP_STABLE

 Documentation/core-api/cachetlb.rst |   6 +
 arch/arm/include/asm/cacheflush.h   |   1 +
 arch/nds32/include/asm/cacheflush.h |   1 +
 fs/jfs/jfs_metapage.c               |   1 +
 include/asm-generic/cacheflush.h    |   6 +
 include/linux/backing-dev.h         |   6 +-
 include/linux/flex_proportions.h    |   9 +-
 include/linux/gfp.h                 |  22 +-
 include/linux/highmem-internal.h    |  11 +
 include/linux/highmem.h             |  38 +++
 include/linux/ksm.h                 |   4 +-
 include/linux/memcontrol.h          |   5 +-
 include/linux/migrate.h             |   4 +
 include/linux/mm.h                  |  62 +++--
 include/linux/page-flags.h          |  20 +-
 include/linux/page_idle.h           |  99 ++++---
 include/linux/page_owner.h          |   8 +-
 include/linux/pagemap.h             | 189 ++++++++++----
 include/linux/rmap.h                |  10 +-
 include/linux/swap.h                |   8 +-
 include/linux/writeback.h           |   9 +-
 include/trace/events/pagemap.h      |  46 ++--
 include/trace/events/writeback.h    |  20 +-
 kernel/bpf/verifier.c               |   2 +-
 lib/flex_proportions.c              |  28 +-
 mm/filemap.c                        | 238 ++++++++---------
 mm/folio-compat.c                   |  99 +++++++
 mm/hugetlb.c                        |   2 +-
 mm/internal.h                       |  35 ++-
 mm/ksm.c                            |  31 ++-
 mm/memory.c                         |   3 +-
 mm/mempolicy.c                      |  10 +
 mm/migrate.c                        | 187 +++++++-------
 mm/page-writeback.c                 | 383 +++++++++++++++-------------
 mm/page_alloc.c                     |  12 +
 mm/page_owner.c                     |  10 +-
 mm/rmap.c                           |  12 +-
 mm/swap.c                           | 136 +++++-----
 mm/swap_state.c                     |   2 +-
 mm/util.c                           |  39 +--
 mm/workingset.c                     |  34 +--
 41 files changed, 1095 insertions(+), 753 deletions(-)

-- 
2.30.2

