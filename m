Return-Path: <linux-fsdevel+bounces-67145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A648C3639C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF6A74FBECD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736232F766;
	Wed,  5 Nov 2025 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fPHkWN3c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlDOApGa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fPHkWN3c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlDOApGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CFC32ED48
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355099; cv=none; b=bzufagJsmCq0aWTUWOLEpIjQYZBBXE9quOfOKD1J1YnXafcrJs+D/t4NYeweKNs461wDzTohYPzRu1Jvbzkutxd3MT8JjlFmKV7jpnVhbsxiuGPU8wOQGXwDOhYmsJR/5zZYPZ5iJaOiAbeKBPgHkYBa3alFtDeq4Gxy/bQPQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355099; c=relaxed/simple;
	bh=7m56ByMl+eoEzthsvVdQQaSSIon6inr0sZfQNwc0w4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDAfseRHJ54VKh0VtnQtn5RezzlrepSHi0g6daPKeI6dsL4Gv+v4Gz2ohGkF3Y5y7yZzduBhuLx7tSMrslz4LoTTdHoCpvT8aAw6YERiGCPX5WHAN+RhOql+tmtpXqKH6GG9GXjx4yj88C/pZsCHtdH3Bbr/XXxvD8VYY6AtXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fPHkWN3c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlDOApGa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fPHkWN3c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlDOApGa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 524981F453;
	Wed,  5 Nov 2025 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762355094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1b2kqqfLNp7GE0vErHBCF/JiZ1v/mSHLXfSO46GI2vQ=;
	b=fPHkWN3cohCt3Y9aKRf5dm54h1HsdlNwgieAXowMXSKEVQAV31WG9vqp5LNul3fcV8VosZ
	xuufrMV4qZezZ1GOacDwpUxuDJKZLUgzoKNoxAhoolNkY93hYgFgbCMQICdUEkkuh+IGAB
	snxdZ4N7OU1ji6kBsCIe+PLk+xRwEok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762355094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1b2kqqfLNp7GE0vErHBCF/JiZ1v/mSHLXfSO46GI2vQ=;
	b=zlDOApGaLytUOYBDPIikb5vi/8jstOehbTANXSGPR4wA1vCX7Q5L/ARIpWAD7RCT3Mb+0b
	zwlX8tjLHn/UoyAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762355094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1b2kqqfLNp7GE0vErHBCF/JiZ1v/mSHLXfSO46GI2vQ=;
	b=fPHkWN3cohCt3Y9aKRf5dm54h1HsdlNwgieAXowMXSKEVQAV31WG9vqp5LNul3fcV8VosZ
	xuufrMV4qZezZ1GOacDwpUxuDJKZLUgzoKNoxAhoolNkY93hYgFgbCMQICdUEkkuh+IGAB
	snxdZ4N7OU1ji6kBsCIe+PLk+xRwEok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762355094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1b2kqqfLNp7GE0vErHBCF/JiZ1v/mSHLXfSO46GI2vQ=;
	b=zlDOApGaLytUOYBDPIikb5vi/8jstOehbTANXSGPR4wA1vCX7Q5L/ARIpWAD7RCT3Mb+0b
	zwlX8tjLHn/UoyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28038132DD;
	Wed,  5 Nov 2025 15:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLH8CJZnC2kjcgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 15:04:54 +0000
