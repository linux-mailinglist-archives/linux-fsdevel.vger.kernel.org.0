Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F27984E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbjIHJiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 05:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjIHJiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:38:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6021B1FCA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 02:38:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54290603887so1460252a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694165892; x=1694770692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQurMd8wafZyGpE7OFXdsS2nMZ3Ok9Nncr0Nhd/YGjQ=;
        b=WfbuyG4cPCs5GhlxwEN0uXDuwd2u+a/4nqxBYitWiSfu94SS9ZoF4m/YLvvVwcccfV
         TYBh67l7tBcqhPt7+82Off4lCMrzxEXWQwgb5W6GRcIhwFe2NQLiSzrRSX8xDfTnkJNI
         GZcVzqwPZpGBxdPMRD/USgTS13G3vWr6m1hOm7aQxvqK5VHYTrUQ+NXELdKT5bxcrXZ2
         zaYxXJnXAo8gbf69ag30wTNsLvxSQbZZ57+ocmzIMN0si431bhGn0itf2F/JnfTzOPwG
         Zc08/pxgvabwOdmODZLYWFKE3PYS9frBlR1jdJHZj6VSC+pNWtK3FXJh7I+HMrBDxI1a
         QW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694165892; x=1694770692;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mQurMd8wafZyGpE7OFXdsS2nMZ3Ok9Nncr0Nhd/YGjQ=;
        b=MpT4Q26oAHBUGaJqgJbFq03vmf7syOtt5ZyVKAiP2Pytki2C3yhUBMCMIGUoGyExR4
         aNqpyluIcHbv7EyZYfpShwE/lwt/BiPx/Yd5tsMLAmZxnAmwIHYxuRAfmrFVxfNL0+0E
         /3ek/ld51qP9at/mqPx4d+vlUd+gNwy3Ei7Z5DZq8F7Ir62iu2eUnE7sFDGrRNLxEwgw
         KkX7npQGj/SysZV91Rh1yBjlL1UojnxFPp95GV2NlnzVoIpiFSUoiTMeTiYyWc/rotR/
         0ALCGSkS8jIevvrDC5kX+N7s7ESOql6N6shnH1woxPJ1bhQq5rhDYLDKuvXJvQL4PYlS
         oaiw==
X-Gm-Message-State: AOJu0YyPb6tktTkpCtftqulLztt87REmXdMHE4WeSpJOBAtjDzdVkLe9
        NGdzck6MBfn6xIDC06ykkaEYKw==
X-Google-Smtp-Source: AGHT+IHB91jf4hnfV9rkW+86RhzzNtiPB4y2Fqq2M5G67tYchUf6VDoRL5TFEYDoIX4qASMsUn4mAw==
X-Received: by 2002:a17:90a:cb93:b0:26b:36dc:2f08 with SMTP id a19-20020a17090acb9300b0026b36dc2f08mr2043363pju.46.1694165891549;
        Fri, 08 Sep 2023 02:38:11 -0700 (PDT)
