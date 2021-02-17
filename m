Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D831D55D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 07:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhBQG0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 01:26:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:44056 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhBQG0Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=cAfBU/411PKRhiWpGgo9nN8pw3+CfaYQSsKUktdXIvU=; b=tvxBm0KEWZeyZRAKc
        6dENRSaYqRAMmCwoRCUKyPfyVsc0liSO4EDgIUZxqq4aHMoEpa8+AKlAoEskXJii/yRYKmMT/Zt9e
        MuZ4hwZYXk1kANuZz9/bFiO5sFW7ED1Ms9ZYuvgsc+e/9wPkw/3JHKPY13DL29OINFKTOgQQwH6PQ
        =;
Received: from [192.168.15.68]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1lCGGq-002GSa-W1; Wed, 17 Feb 2021 09:25:09 +0300
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-6-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <187b874c-91a8-58de-547e-3651e27bf702@virtuozzo.com>
Date:   Wed, 17 Feb 2021 09:25:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217001322.2226796-6-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.02.2021 03:13, Yang Shi wrote:
> Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
> We don't have to define a dedicated callback for call_rcu() anymore.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/vmscan.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2e753c2516fa..c2a309acd86b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
>  	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
>  }
>  
> -static void free_shrinker_map_rcu(struct rcu_head *head)
> -{
> -	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> -}
> -
>  static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>  				   int size, int old_size)
>  {
> @@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		memset((void *)new->map + old_size, 0, size - old_size);
>  
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> -		call_rcu(&old->rcu, free_shrinker_map_rcu);
> +		kvfree_rcu(old);
>  	}
>  
>  	return 0;
> 

