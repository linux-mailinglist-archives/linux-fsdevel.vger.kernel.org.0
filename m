Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC464331B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhJSJDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 05:03:33 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:50933 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234364AbhJSJDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:03:32 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id D70722721
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:01:18 +0100 (IST)
Received: (qmail 4611 invoked from network); 19 Oct 2021 09:01:18 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 19 Oct 2021 09:01:18 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
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
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
Date:   Tue, 19 Oct 2021 10:01:00 +0100
Message-Id: <20211019090108.25501-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changelog since v3
o Count writeback completions for NR_THROTTLED_WRITTEN only
o Use IRQ-safe inc_node_page_state
o Remove redundant throttling

This series is also available at

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-reclaimcongest-v4r2

This series that removes all calls to congestion_wait
in mm/ and deletes wait_iff_congested. It's not a clever
implementation but congestion_wait has been broken for a long time
(https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).
Even if congestion throttling worked, it was never a great idea. While
excessive dirty/writeback pages at the tail of the LRU is one possibility
that reclaim may be slow, there is also the problem of too many pages
being isolated and reclaim failing for other reasons (elevated references,
too many pages isolated, excessive LRU contention etc).

This series replaces the "congestion" throttling with 3 different types.

o If there are too many dirty/writeback pages, sleep until a timeout
  or enough pages get cleaned
o If too many pages are isolated, sleep until enough isolated pages
  are either reclaimed or put back on the LRU
o If no progress is being made, direct reclaim tasks sleep until
  another task makes progress with acceptable efficiency.

This was initially tested with a mix of workloads that used to trigger
corner cases that no longer work. A new test case was created called
"stutterp" (pagereclaim-stutterp-noreaders in mmtests) using a freshly
created XFS filesystem. Note that it may be necessary to increase the
timeout of ssh if executing remotely as ssh itself can get throttled and
the connection may timeout.

stutterp varies the number of "worker" processes from 4 up to NR_CPUS*4
to check the impact as the number of direct reclaimers increase. It has
four types of worker.

o One "anon latency" worker creates small mappings with mmap() and times
  how long it takes to fault the mapping reading it 4K at a time
o X file writers which is fio randomly writing X files where the total
  size of the files add up to the allowed dirty_ratio. fio is allowed
  to run for a warmup period to allow some file-backed pages to
  accumulate. The duration of the warmup is based on the best-case
  linear write speed of the storage.
o Y file readers which is fio randomly reading small files
o Z anon memory hogs which continually map (100-dirty_ratio)% of
  memory
o Total estimated WSS = (100+dirty_ration) percentage of memory

X+Y+Z+1 == NR_WORKERS varying from 4 up to NR_CPUS*4

The intent is to maximise the total WSS with a mix of file and anon memory
where some anonymous memory must be swapped and there is a high likelihood
of dirty/writeback pages reaching the end of the LRU.

The test can be configured to have no background readers to stress
dirty/writeback pages. The results below are based on having zero readers.

The short summary of the results is that the series works and stalls
until some event occurs but the timeouts may need adjustment.

The test results are not broken down by patch as the series should be
treated as one block that replaces a broken throttling mechanism with a
working one.

Finally, three machines were tested but I'm reporting the worst set of
results. The other two machines had much better latencies for example.

First the results of the "anon latency" latency

stutterp
                              5.15.0-rc1             5.15.0-rc1
                                 vanilla mm-reclaimcongest-v4r2