Received: from [10.254.232.87] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id k92-20020a17090a4ce500b00267d9f4d340sm2892132pjh.44.2023.09.08.02.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 02:38:11 -0700 (PDT)
Message-ID: <8f0f4338-40ec-935c-4687-e6217b7bae3e@bytedance.com>
Date:   Fri, 8 Sep 2023 17:38:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/6] maple_tree: Add test for mtree_dup()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-4-zhangpeng.00@bytedance.com>
 <20230907201353.jv6bojekvamvdzaj@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230907201353.jv6bojekvamvdzaj@revolver>
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
>> Add test for mtree_dup().
> 
> Please add a better description of what tests are included.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   tools/testing/radix-tree/maple.c | 344 +++++++++++++++++++++++++++++++
>>   1 file changed, 344 insertions(+)
>>
>> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>> index e5da1cad70ba..38455916331e 100644
>> --- a/tools/testing/radix-tree/maple.c
>> +++ b/tools/testing/radix-tree/maple.c
> 
> Why not lib/test_maple_tree.c?
Because I used mas_dfs_preorder() in user space, which is implemented in 
maple.c
> 
> If they are included there then they will be built into the test module.
> I try to include any tests that I can in the test module, within reason.
> 
> 
>> @@ -35857,6 +35857,346 @@ static noinline void __init check_locky(struct maple_tree *mt)
>>   	mt_clear_in_rcu(mt);
>>   }
>>   
>> +/*
>> + * Compare two nodes and return 0 if they are the same, non-zero otherwise.
> 
> The slots can be different, right?  That seems worth mentioning here.
> It's also worth mentioning this is destructive.
Ok, I'll mention this.
> 
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
>> +static __init void mas_subtree_max_range(struct ma_state *mas)
>> +{
>> +	unsigned long limit = mas->max;
>> +	MA_STATE(newmas, mas->tree, 0, 0);
>> +	void *entry;
>> +
>> +	mas_for_each(mas, entry, limit) {
>> +		if (mas->last - mas->index >=
>> +		    newmas.last - newmas.index) {
>> +			newmas = *mas;
>> +		}
>> +	}
>> +
>> +	*mas = newmas;
>> +}
>> +
>> +/*
>> + * build_full_tree() - Build a full tree.
>> + * @mt: The tree to build.
>> + * @flags: Use @flags to build the tree.
>> + * @height: The height of the tree to build.
>> + *
>> + * Build a tree with full leaf nodes and internal nodes. Note that the height
>> + * should not exceed 3, otherwise it will take a long time to build.
>> + * Return: zero if the build is successful, non-zero if it fails.
>> + */
>> +static __init int build_full_tree(struct maple_tree *mt, unsigned int flags,
>> +		int height)
>> +{
>> +	MA_STATE(mas, mt, 0, 0);
>> +	unsigned long step;
>> +	int ret = 0, cnt = 1;
>> +	enum maple_type type;
>> +
>> +	mt_init_flags(mt, flags);
>> +	mtree_insert_range(mt, 0, ULONG_MAX, xa_mk_value(5), GFP_KERNEL);
>> +
>> +	mtree_lock(mt);
>> +
>> +	while (1) {
>> +		mas_set(&mas, 0);
>> +		if (mt_height(mt) < height) {
>> +			mas.max = ULONG_MAX;
>> +			goto store;
>> +		}
>> +
>> +		while (1) {
>> +			mas_dfs_preorder(&mas);
>> +			if (mas_is_none(&mas))
>> +				goto unlock;
>> +
>> +			type = mte_node_type(mas.node);
>> +			if (mas_data_end(&mas) + 1 < mt_slots[type]) {
>> +				mas_set(&mas, mas.min);
>> +				goto store;
>> +			}
>> +		}
>> +store:
>> +		mas_subtree_max_range(&mas);
>> +		step = mas.last - mas.index;
>> +		if (step < 1) {
>> +			ret = -1;
>> +			goto unlock;
>> +		}
>> +
>> +		step /= 2;
>> +		mas.last = mas.index + step;
>> +		mas_store_gfp(&mas, xa_mk_value(5),
>> +				GFP_KERNEL);
>> +		++cnt;
>> +	}
>> +unlock:
>> +	mtree_unlock(mt);
>> +
>> +	MT_BUG_ON(mt, mt_height(mt) != height);
>> +	/* pr_info("height:%u number of elements:%d\n", mt_height(mt), cnt); */
>> +	return ret;
>> +}
>> +
>> +static noinline void __init check_mtree_dup(struct maple_tree *mt)
>> +{
>> +	DEFINE_MTREE(new);
>> +	int i, j, ret, count = 0;
>> +	unsigned int rand_seed = 17, rand;
>> +
>> +	/* store a value at [0, 0] */
>> +	mt_init_flags(&tree, 0);
>> +	mtree_store_range(&tree, 0, 0, xa_mk_value(0), GFP_KERNEL);
>> +	ret = mtree_dup(&tree, &new, GFP_KERNEL);
>> +	MT_BUG_ON(&new, ret);
>> +	mt_validate(&new);
>> +	if (compare_tree(&tree, &new))
>> +		MT_BUG_ON(&new, 1);
>> +
>> +	mtree_destroy(&tree);
>> +	mtree_destroy(&new);
>> +
>> +	/* The two trees have different attributes. */
>> +	mt_init_flags(&tree, 0);
>> +	mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
>> +	ret = mtree_dup(&tree, &new, GFP_KERNEL);
>> +	MT_BUG_ON(&new, ret != -EINVAL);
>> +	mtree_destroy(&tree);
>> +	mtree_destroy(&new);
>> +
>> +	/* The new tree is not empty */
>> +	mt_init_flags(&tree, 0);
>> +	mt_init_flags(&new, 0);
>> +	mtree_store(&new, 5, xa_mk_value(5), GFP_KERNEL);
>> +	ret = mtree_dup(&tree, &new, GFP_KERNEL);
>> +	MT_BUG_ON(&new, ret != -EINVAL);
>> +	mtree_destroy(&tree);
>> +	mtree_destroy(&new);
>> +
>> +	/* Test for duplicating full trees. */
>> +	for (i = 1; i <= 3; i++) {
>> +		ret = build_full_tree(&tree, 0, i);
>> +		MT_BUG_ON(&tree, ret);
>> +		mt_init_flags(&new, 0);
>> +
>> +		ret = mtree_dup(&tree, &new, GFP_KERNEL);
>> +		MT_BUG_ON(&new, ret);
>> +		mt_validate(&new);
>> +		if (compare_tree(&tree, &new))
>> +			MT_BUG_ON(&new, 1);
>> +
>> +		mtree_destroy(&tree);
>> +		mtree_destroy(&new);
>> +	}
>> +
>> +	for (i = 1; i <= 3; i++) {
>> +		ret = build_full_tree(&tree, MT_FLAGS_ALLOC_RANGE, i);
>> +		MT_BUG_ON(&tree, ret);
>> +		mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
>> +
>> +		ret = mtree_dup(&tree, &new, GFP_KERNEL);
>> +		MT_BUG_ON(&new, ret);
>> +		mt_validate(&new);
>> +		if (compare_tree(&tree, &new))
>> +			MT_BUG_ON(&new, 1);
>> +
>> +		mtree_destroy(&tree);
>> +		mtree_destroy(&new);
>> +	}
>> +
>> +	/* Test for normal duplicating. */
>> +	for (i = 0; i < 1000; i += 3) {
>> +		if (i & 1) {
>> +			mt_init_flags(&tree, 0);
>> +			mt_init_flags(&new, 0);
>> +		} else {
>> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>> +			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
>> +		}
>> +
>> +		for (j = 0; j < i; j++) {
>> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
>> +					  xa_mk_value(j), GFP_KERNEL);
>> +		}
>> +
>> +		ret = mtree_dup(&tree, &new, GFP_KERNEL);
>> +		MT_BUG_ON(&new, ret);
>> +		mt_validate(&new);
>> +		if (compare_tree(&tree, &new))
>> +			MT_BUG_ON(&new, 1);
>> +
>> +		mtree_destroy(&tree);
>> +		mtree_destroy(&new);
>> +	}
>> +
>> +	/* Test memory allocation failed. */
> 
> It might be worth while having specific allocations fail.  At a leaf
> node, intermediate nodes, first node come to mind.
In fact, the random number has covered the first node. I'll write some
test cases later.
> 
>> +	for (i = 0; i < 1000; i += 3) {
>> +		if (i & 1) {
>> +			mt_init_flags(&tree, 0);
>> +			mt_init_flags(&new, 0);
>> +		} else {
>> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>> +			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
>> +		}
>> +
>> +		for (j = 0; j < i; j++) {
>> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
>> +					  xa_mk_value(j), GFP_KERNEL);
>> +		}
>> +		/*
>> +		 * The rand() library function is not used, so we can generate
>> +		 * the same random numbers on any platform.
>> +		 */
>> +		rand_seed = rand_seed * 1103515245 + 12345;
>> +		rand = rand_seed / 65536 % 128;
>> +		mt_set_non_kernel(rand);
>> +
>> +		ret = mtree_dup(&tree, &new, GFP_NOWAIT);
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
>> +	/* pr_info("mtree_dup() fail %d times\n", count); */
>> +	BUG_ON(!count);
>> +}
>> +
>>   extern void test_kmem_cache_bulk(void);
>>   
>>   void farmer_tests(void)
>> @@ -35904,6 +36244,10 @@ void farmer_tests(void)
>>   	check_null_expand(&tree);
>>   	mtree_destroy(&tree);
>>   
>> +	mt_init_flags(&tree, 0);
>> +	check_mtree_dup(&tree);
>> +	mtree_destroy(&tree);
>> +
>>   	/* RCU testing */
>>   	mt_init_flags(&tree, 0);
>>   	check_erase_testset(&tree);
>> -- 
>> 2.20.1
>>
