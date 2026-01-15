Return-Path: <linux-fsdevel+bounces-73875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E53D2267D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8178302DCBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435992D73B4;
	Thu, 15 Jan 2026 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YsDtZ6JY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47823D297
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768453366; cv=none; b=MWT105+YjgVK+yiZ/pQREHL8VxRVlWfvevwy97mnURJMa2AAYBGfTY9gbcgT8/rCijuyHKuTAKY3F2sXZm0w10y++I7jgq4MHx7EghlgDuSkFE7WJxBnA3T473cdwdBv8Zy0bgxeQ6W2PDwiyyihcC/qUr+lS2Haj8UF2WxoO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768453366; c=relaxed/simple;
	bh=96QnO8GhnSDi6D4+gV1BRh5HhaYdMV8l6XsKY5zu23E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyHOTKhQ4BhX/5Ag90K73kGNBgHPYCiFvfZF8WEgHjI/31Myax5RxtHXtBFRN/TiPT34w7ymrgPS0W4g2PERGrHN8wCChZGXm7rqZp1rWXDFGvZP66oYxMtGU3vBl1UPTeCdcWOpLSLq/B36fLKQGRlqtSh82d55CrIeYg9jAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YsDtZ6JY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c56188aef06so235236a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1768453364; x=1769058164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHtMZy+1Hf+5CFrdMNdv7JLbvIeaLMOR/Q+6FgomzqM=;
        b=YsDtZ6JYlo32u0xjTir32KmOQHqbYQmnBSRqLoN745hs7qJFVCVV1Tm8hD1Wh2GFdW
         uN0c3yZoDUAKpBm9rd7HfCaeDgtsdu3ZAHBu55JoAfHu+qMRwFa7NVd7MbKzJWWmtzbA
         eLuriJi5GAml1iMXqXohCgCFosonStBs0mTtwpGwgXMGne3bYI6n7Vzgb9zEWNZOi7U9
         VfXaoqK3SNiVCR9T/A69Q79kjIvwuWo2cUZPBZpzJL743RjI735Rsp/tdXPHN3dxqvnc
         Jt4TFVzsdDv5OzqPGMrakbwUJYLpJCGBLOiiVMXlLHiBwXVyw9RkdOTYRq95/OUNFEys
         Mh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768453364; x=1769058164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHtMZy+1Hf+5CFrdMNdv7JLbvIeaLMOR/Q+6FgomzqM=;
        b=TE7JTk/3EyRZX5lJij+MWuC37SHrMW7X9wtesU41QUixAL3dChzIIWRgY00bmG5vft
         CYLP1A6v+qTZJcjpBBpZjc+oJFrvStpOqhYsH5ab0T94FUd5VLfS6eGRBMQprq+SLjrP
         kJWqeU2qO73Npqr6MURKXoFe8ZRaRgmdB7unUrZgLjjZYx1tZIEciBDTXOv2LJZ6WeKs
         UFtUevFkpmt+qmPd+XYpMThl2p31yyr6c3ClMYjfR1s2CjZRkKumIolMbASeeEGpnRLo
         fISbTlAvqYd4acYn6+z2I8YxNX/Z5X+BboEjm0vR71bREHm0m8wfsatPz7KDDSAZWJiv
         RamQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT59BA3AyKT+2qhBySrU4jMSHkPc5JINw7cE3JT40t1Rcfl+W91+uskEtuYS/001D2tcOjpYLErzf86vvZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBBYUl/NZk/W2kjGorwcBbsAC5vACUCstNW2zFiTT5eUDkNzB
	BJL7riqIZAaiTI6+xngONFjf7z2Y5vkt6nL1FHPBYOQHvR1BfsASz8kh9Puz6NP9kJc=
