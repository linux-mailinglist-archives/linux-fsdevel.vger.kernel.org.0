Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F97631C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 11:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjGZJYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjGZJXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:23:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CD42D5D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 02:21:04 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77dcff76e35so80533339f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690363264; x=1690968064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Vnbbe8QuBX5IRYOyrvoqHk8WWyxAnIOQvNq7rt3Y5Y=;
        b=kMv6YWq3e1+EWrbASVGI+G088ii73Fem/3I6VWvBzdurPzbdbS5fA2RHQQMLz4AOt4
         QngIWAV+s2uZUHK0vckMw0bfgtFV0R5eMbZlIk8/4w/wEVCJ5y5HwXF0DUiZjpzQho8t
         GXjQcaARWKdDQm6TOuzP1j52qtjLaAhVczvWaaLuobF1qPY5atrskgUIXJQL3lYTey8z
         3gvyQ55zN42zfh91LApyOvBpv3V6BxPnFobMIvKLNhs41DtS3MI2Zhwie6ylRR2RxuF8
         50dWB5Tz79PFVi03oGgeTfo0ercw9F6h7q/ECB9SYkDgRGeW/OcVP5UyZnJ2fh3Kr582
         LeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363264; x=1690968064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Vnbbe8QuBX5IRYOyrvoqHk8WWyxAnIOQvNq7rt3Y5Y=;
        b=XSHJ0h4Q4CN4sFTplyGZf3n5hNQ+5S73DGVww51wCiNUlC/xkxNojd/ooQNYN1qJ6g
         D9JHMY9Z88pQX150bSNtAMIkeu1hHxc+lh1PnGb38eLzROLaQn75djCQuBvCOU9u15iz
         8yX5c35j0/Z7Nd0BerBIW1odaJaQAxGHiuNs33LZjmwqb2cfCgQ8Pp4rCrJuuRkWdYgL
         u0wbY/CnLHR2nc7Onk+xyalZvrr7fSZAEOtcVdB611Rry3LSdHWbiuwJh+33LtD9dwO0
         tyNjVJywg5UoMC5jXtdFOHihi6vMr6DrYQA3Up+uOLUbhA1TvsKSlnCHbJ0XdtPsewVu
         Basg==
X-Gm-Message-State: ABy/qLbkOKfvmVPM9WEZ1YhaTmO1kjTXMTEbr7Dgmh/zfKhUfouOYGWP
        bvBgt4D9tYoyOKOsiwMb/Yau0w==
X-Google-Smtp-Source: APBJJlFD+0JL20cmcfz8xSZcxHSPSuKA9am5rBHzXLXGZAWVolxxOeef+bBAtrNC9deWoQ1MX3gUWg==
X-Received: by 2002:a6b:3b44:0:b0:787:1926:54ed with SMTP id i65-20020a6b3b44000000b00787192654edmr1450699ioa.1.1690363264233;
        Wed, 26 Jul 2023 02:21:04 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j1-20020a63b601000000b005638a70110bsm9005279pgf.65.2023.07.26.02.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:21:03 -0700 (PDT)
Message-ID: <0caf10e8-e54b-3c1b-7df5-d95adc757ba7@bytedance.com>
Date:   Wed, 26 Jul 2023 17:20:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/47] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-4-zhengqi.arch@bytedance.com>
 <ZMDKjBCZH6+OP5gW@dread.disaster.area>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZMDKjBCZH6+OP5gW@dread.disaster.area>
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

On 2023/7/26 15:26, Dave Chinner wrote:
> On Mon, Jul 24, 2023 at 05:43:10PM +0800, Qi Zheng wrote:
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
>> 2. shrinker_free_non_registered()
>>
>> Used to destroy the non-registered shrinker instance.
> 
> This is a bit nasty
> 
>>
>> 3. shrinker_register()
>>
>> Used to register the shrinker instance, which is same as the current
>> register_shrinker_prepared().
>>
>> 4. shrinker_unregister()
> 
> rename this "shrinker_free()" and key the two different freeing
> cases on the SHRINKER_REGISTERED bit rather than mostly duplicating
> the two.

OK, will do in the next version.

> 
> void shrinker_free(struct shrinker *shrinker)
> {
> 	struct dentry *debugfs_entry = NULL;
> 	int debugfs_id;
> 
> 	if (!shrinker)
> 		return;
> 
> 	down_write(&shrinker_rwsem);
> 	if (shrinker->flags & SHRINKER_REGISTERED) {
> 		list_del(&shrinker->list);
> 		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
> 	} else if (IS_ENABLED(CONFIG_SHRINKER_DEBUG)) {
> 		kfree_const(shrinker->name);
> 	}
> 
> 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> 		unregister_memcg_shrinker(shrinker);
> 	up_write(&shrinker_rwsem);
> 
> 	if (debugfs_entry)
> 		shrinker_debugfs_remove(debugfs_entry, debugfs_id);
> 
> 	kfree(shrinker->nr_deferred);
> 	kfree(shrinker);
> }
> EXPORT_SYMBOL_GPL(shrinker_free);

Ah, I will change all new APIs to use EXPORT_SYMBOL_GPL().

Thanks,
Qi

> 
