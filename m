Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C63344F09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 19:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhCVStW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhCVStG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:49:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FEC061574;
        Mon, 22 Mar 2021 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YxjzMmOBLMiHOiaQiqnC64+Oadts1R+tWB/7c0yIxpk=; b=GE0DXOJEGOlrSQpvHN5rZQdJdw
        eY5YNVSHYOmqZe2p/snMgmsK5d5fh5VbtZU9tIDXvl0hfSlaguFtAYap7rg+H962JODYUqr6rAQtr
        2MT8Vv7+c8qF/9sEvJ+Kj+pMRXFAkd26CDSV3j53VE7gcJQBNHp+PEH9xC2W0GA6RAvEnBHp/dabb
        wrlW2pvEofkKSssyXR5+8+JPModtT6A2YiC/bPekvXOUGpQtJJHmPlfsVLM4CQhgGhFG3PoxR8bJJ
        GERaGe9Yk7F2owcSGEcP4kpoDSBQTdRlS8Zz0rALzuWoVp/45cbHfGomXeWf8pW+Ke1DhngI7Hh5i
        AjoOCdKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPaa-008w3P-Gk; Mon, 22 Mar 2021 18:47:58 +0000
Date:   Mon, 22 Mar 2021 18:47:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210322184744.GU1719932@casper.infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFja/LRC1NI6quL6@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:59:24PM -0400, Johannes Weiner wrote:
> On Sat, Mar 20, 2021 at 05:40:37AM +0000, Matthew Wilcox (Oracle) wrote:
> > This series introduces the 'struct folio' as a replacement for
> > head-or-base pages.  This initial set reduces the kernel size by
> > approximately 6kB, although its real purpose is adding infrastructure
> > to enable further use of the folio.
> > 
> > The intent is to convert all filesystems and some device drivers to work
> > in terms of folios.  This series contains a lot of explicit conversions,
> > but it's important to realise it's removing a lot of implicit conversions
> > in some relatively hot paths.  There will be very few conversions from
> > folios when this work is completed; filesystems, the page cache, the
> > LRU and so on will generally only deal with folios.
> 
> If that is the case, shouldn't there in the long term only be very
> few, easy to review instances of things like compound_head(),
> PAGE_SIZE etc. deep in the heart of MM? And everybody else should 1)
> never see tail pages and 2) never assume a compile-time page size?

I don't know exactly where we get to eventually.  There are definitely
some aspects of the filesystem<->mm interface which are page-based
(eg ->fault needs to look up the exact page, regardless of its
head/tail/base nature), while ->readpage needs to talk in terms of
folios.

> What are the higher-level places that in the long-term should be
> dealing with tail pages at all? Are there legit ones besides the page
> allocator, THP splitting internals & pte-mapped compound pages?

I can't tell.  I think this patch maybe illustrates some of the
problems, but maybe it's just an intermediate problem:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/047e9185dc146b18f56c6df0b49fe798f1805c7b

It deals mostly in terms of folios, but when it needs to kmap() and
memcmp(), then it needs to work in terms of pages.  I don't think it's
avoidable (maybe we bury the "dealing with pages" inside a kmap()
wrapper somewhere, but I'm not sure that's better).

> I do agree that the current confusion around which layer sees which
> types of pages is a problem. But I also think a lot of it is the
> result of us being in a transitional period where we've added THP in
> more places but not all code and data structures are or were fully
> native yet, and so we had things leak out or into where maybe they
> shouldn't be to make things work in the short term.
> 
> But this part is already getting better, and has gotten better, with
> the page cache (largely?) going native for example.

Thanks ;-)  There's still more work to do on that (ie storing one
entry to cover 512 indices instead of 512 identical entries), but it
is getting better.  What can't be made better is the CPU page tables;
they really do need to point to tail pages.

One of my longer-term goals is to support largeish pages on ARM (and
other CPUs).  Instead of these silly config options to have 16KiB
or 64KiB pages, support "add PTEs for these 16 consecutive, aligned pages".
And I'm not sure how we do that without folios.  The notion that a
page is PAGE_SIZE is really, really ingrained.  I tried the page_size()
macro to make things easier, but there's 17000 instances of PAGE_SIZE
in the tree, and they just aren't going to go away.

> Some compound_head() that are currently in the codebase are already
> unnecessary. Like the one in activate_page().

Right!  And it's hard to find & remove them without very careful analysis,
or particularly deep knowledge.  With folios, we can remove them without
terribly deep thought.

> And looking at grep, I wouldn't be surprised if only the page table
> walkers need the page_compound() that mark_page_accessed() does. We
> would be better off if they did the translation once and explicitly in
> the outer scope, where it's clear they're dealing with a pte-mapped
> compound page, instead of having a series of rather low level helpers
> (page flags testing, refcount operations, LRU operations, stat
> accounting) all trying to be clever but really just obscuring things
> and imposing unnecessary costs on the vast majority of cases.
> 
> So I fully agree with the motivation behind this patch. But I do
> wonder why it's special-casing the commmon case instead of the rare
> case. It comes at a huge cost. Short term, the churn of replacing
> 'page' with 'folio' in pretty much all instances is enormous.

Because people (think they) know what a page is.  It's PAGE_SIZE bytes
long, it occupies one PTE, etc, etc.  A folio is new and instead of
changing how something familiar (a page) behaves, we're asking them
to think about something new instead that behaves a lot like a page,
but has differences.

> And longer term, I'm not convinced folio is the abstraction we want
> throughout the kernel. If nobody should be dealing with tail pages in
> the first place, why are we making everybody think in 'folios'? Why
> does a filesystem care that huge pages are composed of multiple base
> pages internally? This feels like an implementation detail leaking out
> of the MM code. The vast majority of places should be thinking 'page'
> with a size of 'page_size()'. Including most parts of the MM itself.

I think pages already leaked out of the MM and into filesystems (and
most of the filesystem writers seem pretty unknowledgable about how
pages and the page cache work, TBH).  That's OK!  Or it should be OK.
Filesystem authors should be experts on how their filesystem works.
Everywhere that they have to learn about the page cache is a distraction
and annoyance for them.

I mean, I already tried what you're suggesting.  It's really freaking
hard.  It's hard to do, it's hard to explain, it's hard to know if you
got it right.  With folios, I've got the compiler working for me, telling
me that I got some of the low-level bits right (or wrong), leaving me
free to notice "Oh, wait, we got the accounting wrong because writeback
assumes that a page is only PAGE_SIZE bytes".  I would _never_ have
noticed that with the THP tree.  I only noticed it because transitioning
things to folios made me read the writeback code and wonder about the
'inc_wb_stat' call, see that it's measuring something in 'number of pages'
and realise that the wb_stat accounting needs to be fixed.

> The compile-time check is nice, but I'm not sure it would be that much
> more effective at catching things than a few centrally placed warns
> inside PageFoo(), get_page() etc. and other things that should not
> encounter tail pages in the first place (with __helpers for the few
> instances that do). And given the invasiveness of this change, they
> ought to be very drastically better at it, and obviously so, IMO.

We should have come up with a new type 15 years ago instead of doing THP.
But the second best time to invent a new type for "memory objects which
are at least as big as a page" is right now.  Because it only gets more
painful over time.
