Return-Path: <linux-fsdevel+bounces-62088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAAAB83DEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698B14882A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7582F2604;
	Thu, 18 Sep 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vM1rP3yV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TJubyxa3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vM1rP3yV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TJubyxa3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C292E264C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188563; cv=none; b=JdKuyc1nCZOkEKESVvmIg4wNb/FUZpPH5k7oteoW9Y2pIrDtNCq+liprp/pyM5S6rmrj1YEajMv36cIifN3SLyuThkAK9peeic1HJfJgS9tDbcDPDH8nw5knONT0r40fHBV5inm34H6bYtvCAQ/VXBip31K1Vyuqi5wQJ2ic8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188563; c=relaxed/simple;
	bh=Wm8k1T+u7ETDP68QPHbX7EbbPEMMuASOg175leXfdXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdLsxxvitC/HVg5YoqUWFk666r5d9k6zfPesSvd2+P1MuSW1KjawcNAdou9rFBuazgRjA08mQ0D6YS1HJ99JDkOMi6OA1bCVZd8KkUsQgUpY9+4/sUPqyTRSUGqXhNONvdFvwakw3H8HLUNh6iyr6nFCjgslh+aKlwpMBr7apLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vM1rP3yV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TJubyxa3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vM1rP3yV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TJubyxa3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B413633791;
	Thu, 18 Sep 2025 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758188559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn3ZgAyclABPArVlF1TY0PttSK1zxZNnq9QMfWCaAPA=;
	b=vM1rP3yVoDEJprHcVN4K/YihR0aStdKiy5VKefWYmZdqbowDWePzQVvz9GZMspE3xQUEYm
	ehhkiXzrXMiXaOwrumEzK/eGLFMnFfClqqZEV6NulVn7y078j3xq45HN1AhaA//KjmzZjp
	mhpSS8/F0acW69a6lM+KiPZRQ1VCXTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758188559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn3ZgAyclABPArVlF1TY0PttSK1zxZNnq9QMfWCaAPA=;
	b=TJubyxa3wx9BJwCMVXvGdNcEwoLSASnM9ekWZGMAMMgR3MCcFODfUd+/WZAhOdNHoDKFXF
	YGW6X6wpBtkclODA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758188559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn3ZgAyclABPArVlF1TY0PttSK1zxZNnq9QMfWCaAPA=;
	b=vM1rP3yVoDEJprHcVN4K/YihR0aStdKiy5VKefWYmZdqbowDWePzQVvz9GZMspE3xQUEYm
	ehhkiXzrXMiXaOwrumEzK/eGLFMnFfClqqZEV6NulVn7y078j3xq45HN1AhaA//KjmzZjp
	mhpSS8/F0acW69a6lM+KiPZRQ1VCXTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758188559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn3ZgAyclABPArVlF1TY0PttSK1zxZNnq9QMfWCaAPA=;
	b=TJubyxa3wx9BJwCMVXvGdNcEwoLSASnM9ekWZGMAMMgR3MCcFODfUd+/WZAhOdNHoDKFXF
	YGW6X6wpBtkclODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BFAF13A51;
	Thu, 18 Sep 2025 09:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a0QPJg/Uy2jUXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 09:42:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EFE49A09B1; Thu, 18 Sep 2025 11:42:38 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:42:38 +0200
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
Subject: Re: [PATCH 7/9] net: centralize ns_common initialization
Message-ID: <kiyr4pnrw2a2oeoc3lavj73glvdg5llsfz2txfnn56bxmytfgw@o6weansm3iyi>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-7-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-7-1b3bda8ef8f2@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 17-09-25 12:28:06, Christian Brauner wrote:
> Centralize ns_common initialization.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  net/core/net_namespace.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a57b3cda8dbc..897f4927df9e 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -409,7 +409,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
>  	ns_ops = NULL;
>  #endif
>  
> -	ret = ns_common_init(&net->ns, ns_ops, false);
> +	ret = ns_common_init(&net->ns, ns_ops, true);
>  	if (ret)
>  		return ret;
>  
> @@ -597,6 +597,7 @@ struct net *copy_net_ns(unsigned long flags,
>  		net_passive_dec(net);
>  dec_ucounts:
>  		dec_net_namespaces(ucounts);
> +		ns_free_inum(&net->ns);

This looks like a wrong place to put it? dec_ucounts also gets called when we
failed to create 'net' and thus net == NULL. 

>  		return ERR_PTR(rv);
>  	}
>  	return net;
> @@ -718,6 +719,7 @@ static void cleanup_net(struct work_struct *work)
>  #endif
>  		put_user_ns(net->user_ns);
>  		net_passive_dec(net);
> +		ns_free_inum(&net->ns);

The calling of ns_free_inum() after we've dropped our reference
(net_passive_dec()) looks suspicious. Given how 'net' freeing works I don't
think this can lead to actual UAF issues but it is in my opinion a bad
coding pattern and for no good reason AFAICT.

>  	}
>  	WRITE_ONCE(cleanup_net_task, NULL);
>  }

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

