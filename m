Return-Path: <linux-fsdevel+bounces-62566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A79B999CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B76188345B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DDB2FDC49;
	Wed, 24 Sep 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tf3jv/BN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4lXhVBoP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/yvRRoc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B86njsF6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C82E173D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713854; cv=none; b=Bdq/Nt0Osc9YIztkD/P0M+Oh6fARQ7n5HKRyH45anL+YuRhE+5dX0ydaPcQHKXkI1g+rBk9THAdowIwTGTZUjXbZKKHS6BBUY1PQOQA8ONnXnSfN7jEZLVsEOX0l1pVg3LfX8LLlasCSkqWlkuwJKyS81C3yoyVa/us+J8njqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713854; c=relaxed/simple;
	bh=uH+LLl++HnxLepDtLUttWF83jJeR+uOZVzaKeNc3Ddc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gyn5AzYmGiommawnhDSWna1X3anWvGLdNnDQ1LLDJeFkg3zgpQuiG/WhmdL1qvCgrABzEqi9xiaQgF268Wc8L4NFMYsba8L/oeKgrjtSnwSVV0wvLkQV4YB6hSeIssIvU20DXyGIHNphsfrsHzNdDSyYAAp7HLuOrpnbO3juTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tf3jv/BN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4lXhVBoP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/yvRRoc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B86njsF6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB0AC229D4;
	Wed, 24 Sep 2025 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758713847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9K4fWuWQadxiqdj4KQnSwwhZNnSiXNbuiWczmOmss0=;
	b=tf3jv/BNK5LvDDer2hpCL4vWpcXmZV00aK3S2gLqEk+CD4NWHvVybjSZC9IXUBvqr8Hl4/
	vzo5xo0oIaMcb5+hdquZrn/NzCcGm3AbfOnMtwJQn6vCxCdAFidksunYACVwudzVPCLHt0
	KvGXP5YJ951At6RTvfLmPN2ifoK3Dys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758713847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9K4fWuWQadxiqdj4KQnSwwhZNnSiXNbuiWczmOmss0=;
	b=4lXhVBoPYmsI9tYh/gQXHeIGxnm157erD1SqGQlDGsxsp5FOehfTv5VIkdR4tki3uv14Po
	Y5C4CxpI9VGYN3BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758713846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9K4fWuWQadxiqdj4KQnSwwhZNnSiXNbuiWczmOmss0=;
	b=2/yvRRocpudkJcpQtdKSrnbzTRVHzhgfTemq1TEvKPE8WxgxwNIXLeHKn7r85K24LZY9W9
	xkMczE61w1neZNnHZBUFFwJGIUdGsbICE/qUTo0Os0/vVy7O69fSvpo06qoKLF9mN5zy2E
	mfCGurZpaPHt3JKJEAinPT56Or5TBus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758713846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9K4fWuWQadxiqdj4KQnSwwhZNnSiXNbuiWczmOmss0=;
	b=B86njsF6RPUywIRvYt3ld3+86EgsuGQCo/C6pv0l8ZDFhLHQJ5Zn7abnIoNzKHMtSUABu7
	y7MBUN5PXQ9e0VCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0CEA13A61;
	Wed, 24 Sep 2025 11:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HRb5MvbX02jPQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:37:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8ABFAA0A9A; Wed, 24 Sep 2025 13:37:18 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:37:18 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 1/2] Add in_reclaim()
Message-ID: <aoztdpmjelyqarfcjtmg2dmfong5u5p3vjjl3tk4trjloua6ss@5bnseemz2bbw>
References: <20250924091000.2987157-1-willy@infradead.org>
 <20250924091000.2987157-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924091000.2987157-2-willy@infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed 24-09-25 10:09:56, Matthew Wilcox (Oracle) wrote:
> This is more meaningful than checking PF_MEMALLOC.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This is IMO a good cleanup regardless of the other change. I always have to
lookup details in reclaim code when I need to deal with PF_MEMALLOC :).
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/sched/mm.h | 11 +++++++++++
>  mm/page_alloc.c          | 10 +++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2201da0afecc..a9825ea7c331 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -468,6 +468,17 @@ static inline void memalloc_pin_restore(unsigned int flags)
>  	memalloc_flags_restore(flags);
>  }
>  
> +/**
> + * in_reclaim - Is the current task doing reclaim?
> + *
> + * This is true if the current task is kswapd or if we've entered
> + * direct reclaim.
> + */
> +static inline bool in_reclaim(void)
> +{
> +	return current->flags & PF_MEMALLOC;
> +}
> +
>  #ifdef CONFIG_MEMCG
>  DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
>  /**
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1d037f97c5f..d27265df56b5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4220,7 +4220,7 @@ static bool __need_reclaim(gfp_t gfp_mask)
>  		return false;
>  
>  	/* this guy won't enter reclaim */
> -	if (current->flags & PF_MEMALLOC)
> +	if (in_reclaim())
>  		return false;
>  
>  	if (gfp_mask & __GFP_NOLOCKDEP)
> @@ -4455,10 +4455,10 @@ static inline int __gfp_pfmemalloc_flags(gfp_t gfp_mask)
>  		return 0;
>  	if (gfp_mask & __GFP_MEMALLOC)
>  		return ALLOC_NO_WATERMARKS;
> -	if (in_serving_softirq() && (current->flags & PF_MEMALLOC))
> +	if (in_serving_softirq() && in_reclaim())
>  		return ALLOC_NO_WATERMARKS;
>  	if (!in_interrupt()) {
> -		if (current->flags & PF_MEMALLOC)
> +		if (in_reclaim())
>  			return ALLOC_NO_WATERMARKS;
>  		else if (oom_reserves_allowed(current))
>  			return ALLOC_OOM;
> @@ -4627,7 +4627,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		 * because we cannot reclaim anything and only can loop waiting
>  		 * for somebody to do a work for us.
>  		 */
> -		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> +		WARN_ON_ONCE(in_reclaim());
>  	}
>  
>  restart:
> @@ -4774,7 +4774,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		goto nopage;
>  
>  	/* Avoid recursion of direct reclaim */
> -	if (current->flags & PF_MEMALLOC)
> +	if (in_reclaim())
>  		goto nopage;
>  
>  	/* Try direct reclaim and then allocating */
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

