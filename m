Return-Path: <linux-fsdevel+bounces-60823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07FB51CA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B566B7B23D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDB32F74E;
	Wed, 10 Sep 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kwqaTM5U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxg22QqU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kwqaTM5U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxg22QqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E2322A0B
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519878; cv=none; b=VbPMCgL/DcyPJPJfv5TKa5j858B6mKCcK2HJ5ZBUdSWyUkR0g2qfMHyzdTmk+WbL812VrZqt+4c8KFTUgpFYz4oAFCssqz/ao7TfDuFH2jZiPcohvkL5EpHYbXX6D2jh+EjeFfyYxLZYESsIsZw1Tu7A4fDeNCs71L7oRn2Z/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519878; c=relaxed/simple;
	bh=IZrlqx9uORVSUnEosnx1YE8IuMJeJrHVMPuj5iwzZP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3fNsRqw4nO+wO316z1LSxucJ4J4SR+z2GNroa6JN+Ka7AirebrIokinKREW4V0fodfvbeJaeQ96KiMl6iNBxqFA1kHI7hmBAqdju5OU0GqCrd7UYYK0UHeyfZaNgBP5XtDgvD5tXdZ3APIRNZqw8hMlmjWBIVz24xaxPzvHFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kwqaTM5U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxg22QqU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kwqaTM5U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxg22QqU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BB023872D;
	Wed, 10 Sep 2025 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk0aHG6hS8MMs//QobyIp7FNFZW5FT9Bx3ocfWppQgU=;
	b=kwqaTM5UV3amr8dsrDooVR0G3qTbXf7wgp5Lt5wOzJto8cHUjMjRFkXXkjPPTGD2WUA1Yu
	tT5yVR9xdmChHdNfaB67fNWSb9ArmkwKcHL2Hoc4C6Yw4QbUTQA1ZOWStui6+CN7+D2dEx
	ifCN6AbAt3zPZ1pYXim+4W35Nl/6Pwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk0aHG6hS8MMs//QobyIp7FNFZW5FT9Bx3ocfWppQgU=;
	b=hxg22QqUPBIk17+zwN3Ur+4h14Hd65V2KNnA8gVlry0Uos2QXIJRMSPsLywl3HYBOwnMSl
	5Xd2z+RfzqvA74Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk0aHG6hS8MMs//QobyIp7FNFZW5FT9Bx3ocfWppQgU=;
	b=kwqaTM5UV3amr8dsrDooVR0G3qTbXf7wgp5Lt5wOzJto8cHUjMjRFkXXkjPPTGD2WUA1Yu
	tT5yVR9xdmChHdNfaB67fNWSb9ArmkwKcHL2Hoc4C6Yw4QbUTQA1ZOWStui6+CN7+D2dEx
	ifCN6AbAt3zPZ1pYXim+4W35Nl/6Pwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk0aHG6hS8MMs//QobyIp7FNFZW5FT9Bx3ocfWppQgU=;
	b=hxg22QqUPBIk17+zwN3Ur+4h14Hd65V2KNnA8gVlry0Uos2QXIJRMSPsLywl3HYBOwnMSl
	5Xd2z+RfzqvA74Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0980B13310;
	Wed, 10 Sep 2025 15:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 92dRAgGgwWhiQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:57:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F15CA0A2D; Wed, 10 Sep 2025 17:57:52 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:57:52 +0200
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
Subject: Re: [PATCH 14/32] net: use ns_common_init()
Message-ID: <vgfnpdvwiji7bbg7yb5fbymp6f6q5f66rywkjyrxtdejdgoi37@ghpon5czjtkm>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-14-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-14-4dd56e7359d8@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 10-09-25 16:36:59, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

One comment below.

> @@ -812,17 +828,14 @@ static void net_ns_net_debugfs(struct net *net)
>  
>  static __net_init int net_ns_net_init(struct net *net)
>  {
> -#ifdef CONFIG_NET_NS
> -	net->ns.ops = &netns_operations;
> -#endif
> -	net->ns.inum = PROC_NET_INIT_INO;
> -	if (net != &init_net) {
> -		int ret = ns_alloc_inum(&net->ns);
> -		if (ret)
> -			return ret;
> -	}
> +	int ret = 0;
> +
> +	if (net == &init_net)
> +		net->ns.inum = PROC_NET_INIT_INO;
> +	else
> +		ret = proc_alloc_inum(&to_ns_common(net)->inum);
>  	net_ns_net_debugfs(net);

Here you're calling net_ns_net_debugfs() even if proc_alloc_inum() failed
which looks like a bug to me...

								Honza

> -	return 0;
> +	return ret;
>  }
>  
>  static __net_exit void net_ns_net_exit(struct net *net)
> @@ -1282,7 +1295,12 @@ void __init net_ns_init(void)
>  #ifdef CONFIG_KEYS
>  	init_net.key_domain = &init_net_key_domain;
>  #endif
> -	preinit_net(&init_net, &init_user_ns);
> +	/*
> +	 * This currently cannot fail as the initial network namespace
> +	 * has a static inode number.
> +	 */
> +	if (preinit_net(&init_net, &init_user_ns))
> +		panic("Could not preinitialize the initial network namespace");
>  
>  	down_write(&pernet_ops_rwsem);
>  	if (setup_net(&init_net))
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

