Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0C59119D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbiHLNfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiHLNfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:35:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233D9F1A3;
        Fri, 12 Aug 2022 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jywy8j3qYEWAyUmU1bWi3tz3Ir+TGwQS5ddwDc4ngzs=; b=oGZ1KsEBvbUxlOvmjKj4t3IWeL
        LM5PZiUQlbPLkkgE+yowbSwWBItf2xPDxLE0VnWnD8jOtom9xfZIWSvman3833fbDEnyc3WUIV9Te
        VxKpq3lD5osEAk4xrpnc/cMS+LmxktpDb5wzbLAFGNfGFnKYpOZEBjDmsNEUHz7FpCPVhIIP2ZgaG
        HZjaN34FqJlKTfbJPbFcDRVXI68jPajzSdT2V+5YI/tySGQ7pIuVa/+US0ppTNULKyQ6f7aqkepNt
        3isB6bIJZH6aQmvSI/Awfm+lEPbB/e7ceLG8SUj98rnf1wESI3B1Bg9VwhC0gxXc682zSOlmGg0xs
        CGdAPr4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMUoP-002BAD-5b; Fri, 12 Aug 2022 13:34:53 +0000
Date:   Fri, 12 Aug 2022 14:34:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: State of the Page (August 2022)
Message-ID: <YvZW/exP02XceTVl@casper.infradead.org>
References: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
 <20220812101639.ijonnx7zeus7h2hn@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812101639.ijonnx7zeus7h2hn@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 01:16:39PM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 11, 2022 at 10:31:21PM +0100, Matthew Wilcox wrote:
> > ==============================
> > State Of The Page, August 2022
> > ==============================
> > 
> > I thought I'd write down where we are with struct page and where
> > we're going, just to make sure we're all (still?) pulling in a similar
> > direction.
> > 
> > Destination
> > ===========
> > 
> > For some users, the size of struct page is simply too large.  At 64
> > bytes per 4KiB page, memmap occupies 1.6% of memory.  If we can get
> > struct page down to an 8 byte tagged pointer, it will be 0.2% of memory,
> > which is an acceptable overhead.
> 
> Right. This is attractive. But it brings cost of indirection.

It does, but it also crams 8 pages into a single cacheline instead of
occupying one cacheline per page.

> It can be especially painful for physical memory scanning. I guess we can
> derive some info from memdesc type itself, like if it can be movable. But
> still looks like an expensive change.

I just don't think of physical memory scanning as something we do
often, or in a performance-sensitive path.  I'm OK with slowing down
kcompactd if it makes walking the LRU list faster.

> Do you have any estimation on how much CPU time we will pay to reduce
> memory (and cache) overhead? RAM size tend to grow faster than IPC.
> We need to make sure it is the right direction.

I don't.  I've heard colourful metaphors from the hyperscale crowd about
how many more VMs they could sell, usually in terms of putting pallets
of money in the parking lot and setting them on fire.  But IPC isn't the
right metric either, CPU performance is all about cache misses these days.

> > That implies 4 bits needed for the tag, so all memdesc allocations
> > must be 16-byte aligned.  That is not an undue burden.  Memdescs
> > must also be TYPESAFE_BY_RCU if they are mappable to userspace or
> > can be stored in a file's address_space.
> > 
> > It may be worth distinguishing between vmalloc-mappable and
> > vmalloc-unmappable to prevent some things being mapped to userspace
> > inadvertently.
> 
> Given that memdesc represents Slab too, how do we allocate them?

First, we separate out allocating pages from allocating their memdesc.  ie:

struct folio *folio_alloc(u8 order, gfp_t gfp)
{
	struct folio *folio = kmem_cache_alloc(folio_cache, gfp);

	if (!folio)
		return NULL;
	if (page_alloc_desc(order, folio, gfp))
		return folio;
	kmem_cache_free(folio_cache, folio);
	return NULL;
}

That can't work for slab because we might recurse for ever.  So we
have to do it backwards:

struct slab *slab_alloc(size_t size, u8 order, gfp_t gfp)
{
	struct slab *slab;
	struct page *page = page_alloc(order, gfp);

	if (!page)
		return NULL;
	if (sizeof(*slab) == size) {
		slab = page_address(page);
		slab_init(slab, 1);
	} else {
		slab = kmem_cache_alloc(slab_cache, gfp);
		if (!slab) {
			page_free(page, order);
			return NULL;
		}
	}
	page_set_memdesc(page, order, slab);
	return slab;
}

So there is mutual recursion between kmem_cache_alloc() and
slab_alloc(), but it stops after one round.  (obviously this is
just a sketch of a solution)

folio_alloc()
  kmem_cache_alloc(folio)
    page_alloc(folio)
      kmem_cache_alloc(slab)
        page_alloc(slab)
  page_alloc_desc() 

Slab then has to be taught that a slab with a single object allocated
(ie itself) is actually free and can be released back to the pool,
but that seems like a SMOP.

> > Mappable
> > --------
> > 
> > All pages mapped to userspace must have:
> > 
> >  - A refcount
> >  - A mapcount
> > 
> > Preferably in the same place in the memdesc so we can handle them without
> > having separate cases for each type of memdesc.  It would be nice to have
> > a pincount as well, but that's already an optional feature.
> > 
> > I propose:
> > 
> >    struct mappable {
> >        unsigned long flags;	/* contains dirty flag */
> >        atomic_t _refcount;
> >        atomic_t _mapcount;
> >    };
> > 
> >    struct folio {
> >       union {
> >          unsigned long flags;
> >          struct mappable m;
> >       };
> >       ...
> >    };
> 
> Hm. How does lockless page cache lookup would look like in this case?
> 
> Currently it relies on get_page_unless_zero() and to keep it work there's
> should be guarantee that nothing else is allocated where mappable memdesc
> was before. Would it require some RCU tricks on memdesc free?

An earlier paragraph has:

> > That implies 4 bits needed for the tag, so all memdesc allocations
> > must be 16-byte aligned.  That is not an undue burden.  Memdescs
> > must also be TYPESAFE_BY_RCU if they are mappable to userspace or
> > can be stored in a file's address_space.

so yes, I agree, we need this RCU trick to make sure the memdesc remains a
memdesc of the right type, even if it's no longer attached to the right
chunk of memory.
