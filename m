Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D736B3FBC4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhH3SZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbhH3SZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:25:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17FC0617A8;
        Mon, 30 Aug 2021 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qFsHsk6AyJLgCY4KMOK4CQBK1/TyhhbrC84aarSuCoM=; b=K0CGUsgB6cXBq/GMuqmkJ7OFlm
        2eP4ou1xcM9VX8gkbGOPDinAmPcwPQhVxyA+VUovkLmzwvbt3xUe5OrRMFqtD2Coi0hlUvq2MC4PT
        hJU5mUw20jETjrc7oNf59TetDuJCHFtqlEVwpEMLWN+PcWlC1OcqDdUOsRxjzwrWBrLkAEqa04GeE
        xM6MdeFVLkdONh+310fVcN1QHghYq9V9PIw4Hfai4wIRyivwBjZUQNPARFeWmk8jfIgYem1LpyT7o
        CRzIP3PybQe5yeb6SxwxXPb8t2sFAu6epo9esDaZR5cx1A3P4MoXmUvTj3zfH26u0NZWkj8l3mV/c
        cghSiFIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKlvN-000Pkf-DY; Mon, 30 Aug 2021 18:22:36 +0000
Date:   Mon, 30 Aug 2021 19:22:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YS0h4cFhwYoW3MBI@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org>
 <YS0WR38gCSrd6r41@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0WR38gCSrd6r41@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 01:32:55PM -0400, Johannes Weiner wrote:
> A lot of DC hosts nowadays are in a direct pipeline for handling user
> requests, which are highly parallelizable.
> 
> They are much smaller, and there are a lot more of them than there are
> VMs in the world. The per-request and per-host margins are thinner,
> and the compute-to-memory ratio is more finely calibrated than when
> you're renting out large VMs that don't neatly divide up the machine.
> 
> Right now, we're averaging ~1G of RAM per CPU thread for most of our
> hosts. You don't need a very large system - certainly not in the TB
> ballpark - where struct page takes up the memory budget of entire CPU
> threads. So now we have to spec memory for it, and spend additional
> capex and watts, or we'll end up leaving those CPU threads stranded.

So you're noticing at the level of a 64 thread machine (something like
a dual-socket Xeon Gold 5318H, which would have 2x18x2 = 72 threads).
Things certainly have changed, then.

> > The mistake you're making is coupling "minimum mapping granularity" with
> > "minimum allocation granularity".  We can happily build a system which
> > only allocates memory on 2MB boundaries and yet lets you map that memory
> > to userspace in 4kB granules.
> 
> Yeah, but I want to do it without allocating 4k granule descriptors
> statically at boot time for the entirety of available memory.

Even that is possible when bumping the PAGE_SIZE to 16kB.  It needs a
bit of fiddling:

static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
                        unsigned long addr, struct page *page, pgprot_t prot)
{
        if (!pte_none(*pte))
                return -EBUSY;
        /* Ok, finally just insert the thing.. */
        get_page(page);
        inc_mm_counter_fast(mm, mm_counter_file(page));
        page_add_file_rmap(page, false);
        set_pte_at(mm, addr, pte, mk_pte(page, prot));
        return 0;
}

mk_pte() assumes that a struct page refers to a single pte.  If we
revamped it to take (page, offset, prot), it could construct the
appropriate pte for the offset within that page.

---

Independent of _that_, the biggest problem we face (I think) in getting
rid of memmap is that it offers the pfn_to_page() lookup.  If we move to a
dynamically allocated descriptor for our arbitrarily-sized memory objects,
we need a tree to store them in.  Given the trees we currently have,
our best bet is probably the radix tree, but I dislike its glass jaws.
I'm hoping that (again) the maple tree becomes stable soon enough for
us to dynamically allocate memory descriptors and store them in it.
And that we don't discover a bootstrapping problem between kmalloc()
(for tree nodes) and memmap (to look up the page associated with a node).

But that's all a future problem and if we can't even take a first step
to decouple filesystems from struct page then working towards that would
be wasted effort.

> > > Willy says he has future ideas to make compound pages scale. But we
> > > have years of history saying this is incredibly hard to achieve - and
> > > it certainly wasn't for a lack of constant trying.
> > 
> > I genuinely don't understand.  We have five primary users of memory
> > in Linux (once we're in a steady state after boot):
> > 
> >  - Anonymous memory
> >  - File-backed memory
> >  - Slab
> >  - Network buffers
> >  - Page tables
> > 
> > The relative importance of each one very much depends on your workload.
> > Slab already uses medium order pages and can be made to use larger.
> > Folios should give us large allocations of file-backed memory and
> > eventually anonymous memory.  Network buffers seem to be headed towards
> > larger allocations too.  Page tables will need some more thought, but
> > once we're no longer interleaving file cache pages, anon pages and
> > page tables, they become less of a problem to deal with.
> > 
> > Once everybody's allocating order-4 pages, order-4 pages become easy
> > to allocate.  When everybody's allocating order-0 pages, order-4 pages
> > require the right 16 pages to come available, and that's really freaking
> > hard.
> 
> Well yes, once (and iff) everybody is doing that. But for the
> foreseeable future we're expecting to stay in a world where the
> *majority* of memory is in larger chunks, while we continue to see 4k
> cache entries, anon pages, and corresponding ptes, yes?

No.  4k page table entries are demanded by the architecture, and there's
little we can do about that.  We can allocate them in larger chunks, but
let's not solve that problem in this email.  I can see a world where
anon memory is managed (by default, opportunistically) in larger
chunks within a year.  Maybe six months if somebody really works hard
on it.

> Memory is dominated by larger allocations from the main workloads, but
> we'll continue to have a base system that does logging, package
> upgrades, IPC stuff, has small config files, small libraries, small
> executables. It'll be a while until we can raise the floor on those
> much smaller allocations - if ever.
> 
> So we need a system to manage them living side by side.
> 
> The slab allocator has proven to be an excellent solution to this
> problem, because the mailing lists are not flooded with OOM reports
> where smaller allocations fragmented the 4k page space. And even large
> temporary slab explosions (inodes, dentries etc.) are usually pushed
> back with fairly reasonable CPU overhead.

You may not see the bug reports, but they exist.  Right now, we have
a service that is echoing 2 to drop_caches every hour on systems which
are lightly loaded, otherwise the dcache swamps the entire machine and
takes hours or days to come back under control.