Amean     mmap-4      31.4003 (   0.00%)    176.8729 (-463.28%)
Amean     mmap-7      38.1641 (   0.00%)    605.8866 (-1487.58%)
Amean     mmap-12     60.0981 (   0.00%)   2866.8561 (-4670.29%)
Amean     mmap-21    161.2699 (   0.00%)    118.6587 (  26.42%)
Amean     mmap-30    174.5589 (   0.00%)   3729.2263 (-2036.37%)
Amean     mmap-48   8106.8160 (   0.00%)   1463.7815 (  81.94%)
Stddev    mmap-4      41.3455 (   0.00%)   5847.5425 (-14043.13%)
Stddev    mmap-7      53.5556 (   0.00%)  12091.9011 (-22478.20%)
Stddev    mmap-12    171.3897 (   0.00%)  28785.9881 (-16695.63%)
Stddev    mmap-21   1506.6752 (   0.00%)   1609.0361 (  -6.79%)
Stddev    mmap-30    557.5806 (   0.00%)  32712.2440 (-5766.82%)
Stddev    mmap-48  61681.5718 (   0.00%)  15971.4654 (  74.11%)
Max-90    mmap-4      31.4243 (   0.00%)     30.1957 (   3.91%)
Max-90    mmap-7      41.0410 (   0.00%)     36.7782 (  10.39%)
Max-90    mmap-12     66.5255 (   0.00%)    121.8574 ( -83.17%)
Max-90    mmap-21    146.7479 (   0.00%)    132.2327 (   9.89%)
Max-90    mmap-30    193.9513 (   0.00%)     61.6135 (  68.23%)
Max-90    mmap-48    277.9137 (   0.00%)    593.7413 (-113.64%)
Max       mmap-4    1913.8009 (   0.00%) 239690.5578 (-12424.32%)
Max       mmap-7    2423.9665 (   0.00%) 270122.1751 (-11043.81%)
Max       mmap-12   6845.6573 (   0.00%) 308761.7416 (-4410.33%)
Max       mmap-21  56278.6508 (   0.00%)  79286.8553 ( -40.88%)
Max       mmap-30  19716.2990 (   0.00%) 306793.2333 (-1456.04%)
Max       mmap-48 477923.9400 (   0.00%) 229791.8793 (  51.92%)

For most thread counts, the time to mmap() is unfortunately increased.
In earlier versions of the series, this was lower but a large number of
throttling events were reaching their timeout increasing the amount of
inefficient scanning of the LRU. There is no prioritisation of reclaim
tasks making progress based on each tasks rate of page allocation versus
progress of reclaim. The variance is also impacted for high worker
counts but in all cases, the differences in latency are not statistically
significant due to very large maximum outliers. Max-90 shows that 90% of
the stalls are comparable but the Max results show the massive outliers
which are increased to to stalling.

It is expected that this will be very machine dependant. Due to the
test design, reclaim is difficult so allocations stall and there are
variances depending on whether THPs can be allocated or not. The amount
of memory will affect exactly how bad the corner cases are and how often
they trigger.  The warmup period calculation is not ideal as it's based
on linear writes where as fio is randomly writing multiple files from
multiple tasks so the start state of the test is variable. For
example, these are the latencies on a single-socket machine that had
more memory

Amean     mmap-4      20.5437 (   0.00%)     19.1772 *   6.65%*
Amean     mmap-6      39.2860 (   0.00%)     69.4987 ( -76.90%)
Amean     mmap-8    2476.1950 (   0.00%)    151.7673 (  93.87%)
Amean     mmap-12    178.0936 (   0.00%)    209.1427 ( -17.43%)
Amean     mmap-18   3238.9125 (   0.00%)    262.5806 (  91.89%)
Amean     mmap-24   7922.7016 (   0.00%)    322.9738 (  95.92%)
Amean     mmap-30   1766.8392 (   0.00%)    405.8898 (  77.03%)
Amean     mmap-32   7542.2844 (   0.00%)    555.6236 (  92.63%)
Amean     mmap-32   7542.2844 (   0.00%)    512.1812 (  93.21%)

The overall system CPU usage and elapsed time is as follows

                  5.15.0-rc3  5.15.0-rc3
                     vanilla mm-reclaimcongest-v4r2
Duration User        6989.03     2368.70
Duration System      7308.12      843.35
Duration Elapsed     2277.67     2131.77

The patches reduce system CPU usage by 88% as the vanilla kernel is rarely
stalling.

The high-level /proc/vmstats show

                                     5.15.0-rc1     5.15.0-rc1
                                        vanilla mm-reclaimcongest-v4r2
