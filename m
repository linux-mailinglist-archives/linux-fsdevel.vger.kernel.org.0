Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2252D5F74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391611AbgLJPTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 10:19:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:58460 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgLJPTD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:19:03 -0500
Received: from [192.168.15.68]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1knNhZ-00CZ4E-Tz; Thu, 10 Dec 2020 18:17:54 +0300
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-7-shy828301@gmail.com>
 <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com>
 <CAHbLzkoiTmNLXj1Tx0-PggEdcYQ6nj71DUX3ya6mj3VNZ5ho4A@mail.gmail.com>
 <d5454f6d-6739-3252-fba0-ac39c6c526c4@virtuozzo.com>
 <CAHbLzkqu5X-kFKt1vWYc8U=fK=NBWauP-=Kz+A9=GUuQ32+gAQ@mail.gmail.com>
 <20201210151331.GD264602@cmpxchg.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6ffd6aa1-2c55-f4d3-a60a-56786d40531a@virtuozzo.com>
Date:   Thu, 10 Dec 2020 18:17:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210151331.GD264602@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.12.2020 18:13, Johannes Weiner wrote:
> On Wed, Dec 09, 2020 at 09:32:37AM -0800, Yang Shi wrote:
>> On Wed, Dec 9, 2020 at 7:42 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>
>>> On 08.12.2020 20:13, Yang Shi wrote:
>>>> On Thu, Dec 3, 2020 at 3:40 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>>
>>>>> On 02.12.2020 21:27, Yang Shi wrote:
>>>>>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
>>>>>> will be used in the following cases:
>>>>>>     1. Non memcg aware shrinkers
>>>>>>     2. !CONFIG_MEMCG
>>>>>>     3. memcg is disabled by boot parameter
>>>>>>
>>>>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>>>>> ---
>>>>>>  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
>>>>>>  1 file changed, 82 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index cba0bc8d4661..d569fdcaba79 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
>>>>>>  static DEFINE_IDR(shrinker_idr);
>>>>>>  static int shrinker_nr_max;
>>>>>>
>>>>>> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
>>>>>> +{
>>>>>> +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
>>>>>> +             !mem_cgroup_disabled();
>>>>>> +}
>>>>>> +
>>>>>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>>>>>  {
>>>>>>       int id, ret = -ENOMEM;
>>>>>> @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>>>>>>  #endif
>>>>>>       return false;
>>>>>>  }
>>>>>> +
>>>>>> +static inline long count_nr_deferred(struct shrinker *shrinker,
>>>>>> +                                  struct shrink_control *sc)
>>>>>> +{
>>>>>> +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
>>>>>> +     struct memcg_shrinker_deferred *deferred;
>>>>>> +     struct mem_cgroup *memcg = sc->memcg;
>>>>>> +     int nid = sc->nid;
>>>>>> +     int id = shrinker->id;
>>>>>> +     long nr;
>>>>>> +
>>>>>> +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>>>>>> +             nid = 0;
>>>>>> +
>>>>>> +     if (per_memcg_deferred) {
>>>>>> +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
>>>>>> +                                                  true);
>>>>>
>>>>> My comment is about both 5/9 and 6/9 patches.
>>>>
>>>> Sorry for the late reply, I don't know why Gmail filtered this out to spam.
>>>>
>>>>>
>>>>> shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
>>>>> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that you will see
>>>>> memcg->nodeinfo[nid]->shrinker_deferred != NULL in count_nr_deferred(). This may occur
>>>>> because of processor reordering on !x86 (there is no a common lock or memory barriers).
>>>>>
>>>>> Regarding to shrinker_map this is not a problem due to map check in shrink_slab_memcg().
>>>>> The map can't be NULL there.
>>>>>
>>>>> Regarding to shrinker_deferred you should prove either this is not a problem too,
>>>>> or to add proper synchronization (maybe, based on barriers) or to add some similar check
>>>>> (maybe, in shrink_slab_memcg() too).
>>>>
>>>> It seems shrink_slab_memcg() might see shrinker_deferred as NULL
>>>> either due to the same reason. I don't think there is a guarantee it
>>>> won't happen.
>>>>
>>>> We just need guarantee CSS_ONLINE is seen after shrinker_maps and
>>>> shrinker_deferred are allocated, so I'm supposed barriers before
>>>> "css->flags |= CSS_ONLINE" should work.
>>>>
>>>> So the below patch may be ok:
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index df128cab900f..9f7fb0450d69 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -5539,6 +5539,12 @@ static int mem_cgroup_css_online(struct
>>>> cgroup_subsys_state *css)
>>>>                 return -ENOMEM;
>>>>         }
>>>>
>>>>
>>>> +       /*
>>>> +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
>>>> shirnker_maps
>>>> +        * and shrinker_deferred before CSS_ONLINE.
>>>> +        */
>>>> +       smp_mb();
>>>> +
>>>>         /* Online state pins memcg ID, memcg ID pins CSS */
>>>>         refcount_set(&memcg->id.ref, 1);
>>>>         css_get(css);
>>>
>>> smp barriers synchronize data access from different cpus. They should go in a pair.
>>> In case of you add the smp barrier into mem_cgroup_css_online(), we should also
>>> add one more smp barrier in another place, which we want to synchonize with this.
>>> Also, every place should contain a comment referring to its pair: "Pairs with...".
>>
>> Thanks, I think you are correct. Looked into it further, it seems the
>> race pattern looks like:
>>
>> CPU A                                                                  CPU B
>> store shrinker_maps pointer                      load CSS_ONLINE
>> store CSS_ONLINE                                   load shrinker_maps pointer
>>
>> By checking the memory-barriers document, it seems we need write
>> barrier/read barrier pair as below:
>>
>> CPU A                                                                  CPU B
>> store shrinker_maps pointer                       load CSS_ONLINE
>> <write barrier>                                             <read barrier>
>> store CSS_ONLINE                                    load shrinker_maps pointer
>>
>>
>> So, the patch should look like:
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index df128cab900f..489c0a84f82b 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5539,6 +5539,13 @@ static int mem_cgroup_css_online(struct
>> cgroup_subsys_state *css)
>>                 return -ENOMEM;
>>         }
>>
>> +       /*
>> +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
>> shirnker_maps
>> +        * and shrinker_deferred before CSS_ONLINE. It pairs with the
>> read barrier
>> +        * in shrink_slab_memcg().
>> +        */
>> +       smp_wmb();
> 
> Is there a reason why the shrinker allocations aren't done in
> .css_alloc()? That would take care of all necessary ordering:

The reason is that allocations have to be made in a place, where
mem-cgroup_iter() can't miss it, since memcg_expand_shrinker_maps()
shouldn't miss allocated shrinker maps.

> 
>       #0
>       css = ->css_alloc()
>       list_add_tail_rcu(css, parent->children)
>         rcu_assign_pointer()
>       ->css_online(css)
>       css->flags |= CSS_ONLINE
> 
>       #1
>       memcg = mem_cgroup_iter()
>         list_entry_rcu()
> 	  rcu_dereference()
>       shrink_slab(.., memcg)
> 
> RCU ensures that once the cgroup shows up in the reclaim cgroup it's
> also fully allocated.
> 
>>         /* Online state pins memcg ID, memcg ID pins CSS */
>>         refcount_set(&memcg->id.ref, 1);
>>         css_get(css);
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 9d2a6485e982..fc9bda576d98 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -603,13 +603,15 @@ static unsigned long shrink_slab_memcg(gfp_t
>> gfp_mask, int nid,
>>         if (!mem_cgroup_online(memcg))
>>                 return 0;
> 
> ...then we should be able to delete this online check here entirely:
> 
> A not-yet online cgroup is guaranteed to have a shrinker map, just
> with no bits set. The shrinker code handles that just fine.
> 
> An offlined cgroup will eventually have an empty bitmap as the called
> shrinkers return SHRINK_EMPTY. This could also be shortcut by clearing
> the bit in memcg_drain_list_lru_node() the same way we set it in the
> parent when we move all objects upward, but seems correct as-is.
> 

