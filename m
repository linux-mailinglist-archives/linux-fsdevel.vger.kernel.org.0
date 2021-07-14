Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C393C7B34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 03:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhGNB62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 21:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbhGNB62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:58:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC3C0613DD;
        Tue, 13 Jul 2021 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Ip3TBvUfjZRsOcT+hgS0o0GXh0afk99oSwV3nbjP1c=; b=eTTB/6RxmN+yTTQe5iKEdBvKTF
        2mfzJM3XsKao86MCSITohbwpp0HIyDoIYdLRI6GBbf8irM5vD5DQRhjCgrgK8gmIoUYfsgsLBExcD
        jvaQW54RfIIpAP9ATmybg8AE1m7MvqTRbFtLeEje76WXe2bwZbmLIDqH2zyslVEz8lbLJsjqOGOPv
        w7vNFXsjbbaSm1mgmxIAVD/Bl4XYKck1id9cd85MMmrfd7J/Iq7HzVo26h4Y2arHi+sW4uxLDw4AF
        7w4yo2lb+nOTxessQF8hs75P7neKxoKr4UJqm6ZtVVohuXtrNa1wQOeND2gvwwu9pAibLcQMj4xsH
        f3tkg1RQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3U77-001jGC-PW; Wed, 14 Jul 2021 01:55:09 +0000
Date:   Wed, 14 Jul 2021 02:55:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v13 010/137] mm: Add folio flag manipulation functions
Message-ID: <YO5D+XX06TA7CQ6e@casper.infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
 <20210712030701.4000097-11-willy@infradead.org>
 <YOzdKYejOEUbjvMj@cmpxchg.org>
 <YOz3Lms9pcsHPKLt@casper.infradead.org>
 <20210713091533.GB4132@worktop.programming.kicks-ass.net>
 <YO23WOUhhZtL6Gtn@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO23WOUhhZtL6Gtn@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 11:55:04AM -0400, Johannes Weiner wrote:
> On Tue, Jul 13, 2021 at 11:15:33AM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 13, 2021 at 03:15:10AM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 12, 2021 at 08:24:09PM -0400, Johannes Weiner wrote:
> > > > On Mon, Jul 12, 2021 at 04:04:54AM +0100, Matthew Wilcox (Oracle) wrote:
> > > > > +/* Whether there are one or multiple pages in a folio */
> > > > > +static inline bool folio_single(struct folio *folio)
> > > > > +{
> > > > > +	return !folio_head(folio);
> > > > > +}
> > > > 
> > > > Reading more converted code in the series, I keep tripping over the
> > > > new non-camelcased flag testers.
> > > 
> > > Added PeterZ as he asked for it.
> > > 
> > > https://lore.kernel.org/linux-mm/20210419135528.GC2531743@casper.infradead.org/
> > 
> > Aye; I hate me some Camels with a passion. And Linux Coding style
> > explicitly not having Camels these things were always a sore spot. I'm
> > very glad to see them go.
> > 
> > > > It's not an issue when it's adjectives: folio_uptodate(),
> > > > folio_referenced(), folio_locked() etc. - those are obvious. But nouns
> > > > and words that overlap with struct member names can easily be confused
> > > > with non-bool accessors and lookups. Pop quiz: flag test or accessor?
> > > > 
> > > > folio_private()
> > > > folio_lru()
> > > > folio_nid()
> > > > folio_head()
> > > > folio_mapping()
> > > > folio_slab()
> > > > folio_waiters()
> > > 
> > > I know the answers to each of those, but your point is valid.  So what's
> > > your preferred alternative?  folio_is_lru(), folio_is_uptodate(),
> > > folio_is_slab(), etc?  I've seen suggestions for folio_test_lru(),
> > > folio_test_uptodate(), and I don't much care for that alternative.
> > 
> > Either _is_ or _test_ works for me, with a slight preference to _is_ on
> > account it of being shorter.
> 
> I agree that _is_ reads nicer by itself, but paired with other ops
> such as testset, _test_ might be better.
> 
> For example, in __set_page_dirty_no_writeback()
> 
> 	if (folio_is_dirty())
> 		return !folio_testset_dirty()
> 
> is less clear about what's going on than would be:
> 
> 	if (folio_test_dirty())
> 		return !folio_testset_dirty()
> 
> My other example wasn't quoted, but IMO set and clear naming should
> also match testing to not cause confusion. I.e. the current:
> 
> 	if (folio_idle())
> 		folio_clear_idle_flag()
> 
> can make you think two different things are being tested and modified
> (as in if (page_evictable()) ClearPageUnevictable()). IMO easier:
> 
> 	if (folio_test_idle())
> 		folio_clear_idle()
> 
> Non-atomics would have the __ modifier in front of folio rather than
> read __clear or __set, which works I suppose?
> 
> 	__folio_clear_dirty()
> 
> With all that, we'd have something like:
> 
> 	folio_test_foo()
> 	folio_set_foo()
> 	folio_clear_foo()
> 	folio_testset_foo()
> 	folio_testclear_foo()
> 
> 	__folio_test_foo()

