Return-Path: <linux-fsdevel+bounces-45609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31CA79E15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDE8188A663
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC8241CAF;
	Thu,  3 Apr 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vFQR/Wdz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFjLbEDR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OwiZjwYL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyeH/9La"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994C24168A
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668705; cv=none; b=vFNjoiqdvRC8phrwsbCu748bGdBadCNtrJ8OSJVmjTR8xvFWZOEdFelBkGtRsv3USKR/W3+Gzj37iHXpPp1ZfdgIRdSkFjzw1q55R8IHdpl6egN3JqEwHX1cqOmgJ6/QEfAcWLqXavxTqXkMVzK3yn/WA3do0ajr7Q7eia3yN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668705; c=relaxed/simple;
	bh=Kx1i9o1AXCVoRdJiXCk0tz9SYnH6Z2jt+QfBA7F4UQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYKnRH49Cg/wb4tvq7aFksmRfWwnQm1R50Q1FvCxrP4orLo+rOJItfrHsuHRrU2SBoUWwSdOd5cNcqXAH04l8GmG/nVCXRjrzzQ0BqCo94W1oIZP8X6yRkCF2W26lw/lbmS4qa3ZWq66p0Y/aN32hZFHzv76NjIp3xN5zYr7eew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vFQR/Wdz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFjLbEDR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OwiZjwYL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyeH/9La; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1F031F38A;
	Thu,  3 Apr 2025 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743668697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXjFRmAk77Oc3x1SPovG++92LrFyhg0OprYLqRNOBWw=;
	b=vFQR/Wdze1bK+3ZacQZAZO743skDtdGLOXNSFbngtVq6DqVICh0KXF1Cwbe3Zh0Or1HEpT
	guR16qICOZdmu/17T9+4QhXp3iJNYLbRSwVhB60rSrqjEy6w73nWemmpkTvCqz1XhgVY3i
	9LUELfDhpIbbyhNb6ARMn7RjIHz5xDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743668697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXjFRmAk77Oc3x1SPovG++92LrFyhg0OprYLqRNOBWw=;
	b=mFjLbEDRiHXUt/AjqXRWV3pQxDaBiuFItw5urw7TYZ5rntxeAq8ksMScl47UwGUHiYcDgW
	/gBcsIUA63SJCPDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743668696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXjFRmAk77Oc3x1SPovG++92LrFyhg0OprYLqRNOBWw=;
	b=OwiZjwYLf8hovP72Cw9vIm01uCD2VxN9bZagLqJG1QzqqjU1HOZZ4pov6Xg3wvyIzAm9mx
	VVFPKQHxVSNqqbKSG1ZACctheZ3lWZfZ1lIgqlHnog81j+GFPprGaf/AK4AvsyElstT+kW
	k8avUhJeZwG1F9MTnGu+VhRFrptPqzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743668696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXjFRmAk77Oc3x1SPovG++92LrFyhg0OprYLqRNOBWw=;
	b=jyeH/9LadK5HnLQ2uUy9Bi9dD9R0UNkxoulwRh/8D4eZwIoDi3aUcx6ZLSHolDIkkoGaSL
	l6MLPY2PoH8hBqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8AB31392A;
	Thu,  3 Apr 2025 08:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id da5mKNhF7mdeWAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 03 Apr 2025 08:24:56 +0000
Message-ID: <ad7b308e-64aa-4bd4-be1c-fbcdd02a0f10@suse.cz>
Date: Thu, 3 Apr 2025 10:24:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Yafang Shao <laoar.shao@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 linux-mm@kvack.org
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org> <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area> <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka> <Z-48K0OdNxZXcnkB@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z-48K0OdNxZXcnkB@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fromorbit.com,gmail.com,oracle.com,kernel.org,vger.kernel.org,toxicpanda.com,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/3/25 09:43, Michal Hocko wrote:
> There are users like xfs which need larger allocations with NOFAIL
> sementic. They are not using kvmalloc currently because the current
> implementation tries too hard to allocate through the kmalloc path
> which causes a lot of direct reclaim and compaction and that hurts
> performance a lot (see 8dc9384b7d75 ("xfs: reduce kvmalloc overhead for
> CIL shadow buffers") for more details).
> 
> kvmalloc does support __GFP_RETRY_MAYFAIL semantic to express that
> kmalloc (physically contiguous) allocation is preferred and we should go
> more aggressive to make it happen. There is currently no way to express
> that kmalloc should be very lightweight and as it has been argued [1]
> this mode should be default to support kvmalloc(NOFAIL) with a
> lightweight kmalloc path which is currently impossible to express as
> __GFP_NOFAIL cannot be combined by any other reclaim modifiers.
> 
> This patch makes all kmalloc allocations GFP_NOWAIT unless
> __GFP_RETRY_MAYFAIL is provided to kvmalloc. This allows to support both
> fail fast and retry hard on physically contiguous memory with vmalloc
> fallback.
> 
> There is a potential downside that relatively small allocations (smaller
> than PAGE_ALLOC_COSTLY_ORDER) could fallback to vmalloc too easily and
> cause page block fragmentation. We cannot really rule that out but it
> seems that xlog_cil_kvmalloc use doesn't indicate this to be happening.
> 
> [1] https://lore.kernel.org/all/Z-3i1wATGh6vI8x8@dread.disaster.area/T/#u
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks like a step in the right direction, but is that enough?

- to replace xlog_kvmalloc(), we need to deal with kvmalloc() passing
VM_ALLOW_HUGE_VMAP, so we don't end up with GFP_KERNEL huge allocation
anyway (in practice maybe it wouldn't happen because "size >= PMD_SIZE"
required for the huge vmalloc is never true for current xlog_kvmalloc()
users but dunno if we can rely on that).

Maybe it's a bad idea to use VM_ALLOW_HUGE_VMAP in kvmalloc() anyway? Since
we're in a vmalloc fallback which means the huge allocations failed anyway
for the kmalloc() part. Maybe there's some grey area where it makes sense,
with size much larger than PMD_SIZE, e.g. exceeding MAX_PAGE_ORDER where we
can't kmalloc() anyway so at least try to assemble the allocation from huge
vmalloc. Maybe tie it to such a size check, or require __GFP_RETRY_MAYFAIL
to activate VM_ALLOW_HUGE_VMAP?

- we're still not addressing the original issue of high kcompactd activity,
but maybe the answer is that it needs to be investigated more (why deferred
compaction doesn't limit it) instead of trying to suppress it from kvmalloc()

> ---
>  mm/slub.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b46f87662e71..2da40c2f6478 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4972,14 +4972,16 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>  	 * We want to attempt a large physically contiguous block first because
>  	 * it is less likely to fragment multiple larger blocks and therefore
>  	 * contribute to a long term fragmentation less than vmalloc fallback.
> -	 * However make sure that larger requests are not too disruptive - no
> -	 * OOM killer and no allocation failure warnings as we have a fallback.
> +	 * However make sure that larger requests are not too disruptive - i.e.
> +	 * do not direct reclaim unless physically continuous memory is preferred
> +	 * (__GFP_RETRY_MAYFAIL mode). We still kick in kswapd/kcompactd to start
> +	 * working in the background but the allocation itself.
>  	 */
>  	if (size > PAGE_SIZE) {
>  		flags |= __GFP_NOWARN;
>  
>  		if (!(flags & __GFP_RETRY_MAYFAIL))
> -			flags |= __GFP_NORETRY;
> +			flags &= ~__GFP_DIRECT_RECLAIM;
>  
>  		/* nofail semantic is implemented by the vmalloc fallback */
>  		flags &= ~__GFP_NOFAIL;


