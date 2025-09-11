Return-Path: <linux-fsdevel+bounces-60910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67946B52CFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EA81C20DC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419252E92BB;
	Thu, 11 Sep 2025 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvuSesQp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hm03nDpU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvuSesQp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hm03nDpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FA2E92B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582374; cv=none; b=WR06ECGZa8aR7M/gMXHjQZUdxPbKp7QcFjFp3RhG5qPHBdAXWn2JKSDohDQaFzLS0wXEXDpJpjCElu6yJJe9vCN5RXmad3V1w5xNK2T7V6TThbVORH1lJADdcJpCy4Nl0ze8BgfFivD0+FS5XRJB4rr9+shTNbA/5z0E/+P7vac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582374; c=relaxed/simple;
	bh=ppA78DJ9yWeyCxvo3LeoCGpBga25U0H/6MUDTly1Xms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP7yp8utwsme4UdjUWKO8Z6GhxuiHtf4tEKXY+VCF8CNn4S0+aCSIZfD5veMw5/cOe/yYfxO9yO3ZyGQY+NTkzoYrhFmhgQXboNVfMQ4kT8SwrjalIUFJVsnnFSSJ2w2e56K4G6LkcD8mGaspY0FiexiaBFEcD8MLW2mM+hwMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvuSesQp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hm03nDpU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvuSesQp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hm03nDpU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CE8D3FB74;
	Thu, 11 Sep 2025 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757582369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qXB1dXrzmKVQogqD8IFmDaWfstcGAJOkL6rjZjmYWQ=;
	b=kvuSesQp4GgX5DlF4lKnduDs4DedK+gY96zjNDjGo/oyNmgZJc0S4KDxhnGMemckXtjS3W
	GCy80Qn78BfwawpLbWX7iWyeraYXum2G2zXiwq9ch3aJyV4JXUL1w1cQOkPmQSXhgvWbfD
	L2LBvhSaidA085s2WhCQIUs9V1P/qyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757582369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qXB1dXrzmKVQogqD8IFmDaWfstcGAJOkL6rjZjmYWQ=;
	b=hm03nDpUHNvd73gywLlKshmOCQni8oLv69yP0EYBkmbuZGgDPbITQmR+bRDtVyPX5p9ult
	awpSuf3MBi/2boCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kvuSesQp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hm03nDpU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757582369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qXB1dXrzmKVQogqD8IFmDaWfstcGAJOkL6rjZjmYWQ=;
	b=kvuSesQp4GgX5DlF4lKnduDs4DedK+gY96zjNDjGo/oyNmgZJc0S4KDxhnGMemckXtjS3W
	GCy80Qn78BfwawpLbWX7iWyeraYXum2G2zXiwq9ch3aJyV4JXUL1w1cQOkPmQSXhgvWbfD
	L2LBvhSaidA085s2WhCQIUs9V1P/qyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757582369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qXB1dXrzmKVQogqD8IFmDaWfstcGAJOkL6rjZjmYWQ=;
	b=hm03nDpUHNvd73gywLlKshmOCQni8oLv69yP0EYBkmbuZGgDPbITQmR+bRDtVyPX5p9ult
	awpSuf3MBi/2boCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C34213301;
	Thu, 11 Sep 2025 09:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CcGQEiGUwmiQAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 09:19:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0CD53A0A2D; Thu, 11 Sep 2025 11:19:21 +0200 (CEST)
Date: Thu, 11 Sep 2025 11:19:21 +0200
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
Message-ID: <zylbgyeq6l64hldxg44ydrijs3hk6umckkd75eelruuo47xzwc@uxc53envwz6j>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-14-4dd56e7359d8@kernel.org>
 <vgfnpdvwiji7bbg7yb5fbymp6f6q5f66rywkjyrxtdejdgoi37@ghpon5czjtkm>
 <20250911-unqualifiziert-widmen-03b0c271aa69@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-unqualifiziert-widmen-03b0c271aa69@brauner>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5CE8D3FB74
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Thu 11-09-25 10:46:11, Christian Brauner wrote:
> On Wed, Sep 10, 2025 at 05:57:52PM +0200, Jan Kara wrote:
> > On Wed 10-09-25 16:36:59, Christian Brauner wrote:
> > > Don't cargo-cult the same thing over and over.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > One comment below.
> > 
> > > @@ -812,17 +828,14 @@ static void net_ns_net_debugfs(struct net *net)
> > >  
> > >  static __net_init int net_ns_net_init(struct net *net)
> > >  {
> > > -#ifdef CONFIG_NET_NS
> > > -	net->ns.ops = &netns_operations;
> > > -#endif
> > > -	net->ns.inum = PROC_NET_INIT_INO;
> > > -	if (net != &init_net) {
> > > -		int ret = ns_alloc_inum(&net->ns);
> > > -		if (ret)
> > > -			return ret;
> > > -	}
> > > +	int ret = 0;
> > > +
> > > +	if (net == &init_net)
> > > +		net->ns.inum = PROC_NET_INIT_INO;
> > > +	else
> > > +		ret = proc_alloc_inum(&to_ns_common(net)->inum);
> > >  	net_ns_net_debugfs(net);
> > 
> > Here you're calling net_ns_net_debugfs() even if proc_alloc_inum() failed
> > which looks like a bug to me...
> 
> Yes, good catch!
> 
> Fyi, I have been out properly sick this week and that's why I haven't
> been very active on-list. I hope to be back in a more functional state
> tomorrow and will process the backlog.

There's no rush. Get well soon!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

