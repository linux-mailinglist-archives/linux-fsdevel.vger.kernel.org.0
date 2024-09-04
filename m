Return-Path: <linux-fsdevel+bounces-28496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3F96B45C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E615D1C21948
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B418A6B0;
	Wed,  4 Sep 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AydY2+TJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uh0EEPfL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AydY2+TJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uh0EEPfL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237B188A2A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437781; cv=none; b=UO+jHXaQg8FmxqnugpG33Gks+cdcjSSbMGuMZ+oe5MWNwmRSsfeULSjv2Zf9GY4CKkJLFAU5iszhcCoW4Dxq0/mG3ubuRvKIADEXSJgnUfgcSQypTppgiSwsn0vK2/CKjqrffwoKdGiqYNXbVhQLriHwp6aw+4mEwaBygfp3uBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437781; c=relaxed/simple;
	bh=E/M0tf36Z1yw5PczLLbTkOcP7vU0VLPG25P5V2lselo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OG/UtDdUUO697b6nRUp5f14fc7oAHeYIfjoXomBeu0T5vIKIZulfuuq+YY9EB3nuVhuFatPfhOOZCP/SAg2yjHmzk8KHCsR10j/295bQmKqlrkHWQiob5RRK7oZu5sOfItRJOd6Puih6sFo9oF28SrbzT+ozg0yhyhqCjXsye0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AydY2+TJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uh0EEPfL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AydY2+TJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uh0EEPfL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C021F219F3;
	Wed,  4 Sep 2024 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725437777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/RixQvdJJgKlJ1BO6wHZyp+f/Qsn2l3Pj+xoq/d+w2g=;
	b=AydY2+TJyWh3jQIn9uoXWyHePvtQzUYAQzoQzrA4I8IEE43Zwxx5MwjMl/bEwx+9biWiOk
	szfIYWMktmbEO2qa4tXTclYB/O1Oq0028FIBUThegdAt6BLwAg4DGilcNXUI1DY8fZdXaw
	GoRKsAJrU3ypNUVpPMQljT9PLvhNlag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725437777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/RixQvdJJgKlJ1BO6wHZyp+f/Qsn2l3Pj+xoq/d+w2g=;
	b=uh0EEPfLW0wPHeZgzzTnFsDoevNjbineW1p20nZPDq6arivG8FuX/BJcHiM+FQ7bLvfgpo
	j233WwLojdTyvPAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725437777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/RixQvdJJgKlJ1BO6wHZyp+f/Qsn2l3Pj+xoq/d+w2g=;
	b=AydY2+TJyWh3jQIn9uoXWyHePvtQzUYAQzoQzrA4I8IEE43Zwxx5MwjMl/bEwx+9biWiOk
	szfIYWMktmbEO2qa4tXTclYB/O1Oq0028FIBUThegdAt6BLwAg4DGilcNXUI1DY8fZdXaw
	GoRKsAJrU3ypNUVpPMQljT9PLvhNlag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725437777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/RixQvdJJgKlJ1BO6wHZyp+f/Qsn2l3Pj+xoq/d+w2g=;
	b=uh0EEPfLW0wPHeZgzzTnFsDoevNjbineW1p20nZPDq6arivG8FuX/BJcHiM+FQ7bLvfgpo
	j233WwLojdTyvPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0395139D2;
	Wed,  4 Sep 2024 08:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D5anKlEX2Gb1fQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 08:16:17 +0000
Message-ID: <79eb89f6-1e19-4785-b807-1e0459b6011b@suse.cz>
Date: Wed, 4 Sep 2024 10:16:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] sl*b: remove rcu_freeptr_offset from struct
 kmem_cache
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-9-76f97e9a4560@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240903-work-kmem_cache_args-v2-9-76f97e9a4560@kernel.org>
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
> Now that we pass down struct kmem_cache_args to calculate_sizes() we
> don't need it anymore.

Nit: that sounds like a previous patch did the "pass down" part? Fine to do
both at once but maybe adjust description that we do both here?

> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  mm/slab.h |  2 --
>  mm/slub.c | 25 +++++++------------------
>  2 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index c7a4e0fc3cf1..36ac38e21fcb 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -261,8 +261,6 @@ struct kmem_cache {
>  	unsigned int object_size;	/* Object size without metadata */
>  	struct reciprocal_value reciprocal_size;
>  	unsigned int offset;		/* Free pointer offset */
> -	/* Specific free pointer requested (if not UINT_MAX) */
> -	unsigned int rcu_freeptr_offset;
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	/* Number of per cpu partial objects to keep around */
>  	unsigned int cpu_partial;
> diff --git a/mm/slub.c b/mm/slub.c
> index 4719b60215b8..a23c7036cd61 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3916,8 +3916,7 @@ static void *__slab_alloc_node(struct kmem_cache *s,
>   * If the object has been wiped upon free, make sure it's fully initialized by
>   * zeroing out freelist pointer.
>   *
> - * Note that we also wipe custom freelist pointers specified via
> - * s->rcu_freeptr_offset.
> + * Note that we also wipe custom freelist pointers.
>   */
>  static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>  						   void *obj)
> @@ -5141,17 +5140,11 @@ static void set_cpu_partial(struct kmem_cache *s)
>  #endif
>  }
>  
> -/* Was a valid freeptr offset requested? */
> -static inline bool has_freeptr_offset(const struct kmem_cache *s)
> -{
> -	return s->rcu_freeptr_offset != UINT_MAX;
> -}
> -
>  /*
>   * calculate_sizes() determines the order and the distribution of data within
>   * a slab object.
>   */
> -static int calculate_sizes(struct kmem_cache *s)
> +static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
>  {
>  	slab_flags_t flags = s->flags;
>  	unsigned int size = s->object_size;
> @@ -5192,7 +5185,7 @@ static int calculate_sizes(struct kmem_cache *s)
>  	 */
>  	s->inuse = size;
>  
> -	if (((flags & SLAB_TYPESAFE_BY_RCU) && !has_freeptr_offset(s)) ||
> +	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
>  	    (flags & SLAB_POISON) || s->ctor ||
>  	    ((flags & SLAB_RED_ZONE) &&
>  	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
> @@ -5214,8 +5207,8 @@ static int calculate_sizes(struct kmem_cache *s)
>  		 */
>  		s->offset = size;
>  		size += sizeof(void *);
> -	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && has_freeptr_offset(s)) {
> -		s->offset = s->rcu_freeptr_offset;
> +	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_offset) {
> +		s->offset = args->freeptr_offset;
>  	} else {
>  		/*
>  		 * Store freelist pointer near middle of object to keep
> @@ -5856,10 +5849,6 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	s->random = get_random_long();
>  #endif
> -	if (args->use_freeptr_offset)
> -		s->rcu_freeptr_offset = args->freeptr_offset;
> -	else
> -		s->rcu_freeptr_offset = UINT_MAX;
>  	s->align = args->align;
>  	s->ctor = args->ctor;
>  #ifdef CONFIG_HARDENED_USERCOPY
> @@ -5867,7 +5856,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  	s->usersize = args->usersize;
>  #endif
>  
> -	if (!calculate_sizes(s))
> +	if (!calculate_sizes(args, s))
>  		goto out;
>  	if (disable_higher_order_debug) {
>  		/*
> @@ -5877,7 +5866,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  		if (get_order(s->size) > get_order(s->object_size)) {
>  			s->flags &= ~DEBUG_METADATA_FLAGS;
>  			s->offset = 0;
> -			if (!calculate_sizes(s))
> +			if (!calculate_sizes(args, s))
>  				goto out;
>  		}
>  	}
> 


