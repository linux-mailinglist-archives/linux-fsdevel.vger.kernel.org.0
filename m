Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FDD53DEF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 01:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348623AbiFEXcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 19:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbiFEXcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:32:19 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECB2F17E3F;
        Sun,  5 Jun 2022 16:32:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4E11F10E70B8;
        Mon,  6 Jun 2022 09:32:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nxzjB-0039qy-9W; Mon, 06 Jun 2022 09:32:13 +1000
Date:   Mon, 6 Jun 2022 09:32:13 +1000
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
Message-ID: <20220605233213.GN1098723@dread.disaster.area>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area>
 <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <20220602220625.GG1098723@dread.disaster.area>
 <B186E2FB-BCAF-4019-9DFF-9FF05BAC557E@fb.com>
 <20220603052047.GJ1098723@dread.disaster.area>
 <YpojbvB/+wPqHT8y@cmpxchg.org>
 <c3620e1f-91c5-777c-4193-2478c69a033c@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3620e1f-91c5-777c-4193-2478c69a033c@fb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=629d3d00
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=WK0IlTMwbJH2blhR84wA:9 a=QEXdDO2ut3YA:10 a=igBNqPyMv6gA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:09:06PM -0400, Chris Mason wrote:
> [ From a different message, Dave asks wtf my email client was doing. Thanks
> Dave, apparently exchange is being exchangey with base64 in unpredictable
> ways.  This was better in my test reply, lets see. ]
> 
> On 6/3/22 11:06 AM, Johannes Weiner wrote:
> > Hello Dave,
> > 
> > On Fri, Jun 03, 2022 at 03:20:47PM +1000, Dave Chinner wrote:
> > > On Fri, Jun 03, 2022 at 01:29:40AM +0000, Chris Mason wrote:
> > > > As you describe above, the loops are definitely coming from higher
> > > > in the stack.  wb_writeback() will loop as long as
> > > > __writeback_inodes_wb() returns that it’s making progress and
> > > > we’re still globally over the bg threshold, so write_cache_pages()
> > > > is just being called over and over again.  We’re coming from
> > > > wb_check_background_flush(), so:
> > > > 
> > > >                  struct wb_writeback_work work = {
> > > >                          .nr_pages       = LONG_MAX,
> > > >                          .sync_mode      = WB_SYNC_NONE,
> > > >                          .for_background = 1,
> > > >                          .range_cyclic   = 1,
> > > >                          .reason         = WB_REASON_BACKGROUND,
> > > >                  };
> > > 
> > > Sure, but we end up in writeback_sb_inodes() which does this after
> > > the __writeback_single_inode()->do_writepages() call that iterates
> > > the dirty pages:
> > > 
> > >                 if (need_resched()) {
> > >                          /*
> > >                           * We're trying to balance between building up a nice
> > >                           * long list of IOs to improve our merge rate, and
> > >                           * getting those IOs out quickly for anyone throttling
> > >                           * in balance_dirty_pages().  cond_resched() doesn't
> > >                           * unplug, so get our IOs out the door before we
> > >                           * give up the CPU.
> > >                           */
> > >                          blk_flush_plug(current->plug, false);
> > >                          cond_resched();
> > >                  }
> > > 
> > > So if there is a pending IO completion on this CPU on a work queue
> > > here, we'll reschedule to it because the work queue kworkers are
> > > bound to CPUs and they take priority over user threads.
> > 
> > The flusher thread is also a kworker, though. So it may hit this
> > cond_resched(), but it doesn't yield until the timeslice expires.

17us or 10ms, it doesn't matter. The fact is the writeback thread
will give up the CPU long before the latency durations (seconds)
that were reported upthread are seen. Writeback spinning can
not explain why truncate is not making progress - everything points
to it being a downstream symptom, not a cause.

Also important to note, as we are talking about kworker sheduling
hold-offs, the writeback flusher work is unbound (can run on any
CPU), whilst the IO completion workers in XFS are per-CPU and bound
to individual CPUs. Bound kernel tasks usually take run queue
priority on a CPU over unbound and/or user tasks that can be punted
to a different CPU. So, again, with this taken into account I don't
see how the flusher thread consuming CPU would cause long duration
hold-offs of IO completion work....

> Just to underline this, the long tail latencies aren't softlockups or major
> explosions.  It's just suboptimal enough that different metrics and
> dashboards noticed it.

Sure, but you've brought a problem we don't understand the root
cause of to my attention. I want to know what the root cause is so
that I can determine that there are no other unknown underlying
issues that are contributing to this issue.

Nothing found so far explains why truncate is not making progress
and that's what *I* need to understand here. Sure, go ahead and
patch your systems to get rid of the bad writeback looping
behaviour, but that does not explain or solve the underlying long IO
completion tail latency issue that originally lead to finding
writeback spinning.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
