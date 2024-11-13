Return-Path: <linux-fsdevel+bounces-34673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54749C79C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF40AB35FD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73C16130C;
	Wed, 13 Nov 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bqlGpkKM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jEAzLdhK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bqlGpkKM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jEAzLdhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F77E0E8;
	Wed, 13 Nov 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513645; cv=none; b=P2FV/z0kc4I1Gglqe80mCltv7fdij0DvP9of7JvdoW/AuIN9mKS/8of56Jx7YHJL6PHDyyk+9Eqeyk5p+6/ZSoT4QJ/boTguukTlECQBWoWtfzIcRGTwxViqRCbLm1qp1DvXhOr3DciLVbNFXLpVhi8wjLIZRBFyWvsHDwHjZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513645; c=relaxed/simple;
	bh=i4zs6poiel0JnpktSFmEeDplyM1nMi88s9UHq0AK+MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAGe3u8jrQ+o7VV1rOyFBGYmEubRC8H/XVpcgIcU1OYpVPnsR5EApyn6JOy0wDUOtdOQAR7cFyyh0ABa/B/MtwIujRPPttD63MGKHZbTfzqFaq3BfNC7LWWe8Q/i+pttJAXgjAmYWsK0KkwfbicyEeKSettSxnnr8or8WUs3oGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bqlGpkKM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jEAzLdhK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bqlGpkKM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jEAzLdhK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A8941F391;
	Wed, 13 Nov 2024 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731513642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHAQ26Nn5tcyaowagOdm7FS32VGBuE9uK32EZ1ieVuo=;
	b=bqlGpkKM4gCPo2pnaaUYI7IusD/IeQkjcBxY2Hfv9VIs16KyltuHpE59AtZq7HR2pBhfCM
	Vhk+qxtnohvEldX6ZhgYLR2FZCUWf4Jsip0LJiw5lH+F5dtPUqj4L3UyU9WqphxUGqlEsI
	jz40hJZVI6bLiAOJ/81PDcm+u/dYw+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731513642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHAQ26Nn5tcyaowagOdm7FS32VGBuE9uK32EZ1ieVuo=;
	b=jEAzLdhKj625CSkoN93JQVtrv8TJ6c8/Efc7JHCF9GLk+XedmTmuKN3FyMS9OvaQ2YG7GN
	ARJI6OGSkHcX+aBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bqlGpkKM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jEAzLdhK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731513642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHAQ26Nn5tcyaowagOdm7FS32VGBuE9uK32EZ1ieVuo=;
	b=bqlGpkKM4gCPo2pnaaUYI7IusD/IeQkjcBxY2Hfv9VIs16KyltuHpE59AtZq7HR2pBhfCM
	Vhk+qxtnohvEldX6ZhgYLR2FZCUWf4Jsip0LJiw5lH+F5dtPUqj4L3UyU9WqphxUGqlEsI
	jz40hJZVI6bLiAOJ/81PDcm+u/dYw+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731513642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHAQ26Nn5tcyaowagOdm7FS32VGBuE9uK32EZ1ieVuo=;
	b=jEAzLdhKj625CSkoN93JQVtrv8TJ6c8/Efc7JHCF9GLk+XedmTmuKN3FyMS9OvaQ2YG7GN
	ARJI6OGSkHcX+aBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10DDE13A6E;
	Wed, 13 Nov 2024 16:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tM8cBCrNNGdvKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 16:00:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BFC28A08D0; Wed, 13 Nov 2024 17:00:37 +0100 (CET)
Date: Wed, 13 Nov 2024 17:00:37 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>,
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Message-ID: <20241113160037.74vu5yqzsfbvk3ad@quack3>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
 <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241113151848.hta3zax57z7lprxg@quack3>
 <CAJfpegt5_5z1qSefL-Y7HGo0_j6OZGTQfM74wG6N2Q__vB0DsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt5_5z1qSefL-Y7HGo0_j6OZGTQfM74wG6N2Q__vB0DsQ@mail.gmail.com>
X-Rspamd-Queue-Id: 1A8941F391
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 13-11-24 16:49:52, Miklos Szeredi wrote:
> On Wed, 13 Nov 2024 at 16:18, Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 13-11-24 08:45:06, Jeff Layton wrote:
> > > On Wed, 2024-11-13 at 12:27 +0100, Karel Zak wrote:
> > > > On Tue, Nov 12, 2024 at 02:39:21PM GMT, Christian Brauner wrote:
> > > > Next on the wish list is a notification (a file descriptor that can be
> > > > used in epoll) that returns a 64-bit ID when there is a change in the
> > > > mount node. This will enable us to enhance systemd so that it does not
> > > > have to read the entire mount table after every change.
> > > >
> > >
> > > New fanotify events for mount table changes, perhaps?
> >
> > Now that I'm looking at it I'm not sure fanotify is a great fit for this
> > usecase. A lot of fanotify functionality does not really work for virtual
> > filesystems such as proc and hence we generally try to discourage use of
> > fanotify for them. So just supporting one type of event (like FAN_MODIFY)
> > on one file inside proc looks as rather inconsistent interface. But I
> > vaguely remember we were discussing some kind of mount event, weren't we?
> > Or was that for something else?
> 
> Yeah, if memory serves right what we agreed on was that placing a
> watch on a mount would result in events being generated for
> mount/umount/move_mount directly under that mount.  So this would not
> be monitoring the entire namespace as poll on /proc/$$/mountinfo does.
> IIRC Lennart said that this is okay and even desirable for systemd,
> since it's only interested in a particular set of mounts.

Oh, right. Thanks for reminding me. And yes, this would fit within what
fanotify supports quite nicely.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

