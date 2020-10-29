Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18329F553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgJ2TeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgJ2TeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B2C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZgHdCfzpzQ7IKzaSzNJ4oqpe7Y/vCw/REGTk/NIYUac=; b=ZjY+Roa5E8NERG2vcHsA/VL0xq
        yxwnoKgifxkRONE0Nc43Eiet6to737Kmfg/txM3J0H9yp+txHibqtoNIt7/7DbfvF3YR7lgT+2B1z
        q87GKVfSDkvX3zU3HaZnq1qxki1lEncP+U5laHOstMeMiiZGa1ORkdpmHUNOTbkLgjvOOzjjdHLNA
        /CqbNvXGayzv2jZxI0bJzQwl+GJLg02pk7Xn5niOfeo3mSG5rjymWTM6iuiy3eNj9Tf7l5MGpPe5r
        W/FUZv5iCCAoXsAe6IEafwU+s5eR3SwEQaXZq02cXCfJTL70q7F+ioEqhI2Xk0AgbdVCSWeFSfUq0
        msemzhEA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgV-0007b1-IU; Thu, 29 Oct 2020 19:34:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/19] Transparent Hugepages for non-tmpfs filesystems
Date:   Thu, 29 Oct 2020 19:33:46 +0000
Message-Id: <20201029193405.29125-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After months of merging prep patches, here's the end result.  It holds
up to xfstests on both shmem and xfs.  It's based on linux-next as of
a couple of days ago, plus several of the patches I've sent in the
last week:
https://lore.kernel.org/linux-mm/20201026041408.25230-1-willy@infradead.org/
https://lore.kernel.org/linux-mm/20201026151849.24232-1-willy@infradead.org/
https://lore.kernel.org/linux-mm/20201026183136.10404-1-willy@infradead.org/

You can get a complete git tree here:
http://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/next

This tree only includes support for XFS.  It would probably be
straightforward to add support to ZoneFS (which also uses iomap), but I
haven't looked into it.  Dave Howells has AFS support working based on
these patches:
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-thp

Matthew Wilcox (Oracle) (18):
  XArray: Expose xas_destroy
  mm: Use multi-index entries in the page cache
  mm: Support arbitrary THP sizes
  mm: Change NR_FILE_THPS to account in base pages
  mm/filemap: Rename generic_file_buffered_read subfunctions
  mm/filemap: Change calling convention for gfbr_ functions
  mm/filemap: Use head pages in generic_file_buffered_read
  mm/filemap: Add __page_cache_alloc_order
  mm/filemap: Allow THPs to be added to the page cache
  mm/vmscan: Optimise shrink_page_list for smaller THPs
  mm/filemap: Allow PageReadahead to be set on head pages
  mm: Pass a sleep state to put_and_wait_on_page_locked
  mm/filemap: Support readpage splitting a page
  mm/filemap: Inline __wait_on_page_locked_async into caller
  mm/readahead: Add THP readahead
  mm/readahead: Switch to page_cache_ra_order
  mm/filemap: Support VM_HUGEPAGE for file mappings
  selftests/vm/transhuge-stress: Support file-backed THPs

William Kucharski (1):
  mm/readahead: Align THP mappings for non-DAX

 drivers/base/node.c                           |   3 +-
 fs/proc/meminfo.c                             |   2 +-
 include/linux/huge_mm.h                       |   8 +-
 include/linux/mm.h                            |  42 +-
 include/linux/mmzone.h                        |   2 +-
 include/linux/page-flags.h                    |   4 +-
 include/linux/pagemap.h                       |  37 +-
 include/linux/xarray.h                        |   1 +
 lib/xarray.c                                  |   7 +-
 mm/filemap.c                                  | 399 ++++++++++--------
 mm/huge_memory.c                              |  31 +-
 mm/internal.h                                 |   4 +-
 mm/khugepaged.c                               |  15 +-
 mm/migrate.c                                  |  12 +-
 mm/readahead.c                                | 102 ++++-
 mm/shmem.c                                    |  11 +-
 mm/vmscan.c                                   |   3 +-
 tools/testing/selftests/vm/transhuge-stress.c |  36 +-
 18 files changed, 430 insertions(+), 289 deletions(-)

-- 
2.28.0

