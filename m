Return-Path: <linux-fsdevel+bounces-17045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98D8A6F75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D68284527
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 15:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D32130A60;
	Tue, 16 Apr 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2plJDkr+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tlBnu+EQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Khms1r4E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3uhX78w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7B1304B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280565; cv=none; b=AbPyJ5YDYV8Cc8dI8MxS68uQ6tU41K4FF4kpo6aLwdibEFBGxvG337VCWm68GFMpCwDKTIubCtnEBodpZUdHHhDT60FBXhsrvYZV5dHhUIxmmXrTG76R7K/K+c5UcJbbabkrIhOQM2Iqq3a6e1ZCGOQx7YIqcgd9vpMgkbvwh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280565; c=relaxed/simple;
	bh=KiWrTtU6hA0392tdlnnvfTYLXiqDNw7Jnjgv7Ah+0eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV0JNw9UVUisSUz5X4+6icAU1GP0rxjSEznumA8mpiLTXB4T56NEt34KptHwY1AyeFSq4MM0saKpjIuVHIQ7ql9mllKOSu5hV8ceT49c6cAEkkA+K+00vvaj5HA/2pTLgwNicIN7RuhMAHvSs0rl3prytneCKTqtShOQtrSXUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2plJDkr+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tlBnu+EQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Khms1r4E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e3uhX78w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA9185F90D;
	Tue, 16 Apr 2024 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713280561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsmfeak1f5w+VPb9JBKOFDKCtWr2+T5H/2bWJ+67VV8=;
	b=2plJDkr+s9dZ0z55GX4FrNnSsKwq2TGYNf1DKZFgwKG0FR6C6xGRmYLoEfIquzvPGbo+/V
	tn5XZ8PsrsduVThYMAibJI8T+zq/nnDpUbIwN8dB8/t+KQ0aqtRA3YhdmV9zR8a/DM6SUj
	BY4wyDrV7KXsvgSqiq5vuFE1DE/clKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713280561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsmfeak1f5w+VPb9JBKOFDKCtWr2+T5H/2bWJ+67VV8=;
	b=tlBnu+EQggeCjw4VUy/V1qBHfsJgMxbUbOKODKCw7o6EJ02vVZLfT57hiI5oUrQw+PeUJ7
	r3v9YBXV6NzEfUDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Khms1r4E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e3uhX78w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713280560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsmfeak1f5w+VPb9JBKOFDKCtWr2+T5H/2bWJ+67VV8=;
	b=Khms1r4EGgcDIRGLwBCc9DYDzM/YKt/w3BZL9mrsY1XZODW2osCTU/1b0+bTRaftAADSFn
	Nm3i2SizTLsr58WXITxqdqHirqkkjbCvKSGa76cDDrhHsAFRO6T4AtlU692W9iEgy1diEp
	kiCwlHLTRPcFQzGR7GhwLbLv97+XHRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713280560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsmfeak1f5w+VPb9JBKOFDKCtWr2+T5H/2bWJ+67VV8=;
	b=e3uhX78wxAXQhWDTOj1tVsoYUSQHMElin1Zgj8MU4rV6aIhKvC/rGtr5hntl9Q+Es7fzB4
	R56ap/kifsP8ofDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE7F413432;
	Tue, 16 Apr 2024 15:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JndMNjCWHmafAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Apr 2024 15:16:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 77518A082E; Tue, 16 Apr 2024 17:15:52 +0200 (CEST)
Date: Tue, 16 Apr 2024 17:15:52 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20240416151552.rpjbbbb5lbdvjofe@quack3>
References: <20240208183127.5onh65vyho4ds7o7@quack3>
 <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3>
 <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3>
 <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
 <20240219110121.moeds3khqgnghuj2@quack3>
 <CAOQ4uxizF_=PK9N9A8i8Q_QhpXe7MNrfUTRwR5jCVzgfSBm1dw@mail.gmail.com>
 <20240304103337.qdzkehmpj5gqrdcs@quack3>
 <CAOQ4uxh35YhMVfXHchYpgG_HoOmLY4civVpeVtz4GQmasHqWdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh35YhMVfXHchYpgG_HoOmLY4civVpeVtz4GQmasHqWdw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EA9185F90D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 15-04-24 17:23:40, Amir Goldstein wrote:
