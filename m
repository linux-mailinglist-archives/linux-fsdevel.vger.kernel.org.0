Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC77480827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 11:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhL1KE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhL1KE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:04:28 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A0C061574;
        Tue, 28 Dec 2021 02:04:28 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n29L9-0002M2-F7; Tue, 28 Dec 2021 11:04:19 +0100
Message-ID: <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info>
Date:   Tue, 28 Dec 2021 11:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Content-Language: en-BS
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211202150614.22440-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1640685868;b59603a4;
X-HE-SMSGID: 1n29L9-0002M2-F7
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 02.12.21 16:06, Mel Gorman wrote:
> Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> problems due to reclaim throttling for excessive lengths of time.
> In Alexey's case, a memory hog that should go OOM quickly stalls for
> several minutes before stalling. In Mike and Darrick's cases, a small
> memcg environment stalled excessively even though the system had enough
> memory overall.

Just wondering: this patch afaics is now in -mm and  Linux next for
nearly two weeks. Is that intentional? I had expected it to be mainlined
with the batch of patches Andrew mailed to Linus last week, but it
wasn't among them.

Or am I missing something?

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.


> Commit 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being
> made") introduced the problem although commit a19594ca4a8b ("mm/vmscan:
> increase the timeout if page reclaim is not making progress") made it
> worse. Systems at or near an OOM state that cannot be recovered must
> reach OOM quickly and memcg should kill tasks if a memcg is near OOM.
> 
> To address this, only stall for the first zone in the zonelist, reduce
> the timeout to 1 tick for VMSCAN_THROTTLE_NOPROGRESS and only stall if
> the scan control nr_reclaimed is 0, kswapd is still active and there were
> excessive pages pending for writeback. If kswapd has stopped reclaiming due
> to excessive failures, do not stall at all so that OOM triggers relatively
> quickly. Similarly, if an LRU is simply congested, only lightly throttle
> similar to NOPROGRESS.
> 
> Alexey's original case was the most straight forward
> 
> 	for i in {1..3}; do tail /dev/zero; done
> 
> On vanilla 5.16-rc1, this test stalled heavily, after the patch the test
> completes in a few seconds similar to 5.15.
> 
> Alexey's second test case added watching a youtube video while tail runs
> 10 times. On 5.15, playback only jitters slightly, 5.16-rc1 stalls a lot
> with lots of frames missing and numerous audio glitches. With this patch
> applies, the video plays similarly to 5.15.
> 
> Link: https://lore.kernel.org/r/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de
> Link: https://lore.kernel.org/r/20211124011954.7cab9bb4@mail.inbox.lv
> Link: https://lore.kernel.org/r/20211022144651.19914-1-mgorman@techsingularity.net
> 
> [lkp@intel.com: Fix W=1 build warning]
> Reported-and-tested-by: Alexey Avramov <hakavlad@inbox.lv>
> Reported-and-tested-by: Mike Galbraith <efault@gmx.de>
> Reported-and-tested-by: Darrick J. Wong <djwong@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being made")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/mmzone.h        |  1 +
>  include/trace/events/vmscan.h |  4 ++-
>  mm/vmscan.c                   | 64 ++++++++++++++++++++++++++++++-----
>  3 files changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..936dc0b6c226 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -277,6 +277,7 @@ enum vmscan_throttle_state {
>  	VMSCAN_THROTTLE_WRITEBACK,
>  	VMSCAN_THROTTLE_ISOLATED,
>  	VMSCAN_THROTTLE_NOPROGRESS,
> +	VMSCAN_THROTTLE_CONGESTED,
>  	NR_VMSCAN_THROTTLE,
>  };
>  
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index f25a6149d3ba..ca2e9009a651 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -30,12 +30,14 @@
>  #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
>  #define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
>  #define _VMSCAN_THROTTLE_NOPROGRESS	(1 << VMSCAN_THROTTLE_NOPROGRESS)
> +#define _VMSCAN_THROTTLE_CONGESTED	(1 << VMSCAN_THROTTLE_CONGESTED)
>  
>  #define show_throttle_flags(flags)						\
>  	(flags) ? __print_flags(flags, "|",					\
>  		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"},	\
>  		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"},	\
> -		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"}	\
> +		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"},	\
> +		{_VMSCAN_THROTTLE_CONGESTED,	"VMSCAN_THROTTLE_CONGESTED"}	\
>  		) : "VMSCAN_THROTTLE_NONE"
>  
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..4c4d5f6cd8a3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1021,6 +1021,39 @@ static void handle_write_error(struct address_space *mapping,
>  	unlock_page(page);
>  }
>  
> +static bool skip_throttle_noprogress(pg_data_t *pgdat)
> +{
> +	int reclaimable = 0, write_pending = 0;
> +	int i;
> +
> +	/*
> +	 * If kswapd is disabled, reschedule if necessary but do not
> +	 * throttle as the system is likely near OOM.
> +	 */
> +	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
> +		return true;
> +
> +	/*
> +	 * If there are a lot of dirty/writeback pages then do not
> +	 * throttle as throttling will occur when the pages cycle
> +	 * towards the end of the LRU if still under writeback.
> +	 */
> +	for (i = 0; i < MAX_NR_ZONES; i++) {
> +		struct zone *zone = pgdat->node_zones + i;
> +
> +		if (!populated_zone(zone))
> +			continue;
> +
> +		reclaimable += zone_reclaimable_pages(zone);
> +		write_pending += zone_page_state_snapshot(zone,
> +						  NR_ZONE_WRITE_PENDING);
> +	}
> +	if (2 * write_pending <= reclaimable)
> +		return true;
> +
> +	return false;
> +}
> +
>  void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
>  {
>  	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
> @@ -1056,8 +1089,16 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
>  		}
>  
>  		break;
> +	case VMSCAN_THROTTLE_CONGESTED:
> +		fallthrough;
>  	case VMSCAN_THROTTLE_NOPROGRESS:
> -		timeout = HZ/2;
> +		if (skip_throttle_noprogress(pgdat)) {
> +			cond_resched();
> +			return;
> +		}
> +
> +		timeout = 1;
> +
>  		break;
>  	case VMSCAN_THROTTLE_ISOLATED:
>  		timeout = HZ/50;
> @@ -3321,7 +3362,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	if (!current_is_kswapd() && current_may_throttle() &&
>  	    !sc->hibernation_mode &&
>  	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
> -		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
> +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
>  
>  	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
>  				    sc))
> @@ -3386,16 +3427,16 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
>  	}
>  
>  	/*
> -	 * Do not throttle kswapd on NOPROGRESS as it will throttle on
> -	 * VMSCAN_THROTTLE_WRITEBACK if there are too many pages under
> -	 * writeback and marked for immediate reclaim at the tail of
> -	 * the LRU.
> +	 * Do not throttle kswapd or cgroup reclaim on NOPROGRESS as it will
> +	 * throttle on VMSCAN_THROTTLE_WRITEBACK if there are too many pages
> +	 * under writeback and marked for immediate reclaim at the tail of the
> +	 * LRU.
>  	 */
> -	if (current_is_kswapd())
> +	if (current_is_kswapd() || cgroup_reclaim(sc))
>  		return;
>  
>  	/* Throttle if making no progress at high prioities. */
> -	if (sc->priority < DEF_PRIORITY - 2)
> +	if (sc->priority == 1 && !sc->nr_reclaimed)
>  		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
>  }
>  
> @@ -3415,6 +3456,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  	unsigned long nr_soft_scanned;
>  	gfp_t orig_mask;
>  	pg_data_t *last_pgdat = NULL;
> +	pg_data_t *first_pgdat = NULL;
>  
>  	/*
>  	 * If the number of buffer_heads in the machine exceeds the maximum
> @@ -3478,14 +3520,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  			/* need some check for avoid more shrink_zone() */
>  		}
>  
> +		if (!first_pgdat)
> +			first_pgdat = zone->zone_pgdat;
> +
>  		/* See comment about same check for global reclaim above */
>  		if (zone->zone_pgdat == last_pgdat)
>  			continue;
>  		last_pgdat = zone->zone_pgdat;
>  		shrink_node(zone->zone_pgdat, sc);
> -		consider_reclaim_throttle(zone->zone_pgdat, sc);
>  	}
>  
> +	consider_reclaim_throttle(first_pgdat, sc);
> +
>  	/*
>  	 * Restore to original mask to avoid the impact on the caller if we
>  	 * promoted it to __GFP_HIGHMEM.

