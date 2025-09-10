Return-Path: <linux-fsdevel+bounces-60820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F99B51C52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D0D172592
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7A327A39;
	Wed, 10 Sep 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFc3ws0G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o6w8Yyur";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFc3ws0G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o6w8Yyur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BB327A30
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519212; cv=none; b=mPGV07wvGVnPKkJFqJKdzwdNYuo68dMGXOCcuIgq0c/+M2wyinQTobSFaY+kO6iHla1iM+zuo78p4HElgpz/qnA/hoRLFdyEQfz6fzO+s1Y2uWE/2S5gSq6NU9+mckkKe/3UtTOvZlvZ1UeDfFbfUzycjIwbRm+ibKZ9rWfEkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519212; c=relaxed/simple;
	bh=p3zB8vManmasHn4+Hq/M/BFg0OxKQuK9ur3N8meFVZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fezWFf53YUBe8wAaN/i86tn085YofoOhNe25Cnes33woyol2Nqhu/XVOG7WDHlFlMe23XS79q+67aDP9jCPfIN55SnKjoSEWcKE0wdgeinzgoxP95RM+o/oRsrezuH0ycJLfUqwfb3dEQioJaAprFg9iu09L06WdVABfUg9oYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UFc3ws0G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o6w8Yyur; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UFc3ws0G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o6w8Yyur; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BBDB5D920;
	Wed, 10 Sep 2025 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEIRFBW2JTO76c/Z8WF8UYdn04ImhqRHpoPD+gl+1k=;
	b=UFc3ws0GrWbj/nyEGSPTc7INNlyNkG9ZzYHfAEG1xKPSJaPqYl0kRMzsv22Ogn9CM+8WcJ
	eAOoO5bySNa82BmWxq4/tsYGD0pK1wTYPpGjtMl6VcYCkcSJHB8OX/LsDW2cLgnjSJ5wWX
	iwMy6FqmlhyZ632L5aFVpKG+9QX/lQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEIRFBW2JTO76c/Z8WF8UYdn04ImhqRHpoPD+gl+1k=;
	b=o6w8YyurIubGtR4xQGzv40qGq1mxwME7WN0xh2AYmKoNX0BWC2x6NwXdTzQd85o4XZJ1Ox
	1I25Ru1KGXwlPGCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UFc3ws0G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o6w8Yyur
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEIRFBW2JTO76c/Z8WF8UYdn04ImhqRHpoPD+gl+1k=;
	b=UFc3ws0GrWbj/nyEGSPTc7INNlyNkG9ZzYHfAEG1xKPSJaPqYl0kRMzsv22Ogn9CM+8WcJ
	eAOoO5bySNa82BmWxq4/tsYGD0pK1wTYPpGjtMl6VcYCkcSJHB8OX/LsDW2cLgnjSJ5wWX
	iwMy6FqmlhyZ632L5aFVpKG+9QX/lQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEIRFBW2JTO76c/Z8WF8UYdn04ImhqRHpoPD+gl+1k=;
	b=o6w8YyurIubGtR4xQGzv40qGq1mxwME7WN0xh2AYmKoNX0BWC2x6NwXdTzQd85o4XZJ1Ox
	1I25Ru1KGXwlPGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 554DE13310;
	Wed, 10 Sep 2025 15:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S43RFGGdwWgbPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:46:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 29163A0A2D; Wed, 10 Sep 2025 17:46:27 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:46:27 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 12/32] uts: use ns_common_init()
Message-ID: <infsybiodcbptlbolgls6jpur674rszsvdjee6iylcqhq3m5jq@jdmi6vhn2ctf>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-12-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-12-4dd56e7359d8@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4BBDB5D920
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 10-09-25 16:36:57, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/utsname.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index b1ac3ca870f2..02037010b378 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -27,16 +27,6 @@ static void dec_uts_namespaces(struct ucounts *ucounts)
>  	dec_ucount(ucounts, UCOUNT_UTS_NAMESPACES);
>  }
>  
> -static struct uts_namespace *create_uts_ns(void)
> -{
> -	struct uts_namespace *uts_ns;
> -
> -	uts_ns = kmem_cache_alloc(uts_ns_cache, GFP_KERNEL);
> -	if (uts_ns)
> -		refcount_set(&uts_ns->ns.count, 1);
> -	return uts_ns;
> -}
> -
>  /*
>   * Clone a new ns copying an original utsname, setting refcount to 1
>   * @old_ns: namespace to clone
> @@ -55,17 +45,15 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
>  		goto fail;
>  
>  	err = -ENOMEM;
> -	ns = create_uts_ns();
> +	ns = kmem_cache_zalloc(uts_ns_cache, GFP_KERNEL);
>  	if (!ns)
>  		goto fail_dec;
>  
> -	err = ns_alloc_inum(&ns->ns);
> +	err = ns_common_init(&ns->ns, &utsns_operations, true);
>  	if (err)
>  		goto fail_free;
>  
>  	ns->ucounts = ucounts;
> -	ns->ns.ops = &utsns_operations;
> -
>  	down_read(&uts_sem);
>  	memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
>  	ns->user_ns = get_user_ns(user_ns);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

