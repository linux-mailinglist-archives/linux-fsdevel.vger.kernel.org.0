Return-Path: <linux-fsdevel+bounces-4955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA0806C45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F95C1F210FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064B62D7AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L78+rBtP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF431B6
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 00:37:47 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b8bbc9904cso665860b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 00:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701851866; x=1702456666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaJoVl1xcnDv8bDUAtsLOITCy9bE8N9edGoKxnrkX8Y=;
        b=L78+rBtP/F4GFj4FX5q0OpxFm3VJZ1v3SREwG4bulzwmVVuBDNjBNzoiMYdhypz7RS
         Ox1QCdWnSy+2C5Z0gc02cxGjsGRFD1jSt1yBxDcgB2vbMr5rrKpDu/V8VD4/27qpP7CL
         wb2LkRZA1klLRWkKvFQqX1WLUIjsNHpQi+pImP3qcZQ1N8V9p5yuyHCmkUGJwd6mw6fS
         YevZaa261XHWPz7DL8aZ5xpH4jyQbYdNIdTy6+4h4diXpLoBY2Vq0lYNcSDPnmIZOABy
         EY6Binuqicrt8AP/911Xx4DctM+n07xzTztYqlZiy2cSdMreiOdmowIU5ze+ngjDx+sB
         eKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851866; x=1702456666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaJoVl1xcnDv8bDUAtsLOITCy9bE8N9edGoKxnrkX8Y=;
        b=jbuBwrxNi6OD22mKTcviMZ0MUk70P8L428GIWv8VYT/s7fR/LVbMMgL5hZEP0O3bOU
         qWdH65dPLSWmFbBX3YlXB8mwl9oJ4P7TcH46uITSjpJXs8BQpQmugnRHDet6oBrudrVp
         cB28/thBVGq2rxtKW1+RrkbYiYEw9xiVRTFUrjqBjh+2et8uOHqOxYkTyOr2cJv3zyZr
         n55Qx/jE0I9UNCGk+cSjmlt/QtKTQEsE25qSBbjWfLV8Ow/eQwixeu0xgUq3iajBjKce
         YUoThDMbrHzTvaVwzhnIWW29WGzXfps8UL43zAR/2nt8b9rwKhOs50ANvC+NfGpsRPdP
         UJvA==
X-Gm-Message-State: AOJu0YwDXZNe5oisK8E7VFc/JrmUmVBsdfyNng3mnXEQ2ynJ2SYvSASc
	rkvc/8re3bHmeTcvlFvlU8Xzig==
X-Google-Smtp-Source: AGHT+IFiQNAALnSXiskPUOUstWqNThnLWbU+mRiJzu4yAKenbwX/YTOEz22k0SFEWiI9vkQtni/C4Q==
X-Received: by 2002:a05:6808:1897:b0:3b8:98f0:3c2 with SMTP id bi23-20020a056808189700b003b898f003c2mr1066637oib.4.1701851866156;
        Wed, 06 Dec 2023 00:37:46 -0800 (PST)
Received: from [10.84.152.29] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id e14-20020a62aa0e000000b006ce95e37a40sm602816pff.111.2023.12.06.00.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 00:37:45 -0800 (PST)
Message-ID: <7c170029-e847-49cf-8332-dc1388fc5c86@bytedance.com>
Date: Wed, 6 Dec 2023 16:37:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/45] mm: shrinker: make global slab shrink lockless
Content-Language: en-US
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: akpm@linux-foundation.org, paulmck@kernel.org, david@fromorbit.com,
 tkhai@ya.ru, vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, tytso@mit.edu, steven.price@arm.com, cel@kernel.org,
 senozhatsky@chromium.org, yujie.liu@intel.com, gregkh@linuxfoundation.org,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-43-zhengqi.arch@bytedance.com>
 <CAJhGHyBdk++L+DhZoZfHUac3ci14QdTM7qqUSQ_fO2iY1iHKKA@mail.gmail.com>
 <93c36097-5266-4fc5-84a8-d770ab344361@bytedance.com>
 <CAJhGHyBJiYOQGY3t=Lpe4A-rmJML8Mn8GC35GkrQ6Us082ZTAQ@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAJhGHyBJiYOQGY3t=Lpe4A-rmJML8Mn8GC35GkrQ6Us082ZTAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2023/12/6 16:23, Lai Jiangshan wrote:
