Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA645B117
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 02:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhKXBWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 20:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhKXBWW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:22:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5346160F5B;
        Wed, 24 Nov 2021 01:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637716753;
        bh=+eAMlPxbAMpmUM1vrLqrEV0szMpwU9SyCqtGZy/+OT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLUAhJbdIUbifaR0KUbJSCUw8pqHSkWPwtiBAr1yHcFO8uEteIFap1QzZRZf551V+
         aML3+T/lDHF+9g6//3pPCo5gLppFLg7+U0dItZ1e/KRrKrku/9PPTX99LgnnawbMpC
         bJY9JLHNt/kChBTm/qnrgvV3fsMI6w7QFzd/Ka+sPg03wqZGj1i2nzmtilsfdLGyj0
         O5XjZYx0CXSWiF5ubb2wWXX88CBPNwYc9hWn86xkiZWKCHO8bB2CIISrTwlpv4cuV0
         MGHSXcpp2prYsqqzHt7T0BueMAqYtrLplNPf9Xe8j9pGKQl8H9f+qBFdQyudkXR8yN
         ajIbarT1/X2nA==
Date:   Tue, 23 Nov 2021 17:19:12 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <20211124011912.GA265983@magnolia>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
 <20211022144651.19914-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022144651.19914-4-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 03:46:46PM +0100, Mel Gorman wrote:
> Memcg reclaim throttles on congestion if no reclaim progress is made.
> This makes little sense, it might be due to writeback or a host of
> other factors.
> 
> For !memcg reclaim, it's messy. Direct reclaim primarily is throttled
> in the page allocator if it is failing to make progress. Kswapd
> throttles if too many pages are under writeback and marked for
> immediate reclaim.
> 
> This patch explicitly throttles if reclaim is failing to make progress.

Hi Mel,

Ever since Christoph broke swapfiles, I've been carrying around a little
fstest in my dev tree[1] that tries to exercise paging things in and out
of a swapfile.  Sadly I've been trapped in about three dozen customer
escalations for over a month, which means I haven't been able to do much
upstream in weeks.  Like submit this test upstream. :(

Now that I've finally gotten around to trying out a 5.16-rc2 build, I
notice that the runtime of this test has gone from ~5s to 2 hours.
Among other things that it does, the test sets up a cgroup with a memory
controller limiting the memory usage to 25MB, then runs a program that
tries to dirty 50MB of memory.  There's 2GB of memory in the VM, so
we're not running reclaim globally, but the cgroup gets throttled very
severely.

AFAICT the system is mostly idle, but it's difficult to tell because ps
and top also get stuck waiting for this cgroup for whatever reason.  My
uninformed spculation is that usemem_and_swapoff takes a page fault
while dirtying the 50MB memory buffer, prepares to pull a page in from
swap, tries to evict another page to stay under the memcg limit, but
that decides that it's making no progress and calls
reclaim_throttle(..., VMSCAN_THROTTLE_NOPROGRESS).

The sleep is uninterruptible, so I can't even kill -9 fstests to shut it
down.  Eventually we either finish the test or (for the mlock part) the
OOM killer actually kills the process, but this takes a very long time.

Any thoughts?  For now I can just hack around this by skipping
reclaim_throttle if cgroup_reclaim() == true, but that's probably not
the correct fix. :)

--D

[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/commit/?h=test-swapfile-io&id=0d0ad843cea366d0ab0a7d8d984e5cd1deba5b43

> 
> [vbabka@suse.cz: Remove redundant code]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mmzone.h        |  1 +
>  include/trace/events/vmscan.h |  4 +++-
>  mm/memcontrol.c               | 10 +---------
>  mm/vmscan.c                   | 28 ++++++++++++++++++++++++++++
>  4 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9ccd8d95291b..00e305cfb3ec 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -276,6 +276,7 @@ enum lru_list {
>  enum vmscan_throttle_state {
>  	VMSCAN_THROTTLE_WRITEBACK,
>  	VMSCAN_THROTTLE_ISOLATED,
> +	VMSCAN_THROTTLE_NOPROGRESS,
>  	NR_VMSCAN_THROTTLE,
>  };
>  
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index d4905bd9e9c4..f25a6149d3ba 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -29,11 +29,13 @@
>  
>  #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
>  #define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
> +#define _VMSCAN_THROTTLE_NOPROGRESS	(1 << VMSCAN_THROTTLE_NOPROGRESS)
>  
>  #define show_throttle_flags(flags)						\
>  	(flags) ? __print_flags(flags, "|",					\
>  		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"},	\
> -		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"}	\
> +		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"},	\
> +		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"}	\
>  		) : "VMSCAN_THROTTLE_NONE"
>  
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6da5020a8656..8b33152c9b85 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3465,19 +3465,11 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  
>  	/* try to free all pages in this cgroup */
>  	while (nr_retries && page_counter_read(&memcg->memory)) {
> -		int progress;
> -
>  		if (signal_pending(current))
>  			return -EINTR;
>  
> -		progress = try_to_free_mem_cgroup_pages(memcg, 1,
> -							GFP_KERNEL, true);
> -		if (!progress) {
> +		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL, true))
>  			nr_retries--;
> -			/* maybe some writeback is necessary */
> -			congestion_wait(BLK_RW_ASYNC, HZ/10);
> -		}
> -
>  	}
>  
>  	return 0;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1e54e636b927..0450f6867d61 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3323,6 +3323,33 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
>  	return zone_watermark_ok_safe(zone, 0, watermark, sc->reclaim_idx);
>  }
>  
> +static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
> +{
> +	/* If reclaim is making progress, wake any throttled tasks. */
> +	if (sc->nr_reclaimed) {
> +		wait_queue_head_t *wqh;
> +
> +		wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_NOPROGRESS];
> +		if (waitqueue_active(wqh))
> +			wake_up(wqh);
> +
> +		return;
> +	}
> +
> +	/*
> +	 * Do not throttle kswapd on NOPROGRESS as it will throttle on
> +	 * VMSCAN_THROTTLE_WRITEBACK if there are too many pages under
> +	 * writeback and marked for immediate reclaim at the tail of
> +	 * the LRU.
> +	 */
> +	if (current_is_kswapd())
> +		return;
> +
> +	/* Throttle if making no progress at high prioities. */
> +	if (sc->priority < DEF_PRIORITY - 2)
> +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
> +}
> +
>  /*
>   * This is the direct reclaim path, for page-allocating processes.  We only
>   * try to reclaim pages from zones which will satisfy the caller's allocation
> @@ -3407,6 +3434,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  			continue;
>  		last_pgdat = zone->zone_pgdat;
>  		shrink_node(zone->zone_pgdat, sc);
> +		consider_reclaim_throttle(zone->zone_pgdat, sc);
>  	}
>  
>  	/*
> -- 
> 2.31.1
> 
