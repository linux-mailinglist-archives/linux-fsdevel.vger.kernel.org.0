Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657AD41323C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhIULFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 07:05:01 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:54200 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhIULEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:04:54 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id CCFF0BF071
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 12:03:24 +0100 (IST)
Received: (qmail 2386 invoked from network); 21 Sep 2021 11:03:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 11:03:24 -0000
Date:   Tue, 21 Sep 2021 12:03:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>, Theodore Ts'o <tytso@mit.edu>,
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
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] mm/vmscan: Throttle reclaim and compaction when too
 may pages are isolated
Message-ID: <20210921110323.GP3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-3-mgorman@techsingularity.net>
 <163218047640.3992.16597395100064789255@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163218047640.3992.16597395100064789255@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:27:56AM +1000, NeilBrown wrote:
> On Mon, 20 Sep 2021, Mel Gorman wrote:
> > @@ -2291,8 +2302,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> >  			return 0;
> >  
> >  		/* wait a bit for the reclaimer. */
> > -		msleep(100);
> > -		stalled = true;
> > +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
> 
> Why drop the assignment to "stalled"?
> Doing that changes the character of the loop - and makes the 'stalled'
> variable always 'false'.
> 

This was a thought that was never completed. The intent was that if
there are too many pages isolated that it should not return prematurely
and do busy work elsewhere. It potentially means an allocation request
moves to lower zones or remote nodes prematurely but I never did the
full removal. Even if I had, on reflection, that type of behavioural
change does not belong in this series.

I've restored the "stalled = true".

-- 
Mel Gorman
SUSE Labs