> On Wed, Dec 6, 2023 at 3:55 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Hi,
>>
>> On 2023/12/6 15:47, Lai Jiangshan wrote:
>>> On Tue, Sep 12, 2023 at 9:57 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>>> -       if (!down_read_trylock(&shrinker_rwsem))
>>>> -               goto out;
>>>> -
>>>> -       list_for_each_entry(shrinker, &shrinker_list, list) {
>>>> +       /*
>>>> +        * lockless algorithm of global shrink.
>>>> +        *
>>>> +        * In the unregistration setp, the shrinker will be freed asynchronously
>>>> +        * via RCU after its refcount reaches 0. So both rcu_read_lock() and
>>>> +        * shrinker_try_get() can be used to ensure the existence of the shrinker.
>>>> +        *
>>>> +        * So in the global shrink:
>>>> +        *  step 1: use rcu_read_lock() to guarantee existence of the shrinker
>>>> +        *          and the validity of the shrinker_list walk.
>>>> +        *  step 2: use shrinker_try_get() to try get the refcount, if successful,
>>>> +        *          then the existence of the shrinker can also be guaranteed,
>>>> +        *          so we can release the RCU lock to do do_shrink_slab() that
>>>> +        *          may sleep.
>>>> +        *  step 3: *MUST* to reacquire the RCU lock before calling shrinker_put(),
>>>> +        *          which ensures that neither this shrinker nor the next shrinker
>>>> +        *          will be freed in the next traversal operation.
>>>
>>> Hello, Qi, Andrew, Paul,
>>>
>>> I wonder know how RCU can ensure the lifespan of the next shrinker.
>>> it seems it is diverged from the common pattern usage of RCU+reference.
>>>
>>> cpu1:
>>> rcu_read_lock();
>>> shrinker_try_get(this_shrinker);
>>> rcu_read_unlock();
>>>       cpu2: shrinker_free(this_shrinker);
>>>       cpu2: shrinker_free(next_shrinker); and free the memory of next_shrinker
>>>       cpu2: when shrinker_free(next_shrinker), no one updates this_shrinker's next
>>>       cpu2: since this_shrinker has been removed first.
>>
>> No, this_shrinker will not be removed from the shrinker_list until the
>> last refcount is released. See below:
>>
>>> rcu_read_lock();
>>> shrinker_put(this_shrinker);
>>
>>          CPU 1                                      CPU 2
>>
>>     --> if (refcount_dec_and_test(&shrinker->refcount))
>>                  complete(&shrinker->done);
>>
>>                                  wait_for_completion(&shrinker->done);
>>                                   list_del_rcu(&shrinker->list);
> 
> since shrinker will not be removed from the shrinker_list until the
> last refcount is released.
> 
> Is it possible that shrinker_free() can be starved by continuous
> scanners getting and putting the refcount?

I actually considered this case, but the probability of this
happening was low, so I discarded the relevant code (v2 --> v3).
If this problem really occurs in a production environment, we
can fix it, like below:

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 1a00be90d93a..e5ebbbf1414f 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -88,6 +88,7 @@ struct shrinker {
         long batch;     /* reclaim batch size, 0 = default */
         int seeks;      /* seeks to recreate an obj */
         unsigned flags;
+       bool registered;

         /*
          * The reference count of this shrinker. Registered shrinker 
have an
@@ -138,7 +139,8 @@ void shrinker_free(struct shrinker *shrinker);

  static inline bool shrinker_try_get(struct shrinker *shrinker)
  {
-       return refcount_inc_not_zero(&shrinker->refcount);
+       return READ_ONCE(shrinker->registered) &&
+              refcount_inc_not_zero(&shrinker->refcount);
  }

  static inline void shrinker_put(struct shrinker *shrinker)
diff --git a/mm/shrinker.c b/mm/shrinker.c
index dd91eab43ed3..9b8881d178c6 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -753,6 +753,7 @@ void shrinker_register(struct shrinker *shrinker)
          * shrinker_try_get().
          */
         refcount_set(&shrinker->refcount, 1);
+       WRITE_ONCE(shrinker->registered, true);
  }
  EXPORT_SYMBOL_GPL(shrinker_register);

@@ -773,6 +774,7 @@ void shrinker_free(struct shrinker *shrinker)
                 return;

         if (shrinker->flags & SHRINKER_REGISTERED) {
+               WRITE_ONCE(shrinker->registered, false);
                 /* drop the initial refcount */
                 shrinker_put(shrinker);
                 /*

Thanks,
Qi

> 
> Thanks
> Lai
> 
> 
>>
>>> travel to the freed next_shrinker.
>>>
>>> a quick simple fix:
>>>
>>> // called with other references other than RCU (i.e. refcount)
>>> static inline rcu_list_deleted(struct list_head *entry)
>>> {
>>>      // something like this:
>>>      return entry->prev == LIST_POISON2;
>>> }
>>>
>>> // in the loop
>>> if (rcu_list_deleted(&shrinker->list)) {
>>>      shrinker_put(shrinker);
>>>      goto restart;
>>> }
>>> rcu_read_lock();
>>> shrinker_put(shrinker);
>>>
>>> Thanks
>>> Lai
>>>
>>>> +        *  step 4: do shrinker_put() paired with step 2 to put the refcount,
>>>> +        *          if the refcount reaches 0, then wake up the waiter in
>>>> +        *          shrinker_free() by calling complete().
>>>> +        */
>>>> +       rcu_read_lock();
>>>> +       list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>>>>                   struct shrink_control sc = {
>>>>                           .gfp_mask = gfp_mask,
>>>>                           .nid = nid,
>>>>                           .memcg = memcg,
>>>>                   };
>>>>
>>>> +               if (!shrinker_try_get(shrinker))
>>>> +                       continue;
>>>> +
>>>> +               rcu_read_unlock();
>>>> +
>>>>                   ret = do_shrink_slab(&sc, shrinker, priority);
>>>>                   if (ret == SHRINK_EMPTY)
>>>>                           ret = 0;
>>>>                   freed += ret;
>>>> -               /*
>>>> -                * Bail out if someone want to register a new shrinker to
>>>> -                * prevent the registration from being stalled for long periods
>>>> -                * by parallel ongoing shrinking.
>>>> -                */
>>>> -               if (rwsem_is_contended(&shrinker_rwsem)) {
>>>> -                       freed = freed ? : 1;
>>>> -                       break;
>>>> -               }
>>>> +
>>>> +               rcu_read_lock();
>>>> +               shrinker_put(shrinker);
>>>>           }
>>>>

