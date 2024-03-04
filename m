Return-Path: <linux-fsdevel+bounces-13441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701086FF23
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 11:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19B5284E2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C424A00;
	Mon,  4 Mar 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IGIJWsF+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lVba81H0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IGIJWsF+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lVba81H0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6A1A29F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548429; cv=none; b=dtHR/2QQp25DWc/ofFqeAI3HpnBRF4nvmE6NgwtCdOK0qnagrYnUbfmVLQ6agGlM/el3C4P9NJtE2jGn+FD/NEZ6uk1v1KwkryabEjfFI3kUITnVJWKYLiBrHPzzgAuaV0Zp+nI4HPBE5t8qM/3NO1rwJ9ZNJsQ2pz/LQmpbd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548429; c=relaxed/simple;
	bh=UzH++0WtaNWpbQqe8rpNwAcOIP8jNGOHHQicuwg0e/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwlzoYU4ITXM6eid4OcclPJQxfDeCWPAt65xexr28L6zvTE57r6gnnnck/QwBhUUeyW9xi1tXBKoYhO1uYBa6K9WZ56AHsuKk1KWxmEA/Es5k5X//zUwrPWqYzJ1WKnTOynnbpfzLoJ9fdyDr0Cocp/Swosu/UZmCoA+qfZQ7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IGIJWsF+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lVba81H0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IGIJWsF+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lVba81H0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 565B075849;
	Mon,  4 Mar 2024 10:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709548422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoEbnwhUR/Ke4+eQLT5fjQ2ebfqFGf33nfeWyy5ToTU=;
	b=IGIJWsF+M1Ia2pG22mz3y1n9AvR9V0ELp/9sMRdVpOhZWvb1LjqqvuxMfsG9+BL8DGuYgo
	v0bguWeu1CHSUdpF42vFv//29zypTKQG53pA6dNYZuH/cXBO/9txqgRjxKcPgTBWfHVtfF
	92uaGUW4tPdhar1n14NgnEW1x9rtHYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709548422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoEbnwhUR/Ke4+eQLT5fjQ2ebfqFGf33nfeWyy5ToTU=;
	b=lVba81H0TD+TmXdGAJ2B3f4/sjHJofVUX2RTfmnWRWmp/KbkTZ5Uy1v293TnNR4F/rrv0/
	ZGgNPrhMqT1HhQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709548422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoEbnwhUR/Ke4+eQLT5fjQ2ebfqFGf33nfeWyy5ToTU=;
	b=IGIJWsF+M1Ia2pG22mz3y1n9AvR9V0ELp/9sMRdVpOhZWvb1LjqqvuxMfsG9+BL8DGuYgo
	v0bguWeu1CHSUdpF42vFv//29zypTKQG53pA6dNYZuH/cXBO/9txqgRjxKcPgTBWfHVtfF
	92uaGUW4tPdhar1n14NgnEW1x9rtHYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709548422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoEbnwhUR/Ke4+eQLT5fjQ2ebfqFGf33nfeWyy5ToTU=;
	b=lVba81H0TD+TmXdGAJ2B3f4/sjHJofVUX2RTfmnWRWmp/KbkTZ5Uy1v293TnNR4F/rrv0/
	ZGgNPrhMqT1HhQCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 49A4713419;
	Mon,  4 Mar 2024 10:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FGH1EYaj5WUXGwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 04 Mar 2024 10:33:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8667A07D6; Mon,  4 Mar 2024 11:33:37 +0100 (CET)
Date: Mon, 4 Mar 2024 11:33:37 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20240304103337.qdzkehmpj5gqrdcs@quack3>
References: <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3>
 <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3>
 <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3>
 <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
 <20240219110121.moeds3khqgnghuj2@quack3>
 <CAOQ4uxizF_=PK9N9A8i8Q_QhpXe7MNrfUTRwR5jCVzgfSBm1dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxizF_=PK9N9A8i8Q_QhpXe7MNrfUTRwR5jCVzgfSBm1dw@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IGIJWsF+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lVba81H0
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 565B075849
X-Spam-Flag: NO

