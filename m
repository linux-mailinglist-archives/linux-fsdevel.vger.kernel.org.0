Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5856530ED40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 08:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhBDHXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 02:23:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:45202 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhBDHXp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:23:45 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7Yy0-001eFd-H1; Thu, 04 Feb 2021 10:22:16 +0300
Subject: Re: [v6 PATCH 01/11] mm: vmscan: use nid from shrink_control for
 tracepoint
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-2-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <779bb965-4e67-da37-1a17-64151eaeb93d@virtuozzo.com>
Date:   Thu, 4 Feb 2021 10:22:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-2-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
> The tracepoint's nid should show what node the shrink happens on, the start tracepoint
> uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
> shrinker is not NUMA aware, so the traceing log may show the shrink happens on one
> node but end up on the other node.  It seems confusing.  And the following patch
> will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
> the code.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b1b574ad199d..b512dd5e3a1c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -535,7 +535,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	else
>  		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
>  
> -	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
> +	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
>  	return freed;
>  }
>  
> 

