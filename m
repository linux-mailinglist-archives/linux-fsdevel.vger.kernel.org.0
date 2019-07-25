Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7189D75BA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 01:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGYXvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 19:51:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGYXvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnWpmDquviv2T4rhOaKwfYrYkAK4O04dPwOKTktYaOs=; b=thhM7y8KKCymntW36Aear/ueL
        3yz70nHaio9xlpXUE8ytrM21+KRWlKYUO2me8Mk/zwg4dNq8qcIbXPODdZ3avIukc6wI4Du1LVxJo
        8d1pMsg8sILIf8rByVRmAQ97UlVSAGve0hNP8Dta041us0ooVAroMXcDN5q2rfpeqs8Cagem+5I4q
        y3hKbtksNNtRMWUff6W/Ox/dcr02eeOTKMs0+Ppw+OF5ZS/b0lmJgEWJ4IJSBnI5xhrF1wuSURU26
        3xH6xb2WP2EIEfqSnTrwl6B7YDyLh/Av21TfBdp1uc+nk3LC460dz8qRyPdxcv9fhXcA2E7WtL7xm
        XkQJkJjEA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqnW0-0005yk-GJ; Thu, 25 Jul 2019 23:51:16 +0000
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Chris Down <chris@chrisdown.name>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
 <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
 <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <704b25d9-08bd-8418-f6b3-d8ba4c4cecfa@infradead.org>
Date:   Thu, 25 Jul 2019 16:51:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/25/19 4:39 PM, Andrew Morton wrote:
> On Thu, 25 Jul 2019 15:02:59 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 7/24/19 9:40 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2019-07-24-21-39 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>
>> on i386:
>>
>> ld: mm/memcontrol.o: in function `mem_cgroup_handle_over_high':
>> memcontrol.c:(.text+0x6235): undefined reference to `__udivdi3'
> 
> Thanks.  This?


Yes, that works.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> --- a/mm/memcontrol.c~mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix
> +++ a/mm/memcontrol.c
> @@ -2414,8 +2414,9 @@ void mem_cgroup_handle_over_high(void)
>  	 */
>  	clamped_high = max(high, 1UL);
>  
> -	overage = ((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT)
> -		/ clamped_high;
> +	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
> +	do_div(overage, clamped_high);
> +
>  	penalty_jiffies = ((u64)overage * overage * HZ)
>  		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
>  
> _
> 


-- 
~Randy
