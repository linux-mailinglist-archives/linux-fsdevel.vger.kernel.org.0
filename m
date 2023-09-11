Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2961479AD99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjIKUxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbjIKM7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:59:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A152E40
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 05:59:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c397ed8681so13150005ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694437177; x=1695041977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9K9PV8rCUk+B/IC15F5p4JTJ+5tMZARiqrSac1yaAY=;
        b=cvKetsLBva9j2NCTgC84iEPcynqNMGv3GC1OmMtPJ3rRrTD3A7i7crbt7BiCiB9UJR
         wvWYw4qDFjvQPJDr+l7t5Sa1EtJDrt2k5NZQ3M8fDRZT2H1cwe3I2aEkuBmvnvLROGcO
         q3e8EZIdqx+DjNzNIeStmLklD8qNnYPNwG9oW+47GiHIK2kK39AoM9TkPhzMSEryNNLa
         PY3tC86a20Y0FIcjqXZmibbrfwrarVyXcsUczBPp+Dpz+jwOCqLZtYLemKOdW0mognx7
         guO3OhD3yqqyDzbJQMEqeQRdHmhr4PMJKmU0TFs7kR1o3DqVZx/I+shcJn8Ab1K22+U9
         nC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437177; x=1695041977;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9K9PV8rCUk+B/IC15F5p4JTJ+5tMZARiqrSac1yaAY=;
        b=maS2D7LTuCcwiShq/y2pUyu6KQCyOrkeV3pQds2mIGzwomYrQCL+YFSlOxrV2twj5H
         K0Lb2tD9pH7WEgZ0ln8R884ZTe5F/81OTjZSqLKAHaL9DWVcyaHgUlc1H84Y1WloLbwW
         2Tk1NItVeboHt3MN737o4V8Ss50RT3jWV4iNA8kMh61/ZmM9oAS1axM7L0posRwHmyFX
         aFsDIMeBfedfbVcpu1pzMmM5hGrQFK/x5fvP3C1UaMK1J2Q2CPymlfrNih4Qb/XmtqHS
         VKYohPyU9ymzFY22oBZkQjRUQxbHml5z/M4V9vIUrpPVNqB2hXymNM7P5TmBExJu5SiJ
         9Lbw==
X-Gm-Message-State: AOJu0YzofPv9e6JdEraCl9yrIID+Uat9DQSKkKh5sMGJ0GnFxmtfzfZY
        B937E+k1qHkrMzJ71rkAnA9pAg==
X-Google-Smtp-Source: AGHT+IF0oOYT6OYBqZ+NhEZ/u0pJPEqP5WDyQnKZHqRlsJf7LY3KaXHXMZJ7AMyMKhj/KCQHODv8Xg==
X-Received: by 2002:a17:903:2291:b0:1c0:8bf3:eb15 with SMTP id b17-20020a170903229100b001c08bf3eb15mr9519352plh.30.1694437176737;
        Mon, 11 Sep 2023 05:59:36 -0700 (PDT)
Received: from [10.84.144.104] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902778a00b001b53953f306sm6436614pll.178.2023.09.11.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 05:59:36 -0700 (PDT)
Message-ID: <d388a9e5-560a-72c2-4db5-1f39827740c9@bytedance.com>
Date:   Mon, 11 Sep 2023 20:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/6] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-3-zhangpeng.00@bytedance.com>
 <20230907201333.nyydilmlbbf2wzf7@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230907201333.nyydilmlbbf2wzf7@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/9/8 04:13, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:57]:
>> Introduce interfaces __mt_dup() and mtree_dup(), which are used to
>> duplicate a maple tree. Compared with traversing the source tree and
>> reinserting entry by entry in the new tree, it has better performance.
>> The difference between __mt_dup() and mtree_dup() is that mtree_dup()
>> handles locks internally.
> 
> __mt_dup() should be called mas_dup() to indicate the advanced interface
> which requires users to handle their own locks.
Changing to the mas_dup() interface may look like this:
mas_dup(mas_old, mas_new)

This still encounters the problem we discussed before. You expect both
mas_old and mas_new to point to the first element after the function
returns, but for_each_vma(vmi, mpnt) in dup_mmap() does not support
this, and will skip the first element.

Unless we have an iterator similar to "do {} while()", we have to reset 
mas_new. There is still additional overhead in making both mas_old and
mas_new point to the first element, because mas will point to the last
node after dfs order traversal.

