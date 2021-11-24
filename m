Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8645B864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 11:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbhKXKfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 05:35:34 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:56659 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241501AbhKXKfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:35:33 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 007E41C4678
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 10:32:22 +0000 (GMT)
Received: (qmail 23747 invoked from network); 24 Nov 2021 10:32:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Nov 2021 10:32:22 -0000
Date:   Wed, 24 Nov 2021 10:32:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] mm/vmscan: Throttle reclaim when no progress is
 being made
Message-ID: <20211124103221.GD3366@techsingularity.net>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
 <20211022144651.19914-4-mgorman@techsingularity.net>
 <20211124011912.GA265983@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211124011912.GA265983@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:19:12PM -0800, Darrick J. Wong wrote:
> On Fri, Oct 22, 2021 at 03:46:46PM +0100, Mel Gorman wrote:
> > Memcg reclaim throttles on congestion if no reclaim progress is made.
> > This makes little sense, it might be due to writeback or a host of
> > other factors.
> > 
> > For !memcg reclaim, it's messy. Direct reclaim primarily is throttled
> > in the page allocator if it is failing to make progress. Kswapd
> > throttles if too many pages are under writeback and marked for
> > immediate reclaim.
> > 
> > This patch explicitly throttles if reclaim is failing to make progress.
> 
> Hi Mel,
> 
> Ever since Christoph broke swapfiles, I've been carrying around a little
> fstest in my dev tree[1] that tries to exercise paging things in and out
> of a swapfile.  Sadly I've been trapped in about three dozen customer
> escalations for over a month, which means I haven't been able to do much
> upstream in weeks.  Like submit this test upstream. :(
> 
> Now that I've finally gotten around to trying out a 5.16-rc2 build, I
> notice that the runtime of this test has gone from ~5s to 2 hours.
> Among other things that it does, the test sets up a cgroup with a memory
> controller limiting the memory usage to 25MB, then runs a program that
> tries to dirty 50MB of memory.  There's 2GB of memory in the VM, so
> we're not running reclaim globally, but the cgroup gets throttled very
> severely.
> 

Ok, so this test cannot make progress until some of the cgroup pages get
cleaned. What is the expectation for the test? Should it OOM or do you
expect it to have spin-like behaviour until some writeback completes?
I'm guessing you'd prefer it to spin and right now it's sleeping far
too much.

> AFAICT the system is mostly idle, but it's difficult to tell because ps
> and top also get stuck waiting for this cgroup for whatever reason. 

But this is surprising because I expect that ps and top are not running
within the cgroup. Was /proc/PID/stack readable? 

> My
> uninformed spculation is that usemem_and_swapoff takes a page fault
> while dirtying the 50MB memory buffer, prepares to pull a page in from
> swap, tries to evict another page to stay under the memcg limit, but
> that decides that it's making no progress and calls
> reclaim_throttle(..., VMSCAN_THROTTLE_NOPROGRESS).
> 
> The sleep is uninterruptible, so I can't even kill -9 fstests to shut it
> down.  Eventually we either finish the test or (for the mlock part) the
> OOM killer actually kills the process, but this takes a very long time.
> 

The sleep can be interruptible.

> Any thoughts?  For now I can just hack around this by skipping
> reclaim_throttle if cgroup_reclaim() == true, but that's probably not
> the correct fix. :)
> 

No, it wouldn't be but a possibility is throttling for only 1 jiffy if
reclaiming within a memcg and the zone is balanced overall.

The interruptible part should just be the patch below. I need to poke at
the cgroup limit part a bit

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..07db03883062 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1068,7 +1068,7 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 		break;
 	}
 
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
 	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
 
