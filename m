Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0965C5EEB85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 04:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiI2CPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 22:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiI2CPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9D10952C;
        Wed, 28 Sep 2022 19:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0917E61AD2;
        Thu, 29 Sep 2022 02:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660A1C433D7;
        Thu, 29 Sep 2022 02:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664417727;
        bh=k2wflFgQECzPufVWTIiUxC7W+iON7k0EvxVQlitKNZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jmzhf9wzYUFIDKe6epFS2KMsQj/U1Avnfky0FL3FMC+CzfYZOEC2GTH36nAJ1tPQF
         4f4FYTuLfiw1gYNnL6dLn712yt9ib3YNmBz5ktvgNYxniSvetmCqsx0equWnHUL3hk
         GIA6kJMlLQxGiWGqyk6wK1/zeAuVvtnCnJA0IKM+2Y6ASGc2AJQxQUHFygcAhmbq6D
         ExN0EQCEW3nSJmKVUP5HSZKQOShO/QUd0mJoFwf3EH/DM2XPCxu2kbm6QbG4Ijz3C+
         3bEsMwBp7t5o4gH3vgR+xcnrW70C0dEbz7MkTxmM9k8Kp2wORUk+bDHV9oxOtskoU4
         e10GAgLls1aOQ==
Date:   Wed, 28 Sep 2022 19:15:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iomap/xfs: fix data corruption due to stale
 cached iomaps
Message-ID: <YzT/vk6lABR/jSvl@magnolia>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <Yyvjtpi49YSUej+w@magnolia>
 <20220922225934.GU3600936@dread.disaster.area>
 <YzPYuu7GtzoN4tB+@magnolia>
 <20220929021128.GF3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929021128.GF3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:11:28PM +1000, Dave Chinner wrote:
