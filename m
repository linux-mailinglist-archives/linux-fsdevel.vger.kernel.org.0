Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C358438169
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 04:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJWC1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJWC1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 22:27:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487DC061764;
        Fri, 22 Oct 2021 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L+Crhvh7UT3jj1pWTw4/ixGXa9S6abJhYuA13R+zb0g=; b=bT9aKWu5z2XwsG1DRMRMUtkCKv
        fjD6K4wFRPA/EkLmxRu3qnBDOeydDAUus+h2KWpuru2OafzKm5AeL4nU/V4mwreWY2cEjVfZ1UEnc
        ykaxTErBWk9Qt43xCmiv1iZicheTr/ifVdNJVcqGcaJhKA022ZxLQqYRU9a8CGlcj6Rjz5oLMllLI
        SofbiXeLtDmXyz6k+qoXogOoPggpmrRNCBJsuOuF4PKVS4XtXH64ED7w1QsyDJawq28PA5n7uisfR
        VXTLVSi34mjdUVz50yLMwoWEP1nDxyVnl7QrrBSq9H3dHsf/nvOfBFmEJiWXResWqMl7rjJ8G2nAB
        Kg7BAwhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me6g7-00EL7y-4B; Sat, 23 Oct 2021 02:22:47 +0000
Date:   Sat, 23 Oct 2021 03:22:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
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
Message-ID: <YXNx686gvsJMgS+z@casper.infradead.org>
References: <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
 <YXK2ICKi6fjNfr4X@casper.infradead.org>
 <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 04:40:24PM +0200, David Hildenbrand wrote:
> On 22.10.21 15:01, Matthew Wilcox wrote:
> > On Fri, Oct 22, 2021 at 09:59:05AM +0200, David Hildenbrand wrote:
> >> something like this would roughly express what I've been mumbling about:
> >>
> >> anon_mem    file_mem
> >>    |            |
> >>    ------|------
> >>       lru_mem       slab
> >>          |           |
> >>          -------------
> >>                |
> >> 	      page
> >>
> >> I wouldn't include folios in this picture, because IMHO folios as of now
> >> are actually what we want to be "lru_mem", just which a much clearer
> >> name+description (again, IMHO).
> > 
> > I think folios are a superset of lru_mem.  To enhance your drawing:
> > 
> 
> In the picture below we want "folio" to be the abstraction of "mappable
> into user space", after reading your link below and reading your graph,
> correct? Like calling it "user_mem" instead.

Hmm.  Actually, we want a new layer in the ontology:

page
   folio
      mappable
         lru_mem
            anon_mem
            ksm
            file_mem
         netpool
         devmem
         zonedev
         vmalloc
      zsmalloc
      dmapool
      devmem (*)
   slab
   pgtable
   buddy

(*) yes, devmem appears twice; some is mappable and some is not

The ontology is kind of confusing because *every* page is part of a
folio.  Sometimes it's a folio of one page (eg vmalloc).  Which means
that it's legitimate to call page_folio() on a slab page and then call
folio_test_slab().  It's not the direction we want to go though.

We're also inconsistent about whether we consider an entire compound
page / folio the thing which is mapped, or whether each individual page
in the compound page / folio can be mapped.  See how differently file-THP
and anon-THP are handled in rmap, for example.  I think that was probably
a mistake.

> Because any of these types would imply that we're looking at the head
> page (if it's a compound page). And we could (or even already have?)
> have other types that cannot be mapped to user space that are actually a
> compound page.

Sure, slabs are compound pages which cannot be mapped to userspace.

> > I have a little list of memory types here:
> > https://kernelnewbies.org/MemoryTypes
> > 
> > Let me know if anything is missing.
> 
> hugetlbfs pages might deserve a dedicated type, right?

Not sure.  Aren't they just file pages (albeit sometimes treated
specially, which is one of the mistakes we need to fix)?

> > And starting with file_mem makes the supposition that it's worth splitting
> > file_mem from anon_mem.  I believe that's one or two steps further than
> > it's worth, but I can be convinced otherwise.  For example, do we have
> > examples of file pages being passed to routines that expect anon pages?
> 
> That would be a BUG, so I hope we don't have it ;)

Right.  I'm asking, did we fix any bugs in the last year or two that
were caused by this kind of mismatch and would be prevented by using
a different type?  There's about half a dozen bugs we've had in the
last year that were caused by passing tail pages to functions that
were expecting head pages.

I can think of one problem we have, which is that (for a few filesystems
which have opted into this), we can pass an anon page into ->readpage()
and we've had problems with those filesystems then mishandling the
anon page.  The solution to this problem is not to pass an lru_mem to
readpage, but to use a different fs operation to read swap pages.

> Let's consider folio_wait_writeback(struct folio *folio)
> 
> Do we actually want to pass in a folio here? Would we actually want to
> pass in lru_mem here or even something else?

Well, let's look at the callers (for simplicity, look at Linus'
current tree).  Other than the ones in filesystems which we can assume
have file pages, mm/migrate.c has __unmap_and_move().  What type should
migrate_pages() have and pass around?

> Looking at some core MM code, like mm/huge_memory.c, and seeing all the
> PageAnon() specializations, having a dedicated anon_mem type might be
> valuable. But at this point it's hard to tell if splitting up these
> functions would actually be desirable.

Yes.  That's my point; it *might* be desirable.  I have no objections to
it, but the people doing the work need to show the benefits.  I'm showing
the benefits to folios -- fewer bugs, smaller code, larger pages in the
page cache leading to faster systems.  I acknowledge the costs in terms
of churn.

You can see folios as a first step to disentangling some of the users
of struct page.  It certainly won't be the last step.  But I'd really
like to stop having theoretical discussions of memory types and get on
with writing code.  If that means we modify the fs APIs again in twelve
months to replace folios with file_mem, well, I'm OK with that.

