Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4164B3B0418
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFVMT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhFVMT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:19:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B81C061574;
        Tue, 22 Jun 2021 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Bi9mU/y3AgkZqz4pMv+LJds5ZZ5YN/sF3JHkG2XPIRU=; b=vNqAYHTCbmsKnhZGNaz5EB5LTQ
        LYXNE5jNBz5YQ2zgc9MAq/aMxg8YraTwNmWjNzjcIozk3QnCpFPnYD9GqVw7EE2izuXvw/yjwgE3w
        gBxlWJEt9WzahbigIBPCJewXqhXRKXtD55nrUXBEkBOy+Z9GlCoJ6soFy8ZIHPE9IjCvO0nxr0thf
        jdmAQs82OeAVqvmAFbBhTnPoXUj1kufVpzkhpJQK00AIR4J5P6XSsST9Jnf6gbsI++watVhpzi0Cz
        BSQbs0tNsKhAnRg3kZHBQMFV9+aCmHxmGB1ODBLhg309z1eQs1Y3/UqPDxFKj61e8NduO8KN7l+3J
        FKhX/ZWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfJs-00EGBW-7m; Tue, 22 Jun 2021 12:16:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/46] Folio-enabling the page cache
Date:   Tue, 22 Jun 2021 13:15:05 +0100
Message-Id: <20210622121551.3398730-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are all the patches I've collected to date which enable filesystems
to be converted to use folios.  After applying these patches (on top of
folio v12), I have an iomap (ie xfs/zonefs) conversion.  I would expect
filesystems to convert one-by-one, rather than converting all callers of
(say) set_page_writeback() to call folio_start_writeback().

The biggest chunk of this is teaching the writeback code that folios may
be larger than a single page, so there's no (or little) code reduction
from these patches.  Instead it takes us to where we can start preparing
filesystems to see multi-page folios.

Matthew Wilcox (Oracle) (46):
  mm: Add folio_to_pfn()
  mm: Add folio_rmapping()
  mm: Add kmap_local_folio()
  mm: Add flush_dcache_folio()
  mm: Add arch_make_folio_accessible()
  mm: Add folio_young() and folio_idle()
  mm/workingset: Convert workingset_activation to take a folio
  mm/swap: Add folio_activate()
  mm/swap: Add folio_mark_accessed()
  mm/rmap: Add folio_mkclean()
  mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics()
  mm/memcg: Use the node id in mem_cgroup_update_tree()
  mm/memcg: Convert commit_charge() to take a folio
  mm/memcg: Add folio_charge_cgroup()
  mm/memcg: Add folio_uncharge_cgroup()
  mm/memcg: Add folio_migrate_cgroup()
  mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
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
  mm/filemap: Add filemap_add_folio
  mm/filemap: Convert mapping_get_entry to return a folio
  mm/filemap: Add filemap_get_folio
  mm/filemap: Add FGP_STABLE

 .../admin-guide/cgroup-v1/memcg_test.rst      |   2 +-
 Documentation/core-api/cachetlb.rst           |   6 +
 arch/nds32/include/asm/cacheflush.h           |   1 +
 fs/jfs/jfs_metapage.c                         |   1 +
 include/asm-generic/cacheflush.h              |   6 +
 include/linux/backing-dev.h                   |   6 +-
 include/linux/flex_proportions.h              |   9 +-
 include/linux/gfp.h                           |  22 +-
 include/linux/highmem-internal.h              |  11 +
 include/linux/highmem.h                       |  38 ++
 include/linux/ksm.h                           |   4 +-
 include/linux/memcontrol.h                    |  28 +-
 include/linux/migrate.h                       |   4 +
 include/linux/mm.h                            |  51 +--
 include/linux/page-flags.h                    |  20 +-
 include/linux/page_idle.h                     |  99 +++--
 include/linux/page_owner.h                    |   8 +-
 include/linux/pagemap.h                       | 195 ++++++---
 include/linux/rmap.h                          |  10 +-
 include/linux/swap.h                          |  10 +-
 include/linux/writeback.h                     |   9 +-
 include/trace/events/writeback.h              |   8 +-
 kernel/bpf/verifier.c                         |   2 +-
 lib/flex_proportions.c                        |  28 +-
 mm/filemap.c                                  | 240 +++++------
 mm/folio-compat.c                             |  98 +++++
 mm/internal.h                                 |  35 +-
 mm/ksm.c                                      |  31 +-
 mm/memcontrol.c                               | 124 +++---
 mm/memory.c                                   |   3 +-
 mm/mempolicy.c                                |  10 +
 mm/migrate.c                                  | 242 +++++------
 mm/page-writeback.c                           | 383 ++++++++++--------
 mm/page_alloc.c                               |  12 +
 mm/page_owner.c                               |  10 +-
 mm/rmap.c                                     |  12 +-
 mm/shmem.c                                    |   5 +-
 mm/swap.c                                     | 137 ++++---
 mm/swap_state.c                               |   2 +-
 mm/util.c                                     |  33 +-
 mm/workingset.c                               |  44 +-
 41 files changed, 1158 insertions(+), 841 deletions(-)

-- 
2.30.2

