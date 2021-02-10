Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C20316665
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 13:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBJMPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 07:15:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:56482 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhBJMNi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GAOsibDhKJ04+xMmEsdPpg7oFYUkfCHjNiy9fpcutpg=; b=wKkkF4iMbqvGVMzMq11k823xrW
        UgQUXkdf+qTU7A3j4VsVhEg9a8/s5d7Ydo+IgEMhU69ecEtaNz7JLebZaRhPCOYb2ysiF74VulqcC
        16gA3FWJFaztuo9uYYa4+R/3k0d74rgLQkwj8AzVak53jrJ9Vkvr9ckz/t9B5ez1rVCo=;
Received: from [192.168.15.133]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l9oMA-002822-3z; Wed, 10 Feb 2021 15:12:30 +0300
Subject: Re: [v7 PATCH 06/12] mm: vmscan: add shrinker_info_protected() helper
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-7-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <73458559-f8b9-3f3a-6ffc-8fcc8a7dc519@virtuozzo.com>
Date:   Wed, 10 Feb 2021 15:12:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209174646.1310591-7-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.02.2021 20:46, Yang Shi wrote:
> The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
> with different calling conventions, for example, using mem_cgroup_nodeinfo helper
> or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
> will add more dereference places.
> 
> So extract the dereference into a helper to make the code more readable.  No
> functional change.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/vmscan.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9436f9246d32..273efbf4d53c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -190,6 +190,13 @@ static int shrinker_nr_max;
>  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
>  	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
>  
> +static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> +						     int nid)
> +{
> +	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> +					 lockdep_is_held(&shrinker_rwsem));
> +}
> +
>  static void free_shrinker_info_rcu(struct rcu_head *head)
>  {
>  	kvfree(container_of(head, struct shrinker_info, rcu));
> @@ -202,8 +209,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  	int nid;
>  
>  	for_each_node(nid) {
> -		old = rcu_dereference_protected(
> -			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
> +		old = shrinker_info_protected(memcg, nid);
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
> @@ -234,7 +240,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>  
>  	for_each_node(nid) {
>  		pn = mem_cgroup_nodeinfo(memcg, nid);
> -		info = rcu_dereference_protected(pn->shrinker_info, true);
> +		info = shrinker_info_protected(memcg, nid);
>  		kvfree(info);
>  		rcu_assign_pointer(pn->shrinker_info, NULL);
>  	}
> @@ -674,8 +680,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  	if (!down_read_trylock(&shrinker_rwsem))
>  		return 0;
>  
> -	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> -					 true);
> +	info = shrinker_info_protected(memcg, nid);
>  	if (unlikely(!info))
>  		goto unlock;
>  
> 

