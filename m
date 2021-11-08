Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62316447925
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhKHENT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbhKHENS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:13:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981FC061570;
        Sun,  7 Nov 2021 20:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ktUs3uTQ8/E5fdzFkqY1zH7fnzNTHiKLIPKl79EDTvQ=; b=rz69hoxIcde3ZSkZGxzrx8B3G3
        NZ6ipfKdYo7Dgv0EQAZqiT/2KjOgglkGFI5PCGdSzPIFGuNMW7Pg6mYhHUqsdM2/uAWAfEcIZdixl
        dri2cK+oMRkmy/8S11UkympF9k6ohjmCUXcasgTnz1SpbJEy8bvwlPeuSB9EH8ju9xPAGstrkMhA+
        VN1hfVqbAuwlG+Krp34Fg6ez5l2mxpIboxKVvpzl1ASZvTKcOBquL19nrC9NL14ro8LjvQrl5JSAD
        ae4HVB0MXWulOgw5oTH1VoWBTwWupJgDaOi29ZoE5sG6qg8QXyndUsWfjxEjr3a9hyLoLSTg3kkTd
        O1qRXaZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjvur-0089Qy-Hv; Mon, 08 Nov 2021 04:06:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 00/28] iomap/xfs folio patches
Date:   Mon,  8 Nov 2021 04:05:23 +0000
Message-Id: <20211108040551.1942823-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset converts XFS & iomap to use folios, and gets them to a
state where they can handle multi-page folios.  Applying these patches
is not yet sufficient to actually start using multi-page folios for
XFS; more page cache changes are needed.  I don't anticipate needing to
touch XFS again until we're at the point where we want to convert the
aops to be type-safe.  It completes an xfstests run with no unexpected
failures.  Most of these patches have been posted before and I've retained
acks/reviews where I thought them reasonable.  Some patches are new.

v2:
 - Added review tags from Jens, Darrick & Christoph (thanks!)
 - Added folio_zero_* wrappers around zero_user_*()
 - Added a patch to rename AS_THP_SUPPORT
 - Added a patch to convert __block_write_begin_int() to take a folio
 - Split the iomap_add_to_ioend() patch into three
 - Updated changelog of bio_add_folio() (Jens)
 - Adjusted whitespace of bio patches (Christoph, Jens)
 - Improved changelog of readahead conversion to explain why the put_page()
   disappeared (Christoph)
 - Add a patch to zero an entire folio at a time, instead of limiting to
   a page
 - Switch pos & end_pos back to being u64 from loff_t
 - Call block_write_end() and ->page_done with the head page of the folio,
   as that's what those functions expect.

I intend to push patch 1 upstream myself (before 5.16), but I've included
it here to avoid nasty messages from the build-bots.  I can probably
persuade Linus to take patches 2-4 as well if Darrick's not comfortable
taking them as part of the iomap changes.

These changes are also available at:
  git://git.infradead.org/users/willy/pagecache.git heads/folio-iomap

I intend to rebase that branch to include any further R-b tags (some of
the patches are new and don't have reviews).

Matthew Wilcox (Oracle) (28):
  csky,sparc: Declare flush_dcache_folio()
  mm: Add functions to zero portions of a folio
  fs: Remove FS_THP_SUPPORT
  fs: Rename AS_THP_SUPPORT and mapping_thp_support
  block: Add bio_add_folio()
  block: Add bio_for_each_folio_all()
  fs/buffer: Convert __block_write_begin_int() to take a folio
  iomap: Convert to_iomap_page to take a folio
  iomap: Convert iomap_page_create to take a folio
  iomap: Convert iomap_page_release to take a folio
  iomap: Convert iomap_releasepage to use a folio
  iomap: Add iomap_invalidate_folio
  iomap: Pass the iomap_page into iomap_set_range_uptodate
  iomap: Convert bio completions to use folios
  iomap: Use folio offsets instead of page offsets
  iomap: Convert iomap_read_inline_data to take a folio
  iomap: Convert readahead and readpage to use a folio
  iomap: Convert iomap_page_mkwrite to use a folio
  iomap: Convert __iomap_zero_iter to use a folio
  iomap: Convert iomap_write_begin() and iomap_write_end() to folios
  iomap: Convert iomap_write_end_inline to take a folio
  iomap,xfs: Convert ->discard_page to ->discard_folio
  iomap: Simplify iomap_writepage_map()
  iomap: Simplify iomap_do_writepage()
  iomap: Convert iomap_add_to_ioend() to take a folio
  iomap: Convert iomap_migrate_page() to use folios
  iomap: Support multi-page folios in invalidatepage
  xfs: Support multi-page folios

 Documentation/core-api/kernel-api.rst  |   1 +
 arch/csky/abiv1/inc/abi/cacheflush.h   |   1 +
 arch/csky/abiv2/inc/abi/cacheflush.h   |   2 +
 arch/sparc/include/asm/cacheflush_32.h |   1 +
 arch/sparc/include/asm/cacheflush_64.h |   1 +
 block/bio.c                            |  22 ++
 fs/buffer.c                            |  22 +-
 fs/inode.c                             |   2 -
 fs/internal.h                          |   2 +-
 fs/iomap/buffered-io.c                 | 506 +++++++++++++------------
 fs/xfs/xfs_aops.c                      |  24 +-
 fs/xfs/xfs_icache.c                    |   2 +
 include/linux/bio.h                    |  56 ++-
 include/linux/fs.h                     |   1 -
 include/linux/highmem.h                |  44 ++-
 include/linux/iomap.h                  |   3 +-
 include/linux/pagemap.h                |  26 +-
 mm/highmem.c                           |   2 -
 mm/shmem.c                             |   3 +-
 19 files changed, 431 insertions(+), 290 deletions(-)

-- 
2.33.0

