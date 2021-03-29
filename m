Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB234D59E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC2Q7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhC2Q7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:59:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DD9C061574;
        Mon, 29 Mar 2021 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a1/gckG0R0lxWG+xUAHM791jOnFfFKGW4A+MjC93kxs=; b=S58sz8AIZxdzJ95Pez327TxYVr
        /aqkcOHbecjHrpGW/NsCpPTjoZ6HcS9j2D5AdeiRBQDju2u1dXwSD1ZzTd01tIAbw3XGaJj7exZ5w
        tB9wjqVgMgcJWYlDxp52ooyI9bvAo3SQiXdsWjFqJldR60UoQUjkothTt7UBpdyishT9FiBhToYJn
        IUfbnMD8dLpzMiGRVbtjXqGwtgdiu/imjGp4qmEPsIIc5wQ6rGcokXyEAfgw0clrt5XzMqmDvCbfI
        jw+qDAMzFfZmQPppG4/MefOK1KlakaUrtgSpTp7jIrEGHZ0j3uayV3XMUC0S8rG0iif+KvVbfJXKE
        Qa696SQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQvDk-001r6L-RG; Mon, 29 Mar 2021 16:58:38 +0000
Date:   Mon, 29 Mar 2021 17:58:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210329165832.GG351017@casper.infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF4eX/VBPLmontA+@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm going to respond to some points in detail below, but there are a
couple of overarching themes that I want to bring out up here.

Grand Vision
~~~~~~~~~~~~

I haven't outlined my long-term plan.  Partly because it is a _very_
long way off, and partly because I think what I'm doing stands on its
own.  But some of the points below bear on this, so I'll do it now.

Eventually, I want to make struct page optional for allocations.  It's too
small for some things (allocating page tables, for example), and overly
large for others (allocating a 2MB page, networking page_pool).  I don't
want to change its size in the meantime; having a struct page refer to
PAGE_SIZE bytes is something that's quite deeply baked in.

In broad strokes, I think that having a Power Of Two Allocator
with Descriptor (POTAD) is a useful foundational allocator to have.
The specific allocator that we call the buddy allocator is very clever for
the 1990s, but touches too many cachelines to be good with today's CPUs.
The generalisation of the buddy allocator to the POTAD lets us allocate
smaller quantities (eg a 512 byte block) and allocate descriptors which
differ in size from a struct page.  For an extreme example, see xfs_buf
which is 360 bytes and is the descriptor for an allocation between 512
and 65536 bytes.

There are times when we need to get from the physical address to
the descriptor, eg memory-failure.c or get_user_pages().  This is the
equivalent of phys_to_page(), and it's going to have to be a lookup tree.
I think this is a role for the Maple Tree, but it's not ready yet.
I don't know if it'll be fast enough for this case.  There's also the
need (particularly for memory-failure) to determine exactly what kind
of descriptor we're dealing with, and also its size.  Even its owner,
so we can notify them of memory failure.

There's still a role for the slab allocator, eg allocating objects
which aren't a power of two, or allocating things for which the user
doesn't need a descriptor of its own.  We can even keep the 'alloc_page'
interface around; it's just a specialisation of the POTAD.

Anyway, there's a lot of work here, and I'm sure there are many holes
to be poked in it, but eventually I want the concept of tail pages to
go away, and for pages to become not-the-unit of memory management in
Linux any more.

Naming
~~~~~~

The fun thing about the word folio is that it actually has several
meanings.  Quoting wikipedia,

: it is firstly a term for a common method of arranging sheets of paper
: into book form, folding the sheet only once, and a term for a book
: made in this way; secondly it is a general term for a sheet, leaf or
: page in (especially) manuscripts and old books; and thirdly it is an
: approximate term for the size of a book, and for a book of this size.

So while it is a collection of pages in the first sense, in the second
sense it's also its own term for a "sheet, leaf or page".  I (still)
don't insist on the word folio, but I do insist that it be _a_ word.
The word "slab" was a great coin by Bonwick -- it didn't really mean
anything in the context of memory before he used it, and now we all know
exactly what it means.  I just don't want us to end up with

