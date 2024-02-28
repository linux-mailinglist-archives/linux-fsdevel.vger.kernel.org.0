Return-Path: <linux-fsdevel+bounces-13053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160086AA41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 09:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F20E1F22208
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727DF2D610;
	Wed, 28 Feb 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="phMwb3Dm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiMXxSwd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="phMwb3Dm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiMXxSwd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417A2CCB3;
	Wed, 28 Feb 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109687; cv=none; b=oEIMjTRXqPe3exynqEdC4zpYh2whEIUwsVSgdLUvdc6mYmI5A7XZwiglGk5Gpm8XMeDX8bwoIhPKhCU39ga6IUPd3SlboAF3p4Y3EEzgas1+uBu2WznYcwL38Q1lKFfFLlbjOvRZ8cVeTSF8QeAdjE1VkHGCIOG3MqvASRb1vDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109687; c=relaxed/simple;
	bh=hplaKtl+hDgUwRuZLuh32H7SNkx0acRFj13Yup3ATyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLYqm+lFtsW7NHDvLzMjMkt8XQVmwqiEnS1w/02Qy3TQF2PDV0RW4xFcDSMlgCdebtgBNXSuLXi7PeDuWPVKG4PNGrzMpixrKxWgt/+motC14vv9IVyR2HWfQ4berMc7VMpVqa+afoFHd6qV722YW+sLyp7Njfp93OisPpa4rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=phMwb3Dm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiMXxSwd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=phMwb3Dm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiMXxSwd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4835222657;
	Wed, 28 Feb 2024 08:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709109684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbyCcmaBlZljStHMFxVLjYUCEfDtYTJa/CPT8Hf97G0=;
	b=phMwb3DmngqD0XbmYjbTtwj2HpuJRzy2jPOcV9smFnZg9gOK3wmT5AzkgJGO7bW5mFPHXR
	mtS4nM3ecmVMEMI1vV/u8F6Igprc+vXqDZg8Y4iQQl4xRr46wLOOciVQ0smfijBDz2ujL4
	ochkGT0fT/pCKtqaDyHABD3X2QC5DSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709109684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbyCcmaBlZljStHMFxVLjYUCEfDtYTJa/CPT8Hf97G0=;
	b=uiMXxSwd/ls4abrN/CYlVK3trcA8uiNb2ZizYjXht+o3s/9ZaVowrkwutXM+EF/tbQmIBw
	q/35F2fz7wxPXrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709109684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbyCcmaBlZljStHMFxVLjYUCEfDtYTJa/CPT8Hf97G0=;
	b=phMwb3DmngqD0XbmYjbTtwj2HpuJRzy2jPOcV9smFnZg9gOK3wmT5AzkgJGO7bW5mFPHXR
	mtS4nM3ecmVMEMI1vV/u8F6Igprc+vXqDZg8Y4iQQl4xRr46wLOOciVQ0smfijBDz2ujL4
	ochkGT0fT/pCKtqaDyHABD3X2QC5DSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709109684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbyCcmaBlZljStHMFxVLjYUCEfDtYTJa/CPT8Hf97G0=;
	b=uiMXxSwd/ls4abrN/CYlVK3trcA8uiNb2ZizYjXht+o3s/9ZaVowrkwutXM+EF/tbQmIBw
	q/35F2fz7wxPXrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0FBD13A58;
	Wed, 28 Feb 2024 08:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ou/VJrPx3mVlIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Feb 2024 08:41:23 +0000
Message-ID: <b62d2ace-4619-40ac-8536-c5626e95d87b@suse.cz>
Date: Wed, 28 Feb 2024 09:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
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
 <20240221194052.927623-15-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-15-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-1.44)[91.19%];
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.03

Another thing I noticed, dunno how critical

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> +static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> +{
> +	struct alloc_tag *tag;
> +
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +	WARN_ONCE(ref && !ref->ct, "alloc_tag was not set\n");
> +#endif
> +	if (!ref || !ref->ct)
> +		return;

This is quite careful.

> +
> +	tag = ct_to_alloc_tag(ref->ct);
> +
> +	this_cpu_sub(tag->counters->bytes, bytes);
> +	this_cpu_dec(tag->counters->calls);
> +
> +	ref->ct = NULL;
> +}
> +
> +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> +{
> +	__alloc_tag_sub(ref, bytes);
> +}
> +
> +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_t bytes)
> +{
> +	__alloc_tag_sub(ref, bytes);
> +}
> +
> +static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
> +{
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +	WARN_ONCE(ref && ref->ct,
> +		  "alloc_tag was not cleared (got tag for %s:%u)\n",\
> +		  ref->ct->filename, ref->ct->lineno);
> +
> +	WARN_ONCE(!tag, "current->alloc_tag not set");
> +#endif
> +	if (!ref || !tag)
> +		return;

This too.

> +
> +	ref->ct = &tag->ct;
> +	/*
> +	 * We need in increment the call counter every time we have a new
> +	 * allocation or when we split a large allocation into smaller ones.
> +	 * Each new reference for every sub-allocation needs to increment call
> +	 * counter because when we free each part the counter will be decremented.
> +	 */
> +	this_cpu_inc(tag->counters->calls);
> +}
> +
> +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
> +{
> +	alloc_tag_ref_set(ref, tag);

We might have returned from alloc_tag_ref_set() due to !tag

> +	this_cpu_add(tag->counters->bytes, bytes);

But here we still assume it's valid.

> +}
> +


