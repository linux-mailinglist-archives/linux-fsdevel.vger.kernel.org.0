Return-Path: <linux-fsdevel+bounces-12835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A4867BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EA11C2B07E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64E12F5BA;
	Mon, 26 Feb 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="prylBFUV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rk75k5ot";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="prylBFUV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rk75k5ot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95612BEBD;
	Mon, 26 Feb 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964791; cv=none; b=E0A4ETSc9hgNncKo2aymxPWOyuDoTgrehTuqGxFeChdFhfHFA52NTTXGkjzExrMgbhRoGA0In11RigahGLkUzK5bybrvG7Td6OgmjArpacCU2sAwKLtXiXO9qXuFTp1PHzcAVnaqVIuwCHkFREZjiYQUE2U3q7Lioc6J75yTNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964791; c=relaxed/simple;
	bh=m1+OxDyWqmC4C/CIeB1ZfjnZ/sIWoPCZ4fQO0ohPnGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufblo56o2y9rCemB9RDFe+M2CN3eZuYmODTqOyeLTrUnmVKl+VpM+vCvVo2LFbyuA7wpBg4yW+dsm7gAtXQjQqhcFmSqunvxQGIVySOEVNNSPd7EX9xIQ2DMcq4V1uT17UdBIaKCqO4qfF99cFP7zX56z0I0dvKHzZZdRTYhnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=prylBFUV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rk75k5ot; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=prylBFUV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rk75k5ot; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B325225DB;
	Mon, 26 Feb 2024 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708964787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kt81o7iYJbd84eehNyWBdCqngFrw9GogG9YZ6mhQs9s=;
	b=prylBFUVU36+pJJCGCC5sliujGfk5LXuNCQ8tu3eUSPV3RnVIxQ44xNPM3FiFKYmH2yQHq
	1VqibfIv5LQdUqVfPchGb0gOUYg2aO+yPLZNGaDP7SVSVFuJUVKShYe1LwzX5+f+EQqVJN
	zfsMnUyEb3FETAuVnkP4D1DcAXC9+8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708964787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kt81o7iYJbd84eehNyWBdCqngFrw9GogG9YZ6mhQs9s=;
	b=Rk75k5ots+cwnzM6f62N5UgfIwitm7OAMJjHAXHd38Hv3tJ4vgRISO6+vs63zG8UHSyLxX
	uuruOJTYktTtGIAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708964787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kt81o7iYJbd84eehNyWBdCqngFrw9GogG9YZ6mhQs9s=;
	b=prylBFUVU36+pJJCGCC5sliujGfk5LXuNCQ8tu3eUSPV3RnVIxQ44xNPM3FiFKYmH2yQHq
	1VqibfIv5LQdUqVfPchGb0gOUYg2aO+yPLZNGaDP7SVSVFuJUVKShYe1LwzX5+f+EQqVJN
	zfsMnUyEb3FETAuVnkP4D1DcAXC9+8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708964787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kt81o7iYJbd84eehNyWBdCqngFrw9GogG9YZ6mhQs9s=;
	b=Rk75k5ots+cwnzM6f62N5UgfIwitm7OAMJjHAXHd38Hv3tJ4vgRISO6+vs63zG8UHSyLxX
	uuruOJTYktTtGIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FD3C13A3A;
	Mon, 26 Feb 2024 16:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4j3mHrK73GXJDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 16:26:26 +0000
Message-ID: <6851f8a0-e5d2-4b79-9cee-cff0fdec2970@suse.cz>
Date: Mon, 26 Feb 2024 17:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/36] mm: introduce slabobj_ext to support slab object
 extensions
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-8-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-8-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_GT_50(0.00)[74];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.41
X-Spam-Flag: NO

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> Currently slab pages can store only vectors of obj_cgroup pointers in
> page->memcg_data. Introduce slabobj_ext structure to allow more data
> to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> to support current functionality while allowing to extend slabobj_ext
> in the future.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Hi, mostly good from slab perspective, just some fixups:

> --- a/mm/slab.h
> +++ b/mm/slab.h
> -int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
> -				 gfp_t gfp, bool new_slab);
> -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> -		     enum node_stat_item idx, int nr);
> -#else /* CONFIG_MEMCG_KMEM */
> -static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> +			gfp_t gfp, bool new_slab);
>

We could remove this declaration and make the function static in mm/slub.c.

> +#else /* CONFIG_SLAB_OBJ_EXT */
> +
> +static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  {
>  	return NULL;
>  }
>  
> -static inline int memcg_alloc_slab_cgroups(struct slab *slab,
> -					       struct kmem_cache *s, gfp_t gfp,
> -					       bool new_slab)
> +static inline int alloc_slab_obj_exts(struct slab *slab,
> +				      struct kmem_cache *s, gfp_t gfp,
> +				      bool new_slab)
>  {
>  	return 0;
>  }

Ditto

> -#endif /* CONFIG_MEMCG_KMEM */
> +
> +static inline struct slabobj_ext *
> +prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> +{
> +	return NULL;
> +}

Same here (and the definition and usage even happens in later patch).

> +#endif /* CONFIG_SLAB_OBJ_EXT */
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +		     enum node_stat_item idx, int nr);
> +#endif
>  
>  size_t __ksize(const void *objp);
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index d31b03a8d9d5..76fb600fbc80 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -683,10 +683,10 @@ static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *sla
>  
>  	if (s->flags & __CMPXCHG_DOUBLE) {
>  		ret = __update_freelist_fast(slab, freelist_old, counters_old,
> -				            freelist_new, counters_new);
> +					    freelist_new, counters_new);
>  	} else {
>  		ret = __update_freelist_slow(slab, freelist_old, counters_old,
> -				            freelist_new, counters_new);
> +					    freelist_new, counters_new);
>  	}
>  	if (likely(ret))
>  		return true;
> @@ -710,13 +710,13 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
>  
>  	if (s->flags & __CMPXCHG_DOUBLE) {
>  		ret = __update_freelist_fast(slab, freelist_old, counters_old,
> -				            freelist_new, counters_new);
> +					    freelist_new, counters_new);
>  	} else {
>  		unsigned long flags;
>  
>  		local_irq_save(flags);
>  		ret = __update_freelist_slow(slab, freelist_old, counters_old,
> -				            freelist_new, counters_new);
> +					     freelist_new, counters_new);

Please no drive-by fixups of whitespace in code you're not actually
changing. I thought you agreed in v3?

>  static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
>  					     struct list_lru *lru,
>  					     struct obj_cgroup **objcgp,
> @@ -2314,7 +2364,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
>  					 struct kmem_cache *s, gfp_t gfp)
>  {
>  	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> -		memcg_alloc_slab_cgroups(slab, s, gfp, true);
> +		alloc_slab_obj_exts(slab, s, gfp, true);

This is still guarded by the memcg_kmem_online() static key, which is good.

>  
>  	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
>  			    PAGE_SIZE << order);
> @@ -2323,8 +2373,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
>  static __always_inline void unaccount_slab(struct slab *slab, int order,
>  					   struct kmem_cache *s)
>  {
> -	if (memcg_kmem_online())
> -		memcg_free_slab_cgroups(slab);
> +	free_slab_obj_exts(slab);

But this no longer is, yet it still could be?

>  
>  	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
>  			    -(PAGE_SIZE << order));


