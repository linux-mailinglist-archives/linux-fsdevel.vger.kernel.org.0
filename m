Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B6423009
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 20:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhJEScu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 14:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJEScu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:32:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E5CC061749;
        Tue,  5 Oct 2021 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V4HWcJgm7yUTnESl6ofpu0d7c9zjVPFprc6gkyZV4S4=; b=uax2J7fWq5jqHUfAdY6GXcx8rw
        T/CLdz0fP4+xrIsb5qLH6Ofi1ijVl7uEQyAoxzrwQSqf7OgFWVBlZrG8KHQUeqzweIjJjxAw83VxF
        u2s80QBDolpETs3ESQkpBwfEeopfI7HzaHhNZBFMoXmFT038AMJSnxWxMSwCMdXyAwrsmFrn1U9gL
        htFJmnsWJjeN3Wnz23Ipvfi9RftmlPLuEmYNtG6lkJUMRbgFiSSCMTVddp3FMIrRLUkzz8UcMpIQN
        A3YixlSuHr0UMAA/E6xI7LBSUpxAG75/Mie5hlqWPzYaIHGm/YSp4CTKC5lD6n9ef+F3CHEvr6C+4
        0w6oUpjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXpCY-000A5a-E6; Tue, 05 Oct 2021 18:30:15 +0000
Date:   Tue, 5 Oct 2021 19:30:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YVyZruvGbGlNycSu@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YVxYgQa1cECYMtOL@casper.infradead.org>
 <YVyLh+bnZzNeQkyb@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVyLh+bnZzNeQkyb@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:29:43PM -0400, Johannes Weiner wrote:
> On Tue, Oct 05, 2021 at 02:52:01PM +0100, Matthew Wilcox wrote:
> > On Mon, Aug 23, 2021 at 05:26:41PM -0400, Johannes Weiner wrote:
> > > One one hand, the ambition appears to substitute folio for everything
> > > that could be a base page or a compound page even inside core MM
> > > code. Since there are very few places in the MM code that expressly
> > > deal with tail pages in the first place, this amounts to a conversion
> > > of most MM code - including the LRU management, reclaim, rmap,
> > > migrate, swap, page fault code etc. - away from "the page".
> > > 
> > > However, this far exceeds the goal of a better mm-fs interface. And
> > > the value proposition of a full MM-internal conversion, including
> > > e.g. the less exposed anon page handling, is much more nebulous. It's
> > > been proposed to leave anon pages out, but IMO to keep that direction
> > > maintainable, the folio would have to be translated to a page quite
> > > early when entering MM code, rather than propagating it inward, in
> > > order to avoid huge, massively overlapping page and folio APIs.
> > 
> > Here's an example where our current confusion between "any page"
> > and "head page" at least produces confusing behaviour, if not an
> > outright bug, isolate_migratepages_block():
> > 
> >                 page = pfn_to_page(low_pfn);
> > ...
> >                 if (PageCompound(page) && !cc->alloc_contig) {
> >                         const unsigned int order = compound_order(page);
> > 
> >                         if (likely(order < MAX_ORDER))
> >                                 low_pfn += (1UL << order) - 1;
> >                         goto isolate_fail;
> >                 }
> > 
> > compound_order() does not expect a tail page; it returns 0 unless it's
> > a head page.  I think what we actually want to do here is:
> > 
> > 		if (!cc->alloc_contig) {
> > 			struct page *head = compound_head(page);
> > 			if (PageHead(head)) {
> > 				const unsigned int order = compound_order(head);
> > 
> > 				low_pfn |= (1UL << order) - 1;
> > 				goto isolate_fail;
> > 			}
> > 		}
> > 
> > Not earth-shattering; not even necessarily a bug.  But it's an example
> > of the way the code reads is different from how the code is executed,
> > and that's potentially dangerous.  Having a different type for tail
> > and not-tail pages prevents the muddy thinking that can lead to
> > tail pages being passed to compound_order().
> 
> Thanks for digging this up. I agree the second version is much better.
> 
> My question is still whether the extensive folio whitelisting of
> everybody else is the best way to bring those codepaths to light.

