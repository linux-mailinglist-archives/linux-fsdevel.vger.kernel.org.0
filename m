Return-Path: <linux-fsdevel+bounces-11593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A9855173
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 19:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258121C290DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3607129A70;
	Wed, 14 Feb 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aK+8VjyI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Psgv+7MZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aK+8VjyI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Psgv+7MZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17C127B51;
	Wed, 14 Feb 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933552; cv=none; b=Zgu9o4G5j9Jos+HuS0vo4E4Lw/DB7fwJ7R199lwrNPWqUCxdUMcVAdDLuHk7XrLj+MGyIibQr1JQ9ZnHWRTsQy2NmGaNEz7sMwuLwiJDmjv3LElUlhwTSCk2LGpSZQnYJxMMMj470UXkK/ejQ9BtEcu8sHG3UQIBpqgl/2DjtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933552; c=relaxed/simple;
	bh=9V0iplNY41PM7qEgN8bqjGbfH2zuN+jagfpAQuGGGCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSQI/OmUEAFvL2979z3i/3eS/SLSalTdzShB8F9yCfFJ/1R0iB4kLPjNZu4pbl+uzbfUdkNSVoPMF5eOnQ9Cp9BuvmBR7aKWTm093Ajs4oXa7kYQR+UT67tanWILP9lK12CTEioLAVMGWr/6OPszIsD9xdSoy4UraFxsbM8GsFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aK+8VjyI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Psgv+7MZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aK+8VjyI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Psgv+7MZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 147452207D;
	Wed, 14 Feb 2024 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707933548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2RWtNk8U1R2XRFQl1j1CoYNmJnR10fxgpFPBsng0LI=;
	b=aK+8VjyIaHpcdTKDOIsz5Dbg+qMpGN+F023AOzqddNbIfq73gfsEKREJMDDJVrMeddBxDH
	y/jmcG8oIsiuYjaYRXJ6hRHScHzyIkrEsxooTPm81qEVH9/NYPfK+XH92v4riFamS0n3vK
	g0CfCWblAz1VGwP7B6hXh/8EdncqQxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707933548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2RWtNk8U1R2XRFQl1j1CoYNmJnR10fxgpFPBsng0LI=;
	b=Psgv+7MZTA60P9ZPDJ7pfz/hWkKqrnS24bNJS16VF6X116lWn7Dj9qqKsI0svfIgaI+dz6
	w/Ig421ykrX9vsAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707933548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2RWtNk8U1R2XRFQl1j1CoYNmJnR10fxgpFPBsng0LI=;
	b=aK+8VjyIaHpcdTKDOIsz5Dbg+qMpGN+F023AOzqddNbIfq73gfsEKREJMDDJVrMeddBxDH
	y/jmcG8oIsiuYjaYRXJ6hRHScHzyIkrEsxooTPm81qEVH9/NYPfK+XH92v4riFamS0n3vK
	g0CfCWblAz1VGwP7B6hXh/8EdncqQxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707933548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2RWtNk8U1R2XRFQl1j1CoYNmJnR10fxgpFPBsng0LI=;
	b=Psgv+7MZTA60P9ZPDJ7pfz/hWkKqrnS24bNJS16VF6X116lWn7Dj9qqKsI0svfIgaI+dz6
	w/Ig421ykrX9vsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5910813A6D;
	Wed, 14 Feb 2024 17:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Om60FGv/zGWRTgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 Feb 2024 17:59:07 +0000
