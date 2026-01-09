Return-Path: <linux-fsdevel+bounces-73063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D2D0B17A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3B9C301515E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E27347C6;
	Fri,  9 Jan 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="duTcYuly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517914F70
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974423; cv=none; b=G2ho+4C5/bGVYFjgJLf67Xk1lUdM/lZZmXmeSLzcKuQUcMNTTQAwzBZvBkWVdQ1uGvavZZNlTxdO+MHyL17Y5XaIlwPYqKXRXRaTjo8FSD7Ggba/PTIB6n1u6a8Xbqh8qUAGDL4hJ1qBII42xKsD6Z6wHBYx8I4XKsnt3LviIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974423; c=relaxed/simple;
	bh=gomJotxWW8NkYaNCgEbIn1dGI/O/yCHmiC2zmSSFvTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO4oVgQZo+2BT7v7xJuWkG0xG7dvy2DBUE4LBklEiPENG0dphQGvQaWpWFl8myK2+Dkp3RjUYkaK+1pQW2klelZs6dOlfqNFv8juTSPehLbTYOQUdPmkpZRmZhsT7lsVnT2sdh+i5U/Raz0HlKS2vEZOw1qh9EQhofAh1fijW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=duTcYuly; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 9 Jan 2026 16:00:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767974418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5LAdhOCCc8N41wLK+KHHr42/lhH/TW4Y/qOP6oJbhM=;
	b=duTcYulyLdWHtvP4Q8YAlW6mTv845miu1bdA/mIk/vToHI6CugjQw322Jf709n/7q2LkUI
	iwmuedRmZe5i0/w1YslWme1xHC/2GmJcu7XkAYZ/3pLBQhCZ2036aJeXlSsk37SEdcMIDP
	VHyJwH0lH61D2s6KyefTV3iQPtSt5wU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	ziy@nvidia.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, 
	rientjes@google.com, shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108203755.1163107-8-gourry@gourry.net>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> If a private zswap-node is available, skip the entire software
