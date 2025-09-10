Return-Path: <linux-fsdevel+bounces-60819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB7B51C3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953F0546588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526B3277A9;
	Wed, 10 Sep 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="doGdQZYT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yv59mdRs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="doGdQZYT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yv59mdRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00F327A10
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519057; cv=none; b=GukWeZala/sq2nRFSnE7PEtioXA2o+BZiMNiCAB3gMOMp0MsJToUNEWOfmJ7rLULEd/gVT9Ov/wIZZfJNQLyf3DyJy8MQJQeqNItYEztPquATzsIy+c5uC2tzKLfSoxU9rA53FUAZiiRwimQFkZWVJlytFVzgiQ/Gcnoj1R63Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519057; c=relaxed/simple;
	bh=HBAyyll4MQv4LcGdf6sZ/gV1F8NOWPyuwaqMUjvRbRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcAxBXikglLw+QKpKi5ZtmGemBSGz+LIzgJixq8hBrocUBTcFm/D/HGq/DhW3hGZRHMXL4S+xLluPWOreZe0wRr/SO6CxUAwpaPAtOuoaVbfQnZpGSUB60hvWob1ifUczhPKLelaZ4CYsRZMU9FCW0AnPm/Ht/be4CIICnbN2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=doGdQZYT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yv59mdRs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=doGdQZYT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yv59mdRs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F4E9613FD;
	Wed, 10 Sep 2025 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgDrfKtx0yUzNT3wkhL09Qii9hxpxHo2nkRJMW/xtE4=;
	b=doGdQZYTbwAFiUNdU4xi9q+FqHPWCZ/kL3vg5ALmwW0Z3mq6Z7gwpRzvBPI30+KDgVCEvY
	fDrBfPTWpmH1Q+oE+aCrvz8R4ZDvH43fLpRDBrk2nET6jUiyNUEhFhTlpPf0GDGL38dqSY
	Q4TMJHPjdbDKQaHzKbN//jmj32WUR9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgDrfKtx0yUzNT3wkhL09Qii9hxpxHo2nkRJMW/xtE4=;
	b=yv59mdRsNMTohiPzzUgQecrvBWAtzuqhGZ7EG1ep0ZE1CkIAvYpWOXNfWuuMJUsqGj/TcC
	588G3e9Czr1SA6Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=doGdQZYT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yv59mdRs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgDrfKtx0yUzNT3wkhL09Qii9hxpxHo2nkRJMW/xtE4=;
	b=doGdQZYTbwAFiUNdU4xi9q+FqHPWCZ/kL3vg5ALmwW0Z3mq6Z7gwpRzvBPI30+KDgVCEvY
	fDrBfPTWpmH1Q+oE+aCrvz8R4ZDvH43fLpRDBrk2nET6jUiyNUEhFhTlpPf0GDGL38dqSY
	Q4TMJHPjdbDKQaHzKbN//jmj32WUR9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgDrfKtx0yUzNT3wkhL09Qii9hxpxHo2nkRJMW/xtE4=;
	b=yv59mdRsNMTohiPzzUgQecrvBWAtzuqhGZ7EG1ep0ZE1CkIAvYpWOXNfWuuMJUsqGj/TcC
	588G3e9Czr1SA6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4190C13A54;
	Wed, 10 Sep 2025 15:44:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZOkBEMycwWgxPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:44:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE2A9A0A2D; Wed, 10 Sep 2025 17:44:03 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:44:03 +0200
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
Subject: Re: [PATCH 11/32] time: use ns_common_init()
Message-ID: <nw4v4xdhurephubizr2joq7vxa2tuvzkaz2ynucukdnm3bxfsc@y6qryhtbi3h5>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-11-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-11-4dd56e7359d8@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5F4E9613FD
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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

On Wed 10-09-25 16:36:56, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/time/namespace.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 667452768ed3..80b3d2ce2fb6 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -92,18 +92,15 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
>  	if (!ns)
>  		goto fail_dec;
>  
> -	refcount_set(&ns->ns.count, 1);
> -
>  	ns->vvar_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>  	if (!ns->vvar_page)
>  		goto fail_free;
>  
> -	err = ns_alloc_inum(&ns->ns);
> +	err = ns_common_init(&ns->ns, &timens_operations, true);
>  	if (err)
>  		goto fail_free_page;
>  
>  	ns->ucounts = ucounts;
> -	ns->ns.ops = &timens_operations;
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->offsets = old_ns->offsets;
>  	ns->frozen_offsets = false;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

