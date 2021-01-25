Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427D13023D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 11:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbhAYKsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 05:48:13 -0500
Received: from relay.sw.ru ([185.231.240.75]:49414 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbhAYKrk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:47:40 -0500
Received: from [192.168.15.14]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l3yGy-000TKx-0R; Mon, 25 Jan 2021 12:35:00 +0300
Subject: Re: [v4 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of
 shrinker
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210121230621.654304-1-shy828301@gmail.com>
 <20210121230621.654304-9-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <bbfaaf59-ad56-81ef-347b-92003b8cbebe@virtuozzo.com>
Date:   Mon, 25 Jan 2021 12:35:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121230621.654304-9-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.01.2021 02:06, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 81 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 722aa71b13b2..d8e77ea13815 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -359,6 +359,27 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  	up_write(&shrinker_rwsem);
>  }
>  
> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> +				    struct mem_cgroup *memcg)
> +{
> +	struct shrinker_info *info;
> +
> +	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> +					 true);

Since now these rcu_dereference_protected() are in separate functions and there is
no taking a lock near them, it seems it would be better to underling the desired
lock with rcu_dereference_protected(, lockdep_assert_held(lock_you_need_here_locked));


> +	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> +}
> +
> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> +				  struct mem_cgroup *memcg)
> +{
> +	struct shrinker_info *info;
> +
> +	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> +					 true);
> +
> +	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return sc->target_mem_cgroup;
> @@ -397,6 +418,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  {
>  }
>  
> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> +				    struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> +				  struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return false;
> @@ -408,6 +441,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  }
>  #endif
>  
> +static long count_nr_deferred(struct shrinker *shrinker,
> +			      struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (sc->memcg &&
> +	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		return count_nr_deferred_memcg(nid, shrinker,
> +					       sc->memcg);
> +
> +	return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +}
> +
> +
> +static long set_nr_deferred(long nr, struct shrinker *shrinker,
> +			    struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (sc->memcg &&
> +	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		return set_nr_deferred_memcg(nr, nid, shrinker,
> +					     sc->memcg);
> +
> +	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> +}
> +
>  /*
>   * This misses isolated pages which are not accounted for to save counters.
>   * As the data only determines if reclaim or compaction continues, it is
> @@ -544,14 +610,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
> @@ -561,7 +623,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * and zero it so that other concurrent shrinker invocations
>  	 * don't also do this scanning work.
>  	 */
> -	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +	nr = count_nr_deferred(shrinker, shrinkctl);
>  
>  	total_scan = nr;
>  	if (shrinker->seeks) {
> @@ -652,14 +714,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
> +	new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
>  
>  	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
>  	return freed;
> 

