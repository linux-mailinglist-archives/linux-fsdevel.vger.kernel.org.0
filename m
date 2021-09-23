Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7444155E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhIWDZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbhIWDZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:25:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E342C061574;
        Wed, 22 Sep 2021 20:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cdwGbJhCdZfPvbE5YQ9fHyZz3Nnu8LjufzhZ9sT+PUY=; b=dXqGLXI/tXcTdVyBCjx9XA641I
        uZK5/7s8XVsJwM3BneZXKjC3CddUAprDRfts74WJK/uVTUez/DfYXyyOg12bDBie6w15LiH8V8YkI
        1pt1Jj4rfrxiSRgGbmFH3RNG52LI8TXHn/hAwHOVEqwKU91JSmeN1VtPTsMtCn0z7mSJjrb2LixPP
        /xtTLjYjqfvVwCi/tl4RyPLVAOdSfno3e3I20pPUri3IeUfxvfyfUxwIZfUSe4G/o1OGT3u1Bglx1
        5DtGV8i98RZZo424RutJiNpXk1+eMuMX6Gt3Cj9xAKznYN1AUFsSxf9nzdf+kBxEoPPc2yORy+4eZ
        eHfezsfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTFKK-005TjG-3A; Thu, 23 Sep 2021 03:23:17 +0000
Date:   Thu, 23 Sep 2021 04:23:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YUvzINep9m7G0ust@casper.infradead.org>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUvWm6G16+ib+Wnb@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 09:21:31PM -0400, Kent Overstreet wrote:
> The fundamental reason for struct page is that we need memory to be self
> describing, without any context - we need to be able to go from a generic
> untyped struct page and figure out what it contains: handling physical memory
> failure is the most prominent example, but migration and compaction are more
> common. We need to be able to ask the thing that owns a page of memory "hey,
> stop using this and move your stuff here".

Yup, and another thing we need is to take any page mapped to userspace
and mark it as dirty (whatever that means for the owner of the page).