Ops Direct pages scanned          1056608451.00    76886196.00
Ops Kswapd pages scanned           109795048.00    82179688.00
Ops Kswapd pages reclaimed          63269243.00    27410157.00
Ops Direct pages reclaimed          10803973.00     8016444.00
Ops Kswapd efficiency %                   57.62          33.35
Ops Kswapd velocity                    48204.98       38549.98
Ops Direct efficiency %                    1.02          10.43
Ops Direct velocity                   463898.83       36066.83

Kswapd scanned lesspages but the detailed pattern is different. The
vanilla kernel scans slowly over time where as the patches exhibits burst
patterns of scan activity. Direct reclaim scanning is reduced by 92%
due to stalling.

The pattern for stealing pages is also slightly different. Both kernels exhibit
spikes but the vanilla kernel when reclaiming shows pages being reclaimed over
a period of time where as the patches tend to reclaim in spikes. The difference
is that vanilla is not throttling and instead scanning constantly finding some
pages over time where as the patched kernel throttles and reclaims in spikes.

Ops Percentage direct scans               90.59          48.34

For direct reclaim, vanilla scanned 90.59% of pages where as with the
patches, 48.34% were direct reclaim due to throttling

Ops Page writes by reclaim           2613590.00     1882533.00

Page writes from reclaim context are reduced.

Ops Page writes anon                 2932752.00     2266749.00

And there is slightly less swapping.

Ops Page reclaim immediate         996248528.00    29230920.00

The number of pages encountered at the tail of the LRU tagged for immediate
reclaim but still dirty/writeback is reduced by 97%.

Ops Slabs scanned                     164284.00      166646.00

Slab scan activity is similar.

ftrace was used to gather stall activity

Vanilla
-------
      1 writeback_wait_iff_congested: usec_timeout=100000 usec_delayed=16000
      2 writeback_wait_iff_congested: usec_timeout=100000 usec_delayed=12000
      8 writeback_wait_iff_congested: usec_timeout=100000 usec_delayed=8000
     29 writeback_wait_iff_congested: usec_timeout=100000 usec_delayed=4000
  82394 writeback_wait_iff_congested: usec_timeout=100000 usec_delayed=0

The fast majority of wait_iff_congested calls do not stall at all.
What is likely happening is that cond_resched() reschedules the task for
a short period when the BDI is not registering congestion (which it never
will in this test setup).

      1 writeback_congestion_wait: usec_timeout=100000 usec_delayed=120000
      2 writeback_congestion_wait: usec_timeout=100000 usec_delayed=132000
      4 writeback_congestion_wait: usec_timeout=100000 usec_delayed=112000
    380 writeback_congestion_wait: usec_timeout=100000 usec_delayed=108000
    778 writeback_congestion_wait: usec_timeout=100000 usec_delayed=104000

congestion_wait if called always exceeds the timeout as there is no
trigger to wake it up.

Bottom line: Vanilla will throttle but it's not effective.

Patch series
------------

Kswapd throttle activity was always due to scanning pages tagged for
immediate reclaim at the tail of the LRU

      1 usect_delayed=12000 reason=VMSCAN_THROTTLE_WRITEBACK
      1 usect_delayed=16000 reason=VMSCAN_THROTTLE_WRITEBACK
      1 usect_delayed=28000 reason=VMSCAN_THROTTLE_WRITEBACK
      1 usect_delayed=68000 reason=VMSCAN_THROTTLE_WRITEBACK
      1 usect_delayed=96000 reason=VMSCAN_THROTTLE_WRITEBACK
      2 usect_delayed=24000 reason=VMSCAN_THROTTLE_WRITEBACK
      8 usect_delayed=8000 reason=VMSCAN_THROTTLE_WRITEBACK
     23 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
     52 usect_delayed=4000 reason=VMSCAN_THROTTLE_WRITEBACK
     61 usect_delayed=0 reason=VMSCAN_THROTTLE_WRITEBAC

The majority of events did not stall or stalled for a short period.
Roughly 16% of stalls reached the timeout before expiry. For direct
reclaim, the number of times stalled for each reason were

  13594 reason=VMSCAN_THROTTLE_ISOLATED
  72247 reason=VMSCAN_THROTTLE_WRITEBACK
  77203 reason=VMSCAN_THROTTLE_NOPROGRESS

