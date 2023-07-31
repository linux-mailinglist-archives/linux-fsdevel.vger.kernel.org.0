Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2350769660
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjGaMdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjGaMcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:32:50 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC3A1B3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:32:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34913c049c4so8215835ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690806768; x=1691411568;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M82ZdWiowDuFGINOioxht4VyUsVaoAlVTe7iYwfL+EY=;
        b=jzUbqYItuP9YFcB/tb2GFTKwveIsFjgvgxT2X14M7kdofmVGaSkN/Kgech4ITWRdYm
         hvCkCAVFZwvUUSNlbIjm2QyFxXJES2guD/oDfWsZGqOxcxuYs5/wC0Vx6ZgRdFQ+pIT4
         YAimzTigd7Ic9pmG28jLiKXfDVVdduoEZ8PkrTL77rcIjOP+80lW+jNBmF9FtBymy8Pf
         VdpQUO3iOvXgUzM4CcKgh43qQ2S613H5cT2gwYAoHza3Tt9f21SzoZr6glkM9m/LDqZl
         d51Y7Skn8D34TSlc4TbvfSPhEoYXyKly6H7CfFBd9v/OqwsJUwsJFX2xjNF+ANuLLjG/
         YUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806768; x=1691411568;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M82ZdWiowDuFGINOioxht4VyUsVaoAlVTe7iYwfL+EY=;
        b=Fsuu1WEA8FUQy5rnK6d2K2kNgFCvEa7hfsxix65FKNh9hd6VIu9p06H/qBlYs18Ze2
         Jgvn0fWOjX25fSUinUU7bU1SOZ2QsHeByBmoV8tP57RxNfGzwBkmoS0h++8ieq7BgvXZ
         /N/Cu7/YytIpoIGJ8+sa2uLNeuFRxkjAkqvavj1dzUNx3Yj2dCsgkhtHBK4G48feP1yK
         Vt7q+uYA2g3JHaJAqBr4ZHe4oNDPHby4hQWJzBvC3orLGj/dC4hbRwwd3YtdhkOSH6N2
         KrWiRLf6rU/7ULSXUtI8v0fjQ3xaSQCuf99dnfLuBHufoNmYvXLSy+XewVCJ+WG8N7hV
         2XRg==
X-Gm-Message-State: ABy/qLbBgxX9THruBfE++Q1k6SRgIbcnO1LKR3wUYHSggkvrun5p497V
        u/ZOu0meq0F3Vvu5wfJMkk6Opw==
X-Google-Smtp-Source: APBJJlGwNo86te08ep7jpQMQqoMESzoPDWpWBxvTZh6sPoZa7hVi8pEFmx+2RZS4UZzgQFprT3Mfhg==
X-Received: by 2002:a05:6e02:12ad:b0:348:cfad:1608 with SMTP id f13-20020a056e0212ad00b00348cfad1608mr7556440ilr.5.1690806767771;
        Mon, 31 Jul 2023 05:32:47 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gj2-20020a17090b108200b00267fff8e024sm7773341pjb.30.2023.07.31.05.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:32:47 -0700 (PDT)
