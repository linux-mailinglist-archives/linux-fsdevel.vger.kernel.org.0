Return-Path: <linux-fsdevel+bounces-60816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C78B51C18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818D0545CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DB32F75A;
	Wed, 10 Sep 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fyOwzFIn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DfTaYin0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qrbz3AMb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zg8UREbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8131DD8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518872; cv=none; b=f3MVQblUJHzG+dNL9ldinVrIy2ziW27Yzx+GYpkKDUW/8eaaUvGUXVs+ZHJEb8iEvUXuJrxLaOCmddaCTx8e82qpRpfMFvZhITdhfshEpPF4zu6NWA2K66I5NuWjslC0kCIk10YeigU19Q64ziu0svOMV+knt5AskxzTOpqiMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518872; c=relaxed/simple;
	bh=+bfD+JXYzRWJntuOC+egI4Wcf4ofl0H3jRCUqJ8PRYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky+dMjte3ppZnsfviNJLltcJlEZ98GHSbm1HTqa69sFH0K1d8t2yQHskMBZ0Sxsyhcrfyl4v8ijIM5Ckq/4k7tKgO8bElsXmF11HgMsKJSC5NBzbi3G5tCXA7sTfFukt1BTjK44VCBcKjF0cGODwCempdxRDzfNq3QsnFq1Bl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fyOwzFIn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DfTaYin0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qrbz3AMb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zg8UREbq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9283613F3;
	Wed, 10 Sep 2025 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1rZ9VWfuOSyaktyZzCO5tdK7LQ0sGN/uHyRso6Xglk=;
	b=fyOwzFIn9BDhaD1d86N4yDZFdsr9KuTuCs7u3KjKqP7kq3WbggOQDyuUr4rnkW3UZ/P0hQ
	N+uMm57zYKX5J87FMm8Nnxw6kIMC20FP2gKs0MMA45GJhvAjb8r6GhzM+zIGSLfVP3GjY+
	OP+GaJ7EbAq14aDI5CI8OUvHJVWxshg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1rZ9VWfuOSyaktyZzCO5tdK7LQ0sGN/uHyRso6Xglk=;
	b=DfTaYin05eIyUQ70C8RLNxXu3mqTBv2AKlq1qsGBvX1ZEU67doEX3YkUplzjh3EISLMoBH
	TSFQhuPn6+pn4uCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1rZ9VWfuOSyaktyZzCO5tdK7LQ0sGN/uHyRso6Xglk=;
	b=Qrbz3AMb8F1zDMzkGwv6BkIgVVL6E3QZDudyFs1kNqEqOok1/EYXw2PI2DDZNBcyGq2M3n
	oPMEPb2KHw/KhCFuKLhJVSRvmDmWNgdqVEHTXLM9ZZuNLIfTyLPhUulsoZE0mpI8QXV1Id
	NTMvTVcn9p6kbujzRWytc/LgwS1mtmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1rZ9VWfuOSyaktyZzCO5tdK7LQ0sGN/uHyRso6Xglk=;
	b=Zg8UREbqtFEhQ1ut1FfFQRMBiMb5/A7ehdPyEZRtfZhlFRfS7IKtxhTUhA9jUBzU0YH4LF
	TWX/wbMVf2hYxJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D728413310;
	Wed, 10 Sep 2025 15:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ibyFNBKcwWhYOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:41:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B451A0A2D; Wed, 10 Sep 2025 17:40:58 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:40:58 +0200
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
Subject: Re: [PATCH 08/32] ipc: use ns_common_init()
Message-ID: <x7qn3pxniqhkfeccsa77e7w7iw6bk7p77fu6hoqycvkdbluygu@bl35gogbwyus>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-8-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-8-4dd56e7359d8@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 10-09-25 16:36:53, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  ipc/namespace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 4df91ceeeafe..d4188a88ee57 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -61,12 +61,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  	if (ns == NULL)
>  		goto fail_dec;
>  
> -	err = ns_alloc_inum(&ns->ns);
> +	err = ns_common_init(&ns->ns, &ipcns_operations, true);
>  	if (err)
>  		goto fail_free;
> -	ns->ns.ops = &ipcns_operations;
>  
> -	refcount_set(&ns->ns.count, 1);
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->ucounts = ucounts;
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

