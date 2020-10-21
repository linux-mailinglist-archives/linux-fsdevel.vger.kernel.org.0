Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C995C2954B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 00:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502255AbgJUWOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 18:14:40 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57107 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502060AbgJUWOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 18:14:40 -0400
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 20EA458CF5A;
        Thu, 22 Oct 2020 09:14:36 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kVMNP-002yDm-1U; Thu, 22 Oct 2020 09:14:35 +1100
Date:   Thu, 22 Oct 2020 09:14:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201021221435.GR7391@dread.disaster.area>
References: <20201020014357.GW20115@casper.infradead.org>
 <20201020045928.GO7391@dread.disaster.area>
 <20201020112138.GZ20115@casper.infradead.org>
 <20201020211634.GQ7391@dread.disaster.area>
 <20201020225331.GE20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020225331.GE20115@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
        a=7-415B0cAAAA:8 a=512na9dZCLelpKU4a54A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:53:31PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 21, 2020 at 08:16:34AM +1100, Dave Chinner wrote:
> > On Tue, Oct 20, 2020 at 12:21:38PM +0100, Matthew Wilcox wrote:
> > > On Tue, Oct 20, 2020 at 03:59:28PM +1100, Dave Chinner wrote:
> > > > On Tue, Oct 20, 2020 at 02:43:57AM +0100, Matthew Wilcox wrote:
> > > > > This is a weird one ... which is good because it means the obvious
> > > > > ones have been fixed and now I'm just tripping over the weird cases.
> > > > > And fortunately, xfstests exercises the weird cases.
> > > > > 
> > > > > 1. The file is 0x3d000 bytes long.
> > > > > 2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
> > > > > 3. We simulate a read error for 0x3c000-0x3cfff
> > > > > 4. Userspace writes to 0x3d697 to 0x3dfaa
> > > > 
> > > > So this is a write() beyond EOF, yes?
> > > > 
> > > > If yes, then we first go through this path:
> > > > 
> > > > 	xfs_file_buffered_aio_write()
> > > > 	  xfs_file_aio_write_checks()
> > > > 	    iomap_zero_range(isize, pos - isize)
> > > > 
> > > > To zero the region between the current EOF and where the new write
> > > > starts. i.e. from 0x3d000 to 0x3d696.
> > > 
> > > Yes.  That calls iomap_write_begin() which calls iomap_split_page()
> > > which is where we run into trouble.  I elided the exact path from the
> > > description of the problem.
> > > 
> > > > > 5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
> > > > >    so it calls iomap_split_page() (passing page 0x3d)
> > > > 
> > > > Splitting the page because it's !Uptodate seems rather drastic to
> > > > me.  Why does it need to split the page here?
> > > 
> > > Because we can't handle Dirty, !Uptodate THPs in the truncate path.
> > > Previous discussion:
> > > https://lore.kernel.org/linux-mm/20200821144021.GV17456@casper.infradead.org/
> > 
> > Maybe I'm just dense, but this doesn't explain the reason for
> > needing to split THPs during partial THP invalidation, nor the
> > reason why we need to split THPs when the write path sees a
> > partially up to date THP. iomap is supposed to be tracking the
> > sub-page regions that are not up to date, so why would we ever need
> > to split the page to get sub-page regions into the correct state?
> 
> True, we don't _have to_ split THP on holepunch/truncation/... but it's
> a better implementation to free pages which cover blocks that no longer
> have data associated with them.

"Better" is a very subjective measure. What numbers do you have
to back that up?

e.g. if we are just punching a 4kB hole in a range covered by a THP,
then breaking up the THP is, IMO, exactly the wrong thing to do.
Just zeroing it out via iomap_zero_range() has much lower overhead
and is far simpler than breaking up the THP just to remove a single
page from the range...

> > FWIW, didn't you change the dirty tracking to be done sub-page and
> > held in the iomap_page? If so, releasing the iomap_page on a partial
> > page invalidation looks ... problematic. i.e. not only are you
> > throwing away the per-block up-to-date state on a THP, you're alos
> > throwing away the per-block dirty state.
> 
> That wasn't my patch.  Also, discarding the iomap_page causes the entire
> page to be treated as a single unit.  So if we lose per-block state,
> and the page is marked as dirty, then each subpage (that remains after
> the holepunch) will be treated as dirty.

That really sounds like something that your patchset needs to do,
though. You're jumping through hoops to handle untracked partial
THP page state that add complexity, but you can avoid all this with
a relatively simple change...

> > > The current assumption is that a !Uptodate THP is due to a read error,
> > > and so the sensible thing to do is split it and handle read errors at
> > > a single-page level.
> > 
> > Why? Apart from the range of the file coverd by the page, how is
> > handling a read error at a single page level any different from
> > handling it at a THP level?
> > 
> > Alternatively, if there's a read error on THP-based readahead, then
> > why isn't the entire THP tossed away when a subsequent read sees
> > PageError() so it can then be re-read synchronously into the cache
> > using single pages?
> 
> Splitting the page instead of throwing it away makes sense once we can
> transfer the Uptodate bits to each subpage.  If we don't have that,
> it doesn't really matter which we do.

Sounds like more required functionality...

> > > We do that in iomap_readpage_actor().  Had the readahead I/O not "failed",
> > > we'd've had an Uptodate THP which straddled EOF.
> > 
> > If the IO error in a THP is the trigger for bad things here, then
> > surely the correct thing to do is trash the THP on IO error, not
> > leave a landmine that every path has to handle specially...
> 
> Can't split a page on I/O error -- split_huge_page() has to be called
> from process context and we get notified about the error in BH context.

That's exactly why we have workqueues on the write IO completion
path - much of the write completion work we do must execute in a
context where we can take sleeping locks, block, issue more IO, etc.

IOWs, if the THP read IO fails, punt it to a workqueue to do the
page split and update the page error states.

CHeers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
