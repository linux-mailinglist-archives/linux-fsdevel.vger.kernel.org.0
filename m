Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB87C2CCD20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 04:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgLCDNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 22:13:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8924 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgLCDNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:13:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmgrD24JGz77Sk;
        Thu,  3 Dec 2020 11:12:44 +0800 (CST)
Received: from [10.143.60.252] (10.143.60.252) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 11:13:03 +0800
Subject: Re: [PATCH 2/9] mm: vmscan: use nid from shrink_control for
 tracepoint
To:     Yang Shi <shy828301@gmail.com>, <guro@fb.com>,
        <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liu Yi <daniel.liuyi@hisilicon.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-3-shy828301@gmail.com>
From:   "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Message-ID: <550518d6-fd50-72be-7c84-71153b470cfd@hisilicon.com>
Date:   Thu, 3 Dec 2020 11:13:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20201202182725.265020-3-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.143.60.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/12/3 2:27, Yang Shi wrote:
> The tracepoint's nid should show what node the shrink happens on, the start tracepoint
> uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
> shrinker is not NUMA aware, so the traceing log may show the shrink happens on one
> node but end up on the other node.  It seems confusing.  And the following patch
> will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
> the code.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>   mm/vmscan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7d6186a07daf..457ce04eebf2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -533,7 +533,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>   	new_nr = atomic_long_add_return(next_deferred,
>   					&shrinker->nr_deferred[nid]);
>   
> -	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
> +	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);

Hi， Yang

When I read this patch, I wondered why you modified it so much until I read patch6. Could you merge
this patch into patch6?

Thanks!

>   	return freed;
>   }
>   

