Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52B02DD27A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 14:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLQN4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 08:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQN4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:56:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5D4C061794;
        Thu, 17 Dec 2020 05:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/xHuHZVNJiJuB1/wE9ThBTiKge7RljSzOXowcSsCUnQ=; b=ZdApPT+uTR97j2wNolGGi0gLIu
        tjIfiom1cLqE2++kuNnVek0RmaLJeVwv6sCyqdVQGr1W6pMo+/VpjWxBTbr1wdNJProsbSf+LVl5k
        3tGDDSw84fDoW/zibD25DAUhHNmUT4xBbADU6IWtEa+6hx+B1qG4VejZL7YSyMgPteoMtwiS+zlX5
        D+4Q69bXWdXu0klpAocgsgtzHnH/0BLlhZ37zXho5bwgS0V94yTce8xKb44rLdNKoxDAVusOS2cCC
        ByPAbjZ1DVsf1EVLdRVw2aHv+T65lY1GgcIf5VxAhA51UlexSHmlSSptXFrtMAWrnQ36SQVOOXnq3
        VimrJ9QQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kptkU-0007V5-29; Thu, 17 Dec 2020 13:55:18 +0000
Date:   Thu, 17 Dec 2020 13:55:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] Page folios
Message-ID: <20201217135517.GF15600@casper.infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
 <9e764222-a274-0a99-5e41-7cfa9ea15b86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e764222-a274-0a99-5e41-7cfa9ea15b86@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 01:47:57PM +0100, David Hildenbrand wrote:
> On 16.12.20 19:23, Matthew Wilcox (Oracle) wrote:
> > One of the great things about compound pages is that when you try to
> > do various operations on a tail page, it redirects to the head page and
> > everything Just Works.  One of the awful things is how much we pay for
> > that simplicity.  Here's an example, end_page_writeback():
> > 
> >         if (PageReclaim(page)) {
> >                 ClearPageReclaim(page);
> >                 rotate_reclaimable_page(page);
> >         }
> >         get_page(page);
> >         if (!test_clear_page_writeback(page))
> >                 BUG();
> > 
> >         smp_mb__after_atomic();
> >         wake_up_page(page, PG_writeback);
> >         put_page(page);
> > 
> > That all looks very straightforward, but if you dive into the disassembly,
> > you see that there are four calls to compound_head() in this function
> > (PageReclaim(), ClearPageReclaim(), get_page() and put_page()).  It's
> > all for nothing, because if anyone does call this routine with a tail
> > page, wake_up_page() will VM_BUG_ON_PGFLAGS(PageTail(page), page).
> > 
> > I'm not really a CPU person, but I imagine there's some kind of dependency
> > here that sucks too:
> > 
> >     1fd7:       48 8b 57 08             mov    0x8(%rdi),%rdx
> >     1fdb:       48 8d 42 ff             lea    -0x1(%rdx),%rax
> >     1fdf:       83 e2 01                and    $0x1,%edx
> >     1fe2:       48 0f 44 c7             cmove  %rdi,%rax
> >     1fe6:       f0 80 60 02 fb          lock andb $0xfb,0x2(%rax)
> > 
> > Sure, it's going to be cache hot, but that cmove has to execute before
> > the lock andb.
> > 
> > I would like to introduce a new concept that I call a Page Folio.
> > Or just struct folio to its friends.  Here it is,
> > struct folio {
> >         struct page page;
> > };
> > 
> > A folio is a struct page which is guaranteed not to be a tail page.
> > So it's either a head page or a base (order-0) page.  That means
> > we don't have to call compound_head() on it and we save massively.
> > end_page_writeback() reduces from four calls to compound_head() to just
> > one (at the beginning of the function) and it shrinks from 213 bytes
> > to 126 bytes (using distro kernel config options).  I think even that one
> > can be eliminated, but I'm going slowly at this point and taking the
> > safe route of transforming a random struct page pointer into a struct
> > folio pointer by calling page_folio().  By the end of this exercise,
> > end_page_writeback() will become end_folio_writeback().
> > 
> > This is going to be a ton of work, and massively disruptive.  It'll touch
> > every filesystem, and a good few device drivers!  But I think it's worth
> > it.  Not every routine benefits as much as end_page_writeback(), but it
> > makes everything a little better.  At 29 bytes per call to lock_page(),
> > unlock_page(), put_page() and get_page(), that's on the order of 60kB of
> > text for allyesconfig.  More when you add on all the PageFoo() calls.
> > With the small amount of work I've done here, mm/filemap.o shrinks its
> > text segment by over a kilobyte from 33687 to 32318 bytes (and also 192
> > bytes of data).
> 
> Just wondering, as the primary motivation here is "minimizing CPU work",
> did you run any benchmarks that revealed a visible performance improvement?
> 
> Otherwise, we're left with a concept that's hard to grasp first (folio -
> what?!) and "a ton of work, and massively disruptive", saving some kb of
> code - which does not sound too appealing to me.
> 
> (I like the idea of abstracting which pages are actually worth looking
> at directly instead of going via a tail page - tail pages act somewhat
> like a proxy for the head page when accessing flags)

My primary motivation here isn't minimising CPU work at all.  It's trying
to document which interfaces are expected to operate on an entire
compound page and which are expected to operate on a PAGE_SIZE page.
Today, we have a horrible mishmash of

 - This is a head page, I shall operate on 2MB of data
 - This is a tail page, I shall operate on 2MB of data
 - This is not a head page, I shall operate on 4kB of data
 - This is a head page, I shall operate on 4kB of data
 - This is a head|tail page, I shall operate on the size of the compound page.

You might say "Well, why not lead with that?", but I don't know which
advantages people are going to find most compelling.  Even if someone
doesn't believe in the advantages of using folios in the page cache,
looking at the assembler output is, I think, compelling.
