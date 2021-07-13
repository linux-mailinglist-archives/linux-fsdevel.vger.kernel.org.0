Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABD93C6D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhGMJT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhGMJT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:19:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C31C0613DD;
        Tue, 13 Jul 2021 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dp/8pxc8dqgxWvcjc5TifTl7meQRxsxy+9mJMarjXc0=; b=K4y1kRX0/KPbAZqhljfqJhqifE
        6dfhRyDM8ugUsMRWIxHCUSYYu/G8NOGS1PoLdV5BJQKGGKXT1+EKMWncZ2Y1sce6CFKSJBqL/vlkM
        TtHc1NNw98HAFVVEBXmyG9YRruAyyqs61o8mGnEwaWwlplpzcXtj58vALs4tQx2Rff3isQAxPJeuE
        CN2Yo0qJ+ekagVtU166HYPObDK+7Hz0t0CdW8BkF9tKWjpdqZlsKjABUD78dcu5NscsPUP/IzH9gg
        F24L6PbiRAlfrqQgsyNcuM3QFOGTcQpbG68Wgx8ZxQkfJiZxucLlgrWcyRw7uDBcBx29jrW2zGW1u
        ssOKyiBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3EVr-000w1f-Aa; Tue, 13 Jul 2021 09:15:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11E5398460B; Tue, 13 Jul 2021 11:15:34 +0200 (CEST)
Date:   Tue, 13 Jul 2021 11:15:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v13 010/137] mm: Add folio flag manipulation functions
Message-ID: <20210713091533.GB4132@worktop.programming.kicks-ass.net>
References: <20210712030701.4000097-1-willy@infradead.org>
 <20210712030701.4000097-11-willy@infradead.org>
 <YOzdKYejOEUbjvMj@cmpxchg.org>
 <YOz3Lms9pcsHPKLt@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOz3Lms9pcsHPKLt@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 03:15:10AM +0100, Matthew Wilcox wrote:
> On Mon, Jul 12, 2021 at 08:24:09PM -0400, Johannes Weiner wrote:
> > On Mon, Jul 12, 2021 at 04:04:54AM +0100, Matthew Wilcox (Oracle) wrote:
> > > +/* Whether there are one or multiple pages in a folio */
> > > +static inline bool folio_single(struct folio *folio)
> > > +{
> > > +	return !folio_head(folio);
> > > +}
> > 
> > Reading more converted code in the series, I keep tripping over the
> > new non-camelcased flag testers.
> 
> Added PeterZ as he asked for it.
> 
> https://lore.kernel.org/linux-mm/20210419135528.GC2531743@casper.infradead.org/

Aye; I hate me some Camels with a passion. And Linux Coding style
explicitly not having Camels these things were always a sore spot. I'm
very glad to see them go.

> > It's not an issue when it's adjectives: folio_uptodate(),
> > folio_referenced(), folio_locked() etc. - those are obvious. But nouns
> > and words that overlap with struct member names can easily be confused
> > with non-bool accessors and lookups. Pop quiz: flag test or accessor?
> > 
> > folio_private()
> > folio_lru()
> > folio_nid()
> > folio_head()
> > folio_mapping()
> > folio_slab()
> > folio_waiters()
> 
> I know the answers to each of those, but your point is valid.  So what's
> your preferred alternative?  folio_is_lru(), folio_is_uptodate(),
> folio_is_slab(), etc?  I've seen suggestions for folio_test_lru(),
> folio_test_uptodate(), and I don't much care for that alternative.

Either _is_ or _test_ works for me, with a slight preference to _is_ on
account it of being shorter.

> > Now, is anybody going to mistake folio_lock() for an accessor? Not
> > once they think about it. Can you figure out and remember what
> > folio_head() returns? Probably. What about all the examples above at
> > the same time? Personally, I'm starting to struggle. It certainly
> > eliminates syntactic help and pattern matching, and puts much more
> > weight on semantic analysis and remembering API definitions.
> 
> Other people have given the opposite advice.  For example,
> https://lore.kernel.org/linux-mm/YMmfQNjExNs3cuyq@kroah.com/

Yes, we -tip folk tend to also prefer consistent prefix_ naming, and
every time something big gets refactorered we make sure to make it so.

Look at it like a namespace; you can read it like
folio::del_from_lru_list() if you want. Obviously there's nothing like
'using folio' for this being C and not C++.

> > What about functions like shrink_page_list() which are long sequences
> > of page queries and manipulations? Many lines would be folio_<foo>
> > with no further cue whether you're looking at tests, accessors, or a
> > high-level state change that is being tested for success. There are
> > fewer visual anchors to orient yourself when you page up and down. It
> > quite literally turns some code into blah_(), blah_(), blah_():
> > 
> >        if (!folio_active(folio) && !folio_unevictable(folio)) {
> > 	       folio_del_from_lru_list(folio, lruvec);
> > 	       folio_set_active_flag(folio);
> > 	       folio_add_to_lru_list(folio, lruvec);
> > 	       trace_mm_lru_activate(&folio->page);
> > 	}
> 
> I actually like the way that looks (other than the trace_mm_lru_activate()
> which is pending a conversion from page to folio).  But I have my head
> completely down in it, and I can't tell what works for someone who's
> fresh to it.  I do know that it's hard to change from an API you're
> used to (and that's part of the cost of changing an API), and I don't
> know how to balance that against making a more discoverable API.

Yeah, I don't particularly have a problem with the repeated folio_ thing
either, it's something you'll get used to.

I agree that significantly changing the naming of things is a majoy
PITA, but given the level of refactoring at that, I think folio_ beats
pageymcpageface_. Give it some time to get used to it...