struct uma { /* unit of memory allocation */

We could choose another (short, not-used-in-kernel) word almost at random.
How about 'kerb'?


What I haven't touched on anywhere in this, is whether a folio is the
descriptor for all POTA or whether it's specifically the page cache
descriptor.  I like the idea of having separate descriptors for objects
in the page cache from anonymous or other allocations.  But I'm not very
familiar with the rmap code, and that wants to do things like manipulate
the refcount on a descriptor without knowing whether it's a file or
anon page.  Or neither (eg device driver memory mapped to userspace.
Or vmalloc memory mapped to userspace.  Or ...)

We could get terribly carried away with this ...

struct mappable { /* any mappable object must be LRU */
	struct list_head lru;
	int refcount;
	int mapcount;
};

struct folio { /* for page cache */
	unsigned long flags;
	struct mappable map;
	struct address_space *mapping;
	pgoff_t index;
	void *private;
};

struct quarto { /* for anon pages */
	unsigned long flags;
	struct mappable map;
	swp_entry_t swp;
	struct anon_vma *vma;
};

but I'm not sure we want to go there.

On Fri, Mar 26, 2021 at 01:48:15PM -0400, Johannes Weiner wrote:
> On Wed, Mar 24, 2021 at 06:24:21AM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 23, 2021 at 08:29:16PM -0400, Johannes Weiner wrote:
> > > On Mon, Mar 22, 2021 at 06:47:44PM +0000, Matthew Wilcox wrote:
> > > > On Mon, Mar 22, 2021 at 01:59:24PM -0400, Johannes Weiner wrote:
> > One of the patches I haven't posted yet starts to try to deal with kmap()/mem*()/kunmap():
> > 
> >     mm: Add kmap_local_folio
> >     
> >     This allows us to map a portion of a folio.  Callers can only expect
> >     to access up to the next page boundary.
> >     
> >     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> > index 7902c7d8b55f..55a29c9d562f 100644
> > --- a/include/linux/highmem-internal.h
> > +++ b/include/linux/highmem-internal.h
> > @@ -73,6 +73,12 @@ static inline void *kmap_local_page(struct page *page)
> >         return __kmap_local_page_prot(page, kmap_prot);
> >  }
> >  
> > +static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> > +{
> > +       struct page *page = &folio->page + offset / PAGE_SIZE;
> > +       return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
> > +}
> > 
> > Partly I haven't shared that one because I'm not 100% sure that 'byte
> > offset relative to start of folio' is the correct interface.  I'm looking
> > at some users and thinking that maybe 'byte offset relative to start
> > of file' might be better.  Or perhaps that's just filesystem-centric
> > thinking.
> 
> Right, this doesn't seem specific to files just because they would be
> the primary users of it.

Yeah.  I think I forgot to cc you on this:

https://lore.kernel.org/linux-fsdevel/20210325032202.GS1719932@casper.infradead.org/

and "byte offset relative to the start of the folio" works just fine:

+	offset = offset_in_folio(folio, diter->pos);
+
+map:
+	diter->entry = kmap_local_folio(folio, offset);

> > > But for that to work, we'll need the allocator to produce huge pages
> > > at the necessary rate, too. The current implementation likely won't
> > > scale. Compaction is expensive enough that we have to weigh when to
> > > allocate huge pages for long-lived anon regions, let alone allocate
> > > them for streaming IO cache entries.
> > 
> > Heh, I have that as a work item for later this year -- give the page
> > allocator per-cpu lists of compound pages, not just order-0 pages.
> > That'll save us turning compound pages back into buddy pages, only to
> > turn them into compound pages again.
> > 
> > I also have a feeling that the page allocator either needs to become a
> > sub-allocator of an allocator that deals in, say, 1GB chunks of memory,
> > or it needs to become reluctant to break up larger orders.  eg if the
> > dcache asks for just one more dentry, it should have to go through at
> > least one round of reclaim before we choose to break up a high-order
> > page to satisfy that request.
> 
> Slub already allocates higher-order pages for dentries:
> 
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> dentry            133350 133350    192   42    2 : tunables    0    0    0 : slabdata   3175   3175      0
> 
>                                                ^ here
> 
> and it could avoid even more internal fragmentation with bigger
> orders. It only doesn't because of the overhead of allocating them.