> On Mon, Mar 4, 2024 at 12:33 PM Jan Kara <jack@suse.cz> wrote:
> > On Tue 27-02-24 21:42:37, Amir Goldstein wrote:
> > > On Mon, Feb 19, 2024 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > These handlers would return EACCESS unless
> > > > > > there's somebody handling events and returning something else.
> > > > > >
> > > > > > You could then do:
> > > > > >
> > > > > > fan_fd = fanotify_init()
> > > > > > ffd = fsopen()
> > > > > > fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
> > > > > > fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
> > > > > > rootfd = fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
> > > > > > fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
> > > > > > <now you can move the superblock into the mount hierarchy>
> > > > >
> > > > > Not too bad.
> > > > > I think that "hsm_deny_mask=" mount options would give more flexibility,
> > > > > but I could be convinced otherwise.
> > > > >
> > > > > It's probably not a great idea to be running two different HSMs on the same
> > > > > fs anyway, but if user has an old HSM version installed that handles only
> > > > > pre-content events, I don't think that we want this old version if it happens
> > > > > to be run by mistake, to allow for unsupervised create,rename,delete if the
> > > > > admin wanted to atomically mount a fs that SHOULD be supervised by a
> > > > > v2 HSM that knows how to handle pre-path events.
> > > > >
> > > > > IOW, and "HSM bit" on sb is too broad IMO.
> > > >
> > > > OK. So "hsm_deny_mask=" would esentially express events that we require HSM
> > > > to handle, the rest would just be accepted by default. That makes sense.
> > >
> > > Yes.
> > >
> > > > The only thing I kind of dislike is that this ties fanotify API with mount
> > > > API. So perhaps hsm_deny_mask should be specified as a string? Like
> > > > preaccess,premodify,prelookup,... and transformed into a bitmask only
> > > > inside the kernel? It gives us more maneuvering space for the future.
> > > >
> > >
> > > Urgh. I see what you are saying, but this seems so ugly to me.
> > > I have a strong feeling that we are trying to reinvent something
> > > and that we are going to reinvent it badly.
> > > I need to look for precedents, maybe in other OS.
> > > I believe that in Windows, there is an API to register as a
> > > Cloud Engine Provider, so there is probably a way to have multiple HSMs
> > > working on different sections of the filesystem in some reliable
> > > crash safe manner.
> >
> > OK, let's see what other's have came up with :)
> 
> From my very basic Google research (did not ask Chat GPT yet ;))
> I think that MacOS FSEvents do not have blocking permission events at all,
> so there is no built-in HSM API.
> 
> The Windows Cloud Sync Engine API:
> https://learn.microsoft.com/en-us/windows/win32/cfapi/build-a-cloud-file-sync-engine
> Does allow registring different "Storage namespace providers".
> AFAICT, the persistence of "Place holder" files is based on NTFS
> "Reparse points",
> which are a long time native concept which allows registering a persistent
> hook on a file to be handled by a specific Windows driver.
> 
> So for example, a Dropbox place holder file, is a file with "reparse point"
> that has some label to direct the read/write calls to the Windows
> Cloud Sync Engine
> driver and a sub-label to direct the handling of the upcall by the Dropbox
> CloudSync Engine service.

OK, so AFAIU they implement HSM directly in the filesystem which is somewhat
different situation from what we are trying to do.

> I do not want to deal with "persistent fanotify marks" at this time, so
> maybe something like:
> 
> fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "dropbox", 0)
> fsconfig(ffd, FSCONFIG_SET_STRING, "hsmver", "1", 0)
> 
> Add support ioctls in fanotify_ioctl():
> - FANOTIFY_IOC_HSMID
> - FANOTIFY_IOC_HSMVER

What would these do? Set HSMID & HSMVER for fsnotify_group identified by
'file'? BTW I'm not so convinced about the 'version' thing. I have hard
time to remember an example where the versioning in the API actually ended
up being useful. I also expect tight coupling between userspace mounting
the filesystem and setting up HSM so it is hard to imagine some wrong
version of HSM provider would be "accidentally" started for the
filesystem.

> And require that a group with matching hsmid and recent hsmver has a live
> filesystem mark on the sb.

I'm not quite following here. We'd require matching fsnotify group for
what? For mounting the fs? For not returning EPERM from all pre-op
handlers? Either way that doesn't make sense to me as its unclear how
userspace would be able to place the mark... But there's a way around that
- since the HSM app will have its private non-HSM mount for filling in
contents, it can first create that mount, place filesystem marks though
it and then remount the superblock with hsmid mount option and create the
public mount. But I'm not sure if you meant this or something else...

> If this is an acceptable API for a single crash-safe HSM provider, then the
> question becomes:
> How would we extend this to multiple crash-safe HSM providers in the future?

Something like:

fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "dropbox,cloudsync,httpfs", 0)

means all of them are required to have a filesystem mark?
 
> Or maybe we do not need to support multiple HSM groups per sb?
> Maybe in the future a generic service could be implemented to
> delegate different HSM modules, e.g.:
> 
> fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "cloudsync", 0)
> fsconfig(ffd, FSCONFIG_SET_STRING, "hsmver", "1", 0)
> 
> And a generic "cloudsync" service could be in charge of
> registration of "cloudsync" engines and dispatching the pre-content
> event to the appropriate module based on path (i.e. under the dropbox folder).
> 
> Once this gets passed NACKs from fs developers I'd like to pull in
> some distro people to the discussion and maybe bring this up as
> a topic discussion for LSFMM if we feel that there is something to discuss.

I guess a short talk (lighting talk?) what we are planning to do would be
interesting so that people are aware. At this point I don't think we have
particular problems to discuss that would be interesting for the whole fs
crowd for a full slot...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

