Return-Path: <linux-fsdevel+bounces-62382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D544DB8FF8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223213BF8E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41D2FF142;
	Mon, 22 Sep 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYSZLn1J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FPsuUoSa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYSZLn1J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FPsuUoSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2522422A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536392; cv=none; b=RRxFc7Y4a6kVIPN1iEWT9Pm6V+4poJlVAyLWPLjPIeXhBV+nLiFjMp//LUBjKS4sjd8E5pyuPoxrKD3tx4dxTsUYqn796TdaGD+0ojsyzzK5KrwsDhvkSJVaHpuTUYnr3K7/TYnv4bb75AkSvqEDAI8iRfQWxK5LIcbpW0zRzi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536392; c=relaxed/simple;
	bh=JE6eqHzVPMQMi049oMT9AY3guqoW9SUvz9a8sK5TNWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHjydojm5HgRaFEY4W05m8N+ALY5FhsGZ+7Ho0/O+aY5SxlihcaxixBO64l1bHbFkEhcBQbSIEJLSOSqHZEHd06oj9OJ6dIWId+ZnwRaUqaz9dckPVam9XdjLKVNc9MLh+0J7kgXAlSYB24Dczh7L/M2szzHAb3OPAv5YJe+UpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYSZLn1J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FPsuUoSa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYSZLn1J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FPsuUoSa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96277223EF;
	Mon, 22 Sep 2025 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAiuS03SpWwOA2S2gGfiYmmunr9i/aaWyctgd7V3wXs=;
	b=iYSZLn1JntyqA+I6cogq3wX0qOAwNaCuk9s7EBuBuBpGQZZYbyI3qcq2tcC8kCsz0RwZ0k
	W5ca5XDxazKW8PKsS65TLZHzw8G9nXUBeCgzPUwh8pi2zcugodnORNmWTXb4XAZG2aK/v7
	lbpXVXC4dZ8ZRWm7XLlpAE9kRYehKUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAiuS03SpWwOA2S2gGfiYmmunr9i/aaWyctgd7V3wXs=;
	b=FPsuUoSaBzFUiW089T9i9Cc3L02cTEg2aWNHzjKD31U+jq5rDqz/9wdVVjO3QR2uHpJKec
	4qnH7utVocSHMHDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAiuS03SpWwOA2S2gGfiYmmunr9i/aaWyctgd7V3wXs=;
	b=iYSZLn1JntyqA+I6cogq3wX0qOAwNaCuk9s7EBuBuBpGQZZYbyI3qcq2tcC8kCsz0RwZ0k
	W5ca5XDxazKW8PKsS65TLZHzw8G9nXUBeCgzPUwh8pi2zcugodnORNmWTXb4XAZG2aK/v7
	lbpXVXC4dZ8ZRWm7XLlpAE9kRYehKUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAiuS03SpWwOA2S2gGfiYmmunr9i/aaWyctgd7V3wXs=;
	b=FPsuUoSaBzFUiW089T9i9Cc3L02cTEg2aWNHzjKD31U+jq5rDqz/9wdVVjO3QR2uHpJKec
	4qnH7utVocSHMHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8359B13A63;
	Mon, 22 Sep 2025 10:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ZgPIMMi0WhlOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 10:19:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A874A07C4; Mon, 22 Sep 2025 12:19:43 +0200 (CEST)
Date: Mon, 22 Sep 2025 12:19:43 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 7/9] net: centralize ns_common initialization
Message-ID: <yfd2esldmb63p3cv43gbnqy4xsefqfdlbfpoi2sr3crocmptp5@ouvz5orl7zlo>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-7-1b3bda8ef8f2@kernel.org>
 <kiyr4pnrw2a2oeoc3lavj73glvdg5llsfz2txfnn56bxmytfgw@o6weansm3iyi>
 <20250919-fanatiker-ethik-7a9bb32ee334@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-fanatiker-ethik-7a9bb32ee334@brauner>
X-Spam-Level: 
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
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,cmpxchg.org,suse.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Fri 19-09-25 10:08:33, Christian Brauner wrote:
> On Thu, Sep 18, 2025 at 11:42:38AM +0200, Jan Kara wrote:
> > On Wed 17-09-25 12:28:06, Christian Brauner wrote:
> > > Centralize ns_common initialization.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  net/core/net_namespace.c | 23 +++--------------------
> > >  1 file changed, 3 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > > index a57b3cda8dbc..897f4927df9e 100644
> > > --- a/net/core/net_namespace.c
> > > +++ b/net/core/net_namespace.c
> > > @@ -409,7 +409,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
> > >  	ns_ops = NULL;
> > >  #endif
> > >  
> > > -	ret = ns_common_init(&net->ns, ns_ops, false);
> > > +	ret = ns_common_init(&net->ns, ns_ops, true);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > @@ -597,6 +597,7 @@ struct net *copy_net_ns(unsigned long flags,
> > >  		net_passive_dec(net);
> > >  dec_ucounts:
> > >  		dec_net_namespaces(ucounts);
> > > +		ns_free_inum(&net->ns);
> > 
> > This looks like a wrong place to put it? dec_ucounts also gets called when we
> > failed to create 'net' and thus net == NULL. 
> > 
> > >  		return ERR_PTR(rv);
> > >  	}
> > >  	return net;
> > > @@ -718,6 +719,7 @@ static void cleanup_net(struct work_struct *work)
> > >  #endif
> > >  		put_user_ns(net->user_ns);
> > >  		net_passive_dec(net);
> > > +		ns_free_inum(&net->ns);
> > 
> > The calling of ns_free_inum() after we've dropped our reference
> > (net_passive_dec()) looks suspicious. Given how 'net' freeing works I don't
> > think this can lead to actual UAF issues but it is in my opinion a bad
> > coding pattern and for no good reason AFAICT.
> 
> All good points. I can't say I'm fond of the complexity in this specific
> instance in general.

Agreed. The changes look good to me now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 897f4927df9e..9df236811454 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -590,6 +590,7 @@ struct net *copy_net_ns(unsigned long flags,
> 
>         if (rv < 0) {
>  put_userns:
> +               ns_free_inum(&net->ns);
>  #ifdef CONFIG_KEYS
>                 key_remove_domain(net->key_domain);
>  #endif
> @@ -597,7 +598,6 @@ struct net *copy_net_ns(unsigned long flags,
>                 net_passive_dec(net);
>  dec_ucounts:
>                 dec_net_namespaces(ucounts);
> -               ns_free_inum(&net->ns);
>                 return ERR_PTR(rv);
>         }
>         return net;
> @@ -713,13 +713,13 @@ static void cleanup_net(struct work_struct *work)
>         /* Finally it is safe to free my network namespace structure */
>         list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
>                 list_del_init(&net->exit_list);
> +               ns_free_inum(&net->ns);
>                 dec_net_namespaces(net->ucounts);
>  #ifdef CONFIG_KEYS
>                 key_remove_domain(net->key_domain);
>  #endif
>                 put_user_ns(net->user_ns);
>                 net_passive_dec(net);
> -               ns_free_inum(&net->ns);
>         }
>         WRITE_ONCE(cleanup_net_task, NULL);
>  }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

