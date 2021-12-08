Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F546CC75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbhLHE1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244217AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DEAC061A32
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=l/b5HovyiPdSaDHY7RLFyp0+AG8r4EQpFVIDRiW559Y=; b=AVnrf3p75+sXkTtR5iOj6WkwuI
        KcYzkTJlN1ymZWMI7/nRYcZF5BdS/XN7d74Q0bbouLorlXp70GOiCw2s1Oe2pjUJITMwZTxJO1Fzr
        /Qvd7O6JYwMolaEd+uYGRhRRG7uS1A4dErU79+/nylyMcRKBC8JWtl6thKWxMXXVRtStNdQc7zpic
        QWfzIH7vpFcLjN6AgVOvr9fgcCYWN+4QwRi0s+IeaMFBejkxVewLk6/gF5+lcjupdlQuQw8y1zbnc
        fJJ89esO1xucnw5aNFX9nKuiP30QqfVhMxQKzradYRSFVpVOTWXzj9RXJWTu7zEvojy6SRTq62QXT
        D0BWd4ug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU1-0084Wf-Dc; Wed, 08 Dec 2021 04:23:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/48] Folios for 5.17
Date:   Wed,  8 Dec 2021 04:22:08 +0000
Message-Id: <20211208042256.1923824-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I was trying to get all the way to adding large folios to the page cache,
but I ran out of time.  I think the changes in this batch of patches
are worth adding, even without large folio support for filesystems other
than tmpfs.

The big change here is the last patch which switches from storing
large folios in the page cache as 2^N identical entries to using the
XArray support for multi-index entries.  As the changelog says, this
fixes a bug that can occur when doing (eg) msync() or sync_file_range().

Some parts of this have been sent before.  The first patch is already
in Andrew's tree, but I included it here so the build bots don't freak
out about not being able to apply this patch series.  The folio_batch
(replacement for pagevec) is new.  I also fixed a few bugs.

This all passes xfstests with no new failures on both xfs and tmpfs.
I intend to put all this into for-next tomorrow.

Matthew Wilcox (Oracle) (48):
  filemap: Remove PageHWPoison check from next_uptodate_page()
  fs/writeback: Convert inode_switch_wbs_work_fn to folios
  mm/doc: Add documentation for folio_test_uptodate
  mm/writeback: Improve __folio_mark_dirty() comment
  pagevec: Add folio_batch
  iov_iter: Add copy_folio_to_iter()
  iov_iter: Convert iter_xarray to use folios
  mm: Add folio_test_pmd_mappable()
  filemap: Add folio_put_wait_locked()
  filemap: Convert page_cache_delete to take a folio
  filemap: Add filemap_unaccount_folio()
  filemap: Convert tracing of page cache operations to folio
  filemap: Add filemap_remove_folio and __filemap_remove_folio
  filemap: Convert find_get_entry to return a folio
  filemap: Remove thp_contains()
  filemap: Convert filemap_get_read_batch to use folios
  filemap: Convert find_get_pages_contig to folios
  filemap: Convert filemap_read_page to take a folio
  filemap: Convert filemap_create_page to folio
  filemap: Convert filemap_range_uptodate to folios
  readahead: Convert page_cache_async_ra() to take a folio
  readahead: Convert page_cache_ra_unbounded to folios
  filemap: Convert do_async_mmap_readahead to take a folio
  filemap: Convert filemap_fault to folio
  filemap: Add read_cache_folio and read_mapping_folio
  filemap: Convert filemap_get_pages to use folios
  filemap: Convert page_cache_delete_batch to folios
  filemap: Use folios in next_uptodate_page
  filemap: Use a folio in filemap_map_pages
  filemap: Use a folio in filemap_page_mkwrite
  filemap: Add filemap_release_folio()
  truncate: Add truncate_cleanup_folio()
  mm: Add unmap_mapping_folio()
  shmem: Convert part of shmem_undo_range() to use a folio
  truncate,shmem: Add truncate_inode_folio()
  truncate: Skip known-truncated indices
  truncate: Convert invalidate_inode_pages2_range() to use a folio
  truncate: Add invalidate_complete_folio2()
  filemap: Convert filemap_read() to use a folio
  filemap: Convert filemap_get_read_batch() to use a folio_batch
  filemap: Return only folios from find_get_entries()
  mm: Convert find_lock_entries() to use a folio_batch
  mm: Remove pagevec_remove_exceptionals()
  fs: Convert vfs_dedupe_file_range_compare to folios
  truncate: Convert invalidate_inode_pages2_range to folios
  truncate,shmem: Handle truncates that split large folios
  XArray: Add xas_advance()
  mm: Use multi-index entries in the page cache

 fs/fs-writeback.c              |  24 +-
 fs/remap_range.c               | 116 ++--
 include/linux/huge_mm.h        |  14 +
 include/linux/mm.h             |  68 +--
 include/linux/page-flags.h     |  13 +-
 include/linux/pagemap.h        |  59 +-
 include/linux/pagevec.h        |  61 ++-
 include/linux/uio.h            |   7 +
 include/linux/xarray.h         |  18 +
 include/trace/events/filemap.h |  32 +-
 lib/iov_iter.c                 |  29 +-
 lib/xarray.c                   |   6 +-
 mm/filemap.c                   | 967 ++++++++++++++++-----------------
 mm/folio-compat.c              |  11 +
 mm/huge_memory.c               |  20 +-
 mm/internal.h                  |  35 +-
 mm/khugepaged.c                |  12 +-
 mm/memory.c                    |  27 +-
 mm/migrate.c                   |  29 +-
 mm/page-writeback.c            |   6 +-
 mm/readahead.c                 |  24 +-
 mm/shmem.c                     | 174 +++---
 mm/swap.c                      |  26 +-
 mm/truncate.c                  | 305 ++++++-----
 24 files changed, 1100 insertions(+), 983 deletions(-)

-- 
2.33.0

