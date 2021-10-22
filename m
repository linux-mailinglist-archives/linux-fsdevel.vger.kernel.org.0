Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2A436F9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJVB51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhJVB5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:57:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C335C061764;
        Thu, 21 Oct 2021 18:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ilx0zbyzZLhr0hRRhN8lPrtWYLabYtK6tA2ooR2rQbg=; b=AfZvMEHCjf6DYVQJQpimkLZ9yh
        juDGKSXPuAyWo/tJ9ABzFSb5BMr22gLiLCKsMCWF/JHUTegq6zl6CA3bhiVxwC5GU1eVhMywzzkCM
        /BwylOV2foW8mKZ50Us6JO1vVr9E223FIk4HqBRDMojK/6vqbKxy+H/xQBe/+wFqdsD5HFjhiWFhz
        KNYnX+iY9WUeuN3I7KghFoRlOaU6+6LGjuHVGumEx9bLlL/v346NXlROVQ3NqUNuMVvjf0l/qirKx
        4CzBSaP/fgPJkUpHIc0vRcgMOtLBMw3mn2EV8n6Wgd+fvQJpFZOrH3EsyBn9ufnB2SrgLklMp5K8+
        j8JyzPkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdjjT-00DdbW-Je; Fri, 22 Oct 2021 01:52:51 +0000
Date:   Fri, 22 Oct 2021 02:52:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXIZX0truEBv2YSz@casper.infradead.org>
References: <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXHdpQTL1Udz48fc@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 05:37:41PM -0400, Johannes Weiner wrote:
> Here is my summary of the discussion, and my conclusion:

Thank you for this.  It's the clearest, most useful post on this thread,
including my own.  It really highlights the substantial points that
should be discussed.

> The premise of the folio was initially to simply be a type that says:
> I'm the headpage for one or more pages. Never a tailpage. Cool.
> 
> However, after we talked about what that actually means, we seem to
> have some consensus on the following:
> 
> 	1) If folio is to be a generic headpage, it'll be the new
> 	   dumping ground for slab, network, drivers etc. Nobody is
> 	   psyched about this, hence the idea to split the page into
> 	   subtypes which already resulted in the struct slab patches.
> 
> 	2) If higher-order allocations are going to be the norm, it's
> 	   wasteful to statically allocate full descriptors at a 4k
> 	   granularity. Hence the push to eliminate overloading and do
> 	   on-demand allocation of necessary descriptor space.
> 
> I think that's accurate, but for the record: is there anybody who
> disagrees with this and insists that struct folio should continue to
> be the dumping ground for all kinds of memory types?

I think there's a useful distinction to be drawn between "where we're
going with this patchset", "where we're going in the next six-twelve
months" and "where we're going eventually".  I think we have minor
differences of opinion on the answers to those questions, and they can
be resolved as we go, instead of up-front.

My answer to that question is that, while this full conversion is not
part of this patch, struct folio is logically:

struct folio {
	... almost everything that's currently in struct page ...
};

struct page {
    unsigned long flags;
    unsigned long compound_head;
    union {
        struct { /* First tail page only */
            unsigned char compound_dtor;
            unsigned char compound_order;
            atomic_t compound_mapcount;
            unsigned int compound_nr;
        };
        struct { /* Second tail page only */
            atomic_t hpage_pinned_refcount;
            struct list_head deferred_list;
        };
        unsigned long padding1[4];
    };
    unsigned int padding2[2];
#ifdef CONFIG_MEMCG
    unsigned long padding3;
#endif
#ifdef WANT_PAGE_VIRTUAL
    void *virtual;
#endif
#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
    int _last_cpupid;
#endif
};

(I'm open to being told I have some of that wrong, eg maybe _last_cpupid
is actually part of struct folio and isn't a per-page property at all)

I'd like to get there in the next year.  I think dynamically allocating
memory descriptors is more than a year out.

Now, as far as struct folio being a dumping group, I would like to
split other things out from struct folio.  Let me address that below.

> Let's assume the answer is "no" for now and move on.
> 
> If folios are NOT the common headpage type, it begs two questions:
> 
> 	1) What subtype(s) of page SHOULD it represent?
> 
> 	   This is somewhat unclear at this time. Some say file+anon.
> 	   It's also been suggested everything userspace-mappable, but
> 	   that would again bring back major type punning. Who knows?
> 
> 	   Vocal proponents of the folio type have made conflicting
> 	   statements on this, which certainly gives me pause.
> 
> 	2) What IS the common type used for attributes and code shared
> 	   between subtypes?
> 
> 	   For example: if a folio is anon+file, then the code that
>            maps memory to userspace needs a generic type in order to
>            map both folios and network pages. Same as the page table
>            walkers, and things like GUP.
> 
> 	   Will this common type be struct page? Something new? Are we
> 	   going to duplicate the implementation for each subtype?
> 
> 	   Another example: GUP can return tailpages. I don't see how
> 	   it could return folio with even its most generic definition
> 	   of "headpage".
> 
> (But bottomline, it's not clear how folio can be the universal
> headpage type and simultaneously avoid being the type dumping ground
> that the page was. Maybe I'm not creative enough?)

This whole section is predicated on "If it is NOT the headpage type",
but I think this is a great list of why it _should_ be the generic
headpage type.

To answer a questions in here; GUP should continue to return precise
pages because that's what its callers expect.  But we should have a
better interface than GUP which returns a rather more compressed list
(something like today's biovec).

> Anyway. I can even be convinved that we can figure out the exact fault
> lines along which we split the page down the road.
> 
> My worry is more about 2). A shared type and generic code is likely to
> emerge regardless of how we split it. Think about it, the only world
> in which that isn't true would be one in which either
> 
> 	a) page subtypes are all the same, or
> 	b) the subtypes have nothing in common
> 
> and both are clearly bogus.

Amen!

I'm convinced that pgtable, slab and zsmalloc uses of struct page can all
be split out into their own types instead of being folios.  They have
little-to-nothing in common with anon+file; they can't be mapped into
userspace and they can't be on the LRU.  The only situation you can find
them in is something like compaction which walks PFNs.

I don't think we can split out ZONE_DEVICE and netpool into their own
types.  While they can't be on the LRU, they can be mapped to userspace,
like random device drivers.  So they can be found by GUP, and we want
(need) to be able to go to folio from there in order to get, lock and
set a folio as dirty.  Also, they have a mapcount as well as a refcount.

The real question, I think, is whether it's worth splitting anon & file
pages out from generic pages.  I can see arguments for it, but I can also
see arguments against it (whether it's two types: lru_mem and folio,
three types: anon_mem, file_mem and folio or even four types: ksm_mem,
anon_mem and file_mem).  I don't think a compelling argument has been
made either way.

Perhaps you could comment on how you'd see separate anon_mem and
file_mem types working for the memcg code?  Would you want to have
separate lock_anon_memcg() and lock_file_memcg(), or would you want
them to be cast to a common type like lock_folio_memcg()?

P.S. One variant we haven't explored is separating type specialisation
from finding the head page.  eg, instead of having

struct slab *slab = page_slab(page);

we could have:

struct slab *slab = folio_slab(page_folio(page));

I don't think it's particularly worth doing, but Kent mused about it
at one point.
