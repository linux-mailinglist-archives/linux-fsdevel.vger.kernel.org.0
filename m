Return-Path: <linux-fsdevel+bounces-11763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF9856F80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15FBB22B3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D01419A9;
	Thu, 15 Feb 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ay4ravC8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sPqC4gP5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ay4ravC8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sPqC4gP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2613DB8A;
	Thu, 15 Feb 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033448; cv=none; b=HTLZFKHtqVjJNBpx9eRGtS2EiFA6zod5iAPFoHiGDO6mqlaxYhEsOpYwsXIss0HMWiAFa/i6pqo4aqbuuLa4caLE4yfwCCPThiq2jZom1eYaOcfelCkVxaP2NEniaRbkKv0G0LWgOyCWFTjEVqG3NLJE2XAGPPl9OXTAv1dk9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033448; c=relaxed/simple;
	bh=7S5R33xR5Od4qt6j36JNeOsc9OaPlGfC5u1SCRAJJ44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSOg5BAXawNd7Idv5hq0qRPy28c9STsVVhD0KZzOiTd5m6eUU16TSrsViqxnDoEbv0w8jTE3LZ5seYzhbmqYJqxHzAUIGHYhJ5vD32WwotWAc80lW9sVSnPfnZRX9EtnCNXtv0ZYs4bSJbN5xBoOruzgxMS/2KRMnORs4HBKUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ay4ravC8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sPqC4gP5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ay4ravC8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sPqC4gP5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 664591FD40;
	Thu, 15 Feb 2024 21:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708033444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQY+F3nMlxstoB6O6HK9gnIcEp2qVMn7wy1cyDkxwTk=;
	b=Ay4ravC8tz3DhfoYvoB3LNDbjnAF0ZXlS655OZ3Fd0H/F55bSQDiu48paFSjQX0cKW5AgT
	5iyUw/Htn37YNdgjBvwRJyX2Sd2Bg+9UTep/WDJ7H+xA2xGgkyFZSjqIN68pSEw4kJzoMJ
	dErOJCGuqDpXXWQK5IIwVDOJQzk8wZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708033444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQY+F3nMlxstoB6O6HK9gnIcEp2qVMn7wy1cyDkxwTk=;
	b=sPqC4gP5gNHBPrt4HC5l6ZN5X9CSu4w9/m7c2WnUTrBqWbrv4PL9ApcsRSztcRjH4lhvGx
	e22tnmK9X77zK6AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708033444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQY+F3nMlxstoB6O6HK9gnIcEp2qVMn7wy1cyDkxwTk=;
	b=Ay4ravC8tz3DhfoYvoB3LNDbjnAF0ZXlS655OZ3Fd0H/F55bSQDiu48paFSjQX0cKW5AgT
	5iyUw/Htn37YNdgjBvwRJyX2Sd2Bg+9UTep/WDJ7H+xA2xGgkyFZSjqIN68pSEw4kJzoMJ
	dErOJCGuqDpXXWQK5IIwVDOJQzk8wZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708033444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQY+F3nMlxstoB6O6HK9gnIcEp2qVMn7wy1cyDkxwTk=;
	b=sPqC4gP5gNHBPrt4HC5l6ZN5X9CSu4w9/m7c2WnUTrBqWbrv4PL9ApcsRSztcRjH4lhvGx
	e22tnmK9X77zK6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6209F13A53;
	Thu, 15 Feb 2024 21:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +AxGF6OFzmUvTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 21:44:03 +0000
Message-ID: <02cb04cd-0d8d-4948-b3ef-036160c52e64@suse.cz>
Date: Thu, 15 Feb 2024 22:44:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/35] mm: prevent slabobj_ext allocations for
 slabobj_ext and kmem_cache objects
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
 <20240212213922.783301-9-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-9-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ay4ravC8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sPqC4gP5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.00
X-Rspamd-Queue-Id: 664591FD40
X-Spam-Flag: NO

On 2/12/24 22:38, Suren Baghdasaryan wrote:
> Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
> objects. Also prevent slabobj_ext allocations for kmem_cache objects.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/slab.h        | 6 ++++++
>  mm/slab_common.c | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 436a126486b5..f4ff635091e4 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -589,6 +589,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  	if (!need_slab_obj_ext())
>  		return NULL;
>  
> +	if (s->flags & SLAB_NO_OBJ_EXT)
> +		return NULL;
> +
> +	if (flags & __GFP_NO_OBJ_EXT)
> +		return NULL;

Since we agreed to postpone this function, when it appears later it can have
those in.

>  	slab = virt_to_slab(p);
>  	if (!slab_obj_exts(slab) &&
>  	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6bfa1810da5e..83fec2dd2e2d 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -218,6 +218,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	void *vec;
>  
>  	gfp &= ~OBJCGS_CLEAR_MASK;
> +	/* Prevent recursive extension vector allocation */
> +	gfp |= __GFP_NO_OBJ_EXT;

And this could become part of 6/35 mm: introduce __GFP_NO_OBJ_EXT ... ?

>  	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
>  			   slab_nid(slab));
>  	if (!vec)


