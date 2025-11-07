Return-Path: <linux-fsdevel+bounces-67406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 186C8C3E65C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 04:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBAC34E1E33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 03:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C41E32D3;
	Fri,  7 Nov 2025 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj6wZOA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FA3B2A0;
	Fri,  7 Nov 2025 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762487628; cv=none; b=fE/pCucXtmBgGA89/bO3MkmOzIukbtBCVHj/dzSijXhl04GXMDustQ8O1G/kCVn2Ksssjn0IqMjaq/u5Tg/qrrmZfVjFLS6vd7kQg0Qk1gFXIM/fmLIpWQBctMPp/iiyqtvCgJiiEzBlfRvCg7zTtaDsKxbNikXelQUDNPDv3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762487628; c=relaxed/simple;
	bh=qPQrDC4pqEccrd+WZeXGR0TqGt+hmB5tkru+7RCZNlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNhNrZNmTdqs/q7RLMLDtvJ6yvUx0yW01d/LGzIQmf9eQ4h9tpVBlOVCE3VlG3mPIUi8HWH8UDo/h0w5KNeYqhknQDsgO3aFl5zZKos61TNMI7tjfKQQHyqnSwghkMNnVtZVzzH675sOc++99bePPJpnSmapR4oW+/PZyOMjvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj6wZOA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A8C4CEF8;
	Fri,  7 Nov 2025 03:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762487627;
	bh=qPQrDC4pqEccrd+WZeXGR0TqGt+hmB5tkru+7RCZNlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aj6wZOA40pHVyNtDVKnc1AXjXHCwrNFRyy0fGlzNo3pt+uEjZAP1Djash7uN7F9eE
	 syY+ICi/KDynnnot29wlzSi5c3/DcfGLJXeOBr1LKQArXCiQZL9MU8cOBFC5NGIuez
	 YFXxASWmwSeEFQyC9ysQRgXA8FvNc+F55M2CiaGvWzSMFxbvfLB3zz7CJq92biO6+d
	 1urVPv9rOkPXujGLFMRDv6nA5Q4xPgvO0BnHPt4qjKshqXBbZtoqOgbQsIR/DbRKH+
	 iZgHRKJHTRzvbjFLf51ARgCFv6GJQifI/k61WYCED+/r6wV09nPR/+Rh738s5DzJD3
	 3LP5RkUDv4w8A==
Date: Thu, 6 Nov 2025 19:52:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/9] mempool: add mempool_{alloc,free}_bulk
Message-ID: <20251107035207.GA47797@sol>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-4-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:33AM +0100, Christoph Hellwig wrote:
>  /**
> - * mempool_alloc - allocate an element from a memory pool
> + * mempool_alloc_bulk - allocate multiple elements from a memory pool
>   * @pool:	pointer to the memory pool
> + * @elem:	partially or fully populated elements array
> + * @count:	size (in entries) of @elem
>   * @gfp_mask:	GFP_* flags.
>   *
> + * Allocate elements for each slot in @elem that is non-%NULL.

elem => elems (and likewise for mempool_free_bulk())

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

What exactly is the behavior on partial failures?  Is the return value 0
or is it -ENOMEM, and is the array restored to its original state or
might some elements have been allocated?

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

How much overhead does this add to mempool_alloc(), which will continue
to be the common case?  I wonder if it would be worthwhile to
force-inline the bulk allocation function into it, so that it will get
generate about the same code as before.

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

The above comment has a weird position now.  Maybe move it into the
'else if' block below.

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

- Eric

