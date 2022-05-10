Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57128520AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 03:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiEJBaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 21:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiEJBaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 21:30:35 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB021286E8
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 18:26:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 18C1710E6967;
        Tue, 10 May 2022 11:26:36 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1noEe4-00A70G-DZ; Tue, 10 May 2022 11:26:36 +1000
Date:   Tue, 10 May 2022 11:26:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 00/10] Make O_SYNC writethrough
Message-ID: <20220510012636.GB2306852@dread.disaster.area>
References: <20220503064008.3682332-1-willy@infradead.org>
 <20220505045821.GA1949718@dread.disaster.area>
 <YnNbf9dPhJ3FiHzH@casper.infradead.org>
 <20220505070534.GB1949718@dread.disaster.area>
 <6aeb8359-a31c-0832-61fe-ff6dc18b30c5@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aeb8359-a31c-0832-61fe-ff6dc18b30c5@opensource.wdc.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6279bf4e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=qqbEPULYKHmJKffmjx8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 06, 2022 at 09:03:40PM +0900, Damien Le Moal wrote:
> On 2022/05/05 16:05, Dave Chinner wrote:
> > On Thu, May 05, 2022 at 06:07:11AM +0100, Matthew Wilcox wrote:
> >> On Thu, May 05, 2022 at 02:58:21PM +1000, Dave Chinner wrote:
> >>> On Tue, May 03, 2022 at 07:39:58AM +0100, Matthew Wilcox (Oracle) wrote:
> >>>> This is very much in development and basically untested, but Damian
> >>>> started describing to me something that he wanted, and I told him he
> >>>> was asking for the wrong thing, and I already had this patch series
> >>>> in progress.  If someone wants to pick it up and make it mergable,
> >>>> that'd be grand.
> >>>
> >>> That've very non-descriptive. Saying "someone wanted something, I said it's
> >>> wrong, so here's a patch series about something else" doesn't tell me anything
> >>> about the problem that Damien was trying to solve.
> >>
> >> Sorry about that.  I was a bit jet-lagged when I wrote it.
> >>
> >>>> The idea is that an O_SYNC write is always going to want to write, and
> >>>> we know that at the time we're storing into the page cache.  So for an
> >>>> otherwise clean folio, we can skip the part where we dirty the folio,
> >>>> find the dirty folios and wait for their writeback.
> >>>
> >>> What exactly is this shortcut trying to optimise away? A bit of CPU
> >>> time?
> >>>
> >>> O_SYNC is already a write-through operation - we just call
> >>> filemap_write_and_wait_range() once we've copied the data into the
> >>> page cache and dirtied the page. What does skipping the dirty page
> >>> step gain us?
> >>
> >> Two things; the original reason I was doing this, and Damien's reason.
> >>
> >> My reason: a small write to a large folio will cause the entire folio to
> >> be dirtied and written.
> > 
> > If that's a problem, then shouldn't we track sub-folio dirty
> > regions? Because normal non-O_SYNC buffered writes will still cause
> > this to happen...
> > 
> >> This is unnecessary with O_SYNC; we're about
> >> to force the write anyway; we may as well do the write of the part of
> >> the folio which is modified, and skip the whole dirtying step.
> > 
> > What happens when another part of the folio is concurrently dirtied?
> > 
> > What happens if the folio already has other parts of it under
> > writeback? How do we avoid and/or resolve concurent "partial folio
> > writeback" race conditions?
> > 
> >> Damien's reason: It's racy.  Somebody else (... even vmscan) could cause
> >> folios to be written out of order.  This matters for ZoneFS because
> >> writing a file out of order is Not Allowed.  He was looking at relaxing
> >> O_DIRECT, but I think what he really wants is a writethrough page cache.
> > 
> > Zonefs has other mechanisms to solve this. It already has the
> > inode_lock() to serialise all dio writes to a zone because they must
> > be append IOs. i.e. new writes must be located at the write pointer,
> > and the write pointer does not get incremented until the IO
> > has been submitted (for DIO+AIO) or completed (for non-AIO).
> > 
> > Hence for buffered writes, we have the same situation: once we have
> > sampled the zone write pointer to get the offset, we cannot start
> > another write until the current IO has been submitted.
> > 
> > Further, for zonefs, we cannot get another write to that page cache
> > page *ever*; we can only get reads from it. Hence page state really
> > doesn't matter at all - once there is data in the page cache page,
> > all that can happen is it can be invalidated but it cannot change
> > (ah, the beauties of write-once media!). Hence the dirty state is
> > completely meaningless from a coherency and integrity POV, as is the
> > writeback state.
> > 
> > IOWs, for zonefs we can already ignore the page dirtying and
> > writeback mechanisms fairly safely. Hence we could do something like
> > this in the zonefs buffered write path:
> > 
> > - lock the inode
> > - sample the write pointer to get the file offset
> > - instantiate a page cache folio at the given offset
> > - copy the data into the folio, mark it up to date.
> > - mark it as under writeback or lock the folio to keep reclaim away
> > - add the page cache folio to an iter_iov
> > - pass the iter_iov to the direct IO write path to submit the IO and
> >   wait for completion.
> > - clear the folio writeback state.
> > - move the write pointer
> > - unlock the inode
> 
> That was my initial idea. When I talked about it with Matthew, he mentioned his
> write-through work and posted it. For my use case, I do like what he has done
> since that would avoid the need to add most of the above machinery to zonefs.
> But if there are no benefits anywhere else, adding this as a zonefs only thing
> is fine with me.

