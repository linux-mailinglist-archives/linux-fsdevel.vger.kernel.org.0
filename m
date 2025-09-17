Return-Path: <linux-fsdevel+bounces-61960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95205B81018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D4917DA4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A42F90D3;
	Wed, 17 Sep 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmD27b4B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DlBgZGiU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1j/1c0St";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TCFC+7h0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E81F7586
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126490; cv=none; b=Ifm7Kp2JkciNxuVNiy8K7HBn8FyXMZ2Go1c3bZFdY+5M+GGp2psbARg9nCQim5q6EewkZ9ZU13klXjmJiZjJIVcPUQGKLhdDYBC33HmsNc9BEib6qf1CxYabVJ606dXItwVwa6AZH/U6+c8tm/TCY1X+SQa9tQ/MXkDt4Npv77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126490; c=relaxed/simple;
	bh=AYoQ9gSJVsp1ktMxwpgGVIDF2JBU+4HfsaFdN1qVlfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbR0YVaqBusPq30y9OU1fhjWh2CfZRGKPw7FSJH8if47JEXYqfGQ2UerCRBSghXYa9+mBHUjDjrZu9Nj2bFBYiYFxu6GuB/Ga6zmFRDpiY6Elh3lW9dJAwNxDpLwxWKOvDrb4fCYKrplv2gkWiCEOFp3Kb6v4VMUElZGh5aMwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmD27b4B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DlBgZGiU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1j/1c0St; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TCFC+7h0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C73BD20D71;
	Wed, 17 Sep 2025 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJvaxjsReAH5d3kbnAfNByUGaY9p2NVaEyyxIn+izk4=;
	b=hmD27b4BWSo5vVqG/At0KtqDKdvW5gF0Bca2yHnr9BsWrdzJyGQjkFY83PHE7B4nfbBE7d
	crP010m7gfrNlTkJeuAQdEYwfIIq9p22maCj5B0mHP2VEkgCmpC8Ga1Eyhud38CPqXtVAt
	jppKc2GJgM5CH1VdsGC21RrFoAsDJNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJvaxjsReAH5d3kbnAfNByUGaY9p2NVaEyyxIn+izk4=;
	b=DlBgZGiUPbr8PCEXBQELl1DvgjCULZU5qiwWj2EFKFm0MMK/WGxq9NJOxubm3tt2X6DT/6
	RNE2jaexmP16FcCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="1j/1c0St";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TCFC+7h0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJvaxjsReAH5d3kbnAfNByUGaY9p2NVaEyyxIn+izk4=;
	b=1j/1c0StxgIbqBxuolcijubS0/x79jaT/IR86x/GetHTjsPA4SCknHTb2L9Tq13CvNdCHo
	2wgqGFOgxgvXkuH81cAMRzLcCb+eIUd76Xr1knC9u1KTZVakOzI/nPRVYKzodw/w/L9Wrx
	ratHvh5dCdBdUjJIyFTZQOclq/8jqGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJvaxjsReAH5d3kbnAfNByUGaY9p2NVaEyyxIn+izk4=;
	b=TCFC+7h0Uwu1Sw7H5mugScMY0PszqBSt+wDtv3LHUW6K2smYBjbXCvdhgBfKlNnQwNl319
	nYrj6h9sDJftkYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4BA61368D;
	Wed, 17 Sep 2025 16:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8VwWLJXhymjuMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:28:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6940BA083B; Wed, 17 Sep 2025 18:28:05 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:28:05 +0200
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
Subject: Re: [PATCH 1/9] uts: split namespace into separate header
Message-ID: <aoqhkflvxtqwo6xg72pqhuqz6khzqiqpjh2xoboubhv3kctjpo@bheczoufd5yh>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-1-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-1-1b3bda8ef8f2@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C73BD20D71
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
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51

