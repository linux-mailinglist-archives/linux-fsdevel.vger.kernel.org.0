Return-Path: <linux-fsdevel+bounces-11992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D185A18E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A899A1F244D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2112C1B1;
	Mon, 19 Feb 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T31ls3Hd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="303SokyO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHRIqPc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PnMHBPCy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C128E09
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340485; cv=none; b=nHk7f5zYdLmIjf37glvOTHqff/kneUT85hk5jDn/UHBKaXc1GvdVMU4XeZV733KvlSI+VzbjCfxx5YF4OWbojeKyeroVigv9ux0K0AJi7hDuJ1Zrkm1RXgbd4eKnxm8eIT1s7M33Cmcenj1Ps5oQiZPuH79YxvAOpItjXKHrpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340485; c=relaxed/simple;
	bh=VzQf8LkzTrza63Z0r29uK9NxHXCnKE/BIt2puOBiMCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mssk5XEoEDWcpK2TVWD8uNcHXaQw4Cz15UaiugkTMLWYaDSvMfVi6kE/z6MhL6GGx4EwGWt9muN0IxBbLRGZhFpHb7XXA7NS299iHpfexoDdUSXQ9ZOlCYuV2UJvkJPyByB13PX3rj+mdJ2h0N4o/np5tjQPNVkSPKN3CtkUTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T31ls3Hd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=303SokyO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHRIqPc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PnMHBPCy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9FA722162;
	Mon, 19 Feb 2024 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708340482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qdPL8UHt9eZorZ24/fz6Y7RZ4Va1aG4L+yZV2OZj5s=;
	b=T31ls3HdcvcvwW+ZQnpkuiRLd3ggArHyn7HezyFS5/MCV2/+GLUKp3Um7Fzqaw9MUbYO6Z
	yxDsyWsSbTZqypXqhMSpo+FCpOVvA/hqtDeiWHEb2MgeUbFWk3HDqSC6VyXpqcHiGUxn5z
	/APK9HSgiX8woKTlgi6kFvLN+TNdO4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708340482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qdPL8UHt9eZorZ24/fz6Y7RZ4Va1aG4L+yZV2OZj5s=;
	b=303SokyOIlpr8Zblty0rsRIZCJGqUjHgwXDT8j1jjyAng+YVyj1D+xdV2jP2x/kZUtelMY
	fIGHDTa68W5mjtAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708340481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qdPL8UHt9eZorZ24/fz6Y7RZ4Va1aG4L+yZV2OZj5s=;
	b=gHRIqPc4B6KnlFAgyaLrle4YVYzUKt4bkfDcPFrHJQPy892cgnQotH8jqpElPO5Az4TOnh
	3EmsAX7rOZ/8wXSRvJzuNqtft7/bHOZkkYcCmU4JUhU4U9qMdQ+1zSXPbq+cuKKooafFHr
	b0pYT5VYH5eMhzy4PJCv+3KDPMUJQVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708340481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qdPL8UHt9eZorZ24/fz6Y7RZ4Va1aG4L+yZV2OZj5s=;
	b=PnMHBPCy3nWvquVz4vPJC/85XH61uMdqI4pJflAVYcC5w3fn1EWEjeJ5AR+H8AZwJdCQHt
	fXycbHFv+aRb2PDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DEF79139C6;
	Mon, 19 Feb 2024 11:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +OBqNgE102XZYwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:01:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A0F0A0806; Mon, 19 Feb 2024 12:01:21 +0100 (CET)
Date: Mon, 19 Feb 2024 12:01:21 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20240219110121.moeds3khqgnghuj2@quack3>
References: <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3>
 <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3>
 <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3>
 <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3>
 <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gHRIqPc4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PnMHBPCy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: E9FA722162
X-Spam-Flag: NO