BTW, this one doesn't exist.

> 	__folio_set_foo()
> 	__folio_clear_foo()
> 
> Would that be a workable compromise for everybody?

I think it has to be, because not all these work (marked with *):

  folio_is_locked()
  folio_is_referenced()
  folio_is_uptodate()
  folio_is_dirty()
* folio_is_lru()
  folio_is_active()
  folio_is_workingset()
* folio_is_waiters()
  folio_is_error()
  folio_is_slab()
* folio_is_owner_priv_1()
* folio_is_arch_1()
  folio_is_reserved()
* folio_is_private()
* folio_is_private_2()
  folio_is_writeback()
+ folio_is_head()
  folio_is_mappedtodisk()
* folio_is_reclaim()
  folio_is_swapbacked()
  folio_is_unevictable()
  folio_is_mlocked()
  folio_is_uncached()
* folio_is_hwpoison()
  folio_is_young()
  folio_is_idle()
  folio_is_arch_2()
* folio_is_skip_kasan_poison()
  folio_is_readahead()
  folio_is_checked()
  folio_is_swapcache()
  folio_is_fscache()
  folio_is_pinned()
  folio_is_savepinned()
  folio_is_foreign()
  folio_is_xen_remapped()
  folio_is_slob_free()
  folio_is_double_map()
  folio_is_isolated()
* folio_is_reported()

> > Yes, we -tip folk tend to also prefer consistent prefix_ naming, and
> > every time something big gets refactorered we make sure to make it so.
> > 
> > Look at it like a namespace; you can read it like
> > folio::del_from_lru_list() if you want. Obviously there's nothing like
> > 'using folio' for this being C and not C++.
> 
> Yeah the lack of `using` is my concern.
> 
> Namespacing is nice for more contained APIs. Classic class + method
> type deals, with non-namespaced private helpers implementing public
> methods, and public methods not layered past trivial stuff like
> foo_insert() calling __foo_insert() with a lock held.
> 
> memcg, vmalloc, kobject, you name it.
> 
> But the page api is pretty sprawling with sizable overlaps between
> interface and implementation, and heavy layering in both. `using`
> would be great to avoid excessive repetition where file or function
> context already does plenty of namespacing. Alas, it's not an option.

I mean, we could do ...

#include <linux/using_folio.h>

which makes
	bool test_writeback(struct folio *)
an alias of folio_test_writeback.  But I don't know that's a great
thing to do.  It makes it hard for people to get started in mm,
hard to move code between mm and other parts of the kernel, or
between mm/ and include/

Maybe I'm missing something important about 'using'.  It's been over
twenty years since I wrote Java in earnest and twenty-five since
I wrote a single line of Ada, so I'm a little rusty with the concept
of namespacing.

> If everybody agrees we'll be fine, I won't stand in the way. But I do
> think the page API is a bit unusual in that regard. And while it is
> nice for the outward-facing filesystem interface - and I can see why
> fs people love it - the cost of it seems to be carried by the MM
> implementation code.

I'm actually OK with that tradeoff.  There are more filesystem people than
MM people, and their concern is with how to implement their filesystem,
not with how the page cache works.  So if the MM side of the house needs
to be a little more complicated to make filesystems simpler, then that's
fine with me.

> Although I will say, folio_del_from_lru_list() reads a bit like
> 'a'.append_to(string) to me. lruvec_add_folio() would match more
> conventional object hierarchy for container/collection/list/array
> interactions, like with list_add, xa_store, rb_insert, etc.
> 
> Taking all of the above, we'd have:
> 
> 	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
> 		lruvec_del_folio(folio, lruvec);
> 		folio_set_active(folio);
> 		lruvec_add_folio(folio, lruvec);
> 		trace_mm_lru_activate(&folio->page);
> 	}
> 
> which reads a little better overall, IMO.
> 
> Is that a direction we could agree on?

Yes!  I have that ordering already with filemap_add_folio().  I don't
mind doing that for lruvec too.  But, it should then be:

		lruvec_del_folio(lruvec, folio);
		folio_set_active(folio);
		lruvec_add_folio(lruvec, folio);
		trace_mm_lru_activate(folio);