Message-ID: <3cf2acae-cb8d-455a-b09d-a1fdc52f5774@suse.cz>
Date: Wed, 14 Feb 2024 18:59:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/35] mm: introduce slabobj_ext to support slab object
 extensions
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-6-surenb@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-6-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aK+8VjyI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Psgv+7MZ
X-Spamd-Result: default: False [-5.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 147452207D
X-Spam-Level: 
X-Spam-Score: -5.30
X-Spam-Flag: NO

On 2/12/24 22:38, Suren Baghdasaryan wrote:
> Currently slab pages can store only vectors of obj_cgroup pointers in
> page->memcg_data. Introduce slabobj_ext structure to allow more data
> to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> to support current functionality while allowing to extend slabobj_ext
> in the future.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

...

> +static inline bool need_slab_obj_ext(void)
> +{
> +	/*
> +	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
> +	 * inside memcg_slab_post_alloc_hook. No other users for now.
> +	 */
> +	return false;
> +}
> +
> +static inline struct slabobj_ext *
> +prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> +{
> +	struct slab *slab;
> +
> +	if (!p)
> +		return NULL;
> +
> +	if (!need_slab_obj_ext())
> +		return NULL;
> +
> +	slab = virt_to_slab(p);
> +	if (!slab_obj_exts(slab) &&
> +	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
> +		 "%s, %s: Failed to create slab extension vector!\n",
> +		 __func__, s->name))
> +		return NULL;
> +
> +	return slab_obj_exts(slab) + obj_to_index(s, slab, p);

This is called in slab_post_alloc_hook() and the result stored to obj_exts
but unused. Maybe introduce this only in a later patch where it becomes
relevant?

> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -201,6 +201,54 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +/*
> + * The allocated objcg pointers array is not accounted directly.
> + * Moreover, it should not come from DMA buffer and is not readily
> + * reclaimable. So those GFP bits should be masked off.
> + */
> +#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
> +				__GFP_ACCOUNT | __GFP_NOFAIL)
> +
> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> +			gfp_t gfp, bool new_slab)

Since you're moving this function between files anyway, could you please
instead move it to mm/slub.c. I expect we'll eventually (maybe even soon)
move the rest of performance sensitive kmemcg hooks there as well to make
inlining possible.

> +{
> +	unsigned int objects = objs_per_slab(s, slab);
> +	unsigned long obj_exts;
> +	void *vec;
> +
> +	gfp &= ~OBJCGS_CLEAR_MASK;
> +	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> +			   slab_nid(slab));
> +	if (!vec)
> +		return -ENOMEM;
> +
> +	obj_exts = (unsigned long)vec;
> +#ifdef CONFIG_MEMCG
> +	obj_exts |= MEMCG_DATA_OBJEXTS;
> +#endif
> +	if (new_slab) {
> +		/*
> +		 * If the slab is brand new and nobody can yet access its
> +		 * obj_exts, no synchronization is required and obj_exts can
> +		 * be simply assigned.
> +		 */
> +		slab->obj_exts = obj_exts;
> +	} else if (cmpxchg(&slab->obj_exts, 0, obj_exts)) {
> +		/*
> +		 * If the slab is already in use, somebody can allocate and
> +		 * assign slabobj_exts in parallel. In this case the existing
> +		 * objcg vector should be reused.
> +		 */
> +		kfree(vec);
> +		return 0;
> +	}
> +
> +	kmemleak_not_leak(vec);
> +	return 0;
> +}
> +#endif /* CONFIG_SLAB_OBJ_EXT */
> +
>  static struct kmem_cache *create_cache(const char *name,
>  		unsigned int object_size, unsigned int align,
>  		slab_flags_t flags, unsigned int useroffset,
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..1eb1050814aa 100644
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
> +					    freelist_new, counters_new);

I can see the mixing of tabs and spaces is wrong but perhaps not fix it as
part of the series?

>  		local_irq_restore(flags);
>  	}
>  	if (likely(ret))
> @@ -1881,13 +1881,25 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>  		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
>  }
>  
> -#ifdef CONFIG_MEMCG_KMEM
> -static inline void memcg_free_slab_cgroups(struct slab *slab)
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +static inline void free_slab_obj_exts(struct slab *slab)

Right, freeing is already here, so makes sense put the allocation here as well.

> @@ -3817,6 +3820,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, init_flags);
>  		kmsan_slab_alloc(s, p[i], init_flags);
> +		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);

Yeah here's the hook used. Doesn't it generate a compiler warning? Maybe at
least postpone the call until the result is further used.

>  	}
>  
>  	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);


