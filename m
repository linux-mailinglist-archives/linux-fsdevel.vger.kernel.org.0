Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFC392DA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhE0MKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhE0MK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 08:10:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B09C061574;
        Thu, 27 May 2021 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UitDoJucuhEdG/aM9azc+2/HTAq0NOoRnbDihbDzzho=; b=vstICU0+6ZbfxFC4m6nq8iLf5X
        3AdMeNeK+5PwwJu7seQNrzGRWwGr04a/lb/2pWhtx0iMI5mF568mCl+xMk2R48pSapKggg6u0+iaj
        vgd0tf0K1/zERYTKteIF/hssuPTxumd253OLLxowiMR9UfjsN0aRY4SRPLMKBN7VVRf2esgZp3stI
        GMnLZQcoSWz/XlshaokKG0lXOxrj+2PPJgLwh7gOdiCbbkuMZCa59LOgX2ZCyi1ZxgAcLti5mJJ+B
        6XDxDMBqk4f/EH3oW+ZX7aGeo/Hx84Rc+fM+l41Lfo1n5/xaIynydrisYKLkdu6Sb6fF/5oljTBaL
        0hIvanUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmEnV-005VKO-9A; Thu, 27 May 2021 12:07:43 +0000
Date:   Thu, 27 May 2021 13:07:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, guro@fb.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        david@fromorbit.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH v2 17/21] mm: list_lru: replace linear array with xarray
Message-ID: <YK+LhWvabd+KQWOJ@casper.infradead.org>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
 <20210527062148.9361-18-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527062148.9361-18-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 27, 2021 at 02:21:44PM +0800, Muchun Song wrote:
> If we run 10k containers in the system, the size of the
> list_lru_memcg->lrus can be ~96KB per list_lru. When we decrease the
> number containers, the size of the array will not be shrinked. It is
> not scalable. The xarray is a good choice for this case. We can save
> a lot of memory when there are tens of thousands continers in the
> system. If we use xarray, we also can remove the logic code of
> resizing array, which can simplify the code.

I am all for this, in concept.  Some thoughts below ...

> @@ -56,10 +51,8 @@ struct list_lru {
>  #ifdef CONFIG_MEMCG_KMEM
>  	struct list_head	list;
>  	int			shrinker_id;
> -	/* protects ->memcg_lrus->lrus[i] */
> -	spinlock_t		lock;
>  	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
> -	struct list_lru_memcg	__rcu *memcg_lrus;
> +	struct xarray		*xa;
>  #endif

Normally, we embed an xarray in its containing structure instead of
allocating it.  It's only a pointer, int and spinlock, so generally
16 bytes, as opposed to the 8 bytes for the pointer and a 16 byte
allocation.  There is a minor wrinkle in that currently 'NULL' is
used to indicate "is not cgroup aware".  Maybe there's another way
to indicate that?

> @@ -51,22 +51,12 @@ static int lru_shrinker_id(struct list_lru *lru)
>  static inline struct list_lru_one *
>  list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>  {
> -	struct list_lru_memcg *memcg_lrus;
> -	struct list_lru_node *nlru = &lru->node[nid];
> +	if (list_lru_memcg_aware(lru) && idx >= 0) {
> +		struct list_lru_per_memcg *mlru = xa_load(lru->xa, idx);
>  
> -	/*
> -	 * Either lock or RCU protects the array of per cgroup lists
> -	 * from relocation (see memcg_update_list_lru).
> -	 */
> -	memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
> -					   lockdep_is_held(&nlru->lock));
> -	if (memcg_lrus && idx >= 0) {
> -		struct list_lru_per_memcg *mlru;
> -
> -		mlru = rcu_dereference_check(memcg_lrus->lrus[idx], true);
>  		return mlru ? &mlru->nodes[nid] : NULL;
>  	}
> -	return &nlru->lru;
> +	return &lru->node[nid].lru;
>  }

... perhaps we move the xarray out from under the #ifdef and use index 0
for non-memcg-aware lrus?  The XArray is specially optimised for arrays
which only have one entry at 0.

>  int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t gfp)
>  {
> +	XA_STATE(xas, lru->xa, 0);
>  	unsigned long flags;
> -	struct list_lru_memcg *memcg_lrus;
> -	int i;
> +	int i, ret = 0;
>  
>  	struct list_lru_memcg_table {
>  		struct list_lru_per_memcg *mlru;
> @@ -601,22 +522,45 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
>  		}
>  	}
>  
> -	spin_lock_irqsave(&lru->lock, flags);
> -	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
> +	xas_lock_irqsave(&xas, flags);
>  	while (i--) {
>  		int index = memcg_cache_id(table[i].memcg);
>  		struct list_lru_per_memcg *mlru = table[i].mlru;
>  
> -		if (index < 0 || rcu_dereference_protected(memcg_lrus->lrus[index], true))
> +		xas_set(&xas, index);
> +retry:
> +		if (unlikely(index < 0 || ret || xas_load(&xas))) {
>  			kfree(mlru);
> -		else
> -			rcu_assign_pointer(memcg_lrus->lrus[index], mlru);
> +		} else {
> +			ret = xa_err(xas_store(&xas, mlru));

This is mixing advanced and normal XArray concepts ... sorry to have
confused you.  I think what you meant to do here was:

			xas_store(&xas, mlru);
			ret = xas_error(&xas);

Or you can avoid introducing 'ret' at all, and keep your errors in the
xa_state.  You're kind of mirroring the xa_state errors into 'ret'
anyway, so that seems easier to understand?

> -	memcg_id = memcg_alloc_cache_id();
> +	memcg_id = ida_simple_get(&memcg_cache_ida, 0, MEMCG_CACHES_MAX_SIZE,
> +				  GFP_KERNEL);

	memcg_id = ida_alloc_max(&memcg_cache_ida,
			MEMCG_CACHES_MAX_SIZE - 1, GFP_KERNEL);

... although i think there's actually a fencepost error, and this really
should be MEMCG_CACHES_MAX_SIZE.

>  	objcg = obj_cgroup_alloc();
>  	if (!objcg) {
> -		memcg_free_cache_id(memcg_id);
> +		ida_simple_remove(&memcg_cache_ida, memcg_id);

		ida_free(&memcg_cache_ida, memcg_id);

