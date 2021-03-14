Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156EC33A290
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 05:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhCNEHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 23:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhCNEHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 23:07:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3684C061574;
        Sat, 13 Mar 2021 20:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ep4XP1vBhI2Nl2tuCJff7SZZhlszaM+4YBa95k0m6hE=; b=fvBEvXJLhUaBT+ywAUZVPzXErX
        PeralbBBpFivDeoXw9faZtVMcd7CnMOP5YfBHOoWEPaQLVtKPiTElno5z21U071kSxAGUUjpGxmuj
        bmNYMubPhgbinVt07ZqEMP3lwuBrNJ+lQG117bupqIGLG7QPT1BwuoNgEIOMleRJvtANu7Tdbj+W+
        UA1iAKXP2JMjnBoO83rM1pvn8IFbU0PnEvtT6r213kSmmr3fGyNXsu5WOB3ZDEl12oy4rliDMRezS
        eIwFhYPusuvc1fCC/7qAv2n+tgqT7pIu6hCGVyMeqZNVi1lMUffYZZF2rdgTUis6nc+IZUHqBihEi
        GiZvNQAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLI2O-00FWWB-0f; Sun, 14 Mar 2021 04:07:37 +0000
Date:   Sun, 14 Mar 2021 04:07:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
Message-ID: <20210314040731.GO2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-2-willy@infradead.org>
 <20210313123702.b7724b84d955ab6669d4417a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313123702.b7724b84d955ab6669d4417a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:37:02PM -0800, Andrew Morton wrote:
> On Fri,  5 Mar 2021 04:18:37 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > A struct folio refers to an entire (possibly compound) page.  A function
> > which takes a struct folio argument declares that it will operate on the
> > entire compound page, not just PAGE_SIZE bytes.  In return, the caller
> > guarantees that the pointer it is passing does not point to a tail page.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/mm.h       | 30 ++++++++++++++++++++++++++++++
> >  include/linux/mm_types.h | 17 +++++++++++++++++
> 
> Perhaps a new folio.h would be neater.

I understand that urge (I'm no fan of the size of mm.h ...), but it ends
up pretty interwoven with mm.h.  For example:

static inline struct zone *folio_zone(const struct folio *folio)
{
        return page_zone(&folio->page);
}

so we need both struct folio defined here and we need page_zone().
page_zone() is defined in mm.h, so we'd have folio.h including mm.h.
But then put_page() calls put_folio(), so we need folio.h included
in mm.h.

The patch series I have does a lot of movement of page cache functionality
from mm.h to filemap.h, so you may end up with a smaller mm.h at the
end of it.  Right now, it's 10 lines longer than it was.

> > +static inline struct folio *next_folio(struct folio *folio)
> > +{
> > +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> > +	return (struct folio *)nth_page(&folio->page, folio_nr_pages(folio));
> > +#else
> > +	return folio + folio_nr_pages(folio);
> > +#endif
> > +}
> 
> It's a shame this isn't called folio_something(), like the rest of the API.
> 
> Unclear what this does.  Some comments would help.

folio_next() it can be.  I'll add some commentary.

> > +static inline unsigned int folio_shift(struct folio *folio)
> > +{
> > +	return PAGE_SHIFT + folio_order(folio);
> > +}
> > +
> > +static inline size_t folio_size(struct folio *folio)
> > +{
> > +	return PAGE_SIZE << folio_order(folio);
> > +}
> 
> Why size_t?  That's pretty rare in this space and I'd have expected
> unsigned long.

I like to use size_t for things which are the number of bytes represented
by an in-memory object.  As opposed to all the other things which we
use unsigned long for.  Maybe that's more common on the filesystem side
of the house.

> > +static inline struct folio *page_folio(struct page *page)
> > +{
> > +	unsigned long head = READ_ONCE(page->compound_head);
> > +
> > +	if (unlikely(head & 1))
> > +		return (struct folio *)(head - 1);
> > +	return (struct folio *)page;
> > +}
> 
> What purpose does the READ_ONCE() serve?

Same purpose as it does in compound_head():

static inline struct page *compound_head(struct page *page)
{
        unsigned long head = READ_ONCE(page->compound_head);

        if (unlikely(head & 1))
                return (struct page *) (head - 1);
        return page;
}

I think Kirill would say that it's to defend against splitting if we
don't have a refcount on the page yet.  So if we do something like walk
the page tables, find a PTE, translate it to a struct page, then try to
get a reference on the head page, we don't end up with an incoherent
answer from 'compound_head()' if it's split in the middle of the call
and the page->compound_head field gets assigned some other value.

It might return the wrong page, so get_user_pages() still has to check
the page is right after it's got the reference, but at least this way
it's guaranteed to return something that was right at one time.

There might be more to it, but that's my understanding of why the code
is currently written this way.
