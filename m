Return-Path: <linux-fsdevel+bounces-11760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7283856F5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663C01F235EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692F4141995;
	Thu, 15 Feb 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8Nsov5u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GUVg/06b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8Nsov5u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GUVg/06b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3C13B791;
	Thu, 15 Feb 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032672; cv=none; b=omc/Umv8J5pAcjB0xIvMDovJVBp2UHBdW7++lox5E4VCAcsNJsnu11k1gNGJNhSh/eUr7J/W1wVuDoxy3PhbV8S8Zvrl3pzY6V5MPBNwA0RhMsjPuiUxJzaXVv6qE0EpFvaoG0eZAr+d204QMj8DTBfzRdvM8MfSs+HFpx6d948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032672; c=relaxed/simple;
	bh=3yDM0ZP46pK4fnHSsmL6R3X/38sqCvjEVTAglOUb9wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEP3QbSGkX9bqJ+hn4/GSCbAP451kwdv7qkdLMZB9xpRIi4pypJZhbrwe9Kcpafg0B9+2R8hwylf3zLH6o0D2gEMvLW+t2iIQOSNSs2N4i4mpWlE13wCfp2fKWHNtHyNJwAjL/Rp9Qg8AlNGF0jfhbdJzDEDJiluk/LorgirbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8Nsov5u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GUVg/06b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8Nsov5u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GUVg/06b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5084E21DA7;
	Thu, 15 Feb 2024 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708032668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6ZvPT33F9NrnVg8JxGTJmzEamMsclNNB8LU0yx6M8A=;
	b=E8Nsov5uPAg0mjeawQLdoRqATRoEAbDe5XO0GEM9WfnKB2qR2mwNAuZhKByuBRYOwzIfk7
	eZoQN0V5wp2YxP2Z7PJ/DBcdIOioFKPJeTjWdyzxiI5ORqpKlwby00VGVLzbyv1YO342n5
	DUhv2kwS9+B6ed+MTfF2cLRtkaA/5HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708032668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6ZvPT33F9NrnVg8JxGTJmzEamMsclNNB8LU0yx6M8A=;
	b=GUVg/06bHbX3QUnYbZbacX02nQLtbZN/1obCAsDgxplA2OXNsNNjCi234wRWw1iP7VbUIR
	yqFA84e/GWorUVDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708032668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6ZvPT33F9NrnVg8JxGTJmzEamMsclNNB8LU0yx6M8A=;
	b=E8Nsov5uPAg0mjeawQLdoRqATRoEAbDe5XO0GEM9WfnKB2qR2mwNAuZhKByuBRYOwzIfk7
	eZoQN0V5wp2YxP2Z7PJ/DBcdIOioFKPJeTjWdyzxiI5ORqpKlwby00VGVLzbyv1YO342n5
	DUhv2kwS9+B6ed+MTfF2cLRtkaA/5HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708032668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6ZvPT33F9NrnVg8JxGTJmzEamMsclNNB8LU0yx6M8A=;
	b=GUVg/06bHbX3QUnYbZbacX02nQLtbZN/1obCAsDgxplA2OXNsNNjCi234wRWw1iP7VbUIR
	yqFA84e/GWorUVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D6D813A53;
	Thu, 15 Feb 2024 21:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LUvEpuCzmWGSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 21:31:07 +0000
Message-ID: <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz>
Date: Thu, 15 Feb 2024 22:31:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
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
 <20240212213922.783301-8-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-8-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E8Nsov5u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="GUVg/06b"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_GT_50(0.00)[73];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[25.68%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.00
X-Rspamd-Queue-Id: 5084E21DA7
X-Spam-Flag: NO

On 2/12/24 22:38, Suren Baghdasaryan wrote:
> Slab extension objects can't be allocated before slab infrastructure is
> initialized. Some caches, like kmem_cache and kmem_cache_node, are created
> before slab infrastructure is initialized. Objects from these caches can't
> have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
> caches and avoid creating extensions for objects allocated from these
> slabs.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/slab.h | 7 +++++++
>  mm/slub.c            | 5 +++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b5f5ee8308d0..3ac2fc830f0f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -164,6 +164,13 @@
>  #endif
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>  
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +/* Slab created using create_boot_cache */
> +#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)

There's
   #define SLAB_SKIP_KFENCE        ((slab_flags_t __force)0x20000000U)
already, so need some other one?

> +#else
> +#define SLAB_NO_OBJ_EXT         0
> +#endif
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> diff --git a/mm/slub.c b/mm/slub.c
> index 1eb1050814aa..9fd96238ed39 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5650,7 +5650,8 @@ void __init kmem_cache_init(void)
>  		node_set(node, slab_nodes);
>  
>  	create_boot_cache(kmem_cache_node, "kmem_cache_node",
> -		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
> +			sizeof(struct kmem_cache_node),
> +			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
>  
>  	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
>  
> @@ -5660,7 +5661,7 @@ void __init kmem_cache_init(void)
>  	create_boot_cache(kmem_cache, "kmem_cache",
>  			offsetof(struct kmem_cache, node) +
>  				nr_node_ids * sizeof(struct kmem_cache_node *),
> -		       SLAB_HWCACHE_ALIGN, 0, 0);
> +			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
>  
>  	kmem_cache = bootstrap(&boot_kmem_cache);
>  	kmem_cache_node = bootstrap(&boot_kmem_cache_node);


