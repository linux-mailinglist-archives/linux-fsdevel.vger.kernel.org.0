Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D8542027
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352049AbiFHASN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587907AbiFGXxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:53:50 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 117825EDEA;
        Tue,  7 Jun 2022 15:52:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C06E35EC5CF;
        Wed,  8 Jun 2022 08:52:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nyi3P-003w7D-R2; Wed, 08 Jun 2022 08:52:03 +1000
Date:   Wed, 8 Jun 2022 08:52:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <20220607225203.GV227878@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da9984a7-a3f1-8a62-f2ca-f8f6d4321e80@fb.com>
 <Yp4TWwLrNM1Lhwq3@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=629fd697
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=gt4SOwb8OZzSaSjGkrgA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 11:13:18AM -0400, Chris Mason wrote:
> On Mon, Jun 06, 2022 at 10:46:51AM -0400, Johannes Weiner wrote:
> > Hello,
> > 
> > On Mon, Jun 06, 2022 at 09:32:13AM +1000, Dave Chinner wrote:
> > > On Fri, Jun 03, 2022 at 12:09:06PM -0400, Chris Mason wrote:
> > > > On 6/3/22 11:06 AM, Johannes Weiner wrote:
> > > > > On Fri, Jun 03, 2022 at 03:20:47PM +1000, Dave Chinner wrote:
> > > > > > On Fri, Jun 03, 2022 at 01:29:40AM +0000, Chris Mason wrote:
> > > > > > > As you describe above, the loops are definitely coming from higher
> > > > > > > in the stack.  wb_writeback() will loop as long as
> > > > > > > __writeback_inodes_wb() returns that it’s making progress and
> > > > > > > we’re still globally over the bg threshold, so write_cache_pages()
> > > > > > > is just being called over and over again.  We’re coming from
> > > > > > > wb_check_background_flush(), so:
> > > > > > > 
> > > > > > >                  struct wb_writeback_work work = {
> > > > > > >                          .nr_pages       = LONG_MAX,
> > > > > > >                          .sync_mode      = WB_SYNC_NONE,
> > > > > > >                          .for_background = 1,
> > > > > > >                          .range_cyclic   = 1,
> > > > > > >                          .reason         = WB_REASON_BACKGROUND,
> > > > > > >                  };
> > > > > > 
> > > > > > Sure, but we end up in writeback_sb_inodes() which does this after
> > > > > > the __writeback_single_inode()->do_writepages() call that iterates
> > > > > > the dirty pages:
> > > > > > 
> > > > > >                 if (need_resched()) {
> > > > > >                          /*
> > > > > >                           * We're trying to balance between building up a nice
> > > > > >                           * long list of IOs to improve our merge rate, and
> > > > > >                           * getting those IOs out quickly for anyone throttling
> > > > > >                           * in balance_dirty_pages().  cond_resched() doesn't
> > > > > >                           * unplug, so get our IOs out the door before we
> > > > > >                           * give up the CPU.
> > > > > >                           */
> > > > > >                          blk_flush_plug(current->plug, false);
> > > > > >                          cond_resched();
> > > > > >                  }
> > > > > > 
> > > > > > So if there is a pending IO completion on this CPU on a work queue
> > > > > > here, we'll reschedule to it because the work queue kworkers are
> > > > > > bound to CPUs and they take priority over user threads.
> > > > > 
> > > > > The flusher thread is also a kworker, though. So it may hit this
> > > > > cond_resched(), but it doesn't yield until the timeslice expires.
> > > 
> > > 17us or 10ms, it doesn't matter. The fact is the writeback thread
> > > will give up the CPU long before the latency durations (seconds)
> > > that were reported upthread are seen. Writeback spinning can
> > > not explain why truncate is not making progress - everything points
> > > to it being a downstream symptom, not a cause.
> > 
> > Chris can clarify, but I don't remember second-long latencies being
> > mentioned. Rather sampling periods of multiple seconds during which
> > the spin bursts occur multiple times.

