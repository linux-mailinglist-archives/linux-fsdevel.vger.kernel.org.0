Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC471BDDBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgD2NhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2Ng7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:36:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC4C03C1AD;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2R/FYBpDxf8n8DUKZHEPryWyNhbKsTabgMS9K6/ChLE=; b=NHSXfgm8lk/2Hx8SW1rWpWtiV3
        CMlijdePU4dNUxJhfYwYKKr++zz3A3vWmZ0U+m39yRV3QnD1yEK6fEIj30dwVbZmhkJGaXB6a4hCS
        9WPxVP/ku95he8yuNEd9dWy4YIkAUHLgX17mPcszOtUkVc7gqxXx081Wt/XyobfJJaqzzPVUmiPwx
        9ZDVdyUFB/jYmVvKEq+hdDheMxldBQB3n4xgppgq5QNMBECHin+il0gJINg8YZ7tpgjooDajwaTEJ
        8iBfm3wuj0F//WR35WQ2hQp9jPNF23EQhb9gPpc6la3Z+JY7BRbk6rU8oFCkwqmTyXmpLtISGbOFA
        do5Dx+UA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005uB-2T; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/25] Large pages in the page cache
Date:   Wed, 29 Apr 2020 06:36:32 -0700
Message-Id: <20200429133657.22632-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This patch set does not pass xfstests.  Test at your own risk.  It is
based on the readahead rewrite which is in Andrew's tree.  The large
pages somehow manage to fall off the LRU, so the test VM quickly runs
out of memory and freezes.  To reproduce:

# mkfs.xfs /dev/sdb && mount /dev/sdb /mnt && dd if=/dev/zero bs=1M count=2048 of=/mnt/bigfile && sync && sleep 2 && sync && echo 1 >/proc/sys/vm/drop_caches 
# /host/home/willy/kernel/xarray-2/tools/vm/page-types | grep thp
0x0000000000401800	       511        1  ___________Ma_________t____________________	mmap,anonymous,thp
0x0000000000405868	         1        0  ___U_lA____Ma_b_______t____________________	uptodate,lru,active,mmap,anonymous,swapbacked,thp
# dd if=/mnt/bigfile of=/dev/null bs=2M count=5
# /host/home/willy/kernel/xarray-2/tools/vm/page-types | grep thp
0x0000000000400000	      2516        9  ______________________t____________________	thp
0x0000000000400028	         1        0  ___U_l________________t____________________	uptodate,lru,thp
0x000000000040006c	       106        0  __RU_lA_______________t____________________	referenced,uptodate,lru,active,thp
0x0000000000400228	         1        0  ___U_l___I____________t____________________	uptodate,lru,reclaim,thp
0x0000000000401800	       511        1  ___________Ma_________t____________________	mmap,anonymous,thp
0x0000000000405868	         1        0  ___U_lA____Ma_b_______t____________________	uptodate,lru,active,mmap,anonymous,swapbacked,thp


The principal idea here is that a large part of the overhead in dealing
with individual pages is that there's just so darned many of them.  We
would be better off dealing with fewer, larger pages, even if they don't
get to be the size necessary for the CPU to use a larger TLB entry.

Matthew Wilcox (Oracle) (24):
  mm: Allow hpages to be arbitrary order
  mm: Introduce thp_size
  mm: Introduce thp_order
  mm: Introduce offset_in_thp
  fs: Add a filesystem flag for large pages
  fs: Introduce i_blocks_per_page
  fs: Make page_mkwrite_check_truncate thp-aware
  fs: Support THPs in zero_user_segments
  bio: Add bio_for_each_thp_segment_all
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
  mm: Remove page fault assumption of compound page size
  mm: Add DEFINE_READAHEAD
  mm: Make page_cache_readahead_unbounded take a readahead_control
  mm: Make __do_page_cache_readahead take a readahead_control
  mm: Add large page readahead

William Kucharski (1):
  mm: Align THP mappings for non-DAX

 drivers/nvdimm/btt.c    |   4 +-
 drivers/nvdimm/pmem.c   |   6 +-
 fs/ext4/verity.c        |   4 +-
 fs/f2fs/verity.c        |   4 +-
 fs/iomap/buffered-io.c  | 110 ++++++++++++++++--------------
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |   4 +-
 fs/xfs/xfs_super.c      |   2 +-
 include/linux/bio.h     |  13 ++++
 include/linux/bvec.h    |  23 +++++++
 include/linux/fs.h      |   1 +
 include/linux/highmem.h |  15 +++--
 include/linux/huge_mm.h |  25 +++++--
 include/linux/mm.h      |  97 ++++++++++++++-------------
 include/linux/pagemap.h |  62 ++++++++++++++---
 mm/filemap.c            |  60 ++++++++++++-----
 mm/highmem.c            |  62 ++++++++++++++++-
 mm/huge_memory.c        |  49 ++++++--------
 mm/internal.h           |  13 ++--
 mm/memory.c             |   7 +-
 mm/page_io.c            |   2 +-
 mm/page_vma_mapped.c    |   4 +-
 mm/readahead.c          | 145 ++++++++++++++++++++++++++++++----------
 23 files changed, 485 insertions(+), 229 deletions(-)

-- 
2.26.2

