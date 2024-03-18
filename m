Return-Path: <linux-fsdevel+bounces-14699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD287E2E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F5281F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 04:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B813214;
	Mon, 18 Mar 2024 04:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shjwgewW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E801F951
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737945; cv=none; b=n+6ApA9SVJWrzo3P8xoQS9gIZVAIOqBVbEewD98GiJ2KD/jKQbpWEkAaWGe60v5ZwK5e60WC1oz6xhn5VwmHLh5xSKzTUlPA8kzc93P6PRTMtxp/LMtANXu4zOmpkqQSbJhr4edrCL1SzeaJZMXnDIEih7JTGH9sTAff95RoKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737945; c=relaxed/simple;
	bh=i5WFbVz4CUOhspnMDXsmliBJ84Jka6NyQZphhIK8sfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUgJPfUDuXoFsEgIJuEyrt12bzgzI1wa4iWE1QkYd5If+q3wbGVXGj+XwcXn9HXjKPbui5FL9mM9MCeH4u3Yh2Je3c/6O0OdQ4ADhMkLGh4XILGcs8OzU6QmW/xTz+Mp1WunZvQW5xvGp8Hdhn5GCQQuLOgYnngILYTEDgfclUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shjwgewW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C59C433C7;
	Mon, 18 Mar 2024 04:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710737945;
	bh=i5WFbVz4CUOhspnMDXsmliBJ84Jka6NyQZphhIK8sfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shjwgewWi2jKlnh37FZt/htlBx9oXA9mIcPc/J+SWMpsfdwTd94MVbokXmCjAvfhM
	 pHkUkPTiAGGfnzENUrT0lBJ1CvNcK/UJaDzkPzcp+p/TueTTuV/r76PJiJGUkVPT99
	 y+w/07z4OkrIcz+RI1vxt8Wfl+ImArqlw8s2O4T8vjO2eszwqbDvuR+zHxfBsTcMvW
	 jSMW88soECpbnyvamvzuaVygWbmrQBJMzU5Kx9SgSehlNPQ6cD3PB+X8PfKI3zQP0d
	 6LQj5FoMIaU376DC+YbVLa5Ir2zqQ+IxhKcKF5KXb+lzwDNWjTJwiPDTnvyo9CbnXb
	 gngaMIQWVyCvg==
Date: Sun, 17 Mar 2024 21:59:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ivan Trofimov <i.trofimow@yandex.ru>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] eventpoll: optimize epoll_ctl by reusing
 eppoll_entry allocations
Message-ID: <20240318045903.GA63337@sol.localdomain>
References: <20240317222004.76084-1-i.trofimow@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317222004.76084-1-i.trofimow@yandex.ru>

On Mon, Mar 18, 2024 at 01:20:04AM +0300, Ivan Trofimov wrote:
> Instead of unconditionally allocating and deallocating pwq objects,
> try to reuse them by storing the entry in the eventpoll struct
> at deallocation request, and consuming that entry at allocation request.
> This way every EPOLL_CTL_ADD operation immediately following an
> EPOLL_CTL_DEL operation effectively cancels out its pwq allocation
> with the preceding deallocation.
> 
> With this patch applied I'm observing ~13% overall speedup when 
> benchmarking the following scenario:
> 1. epoll_ctl(..., EPOLL_CTL_ADD, ...)
> 2. epoll_ctl(..., EPOLL_CTL_DEL, ...)
> which should be a pretty common one for either applications dealing with
> a lot of short-lived connections or applications doing a DEL + ADD dance
> per level-triggered FD readiness.
> 
> This optimization comes with a sizeof(void*) + sizeof(struct eppoll_entry)
> per-epoll-instance memory cost, which amounts to 72 bytes for 64-bit.
> 
> Signed-off-by: Ivan Trofimov <i.trofimow@yandex.ru>
> ---
> This is my first ever attempt at submiting a patch for the kernel,
> so please don't hesitate to point out mistakes I'm doing in the process.
> 
>  fs/eventpoll.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 882b89edc..c4094124c 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -219,6 +219,9 @@ struct eventpoll {
>  	u64 gen;
>  	struct hlist_head refs;
>  
> +	/* a single-item cache used to reuse eppoll_entry allocations */
> +	struct eppoll_entry *pwq_slot;
> +
>  	/*
>  	 * usage count, used together with epitem->dying to
>  	 * orchestrate the disposal of this struct
> @@ -648,6 +651,36 @@ static void ep_remove_wait_queue(struct eppoll_entry *pwq)
>  	rcu_read_unlock();
>  }
>  
> +/*
> + * This functions either consumes the pwq_slot, or allocates a new

"This function"

> @@ -789,6 +822,8 @@ static void ep_free(struct eventpoll *ep)
>  	mutex_destroy(&ep->mtx);
>  	free_uid(ep->user);
>  	wakeup_source_unregister(ep->ws);
> +	if (ep->pwq_slot)
> +		kmem_cache_free(pwq_cache, ep->pwq_slot);

A NULL check isn't necessary before kmem_cache_free().

> @@ -1384,7 +1419,7 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
>  	if (unlikely(!epi))	// an earlier allocation has failed
>  		return;
>  
> -	pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL);
> +	pwq = ep_alloc_pwq(epi->ep);

What guarantees that ep->mtx is held here?

- Eric

