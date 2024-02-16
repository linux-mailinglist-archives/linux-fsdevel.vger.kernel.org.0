Return-Path: <linux-fsdevel+bounces-11862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A2858278
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D47281302
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43963130AC9;
	Fri, 16 Feb 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PvWNYFER";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+FYGDISJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w2RqONsA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eEYKBvcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5391DFF0;
	Fri, 16 Feb 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101078; cv=none; b=VZn72trY6y6L7XbEsEGGmj54/L1ZvaodRiK1ky48DdNhl3HJeinmdNeF1AeAZiEZsXhUVjV08a0pSjglMvj6nNGFtOtximoebeq7DtI54GQmUVygELxuJoZdwtvhuA41/7URy1ShnxgKoz5fZWZ4yM8unM9bQUkyWm/btI0OxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101078; c=relaxed/simple;
	bh=+pZ1ryuaBWtnB9/+TYxnV0GLBmD4Hr4MBmuOHCG4Kwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxFHHCO0R4SqEt1XHVhD3b15xT/+uIgFhfUf7w2Ywjtus2kLSF5af96z9uNzxPuel4USXQFesWXSIp+1Hb61DiFJmo0RwusoSwuq2kLXxa9FDipTS65K5xx5CwJ9cVfohFXCnQ3MGM+JoJJBGDHtmAo4F3H6J1Nexivy5bvyHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PvWNYFER; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+FYGDISJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w2RqONsA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eEYKBvcE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D015A1FB81;
	Fri, 16 Feb 2024 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708101074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPLurTqAKLnQ458IhhqsUiDYFpmaxE3prWq99XPtm2A=;
	b=PvWNYFERdBj6/X38g8RBED/odsY20Q+KehPIlVU0G6U0b4vOUZmfj77qPboFhrp7Bd9CnV
	0H2m1Gs1s8M3CQCPnvyvZK5n8Vf4tyAdtWp1+uqsjkpDh3cFGiIYHtEbze0tARZthulYoj
	PJQNhMLmZSbaaCV+ep7Hhzl4ewWkCeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708101074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPLurTqAKLnQ458IhhqsUiDYFpmaxE3prWq99XPtm2A=;
	b=+FYGDISJl02L7Oya4mQkx8/oWxMYWCf6DNOnjrKyNJPJKOBikQpCCKkKlBHLHnUGiMgp7b
	aW1Yl2TtAoEfNHBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708101072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPLurTqAKLnQ458IhhqsUiDYFpmaxE3prWq99XPtm2A=;
	b=w2RqONsAnc+GQMiPPww7rXdu6p7bKILnnJPgLwqTzKH0H7OXuM5DPfFo7Pvy2me/P2YVTh
	X63CzX9gRR1UZXOHy3bxAPJwojhSeLTbLhs0AIN5O5TkNEp9cxwS37Dc0ugthfG9h0ZZXg
	1pmrr2oxaR6lSO0gSf6iGntKIz6gSSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708101072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPLurTqAKLnQ458IhhqsUiDYFpmaxE3prWq99XPtm2A=;
	b=eEYKBvcE3fUI6yqCe5di1cJaiYnNwB+JhiJpTBU1abe/HW09sf7huSfQ37SMWxMIagWemO
	dg2ebBA8JFTuH/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CE2F1398D;
	Fri, 16 Feb 2024 16:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bsViDtCNz2U/UAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 16:31:12 +0000
Message-ID: <ec0f9be2-d544-45a6-b6a9-178872b27bd4@suse.cz>
Date: Fri, 16 Feb 2024 17:31:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/35] mm/slab: add allocation accounting into slab
 allocation and free paths
Content-Language: en-US
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
 <20240212213922.783301-22-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-22-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
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
	 BAYES_HAM(-0.00)[19.51%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.41
X-Spam-Flag: NO

On 2/12/24 22:39, Suren Baghdasaryan wrote:
> Account slab allocations using codetag reference embedded into slabobj_ext.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  mm/slab.h | 26 ++++++++++++++++++++++++++
>  mm/slub.c |  5 +++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 224a4b2305fb..c4bd0d5348cb 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -629,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>  
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +
> +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +					void **p, int objects)
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

You don't actually use the alloc_tagging_slab_free_hook() anywhere? I see
it's in the next patch, but logically should belong to this one.

> +
>  #ifdef CONFIG_MEMCG_KMEM
>  void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		     enum node_stat_item idx, int nr);
> diff --git a/mm/slub.c b/mm/slub.c
> index 9fd96238ed39..f4d5794c1e86 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3821,6 +3821,11 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
>  					 s->flags, init_flags);
>  		kmsan_slab_alloc(s, p[i], init_flags);
>  		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +		/* obj_exts can be allocated for other reasons */
> +		if (likely(obj_exts) && mem_alloc_profiling_enabled())
> +			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
> +#endif
>  	}
>  
>  	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);


