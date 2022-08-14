Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0A591F9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiHNK6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Aug 2022 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiHNK6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:58:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA119C1A;
        Sun, 14 Aug 2022 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/brGozvVD9cl/+914MInuZZjHLBSc//JGiLi6Vu2gg=; b=reBkghLMUYHiSqHJ4cVCxZoS6M
        ee6fsVy67abBzkc5rvA6bmLLRo4oS6mpy9vl/P2zdwTmsf0WJzsFLM1XQgkt8Bf1uKZPDyt420u+0
        iJvGBD9TSDXhl96OTD+E2+/DG8M3hMwY8wcBvbxEDOZLWN17aWCIf8ukjQAOlKsep/z3XNFWMaF8P
        c3MaTHcRjtacsiVVcpNlHGVNJ5H5qnyOicQLb7joyPaqlGbAx+9APQPXtkPZEC3DvmiodXPDGJqh8
        2pny1thu178wulhvSsKDhHQvm7fRGr7vc1NPZhPhRmEdMHRTBgvfxnrrnCWf9VBhxmQQr1KTJQJX7
        E1UgGTaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNBJc-004j7t-Fp; Sun, 14 Aug 2022 10:57:56 +0000
Date:   Sun, 14 Aug 2022 11:57:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: State of the Page (August 2022)
Message-ID: <YvjVNBBgLxEy4xbQ@casper.infradead.org>
References: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
 <YvfBaKUlDkeVzIm9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvfBaKUlDkeVzIm9@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 13, 2022 at 06:21:12PM +0300, Mike Rapoport wrote:
> > For some users, the size of struct page is simply too large.  At 64
> > bytes per 4KiB page, memmap occupies 1.6% of memory.  If we can get
> > struct page down to an 8 byte tagged pointer, it will be 0.2% of memory,
> > which is an acceptable overhead.
> > 
> >    struct page {
> >       unsigned long mem_desc;
> >    };
> 
> This is 0.2% for a system that does not have any actual memdescs.
> 
> Do you have an estimate how much memory will be used by the memdescs, at
> least for some use-cases?

Sure.  For SLUB, we can see it today,

struct slab {
        unsigned long __page_flags;
        union {
                struct list_head slab_list;
                struct rcu_head rcu_head;
        };
        struct kmem_cache *slab_cache;
        /* Double-word boundary */
        void *freelist;         /* first free object */
        union {
                unsigned long counters;
                struct {
                        unsigned inuse:16;
                        unsigned objects:15;
                        unsigned frozen:1;
                };
        };
        unsigned int __unused;
        atomic_t __page_refcount;
#ifdef CONFIG_MEMCG
        unsigned long memcg_data;
#endif
};

That's 8 words on 64-bit, or 64 bytes.  We'll get to remove __unused and
__page_refcount which brings us back down to 56 bytes, but we'll need to
add a pointer to struct page, bringing us back up to 64 bytes.  Note
that this is per-allocation, so to calculate the amount of space used on
your system, you need to take each line like this:

radix_tree_node   189800 278348    584   28    4 : tunables    0    0    0 : slabdata   9941   9941      0

That last number before the first colon is the number of pages per slab,
so my system has currently allocated 9941 slabs, each with 4 pages in
it.  Current memory consumption is 64 * 4 * 9941 = ~2.5MB.  With
separately allocated memdescs, it's 8 * 4 * 9941 + 64 * 9941, or just
under 1MB.  Would need to repeat this calculation for each line of
slabinfo.


For other users, it depends how they evolve.  In my quick sketch, I
decided that adding pfn to struct folio was a good idea, but adding
a pointer to the page wasn't needed (for the few times it's needed,
we can call pfn_to_page()).  So struct folio will grow from 64 bytes
to 72 in order to add the pfn.  We'll also need to include the size
of subsequent fields currently stored in page[1], so dtor, order,
total_mapcount and pincount, bumping large folios up to 88 bytes.
If the mean size of a folio is 2 pages, then it's 88 + 2 * 8 = 104 bytes
per allocation instead of the current 128 bytes.  So it's still a win,
as long as we don't cache a lot of files less than 4kB.

> Another thing, we are very strict about keeping struct page at its current
> size. Don't you think it will be much more tempting to grow either of
> memdescs and for some use cases the overhead will be at least as big as
> now?

Possibly!  But we get to make that choice.  If the networking people want
to grow the size of the netpool memdesc, you and I don't need to care.
They don't need to negotiate with the MM people about the tradeoffs
involved, they can just do it, benchmark, and decide whether it makes
sense to them.

This is more of an opportunity than a potential downside.  Maybe we can
get rid of page_ext.  Yes, people who enable the features in page_ext
will see their memdescs grow, but they've got rid of the memdesc array
in the process.

Thanks for the feedback.
