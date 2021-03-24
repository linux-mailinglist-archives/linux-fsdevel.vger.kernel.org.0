Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E432347198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhCXGZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 02:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCXGZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:25:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E9C061763;
        Tue, 23 Mar 2021 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EbVFloTBByxI3X1rSuIw5BMaT+Jzn59Rgl4yrfYnCj0=; b=MOiE/XKDPXExEdtUrdbjH669Gy
        /6EPNa9xW4Nc7jM/r9794Mxlrb05H+OquYiN4E47aIZ/EevioYcxs3Na7ARzz1t1zXlf/Hy5M0zLX
        lDTswlCDjqDNA9NVnZnqTh8YjKh1oUt4HNyRHHFQwn8FLLd64RwX+S70iQGJor1ZzeBiRd8KqPhq6
        pJt5PS0uvwOmakAhJPbpRK+SJjfC6FIxL1CXmrwD0NLWW1bZ5VJ5eiHfc0w7isVm8zZanPHLYMhhD
        RDLFDe6cqfYlJa4qatVFZbtdlKQ7fKPtVnAjetpPGlCx6hR/5bYxW703YbYvinoGVzO5VIrowlnLZ
        xKzcTg7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOwwH-00B27t-Gd; Wed, 24 Mar 2021 06:24:29 +0000
Date:   Wed, 24 Mar 2021 06:24:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210324062421.GQ1719932@casper.infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFqH3B80Gn8pcPqB@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 08:29:16PM -0400, Johannes Weiner wrote:
> On Mon, Mar 22, 2021 at 06:47:44PM +0000, Matthew Wilcox wrote:
> > On Mon, Mar 22, 2021 at 01:59:24PM -0400, Johannes Weiner wrote:
> > > On Sat, Mar 20, 2021 at 05:40:37AM +0000, Matthew Wilcox (Oracle) wrote:
> > > > This series introduces the 'struct folio' as a replacement for
> > > > head-or-base pages.  This initial set reduces the kernel size by
> > > > approximately 6kB, although its real purpose is adding infrastructure
> > > > to enable further use of the folio.
> > > > 
> > > > The intent is to convert all filesystems and some device drivers to work
> > > > in terms of folios.  This series contains a lot of explicit conversions,
> > > > but it's important to realise it's removing a lot of implicit conversions
> > > > in some relatively hot paths.  There will be very few conversions from
> > > > folios when this work is completed; filesystems, the page cache, the
> > > > LRU and so on will generally only deal with folios.
> > > 
> > > If that is the case, shouldn't there in the long term only be very
> > > few, easy to review instances of things like compound_head(),
> > > PAGE_SIZE etc. deep in the heart of MM? And everybody else should 1)
> > > never see tail pages and 2) never assume a compile-time page size?
> > 
> > I don't know exactly where we get to eventually.  There are definitely
> > some aspects of the filesystem<->mm interface which are page-based
> > (eg ->fault needs to look up the exact page, regardless of its
> > head/tail/base nature), while ->readpage needs to talk in terms of
> > folios.
> 
> I can imagine we'd eventually want fault handlers that can also fill
> in larger chunks of data if the file is of the right size and the MM
> is able to (and policy/heuristics determine to) go with a huge page.

Oh yes, me too!

The way I think this works is that the VM asks for the specific
page, just as it does today and the ->fault handler returns the page.
Then the VM looks up the folio for that page, and asks the arch to map
the entire folio.  How the arch does that is up to the arch -- if it's
PMD sized and aligned, it can do that; if the arch knows that it should
use 8 consecutive PTE entries to map 32KiB all at once, it can do that.

But I think we need the ->fault handler to return the specific page,
because that's how we can figure out whether this folio is mapped at the
appropriate alignment to make this work.  If the fault handler returns
the folio, I don't think we can figure out if the alignment is correct.
Maybe we can for the page cache, but a device driver might have a compound
page allocated for its own purposes, and it might not be amenable to
the same rules as the page cache.

