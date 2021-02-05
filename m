Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD27310E20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhBEPIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 10:08:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:46752 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233104AbhBEPFY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:05:24 -0500
Received: from [192.168.15.95]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l82L1-001mbB-TC; Fri, 05 Feb 2021 17:43:59 +0300
Subject: Re: [v6 PATCH 09/11] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-10-shy828301@gmail.com>
 <656865f5-bb56-4f4c-b88d-ec933a042b4c@virtuozzo.com>
 <5e335e4a-1556-e694-8f0b-192d924f99e5@virtuozzo.com>
 <CAHbLzkpy+bg+7HMb5qG_1gocXhkuuxip0Wn9Afu3Tx6-FMoMig@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b2509337-cbdf-5981-74ab-2b75361c6d2b@virtuozzo.com>
Date:   Fri, 5 Feb 2021 17:44:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpy+bg+7HMb5qG_1gocXhkuuxip0Wn9Afu3Tx6-FMoMig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.02.2021 20:32, Yang Shi wrote:
> On Thu, Feb 4, 2021 at 2:14 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 04.02.2021 12:29, Kirill Tkhai wrote:
>>> On 03.02.2021 20:20, Yang Shi wrote:
>>>> Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
>>>> allocate shrinker->nr_deferred for such shrinkers anymore.
>>>>
>>>> The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
>>>> by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
>>>> This makes the implementation of this patch simpler.
>>>>
>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>>> ---
>>>>  mm/vmscan.c | 31 ++++++++++++++++---------------
>>>>  1 file changed, 16 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 545422d2aeec..20a35d26ae12 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -334,6 +334,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>>>  {
>>>>      int id, ret = -ENOMEM;
>>>>
>>>> +    if (mem_cgroup_disabled())
>>>> +            return -ENOSYS;
>>>> +
>>>>      down_write(&shrinker_rwsem);
>>>>      /* This may call shrinker, so it must use down_read_trylock() */
>>>>      id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>>>> @@ -414,7 +417,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>>>>  #else
>>>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>>>  {
>>>> -    return 0;
>>>> +    return -ENOSYS;
>>>>  }
>>>>
>>>>  static void unregister_memcg_shrinker(struct shrinker *shrinker)
>>>> @@ -525,8 +528,18 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
>>>>   */
>>>>  int prealloc_shrinker(struct shrinker *shrinker)
>>>>  {
>>>> -    unsigned int size = sizeof(*shrinker->nr_deferred);
>>>> +    unsigned int size;
>>>> +    int err;
>>>> +
>>>> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>>>> +            err = prealloc_memcg_shrinker(shrinker);
>>>> +            if (err != -ENOSYS)
>>>> +                    return err;
>>>>
>>>> +            shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
>>>> +    }
>>>> +
>>>> +    size = sizeof(*shrinker->nr_deferred);
>>>>      if (shrinker->flags & SHRINKER_NUMA_AWARE)
>>>>              size *= nr_node_ids;
>>>
>>> This may sound surprisingly, but IIRC do_shrink_slab() may be called on early boot
>>> *even before* root_mem_cgroup is allocated. AFAIR, I received syzcaller crash report
>>> because of this, when I was implementing shrinker_maps.
>>>
>>> This is a reason why we don't use shrinker_maps even in case of mem cgroup is not
>>> disabled: we iterate every shrinker of shrinker_list. See check in shrink_slab():
>>>
>>>       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>
>>> Possible, we should do the same for nr_deferred: 1)always allocate shrinker->nr_deferred,
>>> 2)use shrinker->nr_deferred in count_nr_deferred() and set_nr_deferred().
>>
>> I looked over my mail box, and I can't find that crash report and conditions to reproduce.
>>
>> Hm, let's remain this as is, and we rework this in case of such early shrinker call is still
>> possible, and there will be a report...
> 
> Sure. But I'm wondering how that could happen. On a very small machine?

Sorry, but I don't remember. Maybe this case you said. Maybe some self-tests on node boot..

>>
>> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
>> With only nit:
>>
>>>>
>>>> @@ -534,26 +547,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
>>>>      if (!shrinker->nr_deferred)
>>>>              return -ENOMEM;
>>>>
>>>> -    if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>>>> -            if (prealloc_memcg_shrinker(shrinker))
>>>> -                    goto free_deferred;
>>>> -    }
>>>>
>>>>      return 0;
>>>> -
>>>> -free_deferred:
>>>> -    kfree(shrinker->nr_deferred);
>>>> -    shrinker->nr_deferred = NULL;
>>>> -    return -ENOMEM;
>>>>  }
>>>>
>>>>  void free_prealloced_shrinker(struct shrinker *shrinker)
>>>>  {
>>>> -    if (!shrinker->nr_deferred)
>>>> -            return;
>>>> -
>>>>      if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>> -            unregister_memcg_shrinker(shrinker);
>>>> +            return unregister_memcg_shrinker(shrinker);
>>
>> I've never seen return of void function in linux kernel. I'm not sure this won't confuse people.
> 
> Will fix in v7.
> 
>>
>>>>
>>>>      kfree(shrinker->nr_deferred);
>>>>      shrinker->nr_deferred = NULL;
>>>>
>>>
>>
>>

