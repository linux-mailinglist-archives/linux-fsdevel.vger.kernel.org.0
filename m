Return-Path: <linux-fsdevel+bounces-11870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA813858305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B76A1C223B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED0130E37;
	Fri, 16 Feb 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfwPmBXr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5f+K6CWT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfwPmBXr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5f+K6CWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A9130AF3;
	Fri, 16 Feb 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102359; cv=none; b=DHtA1kru24YwhFK9ceHmYjXWaaPt8LAgGnCe2tRakXv9QVM8h3e9sHE0DypEmyki4oSBktSC8tcN+NM9ZlSyz3hLdE47Mt5wyLNWdpo7eoquWnhg5cN62XlmOkAVwy1oocgbF9g9mfr9wWlWYZg7FzauSpgvrZk0dzpZ0xPg0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102359; c=relaxed/simple;
	bh=YSlN9L1xkLAZYRMT2oJ0+KPZ6eaebeEort6iIFJ4aAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKbdWH4a4WuByEaYbz957ZgniC6jjw4mAiJrAFEQAjBmrP+QTTuAjRJR2qPRH+Zg4g5QZsfoBgG/lJuxGu35WAU8bo7f3I25IQ5JW2XFPL5gY2UPBhcm7pCFNP3YmwJHjgdngwAccpNFD4TrD4J0NuuCMncn3xVUOLsAn5M7cWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfwPmBXr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5f+K6CWT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfwPmBXr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5f+K6CWT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 252FA22043;
	Fri, 16 Feb 2024 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708102355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjFfGHq1FbZX5RctuoEE2JMZaFbk7fCFrSUdFxCZeQM=;
	b=gfwPmBXrOQkJAnTdNzEhnp/agnnibHhiJyUDTlS4Yi2VTrb3IA69570I2qH2Dq9w9OCfye
	yxYnEP6Hf7Oajb/o/H05S6+hQ2i066X961IWR6LbLJpDuXhvlbopXi1xyNUt+JxndXS1DO
	d8CrJL6LkZAY2JIdSC+pPSU1KutC/Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708102355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjFfGHq1FbZX5RctuoEE2JMZaFbk7fCFrSUdFxCZeQM=;
	b=5f+K6CWTzCWeRCrTYtcPXe4eP2DBGf5KgTKiEmuqzNp5dQdmJ2kvIE73z2E2Dv5//S9pZn
	3WOa8WiEGgu+8kCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708102355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjFfGHq1FbZX5RctuoEE2JMZaFbk7fCFrSUdFxCZeQM=;
	b=gfwPmBXrOQkJAnTdNzEhnp/agnnibHhiJyUDTlS4Yi2VTrb3IA69570I2qH2Dq9w9OCfye
	yxYnEP6Hf7Oajb/o/H05S6+hQ2i066X961IWR6LbLJpDuXhvlbopXi1xyNUt+JxndXS1DO
	d8CrJL6LkZAY2JIdSC+pPSU1KutC/Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708102355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjFfGHq1FbZX5RctuoEE2JMZaFbk7fCFrSUdFxCZeQM=;
	b=5f+K6CWTzCWeRCrTYtcPXe4eP2DBGf5KgTKiEmuqzNp5dQdmJ2kvIE73z2E2Dv5//S9pZn
	3WOa8WiEGgu+8kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C8D71398D;
	Fri, 16 Feb 2024 16:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rjARHtKSz2X4VAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 16:52:34 +0000
Message-ID: <a27189a9-b0fc-4705-bdd5-3ee0a5c23dd5@suse.cz>
Date: Fri, 16 Feb 2024 17:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/35] mm/slab: enable slab allocation tagging for
 kmalloc and friends
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
 <20240212213922.783301-23-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-23-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.96 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.45)[78.97%];
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.96

On 2/12/24 22:39, Suren Baghdasaryan wrote:
> Redefine kmalloc, krealloc, kzalloc, kcalloc, etc. to record allocations
> and deallocations done by these functions.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>


> -}
> +#define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
> +#define kvzalloc(_size, _flags)			kvmalloc(_size, _flags|__GFP_ZERO)
>  
> -static inline __alloc_size(1, 2) void *kvmalloc_array(size_t n, size_t size, gfp_t flags)

This has __alloc_size(1, 2)

> -{
> -	size_t bytes;
> -
> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> -		return NULL;
> +#define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|__GFP_ZERO, _node)
>  
> -	return kvmalloc(bytes, flags);
> -}
> +#define kvmalloc_array(_n, _size, _flags)						\
> +({											\
> +	size_t _bytes;									\
> +											\
> +	!check_mul_overflow(_n, _size, &_bytes) ? kvmalloc(_bytes, _flags) : NULL;	\
> +})

But with the calculation now done in a macro, that's gone?

> -static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t flags)

Same here...

> -{
> -	return kvmalloc_array(n, size, flags | __GFP_ZERO);
> -}
> +#define kvcalloc(_n, _size, _flags)		kvmalloc_array(_n, _size, _flags|__GFP_ZERO)

... transitively?

But that's for Kees to review, I'm just not sure if he missed it or it's fine.

