Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243B93F55C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 04:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhHXCWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 22:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhHXCWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:22:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A007C061575;
        Mon, 23 Aug 2021 19:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w3YWD1YQ7yzJTuhmTwVKzCh8QAlpDX6ZrTlsUvoyX8U=; b=M8bh9QnVXsa2B22/luwUvosuoq
        3POH1pQHw64iMgvVdeifyHHUc/kPPgLkE5xvmMAIsrxLx4BTAVWPF0wcoVobVv4PakX4F0yadjCXZ
        cgSgj9xae/UtiRvs+RtT8tqdByBiyvruXQGWJhnNLdP0VYNhryO6OkJn1BLSKYlStL1nRXtVywueb
        wzGm1T6E2iIPsyJA9DNm/RkVRhJeLh6mWP7NQ2oTnqUCFfEIEsGY+TWwE+fzRGvazF5WSYyRwBvrn
        WsN+OOhYW7rIH83g03B0ghqj9HRkdcAnTzpvlGALID3/yg/Kjz6JtR/KK1NnOHCfpCZXZaVjmHBL8
        0cGKXDNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIM3V-00AR03-14; Tue, 24 Aug 2021 02:20:58 +0000
Date:   Tue, 24 Aug 2021 03:20:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSRXgJ/axyNma3oh@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 03:06:08PM -0700, Linus Torvalds wrote:
> On Mon, Aug 23, 2021 at 2:25 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > One one hand, the ambition appears to substitute folio for everything
> > that could be a base page or a compound page even inside core MM
> > code. Since there are very few places in the MM code that expressly
> > deal with tail pages in the first place, this amounts to a conversion
> > of most MM code - including the LRU management, reclaim, rmap,
> > migrate, swap, page fault code etc. - away from "the page".
> 
> Yeah, honestly, I would have preferred to see this done the exact
> reverse way: make the rule be that "struct page" is always a head
> page, and anything that isn't a head page would be called something
> else.
> 
> Because, as you say, head pages are the norm. And "folio" may be a
> clever term, but it's not very natural. Certainly not at all as
> intuitive or common as "page" as a name in the industry.
> 
> That said, I see why Willy did it the way he did - it was easier to do
> it incrementally the way he did. But I do think it ends up with an end
> result that is kind of topsy turvy where the common "this is the core
> allocation" being called that odd "folio" thing, and then the simpler
> "page" name is for things that almost nobody should even care about.
> 
> I'd have personally preferred to call the head page just a "page", and
> other pages "subpage" or something like that. I think that would be
> much more intuitive than "folio/page".

I'm trying to figure out how we can get there.

To start, define

struct mmu_page {
	union {
		struct page;
		struct {
			unsigned long flags;
			unsigned long compound_head;
			unsigned char compound_dtor;
			unsigned char compound_order;
			atomic_t compound_mapcount;
			unsigned int compound_nr;
		};
	};
};

Now memmap becomes an array of struct mmu_pages instead of struct pages.

We also need to sort out the type returned from the page cache APIs.
Right now, it returns (effectively) the mmu_page.  I think it _should_
return the (arbitrary order) struct page, but auditing every caller of
every function is an inhuman job.

I can't see how to get there from here without a ridiculous number
of bugs.  Maybe you can.
