Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03533C7B37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 03:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhGNB7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 21:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237374AbhGNB7U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:59:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7A9561380;
        Wed, 14 Jul 2021 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626227789;
        bh=isw8NObe2WdOuF2gCTnoGlePrUX9TGB3R1LTs96xebw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/0aWmM8zERl9IDeVpu0B9LIhUBUv1uFoYowcExAcB7aeU7C2aKU7pxj53bNl7L+l
         UdWapP8A3OWW4iPDiwzXDBlQ3KUVUBdmBP/ZnACUvCXKZrPulR457+JQR1DJD2M9Di
         Fkjx++0Yc7e7lvd7Abi30J7XPI+Vl6czx+gJLDPA=
Date:   Tue, 13 Jul 2021 18:56:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v13 010/137] mm: Add folio flag manipulation functions
Message-Id: <20210713185628.9962f4ce987fd952515c83fa@linux-foundation.org>
In-Reply-To: <YO23WOUhhZtL6Gtn@cmpxchg.org>
References: <20210712030701.4000097-1-willy@infradead.org>
        <20210712030701.4000097-11-willy@infradead.org>
        <YOzdKYejOEUbjvMj@cmpxchg.org>
        <YOz3Lms9pcsHPKLt@casper.infradead.org>
        <20210713091533.GB4132@worktop.programming.kicks-ass.net>
        <YO23WOUhhZtL6Gtn@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Jul 2021 11:55:04 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

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

Useful discussion, and quite important.  Thanks for bringing it up.

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

I like folio_is_foo().  As long as it is used consistently, we'll get
used to it quickly.

Some GNU tools are careful about appending "_p" to
functions-which-test-something (stands for "predicate").  Having spent
a lot of time a long time ago with my nose in this stuff, I found the
convention to be very useful.  I think foo_is_bar() is as good as
foo_bar_p() in this regard.

> 
> 	folio_test_foo()
> 	folio_set_foo()
> 	folio_clear_foo()
> 	folio_testset_foo()
> 	folio_testclear_foo()

Agree with everyone else about prefixing every symbol with "folio_". 
Although at times there will be heartache over which subsystem the
function actually belongs to.  For example, a hypothetical function
which writes back a folio to disk could be writeback_folio() or
folio_writeback().  Really it's a part of writeback so should be
writeback_folio().  Plus folio isn't really a subsystem.  But then,
neither is spin_lock much, and that naming works OK.


And sure, the CaMeLcAsE is fugly, but it sure is useful. 
set_page_dirty() is very different from SetPageDirty() and boy that
visual differentiation is a relief.
