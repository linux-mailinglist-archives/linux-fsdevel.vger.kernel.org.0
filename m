Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F0B410E54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 04:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhITCTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhITCTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 22:19:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8AC061574;
        Sun, 19 Sep 2021 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oUwId34IF+axzORff1TzY+UskLBGEaHAwq3VifaXgN8=; b=N+5nxDY9xjGDULQjNX63zx7FIM
        Pji+0rueFcVQfoKvtSHPG9+EdwQ3YXRh+HK2bov/KO0H8THxt1hphjd7kQUA9NDWgvCK/wzO3fDeU
        f7C/aXzxLyeAR0hQ7TiRkt432ao/u+yazD6RnKm95iEvXt1BVNT4avkuu1AyU4gMmXq6jCrAS7CVr
        YDcpc12bCHsPPmJD+0vfTWzBhNbMMxLlj2+j4ISzTXDIdeusNO3mYuuIO4QZN/SOLfHrbyos6eSbB
        V7RRZuifaBwQ+H7RmXMgrgoppf58v2A7TT2VGXieDj/80AD8WuyLFtbjPx4JtmcAHYHYPAp/pSdG7
        AtU3AUdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mS8rr-002JoN-Oz; Mon, 20 Sep 2021 02:17:27 +0000
Date:   Mon, 20 Sep 2021 03:17:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUfvK3h8w+MmirDF@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTu9HIu+wWWvZLxp@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> Q: Oh yeah, but what again are folios for, exactly?
> 
> Folios are for cached filesystem data which (importantly) may be mapped to
> userspace.
> 
> So when MM people see a new data structure come up with new references to page
> size - there's a very good reason with that, which is that we need to be
> allocating in multiples of the hardware page size if we're going to be able to
> map it to userspace and have PTEs point to it.
> 
> So going forward, if the MM people want struct page to refer to muliple hardware
> pages - this shouldn't prevent that, and folios will refer to multiples of the
> _hardware_ page size, not struct page pagesize.
> 
> Also - all the filesystem code that's being converted tends to talk and thing in
> units of pages. So going forward, it would be a nice cleanup to get rid of as
> many of those references as possible and just talk in terms of bytes (e.g. I
> have generally been trying to get rid of references to PAGE_SIZE in bcachefs
> wherever reasonable, for other reasons) - those cleanups are probably for
> another patch series, and in the interests of getting this patch series merged
> with the fewest introduced bugs possible we probably want the current helpers.

I'd like to thank those who reached out off-list.  Some of you know I've
had trouble with depression in the past, and I'd like to reassure you
that that's not a problem at the moment.  I had a good holiday, and I
was able to keep from thinking about folios most of the time.

I'd also like to thank those who engaged in the discussion while I was
gone.  A lot of good points have been made.  I don't think the normal
style of replying to each email individually makes a lot of sense at
this point, so I'll make some general comments instead.  I'll respond
to the process issues on the other thread.

I agree with the feeling a lot of people have expressed, that struct page
is massively overloaded and we would do much better with stronger typing.
I like it when the compiler catches bugs for me.  Disentangling struct
page is something I've been working on for a while, and folios are a
step in that direction (in that they remove the two types of tail page
from the universe of possibilities).

I don't believe it is realistic to disentangle file pages and anon
pages from each other.  Thanks to swap and shmem, both file pages and
anon pages need to be able to be moved in and out of the swap cache.
The swap cache shares a lot of code with the page cache, so changing
how the swap cache works is also tricky.

What I do believe is possible is something Kent hinted at; treating anon
pages more like file pages.  I also believe that shmem should be able to
write pages to swap without moving the pages into the swap cache first.
But these two things are just beliefs.  I haven't tried to verify them
and they may come to nothing.

I also want to split out slab_page and page_table_page from struct page.
I don't intend to convert either of those to folios.

I do want to make struct page dynamically allocated (and have for
a while).  There are some complicating factors ...

There are two primary places where we need to map from a physical
address to a "memory descriptor".  The one that most people care about
is get_user_pages().  We have a page table entry and need to increment
the refcount on the head page, possibly mark the head page dirty, but
also return the subpage of any compound page we find.  The one that far
fewer people care about is memory-failure.c; we also need to find the
head page to determine what kind of memory has been affected, but we
need to mark the subpage as HWPoison.

Both of these need to be careful to not confuse tail and non-tail pages.
So yes, we need to use folios for anything that's mappable to userspace.
That's not just anon & file pages but also network pools, graphics card
memory and vmalloc memory.  Eventually, I think struct page actually goes
down to a union of a few words of padding, along with ->compound_head.
Because that's all we're guaranteed is actually there; everything else
is only there in head pages.

There are a lot of places that should use folios which the current
patchset doesn't convert.  I prioritised filesystems because we've got
~60 filesystems to convert, and working on the filesystems can proceed
in parallel with working on the rest of the MM.  Also, if I converted
the entire MM at once, there would be complaints that a 600 patch series
was unreviewable.  So here we are, there's a bunch of compatibility code
that indicates areas which still need to be converted.

I'm sure I've missed things, but I've been working on this email all
day and wanted to send it out before going to sleep.
