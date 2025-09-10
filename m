Return-Path: <linux-fsdevel+bounces-60812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D522B51BEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010543BB22D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68420327A1D;
	Wed, 10 Sep 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oW2mtLcA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkvPRrvC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oW2mtLcA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkvPRrvC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E2327A20
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518607; cv=none; b=ZsVPgTXsammjy9j51zRGQQGpO/sBmgYiU664O+0vDLN3H6qGyj7qTPM55mhmcuiapN5JNx90tn96NfVSaMDG6Y0XrmEKuM9+UuKcWNPNRn9/BmDNIBPEBjohmmCcp4f3bgb/DyyqRm4R8SdGFrQ9fBhI3Wnqxnpn+RXKsIM0wBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518607; c=relaxed/simple;
	bh=uklbeHkJL9epdoXdffSDBTbN8f+AqjZdTiRtA0V+iS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjEVE0XLNoGhUrQRzl2z4iFgBFcfTyjt/Vm/uULVaLciuXF8Csufzqwy5qPEL4+5CSGWpTDrzGNlFc7/EPswgrLqPSwUT9rlAq2zWfUWe10png4W2BpcEk6mLuI8e8cm5480yWQy8dfvs2k8MjLJbAq0nyPHiykr9BSH0t7VOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oW2mtLcA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkvPRrvC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oW2mtLcA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkvPRrvC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6008634DD8;
	Wed, 10 Sep 2025 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt+vyOallBNf7xS4RxrPjVfwD1YXAdOq9LijfCotFfM=;
	b=oW2mtLcAjMJfHvjyqDPCwgqm7hqgbNhlj9D37ranHSXp9XuJGAE4/6V5FCrtib20C3SUXF
	M9AU/Impn1PHggvjKwLOv2N6TWmXEApV4f0GMAQeogKjQ3fBJNgDpWo/5YIb0hqRyntWGe
	JPstF/CGLqAcuioM14ijwsgICG9jepQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt+vyOallBNf7xS4RxrPjVfwD1YXAdOq9LijfCotFfM=;
	b=mkvPRrvCDRSVk044KGPozSX1A02jOOVNals3PrHoFfCtt577ofwR5XeKY8ADbtzvlzSI22
	75GFQiU/FJPmEWAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oW2mtLcA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mkvPRrvC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt+vyOallBNf7xS4RxrPjVfwD1YXAdOq9LijfCotFfM=;
	b=oW2mtLcAjMJfHvjyqDPCwgqm7hqgbNhlj9D37ranHSXp9XuJGAE4/6V5FCrtib20C3SUXF
	M9AU/Impn1PHggvjKwLOv2N6TWmXEApV4f0GMAQeogKjQ3fBJNgDpWo/5YIb0hqRyntWGe
	JPstF/CGLqAcuioM14ijwsgICG9jepQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt+vyOallBNf7xS4RxrPjVfwD1YXAdOq9LijfCotFfM=;
	b=mkvPRrvCDRSVk044KGPozSX1A02jOOVNals3PrHoFfCtt577ofwR5XeKY8ADbtzvlzSI22
	75GFQiU/FJPmEWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F54C13301;
	Wed, 10 Sep 2025 15:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NpclCwabwWjaOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:36:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD4EFA0A2D; Wed, 10 Sep 2025 17:36:29 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:36:29 +0200
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
Subject: Re: [PATCH 04/32] ns: move to_ns_common() to ns_common.h
Message-ID: <ibq6c56ja4mkcthp2yjtqv6qppadm5s7o2u533tdgebfbrfhx6@qzd32irlnvn7>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-4-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-4-4dd56e7359d8@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6008634DD8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 10-09-25 16:36:49, Christian Brauner wrote:
> Move the helper to ns_common.h where it belongs.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/ns_common.h | 20 ++++++++++++++++++++
>  include/linux/nsproxy.h   | 11 -----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 7d22ea50b098..bc2e0758e1c9 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -6,6 +6,15 @@
>  
>  struct proc_ns_operations;
>  
> +struct cgroup_namespace;
> +struct ipc_namespace;
> +struct mnt_namespace;
> +struct net;
> +struct pid_namespace;
> +struct time_namespace;
> +struct user_namespace;
> +struct uts_namespace;
> +
>  struct ns_common {
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
> @@ -13,4 +22,15 @@ struct ns_common {
>  	refcount_t count;
>  };
>  
> +#define to_ns_common(__ns)                              \
> +	_Generic((__ns),                                \
> +		struct cgroup_namespace *: &(__ns)->ns, \
> +		struct ipc_namespace *:    &(__ns)->ns, \
> +		struct mnt_namespace *:    &(__ns)->ns, \
> +		struct net *:              &(__ns)->ns, \
> +		struct pid_namespace *:    &(__ns)->ns, \
> +		struct time_namespace *:   &(__ns)->ns, \
> +		struct user_namespace *:   &(__ns)->ns, \
> +		struct uts_namespace *:    &(__ns)->ns)
> +
>  #endif
> diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
> index dab6a1734a22..e6bec522b139 100644
> --- a/include/linux/nsproxy.h
> +++ b/include/linux/nsproxy.h
> @@ -42,17 +42,6 @@ struct nsproxy {
>  };
>  extern struct nsproxy init_nsproxy;
>  
> -#define to_ns_common(__ns)                              \
> -	_Generic((__ns),                                \
> -		struct cgroup_namespace *: &(__ns->ns), \
> -		struct ipc_namespace *:    &(__ns->ns), \
> -		struct net *:              &(__ns->ns), \
> -		struct pid_namespace *:    &(__ns->ns), \
> -		struct mnt_namespace *:    &(__ns->ns), \
> -		struct time_namespace *:   &(__ns->ns), \
> -		struct user_namespace *:   &(__ns->ns), \
> -		struct uts_namespace *:    &(__ns->ns))
> -
>  /*
>   * A structure to encompass all bits needed to install
>   * a partial or complete new set of namespaces.
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