X-Gm-Gg: AY/fxX4IjSoJiLB+BlA8GsIHmz6kLEMyZhmW2LssseuiEeeUHknv+NDXVErfbSgIjj4
	joyzx8dFlnBsszj7+pbef1losLVHMgIAJgWw2rynlaFvk/4zFaE+xrHNY1Ppp+2WsCa9bwpWmIQ
	lyCC4qVMfFsTcjbnqX20rylmQ9kLQ7IVsvwYABEzSE5gJ52AGhOUdesAurBmJHnDfMwcpfZol3j
	1RhMd9vjiYbo2M2bMG5TUXj33HTQtid8ffP8ym67Sj5gdQp0/EmnW1cpUn3LtrQxDsK3NJVpWXe
	hB2+pifWXBTzQl3i1wwWdngC79occHalI8mql8/A38PWuvcp83H6VfKoocwmE1sRHyKOZZqixtD
	xJctmRkKmlBdQa3b3AjYNAnSPynQ6bksm1R/3j1ZVdvezQpSJh4dHoZQsNKR5G2U8D8FkYZVbVk
	JBa+5WU55AnNGb4ONvCUDPZv3DC7YQHCJgJ9XZ0Jg1iDeu4PwoZZIxrDsS+q6HSgY=
X-Received: by 2002:a05:6a20:9191:b0:341:262f:6510 with SMTP id adf61e73a8af0-38befbcabdamr4401639637.41.1768453363467;
        Wed, 14 Jan 2026 21:02:43 -0800 (PST)
Received: from dread.disaster.area (pa49-180-164-75.pa.nsw.optusnet.com.au. [49.180.164.75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5dbfsm23665476a12.27.2026.01.14.21.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 21:02:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.99.1)
	(envelope-from <david@fromorbit.com>)
	id 1vgFVB-00000003cVO-2mpR;
	Thu, 15 Jan 2026 16:02:33 +1100
Date: Thu, 15 Jan 2026 16:02:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: guzebing <guzebing1612@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, guzebing@bytedance.com,
	syzbot@syzkaller.appspotmail.com,
	Fengnan Chang <changfengnan@bytedance.com>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] iomap: add allocation cache for iomap_dio
Message-ID: <aWh06YoiJrR3-J-X@dread.disaster.area>
References: <20260115021108.1913695-1-guzebing1612@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115021108.1913695-1-guzebing1612@gmail.com>

[cc linux-mm]

On Thu, Jan 15, 2026 at 10:11:08AM +0800, guzebing wrote:
> As implemented by the bio structure, we do the same thing on the
> iomap-dio structure. Add a per-cpu cache for iomap_dio allocations,
> enabling us to quickly recycle them instead of going through the slab
> allocator.
> 
> By making such changes, we can reduce memory allocation on the direct
> IO path, so that direct IO will not block due to insufficient system
> memory. In addition, for direct IO, the read performance of io_uring
> is improved by about 2.6%.

Honestly, this just feels wrong.

If heap memory allocation has performance issues, then the right
solution is to fix the memory allocator.

Oh, wait, you're copy-pasting the hacky per-cpu bio allocator cache
lists into the iomap DIO code.

IMO, this really should be part of the generic memory allocation
APIs, not repeatedly tacked on the outside of specific individual
object allocations.

<thinks a bit>

Huh. per-cpu free lists is the traditional SLAB allocator
architecture. That was removed a while back because SLUB performs
better in most cases....

<thinks a bit more>

ISTR somebody was already working to optimise the SLUB allocator to
address these corner case shortcomings w.r.t. traditional SLABs.

Yup:


commit 2d517aa09bbc4203f10cdee7e1d42f3bbdc1b1cd
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Wed Sep 3 14:59:45 2025 +0200

    slab: add opt-in caching layer of percpu sheaves

    Specifying a non-zero value for a new struct kmem_cache_args field
    sheaf_capacity will setup a caching layer of percpu arrays called
    sheaves of given capacity for the created cache.

    Allocations from the cache will allocate via the percpu sheaves (main or
    spare) as long as they have no NUMA node preference. Frees will also
    put the object back into one of the sheaves.

    When both percpu sheaves are found empty during an allocation, an empty
    sheaf may be replaced with a full one from the per-node barn. If none
    are available and the allocation is allowed to block, an empty sheaf is
    refilled from slab(s) by an internal bulk alloc operation. When both
    percpu sheaves are full during freeing, the barn can replace a full one
    with an empty one, unless over a full sheaves limit. In that case a
    sheaf is flushed to slab(s) by an internal bulk free operation. Flushing
    sheaves and barns is also wired to the existing cpu flushing and cache
    shrinking operations.

    The sheaves do not distinguish NUMA locality of the cached objects. If
    an allocation is requested with kmem_cache_alloc_node() (or a mempolicy
    with strict_numa mode enabled) with a specific node (not NUMA_NO_NODE),
    the sheaves are bypassed.

    The bulk operations exposed to slab users also try to utilize the
    sheaves as long as the necessary (full or empty) sheaves are available
    on the cpu or in the barn. Once depleted, they will fallback to bulk
    alloc/free to slabs directly to avoid double copying.

    The sheaf_capacity value is exported in sysfs for observability.

    Sysfs CONFIG_SLUB_STATS counters alloc_cpu_sheaf and free_cpu_sheaf
    count objects allocated or freed using the sheaves (and thus not
    counting towards the other alloc/free path counters). Counters
    sheaf_refill and sheaf_flush count objects filled or flushed from or to
    slab pages, and can be used to assess how effective the caching is. The
    refill and flush operations will also count towards the usual
    alloc_fastpath/slowpath, free_fastpath/slowpath and other counters for
    the backing slabs.  For barn operations, barn_get and barn_put count how
    many full sheaves were get from or put to the barn, the _fail variants
    count how many such requests could not be satisfied mainly  because the
    barn was either empty or full. While the barn also holds empty sheaves
    to make some operations easier, these are not as critical to mandate own
    counters.  Finally, there are sheaf_alloc/sheaf_free counters.

    Access to the percpu sheaves is protected by local_trylock() when
    potential callers include irq context, and local_lock() otherwise (such
    as when we already know the gfp flags allow blocking). The trylock
    failures should be rare and we can easily fallback. Each per-NUMA-node
    barn has a spin_lock.

    When slub_debug is enabled for a cache with sheaf_capacity also
    specified, the latter is ignored so that allocations and frees reach the
    slow path where debugging hooks are processed. Similarly, we ignore it
    with CONFIG_SLUB_TINY which prefers low memory usage to performance.

    [boot failure: https://lore.kernel.org/all/583eacf5-c971-451a-9f76-fed0e341b815@linux.ibm.com/ ]

    Reported-and-tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
    Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
    Reviewed-by: Suren Baghdasaryan <surenb@google.com>
    Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Yeah, recent code, functionality is not enabled by default yet. So,
kmem_cache_alloc() with:

struct kmem_cache_args {
.....
        /**
         * @sheaf_capacity: Enable sheaves of given capacity for the cache.
         *
         * With a non-zero value, allocations from the cache go through caching
         * arrays called sheaves. Each cpu has a main sheaf that's always
         * present, and a spare sheaf that may be not present. When both become
         * empty, there's an attempt to replace an empty sheaf with a full sheaf
         * from the per-node barn.
         *
         * When no full sheaf is available, and gfp flags allow blocking, a
         * sheaf is allocated and filled from slab(s) using bulk allocation.
         * Otherwise the allocation falls back to the normal operation
         * allocating a single object from a slab.
         *
         * Analogically when freeing and both percpu sheaves are full, the barn
         * may replace it with an empty sheaf, unless it's over capacity. In
         * that case a sheaf is bulk freed to slab pages.
         *
         * The sheaves do not enforce NUMA placement of objects, so allocations
         * via kmem_cache_alloc_node() with a node specified other than
         * NUMA_NO_NODE will bypass them.
         *
         * Bulk allocation and free operations also try to use the cpu sheaves
         * and barn, but fallback to using slab pages directly.
         *
         * When slub_debug is enabled for the cache, the sheaf_capacity argument
         * is ignored.
         *
         * %0 means no sheaves will be created.
         */
        unsigned int sheaf_capacity;
}

set to the value required is all we need. i.e. something like this
in iomap_dio_init():


	struct kmem_cache_args kmem_args = {
		.sheaf_capacity = 256,
	};

	dio_kmem_cache = kmem_cache_create("iomap_dio", sizeof(struct iomap_dio),
			&kmem_args, SLAB_PANIC | SLAB_ACCOUNT

And changing the allocation to kmem_cache_alloc(dio_kmem_cache,
GFP_KERNEL) should provide the same sort of performance improvement
as this patch does.

Can you test this, please?

If it doesn't provide any performance improvment, then I suspect
that Vlastimil will be interested to find out why....

Also, if it does work, it is likely the bioset mempools (which are
slab based) can be initialised similarly, removing the need for
custom per-cpu free lists in the block layer, too.

-Dave.

> 
> v3:
> kmalloc now is called outside the get_cpu/put_cpu code section.
> 
> v2:
> Factor percpu cache into common code and the iomap module uses it.
> 
> v1:
> https://lore.kernel.org/all/20251121090052.384823-1-guzebing1612@gmail.com/
> 
> Tested-by: syzbot@syzkaller.appspotmail.com
> 
> Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
> Signed-off-by: guzebing <guzebing1612@gmail.com>
> ---
>  fs/iomap/direct-io.c | 133 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 130 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 5d5d63efbd57..4421e4ad3a8f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -56,6 +56,130 @@ struct iomap_dio {
>  	};
>  };
>  
> +#define PCPU_CACHE_IRQ_THRESHOLD	16
> +#define PCPU_CACHE_ELEMENT_SIZE(pcpu_cache_list) \
> +	(sizeof(struct pcpu_cache_element) + pcpu_cache_list->element_size)
> +#define PCPU_CACHE_ELEMENT_GET_HEAD_FROM_PAYLOAD(payload) \
> +	((struct pcpu_cache_element *)((unsigned long)(payload) - \
> +				       sizeof(struct pcpu_cache_element)))
> +#define PCPU_CACHE_ELEMENT_GET_PAYLOAD_FROM_HEAD(head) \
> +	((void *)((unsigned long)(head) + sizeof(struct pcpu_cache_element)))
> +
> +struct pcpu_cache_element {
> +	struct pcpu_cache_element	*next;
> +	char	payload[];
> +};
> +struct pcpu_cache {
> +	struct pcpu_cache_element	*free_list;
> +	struct pcpu_cache_element	*free_list_irq;
> +	int		nr;
> +	int		nr_irq;
> +};
> +struct pcpu_cache_list {
> +	struct pcpu_cache __percpu *cache;
> +	size_t element_size;
> +	int max_nr;
> +};
> +
> +static struct pcpu_cache_list *pcpu_cache_list_create(int max_nr, size_t size)
> +{
> +	struct pcpu_cache_list *pcpu_cache_list;
> +
> +	pcpu_cache_list = kmalloc(sizeof(struct pcpu_cache_list), GFP_KERNEL);
> +	if (!pcpu_cache_list)
> +		return NULL;
> +
> +	pcpu_cache_list->element_size = size;
> +	pcpu_cache_list->max_nr = max_nr;
> +	pcpu_cache_list->cache = alloc_percpu(struct pcpu_cache);
> +	if (!pcpu_cache_list->cache) {
> +		kfree(pcpu_cache_list);
> +		return NULL;
> +	}
> +	return pcpu_cache_list;
> +}
> +
> +static void pcpu_cache_list_destroy(struct pcpu_cache_list *pcpu_cache_list)
> +{
> +	free_percpu(pcpu_cache_list->cache);
> +	kfree(pcpu_cache_list);
> +}
> +
> +static void irq_cache_splice(struct pcpu_cache *cache)
> +{
> +	unsigned long flags;
> +
> +	/* cache->free_list must be empty */
> +	if (WARN_ON_ONCE(cache->free_list))
> +		return;
> +
> +	local_irq_save(flags);
> +	cache->free_list = cache->free_list_irq;
> +	cache->free_list_irq = NULL;
> +	cache->nr += cache->nr_irq;
> +	cache->nr_irq = 0;
> +	local_irq_restore(flags);
> +}
> +
> +static void *pcpu_cache_list_alloc(struct pcpu_cache_list *pcpu_cache_list)
> +{
> +	struct pcpu_cache *cache;
> +	struct pcpu_cache_element *cache_element;
> +
> +	cache = per_cpu_ptr(pcpu_cache_list->cache, get_cpu());
> +	if (!cache->free_list) {
> +		if (READ_ONCE(cache->nr_irq) >= PCPU_CACHE_IRQ_THRESHOLD)
> +			irq_cache_splice(cache);
> +		if (!cache->free_list) {
> +			put_cpu();
> +			cache_element = kmalloc(PCPU_CACHE_ELEMENT_SIZE(pcpu_cache_list),
> +									GFP_KERNEL);
> +			if (!cache_element)
> +				return NULL;
> +			return PCPU_CACHE_ELEMENT_GET_PAYLOAD_FROM_HEAD(cache_element);
> +		}
> +	}
> +
> +	cache_element = cache->free_list;
> +	cache->free_list = cache_element->next;
> +	cache->nr--;
> +	put_cpu();
> +	return PCPU_CACHE_ELEMENT_GET_PAYLOAD_FROM_HEAD(cache_element);
> +}
> +
> +static void pcpu_cache_list_free(void *payload, struct pcpu_cache_list *pcpu_cache_list)
> +{
> +	struct pcpu_cache *cache;
> +	struct pcpu_cache_element *cache_element;
> +
> +	cache_element = PCPU_CACHE_ELEMENT_GET_HEAD_FROM_PAYLOAD(payload);
> +
> +	cache = per_cpu_ptr(pcpu_cache_list->cache, get_cpu());
> +	if (READ_ONCE(cache->nr_irq) + cache->nr >= pcpu_cache_list->max_nr)
> +		goto out_free;
> +
> +	if (in_task()) {
> +		cache_element->next = cache->free_list;
> +		cache->free_list = cache_element;
> +		cache->nr++;
> +	} else if (in_hardirq()) {
> +		lockdep_assert_irqs_disabled();
> +		cache_element->next = cache->free_list_irq;
> +		cache->free_list_irq = cache_element;
> +		cache->nr_irq++;
> +	} else {
> +		goto out_free;
> +	}
> +	put_cpu();
> +	return;
> +out_free:
> +	put_cpu();
> +	kfree(cache_element);
> +}
> +
> +#define DIO_ALLOC_CACHE_MAX		256
> +static struct pcpu_cache_list *dio_pcpu_cache_list;
> +
>  static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
>  		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
>  {
> @@ -135,7 +259,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  			ret += dio->done_before;
>  	}
>  	trace_iomap_dio_complete(iocb, dio->error, ret);
> -	kfree(dio);
> +	pcpu_cache_list_free(dio, dio_pcpu_cache_list);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_complete);
> @@ -620,7 +744,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (!iomi.len)
>  		return NULL;
>  
> -	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
> +	dio = pcpu_cache_list_alloc(dio_pcpu_cache_list);
>  	if (!dio)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -804,7 +928,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	return dio;
>  
>  out_free_dio:
> -	kfree(dio);
> +	pcpu_cache_list_free(dio, dio_pcpu_cache_list);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	return NULL;
> @@ -834,6 +958,9 @@ static int __init iomap_dio_init(void)
>  	if (!zero_page)
>  		return -ENOMEM;
>  
> +	dio_pcpu_cache_list = pcpu_cache_list_create(DIO_ALLOC_CACHE_MAX, sizeof(struct iomap_dio));
> +	if (!dio_pcpu_cache_list)
> +		return -ENOMEM;
>  	return 0;
>  }
>  fs_initcall(iomap_dio_init);
> -- 
> 2.20.1
> 
> 
> 

-- 
Dave Chinner
david@fromorbit.com

