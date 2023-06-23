Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610B73B817
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjFWMuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjFWMtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:49:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A862699
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 05:49:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25eabe8b5fcso128674a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687524556; x=1690116556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8pNNe3/2YXc1UbpwIO0yIQjjCMHlVzYoQIGO6mvjFk=;
        b=QGBZmpep2cOxIyWlosUFsMcpQ9kg5K87eUwaCkoJh4THNNRNLwHsme8TdeLzEMWIeP
         VdLJNjtWaWRTs1BgqyEhXBtiEVFykoOa991SQObW/BJT+zi5DexUk11xpe7roRZxmWon
         2pGVoZYSHZZ/jcf4PvMYbIbG4+IvNv5UsypZ1n69fFVKkkIf9VFUIy36CCJ41i5gEjmj
         pEUDPSL4513Qlt5OfOQBEaAkajaH6+U57PEpyNffGcW5GRaJN9aybo3oePHHyCF2AmXB
         fAsbevik08duVzt2PX0xDdykhFrKiqCqdIA2Nyt6p8FSXga6r8QFK1BCiiTQLBdQZfhD
         b2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524556; x=1690116556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8pNNe3/2YXc1UbpwIO0yIQjjCMHlVzYoQIGO6mvjFk=;
        b=BQM7SuqLfrMbAdMSocvISbkwk+SLaJYGvxXEV5pNuoFfrIkVIvSswQnYif0RrT9HLU
         4itDLTELYxf6yHmcY77XhU6F/gZPVaFcTCbolV7ISsgerMgHew7z5qbsQZMyCbApAXZM
         wvUhhFGSVPrfXb6xILnpsvE3rjTSBxe7Mjic99cfxY1+G5t4BBOBzwurb2cURqsHfRKT
         HvS+4SAXv5/QrD5XBuXQ01MBFvxsodjEpxH4dq9VlR9PaiqaEyAthdV6qksPqd5OR2kT
         DAa6tnxk94BD9uSsPCOxY3UuFOUrT/iBLp+9GnWOgqsMMzSInfpbvHvTbaUI2EL6GA68
         eBSA==
X-Gm-Message-State: AC+VfDyO/UThENGfBOrfR2tpHcP4WXABPIuXhG6cYE8c1hBk68ITcywE
        0yYCvf3nFwIDpRi4yF1gU6zLGA==
X-Google-Smtp-Source: ACHHUZ6eQKAAK+mFZK9b/rl5yBeScp7LGUAVTtY7Qwt+jrMMbGjG/tQ037wkOBUmA1P5xX8mDtOLpg==
X-Received: by 2002:a17:90b:350f:b0:258:d367:63c with SMTP id ls15-20020a17090b350f00b00258d367063cmr24920553pjb.1.1687524555690;
        Fri, 23 Jun 2023 05:49:15 -0700 (PDT)
Received: from [10.4.168.167] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b0026135208e97sm1471795pja.19.2023.06.23.05.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:49:15 -0700 (PDT)
Message-ID: <d8632edc-5021-4dc8-b75a-3995a710f196@bytedance.com>
Date:   Fri, 23 Jun 2023 20:49:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 02/29] mm: vmscan: introduce some helpers for dynamically
 allocating shrinker
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-3-zhengqi.arch@bytedance.com>
 <ZJU3s8tyGsYTVS8f@dread.disaster.area>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZJU3s8tyGsYTVS8f@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On 2023/6/23 14:12, Dave Chinner wrote:
