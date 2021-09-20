Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC62C412706
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351269AbhITTyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 15:54:41 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:42981 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351014AbhITTwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:52:40 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 5C9D41C5485
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 20:51:11 +0100 (IST)
Received: (qmail 25265 invoked from network); 20 Sep 2021 19:51:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Sep 2021 19:51:11 -0000
Date:   Mon, 20 Sep 2021 20:51:09 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Message-ID: <20210920195109.GJ3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <YUhztA8TmplTluyQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YUhztA8TmplTluyQ@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 12:42:44PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 20, 2021 at 09:54:31AM +0100, Mel Gorman wrote:
> > This has been lightly tested only and the testing was useless as the
> > relevant code was not executed. The workload configurations I had that
> > used to trigger these corner cases no longer work (yey?) and I'll need
> > to implement a new synthetic workload. If someone is aware of a realistic
> > workload that forces reclaim activity to the point where reclaim stalls
> > then kindly share the details.
> 
> The stereeotypical "stalling on I/O" problem is to plug in one of the
> crap USB drives you were given at a trade show and simply
> 	dd if=/dev/zero of=/dev/sdb
> 	sync
> 
> You can also set up qemu to have extremely slow I/O performance:
> https://serverfault.com/questions/675704/extremely-slow-qemu-storage-performance-with-qcow2-images
> 

Ok, I managed to get something working and nothing blew up.

The workload was similar to what I described except the dirty file data
is related to dirty_ratio, the memory hogs no longer sleep and I disabled
the parallel readers. There is still a configuration with the parallel
readers but I won't have the results till tomorrow.

Surprising no one, vanilla kernel throttling barely works.

      1 writeback_wait_iff_congested: usec_delayed=4000
      3 writeback_congestion_wait: usec_delayed=108000
    196 writeback_congestion_wait: usec_delayed=104000
  16697 writeback_wait_iff_congested: usec_delayed=0

too_many_isolated it not tracked at all so we don't know what that looks
like but kswapd "blocking" on dirty pages at the tail basically never
stalls. The few congestion_wait's that did happen stalled for the full
duration as the bdi is not tracking congestion at all.

With the series, the breakdown of reasons to stall were

   5703 reason=VMSCAN_THROTTLE_WRITEBACK
  29644 reason=VMSCAN_THROTTLE_NOPROGRESS
1979999 reason=VMSCAN_THROTTLE_ISOLATED

kswapd stalls were rare but they did happen and surprise surprise, it
was dirty pages

    914 reason=VMSCAN_THROTTLE_WRITEBACK

All of them stalled for the full timeout so there might be a bug in
patch 1 because that sounds suspicious.

As "too many pages isolated" was the top reason, the frequency of each
stall time is as follows

      1 usect_delayed=164000
      1 usect_delayed=192000
      1 usect_delayed=200000
      1 usect_delayed=208000
      1 usect_delayed=220000
      1 usect_delayed=244000
      1 usect_delayed=308000
      1 usect_delayed=312000
      1 usect_delayed=316000
      1 usect_delayed=332000
      1 usect_delayed=588000
      1 usect_delayed=620000
      1 usect_delayed=836000
      3 usect_delayed=116000
      4 usect_delayed=124000
      4 usect_delayed=128000
      6 usect_delayed=120000
      9 usect_delayed=112000
     11 usect_delayed=100000
     13 usect_delayed=48000
     13 usect_delayed=96000
     14 usect_delayed=40000
     15 usect_delayed=88000
     15 usect_delayed=92000
     16 usect_delayed=80000
     18 usect_delayed=68000
     19 usect_delayed=76000
     22 usect_delayed=84000
     23 usect_delayed=108000
     23 usect_delayed=60000
     25 usect_delayed=44000
     25 usect_delayed=52000
     29 usect_delayed=36000
     30 usect_delayed=56000
     30 usect_delayed=64000
     33 usect_delayed=72000
     57 usect_delayed=32000
     91 usect_delayed=20000
    107 usect_delayed=24000
    125 usect_delayed=28000
    131 usect_delayed=16000
    180 usect_delayed=12000
    186 usect_delayed=8000
   1379 usect_delayed=104000
  16493 usect_delayed=4000
1960837 usect_delayed=0

In other words, the vast majority of stalls were for 0 time and the task
was immediately woken again. The next most common stall time was 1 tick
but a sizable number reach the full timeout. Everything else is somewhere
in between so the event trigger appears to be ok.

I don't know how the application itself performed as I still have to
write the analysis script and assuming I can look at this tomorrow, I'll
probably start with why VMSCAN_THROTTLE_WRITEBACK always stalled for the
full timeout.

-- 
Mel Gorman
SUSE Labs
