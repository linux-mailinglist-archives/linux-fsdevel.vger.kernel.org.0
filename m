Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D50411D7A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 21:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfLLUFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 15:05:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbfLLUFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zr1kxExAzyfv2B4BiRd28MJfhNLW3Gxwvv8ht0OdwRo=; b=fLZHIs5DHnBZQwMmcxGuIJVS6
        pF6dZGsH7jYzDpvFADjhy/O/Fnn3m/giBJSDfCIVfQE1QVd5YL5lUxQ84KqcQwQcJLLDlJCerkLMO
        7IsojluasionpqAgRezxVRPmSqiwPbynaDZN/59BRf6bSnv38rQ0P19bGfpcks82ipnl4VMZ2XkFa
        YE0Cxr/Fb816OCCVPrQ59Dka0iOBUFfF9+HyUjtlf6gT9KpVcckdmJKhALsWYBrZjTL/E5sl+iexN
        iC7N4Oy+xxrwF+1KgGIZytkW6khV6QnfapUyBJs1M77/ZYkjzJOMEEnYAqVwJZWDDWNlgAhJumi9t
        T2gtw0fRw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifUhw-0008ND-7k; Thu, 12 Dec 2019 20:05:08 +0000
Date:   Thu, 12 Dec 2019 12:05:08 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20191212200508.GU32169@bombadil.infradead.org>
References: <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
 <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
 <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
 <20191212015612.GP32169@bombadil.infradead.org>
 <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
 <20191212175200.GS32169@bombadil.infradead.org>
 <CAHk-=wh4J91wMrEU12DP1r+rLiThQ6wDBb+UOzOuMDkusxtdhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4J91wMrEU12DP1r+rLiThQ6wDBb+UOzOuMDkusxtdhw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:29:02AM -0800, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 9:52 AM Matthew Wilcox <willy@infradead.org> wrote:
> > 1. We could semi-sort the pages on the LRU list.  If we know we're going
> > to remove a bunch of pages, we could take a batch of them off the list,
> > sort them and remove them in-order.  This probably wouldn't be terribly
> > effective.
> 
> I don't think the sorting is relevant.
> 
> Once you batch things, you already would get most of the locality
> advantage in the cache if it exists (and the batch isn't insanely
> large so that one batch already causes cache overflows).
> 
> The problem - I suspect - is that we don't batch at all. Or rather,
> the "batching" does exist at a high level, but it's so high that
> there's just tons of stuff going on between single pages. It is at the
> shrink_page_list() level, which is pretty high up and basically does
> one page at a time with locking and a lot of tests for each page, and
> then we do "__remove_mapping()" (which does some more work) one at a
> time before we actually get to __delete_from_page_cache().
> 
> So it's "batched", but it's in a huge loop, and even at that huge loop
> level the batch size is fairly small. We limit it to SWAP_CLUSTER_MAX,
> which is just 32.
> 
> Thinking about it, that SWAP_CLUSTER_MAX may make sense in some other
> circumstances, but not necessarily in the "shrink clean inactive
> pages" thing. I wonder if we could just batch clean pages a _lot_ more
> aggressively. Yes, our batching loop is still very big and it might
> not help at an L1 level, but it might help in the L2, at least.
> 
> In kswapd, when we have 28 GB of pages on the inactive list, a batch
> of 32 pages at a time is pretty small ;)

Yeah, that's pretty poor.  I just read through it, and even if pages are
in order on the page list, they're not going to batch nicely.  It'd be
nice to accumulate them and call delete_from_page_cache_batch(), but we
need to put shadow entries in to replace them, so we'd need a variant
of that which took two pagevecs.

> > 2. We could change struct page to point to the xa_node that holds them.
> > Looking up the page mapping would be page->xa_node->array and then
> > offsetof(i_pages) to get the mapping.
> 
> I don't think we have space in 'struct page', and I'm pretty sure we
> don't want to grow it. That's one of the more common data structures
> in the kernel.

Oh, I wasn't clear.  I meant replace page->mapping with page->xa_node.
We could still get from page to mapping, but it would be an extra
dereference.  I did say it was a _bad_ idea.