> compression process and memcpy directly to a compressed memory
> folio, and store the newly allocated compressed memory page as
> the zswap entry->handle.
> 
> On decompress we do the opposite: copy directly from the stored
> page to the destination, and free the compressed memory page.
> 
> The driver callback is responsible for preventing run-away
> compression ratio failures by checking that the allocated page is
> safe to use (i.e. a compression ratio limit hasn't been crossed).
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Hi Gregory,

Thanks for sending this, I have a lot of questions/comments below, but
from a high-level I am trying to understand the benefit of using a
compressed node for zswap rather than as a second tier.

If the memory is byte-addressable, using it as a second tier makes it
directly accessible without page faults, so the access latency is much
better than a swapped out page in zswap.

Are there some HW limitations that allow a node to be used as a backend
for zswap but not a second tier?

Or is the idea to make promotions from compressed memory to normal
memory fault-driver instead of relying on page hotness?

I also think there are some design decisions that need to be made before
we commit to this, see the comments below for more.

> ---
>  include/linux/zswap.h |   5 ++
>  mm/zswap.c            | 106 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 109 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 30c193a1207e..4b52fe447e7e 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -35,6 +35,8 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
>  void zswap_folio_swapin(struct folio *folio);
>  bool zswap_is_enabled(void);
>  bool zswap_never_enabled(void);
> +void zswap_add_direct_node(int nid);
> +void zswap_remove_direct_node(int nid);
>  #else
>  
>  struct zswap_lruvec_state {};
> @@ -69,6 +71,9 @@ static inline bool zswap_never_enabled(void)
>  	return true;
>  }
>  
> +static inline void zswap_add_direct_node(int nid) {}
> +static inline void zswap_remove_direct_node(int nid) {}
> +
>  #endif
>  
>  #endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/zswap.c b/mm/zswap.c
> index de8858ff1521..aada588c957e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -35,6 +35,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/list_lru.h>
>  #include <linux/zsmalloc.h>
> +#include <linux/node.h>
>  
>  #include "swap.h"
>  #include "internal.h"
> @@ -190,6 +191,7 @@ struct zswap_entry {
>  	swp_entry_t swpentry;
>  	unsigned int length;
>  	bool referenced;
> +	bool direct;
>  	struct zswap_pool *pool;
>  	unsigned long handle;
>  	struct obj_cgroup *objcg;
> @@ -199,6 +201,20 @@ struct zswap_entry {
>  static struct xarray *zswap_trees[MAX_SWAPFILES];
>  static unsigned int nr_zswap_trees[MAX_SWAPFILES];
>  
> +/* Nodemask for compressed RAM nodes used by zswap_compress_direct */
> +static nodemask_t zswap_direct_nodes = NODE_MASK_NONE;
> +
> +void zswap_add_direct_node(int nid)
> +{
> +	node_set(nid, zswap_direct_nodes);
> +}
> +
> +void zswap_remove_direct_node(int nid)
> +{
> +	if (!node_online(nid))
> +		node_clear(nid, zswap_direct_nodes);
> +}
> +
>  /* RCU-protected iteration */
>  static LIST_HEAD(zswap_pools);
>  /* protects zswap_pools list modification */
> @@ -716,7 +732,13 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
>  	zswap_lru_del(&zswap_list_lru, entry);
> -	zs_free(entry->pool->zs_pool, entry->handle);
> +	if (entry->direct) {
> +		struct page *page = (struct page *)entry->handle;

Would it be cleaner to add a union in zswap_entry that has entry->handle
and entry->page?

> +
> +		node_private_freed(page);
> +		__free_page(page);
> +	} else
> +		zs_free(entry->pool->zs_pool, entry->handle);
>  	zswap_pool_put(entry->pool);
>  	if (entry->objcg) {
>  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> @@ -849,6 +871,58 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
>  	mutex_unlock(&acomp_ctx->mutex);
>  }
>  
> +static struct page *zswap_compress_direct(struct page *src,
> +					  struct zswap_entry *entry)
> +{
> +	int nid;
> +	struct page *dst;
> +	gfp_t gfp;
> +	nodemask_t tried_nodes = NODE_MASK_NONE;
> +
> +	if (nodes_empty(zswap_direct_nodes))
> +		return NULL;
> +
> +	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE |
> +	      __GFP_THISNODE;
> +
> +	for_each_node_mask(nid, zswap_direct_nodes) {
> +		int ret;
> +
> +		/* Skip nodes we've already tried and failed */
> +		if (node_isset(nid, tried_nodes))
> +			continue;

Why do we need this? Does for_each_node_mask() iterate each node more
than once?

> +
> +		dst = __alloc_pages(gfp, 0, nid, &zswap_direct_nodes);
> +		if (!dst)
> +			continue;
> +
> +		/*
> +		 * Check with the device driver that this page is safe to use.
> +		 * If the device reports an error (e.g., compression ratio is
> +		 * too low and the page can't safely store data), free the page
> +		 * and try another node.
> +		 */
> +		ret = node_private_allocated(dst);
> +		if (ret) {
> +			__free_page(dst);
> +			node_set(nid, tried_nodes);
> +			continue;
> +		}

I think we can drop the 'found' label by moving things around, would
this be simpler?

	for_each_node_mask(..) {
		...
		ret = node_private_allocated(dst);
		if (!ret)
			break;

		__free_page(dst);
		dst = NULL;
	}

	if (!dst)
		return NULL;

	if (copy_mc_highpage(..) {
		..
	}
	return dst;
		

> +
> +		goto found;
> +	}
> +
> +	return NULL;
> +
> +found:
> +	/* If we fail to copy at this point just fallback */
> +	if (copy_mc_highpage(dst, src)) {
> +		__free_page(dst);
> +		dst = NULL;
> +	}
> +	return dst;
> +}
> +

So the CXL code tells zswap what nodes are usable, then zswap tries
getting a page from these nodes and checking them using APIs provided by
the CXL code.

Wouldn't it be a better abstraction if the nodemask lived in the CXL
code and an API was exposed to zswap just to allocate a page to copy to?
Or we can abstract the copy as well and provide an API that directly
tries to copy the page to the compressible node.

IOW move zswap_compress_direct() (probably under a different name?) and
zswap_direct_nodes into CXL code since it's not really zswap logic.

Also, I am not sure if the zswap_compress_direct() call and check would
introduce any latency, since almost all existing callers will pay for it
without benefiting.

If we move the function into CXL code, we could probably have an inline
wrapper in a header with a static key guarding it to make there is no
overhead for existing users.

>  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  			   struct zswap_pool *pool)
>  {
> @@ -860,6 +934,17 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	gfp_t gfp;
>  	u8 *dst;
>  	bool mapped = false;
> +	struct page *zpage;
> +
> +	/* Try to shunt directly to compressed ram */
> +	zpage = zswap_compress_direct(page, entry);
> +	if (zpage) {
> +		entry->handle = (unsigned long)zpage;
> +		entry->length = PAGE_SIZE;
> +		entry->direct = true;
> +		return true;
> +	}

I don't think this works. Setting entry->length = PAGE_SIZE will cause a
few problems, off the top of my head:

1. An entire page of memory will be charged to the memcg, so swapping
out the page won't reduce the memcg usage, which will cause thrashing
(reclaim with no progress when hitting the limit).

Ideally we'd get the compressed length from HW and record it here to
charge it appropriately, but I am not sure how we actually want to
charge memory on a compressed node. Do we charge the compressed size as
normal memory? Does it need separate charging and a separate limit?

There are design discussions to be had before we commit to something.

2. The page will be incorrectly counted in
zswap_stored_incompressible_pages.

Aside from that, zswap_total_pages() will be wrong now, as it gets the
pool size from zsmalloc and these pages are not allocated from zsmalloc.
This is used when checking the pool limits and is exposed in stats.

> +	/* otherwise fallback to normal zswap */
>  
>  	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
>  	dst = acomp_ctx->buffer;
> @@ -913,6 +998,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	zs_obj_write(pool->zs_pool, handle, dst, dlen);
>  	entry->handle = handle;
>  	entry->length = dlen;
> +	entry->direct = false;
>  
>  unlock:
>  	if (mapped)
> @@ -936,6 +1022,15 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	int decomp_ret = 0, dlen = PAGE_SIZE;
>  	u8 *src, *obj;
>  
> +	/* compressed ram page */
> +	if (entry->direct) {
> +		struct page *src = (struct page *)entry->handle;
> +		struct folio *zfolio = page_folio(src);
> +
> +		memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);

Why are we using memcpy_folio() here but copy_mc_highpage() on the
compression path? Are they equivalent?

> +		goto direct_done;
> +	}
> +
>  	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
>  	obj = zs_obj_read_begin(pool->zs_pool, entry->handle, acomp_ctx->buffer);
>  
> @@ -969,6 +1064,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	zs_obj_read_end(pool->zs_pool, entry->handle, obj);
>  	acomp_ctx_put_unlock(acomp_ctx);
>  
> +direct_done:
>  	if (!decomp_ret && dlen == PAGE_SIZE)
>  		return true;
>  
> @@ -1483,7 +1579,13 @@ static bool zswap_store_page(struct page *page,
>  	return true;
>  
>  store_failed:
> -	zs_free(pool->zs_pool, entry->handle);
> +	if (entry->direct) {
> +		struct page *freepage = (struct page *)entry->handle;
> +
> +		node_private_freed(freepage);
> +		__free_page(freepage);
> +	} else
> +		zs_free(pool->zs_pool, entry->handle);

This code is repeated in zswap_entry_free(), we should probably wrap it
in a helper that frees the private page or the zsmalloc entry based on
entry->direct.

>  compress_failed:
>  	zswap_entry_cache_free(entry);
>  	return false;
> -- 
> 2.52.0
> 

