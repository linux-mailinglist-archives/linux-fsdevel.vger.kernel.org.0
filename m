Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5ABD5D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411316AbfIYAwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411311AbfIYAwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Iij4AiVZizN/3WavyeQe30O/Qctp+EpEPG2/rssTGhE=; b=d2NWBPO+cJQTO7cy/KuThc+Et
        Jrr0ZF/vteZHveQ2m5qltMFPmGXQdEUTl5DW4vcnTTsNVAqpIpAPCvzd9l2iYORY2XpfiFS03D2ZX
        MPHFvKHe+WhY69n8zUsQUWNd2s1NbL1ao/+XWh25w+dMquJkQPNssjRALCKe+05KBwB0nsmobvGa2
        83ati+Zq8wyQ4P5jOlF19o+QkZ77oeHsVWZaj0JWK3GXsefzGqlacBETV4B9OOj3LSTmKKs4eR9uy
        i5huzFvcFI64wpPWoVxO4t4MdWol9Q4lFpImLpM/e4fXb8R3Lud7P4ZFhXcGNxcn3PGaQz50bWSZd
        ZyP7JjiVw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076D-4c; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [RFC 00/15] Large pages in the page-cache
Date:   Tue, 24 Sep 2019 17:51:59 -0700
Message-Id: <20190925005214.27240-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Here's what I'm currently playing with.  I'm having trouble _testing_
it, but since akpm's patches were just merged into Linus' tree, I
thought this would be a good point to send out my current work tree.
Thanks to kbuild bot for finding a bunch of build problems ;-)

Matthew Wilcox (Oracle) (12):
  mm: Use vm_fault error code directly
  fs: Introduce i_blocks_per_page
  mm: Add file_offset_of_ helpers
  iomap: Support large pages
  xfs: Support large pages
  xfs: Pass a page to xfs_finish_page_writeback
  mm: Make prep_transhuge_page tail-callable
  mm: Add __page_cache_alloc_order
  mm: Allow large pages to be added to the page cache
  mm: Allow find_get_page to be used for large pages
  mm: Remove hpage_nr_pages
  xfs: Use filemap_huge_fault

William Kucharski (3):
  mm: Support removing arbitrary sized pages from mapping
  mm: Add a huge page fault handler for files
  mm: Align THP mappings for non-DAX

 drivers/net/ethernet/ibm/ibmveth.c |   2 -
 drivers/nvdimm/btt.c               |   4 +-
 drivers/nvdimm/pmem.c              |   3 +-
 fs/iomap/buffered-io.c             | 121 +++++++----
 fs/jfs/jfs_metapage.c              |   2 +-
 fs/xfs/xfs_aops.c                  |  37 ++--
 fs/xfs/xfs_file.c                  |   5 +-
 include/linux/huge_mm.h            |  15 +-
 include/linux/iomap.h              |   2 +-
 include/linux/mm.h                 |  12 ++
 include/linux/mm_inline.h          |   6 +-
 include/linux/pagemap.h            |  73 ++++++-
 mm/filemap.c                       | 311 ++++++++++++++++++++++++++---
 mm/gup.c                           |   2 +-
 mm/huge_memory.c                   |  11 +-
 mm/internal.h                      |   4 +-
 mm/memcontrol.c                    |  14 +-
 mm/memory_hotplug.c                |   4 +-
 mm/mempolicy.c                     |   2 +-
 mm/migrate.c                       |  19 +-
 mm/mlock.c                         |   9 +-
 mm/page_io.c                       |   4 +-
 mm/page_vma_mapped.c               |   6 +-
 mm/rmap.c                          |   8 +-
 mm/swap.c                          |   4 +-
 mm/swap_state.c                    |   4 +-
 mm/swapfile.c                      |   2 +-
 mm/vmscan.c                        |   9 +-
 28 files changed, 519 insertions(+), 176 deletions(-)

-- 
2.23.0

