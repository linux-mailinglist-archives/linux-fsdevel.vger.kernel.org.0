Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66F053C41D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiFCFUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiFCFUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:20:53 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 180202A71E;
        Thu,  2 Jun 2022 22:20:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1CE805EC50D;
        Fri,  3 Jun 2022 15:20:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwzjr-0024P8-N0; Fri, 03 Jun 2022 15:20:47 +1000
Date:   Fri, 3 Jun 2022 15:20:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <20220603052047.GJ1098723@dread.disaster.area>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area>
 <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <20220602220625.GG1098723@dread.disaster.area>
 <B186E2FB-BCAF-4019-9DFF-9FF05BAC557E@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B186E2FB-BCAF-4019-9DFF-9FF05BAC557E@fb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62999a32
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=Xvn0XkXP7fblPhEtvuMA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Chris, can you lne wrap your emails at 72 columns, please? ]

On Fri, Jun 03, 2022 at 01:29:40AM +0000, Chris Mason wrote:
> > On Jun 2, 2022, at 6:06 PM, Dave Chinner <david@fromorbit.com>
> > wrote: On Thu, Jun 02, 2022 at 11:32:30AM -0400, Johannes Weiner
> > wrote:
> >> On Thu, Jun 02, 2022 at 04:52:52PM +1000, Dave Chinner wrote:
> >>> On Wed, Jun 01, 2022 at 02:13:42PM +0000, Chris Mason wrote:
> >>>> In prod, bpftrace showed looping on a single inode inside a
> >>>> mysql cgroup. That inode was usually in the middle of being
> >>>> deleted, i_size set to zero, but it still had 40-90 pages
> >>>> sitting in the xarray waiting for truncation. We’d loop
> >>>> through the whole call path above over and over again, mostly
> >>>> because writepages() was returning progress had been made on
> >>>> this one inode. The redirty_page_for_writepage() path does
> >>>> drop wbc->nr_to_write, so the rest of the writepages
> >>>> machinery believes real work is being done. nr_to_write is
> >>>> LONG_MAX, so we’ve got a while to loop.
> >>> 
> >>> Yup, this code relies on truncate making progress to avoid
> >>> looping forever. Truncate should only block on the page while
> >>> it locks it and waits for writeback to complete, then it gets
> >>> forcibly invalidated and removed from the page cache.
> >> 
> >> It's not looping forever, truncate can just take a relatively
> >> long time during which the flusher is busy-spinning full bore
> >> on a relatively small number of unflushable pages
> >> (range_cyclic).
> >> 
> >> But you raise a good point asking "why is truncate stuck?". I
> >> first thought they might be cannibalizing each other over the
> >> page locks, but that wasn't it (and wouldn't explain the clear
> >> asymmetry between truncate and flusher). That leaves the
> >> waiting for writeback. I just confirmed with tracing that
> >> that's exactly where truncate sits while the flusher goes
> >> bananas on the same inode. So the race must be this:
> >> 
> >> truncate: flusher put a subset of pages under writeback
> >> i_size_write(0) wait_on_page_writeback() loop with range_cyclic
> >> over remaining dirty >EOF pages
> > 
> > But write_cache_pages() doesn't repeatedly loop over the
> > pages.
> > 
> > The flusher is
> > 
> > ->writepages iomap_writepages write_cache_pages() loop over
> > mapping tree lock page iomap_do_writepage set_page_writeback()
> > add page to ioend <end of mapping reached> iomap_submit_ioend()
> > <pages under writeback get sent for IO> return to high level
> > writeback
> > 
> > And eventually IO completion will clear page writeback state.
> > 
> 
> Yes, this is actually happening before the truncate starts.  The
> truncate finds these writeback pages and waits for them to finish
> IO, and while it’s waiting wb_check_background_flush() goes wild
> on the redirty path.

I still don't think the redirty path is the underlying problem. Yes,
it triggers it, but it looks to be triggering an existing behaviour
that the writeback path should not have...

