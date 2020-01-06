Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625F3131C41
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgAFXVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 18:21:09 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54458 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgAFXVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:21:09 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6171D7E8AC3;
        Tue,  7 Jan 2020 10:21:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iobgC-0006Ms-6o; Tue, 07 Jan 2020 10:21:00 +1100
Date:   Tue, 7 Jan 2020 10:21:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200106232100.GL23195@dread.disaster.area>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106115514.GG12699@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=Gjqk4l_1r1m8T7qFzNsA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 12:55:14PM +0100, Michal Hocko wrote:
> On Tue 31-12-19 04:59:08, Matthew Wilcox wrote:
> > 
> > I don't want to present this topic; I merely noticed the problem.
> > I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> > thread here:
> 
> Thanks for bringing this up Matthew! The change in the behavior came as
> a surprise to me. I can lead the session for the MM side.
> 
> > https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> > 
> > Summary: Congestion is broken and has been for years, and everybody's
> > system is sleeping waiting for congestion that will never clear.
> > 
> > A good outcome for this meeting would be:
> > 
> >  - MM defines what information they want from the block stack.
> 
> The history of the congestion waiting is kinda hairy but I will try to
> summarize expectations we used to have and we can discuss how much of
> that has been real and what followed up as a cargo cult. Maybe we just
> find out that we do not need functionality like that anymore. I believe
> Mel would be a great contributor to the discussion.

We most definitely do need some form of reclaim throttling based on
IO congestion, because it is trivial to drive the system into swap
storms and OOM killer invocation when there are large dirty slab
caches that require IO to make reclaim progress and there's little
in the way of page cache to reclaim.

This is one of the biggest issues I've come across trying to make
XFS inode reclaim non-blocking - the existing code blocks on inode
writeback IO congestion to throttle the overall reclaim rate and
so prevents swap storms and OOM killer rampages from occurring.

The moment I remove the inode writeback blocking from the reclaim
path and move the backoffs to the core reclaim congestion backoff
algorithms, I see a sustantial increase in the typical reclaim scan
priority. This is because the reclaim code does not have an
integrated back-off mechanism that can balance reclaim throttling
between slab cache and page cache reclaim. This results in
insufficient page reclaim backoff under slab cache backoff
conditions, leading to excessive page cache reclaim and swapping out
all the anonymous pages in memory. Then performance goes to hell as
userspace then starts to block on page faults swap thrashing like
this:

page_fault
  swap_in
    alloc page
      direct reclaim
        swap out anon page
	  submit_bio
	    wbt_throttle


IOWs, page reclaim doesn't back off until userspace gets throttled
in the block layer doing swap out during swap in during page
faults. For these sorts of workloads there should be little to no
swap thrashing occurring - throttling reclaim to the rate at which
inodes are cleaned by async IO dispatcher threads is what is needed
here, not continuing to wind up reclaim priority  until swap storms
and the oom killer end up killng the machine...

I also see this when the inode cache load is on a separate device to
the swap partition - both devices end up at 100% utilisation, one
doing inode writeback flat out (about 300,000 inodes/sec from an
inode cache of 5-10 million inodes), the other is swap thrashing
from a page cache of only 250-500 pages in size.

Hence the way congestion was historically dealt with as a "global
condition" still needs to exist in some manner - congestion on a
single device is sufficient to cause the high level reclaim
algroithms to misbehave badly...

Hence it seems to me that having IO load feedback to the memory
reclaim algorithms is most definitely required for memory reclaim to
be able to make the correct decisions about what to reclaim. If the
shrinker for the cache that uses 50% of RAM in the machine is saying
"backoff needed" and it's underlying device is
congested and limiting object reclaim rates, then it's a pretty good
indication that reclaim should back off and wait for IO progress to
be made instead of trying to reclaim from other LRUs that hold an
insignificant amount of memory compared to the huge cache that is
backed up waiting on IO completion to make progress....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