In fact, I think mtree_dup() and __mt_dup() are enough. They seem to
match mtree_destroy() and __mt_destroy() very well. Underlines indicate
that users need to handle the lock themselves.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   include/linux/maple_tree.h |   3 +
>>   lib/maple_tree.c           | 265 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 268 insertions(+)
>>
>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> index e41c70ac7744..44fe8a57ecbd 100644
>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
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
>> index ef234cf02e3e..8f841682269c 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -6370,6 +6370,271 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>>   }
>>   EXPORT_SYMBOL(mtree_erase);
>>   
>> +/*
>> + * mas_dup_free() - Free a half-constructed tree.
> 
> Maybe "Free an incomplete duplication of a tree" ?
> 
>> + * @mas: Points to the last node of the half-constructed tree.
> 
> Your use of "Points to" seems to indicate someone knows you are talking
> about a "maple state that has a node pointing to".  Can this be made
> more clear?
> @mas: The maple state of a incomplete tree.
> 
> Then add a note that @mas->node points to the last successfully
> allocated node?
> 
> Or something along those lines.
> 
>> + *
>> + * This function frees all nodes starting from @mas->node in the reverse order
>> + * of mas_dup_build(). There is no need to hold the source tree lock at this
>> + * time.
>> + */
>> +static void mas_dup_free(struct ma_state *mas)
>> +{
>> +	struct maple_node *node;
>> +	enum maple_type type;
>> +	void __rcu **slots;
>> +	unsigned char count, i;
>> +
>> +	/* Maybe the first node allocation failed. */
>> +	if (!mas->node)
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
> 
> Can you blindly descend and check !mte_is_leaf()?  What happens when the
> tree duplication fails at random internal nodes?  Maybe I missed how
> this cannot happen?
> 
>> +
>> +			mas_ascend(mas);
>> +		}
>> +
>> +		node = mte_to_node(mas->node);
>> +		type = mte_node_type(mas->node);
>> +		slots = (void **)ma_slots(node, type);
>> +		count = mas_data_end(mas) + 1;
>> +		for (i = 0; i < count; i++)
>> +			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
>> +
>> +		mt_free_bulk(count, slots);
>> +	}
> 
> 
>> +
>> +	node = mte_to_node(mas->node);
>> +	mt_free_one(node);
>> +}
>> +
>> +/*
>> + * mas_copy_node() - Copy a maple node and allocate child nodes.
> 
> if required. "..and allocate child nodes if required."
> 
>> + * @mas: Points to the source node.
>> + * @new_mas: Points to the new node.
>> + * @parent: The parent node of the new node.
>> + * @gfp: The GFP_FLAGS to use for allocations.
>> + *
>> + * Copy @mas->node to @new_mas->node, set @parent to be the parent of
>> + * @new_mas->node and allocate new child nodes for @new_mas->node.
>> + * If memory allocation fails, @mas is set to -ENOMEM.
>> + */
>> +static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
>> +		struct maple_node *parent, gfp_t gfp)
>> +{
>> +	struct maple_node *node = mte_to_node(mas->node);
>> +	struct maple_node *new_node = mte_to_node(new_mas->node);
>> +	enum maple_type type;
>> +	unsigned long val;
>> +	unsigned char request, count, i;
>> +	void __rcu **slots;
>> +	void __rcu **new_slots;
>> +
>> +	/* Copy the node completely. */
>> +	memcpy(new_node, node, sizeof(struct maple_node));
>> +
>> +	/* Update the parent node pointer. */
>> +	if (unlikely(ma_is_root(node)))
>> +		val = MA_ROOT_PARENT;
>> +	else
>> +		val = (unsigned long)node->parent & MAPLE_NODE_MASK;
> 
> If you treat the root as special and outside the loop, then you can
> avoid the check for root for every non-root node.  For root, you just
> need to copy and do this special parent thing before the main loop in
> mas_dup_build().  This will avoid an extra branch for each VMA over 14,
> so that would add up to a lot of instructions.
> 
>> +
>> +	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
>> +
>> +	if (mte_is_leaf(mas->node))
>> +		return;
> 
> You are checking here and in mas_dup_build() for the leaf, splitting the
> function into parent assignment and allocate would allow you to check
> once. Copy could be moved to the main loop or with the parent setting,
> depending on how you handle the root suggestion above.
> 
>> +
>> +	/* Allocate memory for child nodes. */
>> +	type = mte_node_type(mas->node);
>> +	new_slots = ma_slots(new_node, type);
>> +	request = mas_data_end(mas) + 1;
>> +	count = mt_alloc_bulk(gfp, request, new_slots);
>> +	if (unlikely(count < request)) {
>> +		if (count)
>> +			mt_free_bulk(count, new_slots);
> 
> The new_slots will still contain the addresses of the freed nodes.
> Don't you need to clear it here to avoid a double free?  Is there a
> test case for this in your testing?  Again, I may have missed how this
> is not possible..
> 
>> +		mas_set_err(mas, -ENOMEM);
>> +		return;
>> +	}
>> +
>> +	/* Restore node type information in slots. */
>> +	slots = ma_slots(node, type);
>> +	for (i = 0; i < count; i++)
>> +		((unsigned long *)new_slots)[i] |=
>> +			((unsigned long)mt_slot_locked(mas->tree, slots, i) &
>> +			MAPLE_NODE_MASK);
> 
> Can you expand this to multiple lines to make it more clear what is
> going on?
> 
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
>> + * last node. mas_dup_free() will free the half-constructed tree.
>> + *
>> + * Note that the attributes of the two trees must be exactly the same, and the
>> + * new tree must be empty, otherwise -EINVAL will be returned.
>> + */
>> +static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
>> +		gfp_t gfp)
>> +{
>> +	struct maple_node *node, *parent;
> 
> Could parent be struct maple_pnode?
> 
>> +	struct maple_enode *root;
>> +	enum maple_type type;
>> +
>> +	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
>> +	    unlikely(!mtree_empty(new_mas->tree))) {
>> +		mas_set_err(mas, -EINVAL);
>> +		return;
>> +	}
>> +
>> +	mas_start(mas);
>> +	if (mas_is_ptr(mas) || mas_is_none(mas)) {
>> +		/*
>> +		 * The attributes of the two trees must be the same before this.
>> +		 * The following assignment makes them the same height.
>> +		 */
>> +		new_mas->tree->ma_flags = mas->tree->ma_flags;
>> +		rcu_assign_pointer(new_mas->tree->ma_root, mas->tree->ma_root);
>> +		return;
>> +	}
>> +
>> +	node = mt_alloc_one(gfp);
>> +	if (!node) {
>> +		new_mas->node = NULL;
> 
> We don't have checks around for node == NULL, MAS_NONE would be a safer
> choice.  It is unlikely that someone would dup the tree and fail then
> call something else, but I avoid setting node to NULL.
> 
>> +		mas_set_err(mas, -ENOMEM);
>> +		return;
>> +	}
>> +
>> +	type = mte_node_type(mas->node);
>> +	root = mt_mk_node(node, type);
>> +	new_mas->node = root;
>> +	new_mas->min = 0;
>> +	new_mas->max = ULONG_MAX;
>> +	parent = ma_mnode_ptr(new_mas->tree);
>> +
>> +	while (1) {
>> +		mas_copy_node(mas, new_mas, parent, gfp);
>> +
>> +		if (unlikely(mas_is_err(mas)))
>> +			return;
>> +
>> +		/* Once we reach a leaf, we need to ascend, or end the loop. */
>> +		if (mte_is_leaf(mas->node)) {
>> +			if (mas->max == ULONG_MAX) {
>> +				new_mas->tree->ma_flags = mas->tree->ma_flags;
>> +				rcu_assign_pointer(new_mas->tree->ma_root,
>> +						   mte_mk_root(root));
>> +				break;
> 
> If you move this to the end of the function, you can replace the same
> block above with a goto.  That will avoid breaking the line up.
> 
>> +			}
>> +
>> +			do {
>> +				/*
>> +				 * Must not at the root node, because we've
>> +				 * already end the loop when we reach the last
>> +				 * leaf.
>> +				 */
> 
> I'm not sure what the comment above is trying to say.  Do you mean "This
> won't reach the root node because the loop will break when the last leaf
> is hit"?  I don't think that is accurate.. it will hit the root node but
> not the end of the root node, right?  Anyways, the comment isn't clear
> so please have a look.
> 
>> +				mas_ascend(mas);
>> +				mas_ascend(new_mas);
>> +			} while (mas->offset == mas_data_end(mas));
>> +
>> +			mas->offset++;
>> +			new_mas->offset++;
>> +		}
>> +
>> +		mas_descend(mas);
>> +		parent = mte_to_node(new_mas->node);
>> +		mas_descend(new_mas);
>> +		mas->offset = 0;
>> +		new_mas->offset = 0;
>> +	}
>> +}
>> +
>> +/**
>> + * __mt_dup(): Duplicate a maple tree
>> + * @mt: The source maple tree
>> + * @new: The new maple tree
>> + * @gfp: The GFP_FLAGS to use for allocations
>> + *
>> + * This function duplicates a maple tree using a faster method than traversing
>> + * the source tree and inserting entries into the new tree one by one.
> 
> Can you make this comment more about what your code does instead of the
> "one by one" description?
> 
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
>> + * This function duplicates a maple tree using a faster method than traversing
>> + * the source tree and inserting entries into the new tree one by one.
> 
> Again, it's more interesting to state it uses the DFS preorder copy.
> 
> It is also worth mentioning the superior allocation behaviour since that
> is a desirable trait for many.  In fact, you should add the allocation
> behaviour in your cover letter.
> 
>> + * The user needs to ensure that the attributes of the source tree and the new
>> + * tree are the same, and the new tree needs to be an empty tree, otherwise
>> + * -EINVAL will be returned.
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
>> +	mas_lock(&mas);
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
