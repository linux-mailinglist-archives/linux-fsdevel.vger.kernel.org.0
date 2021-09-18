Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA32410288
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhIRBGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 21:06:08 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42375 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhIRBGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 21:06:07 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A65A61050EE2;
        Sat, 18 Sep 2021 11:04:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mROmW-00Diuy-B5; Sat, 18 Sep 2021 11:04:40 +1000
Date:   Sat, 18 Sep 2021 11:04:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210918010440.GK1756565@dread.disaster.area>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUTC6O0w3j7i8iDm@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=0nqi6NygBYswCuMazx8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:31:36PM -0400, Johannes Weiner wrote:
> My question for fs folks is simply this: as long as you can pass a
> folio to kmap and mmap and it knows what to do with it, is there any
> filesystem relevant requirement that the folio map to 1 or more
> literal "struct page", and that folio_page(), folio_nr_pages() etc be
> part of the public API?

In the short term, yes, we need those things in the public API.
In the long term, not so much.

We need something in the public API that tells us the offset and
size of the folio. Lots of page cache code currently does stuff like
calculate the size or iteration counts based on the difference of
page->index values (i.e. number of pages) and iterate page by page.
A direct conversion of such algorithms increments by
folio_nr_pages() instead of 1. So stuff like this is definitely
necessary as public APIs in the initial conversion.

Let's face it, folio_nr_pages() is a huge improvement on directly
exposing THP/compound page interfaces to filesystems and leaving
them to work it out for themselves. So even in the short term, these
API members represent a major step forward in mm API cleanliness.

As for long term, everything in the page cache API needs to
transition to byte offsets and byte counts instead of units of
PAGE_SIZE and page->index. That's a more complex transition, but
AFAIA that's part of the future work Willy is intended to do with
folios and the folio API. Once we get away from accounting and
tracking everything as units of struct page, all the public facing
APIs that use those units can go away.

It's fairly slow to do this, because we have so much code that is
doing stuff like converting file offsets between byte counts and
page counts and vice versa. And it's not necessary to do an initial
conversion to folios, either. But once everything in the page cache
indexing API moves to byte ranges, the need to count pages, use page
counts are ranges, iterate by page index, etc all goes away and
hence those APIs can also go away.

As for converting between folios and pages, we'll need those sorts
of APIs for the foreseeable future because low level storage layers
and hardware use pages for their scatter gather arrays and at some
point we've got to expose those pages from behind the folio API.
Even if we replace struct page with some other hardware page
descriptor, we're still going to need such translation APIs are some
point in the stack....

> Or can we keep this translation layer private
> to MM code? And will page_folio() be required for anything beyond the
> transitional period away from pages?

No idea, but as per above I think it's a largely irrelevant concern
for the forseeable future because pages will be here for a long time
yet.

> Can we move things not used outside of MM into mm/internal.h, mark the
> transitional bits of the public API as such, and move on?

Sure, but that's up to you to do as a patch set on top of Willy's
folio trees if you think it improves the status quo.  Write the
patches and present them for review just like everyone else does,
and they can be discussed on their merits in that context rather
than being presented as a reason for blocking current progress on
folios.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
