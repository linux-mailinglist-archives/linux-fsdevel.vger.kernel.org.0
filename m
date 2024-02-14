Return-Path: <linux-fsdevel+bounces-11541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82385482E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67CDB2228F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166E1947D;
	Wed, 14 Feb 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="POzXT2W9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P1OvNP7E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPufzJDN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v4tPTTPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17118E2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909797; cv=none; b=KnJb67t1L0goLDwZ7k6PsvmeoW5RFtNY6UhSL8Aqg+1CE2C4FBpOc+/094eBUz1ovq6JLXN7jErQOtJ1eHuiuMmZfDXuv256bIP7FGE6Q2at7DiHpYwGMkpSW//dPbWi/8j+tB6RStHoWxmej+dYrChB5xKaoVC8Wk0WhQuXqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909797; c=relaxed/simple;
	bh=4naIVH1wkE9l57hGfXlNkURKzbu7ql8tV9YG/LW5j38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3x6mMihftUY/CBvz8nI1Ip4Q7QKv/UO8+qzbiGgwZ1wwjwrL+C9+HoeR89UcUH50Mi6gk2TpQR8xBWKl0rVJzDYpEFJ/33liv5U0+b6B7CUa6/4nxWMoASlq1edg8CPjYO+i4nWKTWANKgtG1UkPh81vp/Hs1Efw2CxD5TId+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=POzXT2W9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P1OvNP7E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPufzJDN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v4tPTTPK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22A6C220E5;
	Wed, 14 Feb 2024 11:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707909792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wmbEvAC4ROZ+A7miAdCajpjoIq03neczv1pKm/WFd0=;
	b=POzXT2W9ASBPPcNWlmbVmBacWUF7muv3iEEh0n0EXbz7v2BO6kY7IzHPrEuMivhY4QmWfd
	7JU1ZsB/KIbla9u6zxzPV59XNlH30Kuc3s0HH4A5HYwTSxtZygQx/EZ+B3VPVEc0b7osuk
	vRbsXOFoZvRiVVolmpJwAMD3HgokL1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707909792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wmbEvAC4ROZ+A7miAdCajpjoIq03neczv1pKm/WFd0=;
	b=P1OvNP7EBab0j1tpk9q0D8vLw5NyrorxnAVDkSRYFhxi2KuKR6dGHzRA9o1hWknrRWNPtv
	2qcdz6hsdMvlh5AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707909791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wmbEvAC4ROZ+A7miAdCajpjoIq03neczv1pKm/WFd0=;
	b=QPufzJDNjR+tuMWInglEN1Ft+8Qgp9zmxJ2sAXB3jScJpRGf7aY9Mqv6su7GUX5sFvUDVO
	M9v5sGM1XkxPTCsUxUROtfoexOxpyGnM5Y0t8nWew+LSn4AEYTypK8sWVSyr9IBOHkoCmN
	Hvjj2tpgH4VPRZmE7Ldts8oWVI5JVxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707909791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wmbEvAC4ROZ+A7miAdCajpjoIq03neczv1pKm/WFd0=;
	b=v4tPTTPKNupMrE+6rNlNTotWeFUrGLalHxzNLjXHAffFh1QyMJz7pVxKr+xmKrOQ4dMUmK
	Erw7J1DE65zVuLCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 17A4213A1A;
	Wed, 14 Feb 2024 11:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XZq9BZ+izGUPYwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 14 Feb 2024 11:23:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC4C9A0809; Wed, 14 Feb 2024 12:23:10 +0100 (CET)
