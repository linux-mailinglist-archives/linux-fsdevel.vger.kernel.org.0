Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9768220D36B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgF2S6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgF2S5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:46 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337DC030789
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tNH0UcdJNwMg0E0N/7yxDHtc+jMuOV3AzjC5PE5g8zc=; b=I1FkQoYpV/2o0z9p1yUhi/oY/G
        xGEVjEBo0jAJyfwAzyP8kZ3aVPUPs9rsOaUaZ0GAyU2p1pVxAawLrETAzA8GjLNCAyCt2V/rK2EPx
        Ai/VkDqKPtf0/we8KrqQN1tCj4zuxMkgMc0WGnVDTqhWUcMIykq0hmDsOITG9Vig1QurMeEnNs4ii
        MLRiNYvfan+cqaC5FGmrXctcN5tf6mXghyTXhKNUjaOdCKDRAEDCLl5or+s7VkKPPYxx666Jv5Iyj
        jtfvkGB57idO5YB4L/AmnXnsliMecrGvnseiPlReNuRJxwIl/ORFKSqmBxh+aLjLbE5QivGSzrY0X
        iGs3CZ7A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZn-0004Bu-4L; Mon, 29 Jun 2020 15:20:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/7] THP prep patches
Date:   Mon, 29 Jun 2020 16:19:52 +0100
Message-Id: <20200629151959.15779-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are some generic cleanups and improvements, which I would like
merged into mmotm soon.  The first one should be a performance improvement
for all users of compound pages, and the others are aimed at getting
code to compile away when CONFIG_TRANSPARENT_HUGEPAGE is disabled (ie
small systems).  Also better documented / less confusing than the current
prefix mixture of compound, hpage and thp.

Matthew Wilcox (Oracle) (7):
  mm: Store compound_nr as well as compound_order
  mm: Move page-flags include to top of file
  mm: Add thp_order
  mm: Add thp_size
  mm: Replace hpage_nr_pages with thp_nr_pages
  mm: Add thp_head
  mm: Introduce offset_in_thp

 drivers/nvdimm/btt.c      |  4 +--
 drivers/nvdimm/pmem.c     |  6 ++--
 include/linux/huge_mm.h   | 58 ++++++++++++++++++++++++++++++++++++---
 include/linux/mm.h        | 12 ++++----
 include/linux/mm_inline.h |  6 ++--
 include/linux/mm_types.h  |  1 +
 include/linux/pagemap.h   |  6 ++--
 mm/compaction.c           |  2 +-
 mm/filemap.c              |  2 +-
 mm/gup.c                  |  2 +-
 mm/hugetlb.c              |  2 +-
 mm/internal.h             |  4 +--
 mm/memcontrol.c           | 10 +++----
 mm/memory_hotplug.c       |  7 ++---
 mm/mempolicy.c            |  2 +-
 mm/migrate.c              | 16 +++++------
 mm/mlock.c                |  9 +++---
 mm/page_alloc.c           |  5 ++--
 mm/page_io.c              |  4 +--
 mm/page_vma_mapped.c      |  6 ++--
 mm/rmap.c                 |  8 +++---
 mm/swap.c                 | 16 +++++------
 mm/swap_state.c           |  6 ++--
 mm/swapfile.c             |  2 +-
 mm/vmscan.c               |  6 ++--
 mm/workingset.c           |  6 ++--
 26 files changed, 127 insertions(+), 81 deletions(-)

-- 
2.27.0