> On Tue, Sep 27, 2022 at 10:16:42PM -0700, Darrick J. Wong wrote:
> > On Fri, Sep 23, 2022 at 08:59:34AM +1000, Dave Chinner wrote:
> > > On Wed, Sep 21, 2022 at 09:25:26PM -0700, Darrick J. Wong wrote:
> > > > On Wed, Sep 21, 2022 at 06:29:57PM +1000, Dave Chinner wrote:
> > > > > Hi folks,
> > > > > 
> > > > > THese patches address the data corruption first described here:
> > > > > 
> > > > > https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> > > > > 
> > > > > This data corruption has been seen in high profile production
> > > > > systems so there is some urgency to fix it. The underlying flaw is
> > > > > essentially a zero-day iomap bug, so whatever fix we come up with
> > > > > needs to be back portable to all supported stable kernels (i.e.
> > > > > ~4.18 onwards).
> > > > > 
> > > > > A combination of concurrent write()s, writeback IO completion, and
> > > > > memory reclaim combine to expose the fact that the cached iomap that
> > > > > is held across an iomap_begin/iomap_end iteration can become stale
> > > > > without the iomap iterator actor being aware that the underlying
> > > > > filesystem extent map has changed.
> > > > > 
> > > > > Hence actions based on the iomap state (e.g. is unwritten or newly
> > > > > allocated) may actually be incorrect as writeback actions may have
> > > > > changed the state (unwritten to written, delalloc to unwritten or
> > > > > written, etc). This affects partial block/page operations, where we
> > > > > may need to read from disk or zero cached pages depending on the
> > > > > actual extent state. Memory reclaim plays it's part here in that it
> > > > > removes pages containing partial state from the page cache, exposing
> > > > > future partial page/block operations to incorrect behaviour.
> > > > > 
> > > > > Really, we should have known that this would be a problem - we have
> > > > > exactly the same issue with cached iomaps for writeback, and the
> > > > > ->map_blocks callback that occurs for every filesystem block we need
> > > > > to write back is responsible for validating the cached iomap is
> > > > > still valid. The data corruption on the write() side is a result of
> > > > > not validating that the iomap is still valid before we initialise
> > > > > new pages and prepare them for data to be copied in to them....
> > > > > 
> > > > > I'm not really happy with the solution I have for triggering
> > > > > remapping of an iomap when the current one is considered stale.
> > > > > Doing the right thing requires both iomap_iter() to handle stale
> > > > > iomaps correctly (esp. the "map is invalid before the first actor
> > > > > operation" case), and it requires the filesystem
> > > > > iomap_begin/iomap_end operations to co-operate and be aware of stale
> > > > > iomaps.
> > > > > 
> > > > > There are a bunch of *nasty* issues around handling failed writes in
> > > > > XFS taht this has exposed - a failed write() that races with a
> > > > > mmap() based write to the same delalloc page will result in the mmap
> > > > > writes being silently lost if we punch out the delalloc range we
> > > > > allocated but didn't write to. g/344 and g/346 expose this bug
> > > > > directly if we punch out delalloc regions allocated by now stale
> > > > > mappings.
> > > > 
> > > > Yuck.  I'm pretty sure that callers (xfs_buffered_write_iomap_end) is
> > > > supposed to call truncate_pagecache_range with the invalidatelock (fka
> > > > MMAPLOCK) held.
> > > 
> > > Yup, there's multiple problems with this code; apart from
> > > recognising that it is obviously broken and definitely problematic,
> > > I haven't dug into it further.
> > 
> > ...and I've been so buried in attending meetings and livedebug sessions
> > related to a 4.14 corruption that now I'm starved of time to fully think
> > through all the implications of this one. :(
> > 
> > > > > Then, because we can't punch out the delalloc we allocated region
> > > > > safely when we have a stale iomap, we have to ensure when we remap
> > > > > it the IOMAP_F_NEW flag is preserved so that the iomap code knows
> > > > > that it is uninitialised space that is being written into so it will
> > > > > zero sub page/sub block ranges correctly.
> > > > 
> > > > Hm.  IOMAP_F_NEW results in zeroing around, right?  So if the first
> > > > ->iomap_begin got a delalloc mapping, but by the time we got the folio
> > > > locked someone else managed to writeback and evict the page, we'd no
> > > > longer want that zeroing ... right?
> > > 
> > > Yes, and that is one of the sources of the data corruption - zeroing
> > > when we shouldn't.
> > > 
> > > There are multiple vectors to having a stale iomap here:
> > > 
> > > 1. we allocate the delalloc range, giving us IOMAP_DELALLOC and
> > >    IOMAP_F_NEW. Writeback runs, allocating the range as unwritten.
> > >    Even though the iomap is now stale, there is no data corruption
> > >    in this case because the range is unwritten and so we still need
> > >    zeroing.
> > 
> > ...and I guess this at least happens more often now that writeback does
> > delalloc -> unwritten -> write -> unwritten conversion?
> 
> *nod*
> 
> > > 2. Same as above, but IO completion converts the range to written.
> > >    Data corruption occurs in this case because IOMAP_F_NEW causes
> > >    incorrect page cache zeroing to occur on partial page writes.
> > > 
> > > 3. We have an unwritten extent (prealloc, writeback in progress,
> > >    etc) so we have IOMAP_UNWRITTEN. These require zeroing,
> > >    regardless of whether IOMAP_F_NEW is set or not. Extent is
> > >    written behind our backs, unwritten conversion occurs, and now we
> > >    zero partial pages when we shouldn't.
> > 
> > Yikes.
> > 
> > > Other issues I've found:
> > > 
> > > 4. page faults can run the buffered write path concurrently with
> > >    write() because they aren't serialised against each other. Hence
> > >    we can have overlapping concurrent iomap_iter() operations with
> > >    different zeroing requirements and it's anyone's guess as to
> > >    which will win the race to the page lock and do the initial
> > >    zeroing. This is a potential silent mmap() write data loss
> > >    vector.
> > 
> > TBH I've long wondered why IOLOCK and MMAPLOCK both seemingly protected
> > pagecache operations but the buffered io paths never seemed to take the
> > MMAPLOCK, and if there was some subtle way things could go wrong.
> 
> We can't take MMAPLOCK in the buffered IO path because the user
> buffer could be a mmap()d range of the same file and we need to be
> able to fault in those pages during copyin/copyout. Hence we can't
> hold the MMAPLOCK across iomap_iter(), nor across
> .iomap_begin/.iomap_end context pairs.

Ahh, right, I forgot that case. >:O

> taking the MMAPLOCK and dropping it again can be done in iomap_begin
> or iomap_end, as long as those methods aren't called from the page
> fault path....
> 
> > > 5. anything that can modify the extent layout without holding the
> > >    i_rwsem exclusive can race with iomap iterating the extent list.
> > >    Holding the i_rwsem shared and modifying the extent list (e.g.
> > >    direct IO writes) can result in iomaps changing in the middle of,
> > >    say, buffered reads (e.g. hole->unwritten->written).
> > 
> > Yep.  I wonder, can this result in other incorrect write behavior that
> > you and I haven't thought of yet?
> 
> Entirely possible - this code is complex and there are lots of very
> subtle interactions and we've already found several bonus broken
> bits as a result. Hence I wouldn't be surprised if we've missed
> other subtle issues and/or not fully grokked the implications of the
> broken bits we've found...
> 
> [....]
> 
> > > > What happens if iomap_writepage_map errors out (say because ->map_blocks
> > > > returns an error) without adding the folio to any ioend?
> > > 
> > > Without reading further:
> > > 
> > > 1. if we want to retry the write, we folio_redirty_for_writepage(),
> > > unlock it and return with no error. Essentially we just skip over
> > > it.
> > 
> > If the fs isn't shut down, I guess we could redirty the page, though I
> > guess the problem is that the page is now stuck in dirty state until
> > xfs_scrub fixes the problem.  If it fixes the problem.
> > 
> > I think for bufferhead users it's nastier because we might have a
> > situation where pagedirty is unset but BH_Dirty is still set.  It
> > certainly is a problem on 4.14.
> > 
> > > 2. If we want to fail the write, we should call set_mapping_error()
> > > to record the failure for the next syscall to report and, maybe, set
> > > the error flag/clear the uptodate flag on the folio depending on
> > > whether we want the data to remain valid in memory or not.
> > 
> > <nod> That seems to be happening.  Sort of.
> > 
> > I think there's also a UAF in iomap_writepage_map -- if the folio is
> > unlocked and we cleared (or never set) PageWriteback, isn't it possible
> > that by the time we get to the mapping_set_error, the folio could have
> > been torn out of the page cache and reused somewhere else?
> 
> We still have a reference to the folio at this point from the lookup
> in write_cache_pages(). Hence the folio can't be freed while we are
> running iomap_writepage_map().
> 
> However, we have unlocked the folio, and we don't hold either the IO
> lock or the invalidate lock and so the folio could get punched out
> of the page cache....
> 
> > In which case, we're at best walking off a NULL mapping and crashing the
> > system, and at worst setting an IO error on the wrong mapping?
> 
> Yes, I think so - we could walk off a NULL mapping here,
> but because write_cache_pages() still holds a page reference, the
> page won't get freed from under us so we won't ever see the wrong
> mapping being set here.
> 
> I think we could fix that simply by using inode->i_mapping instead
> of folio->mapping...

Oh.  Yes.  I'll get on that tomorrow.

> > > > I think in
> > > > that case we'll follow the (error && !count) case, in which we unlock
> > > > the folio and exit without calling folio_redirty_for_writepage, right?
> > > > The error will get recorded in the mapping for the next fsync, I think,
> > > > but I also wonder if we *should* redirty because the mapping failed, not
> > > > the attempt at persistence.
> > > 
> > > *nod*
> > > 
> > > I think the question that needs to be answered here is this: in what
> > > case is an error being returned from ->map_blocks a recoverable
> > > error that a redirty + future writeback retry will succeed?
> > > 
> > > AFAICT, all cases from XFS this is a fatal error (e.g. corruption of
> > > the BMBT), so the failure will persist across all attempts to retry
> > > the write?
> > > 
> > > Perhaps online repair will change this (i.e. in the background
> > > repair fixes the BMBT corruption and so the next attempt to write
> > > the data will succeed) so I can see that we *might* need to redirty
> > > the page in this case, but....
> > 
> > ...but I don't know that we can practically wait for repairs to happen
> > because the page is now stuck in dirty state indefinitely.
> 
> *nod*
> 
> So do we treat it as fatal for now, and revisit it later when online
> repair might be able to do something better here? 

Sounds good to me.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