Date: Wed, 14 Feb 2024 12:23:10 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
Message-ID: <20240214112310.ovg2w3p6wztuslnw@quack3>
References: <20240116113247.758848-1-amir73il@gmail.com>
 <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3>
 <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
 <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QPufzJDN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v4tPTTPK
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,kernel.dk:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 22A6C220E5
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 13-02-24 21:45:56, Amir Goldstein wrote:
> On Wed, Jan 24, 2024 at 6:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Jan 24, 2024 at 6:08 PM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 16-01-24 14:53:00, Amir Goldstein wrote:
> > > > On Tue, Jan 16, 2024 at 2:04 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Tue 16-01-24 13:32:47, Amir Goldstein wrote:
> > > > > > If parent inode is not watching, check for the event in masks of
> > > > > > sb/mount/inode masks early to optimize out most of the code in
> > > > > > __fsnotify_parent() and avoid calling fsnotify().
> > > > > >
> > > > > > Jens has reported that this optimization improves BW and IOPS in an
> > > > > > io_uring benchmark by more than 10% and reduces perf reported CPU usage.
> > > > > >
> > > > > > before:
> > > > > >
> > > > > > +    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
> > > > > > +    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > > > > >
> > > > > > after:
> > > > > >
> > > > > > +    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > > > > >
> > > > > > Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> > > > > > Link: https://lore.kernel.org/linux-fsdevel/b45bd8ff-5654-4e67-90a6-aad5e6759e0b@kernel.dk/
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > ---
> > > > > >
> > > > > > Jan,
> > > > > >
> > > > > > Considering that this change looks like a clear win and it actually
> > > > > > the change that you suggested, I cleaned it up a bit and posting for
> > > > > > your consideration.
> > > > >
> > > > > Agreed, I like this. What did you generate this patch against? It does not
> > > > > apply on top of current Linus' tree (maybe it needs the change sitting in
> > > > > VFS tree - which is fine I can wait until that gets merged)?
> > > > >
> > > >
> > > > Yes, it is on top of Christian's vfs-fixes branch.
> > >
> > > Merged your improvement now (and I've split off the cleanup into a separate
> > > change and dropped the creation of fsnotify_path() which seemed a bit
> > > pointless with a single caller). All pushed out.
> > >
> >
> 
> Jan & Jens,
> 
> Although Jan has already queued this v3 patch with sufficient performance
> improvement for Jens' workloads, I got a performance regression report from
> kernel robot on will-it-scale microbenchmark (buffered write loop)
> on my fan_pre_content patches, so I tried to improve on the existing solution.
> 
> I tried something similar to v1/v2 patches, where the sb keeps accounting
> of the number of watchers for specific sub-classes of events.
> 
> I've made two major changes:
> 1. moved to counters into a per-sb state object fsnotify_sb_connector
>     as Christian requested
> 2. The counters are by fanotify classes, not by specific events, so they
>     can be used to answer the questions:
> a) Are there any fsnotify watchers on this sb?
> b) Are there any fanotify permission class listeners on this sb?
> c) Are there any fanotify pre-content (a.k.a HSM) class listeners on this sb?
> 
> I think that those questions are very relevant in the real world, because
> a positive answer to (b) and (c) is quite rare in the real world, so the
> overhead on the permission hooks could be completely eliminated in
> the common case.
> 
> If needed, we can further bisect the class counters per specific painful
> events (e.g. FAN_ACCESS*), but there is no need to do that before
> we see concrete benchmark results.

OK, I think this idea is sound, I'd just be interested whether the 0-day
bot (or somebody else) is able to see improvement with this. Otherwise why
bother :)

> Jan,
> 
> Whenever you have the time, feel free to see if this is a valid direction,
> if not for the perf optimization then we are going to need the
> fsnotify_sb_connector container for other features as well.

So firstly the name fsnotify_sb_connector really confuses me. I'd save
"connector" names to fsnotify_mark_connector. Maybe fsnotify_sb_info?

Then I dislike how we have to specialcase superblock in quite a few places
and add these wrappers and what not. This seems to be mostly caused by the
fact that you directly embed fsnotify_mark_connector into fsnotify_sb_info.
What if we just put fsnotify_connp_t there? I understand that this will
mean one more pointer fetch if there are actually marks attached to the
superblock and the event mask matches s_fsnotify_mask. But in that case we
are likely to generate the event anyway so the cost of that compared to
event generation is negligible?

And I'd allocate fsnotify_sb_info on demand from fsnotify_add_mark_locked()
which means that we need to pass object pointer (in the form of void *)
instead of fsnotify_connp_t to various mark adding functions (and transform
it to fsnotify_connp_t only in fsnotify_add_mark_locked() after possibly
setting up fsnotify_sb_info). Passing void * around is not great but it
should be fairly limited (and actually reduces the knowledge of fsnotify
internals outside of the fsnotify core).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

