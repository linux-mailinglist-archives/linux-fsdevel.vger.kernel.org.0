Return-Path: <linux-fsdevel+bounces-61317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC6FB5790D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F8D188C370
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19A301475;
	Mon, 15 Sep 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hc0/jpKt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1M4fn2X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hc0/jpKt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1M4fn2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D42FFDFD
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937036; cv=none; b=AtifS/Q7TVLBYvJR9vPkL1ejL4T75v3oIJU9w+P9Aw0Y/bVh6e4qkjzT2OWkCB8Hl3tuNYjRcBdkShpDuC9w2sOQylqmRUIqcoNl1HhFbKueHxVSd6SQbz0JAbJBtWC4cD3GfdaoGwLIKWuCyI1pFZQARjadPocoZIV4sRQX59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937036; c=relaxed/simple;
	bh=eGmdzk8qdRpi3uTrcDbqlZ4vbhjAV/klz6ueyNt7fPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnXe7v1Jta3wbYCWrNLUJvrU1gJeQuz08hWim1bcY6djhUc8vwxY0qiyOON0fICvkJSU0s7ue6YfL2/wySharknam9A9a1qNClKSzwGdjCQFzC4GsctTnaF+KA3YbFei5+6IpPI93Cq25jnu6rX6DIP9oKnmSV+par75QPuVFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hc0/jpKt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1M4fn2X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hc0/jpKt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1M4fn2X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E70101F7B2;
	Mon, 15 Sep 2025 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJr/O2CxPJVVFY8RuWlCQHMtPWOyR5WAKB8tE++Kg0c=;
	b=hc0/jpKtI+pRARbNUhVnHFGe0pyfe3dQpLw1tICLJu2HoseJQeYD28y2PU4xKVTKYAZEN5
	SVNNFypIcbwkoYsOjDuM4dSKJECfqxFNFbXCvDr3hmRrRomeT0X/hWsmSWb1iqFpPU/M8V
	SJY+9aMDBELTG1DR4rD319k9lR4/5ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJr/O2CxPJVVFY8RuWlCQHMtPWOyR5WAKB8tE++Kg0c=;
	b=U1M4fn2XGfSF+z0O/SEB7Bb1Wpx09GfD7pQkUdTkwO9TKaest6NG7ZmKgXzklaL8zGEAOG
	Y7oOooz09iAkP7Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="hc0/jpKt";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U1M4fn2X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJr/O2CxPJVVFY8RuWlCQHMtPWOyR5WAKB8tE++Kg0c=;
	b=hc0/jpKtI+pRARbNUhVnHFGe0pyfe3dQpLw1tICLJu2HoseJQeYD28y2PU4xKVTKYAZEN5
	SVNNFypIcbwkoYsOjDuM4dSKJECfqxFNFbXCvDr3hmRrRomeT0X/hWsmSWb1iqFpPU/M8V
	SJY+9aMDBELTG1DR4rD319k9lR4/5ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJr/O2CxPJVVFY8RuWlCQHMtPWOyR5WAKB8tE++Kg0c=;
	b=U1M4fn2XGfSF+z0O/SEB7Bb1Wpx09GfD7pQkUdTkwO9TKaest6NG7ZmKgXzklaL8zGEAOG
	Y7oOooz09iAkP7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAC7F1368D;
	Mon, 15 Sep 2025 11:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0qtnNYf9x2gRLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 11:50:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C1D7A0A06; Mon, 15 Sep 2025 13:50:31 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:50:31 +0200
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
Message-ID: <rdp6afroud2vjvh6mjzbvq25ok2thpps5o2l3ygudrbbjpceln@qadh4ztv7deh>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-11-1a247645cef5@kernel.org>
 <ucldl3baqsuuiwzmubrkloblxfjvcecfhjd2nyvl6boccc3qlh@bumwo2wjyvgr>
 <20250915-ungeduldig-erlegen-f3d3770f15d3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-ungeduldig-erlegen-f3d3770f15d3@brauner>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E70101F7B2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Mon 15-09-25 13:42:04, Christian Brauner wrote:
> On Mon, Sep 15, 2025 at 01:07:06PM +0200, Jan Kara wrote:
> > On Fri 12-09-25 13:52:34, Christian Brauner wrote:
> > > Don't cargo-cult the same thing over and over.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > ...
> > 
> > > @@ -559,7 +572,9 @@ struct net *copy_net_ns(unsigned long flags,
> > >  		goto dec_ucounts;
> > >  	}
> > >  
> > > -	preinit_net(net, user_ns);
> > > +	rv = preinit_net(net, user_ns);
> > > +	if (rv < 0)
> > > +		goto dec_ucounts;
> > 
> > Umm, this seems to be leaking 'net' on error exit.
> 
> Sorry about this:

Looks good now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 5fb7bd8ac45a..466de530c495 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -572,12 +572,13 @@ struct net *copy_net_ns(unsigned long flags,
>                 goto dec_ucounts;
>         }
> 
> -       rv = preinit_net(net, user_ns);
> -       if (rv < 0)
> -               goto dec_ucounts;
>         net->ucounts = ucounts;
>         get_user_ns(user_ns);
> 
> +       rv = preinit_net(net, user_ns);
> +       if (rv < 0)
> +               goto put_userns;
> +
>         rv = down_read_killable(&pernet_ops_rwsem);
>         if (rv < 0)
>                 goto put_userns;
> 
> Thanks for noticing! Fixed in-tree.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

