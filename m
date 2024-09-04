Return-Path: <linux-fsdevel+bounces-28495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427296B452
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586421C20B4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22E187FF5;
	Wed,  4 Sep 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TEqAGXrx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQxOFzR0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TEqAGXrx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQxOFzR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDB155735
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437680; cv=none; b=oKIloi68k9gpt1O+KgYkwrZszA9uAsOAbJoLu1giNPscNrPr/NaCdz7+TNTsOl9FBtLVAkbBOtne9oRQahNBD5q4fhNe9uMqOywnXkdchO+smtFrhA8loHbmVZn3Go1fepsPKg8q6F09DkZpEvb8uuK0AiCRrILbptGwFJivS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437680; c=relaxed/simple;
	bh=x3lVJ2+xmmk4ceLuUX7SQnOvAk3YPgEj+U6Aj3YhtBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tf6hjFThZrxzkNj9JVxM79ZHVusBHT3JT2jnvyLiQomyTs/aNc/hsxxIkB9sSeq5JTv7xSUD4u58h3NLxJUvLK4Uajj5faCbf/IoKM9YWzjc2ycZtRta3RfZ1Vk2dpOuIBxRA4du+T4oJS6xy8JLFH5KKTMHBru/Lhi/gCLJ0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TEqAGXrx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQxOFzR0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TEqAGXrx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQxOFzR0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CF20219F9;
	Wed,  4 Sep 2024 08:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725437677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VLiPbVYKmQ0b+1MOELAMx/PhGTBcH7hBgQmyGtsLgT0=;
	b=TEqAGXrxb2QIhI9BHLe4Niaq7MHf8XyoyBvBY7h/CPYxOjLYElEmZXO6d+DZfBSgSibOjQ
	roFghqOx8uA2U9tyl5bE6Lr1RfZ2/I0Eojoy9LMcE1xHg0XG4dJwrwcndhb+/REXG0NqEu
	S76P8L9SckL0LuWXm2RkJ/aX5QxwdtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725437677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VLiPbVYKmQ0b+1MOELAMx/PhGTBcH7hBgQmyGtsLgT0=;
	b=mQxOFzR0T/aW0s1LU6IqL8kAcRkxc1YCfFKpfGyP/JgKIwCmeIw+9JwIhwewexImR9YxDy
	h6sdBvh0bIZVeXBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725437677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VLiPbVYKmQ0b+1MOELAMx/PhGTBcH7hBgQmyGtsLgT0=;
	b=TEqAGXrxb2QIhI9BHLe4Niaq7MHf8XyoyBvBY7h/CPYxOjLYElEmZXO6d+DZfBSgSibOjQ
	roFghqOx8uA2U9tyl5bE6Lr1RfZ2/I0Eojoy9LMcE1xHg0XG4dJwrwcndhb+/REXG0NqEu
	S76P8L9SckL0LuWXm2RkJ/aX5QxwdtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725437677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VLiPbVYKmQ0b+1MOELAMx/PhGTBcH7hBgQmyGtsLgT0=;
	b=mQxOFzR0T/aW0s1LU6IqL8kAcRkxc1YCfFKpfGyP/JgKIwCmeIw+9JwIhwewexImR9YxDy
	h6sdBvh0bIZVeXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58BC3139D2;
	Wed,  4 Sep 2024 08:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7bRQFe0W2GZJfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 08:14:37 +0000
Message-ID: <44c51c2b-957c-4bb6-bade-fb202dbd07ce@suse.cz>
Date: Wed, 4 Sep 2024 10:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] slab: port kmem_cache_create_usercopy() to
 struct kmem_cache_args
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-5-76f97e9a4560@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240903-work-kmem_cache_args-v2-5-76f97e9a4560@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/3/24 16:20, Christian Brauner wrote:
> Pprt kmem_cache_create_usercopy() to struct kmem_cache_args and remove

Typo

> the now unused do_kmem_cache_create_usercopy() helper.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  mm/slab_common.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index da62ed30f95d..16c36a946135 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -351,26 +351,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  }
>  EXPORT_SYMBOL(__kmem_cache_create_args);
>  
> -static struct kmem_cache *
> -do_kmem_cache_create_usercopy(const char *name,
> -                 unsigned int size, unsigned int freeptr_offset,
> -                 unsigned int align, slab_flags_t flags,
> -                 unsigned int useroffset, unsigned int usersize,
> -                 void (*ctor)(void *))
> -{
> -	struct kmem_cache_args kmem_args = {
> -		.align			= align,
> -		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
> -		.freeptr_offset		= freeptr_offset,
> -		.useroffset		= useroffset,
> -		.usersize		= usersize,
> -		.ctor			= ctor,
> -	};
> -
> -	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> -}
> -
> -
>  /**
>   * kmem_cache_create_usercopy - Create a cache with a region suitable
>   * for copying to userspace
> @@ -405,8 +385,14 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
>  			   unsigned int useroffset, unsigned int usersize,
>  			   void (*ctor)(void *))
>  {
> -	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
> -					     useroffset, usersize, ctor);
> +	struct kmem_cache_args kmem_args = {
> +		.align		= align,
> +		.ctor		= ctor,
> +		.useroffset	= useroffset,
> +		.usersize	= usersize,
> +	};
> +
> +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
>  }
>  EXPORT_SYMBOL(kmem_cache_create_usercopy);
>  
> 


