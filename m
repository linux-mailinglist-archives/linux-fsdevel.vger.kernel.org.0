Return-Path: <linux-fsdevel+bounces-27956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99942965242
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275081F223BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74C51BAEFC;
	Thu, 29 Aug 2024 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lyLWPaXE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9g/zKyGU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uoqEFiH1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u4RLto1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097E1BA861;
	Thu, 29 Aug 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967937; cv=none; b=rX3jLTx5pZhgcfe/7SRswYM/jwaB2sfiszepNqAOI3pHVP3oRJ6qpOMx6Dj6AakAnqA41v7UjuQEaQiQf3Vo4i4UngSploHi6mcHci2voa/iYZLMVrtJj4Mt6PvdZhNuv9iRMyA5zmpfirS+xRkTg1emfBiGAkw9Hkom/QoTkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967937; c=relaxed/simple;
	bh=vP/HVZzbVRARn9AjqUXoM4zpI+oz2PPwnkQ9kvQ4SF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty2UKehcBN00ez0PJ6K9yB6L7dM7koLdPe8vwICKzqyUqv7jp1AXvqSxhNhWUDKpgkIObIIBiSuLzyBPcu9ATY658NE8wBITHiMoTXiJ/nAO8bbtunzauCwJs1ckkOM12y6H1tmbUQkaQvTzIaaO+biGZvwgJhTh8iJ4zUpA6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lyLWPaXE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9g/zKyGU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uoqEFiH1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u4RLto1R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02E4C1F750;
	Thu, 29 Aug 2024 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724967933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQV+TkMQ/RSXppk8BRj8kyWXWQXEg5Fvu9E5Au4hTY0=;
	b=lyLWPaXEr30uNQod6qxz5RUQuDdlpm7ZXEb0QJ6YUPWO6/P/wddmqtC1AaxvxPMrTzLJgJ
	65oQjRJmDBhaJ2xS0ytME0cIyAqQRlJBdvDRnIETn3GdwkDeB26dpxLf48/TQRfrEYPwhC
	MB1bRsnc8hAwthSCMw3CwW4ibR0UQRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724967933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQV+TkMQ/RSXppk8BRj8kyWXWQXEg5Fvu9E5Au4hTY0=;
	b=9g/zKyGUHhc3vRaQ1IYmhSLPr+oyI41Mk5O1dAb2gFm0TuOrcpp6C/eLaaM9h8o/pkczav
	Pjivdofk1kHW1KCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uoqEFiH1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u4RLto1R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724967932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQV+TkMQ/RSXppk8BRj8kyWXWQXEg5Fvu9E5Au4hTY0=;
	b=uoqEFiH1em8fTqpv4b6+4iIeo4kNlPshwFehhVuOC+/fv4xOdQPJ0mw6IBBN2XHdc1BOpO
	HeIB0ecV84v2WemkeXgE9x7E34L2FHfvc2U6AR0y2PY0RI2GfuALHCYAk5oc5RtU3oWUZP
	TVrW92U6Frjr3Ff38urpqWaIHTyNzV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724967932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQV+TkMQ/RSXppk8BRj8kyWXWQXEg5Fvu9E5Au4hTY0=;
	b=u4RLto1RVoYINp8Jmw+wPuVQ0v8r6aeXYWHpiF2pksW/YbS1xuKWxxysYmgfrl24wlMU+g
	/ckn/tJFyf7cYqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE5E813408;
	Thu, 29 Aug 2024 21:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a82iMfvr0Ga6TQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 29 Aug 2024 21:45:31 +0000