Message-ID: <1fff522d-1987-4dcc-a6a2-4406a22d3ec2@suse.cz>
Date: Wed, 5 Nov 2025 16:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] mempool: add mempool_{alloc,free}_bulk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Eric Biggers <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-mm@kvack.org
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-4-hch@lst.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251031093517.1603379-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/31/25 10:34, Christoph Hellwig wrote:
> Add a version of the mempool allocator that works for batch allocations
> of multiple objects.  Calling mempool_alloc in a loop is not safe because
> it could deadlock if multiple threads are performing such an allocation
> at the same time.
> 
> As an extra benefit the interface is build so that the same array can be
> used for alloc_pages_bulk / release_pages so that at least for page
> backed mempools the fast path can use a nice batch optimization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mempool.h |   7 ++
>  mm/mempool.c            | 145 ++++++++++++++++++++++++++++------------
>  2 files changed, 111 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> index 34941a4b9026..486ed50776db 100644
> --- a/include/linux/mempool.h
> +++ b/include/linux/mempool.h
> @@ -66,9 +66,16 @@ extern void mempool_destroy(mempool_t *pool);
>  extern void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask) __malloc;
>  #define mempool_alloc(...)						\
>  	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
> +int mempool_alloc_bulk_noprof(mempool_t *pool, void **elem,
> +		unsigned int count, gfp_t gfp_mask, unsigned long caller_ip);
> +#define mempool_alloc_bulk(pool, elem, count, gfp_mask)			\
> +	alloc_hooks(mempool_alloc_bulk_noprof(pool, elem, count, gfp_mask, \
> +			_RET_IP_))
>  
>  extern void *mempool_alloc_preallocated(mempool_t *pool) __malloc;
>  extern void mempool_free(void *element, mempool_t *pool);
> +unsigned int mempool_free_bulk(mempool_t *pool, void **elem,
> +		unsigned int count);
>  
>  /*
>   * A mempool_alloc_t and mempool_free_t that get the memory from
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 15581179c8b9..c980a0396986 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -381,23 +381,29 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
>  EXPORT_SYMBOL(mempool_resize);
>  
>  /**
> - * mempool_alloc - allocate an element from a memory pool
> + * mempool_alloc_bulk - allocate multiple elements from a memory pool
>   * @pool:	pointer to the memory pool
> + * @elem:	partially or fully populated elements array
> + * @count:	size (in entries) of @elem
>   * @gfp_mask:	GFP_* flags.
>   *
> + * Allocate elements for each slot in @elem that is non-%NULL.
> + *
>   * Note: This function only sleeps if the alloc_fn callback sleeps or returns
>   * %NULL.  Using __GFP_ZERO is not supported.
>   *
> - * Return: pointer to the allocated element or %NULL on error. This function
> - * never returns %NULL when @gfp_mask allows sleeping.
> + * Return: 0 if successful, else -ENOMEM.  This function never returns -ENOMEM
> + * when @gfp_mask allows sleeping.
>   */
> -void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
> +int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
> +		unsigned int count, gfp_t gfp_mask, unsigned long caller_ip)
>  {
> -	void *element;
>  	unsigned long flags;
>  	wait_queue_entry_t wait;
>  	gfp_t gfp_temp;
> +	unsigned int i;
>  
> +	VM_WARN_ON_ONCE(count > pool->min_nr);
>  	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
>  	might_alloc(gfp_mask);
>  
> @@ -407,20 +413,31 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
>  
>  	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
>  
> +	i = 0;
>  repeat_alloc:
> -	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {
> -		pr_info("forcing mempool usage for pool %pS\n",
> -				(void *)_RET_IP_);
> -		element = NULL;
> -	} else {
> -		element = pool->alloc(gfp_temp, pool->pool_data);
> -		if (likely(element != NULL))
> -			return element;
> +	for (; i < count; i++) {
> +		if (!elem[i]) {
> +			if (should_fail_ex(&fail_mempool_alloc, 1,
> +					FAULT_NOWARN)) {
> +				pr_info("forcing pool usage for pool %pS\n",
> +					(void *)caller_ip);
> +				goto use_pool;
> +			}

Would it be enough to do this failure injection attempt once and not in
every iteration?

> +			elem[i] = pool->alloc(gfp_temp, pool->pool_data);
> +			if (unlikely(!elem[i]))
> +				goto use_pool;
> +		}
>  	}
>  
> +	return 0;
> +
> +use_pool:
>  	spin_lock_irqsave(&pool->lock, flags);
> -	if (likely(pool->curr_nr)) {
> -		element = remove_element(pool);
> +	if (likely(pool->curr_nr >= count - i)) {
> +		for (; i < count; i++) {
> +			if (!elem[i])
> +				elem[i] = remove_element(pool);
> +		}
>  		spin_unlock_irqrestore(&pool->lock, flags);
>  		/* paired with rmb in mempool_free(), read comment there */
>  		smp_wmb();
> @@ -428,8 +445,9 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
>  		 * Update the allocation stack trace as this is more useful
>  		 * for debugging.
>  		 */
> -		kmemleak_update_trace(element);
> -		return element;
> +		for (i = 0; i < count; i++)
> +			kmemleak_update_trace(elem[i]);
> +		return 0;
>  	}
>  
>  	/*
> @@ -445,10 +463,12 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
>  	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
>  	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
>  		spin_unlock_irqrestore(&pool->lock, flags);
> -		return NULL;
> +		if (i > 0)
> +			mempool_free_bulk(pool, elem + i, count - i);

I don't understand why we are trying to free from i to count and not from 0
to i? Seems buggy, there will likely be NULLs which might go through
add_element() which assumes they are not NULL.

Assuming this is fixed we might still have confusing API. We might be
freeing away elements that were already in the array when
mempool_alloc_bulk() was called. OTOH the pool might be missing less than i
elements and mempool_free_bulk() will not do anything with the rest.
Anything beyond i is untouched. The caller has no idea what's in the array
after getting this -ENOMEM. (alloc_pages_bulk() returns the number of pages
there).
Maybe it's acceptable (your usecase I think doesn't even add a caller that
can't block), but needs documenting clearly.

> +		return -ENOMEM;
>  	}
>  
> -	/* Let's wait for someone else to return an element to @pool */
> +	/* Let's wait for someone else to return elements to @pool */
>  	init_wait(&wait);
>  	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);

So in theory callers waiting for many objects might wait indefinitely to
find enough objects in the pool, while smaller callers succeed their
allocations and deplete the pool. Mempools never provided some fair ordering
of waiters, but this might make it worse deterministically instead of
randomly. Guess it's not such a problem if all callers are comparable in
number of objects.

> @@ -463,6 +483,27 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
>  	finish_wait(&pool->wait, &wait);
>  	goto repeat_alloc;
>  }
> +EXPORT_SYMBOL_GPL(mempool_alloc_bulk_noprof);
> +
> +/**
> + * mempool_alloc - allocate an element from a memory pool
> + * @pool:	pointer to the memory pool
> + * @gfp_mask:	GFP_* flags.
> + *
> + * Note: This function only sleeps if the alloc_fn callback sleeps or returns
> + * %NULL.  Using __GFP_ZERO is not supported.
> + *
> + * Return: pointer to the allocated element or %NULL on error. This function
> + * never returns %NULL when @gfp_mask allows sleeping.
> + */
> +void *mempool_alloc_noprof(struct mempool *pool, gfp_t gfp_mask)
> +{
> +	void *elem[1] = { };
> +
> +	if (mempool_alloc_bulk_noprof(pool, elem, 1, gfp_mask, _RET_IP_) < 0)
> +		return NULL;
> +	return elem[0];
> +}
>  EXPORT_SYMBOL(mempool_alloc_noprof);
>  
>  /**
> @@ -502,21 +543,26 @@ void *mempool_alloc_preallocated(mempool_t *pool)
>  EXPORT_SYMBOL(mempool_alloc_preallocated);
>  
>  /**
> - * mempool_free - return an element to a mempool
> - * @element:	pointer to element
> + * mempool_free_bulk - return elements to a mempool
>   * @pool:	pointer to the memory pool
> + * @elem:	elements to return
> + * @count:	number of elements to return
>   *
> - * Returns @elem to @pool if its needs replenishing, else free it using
> - * the free_fn callback in @pool.
> + * Returns elements from @elem to @pool if its needs replenishing and sets
> + * their slot in @elem to NULL.  Other elements are left in @elem.
> + *
> + * Return: number of elements transferred to @pool.  Elements are always
> + * transferred from the beginning of @elem, so the return value can be used as
> + * an offset into @elem for the freeing the remaining elements in the caller.
>   *
>   * This function only sleeps if the free_fn callback sleeps.

This part now only applies to mempool_free() ?

>   */
> -void mempool_free(void *element, mempool_t *pool)
> +unsigned int mempool_free_bulk(struct mempool *pool, void **elem,
> +		unsigned int count)
>  {
>  	unsigned long flags;
> -
> -	if (unlikely(element == NULL))
> -		return;
> +	bool added = false;
> +	unsigned int freed = 0;
>  
>  	/*
>  	 * Paired with the wmb in mempool_alloc().  The preceding read is
> @@ -553,15 +599,11 @@ void mempool_free(void *element, mempool_t *pool)
>  	 */
>  	if (unlikely(READ_ONCE(pool->curr_nr) < pool->min_nr)) {
>  		spin_lock_irqsave(&pool->lock, flags);
> -		if (likely(pool->curr_nr < pool->min_nr)) {
> -			add_element(pool, element);
> -			spin_unlock_irqrestore(&pool->lock, flags);
> -			if (wq_has_sleeper(&pool->wait))
> -				wake_up(&pool->wait);
> -			return;
> +		while (pool->curr_nr < pool->min_nr && freed < count) {
> +			add_element(pool, elem[freed++]);
> +			added = true;
>  		}
>  		spin_unlock_irqrestore(&pool->lock, flags);
> -	}
>  
>  	/*
>  	 * Handle the min_nr = 0 edge case:
> @@ -572,20 +614,41 @@ void mempool_free(void *element, mempool_t *pool)
>  	 * allocation of element when both min_nr and curr_nr are 0, and
>  	 * any active waiters are properly awakened.
>  	 */
> -	if (unlikely(pool->min_nr == 0 &&
> +	} else if (unlikely(pool->min_nr == 0 &&
>  		     READ_ONCE(pool->curr_nr) == 0)) {
>  		spin_lock_irqsave(&pool->lock, flags);
>  		if (likely(pool->curr_nr == 0)) {
> -			add_element(pool, element);
> -			spin_unlock_irqrestore(&pool->lock, flags);
> -			if (wq_has_sleeper(&pool->wait))
> -				wake_up(&pool->wait);
> -			return;
> +			add_element(pool, elem[freed++]);
> +			added = true;
>  		}
>  		spin_unlock_irqrestore(&pool->lock, flags);
>  	}
>  
> -	pool->free(element, pool->pool_data);
> +	if (unlikely(added) && wq_has_sleeper(&pool->wait))
> +		wake_up(&pool->wait);
> +
> +	return freed;
> +}
> +EXPORT_SYMBOL_GPL(mempool_free_bulk);
> +
> +/**
> + * mempool_free - return an element to the pool.
> + * @element:	element to return
> + * @pool:	pointer to the memory pool
> + *
> + * Returns @elem to @pool if its needs replenishing, else free it using
> + * the free_fn callback in @pool.
> + *
> + * This function only sleeps if the free_fn callback sleeps.
> + */
> +void mempool_free(void *element, struct mempool *pool)
> +{
> +	if (likely(element)) {
> +		void *elem[1] = { element };
> +
> +		if (!mempool_free_bulk(pool, elem, 1))
> +			pool->free(element, pool->pool_data);
> +	}
>  }
>  EXPORT_SYMBOL(mempool_free);
>  


