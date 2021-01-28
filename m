Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC2307B6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 17:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhA1QyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 11:54:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:50228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232716AbhA1Qxq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:53:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10056AD3E;
        Thu, 28 Jan 2021 16:53:05 +0000 (UTC)
Subject: Re: [v5 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210127233345.339910-1-shy828301@gmail.com>
 <20210127233345.339910-5-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <255b9236-3e0b-f6f6-4a72-5e69351a979a@suse.cz>
Date:   Thu, 28 Jan 2021 17:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127233345.339910-5-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 12:33 AM, Yang Shi wrote:
> Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> bit map.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d3f3701dfcd2..847369c19775 100644
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
> @@ -266,12 +265,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
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

What's wrong with using DIV_ROUND_UP() here?

>  	if (size <= old_size)
> -		return 0;
> +		goto out;

Can this even happen? Seems to me it can't, so just remove this?

>  
>  	if (!root_mem_cgroup)
>  		goto out;
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

