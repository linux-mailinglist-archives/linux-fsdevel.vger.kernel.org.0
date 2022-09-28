Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDEE5ED42A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 07:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiI1FQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 01:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiI1FQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:16:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BDE129689;
        Tue, 27 Sep 2022 22:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72514B81F0A;
        Wed, 28 Sep 2022 05:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B44C433D6;
        Wed, 28 Sep 2022 05:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664342203;
        bh=TrZdrt98AaL4pp/R0/mug1f7Dkwrizv/QN/dHVReiRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdLQfnA4sVDgd/kxFWnam01dbumZn0vP1lltt5BZ04fSCfFwgP+jMqdAp3IXB17wF
         dTJZFAPJhGMJX+EOMoUsoHqn5526pr9oqmsXJCwj8V+mOpIxL0woVh7355l9QLqvx4
         VIzKbf3/utpfcRk3FTBf01mmWlZKP1bk7u9fkPAZz2OukBBf6TqW9qPPrb1HWuieN9
         ECAjw4LkQytxFCrSk+jl1irtxw96LUrWXE+75qPav7tVEjnwtaN1f25msh03jF/152
         9TLCOBbzguQzK9ZqmU2S5XROFBbXa6YzaSN8IYqbCgyYExsNXrGULQewHIcZ4/BR3+
         /lrhAVHW4urcQ==
Date:   Tue, 27 Sep 2022 22:16:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iomap/xfs: fix data corruption due to stale
 cached iomaps
Message-ID: <YzPYuu7GtzoN4tB+@magnolia>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <Yyvjtpi49YSUej+w@magnolia>
 <20220922225934.GU3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922225934.GU3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:59:34AM +1000, Dave Chinner wrote:
