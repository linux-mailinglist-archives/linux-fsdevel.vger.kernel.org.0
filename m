Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC54B41C249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbhI2KLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 06:11:11 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:53541 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245226AbhI2KLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:11:10 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 69C03FB4AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 11:09:26 +0100 (IST)
Received: (qmail 18912 invoked from network); 29 Sep 2021 10:09:26 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 29 Sep 2021 10:09:25 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/5] Remove dependency on congestion_wait in mm/ v2
Date:   Wed, 29 Sep 2021 11:09:09 +0100
Message-Id: <20210929100914.14704-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a series that removes all calls to congestion_wait
in mm/ and deletes wait_iff_congested. It's not a clever
implementation but congestion_wait has been broken for a long time
(https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).
Even if it worked, it was never a great idea. While excessive
dirty/writeback pages at the tail of the LRU is one possibility that
reclaim may be slow, there is also the problem of too many pages being
isolated and reclaim failing for other reasons (elevated references,
too many pages isolated, excessive LRU contention etc).

This series replaces the reclaim conditions with event driven ones

o If there are too many dirty/writeback pages, sleep until a timeout
  or enough pages get cleaned
o If too many pages are isolated, sleep until enough isolated pages
  are either reclaimed or put back on the LRU
o If no progress is being made, let direct reclaim tasks sleep until
  another task makes progress

This was initially tested with a mix of workloads that used to trigger
corner cases that no longer work. A new test case was created called
"stutterp" (pagereclaim-stutterp-noreaders in mmtests) using a freshly
created XFS filesystem.

stutterp varies the number of "worker" processes from 4 up to NR_CPUS*4
to check the impact as the number of direct reclaimers increase. It has
three components

o One "anon latency" worker creates small mappings with mmap() and times
  how long it takes to fault the mapping reading it 4K at a time
o X file writers which is fio randomly writing iX files where the total
  size of the files add up to the allowed dirty_ratio. fio is allowed
  to run for a warmup period to allow some file-backed pages to
  accumulate. The duration of the warmup is based on the best-case
  linear write speed of the storage.
o Y anon memory hogs which continually map (100-dirty_ratio)% of
  memory
o Total estimated WSS = (100+dirty_ration) percentage of memory

X+Y+1 == NR_WORKERS varying from 4 up to NR_CPUS*4

The intent is to maximise the total WSS to force a lot of file and
anon memory where some anonymous memory must be swapped and there
is a high likelihood of dirty/writeback pages reaching the end of
the LRU.

The test can be configured to have background readers but it stresses
reclaim less.

Now the results -- short summary is that the series works and stalls
until some event occurs but the timeouts may need adjustment.

The test results are not broken down by patch as the series should be
treated as one block that replaces a broken throttling mechanism with a
working one.

First the results of the "anon latency" latency

stutterp
                              5.15.0-rc1             5.15.0-rc1
                                 vanilla mm-reclaimcongest-v2r5
