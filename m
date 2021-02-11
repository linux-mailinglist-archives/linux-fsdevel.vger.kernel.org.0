Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA331905A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhBKQuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 11:50:21 -0500
Received: from relay.sw.ru ([185.231.240.75]:46364 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhBKQsL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=oXZLziWhPu0Gxt1AEaJltuNOBVwsbPLtvv7bCVewRGs=; b=MQLqvmNXnlj1eL6Vx
        FGReTJzxdR5dhLDUHLMLbu7YV9PE0pQR3UuFORqWBK8hy+E1N3a3AOTzWlvWuvqnZS1oOQe6zIHUV
        XO0X6ZttcD4hyoDO5rkit0GV9/vz/CfQoe5aJLrePyXGmCDrgog+h3r2LfZ1J1dBt8bhD9uOQ7yg4
        =;
Received: from [192.168.15.211]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1lAF7L-002AG4-Pk; Thu, 11 Feb 2021 19:46:59 +0300
Subject: Re: [v7 PATCH 05/12] mm: memcontrol: rename shrinker_map to
 shrinker_info
To:     Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-6-shy828301@gmail.com>
 <20210209205014.GH524633@carbon.DHCP.thefacebook.com>
 <CAHbLzkr+5t5wTVRDih53ty-TcsMrmKxZ5iiPw1dwnDsz_URz=Q@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5703130a-ea5b-3257-2ba0-3c25df010296@virtuozzo.com>
Date:   Thu, 11 Feb 2021 19:47:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHbLzkr+5t5wTVRDih53ty-TcsMrmKxZ5iiPw1dwnDsz_URz=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.02.2021 02:33, Yang Shi wrote:
> On Tue, Feb 9, 2021 at 12:50 PM Roman Gushchin <guro@fb.com> wrote:
>>
>> On Tue, Feb 09, 2021 at 09:46:39AM -0800, Yang Shi wrote:
>>> The following patch is going to add nr_deferred into shrinker_map, the change will
>>> make shrinker_map not only include map anymore, so rename it to "memcg_shrinker_info".
>>> And this should make the patch adding nr_deferred cleaner and readable and make
>>> review easier.  Also remove the "memcg_" prefix.
>>>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>> ---
>>>  include/linux/memcontrol.h |  8 ++---
>>>  mm/memcontrol.c            |  6 ++--
>>>  mm/vmscan.c                | 62 +++++++++++++++++++-------------------
>>>  3 files changed, 38 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index 1739f17e0939..4c9253896e25 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -96,7 +96,7 @@ struct lruvec_stat {
>>>   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
>>>   * which have elements charged to this memcg.
>>>   */
>>> -struct memcg_shrinker_map {
>>> +struct shrinker_info {
>>>       struct rcu_head rcu;
>>>       unsigned long map[];
>>>  };
>>> @@ -118,7 +118,7 @@ struct mem_cgroup_per_node {
>>>
>>>       struct mem_cgroup_reclaim_iter  iter;
>>>
>>> -     struct memcg_shrinker_map __rcu *shrinker_map;
>>> +     struct shrinker_info __rcu      *shrinker_info;
>>
>> Nice!
>>
>> I really like how it looks now in comparison to the v1. Thank you for
>> working on it!
> 
> Thanks a lot for all the great comments from all of you.
> 
>>
>>>
>>>       struct rb_node          tree_node;      /* RB tree node */
>>>       unsigned long           usage_in_excess;/* Set to the value by which */
>>> @@ -1581,8 +1581,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>>>       return false;
>>>  }
>>>
>>> -int alloc_shrinker_maps(struct mem_cgroup *memcg);
>>> -void free_shrinker_maps(struct mem_cgroup *memcg);
>>> +int alloc_shrinker_info(struct mem_cgroup *memcg);
>>> +void free_shrinker_info(struct mem_cgroup *memcg);
>>>  void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
>>>  #else
>>>  #define mem_cgroup_sockets_enabled 0
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index f5c9a0d2160b..f64ad0d044d9 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -5246,11 +5246,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>>       struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>>
>>>       /*
>>> -      * A memcg must be visible for expand_shrinker_maps()
>>> +      * A memcg must be visible for expand_shrinker_info()
>>>        * by the time the maps are allocated. So, we allocate maps
>>>        * here, when for_each_mem_cgroup() can't skip it.
>>>        */
>>> -     if (alloc_shrinker_maps(memcg)) {
>>> +     if (alloc_shrinker_info(memcg)) {
>>>               mem_cgroup_id_remove(memcg);
>>>               return -ENOMEM;
>>>       }
>>> @@ -5314,7 +5314,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>>>       vmpressure_cleanup(&memcg->vmpressure);
>>>       cancel_work_sync(&memcg->high_work);
>>>       mem_cgroup_remove_from_trees(memcg);
>>> -     free_shrinker_maps(memcg);
>>> +     free_shrinker_info(memcg);
>>>       memcg_free_kmem(memcg);
>>>       mem_cgroup_free(memcg);
>>>  }
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 641077b09e5d..9436f9246d32 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -190,20 +190,20 @@ static int shrinker_nr_max;
>>>  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
>>>       (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
>>>
>>> -static void free_shrinker_map_rcu(struct rcu_head *head)
>>> +static void free_shrinker_info_rcu(struct rcu_head *head)
>>>  {
>>> -     kvfree(container_of(head, struct memcg_shrinker_map, rcu));
>>> +     kvfree(container_of(head, struct shrinker_info, rcu));
>>>  }
>>>
>>> -static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>>> +static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>>                                  int size, int old_size)
>>>  {
>>> -     struct memcg_shrinker_map *new, *old;
>>> +     struct shrinker_info *new, *old;
>>>       int nid;
>>>
>>>       for_each_node(nid) {
>>>               old = rcu_dereference_protected(
>>> -                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
>>> +                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
>>>               /* Not yet online memcg */
>>>               if (!old)
>>>                       return 0;
>>> @@ -216,17 +216,17 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>>>               memset(new->map, (int)0xff, old_size);
>>>               memset((void *)new->map + old_size, 0, size - old_size);
>>>
>>> -             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
>>> -             call_rcu(&old->rcu, free_shrinker_map_rcu);
>>> +             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
>>> +             call_rcu(&old->rcu, free_shrinker_info_rcu);
>>
>> Why not use kvfree_rcu() and get rid of free_shrinker_info_rcu() callback?
> 
> Just because this patch is aimed to rename the structure. I think it
> may be more preferred to have the cleanup in a separate patch?

I'd voted for a separate patch
