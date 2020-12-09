Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA92D45A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 16:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgLIPmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 10:42:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:45694 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbgLIPmq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:42:46 -0500
Received: from [192.168.15.177]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kn1b1-00CQdb-IE; Wed, 09 Dec 2020 18:41:39 +0300
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-7-shy828301@gmail.com>
 <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com>
 <CAHbLzkoiTmNLXj1Tx0-PggEdcYQ6nj71DUX3ya6mj3VNZ5ho4A@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d5454f6d-6739-3252-fba0-ac39c6c526c4@virtuozzo.com>
Date:   Wed, 9 Dec 2020 18:41:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoiTmNLXj1Tx0-PggEdcYQ6nj71DUX3ya6mj3VNZ5ho4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.12.2020 20:13, Yang Shi wrote:
> On Thu, Dec 3, 2020 at 3:40 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 02.12.2020 21:27, Yang Shi wrote:
>>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
>>> will be used in the following cases:
>>>     1. Non memcg aware shrinkers
>>>     2. !CONFIG_MEMCG
>>>     3. memcg is disabled by boot parameter
>>>
>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>> ---
>>>  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 82 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index cba0bc8d4661..d569fdcaba79 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
>>>  static DEFINE_IDR(shrinker_idr);
>>>  static int shrinker_nr_max;
>>>
>>> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
>>> +{
>>> +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
>>> +             !mem_cgroup_disabled();
>>> +}
>>> +
>>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>>  {
>>>       int id, ret = -ENOMEM;
>>> @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>>>  #endif
>>>       return false;
>>>  }
>>> +
>>> +static inline long count_nr_deferred(struct shrinker *shrinker,
>>> +                                  struct shrink_control *sc)
>>> +{
>>> +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
>>> +     struct memcg_shrinker_deferred *deferred;
>>> +     struct mem_cgroup *memcg = sc->memcg;
>>> +     int nid = sc->nid;
>>> +     int id = shrinker->id;
>>> +     long nr;
>>> +
>>> +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>>> +             nid = 0;
>>> +
>>> +     if (per_memcg_deferred) {
>>> +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
>>> +                                                  true);
>>
>> My comment is about both 5/9 and 6/9 patches.
> 
> Sorry for the late reply, I don't know why Gmail filtered this out to spam.
> 
>>
>> shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
>> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that you will see
>> memcg->nodeinfo[nid]->shrinker_deferred != NULL in count_nr_deferred(). This may occur
>> because of processor reordering on !x86 (there is no a common lock or memory barriers).
>>
>> Regarding to shrinker_map this is not a problem due to map check in shrink_slab_memcg().
>> The map can't be NULL there.
>>
>> Regarding to shrinker_deferred you should prove either this is not a problem too,
>> or to add proper synchronization (maybe, based on barriers) or to add some similar check
>> (maybe, in shrink_slab_memcg() too).
> 
> It seems shrink_slab_memcg() might see shrinker_deferred as NULL
> either due to the same reason. I don't think there is a guarantee it
> won't happen.
> 
> We just need guarantee CSS_ONLINE is seen after shrinker_maps and
> shrinker_deferred are allocated, so I'm supposed barriers before
> "css->flags |= CSS_ONLINE" should work.
> 
> So the below patch may be ok:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index df128cab900f..9f7fb0450d69 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5539,6 +5539,12 @@ static int mem_cgroup_css_online(struct
> cgroup_subsys_state *css)
>                 return -ENOMEM;
>         }
> 
> 
> +       /*
> +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
> shirnker_maps
> +        * and shrinker_deferred before CSS_ONLINE.
> +        */
> +       smp_mb();
> +
>         /* Online state pins memcg ID, memcg ID pins CSS */
>         refcount_set(&memcg->id.ref, 1);
>         css_get(css);

smp barriers synchronize data access from different cpus. They should go in a pair.
In case of you add the smp barrier into mem_cgroup_css_online(), we should also
add one more smp barrier in another place, which we want to synchonize with this.
Also, every place should contain a comment referring to its pair: "Pairs with...".

Kirill
