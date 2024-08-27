Return-Path: <linux-fsdevel+bounces-27451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A23961902
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0AB1C22B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ADC1D31A3;
	Tue, 27 Aug 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TU2PnOy7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpUyolWa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TU2PnOy7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpUyolWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896D156661
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793014; cv=none; b=YMhX+FqS6zLGYWXuTWI4Bw4kt2lVXN0enD+YPSvHIEX0uuZh9sQuuLVH5DIcrPUKF61XdXE+H4fgN+r9PUO5zKEmEiIbv8lrqNgkOaqtsMgSgqinswjcnSmfqwfGqR4tMZOqPiKQS5wYPKJ7IQsTdhsVft0acY1EGinr8o/xx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793014; c=relaxed/simple;
	bh=2KSciEHApnTePwwH5F2zFR0IWSvLAHuY8ROPaYVDxpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgYmrZcqRPm6fEZBtU4TegE4UI5Ioc0k74TSFsb/v+VT1F7rJQ4+VBVptRw2+qOnmL5HK/6hbENykBr0cj+ACgve4xz/L3V/CekX+B73mt1JGFSJ/bQBFhgxSxdvrLbftX1hs55dEXyYwJp2n1HNbsYnO2N7gXtBRNew28t+dvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TU2PnOy7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpUyolWa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TU2PnOy7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpUyolWa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26E3E1FB91;
	Tue, 27 Aug 2024 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724793011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+mq+f9MBlP27Xg6qLjcVvrkFE73glilgNQvAZi9ssM=;
	b=TU2PnOy7SS4d+FK1QdFhc+sgm8CaZuImOYaDz8pYTE25NsDfn8QJyYAAUtwmwH9bm1g8ZQ
	hl/ZCMuHAFnD/CshlfGREq6cpZoQo6q76AkioqDAzr4TueZKjsx6EWyXdRq59uuuZ16Lsu
	M8Zep2mdQL+HTf5F6XDmvLfHW5Q4MAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724793011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+mq+f9MBlP27Xg6qLjcVvrkFE73glilgNQvAZi9ssM=;
	b=dpUyolWawiGzdnuxTGwizpVDkkNB5uAPjEpbcJU44UCtnF2phHBVNsdqOHRN9nm9pfiMBZ
	cjIw7t00tbMCJuDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724793011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+mq+f9MBlP27Xg6qLjcVvrkFE73glilgNQvAZi9ssM=;
	b=TU2PnOy7SS4d+FK1QdFhc+sgm8CaZuImOYaDz8pYTE25NsDfn8QJyYAAUtwmwH9bm1g8ZQ
	hl/ZCMuHAFnD/CshlfGREq6cpZoQo6q76AkioqDAzr4TueZKjsx6EWyXdRq59uuuZ16Lsu
	M8Zep2mdQL+HTf5F6XDmvLfHW5Q4MAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724793011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+mq+f9MBlP27Xg6qLjcVvrkFE73glilgNQvAZi9ssM=;
	b=dpUyolWawiGzdnuxTGwizpVDkkNB5uAPjEpbcJU44UCtnF2phHBVNsdqOHRN9nm9pfiMBZ
	cjIw7t00tbMCJuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1392C13724;
	Tue, 27 Aug 2024 21:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJ5jBLNAzmaNDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Aug 2024 21:10:11 +0000
Message-ID: <ee495744-bb34-4467-8838-3cec016fda0d@suse.cz>
Date: Tue, 27 Aug 2024 23:10:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: add kmem_cache_create_rcu()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
 <20240827-work-kmem_cache-rcu-v2-2-7bc9c90d5eef@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240827-work-kmem_cache-rcu-v2-2-7bc9c90d5eef@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 8/27/24 17:59, Christian Brauner wrote:
> When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
> must be located outside of the object because we don't know what part of
> the memory can safely be overwritten as it may be needed to prevent
> object recycling.
> 
> That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
> new cacheline. This is the case for .e.g, struct file. After having it
> shrunk down by 40 bytes and having it fit in three cachelines we still
> have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
> accomodate the free pointer and is hardware cacheline aligned.
> 
> I tried to find ways to rectify this as struct file is pretty much
> everywhere and having it use less memory is a good thing. So here's a
> proposal.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

So logistically patch 3 needs stuff in the vfs tree and having 1+2 in slab
tree and 3 in vfs that depends on 1+2 elsewhere is infeasible, so it will be
easiest for whole series to be in vfs, right?

> ---
>  include/linux/slab.h |   9 ++++
>  mm/slab.h            |   1 +
>  mm/slab_common.c     | 133 ++++++++++++++++++++++++++++++++++++---------------
>  mm/slub.c            |  17 ++++---
>  4 files changed, 114 insertions(+), 46 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..5b2da2cf31a8 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -212,6 +212,12 @@ enum _slab_flag_bits {
>  #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
>  #endif
>  
> +/*
> + * freeptr_t represents a SLUB freelist pointer, which might be encoded
> + * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
> + */
> +typedef struct { unsigned long v; } freeptr_t;
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> @@ -242,6 +248,9 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  			slab_flags_t flags,
>  			unsigned int useroffset, unsigned int usersize,
>  			void (*ctor)(void *));
> +struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
> +					 unsigned int freeptr_offset,
> +					 slab_flags_t flags);
>  void kmem_cache_destroy(struct kmem_cache *s);
>  int kmem_cache_shrink(struct kmem_cache *s);
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index dcdb56b8e7f5..b05512a14f07 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -261,6 +261,7 @@ struct kmem_cache {
>  	unsigned int object_size;	/* Object size without metadata */
>  	struct reciprocal_value reciprocal_size;
>  	unsigned int offset;		/* Free pointer offset */
> +	unsigned int rcu_freeptr_offset; /* Specific free pointer requested */

More precisely something like:

				  Specific offset requested (if not
				  UINT_MAX)

?

>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	/* Number of per cpu partial objects to keep around */
>  	unsigned int cpu_partial;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c8dd7e08c5f6..c4beff642fff 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -202,9 +202,10 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  }
>  
>  static struct kmem_cache *create_cache(const char *name,
> -		unsigned int object_size, unsigned int align,
> -		slab_flags_t flags, unsigned int useroffset,
> -		unsigned int usersize, void (*ctor)(void *))
> +		unsigned int object_size, unsigned int freeptr_offset,
> +		unsigned int align, slab_flags_t flags,
> +		unsigned int useroffset, unsigned int usersize,
> +		void (*ctor)(void *))
>  {
>  	struct kmem_cache *s;
>  	int err;
> @@ -212,6 +213,12 @@ static struct kmem_cache *create_cache(const char *name,
>  	if (WARN_ON(useroffset + usersize > object_size))
>  		useroffset = usersize = 0;
>  
> +	err = -EINVAL;
> +	if (freeptr_offset < UINT_MAX &&

freeptr_offset != UINT_MAX to be more obvious and match has_freeptr_offset() ?

> +	    (freeptr_offset >= object_size ||
> +	     (freeptr_offset && !(flags & SLAB_TYPESAFE_BY_RCU))))

and here drop the "freeptr_offset &&" as zero is a valid value

instead we could want alignment to sizeof(freeptr_t) if we were paranoid?

> +		goto out;

The rest seems good to me now.


