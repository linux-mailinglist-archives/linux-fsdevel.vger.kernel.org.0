Return-Path: <linux-fsdevel+bounces-61389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2950AB57C28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F977188A126
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194730DD36;
	Mon, 15 Sep 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAcrO9AP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bU22iS28";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAcrO9AP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bU22iS28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B530DD2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941177; cv=none; b=p72JbGLnqzGkxCYNgLfiYLWd7fgMjAR9kejhr5btAh+pqr9xJp6aQbll5TVukPsx0bQBUd4sqDyB7zwvwW6W4/qOOb731J2DSHcBHbE4fhKyivO1HppMF40Av+dD3UseJ/iMCMKThOjnHKzyGY4xoFdMhAFLhNlPQgsaPWfuO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941177; c=relaxed/simple;
	bh=mxocf+cy5MC3Cu0DwEUz97XcAG5uLkrwSdD8mAteRYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqLGKbuJLw0cKQiSQBPVijdx1CMOJGlkvKN65t2duXAlE0Y0nz++G7Ng1q1oyUjTfZQ0TIraFW0QVmskWGzMrAjN0uDdrNCw6OAL9GsSM2Ksl9X+ErbN3t56Imy3YG36aoTe5i2FOiqw67p9HaQ0z1QKNNrIKE791UllxjhF1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAcrO9AP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bU22iS28; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAcrO9AP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bU22iS28; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BAE11FB6B;
	Mon, 15 Sep 2025 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757941173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6WMrfXNUP0q2tEtBXN294FElV6YXFXuqFCdyldB7kc=;
	b=OAcrO9APtk2UaMNWdH/85ofNQGQl/E+RqET2VQKRfBVFxDOQV1wOjD/zDEZNT+BpPQUxPx
	Z/jppeSRpIngqVMhcip35nGclQZb5nYwFlxddScQMFwWlqzoF2aVedl2K/eVbIG0jOIMUP
	1/39fN1lZiDskdAS+hM9j7v4aUbcYOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757941173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6WMrfXNUP0q2tEtBXN294FElV6YXFXuqFCdyldB7kc=;
	b=bU22iS28aEk+zXS1KzuNABm/j2SkZdZeTnMeyVIVuMmahhjNymt76VhqEMNvHnFJc5/Qhw
	8DmpAn+dUvt/qjDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757941173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6WMrfXNUP0q2tEtBXN294FElV6YXFXuqFCdyldB7kc=;
	b=OAcrO9APtk2UaMNWdH/85ofNQGQl/E+RqET2VQKRfBVFxDOQV1wOjD/zDEZNT+BpPQUxPx
	Z/jppeSRpIngqVMhcip35nGclQZb5nYwFlxddScQMFwWlqzoF2aVedl2K/eVbIG0jOIMUP
	1/39fN1lZiDskdAS+hM9j7v4aUbcYOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757941173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6WMrfXNUP0q2tEtBXN294FElV6YXFXuqFCdyldB7kc=;
	b=bU22iS28aEk+zXS1KzuNABm/j2SkZdZeTnMeyVIVuMmahhjNymt76VhqEMNvHnFJc5/Qhw
	8DmpAn+dUvt/qjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73E851372E;
	Mon, 15 Sep 2025 12:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a+NCHLUNyGgBRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 12:59:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04507A0A06; Mon, 15 Sep 2025 14:59:29 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:59:28 +0200
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
Subject: Re: [PATCH v2 25/33] uts: support ns lookup
Message-ID: <altaotwhserbakcnhlenmma5o7o7j6yhy3gcaqwxdaf7sotlz5@qzsiiyu5s4ah>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-25-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-25-1a247645cef5@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Fri 12-09-25 13:52:48, Christian Brauner wrote:
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/utsname.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index 02037010b378..64155417ae0c 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -13,6 +13,7 @@
>  #include <linux/cred.h>
>  #include <linux/user_namespace.h>
>  #include <linux/proc_ns.h>
> +#include <linux/nstree.h>
>  #include <linux/sched/task.h>
>  
>  static struct kmem_cache *uts_ns_cache __ro_after_init;
> @@ -58,6 +59,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
>  	memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
>  	ns->user_ns = get_user_ns(user_ns);
>  	up_read(&uts_sem);
> +	ns_tree_add(ns);
>  	return ns;
>  
>  fail_free:
> @@ -93,10 +95,12 @@ struct uts_namespace *copy_utsname(unsigned long flags,
>  
>  void free_uts_ns(struct uts_namespace *ns)
>  {
> +	ns_tree_remove(ns);
>  	dec_uts_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
>  	ns_free_inum(&ns->ns);
> -	kmem_cache_free(uts_ns_cache, ns);
> +	/* Concurrent nstree traversal depends on a grace period. */
> +	kfree_rcu(ns, ns.ns_rcu);
>  }
>  
>  static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
> @@ -162,4 +166,5 @@ void __init uts_ns_init(void)
>  			offsetof(struct uts_namespace, name),
>  			sizeof_field(struct uts_namespace, name),
>  			NULL);
> +	ns_tree_add(&init_uts_ns);
>  }
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

