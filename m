Return-Path: <linux-fsdevel+bounces-61323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5DCB5796D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A397548191C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6340302760;
	Mon, 15 Sep 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PLvjQb+/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="joSEGeUW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PLvjQb+/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="joSEGeUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FED3009FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937189; cv=none; b=VJYmub0UsDleFiRW2UleABHz+zZGpooA68AsQiAhJ5mH2uRFeKnRPS9qWtaWZlVu9I2REWbJAr58Klwv29Ugxza6+yk26+87jxYzlHAFp3vPjtBo/Ad4oO9d/O/1h5BxY41QudIHE/+/qBdb69OOBXCgpbtlJ1UDshIuQQjrf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937189; c=relaxed/simple;
	bh=nlLI3L0Sq8c/MSaRVTC+PEhR8VCrTRWJMTkcjoJpjxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyyzK1yTGbF5AqeWFYWvHoyB8+vmKLdykpHhs1XBr3NG0vufrdhI0Vob2bDzjigYH10i3EAzflZ/kl/7JTRv5lgZNBOjFsaw+yEEjmjMgbU396rnnUy0ENeJF6MlUre/8Cig7WAC4Cor0X34C3RxhLnQU6ZNm4/ic8eAX2Y0Z8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PLvjQb+/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=joSEGeUW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PLvjQb+/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=joSEGeUW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 955FD1F7B2;
	Mon, 15 Sep 2025 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ic8ewN0DszMH+kil9P8NRCiSXAr9daRFgx2afEtpvfY=;
	b=PLvjQb+/6Kib4OEvYcMjo995aZn2ZD+hk8dzkCI/Lekn5RPqHKgsQdcVP+XH45TJe2aWop
	YtqQyc7kQQJsVkicyW4GAGOsb92YFr+42hF3FUXARrM4RCRNGAdWiRfqeue7M1SwcpXdKn
	9N19uEJwSx9YhYKSqllMtwEu7fH/bRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ic8ewN0DszMH+kil9P8NRCiSXAr9daRFgx2afEtpvfY=;
	b=joSEGeUWresm7k29iPtanJSm62JLLX3zz5yrGwC23sf+qCZxSOKimqXVwlKMq39R33OYIl
	+EWBFnDkxdlOloDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="PLvjQb+/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=joSEGeUW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ic8ewN0DszMH+kil9P8NRCiSXAr9daRFgx2afEtpvfY=;
	b=PLvjQb+/6Kib4OEvYcMjo995aZn2ZD+hk8dzkCI/Lekn5RPqHKgsQdcVP+XH45TJe2aWop
	YtqQyc7kQQJsVkicyW4GAGOsb92YFr+42hF3FUXARrM4RCRNGAdWiRfqeue7M1SwcpXdKn
	9N19uEJwSx9YhYKSqllMtwEu7fH/bRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ic8ewN0DszMH+kil9P8NRCiSXAr9daRFgx2afEtpvfY=;
	b=joSEGeUWresm7k29iPtanJSm62JLLX3zz5yrGwC23sf+qCZxSOKimqXVwlKMq39R33OYIl
	+EWBFnDkxdlOloDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 891B71368D;
	Mon, 15 Sep 2025 11:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ni9/ISH+x2jtLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 11:53:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3CAC2A0A06; Mon, 15 Sep 2025 13:53:05 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:53:05 +0200
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
Subject: Re: [PATCH v2 19/33] cgroup: support ns lookup
Message-ID: <wx455y2gvdfkpg34r5apf3kzgj4yu6x2s45vgvrjitlgyayrum@lhrpijrvkmpm>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-19-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-19-1a247645cef5@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 955FD1F7B2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:42, Christian Brauner wrote:
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/cgroup/cgroup.c    | 2 ++
>  kernel/cgroup/namespace.c | 7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..092e6bf081ed 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -59,6 +59,7 @@
>  #include <linux/sched/cputime.h>
>  #include <linux/sched/deadline.h>
>  #include <linux/psi.h>
> +#include <linux/nstree.h>
>  #include <net/sock.h>
>  
>  #define CREATE_TRACE_POINTS
> @@ -6312,6 +6313,7 @@ int __init cgroup_init(void)
>  	WARN_ON(register_filesystem(&cpuset_fs_type));
>  #endif
>  
> +	ns_tree_add(&init_cgroup_ns);
>  	return 0;
>  }
>  
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index 0391b6ab0bf1..fc12c416dfeb 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -5,7 +5,7 @@
>  #include <linux/slab.h>
>  #include <linux/nsproxy.h>
>  #include <linux/proc_ns.h>
> -
> +#include <linux/nstree.h>
>  
>  /* cgroup namespaces */
>  
> @@ -30,16 +30,19 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
>  	ret = ns_common_init(&new_ns->ns, &cgroupns_operations, true);
>  	if (ret)
>  		return ERR_PTR(ret);
> +	ns_tree_add(new_ns);
>  	return no_free_ptr(new_ns);
>  }
>  
>  void free_cgroup_ns(struct cgroup_namespace *ns)
>  {
> +	ns_tree_remove(ns);
>  	put_css_set(ns->root_cset);
>  	dec_cgroup_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
>  	ns_free_inum(&ns->ns);
> -	kfree(ns);
> +	/* Concurrent nstree traversal depends on a grace period. */
> +	kfree_rcu(ns, ns.ns_rcu);
>  }
>  EXPORT_SYMBOL(free_cgroup_ns);
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

