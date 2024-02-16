Return-Path: <linux-fsdevel+bounces-11835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F3E857926
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266641C224F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11FC1BF3A;
	Fri, 16 Feb 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K3GJLk0N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPdo0nzZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K3GJLk0N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPdo0nzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4ED1BDCE;
	Fri, 16 Feb 2024 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076746; cv=none; b=C0c9URupxhwFErvZdptahyXqB+CDLMfFE6byxYZDSPRTClkN8ZnRR+Qxi46nmUrOV9QX9dsu7OSxOJrnr+bwBehYUj/DOOkSZ7SvkFpREXsWA4MPatdIzGMnDfzkh/rB3wLkEaNIwAIS/7CafZRCnIujpf8iFN+ZYeJaOiyVCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076746; c=relaxed/simple;
	bh=WVjbAfHuftK8LltDDQjmFiGwj7PPAcUMu1yWr19lI/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtPFBI6l05E+wM1iV2QjRty3xfflH7nvLS9Q+q/H3rEnl1FWgbWSbK/j71FKqO9q5vCqhKjL2x+y8GrIi73Jr3KN08jnwJTa0A7Py1fh/alJE7Bsq9aQMpOIZiO+RPEk9FbNnFequuoyAjoR+JX36GOCSLrP1CdppNKstlLYW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K3GJLk0N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPdo0nzZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K3GJLk0N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPdo0nzZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9417021B7B;
	Fri, 16 Feb 2024 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708076741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYMvNCYqDaBQbPMA0B0bnoIRN91Lu24uOJ7yYQTso7E=;
	b=K3GJLk0NyXrPMf/aFqjbRry/Qxwjc8Bj/g4q/MeRsSfZAu8Ybdf5Tj7wI+qAyBsgbcC0vR
	xvxA7q+GGIm0yNvWUhWlBiqDWnj8pXbApt4a7yj3KGLQ2wRXaaHf5f+9c+RLhe5CYVhpn1
	ZLX976pxOCFWLoG08M8uzuMAE2T3dv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708076741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYMvNCYqDaBQbPMA0B0bnoIRN91Lu24uOJ7yYQTso7E=;
	b=WPdo0nzZBeg7Is27N5OIoEVPSfjVEKKv5xifLSGaijJGJbFNXXV9iA4sUvGd1/G+OGidNi
	O5Nz+b6HIU0o9pAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708076741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYMvNCYqDaBQbPMA0B0bnoIRN91Lu24uOJ7yYQTso7E=;
	b=K3GJLk0NyXrPMf/aFqjbRry/Qxwjc8Bj/g4q/MeRsSfZAu8Ybdf5Tj7wI+qAyBsgbcC0vR
	xvxA7q+GGIm0yNvWUhWlBiqDWnj8pXbApt4a7yj3KGLQ2wRXaaHf5f+9c+RLhe5CYVhpn1
	ZLX976pxOCFWLoG08M8uzuMAE2T3dv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708076741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYMvNCYqDaBQbPMA0B0bnoIRN91Lu24uOJ7yYQTso7E=;
	b=WPdo0nzZBeg7Is27N5OIoEVPSfjVEKKv5xifLSGaijJGJbFNXXV9iA4sUvGd1/G+OGidNi
	O5Nz+b6HIU0o9pAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF6F313A39;
	Fri, 16 Feb 2024 09:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rhsGNsQuz2WEcAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 09:45:40 +0000
Message-ID: <039a817d-20c4-487d-a443-f87e19727305@suse.cz>
Date: Fri, 16 Feb 2024 10:45:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/35] lib: introduce support for page allocation
 tagging
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
 <20240212213922.783301-15-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-15-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/12/24 22:39, Suren Baghdasaryan wrote:
