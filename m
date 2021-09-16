Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA12B40D1D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 04:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhIPDAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 23:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhIPDAO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 23:00:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AB8E61178;
        Thu, 16 Sep 2021 02:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631761135;
        bh=BIDj86b7GdqEi75480/vY4WhdAcfCvujeZlC9eBNPKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DA7HCRVoesuIX5BhtALZZGSnJtBqtQR139vRVY3x4NWvE4JMRqXDaRPM3/aKH+WqQ
         rdOQkFq9+AEEKMC3gz/DaCkcReGw65fhta0CG/N5qtVNaDSTIfoa3n+u2W47F7C/mT
         xt/zlF+rNnQT6+VQ6yImDp6inpLdLiyuFDk0sNsj1FlWbI4AIgEVijZfV9ugZDkghD
         sdOGrmHJFAne/HwVMSl/4TZqo3TflPA/Ey4DPO/GPZkFPfyx/p7c3pgx5wO58T4mcQ
         TUmrnHPkv40IhQqDhWsakVy5p35dIlGr30f67BQfkCOafYXo5iXalbW1QpYVs/xaQ7
         TKJpjpnbJ6rkw==
Date:   Wed, 15 Sep 2021 19:58:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210916025854.GE34899@magnolia>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUIT2/xXwvZ4IErc@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:40:11AM -0400, Johannes Weiner wrote:
> On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> > One particularly noteworthy idea was having struct page refer to
> > multiple hardware pages, and using slab/slub for larger
> > alloctions. In my view, the primary reason for making this change
> > isn't the memory overhead to struct page (though reducing that would
> > be nice);
> 
> Don't underestimate this, however.
> 
> Picture the near future Willy describes, where we don't bump struct
> page size yet but serve most cache with compound huge pages.
> 
> On x86, it would mean that the average page cache entry has 512
> mapping pointers, 512 index members, 512 private pointers, 1024 LRU
> list pointers, 512 dirty flags, 512 writeback flags, 512 uptodate
> flags, 512 memcg pointers etc. - you get the idea.
> 
> This is a ton of memory. I think this doesn't get more traction
> because it's memory we've always allocated, and we're simply more
> sensitive to regressions than long-standing pain. But nevertheless
> this is a pretty low-hanging fruit.
> 
> The folio makes a great first step moving those into a separate data
> structure, opening the door to one day realizing these savings. Even
> when some MM folks say this was never the intent behind the patches, I
> think this is going to matter significantly, if not more so, later on.

So ... I chatted with Kent the other day, who suggested to me that maybe
the point you're really after is that you want to increase the hw page
size to reduce overhead while retaining the ability to hand out parts of
those larger pages to the page cache, and folios don't get us there?

