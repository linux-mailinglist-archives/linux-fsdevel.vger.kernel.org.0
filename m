Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189253049AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbhAZFYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:24:37 -0500
Received: from relay.sw.ru ([185.231.240.75]:40670 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbhAYMnb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:43:31 -0500
Received: from [192.168.15.14]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l3xLj-000T1I-8x; Mon, 25 Jan 2021 11:35:51 +0300
Subject: Re: [v4 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210121230621.654304-1-shy828301@gmail.com>
 <20210121230621.654304-5-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <af9204cb-2298-ee7c-5307-295d33befd8a@virtuozzo.com>
Date:   Mon, 25 Jan 2021 11:35:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121230621.654304-5-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.01.2021 02:06, Yang Shi wrote:
> Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> bit map.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d3f3701dfcd2..40e7751ef961 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -185,8 +185,7 @@ static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
>  #ifdef CONFIG_MEMCG
> -
> -static int memcg_shrinker_map_size;
> +static int shrinker_nr_max;
>  
>  static void free_shrinker_map_rcu(struct rcu_head *head)
>  {
> @@ -248,7 +247,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  		return 0;
>  
>  	down_write(&shrinker_rwsem);
> -	size = memcg_shrinker_map_size;
> +	size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
>  	for_each_node(nid) {
>  		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
>  		if (!map) {
> @@ -266,10 +265,11 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  static int expand_shrinker_maps(int new_id)
>  {
>  	int size, old_size, ret = 0;
> +	int new_nr_max = new_id + 1;
>  	struct mem_cgroup *memcg;
>  
> -	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> -	old_size = memcg_shrinker_map_size;
> +	size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> +	old_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
>
>  	if (size <= old_size)
>  		return 0;

This looks a BUG:

expand_shrinker_maps(id == 1)
{
	old_size = 64;
	size = 64;
	
	===>return 0 and shrinker_nr_max remains 0.
}

Then shrink_slab_memcg() misses this shrinker since shrinker_nr_max == 0.

>  
> @@ -286,9 +286,10 @@ static int expand_shrinker_maps(int new_id)
>  			goto out;
>  		}
>  	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> +
>  out:
>  	if (!ret)
> -		memcg_shrinker_map_size = size;
> +		shrinker_nr_max = new_nr_max;
>  
>  	return ret;
>  }
> @@ -321,7 +322,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
>  
>  static DEFINE_IDR(shrinker_idr);
> -static int shrinker_nr_max;
>  
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
> @@ -338,8 +338,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  			idr_remove(&shrinker_idr, id);
>  			goto unlock;
>  		}
> -
> -		shrinker_nr_max = id + 1;
>  	}
>  	shrinker->id = id;
>  	ret = 0;
> 

