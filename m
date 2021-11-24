Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C469F45CBB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhKXSFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 13:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhKXSFQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:05:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D51960FE7;
        Wed, 24 Nov 2021 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637776926;
        bh=ghJS3jGGu5kWGLtrRX24KcEJQU5zXpWk4Ozmk3/+lI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hh6dJHCgf43J99xBMAJumYKbP8Runga4il/ukvb/iTFg1CHRx6S2JegpL/ujVQ6EE
         ISWcSW/Xl4uainmZk3I7c4TQeGBtZxlYLpBe/zOMO9Kiak/MXvLn8WRcll6SL2KkEb
         f2aFVw8dHuv9KrpH2FOUJXI1BR+nMIOhzYrQCFpRAey+hhIw05qpl29ObUMbI8jJla
         f3IqVCzV/sdWNmLwGP6W1h2Kj0YNjX5GyY+D0mdrTmTz6TRR0wdWMF9UEFDYrRedJp
         lpSHLjqYSOWZdXstEMbJwhkhYLqmbZk7rGmGiy/7YbmMo9mJZUKSRixPKgPUb07AUG
         R9G4b6peZn9zg==
Date:   Wed, 24 Nov 2021 10:02:05 -0800
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
Message-ID: <20211124180205.GA266049@magnolia>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
 <20211022144651.19914-4-mgorman@techsingularity.net>
 <20211124011912.GA265983@magnolia>
 <20211124014914.GB265983@magnolia>
 <20211124143559.GI3366@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124143559.GI3366@techsingularity.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 02:35:59PM +0000, Mel Gorman wrote:
> On Tue, Nov 23, 2021 at 05:49:14PM -0800, Darrick J. Wong wrote:
> > > Ever since Christoph broke swapfiles, I've been carrying around a little
> > > fstest in my dev tree[1] that tries to exercise paging things in and out
> > > of a swapfile.  Sadly I've been trapped in about three dozen customer
> > > escalations for over a month, which means I haven't been able to do much
> > > upstream in weeks.  Like submit this test upstream. :(
> > > 
> > > Now that I've finally gotten around to trying out a 5.16-rc2 build, I
> > > notice that the runtime of this test has gone from ~5s to 2 hours.
> > > Among other things that it does, the test sets up a cgroup with a memory
> > > controller limiting the memory usage to 25MB, then runs a program that
> > > tries to dirty 50MB of memory.  There's 2GB of memory in the VM, so
> > > we're not running reclaim globally, but the cgroup gets throttled very
> > > severely.
> > > 
> > > AFAICT the system is mostly idle, but it's difficult to tell because ps
> > > and top also get stuck waiting for this cgroup for whatever reason.  My
> > > uninformed spculation is that usemem_and_swapoff takes a page fault
> > > while dirtying the 50MB memory buffer, prepares to pull a page in from
> > > swap, tries to evict another page to stay under the memcg limit, but
> > > that decides that it's making no progress and calls
> > > reclaim_throttle(..., VMSCAN_THROTTLE_NOPROGRESS).
> > > 
> > > The sleep is uninterruptible, so I can't even kill -9 fstests to shut it
> > > down.  Eventually we either finish the test or (for the mlock part) the
> > > OOM killer actually kills the process, but this takes a very long time.
> > > 
> > > Any thoughts?  For now I can just hack around this by skipping
> > > reclaim_throttle if cgroup_reclaim() == true, but that's probably not
> > > the correct fix. :)
> > 
> > Update: after adding timing information to usemem_and_swapoff, it looks
> > like dirtying the 50MB buffer takes ~22s (up from 0.06s on 5.15).  The
> > mlock call stalls for ~280s until the OOM killer kills it (up from
> > nearly instantaneous on 5.15), and the swapon/swapoff variant takes
> > 20 minutes to hours depending on the run.
> > 
> 
> Can you try the patch below please? I think I'm running the test
> correctly and it finishes for me in 16 seconds with this applied

20 seconds here, but this /does/ fix the problem.  Thank you!

Tested-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 07db03883062..d9166e94eb95 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1057,7 +1057,17 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
>  
>  		break;
>  	case VMSCAN_THROTTLE_NOPROGRESS:
> -		timeout = HZ/2;
> +		timeout = 1;
> +
> +		/*
> +		 * If kswapd is disabled, reschedule if necessary but do not
> +		 * throttle as the system is likely near OOM.
> +		 */
> +		if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES) {
> +			cond_resched();
> +			return;
> +		}
> +
>  		break;
>  	case VMSCAN_THROTTLE_ISOLATED:
>  		timeout = HZ/50;
> @@ -3395,7 +3405,7 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
>  		return;
>  
>  	/* Throttle if making no progress at high prioities. */
> -	if (sc->priority < DEF_PRIORITY - 2)
> +	if (sc->priority < DEF_PRIORITY - 2 && !sc->nr_reclaimed)
>  		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
>  }
>  
> @@ -3415,6 +3425,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  	unsigned long nr_soft_scanned;
>  	gfp_t orig_mask;
>  	pg_data_t *last_pgdat = NULL;
> +	pg_data_t *first_pgdat = NULL;
>  
>  	/*
>  	 * If the number of buffer_heads in the machine exceeds the maximum
> @@ -3478,14 +3489,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
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
