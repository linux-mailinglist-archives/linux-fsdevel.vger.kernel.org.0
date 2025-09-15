Return-Path: <linux-fsdevel+bounces-61310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5193B577A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F01704B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410442FE060;
	Mon, 15 Sep 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KflZ5prr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2HNRZWLu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KflZ5prr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2HNRZWLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A432FD7A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934434; cv=none; b=Vnf+vBaGWU4lPSIycstK3epUGRaLAcoLer+6WCk6B3JnRn00LSsYej4gvLY6CZNTwoRv+rDemd3Jjd+yUTYqvsAlgBfD32EffEvmUQx37m8l7OW8hSh9QuzYFqKkqT4krnRUafwgQ2RfnPj7ukKMKsCmlru1JvDrDRHygRNXIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934434; c=relaxed/simple;
	bh=2rTj9y3vFl3DSsUtFge7HoysdKEspuu1+SWZm5XQOXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK69HgJ0Unze/v1HBWiSyZwUt4Ylt0wofZfBHEya0JdJ6joe19SA6CeidIACmAT1E4kFP7fe2G34ivkOkiarx4MBkCDQMewvJwKu0M8wUAtSBAvCsDZhHdWXHibMkcTVft4AgygnZQ39OjWkJOuif9S7GYibeGw8AMJMqEmEyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KflZ5prr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2HNRZWLu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KflZ5prr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2HNRZWLu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2539C1F8B0;
	Mon, 15 Sep 2025 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757934431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpKepJH4yP8uSf3BpFDlyGc+QODtbZz7D8+877HUnZQ=;
	b=KflZ5prrtYNzVmL8k1x+IKinkh2EqpPUsKcKlQe2o8DkEj6UfckRnBAk7AQddMPpFg1KZz
	Nd+4bkps7q0UZs9OuwrdlssIryLTv8Y3wgxHvXfbIu8Lj1zwXIFvFdBrl932x6iguGkm1D
	s58C3CgZrMGFdfwdGBXfunliqX/vuh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757934431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpKepJH4yP8uSf3BpFDlyGc+QODtbZz7D8+877HUnZQ=;
	b=2HNRZWLurYY2wsfcOlxWXzeiYIF0ycKfGboF0uoy5qGjuFJKKtuPZ9TwlvrzDkd7wEl8mJ
	IXL9absr8FMy3lCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KflZ5prr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2HNRZWLu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757934431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpKepJH4yP8uSf3BpFDlyGc+QODtbZz7D8+877HUnZQ=;
	b=KflZ5prrtYNzVmL8k1x+IKinkh2EqpPUsKcKlQe2o8DkEj6UfckRnBAk7AQddMPpFg1KZz
	Nd+4bkps7q0UZs9OuwrdlssIryLTv8Y3wgxHvXfbIu8Lj1zwXIFvFdBrl932x6iguGkm1D
	s58C3CgZrMGFdfwdGBXfunliqX/vuh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757934431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpKepJH4yP8uSf3BpFDlyGc+QODtbZz7D8+877HUnZQ=;
	b=2HNRZWLurYY2wsfcOlxWXzeiYIF0ycKfGboF0uoy5qGjuFJKKtuPZ9TwlvrzDkd7wEl8mJ
	IXL9absr8FMy3lCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDC961372E;
	Mon, 15 Sep 2025 11:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rqYHOl7zx2jFHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 11:07:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A844A09B1; Mon, 15 Sep 2025 13:07:06 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:07:06 +0200
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
Subject: Re: [PATCH v2 11/33] net: use ns_common_init()
Message-ID: <ucldl3baqsuuiwzmubrkloblxfjvcecfhjd2nyvl6boccc3qlh@bumwo2wjyvgr>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-11-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-11-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2539C1F8B0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_TWELVE(0.00)[27];
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
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:34, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

...

> @@ -559,7 +572,9 @@ struct net *copy_net_ns(unsigned long flags,
>  		goto dec_ucounts;
>  	}
>  
> -	preinit_net(net, user_ns);
> +	rv = preinit_net(net, user_ns);
> +	if (rv < 0)
> +		goto dec_ucounts;

Umm, this seems to be leaking 'net' on error exit.

>  	net->ucounts = ucounts;
>  	get_user_ns(user_ns);
>  

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