> > Fortunately, Matthew made a big step in the right direction by making folios a
> > new type. Right now, struct folio is not separately allocated - it's just
> > unionized/overlayed with struct page - but perhaps in the future they could be
> > separately allocated. I don't think that is a remotely realistic goal for _this_
> > patch series given the amount of code that touches struct page (thing: writeback
> > code, LRU list code, page fault handlers!) - but I think that's a goal we could
> > keep in mind going forward.
> 
> Yeah, agreed. Not doable out of the gate, but retaining the ability to
> allocate the "cache entry descriptor" bits - mapping, index etc. -
> on-demand would be a huge benefit down the road for the above reason.
> 
> For that they would have to be in - and stay in - their own type.
> 
> > We should also be clear on what _exactly_ folios are for, so they don't become
> > the new dumping ground for everyone to stash their crap. They're to be a new
> > core abstraction, and we should endeaver to keep our core data structures
> > _small_, and _simple_.
> 
> Right. struct page is a lot of things and anything but simple and
> obvious today. struct folio in its current state does a good job
> separating some of that stuff out.
> 
> However, when we think about *which* of the struct page mess the folio
> wants to address, I think that bias toward recent pain over much
> bigger long-standing pain strikes again.
> 
> The compound page proliferation is new, and we're sensitive to the
> ambiguity it created between head and tail pages. It's added some
> compound_head() in lower-level accessor functions that are not
> necessary for many contexts. The folio type safety will help clean
> that up, and this is great.
> 
> However, there is a much bigger, systematic type ambiguity in the MM
> world that we've just gotten used to over the years: anon vs file vs
> shmem vs slab vs ...
> 
> - Many places rely on context to say "if we get here, it must be
>   anon/file", and then unsafely access overloaded member elements:
>   page->mapping, PG_readahead, PG_swapcache, PG_private
> 
> - On the other hand, we also have low-level accessor functions that
>   disambiguate the type and impose checks on contexts that may or may
>   not actually need them - not unlike compound_head() in PageActive():
> 
>   struct address_space *folio_mapping(struct folio *folio)
>   {
> 	struct address_space *mapping;
> 
> 	/* This happens if someone calls flush_dcache_page on slab page */
> 	if (unlikely(folio_test_slab(folio)))
> 		return NULL;
> 
> 	if (unlikely(folio_test_swapcache(folio)))
> 		return swap_address_space(folio_swap_entry(folio));
> 
> 	mapping = folio->mapping;
> 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
> 		return NULL;
> 
> 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
>   }
> 
>   Then we go identify places that say "we know it's at least not a
>   slab page!" and convert them to page_mapping_file() which IS safe to
>   use with anon. Or we say "we know this MUST be a file page" and just
>   access the (unsafe) mapping pointer directly.
> 
> - We have a singular page lock, but what it guards depends on what
>   type of page we're dealing with. For a cache page it protects
>   uptodate and the mapping. For an anon page it protects swap state.
> 
>   A lot of us can remember the rules if we try, but the code doesn't
>   help and it gets really tricky when dealing with multiple types of
>   pages simultaneously. Even mature code like reclaim just serializes
>   the operation instead of protecting data - the writeback checks and
>   the page table reference tests don't seem to need page lock.
> 
>   When the cgroup folks wrote the initial memory controller, they just
>   added their own page-scope lock to protect page->memcg even though
>   the page lock would have covered what it needed.
> 
> - shrink_page_list() uses page_mapping() in the first half of the
>   function to tell whether the page is anon or file, but halfway
>   through we do this:
> 
> 	  /* Adding to swap updated mapping */
>           mapping = page_mapping(page);
> 
>   and then use PageAnon() to disambiguate the page type.
> 
> - At activate_locked:, we check PG_swapcache directly on the page and
>   rely on it doing the right thing for anon, file, and shmem pages.
>   But this flag is PG_owner_priv_1 and actually used by the filesystem
>   for something else. I guess PG_checked pages currently don't make it
>   this far in reclaim, or we'd crash somewhere in try_to_free_swap().
> 
>   I suppose we're also never calling page_mapping() on PageChecked
>   filesystem pages right now, because it would return a swap mapping
>   before testing whether this is a file page. You know, because shmem.

(Yes, it would be helpful to fix these ambiguities, because I feel like
discussions about all these other non-pagecache uses of memory keep
coming up on fsdevel and the code /really/ doesn't help me figure out
what everyone's talking about before the discussion moves on...)

> These are just a few examples from an MM perspective. I'm sure the FS
> folks have their own stories and examples about pitfalls in dealing
> with struct page members.

We do, and I thought we were making good progress pushing a lot of that
into the fs/iomap/ library.  With fs iomap, disk filesystems pass space
mapping data to the iomap functions and let them deal with pages (or
folios).  IOWs, filesystems don't deal with pages directly anymore, and
folios sounded like an easy transition (for a filesystem) to whatever
comes next.  At some point it would be nice to get fscrypt and fsverify
hooked up so that we could move ext4 further off of buffer heads.

I don't know how we proceed from here -- there's quite a bit of
filesystems work that depended on the folios series actually landing.
Given that Linus has neither pulled it, rejected it, or told willy what
to do, and the folio series now has a NAK on it, I can't even start on
how to proceed from here.

--D

> We're so used to this that we don't realize how much bigger and
> pervasive this lack of typing is than the compound page thing.
> 
> I'm not saying the compound page mess isn't worth fixing. It is.
> 
> I'm saying if we started with a file page or cache entry abstraction
> we'd solve not only the huge page cache, but also set us up for a MUCH
> more comprehensive cleanup in MM code and MM/FS interaction that makes
> the tailpage cleanup pale in comparison. For the same amount of churn,
> since folio would also touch all of these places.
