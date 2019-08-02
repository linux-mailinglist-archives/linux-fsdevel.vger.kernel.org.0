Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE34B7FD7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfHBP1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732033AbfHBP1M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:27:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26D163082137;
        Fri,  2 Aug 2019 15:27:12 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98BF05D9D3;
        Fri,  2 Aug 2019 15:27:11 +0000 (UTC)
Date:   Fri, 2 Aug 2019 11:27:09 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/24] mm: directed shrinker work deferral
Message-ID: <20190802152709.GA60893@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-2-david@fromorbit.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 02 Aug 2019 15:27:12 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:29PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Introduce a mechanism for ->count_objects() to indicate to the
> shrinker infrastructure that the reclaim context will not allow
> scanning work to be done and so the work it decides is necessary
> needs to be deferred.
> 
> This simplifies the code by separating out the accounting of
> deferred work from the actual doing of the work, and allows better
> decisions to be made by the shrinekr control logic on what action it
> can take.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/linux/shrinker.h | 7 +++++++
>  mm/vmscan.c              | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 9443cafd1969..af78c475fc32 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -31,6 +31,13 @@ struct shrink_control {
>  
>  	/* current memcg being shrunk (for memcg aware shrinkers) */
>  	struct mem_cgroup *memcg;
> +
> +	/*
> +	 * set by ->count_objects if reclaim context prevents reclaim from
> +	 * occurring. This allows the shrinker to immediately defer all the
> +	 * work and not even attempt to scan the cache.
> +	 */
> +	bool will_defer;

Functionality wise this seems fairly straightforward. FWIW, I find the
'will_defer' name a little confusing because it implies to me that the
shrinker is telling the caller about something it would do if called as
opposed to explicitly telling the caller to defer. I'd just call it
'defer' I guess, but that's just my .02. ;P

>  };
>  
>  #define SHRINK_STOP (~0UL)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 44df66a98f2a..ae3035fe94bc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -541,6 +541,13 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
>  				   freeable, delta, total_scan, priority);
>  
> +	/*
> +	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> +	 * defer the work to a context that can scan the cache.
> +	 */
> +	if (shrinkctl->will_defer)
> +		goto done;
> +

Who's responsible for clearing the flag? Perhaps we should do so here
once it's acted upon since we don't call into the shrinker again?

Note that I see this structure is reinitialized on every iteration in
the caller, but there already is the SHRINK_EMPTY case where we call
back into do_shrink_slab(). Granted the deferred state likely hasn't
changed, but the fact that we'd call back into the count callback to set
it again implies the logic could be a bit more explicit, particularly if
this will eventually be used for more dynamic shrinker state that might
change call to call (i.e., object dirty state, etc.).

BTW, do we need to care about the ->nr_cached_objects() call from the
generic superblock shrinker (super_cache_scan())?

Brian

>  	/*
>  	 * Normally, we should not scan less than batch_size objects in one
>  	 * pass to avoid too frequent shrinker calls, but if the slab has less
> @@ -575,6 +582,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		cond_resched();
>  	}
>  
> +done:
>  	if (next_deferred >= scanned)
>  		next_deferred -= scanned;
>  	else
> -- 
> 2.22.0
> 