> On Wed, Sep 21, 2022 at 09:25:26PM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 21, 2022 at 06:29:57PM +1000, Dave Chinner wrote:
> > > Hi folks,
> > > 
> > > THese patches address the data corruption first described here:
> > > 
> > > https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> > > 
> > > This data corruption has been seen in high profile production
> > > systems so there is some urgency to fix it. The underlying flaw is
> > > essentially a zero-day iomap bug, so whatever fix we come up with
> > > needs to be back portable to all supported stable kernels (i.e.
> > > ~4.18 onwards).
> > > 
> > > A combination of concurrent write()s, writeback IO completion, and
> > > memory reclaim combine to expose the fact that the cached iomap that
> > > is held across an iomap_begin/iomap_end iteration can become stale
> > > without the iomap iterator actor being aware that the underlying
> > > filesystem extent map has changed.
> > > 
> > > Hence actions based on the iomap state (e.g. is unwritten or newly
> > > allocated) may actually be incorrect as writeback actions may have
> > > changed the state (unwritten to written, delalloc to unwritten or
> > > written, etc). This affects partial block/page operations, where we
> > > may need to read from disk or zero cached pages depending on the
> > > actual extent state. Memory reclaim plays it's part here in that it
> > > removes pages containing partial state from the page cache, exposing
> > > future partial page/block operations to incorrect behaviour.
> > > 
> > > Really, we should have known that this would be a problem - we have
> > > exactly the same issue with cached iomaps for writeback, and the
> > > ->map_blocks callback that occurs for every filesystem block we need
> > > to write back is responsible for validating the cached iomap is
> > > still valid. The data corruption on the write() side is a result of
> > > not validating that the iomap is still valid before we initialise
> > > new pages and prepare them for data to be copied in to them....
> > > 
> > > I'm not really happy with the solution I have for triggering
> > > remapping of an iomap when the current one is considered stale.
> > > Doing the right thing requires both iomap_iter() to handle stale
> > > iomaps correctly (esp. the "map is invalid before the first actor
> > > operation" case), and it requires the filesystem
> > > iomap_begin/iomap_end operations to co-operate and be aware of stale
> > > iomaps.
> > > 
> > > There are a bunch of *nasty* issues around handling failed writes in
> > > XFS taht this has exposed - a failed write() that races with a
> > > mmap() based write to the same delalloc page will result in the mmap
> > > writes being silently lost if we punch out the delalloc range we
> > > allocated but didn't write to. g/344 and g/346 expose this bug
> > > directly if we punch out delalloc regions allocated by now stale
> > > mappings.
> > 
> > Yuck.  I'm pretty sure that callers (xfs_buffered_write_iomap_end) is
> > supposed to call truncate_pagecache_range with the invalidatelock (fka
> > MMAPLOCK) held.
> 
> Yup, there's multiple problems with this code; apart from
> recognising that it is obviously broken and definitely problematic,
> I haven't dug into it further.

...and I've been so buried in attending meetings and livedebug sessions
related to a 4.14 corruption that now I'm starved of time to fully think
through all the implications of this one. :(

> > > Then, because we can't punch out the delalloc we allocated region
> > > safely when we have a stale iomap, we have to ensure when we remap
> > > it the IOMAP_F_NEW flag is preserved so that the iomap code knows
> > > that it is uninitialised space that is being written into so it will
> > > zero sub page/sub block ranges correctly.
> > 
> > Hm.  IOMAP_F_NEW results in zeroing around, right?  So if the first
> > ->iomap_begin got a delalloc mapping, but by the time we got the folio
> > locked someone else managed to writeback and evict the page, we'd no
> > longer want that zeroing ... right?
> 
> Yes, and that is one of the sources of the data corruption - zeroing
> when we shouldn't.
> 
> There are multiple vectors to having a stale iomap here:
> 
> 1. we allocate the delalloc range, giving us IOMAP_DELALLOC and
>    IOMAP_F_NEW. Writeback runs, allocating the range as unwritten.
>    Even though the iomap is now stale, there is no data corruption
>    in this case because the range is unwritten and so we still need
>    zeroing.

...and I guess this at least happens more often now that writeback does
delalloc -> unwritten -> write -> unwritten conversion?

> 2. Same as above, but IO completion converts the range to written.
>    Data corruption occurs in this case because IOMAP_F_NEW causes
>    incorrect page cache zeroing to occur on partial page writes.
> 
> 3. We have an unwritten extent (prealloc, writeback in progress,
>    etc) so we have IOMAP_UNWRITTEN. These require zeroing,
>    regardless of whether IOMAP_F_NEW is set or not. Extent is
>    written behind our backs, unwritten conversion occurs, and now we
>    zero partial pages when we shouldn't.

Yikes.

> Other issues I've found:
> 
> 4. page faults can run the buffered write path concurrently with
>    write() because they aren't serialised against each other. Hence
>    we can have overlapping concurrent iomap_iter() operations with
>    different zeroing requirements and it's anyone's guess as to
>    which will win the race to the page lock and do the initial
>    zeroing. This is a potential silent mmap() write data loss
>    vector.

TBH I've long wondered why IOLOCK and MMAPLOCK both seemingly protected
pagecache operations but the buffered io paths never seemed to take the
MMAPLOCK, and if there was some subtle way things could go wrong.

> 5. anything that can modify the extent layout without holding the
>    i_rwsem exclusive can race with iomap iterating the extent list.
>    Holding the i_rwsem shared and modifying the extent list (e.g.
>    direct IO writes) can result in iomaps changing in the middle of,
>    say, buffered reads (e.g. hole->unwritten->written).

Yep.  I wonder, can this result in other incorrect write behavior that
you and I haven't thought of yet?

> IOWs, we must always treat iomaps that are returned by iomap_iter()
> to the actor functions as volatile and potentially invalid. If we
> are using folio locks to ensure only one task is accessing page
> cache data at any given time, then we *always* need to check that
> the iomap is valid once we have the folio locked. If the iomap is
> invalid, then we have to remap the file offset before deciding wht
> to do with the data in the page....

Agreed.

> > > As a result, ->iomap_begin() needs to know if the previous iomap was
> > > IOMAP_F_STALE, and if so, it needs to know if that previous iomap
> > > was IOMAP_F_NEW so it can propagate it to the remap.
> > > 
> > > So the fix is awful, messy, and I really, really don't like it. But
> > > I don't have any better ideas right now, and the changes as
> > > presented fix the reproducer for the original data corruption and
> > > pass fstests without and XFS regressions for block size <= page size
> > > configurations.
> > > 
> > > Thoughts?
> > 
> > I have a related question about another potential corruption vector in
> > writeback.  If write_cache_pages selects a folio for writeback, it'll
> > call clear_page_dirty_for_io to clear the PageDirty bit before handing
> > it to iomap_writepage, right?
> 
> Yes all interactions from that point onwards until we mark the folio
> as under writeback are done under the folio lock, so they should be
> atomic from the perspective of the data paths that dirty/clean the
> page.

<nod>

> > What happens if iomap_writepage_map errors out (say because ->map_blocks
> > returns an error) without adding the folio to any ioend?
> 
> Without reading further:
> 
> 1. if we want to retry the write, we folio_redirty_for_writepage(),
> unlock it and return with no error. Essentially we just skip over
> it.

If the fs isn't shut down, I guess we could redirty the page, though I
guess the problem is that the page is now stuck in dirty state until
xfs_scrub fixes the problem.  If it fixes the problem.

I think for bufferhead users it's nastier because we might have a
situation where pagedirty is unset but BH_Dirty is still set.  It
certainly is a problem on 4.14.

> 2. If we want to fail the write, we should call set_mapping_error()
> to record the failure for the next syscall to report and, maybe, set
> the error flag/clear the uptodate flag on the folio depending on
> whether we want the data to remain valid in memory or not.

<nod> That seems to be happening.  Sort of.

I think there's also a UAF in iomap_writepage_map -- if the folio is
unlocked and we cleared (or never set) PageWriteback, isn't it possible
that by the time we get to the mapping_set_error, the folio could have
been torn out of the page cache and reused somewhere else?

In which case, we're at best walking off a NULL mapping and crashing the
system, and at worst setting an IO error on the wrong mapping?

> > I think in
> > that case we'll follow the (error && !count) case, in which we unlock
> > the folio and exit without calling folio_redirty_for_writepage, right?
> > The error will get recorded in the mapping for the next fsync, I think,
> > but I also wonder if we *should* redirty because the mapping failed, not
> > the attempt at persistence.
> 
> *nod*
> 
> I think the question that needs to be answered here is this: in what
> case is an error being returned from ->map_blocks a recoverable
> error that a redirty + future writeback retry will succeed?
> 
> AFAICT, all cases from XFS this is a fatal error (e.g. corruption of
> the BMBT), so the failure will persist across all attempts to retry
> the write?
> 
> Perhaps online repair will change this (i.e. in the background
> repair fixes the BMBT corruption and so the next attempt to write
> the data will succeed) so I can see that we *might* need to redirty
> the page in this case, but....

...but I don't know that we can practically wait for repairs to happen
because the page is now stuck in dirty state indefinitely.

> > This isn't a problem for XFS because the next buffered write will mark
> > the page dirty again, but I've been trawling through the iomap buffer
> > head code (because right now we have a serious customer escalation on
> > 4.14) and I noticed that we never clear the dirty state on the buffer
> > heads.  gfs2 is the only user of iomap buffer head code, but that stands
> > out as something that doesn't quite smell right.  I /think/ this is a
> > result of XFS dropping buffer heads in 4.19, hoisting the writeback
> > framework to fs/iomap/ in 5.5, and only adding buffer heads back to
> > iomap later.
> 
> Seems plausible.

Though, more awkwardly, iomap has no idea if a given page has
bufferheads attached to it.  So I guess we could add that call if the
->map_blocks function sets IOMAP_F_BUFFER_HEAD on wpc->iomap... but gfs2
doesn't do that.

> > The reason I even noticed this at all is because of what 4.14 does --
> > back in those days, initiating writeback on a page clears the dirty
> > bit from the attached buffer heads in xfs_start_buffer_writeback.  If
> > xfs_writepage_map fails to initiate any writeback IO at all, then it
> > simply unlocks the page and exits without redirtying the page.  IOWs, it
> > causes the page and buffer head state to become inconsistent, because
> > now the page thinks it is clean but the BHs think they are dirty.
> > 
> > Worse yet, if userspace responds to the EIO by reissuing the write()
> > calls, the write code will see BH_Dirty set on the buffer and doesn't
> > even try to set PageDirty, which means ... that the page never gets
> > written to disk again!
> > 
> > There are three questions in my mind:
> > 
> > A. Upstream iomap writeback code doesn't change (AFAICT) the buffer head
> > dirty state.  I don't know if this is really broken?  Or maybe gfs2 just
> > doesn't notice or care?
> 
> You'd need to talk to the GFS2 ppl about that - I haven't paid any
> attention to the iomap bufferhead code and so I have no idea what
> constraints it is operating under or what bufferhead state GFS2 even
> needs...

Yeah.  gfs2 doesn't always set it, too.  I think it only uses it for
journalled file data.

> > B. Should writeback be redirtying any folios that aren't added to an
> > ioend?  I'm not sure that doing so is correct, since writeback to a
> > shutdown filesystem won't clear the dirty pages.
> 
> See above - I think the action depends on the error being returned.
> If it's a fatal error that can never succeed in future (e.g.  fs is
> shutdown), then we should not redirty the page and just error it
> out. If it's not a fatal error, then *maybe* we should be redirtying
> the page. Of course, this can lead to dirty pages that can never be
> written.....

<nod>

> > C. Gotta figure out why our 4.14 kernel doesn't initiate writeback.
> > At this point we're pretty sure it's because we're actually hitting the
> > same RCA as commit d9252d526ba6 ("xfs: validate writeback mapping using
> > data fork seq counter").  Given the (stale) data it has, it never
> > manages to get a valid mapping, and just... exits xfs_map_blocks without
> > doing anything.
> 
> I haven't looked at any code that old for a long while, so I can't
> really help you there... :/

Well yeah, let's focus on upstream and I'll help our internal teams deal
with UEK5.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
