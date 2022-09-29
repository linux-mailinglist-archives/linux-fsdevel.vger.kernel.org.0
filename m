Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676F85EEB76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 04:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiI2CLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 22:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiI2CLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:11:35 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 795A3106A14;
        Wed, 28 Sep 2022 19:11:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 74B791100EC2;
        Thu, 29 Sep 2022 12:11:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1odj1M-00DOIH-5V; Thu, 29 Sep 2022 12:11:28 +1000
Date:   Thu, 29 Sep 2022 12:11:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iomap/xfs: fix data corruption due to stale
 cached iomaps
Message-ID: <20220929021128.GF3600936@dread.disaster.area>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <Yyvjtpi49YSUej+w@magnolia>
 <20220922225934.GU3600936@dread.disaster.area>
 <YzPYuu7GtzoN4tB+@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzPYuu7GtzoN4tB+@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=6334fed1
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=wJG8Qe-dKeRbcGPIRh8A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:16:42PM -0700, Darrick J. Wong wrote:
> On Fri, Sep 23, 2022 at 08:59:34AM +1000, Dave Chinner wrote:
> > On Wed, Sep 21, 2022 at 09:25:26PM -0700, Darrick J. Wong wrote:
> > > On Wed, Sep 21, 2022 at 06:29:57PM +1000, Dave Chinner wrote:
> > > > Hi folks,
> > > > 
> > > > THese patches address the data corruption first described here:
> > > > 
> > > > https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> > > > 
> > > > This data corruption has been seen in high profile production
> > > > systems so there is some urgency to fix it. The underlying flaw is
> > > > essentially a zero-day iomap bug, so whatever fix we come up with
> > > > needs to be back portable to all supported stable kernels (i.e.
> > > > ~4.18 onwards).
> > > > 
> > > > A combination of concurrent write()s, writeback IO completion, and
> > > > memory reclaim combine to expose the fact that the cached iomap that
> > > > is held across an iomap_begin/iomap_end iteration can become stale
> > > > without the iomap iterator actor being aware that the underlying
> > > > filesystem extent map has changed.
> > > > 
> > > > Hence actions based on the iomap state (e.g. is unwritten or newly
> > > > allocated) may actually be incorrect as writeback actions may have
> > > > changed the state (unwritten to written, delalloc to unwritten or
> > > > written, etc). This affects partial block/page operations, where we
> > > > may need to read from disk or zero cached pages depending on the
> > > > actual extent state. Memory reclaim plays it's part here in that it
> > > > removes pages containing partial state from the page cache, exposing
> > > > future partial page/block operations to incorrect behaviour.
> > > > 
> > > > Really, we should have known that this would be a problem - we have
> > > > exactly the same issue with cached iomaps for writeback, and the
> > > > ->map_blocks callback that occurs for every filesystem block we need
> > > > to write back is responsible for validating the cached iomap is
> > > > still valid. The data corruption on the write() side is a result of
> > > > not validating that the iomap is still valid before we initialise
> > > > new pages and prepare them for data to be copied in to them....
> > > > 
> > > > I'm not really happy with the solution I have for triggering
> > > > remapping of an iomap when the current one is considered stale.
> > > > Doing the right thing requires both iomap_iter() to handle stale
> > > > iomaps correctly (esp. the "map is invalid before the first actor
> > > > operation" case), and it requires the filesystem
> > > > iomap_begin/iomap_end operations to co-operate and be aware of stale
> > > > iomaps.
> > > > 
> > > > There are a bunch of *nasty* issues around handling failed writes in
> > > > XFS taht this has exposed - a failed write() that races with a
> > > > mmap() based write to the same delalloc page will result in the mmap
> > > > writes being silently lost if we punch out the delalloc range we
> > > > allocated but didn't write to. g/344 and g/346 expose this bug
> > > > directly if we punch out delalloc regions allocated by now stale
> > > > mappings.
> > > 
> > > Yuck.  I'm pretty sure that callers (xfs_buffered_write_iomap_end) is
> > > supposed to call truncate_pagecache_range with the invalidatelock (fka
> > > MMAPLOCK) held.
> > 
> > Yup, there's multiple problems with this code; apart from
> > recognising that it is obviously broken and definitely problematic,
> > I haven't dug into it further.
> 
> ...and I've been so buried in attending meetings and livedebug sessions
> related to a 4.14 corruption that now I'm starved of time to fully think
> through all the implications of this one. :(
> 
> > > > Then, because we can't punch out the delalloc we allocated region
> > > > safely when we have a stale iomap, we have to ensure when we remap
> > > > it the IOMAP_F_NEW flag is preserved so that the iomap code knows
> > > > that it is uninitialised space that is being written into so it will
> > > > zero sub page/sub block ranges correctly.
> > > 
> > > Hm.  IOMAP_F_NEW results in zeroing around, right?  So if the first
> > > ->iomap_begin got a delalloc mapping, but by the time we got the folio
> > > locked someone else managed to writeback and evict the page, we'd no
> > > longer want that zeroing ... right?
> > 
> > Yes, and that is one of the sources of the data corruption - zeroing
> > when we shouldn't.
> > 
> > There are multiple vectors to having a stale iomap here:
> > 
> > 1. we allocate the delalloc range, giving us IOMAP_DELALLOC and
> >    IOMAP_F_NEW. Writeback runs, allocating the range as unwritten.
> >    Even though the iomap is now stale, there is no data corruption
> >    in this case because the range is unwritten and so we still need
> >    zeroing.
> 
> ...and I guess this at least happens more often now that writeback does
> delalloc -> unwritten -> write -> unwritten conversion?

*nod*

> > 2. Same as above, but IO completion converts the range to written.
> >    Data corruption occurs in this case because IOMAP_F_NEW causes
> >    incorrect page cache zeroing to occur on partial page writes.
> > 
> > 3. We have an unwritten extent (prealloc, writeback in progress,
> >    etc) so we have IOMAP_UNWRITTEN. These require zeroing,
> >    regardless of whether IOMAP_F_NEW is set or not. Extent is
> >    written behind our backs, unwritten conversion occurs, and now we
> >    zero partial pages when we shouldn't.
> 
> Yikes.
> 
> > Other issues I've found:
> > 
> > 4. page faults can run the buffered write path concurrently with
> >    write() because they aren't serialised against each other. Hence
> >    we can have overlapping concurrent iomap_iter() operations with
> >    different zeroing requirements and it's anyone's guess as to
> >    which will win the race to the page lock and do the initial
> >    zeroing. This is a potential silent mmap() write data loss
> >    vector.
> 
> TBH I've long wondered why IOLOCK and MMAPLOCK both seemingly protected
> pagecache operations but the buffered io paths never seemed to take the
> MMAPLOCK, and if there was some subtle way things could go wrong.

We can't take MMAPLOCK in the buffered IO path because the user
buffer could be a mmap()d range of the same file and we need to be
able to fault in those pages during copyin/copyout. Hence we can't
hold the MMAPLOCK across iomap_iter(), nor across
.iomap_begin/.iomap_end context pairs.

taking the MMAPLOCK and dropping it again can be done in iomap_begin
or iomap_end, as long as those methods aren't called from the page
fault path....

> > 5. anything that can modify the extent layout without holding the
> >    i_rwsem exclusive can race with iomap iterating the extent list.
> >    Holding the i_rwsem shared and modifying the extent list (e.g.
> >    direct IO writes) can result in iomaps changing in the middle of,
> >    say, buffered reads (e.g. hole->unwritten->written).
> 
> Yep.  I wonder, can this result in other incorrect write behavior that
> you and I haven't thought of yet?

Entirely possible - this code is complex and there are lots of very
subtle interactions and we've already found several bonus broken
bits as a result. Hence I wouldn't be surprised if we've missed
other subtle issues and/or not fully grokked the implications of the
broken bits we've found...

[....]

> > > What happens if iomap_writepage_map errors out (say because ->map_blocks
> > > returns an error) without adding the folio to any ioend?
> > 
> > Without reading further:
> > 
> > 1. if we want to retry the write, we folio_redirty_for_writepage(),
> > unlock it and return with no error. Essentially we just skip over
> > it.
> 
> If the fs isn't shut down, I guess we could redirty the page, though I
> guess the problem is that the page is now stuck in dirty state until
> xfs_scrub fixes the problem.  If it fixes the problem.
> 
> I think for bufferhead users it's nastier because we might have a
> situation where pagedirty is unset but BH_Dirty is still set.  It
> certainly is a problem on 4.14.
> 
> > 2. If we want to fail the write, we should call set_mapping_error()
> > to record the failure for the next syscall to report and, maybe, set
> > the error flag/clear the uptodate flag on the folio depending on
> > whether we want the data to remain valid in memory or not.
> 
> <nod> That seems to be happening.  Sort of.
> 
> I think there's also a UAF in iomap_writepage_map -- if the folio is
> unlocked and we cleared (or never set) PageWriteback, isn't it possible
> that by the time we get to the mapping_set_error, the folio could have
> been torn out of the page cache and reused somewhere else?

We still have a reference to the folio at this point from the lookup
in write_cache_pages(). Hence the folio can't be freed while we are
running iomap_writepage_map().

However, we have unlocked the folio, and we don't hold either the IO
lock or the invalidate lock and so the folio could get punched out
of the page cache....

> In which case, we're at best walking off a NULL mapping and crashing the
> system, and at worst setting an IO error on the wrong mapping?

Yes, I think so - we could walk off a NULL mapping here,
but because write_cache_pages() still holds a page reference, the
page won't get freed from under us so we won't ever see the wrong
mapping being set here.

I think we could fix that simply by using inode->i_mapping instead
of folio->mapping...

> > > I think in
> > > that case we'll follow the (error && !count) case, in which we unlock
> > > the folio and exit without calling folio_redirty_for_writepage, right?
> > > The error will get recorded in the mapping for the next fsync, I think,
> > > but I also wonder if we *should* redirty because the mapping failed, not
> > > the attempt at persistence.
> > 
> > *nod*
> > 
> > I think the question that needs to be answered here is this: in what
> > case is an error being returned from ->map_blocks a recoverable
> > error that a redirty + future writeback retry will succeed?
> > 
> > AFAICT, all cases from XFS this is a fatal error (e.g. corruption of
> > the BMBT), so the failure will persist across all attempts to retry
> > the write?
> > 
> > Perhaps online repair will change this (i.e. in the background
> > repair fixes the BMBT corruption and so the next attempt to write
> > the data will succeed) so I can see that we *might* need to redirty
> > the page in this case, but....
> 
> ...but I don't know that we can practically wait for repairs to happen
> because the page is now stuck in dirty state indefinitely.

*nod*

So do we treat it as fatal for now, and revisit it later when online
repair might be able to do something better here? 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
