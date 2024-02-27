Return-Path: <linux-fsdevel+bounces-12950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307A86915F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F7F2910BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715813B28B;
	Tue, 27 Feb 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lLjXBkwS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QuOdtqlw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDeXG6qf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7kVZZ2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E31332A7;
	Tue, 27 Feb 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039236; cv=none; b=Mio4j+JMNG3gMZG/6mVL1ZR74IJAu3p0R9svJd0VTj9DyaCi9wvSWhahm1sUTFV5pw0iNwlNGwYhFblZfaPoTLvRFgQqKB/CwiZ1xs4gwTlHvvsNbn24BgTUb6OQwpHgIv3TeC0WiyiCv+v+t5qYpiOFR/j2ORhAIa2j2l8YObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039236; c=relaxed/simple;
	bh=0isnxikG8GrDJkS92OJPHouLCX1i2vGfJQ6mWe0D9QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWKCz7FiL3CBvxmYo/SbyOmvBykcvGXO24/TOxl4snwSNIssaQlqH+XFVgXiKF2co4BH0KwbkWa9HW+NOs3QR8zIehiDiq96UrWJRw/IVdpUqnF3A4hqiw9061n7vgjGttTXA5Ik6Ft/HyG7v6jnVUaPjgGtdY/HARk/9F0bgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lLjXBkwS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QuOdtqlw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDeXG6qf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7kVZZ2b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8D1D1FB96;
	Tue, 27 Feb 2024 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709039230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cW70zYu78ce27du6nFlEM9h9LcRqy3qIdoJOEMgxHrU=;
	b=lLjXBkwSq4zVWDpU6/ofgbzfBCnuGD7WdSXfD8ViQQRE1+HKJbO34+Gzh29oHqfhywajAJ
	xd6VpHYHeA+lMIDc2X0LUuilIJLgFgRUWpX0+2USkX8CkBSSuM5wQ8HcvRNtGEJDU8zQzg
	B1EiPMFl21up4fU4/nhvYVWOow9hpcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709039230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cW70zYu78ce27du6nFlEM9h9LcRqy3qIdoJOEMgxHrU=;
	b=QuOdtqlwB2n5UpUvZAQXn1p6d3jd41mAMNMufuBBkSELyBp/2B9PV6bswWPZs/NGwzSwma
	MfH9Uc8gUFNHdnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709039228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cW70zYu78ce27du6nFlEM9h9LcRqy3qIdoJOEMgxHrU=;
	b=TDeXG6qfFssifgl/IwZPUo2hz8sRgPKz7Rc+MiJVTP4aR1BZWy7Q6jkFcRNhFXSoq9UfSu
	cN35aZnq5noMPiPIwcTJ6Wbc9eN5lKdjPWO9jqaZdLUwn/xvaDQoSSCKZCpxQKC8uBTm+U
	soVbxLp9C4/rdFn1gbl5nYmN0zVuniQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709039228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cW70zYu78ce27du6nFlEM9h9LcRqy3qIdoJOEMgxHrU=;
	b=x7kVZZ2bAkzoDmE//U9l56lfDmWmTUJkTS193DKe/lp6VGXut63+mJFIV0tJi7b7AxADyk
	Pb79/ZLGUtSXyIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F129813A58;
	Tue, 27 Feb 2024 13:07:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XexAOnre3WWJKQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Feb 2024 13:07:06 +0000
Message-ID: <4a0e40e5-3542-4d47-bb2b-c0666f6a904d@suse.cz>
Date: Tue, 27 Feb 2024 14:07:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/36] mm/slab: add allocation accounting into slab
 allocation and free paths
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
 <20240221194052.927623-23-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-23-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_GT_50(0.00)[74];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO



On 2/21/24 20:40, Suren Baghdasaryan wrote:
> Account slab allocations using codetag reference embedded into slabobj_ext.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/slab.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/slub.c |  9 ++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 13b6ba2abd74..c4bd0d5348cb 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -567,6 +567,46 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  			gfp_t gfp, bool new_slab);
>  
> +static inline bool need_slab_obj_ext(void)
> +{
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +	if (mem_alloc_profiling_enabled())
> +		return true;
> +#endif
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
> +	if (s->flags & SLAB_NO_OBJ_EXT)
> +		return NULL;
> +
> +	if (flags & __GFP_NO_OBJ_EXT)
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
> +}
> +
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
>  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> @@ -589,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>  
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +
> +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +					void **p, int objects)

Only used from mm/slub.c so could move?

> +{
> +	struct slabobj_ext *obj_exts;
> +	int i;
> +
> +	obj_exts = slab_obj_exts(slab);
> +	if (!obj_exts)
> +		return;
> +
> +	for (i = 0; i < objects; i++) {
> +		unsigned int off = obj_to_index(s, slab, p[i]);
> +
> +		alloc_tag_sub(&obj_exts[off].ref, s->size);
> +	}
> +}
> +
> +#else
> +
> +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +					void **p, int objects) {}
> +
> +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		     enum node_stat_item idx, int nr);
> diff --git a/mm/slub.c b/mm/slub.c
> index 5dc7beda6c0d..a69b6b4c8df6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3826,6 +3826,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
>  			  unsigned int orig_size)
>  {
>  	unsigned int zero_size = s->object_size;
> +	struct slabobj_ext *obj_exts;
>  	bool kasan_init = init;
>  	size_t i;
>  	gfp_t init_flags = flags & gfp_allowed_mask;
> @@ -3868,6 +3869,12 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, init_flags);
>  		kmsan_slab_alloc(s, p[i], init_flags);
> +		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +		/* obj_exts can be allocated for other reasons */
> +		if (likely(obj_exts) && mem_alloc_profiling_enabled())
> +			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
> +#endif

I think that like in the page allocator, this could be better guarded by
mem_alloc_profiling_enabled() as the outermost thing.

>  	}
>  
>  	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> @@ -4346,6 +4353,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	       unsigned long addr)
>  {
>  	memcg_slab_free_hook(s, slab, &object, 1);
> +	alloc_tagging_slab_free_hook(s, slab, &object, 1);

Same here, the static key is not even inside of this?

>  
>  	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>  		do_slab_free(s, slab, object, object, 1, addr);
> @@ -4356,6 +4364,7 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
>  		    void *tail, void **p, int cnt, unsigned long addr)
>  {
>  	memcg_slab_free_hook(s, slab, p, cnt);
> +	alloc_tagging_slab_free_hook(s, slab, p, cnt);

Ditto.

>  	/*
>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
>  	 * to remove objects, whose reuse must be delayed.

