Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC172CD4BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 12:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgLCLlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 06:41:18 -0500
Received: from relay.sw.ru ([185.231.240.75]:34248 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbgLCLlS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:41:18 -0500
Received: from [192.168.15.126]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kkmyH-00BZ31-6K; Thu, 03 Dec 2020 14:40:25 +0300
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-7-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com>
Date:   Thu, 3 Dec 2020 14:40:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202182725.265020-7-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.12.2020 21:27, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cba0bc8d4661..d569fdcaba79 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  static DEFINE_IDR(shrinker_idr);
>  static int shrinker_nr_max;
>  
> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> +{
> +	return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> +		!mem_cgroup_disabled();
> +}
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

My comment is about both 5/9 and 6/9 patches.

shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that you will see
memcg->nodeinfo[nid]->shrinker_deferred != NULL in count_nr_deferred(). This may occur
because of processor reordering on !x86 (there is no a common lock or memory barriers).

Regarding to shrinker_map this is not a problem due to map check in shrink_slab_memcg().
The map can't be NULL there.

Regarding to shrinker_deferred you should prove either this is not a problem too,
or to add proper synchronization (maybe, based on barriers) or to add some similar check
(maybe, in shrink_slab_memcg() too).

Kirill