The most common reason to stall was due to a failure to make forward
progress followed closely by excessive pages tagged for immediate reclaim
at the tail of the LRU.  A relatively small number were due to too many
pages isolated from the LRU by parallel threads

For VMSCAN_THROTTLE_ISOLATED, the breakdown of delays was
 
      3 usec_timeout=20000 usect_delayed=16000 reason=VMSCAN_THROTTLE_ISOLATED
      8 usec_timeout=20000 usect_delayed=8000 reason=VMSCAN_THROTTLE_ISOLATED
      9 usec_timeout=20000 usect_delayed=12000 reason=VMSCAN_THROTTLE_ISOLATED
     18 usec_timeout=20000 usect_delayed=4000 reason=VMSCAN_THROTTLE_ISOLATED
     69 usec_timeout=20000 usect_delayed=20000 reason=VMSCAN_THROTTLE_ISOLATED
   1946 usec_timeout=20000 usect_delayed=0 reason=VMSCAN_THROTTLE_ISOLATED

Most did not stall at all or for a short period. A small number reached
the timeout.

For VMSCAN_THROTTLE_NOPROGRESS, the breakdown of stalls were all over the
map

      1 usec_timeout=500000 usect_delayed=188000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=204000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=264000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=268000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=276000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=360000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=364000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=380000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=388000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=400000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=432000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usec_timeout=500000 usect_delayed=468000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=180000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=236000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=284000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=396000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=404000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=420000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=436000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=456000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=464000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usec_timeout=500000 usect_delayed=472000 reason=VMSCAN_THROTTLE_NOPROGRESS
      3 usec_timeout=500000 usect_delayed=156000 reason=VMSCAN_THROTTLE_NOPROGRESS
      3 usec_timeout=500000 usect_delayed=328000 reason=VMSCAN_THROTTLE_NOPROGRESS
      3 usec_timeout=500000 usect_delayed=336000 reason=VMSCAN_THROTTLE_NOPROGRESS
      3 usec_timeout=500000 usect_delayed=476000 reason=VMSCAN_THROTTLE_NOPROGRESS
      4 usec_timeout=500000 usect_delayed=168000 reason=VMSCAN_THROTTLE_NOPROGRESS
      4 usec_timeout=500000 usect_delayed=348000 reason=VMSCAN_THROTTLE_NOPROGRESS
      4 usec_timeout=500000 usect_delayed=412000 reason=VMSCAN_THROTTLE_NOPROGRESS
      4 usec_timeout=500000 usect_delayed=452000 reason=VMSCAN_THROTTLE_NOPROGRESS
      4 usec_timeout=500000 usect_delayed=484000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=164000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=240000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=256000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=316000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=352000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=408000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=444000 reason=VMSCAN_THROTTLE_NOPROGRESS
      5 usec_timeout=500000 usect_delayed=492000 reason=VMSCAN_THROTTLE_NOPROGRESS
      6 usec_timeout=500000 usect_delayed=280000 reason=VMSCAN_THROTTLE_NOPROGRESS
      6 usec_timeout=500000 usect_delayed=332000 reason=VMSCAN_THROTTLE_NOPROGRESS
      6 usec_timeout=500000 usect_delayed=368000 reason=VMSCAN_THROTTLE_NOPROGRESS
      7 usec_timeout=500000 usect_delayed=116000 reason=VMSCAN_THROTTLE_NOPROGRESS
      7 usec_timeout=500000 usect_delayed=132000 reason=VMSCAN_THROTTLE_NOPROGRESS
      7 usec_timeout=500000 usect_delayed=136000 reason=VMSCAN_THROTTLE_NOPROGRESS
      7 usec_timeout=500000 usect_delayed=272000 reason=VMSCAN_THROTTLE_NOPROGRESS
      7 usec_timeout=500000 usect_delayed=308000 reason=VMSCAN_THROTTLE_NOPROGRESS
      7 usec_timeout=500000 usect_delayed=440000 reason=VMSCAN_THROTTLE_NOPROGRESS
      8 usec_timeout=500000 usect_delayed=292000 reason=VMSCAN_THROTTLE_NOPROGRESS
      8 usec_timeout=500000 usect_delayed=324000 reason=VMSCAN_THROTTLE_NOPROGRESS
      8 usec_timeout=500000 usect_delayed=448000 reason=VMSCAN_THROTTLE_NOPROGRESS
      9 usec_timeout=500000 usect_delayed=144000 reason=VMSCAN_THROTTLE_NOPROGRESS
      9 usec_timeout=500000 usect_delayed=152000 reason=VMSCAN_THROTTLE_NOPROGRESS
      9 usec_timeout=500000 usect_delayed=184000 reason=VMSCAN_THROTTLE_NOPROGRESS
     10 usec_timeout=500000 usect_delayed=392000 reason=VMSCAN_THROTTLE_NOPROGRESS
     10 usec_timeout=500000 usect_delayed=424000 reason=VMSCAN_THROTTLE_NOPROGRESS
     11 usec_timeout=500000 usect_delayed=220000 reason=VMSCAN_THROTTLE_NOPROGRESS
     11 usec_timeout=500000 usect_delayed=228000 reason=VMSCAN_THROTTLE_NOPROGRESS
     11 usec_timeout=500000 usect_delayed=252000 reason=VMSCAN_THROTTLE_NOPROGRESS
     12 usec_timeout=500000 usect_delayed=140000 reason=VMSCAN_THROTTLE_NOPROGRESS
     12 usec_timeout=500000 usect_delayed=148000 reason=VMSCAN_THROTTLE_NOPROGRESS
     12 usec_timeout=500000 usect_delayed=384000 reason=VMSCAN_THROTTLE_NOPROGRESS
     13 usec_timeout=500000 usect_delayed=212000 reason=VMSCAN_THROTTLE_NOPROGRESS
     14 usec_timeout=500000 usect_delayed=176000 reason=VMSCAN_THROTTLE_NOPROGRESS
     14 usec_timeout=500000 usect_delayed=488000 reason=VMSCAN_THROTTLE_NOPROGRESS
     15 usec_timeout=500000 usect_delayed=196000 reason=VMSCAN_THROTTLE_NOPROGRESS
     17 usec_timeout=500000 usect_delayed=216000 reason=VMSCAN_THROTTLE_NOPROGRESS
     18 usec_timeout=500000 usect_delayed=112000 reason=VMSCAN_THROTTLE_NOPROGRESS
     20 usec_timeout=500000 usect_delayed=124000 reason=VMSCAN_THROTTLE_NOPROGRESS
     20 usec_timeout=500000 usect_delayed=300000 reason=VMSCAN_THROTTLE_NOPROGRESS
     21 usec_timeout=500000 usect_delayed=304000 reason=VMSCAN_THROTTLE_NOPROGRESS
     24 usec_timeout=500000 usect_delayed=120000 reason=VMSCAN_THROTTLE_NOPROGRESS
     24 usec_timeout=500000 usect_delayed=312000 reason=VMSCAN_THROTTLE_NOPROGRESS
     27 usec_timeout=500000 usect_delayed=224000 reason=VMSCAN_THROTTLE_NOPROGRESS
     27 usec_timeout=500000 usect_delayed=68000 reason=VMSCAN_THROTTLE_NOPROGRESS
     28 usec_timeout=500000 usect_delayed=416000 reason=VMSCAN_THROTTLE_NOPROGRESS
     29 usec_timeout=500000 usect_delayed=200000 reason=VMSCAN_THROTTLE_NOPROGRESS
     30 usec_timeout=500000 usect_delayed=160000 reason=VMSCAN_THROTTLE_NOPROGRESS
     30 usec_timeout=500000 usect_delayed=60000 reason=VMSCAN_THROTTLE_NOPROGRESS
     30 usec_timeout=500000 usect_delayed=76000 reason=VMSCAN_THROTTLE_NOPROGRESS
     31 usec_timeout=500000 usect_delayed=496000 reason=VMSCAN_THROTTLE_NOPROGRESS
     32 usec_timeout=500000 usect_delayed=192000 reason=VMSCAN_THROTTLE_NOPROGRESS
     32 usec_timeout=500000 usect_delayed=296000 reason=VMSCAN_THROTTLE_NOPROGRESS
     38 usec_timeout=500000 usect_delayed=232000 reason=VMSCAN_THROTTLE_NOPROGRESS
     38 usec_timeout=500000 usect_delayed=320000 reason=VMSCAN_THROTTLE_NOPROGRESS
     39 usec_timeout=500000 usect_delayed=208000 reason=VMSCAN_THROTTLE_NOPROGRESS
     47 usec_timeout=500000 usect_delayed=108000 reason=VMSCAN_THROTTLE_NOPROGRESS
     47 usec_timeout=500000 usect_delayed=52000 reason=VMSCAN_THROTTLE_NOPROGRESS
     52 usec_timeout=500000 usect_delayed=128000 reason=VMSCAN_THROTTLE_NOPROGRESS
     54 usec_timeout=500000 usect_delayed=80000 reason=VMSCAN_THROTTLE_NOPROGRESS
     55 usec_timeout=500000 usect_delayed=288000 reason=VMSCAN_THROTTLE_NOPROGRESS
     61 usec_timeout=500000 usect_delayed=72000 reason=VMSCAN_THROTTLE_NOPROGRESS
     63 usec_timeout=500000 usect_delayed=84000 reason=VMSCAN_THROTTLE_NOPROGRESS
     68 usec_timeout=500000 usect_delayed=64000 reason=VMSCAN_THROTTLE_NOPROGRESS
     75 usec_timeout=500000 usect_delayed=44000 reason=VMSCAN_THROTTLE_NOPROGRESS
     80 usec_timeout=500000 usect_delayed=48000 reason=VMSCAN_THROTTLE_NOPROGRESS
     83 usec_timeout=500000 usect_delayed=88000 reason=VMSCAN_THROTTLE_NOPROGRESS
     88 usec_timeout=500000 usect_delayed=56000 reason=VMSCAN_THROTTLE_NOPROGRESS
     97 usec_timeout=500000 usect_delayed=100000 reason=VMSCAN_THROTTLE_NOPROGRESS
     99 usec_timeout=500000 usect_delayed=36000 reason=VMSCAN_THROTTLE_NOPROGRESS
     99 usec_timeout=500000 usect_delayed=92000 reason=VMSCAN_THROTTLE_NOPROGRESS
    102 usec_timeout=500000 usect_delayed=480000 reason=VMSCAN_THROTTLE_NOPROGRESS
    149 usec_timeout=500000 usect_delayed=40000 reason=VMSCAN_THROTTLE_NOPROGRESS
    187 usec_timeout=500000 usect_delayed=32000 reason=VMSCAN_THROTTLE_NOPROGRESS
    196 usec_timeout=500000 usect_delayed=28000 reason=VMSCAN_THROTTLE_NOPROGRESS
    245 usec_timeout=500000 usect_delayed=96000 reason=VMSCAN_THROTTLE_NOPROGRESS
    322 usec_timeout=500000 usect_delayed=24000 reason=VMSCAN_THROTTLE_NOPROGRESS
    406 usec_timeout=500000 usect_delayed=20000 reason=VMSCAN_THROTTLE_NOPROGRESS
    588 usec_timeout=500000 usect_delayed=16000 reason=VMSCAN_THROTTLE_NOPROGRESS
    843 usec_timeout=500000 usect_delayed=12000 reason=VMSCAN_THROTTLE_NOPROGRESS
   1299 usec_timeout=500000 usect_delayed=104000 reason=VMSCAN_THROTTLE_NOPROGRESS
   2839 usec_timeout=500000 usect_delayed=8000 reason=VMSCAN_THROTTLE_NOPROGRESS
  10111 usec_timeout=500000 usect_delayed=4000 reason=VMSCAN_THROTTLE_NOPROGRESS
  21492 usec_timeout=500000 usect_delayed=0 reason=VMSCAN_THROTTLE_NOPROGRESS
  36441 usec_timeout=500000 usect_delayed=500000 reason=VMSCAN_THROTTLE_NOPROGRESS

