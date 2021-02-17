Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A794831D56C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 07:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBQGkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 01:40:21 -0500
Received: from relay.sw.ru ([185.231.240.75]:48710 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhBQGkS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=msbrzWSRT5T++kWmjXz/e9gdzpOs5BdgrXcVbJWD5Xc=; b=tsBHnKGrU+6H/vsSb
        TAb/c7pIa3s4LaCLiLYIyaITybbHYyf2/5Xu4EgAT93JTIfEAxqjxrul1cIQHZKirvgePPe3ZEAyb
        gOyb/hyUUiBNjOixs/bDwyIvtJilLiKi3xHQOaS1NQYEGM7Ek59kfb9Hggkl8+cEtCMLG1AkJP6vc
        =;
Received: from [192.168.15.68]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1lCGUM-002GTE-8V; Wed, 17 Feb 2021 09:39:06 +0300
Subject: Re: [v8 PATCH 10/13] mm: vmscan: use per memcg nr_deferred of
 shrinker
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-11-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <acd90ddf-b9b3-cbb1-7037-2fec3af49924@virtuozzo.com>
Date:   Wed, 17 Feb 2021 09:39:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217001322.2226796-11-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.02.2021 03:13, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/vmscan.c | 78 ++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 66 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fcb399e18fc3..57cbc6bc8a49 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -374,6 +374,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  	idr_remove(&shrinker_idr, id);
>  }
>  
> +static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> +				   struct mem_cgroup *memcg)
> +{
> +	struct shrinker_info *info;
> +
> +	info = shrinker_info_protected(memcg, nid);
> +	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> +}
> +
> +static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> +				  struct mem_cgroup *memcg)
> +{
> +	struct shrinker_info *info;
> +
> +	info = shrinker_info_protected(memcg, nid);
> +	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return sc->target_mem_cgroup;
> @@ -412,6 +430,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  {
>  }
>  
> +static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> +				   struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
> +static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> +				  struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return false;
> @@ -423,6 +453,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  }
>  #endif
>  
> +static long xchg_nr_deferred(struct shrinker *shrinker,
> +			     struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (sc->memcg &&
> +	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		return xchg_nr_deferred_memcg(nid, shrinker,
> +					      sc->memcg);
> +
> +	return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +}
> +
> +
> +static long add_nr_deferred(long nr, struct shrinker *shrinker,
> +			    struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (sc->memcg &&
> +	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		return add_nr_deferred_memcg(nr, nid, shrinker,
> +					     sc->memcg);
> +
> +	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> +}
> +
>  /*
>   * This misses isolated pages which are not accounted for to save counters.
>   * As the data only determines if reclaim or compaction continues, it is
> @@ -558,14 +621,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	long freeable;
>  	long nr;
>  	long new_nr;
> -	int nid = shrinkctl->nid;
>  	long batch_size = shrinker->batch ? shrinker->batch
>  					  : SHRINK_BATCH;
>  	long scanned = 0, next_deferred;
>  
> -	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> -		nid = 0;
> -
>  	freeable = shrinker->count_objects(shrinker, shrinkctl);
>  	if (freeable == 0 || freeable == SHRINK_EMPTY)
>  		return freeable;
> @@ -575,7 +634,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * and zero it so that other concurrent shrinker invocations
>  	 * don't also do this scanning work.
>  	 */
> -	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +	nr = xchg_nr_deferred(shrinker, shrinkctl);
>  
>  	total_scan = nr;
>  	if (shrinker->seeks) {
> @@ -666,14 +725,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		next_deferred = 0;
>  	/*
>  	 * move the unused scan count back into the shrinker in a
> -	 * manner that handles concurrent updates. If we exhausted the
> -	 * scan, there is no need to do an update.
> +	 * manner that handles concurrent updates.
>  	 */
> -	if (next_deferred > 0)
> -		new_nr = atomic_long_add_return(next_deferred,
> -						&shrinker->nr_deferred[nid]);
> -	else
> -		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
> +	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
>  
>  	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
>  	return freed;
> 

