Return-Path: <linux-fsdevel+bounces-14434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D087CBB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 11:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444822833F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158611AACF;
	Fri, 15 Mar 2024 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kIeV/N+n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4muqVjs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kIeV/N+n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4muqVjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04C19474;
	Fri, 15 Mar 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500337; cv=none; b=ADK6iyvmqlO0bpszkQnFd2HMJTJlOsKUi6jjo678k7pHmCX+Pb1E1DIdWbsZvGPNzyF+6ezOqzREz35fYxoauWHr6dNGiOgOgtP7l7K5wBjmz+NWjAJfbsymffAxbG+9GTxioTGXQWp8MPd7pgDFkMxiPe8fSuLI2uRB9p2dpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500337; c=relaxed/simple;
	bh=bLXi0Kv2aTCp63cNUTwNkTolcU7Fdj7oossLerdiFcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mokFSlsCyn/pc7u8J/SYlROAZjToEGytjMRd38KQYxDqX97/yYZSzfmCojICe1c0yKIb/+VvpKnW97Ra/y+Uyag66QqYLf7FJ1prXWqC42yUUPqZEU/7+GM+18hdlIv8sQSBxNVoMrHopWh1SKkTZpo0vfABWVoHo98W2hZtBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kIeV/N+n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4muqVjs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kIeV/N+n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4muqVjs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50E4E21DD2;
	Fri, 15 Mar 2024 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710500333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9muM8bo+rTj/3DcyAeA4j1Dljj8nhnMTXgWWpTVnpQM=;
	b=kIeV/N+n1Qjn4RwdctLpBJA/ti5qrD6sZCC/MPiMggb17MFzRe5HBe0AQTNROQDaKSju7R
	a0SLFUAt+MJiKmd9tkmDZZP0d8BIvQQaQcoE33BtEHz87wjWhVe0H/xpFhRF3pbknSydFH
	TYmRZwi/PzREciTT3ulCpGUJ5who+rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710500333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9muM8bo+rTj/3DcyAeA4j1Dljj8nhnMTXgWWpTVnpQM=;
	b=N4muqVjs0s0Jytaoa8YUY3ruVKbKV/g3CLqo9GREsnONsvr9go6NQwryE9JTCFZbAjNLnA
	uwWsA04tQTN0rHCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710500333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9muM8bo+rTj/3DcyAeA4j1Dljj8nhnMTXgWWpTVnpQM=;
	b=kIeV/N+n1Qjn4RwdctLpBJA/ti5qrD6sZCC/MPiMggb17MFzRe5HBe0AQTNROQDaKSju7R
	a0SLFUAt+MJiKmd9tkmDZZP0d8BIvQQaQcoE33BtEHz87wjWhVe0H/xpFhRF3pbknSydFH
	TYmRZwi/PzREciTT3ulCpGUJ5who+rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710500333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9muM8bo+rTj/3DcyAeA4j1Dljj8nhnMTXgWWpTVnpQM=;
	b=N4muqVjs0s0Jytaoa8YUY3ruVKbKV/g3CLqo9GREsnONsvr9go6NQwryE9JTCFZbAjNLnA
	uwWsA04tQTN0rHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4DD81368C;
	Fri, 15 Mar 2024 10:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BxitK+wp9GU7dwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Mar 2024 10:58:52 +0000
Message-ID: <1f51ffe8-e5b9-460f-815e-50e3a81c57bf@suse.cz>
Date: Fri, 15 Mar 2024 11:58:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/37] mm/slab: add allocation accounting into slab
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
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
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
 aliceryhl@google.com, rientjes@google.com, minchan@google.com,
 kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-24-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240306182440.2003814-24-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[76];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,nvidia.com,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="kIeV/N+n";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N4muqVjs
X-Rspamd-Queue-Id: 50E4E21DD2

On 3/6/24 19:24, Suren Baghdasaryan wrote:
> Account slab allocations using codetag reference embedded into slabobj_ext.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> @@ -3833,6 +3913,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
>  			  unsigned int orig_size)
>  {
>  	unsigned int zero_size = s->object_size;
> +	struct slabobj_ext *obj_exts;
>  	bool kasan_init = init;
>  	size_t i;
>  	gfp_t init_flags = flags & gfp_allowed_mask;
> @@ -3875,6 +3956,12 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, init_flags);
>  		kmsan_slab_alloc(s, p[i], init_flags);
> +		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +		/* obj_exts can be allocated for other reasons */
> +		if (likely(obj_exts) && mem_alloc_profiling_enabled())
> +			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
> +#endif

I think you could still do this a bit better:

Check mem_alloc_profiling_enabled() once before the whole block calling
prepare_slab_obj_exts_hook() and alloc_tag_add()
Remove need_slab_obj_ext() check from prepare_slab_obj_exts_hook()

>  	}
>  
>  	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> @@ -4353,6 +4440,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	       unsigned long addr)
>  {
>  	memcg_slab_free_hook(s, slab, &object, 1);
> +	alloc_tagging_slab_free_hook(s, slab, &object, 1);
>  
>  	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>  		do_slab_free(s, slab, object, object, 1, addr);
> @@ -4363,6 +4451,7 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
>  		    void *tail, void **p, int cnt, unsigned long addr)
>  {
>  	memcg_slab_free_hook(s, slab, p, cnt);
> +	alloc_tagging_slab_free_hook(s, slab, p, cnt);
>  	/*
>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
>  	 * to remove objects, whose reuse must be delayed.