Amean     mmap-4      30.4535 (   0.00%)     35.8324 ( -17.66%)
Amean     mmap-7      36.2699 (   0.00%)     45.2236 ( -24.69%)
Amean     mmap-12     50.9131 (   0.00%)     82.3022 ( -61.65%)
Amean     mmap-21   2237.9029 (   0.00%)    248.5605 (  88.89%)
Amean     mmap-30  13015.0189 (   0.00%)    285.9522 (  97.80%)
Amean     mmap-48    554.7624 (   0.00%)    573.8247 (  -3.44%)
Amean     mmap-64    308.4377 (   0.00%)    349.8743 ( -13.43%)
Stddev    mmap-4      35.4820 (   0.00%)    488.2629 (-1276.08%)
Stddev    mmap-7      78.7472 (   0.00%)    489.7342 (-521.91%)
Stddev    mmap-12    133.3145 (   0.00%)   1468.1633 (-1001.28%)
Stddev    mmap-21  21210.2154 (   0.00%)   4416.6959 (  79.18%)
Stddev    mmap-30 102917.0729 (   0.00%)   3816.3041 (  96.29%)
Stddev    mmap-48   3839.4931 (   0.00%)   3830.6352 (   0.23%)
Stddev    mmap-64     84.7670 (   0.00%)   1264.4255 (-1391.65%)
Max-99    mmap-4      32.0370 (   0.00%)     33.3524 (  -4.11%)
Max-99    mmap-7      44.9212 (   0.00%)     43.0797 (   4.10%)
Max-99    mmap-12     65.0430 (   0.00%)     90.2671 ( -38.78%)
Max-99    mmap-21    424.5115 (   0.00%)    188.7360 (  55.54%)
Max-99    mmap-30    408.4132 (   0.00%)    286.8658 (  29.76%)
Max-99    mmap-48    521.7660 (   0.00%)   1183.9219 (-126.91%)
Max-99    mmap-64    422.4280 (   0.00%)    421.6158 (   0.19%)
Max       mmap-4    1908.9517 (   0.00%)  42286.3987 (-2115.16%)
Max       mmap-7    5514.1997 (   0.00%)  37353.5532 (-577.41%)
Max       mmap-12   5385.8229 (   0.00%)  86358.3761 (-1503.44%)
Max       mmap-21 226560.1452 (   0.00%) 152778.0127 (  32.57%)
Max       mmap-30 816927.5043 (   0.00%) 122999.4260 (  84.94%)
Max       mmap-48  88771.0063 (   0.00%)  87701.5264 (   1.20%)
Max       mmap-64   2489.0185 (   0.00%)  37293.3631 (-1398.32%

For low thread counts, the time to mmap() is lower and improves for
some higher thread counts. The variance is all over the map although
the vanilla kernel has much worse variances at low thread counts. In all
cases, the differences are not statistically significant due to very large
maximum outliers. Max-99 is the maximum latency at the 99% percentile
with massive latencies in the remaining 1%. This is partially due to
the test design, reclaim is difficult so allocations stall and there are
variances depending on whether THPs can be allocated or not. The warmup
period calculation is not ideal as it's based on linear writes where as
fio is randomly writing multiple files from multiple tasks so the start
state of the test is variable.

The overall system CPU usage and elapsed time is as follows

                  5.15.0-rc1  5.15.0-rc1
                     vanillamm-reclaimcongest-v2r5
Duration User        9775.48    11210.47
Duration System     12434.96     2356.96
Duration Elapsed     3019.60     2432.12

The patches significantly reduce system CPU usage as the vanilla kernel
is not stalling and instead hammering the LRU lists uselessly.

The high-level /proc/vmstats show

                                     5.15.0-rc1     5.15.0-rc1
                                        vanillamm-reclaimcongest-v2r5
Ops Direct pages scanned          1985928832.00   114592698.00
Ops Kswapd pages scanned           129232402.00   173143704.00
Ops Kswapd pages reclaimed          71154883.00    78204376.00
Ops Direct pages reclaimed          10082328.00    11225695.00
Ops Kswapd efficiency %                   55.06          45.17
Ops Kswapd velocity                    42797.85       71190.44
Ops Direct efficiency %                    0.51           9.80
Ops Direct velocity                   657679.44       47116.38

Kswapd scans more pages as a result of the patch and at a
higher velocity. This is because direct reclaim is scanning
fewer pages at much lower velocity as it gets stalled.
From a detailed graph, what is clear is that direct reclaim
is not occuring uniformly during the duration of the test.
Instead, there are massive spikes in reclaim activity (both
direct and kswapd) but crucially, the number of pages reclaimed
is relatively consistent. In other words, with this workload,
reclaim rate remains relatively constant but there are massive
variations in scan activity representing useless sacnning.

Ops Percentage direct scans               93.89          39.83

For the overall scans, vanilla scanned 94.89% of pages where
as with the patches, 39.83% were direct reclaim

Ops Page writes by reclaim           2228237.00     2310272.00

Page writes from reclaim context remain consistent.

Ops Page writes anon                 2719172.00     2594781.00

Swap activity remain consistent.

Ops Page reclaim immediate        1904282975.00    78707724.00

The number of pages encountered at the tail of the LRU tagged for immediate
reclaim but still dirty/writeback is reduced by 95%

Ops Slabs scanned                     178981.00      155082.00

Slab scan activity is similar

Ops Direct inode steals              3111707.00        2909.00
Ops Kswapd inode steals               148176.00      149325.00

But the number of inodes reclaimed from direct reclaim context
is massively reduced.

ftrace was used to gather stall activity

Vanilla
-------
      1 writeback_wait_iff_congested: usec_delayed=32000
      2 writeback_wait_iff_congested: usec_delayed=24000
      2 writeback_wait_iff_congested: usec_delayed=28000
     16 writeback_wait_iff_congested: usec_delayed=20000
     29 writeback_wait_iff_congested: usec_delayed=16000
     82 writeback_wait_iff_congested: usec_delayed=12000
    142 writeback_wait_iff_congested: usec_delayed=8000
    235 writeback_wait_iff_congested: usec_delayed=4000
 128103 writeback_wait_iff_congested: usec_delayed=0

The fast majority of wait_iff_congested calls do not stall at all.
What is likely happening is that cond_resched() reschedules the task for
a short period when the BDI is not registering congestion (which it never
will in this test setup).

      1 writeback_congestion_wait: usec_delayed=124000
      1 writeback_congestion_wait: usec_delayed=136000
      2 writeback_congestion_wait: usec_delayed=112000
      2 writeback_congestion_wait: usec_delayed=116000
    229 writeback_congestion_wait: usec_delayed=108000
    446 writeback_congestion_wait: usec_delayed=104000

congestion_wait if called always exceeds the timeout as there is no
trigger to wake it up.

Bottom line: Vanilla will throttle but it's not effective

Patch series
------------

Kswapd throttle activity was always due to scanning pages tagged
for immediate reclaim but still dirty/writeback at the tail
of the LRU

      1 usect_delayed=84000 reason=VMSCAN_THROTTLE_WRITEBACK
      2 usect_delayed=20000 reason=VMSCAN_THROTTLE_WRITEBACK
      6 usect_delayed=16000 reason=VMSCAN_THROTTLE_WRITEBACK
     12 usect_delayed=12000 reason=VMSCAN_THROTTLE_WRITEBACK
     17 usect_delayed=8000 reason=VMSCAN_THROTTLE_WRITEBACK
    129 usect_delayed=4000 reason=VMSCAN_THROTTLE_WRITEBACK
    205 usect_delayed=0 reason=VMSCAN_THROTTLE_WRITEBACK

Some were woken immediately, others stalled for short periods
until enough IO was completed but did not hit the timeout.

For direct reclaim, the number of times stalled for each
reason were

  16909 reason=VMSCAN_THROTTLE_ISOLATED
  77844 reason=VMSCAN_THROTTLE_NOPROGRESS
 113415 reason=VMSCAN_THROTTLE_WRITEBACK

Like kswapd, the most common reason was pages tagged for
immediate reclaim. A very large number of stalls were
due to failing to make progress. A relatively small
number were due to too many pages isolated from the
LRU by parallel threads

For VMSCAN_THROTTLE_ISOLATED, the breakdown of delays was

      1 usect_delayed=36000 reason=VMSCAN_THROTTLE_ISOLATED
      3 usect_delayed=24000 reason=VMSCAN_THROTTLE_ISOLATED
      7 usect_delayed=20000 reason=VMSCAN_THROTTLE_ISOLATED
     49 usect_delayed=16000 reason=VMSCAN_THROTTLE_ISOLATED
     94 usect_delayed=12000 reason=VMSCAN_THROTTLE_ISOLATED
    105 usect_delayed=8000 reason=VMSCAN_THROTTLE_ISOLATED
    417 usect_delayed=4000 reason=VMSCAN_THROTTLE_ISOLATED
  16233 usect_delayed=0 reason=VMSCAN_THROTTLE_ISOLATED

The vast majority do not stall at all, others stall for
short periods by never hit the timeout

For VMSCAN_THROTTLE_NOPROGRESS, the breakdown of stalls
was

      1 usect_delayed=124000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=128000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=176000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=536000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=544000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=556000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=624000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=716000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=772000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usect_delayed=512000 reason=VMSCAN_THROTTLE_NOPROGRESS
     16 usect_delayed=120000 reason=VMSCAN_THROTTLE_NOPROGRESS
     53 usect_delayed=116000 reason=VMSCAN_THROTTLE_NOPROGRESS
    116 usect_delayed=112000 reason=VMSCAN_THROTTLE_NOPROGRESS
   5907 usect_delayed=108000 reason=VMSCAN_THROTTLE_NOPROGRESS
  71741 usect_delayed=104000 reason=VMSCAN_THROTTLE_NOPROGRESS

This is showing that the timeout was always hit and often
overrun by a large margin. If anything, this indicates that
stalling on NOPROGRESS should have a timeout larger than
HZ/10

For VMSCAN_THROTTLE_WRITEBACK, the delays were all over the
map

      1 usect_delayed=136000 reason=VMSCAN_THROTTLE_WRITEBACK
      1 usect_delayed=500000 reason=VMSCAN_THROTTLE_WRITEBACK
      1 usect_delayed=512000 reason=VMSCAN_THROTTLE_WRITEBACK
      1 usect_delayed=528000 reason=VMSCAN_THROTTLE_WRITEBACK
      2 usect_delayed=128000 reason=VMSCAN_THROTTLE_WRITEBACK
      3 usect_delayed=124000 reason=VMSCAN_THROTTLE_WRITEBACK
      4 usect_delayed=60000 reason=VMSCAN_THROTTLE_WRITEBACK
      5 usect_delayed=56000 reason=VMSCAN_THROTTLE_WRITEBACK
      6 usect_delayed=68000 reason=VMSCAN_THROTTLE_WRITEBACK
      7 usect_delayed=40000 reason=VMSCAN_THROTTLE_WRITEBACK
      7 usect_delayed=88000 reason=VMSCAN_THROTTLE_WRITEBACK
     11 usect_delayed=64000 reason=VMSCAN_THROTTLE_WRITEBACK
     12 usect_delayed=92000 reason=VMSCAN_THROTTLE_WRITEBACK
     14 usect_delayed=44000 reason=VMSCAN_THROTTLE_WRITEBACK
     18 usect_delayed=48000 reason=VMSCAN_THROTTLE_WRITEBACK
     19 usect_delayed=36000 reason=VMSCAN_THROTTLE_WRITEBACK
     19 usect_delayed=72000 reason=VMSCAN_THROTTLE_WRITEBACK
     21 usect_delayed=76000 reason=VMSCAN_THROTTLE_WRITEBACK
     22 usect_delayed=84000 reason=VMSCAN_THROTTLE_WRITEBACK
     22 usect_delayed=96000 reason=VMSCAN_THROTTLE_WRITEBACK
     23 usect_delayed=120000 reason=VMSCAN_THROTTLE_WRITEBACK
     23 usect_delayed=80000 reason=VMSCAN_THROTTLE_WRITEBACK
     33 usect_delayed=52000 reason=VMSCAN_THROTTLE_WRITEBACK
     37 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
     45 usect_delayed=28000 reason=VMSCAN_THROTTLE_WRITEBACK
     50 usect_delayed=116000 reason=VMSCAN_THROTTLE_WRITEBACK
     73 usect_delayed=32000 reason=VMSCAN_THROTTLE_WRITEBACK
     82 usect_delayed=24000 reason=VMSCAN_THROTTLE_WRITEBACK
     95 usect_delayed=20000 reason=VMSCAN_THROTTLE_WRITEBACK
    117 usect_delayed=112000 reason=VMSCAN_THROTTLE_WRITEBACK
    254 usect_delayed=16000 reason=VMSCAN_THROTTLE_WRITEBACK
    367 usect_delayed=12000 reason=VMSCAN_THROTTLE_WRITEBACK
    893 usect_delayed=8000 reason=VMSCAN_THROTTLE_WRITEBACK
   3914 usect_delayed=108000 reason=VMSCAN_THROTTLE_WRITEBACK
   8526 usect_delayed=4000 reason=VMSCAN_THROTTLE_WRITEBACK
  32907 usect_delayed=0 reason=VMSCAN_THROTTLE_WRITEBACK
  65780 usect_delayed=104000 reason=VMSCAN_THROTTLE_WRITEBACK

The majority hit the timeout in direct reclaim context which
is not the same as what happened for kswapd. One one hand,
this might imply that direct and kswapd should have different
timeouts but that would be very clumsy. It would make more
sense to increase the timeout for NOPROGRESS and see does
that alleviate the pressure.

Bottom line, the new throttling mechanism works but the timeouts
may need adjutment.

-- 
2.31.1