> > https://git.infradead.org/users/willy/pagecache.git/commitdiff/047e9185dc146b18f56c6df0b49fe798f1805c7b
> > 
> > It deals mostly in terms of folios, but when it needs to kmap() and
> > memcmp(), then it needs to work in terms of pages.  I don't think it's
> > avoidable (maybe we bury the "dealing with pages" inside a kmap()
> > wrapper somewhere, but I'm not sure that's better).
> 
> Yeah it'd be nice to get low-level, PAGE_SIZE pages out of there. We
> may be able to just kmap whole folios too, which are more likely to be
> small pages on highmem systems anyway.

I got told "no" when asking for kmap_local() of a compound page.
Maybe that's changeable, but I'm assuming that kmap() space will
continue to be tight for the foreseeable future (until we can
kill highmem forever).

> > > Some compound_head() that are currently in the codebase are already
> > > unnecessary. Like the one in activate_page().
> > 
> > Right!  And it's hard to find & remove them without very careful analysis,
> > or particularly deep knowledge.  With folios, we can remove them without
> > terribly deep thought.
> 
> True. It definitely also helps mark the places that have been
> converted from the top down and which ones haven't. Without that you
> need to think harder about the context ("How would a tail page even
> get here?" vs. "No page can get here, only folios" ;-))

Exactly!  Take a look at page_mkclean().  Its implementation strongly
suggests that it expects a head page, but I think it'll unmap a single
page if passed a tail page ... and it's not clear to me that isn't the
behaviour that pagecache_isize_extended() would prefer.  Tricky.

> > I mean, I already tried what you're suggesting.  It's really freaking
> > hard.  It's hard to do, it's hard to explain, it's hard to know if you
> > got it right.  With folios, I've got the compiler working for me, telling
> > me that I got some of the low-level bits right (or wrong), leaving me
> > free to notice "Oh, wait, we got the accounting wrong because writeback
> > assumes that a page is only PAGE_SIZE bytes".  I would _never_ have
> > noticed that with the THP tree.  I only noticed it because transitioning
> > things to folios made me read the writeback code and wonder about the
> > 'inc_wb_stat' call, see that it's measuring something in 'number of pages'
> > and realise that the wb_stat accounting needs to be fixed.
> 
> I agree with all of this whole-heartedly.
> 
> The reason I asked about who would deal with tail pages in the long
> term is because I think optimally most places would just think of
> these things as descriptors for variable lengths of memory. And only
> the allocator looks behind the curtain and deals with the (current!)
> reality that they're stitched together from fixed-size objects.
> 
> To me, folios seem to further highlight this implementation detail,
> more so than saying a page is now page_size() - although I readily
> accept that the latter didn't turn out to be a viable mid-term
> strategy in practice at all, and that a clean break is necessary
> sooner rather than later (instead of cleaning up the page api now and
> replacing the backing pages with struct hwpage or something later).
> 
> The name of the abstraction indicates how we think we're supposed to
> use it, what behavior stands out as undesirable.
> 
> For example, you brought up kmap/memcpy/usercopy, which is a pretty
> common operation. Should they continue to deal with individual tail
> pages, and thereby perpetuate the exposure of these low-level MM
> building blocks to drivers and filesystems?
> 
> It means portfolio -> page lookups will remain common - and certainly
> the concept of the folio suggests thinking of it as a couple of pages
> strung together. And the more this is the case, the less it stands out
> when somebody is dealing with low-level pages when really they
> shouldn't be - the thing this is trying to fix. Granted it's narrowing
> the channel quite a bit. But it's also so pervasively used that I do
> wonder if it's possible to keep up with creative new abuses.
> 
> But I also worry about the longevity of the concept in general. This
> is one of the most central and fundamental concepts in the kernel. Is
> this going to make sense in the future? In 5 years even?

One of the patches I haven't posted yet starts to try to deal with kmap()/mem*()/kunmap():

    mm: Add kmap_local_folio
    
    This allows us to map a portion of a folio.  Callers can only expect
    to access up to the next page boundary.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 7902c7d8b55f..55a29c9d562f 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -73,6 +73,12 @@ static inline void *kmap_local_page(struct page *page)
        return __kmap_local_page_prot(page, kmap_prot);
 }
 
