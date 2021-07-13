Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03B13C686B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 04:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGMCS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 22:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhGMCS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 22:18:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D285AC0613DD;
        Mon, 12 Jul 2021 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xJavVTfNWhtpN9cK3gRrytjNmd7xz7skpAOWkhfRqSk=; b=BWJ5IeYDzBpfCxr6ONu4e9+vr0
        WDw6K+XJXd3pWafSZzG9GLPx1+YCV1GSQsOaGRWoOGYqTboibclpE+PeWiSx67JixZrTlAYy+YP4T
        /xO+cURfcqiKEYY9Fy/dosw/mXDt5Cq5pKeJe/W+WEYJi5+pqT4vPK8GnzksEvdxODZJDev+Bcc0O
        34J1BQvt3XMsGb2qC9t0SBuNeg3OfOEFK1jKwuRS9O+cqtJSCITFAdFGFUrKdkZNUu15eZsI9KN7k
        ZTGM0VLaX/OJCTzl0sF1SFwVl8hvkdYcqcqnYO6e6NA2ENH6IlgY/m83rJXaZ09IBXcyz3vuNqY5D
        djP2UfCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m37x0-000eHy-EK; Tue, 13 Jul 2021 02:15:16 +0000
Date:   Tue, 13 Jul 2021 03:15:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v13 010/137] mm: Add folio flag manipulation functions
Message-ID: <YOz3Lms9pcsHPKLt@casper.infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
 <20210712030701.4000097-11-willy@infradead.org>
 <YOzdKYejOEUbjvMj@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOzdKYejOEUbjvMj@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 08:24:09PM -0400, Johannes Weiner wrote:
> On Mon, Jul 12, 2021 at 04:04:54AM +0100, Matthew Wilcox (Oracle) wrote:
> > +/* Whether there are one or multiple pages in a folio */
> > +static inline bool folio_single(struct folio *folio)
> > +{
> > +	return !folio_head(folio);
> > +}
> 
> Reading more converted code in the series, I keep tripping over the
> new non-camelcased flag testers.

Added PeterZ as he asked for it.

https://lore.kernel.org/linux-mm/20210419135528.GC2531743@casper.infradead.org/

> It's not an issue when it's adjectives: folio_uptodate(),
> folio_referenced(), folio_locked() etc. - those are obvious. But nouns
> and words that overlap with struct member names can easily be confused
> with non-bool accessors and lookups. Pop quiz: flag test or accessor?
> 
> folio_private()
> folio_lru()
> folio_nid()
> folio_head()
> folio_mapping()
> folio_slab()
> folio_waiters()

I know the answers to each of those, but your point is valid.  So what's
your preferred alternative?  folio_is_lru(), folio_is_uptodate(),
folio_is_slab(), etc?  I've seen suggestions for folio_test_lru(),
folio_test_uptodate(), and I don't much care for that alternative.

> This requires a lot of double-taking on what is actually being
> queried. Bool types, ! etc. don't help, since we test pointers for
> NULL/non-NULL all the time.
> 
> I see in a later patch you changed the existing page_lru() (which
> returns an enum) to folio_lru_list() to avoid the obvious collision
> with the PG_lru flag test. page_private() has the same problem but it
> changed into folio_get_private() (no refcounting involved). There
> doesn't seem to be a consistent, future-proof scheme to avoid this new
> class of collisions between flag testing and member accessors.
> 
> There is also an inconsistency between flag test and set that makes me
> pause to think if they're actually testing and setting the same thing:
> 
> 	if (folio_idle(folio))
> 		folio_clear_idle_flag(folio);
> 
> Compare this to check_move_unevictable_pages(), where we do
> 
> 	if (page_evictable(page))
> 		ClearPageUnevictable(page);
> 
> where one queries a more complex, contextual userpage state and the
> other updates the corresponding pageframe bit flag.
> 
> The camelcase stuff we use for page flag testing is unusual for kernel
> code. But the page API is also unusually rich and sprawling. What
> would actually come close? task? inode? Having those multiple
> namespaces to structure and organize the API has been quite helpful.
> 
> On top of losing the flagops namespacing, this series also disappears
> many <verb>_page() operations (which currently optically distinguish
> themselves from page_<noun>() accessors) into the shared folio_
> namespace. This further increases the opportunities for collisions,
> which force undesirable naming compromises and/or ambiguity.
> 
> More double-taking when the verb can be read as a noun: lock_folio()
> vs folio_lock().
> 
> Now, is anybody going to mistake folio_lock() for an accessor? Not
> once they think about it. Can you figure out and remember what
> folio_head() returns? Probably. What about all the examples above at
> the same time? Personally, I'm starting to struggle. It certainly
> eliminates syntactic help and pattern matching, and puts much more
> weight on semantic analysis and remembering API definitions.

Other people have given the opposite advice.  For example,
https://lore.kernel.org/linux-mm/YMmfQNjExNs3cuyq@kroah.com/

> What about functions like shrink_page_list() which are long sequences
> of page queries and manipulations? Many lines would be folio_<foo>
> with no further cue whether you're looking at tests, accessors, or a
> high-level state change that is being tested for success. There are
> fewer visual anchors to orient yourself when you page up and down. It
> quite literally turns some code into blah_(), blah_(), blah_():
> 
>        if (!folio_active(folio) && !folio_unevictable(folio)) {
> 	       folio_del_from_lru_list(folio, lruvec);
> 	       folio_set_active_flag(folio);
> 	       folio_add_to_lru_list(folio, lruvec);
> 	       trace_mm_lru_activate(&folio->page);
> 	}

I actually like the way that looks (other than the trace_mm_lru_activate()
which is pending a conversion from page to folio).  But I have my head
completely down in it, and I can't tell what works for someone who's
fresh to it.  I do know that it's hard to change from an API you're
used to (and that's part of the cost of changing an API), and I don't
know how to balance that against making a more discoverable API.

> Think about the mental strain of reading and writing complicated
> memory management code with such a degree of syntactic parsimony, let
> alone the repetetive monotony.
> 
> In those few lines of example code alone, readers will pause on things
> that should be obvious, and miss grave errors that should stand out.
> 
> Add compatible return types to similarly named functions and we'll
> provoke subtle bugs that the compiler won't catch either.
> 
> There are warts and inconsistencies in our naming patterns that could
> use cleanups. But I think this compresses a vast API into one template
> that isn't nearly expressive enough to adequately communicate and
> manage the complexity of the underlying structure and its operations.

I don't want to dismiss your concerns.  I just don't agree with them.
If there's a consensus on folio_verb() vs verb_folio(), I'm happy to
go back through all these patches and do the rename.