> On Thu, Jun 22, 2023 at 04:53:08PM +0800, Qi Zheng wrote:
>> Introduce some helpers for dynamically allocating shrinker instance,
>> and their uses are as follows:
>>
>> 1. shrinker_alloc_and_init()
>>
>> Used to allocate and initialize a shrinker instance, the priv_data
>> parameter is used to pass the pointer of the previously embedded
>> structure of the shrinker instance.
>>
>> 2. shrinker_free()
>>
>> Used to free the shrinker instance when the registration of shrinker
>> fails.
>>
>> 3. unregister_and_free_shrinker()
>>
>> Used to unregister and free the shrinker instance, and the kfree()
>> will be changed to kfree_rcu() later.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/shrinker.h | 12 ++++++++++++
>>   mm/vmscan.c              | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 43e6fcabbf51..8e9ba6fa3fcc 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -107,6 +107,18 @@ extern void unregister_shrinker(struct shrinker *shrinker);
>>   extern void free_prealloced_shrinker(struct shrinker *shrinker);
>>   extern void synchronize_shrinkers(void);
>>   
>> +typedef unsigned long (*count_objects_cb)(struct shrinker *s,
>> +					  struct shrink_control *sc);
>> +typedef unsigned long (*scan_objects_cb)(struct shrinker *s,
>> +					 struct shrink_control *sc);
>> +
>> +struct shrinker *shrinker_alloc_and_init(count_objects_cb count,
>> +					 scan_objects_cb scan, long batch,
>> +					 int seeks, unsigned flags,
>> +					 void *priv_data);
>> +void shrinker_free(struct shrinker *shrinker);
>> +void unregister_and_free_shrinker(struct shrinker *shrinker);
> 
> Hmmmm. Not exactly how I envisioned this to be done.
> 
> Ok, this will definitely work, but I don't think it is an
> improvement. It's certainly not what I was thinking of when I
> suggested dynamically allocating shrinkers.
> 
> The main issue is that this doesn't simplify the API - it expands it
> and creates a minefield of old and new functions that have to be
> used in exactly the right order for the right things to happen.
> 
> What I was thinking of was moving the entire shrinker setup code
> over to the prealloc/register_prepared() algorithm, where the setup
> is already separated from the activation of the shrinker.
> 
> That is, we start by renaming prealloc_shrinker() to
> shrinker_alloc(), adding a flags field to tell it everything that it
> needs to alloc (i.e. the NUMA/MEMCG_AWARE flags) and having it
> returned a fully allocated shrinker ready to register. Initially
> this also contains an internal flag to say the shrinker was
> allocated so that unregister_shrinker() knows to free it.
> 
> The caller then fills out the shrinker functions, seeks, etc. just
> like the do now, and then calls register_shrinker_prepared() to make
> the shrinker active when it wants to turn it on.
> 
> When it is time to tear down the shrinker, no API needs to change.
> unregister_shrinker() does all the shutdown and frees all the
> internal memory like it does now. If the shrinker is also marked as
> allocated, it frees the shrinker via RCU, too.
> 
> Once everything is converted to this API, we then remove
> register_shrinker(), rename register_shrinker_prepared() to
> shrinker_register(), rename unregister_shrinker to
> shrinker_unregister(), get rid of the internal "allocated" flag
> and always free the shrinker.

IIUC, you mean that we also need to convert the original statically
defined shrinker instances to dynamically allocated.

I think this is a good idea, it helps to simplify the APIs and also
remove special handling for case a and b (mentioned in cover letter).

> 
> At the end of the patchset, every shrinker should be set
> up in a manner like this:
> 
> 
> 	sb->shrinker = shrinker_alloc(SHRINKER_MEMCG_AWARE|SHRINKER_NUMA_AWARE,
> 				"sb-%s", type->name);
> 	if (!sb->shrinker)
> 		return -ENOMEM;
> 
> 	sb->shrinker->count_objects = super_cache_count;
> 	sb->shrinker->scan_objects = super_cache_scan;
> 	sb->shrinker->batch = 1024;
> 	sb->shrinker->private = sb;
> 
> 	.....
> 
> 	shrinker_register(sb->shrinker);
> 
> And teardown is just a call to shrinker_unregister(sb->shrinker)
> as it is now.
> 
> i.e. the entire shrinker regsitration API is now just three
> functions, down from the current four, and much simpler than the
> the seven functions this patch set results in...
> 
> The other advantage of this is that it will break all the existing
> out of tree code and third party modules using the old API and will
> no longer work with a kernel using lockless slab shrinkers. They
> need to break (both at the source and binary levels) to stop bad
> things from happening due to using uncoverted shrinkers in the new
> setup.

Got it. And totally agree.

I will do it in the v2.

Thanks,
Qi

> 
> -Dave.
