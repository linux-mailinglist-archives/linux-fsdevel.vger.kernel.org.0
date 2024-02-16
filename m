Return-Path: <linux-fsdevel+bounces-11883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE655858566
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D2C282050
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9731353EC;
	Fri, 16 Feb 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3D8vPec";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z69yD9wW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3D8vPec";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z69yD9wW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051141339B1;
	Fri, 16 Feb 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108801; cv=none; b=I8ha4bPaBZgdZf/lonJYukI9A7x5/eS7pZXzRS/DjBpJ3wg1EMQffqdO9zYwT3eG/mP70Ao/c8fR6v4xWBJFhwQQukaYFnoiYp0DaxT2cJwtoexOt9mvRtb/Ra4tfoS0IccfSc3L21QCepiD69dnD3xe8M5fswLz7EVEG21dZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108801; c=relaxed/simple;
	bh=W3xZTWVFlItRUlgXMgoc0VAaiaG33E2DoCPxs2ZMPAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBBCSrywsbvwTW3e6NalIS2fLolHZyj1HvkrNL52DpQcUMmm3WA7Wn5T6RrRCXDOJFL3Iowybwn5D50xJ7VBoQr11+1F/xwcBAVjhoTpjSKySYPsy0Gms5NCEGO4evShpSkx9yQAh44xtNarvNksHI3HEVR7mOBUL8lZfQY3Ui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3D8vPec; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z69yD9wW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3D8vPec; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z69yD9wW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0796D1FB78;
	Fri, 16 Feb 2024 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708108797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owuEgnvOaosc1e6fEV37dsj+Uoc2y36g1E2N9MOPSbU=;
	b=T3D8vPec3pNpFlXmod27xj43+za8xehJtXjEJjuRtBo/mktHW05oGylB6ezvGFc6PLKMmn
	yPmSLY0xDJ+xp9Z2AET1dy/qNC4j/fo7DfG+YwD2u6qhsEz30g5n3vpoGinmcTRmTFJuEc
	aFyHa0Z9T7HhWJUT9vMlj6ocUutwiaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708108797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owuEgnvOaosc1e6fEV37dsj+Uoc2y36g1E2N9MOPSbU=;
	b=z69yD9wW/OFsQgrqUmJct6GWlXv9jqFb/nEfoePXqTOUsy1f78dsLh7MdrAWwB2IYnRcaf
	4CeMSFQrrJCGawBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708108797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owuEgnvOaosc1e6fEV37dsj+Uoc2y36g1E2N9MOPSbU=;
	b=T3D8vPec3pNpFlXmod27xj43+za8xehJtXjEJjuRtBo/mktHW05oGylB6ezvGFc6PLKMmn
	yPmSLY0xDJ+xp9Z2AET1dy/qNC4j/fo7DfG+YwD2u6qhsEz30g5n3vpoGinmcTRmTFJuEc
	aFyHa0Z9T7HhWJUT9vMlj6ocUutwiaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708108797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owuEgnvOaosc1e6fEV37dsj+Uoc2y36g1E2N9MOPSbU=;
	b=z69yD9wW/OFsQgrqUmJct6GWlXv9jqFb/nEfoePXqTOUsy1f78dsLh7MdrAWwB2IYnRcaf
	4CeMSFQrrJCGawBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0741398D;
	Fri, 16 Feb 2024 18:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ya4MGvyrz2W6awAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 18:39:56 +0000
Message-ID: <f0a56027-472d-44a6-aba5-912bd50ee3ae@suse.cz>
Date: Fri, 16 Feb 2024 19:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/35] codetag: debug: skip objext checking when it's
 for objext itself
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
 <20240212213922.783301-33-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-33-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T3D8vPec;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z69yD9wW
X-Spamd-Result: default: False [1.20 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: 0796D1FB78
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/12/24 22:39, Suren Baghdasaryan wrote:
> objext objects are created with __GFP_NO_OBJ_EXT flag and therefore have
> no corresponding objext themselves (otherwise we would get an infinite
> recursion). When freeing these objects their codetag will be empty and
> when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to false
> warnings. Introduce CODETAG_EMPTY special codetag value to mark
> allocations which intentionally lack codetag to avoid these warnings.
> Set objext codetags to CODETAG_EMPTY before freeing to indicate that
> the codetag is expected to be empty.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
>  mm/slab.h                 | 25 +++++++++++++++++++++++++
>  mm/slab_common.c          |  1 +
>  mm/slub.c                 |  8 ++++++++
>  4 files changed, 60 insertions(+)
> 
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 0a5973c4ad77..1f3207097b03 100644

...

> index c4bd0d5348cb..cf332a839bf4 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -567,6 +567,31 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  			gfp_t gfp, bool new_slab);
>  
> +
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +
> +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
> +{
> +	struct slabobj_ext *slab_exts;
> +	struct slab *obj_exts_slab;
> +
> +	obj_exts_slab = virt_to_slab(obj_exts);
> +	slab_exts = slab_obj_exts(obj_exts_slab);
> +	if (slab_exts) {
> +		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
> +						 obj_exts_slab, obj_exts);
> +		/* codetag should be NULL */
> +		WARN_ON(slab_exts[offs].ref.ct);
> +		set_codetag_empty(&slab_exts[offs].ref);
> +	}
> +}
> +
> +#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> +
> +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
> +
> +#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> +

I assume with alloc_slab_obj_exts() moved to slub.c, mark_objexts_empty()
could move there too.

>  static inline bool need_slab_obj_ext(void)
>  {
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 21b0b9e9cd9e..d5f75d04ced2 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -242,6 +242,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		 * assign slabobj_exts in parallel. In this case the existing
>  		 * objcg vector should be reused.
>  		 */
> +		mark_objexts_empty(vec);
>  		kfree(vec);
>  		return 0;
>  	}
> diff --git a/mm/slub.c b/mm/slub.c
> index 4d480784942e..1136ff18b4fe 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1890,6 +1890,14 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  	if (!obj_exts)
>  		return;
>  
> +	/*
> +	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
> +	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
> +	 * warning if slab has extensions but the extension of an object is
> +	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
> +	 * the extension for obj_exts is expected to be NULL.
> +	 */
> +	mark_objexts_empty(obj_exts);
>  	kfree(obj_exts);
>  	slab->obj_exts = 0;
>  }


