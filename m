Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9800C2F21EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 22:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbhAKVjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 16:39:19 -0500
Received: from relay.sw.ru ([185.231.240.75]:53800 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727668AbhAKVjT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:39:19 -0500
Received: from [192.168.15.62]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kz4sM-00GEoi-P1; Tue, 12 Jan 2021 00:37:22 +0300
Subject: Re: [v3 PATCH 05/11] mm: vmscan: use a new flag to indicate shrinker
 is registered
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-6-shy828301@gmail.com>
 <bdf650e0-6728-4481-3454-c865649bbdcf@virtuozzo.com>
 <CAHbLzkqZ7Hmo7DSQijrgoKaDQDaOb3+tTGeJ2xU8drFKZ6jv4A@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ff0d1ed1-e2ae-3e0c-e780-e8d2287cc99b@virtuozzo.com>
Date:   Tue, 12 Jan 2021 00:37:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkqZ7Hmo7DSQijrgoKaDQDaOb3+tTGeJ2xU8drFKZ6jv4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.01.2021 21:17, Yang Shi wrote:
> On Wed, Jan 6, 2021 at 2:22 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 06.01.2021 01:58, Yang Shi wrote:
>>> Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
>>> This approach is fine with nr_deferred at the shrinker level, but the following
>>> patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
>>> shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
>>> from unregistering correctly.
>>>
>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>> ---
>>>  include/linux/shrinker.h |  7 ++++---
>>>  mm/vmscan.c              | 13 +++++++++----
>>>  2 files changed, 13 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>>> index 0f80123650e2..1eac79ce57d4 100644
>>> --- a/include/linux/shrinker.h
>>> +++ b/include/linux/shrinker.h
>>> @@ -79,13 +79,14 @@ struct shrinker {
>>>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
>>>
>>>  /* Flags */
>>> -#define SHRINKER_NUMA_AWARE  (1 << 0)
>>> -#define SHRINKER_MEMCG_AWARE (1 << 1)
>>> +#define SHRINKER_REGISTERED  (1 << 0)
>>> +#define SHRINKER_NUMA_AWARE  (1 << 1)
>>> +#define SHRINKER_MEMCG_AWARE (1 << 2)
>>>  /*
>>>   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
>>>   * non-MEMCG_AWARE shrinker should not have this flag set.
>>>   */
>>> -#define SHRINKER_NONSLAB     (1 << 2)
>>> +#define SHRINKER_NONSLAB     (1 << 3)
>>>
>>>  extern int prealloc_shrinker(struct shrinker *shrinker);
>>>  extern void register_shrinker_prepared(struct shrinker *shrinker);
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 8da765a85569..9761c7c27412 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -494,6 +494,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>>>       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>               idr_replace(&shrinker_idr, shrinker, shrinker->id);
>>>  #endif
>>> +     shrinker->flags |= SHRINKER_REGISTERED;
>>
>> In case of we introduce this new flag, we should kill old flag SHRINKER_REGISTERING,
>> which are not needed anymore (we should you the new flag instead of that).
> 
> The only think that I'm confused with is the check in
> shrink_slab_memcg, it does:
> 
> shrinker = idr_find(&shrinker_idr, i);
> if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> 
> When allocating idr, the shrinker is associated with
> SHRINKER_REGISTERING. But, shrink_slab_memcg does acquire read
> shrinker_rwsem, and idr_alloc is called with holding write
> shrinker_rwsem, so I'm supposed shrink_slab_memcg should never see
> shrinker is registering.

After prealloc_shrinker() shrinker is visible for shrink_slab_memcg().
This is the moment shrink_slab_memcg() sees SHRINKER_REGISTERED.

> If so it seems easy to remove
> SHRINKER_REGISTERING.
> 
> We just need change that check to:
> !shrinker || !(shrinker->flags & SHRINKER_REGISTERED)
> 
>>>       up_write(&shrinker_rwsem);
>>>  }
>>>
>>> @@ -513,13 +514,17 @@ EXPORT_SYMBOL(register_shrinker);
>>>   */
>>>  void unregister_shrinker(struct shrinker *shrinker)
>>>  {
>>> -     if (!shrinker->nr_deferred)
>>> -             return;
>>> -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>> -             unregister_memcg_shrinker(shrinker);
>>>       down_write(&shrinker_rwsem);
>>
>> I do not think there are some users which registration may race with unregistration.
>> So, I think we should check SHRINKER_REGISTERED unlocked similar to we used to check
>> shrinker->nr_deferred unlocked.
> 
> Yes, I agree.
> 
>>
>>> +     if (!(shrinker->flags & SHRINKER_REGISTERED)) {
>>> +             up_write(&shrinker_rwsem);
>>> +             return;
>>> +     }
>>>       list_del(&shrinker->list);
>>> +     shrinker->flags &= ~SHRINKER_REGISTERED;
>>>       up_write(&shrinker_rwsem);
>>> +
>>> +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>> +             unregister_memcg_shrinker(shrinker);
>>>       kfree(shrinker->nr_deferred);
>>>       shrinker->nr_deferred = NULL;
>>>  }
>>>
>>
>>

