Return-Path: <linux-fsdevel+bounces-60814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D98CB51C05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C39D440752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351D327A21;
	Wed, 10 Sep 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJokTYRP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qkORvjYA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJokTYRP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qkORvjYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF1324B08
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518824; cv=none; b=kkaYqZ+hWEmcCZavg29y7RgyJZW8zFRGWkm+SZI4lqnqU8gYH9Sw1f9eYVkQwB8nzzHZYbZ+0KC5dAI+KWw9dpSpIaSh+UToSHA8B1ysPwDV6aOskPDgIwJSaklSIVKh+KJuK1CTVb5SZkmlPKirfVTMhh0C+tcXqWkT/kAINOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518824; c=relaxed/simple;
	bh=jq7L7eGBng+zbnP6r3PZbT0QXHx5eksefqyFw4aOjew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo0gkNv9TWq5BBpiiv8KJG2LlOoKh9uleq0b5QA8bMWxMcYPmCS/kfFPE0narILdtphd5zLVMpisoo/O8oC+OA4S96A4YjE4UJKRildL5+9QJVE6Qs7igtZEF6UNXNTjkZVBnX+8fRFcQXxtYTrrRE0kYY8iPDfVyv7Y4slzaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJokTYRP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qkORvjYA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJokTYRP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qkORvjYA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94F7761278;
	Wed, 10 Sep 2025 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdqbbADn8hJ8kZWz58S6PALjN2HsFs+f7PEH5INcWko=;
	b=IJokTYRPUkRlyFQbBEbrbvzKBTCB/z0eRLUpN4qS7pEX75jnCuB+znPy7DwvPt1Hvfdlo2
	8gjTtNipWuubPKNxDAnPDk0BltP4OaW3LHbfwHjJCEuqcmbFzdqRHuDB69QNkDh0sBahJJ
	Dc1Je1u5Tn/uMZCGpJ1VPuDDerf2d6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdqbbADn8hJ8kZWz58S6PALjN2HsFs+f7PEH5INcWko=;
	b=qkORvjYAk5OrEdvHsYIm3nksYCTezowZNx3v8GdXIHWyMIzZTq/QENvqW4oTCx42+gDisT
	syrf4B0wXlRkAsBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdqbbADn8hJ8kZWz58S6PALjN2HsFs+f7PEH5INcWko=;
	b=IJokTYRPUkRlyFQbBEbrbvzKBTCB/z0eRLUpN4qS7pEX75jnCuB+znPy7DwvPt1Hvfdlo2
	8gjTtNipWuubPKNxDAnPDk0BltP4OaW3LHbfwHjJCEuqcmbFzdqRHuDB69QNkDh0sBahJJ
	Dc1Je1u5Tn/uMZCGpJ1VPuDDerf2d6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdqbbADn8hJ8kZWz58S6PALjN2HsFs+f7PEH5INcWko=;
	b=qkORvjYAk5OrEdvHsYIm3nksYCTezowZNx3v8GdXIHWyMIzZTq/QENvqW4oTCx42+gDisT
	syrf4B0wXlRkAsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8223D13310;
	Wed, 10 Sep 2025 15:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RpnHH+ObwWgGOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:40:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C1CA9A0A2D; Wed, 10 Sep 2025 17:40:14 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:40:14 +0200
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
Subject: Re: [PATCH 07/32] mnt: use ns_common_init()
Message-ID: <zceitqfhxx5kbrjfxryglh6ydnlnnbur2sffcsm6ani7qpzt3r@xlws63zmhrln>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-7-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-7-4dd56e7359d8@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 10-09-25 16:36:52, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ddfd4457d338..14c5cdbdd6e1 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4177,18 +4177,15 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  		dec_mnt_namespaces(ucounts);
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	if (!anon) {
> -		ret = ns_alloc_inum(&new_ns->ns);
> -		if (ret) {
> -			kfree(new_ns);
> -			dec_mnt_namespaces(ucounts);
> -			return ERR_PTR(ret);
> -		}
> +
> +	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
> +	if (ret) {
> +		kfree(new_ns);
> +		dec_mnt_namespaces(ucounts);
> +		return ERR_PTR(ret);
>  	}
> -	new_ns->ns.ops = &mntns_operations;
>  	if (!anon)
>  		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
> -	refcount_set(&new_ns->ns.count, 1);
>  	refcount_set(&new_ns->passive, 1);
>  	new_ns->mounts = RB_ROOT;
>  	INIT_LIST_HEAD(&new_ns->mnt_ns_list);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

