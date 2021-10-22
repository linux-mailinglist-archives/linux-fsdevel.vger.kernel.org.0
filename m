Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07F437389
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhJVIRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:17:10 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:50469 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhJVIRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:17:10 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id E559C1C47A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 09:14:51 +0100 (IST)
Received: (qmail 24056 invoked from network); 22 Oct 2021 08:14:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Oct 2021 08:14:51 -0000
Date:   Fri, 22 Oct 2021 09:14:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
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
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] mm/vmscan: Increase the timeout if page reclaim is
 not making progress
Message-ID: <20211022081450.GH3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <20211019090108.25501-8-mgorman@techsingularity.net>
 <163486486314.17149.7181265861483962024@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163486486314.17149.7181265861483962024@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:07:43PM +1100, NeilBrown wrote:
> On Tue, 19 Oct 2021, Mel Gorman wrote:
> > Tracing of the stutterp workload showed the following delays
> > 
> >       1 usect_delayed=124000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=128000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=176000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=536000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=544000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=556000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=624000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=716000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       1 usect_delayed=772000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >       2 usect_delayed=512000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >      16 usect_delayed=120000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >      53 usect_delayed=116000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >     116 usect_delayed=112000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >    5907 usect_delayed=108000 reason=VMSCAN_THROTTLE_NOPROGRESS
> >   71741 usect_delayed=104000 reason=VMSCAN_THROTTLE_NOPROGRESS
> > 
> > All the throttling hit the full timeout and then there was wakeup delays
> > meaning that the wakeups are premature as no other reclaimer such as
> > kswapd has made progress. This patch increases the maximum timeout.
> 
> Would love to see the comparable tracing results for after the patch.
> 

They're in the leader. The trace figures in the changelog are the ones I
had at the time the patch was developed and I didn't keep them up to date
to reduce overall test time. At the last set of results, some throttling
was still hitting the full timeout;

  [....]
    843 usec_timeout=500000 usect_delayed=12000 reason=VMSCAN_THROTTLE_NOPROGRESS
   1299 usec_timeout=500000 usect_delayed=104000 reason=VMSCAN_THROTTLE_NOPROGRESS
   2839 usec_timeout=500000 usect_delayed=8000 reason=VMSCAN_THROTTLE_NOPROGRESS
  10111 usec_timeout=500000 usect_delayed=4000 reason=VMSCAN_THROTTLE_NOPROGRESS
  21492 usec_timeout=500000 usect_delayed=0 reason=VMSCAN_THROTTLE_NOPROGRESS
  36441 usec_timeout=500000 usect_delayed=500000 reason=VMSCAN_THROTTLE_NOPROGRESS


-- 
Mel Gorman
SUSE Labs
