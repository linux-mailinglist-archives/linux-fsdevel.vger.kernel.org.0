Return-Path: <linux-fsdevel+bounces-46055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D5A820C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBC8A037C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7525D532;
	Wed,  9 Apr 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x68SfJeD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATH4sD7m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x68SfJeD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATH4sD7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106525A2D7
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189893; cv=none; b=nNGojMhp9AoPO8iugWfWyQbz6qlpFc2CWRIMtodnZ96/RHImreKjbOqVHMnsNwf41O1h80Ft8Sqt++CWlkoxWM1Zr1cWdTodAdHJkC2qBiL+kdYeNK0KPohXMsGBohBJGRfsIqO+2LsIR8tQroeI2fdezm4teTGuIVyduMOhv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189893; c=relaxed/simple;
	bh=oxBpfxWpETYNWAwIwG57Qtk/PEMDni3sXW1IrlVnkiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o89LmmI8TggGH4tFnxpBAuh714S243ZNmBbsxIFd8Rtg/L6SVdc753YqGSGDB58TnxKDwhePkfMKAZfzGLHPe7HNYbao6ZOhY6q26kJc6UX/wQfU2a9a1QPhq1ryK5P1bs/NV6B1EF9Ufdni4v667UILXUvPGfE4JlrYjwGdnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x68SfJeD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATH4sD7m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x68SfJeD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATH4sD7m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15F1F21163;
	Wed,  9 Apr 2025 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744189889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VXKOBNGUI9fKpg7pWhEZW+0RN6rg/pB63thRan8omU=;
	b=x68SfJeDcHWG4nFcDgc0x+pMik057A/7bA8Si1mY8jdtIS8ZV99dKP54JG6sLgFH4x29rT
	QoY47pkCg30pmyOhVz14P/MJBWT04qTcrNT3+aMGP5L1UbuP5howowKrCoXiBsAqoXdkVr
	tpK3Azj1uysVQmPb7LZpkHVHGeBeNY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744189889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VXKOBNGUI9fKpg7pWhEZW+0RN6rg/pB63thRan8omU=;
	b=ATH4sD7mpWPE4lfUe+bcILMf7OGxlOw2A3qtnSff+apAYhQUB7VOa1SIOkMbO8Sr4VczvK
	WPGh52nLDaQz8ZDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744189889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VXKOBNGUI9fKpg7pWhEZW+0RN6rg/pB63thRan8omU=;
	b=x68SfJeDcHWG4nFcDgc0x+pMik057A/7bA8Si1mY8jdtIS8ZV99dKP54JG6sLgFH4x29rT
	QoY47pkCg30pmyOhVz14P/MJBWT04qTcrNT3+aMGP5L1UbuP5howowKrCoXiBsAqoXdkVr
	tpK3Azj1uysVQmPb7LZpkHVHGeBeNY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744189889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VXKOBNGUI9fKpg7pWhEZW+0RN6rg/pB63thRan8omU=;
	b=ATH4sD7mpWPE4lfUe+bcILMf7OGxlOw2A3qtnSff+apAYhQUB7VOa1SIOkMbO8Sr4VczvK
	WPGh52nLDaQz8ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0351313691;
	Wed,  9 Apr 2025 09:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qdSUAME59mfRawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 09 Apr 2025 09:11:29 +0000
Message-ID: <0f2091ba-0a43-4dd3-aa48-fe284530044a@suse.cz>
Date: Wed, 9 Apr 2025 11:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
To: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Yafang Shao
 <laoar.shao@gmail.com>, Harry Yoo <harry.yoo@oracle.com>,
 Kees Cook <kees@kernel.org>, joel.granados@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org> <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area> <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka> <Z-48K0OdNxZXcnkB@tiehlicka>
 <Z-7m0CjNWecCLDSq@tiehlicka> <Z_YjKs5YPk66vmy8@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <Z_YjKs5YPk66vmy8@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,oracle.com,kernel.org,vger.kernel.org,toxicpanda.com,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/9/25 9:35 AM, Michal Hocko wrote:
> On Thu 03-04-25 21:51:46, Michal Hocko wrote:
>> Add Andrew
> 
> Andrew, do you want me to repost the patch or can you take it from this
> email thread?

I'll take it as it's now all in mm/slub.c

>> Also, Dave do you want me to redirect xlog_cil_kvmalloc to kvmalloc or
>> do you preffer to do that yourself?
>>
>> On Thu 03-04-25 09:43:41, Michal Hocko wrote:
>>> There are users like xfs which need larger allocations with NOFAIL
>>> sementic. They are not using kvmalloc currently because the current
>>> implementation tries too hard to allocate through the kmalloc path
>>> which causes a lot of direct reclaim and compaction and that hurts
>>> performance a lot (see 8dc9384b7d75 ("xfs: reduce kvmalloc overhead for
>>> CIL shadow buffers") for more details).
>>>
>>> kvmalloc does support __GFP_RETRY_MAYFAIL semantic to express that
>>> kmalloc (physically contiguous) allocation is preferred and we should go
>>> more aggressive to make it happen. There is currently no way to express
>>> that kmalloc should be very lightweight and as it has been argued [1]
>>> this mode should be default to support kvmalloc(NOFAIL) with a
>>> lightweight kmalloc path which is currently impossible to express as
>>> __GFP_NOFAIL cannot be combined by any other reclaim modifiers.
>>>
>>> This patch makes all kmalloc allocations GFP_NOWAIT unless
>>> __GFP_RETRY_MAYFAIL is provided to kvmalloc. This allows to support both
>>> fail fast and retry hard on physically contiguous memory with vmalloc
>>> fallback.
>>>
>>> There is a potential downside that relatively small allocations (smaller
>>> than PAGE_ALLOC_COSTLY_ORDER) could fallback to vmalloc too easily and
>>> cause page block fragmentation. We cannot really rule that out but it
>>> seems that xlog_cil_kvmalloc use doesn't indicate this to be happening.
>>>
>>> [1] https://lore.kernel.org/all/Z-3i1wATGh6vI8x8@dread.disaster.area/T/#u
>>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>>> ---
>>>  mm/slub.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index b46f87662e71..2da40c2f6478 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4972,14 +4972,16 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>>>  	 * We want to attempt a large physically contiguous block first because
>>>  	 * it is less likely to fragment multiple larger blocks and therefore
>>>  	 * contribute to a long term fragmentation less than vmalloc fallback.
>>> -	 * However make sure that larger requests are not too disruptive - no
>>> -	 * OOM killer and no allocation failure warnings as we have a fallback.
>>> +	 * However make sure that larger requests are not too disruptive - i.e.
>>> +	 * do not direct reclaim unless physically continuous memory is preferred
>>> +	 * (__GFP_RETRY_MAYFAIL mode). We still kick in kswapd/kcompactd to start
>>> +	 * working in the background but the allocation itself.
>>>  	 */
>>>  	if (size > PAGE_SIZE) {
>>>  		flags |= __GFP_NOWARN;
>>>  
>>>  		if (!(flags & __GFP_RETRY_MAYFAIL))
>>> -			flags |= __GFP_NORETRY;
>>> +			flags &= ~__GFP_DIRECT_RECLAIM;
>>>  
>>>  		/* nofail semantic is implemented by the vmalloc fallback */
>>>  		flags &= ~__GFP_NOFAIL;
>>> -- 
>>> 2.49.0
>>>
>>
>> -- 
>> Michal Hocko
>> SUSE Labs
> 


