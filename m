Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205C342D9AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhJNNFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 09:05:21 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:47117 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhJNNFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:05:21 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id F23CFC0BCF
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Oct 2021 14:03:14 +0100 (IST)
Received: (qmail 518 invoked from network); 14 Oct 2021 13:03:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Oct 2021 13:03:14 -0000
Date:   Thu, 14 Oct 2021 14:03:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] mm/vmscan: Throttle reclaim when no progress is
 being made
Message-ID: <20211014130312.GA3959@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
 <20211008135332.19567-4-mgorman@techsingularity.net>
 <63336163-e709-65de-6d53-8764facd3924@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <63336163-e709-65de-6d53-8764facd3924@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 02:31:17PM +0200, Vlastimil Babka wrote:
> On 10/8/21 15:53, Mel Gorman wrote:
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
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ...
> > @@ -3769,6 +3797,16 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >  	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
> >  	set_task_reclaim_state(current, NULL);
> >  
> > +	if (!nr_reclaimed) {
> > +		struct zoneref *z;
> > +		pg_data_t *pgdat;
> > +
> > +		z = first_zones_zonelist(zonelist, sc.reclaim_idx, sc.nodemask);
> > +		pgdat = zonelist_zone(z)->zone_pgdat;
> > +
> > +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
> > +	}
> 
> Is this necessary? AFAICS here we just returned from:
> 
> do_try_to_free_pages()
>   shrink_zones()
>    for_each_zone()...
>      consider_reclaim_throttle()
> 
> Which already throttles when needed and using the appropriate pgdat, while
> here we have to somewhat awkwardly assume the preferred one.
> 

Yes, you're right, consider_reclaim_throttle not only throttles on the
appropriate pgdat but takes priority into account.

Well spotted!

-- 
Mel Gorman
SUSE Labs
