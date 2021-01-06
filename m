Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9182EBD10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 12:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbhAFLQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 06:16:44 -0500
Received: from relay.sw.ru ([185.231.240.75]:49728 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbhAFLQo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:16:44 -0500
Received: from [192.168.15.143]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kx6mG-00Fd6I-Ge; Wed, 06 Jan 2021 14:14:56 +0300
Subject: Re: [v3 PATCH 09/11] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-10-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7c591313-08fd-4f98-6021-6dfa59f01aff@virtuozzo.com>
Date:   Wed, 6 Jan 2021 14:15:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105225817.1036378-10-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.01.2021 01:58, Yang Shi wrote:
> Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> allocate shrinker->nr_deferred for such shrinkers anymore.
> 
> The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
> by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
> This makes the implementation of this patch simpler.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f20ed8e928c2..d9795fb0f1c5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -340,6 +340,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	int id, ret = -ENOMEM;
>  
> +	if (mem_cgroup_disabled())
> +		return -ENOSYS;
> +
>  	down_write(&shrinker_rwsem);
>  	/* This may call shrinker, so it must use down_read_trylock() */
>  	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> @@ -424,7 +427,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  #else
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static void unregister_memcg_shrinker(struct shrinker *shrinker)
> @@ -535,8 +538,20 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
>   */
>  int prealloc_shrinker(struct shrinker *shrinker)
>  {
> -	unsigned int size = sizeof(*shrinker->nr_deferred);
> +	unsigned int size;
> +	int err;
> +
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> +		err = prealloc_memcg_shrinker(shrinker);
> +		if (!err)
> +			return 0;
> +		if (err != -ENOSYS)
> +			return err;
> +
> +		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;

This looks very confusing.

In case of you want to disable preallocation branch for !MEMCG case,
you should firstly consider something like the below:

#ifdef CONFIG_MEMCG
#define SHRINKER_MEMCG_AWARE    (1 << 2)
#else
#define SHRINKER_MEMCG_AWARE    0
#endif

> +	}
>  
> +	size = sizeof(*shrinker->nr_deferred);
>  	if (shrinker->flags & SHRINKER_NUMA_AWARE)
>  		size *= nr_node_ids;
>  
> @@ -544,26 +559,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return -ENOMEM;
>  
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> -		if (prealloc_memcg_shrinker(shrinker))
> -			goto free_deferred;
> -	}
>  
>  	return 0;
> -
> -free_deferred:
> -	kfree(shrinker->nr_deferred);
> -	shrinker->nr_deferred = NULL;
> -	return -ENOMEM;
>  }
>  
>  void free_prealloced_shrinker(struct shrinker *shrinker)
>  {
> -	if (!shrinker->nr_deferred)
> -		return;
> -
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		unregister_memcg_shrinker(shrinker);
> +		return unregister_memcg_shrinker(shrinker);
>  
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
> 