> > i.e. write_cache_pages() should not be hard looping over the
> > pages beyond EOF even if range_cyclic is set - it's skipping
> > those pages, submitting any that are under writeback, and the,
> > going back to high level code for it to make a decision about
> > continuation of writeback. It may call back down and we loop
> > over dirty pages beyond EOF again, but the flusher should not be
> > holding on to pages under writeback for any signification length
> > of time before they are submitted for IO.
> > 
> 
> I spent a while trying to blame write_cache_pages() for looping
> repeatedly, and ended up making a series of bpftrace scripts that
> collected call stack frequency counters for all the different ways
> to wander into write_cache_pages().  I eventually ran it across
> 100K systems to figure out exactly how we were getting into
> trouble.  It was (thankfully) really consistent.
> 
> As you describe above, the loops are definitely coming from higher
> in the stack.  wb_writeback() will loop as long as
> __writeback_inodes_wb() returns that it’s making progress and
> we’re still globally over the bg threshold, so write_cache_pages()
> is just being called over and over again.  We’re coming from
> wb_check_background_flush(), so:
> 
>                 struct wb_writeback_work work = {
>                         .nr_pages       = LONG_MAX,
>                         .sync_mode      = WB_SYNC_NONE,
>                         .for_background = 1,
>                         .range_cyclic   = 1,
>                         .reason         = WB_REASON_BACKGROUND,
>                 };

Sure, but we end up in writeback_sb_inodes() which does this after
the __writeback_single_inode()->do_writepages() call that iterates
the dirty pages:

               if (need_resched()) {
                        /*
                         * We're trying to balance between building up a nice
                         * long list of IOs to improve our merge rate, and
                         * getting those IOs out quickly for anyone throttling
                         * in balance_dirty_pages().  cond_resched() doesn't
                         * unplug, so get our IOs out the door before we
                         * give up the CPU.
                         */
                        blk_flush_plug(current->plug, false);
                        cond_resched();
                }

So if there is a pending IO completion on this CPU on a work queue
here, we'll reschedule to it because the work queue kworkers are
bound to CPUs and they take priority over user threads.

Also, this then requeues the inode of the b_more_io queue, and
wb_check_background_flush() won't come back to it until all other
inodes on all other superblocks on the bdi have had writeback
attempted. So if the system truly is over the background dirty
threshold, why is writeback getting stuck on this one inode in this
way?

> > IOWs, if truncate is getting stuck waiting on writeback, then that
> > implies something is holding up IO completions for a long time,
> 
> From Johannes’s tracing today, that’s about 17us.

Which means there should only be a delay of 17us between IO completion
being queued on this CPU and the flusher thread being preempted and
completion being run, right?

> Our victim cgroup has just a handful of files, so we can burn
> through a lot of write_cache_pages loops in the time truncate is
> waiting for a single IO on a relatively fast ssd.

Yes, I'm not denying that, but background writeback when over global
dirty thresholds should not be spinning on a single inode with
50-100 pages attached to it. It should visit it, try to flush it,
and then move on to the next.

> > not
> > that there's a problem in writeback submission. i.e. you might
> > actually be looking at a workqueue backlog
> 
> I actually think a workqueue backlog is coming from the flusher
> thread hogging the CPU.

I can't see how that happens with that need_resched() check in
writeback_sb_inodes().

> The investigation started by looking for long tail latencies in
> write() systemcalls, and Domas’s original finding was IO
> completion workers were waiting for CPUs.  That’s how he ended up
> finding the redirty calls using high levels of CPU.  We honestly
> won’t be sure until we live patch a lot of boxes and look for long
> tail latency improvements, but I’m pretty optimistic.

Something still doesn't add up. I don't see how submission spinning
is holding off completion because it plays nice with resched
checks. You're now saying that this started because someone found
long tail completion latencies, and that explains truncate getting
stuck. But AFAICT the writeback behaviour isn't responsible for
completion latencies as writeback will give up the CPU to any other
thread scheduled to run on that CPU pretty quickly.

It feels like there still something unknown behaviour here, and it
still smells to me like IO completions are getting backed up by
something. I wonder - are there large files getting written using
buffered IO on these machines? Commit ebb7fb1557b1 ("xfs, iomap:
limit individual ioend chain lengths in writeback") might be
relevant if that is the case....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