On Thu 15-02-24 17:40:07, Amir Goldstein wrote:
> > > Last time we discussed this the conclusion was an API of a group-less
> > > default mask, for example:
> > >
> > > 1. fanotify_mark(FAN_GROUP_DEFAULT,
> > >                            FAN_MARK_ADD | FAN_MARK_MOUNT,
> > >                            FAN_PRE_ACCESS, AT_FDCWD, path);
> > > 2. this returns -EPERM for access until some group handles FAN_PRE_ACCESS
> > > 3. then HSM is started and subscribes to FAN_PRE_ACCESS
> > > 4. and then the mount is moved or bind mounted into a path exported to users
> >
> > Yes, this was the process I was talking about.
> >
> > > It is a simple solution that should be easy to implement.
> > > But it does not involve "register the HSM app with the filesystem",
> > > unless you mean that a process that opens an HSM group
> > > (FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
> > > be given FMODE_NONOTIFY files?
> >
> > Two ideas: What you describe above seems like what the new mount API was
> > intended for? What if we introduced something like an "hsm" mount option
> > which would basically enable calling into pre-content event handlers
> 
> I like that.
> I forgot that with my suggestion we'd need a path to setup
> the default mask.
> 
> > (for sb without this flag handlers wouldn't be called and you cannot place
> > pre-content marks on such sb).
> 
> IMO, that limitation (i.e. inside brackets) is too restrictive.
> In many cases, the user running HSM may not have control over the
> mount of the filesystem (inside containers?).
> It is true that HSM without anti-crash protection is less reliable,
> but I think that it is still useful enough that users will want the
> option to run it (?).
> 
> Think of my HttpDirFS demo - it's just a simple lazy mirroring
> of a website. Even with low reliability I think it is useful (?).

Yeah, ok, makes sense. But for such "unpriviledged" usecases we don't have
a deadlock-free way to fill in the file contents because that requires a
special mountpoint?

> > These handlers would return EACCESS unless
> > there's somebody handling events and returning something else.
> >
> > You could then do:
> >
> > fan_fd = fanotify_init()
> > ffd = fsopen()
> > fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
> > fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
> > rootfd = fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
> > fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
> > <now you can move the superblock into the mount hierarchy>
> 
> Not too bad.
> I think that "hsm_deny_mask=" mount options would give more flexibility,
> but I could be convinced otherwise.
> 
> It's probably not a great idea to be running two different HSMs on the same
> fs anyway, but if user has an old HSM version installed that handles only
> pre-content events, I don't think that we want this old version if it happens
> to be run by mistake, to allow for unsupervised create,rename,delete if the
> admin wanted to atomically mount a fs that SHOULD be supervised by a
> v2 HSM that knows how to handle pre-path events.
> 
> IOW, and "HSM bit" on sb is too broad IMO.

OK. So "hsm_deny_mask=" would esentially express events that we require HSM
to handle, the rest would just be accepted by default. That makes sense.
The only thing I kind of dislike is that this ties fanotify API with mount
API. So perhaps hsm_deny_mask should be specified as a string? Like
preaccess,premodify,prelookup,... and transformed into a bitmask only
inside the kernel? It gives us more maneuvering space for the future.

> > This would elegantly solve the "what if HSM handler dies" problem as well
> > as cleanly handle the setup. And we don't have to come up with a concept of
> > "default mask".
> 
> We can still have a mask, it's just about the API to set it up.
> 
> > Now we still have the problem how to fill in the filesystem
> > on pre-content event without deadlocking. As I was thinking about it the
> > most elegant solution would IMHO be if the HSM handler could have a private
> > mount flagged so that HSM is excluded from there (or it could place ignore
> > mark on this mount for HSM events).
> 
> My HttpDirFS demo does it the other way around - HSM uses a mount
> without a mark mount - but ignore mark works too.

Yes, the HSM handler is free to setup whatever works for it. I was just
thinking to make sure there is at least one sane way how to do it :)

> > I think we've discarded similar ideas
> > in the past because this is problematic with directory pre-content events
> > because security hooks don't get the mountpoint. But what if we used
> > security_path_* hooks for directory pre-content events?
> 
> No need for security_path_ * hooks.
> In my POC, the pre-path hooks have the path argument.
> For people who are not familiar with the term, here is man page draft
> for "pre-path" events:
> https://github.com/amir73il/man-pages/commits/fan_pre_path/
> 
> This is an out of date branch from the time that I called them
> FAN_PRE_{CREATE,DELETE,MOVE_*} events:
> https://github.com/amir73il/linux/commit/29c60e4db3068ff2cd7b2c5a73108afb2c19b868
> 
> They are implemented by replacing the mnt_want_write() calls
> with mnt_want_write_{path,parent,parents}() calls.
> 
> This was done to make sure that they take the sb write srcu and call
> the pre-path hook before taking sb writers freeze protection.

Ok, so AFAIU you agree we don't need to rely on FMODE_NONOTIFY for HSM and
can just use access through dedicated mount for filling in the filesystem?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