Oh, yes.  Sorry, I didn't explain myself properly.  If we have a
lightly-loaded system with terabytes of memory (perhaps all the jobs
it is running are CPU intensive and don't need much memory), the system
has a tendency to clog up with negative dentries.  Hundreds of millions
of them.  We rely on memory pressure to get rid of them, and when there
finally is memory pressure, it takes literally hours.

If there were a slight amount of pressure to trim the dcache at the point
when we'd otherwise break up an order-4 page to get an order-2 page,
the system would work much better.  Obviously, we do want the dcache to
be able to expand to the point where it's useful, but at the point that
it's no longer useful, we need to trim it.

It'd probably be better to have the dcache realise that its old entries
aren't useful any more and age them out instead of relying on memory
pressure to remove old entries, so this is probably an unnecessary
digression.

> If the default block size in the allocator were 2M, we'd also get slab
> packing at that granularity, and we wouldn't have to worry about small
> objects breaking huge pages any more than we worry about slab objects
> fragmenting 4k pages today.

Yup.  I definitely see the attraction of letting the slab allocator
allocate in larger units.  On the other hand, you have to start worrying
about underutilisation of the memory at _some_ size, and I'd argue the
sweet spot is somewhere between 4kB and 2MB today.  For example:

fat_inode_cache      110    110    744   22    4 : tunables    0    0    0 : slabdata      5      5      0

That's currently using 20 pages.  If slab were only allocating 2MB slabs
from the page allocator, I'd have 1.9MB of ram unused in that cache.

> > But people seem attached to being able to use smaller page sizes.
> > There's that pesky "compatibility" argument.
> 
> Right, that's why I'm NOT saying we should eliminate the support for
> 4k chunks in the page cache and page tables. That's still useful if
> you have lots of small files.
> 
> I'm just saying it doesn't have to be the default that everything is
> primarily optimized for. We can make the default allocation size of
> the allocator correspond to a hugepage and have a secondary allocator
> level for 4k chunks. Like slab, but fixed-size and highmem-aware.
> 
> It makes sense to make struct page 2M as well. It would save a ton of
> memory on average and reduce the pressure we have on struct page's
> size today.
> 
> And we really don't need struct page at 4k just to support this unit
> of paging when necesary: page tables don't care, they use pfns and can
> point to any 4k offset, struct page or no struct page. For the page
> cache, we can move mapping, index, lru. etc from today's struct page
> into an entry descriptor that could either sit in a native 2M struct
> page (just like today), or be be allocated on demand and point into a
> chunked struct page. Same for <2M anonymous mappings.
> 
> Hey, didn't you just move EXACTLY those fields into the folio? ;)

You say page tables don't actually need a struct page, but we do use it.

                struct {        /* Page table pages */
                        unsigned long _pt_pad_1;        /* compound_head */
                        pgtable_t pmd_huge_pte; /* protected by page->ptl */
                        unsigned long _pt_pad_2;        /* mapping */
                        union {
                                struct mm_struct *pt_mm; /* x86 pgds only */
                                atomic_t pt_frag_refcount; /* powerpc */
                        };
#if ALLOC_SPLIT_PTLOCKS
                        spinlock_t *ptl;
#else
                        spinlock_t ptl;
#endif
                };

It's a problem because some architectures would really rather
allocate 2KiB page tables (s390) or would like to support 4KiB page
tables on a 64KiB base page size kernel (ppc).

[actually i misread your comment initially; you meant that page
tables point to PFNs and don't care what struct backs them ... i'm
leaving this in here because it illustrates a problem with change
struct-page-size-to-2MB]

