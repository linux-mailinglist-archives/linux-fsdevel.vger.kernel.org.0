Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03F935A632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 20:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhDISwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:52:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA26C061762;
        Fri,  9 Apr 2021 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TDIZgvFzcR8K+/11qdOXTve6vu0rmbO7Ks3X0/fN77U=; b=KJFOLYi0ZE+WZeegWTt6hz9W4v
        KHj43VCXgDh2ol5c8nd+GLXv+XTxRJoXVe8nyp8VVEm8zuE905cFzy1IpruGyiKJa1x2UOZSFNP3w
        NfJWobLEsPhECUJOwsVxBbIbJhY7LYXyWmQfTnUbTMnGxJGMqFA43PfFVJukM21PUEsksUsXsTEff
        OtNciHkYTN8DbvF3vc2Mi+cnNWLvsbshTNEn0LlE4bHtG/cFvhWCg1Y/RfU2ms9zcxsqMIlU2JYkX
        MtetiSxyc+wOXc7mgFQjh0bZiHnZdSUiyE6JBI98qUhiiVgjt3wCQq0GKeA0c/syARfSgA5cL1VB2
        ORZNe0hA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwDi-000mzc-DV; Fri, 09 Apr 2021 18:51:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v7 00/28] Memory Folios
Date:   Fri,  9 Apr 2021 19:50:37 +0100
Message-Id: <20210409185105.188284-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
benefit from a larger "page size".  As an example, an earlier iteration
of this idea which used compound pages (and wasn't particularly tuned)
got a 7% performance boost when compiling the kernel.

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

We also waste a lot of instructions ensuring that we're not looking at
a tail page.  Almost every call to PageFoo() contains one or more hidden
calls to compound_head().  This also happens for get_page(), put_page()
and many more functions.  There does not appear to be a way to tell gcc
that it can cache the result of compound_head(), nor is there a way to
tell it that compound_head() is idempotent.

This series introduces the 'struct folio' as a replacement for
head-or-base pages.  This initial set reduces the kernel size by
approximately 6kB by removing conversions from tail pages to head pages.
The real purpose of this series is adding infrastructure to enable
further use of the folio.

The medium-term goal is to convert all filesystems and some device
drivers to work in terms of folios.  This series contains a lot of
explicit conversions, but it's important to realise it's removing a lot
of implicit conversions in some relatively hot paths.  There will be very
few conversions from folios when this work is completed; filesystems,
the page cache, the LRU and so on will generally only deal with folios.

I analysed the text size reduction using a config based on Oracle UEK
with all modules changed to built-in.  That's obviously not a kernel
which makes sense to run, but it serves to compare the effects on (many
common) filesystems & drivers, not just the core.

add/remove: 33652/33642 grow/shrink: 1799/1955 up/down: 895792/-901770 (-5978)

For a "just the core" comparison, here's an allnoconfig comparison:
add/remove: 201/197 grow/shrink: 9/29 up/down: 7523/-8797 (-1274)

Current tree at:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

(contains another ~100 patches on top of this batch, not all of which are
in good shape for submission)

v7:
 - Rebase on next-20210409
   - keep up with afs changes
   - wait_on_page_fscache() no longer needs to be modified
   - unlock_page_private_2() changed to end_page_private_2()
   - wait_on_page_private_2() is new
   - wait_on_page_private_2_killable() is new
 - Optimise nth_page() instead of avoiding it (Christoph, Kirill)
 - Use nth_page() in folio_file_page()
 - Use static_assert() for FOLIO_MATCH (Rasmus)
 - Add a FOLIO_MATCH that lru and compound_head are at the same offset
 - Make page_count() use folio_ref_count() instead of page_ref_count()
v6:
 - Rebase on next-20210330
   - wait_bit_key patch merged by Linus
   - wait_on_page_writeback_killable() patches merged by Linus
   - Documentation patch merged by Andrew
 - Move folio_next_index() into this series
 - Move folio_offset() and folio_file_offset() into this series
 - Mirror members of struct page (for pagecache / anon) into struct folio,
   so (eg) you can use folio->mapping instead of folio->page.mapping
 - Add folio_ref_* functions, including kernel-doc for folio_ref_count().
 - Add count_memcg_folio_event()
 - Add put_folio_testzero()
 - Add folio_mapcount()
 - Add FolioKsm()
 - Fix afs_page_mkwrite() compilation
 - Fix/improve kernel-doc for
   - struct folio
   - add_folio_wait_queue()
   - wait_for_stable_folio()
   - wait_on_folio_writeback()
   - wait_on_folio_writeback_killable()
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

Matthew Wilcox (Oracle) (28):
  mm: Optimise nth_page for contiguous memmap
  mm: Introduce struct folio
  mm: Add folio_pgdat and folio_zone
  mm/vmstat: Add functions to account folio statistics
  mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
  mm: Add folio reference count functions
  mm: Add put_folio
  mm: Add get_folio
  mm: Create FolioFlags
  mm: Handle per-folio private data
  mm/filemap: Add folio_index, folio_file_page and folio_contains
  mm/filemap: Add folio_next_index
  mm/filemap: Add folio_offset and folio_file_offset
  mm/util: Add folio_mapping and folio_file_mapping
  mm: Add folio_mapcount
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

 Documentation/core-api/mm-api.rst |   3 +
 fs/afs/write.c                    |   9 +-
 fs/cachefiles/rdwr.c              |  16 +-
 fs/io_uring.c                     |   2 +-
 include/linux/memcontrol.h        |  30 ++++
 include/linux/mm.h                | 177 ++++++++++++++++----
 include/linux/mm_types.h          |  96 +++++++++++
 include/linux/mmdebug.h           |  20 +++
 include/linux/page-flags.h        | 130 +++++++++++---
 include/linux/page_ref.h          |  88 +++++++++-
 include/linux/pagemap.h           | 270 ++++++++++++++++++++++--------
 include/linux/swap.h              |   6 +
 include/linux/vmstat.h            | 107 ++++++++++++
 mm/Makefile                       |   2 +-
 mm/filemap.c                      | 256 ++++++++++++++--------------
 mm/folio-compat.c                 |  37 ++++
 mm/memory.c                       |   8 +-
 mm/page-writeback.c               |  72 +++++---
 mm/swapfile.c                     |   8 +-
 mm/util.c                         |  30 ++--
 20 files changed, 1056 insertions(+), 311 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

