Return-Path: <linux-fsdevel+bounces-61965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5DAB81022
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2201C27695
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C12FB978;
	Wed, 17 Sep 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ga1h1sq/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wIVxOdXN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ga1h1sq/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wIVxOdXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314B2FB097
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126655; cv=none; b=ePpiI8/Mi5oqWv59u4HAkEE6XNXbyh2BBRG5NTmqou8HPdYtjhLC4syY0BeMGL6HmND2ZOerOWPR8w6Uj6IUPn5kf00zsbOJgyR8IRN/mmYMj36tp5It5Rs90JrpkFkSA6aqDg/C81jHnp5KffnTeWJTvF6e3LVAOUifR8/MWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126655; c=relaxed/simple;
	bh=LCNbaDdQhrx2BpnkiWtJgCkKfuj530J/NTd5ejrL3DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6Qrfsln9O7i68aGgln6uAkIabP0IRkhgk1Pc8V7E741ZQ/uH2nnYojV+t/Qu+kK/rilGq9pyI/LWppWZSoSRUgCZUI7u620y7Co7WR0WPiClfQiieAjqKi16+UmVqPCYxz/FONCb/+uxrccZ3Hd9ZQNSjLv9m1WBFAQPx4j/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ga1h1sq/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wIVxOdXN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ga1h1sq/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wIVxOdXN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3631420C1C;
	Wed, 17 Sep 2025 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHu8FUHflfKp3Eqxd3cRb7pz8qqaKd7rwqgkkqIOk58=;
	b=ga1h1sq/ud4bUThusCVdl6s8oH6JnPYOiF1Gz4E86qDndOyMX+FUM4brX1NS0pW5YNYCrK
	oeB8eyJ7fmQAoQcla7CJLudSYRwzESMJmH5yBcI3aFell4n+ocWGbgEfoZSVw13q8wAO8H
	E+YaMqY5L8Pr7BF9ccG9vUlpUZy72A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHu8FUHflfKp3Eqxd3cRb7pz8qqaKd7rwqgkkqIOk58=;
	b=wIVxOdXNafOER9D+9HQOiEfH2BAmt4dLNCabI3Ay1xZA9zo3B5Tmhtao4Xgvs0LfA2WoD1
	sjbFFBN6iCL7+WAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ga1h1sq/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wIVxOdXN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHu8FUHflfKp3Eqxd3cRb7pz8qqaKd7rwqgkkqIOk58=;
	b=ga1h1sq/ud4bUThusCVdl6s8oH6JnPYOiF1Gz4E86qDndOyMX+FUM4brX1NS0pW5YNYCrK
	oeB8eyJ7fmQAoQcla7CJLudSYRwzESMJmH5yBcI3aFell4n+ocWGbgEfoZSVw13q8wAO8H
	E+YaMqY5L8Pr7BF9ccG9vUlpUZy72A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHu8FUHflfKp3Eqxd3cRb7pz8qqaKd7rwqgkkqIOk58=;
	b=wIVxOdXNafOER9D+9HQOiEfH2BAmt4dLNCabI3Ay1xZA9zo3B5Tmhtao4Xgvs0LfA2WoD1
	sjbFFBN6iCL7+WAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2865D1368D;
	Wed, 17 Sep 2025 16:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JXPcCTziymjhMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:30:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D3445A083B; Wed, 17 Sep 2025 18:30:51 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:30:51 +0200
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
Subject: Re: [PATCH 4/9] cgroup: split namespace into separate header
Message-ID: <3fjdecxh2a76ugqui4gke2qrl53n7l7ujmij3kf26arlrmgx5t@adnhg27vve54>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-4-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-4-1b3bda8ef8f2@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[22];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3631420C1C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 17-09-25 12:28:03, Christian Brauner wrote:
> We have dedicated headers for all namespace types. Add one for the
> cgroup namespace as well. Now it's consistent for all namespace types
> and easy to figure out what to include.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/cgroup.h           | 51 +-----------------------------------
>  include/linux/cgroup_namespace.h | 56 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 9ca25346f7cb..5156fed8cbc3 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -27,6 +27,7 @@
>  #include <linux/kernel_stat.h>
>  
>  #include <linux/cgroup-defs.h>
> +#include <linux/cgroup_namespace.h>
>  
>  struct kernel_clone_args;
>  
> @@ -783,56 +784,6 @@ static inline void cgroup_sk_free(struct sock_cgroup_data *skcd) {}
>  
>  #endif	/* CONFIG_CGROUP_DATA */
>  
> -struct cgroup_namespace {
> -	struct ns_common	ns;
> -	struct user_namespace	*user_ns;
> -	struct ucounts		*ucounts;
> -	struct css_set          *root_cset;
> -};
> -
> -extern struct cgroup_namespace init_cgroup_ns;
> -
> -#ifdef CONFIG_CGROUPS
> -
> -static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct cgroup_namespace, ns);
> -}
> -
> -void free_cgroup_ns(struct cgroup_namespace *ns);
> -
> -struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
> -					struct user_namespace *user_ns,
> -					struct cgroup_namespace *old_ns);
> -
> -int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
> -		   struct cgroup_namespace *ns);
> -
> -static inline void get_cgroup_ns(struct cgroup_namespace *ns)
> -{
> -	refcount_inc(&ns->ns.count);
> -}
> -
> -static inline void put_cgroup_ns(struct cgroup_namespace *ns)
> -{
> -	if (refcount_dec_and_test(&ns->ns.count))
> -		free_cgroup_ns(ns);
> -}
> -
> -#else /* !CONFIG_CGROUPS */
> -
> -static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
> -static inline struct cgroup_namespace *
> -copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
> -	       struct cgroup_namespace *old_ns)
> -{
> -	return old_ns;
> -}
> -
> -static inline void get_cgroup_ns(struct cgroup_namespace *ns) { }
> -static inline void put_cgroup_ns(struct cgroup_namespace *ns) { }
> -
> -#endif /* !CONFIG_CGROUPS */
>  
>  #ifdef CONFIG_CGROUPS
>  
> diff --git a/include/linux/cgroup_namespace.h b/include/linux/cgroup_namespace.h
> new file mode 100644
> index 000000000000..c02bb76c5e32
> --- /dev/null
> +++ b/include/linux/cgroup_namespace.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CGROUP_NAMESPACE_H
> +#define _LINUX_CGROUP_NAMESPACE_H
> +
> +struct cgroup_namespace {
> +	struct ns_common	ns;
> +	struct user_namespace	*user_ns;
> +	struct ucounts		*ucounts;
> +	struct css_set          *root_cset;
> +};
> +
> +extern struct cgroup_namespace init_cgroup_ns;
> +
> +#ifdef CONFIG_CGROUPS
> +
> +static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct cgroup_namespace, ns);
> +}
> +
> +void free_cgroup_ns(struct cgroup_namespace *ns);
> +
> +struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
> +					struct user_namespace *user_ns,
> +					struct cgroup_namespace *old_ns);
> +
> +int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
> +		   struct cgroup_namespace *ns);
> +
> +static inline void get_cgroup_ns(struct cgroup_namespace *ns)
> +{
> +	refcount_inc(&ns->ns.count);
> +}
> +
> +static inline void put_cgroup_ns(struct cgroup_namespace *ns)
> +{
> +	if (refcount_dec_and_test(&ns->ns.count))
> +		free_cgroup_ns(ns);
> +}
> +
> +#else /* !CONFIG_CGROUPS */
> +
> +static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
> +static inline struct cgroup_namespace *
> +copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
> +	       struct cgroup_namespace *old_ns)
> +{
> +	return old_ns;
> +}
> +
> +static inline void get_cgroup_ns(struct cgroup_namespace *ns) { }
> +static inline void put_cgroup_ns(struct cgroup_namespace *ns) { }
> +
> +#endif /* !CONFIG_CGROUPS */
> +
> +#endif /* _LINUX_CGROUP_NAMESPACE_H */
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

