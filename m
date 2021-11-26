Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A245EB24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376549AbhKZKTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 05:19:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhKZKRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:17:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12F941FD37;
        Fri, 26 Nov 2021 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637921671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2cifr/PNsU/ws24Hh5E83jwlr20VSoPNbvNf3rccVU=;
        b=YaF1IivUAVaY/AdmlBTeq1HhmnsL5CncLOX6JLOIX7pi9ILDrxPyrrQJyUZzMFhTb7+rMm
        uwfeaBny8YoXLD2XBUEBEF+o5zzy+UCfqxe+lQXPOluAz4LEiI6ZrPhqNEjRVU2EJIj6uw
        1dZ9wtWDJsSV7it0Gjj5wmTLxHXldRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637921671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2cifr/PNsU/ws24Hh5E83jwlr20VSoPNbvNf3rccVU=;
        b=nQf7sgtRlKTf7wY98+KKokm9OB5fXxf/YPihEShWuHsfMVQKXHJ5BTQqOZDWDo8KRp6Thh
        R+KVV+oXLZRMGqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD2B013C35;
        Fri, 26 Nov 2021 10:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ogpmMYazoGEHVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Nov 2021 10:14:30 +0000
Message-ID: <8817f97a-9c2c-26db-1ab4-0bbdbdc04184@suse.cz>
Date:   Fri, 26 Nov 2021 11:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211125151853.8540-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/25/21 16:18, Mel Gorman wrote:
> Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> problems due to reclaim throttling for excessive lengths of time.
> In Alexey's case, a memory hog that should go OOM quickly stalls for
> several minutes before stalling. In Mike and Darrick's cases, a small
> memcg environment stalled excessively even though the system had enough
> memory overall.
> 
> Commit 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being
> made") introduced the problem although commit a19594ca4a8b ("mm/vmscan:
> increase the timeout if page reclaim is not making progress") made it
> worse. Systems at or near an OOM state that cannot be recovered must
> reach OOM quickly and memcg should kill tasks if a memcg is near OOM.
> 
> To address this, only stall for the first zone in the zonelist, reduce
> the timeout to 1 tick for VMSCAN_THROTTLE_NOPROGRESS and only stall if
> the scan control nr_reclaimed is 0 and kswapd is still active.  If kswapd
> has stopped reclaiming due to excessive failures, do not stall at all so
> that OOM triggers relatively quickly.
> 
> Alexey's test case was the most straight forward
> 
> 	for i in {1..3}; do tail /dev/zero; done
> 
> On vanilla 5.16-rc1, this test stalled and was reset after 10 minutes.
> After the patch, the test gets killed after roughly 15 seconds which is
> the same length of time taken in 5.15.
> 
> Link: https://lore.kernel.org/r/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de
> Link: https://lore.kernel.org/r/20211124011954.7cab9bb4@mail.inbox.lv
> Link: https://lore.kernel.org/r/20211022144651.19914-1-mgorman@techsingularity.net

Should probably include Reported-by: tags too?

> Fixes: 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being made")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmscan.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..176ddd28df21 100644
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
> 

