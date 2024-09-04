Return-Path: <linux-fsdevel+bounces-28494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7796B3F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72D11C240A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF4D17C984;
	Wed,  4 Sep 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rRZrbeQq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGp89qSm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rRZrbeQq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGp89qSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3583CC8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437595; cv=none; b=AQ04Iv16f3h8Jg+Ux363SN5kNWPsQB+1z3GzWk4vOqqkx8kxW6Ejfxey7yUP53cpe1edAPzRrMZyFDS39q+/lbRdusqbQXCay8mHKlraoCDO+APNA1sSxOtkwUHETfRKXvwa9uaK80yVHt/aZD9GEirgvHy9TXhcxrZoMMk3//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437595; c=relaxed/simple;
	bh=LPnMNCK58qhLJLBtMYHBto28yDOjmSkNKLUJWL6abSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnJqgkIPz/8ucFZeQZb9gBmtBx1uAWQ5tSb3Ip+xr4njE8fm2o572m4df1foAdVxz33wk3+1Ird0suMtUj3XsfEC+jFYxkAvTskeoY+0F0457UUKKx4EtOJQU30cJQrWYIpE2xBt4REEwIxSJFKkpSvKLyrkQkklPEtYBMK72yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rRZrbeQq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGp89qSm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rRZrbeQq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGp89qSm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A717219F3;
	Wed,  4 Sep 2024 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725437591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Obsd54eJiKvmRj7QwEzDmQCKD2sIEQqrrLuEFzvG1X4=;
	b=rRZrbeQquDRjQhsutoqlnE9FSqwILlpDxJOjLHeKtSSOHZ1SGx8/w5bPNQxhiTgXqX40TX
	3QXNGoT+JCcDbjfBucTSgbP5AGBrckxf6Hs4b5l7lECba/ZL3o2Ef7qcW4QalkmcDOi2Yl
	6Jo6+WOnLGeptEtZA79QDV1VmixV9Qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725437591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Obsd54eJiKvmRj7QwEzDmQCKD2sIEQqrrLuEFzvG1X4=;
	b=oGp89qSmpVRqz4oAIrK0eAt3ABG2aP2j1gv28Mk0EDhDED+SsFZuFB2ULTpi8Ojl98319e
	eMFhc0bkLtterrBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rRZrbeQq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oGp89qSm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725437591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Obsd54eJiKvmRj7QwEzDmQCKD2sIEQqrrLuEFzvG1X4=;
	b=rRZrbeQquDRjQhsutoqlnE9FSqwILlpDxJOjLHeKtSSOHZ1SGx8/w5bPNQxhiTgXqX40TX
	3QXNGoT+JCcDbjfBucTSgbP5AGBrckxf6Hs4b5l7lECba/ZL3o2Ef7qcW4QalkmcDOi2Yl
	6Jo6+WOnLGeptEtZA79QDV1VmixV9Qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725437591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Obsd54eJiKvmRj7QwEzDmQCKD2sIEQqrrLuEFzvG1X4=;
	b=oGp89qSmpVRqz4oAIrK0eAt3ABG2aP2j1gv28Mk0EDhDED+SsFZuFB2ULTpi8Ojl98319e
	eMFhc0bkLtterrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67990139D2;
	Wed,  4 Sep 2024 08:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JvHJGJcW2GbcfAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 08:13:11 +0000
Message-ID: <c3b8a4e6-42ac-411a-ae0d-cd3aa5f1be50@suse.cz>
Date: Wed, 4 Sep 2024 10:13:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7A717219F3
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/3/24 16:20, Christian Brauner wrote:

You could describe that it's to hold less common args and there's
__kmem_cache_create_args() that takes it, and
do_kmem_cache_create_usercopy() is converted to it? Otherwise LGTM.

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/slab.h | 21 ++++++++++++++++
>  mm/slab_common.c     | 67 +++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 72 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 5b2da2cf31a8..79d8c8bca4a4 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -240,6 +240,27 @@ struct mem_cgroup;
>   */
>  bool slab_is_available(void);
>  
> +/**
> + * @align: The required alignment for the objects.
> + * @useroffset: Usercopy region offset
> + * @usersize: Usercopy region size
> + * @freeptr_offset: Custom offset for the free pointer in RCU caches
> + * @use_freeptr_offset: Whether a @freeptr_offset is used
> + * @ctor: A constructor for the objects.
> + */
> +struct kmem_cache_args {
> +	unsigned int align;
> +	unsigned int useroffset;
> +	unsigned int usersize;
> +	unsigned int freeptr_offset;
> +	bool use_freeptr_offset;
> +	void (*ctor)(void *);
> +};
> +
> +struct kmem_cache *__kmem_cache_create_args(const char *name,
> +					    unsigned int object_size,
> +					    struct kmem_cache_args *args,
> +					    slab_flags_t flags);
>  struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
>  			unsigned int align, slab_flags_t flags,
>  			void (*ctor)(void *));
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 91e0e36e4379..0f13c045b8d1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -248,14 +248,24 @@ static struct kmem_cache *create_cache(const char *name,
>  	return ERR_PTR(err);
>  }
>  
> -static struct kmem_cache *
> -do_kmem_cache_create_usercopy(const char *name,
> -		  unsigned int size, unsigned int freeptr_offset,
> -		  unsigned int align, slab_flags_t flags,
> -		  unsigned int useroffset, unsigned int usersize,
> -		  void (*ctor)(void *))
> +/**
> + * __kmem_cache_create_args - Create a kmem cache
> + * @name: A string which is used in /proc/slabinfo to identify this cache.
> + * @object_size: The size of objects to be created in this cache.
> + * @args: Arguments for the cache creation (see struct kmem_cache_args).
> + * @flags: See %SLAB_* flags for an explanation of individual @flags.
> + *
> + * Cannot be called within a interrupt, but can be interrupted.
> + *
> + * Return: a pointer to the cache on success, NULL on failure.
> + */
> +struct kmem_cache *__kmem_cache_create_args(const char *name,
> +					    unsigned int object_size,
> +					    struct kmem_cache_args *args,
> +					    slab_flags_t flags)
>  {
>  	struct kmem_cache *s = NULL;
> +	unsigned int freeptr_offset = UINT_MAX;
>  	const char *cache_name;
>  	int err;
>  
> @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
>  
>  	mutex_lock(&slab_mutex);
>  
> -	err = kmem_cache_sanity_check(name, size);
> +	err = kmem_cache_sanity_check(name, object_size);
>  	if (err) {
>  		goto out_unlock;
>  	}
> @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
>  
>  	/* Fail closed on bad usersize of useroffset values. */
>  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
> -	    WARN_ON(!usersize && useroffset) ||
> -	    WARN_ON(size < usersize || size - usersize < useroffset))
> -		usersize = useroffset = 0;
> -
> -	if (!usersize)
> -		s = __kmem_cache_alias(name, size, align, flags, ctor);
> +	    WARN_ON(!args->usersize && args->useroffset) ||
> +	    WARN_ON(object_size < args->usersize ||
> +		    object_size - args->usersize < args->useroffset))
> +		args->usersize = args->useroffset = 0;
> +
> +	if (!args->usersize)
> +		s = __kmem_cache_alias(name, object_size, args->align, flags,
> +				       args->ctor);
>  	if (s)
>  		goto out_unlock;
>  
> @@ -311,9 +323,11 @@ do_kmem_cache_create_usercopy(const char *name,
>  		goto out_unlock;
>  	}
>  
> -	s = create_cache(cache_name, size, freeptr_offset,
> -			 calculate_alignment(flags, align, size),
> -			 flags, useroffset, usersize, ctor);
> +	if (args->use_freeptr_offset)
> +		freeptr_offset = args->freeptr_offset;
> +	s = create_cache(cache_name, object_size, freeptr_offset,
> +			 calculate_alignment(flags, args->align, object_size),
> +			 flags, args->useroffset, args->usersize, args->ctor);
>  	if (IS_ERR(s)) {
>  		err = PTR_ERR(s);
>  		kfree_const(cache_name);
> @@ -335,6 +349,27 @@ do_kmem_cache_create_usercopy(const char *name,
>  	}
>  	return s;
>  }
> +EXPORT_SYMBOL(__kmem_cache_create_args);
> +
> +static struct kmem_cache *
> +do_kmem_cache_create_usercopy(const char *name,
> +                 unsigned int size, unsigned int freeptr_offset,
> +                 unsigned int align, slab_flags_t flags,
> +                 unsigned int useroffset, unsigned int usersize,
> +                 void (*ctor)(void *))
> +{
> +	struct kmem_cache_args kmem_args = {
> +		.align			= align,
> +		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
> +		.freeptr_offset		= freeptr_offset,
> +		.useroffset		= useroffset,
> +		.usersize		= usersize,
> +		.ctor			= ctor,
> +	};
> +
> +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> +}
> +
>  
>  /**
>   * kmem_cache_create_usercopy - Create a cache with a region suitable
> 


