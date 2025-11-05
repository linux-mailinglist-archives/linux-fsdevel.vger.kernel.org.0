Return-Path: <linux-fsdevel+bounces-67136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC6C35F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B65562459
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF7328B7B;
	Wed,  5 Nov 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwaBfK9q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5x4wrmEQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gG9BppFp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TxG2x/Ch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F8328B46
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351501; cv=none; b=qu3N3rbhk4ftzHsVb/JU+q4LZn2K5Ef3NmTAuS7UOT3+Bacj/06dCRdfDRvgbbQZX5/SYXi81a7j5SAtIzl/7Y0DN0ZufKfhZIH0XJrO1NEKmApykGRW5tOsJz46dBlqKSYxaPuLp6Zh8oB0tqzfktL/yLK1v/xoCljkn0drOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351501; c=relaxed/simple;
	bh=doNgCutAXkfnawIqd/vMIlud2SyDFR4DcUhZF7WF7ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alrwVrCx0aZVM+uRih/TDCuUfNVFIuopQNCczZraL59pK1l7AF5M4GoJPgZ1oqXGNR1abKxeFbmhhmBE4JgwS18cVb6L00fWOR04PeQHCSPWkLL34tsho3lVMJmUmyqiWm7+7vLOcd9dD8wpuKAzhtmL3AeTRn/mNeNBBcAYhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mwaBfK9q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5x4wrmEQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gG9BppFp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TxG2x/Ch; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7785211A9;
	Wed,  5 Nov 2025 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762351498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ObIHwLo4q/sN8twtSW+vc2ZozvwJfT2HzNmnwS+Wygg=;
	b=mwaBfK9q4KJUD4+xDLEv/Avzvg11MlFEEDvU/3mW6Tp92xKfgpWimolm0IlBswwtG/ibal
	8XSav+g5ch/Uy9mjilQ+1zwAZhfZufpVZMSk1kEEbDAl6q1RQIVEUWBEtCNsj0YTXwpdlA
	iYAK3Oal6h1P2aFlmV3fou6lYefjKV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762351498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ObIHwLo4q/sN8twtSW+vc2ZozvwJfT2HzNmnwS+Wygg=;
	b=5x4wrmEQe1zTSCOrQOzR6jiwukiPGwefynkPcdbCCEMPiYLU+Pdm6eCEkttOSIIDrSqfzY
	LtbR2SI/wBLimMDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gG9BppFp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="TxG2x/Ch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762351495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ObIHwLo4q/sN8twtSW+vc2ZozvwJfT2HzNmnwS+Wygg=;
	b=gG9BppFprhCEcEdSuJpBptD+oBRebryZPhCIRSYT/F+MwIKDaq3HfzW+zyw0Una0MMG9jw
	GjlaOkkPXUfbVGtZ6dKmHVcHDxA+xFSrAm2cWUkyUblk11WS1x6Zxq9KyobZbEBmOGez4W
	C91kToyS+GuF3wLB+t00W5TCdzCFIdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762351495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ObIHwLo4q/sN8twtSW+vc2ZozvwJfT2HzNmnwS+Wygg=;
	b=TxG2x/ChMut6poH3bRkP28pjwq5XZS11dyO7ot9qLxrwIdJUVy6pDHL6gY1A8wPEuMR96g
	INEIcuKzLImnIRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA8F813699;
	Wed,  5 Nov 2025 14:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5FWhL4dZC2mkNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 14:04:55 +0000
Message-ID: <59626bf3-033b-4b2f-99ea-7056ab1e4d74@suse.cz>
Date: Wed, 5 Nov 2025 15:04:55 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] mempool: add error injection support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Eric Biggers <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-mm@kvack.org
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-3-hch@lst.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251031093517.1603379-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E7785211A9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:dkim,suse.cz:mid,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 10/31/25 10:34, Christoph Hellwig wrote:
> Add a call to should_fail_ex that forces mempool to actually allocate
> from the pool to stress the mempool implementation when enabled through
> debugfs.  By default should_fail{,_ex} prints a very verbose stack trace
> that clutters the kernel log, slows down execution and triggers the
> kernel bug detection in xfstests.  Pass FAULT_NOWARN and print a
> single-line message notating the caller instead so that full tests
> can be run with fault injection.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mempool.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index d7c55a98c2be..15581179c8b9 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -9,7 +9,7 @@
>   *  started by Ingo Molnar, Copyright (C) 2001
>   *  debugging by David Rientjes, Copyright (C) 2015
>   */
> -
> +#include <linux/fault-inject.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/highmem.h>
> @@ -20,6 +20,15 @@
>  #include <linux/writeback.h>
>  #include "slab.h"
>  
> +static DECLARE_FAULT_ATTR(fail_mempool_alloc);
> +
> +static int __init mempool_faul_inject_init(void)
> +{
> +	return PTR_ERR_OR_ZERO(fault_create_debugfs_attr("fail_mempool_alloc",
> +			NULL, &fail_mempool_alloc));
> +}
> +late_initcall(mempool_faul_inject_init);
> +
>  #ifdef CONFIG_SLUB_DEBUG_ON
>  static void poison_error(mempool_t *pool, void *element, size_t size,
>  			 size_t byte)
> @@ -399,10 +408,15 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
>  	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
>  
>  repeat_alloc:
> -
> -	element = pool->alloc(gfp_temp, pool->pool_data);
> -	if (likely(element != NULL))
> -		return element;
> +	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {
> +		pr_info("forcing mempool usage for pool %pS\n",
> +				(void *)_RET_IP_);
> +		element = NULL;
> +	} else {
> +		element = pool->alloc(gfp_temp, pool->pool_data);
> +		if (likely(element != NULL))
> +			return element;
> +	}
>  
>  	spin_lock_irqsave(&pool->lock, flags);
>  	if (likely(pool->curr_nr)) {


