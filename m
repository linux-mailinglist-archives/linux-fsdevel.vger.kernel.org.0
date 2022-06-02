Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717BE53C09D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 00:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiFBWGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 18:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiFBWG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:06:29 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 797DF344D3;
        Thu,  2 Jun 2022 15:06:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BC1F05EC4CD;
        Fri,  3 Jun 2022 08:06:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwsxV-001xA9-1q; Fri, 03 Jun 2022 08:06:25 +1000
Date:   Fri, 3 Jun 2022 08:06:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Mason <clm@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <20220602220625.GG1098723@dread.disaster.area>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area>
 <YpjYDjeR2Wpx3ImB@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YpjYDjeR2Wpx3ImB@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62993463
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=c6t9A_BoYkh8vOYkvQ8A:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:32:30AM -0400, Johannes Weiner wrote:
> On Thu, Jun 02, 2022 at 04:52:52PM +1000, Dave Chinner wrote:
> > On Wed, Jun 01, 2022 at 02:13:42PM +0000, Chris Mason wrote:
> > > In prod, bpftrace showed looping on a single inode inside a mysql
> > > cgroup.  That inode was usually in the middle of being deleted,
> > > i_size set to zero, but it still had 40-90 pages sitting in the
> > > xarray waiting for truncation.  We’d loop through the whole call
> > > path above over and over again, mostly because writepages() was
> > > returning progress had been made on this one inode.  The
> > > redirty_page_for_writepage() path does drop wbc->nr_to_write, so
> > > the rest of the writepages machinery believes real work is being
> > > done.  nr_to_write is LONG_MAX, so we’ve got a while to loop.
> > 
> > Yup, this code relies on truncate making progress to avoid looping
> > forever. Truncate should only block on the page while it locks it
> > and waits for writeback to complete, then it gets forcibly
> > invalidated and removed from the page cache.
> 
> It's not looping forever, truncate can just take a relatively long
> time during which the flusher is busy-spinning full bore on a
> relatively small number of unflushable pages (range_cyclic).
> 
> But you raise a good point asking "why is truncate stuck?". I first
> thought they might be cannibalizing each other over the page locks,
> but that wasn't it (and wouldn't explain the clear asymmetry between
> truncate and flusher). That leaves the waiting for writeback. I just
> confirmed with tracing that that's exactly where truncate sits while
> the flusher goes bananas on the same inode. So the race must be this:
> 
> truncate:                flusher
>                          put a subset of pages under writeback
> i_size_write(0)
> wait_on_page_writeback()
>                          loop with range_cyclic over remaining dirty >EOF pages

But write_cache_pages() doesn't repeatedly loop over the pages.

The flusher is

->writepages
  iomap_writepages
    write_cache_pages()
      loop over mapping tree
        lock page
	iomap_do_writepage
	  set_page_writeback()
	  add page to ioend
     <end of mapping reached>
  iomap_submit_ioend()
    <pages under writeback get sent for IO>
return to high level writeback

And eventually IO completion will clear page writeback state.

i.e. write_cache_pages() should not be hard looping over the pages
beyond EOF even if range_cyclic is set - it's skipping those pages,
submitting any that are under writeback, and the, going back to high
level code for it to make a decision about continuation of
writeback. It may call back down and we loop over dirty pages beyond
EOF again, but the flusher should not be holding on to pages under
writeback for any signification length of time before they are
submitted for IO.

IOWs, if truncate is getting stuck waiting on writeback, then that
implies something is holding up IO completions for a long time, not
that there's a problem in writeback submission. i.e. you might
actually be looking at a workqueue backlog or scheduling starvation
problem here preventing IO completion from clearing writeback
state....

> > Hence I think we can remove the redirtying completely - it's not
> > needed and hasn't been for some time.
> > 
> > Further, I don't think we need to invalidate the folio, either. If
> > it's beyond EOF, then it is because a truncate is in progress that
> > means it is somebody else's problem to clean up. Hence we should
> > leave it to the truncate to deal with, just like the pre-2013 code
> > did....
> 
> Perfect, that works.

If there's actually a IO completion latency problem, this will not
fix it - it'll just hide the soft-lockup symptom that the pages
stuck in writeback are manifested through this path.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