I figured as much, but I wanted to get it documented and to set the
context of being able to use the existing DIO path for the
write-through functionality. Because...

> 
> > and that gets us writethrough O_SYNC buffered writes. In fact, I
> > think it may even work with async writes, too, just like the DIO
> > write path seems to work with AIO.
> 
> Yes, I think this all works for AIOs too since we use the "soft" write pointer
> position updated on BIO submit, not completion.
> 
> > The best part about the above mechanism is that there is
> > almost no new iomap, page cache or direct IO functionality required
> > to do this. All the magic is all in the zonefs sequential zone write
> > path. Hence I don't see needing to substantially modify the iomap
> > buffered write path to do zonefs write-through....
> 
> Indeed. The only additional constraint is that zonefs must still ensure that
> writes are physical block aligned to avoid iomap attempting to do a
> read-modify-rewrite of the last written sector of a zone.

Well, we get that with page cache IO - the IO still has to be
filesystem block sized and shaped, adn the page cache has to handle
instantiate of data within the folio/page in the case that buffered
write IO does not align to filesystem blocks.

> Just need to think
> about potential corner cases when the page size is larger than the device block
> size. Could the partially filled last page of a file ever end-up needing a
> read-modify-write ? I do not think so, but need to check.

Yes, if the page is getting marked up to date as a whole during the
write. In that case, the portion of the page that has current data
over it needs to read in before the page can be marked up to date.
If you are doing repeated partial page extension writes, the page
should already have the data in it and be up to date before the new
extending write adds more data to the page. Hence it's only really a
problem for the initial cold cache write....

> > IOWs, what we actually need is a clean page cache write-through
> > model that doesn't have any nasty quirks or side effects. IOWs, I
> > think you are on the right conceptual path, just the wrong
> > architectural path.
> > 
> > My preference would be for the page cache write-through mode to be a
> > thin shim over the DIO write path. The DIO write path is a highly
> > concurrent async IO engine - it's designed to handle everything
> > AIO and io_uring can throw at it. Forget about "direct IO", just
> > treat it as a high concurrency, high throughput async IO engine.
> > 
> > Hence for page cache write-through, all we do is instantiate the
> > page cache page, lock it, copy the data into it and then pass it to
> > the direct IO write implementation to submit it and then unlock it
> > on completion.  There's nothing else we really need to do - the DIO
> > path already handles everything else.
> 
> Yes ! And the special case for zonefs would actually implement almost exactly
> this, modulo the additional requirement of the write alignment that is purely
> due to zonefs/device constraint.

Right - if we have a model like this, then zonefs can likely just
use the generic implementation as we may well need the
cold-cache-partial-tail-read operations in the generic write-through
case, too. That was why I initially outlined the zonefs-specific
implementation above - it shows how a generic implementation can
support even constrained filesystems like zonefs or sub-page partial
IO on block size < page size filesystems....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
