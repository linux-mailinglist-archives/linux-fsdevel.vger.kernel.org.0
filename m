Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24B48FCA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiAPMSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiAPMSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC12C06161C;
        Sun, 16 Jan 2022 04:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eO9Mbt8wibF1aSfmoc1KUz0XgzLpgN1Osvl8mSoNdKw=; b=bYZOQ3nmJ8TB9PORAKFQM7uOcs
        rtzNKqVnVthwUurVGvB5vq+GZ0mpyx4qjPedhwptW1akVFzlVV7j87JYRzbmdN4s4ZHcF+aDA5qOz
        avTlIvyaKK2dT/LXlCQogCXFbmFMj7ioQC1NT/mXAAMhOJnCI6EXdkHr4Ro7r/2U8ycmpT2K4LyrR
        Q0f2wggr38mmzXLDt/Cmi88NfQgCNrbon6HQDsOMdThYWNWd4G8GY4GEwV0GtG8x3M+IaSiWxwbud
        smL7ADwVAA8UMo8SRShmSGVmiyeHEilX22JsQ7R7zeJDXVcZ50Lx1yM1YJzez/NoH8//Od1a1EuDj
        bwim/oWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FU9-3f; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/12] Enabling large folios for 5.17
Date:   Sun, 16 Jan 2022 12:18:10 +0000
Message-Id: <20220116121822.1727633-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Is Linux just too stable for you?  Tired of not having your data eaten
by a grue?  Then it's time to experiment with enabling large folios!

You will need:
 - A recent Linus tree (I used a33f5c380c4b)
 - To enable CONFIG_TRANSPARENT_HUGEPAGE
 - An XFS filesystem
 - Your favourite workload

These patches create large folios in the readahead and fault paths.
They do not create large folios in the write path; that is future
work.  For most workloads, this is quite sufficient.  You can
monitor the sizes of folios being added to the page cache with the
mm_filemap_add_to_page_cache tracepoint.

As mentioned in the 'Add large folio readahead' commit message, the
heuristic for deciding when to enlarge the size of the folio being
created is stupid.  I'm sure somebody out there can do better.

This patchset is not (as far as I'm concerned) a candidate for merging
into 5.17.  It hasn't been in linux-next, and while it does not introduce
any regressions in my testing, I'd be uncomfortable seeing it merged
before 5.18.

Matthew Wilcox (Oracle) (11):
  mm: Add folio_put_refs()
  filemap: Use folio_put_refs() in filemap_free_folio()
  filemap: Allow large folios to be added to the page cache
  mm/vmscan: Free non-shmem folios without splitting them
  mm: Fix READ_ONLY_THP warning
  mm/vmscan: Optimise shrink_page_list for non-PMD-sized folios
  mm: Make large folios depend on THP
  mm/readahead: Add large folio readahead
  mm/readahead: Switch to page_cache_ra_order
  mm/filemap: Support VM_HUGEPAGE for file mappings
  selftests/vm/transhuge-stress: Support file-backed PMD folios

William Kucharski (1):
  mm/readahead: Align file mappings for non-DAX

 include/linux/mm.h                            |  20 ++++
 include/linux/pagemap.h                       |  11 +-
 mm/filemap.c                                  |  69 +++++++----
 mm/huge_memory.c                              |   5 +-
 mm/internal.h                                 |   4 +-
 mm/readahead.c                                | 108 ++++++++++++++++--
 mm/vmscan.c                                   |   7 +-
 tools/testing/selftests/vm/transhuge-stress.c |  35 ++++--
 8 files changed, 204 insertions(+), 55 deletions(-)

-- 
2.34.1

