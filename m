Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8930356C90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352402AbhDGMtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 08:49:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:57556 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352394AbhDGMtr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=eowKYMJJlOx02BM1yZgvM+Udc16+p9Iw201g2IU9Z6I=; b=kcnSys90lhoVgTg5F
        oZBA3IRHy1eVLBOgupUS33+GdAo6R6/UT/dVolKE0qO7AgN56lmlnkYty19XVeqYANTfVXyMpOz6x
        42M3wxSmu5Xm61IJzH7SVrSDugyUKiiOtUAD7w1I9UBCuwdVBtOalE6lQLi9aXD4sgLTl4ICnYPcI
        =;
Received: from [192.168.15.55]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1lU7ca-000P3X-2u; Wed, 07 Apr 2021 15:49:24 +0300
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
To:     bharata@linux.ibm.com
Cc:     Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
 <20210407050541.GC1354243@in.ibm.com>
 <c9bd1744-f15c-669a-b3a9-5a0c47bd4e1d@virtuozzo.com>
 <20210407114723.GD1354243@in.ibm.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <82e806cb-9e3f-c61c-3cbf-484f0661c4f2@virtuozzo.com>
Date:   Wed, 7 Apr 2021 15:49:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407114723.GD1354243@in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.04.2021 14:47, Bharata B Rao wrote:
> On Wed, Apr 07, 2021 at 01:07:27PM +0300, Kirill Tkhai wrote:
>>> Here is how the calculation turns out to be in my setup:
>>>
>>> Number of possible NUMA nodes = 2
>>> Number of mounts per container = 7 (Check below to see which are these)
>>> Number of list creation requests per mount = 2
>>> Number of containers = 10000
>>> memcg_nr_cache_ids for 10k containers = 12286
>>
>> Luckily, we have "+1" in memcg_nr_cache_ids formula: size = 2 * (id + 1).
>> In case of we only multiplied it, you would have to had memcg_nr_cache_ids=20000.
> 
> Not really, it would grow like this for size = 2 * id
> 
> id 0 size 4
> id 4 size 8
> id 8 size 16
> id 16 size 32
> id 32 size 64
> id 64 size 128
> id 128 size 256
> id 256 size 512
> id 512 size 1024
> id 1024 size 2048
> id 2048 size 4096
> id 4096 size 8192
> id 8192 size 16384
> 
> Currently (size = 2 * (id + 1)), it grows like this:
> 
> id 0 size 4
> id 4 size 10
> id 10 size 22
> id 22 size 46
> id 46 size 94
> id 94 size 190
> id 190 size 382
> id 382 size 766
> id 766 size 1534
> id 1534 size 3070
> id 3070 size 6142
> id 6142 size 12286

Oh, thanks, I forgot what power of two is :)
 
>>
>> Maybe, we need change that formula to increase memcg_nr_cache_ids more accurate
>> for further growths of containers number. Say,
>>
>> size = id < 2000 ? 2 * (id + 1) : id + 2000
> 
> For the above, it would only be marginally better like this:
> 
> id 0 size 4
> id 4 size 10
> id 10 size 22
> id 22 size 46
> id 46 size 94
> id 94 size 190
> id 190 size 382
> id 382 size 766
> id 766 size 1534
> id 1534 size 3070
> id 3070 size 5070
> id 5070 size 7070
> id 7070 size 9070
> id 9070 size 11070
> 
> All the above numbers are for 10k memcgs.

I mean the number of containers bigger then your 10000.
