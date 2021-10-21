Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956D6436CD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 23:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhJUVkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhJUVkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:40:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB80C061348
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 14:37:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id v17so1879966qtp.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C3gPRy4fqW6DBMilgxjMkABzP0CVm5ps4cOoNNcXRmM=;
        b=ojz/MM+18C4Z3vk1Id4SmVl0qOd573+bSxgt2VnrOiMb0t/v0eUQSGJns3Ua7xWI/N
         nPNH4jgDSu1/sDNG56sfaYsjXNxzN3fd/Iv6xcZqk5jZ+NaCaeq3qoEYdxsyb4ADubSv
         pJtnTv7W6P/LMrUX4WJ5nk997vUb5wx9ypcRic1xFo+zgNEZPkO+M868UbReG1Oe0NAQ
         gGl7VbfQ5lzvsEYctwegqoLmtoeezqkb9znoVvoR1jA3rc3/V4T/zbmnuwohRETBEEDd
         xi9mczGolFm51G/MSgesfJH3wMAE2NuZihgeGhvAwaktrs6WPG/dUI7O89a80Yx+B4Ej
         AUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C3gPRy4fqW6DBMilgxjMkABzP0CVm5ps4cOoNNcXRmM=;
        b=PgoVbC7oGzriM3VZ2N/IHc/dTeVq9mG1m9wXgc0p7a72OEOm/M6ou1uzeK+Wo2B7v4
         nkRut56OBbMIXpvk7BHzVFSUpHKpiWT0t+Yu8GGNQds6L5lKBZH2vsLHlCWCPPsrX+p+
         6YSX2YLtj7+Q7hjcwfbYW8yLLfoP19wrlcZY7UAXRQW5yIxCuiZRHdYV+P0Ir3F1DBys
         1EPhTll991JwjMpiz/Djd1fRC/xsxvgfIh/+vHrFS3yJT5X41Lay3bRXO0NaQiHJwiiS
         iLDVxZ94S1w32GT/t607ZNW8PD18tVnfsYUkgCx/4pTRIgOhKEj/Ff5tdV3TD4fwOmHw
         r3SA==
X-Gm-Message-State: AOAM531Lbcx/Le5hUasWwFMtDpy4tRXXFz2xJefG9tcpEHEq+sqXrXoA
        fvjMtUoqXZp2LQ8BeWHB+P5KMpPrbvJkjw==
X-Google-Smtp-Source: ABdhPJx4C4gBI9dZVJ/a3IiXPZlfzg1bNJ4Q+x2X10sZknZV2xuHN0rxTnwZ1bL6r73hFghX7zIMOQ==
X-Received: by 2002:ac8:1e95:: with SMTP id c21mr9074020qtm.412.1634852263329;
        Thu, 21 Oct 2021 14:37:43 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id m16sm3379967qkn.15.2021.10.21.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:37:42 -0700 (PDT)
Date:   Thu, 21 Oct 2021 17:37:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXHdpQTL1Udz48fc@cmpxchg.org>
References: <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXBUPguecSeSO6UD@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 01:39:10PM -0400, Kent Overstreet wrote:
> Thank you for at least (belatedly) voicing your appreciation of the struct slab
> patches, that much wasn't at all clear to me or Matthew during the initial
> discussion.

The first sentence I wrote in response to that series is:

	"I like this whole patch series, but I think for memcg this is
	 a particularly nice cleanup."

	- https://lore.kernel.org/all/YWRwrka5h4Q5buca@cmpxchg.org/

The second email I wrote started with:

	"This looks great to me. It's a huge step in disentangling
	 struct page, and it's already showing very cool downstream
	 effects in somewhat unexpected places like the memory cgroup
	 controller."

	- https://lore.kernel.org/all/YWSZctm%2F2yxu19BV@cmpxchg.org/

Then I sent a pageflag cleanup series specifically to help improve the
clarity of the struct slab split a bit.

Truly ambiguous stuff..?

> > I only hoped we could do the same for file pages first, learn from
> > that, and then do anon pages; if they come out looking the same in the
> > process, a unified folio would be a great trailing refactoring step.
> > 
> > But alas here we are months later at the same impasse with the same
> > open questions, and still talking in circles about speculative code.
> > I don't have more time to invest into this, and I'm tired of the
> > vitriol and ad-hominems both in public and in private channels.
> > 
> > I'm not really sure how to exit this. The reasons for my NAK are still
> > there. But I will no longer argue or stand in the way of the patches.
> 
> Johannes, what I gathered from the meeting on Friday is that all you seem to
> care about at this point is whether or not file and anonymous pages are the same
> type.

No.

I'm going to bow out because - as the above confirms again - the
communication around these patches is utterly broken. But I'm not
leaving on a misrepresentation of my stance after having spent months
thinking about these patches and their implications.

Here is my summary of the discussion, and my conclusion:

The premise of the folio was initially to simply be a type that says:
I'm the headpage for one or more pages. Never a tailpage. Cool.

