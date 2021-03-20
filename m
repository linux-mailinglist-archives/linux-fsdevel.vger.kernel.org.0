Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B0342AF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCTFmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhCTFl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:41:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBAAC061762;
        Fri, 19 Mar 2021 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=p1JgNBqrECKzysgbItuvrSJOwQ1sHV3gLAbcBktJsiE=; b=BHU6QWmwlbujmCdRv6Ue94KetU
        kRbrmeWZPpyxHCtOal9Qucq5aFMXPFg5h5u3ucsBiVk0Adz8FbNYN6yx/I+28gSeHznoXcUbgovJg
        LdtQZvpPSmo5cdUMEuJLrjPXxwX8Elz5/zocEZ3ff2MB4KIdkgZmJJBZTx9UFgy1/uN6NQgv74dCi
        xvUzsQ3btp9x0nkj0MUVXnMWnxTXUDja/j51UOksmZF+BgOyOA7JCfgL8Qtf+Qcv0gotmjahe+4rO
        qqAH3touSn5vpvwE1m4nLiqp09OH3KWTwqYYVzCque6se2mmslsjTpemrnF4+o2429MKdUGGv0cL6
        g1MdTiBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUMD-005SPF-P1; Sat, 20 Mar 2021 05:41:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 00/27] Memory Folios
Date:   Sat, 20 Mar 2021 05:40:37 +0000
Message-Id: <20210320054104.1300774-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
exist which show the benefits of a larger "page size".  As an example,
an earlier iteration of this idea which used compound pages got a 7%
performance boost when compiling the kernel using kernbench without any
particular tuning.

Using compound pages or THPs exposes a serious weakness in our type
system.  Functions are often unprepared for compound pages to be passed
to them, and may only act on PAGE_SIZE chunks.  Even functions which are
aware of compound pages may expect a head page, and do the wrong thing
if passed a tail page.

There have been efforts to label function parameters as 'head' instead
of 'page' to indicate that the function expects a head page, but this
leaves us with runtime assertions instead of using the compiler to prove
that nobody has mistakenly passed a tail page.  Calling a struct page
'head' is also inaccurate as they will work perfectly well on base pages.
The term 'nottail' has not proven popular.

We also waste a lot of instructions ensuring that we're not looking at
a tail page.  Almost every call to PageFoo() contains one or more hidden
calls to compound_head().  This also happens for get_page(), put_page()
and many more functions.  There does not appear to be a way to tell gcc
that it can cache the result of compound_head(), nor is there a way to
tell it that compound_head() is idempotent.

This series introduces the 'struct folio' as a replacement for
head-or-base pages.  This initial set reduces the kernel size by
approximately 6kB, although its real purpose is adding infrastructure
to enable further use of the folio.

The intent is to convert all filesystems and some device drivers to work
in terms of folios.  This series contains a lot of explicit conversions,
but it's important to realise it's removing a lot of implicit conversions
in some relatively hot paths.  There will be very few conversions from
folios when this work is completed; filesystems, the page cache, the
LRU and so on will generally only deal with folios.

I analysed the text size reduction using a config based on Oracle UEK
with all modules changed to built-in.  That's obviously not a kernel
which makes sense to run, but it serves to compare the effects on (many
common) filesystems & drivers, not just the core.

add/remove: 33645/33632 grow/shrink: 1850/1924 up/down: 894474/-899674 (-5200)

Current tree at:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

(contains another ~100 patches on top of this batch, not all of which are
in good shape for submission)

