Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E03414F6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhIVRyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 13:54:18 -0400
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:45165 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236815AbhIVRyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:54:17 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id A025E1C4E2A
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 18:52:46 +0100 (IST)
Received: (qmail 19097 invoked from network); 22 Sep 2021 17:52:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 17:52:46 -0000
Date:   Wed, 22 Sep 2021 18:52:44 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Message-ID: <20210922175244.GC3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210921204621.GY2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210921204621.GY2361455@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 06:46:21AM +1000, Dave Chinner wrote:
> On Mon, Sep 20, 2021 at 09:54:31AM +0100, Mel Gorman wrote:
> > Cc list similar to "congestion_wait() and GFP_NOFAIL" as they're loosely
> > related.
> > 
> > This is a prototype series that removes all calls to congestion_wait
> > in mm/ and deletes wait_iff_congested. It's not a clever
> > implementation but congestion_wait has been broken for a long time
> > (https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).
> > Even if it worked, it was never a great idea. While excessive
> > dirty/writeback pages at the tail of the LRU is one possibility that
> > reclaim may be slow, there is also the problem of too many pages being
> > isolated and reclaim failing for other reasons (elevated references,
> > too many pages isolated, excessive LRU contention etc).
> > 
> > This series replaces the reclaim conditions with event driven ones
> > 
> > o If there are too many dirty/writeback pages, sleep until a timeout
> >   or enough pages get cleaned
> > o If too many pages are isolated, sleep until enough isolated pages
> >   are either reclaimed or put back on the LRU
> > o If no progress is being made, let direct reclaim tasks sleep until
> >   another task makes progress
> > 
> > This has been lightly tested only and the testing was useless as the
> > relevant code was not executed. The workload configurations I had that
> > used to trigger these corner cases no longer work (yey?) and I'll need
> > to implement a new synthetic workload. If someone is aware of a realistic
> > workload that forces reclaim activity to the point where reclaim stalls
> > then kindly share the details.
> 
> Got a git tree pointer so I can pull it into a test kernel so I can
> see what impact it has on behaviour before I try to make sense of
> the code?
> 

The current version I'm testing is at

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-reclaimcongest-v2r5

Only one test has completed and I won't be able to analyse the results
in detail for a few days but it's doing *something* for the workload that
is hammering reclaim

                  5.15.0-rc1  5.15.0-rc1
                     vanillamm-reclaimcongest-v2r5
Duration User       10891.30     9945.59
Duration System      5673.78     2649.43
Duration Elapsed     2402.85     2407.96

System CPU usage dropped by a lot. Workload completes runs for a fixed
duration so a difference in elapsed is not interesting

Ops Direct pages scanned           518791317.00   219956338.00
Ops Kswapd pages scanned           128555233.00   165439373.00
Ops Kswapd pages reclaimed          87830801.00    72216420.00
Ops Direct pages reclaimed          16114049.00    10408389.00
Ops Kswapd efficiency %                   68.32          43.65
Ops Kswapd velocity                    53501.15       68705.20
Ops Direct efficiency %                    3.11           4.73
Ops Direct velocity                   215906.66       91345.5
Ops Percentage direct scans               80.14          57.07
Ops Page writes by reclaim           4225921.00     2032865.00

Large reductions in direct pages scanned. The rate kswapd scans is roughly
the same (velocity) where as direct velocity is down (presumably because
it's getting throttled). Pages written from reclaim context are about
halved. Kswapd scan rates are increased slightly but probably because
direct reclaimers throttled. Reclaim efficiency is low but that's expected
given the workload is basically trying to make it as hard as possible
for reclaim to make progress.

Kswapd is only getting throttled on writeback and is being woken before
the timeout of 100000

      1 usect_delayed=84000 reason=VMSCAN_THROTTLE_WRITEBACK
      2 usect_delayed=20000 reason=VMSCAN_THROTTLE_WRITEBACK
      6 usect_delayed=16000 reason=VMSCAN_THROTTLE_WRITEBACK
     12 usect_delayed=12000 reason=VMSCAN_THROTTLE_WRITEBACK
     17 usect_delayed=8000 reason=VMSCAN_THROTTLE_WRITEBACK
    129 usect_delayed=4000 reason=VMSCAN_THROTTLE_WRITEBACK
    205 usect_delayed=0 reason=VMSCAN_THROTTLE_WRITEBACK

The number of throttle events for direct reclaimers were

  16909 reason=VMSCAN_THROTTLE_ISOLATED
  77844 reason=VMSCAN_THROTTLE_NOPROGRESS
 113415 reason=VMSCAN_THROTTLE_WRITEBACK

For the throttle events, 33% of them were NOPROGRESS hitting the full
timeout and 33% were WRITEBACK hitting the full timeout. If anything,
that would suggest increasing the max timeout as presumably they woke up
uselessly like Neil had suggested.

-- 
Mel Gorman
SUSE Labs
