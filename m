Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BBC7B7B46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjJDJJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241914AbjJDJJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:09:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD1BB
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 02:09:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1550639b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696410581; x=1697015381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mlg3qmdzGa2/sOSr+GySj5uG6qeYzpAKzoJclP2pzI=;
        b=McIjcggeN0rpcgJ3GV0kgRLl9Xbph72afwx4KhXmFUw0T+J2fVW3X1YIPI2jo/wuJ8
         DXIR6QLhi9jlvDuzsf3vgP5OUK1/5mxMeRDUWTTbXrkVZLUhHKLAwPKQ+oOBAmuQzCsy
         3r7MUny1eL467neG4rTTFgi8OFNcFpxjFA/xOc4YHF+BVH+yYFs7JkQxl4VgB0UV01xg
         gCznbiGQRCnO5DEwunCgjiQwBZ8MiXyCexmD1V9uusVOmI7r+rptaBOR6vcBqsT2mK9b
         4UwB6u1eNe3mRaTX7luh+nqInjUqDXsFskq2/OHBQCxmLEFTqXlCOVMhvyDQEETxoSIe
         aB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696410581; x=1697015381;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Mlg3qmdzGa2/sOSr+GySj5uG6qeYzpAKzoJclP2pzI=;
        b=emakAobIxKRCKRRltuVrMkFaT/wYColTizGNJ3ZYxF4W7UjW5AMGTgmj5X/flSsv2r
         KGNUo5shnbOp2hJpXmMzoD6zw0E9YF8ngxU4LlheqK8A45khGgyhDQzDIo9egoABUPOv
         VC/KkqmkmhuxiJXPGCCRhPtZbh5HndG+ipbeWEMA1MkQAbGMaMoiz5y3nkwOYeuy3960
         sa/u09bJOSIRCixXGJhvmFd/4n28daTb+o5h2nVIlZHNzzjW8dOz1FQaQ7JJd/UuEt2P
         1c8RQtP2+IM4GT0TFkT+GqbSmGbJu7m8yhisw/p+yUGea7dqt4wLgaQxsHRPGQfu3Elk
         FARQ==
X-Gm-Message-State: AOJu0Yzpud9jCrtMyFXxAPyn5oyz2RI2zrdvzhs53+RHX36rjEOpUFk9
        6fpXNd95RKT0sDZpX9YMW2SqTA==
X-Google-Smtp-Source: AGHT+IGzYX1ZcA7LZgT1KuL+GqkQkKAigEf6i09R4CzkfEMrdRimdzIvgBUqIQyaG+yeNg827B0+1g==
X-Received: by 2002:a05:6a00:244b:b0:68f:b3ed:7d56 with SMTP id d11-20020a056a00244b00b0068fb3ed7d56mr1985020pfj.34.1696410581181;
        Wed, 04 Oct 2023 02:09:41 -0700 (PDT)
Received: from [10.254.225.239] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id i8-20020aa79088000000b00690c9fda0fesm2742626pfa.169.2023.10.04.02.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:09:40 -0700 (PDT)
Message-ID: <7be3abc1-1db0-35a0-0a42-2415674effb1@bytedance.com>
Date:   Wed, 4 Oct 2023 17:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v3 3/9] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-4-zhangpeng.00@bytedance.com>
 <20231003184542.svldlilhgjc4nct4@revolver>
