Return-Path: <linux-fsdevel+bounces-61351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A951B579F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B46A189106F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60830597F;
	Mon, 15 Sep 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s0HewJc9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oI++P+tO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iHXif3SL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j4PMdWnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192873009E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938019; cv=none; b=AqFHj60bzGwi4QHk3IyHu5+eUNHm8+ZBaV/nj72XFqYFV98LZOEJ3X2Bdf6DHpfL7xP5tzshAOwlbNEItRshyH6X/0xjHzWCTGdZB5+DwzueBeh8Oe/flLJqEkzhRTaffC3hnPTeDcINybLKbzb5Sf9eTk3HQJEuEtDVwiqAYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938019; c=relaxed/simple;
	bh=q1oHoZ8VCUtdSKEU7pOuAAsbD6Rmea0nWCs/3I4Oyqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6QtShz3DWYi1fxfz940Lh8NR1KwQf0u62xWmmK6hBqkBezaoE6s1kBbsyNgOH1KLkM0c/RYONo+Ovm8DNZIKTrSbvWxlrLeN+Zapmd8GeLtuFHOENHl2H7uX7oueKFJALJ6e047OvC87dLcUm5mRxkPzbkOnVtrz4CxoyoetMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s0HewJc9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oI++P+tO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iHXif3SL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j4PMdWnT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 582F13370E;
	Mon, 15 Sep 2025 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757938014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNnxc23G5zT9c4WsiSSkHq/o7T1urDMCr/AaNCQXDuc=;
	b=s0HewJc9RHee/hkp3WAs/NMHZlKukScUOSKp5q3fvQ77nSHNxQ9UNRdPJf9PQnsE2fdID3
	ltTnaU8gKoEhKhuqV4vY7NucKMYwkILDuPRTjlwhN1xPNu3QoCuIkaO6XzQ7+BDxSLe1FC
	oSYNgNyXSh/o5i+Af3CHjyKcJEJThJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757938014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNnxc23G5zT9c4WsiSSkHq/o7T1urDMCr/AaNCQXDuc=;
	b=oI++P+tOl9e3fkCMbIFZ25/cgyuKy2ZOxpFQT0VL/X9PTfdvTNvuw1NvkMRvlFtWA8hj4E
	xvb/nKJmudDLFmAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iHXif3SL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j4PMdWnT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757938013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNnxc23G5zT9c4WsiSSkHq/o7T1urDMCr/AaNCQXDuc=;
	b=iHXif3SL8RwaFGWofMUxdRbvUMBRQnvri8hC4gPUPXvXLM5llAPFTiW/N/iAGMi77+5sGQ
	ki/rNkTdO/8K/QE4+v9makNxWK73aGm8bcFTVrtORS6b8JcviqE6k/HqC/iiANfeJt83JN
	ZXZAWGKsRQlPvCvbeyF+22Fr4PPfmAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757938013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNnxc23G5zT9c4WsiSSkHq/o7T1urDMCr/AaNCQXDuc=;
	b=j4PMdWnT/mXUmckib6fM1g/i+kboghs7MNTy2IjMXKB+ReeAbL7eB4Bm56xGal+Ox5+Whk
	kf+dRC2i15ZwgJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48C161398D;
	Mon, 15 Sep 2025 12:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3tDDEV0ByGjXMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 12:06:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C396DA0A06; Mon, 15 Sep 2025 14:06:52 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:06:52 +0200
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
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 23/33] time: support ns lookup
Message-ID: <z5riatsc5fycrrvw4c6puqlyghsaaoefisy7osujxiu2mlnzzk@js5yxopnexcl>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-23-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-23-1a247645cef5@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 582F13370E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:46, Christian Brauner wrote:
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/time_namespace.h |  5 +++++
>  init/main.c                    |  2 ++
>  kernel/time/namespace.c        | 11 ++++++++++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
> index bb2c52f4fc94..7f6af7a9771e 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -33,6 +33,7 @@ struct time_namespace {
>  extern struct time_namespace init_time_ns;
>  
>  #ifdef CONFIG_TIME_NS
> +void __init time_ns_init(void);
>  extern int vdso_join_timens(struct task_struct *task,
>  			    struct time_namespace *ns);
>  extern void timens_commit(struct task_struct *tsk, struct time_namespace *ns);
> @@ -108,6 +109,10 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
>  }
>  
>  #else
> +static inline void __init time_ns_init(void)
> +{
> +}
> +
>  static inline int vdso_join_timens(struct task_struct *task,
>  				   struct time_namespace *ns)
>  {
> diff --git a/init/main.c b/init/main.c
> index 0ee0ee7b7c2c..e7d2c57c65a7 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -103,6 +103,7 @@
>  #include <linux/randomize_kstack.h>
>  #include <linux/pidfs.h>
>  #include <linux/ptdump.h>
> +#include <linux/time_namespace.h>
>  #include <net/net_namespace.h>
>  
>  #include <asm/io.h>
> @@ -1072,6 +1073,7 @@ void start_kernel(void)
>  	fork_init();
>  	proc_caches_init();
>  	uts_ns_init();
> +	time_ns_init();
>  	key_init();
>  	security_init();
>  	dbg_late_init();
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 0be93d8f2896..408f60d0a3b6 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -12,6 +12,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/proc_ns.h>
>  #include <linux/export.h>
> +#include <linux/nstree.h>
>  #include <linux/time.h>
>  #include <linux/slab.h>
>  #include <linux/cred.h>
> @@ -104,6 +105,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->offsets = old_ns->offsets;
>  	ns->frozen_offsets = false;
> +	ns_tree_add(ns);
>  	return ns;
>  
>  fail_free_page:
> @@ -250,11 +252,13 @@ static void timens_set_vvar_page(struct task_struct *task,
>  
>  void free_time_ns(struct time_namespace *ns)
>  {
> +	ns_tree_remove(ns);
>  	dec_time_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
>  	ns_free_inum(&ns->ns);
>  	__free_page(ns->vvar_page);
> -	kfree(ns);
> +	/* Concurrent nstree traversal depends on a grace period. */
> +	kfree_rcu(ns, ns.ns_rcu);
>  }
>  
>  static struct time_namespace *to_time_ns(struct ns_common *ns)
> @@ -487,3 +491,8 @@ struct time_namespace init_time_ns = {
>  	.ns.ops		= &timens_operations,
>  	.frozen_offsets	= true,
>  };
> +
> +void __init time_ns_init(void)
> +{
> +	ns_tree_add(&init_time_ns);
> +}
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

