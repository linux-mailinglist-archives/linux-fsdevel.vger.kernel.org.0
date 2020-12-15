Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83E2DA668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 03:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgLOCrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 21:47:32 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:38667 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgLOCrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:47:23 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 5BD047655DC;
        Tue, 15 Dec 2020 13:46:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kp0MH-0044jx-Mh; Tue, 15 Dec 2020 13:46:37 +1100
Date:   Tue, 15 Dec 2020 13:46:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        hannes@cmpxchg.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
Message-ID: <20201215024637.GM3913616@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-7-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223722.232537-7-shy828301@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=egEBjK1CG8dSuLosGesA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:37:19PM -0800, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Lots of lines way over 80 columns.

> ---
>  mm/vmscan.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 83 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bf34167dd67e..bce8cf44eca2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -203,6 +203,12 @@ DECLARE_RWSEM(shrinker_rwsem);
>  static DEFINE_IDR(shrinker_idr);
>  static int shrinker_nr_max;
>  
> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> +{
> +	return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> +		!mem_cgroup_disabled();
> +}

Why do we care if mem_cgroup_disabled() is disabled here? The return
of this function is then && sc->memcg, so if memcgs are disabled,
sc->memcg will never be set and this mem_cgroup_disabled() check is
completely redundant, right?

> +
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	int id, ret = -ENOMEM;
> @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  #endif
>  	return false;
>  }
> +
> +static inline long count_nr_deferred(struct shrinker *shrinker,
> +				     struct shrink_control *sc)
> +{
> +	bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> +	struct memcg_shrinker_deferred *deferred;
> +	struct mem_cgroup *memcg = sc->memcg;
> +	int nid = sc->nid;
> +	int id = shrinker->id;
> +	long nr;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (per_memcg_deferred) {
> +		deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> +						     true);
> +		nr = atomic_long_xchg(&deferred->nr_deferred[id], 0);
> +	} else
> +		nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +
> +	return nr;
> +}
> +
> +static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
> +				   struct shrink_control *sc)
> +{
> +	bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> +	struct memcg_shrinker_deferred *deferred;
> +	struct mem_cgroup *memcg = sc->memcg;
> +	int nid = sc->nid;
> +	int id = shrinker->id;

Oh, that's a nasty trap. Nobody knows if you mean "id" or "nid" in
any of the code and a single letter type results in a bug.

> +	long new_nr;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (per_memcg_deferred) {
> +		deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> +						     true);
> +		new_nr = atomic_long_add_return(nr, &deferred->nr_deferred[id]);
> +	} else
> +		new_nr = atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> +
> +	return new_nr;
> +}
>  #else
> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> +{
> +	return false;
> +}
> +
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	return 0;
> @@ -290,6 +347,29 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  {
>  	return true;
>  }
> +
> +static inline long count_nr_deferred(struct shrinker *shrinker,
> +				     struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +}
> +
> +static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
> +				   struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	return atomic_long_add_return(nr,
> +				      &shrinker->nr_deferred[nid]);
> +}
>  #endif

This is pretty ... verbose. It doesn't need to be this complex at
all, and you shouldn't be duplicating code in multiple places. THere
is also no need for any of these to be "inline" functions. The
compiler will do that for static functions automatically if it makes
sense.

Ok, so you only do the memcg nr_deferred thing if NUMA_AWARE &&
sc->memcg is true. so....

static long shrink_slab_set_nr_deferred_memcg(...)
{
	int nid = sc->nid;

	deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
					     true);
	return atomic_long_add_return(nr, &deferred->nr_deferred[id]);
}

static long shrink_slab_set_nr_deferred(...)
{
	int nid = sc->nid;

	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
		nid = 0;
	else if (sc->memcg)
		return shrink_slab_set_nr_deferred_memcg(...., nid);

	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
}

And now there's no duplicated code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
