Return-Path: <linux-fsdevel+bounces-52795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E272AE6DCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E421D17BA07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF232D5C91;
	Tue, 24 Jun 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="liNGG8Tq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l7xWAGOP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="liNGG8Tq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l7xWAGOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044816D9C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787119; cv=none; b=LM4JtBW+n/FUj9by9APDLUqZDDyxJ8OjvWPhS2Tgh2xMmL3zKYkPoJaR/qYn2cbGVPT5rUlrhjOLnbTvwV1uC+ko7NUzwAWCEWWg8W3Y3s5m5IYeTcHA/vl8OV9Aab2H6L2ivMRrCYdpgXX9LZiUvLXTMQTxx/I1b1GK90YjxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787119; c=relaxed/simple;
	bh=obqAkOBTmPtVgF0B1N6OQVO3XE5JvjsvV48TrXVB3ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfuCokcimi/SgIhwdHf8qcAW6yBAor5xJgHfKdV97RNtvI0x2H/Y6ODEmXDaMZIOlKL7vm31qhpaTVQlLAynImnDK+NZIoFNAgavzRbYq+S0upC3xMx3tjKlkphZfLPOl4OVJXOPJFmKnRc9e8ZX5wyIa/kWgra6biuhTK0MIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=liNGG8Tq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l7xWAGOP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=liNGG8Tq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l7xWAGOP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87EF5211FD;
	Tue, 24 Jun 2025 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750787115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWsJD0jL3DvlFI+5GP8CPA26G8DS1h1aqKy5XbmLWSk=;
	b=liNGG8Tqg1jQ0Sgm7HucJeaEhwwsLWP++YfjOoLtWDwbAu9juSK+7rh02YiNax6rZe4kP0
	J5NeaExIiVBwMNVuP3y0EIoau2V1Ia8cx2nnCVtn8yC5/J0GWePH9vfvVm7zdTPfgLQjBy
	VJmY0ZyAIVu+PyHlW9+oeNn2/JdXZXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750787115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWsJD0jL3DvlFI+5GP8CPA26G8DS1h1aqKy5XbmLWSk=;
	b=l7xWAGOPN4eccQj1K1w6iP1jCyYgEj18Nc1wWXkIe2z76Y4o+cSk2eWtAQrja/uHvU54uE
	Lp47KbVowxCiMKCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750787115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWsJD0jL3DvlFI+5GP8CPA26G8DS1h1aqKy5XbmLWSk=;
	b=liNGG8Tqg1jQ0Sgm7HucJeaEhwwsLWP++YfjOoLtWDwbAu9juSK+7rh02YiNax6rZe4kP0
	J5NeaExIiVBwMNVuP3y0EIoau2V1Ia8cx2nnCVtn8yC5/J0GWePH9vfvVm7zdTPfgLQjBy
	VJmY0ZyAIVu+PyHlW9+oeNn2/JdXZXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750787115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWsJD0jL3DvlFI+5GP8CPA26G8DS1h1aqKy5XbmLWSk=;
	b=l7xWAGOPN4eccQj1K1w6iP1jCyYgEj18Nc1wWXkIe2z76Y4o+cSk2eWtAQrja/uHvU54uE
	Lp47KbVowxCiMKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FE3A13751;
	Tue, 24 Jun 2025 17:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ZJLGyvkWmicNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 17:45:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3135A04BD; Tue, 24 Jun 2025 19:45:14 +0200 (CEST)
Date: Tue, 24 Jun 2025 19:45:14 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <6vkcvns5bgajmuaghwlivrapbavib5zjinhuqox77etxkm74mv@c3guhgb7tpay>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
 <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
 <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com>
 <20250624-reinreden-museen-5b07804eaffe@brauner>
 <CAOQ4uxg_0+Z9vV1ArX2MbpDu=aGDXQSzQmMXR3mPPu5mFB8rTQ@mail.gmail.com>
 <20250624-dankt-ruhekissen-896ff2e32821@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624-dankt-ruhekissen-896ff2e32821@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,oracle.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 24-06-25 17:23:30, Christian Brauner wrote:
