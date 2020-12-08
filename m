Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE62D33B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgLHUXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgLHUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D315C0611CC;
        Tue,  8 Dec 2020 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x0Gl08yi5khxjYomH67zvoI/GsRD4GlN848WKInaPcA=; b=FS4zhdZ+oQPcbr31iUheqnbM+j
        sto/2JoafZGhBs7N+5ObjYCBua49pmkvF/xJybc9bEuB4t6F6rL5WGhkAqHdD1znQMF4gy4y/cH7R
        3nLh2i5bbFrsk+FTm0dLh3HuRg7NmmU7qOQhVdpvgqOqSTd8ZvOC3tQPMcL2YN6nzcRy8GOC0cqEF
        X2Ru2z3A4eLRVk7h0beVb9PpjCoko7mmiMsuALNyRPpLivKVhBDVmDSJ+GdCK5fc7d8rT7ZZw/Pl0
        iZiLu4B6rWrB4Qs4Jh24QprFYi0812md7gxgxMr/pL1bOJISrEFEEl/tzhwHwXmQbMnCoT9Go9PVr
        +3ikHMnw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwr-000508-E8; Tue, 08 Dec 2020 19:46:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/11] Page folios
Date:   Tue,  8 Dec 2020 19:46:42 +0000
Message-Id: <20201208194653.19180-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the great things about compound pages is that when you try to
do various operations on a tail page, it redirects to the head page and
everything Just Works.  One of the awful things is how much we pay for
that simplicity.  Here's an example, end_page_writeback():

        if (PageReclaim(page)) {
                ClearPageReclaim(page);
                rotate_reclaimable_page(page);
        }
        get_page(page);
        if (!test_clear_page_writeback(page))
                BUG();

        smp_mb__after_atomic();
        wake_up_page(page, PG_writeback);
        put_page(page);

That all looks very straightforward, but if you dive into the disassembly,
you see that there are four calls to compound_head() in this function
(PageReclaim(), ClearPageReclaim(), get_page() and put_page()).  It's
all for nothing, because if anyone does call this routine with a tail
page, wake_up_page() will VM_BUG_ON_PGFLAGS(PageTail(page), page).

I'm not really a CPU person, but I imagine there's some kind of dependency
here that sucks too:

    1fd7:       48 8b 57 08             mov    0x8(%rdi),%rdx
    1fdb:       48 8d 42 ff             lea    -0x1(%rdx),%rax
    1fdf:       83 e2 01                and    $0x1,%edx
    1fe2:       48 0f 44 c7             cmove  %rdi,%rax
    1fe6:       f0 80 60 02 fb          lock andb $0xfb,0x2(%rax)

Sure, it's going to be cache hot, but that cmove is going to have
to execute before the lock andb.

I would like to introduce a new concept that I call a Page Folio.
Or just struct folio to its friends.  Here it is,

struct folio {
        struct page page;
};

A folio is a struct page which is guaranteed not to be a tail page.
So it's either a head page or a base (order-0) page.  That means
we don't have to call compound_head() on it and we save massively.
end_page_writeback() reduces from four calls to compound_head() to just
one (at the beginning of the function) and it shrinks from 213 bytes
to 126 bytes (using the UEK config options).  I think even that one
can be eliminated, but I'm going slowly at this point and taking the
safe route of transforming a random struct page pointer into a struct
folio pointer by calling page_folio().  By the end of this exercise,
end_page_writeback() will become end_folio_writeback().

This is going to be a ton of work, and massively disruptive.  It'll touch
every filesystem, and a good few device drivers!  But I think it's worth
it.  Not every routine benefits as much as end_page_writeback(), but it
makes everything a little better.  At 29 bytes per call to lock_page(),
unlock_page(), put_page() and get_page(), that's on the order of 60kB of
text for allyesconfig.  More when you add on all the PageFoo() calls.
With the small amount of work I've done here, mm/filemap.o shrinks by
almost a kilobyte from 34007 to 33072.

But better than that, it's good documentation.  A function which has a
struct page argument might be expecting a head or base page and will
BUG if given a tail page.  It might work with any kind of page and
operate on PAGE_SIZE bytes.  It might work with any kind of page and
operate on page_size() bytes if given a head page but PAGE_SIZE bytes
if given a base or tail page.  It might operate on page_size() bytes
if passed a head or tail page.  We have examples of all of these today.
If a function takes a folio argument, it's operating on the entire folio.

The first seven patches introduce some of the new infrastructure we'll
need, then the last four are examples of converting functions to use
folios.  Eventually, we'll be able to convert some of the PageFoo flags
to be only available as FolioFoo flags.

I have a Zoom call this Friday at 18:00 UTC (13:00 Eastern,
10:00 Pacific, 03:00 Tokyo, 05:00 Sydney, 19:00 Berlin).
Meeting ID: 960 8868 8749, passcode 2097152
Feel free to join if you want to talk about this.

Matthew Wilcox (Oracle) (11):
  mm: Introduce struct folio
  mm: Add put_folio
  mm: Add get_folio
  mm: Create FolioFlags
  mm: Add unlock_folio
  mm: Add lock_folio
  mm: Add lock_folio_killable
  mm/filemap: Convert end_page_writeback to use a folio
  mm/filemap: Convert mapping_get_entry and pagecache_get_page to folio
  mm/filemap: Add folio_add_to_page_cache
  mm/swap: Convert rotate_reclaimable_page to folio

 include/linux/mm.h         |  36 ++++---
 include/linux/mm_types.h   |  17 ++++
 include/linux/page-flags.h |  36 ++++++-
 include/linux/pagemap.h    |  63 +++++++++---
 include/linux/swap.h       |   1 -
 mm/filemap.c               | 198 ++++++++++++++++++-------------------
 mm/internal.h              |   1 +
 mm/page_io.c               |   4 +-
 mm/swap.c                  |  12 +--
 9 files changed, 231 insertions(+), 137 deletions(-)

-- 
2.29.2