The initial commit said "long tail latencies for write IOs" without
specifying an amount.

In general, long latencies in IO mean seconds, even on SSDs,
especially for writes. If the write requires allocation to be done
we then have to run completion transactions to convert extents to
written. The transaction reservation in completion can get stuck for
seconds if the journal is full and requires waiting on tail pushing.
We can have thousands of IO completions in flight (ever noticed XFS
have several thousand completion kworker threads in the process
listings?) which can then all block in a FIFO queue waiting for
journal space, and getting journal space might involve waiting for
tens of thousands of metadata IOs to complete....

So when anyone says "long tail latencies for write IO" I'm thinking
seconds to tens of seconds because tens to hundreds of milliseconds
for completion latencies is pretty common and somewhat unavoidable
on heavily loaded filesystems....

> > > Also important to note, as we are talking about kworker sheduling
> > > hold-offs, the writeback flusher work is unbound (can run on any
> > > CPU), whilst the IO completion workers in XFS are per-CPU and bound
> > > to individual CPUs. Bound kernel tasks usually take run queue
> > > priority on a CPU over unbound and/or user tasks that can be punted
> > > to a different CPU.
> > 
> > Is that actually true? I'm having trouble finding the corresponding
> > code in the scheduler.

I can't remember exactly which bit of the scheduler code does this
because the scheduler code is completely different every time I look
at it. The behaviour has been around for a long time - the workqueue
thread pools largely rely on bound kthread tasks pre-empting user
tasks to get scheduled work done with low latencies....

> > That said, I'm not sure it matters that much. Even if you take CPU
> > contention out of the equation entirely, I think we agree it's not a
> > good idea (from a climate POV) to have CPUs busywait on IO. Even if
> > that IO is just an ordinary wait_on_page_writeback() on a fast drive.
> > 
> > So if we can get rid of the redirtying, and it sounds like we can, IMO
> > we should just go ahead and do so.

As I've said multiple times now, yes, we should fix that, and I've
pointed out how it should be fixed. I'm waiting for a new patch
to be posted to fix that behaviour while I'm also trying to get to
the bottom of what is causing the truncate hold-offs.

> > > > Just to underline this, the long tail latencies aren't softlockups or major
> > > > explosions.  It's just suboptimal enough that different metrics and
> > > > dashboards noticed it.
> > > 
> > > Sure, but you've brought a problem we don't understand the root
> > > cause of to my attention. I want to know what the root cause is so
> > > that I can determine that there are no other unknown underlying
> > > issues that are contributing to this issue.
> > 
> > It seems to me we're just not on the same page on what the reported
> > bug is. From my POV, there currently isn't a missing piece in this
> > puzzle. But Chris worked closer with the prod folks on this, so I'll
> > leave it to him :)
> 
> The basic description of the investigation:
> 
> * Multiple hits per hour on per 100K machines, but almost impossible to
> catch across a single box.
> * The debugging information from the long tail detector showed high IO and
> high CPU time.  (high CPU is relative here, these machines tend to be IO
> bound).
> * Kernel stack analysis showed IO completion threads waiting for CPU.
> * CPU profiling showed redirty_page_for_writepage() dominating.

Right, that's what I thought was described - high CPU load was
occuring from re-dirtying, but ithere's also high IO load and CPU
load is not obviously the cause of the high IO load or IO latencies.
I'm more interested in what is causing the IO latencies because the
high CPU looks to be a downstream symptom of the high IO latencies,
not the cause....

> From here we made a relatively simple reproduction of the
> redirty_page_for_writepage() part of the problem.  It's a good fix in
> isolation, but we'll have to circle back to see how much of the long tail
> latency issue it solves.
> 
> We can livepatch it quickly, but filtering out the long tail latency hits
> for just this one bug is labor intensive, so it'll take a little bit of time
> to get good data.
> 
> I've got a v2 of the patch that drops the invalidate, doing a load test with
> fsx this morning and then getting a second xfstests baseline run to see if
> I've added new failures.

Thanks!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
