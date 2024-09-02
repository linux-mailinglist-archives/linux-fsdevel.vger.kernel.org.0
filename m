Return-Path: <linux-fsdevel+bounces-28232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952859685B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DB2822A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9730186E5B;
	Mon,  2 Sep 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hI6RQIWC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fzhotnCT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SB/dkSu3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kwxmk9pL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700EF184530;
	Mon,  2 Sep 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275088; cv=none; b=kJL8CxLGDTUyE+JqEpHJmSsa4DmI+gKxqXujpbpXgR+QLujJNZr97cpIx709u1fyG0s2YVvACaryyBlVbYUAEiBt5yYEOWNcS0glmLP2QUzjKcaVG9VHgI4YR3ZUKT4cta6Oxf40Nm9mc2MtTFS3rOZ5TDv/d11vjyyUvby5pU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275088; c=relaxed/simple;
	bh=iw2MVwhX51dJhWKxubjYLfJi88FIn5V4riiOr6+qcOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nagJJmHXDWALIpx6kZKDybFModkJ2+6Y7Y01JJPBry2QxkTbkL+qfzoV0SNvQCKK+7XdY2ZVtcxjFnRZeypUEoRRyKrHuR4OOfNZV9ab7qCzQt3bktq0ik5uJmAksEt0y8xdprvJoPlPlXtNLTBUbaxhO7UC7pVN6xugYPphB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hI6RQIWC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fzhotnCT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SB/dkSu3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kwxmk9pL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D31D1FBA6;
	Mon,  2 Sep 2024 11:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725275084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrwrQnk3AUWu3toRtwqVBHqDGPavhHbdLcu1XMq0qOs=;
	b=hI6RQIWCMmhPKWpe6o9I9QXZIyKLX6nWwWERaF7rK0FX8gm7K4+VUeqm/gFHwJBmh8ZpTC
	N116j6rdT4K+BTuz7Z9A53qZSjmFH15sKy5bgWIRjmG8sLatsYFBzdpdNRTgSVXvMUO/4z
	lVrGKOkxI+zsCsPmoMXcvFGzHJGHLcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725275084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrwrQnk3AUWu3toRtwqVBHqDGPavhHbdLcu1XMq0qOs=;
	b=fzhotnCTLWLF4CazDLISpd0l0merMT3jIRmD475OHBF3W/wb4SdZkLUwSiLaH5yoZB77A7
	hV9pNWjqdDeRMhAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="SB/dkSu3";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Kwxmk9pL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725275083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrwrQnk3AUWu3toRtwqVBHqDGPavhHbdLcu1XMq0qOs=;
	b=SB/dkSu3SP2u2hBSzXm6S9gz7Spy5gi22kJpDyJ52c71E7p6DO8AlWmq6zyQ0pVQ9G9Uhn
	2pFLu2+HoeeP/nKHNnsHmIDGpO6u4B5XSwKuLfQknyqk7TByYid/m80rz/ABTvePGVGXJ2
	WaiGtSCgxKRWIag/SHT6W4usWrRFiAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725275083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrwrQnk3AUWu3toRtwqVBHqDGPavhHbdLcu1XMq0qOs=;
	b=Kwxmk9pLByDZhraqS548Om7S4OJTeE0qbNRB5Q+QkqOnXvG1vuRf3Ro2cc3zr2feQ9z2yX
	AdMOesNtHuAjMwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D4B113A7C;
	Mon,  2 Sep 2024 11:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HruoGsub1WYKcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 11:04:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1FCC7A0965; Mon,  2 Sep 2024 13:04:28 +0200 (CEST)
Date: Mon, 2 Sep 2024 13:04:28 +0200
From: Jan Kara <jack@suse.cz>
To: Kees Cook <kees@kernel.org>
Cc: Kaixiong Yu <yukaixiong@huawei.com>, akpm@linux-foundation.org,
	mcgrof@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, luto@kernel.org, tglx@linutronix.de,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	j.granados@samsung.com, willy@infradead.org,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com,
	trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paul@paul-moore.com, jmorris@namei.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next 12/15] fs: dcache: move the sysctl into its own file
Message-ID: <20240902110428.os726rhlt6y5i4ak@quack3>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
 <20240826120449.1666461-13-yukaixiong@huawei.com>
 <202408261253.D155EA0@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408261253.D155EA0@keescook>
X-Rspamd-Queue-Id: 7D31D1FBA6
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLdxgs459xdbsauns6rcjztsec)];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 26-08-24 12:56:00, Kees Cook wrote:
> On Mon, Aug 26, 2024 at 08:04:46PM +0800, Kaixiong Yu wrote:
> > The sysctl_vfs_cache_pressure belongs to fs/dcache.c, move it to
> > its own file from kernel/sysctl.c. As a part of fs/dcache.c cleaning,
> > sysctl_vfs_cache_pressure is changed to a static variable, and export
> > vfs_pressure_ratio with EXPORT_SYMBOL_GPL to be used by other files.
> > And move the unneeded include(linux/dcache.h).
> > 
> > Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> > ---
> >  fs/dcache.c            | 21 +++++++++++++++++++--
> >  include/linux/dcache.h |  7 +------
> >  kernel/sysctl.c        |  9 ---------
> >  3 files changed, 20 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 1af75fa68638..8717d5026cda 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -73,8 +73,13 @@
> >   * If no ancestor relationship:
> >   * arbitrary, since it's serialized on rename_lock
> >   */
> > -int sysctl_vfs_cache_pressure __read_mostly = 100;
> > -EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
> > +static int sysctl_vfs_cache_pressure __read_mostly = 100;
> > +
> > +unsigned long vfs_pressure_ratio(unsigned long val)
> > +{
> > +	return mult_frac(val, sysctl_vfs_cache_pressure, 100);
> > +}
> > +EXPORT_SYMBOL_GPL(vfs_pressure_ratio);
> 
> This was a static inline, but AFAICT it's only called through
> alloc_super() which is hardly "fast path". If this series gets another
> version it may be worth calling out this inline->out-of-line change in
> the commit log.
> 
> I don't think it's a blocker, but I'm not a VFS maintainer. :)

It's actually called from about 7 shrinkers of filesystem objects. They get
called relatively frequently during memory reclaim but I don't think a
function call is *that* expensive to matter in this case. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