+static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+{
+       struct page *page = &folio->page + offset / PAGE_SIZE;
+       return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
+}

Partly I haven't shared that one because I'm not 100% sure that 'byte
offset relative to start of folio' is the correct interface.  I'm looking
at some users and thinking that maybe 'byte offset relative to start
of file' might be better.  Or perhaps that's just filesystem-centric
thinking.

> > > The compile-time check is nice, but I'm not sure it would be that much
> > > more effective at catching things than a few centrally placed warns
> > > inside PageFoo(), get_page() etc. and other things that should not
> > > encounter tail pages in the first place (with __helpers for the few
> > > instances that do). And given the invasiveness of this change, they
> > > ought to be very drastically better at it, and obviously so, IMO.
> > 
> > We should have come up with a new type 15 years ago instead of doing THP.
> > But the second best time to invent a new type for "memory objects which
> > are at least as big as a page" is right now.  Because it only gets more
> > painful over time.
> 
> Yes and no.
> 
> Yes because I fully agree that too much detail of the pages have
> leaked into all kinds of places where they shouldn't be, and a new
> abstraction for what most places interact with is a good idea IMO.
> 
> But we're also headed in a direction with the VM that give me pause
> about the folios-are-multiple-pages abstraction.
> 
> How long are we going to have multiple pages behind a huge page?

Yes, that's a really good question.  I think Muchun Song's patches
are an interesting and practical way of freeing up memory _now_, but
long-term we'll need something different.  Maybe we end up with
dynamically allocated pages (perhaps when we break a 2MB page into
1MB pages in the buddy allocator).

> Common storage drives are getting fast enough that simple buffered IO
> workloads are becoming limited by CPU, just because it's too many
> individual pages to push through the cache. We have pending patches to
> rewrite the reclaim algorithm because rmap is falling apart with the
> rate of paging we're doing. We'll need larger pages in the VM not just
> for optimizing TLB access, but to cut transaction overhead for paging
> in general (I know you're already onboard with this, especially on the
> page cache side, just stating it for completeness).

yes, yes, yes and yes.  Dave Chinner produced a fantastic perf report
for me illustrating how kswapd and the page cache completely fall apart
under what must be a common streaming load.  Just create a file 2x the
size of memory, then cat it to /dev/null.  cat tries to allocate memory
in readahead and ends up contending on the i_pages lock with kswapd
who's trying to free pages from the LRU list one at a time.

Larger pages will help with that because more work gets done with each
lock acquisition, but I can't help but feel that the real solution is for
the page cache to notice that this is a streaming workload and have cat
eagerly recycle pages from this file.  That's a biggish project; we know
how many pages there are in this mapping, but how to know when to switch
from "allocate memory from the page allocator" to "just delete a page
from early in the file and reuse it at the current position inn the file"?

> But for that to work, we'll need the allocator to produce huge pages
> at the necessary rate, too. The current implementation likely won't
> scale. Compaction is expensive enough that we have to weigh when to
> allocate huge pages for long-lived anon regions, let alone allocate
> them for streaming IO cache entries.

Heh, I have that as a work item for later this year -- give the page
allocator per-cpu lists of compound pages, not just order-0 pages.
That'll save us turning compound pages back into buddy pages, only to
turn them into compound pages again.

I also have a feeling that the page allocator either needs to become a
sub-allocator of an allocator that deals in, say, 1GB chunks of memory,
or it needs to become reluctant to break up larger orders.  eg if the
dcache asks for just one more dentry, it should have to go through at
least one round of reclaim before we choose to break up a high-order
page to satisfy that request.

> But if the overwhelming number of requests going to the page allocator
> are larger than 4k pages - anon regions? check. page cache? likely a
> sizable share. slub? check. network? check - does it even make sense
> to have that as the default block size for the page allocator anymore?
> Or even allocate struct page at this granularity?

Yep, others have talked about that as well.  I think I may even have said
a few times at LSFMM, "What if we just make PAGE_SIZE 2MB?".  After all,
my first 386 Linux system was 4-8MB of RAM (it got upgraded).  The 16GB
laptop that I now have is 2048 times more RAM, so 4x the number of pages
that system had.

