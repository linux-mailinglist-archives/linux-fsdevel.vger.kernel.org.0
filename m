Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAA294469
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 23:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409793AbgJTVQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 17:16:41 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33206 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409790AbgJTVQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:16:40 -0400
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4F5E258C093;
        Wed, 21 Oct 2020 08:16:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kUyzi-002cD8-B3; Wed, 21 Oct 2020 08:16:34 +1100
Date:   Wed, 21 Oct 2020 08:16:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201020211634.GQ7391@dread.disaster.area>
References: <20201020014357.GW20115@casper.infradead.org>
 <20201020045928.GO7391@dread.disaster.area>
 <20201020112138.GZ20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020112138.GZ20115@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
        a=7-415B0cAAAA:8 a=3MSxnCdPCWzHt-A28tsA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:21:38PM +0100, Matthew Wilcox wrote:
> On Tue, Oct 20, 2020 at 03:59:28PM +1100, Dave Chinner wrote:
> > On Tue, Oct 20, 2020 at 02:43:57AM +0100, Matthew Wilcox wrote:
> > > This is a weird one ... which is good because it means the obvious
> > > ones have been fixed and now I'm just tripping over the weird cases.
> > > And fortunately, xfstests exercises the weird cases.
> > > 
> > > 1. The file is 0x3d000 bytes long.
> > > 2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
> > > 3. We simulate a read error for 0x3c000-0x3cfff
> > > 4. Userspace writes to 0x3d697 to 0x3dfaa
> > 
> > So this is a write() beyond EOF, yes?
> > 
> > If yes, then we first go through this path:
> > 
> > 	xfs_file_buffered_aio_write()
> > 	  xfs_file_aio_write_checks()
> > 	    iomap_zero_range(isize, pos - isize)
> > 
> > To zero the region between the current EOF and where the new write
> > starts. i.e. from 0x3d000 to 0x3d696.
> 
> Yes.  That calls iomap_write_begin() which calls iomap_split_page()
> which is where we run into trouble.  I elided the exact path from the
> description of the problem.
> 
> > > 5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
> > >    so it calls iomap_split_page() (passing page 0x3d)
> > 
> > Splitting the page because it's !Uptodate seems rather drastic to
> > me.  Why does it need to split the page here?
> 
> Because we can't handle Dirty, !Uptodate THPs in the truncate path.
> Previous discussion:
> https://lore.kernel.org/linux-mm/20200821144021.GV17456@casper.infradead.org/

Maybe I'm just dense, but this doesn't explain the reason for
needing to split THPs during partial THP invalidation, nor the
reason why we need to split THPs when the write path sees a
partially up to date THP. iomap is supposed to be tracking the
sub-page regions that are not up to date, so why would we ever need
to split the page to get sub-page regions into the correct state?

i.e. why do THPs need to be handled any differently to a block size
< page size situation with a normal PAGE_SIZE page?

FWIW, didn't you change the dirty tracking to be done sub-page and
held in the iomap_page? If so, releasing the iomap_page on a partial
page invalidation looks ... problematic. i.e. not only are you
throwing away the per-block up-to-date state on a THP, you're alos
throwing away the per-block dirty state.

i.e. we still need that per-block state to be maintained once the
THP has been split - the split pages should be set to the correct
state held on the THP as the split progresses. IOWs, I suspect that
split_huge_page() needs to call into iomap to determine the actual
state of each individual sub-page from the iomap_page state attached
to the huge page.

> The current assumption is that a !Uptodate THP is due to a read error,
> and so the sensible thing to do is split it and handle read errors at
> a single-page level.

Why? Apart from the range of the file coverd by the page, how is
handling a read error at a single page level any different from
handling it at a THP level?

Alternatively, if there's a read error on THP-based readahead, then
why isn't the entire THP tossed away when a subsequent read sees
PageError() so it can then be re-read synchronously into the cache
using single pages?

> I've been playing around with creating THPs in the write path, and that
> offers a different pathway to creating Dirty, !Uptodate THPs, so this
> may also change at some point.  I'd like to get what I have merged and
> then figure out how to make this better.

Sure. However, again, splitting THPs in this situation makes no
sense to me. I can't see why we don't just treat them like a normal
page and the sub-page !uptodate range filling algorithms just do
their normal work on them...

> > Also, this concerns me: if we are exposing the cached EOF page via
> > mmap, it needs to contain only zeroes in the region beyond EOF so
> > that we don't expose stale data to userspace. Hence when a THP that
> > contains EOF is instantiated, we have to ensure that the region
> > beyond EOF is compeltely zeroed. It then follows that if we read all
> > the data in that THP up to EOF, then the page is actually up to
> > date...
> 
> We do that in iomap_readpage_actor().  Had the readahead I/O not "failed",
> we'd've had an Uptodate THP which straddled EOF.

If the IO error in a THP is the trigger for bad things here, then
surely the correct thing to do is trash the THP on IO error, not
leave a landmine that every path has to handle specially...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
