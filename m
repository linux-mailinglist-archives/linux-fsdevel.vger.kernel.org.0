Return-Path: <linux-fsdevel+bounces-60821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64629B51C61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518F0562709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D4334399;
	Wed, 10 Sep 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHVEMvLM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rzINFh28";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHVEMvLM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rzINFh28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F93A92E
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519224; cv=none; b=Xd9kav3PbtuUli5Nqqzb2KP7awgHiJJaV+WcYuDcaM+xx8pecDZ7WaNbRGailzpwbIZFUFNYoISAjC1sYdrnP4kkw9EPTOFgIPW0jJNxmJGVWsrXDwQfcmkFQZNv9SCMGQxs1TC13ne7BOr42si7INUS+pL5y/t1NgBS0epJ480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519224; c=relaxed/simple;
	bh=l423H6MBLbqmWRaVTJkPZyIuZ3IqqWFsCT2/gEcGIsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgh9K/61MkB4fHDpC1FhfhdGYQ5qQoBh8EiF542r2ISb40QMxXPSor6vp7p0+9UpqlVCXoaPrQKjfZHvnTxmAIYrkbxwufvzyz4DWZeDGSOuk+U3lujfG67jR9GlHaYl/q3OWj17qdp2zOuggByXVIbiUEs6ouQEtPUguumHCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHVEMvLM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rzINFh28; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHVEMvLM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rzINFh28; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BAB8613C6;
	Wed, 10 Sep 2025 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5YYjlrGegW3fUf2KMnaCC2s6myG6GIkPWzcbo1ASYQ=;
	b=rHVEMvLM2MPbqfuiDLA4kZpBWLjg9VLsB3vIS7XCikTZd9JBHD0FKjB/V4MjK1H1WfxDTi
	Y67CrPEL4zrCZ63DaN5ELNZ/gKjUCYnzVlfjItz0shYPInl1ajHPl7liV3wQ/fy0DbAPQZ
	PA9b6Aw99sPDfAn9bZlf0K0eygx92pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5YYjlrGegW3fUf2KMnaCC2s6myG6GIkPWzcbo1ASYQ=;
	b=rzINFh28cpVQoe0UwzwOzoM3HWafeOfapu9B0K9y+1sfb3fkPth5hH8cr1r0Hs59oVRCkn
	IWI5h4TQqpPqCDCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rHVEMvLM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rzINFh28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5YYjlrGegW3fUf2KMnaCC2s6myG6GIkPWzcbo1ASYQ=;
	b=rHVEMvLM2MPbqfuiDLA4kZpBWLjg9VLsB3vIS7XCikTZd9JBHD0FKjB/V4MjK1H1WfxDTi
	Y67CrPEL4zrCZ63DaN5ELNZ/gKjUCYnzVlfjItz0shYPInl1ajHPl7liV3wQ/fy0DbAPQZ
	PA9b6Aw99sPDfAn9bZlf0K0eygx92pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5YYjlrGegW3fUf2KMnaCC2s6myG6GIkPWzcbo1ASYQ=;
	b=rzINFh28cpVQoe0UwzwOzoM3HWafeOfapu9B0K9y+1sfb3fkPth5hH8cr1r0Hs59oVRCkn
	IWI5h4TQqpPqCDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6286113310;
	Wed, 10 Sep 2025 15:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P9IMGHKdwWgyPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:46:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6DDD1A0A2D; Wed, 10 Sep 2025 17:46:51 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:46:51 +0200
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
Subject: Re: [PATCH 13/32] user: use ns_common_init()
Message-ID: <72cdzyt7uj6ku24h3yryaod2xczpojurz3gql55owqm2ijijnf@fcmiszdhlno3>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-13-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-13-4dd56e7359d8@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8BAB8613C6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.51

On Wed 10-09-25 16:36:58, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/user_namespace.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 682f40d5632d..98f4fe84d039 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -124,12 +124,11 @@ int create_user_ns(struct cred *new)
>  		goto fail_dec;
>  
>  	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
> -	ret = ns_alloc_inum(&ns->ns);
> +
> +	ret = ns_common_init(&ns->ns, &userns_operations, true);
>  	if (ret)
>  		goto fail_free;
> -	ns->ns.ops = &userns_operations;
>  
> -	refcount_set(&ns->ns.count, 1);
>  	/* Leave the new->user_ns reference with the new user namespace. */
>  	ns->parent = parent_ns;
>  	ns->level = parent_ns->level + 1;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

