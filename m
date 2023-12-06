Return-Path: <linux-fsdevel+bounces-4951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43278069CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72543281B8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C9199CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="agnOoORL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E086188
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 23:55:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d03f90b0cbso12449645ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701849337; x=1702454137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KS8bxqNBURkYnzM0KcIii/6TxRexjVdODNdz5oVxNd4=;
        b=agnOoORL9S/rsRVOticNDCtc1yQkbzMho1Fs3vKSvQ+sSqXAh8nm+v6bW61VTsBRTK
         gip3padSAqTxAaJ9wfVq9hxY4+OtOsQFv7h/L2W1FI4w5Ips6zBP7AVxRoasxXY15VpG
         vGZQ6IfHYbfUs/jRJMZweey28YzDiDH1vS/xeaqaSLcrnF16KNUBmAJ9W9PEcea66vAS
         Bg6KNhi7SExObHxLC2Iz29SdBbhp0Q+FTVMa9cZTJUa160d1qesS6fgTm7MqykjvuR0Z
         hfRen1h5EiYRbilNXu9nlIQUzB+dcGkQJX82wT73CJpLgHU1kftwpwWAwnUStR1n5tnn
         ME9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849337; x=1702454137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS8bxqNBURkYnzM0KcIii/6TxRexjVdODNdz5oVxNd4=;
        b=koA+gFh8zIEYOu0BKLjOHCuYMHqAnSGm/LkFphNBoGRo1g4kW/iaylnC4qPdaL4GMU
         +6x1FjB6AdqL+krpgfvoGBZpxn2plkTe3NuMFN1tGctv6+qV6/iDe6mudnMT0yDxNSiv
         ZDx1kRp/AtLtqR8hUlMIz8NCIqU+fYbgYnGabx+O8ksOFLhDrALoaiIwvox7OM/74q5Y
         r5RY2CDx4fQ066HUOa7rmHAXHYfELHhV0Nf8EcnpMfiPJWLSLcnTkYGBdo5ODbLmBcL4
         HQEqqSV8st52pqUsN74tnlHHiGhOKYc2JGTpoXTofQ2Z6AsQWlzT/BLK2ekZp5r8oJtW
         Wjrw==
X-Gm-Message-State: AOJu0YycykWXDi0YLJdWI3JxViD2tHOMU62BcC82DKLnzOzppnfhozGF
	cPiv9dd6VEdRUsXqYPi5xZToVg==
X-Google-Smtp-Source: AGHT+IFLk5sMy9OTPu9J3OwOGKIEAcdCIVFjwUnyOPSBh82NogqdIsEMmvb8Qth2WbV8n11qZVbf8Q==
X-Received: by 2002:a17:902:cec1:b0:1cf:b192:fab8 with SMTP id d1-20020a170902cec100b001cfb192fab8mr945048plg.1.1701849336937;
        Tue, 05 Dec 2023 23:55:36 -0800 (PST)
Received: from [10.84.152.29] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090276c300b001b7f40a8959sm11411596plt.76.2023.12.05.23.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 23:55:36 -0800 (PST)
Message-ID: <93c36097-5266-4fc5-84a8-d770ab344361@bytedance.com>
Date: Wed, 6 Dec 2023 15:55:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/45] mm: shrinker: make global slab shrink lockless
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
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAJhGHyBdk++L+DhZoZfHUac3ci14QdTM7qqUSQ_fO2iY1iHKKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2023/12/6 15:47, Lai Jiangshan wrote:
> On Tue, Sep 12, 2023 at 9:57 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> -       if (!down_read_trylock(&shrinker_rwsem))
>> -               goto out;
>> -
>> -       list_for_each_entry(shrinker, &shrinker_list, list) {
>> +       /*
>> +        * lockless algorithm of global shrink.
>> +        *
>> +        * In the unregistration setp, the shrinker will be freed asynchronously
>> +        * via RCU after its refcount reaches 0. So both rcu_read_lock() and
>> +        * shrinker_try_get() can be used to ensure the existence of the shrinker.
>> +        *
>> +        * So in the global shrink:
>> +        *  step 1: use rcu_read_lock() to guarantee existence of the shrinker
>> +        *          and the validity of the shrinker_list walk.
>> +        *  step 2: use shrinker_try_get() to try get the refcount, if successful,
>> +        *          then the existence of the shrinker can also be guaranteed,
>> +        *          so we can release the RCU lock to do do_shrink_slab() that
>> +        *          may sleep.
>> +        *  step 3: *MUST* to reacquire the RCU lock before calling shrinker_put(),
>> +        *          which ensures that neither this shrinker nor the next shrinker
>> +        *          will be freed in the next traversal operation.
> 
> Hello, Qi, Andrew, Paul,
> 
> I wonder know how RCU can ensure the lifespan of the next shrinker.
> it seems it is diverged from the common pattern usage of RCU+reference.
> 
> cpu1:
> rcu_read_lock();
> shrinker_try_get(this_shrinker);
> rcu_read_unlock();
>      cpu2: shrinker_free(this_shrinker);
>      cpu2: shrinker_free(next_shrinker); and free the memory of next_shrinker
>      cpu2: when shrinker_free(next_shrinker), no one updates this_shrinker's next
>      cpu2: since this_shrinker has been removed first.

No, this_shrinker will not be removed from the shrinker_list until the
last refcount is released. See below:

> rcu_read_lock();
> shrinker_put(this_shrinker);

	CPU 1                                      CPU 2

   --> if (refcount_dec_and_test(&shrinker->refcount))
		complete(&shrinker->done);

				wait_for_completion(&shrinker->done);
                                 list_del_rcu(&shrinker->list);

> travel to the freed next_shrinker.
> 
> a quick simple fix:
> 
> // called with other references other than RCU (i.e. refcount)
> static inline rcu_list_deleted(struct list_head *entry)
> {
>     // something like this:
>     return entry->prev == LIST_POISON2;
> }
> 
> // in the loop
> if (rcu_list_deleted(&shrinker->list)) {
>     shrinker_put(shrinker);
>     goto restart;
> }
> rcu_read_lock();
> shrinker_put(shrinker);
> 
> Thanks
> Lai
> 
>> +        *  step 4: do shrinker_put() paired with step 2 to put the refcount,
>> +        *          if the refcount reaches 0, then wake up the waiter in
>> +        *          shrinker_free() by calling complete().
>> +        */
>> +       rcu_read_lock();
>> +       list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>>                  struct shrink_control sc = {
>>                          .gfp_mask = gfp_mask,
>>                          .nid = nid,
>>                          .memcg = memcg,
>>                  };
>>
>> +               if (!shrinker_try_get(shrinker))
>> +                       continue;
>> +
>> +               rcu_read_unlock();
>> +
>>                  ret = do_shrink_slab(&sc, shrinker, priority);
>>                  if (ret == SHRINK_EMPTY)
>>                          ret = 0;
>>                  freed += ret;
>> -               /*
>> -                * Bail out if someone want to register a new shrinker to
>> -                * prevent the registration from being stalled for long periods
>> -                * by parallel ongoing shrinking.
>> -                */
>> -               if (rwsem_is_contended(&shrinker_rwsem)) {
>> -                       freed = freed ? : 1;
>> -                       break;
>> -               }
>> +
>> +               rcu_read_lock();
>> +               shrinker_put(shrinker);
>>          }
>>