> Introduce helper functions to easily instrument page allocators by
> storing a pointer to the allocation tag associated with the code that
> allocated the page in a page_ext field.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> +
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +
> +#include <linux/page_ext.h>
> +
> +extern struct page_ext_operations page_alloc_tagging_ops;
> +extern struct page_ext *page_ext_get(struct page *page);
> +extern void page_ext_put(struct page_ext *page_ext);
> +
> +static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
> +{
> +	return (void *)page_ext + page_alloc_tagging_ops.offset;
> +}
> +
> +static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
> +{
> +	return (void *)ref - page_alloc_tagging_ops.offset;
> +}
> +
> +static inline union codetag_ref *get_page_tag_ref(struct page *page)
> +{
> +	if (page && mem_alloc_profiling_enabled()) {
> +		struct page_ext *page_ext = page_ext_get(page);
> +
> +		if (page_ext)
> +			return codetag_ref_from_page_ext(page_ext);

I think when structured like this, you're not getting the full benefits of
static keys, and the compiler probably can't improve that on its own.

- page is tested before the static branch is evaluated
- when disabled, the result is NULL, and that's again tested in the callers

> +	}
> +	return NULL;
> +}
> +
> +static inline void put_page_tag_ref(union codetag_ref *ref)
> +{
> +	page_ext_put(page_ext_from_codetag_ref(ref));
> +}
> +
> +static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
> +				   unsigned int order)
> +{
> +	union codetag_ref *ref = get_page_tag_ref(page);

So the more optimal way would be to test mem_alloc_profiling_enabled() here
as the very first thing before trying to get the ref.

> +	if (ref) {
> +		alloc_tag_add(ref, task->alloc_tag, PAGE_SIZE << order);
> +		put_page_tag_ref(ref);
> +	}
> +}
> +
> +static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
> +{
> +	union codetag_ref *ref = get_page_tag_ref(page);

And same here.

> +	if (ref) {
> +		alloc_tag_sub(ref, PAGE_SIZE << order);
> +		put_page_tag_ref(ref);
> +	}
> +}
> +
> +#else /* CONFIG_MEM_ALLOC_PROFILING */
> +
> +static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
> +				   unsigned int order) {}
> +static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
> +
> +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> +
> +#endif /* _LINUX_PGALLOC_TAG_H */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 78d258ca508f..7bbdb0ddb011 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -978,6 +978,7 @@ config MEM_ALLOC_PROFILING
>  	depends on PROC_FS
>  	depends on !DEBUG_FORCE_WEAK_PER_CPU
>  	select CODE_TAGGING
> +	select PAGE_EXTENSION
>  	help
>  	  Track allocation source code and record total allocation size
>  	  initiated at that code location. The mechanism can be used to track
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 4fc031f9cefd..2d5226d9262d 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -3,6 +3,7 @@
>  #include <linux/fs.h>
>  #include <linux/gfp.h>
>  #include <linux/module.h>
> +#include <linux/page_ext.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_buf.h>
>  #include <linux/seq_file.h>
> @@ -124,6 +125,22 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
>  	return module_unused;
>  }
>  
> +static __init bool need_page_alloc_tagging(void)
> +{
> +	return true;

So this means the page_ext memory overead is paid unconditionally once
MEM_ALLOC_PROFILING is compile time enabled, even if never enabled during
runtime? That makes it rather costly to be suitable for generic distro
kernels where the code could be compile time enabled, and runtime enabling
suggested in a debugging/support scenario. It's what we do with page_owner,
debug_pagealloc, slub_debug etc.

Ideally we'd have some vmalloc based page_ext flavor for later-than-boot
runtime enablement, as we now have for stackdepot. But that could be
explored later. For now it would be sufficient to add an early_param boot
parameter to control the enablement including page_ext, like page_owner and
other features do.

> +}
> +
> +static __init void init_page_alloc_tagging(void)
> +{
> +}
> +
> +struct page_ext_operations page_alloc_tagging_ops = {
> +	.size = sizeof(union codetag_ref),
> +	.need = need_page_alloc_tagging,
> +	.init = init_page_alloc_tagging,
> +};
> +EXPORT_SYMBOL(page_alloc_tagging_ops);



