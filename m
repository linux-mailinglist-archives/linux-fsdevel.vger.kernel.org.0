Return-Path: <linux-fsdevel+bounces-60818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91138B51C31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8021C85BDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A8332CF9C;
	Wed, 10 Sep 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbiUUsqw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+CIFNqLq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbiUUsqw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+CIFNqLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FE32ED4C
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518974; cv=none; b=TK6WZS+eI4M1WNt0aT4j80xEDftLRQu9iwIsYRp3zqSA1MEJrDN/Df3/p2FVL889JWCZzPMCtdyCTse1yuF7GMX38fFU8dibDQgqDlbdg8onQhUJ5BvJPofj5PjWfRsU0wb60HJVVmqmfOqUh9IsOp4wL3usD3958WisWTl2psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518974; c=relaxed/simple;
	bh=eX9fCRxnySsU3oTjEntN6jUPytxtqH7RCVTQ+U6pJII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXqA4AARuz+xvqXIOv0XRnRWh9bW9DloEYBvspAIts6vFCLUpcFFk6kjhOnUWkvlTkKxJPSqUMrOXQz8Ar6ZEAin+FNzT+ayW+CJvMjiJALNbG25X6Igd3kbgNRMZNLdtcmsA1rDSKWABDYN68i5D3wvr+0NhjD9oyTLIHYJM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbiUUsqw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+CIFNqLq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbiUUsqw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+CIFNqLq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 046083517F;
	Wed, 10 Sep 2025 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nH1ypI3sV9tCpvo7KDo0hN+Mq7Sf/ivi4ShuDGJz6t4=;
	b=TbiUUsqw6gYRWan4b+JUGsE4C7Pk15/iKJlHExCOSZ+6zvqSswHHxn30r9ExcFNaP9qusJ
	bF7IXiiS++xiDuo6OznN5PScmjQS2C9a4bDEw7E1VraNitDUIX1w7B4n9xi+E/NnECBHXK
	F3ENdv4m8h51PDm7oAikyfqhNuU8spU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nH1ypI3sV9tCpvo7KDo0hN+Mq7Sf/ivi4ShuDGJz6t4=;
	b=+CIFNqLqwF6FD5evBH8REFsCAHUwVnGy+cKN1QFT9wHOzQn4W6nC9a0t7lCYPTNhsUILTw
	xES/6Ken4vpo52Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TbiUUsqw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+CIFNqLq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nH1ypI3sV9tCpvo7KDo0hN+Mq7Sf/ivi4ShuDGJz6t4=;
	b=TbiUUsqw6gYRWan4b+JUGsE4C7Pk15/iKJlHExCOSZ+6zvqSswHHxn30r9ExcFNaP9qusJ
	bF7IXiiS++xiDuo6OznN5PScmjQS2C9a4bDEw7E1VraNitDUIX1w7B4n9xi+E/NnECBHXK
	F3ENdv4m8h51PDm7oAikyfqhNuU8spU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nH1ypI3sV9tCpvo7KDo0hN+Mq7Sf/ivi4ShuDGJz6t4=;
	b=+CIFNqLqwF6FD5evBH8REFsCAHUwVnGy+cKN1QFT9wHOzQn4W6nC9a0t7lCYPTNhsUILTw
	xES/6Ken4vpo52Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9E113310;
	Wed, 10 Sep 2025 15:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fGRWNnicwWjaOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:42:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79085A0A2D; Wed, 10 Sep 2025 17:42:40 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:42:40 +0200
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
Subject: Re: [PATCH 10/32] pid: use ns_common_init()
Message-ID: <zingpzldegs7nm3f3wdf2ghy4x7vugj3btmdg2ud2ryc5gyyby@mvizp4bl5jbe>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-10-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-10-4dd56e7359d8@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 046083517F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -2.51

On Wed 10-09-25 16:36:55, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  kernel/pid_namespace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 7098ed44e717..20ce4052d1c5 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -102,17 +102,15 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	if (ns->pid_cachep == NULL)
>  		goto out_free_idr;
>  
> -	err = ns_alloc_inum(&ns->ns);
> +	err = ns_common_init(&ns->ns, &pidns_operations, true);
>  	if (err)
>  		goto out_free_idr;
> -	ns->ns.ops = &pidns_operations;
>  
>  	ns->pid_max = PID_MAX_LIMIT;
>  	err = register_pidns_sysctls(ns);
>  	if (err)
>  		goto out_free_inum;
>  
> -	refcount_set(&ns->ns.count, 1);
>  	ns->level = level;
>  	ns->parent = get_pid_ns(parent_pid_ns);
>  	ns->user_ns = get_user_ns(user_ns);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