On Wed 17-09-25 12:28:00, Christian Brauner wrote:
> We have dedicated headers for all namespace types. Add one for the uts
> namespace as well. Now it's consistent for all namespace types.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Fine by me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/uts_namespace.h | 65 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/utsname.h       | 58 +-------------------------------------
>  2 files changed, 66 insertions(+), 57 deletions(-)
> 
> diff --git a/include/linux/uts_namespace.h b/include/linux/uts_namespace.h
> new file mode 100644
> index 000000000000..c2b619bb4e57
> --- /dev/null
> +++ b/include/linux/uts_namespace.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UTS_NAMESPACE_H
> +#define _LINUX_UTS_NAMESPACE_H
> +
> +#include <linux/ns_common.h>
> +#include <uapi/linux/utsname.h>
> +
> +struct user_namespace;
> +extern struct user_namespace init_user_ns;
> +
> +struct uts_namespace {
> +	struct new_utsname name;
> +	struct user_namespace *user_ns;
> +	struct ucounts *ucounts;
> +	struct ns_common ns;
> +} __randomize_layout;
> +
> +extern struct uts_namespace init_uts_ns;
> +
> +#ifdef CONFIG_UTS_NS
> +static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct uts_namespace, ns);
> +}
> +
> +static inline void get_uts_ns(struct uts_namespace *ns)
> +{
> +	refcount_inc(&ns->ns.count);
> +}
> +
> +extern struct uts_namespace *copy_utsname(unsigned long flags,
> +	struct user_namespace *user_ns, struct uts_namespace *old_ns);
> +extern void free_uts_ns(struct uts_namespace *ns);
> +
> +static inline void put_uts_ns(struct uts_namespace *ns)
> +{
> +	if (refcount_dec_and_test(&ns->ns.count))
> +		free_uts_ns(ns);
> +}
> +
> +void uts_ns_init(void);
> +#else
> +static inline void get_uts_ns(struct uts_namespace *ns)
> +{
> +}
> +
> +static inline void put_uts_ns(struct uts_namespace *ns)
> +{
> +}
> +
> +static inline struct uts_namespace *copy_utsname(unsigned long flags,
> +	struct user_namespace *user_ns, struct uts_namespace *old_ns)
> +{
> +	if (flags & CLONE_NEWUTS)
> +		return ERR_PTR(-EINVAL);
> +
> +	return old_ns;
> +}
> +
> +static inline void uts_ns_init(void)
> +{
> +}
> +#endif
> +
> +#endif /* _LINUX_UTS_NAMESPACE_H */
> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index 5d34c4f0f945..547bd4439706 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -7,7 +7,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/ns_common.h>
>  #include <linux/err.h>
> -#include <uapi/linux/utsname.h>
> +#include <linux/uts_namespace.h>
>  
>  enum uts_proc {
>  	UTS_PROC_ARCH,
> @@ -18,62 +18,6 @@ enum uts_proc {
>  	UTS_PROC_DOMAINNAME,
>  };
>  
> -struct user_namespace;
> -extern struct user_namespace init_user_ns;
> -
> -struct uts_namespace {
> -	struct new_utsname name;
> -	struct user_namespace *user_ns;
> -	struct ucounts *ucounts;
> -	struct ns_common ns;
> -} __randomize_layout;
> -extern struct uts_namespace init_uts_ns;
> -
> -#ifdef CONFIG_UTS_NS
> -static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct uts_namespace, ns);
> -}
> -
> -static inline void get_uts_ns(struct uts_namespace *ns)
> -{
> -	refcount_inc(&ns->ns.count);
> -}
> -
> -extern struct uts_namespace *copy_utsname(unsigned long flags,
> -	struct user_namespace *user_ns, struct uts_namespace *old_ns);
> -extern void free_uts_ns(struct uts_namespace *ns);
> -
> -static inline void put_uts_ns(struct uts_namespace *ns)
> -{
> -	if (refcount_dec_and_test(&ns->ns.count))
> -		free_uts_ns(ns);
> -}
> -
> -void uts_ns_init(void);
> -#else
> -static inline void get_uts_ns(struct uts_namespace *ns)
> -{
> -}
> -
> -static inline void put_uts_ns(struct uts_namespace *ns)
> -{
> -}
> -
> -static inline struct uts_namespace *copy_utsname(unsigned long flags,
> -	struct user_namespace *user_ns, struct uts_namespace *old_ns)
> -{
> -	if (flags & CLONE_NEWUTS)
> -		return ERR_PTR(-EINVAL);
> -
> -	return old_ns;
> -}
> -
> -static inline void uts_ns_init(void)
> -{
> -}
> -#endif
> -
>  #ifdef CONFIG_PROC_SYSCTL
>  extern void uts_proc_notify(enum uts_proc proc);
>  #else
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

