Return-Path: <linux-fsdevel+bounces-11854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5602185817A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C146AB251AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D3132461;
	Fri, 16 Feb 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fXAS9CXU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLNfUmnQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dSrBHIt3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fpMAcemL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8512FF81;
	Fri, 16 Feb 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097782; cv=none; b=rL5+7YAk3PRS95obvixq6ADqJzb6cHM7mS98sThPK+aPg/tAiPVkfBqC7bR+7UUt3k3aIOGDAq6wBrewd8WiEQnE+UlyKDtncMmtdxvsZm8AtDQFHyngb2olvcwJNHB2itwNzRY8pnaE20Ulpifv5Q2OtzQiBfJjKEVOP6+4s+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097782; c=relaxed/simple;
	bh=pah9zYc57F+4qGNmZRKDvZpI9hjcQlXtnd316b/T9NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLNUm0d6NvJvDq8mJbUz7A6bLxIKqo2/EKfeU0uWxaTsOrtV84pywmVgKOqeGPdfYtX402Hz8LKwNe7H8fDzo7UvYD/rToEQfgZKi2ggJP4ywIMJXK6PHxP9M1Qc39jt+dcUMC6b44TfrwVWsX9huHqUjBa3jpSHCO9AP6n9Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fXAS9CXU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLNfUmnQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dSrBHIt3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fpMAcemL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A575220A7;
	Fri, 16 Feb 2024 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708097778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4vJJ3H+AAWRQYjB/9/s6lx7LTkhnUXf/MDDTj+Stkc=;
	b=fXAS9CXUF42GhTQH6Dk0ERLDWz+szvtqS4hbHz5hlzO72H5LWH2Wl77vKwF3bU9qC4xybd
	HjdmQMfgq/Ycq/gNBcmd7PjKo0cEFheG5OeZ6u/bHVMIQAXHtaIoL5Yj6ebO2LJG9XS+CX
	3+Vje1sZ5ixTYH+20X2ftwyiFvloZpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708097778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4vJJ3H+AAWRQYjB/9/s6lx7LTkhnUXf/MDDTj+Stkc=;
	b=wLNfUmnQHWUDcdPKHwqLu3owRKTcVnwUnzDkwDQ8YYC0pW/hmoNyjQ563BD46+xsjNDUuK
	MhOxPwPapwY2PFAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708097777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4vJJ3H+AAWRQYjB/9/s6lx7LTkhnUXf/MDDTj+Stkc=;
	b=dSrBHIt3uKiS6UBDA1LDFuJGGqb41Kz/+40/qb22uPi50OBP7amfOHDriG5mkg+NJmWi+U
	qsA7fyXiGrj2MiQRrsQVZThBVvedh2cLeqzrNBzmZGLofYe75EsMAx6s8Xg8OeXMG3SdXd
	43cxzKzLMshU7AwlCJqyXmmWyY6b2aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708097777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4vJJ3H+AAWRQYjB/9/s6lx7LTkhnUXf/MDDTj+Stkc=;
	b=fpMAcemL/HQ2lY2evYrW3COdALzWdIIUtvO+/lOtuXTDIKbWXIYZrSnv/m78K626CI9TBX
	31xVPf3QzycPgYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3BB013A39;
	Fri, 16 Feb 2024 15:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xg0ZM/CAz2W1QwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 15:36:16 +0000
Message-ID: <e845a3ee-e6c0-47dd-81e9-ae0fb08886d1@suse.cz>
Date: Fri, 16 Feb 2024 16:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/35] lib: add codetag reference into slabobj_ext
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
 <20240212213922.783301-21-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-21-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dSrBHIt3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fpMAcemL
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
X-Rspamd-Queue-Id: 8A575220A7
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/12/24 22:39, Suren Baghdasaryan wrote:
> To store code tag for every slab object, a codetag reference is embedded
> into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/memcontrol.h | 5 +++++
>  lib/Kconfig.debug          | 1 +
>  mm/slab.h                  | 4 ++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f3584e98b640..2b010316016c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1653,7 +1653,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>   * if MEMCG_DATA_OBJEXTS is set.
>   */
>  struct slabobj_ext {
> +#ifdef CONFIG_MEMCG_KMEM
>  	struct obj_cgroup *objcg;
> +#endif
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +	union codetag_ref ref;
> +#endif
>  } __aligned(8);

So this means that compiling with CONFIG_MEM_ALLOC_PROFILING will increase
the memory overhead of arrays allocated for CONFIG_MEMCG_KMEM, even if
allocation profiling itself is not enabled in runtime? Similar concern to
the unconditional page_ext usage, that this would hinder enabling in a
general distro kernel.

The unused field overhead would be smaller than currently page_ext, but
getting rid of it when alloc profiling is not enabled would be more work
than introducing an early boot param for the page_ext case. Could be however
solved similarly to how page_ext is populated dynamically at runtime.
Hopefully it wouldn't add noticeable cpu overhead.

>  static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7bbdb0ddb011..9ecfcdb54417 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -979,6 +979,7 @@ config MEM_ALLOC_PROFILING
>  	depends on !DEBUG_FORCE_WEAK_PER_CPU
>  	select CODE_TAGGING
>  	select PAGE_EXTENSION
> +	select SLAB_OBJ_EXT
>  	help
>  	  Track allocation source code and record total allocation size
>  	  initiated at that code location. The mechanism can be used to track
> diff --git a/mm/slab.h b/mm/slab.h
> index 77cf7474fe46..224a4b2305fb 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -569,6 +569,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  
>  static inline bool need_slab_obj_ext(void)
>  {
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +	if (mem_alloc_profiling_enabled())
> +		return true;
> +#endif
>  	/*
>  	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
>  	 * inside memcg_slab_post_alloc_hook. No other users for now.