v5:
 - Rebase on next-20210319
 - Pull out three bug-fix patches to the front of the series, allowing
   them to be applied earlier.
 - Fix folio_page() against pages being moved between swap & page cache
 - Fix FolioDoubleMap to use the right page flags
 - Rename next_folio() to folio_next() (akpm)
 - Renamed folio stat functions (akpm)
 - Add 'mod' versions of the folio stats for users that already have 'nr'
 - Renamed folio_page to folio_file_page() (akpm)
 - Added kernel-doc for struct folio, folio_next(), folio_index(),
   folio_file_page(), folio_contains(), folio_order(), folio_nr_pages(),
   folio_shift(), folio_size(), page_folio(), get_folio(), put_folio()
 - Make folio_private() work in terms of void * instead of unsigned long
 - Used page_folio() in attach/detach page_private() (hch)
 - Drop afs_page_mkwrite folio conversion from this series
 - Add wait_on_folio_writeback_killable()
 - Convert add_page_wait_queue() to add_folio_wait_queue()
 - Add folio_swap_entry() helper
 - Drop the additions of *FolioFsCache
 - Simplify the addition of lock_folio_memcg() et al
 - Drop test_clear_page_writeback() conversion from this series
 - Add FolioTransHuge() definition
 - Rename __folio_file_mapping() to swapcache_mapping()
 - Added swapcache_index() helper
 - Removed lock_folio_async()
 - Made __lock_folio_async() static to filemap.c
 - Converted unlock_page_private_2() to use a folio internally
v4:
 - Rebase on current Linus tree (including swap fix)
 - Analyse each patch in terms of its effects on kernel text size.
   A few were modified to improve their effect.  In particular, where
   pushing calls to page_folio() into the callers resulted in unacceptable
   size increases, the wrapper was placed in mm/folio-compat.c.  This lets
   us see all the places which are good targets for conversion to folios.
 - Some of the patches were reordered, split or merged in order to make
   more logical sense.
 - Use nth_page() for folio_next() if we're using SPARSEMEM and not
   VMEMMAP (Zi Yan)
 - Increment and decrement page stats in units of pages instead of units
   of folios (Zi Yan)
v3:
 - Rebase on next-20210127.  Two major sources of conflict, the
   generic_file_buffered_read refactoring (in akpm tree) and the
   fscache work (in dhowells tree).
v2:
 - Pare patch series back to just infrastructure and the page waiting
   parts.

Matthew Wilcox (Oracle) (27):
  fs/cachefiles: Remove wait_bit_key layout dependency
  mm/writeback: Add wait_on_page_writeback_killable
  afs: Use wait_on_page_writeback_killable
  mm: Introduce struct folio
  mm: Add folio_pgdat and folio_zone
  mm/vmstat: Add functions to account folio statistics
  mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
  mm: Add put_folio
  mm: Add get_folio
  mm: Create FolioFlags
  mm: Handle per-folio private data
  mm: Add folio_index, folio_file_page and folio_contains
  mm/util: Add folio_mapping and folio_file_mapping
  mm/memcg: Add folio wrappers for various functions
  mm/filemap: Add unlock_folio
  mm/filemap: Add lock_folio
  mm/filemap: Add lock_folio_killable
  mm/filemap: Add __lock_folio_async
  mm/filemap: Add __lock_folio_or_retry
  mm/filemap: Add wait_on_folio_locked
  mm/filemap: Add end_folio_writeback
  mm/writeback: Add wait_on_folio_writeback
  mm/writeback: Add wait_for_stable_folio
  mm/filemap: Convert wait_on_page_bit to wait_on_folio_bit
  mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
  mm/filemap: Convert page wait queues to be folios
  mm/doc: Build kerneldoc for various mm files

 Documentation/core-api/mm-api.rst |   7 +
 fs/afs/write.c                    |   3 +-
 fs/cachefiles/rdwr.c              |  19 ++-
 fs/io_uring.c                     |   2 +-
 include/linux/memcontrol.h        |  21 +++
 include/linux/mm.h                | 156 +++++++++++++++----
 include/linux/mm_types.h          |  52 +++++++
 include/linux/mmdebug.h           |  20 +++
 include/linux/netfs.h             |   2 +-
 include/linux/page-flags.h        | 120 +++++++++++---
 include/linux/pagemap.h           | 249 ++++++++++++++++++++++--------
 include/linux/swap.h              |   6 +
 include/linux/vmstat.h            | 107 +++++++++++++
 mm/Makefile                       |   2 +-
 mm/filemap.c                      | 237 ++++++++++++++--------------
 mm/folio-compat.c                 |  37 +++++
 mm/memory.c                       |   8 +-
 mm/page-writeback.c               |  62 ++++++--
 mm/swapfile.c                     |   8 +-
 mm/util.c                         |  30 ++--
 20 files changed, 857 insertions(+), 291 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

