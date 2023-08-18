Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CBA7808D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 11:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359343AbjHRJkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359490AbjHRJka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:40:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2B26A5
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 02:40:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565e54cb93aso486451a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692351605; x=1692956405;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wdQzST43/YR9G4a+4189fYlBvDwxb+VSYYfxMLNAKQ=;
        b=SOWjBTjalNORHHZKvzGHsM3e0FrM/OqDNxtFK/uL+5nzyqhsD6NLaufr46k4Y8QxIQ
         zgK1jghWZBqZAIRyB5J3byn68BKAsvF7YaHHX8tOhVyu+hdemHkxaChLroYdldZp/YS2
         DcmB/R7dnzLOjNH6fy3dFipxatNmM/4i1YG3lcIQTGJFYI+PUAi2T3yjKJVMIFo3XukF
         nqKyYmF6D8w6Ou0cNkW8MEa6l6XSlStkCd2ZBORIdndSHFz77BpMHD0OV3b6FmFR8rqG
         l2YmqJGp9+OCrGY5qpxOdec04Q1h6we9OYwSfIJK8uS5rpnFXb/2w5XnJlR4CLX4Mdmu
         tDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351605; x=1692956405;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4wdQzST43/YR9G4a+4189fYlBvDwxb+VSYYfxMLNAKQ=;
        b=fdjUk18Mv45h15x57MdY9vXUq7PdwR9jtPCEkbZ1IhpMC00bT665syPTfi/GIuYWRb
         yLx48j/+fCnRAzVFkjntXZFKlmig++2wbxBUH1LYcBT/YsZqnp46Rrrn4YMr8Qsf59Ry
         RdtI7U7gVm/xm06OSRCak4kQ8ikUF+zBWyNHZgrk12GtLvYlG6hS5dhiAi7dKNZLrk/w
         62p2LfBgNuy6Ah/PxcLvhH4yzjnCHH/bDBy/qOZMbFnJApUqXQwbUDvPqXun8eAtPIQ3
         kErBXBI0KB21QMPvNncICm0ohwNF0dS4pmDMjVBLH/801XmTZsMAh3g4wx+nZF/QN2om
         HR5A==
X-Gm-Message-State: AOJu0YwEqyjwzxp5mt8YHQmUnsr7XHylQds9XQC2Mi4TT+sC/ceefkoQ
        uulnhFsz3y70z26x0c8Up4u3Hg==
X-Google-Smtp-Source: AGHT+IEEgnW6TEQSEWSujD0tsFa+B/Q9tAV7ezMC0E7moN24gpezliNgu9s2GVwQQGX0a8dFdnkB5Q==
X-Received: by 2002:a05:6a20:9384:b0:12f:dce2:b385 with SMTP id x4-20020a056a20938400b0012fdce2b385mr2823148pzh.10.1692351604800;
        Fri, 18 Aug 2023 02:40:04 -0700 (PDT)
Received: from [10.254.252.111] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7910b000000b0067acbc74977sm1169971pfh.96.2023.08.18.02.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:40:04 -0700 (PDT)
Message-ID: <51cc7e0c-2fb3-1c40-4cd2-bad15737d616@bytedance.com>
Date:   Fri, 18 Aug 2023 17:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 06/11] maple_tree: Introduce mas_replace_entry() to
 directly replace an entry
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, avagin@gmail.com,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-7-zhangpeng.00@bytedance.com>
 <20230726160843.hpl4razxiikqbuxy@revolver>
 <20aab1af-c183-db94-90d7-5e5425e3fd80@bytedance.com>
 <20230731164854.vbndc2z2mqpw53in@revolver>
 <6babc4c1-0f0f-f0b1-1d45-311448af8d70@bytedance.com>
 <20230816174017.4imcdnktvyoqcxw6@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230816174017.4imcdnktvyoqcxw6@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/8/17 01:40, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230816 09:11]:
>>
>>
>> 在 2023/8/1 00:48, Liam R. Howlett 写道:
>>> * Peng Zhang <zhangpeng.00@bytedance.com> [230731 08:39]:
>>>>
>>>>
>>>> 在 2023/7/27 00:08, Liam R. Howlett 写道:
>>>>> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>>>>>> If mas has located a specific entry, it may be need to replace this
>>>>>> entry, so introduce mas_replace_entry() to do this. mas_replace_entry()
>>>>>> will be more efficient than mas_store*() because it doesn't do many
>>>>>> unnecessary checks.
>>>>>>
>>>>>> This function should be inline, but more functions need to be moved to
>>>>>> the header file, so I didn't do it for the time being.
>>>>>
>>>>> I am really nervous having no checks here.  I get that this could be
>>>>> used for duplicating the tree more efficiently, but having a function
>>>>> that just swaps a value in is very dangerous - especially since it is
>>>>> decoupled from the tree duplication code.
>>>> I've thought about this, and I feel like this is something the user
>>>> should be guaranteed. If the user is not sure whether to use it,
>>>> mas_store() can be used instead.
>>>
>>> Documentation often isn't up to date and even more rarely read.
>>> mas_replace_entry() does not give a hint of a requirement for a specific
>>> state to the mas.  This is not acceptable.
>>>
>>> The description of the function also doesn't say anything about a
>>> requirement of the maple state, just that it replaces an already
>>> existing entry.  You have to read the notes to find out that 'mas must
>>> already locate an existing entry'.
>>>
>>>> And we should provide this interface
>>>> because it has better performance.
>>>
>>> How much better is the performance?  There's always a trade off but
>>> without numbers, this is hard to justify.
>> I have implemented a new version of this pachset, and I will post it
>> soon.
>>
>> I tested the benefits of mas_replace_entry() in userspace.
>> The test code is attached at the end.
>>
>> Run three times:
>> mas_replace_entry(): 2.7613050s 2.7120030s 2.7274200s
>> mas_store():         3.8451260s 3.8113200s 3.9334160s
> 
> This runtime is too short, we should increase the number of elements or
> loops until it is over 10 seconds.  This will make the setup time
> and other variances less significant and we can use the command run time
> as a rough estimate of performance. IIRC 134 was picked for a rough
> estimate of an average task size so maybe increase the loops.
I changed nr_entries to 1000, and the measured numbers are as follows:
mas_replace_entry():	20.0375820s
mas_store():		28.6175720s
It can be seen that mas_store() is still nearly 40% slower.
> 
> I understand the numbers here are from clock recordings to demonstrate
> the significance of your change.
> 
>>
>> Using mas_store() reduces the performance of duplicating VMAs by about
>> 41%.
>>
>> So I think mas_replace_entry() is necessary. We can describe it in more
>> detail in the documentation to prevent users from misusing it.
> 
> I think something is necessary for a quicker replacement, yes.  I don't
> want to go as far as you did with the lack of checking.
> 
>>
>>
>> static noinline void __init bench_forking(struct maple_tree *mt)
>> {
>> 	struct maple_tree newmt;
>> 	int i, nr_entries = 134, nr_fork = 80000, ret;
>> 	void *val;
>> 	MA_STATE(mas, mt, 0, 0);
>> 	MA_STATE(newmas, &newmt, 0, 0);
>> 	clock_t start;
>> 	clock_t end;
>> 	double cpu_time_used = 0;
>>
>> 	for (i = 0; i <= nr_entries; i++)
>> 		mtree_store_range(mt, i*10, i*10 + 5,
>> 				  xa_mk_value(i), GFP_KERNEL);
>>
>> 	for (i = 0; i < nr_fork; i++) {
>> 		mt_set_non_kernel(99999);
>>
>> 		start = clock();
>> 		mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
>> 		mas_lock(&newmas);
>> 		mas_lock(&mas);
>> 		ret = __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
>> 		if (ret) {
>> 			pr_err("OOM!");
>> 			BUG_ON(1);
>> 		}
>>
>> 		mas_set(&newmas, 0);
>> 		mas_for_each(&newmas, val, ULONG_MAX) {
>> 			mas_replace_entry(&newmas, val);
>> 		}
>>
>> 		mas_unlock(&mas);
>> 		mas_unlock(&newmas);
>> 		end = clock();
>> 		cpu_time_used += ((double) (end - start));
>>
>> 		mas_destroy(&newmas);
>> 		mt_validate(&newmt);
>> 		mt_set_non_kernel(0);
>> 		mtree_destroy(&newmt);
>> 	}
>> 	printf("time consumption:%.7fs\n", cpu_time_used / CLOCKS_PER_SEC);
>> }
>>
>>
>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>>>>> ---
>>>>>>     include/linux/maple_tree.h |  1 +
>>>>>>     lib/maple_tree.c           | 25 +++++++++++++++++++++++++
>>>>>>     2 files changed, 26 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>>>>>> index 229fe78e4c89..a05e9827d761 100644
>>>>>> --- a/include/linux/maple_tree.h
>>>>>> +++ b/include/linux/maple_tree.h
>>>>>> @@ -462,6 +462,7 @@ struct ma_wr_state {
>>>>>>     void *mas_walk(struct ma_state *mas);
>>>>>>     void *mas_store(struct ma_state *mas, void *entry);
>>>>>> +void mas_replace_entry(struct ma_state *mas, void *entry);
>>>>>>     void *mas_erase(struct ma_state *mas);
>>>>>>     int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
>>>>>>     void mas_store_prealloc(struct ma_state *mas, void *entry);
>>>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>>>> index efac6761ae37..d58572666a00 100644
>>>>>> --- a/lib/maple_tree.c
>>>>>> +++ b/lib/maple_tree.c
>>>>>> @@ -5600,6 +5600,31 @@ void *mas_store(struct ma_state *mas, void *entry)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(mas_store);
>>>>>> +/**
>>>>>> + * mas_replace_entry() - Replace an entry that already exists in the maple tree
>>>>>> + * @mas: The maple state
>>>>>> + * @entry: The entry to store
>>>>>> + *
>>>>>> + * Please note that mas must already locate an existing entry, and the new entry
>>>>>> + * must not be NULL. If these two points cannot be guaranteed, please use
>>>>>> + * mas_store*() instead, otherwise it will cause an internal error in the maple
>>>>>> + * tree. This function does not need to allocate memory, so it must succeed.
>>>>>> + */
>>>>>> +void mas_replace_entry(struct ma_state *mas, void *entry)
>>>>>> +{
>>>>>> +	void __rcu **slots;
>>>>>> +
>>>>>> +#ifdef CONFIG_DEBUG_MAPLE_TREE
> 
> CONFIG_DEBUG_MAPLE_TREE is not necessary, MAS_WRAN_ON() will be compiled
> out if it's not set.
> 
>>>>>> +	MAS_WARN_ON(mas, !mte_is_leaf(mas->node));
>>>>>> +	MAS_WARN_ON(mas, !entry);
>>>>>> +	MAS_WARN_ON(mas, mas->offset >= mt_slots[mte_node_type(mas->node)]);
>>>>>> +#endif
>>>>>> +
>>>>>> +	slots = ma_slots(mte_to_node(mas->node), mte_node_type(mas->node));
>>>>>> +	rcu_assign_pointer(slots[mas->offset], entry);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(mas_replace_entry);
>>>>>> +
>>>>>>     /**
>>>>>>      * mas_store_gfp() - Store a value into the tree.
>>>>>>      * @mas: The maple state
>>>>>> -- 
>>>>>> 2.20.1
>>>>>>
