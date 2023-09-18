Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6084E7A456B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjIRJEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbjIRJDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:03:50 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [IPv6:2001:41d0:203:375::e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A76FB
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 02:03:42 -0700 (PDT)
Message-ID: <4aff0e17-b40f-406d-65fd-72a2bacfcc1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695027820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8FIKu/oc8C0T9NCBKrRDhMs8EoaTRCvaUvMqpcHrIE=;
        b=qVx4MQldgaytiWlxDgNucPdP9OuA/qjxMAdjnc13310KRUWLZNWoHrexZyvR+hvPyYBHxg
        IKrlmpeS12OTQ0YOUZZ3pwo87Q0nou3HMhgw2kdwxdzSHTdsaeTrJXgw0dduFIPhicYa6o
        ihWs8+51lRQGImekl3PVipwfJQtmJQQ=
Date:   Mon, 18 Sep 2023 17:03:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6 01/45] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-2-zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230911094444.68966-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/9/11 17:44, Qi Zheng wrote:
> Currently, the shrinker instances can be divided into the following three
> types:
>
> a) global shrinker instance statically defined in the kernel, such as
>     workingset_shadow_shrinker.
>
> b) global shrinker instance statically defined in the kernel modules, such
>     as mmu_shrinker in x86.
>
> c) shrinker instance embedded in other structures.
>
> For case a, the memory of shrinker instance is never freed. For case b,
> the memory of shrinker instance will be freed after synchronize_rcu() when
> the module is unloaded. For case c, the memory of shrinker instance will
> be freed along with the structure it is embedded in.
>
> In preparation for implementing lockless slab shrink, we need to
> dynamically allocate those shrinker instances in case c, then the memory
> can be dynamically freed alone by calling kfree_rcu().
>
> So this commit adds the following new APIs for dynamically allocating
> shrinker, and add a private_data field to struct shrinker to record and
> get the original embedded structure.
>
> 1. shrinker_alloc()
>
> Used to allocate shrinker instance itself and related memory, it will
> return a pointer to the shrinker instance on success and NULL on failure.
>
> 2. shrinker_register()
>
> Used to register the shrinker instance, which is same as the current
> register_shrinker_prepared().
>
> 3. shrinker_free()
>
> Used to unregister (if needed) and free the shrinker instance.
>
> In order to simplify shrinker-related APIs and make shrinker more
> independent of other kernel mechanisms, subsequent submissions will use
> the above API to convert all shrinkers (including case a and b) to
> dynamically allocated, and then remove all existing APIs.
>
> This will also have another advantage mentioned by Dave Chinner:
>
> ```
> The other advantage of this is that it will break all the existing
> out of tree code and third party modules using the old API and will
> no longer work with a kernel using lockless slab shrinkers. They
> need to break (both at the source and binary levels) to stop bad
> things from happening due to using unconverted shrinkers in the new
> setup.
> ```
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   include/linux/shrinker.h |   7 +++
>   mm/internal.h            |  11 +++++
>   mm/shrinker.c            | 102 +++++++++++++++++++++++++++++++++++++++
>   mm/shrinker_debug.c      |  17 ++++++-
>   4 files changed, 135 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 6b5843c3b827..3f3fd9974ce5 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -70,6 +70,8 @@ struct shrinker {
>   	int seeks;	/* seeks to recreate an obj */
>   	unsigned flags;
>   
> +	void *private_data;
> +
>   	/* These are for internal use */
>   	struct list_head list;
>   #ifdef CONFIG_MEMCG
> @@ -95,6 +97,11 @@ struct shrinker {
>    * non-MEMCG_AWARE shrinker should not have this flag set.
>    */
>   #define SHRINKER_NONSLAB	(1 << 3)
> +#define SHRINKER_ALLOCATED	(1 << 4)

It is better to add a comment here to tell users
it is only used by internals of shrinker. The users
are not supposed to pass this flag to shrink APIs.

> +
> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
> +void shrinker_register(struct shrinker *shrinker);
> +void shrinker_free(struct shrinker *shrinker);
>   
>   extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
>   					    const char *fmt, ...);
> diff --git a/mm/internal.h b/mm/internal.h
> index 0471d6326d01..5587cae20ebf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1161,6 +1161,9 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>   
>   #ifdef CONFIG_SHRINKER_DEBUG
>   extern int shrinker_debugfs_add(struct shrinker *shrinker);
> +extern int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
> +				       const char *fmt, va_list ap);
> +extern void shrinker_debugfs_name_free(struct shrinker *shrinker);
>   extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
>   					      int *debugfs_id);
>   extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
> @@ -1170,6 +1173,14 @@ static inline int shrinker_debugfs_add(struct shrinker *shrinker)
>   {
>   	return 0;
>   }
> +static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
> +					      const char *fmt, va_list ap)
> +{
> +	return 0;
> +}
> +static inline void shrinker_debugfs_name_free(struct shrinker *shrinker)
> +{
> +}
>   static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
>   						     int *debugfs_id)
>   {
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index a16cd448b924..201211a67827 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -550,6 +550,108 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>   	return freed;
>   }
>   
> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
> +{
> +	struct shrinker *shrinker;
> +	unsigned int size;
> +	va_list ap;
> +	int err;
> +
> +	shrinker = kzalloc(sizeof(struct shrinker), GFP_KERNEL);
> +	if (!shrinker)
> +		return NULL;
> +
> +	va_start(ap, fmt);
> +	err = shrinker_debugfs_name_alloc(shrinker, fmt, ap);
> +	va_end(ap);
> +	if (err)
> +		goto err_name;
> +
> +	shrinker->flags = flags | SHRINKER_ALLOCATED;
> +	shrinker->seeks = DEFAULT_SEEKS;
> +
> +	if (flags & SHRINKER_MEMCG_AWARE) {
> +		err = prealloc_memcg_shrinker(shrinker);
> +		if (err == -ENOSYS)
> +			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
> +		else if (err == 0)
> +			goto done;
> +		else
> +			goto err_flags;

Actually, the code here is a little confusing me when I fist look
at it. I think there could be some improvements here. Something
like:

         if (flags & SHRINKER_MEMCG_AWARE) {
                 err = prealloc_memcg_shrinker(shrinker);
                 if (err == -ENOSYS) {
                         /* Memcg is not supported and fallback to 
non-memcg-aware shrinker. */
                         shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
                         goto non-memcg;
                 }

                 if (err)
                     goto err_flags;
                 return shrinker;
         }

non-memcg:
         [...]
         return shrinker;

In this case, the code becomes more clear (at least for me). We have 
split the
code into two part, one is handling memcg-aware case, another is 
non-memcg-aware
case. Any side will have a explicit "return" keyword to return once 
succeeds.
It is a little implicit that the previous one uses "goto done".

And the tag of "non-memcg" is also a good annotation to tell us the 
following
code handles non-memcg-aware case.

> +	}
> +
> +	/*
> +	 * The nr_deferred is available on per memcg level for memcg aware
> +	 * shrinkers, so only allocate nr_deferred in the following cases:
> +	 *  - non memcg aware shrinkers
> +	 *  - !CONFIG_MEMCG
> +	 *  - memcg is disabled by kernel command line
> +	 */
> +	size = sizeof(*shrinker->nr_deferred);
> +	if (flags & SHRINKER_NUMA_AWARE)
> +		size *= nr_node_ids;
> +
> +	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
> +	if (!shrinker->nr_deferred)
> +		goto err_flags;
> +
> +done:
> +	return shrinker;
> +
> +err_flags:
> +	shrinker_debugfs_name_free(shrinker);
> +err_name:
> +	kfree(shrinker);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(shrinker_alloc);
> +
> +void shrinker_register(struct shrinker *shrinker)
> +{
> +	if (unlikely(!(shrinker->flags & SHRINKER_ALLOCATED))) {
> +		pr_warn("Must use shrinker_alloc() to dynamically allocate the shrinker");
> +		return;
> +	}
> +
> +	down_write(&shrinker_rwsem);
> +	list_add_tail(&shrinker->list, &shrinker_list);
> +	shrinker->flags |= SHRINKER_REGISTERED;
> +	shrinker_debugfs_add(shrinker);
> +	up_write(&shrinker_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(shrinker_register);
> +
> +void shrinker_free(struct shrinker *shrinker)
> +{
> +	struct dentry *debugfs_entry = NULL;
> +	int debugfs_id;
> +
> +	if (!shrinker)
> +		return;
> +
> +	down_write(&shrinker_rwsem);
> +	if (shrinker->flags & SHRINKER_REGISTERED) {
> +		list_del(&shrinker->list);
> +		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
> +		shrinker->flags &= ~SHRINKER_REGISTERED;
> +	} else {
> +		shrinker_debugfs_name_free(shrinker);

We could remove shrinker_debugfs_name_free() calling from
shrinker_debugfs_detach(), then we could call
shrinker_debugfs_name_free() anyway, otherwise, it it a little
weird for me. And the srinker name is allocated from shrinker_alloc(),
so I think it it reasonable for shrinker_free() to free the
shrinker name.

Thanks.

> +	}
> +
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);
> +	up_write(&shrinker_rwsem);
> +
> +	if (debugfs_entry)
> +		shrinker_debugfs_remove(debugfs_entry, debugfs_id);
> +
> +	kfree(shrinker->nr_deferred);
> +	shrinker->nr_deferred = NULL;
> +
> +	kfree(shrinker);
> +}
> +EXPORT_SYMBOL_GPL(shrinker_free);
> +
>   /*
>    * Add a shrinker callback to be called from the vm.
>    */
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index e4ce509f619e..38452f539f40 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -193,6 +193,20 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>   	return 0;
>   }
>   
> +int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const char *fmt,
> +				va_list ap)
> +{
> +	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
> +
> +	return shrinker->name ? 0 : -ENOMEM;
> +}
> +
> +void shrinker_debugfs_name_free(struct shrinker *shrinker)
> +{
> +	kfree_const(shrinker->name);
> +	shrinker->name = NULL;
> +}

It it better to move both helpers to internal.h and mark them as inline
since both are very simple enough.

Thanks.

> +
>   int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>   {
>   	struct dentry *entry;
> @@ -241,8 +255,7 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
>   
>   	lockdep_assert_held(&shrinker_rwsem);
>   
> -	kfree_const(shrinker->name);
> -	shrinker->name = NULL;
> +	shrinker_debugfs_name_free(shrinker);
>   
>   	*debugfs_id = entry ? shrinker->debugfs_id : -1;
>   	shrinker->debugfs_entry = NULL;