> On Tue, Jun 24, 2025 at 05:07:59PM +0200, Amir Goldstein wrote:
> > On Tue, Jun 24, 2025 at 4:51 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, Jun 24, 2025 at 04:28:50PM +0200, Amir Goldstein wrote:
> > > > On Tue, Jun 24, 2025 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jun 24, 2025 at 11:30 AM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > > > > > > Various filesystems such as pidfs (and likely drm in the future) have a
> > > > > > > use-case to support opening files purely based on the handle without
> > > > > > > having to require a file descriptor to another object. That's especially
> > > > > > > the case for filesystems that don't do any lookup whatsoever and there's
> > > > > > > zero relationship between the objects. Such filesystems are also
> > > > > > > singletons that stay around for the lifetime of the system meaning that
> > > > > > > they can be uniquely identified and accessed purely based on the file
> > > > > > > handle type. Enable that so that userspace doesn't have to allocate an
> > > > > > > object needlessly especially if they can't do that for whatever reason.
> > > > > > >
> > > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > > ---
> > > > > > >  fs/fhandle.c | 22 ++++++++++++++++++++--
> > > > > > >  fs/pidfs.c   |  5 ++++-
> > > > > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > > > > index ab4891925b52..54081e19f594 100644
> > > > > > > --- a/fs/fhandle.c
> > > > > > > +++ b/fs/fhandle.c
> > > > > > > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> > > > > > >       return err;
> > > > > > >  }
> > > > > > >
> > > > > > > -static int get_path_anchor(int fd, struct path *root)
> > > > > > > +static int get_path_anchor(int fd, struct path *root, int handle_type)
> > > > > > >  {
> > > > > > >       if (fd >= 0) {
> > > > > > >               CLASS(fd, f)(fd);
> > > > > > > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *root)
> > > > > > >               return 0;
> > > > > > >       }
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * Only autonomous handles can be decoded without a file
> > > > > > > +      * descriptor.
> > > > > > > +      */
> > > > > > > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > > > +             return -EOPNOTSUPP;
> > > > > >
> > > > > > This somewhat ties to my comment to patch 5 that if someone passed invalid
> > > > > > fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINVAL
> > > > > > or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
> > > > > > much about it so feel free to ignore me but I think the following might be
> > > > > > more sensible error codes:
> > > > > >
> > > > > >         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> > > > > >                 if (fd == FD_INVALID)
> > > > > >                         return -EOPNOTSUPP;
> > > > > >                 return -EBADF;
> > > > > >         }
> > > > > >
> > > > > >         if (fd != FD_INVALID)
> > > > > >                 return -EBADF; (or -EINVAL no strong preference here)
> > > > >
> > > > > FWIW, I like -EBADF better.
> > > > > it makes the error more descriptive and keeps the flow simple:
> > > > >
> > > > > +       /*
> > > > > +        * Only autonomous handles can be decoded without a file
> > > > > +        * descriptor and only when FD_INVALID is provided.
> > > > > +        */
> > > > > +       if (fd != FD_INVALID)
> > > > > +               return -EBADF;
> > > > > +
> > > > > +       if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > +               return -EOPNOTSUPP;
> > > > >
> > > >
> > > > Thinking about it some more, as I am trying to address your concerns
> > > > about crafting autonomous file handles by systemd, as you already
> > > > decided to define a range for kernel reserved values for fd, why not,
> > > > instead of requiring FD_INVALID for autonomous file handle, that we
> > > > actually define a kernel fd value that translates to "the root of pidfs":
> > > >
> > > > +       /*
> > > > +        * Autonomous handles can be decoded with a special file
> > > > +        * descriptor value that describes the filesystem.
> > > > +        */
> > > > +       switch (fd) {
> > > > +       case FD_PIDFS_ROOT:
> > > > +               pidfs_get_root(root);
> > > > +               break;
> > > > +       default:
> > > > +               return -EBADF;
> > > > +       }
> > > > +
> > > >
> > > > Then you can toss all my old ideas, including FILEID_IS_AUTONOMOUS,
> > > > and EXPORT_OP_AUTONOMOUS_HANDLES and you do not even need
> > > > to define FILEID_PIDFS anymore, just keep exporting FILEID_KERNFS
> > > > as before (you can also keep the existing systemd code) and when you want
> > > > to open file by handle you just go
> > > > open_by_handle_at(FD_PIDFS, &handle, 0)
> > > > and that's it.
> > > >
> > > > In the end, my one and only concern with autonomous file handles is that
> > > > there should be a user opt-in to request them.
> > > >
> > > > Sorry for taking the long road to get to this simpler design.
> > > > WDYT?
> > >
> > > And simply place FD_PIDFS_ROOT into the -10000 range?
> > > Sounds good to me.
> > 
> > Yes.
> > 
> > I mean I don't expect there will be a flood of those singleton
> > filesystems, but generally speaking, a unique fd constant
> > to describe the root of a singleton filesystem makes sense IMO.
> 
> Agreed. See the appended updated patches. I'm not resending completely.
> I just dropped other patches.

I like this! Much simpler.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

