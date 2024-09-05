Return-Path: <linux-fsdevel+bounces-28720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F596D7A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 13:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6B61F24156
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A50C199E93;
	Thu,  5 Sep 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nlKawrPj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PiUqEAvz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nlKawrPj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PiUqEAvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156B19A28B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537160; cv=none; b=heOwzr6yYzXposGmc/ggSY7dV/CuauL87cpEszPemPEqzQAX9hmR0Kdqhx0roLQw6pcSBS3Id91ZeU0HDqTZecYph/XQkAfuJY1sycYID7qb+T7D+mFE1tkLflT2sh2JAhmPjUOOn28DjRFTirBHgpL0fVkUFCWpe4Ee015d6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537160; c=relaxed/simple;
	bh=FpVkbGRHRw3nsk8ti+NT9nImrzXmA3GdKmdrl1NM/CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtgAUH/43xnoROEFx9mDSJb62ks96ax9zyKHw4xRg98v8rtAM2hZ4O2ePSXBlQlwC8qgjY/Ps5Fs+GGJtPN3VjxMGCecpnqOl2BE25ifN8mrXnwvQrdbE1ayzXmLq63z3wWT7L0nSCz14XUc3UMFZXHFksUuWzyaYy7N7x5s3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nlKawrPj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PiUqEAvz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nlKawrPj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PiUqEAvz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 009C91F814;
	Thu,  5 Sep 2024 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725537151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXLcfa+LF5L9k/1Hl4YB/O7PmDflxR7/gow6mKM8eA8=;
	b=nlKawrPjch2IiJEeyRM+2OMvr1p82ymdaLUedjGXmfHw+JRnGa/XLZsr4YLU1k7YebeseM
	y9goSfW8Mmk26r4S1UUbu5WoAFz6VZ1hJfJP951on6S8MXMvSwDVvLjlaXkZH9cziuvVhz
	ZS9Z1uhWRbCllIsVdMMt44nOhvpHltA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725537151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXLcfa+LF5L9k/1Hl4YB/O7PmDflxR7/gow6mKM8eA8=;
	b=PiUqEAvzl8E6nix9k7YRSQcaV7N1wMmNpab6QOJjq5CxzO1auJ3aMt8ndNZlD8kdl6JSvm
	lnxsYzt7mJ05sPAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725537151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXLcfa+LF5L9k/1Hl4YB/O7PmDflxR7/gow6mKM8eA8=;
	b=nlKawrPjch2IiJEeyRM+2OMvr1p82ymdaLUedjGXmfHw+JRnGa/XLZsr4YLU1k7YebeseM
	y9goSfW8Mmk26r4S1UUbu5WoAFz6VZ1hJfJP951on6S8MXMvSwDVvLjlaXkZH9cziuvVhz
	ZS9Z1uhWRbCllIsVdMMt44nOhvpHltA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725537151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXLcfa+LF5L9k/1Hl4YB/O7PmDflxR7/gow6mKM8eA8=;
	b=PiUqEAvzl8E6nix9k7YRSQcaV7N1wMmNpab6QOJjq5CxzO1auJ3aMt8ndNZlD8kdl6JSvm
	lnxsYzt7mJ05sPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DECE713419;
	Thu,  5 Sep 2024 11:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OiIgNn6b2WaXZgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 05 Sep 2024 11:52:30 +0000
Message-ID: <3bd1a0c6-bea8-48e8-ae72-5af98bfb97cc@suse.cz>
Date: Thu, 5 Sep 2024 13:54:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] slab: create kmem_cache_create() compatibility
 layer
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-12-ed45d5380679@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240905-work-kmem_cache_args-v4-12-ed45d5380679@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.com,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 9/5/24 9:56 AM, Christian Brauner wrote:
> Use _Generic() to create a compatibility layer that type switches on the
> third argument to either call __kmem_cache_create() or
> __kmem_cache_create_args(). If NULL is passed for the struct
> kmem_cache_args argument use default args making porting for callers
> that don't care about additional arguments easy.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/slab.h | 29 ++++++++++++++++++++++++++---
>  mm/slab_common.c     | 10 +++++-----
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index cb264dded324..f74ceb788ac1 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  					    unsigned int object_size,
>  					    struct kmem_cache_args *args,
>  					    slab_flags_t flags);
> -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> -			unsigned int align, slab_flags_t flags,
> -			void (*ctor)(void *));
> +
> +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> +				       unsigned int align, slab_flags_t flags,
> +				       void (*ctor)(void *));
>  struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  			unsigned int size, unsigned int align,
>  			slab_flags_t flags,
> @@ -272,6 +273,28 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
>  					 unsigned int freeptr_offset,
>  					 slab_flags_t flags);
> +
> +/* If NULL is passed for @args, use this variant with default arguments. */
> +static inline struct kmem_cache *
> +__kmem_cache_default_args(const char *name, unsigned int size,
> +			  struct kmem_cache_args *args,
> +			  slab_flags_t flags)
> +{
> +	struct kmem_cache_args kmem_default_args = {};
> +
> +	/* Make sure we don't get passed garbage. */
> +	if (WARN_ON_ONCE(args))
> +		return NULL;

I'm changing to return ERR_PTR(-EINVAL); locally
although it's not too important

> +
> +	return __kmem_cache_create_args(name, size, &kmem_default_args, flags);
> +}
> +
> +#define kmem_cache_create(__name, __object_size, __args, ...)           \
> +	_Generic((__args),                                              \
> +		struct kmem_cache_args *: __kmem_cache_create_args,	\
> +		void *: __kmem_cache_default_args,			\
> +		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)
> +
>  void kmem_cache_destroy(struct kmem_cache *s);
>  int kmem_cache_shrink(struct kmem_cache *s);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 19ae3dd6e36f..418459927670 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -383,7 +383,7 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
>  EXPORT_SYMBOL(kmem_cache_create_usercopy);
>  
>  /**
> - * kmem_cache_create - Create a cache.
> + * __kmem_cache_create - Create a cache.
>   * @name: A string which is used in /proc/slabinfo to identify this cache.
>   * @size: The size of objects to be created in this cache.
>   * @align: The required alignment for the objects.
> @@ -407,9 +407,9 @@ EXPORT_SYMBOL(kmem_cache_create_usercopy);
>   *
>   * Return: a pointer to the cache on success, NULL on failure.
>   */
> -struct kmem_cache *
> -kmem_cache_create(const char *name, unsigned int size, unsigned int align,
> -		slab_flags_t flags, void (*ctor)(void *))
> +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> +				       unsigned int align, slab_flags_t flags,
> +				       void (*ctor)(void *))
>  {
>  	struct kmem_cache_args kmem_args = {
>  		.align	= align,
> @@ -418,7 +418,7 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  
>  	return __kmem_cache_create_args(name, size, &kmem_args, flags);
>  }
> -EXPORT_SYMBOL(kmem_cache_create);
> +EXPORT_SYMBOL(__kmem_cache_create);
>  
>  /**
>   * kmem_cache_create_rcu - Create a SLAB_TYPESAFE_BY_RCU cache.
> 