However, after we talked about what that actually means, we seem to
have some consensus on the following:

	1) If folio is to be a generic headpage, it'll be the new
	   dumping ground for slab, network, drivers etc. Nobody is
	   psyched about this, hence the idea to split the page into
	   subtypes which already resulted in the struct slab patches.

	2) If higher-order allocations are going to be the norm, it's
	   wasteful to statically allocate full descriptors at a 4k
	   granularity. Hence the push to eliminate overloading and do
	   on-demand allocation of necessary descriptor space.

I think that's accurate, but for the record: is there anybody who
disagrees with this and insists that struct folio should continue to
be the dumping ground for all kinds of memory types?

Let's assume the answer is "no" for now and move on.

If folios are NOT the common headpage type, it begs two questions:

	1) What subtype(s) of page SHOULD it represent?

	   This is somewhat unclear at this time. Some say file+anon.
	   It's also been suggested everything userspace-mappable, but
	   that would again bring back major type punning. Who knows?

	   Vocal proponents of the folio type have made conflicting
	   statements on this, which certainly gives me pause.

	2) What IS the common type used for attributes and code shared
	   between subtypes?

	   For example: if a folio is anon+file, then the code that
           maps memory to userspace needs a generic type in order to
           map both folios and network pages. Same as the page table
           walkers, and things like GUP.

	   Will this common type be struct page? Something new? Are we
	   going to duplicate the implementation for each subtype?

	   Another example: GUP can return tailpages. I don't see how
	   it could return folio with even its most generic definition
	   of "headpage".

(But bottomline, it's not clear how folio can be the universal
headpage type and simultaneously avoid being the type dumping ground
that the page was. Maybe I'm not creative enough?)

Anyway. I can even be convinved that we can figure out the exact fault
lines along which we split the page down the road.

My worry is more about 2). A shared type and generic code is likely to
emerge regardless of how we split it. Think about it, the only world
in which that isn't true would be one in which either

	a) page subtypes are all the same, or
	b) the subtypes have nothing in common

and both are clearly bogus.

I think we're being overly dismissive of this question. It seems to me
that *the core challenge* in splitting out the various subtypes of
struct page is to properly identify the generic domain and private
domains of the subtypes, and then clearly and consistently implement
boundaries! If this isn't a deliberate effort, things will get messy
and confusing quickly. These boundary quirks were the first thing that
showed up in the struct slab patches, and finding a clean and
intuitive fix didn't seem trivial to agree on (to my own surprise.)

So. All of the above leads me to these conclusions:

Once you acknowledge the need for a shared abstraction layer, forcing
a binary choice between anon and file doesn't make sense: they have
some stuff in common, and some stuff is different. Some code can be
shared naturally, some cannot. This isn't unlike the VFS inode and the
various fs-specific inode types. It's a chance for the code to finally
reflect the sizable but incomplete overlap of the two.

And once you need a model for generic and private attributes and code
anyway, doing just file at first - even if it isn't along a substruct
boundary - becomes a more reasonable, smaller step for splitting
things out of the page. Just the fs interface and page cache bits, as
opposed to also reclaim, lru, migration, memcg, all at once.

Obviously, because it's a smaller step, it won't go as far toward
shrinking struct page and separately allocatable descriptors. But it
also doesn't work against that effort. And there are still a ton of
bootstrapping questions around separately allocating descriptors
anyway. So it strikes me as an acceptable tradeoff for now.

There is something else that the smaller step would be great for:
doing file first would force us to properly deal with the generic vs
private domain delineation, and come up with a sound strategy for it.
With private file code and shared anon/file code. And it would do so
inside a much smaller and deliberate changeset, where we could give it
the proper attention. As opposed to letting it emerge ad-hoc and
drowning out the case-by-case decisions in huge, churny series.

So that's my ACTUAL stance.

(For completeness, here are the other considerations I mentioned in
the past: I don't think compound page allocations are a good path to
larger page sizes, based on the THP experience at FB, Google's THP
experience, and testimony from other people who have worked on
fragmentation and compaction; but I'm willing to punt on that pending
more data. I also don't think the head/tailpage question is
interesting enough to make it the central identity of the object we're
passing around MM code. Or that we need a new type to get rid of bogus
compound_head() calls. But whatever at this point.)

Counterarguments I've heard to the above:

Wouldn't a generic struct page layer eat into the goal of shrinking
struct page down to two words? Well sure, but if all that's left in it
at the end is a pointer, a list_head and some flags used by every
subtype, we've done pretty well on that front. It's all tradeoffs.
Also, way too many cornercases to be thinking in absolutes already.

Would it give up type safety in the LRU code? Not really, if all
additions are through typed headpages. We don't need to worry about
tailpages in that code, the same way we don't need to check
PageReserved() in there: there is no plausible route for such pages.

Don't you want tailpage safety in anon code? I'm not against that, but
it's not like the current folio patches provide it. They just set up a
direction (without MM consensus). Either way, it'd happen later on.

Why are my eyes glazing over when I read all this? Well, mine glazed
over writing all this. struct page is a lot of stuff, and IMO these
patches touch too much of it at once.

Anyway, that's my exhaustive take on things.
