Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED12D307A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 17:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA1QDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 11:03:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:39250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhA1QDO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:03:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 050F6AC41;
        Thu, 28 Jan 2021 16:02:33 +0000 (UTC)
Subject: Re: [v5 PATCH 01/11] mm: vmscan: use nid from shrink_control for
 tracepoint
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210127233345.339910-1-shy828301@gmail.com>
 <20210127233345.339910-2-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <621d771e-5d28-9f5f-662b-9f4d81c0ef04@suse.cz>
Date:   Thu, 28 Jan 2021 17:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127233345.339910-2-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 12:33 AM, Yang Shi wrote:
> The tracepoint's nid should show what node the shrink happens on, the start tracepoint
> uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
> shrinker is not NUMA aware, so the traceing log may show the shrink happens on one
> node but end up on the other node.  It seems confusing.  And the following patch
> will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
> the code.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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

