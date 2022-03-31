Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ADE4ED2E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 06:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiCaDtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 23:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCaDtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 23:49:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB028AB3E;
        Wed, 30 Mar 2022 20:43:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98356218F8;
        Thu, 31 Mar 2022 03:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648697196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pDNfMW1pSc9lHHTRKAHvGKffaBRtDqoDLX5/U9HCqo=;
        b=QEmZ9PiamBXzHHpBUx87N7ee2pcDpyR+X4p8TCRWm3xNJWgJT+Cz6EUeXF3OiqT57VqT3U
        bNO8N8y/32zsR6VbxxuilxHZJOlLFw5Yv4W92u0GvVo2KbrLHZbHIdksvUC+T7Yt1Qgz3u
        oqOxbgh6eUr4OJKi36s3N+qZJdOPhz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648697196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pDNfMW1pSc9lHHTRKAHvGKffaBRtDqoDLX5/U9HCqo=;
        b=g6oCvdzRdO2vK/vqrBC/NDNeZnipcIMfI29ggUzoh9bHxGm3oW/bzBzEPf8puLemt51SOl
        1/1TFUn+4z4ZnXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC0AE139C2;
        Thu, 31 Mar 2022 03:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fHxoIWQfRWLTfAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 31 Mar 2022 03:26:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Muchun Song" <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, "Muchun Song" <songmuchun@bytedance.com>
Subject: Re: [PATCH v6 12/16] mm: list_lru: replace linear array with xarray
In-reply-to: <20220228122126.37293-13-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>,
 <20220228122126.37293-13-songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 14:26:25 +1100
Message-id: <164869718565.25542.15818719940772238394@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Feb 2022, Muchun Song wrote:
> If we run 10k containers in the system, the size of the
> list_lru_memcg->lrus can be ~96KB per list_lru. When we decrease the
> number containers, the size of the array will not be shrinked. It is
> not scalable. The xarray is a good choice for this case. We can save
> a lot of memory when there are tens of thousands continers in the
> system. If we use xarray, we also can remove the logic code of
> resizing array, which can simplify the code.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Hi,
 I've just tried some simple testing on NFS (xfstests generic/???) and
 it reliably crashes in this code.
 Specifically in list_lru_add(), list_lru_from_kmem() returns NULL,
 which results in a NULL deref.
 list_lru_from_kmem() returns NULL because an xa_load() returns NULL.

 The patch doesn't make any sense to me.  It replaces an array of
 structures with an xarray, which is an array of pointers.
 It seems to assume that all the pointers in the array get magically
 allocated to the required structures.  I certainly cannot find when
 the 'struct list_lru_node' structures get allocated.  So xa_load() will
 *always* return NULL in this code.

 I can provide more details of the failure stack if needed, but I doubt
 that would be necessary.

Thanks,
NeilBrown


