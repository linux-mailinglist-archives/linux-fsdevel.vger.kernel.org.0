Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A142DA6BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 04:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgLODY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 22:24:29 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35006 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbgLODYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:24:21 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 124D358E5DC;
        Tue, 15 Dec 2020 14:23:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kp0w5-0045Fn-G0; Tue, 15 Dec 2020 14:23:37 +1100
Date:   Tue, 15 Dec 2020 14:23:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        hannes@cmpxchg.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 9/9] mm: vmscan: shrink deferred objects proportional
 to priority
Message-ID: <20201215032337.GP3913616@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-10-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223722.232537-10-shy828301@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=UbRxMYmvtlocDQyDN3oA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:37:22PM -0800, Yang Shi wrote:
> The number of deferred objects might get windup to an absurd number, and it results in
> clamp of slab objects.  It is undesirable for sustaining workingset.
> 
> So shrink deferred objects proportional to priority and cap nr_deferred to twice of
> cache items.

This completely changes the work accrual algorithm without any
explaination of how it works, what the theory behind the algorithm
is, what the work accrual ramp up and damp down curve looks like,
what workloads it is designed to benefit, how it affects page
cache vs slab cache balance and system performance, what OOM stress
testing has been done to ensure pure slab cache pressure workloads
don't easily trigger OOM kills, etc.

You're going to need a lot more supporting evidence that this is a
well thought out algorithm that doesn't obviously introduce
regressions. The current code might fall down in one corner case,
but there are an awful lot of corner cases where it does work.
Please provide some evidence that it not only works in your corner
case, but also doesn't introduce regressions for other slab cache
intensive and mixed cache intensive worklaods...

> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 40 +++++-----------------------------------
>  1 file changed, 5 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 693a41e89969..58f4a383f0df 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -525,7 +525,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 */
>  	nr = count_nr_deferred(shrinker, shrinkctl);
>  
> -	total_scan = nr;
>  	if (shrinker->seeks) {
>  		delta = freeable >> priority;
>  		delta *= 4;
> @@ -539,37 +538,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		delta = freeable / 2;
>  	}
>  
> +	total_scan = nr >> priority;

When there is low memory pressure, this will throw away a large
amount of the work that is deferred. If we are not defering in
amounts larger than ~4000 items, every pass through this code will
zero the deferred work.

Hence when we do get substantial pressure, that deferred work is no
longer being tracked. While it may help your specific corner case,
it's likely to significantly change the reclaim balance of slab
caches, especially under GFP_NOFS intensive workloads where we can
only defer the work to kswapd.

Hence I think this is still a problematic approach as it doesn't
address the reason why deferred counts are increasing out of
control in the first place....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