Message-ID: <248b946a-f42f-6b59-147c-c7dbbe03ef0d@bytedance.com>
Date:   Mon, 31 Jul 2023 20:32:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH 05/11] maple_tree: Add test for mt_dup()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-6-zhangpeng.00@bytedance.com>
 <20230726160607.eoobd4dyvryfb25a@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, avagin@gmail.com, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        michael.christie@oracle.com, surenb@google.com, brauner@kernel.org,
        willy@infradead.org, corbet@lwn.net, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230726160607.eoobd4dyvryfb25a@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/7/27 00:06, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>> Add test for mt_dup().
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   tools/testing/radix-tree/maple.c | 202 +++++++++++++++++++++++++++++++
>>   1 file changed, 202 insertions(+)
>>
>> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>> index e5da1cad70ba..3052e899e5df 100644
>> --- a/tools/testing/radix-tree/maple.c
>> +++ b/tools/testing/radix-tree/maple.c
>> @@ -35857,6 +35857,204 @@ static noinline void __init check_locky(struct maple_tree *mt)
>>   	mt_clear_in_rcu(mt);
>>   }
>>   
>> +/*
>> + * Compare two nodes and return 0 if they are the same, non-zero otherwise.
>> + */
>> +static int __init compare_node(struct maple_enode *enode_a,
>> +			       struct maple_enode *enode_b)
>> +{
>> +	struct maple_node *node_a, *node_b;
>> +	struct maple_node a, b;
>> +	void **slots_a, **slots_b; /* Do not use the rcu tag. */
>> +	enum maple_type type;
>> +	int i;
>> +
>> +	if (((unsigned long)enode_a & MAPLE_NODE_MASK) !=
>> +	    ((unsigned long)enode_b & MAPLE_NODE_MASK)) {
>> +		pr_err("The lower 8 bits of enode are different.\n");
>> +		return -1;
>> +	}
>> +
>> +	type = mte_node_type(enode_a);
>> +	node_a = mte_to_node(enode_a);
>> +	node_b = mte_to_node(enode_b);
>> +	a = *node_a;
>> +	b = *node_b;
>> +
>> +	/* Do not compare addresses. */
>> +	if (ma_is_root(node_a) || ma_is_root(node_b)) {
>> +		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
>> +						  MA_ROOT_PARENT);
>> +		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
>> +						  MA_ROOT_PARENT);
>> +	} else {
>> +		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
>> +						  MAPLE_NODE_MASK);
>> +		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
>> +						  MAPLE_NODE_MASK);
>> +	}
>> +
>> +	if (a.parent != b.parent) {
>> +		pr_err("The lower 8 bits of parents are different. %p %p\n",
>> +			a.parent, b.parent);
>> +		return -1;
>> +	}
>> +
>> +	/*
>> +	 * If it is a leaf node, the slots do not contain the node address, and
>> +	 * no special processing of slots is required.
>> +	 */
>> +	if (ma_is_leaf(type))
>> +		goto cmp;
>> +
>> +	slots_a = ma_slots(&a, type);
>> +	slots_b = ma_slots(&b, type);
>> +
>> +	for (i = 0; i < mt_slots[type]; i++) {
>> +		if (!slots_a[i] && !slots_b[i])
>> +			break;
>> +
>> +		if (!slots_a[i] || !slots_b[i]) {
>> +			pr_err("The number of slots is different.\n");
>> +			return -1;
>> +		}
>> +
>> +		/* Do not compare addresses in slots. */
>> +		((unsigned long *)slots_a)[i] &= MAPLE_NODE_MASK;
>> +		((unsigned long *)slots_b)[i] &= MAPLE_NODE_MASK;
>> +	}
>> +
>> +cmp:
>> +	/*
>> +	 * Compare all contents of two nodes, including parent (except address),
>> +	 * slots (except address), pivots, gaps and metadata.
>> +	 */
>> +	return memcmp(&a, &b, sizeof(struct maple_node));
>> +}
>> +
>> +/*
>> + * Compare two trees and return 0 if they are the same, non-zero otherwise.
>> + */
>> +static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
>> +{
>> +	MA_STATE(mas_a, mt_a, 0, 0);
>> +	MA_STATE(mas_b, mt_b, 0, 0);
>> +
>> +	if (mt_a->ma_flags != mt_b->ma_flags) {
>> +		pr_err("The flags of the two trees are different.\n");
>> +		return -1;
>> +	}
>> +
>> +	mas_dfs_preorder(&mas_a);
>> +	mas_dfs_preorder(&mas_b);
>> +
>> +	if (mas_is_ptr(&mas_a) || mas_is_ptr(&mas_b)) {
>> +		if (!(mas_is_ptr(&mas_a) && mas_is_ptr(&mas_b))) {
>> +			pr_err("One is MAS_ROOT and the other is not.\n");
>> +			return -1;
>> +		}
>> +		return 0;
>> +	}
>> +
>> +	while (!mas_is_none(&mas_a) || !mas_is_none(&mas_b)) {
>> +
>> +		if (mas_is_none(&mas_a) || mas_is_none(&mas_b)) {
>> +			pr_err("One is MAS_NONE and the other is not.\n");
>> +			return -1;
>> +		}
>> +
>> +		if (mas_a.min != mas_b.min ||
>> +		    mas_a.max != mas_b.max) {
>> +			pr_err("mas->min, mas->max do not match.\n");
>> +			return -1;
>> +		}
>> +
>> +		if (compare_node(mas_a.node, mas_b.node)) {
>> +			pr_err("The contents of nodes %p and %p are different.\n",
>> +			       mas_a.node, mas_b.node);
>> +			mt_dump(mt_a, mt_dump_dec);
>> +			mt_dump(mt_b, mt_dump_dec);
>> +			return -1;
>> +		}
>> +
>> +		mas_dfs_preorder(&mas_a);
>> +		mas_dfs_preorder(&mas_b);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static noinline void __init check_mt_dup(struct maple_tree *mt)
>> +{
>> +	DEFINE_MTREE(new);
>> +	int i, j, ret, count = 0;
>> +
>> +	/* stored in the root pointer*/
>> +	mt_init_flags(&tree, 0);
>> +	mtree_store_range(&tree, 0, 0, xa_mk_value(0), GFP_KERNEL);
>> +	mt_dup(&tree, &new, GFP_KERNEL);
>> +	mt_validate(&new);
>> +	if (compare_tree(&tree, &new))
>> +		MT_BUG_ON(&new, 1);
>> +
>> +	mtree_destroy(&tree);
>> +	mtree_destroy(&new);
>> +
>> +	for (i = 0; i < 1000; i += 3) {
>> +		if (i & 1)
>> +			mt_init_flags(&tree, 0);
>> +		else
>> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>> +
>> +		for (j = 0; j < i; j++) {
>> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
>> +					  xa_mk_value(j), GFP_KERNEL);
>> +		}
> 
> Storing in this way is probably not checking a full tree.  I think it's
> important to check the full tree/full nodes since you have changes to
> detect the metadata.
I probably won't change the way I check metadata. But is there a way to
construct a full tree? All I can think of is to write new code to
construct a full tree.
> 
>> +
>> +		ret = mt_dup(&tree, &new, GFP_KERNEL);
>> +		MT_BUG_ON(&new, ret != 0);
>> +		mt_validate(&new);
>> +		if (compare_tree(&tree, &new))
>> +			MT_BUG_ON(&new, 1);
>> +
>> +		mtree_destroy(&tree);
>> +		mtree_destroy(&new);
>> +	}
>> +
>> +	/* Test memory allocation failed. */
>> +	for (i = 0; i < 1000; i += 3) {
>> +		if (i & 1)
>> +			mt_init_flags(&tree, 0);
>> +		else
>> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>> +
>> +		for (j = 0; j < i; j++) {
>> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
>> +					  xa_mk_value(j), GFP_KERNEL);
>> +		}
>> +
>> +		mt_set_non_kernel(50);
> 
> It may be worth while allowing more/less than 50 allocations.
Actually I have used other values before. I haven't thought of a good
value yet, probably a random number in a suitable range would be nice
too.

> 
>> +		ret = mt_dup(&tree, &new, GFP_NOWAIT);
>> +		mt_set_non_kernel(0);
>> +		if (ret != 0) {
>> +			MT_BUG_ON(&new, ret != -ENOMEM);
>> +			count++;
>> +			mtree_destroy(&tree);
>> +			continue;
>> +		}
>> +
>> +		mt_validate(&new);
>> +		if (compare_tree(&tree, &new))
>> +			MT_BUG_ON(&new, 1);
>> +
>> +		mtree_destroy(&tree);
>> +		mtree_destroy(&new);
>> +	}
>> +
>> +	/* pr_info("mt_dup() fail %d times\n", count); */
>> +	BUG_ON(!count);
>> +}
>> +
>>   extern void test_kmem_cache_bulk(void);
>>   
>>   void farmer_tests(void)
>> @@ -35904,6 +36102,10 @@ void farmer_tests(void)
>>   	check_null_expand(&tree);
>>   	mtree_destroy(&tree);
>>   
>> +	mt_init_flags(&tree, 0);
>> +	check_mt_dup(&tree);
>> +	mtree_destroy(&tree);
>> +
>>   	/* RCU testing */
>>   	mt_init_flags(&tree, 0);
>>   	check_erase_testset(&tree);
>> -- 
>> 2.20.1
>>
>>
