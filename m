Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD311D490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfLLRwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 12:52:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfLLRwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ebjGbUUBq076s+Mp3U9ksksWu9YyYBwzUBSi8NM1nMs=; b=YbHlXUaPfUc62DVEt9s6QYS97
        D6HzG6bU0DVL0TnEK9iubvvjS9BRz0++O4EvnCvI36FrhWS32kAYin30JPYRDU6kCqw0XTqbKJYDn
        EASdGOuLZrj+NmJv6Zhlxbj5n5BzXvLsYjXk6OwFnxn/HUjnRF6Xrs6+RKqlkoptqfP640h6kmCMJ
        7cXbhdNEOOA8iXVCMFYXCXHBkAWHJHPrR8n0Rl9aQOX46jfuy0tyPuY2gDv028QARp/AsMws4NBz9
        5KpfHlah9rWoRkpCR1WeT3JM23mLZvhOv7bks0oYe0h06vwPPw+LyHWcPK/OiUIymZkd/GY3hLRIQ
        d5/7+FDRQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifSd6-0007Xl-U3; Thu, 12 Dec 2019 17:52:00 +0000
Date:   Thu, 12 Dec 2019 09:52:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20191212175200.GS32169@bombadil.infradead.org>
References: <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
 <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
 <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
 <20191212015612.GP32169@bombadil.infradead.org>
 <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:47:25PM -0800, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 5:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> > It _should_ be the same order of complexity.  Since there's already
> > a page in the page cache, xas_create() just walks its way down to the
> > right node calling xas_descend() and then xas_store() does the equivalent
> > of __radix_tree_replace().  I don't see a bug that would make it more
> > expensive than the old code ... a 10GB file is going to have four levels
> > of radix tree node, so it shouldn't even spend that long looking for
> > the right node.
> 
> The profile seems to say that 85% of the cost of xas_create() is two
> instructions:
> 
> # lib/xarray.c:143:     return (index >> node->shift) & XA_CHUNK_MASK;
>         movzbl  (%rsi), %ecx    # MEM[(unsigned char *)node_13],
> MEM[(unsigned char *)node_13]
> ...
> # ./include/linux/xarray.h:1145:        return
> rcu_dereference_check(node->slots[offset],
> # ./include/linux/compiler.h:199:       __READ_ONCE_SIZE;
>         movq    (%rax), %rax    # MEM[(volatile __u64 *)_80], <retval>
> 
> where that first load is "node->shift", and the second load seems to
> be just the node dereference.
> 
> I think both of them are basically just xas_descend(), but it's a bit
> hard to read the several levels of inlining.

Yep, that's basically the two cache misses you get for each level of
the tree.  I'd expect the node->shift to be slightly more costly because
sometimes the node->slots[offset] is going to be in the same cacheline
or the next cacheline after node->shift.

> I suspect the real issue is that going through kswapd means we've lost
> almost all locality, and with the random walking the LRU list is
> basically entirely unordered so you don't get any advantage of the
> xarray having (otherwise) possibly good cache patterns.
> 
> So we're just missing in the caches all the time, making it expensive.

I have some bad ideas for improving it.

1. We could semi-sort the pages on the LRU list.  If we know we're going
to remove a bunch of pages, we could take a batch of them off the list,
sort them and remove them in-order.  This probably wouldn't be terribly
effective.

2. We could change struct page to point to the xa_node that holds them.
Looking up the page mapping would be page->xa_node->array and then
offsetof(i_pages) to get the mapping.

3. Once the maple tree is ready, a 10GB file can actually be held more
efficiently in a maple tree than in the radix tree.  Because each level
of the tree is 128 bytes and (Intel) CPUs fetch a pair of cachelines,
there's only one cache miss per level of the tree.  So despite the tree
being deeper, there are fewer cache misses.  With an average of 6 pointers
per level of the tree, terminating in a dense node, we'd see:

: 6 * 6 * 6 * 6 * 6 * 6 * 6 * 15
: 4199040
(a 10GB file contains 2621440 4kB pages)

which is still eight cache misses, so to see an improvement, we'd need to
implement another planned improvement, which is allocating a large, dense
leaf node of 4kB.  That would reduce the height of the tree by 2:

: 6 * 6 * 6 * 6 * 6 * 500
: 3888000

4. For consecutive accesses, I'm working on allocating larger pages
(16kB, 64kB, 256kB, ...).  That will help by reducing the number of
deletions from the page cache by a factor of 4/16/64/...