Outside of core MM developers, I'm not sure that a lot of people
know that a struct page might represent 2^n pages of memory.  Even
architecture maintainers seem to be pretty fuzzy on what
flush_dcache_page() does for compound pages:
https://lore.kernel.org/linux-arch/20200818150736.GQ17456@casper.infradead.org/

I know this change is a massive pain, but I do think we're better off
in a world where 'struct page' really refers to one page of memory,
and we have some other name for a memory descriptor that refers to 2^n
pages of memory.

> The above isn't totally random. That code is a pfn walker which
> translates from the basepage address space to an ambiguous struct page
> object. There are more of those, but we can easily identify them: all
> uses of pfn_to_page() and virt_to_page() indicate that the code needs
> an audit for how exactly they're using the returned page.

Right; it's not random at all.  I ran across it while trying to work
out how zsmalloc interacts with memory compaction.  It just seemed like
a particularly compelling example because it's not part of some random
driver, it's a relatively important part of the MM.  And if such a place
has this kind of ambiguity, everything else must surely be worse.

> The above instance of such a walker wants to deal with a higher-level
> VM object: a thing that can be on the LRU, can be locked, etc. For
> those instances the pattern is clear that the pfn_to_page() always
> needs to be paired with a compound_head() before handling the page. I
> had mentioned in the other subthread a pfn_to_normal_page() to
> streamline this pattern, clarify intent, and mark the finished audit.
> 
> Another class are page table walkers resolving to an ambiguous struct
> page right now. Those are also easy to identify, and AFAICS they all
> want headpages, which is why I had mentioned a central compound_head()
> in vm_normal_page().
> 
> Are there other such classes that I'm missing? Because it seems to me
> there are two and they both have rather clear markers for where the
> disambiguation needs to happen - and central helpers to put them in!
> 
> And it makes sense: almost nobody *actually* needs to access the tail
> members of struct page. This suggests a pushdown and early filtering
> in a few central translation/lookup helpers would work to completely
> disambiguate remaining struct page usage inside MM code.

The end goal (before you started talking about shrinking memmap) was
to rename page->mapping, page->index, page->lru and page->private, so
you can't look at members of struct page any more.  struct page would
still have ->compound_head, but anythng else would require conversion
to folio first.

Now that you've put the "dynamically allocate the memory descriptor"
idea in my head, that rename becomes a deletion, and struct page
itself shrinks down to a single pointer.

> There *are* a few weird struct page usages left, like bio and sparse,
> and you mentioned vm_fault as well in the other subthread. But it
> really seems these want converting away from arbitrary struct page to
> either something like phys_addr_t or a proper headpage anyway. Maybe a
> tuple of headpage and subpage index in the fault case. Because even
> after a full folio conversion of everybody else, those would be quite
> weird in their use of an ambiguous struct page! Which struct members
> are safe to access? What does it mean to lock a tailpage? Etc.

If you think converting the MM from struct page to struct folio is bad,
a lot of churn, etc, you're going to be amazed at how much churn it'll be
to convert all of block and networking from struct page to phys_addr_t!
I'm not saying it's not worth doing, or it'll never be done, but that's
a five year project.  And I have no idea how to migrate to it gracefully.

> But it's possible I'm missing something. Are there entry points that
> are difficult to identify both conceptually and code-wise? And which
> couldn't be pushed down to resolve to headpages quite early? Those I
> think would make the argument for the folio in the MM implementation.

The approach I took with folio was to justify their appearance by
showing how they could remove all these hidden calls to compound_head().
So I went bottom-up.  Doing the slub conversion, I went in the opposite
direction; start out by converting the top layers from virt_to_head_page()
to use virt_to_slab().  Then simply call slab_page() when calling any
function which hasn't yet been converted.  At each step, we get better
and better type safety because every place that gets converted knows
it's being passed a head page and doesn't have to worry about whether
it might be passed a tail page.

Doing it in this direction doesn't let us remove the hidden calls to
compound_head() until the very end of the conversion, but people don't
seem to be particularly moved by all this wasted i-cache anyway.  I can
look at doing this for the page cache, but we kind of need agreement
that separating the types is where we're going, and what we're going to
end up calling both types.

Slab was easy; Bonwick decided what we were going to call the memory
descriptor ;-)
