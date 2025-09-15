Return-Path: <linux-fsdevel+bounces-61394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F23B57C65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079B01A25FD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46030E82B;
	Mon, 15 Sep 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0zaOiip";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i7iqIT6V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zmQdpiqT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e7GDT84W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303530CD91
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941692; cv=none; b=EvVlkeEeQuEaO4dqn2bv8MlUHArIJD4jyZk1mKlcEHChPpqbjGE1wddTcOZJWhwIAgsMQ6B23cn616V8krgTbn3uwzcFKHoh3FUEugbQXb+6DpN7F+hU4qyjL9J+uwNkmxTeeDjFgQWrAYnvLWKdKPb9gtqRAUVAgburalpqFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941692; c=relaxed/simple;
	bh=Re22mJjzS3FlfnQ75rbX5/KkAHtmHxAoHXCLc7Y2T5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixeoXrUf1yNtpRrusSBK1TP1RtONNlVYsff+jH9xlmIzta4XTQMQSJ50I/0L8afXD3oi5wfPUoDzGMqOcAYa2YUDb0UYtn2gqxHdjD6qjecOrFXbYZyoKGq+G454LMwvqSBqwEbmFndHm5leevvd6feL43a1oVW9MoanCvne1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0zaOiip; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i7iqIT6V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zmQdpiqT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e7GDT84W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0A3A1FB7A;
	Mon, 15 Sep 2025 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757941688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDT1ixlN5/l3VLvL8I6eQ25gbYXEk9IwocxJMid4zSY=;
	b=Y0zaOiiprLTkpBrhHIiGO7lF7DVf5wenfiH/E/+IxPG1rQPiz2WVQad5Nx1Z8gATTp6RPM
	oVs9vOF46oel1h+jrpuZF9zlnTuA3RmzJ6wy3iNGziWMz7uy8LCRNSF86Ivvzic3+lmbtS
	tr1Xa9zzMfEexTLliJJ6H9qHB26wZ+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757941688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDT1ixlN5/l3VLvL8I6eQ25gbYXEk9IwocxJMid4zSY=;
	b=i7iqIT6VUHIzFqv3mvi/fCZLKE80GzrdrDyp76OCC2cCUgXtsj8Fao0U+8zkE6tYzsRUEi
	qnNsE/vJyeEsRlAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zmQdpiqT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e7GDT84W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757941686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDT1ixlN5/l3VLvL8I6eQ25gbYXEk9IwocxJMid4zSY=;
	b=zmQdpiqTiBwns3bXFSj8gCGGVExEIKeH1PFidZVlpASWgVEmqj+PccZpJjIeF9IrJ4qcXK
	prAUyLVFTzKt00BujzY3IS5iYWzvj08K8CKr0j68yqMkRKiYTRgCVDNNQWvNBJ/XoyHxWF
	GMxloy2RRvmPJNVcjins+qSegtJN4s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757941686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDT1ixlN5/l3VLvL8I6eQ25gbYXEk9IwocxJMid4zSY=;
	b=e7GDT84W7wexUEtWItPo8Fpq7KhQG8m6jb+EwDDNAgCjN53sZoK/T7t6XWACPiBNIN8FMf
	KZ8m/o0jq2QC32BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCB0E1372E;
	Mon, 15 Sep 2025 13:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rzu+LbYPyGgWRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 13:08:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65AAFA0A06; Mon, 15 Sep 2025 15:08:02 +0200 (CEST)
Date: Mon, 15 Sep 2025 15:08:02 +0200
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
Subject: Re: [PATCH v2 27/33] nsfs: add current_in_namespace()
Message-ID: <oqr6utatstghtjivwscnrrwyyzq7xwnqqw6ylkeyvvv6a4pp3j@ffobmvyqlndm>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-27-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-27-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D0A3A1FB7A
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:50, Christian Brauner wrote:
> Add a helper to easily check whether a given namespace is the caller's
> current namespace. This is currently open-coded in a lot of places.
> Simply switch on the type and compare the results.
> 
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  include/linux/nsfs.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nsfs.h b/include/linux/nsfs.h
> index fb84aa538091..e5a5fa83d36b 100644
> --- a/include/linux/nsfs.h
> +++ b/include/linux/nsfs.h
> @@ -5,6 +5,8 @@
>  #define _LINUX_NSFS_H
>  
>  #include <linux/ns_common.h>
> +#include <linux/cred.h>
> +#include <linux/pid_namespace.h>
>  
>  struct path;
>  struct task_struct;
> @@ -22,5 +24,17 @@ int ns_get_name(char *buf, size_t size, struct task_struct *task,
>  			const struct proc_ns_operations *ns_ops);
>  void nsfs_init(void);
>  
> -#endif /* _LINUX_NSFS_H */
> +#define __current_namespace_from_type(__ns)				\
> +	_Generic((__ns),						\
> +		struct cgroup_namespace *: current->nsproxy->cgroup_ns,	\
> +		struct ipc_namespace *:    current->nsproxy->ipc_ns,	\
> +		struct net *:              current->nsproxy->net_ns,	\
> +		struct pid_namespace *:    task_active_pid_ns(current),	\
> +		struct mnt_namespace *:    current->nsproxy->mnt_ns,	\
> +		struct time_namespace *:   current->nsproxy->time_ns,	\
> +		struct user_namespace *:   current_user_ns(),		\
> +		struct uts_namespace *:    current->nsproxy->uts_ns)
> +
> +#define current_in_namespace(__ns) (__current_namespace_from_type(__ns) == __ns)
>  
> +#endif /* _LINUX_NSFS_H */
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