But people seem attached to being able to use smaller page sizes.
There's that pesky "compatibility" argument.

> So I think transitioning away from ye olde page is a great idea. I
> wonder this: have we mapped out the near future of the VM enough to
> say that the folio is the right abstraction?
> 
> What does 'folio' mean when it corresponds to either a single page or
> some slab-type object with no dedicated page?
> 
> If we go through with all the churn now anyway, IMO it makes at least
> sense to ditch all association and conceptual proximity to the
> hardware page or collections thereof. Simply say it's some length of
> memory, and keep thing-to-page translations out of the public API from
> the start. I mean, is there a good reason to keep this baggage?
> 
> mem_t or something.
> 
> mem = find_get_mem(mapping, offset);
> p = kmap(mem, offset - mem_file_offset(mem), len);
> copy_from_user(p, buf, len);
> kunmap(mem);
> SetMemDirty(mem);
> put_mem(mem);

I think there's still value to the "new thing" being a power of two
in size.  I'm not sure you were suggesting otherwise, but it's worth
putting on the table as something we explicitly agree on (or not!)

I mean what you've written there looks a _lot_ like where I get to
in the iomap code.

                status = iomap_write_begin(inode, pos, bytes, 0, &folio, iomap,
                                srcmap);
                if (unlikely(status))
                        break;

                if (mapping_writably_mapped(inode->i_mapping))
                        flush_dcache_folio(folio);

                /* We may be part-way through a folio */
                offset = offset_in_folio(folio, pos);
                copied = iov_iter_copy_from_user_atomic(folio, i, offset,
                                bytes);

                copied = iomap_write_end(inode, pos, bytes, copied, folio,
                                iomap, srcmap);
(which eventually calls TestSetFolioDirty)

It doesn't copy more than PAGE_SIZE bytes per iteration because
iov_iter_copy_from_user_atomic() isn't safe to do that yet.
But in *principle*, it should be able to.

> There are 10k instances of 'page' in mm/ outside the page allocator, a
> majority of which will be the new thing. 14k in fs. I don't think I
> have the strength to type shrink_folio_list(), or explain to new
> people what it means, years after it has stopped making sense.

One of the things I don't like about the current iteration of folio
is that getting to things is folio->page.mapping.  I think it does want
to be folio->mapping, and I'm playing around with this:

 struct folio {
-       struct page page;
+       union {
+               struct page page;
+               struct {
+                       unsigned long flags;
+                       struct list_head lru;
+                       struct address_space *mapping;
+                       pgoff_t index;
+                       unsigned long private;
+                       atomic_t _mapcount;
+                       atomic_t _refcount;
+               };
+       };
 };

+static inline void folio_build_bug(void)
+{
+#define FOLIO_MATCH(pg, fl)                                            \
+BUILD_BUG_ON(offsetof(struct page, pg) != offsetof(struct folio, fl));
+
+       FOLIO_MATCH(flags, flags);
+       FOLIO_MATCH(lru, lru);
+       FOLIO_MATCH(mapping, mapping);
+       FOLIO_MATCH(index, index);
+       FOLIO_MATCH(private, private);
+       FOLIO_MATCH(_mapcount, _mapcount);
+       FOLIO_MATCH(_refcount, _refcount);
+#undef FOLIO_MATCH
+       BUILD_BUG_ON(sizeof(struct page) != sizeof(struct folio));
+}

with the intent of eventually renaming page->mapping to page->__mapping
so people can't look at page->mapping on a tail page.  If we even have
tail pages eventually.  I could see a future where we have pte_to_pfn(),
pfn_to_folio() and are completely page-free (... the vm_fault would
presumably return a pfn instead of a page at that point ...).  But that's
too ambitious a project to succeed any time soon.

There's a lot of transitional stuff in these patches where I do
&folio->page.  I cringe a little every time I write that.

So yes, let's ask the question of "Is this the right short term, medium
term or long term approach?"  I think it is, at least in broad strokes.
Let's keep refining it.

Thanks for your contribution here; it's really useful.