In-Reply-To: <20231003184542.svldlilhgjc4nct4@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/10/4 02:45, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
>> Introduce interfaces __mt_dup() and mtree_dup(), which are used to
>> duplicate a maple tree. They duplicate a maple tree in Depth-First
>> Search (DFS) pre-order traversal. It uses memcopy() to copy nodes in the
>> source tree and allocate new child nodes in non-leaf nodes. The new node
>> is exactly the same as the source node except for all the addresses
>> stored in it. It will be faster than traversing all elements in the
>> source tree and inserting them one by one into the new tree. The time
>> complexity of these two functions is O(n).
>>
>> The difference between __mt_dup() and mtree_dup() is that mtree_dup()
>> handles locks internally.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   include/linux/maple_tree.h |   3 +
>>   lib/maple_tree.c           | 286 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 289 insertions(+)
>>
>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> index 666a3764ed89..de5a4056503a 100644
>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -329,6 +329,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
>>   		void *entry, gfp_t gfp);
>>   void *mtree_erase(struct maple_tree *mt, unsigned long index);
>>   
>> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
>> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
>> +
>>   void mtree_destroy(struct maple_tree *mt);
>>   void __mt_destroy(struct maple_tree *mt);
>>   
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 3fe5652a8c6c..ed8847b4f1ff 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -6370,6 +6370,292 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>>   }
>>   EXPORT_SYMBOL(mtree_erase);
>>   
>> +/*
>> + * mas_dup_free() - Free an incomplete duplication of a tree.
>> + * @mas: The maple state of a incomplete tree.
>> + *
>> + * The parameter @mas->node passed in indicates that the allocation failed on
>> + * this node. This function frees all nodes starting from @mas->node in the
>> + * reverse order of mas_dup_build(). There is no need to hold the source tree
>> + * lock at this time.
>> + */
>> +static void mas_dup_free(struct ma_state *mas)
>> +{
>> +	struct maple_node *node;
>> +	enum maple_type type;
>> +	void __rcu **slots;
>> +	unsigned char count, i;
>> +
>> +	/* Maybe the first node allocation failed. */
>> +	if (mas_is_none(mas))
>> +		return;
>> +
>> +	while (!mte_is_root(mas->node)) {
>> +		mas_ascend(mas);
>> +
>> +		if (mas->offset) {
>> +			mas->offset--;
>> +			do {
>> +				mas_descend(mas);
>> +				mas->offset = mas_data_end(mas);
>> +			} while (!mte_is_leaf(mas->node));
>> +
>> +			mas_ascend(mas);
>> +		}
>> +
>> +		node = mte_to_node(mas->node);
>> +		type = mte_node_type(mas->node);
>> +		slots = ma_slots(node, type);
>> +		count = mas_data_end(mas) + 1;
>> +		for (i = 0; i < count; i++)
>> +			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
>> +
>> +		mt_free_bulk(count, slots);
>> +	}
>> +
>> +	node = mte_to_node(mas->node);
>> +	mt_free_one(node);
>> +}
>> +
>> +/*
>> + * mas_copy_node() - Copy a maple node and replace the parent.
>> + * @mas: The maple state of source tree.
>> + * @new_mas: The maple state of new tree.
>> + * @parent: The parent of the new node.
>> + *
>> + * Copy @mas->node to @new_mas->node, set @parent to be the parent of
>> + * @new_mas->node. If memory allocation fails, @mas is set to -ENOMEM.
>> + */
>> +static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
>> +		struct maple_pnode *parent)
>> +{
>> +	struct maple_node *node = mte_to_node(mas->node);
>> +	struct maple_node *new_node = mte_to_node(new_mas->node);
>> +	unsigned long val;
>> +
>> +	/* Copy the node completely. */
>> +	memcpy(new_node, node, sizeof(struct maple_node));
>> +
>> +	/* Update the parent node pointer. */
>> +	val = (unsigned long)node->parent & MAPLE_NODE_MASK;
>> +	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
>> +}
>> +
>> +/*
>> + * mas_dup_alloc() - Allocate child nodes for a maple node.
>> + * @mas: The maple state of source tree.
>> + * @new_mas: The maple state of new tree.
>> + * @gfp: The GFP_FLAGS to use for allocations.
>> + *
>> + * This function allocates child nodes for @new_mas->node during the duplication
>> + * process. If memory allocation fails, @mas is set to -ENOMEM.
>> + */
>> +static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
>> +		gfp_t gfp)
>> +{
>> +	struct maple_node *node = mte_to_node(mas->node);
>> +	struct maple_node *new_node = mte_to_node(new_mas->node);
>> +	enum maple_type type;
>> +	unsigned char request, count, i;
>> +	void __rcu **slots;
>> +	void __rcu **new_slots;
>> +	unsigned long val;
>> +
>> +	/* Allocate memory for child nodes. */
>> +	type = mte_node_type(mas->node);
>> +	new_slots = ma_slots(new_node, type);
>> +	request = mas_data_end(mas) + 1;
>> +	count = mt_alloc_bulk(gfp, request, (void **)new_slots);
>> +	if (unlikely(count < request)) {
>> +		if (count) {
>> +			mt_free_bulk(count, new_slots);
> 
> If you look at mm/slab.c: kmem_cache_alloc(), you will see that the
> error path already bulk frees for you - but does not zero the array.
> This bulk free will lead to double free, but you do need the below
> memset().  Also, it will return !count or request. So, I think this code
> is never executed as it is written.
If kmem_cache_alloc() is called to allocate memory in mt_alloc_bulk(),
then this code will not be executed because it only returns 0 or
request. However, I am concerned that changes to mt_alloc_bulk() like
[1] may be merged, which could potentially lead to memory leaks. To
improve robustness, I wrote it this way.

How do you think it should be handled? Is it okay to do this like the
code below?

if (unlikely(count < request)) {
	memset(new_slots, 0, request * sizeof(unsigned long));
	mas_set_err(mas, -ENOMEM);
	return;
}

[1] https://lore.kernel.org/lkml/20230810163627.6206-13-vbabka@suse.cz/
> 
> I don't think this will show up in your testcases because the test code
> doesn't leave dangling pointers and simply returns 0 if there isn't
> enough nodes.
Yes, no testing here.
> 
>> +			memset(new_slots, 0, count * sizeof(unsigned long));
>> +		}
>> +		mas_set_err(mas, -ENOMEM);
>> +		return;
>> +	}
>> +
>> +	/* Restore node type information in slots. */
>> +	slots = ma_slots(node, type);
>> +	for (i = 0; i < count; i++) {
>> +		val = (unsigned long)mt_slot_locked(mas->tree, slots, i);
>> +		val &= MAPLE_NODE_MASK;
>> +		((unsigned long *)new_slots)[i] |= val;
>> +	}
>> +}
>> +
>> +/*
>> + * mas_dup_build() - Build a new maple tree from a source tree
>> + * @mas: The maple state of source tree.
>> + * @new_mas: The maple state of new tree.
>> + * @gfp: The GFP_FLAGS to use for allocations.
>> + *
>> + * This function builds a new tree in DFS preorder. If the memory allocation
>> + * fails, the error code -ENOMEM will be set in @mas, and @new_mas points to the
>> + * last node. mas_dup_free() will free the incomplete duplication of a tree.
>> + *
>> + * Note that the attributes of the two trees need to be exactly the same, and the
>> + * new tree needs to be empty, otherwise -EINVAL will be set in @mas.
>> + */
>> +static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
>> +		gfp_t gfp)
>> +{
>> +	struct maple_node *node;
>> +	struct maple_pnode *parent = NULL;
>> +	struct maple_enode *root;
>> +	enum maple_type type;
>> +
>> +	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
>> +	    unlikely(!mtree_empty(new_mas->tree))) {
> 
> Would it be worth checking mas_is_start() for both mas and new_mas here?
> Otherwise mas_start() will not do what you want below.  I think it is
> implied that both are at MAS_START but never checked?
This function is an internal function and is currently only called by
{mtree,__mt}_dup(). It is ensured that both 'mas' and 'new_mas' are
MAS_START when called. Do you think we really need to check it? Maybe we
just need to explain it in the comments?
> 
>> +		mas_set_err(mas, -EINVAL);
>> +		return;
>> +	}
>> +
>> +	mas_start(mas);
>> +	if (mas_is_ptr(mas) || mas_is_none(mas)) {
>> +		root = mt_root_locked(mas->tree);
>> +		goto set_new_tree;
>> +	}
>> +
>> +	node = mt_alloc_one(gfp);
>> +	if (!node) {
>> +		new_mas->node = MAS_NONE;
>> +		mas_set_err(mas, -ENOMEM);
>> +		return;
>> +	}
>> +
>> +	type = mte_node_type(mas->node);
>> +	root = mt_mk_node(node, type);
>> +	new_mas->node = root;
>> +	new_mas->min = 0;
>> +	new_mas->max = ULONG_MAX;
>> +	root = mte_mk_root(root);
>> +
>> +	while (1) {
>> +		mas_copy_node(mas, new_mas, parent);
>> +
>> +		if (!mte_is_leaf(mas->node)) {
>> +			/* Only allocate child nodes for non-leaf nodes. */
>> +			mas_dup_alloc(mas, new_mas, gfp);
>> +			if (unlikely(mas_is_err(mas)))
>> +				return;
>> +		} else {
>> +			/*
>> +			 * This is the last leaf node and duplication is
>> +			 * completed.
>> +			 */
>> +			if (mas->max == ULONG_MAX)
>> +				goto done;
>> +
>> +			/* This is not the last leaf node and needs to go up. */
>> +			do {
>> +				mas_ascend(mas);
>> +				mas_ascend(new_mas);
>> +			} while (mas->offset == mas_data_end(mas));
>> +
>> +			/* Move to the next subtree. */
>> +			mas->offset++;
>> +			new_mas->offset++;
>> +		}
>> +
>> +		mas_descend(mas);
>> +		parent = ma_parent_ptr(mte_to_node(new_mas->node));
>> +		mas_descend(new_mas);
>> +		mas->offset = 0;
>> +		new_mas->offset = 0;
>> +	}
>> +done:
>> +	/* Specially handle the parent of the root node. */
>> +	mte_to_node(root)->parent = ma_parent_ptr(mas_tree_parent(new_mas));
>> +set_new_tree:
>> +	/* Make them the same height */
>> +	new_mas->tree->ma_flags = mas->tree->ma_flags;
>> +	rcu_assign_pointer(new_mas->tree->ma_root, root);
>> +}
>> +
>> +/**
>> + * __mt_dup(): Duplicate a maple tree
>> + * @mt: The source maple tree
>> + * @new: The new maple tree
>> + * @gfp: The GFP_FLAGS to use for allocations
>> + *
>> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
>> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate
>> + * new child nodes in non-leaf nodes. The new node is exactly the same as the
>> + * source node except for all the addresses stored in it. It will be faster than
>> + * traversing all elements in the source tree and inserting them one by one into
>> + * the new tree.
>> + * The user needs to ensure that the attributes of the source tree and the new
>> + * tree are the same, and the new tree needs to be an empty tree, otherwise
>> + * -EINVAL will be returned.
>> + * Note that the user needs to manually lock the source tree and the new tree.
>> + *
>> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
>> + * the attributes of the two trees are different or the new tree is not an empty
>> + * tree.
>> + */
>> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
>> +{
>> +	int ret = 0;
>> +	MA_STATE(mas, mt, 0, 0);
>> +	MA_STATE(new_mas, new, 0, 0);
>> +
>> +	mas_dup_build(&mas, &new_mas, gfp);
>> +
>> +	if (unlikely(mas_is_err(&mas))) {
>> +		ret = xa_err(mas.node);
>> +		if (ret == -ENOMEM)
>> +			mas_dup_free(&new_mas);
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(__mt_dup);
>> +
>> +/**
>> + * mtree_dup(): Duplicate a maple tree
>> + * @mt: The source maple tree
>> + * @new: The new maple tree
>> + * @gfp: The GFP_FLAGS to use for allocations
>> + *
>> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
>> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate
>> + * new child nodes in non-leaf nodes. The new node is exactly the same as the
>> + * source node except for all the addresses stored in it. It will be faster than
>> + * traversing all elements in the source tree and inserting them one by one into
>> + * the new tree.
>> + * The user needs to ensure that the attributes of the source tree and the new
>> + * tree are the same, and the new tree needs to be an empty tree, otherwise
>> + * -EINVAL will be returned.
> 
> The requirement to duplicate the entire tree should be mentioned and
> maybe the mas_is_start() requirement (as I asked about above?)
Okay, I will add a comment saying 'This duplicates the entire tree'. But
'mas_is_start()' is not a requirement for calling this function because
the function's parameter is 'maple_tree', not 'ma_state'. I think
'mas_is_start()' should be added to the comment for 'mas_dup_build()'.
> 
> I can see someone thinking they are going to make a super fast sub-tree
> of existing data using this - which won't (always?) work.
> 
>> + *
>> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
>> + * the attributes of the two trees are different or the new tree is not an empty
>> + * tree.
>> + */
>> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
>> +{
>> +	int ret = 0;
>> +	MA_STATE(mas, mt, 0, 0);
>> +	MA_STATE(new_mas, new, 0, 0);
>> +
>> +	mas_lock(&new_mas);
>> +	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
>> +
>> +	mas_dup_build(&mas, &new_mas, gfp);
>> +	mas_unlock(&mas);
>> +
>> +	if (unlikely(mas_is_err(&mas))) {
>> +		ret = xa_err(mas.node);
>> +		if (ret == -ENOMEM)
>> +			mas_dup_free(&new_mas);
>> +	}
>> +
>> +	mas_unlock(&new_mas);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(mtree_dup);
>> +
>>   /**
>>    * __mt_destroy() - Walk and free all nodes of a locked maple tree.
>>    * @mt: The maple tree
>> -- 
>> 2.20.1
>>
> 
