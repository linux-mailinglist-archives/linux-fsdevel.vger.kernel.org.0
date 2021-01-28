Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704B3307A57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhA1QKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 11:10:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:45400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhA1QKr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:10:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7132AF10;
        Thu, 28 Jan 2021 16:10:05 +0000 (UTC)
Subject: Re: [v5 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling
 code
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210127233345.339910-1-shy828301@gmail.com>
 <20210127233345.339910-3-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4b0a6d22-e29b-fb85-b05f-b9f9f62ca8ea@suse.cz>
Date:   Thu, 28 Jan 2021 17:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127233345.339910-3-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 12:33 AM, Yang Shi wrote:
> The shrinker map management is not purely memcg specific, it is at the intersection
> between memory cgroup and shrinkers.  It's allocation and assignment of a structure,
> and the only memcg bit is the map is being stored in a memcg structure.  So move the
> shrinker_maps handling code into vmscan.c for tighter integration with shrinker code,
> and remove the "memcg_" prefix.  There is no functional change.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nits below:

> @@ -1581,10 +1581,10 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> -extern int memcg_expand_shrinker_maps(int new_id);
> -
> -extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> -				   int nid, int shrinker_id);
> +extern int alloc_shrinker_maps(struct mem_cgroup *memcg);
> +extern void free_shrinker_maps(struct mem_cgroup *memcg);
> +extern void set_shrinker_bit(struct mem_cgroup *memcg,
> +			     int nid, int shrinker_id);

"extern" is unnecessary and people seem to be removing them nowadays when
touching the code

>  /*
>   * We allow subsystems to populate their shrinker-related
>   * LRU lists before register_shrinker_prepared() is called
> @@ -212,7 +338,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  		goto unlock;
>  
>  	if (id >= shrinker_nr_max) {
> -		if (memcg_expand_shrinker_maps(id)) {
> +		if (expand_shrinker_maps(id)) {
>  			idr_remove(&shrinker_idr, id);
>  			goto unlock;
>  		}
> @@ -601,7 +727,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,

Above this is a comment about barriers in memcg_set_shrinker_bit() that should
be updated.

>  			if (ret == SHRINK_EMPTY)
>  				ret = 0;
>  			else
> -				memcg_set_shrinker_bit(memcg, nid, i);
> +				set_shrinker_bit(memcg, nid, i);
>  		}
>  		freed += ret;
>  
> 