On Tue 27-02-24 21:42:37, Amir Goldstein wrote:
> On Mon, Feb 19, 2024 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 15-02-24 17:40:07, Amir Goldstein wrote:
> > > > > Last time we discussed this the conclusion was an API of a group-less
> > > > > default mask, for example:
> > > > >
> > > > > 1. fanotify_mark(FAN_GROUP_DEFAULT,
> > > > >                            FAN_MARK_ADD | FAN_MARK_MOUNT,
> > > > >                            FAN_PRE_ACCESS, AT_FDCWD, path);
> > > > > 2. this returns -EPERM for access until some group handles FAN_PRE_ACCESS
> > > > > 3. then HSM is started and subscribes to FAN_PRE_ACCESS
> > > > > 4. and then the mount is moved or bind mounted into a path exported to users
> > > >
> > > > Yes, this was the process I was talking about.
> > > >
> > > > > It is a simple solution that should be easy to implement.
> > > > > But it does not involve "register the HSM app with the filesystem",
> > > > > unless you mean that a process that opens an HSM group
> > > > > (FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
> > > > > be given FMODE_NONOTIFY files?
> > > >
> > > > Two ideas: What you describe above seems like what the new mount API was
> > > > intended for? What if we introduced something like an "hsm" mount option
> > > > which would basically enable calling into pre-content event handlers
> > >
> > > I like that.
> > > I forgot that with my suggestion we'd need a path to setup
> > > the default mask.
> > >
> > > > (for sb without this flag handlers wouldn't be called and you cannot place
> > > > pre-content marks on such sb).
> > >
> > > IMO, that limitation (i.e. inside brackets) is too restrictive.
> > > In many cases, the user running HSM may not have control over the
> > > mount of the filesystem (inside containers?).
> > > It is true that HSM without anti-crash protection is less reliable,
> > > but I think that it is still useful enough that users will want the
> > > option to run it (?).
> > >
> > > Think of my HttpDirFS demo - it's just a simple lazy mirroring
> > > of a website. Even with low reliability I think it is useful (?).
> >
> > Yeah, ok, makes sense. But for such "unpriviledged" usecases we don't have
> > a deadlock-free way to fill in the file contents because that requires a
> > special mountpoint?
> 
> True, unless we also keep the FMODE_NONOTIFY event->fd
> for the simple cases. I'll need to think about this some more.

Well, but even creating new fds with FMODE_NONOTIFY or setting up fanotify
group with HSM events need to be somehow priviledged operation (currently
it requires CAP_SYS_ADMIN). So the more I think about it the less obvious
the "unpriviledged" usecase seems to be.

> > > > These handlers would return EACCESS unless
> > > > there's somebody handling events and returning something else.
> > > >
> > > > You could then do:
> > > >
> > > > fan_fd = fanotify_init()
> > > > ffd = fsopen()
> > > > fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
> > > > fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
> > > > rootfd = fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
> > > > fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
> > > > <now you can move the superblock into the mount hierarchy>
> > >
> > > Not too bad.
> > > I think that "hsm_deny_mask=" mount options would give more flexibility,
> > > but I could be convinced otherwise.
> > >
> > > It's probably not a great idea to be running two different HSMs on the same
> > > fs anyway, but if user has an old HSM version installed that handles only
> > > pre-content events, I don't think that we want this old version if it happens
> > > to be run by mistake, to allow for unsupervised create,rename,delete if the
> > > admin wanted to atomically mount a fs that SHOULD be supervised by a
> > > v2 HSM that knows how to handle pre-path events.
> > >
> > > IOW, and "HSM bit" on sb is too broad IMO.
> >
> > OK. So "hsm_deny_mask=" would esentially express events that we require HSM
> > to handle, the rest would just be accepted by default. That makes sense.
> 
> Yes.
> 
> > The only thing I kind of dislike is that this ties fanotify API with mount
> > API. So perhaps hsm_deny_mask should be specified as a string? Like
> > preaccess,premodify,prelookup,... and transformed into a bitmask only
> > inside the kernel? It gives us more maneuvering space for the future.
> >
> 
> Urgh. I see what you are saying, but this seems so ugly to me.
> I have a strong feeling that we are trying to reinvent something
> and that we are going to reinvent it badly.
> I need to look for precedents, maybe in other OS.
> I believe that in Windows, there is an API to register as a
> Cloud Engine Provider, so there is probably a way to have multiple HSMs
> working on different sections of the filesystem in some reliable
> crash safe manner.

OK, let's see what other's have came up with :)

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

