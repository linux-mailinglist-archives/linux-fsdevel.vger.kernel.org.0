Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA77980A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 04:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbjIHCqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 22:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjIHCqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:46:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA61BE2
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 19:45:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so1416944b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694141156; x=1694745956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h7VfuU4Oy/BBgAD3W63aRNBjYZvFElCK9G+YIFUMro=;
        b=DlEwLOspdKXitmVgPP5k0/K4ooJ3MyQHIs7lhOhjcTE+E42DkhFzKmvNxk0Gu5N01O
         r421176bwKsCgtKGE945YI2yBzo8UbI05piy5UdjwFZ6YyWf2gBrzh09H1gGWdXD0lIj
         CSU/h2voAqbUzT1BPeMkWqr1QP/mvAII3wJ3sz3FQQrFA90uJbVcNlfyNTFiAePZqvkD
         LClU3+jFDoWcxxRzpAzjfJ5iKXSqd9VLpHlfyWkzeCaDJQPqOIHHYIN9nRNqqpTmXOh/
         ZLlpA9y9wgbV+HnMF05/aWnljsNlncJ/S9mgUHWJbr9A/6mI2tSCKjAzFicFy7PR4zZd
         wnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694141156; x=1694745956;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9h7VfuU4Oy/BBgAD3W63aRNBjYZvFElCK9G+YIFUMro=;
        b=ut6O81SGDTnYpDOugnNBKhbknl3CFsEUPkeV58IU6DOHGJ7gkFk3Y9E3N5rQKRfJOj
         n6MXRg5RS1xcAVd5Ib/va6kU+/KfZETLFagn9IygjADFnm7rIt7Z+Bn5+hEsNfNy1BcF
         L86vAl7wJiUtmhGv0QGJHCSqoWNLG5AlvDBR7MVXYdUkThkoy+5NHZB5OY3aYyRqEAeh
         l1740gqK2iAUaJ8vyCm4NqrZztyLS1byO7bxaKX9dRvvNr3XYzPZceu0mqu3zlj/z866
         9qaJ4A0SuELv6/OGXXXYy+uUiIzOtyzr85DXXrBGxtXQndrujp4tLYovQyCys0UcknwP
         q0Kg==
X-Gm-Message-State: AOJu0YwS9HsyTU8/8TpB+/yHwP6DguKowl0/Um4bkm7y/ClZz+yTyx5z
        V7Pm5agblHatw7rNIRpFEMDl5w==
X-Google-Smtp-Source: AGHT+IFQnqvdNGpryMKcZ/mzsBNIkInaLkAduE8sTSSLhlfJiuy33tUzTGUUvwepdzpMVoAqKZwRRA==
X-Received: by 2002:a05:6a00:248d:b0:68e:290b:bb57 with SMTP id c13-20020a056a00248d00b0068e290bbb57mr1309970pfv.18.1694141156556;
        Thu, 07 Sep 2023 19:45:56 -0700 (PDT)
Received: from [10.254.232.87] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b00666e649ca46sm357491pfn.101.2023.09.07.19.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 19:45:56 -0700 (PDT)
Message-ID: <3ebd7fab-ba27-9abd-b06f-b16fa567ebbc@bytedance.com>
Date:   Fri, 8 Sep 2023 10:45:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/6] maple_tree: Add two helpers
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-2-zhangpeng.00@bytedance.com>
 <20230907201314.g4scadi3tk5ctrd2@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230907201314.g4scadi3tk5ctrd2@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/9/8 04:13, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:57]:
>> Add two helpers, which will be used later.
> 
> Can you please change the subject to something like:
> Add mt_free_one() and mt_attr() helpers
> 
> for easier git log readability?
OK, I'll do that.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index ee1ff0c59fd7..ef234cf02e3e 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -165,6 +165,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>>   	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>>   }
>>   
>> +static inline void mt_free_one(struct maple_node *node)
>> +{
>> +	kmem_cache_free(maple_node_cache, node);
>> +}
>> +
>>   static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>>   {
>>   	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
>> @@ -205,6 +210,11 @@ static unsigned int mas_mt_height(struct ma_state *mas)
>>   	return mt_height(mas->tree);
>>   }
>>   
>> +static inline unsigned int mt_attr(struct maple_tree *mt)
>> +{
>> +	return mt->ma_flags & ~MT_FLAGS_HEIGHT_MASK;
>> +}
>> +
>>   static inline enum maple_type mte_node_type(const struct maple_enode *entry)
>>   {
>>   	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
>> @@ -5520,7 +5530,7 @@ void mas_destroy(struct ma_state *mas)
>>   			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
>>   			total -= count;
>>   		}
>> -		kmem_cache_free(maple_node_cache, node);
>> +		mt_free_one(ma_mnode_ptr(node));
>>   		total--;
>>   	}
>>   
>> -- 
>> 2.20.1
>>
