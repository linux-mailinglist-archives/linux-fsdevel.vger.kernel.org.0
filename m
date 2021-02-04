Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF330EDF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 09:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhBDICg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 03:02:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:38356 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhBDICe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:02:34 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7ZZc-001ed6-Bv; Thu, 04 Feb 2021 11:01:08 +0300
Subject: Re: [v6 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-5-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <270f3407-03d6-7a20-2c88-80a09807754c@virtuozzo.com>
Date:   Thu, 4 Feb 2021 11:01:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-5-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
> Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> bit map.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/vmscan.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e4ddaaaeffe2..641077b09e5d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -185,8 +185,10 @@ static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
>  #ifdef CONFIG_MEMCG
> +static int shrinker_nr_max;
>  
> -static int memcg_shrinker_map_size;
> +#define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> +	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
>  
>  static void free_shrinker_map_rcu(struct rcu_head *head)
>  {
> @@ -247,7 +249,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  		return 0;
>  
>  	down_write(&shrinker_rwsem);
> -	size = memcg_shrinker_map_size;
> +	size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
>  	for_each_node(nid) {
>  		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
>  		if (!map) {
> @@ -265,12 +267,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  static int expand_shrinker_maps(int new_id)
>  {
>  	int size, old_size, ret = 0;
> +	int new_nr_max = new_id + 1;
>  	struct mem_cgroup *memcg;
>  
> -	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> -	old_size = memcg_shrinker_map_size;
> +	size = NR_MAX_TO_SHR_MAP_SIZE(new_nr_max);
> +	old_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
>  	if (size <= old_size)
> -		return 0;
> +		goto out;
>  
>  	if (!root_mem_cgroup)
>  		goto out;
> @@ -287,7 +290,7 @@ static int expand_shrinker_maps(int new_id)
>  	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>  out:
>  	if (!ret)
> -		memcg_shrinker_map_size = size;
> +		shrinker_nr_max = new_nr_max;
>  
>  	return ret;
>  }
> @@ -320,7 +323,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
>  
>  static DEFINE_IDR(shrinker_idr);
> -static int shrinker_nr_max;
>  
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
> @@ -337,8 +339,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  			idr_remove(&shrinker_idr, id);
>  			goto unlock;
>  		}
> -
> -		shrinker_nr_max = id + 1;
>  	}
>  	shrinker->id = id;
>  	ret = 0;
> 