> ---
>  include/linux/list_lru.h   |  13 +--
>  include/linux/memcontrol.h |  23 ------
>  mm/list_lru.c              | 202 +++++++++++++++--------------------------=
----
>  mm/memcontrol.c            |  77 ++---------------
>  4 files changed, 73 insertions(+), 242 deletions(-)
>=20
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index 4b00fd8cb373..572c263561ac 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -11,6 +11,7 @@
>  #include <linux/list.h>
>  #include <linux/nodemask.h>
>  #include <linux/shrinker.h>
> +#include <linux/xarray.h>
> =20
>  struct mem_cgroup;
> =20
> @@ -37,12 +38,6 @@ struct list_lru_per_memcg {
>  	struct list_lru_one	node[];
>  };
> =20
> -struct list_lru_memcg {
> -	struct rcu_head			rcu;
> -	/* array of per cgroup lists, indexed by memcg_cache_id */
> -	struct list_lru_per_memcg __rcu	*mlru[];
> -};
> -
>  struct list_lru_node {
>  	/* protects all lists on the node, including per cgroup */
>  	spinlock_t		lock;
> @@ -57,10 +52,7 @@ struct list_lru {
>  	struct list_head	list;
>  	int			shrinker_id;
>  	bool			memcg_aware;
> -	/* protects ->mlrus->mlru[i] */
> -	spinlock_t		lock;
> -	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
> -	struct list_lru_memcg	__rcu *mlrus;
> +	struct xarray		xa;
>  #endif
>  };
> =20
> @@ -77,7 +69,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_awar=
e,
> =20
>  int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
>  			 gfp_t gfp);
> -int memcg_update_all_list_lrus(int num_memcgs);
>  void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup =
*parent);
> =20
>  /**
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0d6d838cadfd..1fe44ec5aa03 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1686,18 +1686,6 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, s=
ize_t size);
> =20
>  extern struct static_key_false memcg_kmem_enabled_key;
> =20
> -extern int memcg_nr_cache_ids;
> -void memcg_get_cache_ids(void);
> -void memcg_put_cache_ids(void);
> -
> -/*
> - * Helper macro to loop through all memcg-specific caches. Callers must st=
ill
> - * check if the cache is valid (it is either valid or NULL).
> - * the slab_mutex must be held when looping through those caches
> - */
> -#define for_each_memcg_cache_index(_idx)	\
> -	for ((_idx) =3D 0; (_idx) < memcg_nr_cache_ids; (_idx)++)
> -
>  static inline bool memcg_kmem_enabled(void)
>  {
>  	return static_branch_likely(&memcg_kmem_enabled_key);
> @@ -1754,9 +1742,6 @@ static inline void __memcg_kmem_uncharge_page(struct =
page *page, int order)
>  {
>  }
> =20
> -#define for_each_memcg_cache_index(_idx)	\
> -	for (; NULL; )
> -
>  static inline bool memcg_kmem_enabled(void)
>  {
>  	return false;
> @@ -1767,14 +1752,6 @@ static inline int memcg_cache_id(struct mem_cgroup *=
memcg)
>  	return -1;
>  }
> =20
> -static inline void memcg_get_cache_ids(void)
> -{
> -}
> -
> -static inline void memcg_put_cache_ids(void)
> -{
> -}
> -
>  static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  {
>         return NULL;
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 488dacd1f8ff..8dc1dabb9f05 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -52,21 +52,12 @@ static int lru_shrinker_id(struct list_lru *lru)
>  static inline struct list_lru_one *
>  list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>  {
> -	struct list_lru_memcg *mlrus;
> -	struct list_lru_node *nlru =3D &lru->node[nid];
> +	if (list_lru_memcg_aware(lru) && idx >=3D 0) {
> +		struct list_lru_per_memcg *mlru =3D xa_load(&lru->xa, idx);
> =20
> -	/*
> -	 * Either lock or RCU protects the array of per cgroup lists
> -	 * from relocation (see memcg_update_list_lru).
> -	 */
> -	mlrus =3D rcu_dereference_check(lru->mlrus, lockdep_is_held(&nlru->lock));
> -	if (mlrus && idx >=3D 0) {
> -		struct list_lru_per_memcg *mlru;
> -
> -		mlru =3D rcu_dereference_check(mlrus->mlru[idx], true);
>  		return mlru ? &mlru->node[nid] : NULL;
>  	}
> -	return &nlru->lru;
> +	return &lru->node[nid].lru;
>  }
> =20
>  static inline struct list_lru_one *
> @@ -77,7 +68,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *p=
tr,
>  	struct list_lru_one *l =3D &nlru->lru;
>  	struct mem_cgroup *memcg =3D NULL;
> =20
> -	if (!lru->mlrus)
> +	if (!list_lru_memcg_aware(lru))
>  		goto out;
> =20
>  	memcg =3D mem_cgroup_from_obj(ptr);
> @@ -309,16 +300,20 @@ unsigned long list_lru_walk_node(struct list_lru *lru=
, int nid,
>  				 unsigned long *nr_to_walk)
>  {
>  	long isolated =3D 0;
> -	int memcg_idx;
> =20
>  	isolated +=3D list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
>  				      nr_to_walk);
> +
> +#ifdef CONFIG_MEMCG_KMEM
>  	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> -		for_each_memcg_cache_index(memcg_idx) {
> +		struct list_lru_per_memcg *mlru;
> +		unsigned long index;
> +
> +		xa_for_each(&lru->xa, index, mlru) {
>  			struct list_lru_node *nlru =3D &lru->node[nid];
> =20
>  			spin_lock(&nlru->lock);
> -			isolated +=3D __list_lru_walk_one(lru, nid, memcg_idx,
> +			isolated +=3D __list_lru_walk_one(lru, nid, index,
>  							isolate, cb_arg,
>  							nr_to_walk);
>  			spin_unlock(&nlru->lock);
> @@ -327,6 +322,8 @@ unsigned long list_lru_walk_node(struct list_lru *lru, =
int nid,
>  				break;
>  		}
>  	}
> +#endif
> +
>  	return isolated;
>  }
>  EXPORT_SYMBOL_GPL(list_lru_walk_node);
> @@ -338,15 +335,6 @@ static void init_one_lru(struct list_lru_one *l)
>  }
> =20
>  #ifdef CONFIG_MEMCG_KMEM
> -static void memcg_destroy_list_lru_range(struct list_lru_memcg *mlrus,
> -					 int begin, int end)
> -{
> -	int i;
> -
> -	for (i =3D begin; i < end; i++)
> -		kfree(mlrus->mlru[i]);
> -}
> -
>  static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
>  {
>  	int nid;
> @@ -364,14 +352,7 @@ static struct list_lru_per_memcg *memcg_init_list_lru_=
one(gfp_t gfp)
> =20
>  static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
>  {
> -	struct list_lru_memcg *mlrus;
> -	struct list_lru_per_memcg *mlru;
> -
> -	spin_lock_irq(&lru->lock);
> -	mlrus =3D rcu_dereference_protected(lru->mlrus, true);
> -	mlru =3D rcu_dereference_protected(mlrus->mlru[src_idx], true);
> -	rcu_assign_pointer(mlrus->mlru[src_idx], NULL);
> -	spin_unlock_irq(&lru->lock);
> +	struct list_lru_per_memcg *mlru =3D xa_erase_irq(&lru->xa, src_idx);
> =20
>  	/*
>  	 * The __list_lru_walk_one() can walk the list of this node.
> @@ -383,78 +364,27 @@ static void memcg_list_lru_free(struct list_lru *lru,=
 int src_idx)
>  		kvfree_rcu(mlru, rcu);
>  }
> =20
> -static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
> +static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aw=
are)
>  {
> -	struct list_lru_memcg *mlrus;
> -	int size =3D memcg_nr_cache_ids;
> -
> +	if (memcg_aware)
> +		xa_init_flags(&lru->xa, XA_FLAGS_LOCK_IRQ);
>  	lru->memcg_aware =3D memcg_aware;
> -	if (!memcg_aware)
> -		return 0;
> -
> -	spin_lock_init(&lru->lock);
> -
> -	mlrus =3D kvzalloc(struct_size(mlrus, mlru, size), GFP_KERNEL);
> -	if (!mlrus)
> -		return -ENOMEM;
> -
> -	RCU_INIT_POINTER(lru->mlrus, mlrus);
> -
> -	return 0;
>  }
> =20
>  static void memcg_destroy_list_lru(struct list_lru *lru)
>  {
> -	struct list_lru_memcg *mlrus;
> +	XA_STATE(xas, &lru->xa, 0);
> +	struct list_lru_per_memcg *mlru;
> =20
>  	if (!list_lru_memcg_aware(lru))
>  		return;
> =20
> -	/*
> -	 * This is called when shrinker has already been unregistered,
> -	 * and nobody can use it. So, there is no need to use kvfree_rcu().
> -	 */
> -	mlrus =3D rcu_dereference_protected(lru->mlrus, true);
> -	memcg_destroy_list_lru_range(mlrus, 0, memcg_nr_cache_ids);
> -	kvfree(mlrus);
> -}
> -
> -static int memcg_update_list_lru(struct list_lru *lru, int old_size, int n=
ew_size)
> -{
> -	struct list_lru_memcg *old, *new;
> -
> -	BUG_ON(old_size > new_size);
> -
> -	old =3D rcu_dereference_protected(lru->mlrus,
> -					lockdep_is_held(&list_lrus_mutex));
> -	new =3D kvmalloc(struct_size(new, mlru, new_size), GFP_KERNEL);
> -	if (!new)
> -		return -ENOMEM;
> -
> -	spin_lock_irq(&lru->lock);
> -	memcpy(&new->mlru, &old->mlru, flex_array_size(new, mlru, old_size));
> -	memset(&new->mlru[old_size], 0, flex_array_size(new, mlru, new_size - old=
_size));
> -	rcu_assign_pointer(lru->mlrus, new);
> -	spin_unlock_irq(&lru->lock);
> -
> -	kvfree_rcu(old, rcu);
> -	return 0;
> -}
> -
> -int memcg_update_all_list_lrus(int new_size)
> -{
> -	int ret =3D 0;
> -	struct list_lru *lru;
> -	int old_size =3D memcg_nr_cache_ids;
> -
> -	mutex_lock(&list_lrus_mutex);
> -	list_for_each_entry(lru, &memcg_list_lrus, list) {
> -		ret =3D memcg_update_list_lru(lru, old_size, new_size);
> -		if (ret)
> -			break;
> +	xas_lock_irq(&xas);
> +	xas_for_each(&xas, mlru, ULONG_MAX) {
> +		kfree(mlru);
> +		xas_store(&xas, NULL);
>  	}
> -	mutex_unlock(&list_lrus_mutex);
> -	return ret;
> +	xas_unlock_irq(&xas);
>  }
> =20
>  static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
> @@ -521,7 +451,7 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg,=
 struct mem_cgroup *paren
>  		struct mem_cgroup *child;
> =20
>  		child =3D mem_cgroup_from_css(css);
> -		child->kmemcg_id =3D parent->kmemcg_id;
> +		WRITE_ONCE(child->kmemcg_id, parent->kmemcg_id);
>  	}
>  	rcu_read_unlock();
> =20
> @@ -531,21 +461,12 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memc=
g, struct mem_cgroup *paren
>  	mutex_unlock(&list_lrus_mutex);
>  }
> =20
> -static bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
> -				     struct list_lru *lru)
> +static inline bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
> +					    struct list_lru *lru)
>  {
> -	bool allocated;
> -	int idx;
> +	int idx =3D memcg->kmemcg_id;
> =20
> -	idx =3D memcg->kmemcg_id;
> -	if (unlikely(idx < 0))
> -		return true;
> -
> -	rcu_read_lock();
> -	allocated =3D !!rcu_access_pointer(rcu_dereference(lru->mlrus)->mlru[idx]=
);
> -	rcu_read_unlock();
> -
> -	return allocated;
> +	return idx < 0 || xa_load(&lru->xa, idx);
>  }
> =20
>  int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
> @@ -558,6 +479,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, stru=
ct list_lru *lru,
>  		struct list_lru_per_memcg *mlru;
>  		struct mem_cgroup *memcg;
>  	} *table;
> +	XA_STATE(xas, &lru->xa, 0);
> =20
>  	if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
>  		return 0;
> @@ -586,27 +508,48 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, st=
ruct list_lru *lru,
>  		}
>  	}
> =20
> -	spin_lock_irqsave(&lru->lock, flags);
> -	mlrus =3D rcu_dereference_protected(lru->mlrus, true);
> +	xas_lock_irqsave(&xas, flags);
>  	while (i--) {
> -		int index =3D table[i].memcg->kmemcg_id;
> +		int index =3D READ_ONCE(table[i].memcg->kmemcg_id);
>  		struct list_lru_per_memcg *mlru =3D table[i].mlru;
> =20
> -		if (index < 0 || rcu_dereference_protected(mlrus->mlru[index], true))
> +		xas_set(&xas, index);
> +retry:
> +		if (unlikely(index < 0 || xas_error(&xas) || xas_load(&xas))) {
>  			kfree(mlru);
> -		else
> -			rcu_assign_pointer(mlrus->mlru[index], mlru);
> +		} else {
> +			xas_store(&xas, mlru);
> +			if (xas_error(&xas) =3D=3D -ENOMEM) {
> +				xas_unlock_irqrestore(&xas, flags);
> +				if (xas_nomem(&xas, gfp))
> +					xas_set_err(&xas, 0);
> +				xas_lock_irqsave(&xas, flags);
> +				/*
> +				 * The xas lock has been released, this memcg
> +				 * can be reparented before us. So reload
> +				 * memcg id. More details see the comments
> +				 * in memcg_reparent_list_lrus().
> +				 */
> +				index =3D READ_ONCE(table[i].memcg->kmemcg_id);
> +				if (index < 0)
> +					xas_set_err(&xas, 0);
> +				else if (!xas_error(&xas) && index !=3D xas.xa_index)
> +					xas_set(&xas, index);
> +				goto retry;
> +			}
> +		}
>  	}
> -	spin_unlock_irqrestore(&lru->lock, flags);
> -
> +	/* xas_nomem() is used to free memory instead of memory allocation. */
> +	if (xas.xa_alloc)
> +		xas_nomem(&xas, gfp);
> +	xas_unlock_irqrestore(&xas, flags);
>  	kfree(table);
> =20
> -	return 0;
> +	return xas_error(&xas);
>  }
>  #else
> -static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
> +static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aw=
are)
>  {
> -	return 0;
>  }
> =20
>  static void memcg_destroy_list_lru(struct list_lru *lru)
> @@ -618,7 +561,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aw=
are,
>  		    struct lock_class_key *key, struct shrinker *shrinker)
>  {
>  	int i;
> -	int err =3D -ENOMEM;
> =20
>  #ifdef CONFIG_MEMCG_KMEM
>  	if (shrinker)
> @@ -626,11 +568,10 @@ int __list_lru_init(struct list_lru *lru, bool memcg_=
aware,
>  	else
>  		lru->shrinker_id =3D -1;
>  #endif
> -	memcg_get_cache_ids();
> =20
>  	lru->node =3D kcalloc(nr_node_ids, sizeof(*lru->node), GFP_KERNEL);
>  	if (!lru->node)
> -		goto out;
> +		return -ENOMEM;
> =20
>  	for_each_node(i) {
>  		spin_lock_init(&lru->node[i].lock);
> @@ -639,18 +580,10 @@ int __list_lru_init(struct list_lru *lru, bool memcg_=
aware,
>  		init_one_lru(&lru->node[i].lru);
>  	}
> =20
> -	err =3D memcg_init_list_lru(lru, memcg_aware);
> -	if (err) {
> -		kfree(lru->node);
> -		/* Do this so a list_lru_destroy() doesn't crash: */
> -		lru->node =3D NULL;
> -		goto out;
> -	}
> -
> +	memcg_init_list_lru(lru, memcg_aware);
>  	list_lru_register(lru);
> -out:
> -	memcg_put_cache_ids();
> -	return err;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(__list_lru_init);
> =20
> @@ -660,8 +593,6 @@ void list_lru_destroy(struct list_lru *lru)
>  	if (!lru->node)
>  		return;
> =20
> -	memcg_get_cache_ids();
> -
>  	list_lru_unregister(lru);
> =20
>  	memcg_destroy_list_lru(lru);
> @@ -671,6 +602,5 @@ void list_lru_destroy(struct list_lru *lru)
>  #ifdef CONFIG_MEMCG_KMEM
>  	lru->shrinker_id =3D -1;
>  #endif
> -	memcg_put_cache_ids();
>  }
>  EXPORT_SYMBOL_GPL(list_lru_destroy);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 87ee5b431c05..361ac289d8e9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -351,42 +351,17 @@ static void memcg_reparent_objcgs(struct mem_cgroup *=
memcg,
>   * This will be used as a shrinker list's index.
>   * The main reason for not using cgroup id for this:
>   *  this works better in sparse environments, where we have a lot of memcg=
s,
> - *  but only a few kmem-limited. Or also, if we have, for instance, 200
> - *  memcgs, and none but the 200th is kmem-limited, we'd have to have a
> - *  200 entry array for that.
> - *
> - * The current size of the caches array is stored in memcg_nr_cache_ids. It
> - * will double each time we have to increase it.
> + *  but only a few kmem-limited.
>   */
>  static DEFINE_IDA(memcg_cache_ida);
> -int memcg_nr_cache_ids;
> -
> -/* Protects memcg_nr_cache_ids */
> -static DECLARE_RWSEM(memcg_cache_ids_sem);
> -
> -void memcg_get_cache_ids(void)
> -{
> -	down_read(&memcg_cache_ids_sem);
> -}
> -
> -void memcg_put_cache_ids(void)
> -{
> -	up_read(&memcg_cache_ids_sem);
> -}
> =20
>  /*
> - * MIN_SIZE is different than 1, because we would like to avoid going thro=
ugh
> - * the alloc/free process all the time. In a small machine, 4 kmem-limited
> - * cgroups is a reasonable guess. In the future, it could be a parameter or
> - * tunable, but that is strictly not necessary.
> - *
>   * MAX_SIZE should be as large as the number of cgrp_ids. Ideally, we coul=
d get
>   * this constant directly from cgroup, but it is understandable that this =
is
>   * better kept as an internal representation in cgroup.c. In any case, the
>   * cgrp_id space is not getting any smaller, and we don't have to necessar=
ily
>   * increase ours as well if it increases.
>   */
> -#define MEMCG_CACHES_MIN_SIZE 4
>  #define MEMCG_CACHES_MAX_SIZE MEM_CGROUP_ID_MAX
> =20
>  /*
> @@ -2922,49 +2897,6 @@ __always_inline struct obj_cgroup *get_obj_cgroup_fr=
om_current(void)
>  	return objcg;
>  }
> =20
> -static int memcg_alloc_cache_id(void)
> -{
> -	int id, size;
> -	int err;
> -
> -	id =3D ida_simple_get(&memcg_cache_ida,
> -			    0, MEMCG_CACHES_MAX_SIZE, GFP_KERNEL);
> -	if (id < 0)
> -		return id;
> -
> -	if (id < memcg_nr_cache_ids)
> -		return id;
> -
> -	/*
> -	 * There's no space for the new id in memcg_caches arrays,
> -	 * so we have to grow them.
> -	 */
> -	down_write(&memcg_cache_ids_sem);
> -
> -	size =3D 2 * (id + 1);
> -	if (size < MEMCG_CACHES_MIN_SIZE)
> -		size =3D MEMCG_CACHES_MIN_SIZE;
> -	else if (size > MEMCG_CACHES_MAX_SIZE)
> -		size =3D MEMCG_CACHES_MAX_SIZE;
> -
> -	err =3D memcg_update_all_list_lrus(size);
> -	if (!err)
> -		memcg_nr_cache_ids =3D size;
> -
> -	up_write(&memcg_cache_ids_sem);
> -
> -	if (err) {
> -		ida_simple_remove(&memcg_cache_ida, id);
> -		return err;
> -	}
> -	return id;
> -}
> -
> -static void memcg_free_cache_id(int id)
> -{
> -	ida_simple_remove(&memcg_cache_ida, id);
> -}
> -
>  /*
>   * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a obj=
cg
>   * @objcg: object cgroup to uncharge
> @@ -3619,13 +3551,14 @@ static int memcg_online_kmem(struct mem_cgroup *mem=
cg)
>  	if (unlikely(mem_cgroup_is_root(memcg)))
>  		return 0;
> =20
> -	memcg_id =3D memcg_alloc_cache_id();
> +	memcg_id =3D ida_alloc_max(&memcg_cache_ida, MEMCG_CACHES_MAX_SIZE - 1,
> +				 GFP_KERNEL);
>  	if (memcg_id < 0)
>  		return memcg_id;
> =20
>  	objcg =3D obj_cgroup_alloc();
>  	if (!objcg) {
> -		memcg_free_cache_id(memcg_id);
> +		ida_free(&memcg_cache_ida, memcg_id);
>  		return -ENOMEM;
>  	}
>  	objcg->memcg =3D memcg;
> @@ -3669,7 +3602,7 @@ static void memcg_offline_kmem(struct mem_cgroup *mem=
cg)
>  	 */
>  	memcg_reparent_list_lrus(memcg, parent);
> =20
> -	memcg_free_cache_id(kmemcg_id);
> +	ida_free(&memcg_cache_ida, kmemcg_id);
>  }
>  #else
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
> --=20
> 2.11.0
>=20
>=20