Message-ID: <f9c1dbfd-322a-4021-928b-1d9dcaccbaec@suse.cz>
Date: Thu, 29 Aug 2024 23:45:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig
 <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
 <ZsyKQSesqc5rDFmg@casper.infradead.org> <ZsyyqxSv3-IbaAAO@tiehlicka>
 <ZszAI7oYsh7FvGgg@casper.infradead.org> <ZszU6dTOJYmujMPd@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZszU6dTOJYmujMPd@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02E4C1F750
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lst.de,gmail.com,linux.dev,suse.cz,kernel.org,zeniv.linux.org.uk,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 8/26/24 21:18, Michal Hocko wrote:
> On Mon 26-08-24 18:49:23, Matthew Wilcox wrote:
>> On Mon, Aug 26, 2024 at 06:51:55PM +0200, Michal Hocko wrote:
> [...]
>> > If a plan revert is preferably, I will go with it.
>> 
>> There aren't any other users of PF_MEMALLOC_NOWARN and it definitely
>> seems like something you want at a callsite rather than blanket for every
>> allocation below this point.  We don't seem to have many PF_ flags left,
>> so let's not keep it around if there's no immediate plans for it.
> 
> Good point. What about this?
> --- 
> From 923cd429d4b1a3520c93bcf46611ae74a3158865 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Mon, 26 Aug 2024 21:15:02 +0200
> Subject: [PATCH] Revert "mm: introduce PF_MEMALLOC_NORECLAIM,
>  PF_MEMALLOC_NOWARN"
> 
> This reverts commit eab0af905bfc3e9c05da2ca163d76a1513159aa4.
> 
> There is no existing user of those flags. PF_MEMALLOC_NOWARN is
> dangerous because a nested allocation context can use GFP_NOFAIL which
> could cause unexpected failure. Such a code would be hard to maintain
> because it could be deeper in the call chain.
> 
> PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> that such a allocation contex is inherently unsafe if the context
> doesn't fully control all allocations called from this context.
> 
> While PF_MEMALLOC_NOWARN is not dangerous the way PF_MEMALLOC_NORECLAIM
> is it doesn't have any user and as Matthew has pointed out we are
> running out of those flags so better reclaim it without any real users.
> 
> [1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/sched.h    |  4 ++--
>  include/linux/sched/mm.h | 17 ++++-------------
>  2 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8d150343d42..731ff1078c9e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1657,8 +1657,8 @@ extern struct pid *cad_pid;
>  						 * I am cleaning dirty pages from some other bdi. */
>  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> -#define PF_MEMALLOC_NORECLAIM	0x00800000	/* All allocation requests will clear __GFP_DIRECT_RECLAIM */
> -#define PF_MEMALLOC_NOWARN	0x01000000	/* All allocation requests will inherit __GFP_NOWARN */
> +#define PF__HOLE__00800000	0x00800000
> +#define PF__HOLE__01000000	0x01000000
>  #define PF__HOLE__02000000	0x02000000
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 91546493c43d..07c4fde32827 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -258,25 +258,16 @@ static inline gfp_t current_gfp_context(gfp_t flags)
>  {
>  	unsigned int pflags = READ_ONCE(current->flags);
>  
> -	if (unlikely(pflags & (PF_MEMALLOC_NOIO |
> -			       PF_MEMALLOC_NOFS |
> -			       PF_MEMALLOC_NORECLAIM |
> -			       PF_MEMALLOC_NOWARN |
> -			       PF_MEMALLOC_PIN))) {
> +	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_PIN))) {
>  		/*
> -		 * Stronger flags before weaker flags:
> -		 * NORECLAIM implies NOIO, which in turn implies NOFS
> +		 * NOIO implies both NOIO and NOFS and it is a weaker context
> +		 * so always make sure it makes precedence
>  		 */
> -		if (pflags & PF_MEMALLOC_NORECLAIM)
> -			flags &= ~__GFP_DIRECT_RECLAIM;
> -		else if (pflags & PF_MEMALLOC_NOIO)
> +		if (pflags & PF_MEMALLOC_NOIO)
>  			flags &= ~(__GFP_IO | __GFP_FS);
>  		else if (pflags & PF_MEMALLOC_NOFS)
>  			flags &= ~__GFP_FS;
>  
> -		if (pflags & PF_MEMALLOC_NOWARN)
> -			flags |= __GFP_NOWARN;
> -
>  		if (pflags & PF_MEMALLOC_PIN)
>  			flags &= ~__GFP_MOVABLE;
>  	}


