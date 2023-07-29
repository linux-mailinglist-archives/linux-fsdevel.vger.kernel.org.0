Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3287767D4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 10:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjG2IsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjG2IsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:48:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF08F44A2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 01:48:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-682ae5d4184so685357b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690620488; x=1691225288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbdgPGpGzwv3Ba9ss/qbC8w4dcIJ6EfJ8tT9+ztVBsQ=;
        b=DZFLwwmJndUW6zfnORbYzoucbeb9saaQKrl/QBur5VgS6P58gRgdpp8MYduMN550+T
         ThpBMQd+wqwbcBoSGmvKI7V9Ma4LCpYLWFunl5NiegFEHJNTQE3HPx1j7Fgc5gNqx8Iq
         YHUiWta6/cfbGMyg9gyEl8Eynz728/mHaw1lMQy+t/GfUp9Wqb7L9kJmHKg93SZhln4L
         nQEOOjCm3XtItdkVREm8m6+qA283u73jSwvq4ou9Fha1ZKE4dHZmspSiYw7ywEJDGstN
         q98qzRnKmdM4q9DzoCiLAmxpMakkQvrAM25zQsh718wYNXYSnABRZn4Jdwg4vno9Osq9
         PVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690620488; x=1691225288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbdgPGpGzwv3Ba9ss/qbC8w4dcIJ6EfJ8tT9+ztVBsQ=;
        b=k2e8ipgjP/yqDLBXhGv0bEH0RbLs2yZvA2EJFVUjXCRQVp4NPRU/54DsCTESMPZHAO
         eQCbhFOaE6y6y8Pf6r5/nPjNpIsGLSfhPoSmmUf1fAgmhU7O58zw6CLE08nAf3lltUWD
         WnwzpmUBIeHxXIOkwynUpc84Nlp4Jw3VA6put3OKTakguBI3prwEOZAH3JcAMVFPGJTG
         /SFTvMztohwYEIujSJI909gJR8sPOSzDezA19kC18BpNpPc8UZX4P9eudAxvS5tPeMmR
         q58Q/S6A8k6q/S4c/oiZjUMJwe9LDUTIoihY1iNVRkUhFaaDyLW5ljzdwYgOmb0umXRI
         Z9oQ==
X-Gm-Message-State: ABy/qLaWSCxSHOVbyOb/oKCTmvqbp0MyGKmzAlQHqMQpxhSpVGG6lsEp
        zJVJLYnhBeNRovfUf/axl2+5sw==
X-Google-Smtp-Source: APBJJlGU4WvDtIE3roPXfr2RIP3jnPqKjXBKgd99me7vK4BYh3P3V9BBkMbm8JQkpcQK7ib8McexOg==
X-Received: by 2002:a05:6a00:32c8:b0:67f:7403:1fe8 with SMTP id cl8-20020a056a0032c800b0067f74031fe8mr1763906pfb.3.1690620488142;
        Sat, 29 Jul 2023 01:48:08 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c25:884:3ed:e1db:b610? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b00687087d8bc3sm2935245pfh.141.2023.07.29.01.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 01:48:07 -0700 (PDT)
Message-ID: <5e50711c-a616-f95f-d6d2-c69627ac3cf0@bytedance.com>
Date:   Sat, 29 Jul 2023 16:47:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 05/49] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-6-zhengqi.arch@bytedance.com>
 <ZMOx0y+wdHEATDho@corigine.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZMOx0y+wdHEATDho@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Simon,

On 2023/7/28 20:17, Simon Horman wrote:
> On Thu, Jul 27, 2023 at 04:04:18PM +0800, Qi Zheng wrote:
>> Currently, the shrinker instances can be divided into the following three
>> types:
>>
>> a) global shrinker instance statically defined in the kernel, such as
>>     workingset_shadow_shrinker.
>>
>> b) global shrinker instance statically defined in the kernel modules, such
>>     as mmu_shrinker in x86.
>>
>> c) shrinker instance embedded in other structures.
>>
>> For case a, the memory of shrinker instance is never freed. For case b,
>> the memory of shrinker instance will be freed after synchronize_rcu() when
>> the module is unloaded. For case c, the memory of shrinker instance will
>> be freed along with the structure it is embedded in.
>>
>> In preparation for implementing lockless slab shrink, we need to
>> dynamically allocate those shrinker instances in case c, then the memory
>> can be dynamically freed alone by calling kfree_rcu().
>>
>> So this commit adds the following new APIs for dynamically allocating
>> shrinker, and add a private_data field to struct shrinker to record and
>> get the original embedded structure.
>>
>> 1. shrinker_alloc()
>>
>> Used to allocate shrinker instance itself and related memory, it will
>> return a pointer to the shrinker instance on success and NULL on failure.
>>
>> 2. shrinker_register()
>>
>> Used to register the shrinker instance, which is same as the current
>> register_shrinker_prepared().
>>
>> 3. shrinker_free()
>>
>> Used to unregister (if needed) and free the shrinker instance.
>>
>> In order to simplify shrinker-related APIs and make shrinker more
>> independent of other kernel mechanisms, subsequent submissions will use
>> the above API to convert all shrinkers (including case a and b) to
>> dynamically allocated, and then remove all existing APIs.
>>
>> This will also have another advantage mentioned by Dave Chinner:
>>
>> ```
>> The other advantage of this is that it will break all the existing
>> out of tree code and third party modules using the old API and will
>> no longer work with a kernel using lockless slab shrinkers. They
>> need to break (both at the source and binary levels) to stop bad
>> things from happening due to using uncoverted shrinkers in the new
> 
> nit: uncoverted -> unconverted

Thanks. Will fix.

> 
>> setup.
>> ```
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> ...
> 
>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>> index f1becfd45853..506257585408 100644
>> --- a/mm/shrinker_debug.c
>> +++ b/mm/shrinker_debug.c
>> @@ -191,6 +191,20 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>>   	return 0;
>>   }
>>   
>> +int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const char *fmt,
>> +				va_list ap)
>> +{
>> +	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>> +
>> +	return shrinker->name ? 0 : -ENOMEM;
>> +}
>> +
>> +void shrinker_debugfs_name_free(struct shrinker *shrinker)
>> +{
>> +	kfree_const(shrinker->name);
>> +	shrinker->name = NULL;
>> +}
>> +
> 
> These functions have no prototype in this file,
> perhaps internal.h should be included?

The compiler can find these implementations, so I don't think there
is a need to include internal.h here?

Thanks,
Qi

> 
>>   int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>>   {
>>   	struct dentry *entry;
> 
> ...