The full timeout is often hit but a large number also do not stall at all.
The remainder slept a little allowing other reclaim tasks to make progress.

While this timeout could be further increased, it could also negatively
impact worst-case behaviour when there is no prioritisation of what
task should make progress.

For VMSCAN_THROTTLE_WRITEBACK, the breakdown was

      5 usec_timeout=100000 usect_delayed=48000 reason=VMSCAN_THROTTLE_WRITEBACK
      7 usec_timeout=100000 usect_delayed=80000 reason=VMSCAN_THROTTLE_WRITEBACK
      8 usec_timeout=100000 usect_delayed=60000 reason=VMSCAN_THROTTLE_WRITEBACK
      9 usec_timeout=100000 usect_delayed=28000 reason=VMSCAN_THROTTLE_WRITEBACK
     12 usec_timeout=100000 usect_delayed=72000 reason=VMSCAN_THROTTLE_WRITEBACK
     12 usec_timeout=100000 usect_delayed=84000 reason=VMSCAN_THROTTLE_WRITEBACK
     13 usec_timeout=100000 usect_delayed=40000 reason=VMSCAN_THROTTLE_WRITEBACK
     14 usec_timeout=100000 usect_delayed=44000 reason=VMSCAN_THROTTLE_WRITEBACK
     14 usec_timeout=100000 usect_delayed=76000 reason=VMSCAN_THROTTLE_WRITEBACK
     16 usec_timeout=100000 usect_delayed=88000 reason=VMSCAN_THROTTLE_WRITEBACK
     21 usec_timeout=100000 usect_delayed=68000 reason=VMSCAN_THROTTLE_WRITEBACK
     24 usec_timeout=100000 usect_delayed=36000 reason=VMSCAN_THROTTLE_WRITEBACK
     25 usec_timeout=100000 usect_delayed=56000 reason=VMSCAN_THROTTLE_WRITEBACK
     26 usec_timeout=100000 usect_delayed=32000 reason=VMSCAN_THROTTLE_WRITEBACK
     32 usec_timeout=100000 usect_delayed=52000 reason=VMSCAN_THROTTLE_WRITEBACK
     45 usec_timeout=100000 usect_delayed=96000 reason=VMSCAN_THROTTLE_WRITEBACK
     50 usec_timeout=100000 usect_delayed=92000 reason=VMSCAN_THROTTLE_WRITEBACK
     60 usec_timeout=100000 usect_delayed=64000 reason=VMSCAN_THROTTLE_WRITEBACK
     74 usec_timeout=100000 usect_delayed=24000 reason=VMSCAN_THROTTLE_WRITEBACK
    122 usec_timeout=100000 usect_delayed=16000 reason=VMSCAN_THROTTLE_WRITEBACK
    134 usec_timeout=100000 usect_delayed=20000 reason=VMSCAN_THROTTLE_WRITEBACK
    310 usec_timeout=100000 usect_delayed=12000 reason=VMSCAN_THROTTLE_WRITEBACK
    568 usec_timeout=100000 usect_delayed=8000 reason=VMSCAN_THROTTLE_WRITEBACK
   2038 usec_timeout=100000 usect_delayed=4000 reason=VMSCAN_THROTTLE_WRITEBACK
   7061 usec_timeout=100000 usect_delayed=0 reason=VMSCAN_THROTTLE_WRITEBACK
  61547 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK

The majority hit the timeout in direct reclaim context although
a sizable number did not stall at all. This is very different to
kswapd where only a tiny percentage of stalls due to writeback
reached the timeout.

Bottom line, the throttling appears to work and the wakeup events may limit
worst case stalls. There might be some grounds for adjusting timeouts but
it's likely futile as the worst-case scenarios depend on the workload,
memory size and the speed of the storage. A better approach to improve
the series further would be to prioritise tasks based on their rate of
allocation with the caveat that it may be very expensive to track.

-- 
2.31.1