> Matthew's helpfully been coming up with a list of page types:
> https://kernelnewbies.org/MemoryTypes
> 
> But struct page could be a lot smaller than it is now. I think we can get it
> down to two pointers, which means it'll take up 0.4% of system memory. Both
> Matthew and Johannes have ideas for getting it down even further - the main
> thing to note is that virt_to_page() _should_ be an uncommon operation (most of
> the places we're currently using it are completely unnecessary, look at all the
> places we're using it on the zero page). Johannes is thinking two layer radix
> tree, Matthew was thinking about using maple trees - personally, I think that
> 0.4% of system memory is plenty good enough.

As with a lot of these future plans, I think the details can vary
slightly.  What I propose on the above wiki page is to take it
down to one pointer per page, but yes, I have a dream that eventually we
can take it down to one pointer + size per allocation (so 16 bytes)
rather than 16 bytes per page.

> Ok, but what do we do with the stuff currently in struct page?
> -------------------------------------------------------------
> 
> The main thing to note is that since in normal operation most folios are going
> to be describing many pages, not just one - and we'll be using _less_ memory
> overall if we allocate them separately. That's cool.
> 
> Of course, for this to make sense, we'll have to get all the other stuff in
> struct page moved into their own types, but file & anon pages are the big one,
> and that's already being tackled.

We can also allocate a far larger structure.  eg, we might decide that
a file page looks like this:

struct folio {
    unsigned long flags;
    unsigned long pfn;
    struct list_head lru;
    struct address_space *mapping;
    pgoff_t index;
    void *private;
    atomic_t _mapcount;
    atomic_t _refcount;
#ifdef CONFIG_MEMCG
    unsigned long memcg_data;
#endif
    unsigned char dtor;
    unsigned char order;
    atomic_t hmapcount;
    unsigned int nr_pages;
    atomic_t hpinned_count;
    struct list_head deferred_list;
};

(compiling that list reminds me that we'll need to sort out mapcount
on subpages when it comes time to do this.  ask me if you don't know
what i'm talking about here.)

> Why two ulongs/pointers, instead of just one?
> ---------------------------------------------
> 
> Because one of the things we really want and don't have now is a clean division
> between allocator and allocatee state. Allocator meaning either the buddy
> allocator or slab, allocatee state would be the folio or the network pool state
> or whatever actually called kmalloc() or alloc_pages().
> 
> Right now slab state sits in the same place in struct page where allocatee state
> does, and the reason this is bad is that slab/slub are a hell of a lot faster
> than the buddy allocator, and Johannes wants to move the boundary between slab
> allocations and buddy allocator allocations up to like 64k. If we fix where slab
> state lives, this will become completely trivial to do.
> 
> So if we have this:
> 
> struct page {
> 	unsigned long	allocator;
> 	unsigned long	allocatee;
> };
> 
> The allocator field would be used for either a pointer to slab/slub's state, if
> it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> allocation - like compound order today, and probably whether or not the
> (compound group of) pages is free.
> 
> The allocatee field would be used for a type tagged (using the low bits of the
> pointer) to one of:
>  - struct folio
>  - struct anon_folio, if that becomes a thing
>  - struct network_pool_page
>  - struct pte_page
>  - struct zone_device_page

I think we /can/ do all this.  I don't know that it's the right thing to
do.  And I really mean that.  I genuinely don't know that "allocate
file pages from slab" will solve any problems at all.  And I kind of
don't want to investigate that until later.

By the way, another way we could do this is to put the 'allocator'
field into the allocatee's data structure.  eg the first word
in struct folio could point to the struct slab that contains it.

> Other notes & potential issues:
>  - page->compound_dtor needs to die

The reason we have it right now is that the last person to call
put_page() may not be the one who allocated it.  _maybe_ we can do
all-of-the-dtor-stuff when the person who allocates it frees it, and
have put_page() only free the memory.  TBD.

>  - page->rcu_head moves into the types that actually need it, no issues there

Hope so!

>  - page->refcount has question marks around it. I think we can also just move it
>    into the types that need it; with RCU derefing the pointer to the folio or
>    whatever and grabing a ref on folio->refcount can happen under a RCU read
>    lock - there's no real question about whether it's technically possible to
>    get it out of struct page, and I think it would be cleaner overall that way.
> 
>    However, depending on how it's used from code paths that go from generic
>    untyped pages, I could see it turning into more of a hassle than it's worth.
>    More investigation is needed.

I think this depends how far we go splitting everything apart.

>  - page->memcg_data - I don't know whether that one more properly belongs in
>    struct page or in the page subtypes - I'd love it if Johannes could talk
>    about that one.

Johannes certainly knows more about this than I do.  I think it's needed
for anon folios, file folios and slab, but maybe it's needed for page
tables too?

>  - page->flags - dealing with this is going to be a huge hassle but also where
>    we'll find some of the biggest gains in overall sanity and readability of the
>    code. Right now, PG_locked is super special and ad hoc and I have run into
>    situations multiple times (and Johannes was in vehement agreement on this
>    one) where I simply could not figure the behaviour of the current code re:
>    who is responsible for locking pages without instrumenting the code with
>    assertions.
> 
>    Meaning anything we do to create and enforce module boundaries between
>    different chunks of code is going to suck, but the end result should be
>    really worthwhile.
> 
> Matthew Wilcox and David Howells have been having conversations on IRC about
> what to do about other page bits. It appears we should be able to kill a lot of
> filesystem usage of both PG_private and PG_private_2 - filesystems in general
> hang state off of page->private, soon to be folio->private, and PG_private in
> current use just indicates whether page->private is nonzero - meaning it's
> completely redundant.

Also I want to kill PG_error.  PG_slab and PG_hwpoison become page
types (in the "allocatee" field in your parlance).  PG_head goes away
naturally.

Something we don't have to talk about right now is that there's no reason
several non-contiguous pages can't have the same 'allocatee' value.
I'm thinking that every page allocated to a given vmalloc allocation
would point to the same vm_struct.  So I'm thinking that the way all of
the above would work is we'd allocate a "struct folio" from slab, then
pass the (tagged) pointer to alloc_pages().  alloc_pages() would fill
in the 'allocatee' pointer for each of the struct pages with whatever
pointer it is given.

There's probably a bunch of holes in the above handwaving, but I'm
pretty confident we can fill them.
