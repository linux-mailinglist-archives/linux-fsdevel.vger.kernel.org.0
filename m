Return-Path: <linux-fsdevel+bounces-61962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9408B8106F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB2E3234ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39992F9DBC;
	Wed, 17 Sep 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OE3hcLs5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zp4jDqR4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OE3hcLs5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zp4jDqR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310E2F9C2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126616; cv=none; b=DP+axcffdVu/gHzGsPc82h2chQGNOQjY6kiYoHpumoyydHvHNh/j4f7iz5DYzT8t4MeNXYIKnxNTFX2fpwcvOxmNTUAKgbKo8DmjbsFHXcTYqDry91esAjCaHKa4Alg4pEejMJF6wVtDmQ3fJlIADyUS6CdDV8kj894iGzwfjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126616; c=relaxed/simple;
	bh=cB+9aDQdjjNMF3UrfZ8fO4WwdzVZEgF/hkUoEzY763A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeXndUd96dBzWwjLn9CoKpkgetE/oTAOkIVpEMEhhWDyeSlM4T4YmOo/QL5zhpNYj0wzxQJa+KnxS0e2wpf+sAGWg/LD42A41VK8G6VK5vGd0H0Vt+jlvXhiq9RixzjLdU0aiJhdzpyFWAEG0e64VHpD2UIEsk1XjCDbr/sp4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OE3hcLs5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zp4jDqR4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OE3hcLs5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zp4jDqR4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A66C421CA9;
	Wed, 17 Sep 2025 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z7NOln9zlNouZEOdokL7aaYwYEzJZSXWUIUToQ/mqg=;
	b=OE3hcLs5V77eQwcrATb2miPr6Qk8PuFyi5t9DOzWARSl7+Bre3b9hmyCsVm+yv/HFpV6St
	+e4Un2VVNeluSw3Ye+OSgkTTRya+CTFCiv+36d4Gw67jPtoZm+uT8SPyoiq/QtehuOl2SX
	/jibHWL2OE855Dw31DG8Pbnknr7pf3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z7NOln9zlNouZEOdokL7aaYwYEzJZSXWUIUToQ/mqg=;
	b=zp4jDqR4FK1HWAMDx8Nt8dXoLtiytH/4fSUiREQGNy6hs0dXk3a8Mt4OCODxLRyBhA+O3N
	elkgb+QVQcU8OVBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z7NOln9zlNouZEOdokL7aaYwYEzJZSXWUIUToQ/mqg=;
	b=OE3hcLs5V77eQwcrATb2miPr6Qk8PuFyi5t9DOzWARSl7+Bre3b9hmyCsVm+yv/HFpV6St
	+e4Un2VVNeluSw3Ye+OSgkTTRya+CTFCiv+36d4Gw67jPtoZm+uT8SPyoiq/QtehuOl2SX
	/jibHWL2OE855Dw31DG8Pbnknr7pf3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z7NOln9zlNouZEOdokL7aaYwYEzJZSXWUIUToQ/mqg=;
	b=zp4jDqR4FK1HWAMDx8Nt8dXoLtiytH/4fSUiREQGNy6hs0dXk3a8Mt4OCODxLRyBhA+O3N
	elkgb+QVQcU8OVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 969A91368D;
	Wed, 17 Sep 2025 16:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1qjBJBTiymioMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:30:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2768AA083B; Wed, 17 Sep 2025 18:30:04 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:30:04 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jakub Kicinski <kuba@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/9] nscommon: move to separate file
Message-ID: <uzg5z2g7yv2xbzj54nn37khy54kv5q7vj43w7qk3stebhxphc5@cnbj7tehxdpo>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-3-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-3-1b3bda8ef8f2@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 17-09-25 12:28:02, Christian Brauner wrote:
> It's really awkward spilling the ns common infrastructure into multiple
> headers. Move it to a separate file.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/ns_common.h |  3 +++
>  include/linux/proc_ns.h   | 19 -------------------
>  kernel/Makefile           |  2 +-
>  kernel/nscommon.c         | 21 +++++++++++++++++++++
>  4 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 7224072cccc5..78b17fe80b62 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -31,6 +31,9 @@ struct ns_common {
>  	};
>  };
>  
> +int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
> +		   bool alloc_inum);
> +
>  #define to_ns_common(__ns)                              \
>  	_Generic((__ns),                                \
>  		struct cgroup_namespace *: &(__ns)->ns, \
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 7f89f0829e60..9f21670b5824 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -66,25 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
>  
>  #endif /* CONFIG_PROC_FS */
>  
> -static inline int ns_common_init(struct ns_common *ns,
> -				 const struct proc_ns_operations *ops,
> -				 bool alloc_inum)
> -{
> -	if (alloc_inum) {
> -		int ret;
> -		ret = proc_alloc_inum(&ns->inum);
> -		if (ret)
> -			return ret;
> -	}
> -	refcount_set(&ns->count, 1);
> -	ns->stashed = NULL;
> -	ns->ops = ops;
> -	ns->ns_id = 0;
> -	RB_CLEAR_NODE(&ns->ns_tree_node);
> -	INIT_LIST_HEAD(&ns->ns_list_node);
> -	return 0;
> -}
> -
>  #define ns_free_inum(ns) proc_free_inum((ns)->inum)
>  
>  #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
> diff --git a/kernel/Makefile b/kernel/Makefile
> index b807516a1b43..1f48f7cd2d7b 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -8,7 +8,7 @@ obj-y     = fork.o exec_domain.o panic.o \
>  	    sysctl.o capability.o ptrace.o user.o \
>  	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
>  	    extable.o params.o \
> -	    kthread.o sys_ni.o nsproxy.o nstree.o \
> +	    kthread.o sys_ni.o nsproxy.o nstree.o nscommon.o \
>  	    notifier.o ksysfs.o cred.o reboot.o \
>  	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
>  
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> new file mode 100644
> index 000000000000..ebf4783d0505
> --- /dev/null
> +++ b/kernel/nscommon.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/ns_common.h>
> +
> +int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
> +		   bool alloc_inum)
> +{
> +	if (alloc_inum) {
> +		int ret;
> +		ret = proc_alloc_inum(&ns->inum);
> +		if (ret)
> +			return ret;
> +	}
> +	refcount_set(&ns->count, 1);
> +	ns->stashed = NULL;
> +	ns->ops = ops;
> +	ns->ns_id = 0;
> +	RB_CLEAR_NODE(&ns->ns_tree_node);
> +	INIT_LIST_HEAD(&ns->ns_list_node);
> +	return 0;
> +}
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

