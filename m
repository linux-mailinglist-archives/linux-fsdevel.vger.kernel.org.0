Return-Path: <linux-fsdevel+bounces-11698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4785622F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 12:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548B41F23474
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF97484;
	Thu, 15 Feb 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="deBTGlSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ab4KqGAa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bfDeuAld";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BsNiUcf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039512B146
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997913; cv=none; b=WmwvUdmelIqI9KP7UX3lGspi9yAvR1hB5ApQ1bE/zGiqTEsZgRvH+PtWukc2Yz4Rj1MU7O2iE6jFOWAl4WkKEWE1Uhh+cFQRGlkbyU/nFBeiqd0Dg4VwreqMWUtPo+UgtmDp6dx1GyYpHoKNVenxtTMoOCH06NcNen8H3OB0qu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997913; c=relaxed/simple;
	bh=hqER2tH3AsAd1goEhLW/MH/JM0hCvUyLetjlSqDVg+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDhinhA9FkU16w9ByjLaiOAMjQFipmTdYqORVBKBD3mPPeCFw1t9aHlrVHmLIdRtWGbvDr90UxuS6TlOLm5UyXfqqhH2UwbpPskwfDaq1qbaIW4DL7wDObCR0ab6PMWMeGlrjCJcS+ML7bPbeMyqdjDg6IDZF/3sc7vyGTSLBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=deBTGlSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ab4KqGAa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bfDeuAld; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BsNiUcf9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E50E71F88E;
	Thu, 15 Feb 2024 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707997908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wni3JQkxvXhfGHIFRzZk3Er78qECEuznwQfbp6l6lRk=;
	b=deBTGlSknIowcwMlqIFQCBHKQrNARhF0Q93V/gePdgHD5SYerg0tqNsgXNIzzTZxv2LiAS
	5iT159n/Qs6WKStnQ5e72qynS8U1THcapmjG3nKnEhR9A3fgCfqzTpjWoWG7mTzr02AcBG
	yFybnOGdYLnV2XtvMwESPsmwOxylNHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707997908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wni3JQkxvXhfGHIFRzZk3Er78qECEuznwQfbp6l6lRk=;
	b=Ab4KqGAaQbldhNd9akH/Z4STeTgmYcUZPNLtY/hIM4Gb8ayRJOP12a8mg25ykYUc6A6O/D
	mvINqViS5QkbRVDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707997907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wni3JQkxvXhfGHIFRzZk3Er78qECEuznwQfbp6l6lRk=;
	b=bfDeuAld11Jq1g3Ft5Y0RmnzLZUhkY4rEcvsd/GhTSYU4qekgw4JI6JkR7ZcY8ngI48ug9
	mbGQen1mY94D0DHACRkm3tbNv11G5kyEpiP41Nzh6mkR/9N1cjFeRODB1axNwIsR7gnmW8
	XnxphVPpfTDM5c0b1qN9QJAuT5M2kJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707997907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wni3JQkxvXhfGHIFRzZk3Er78qECEuznwQfbp6l6lRk=;
	b=BsNiUcf9+bfhIj/NdFBrRpWBhOSE7dQw4tlrZbFOZ9WQV+hb9eEb3dgg7HJpedfZ77DZWI
	SaNt+je5FKcAv2Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D9D4C1346A;
	Thu, 15 Feb 2024 11:51:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fREoNdP6zWU6BgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 11:51:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 871D1A0809; Thu, 15 Feb 2024 12:51:39 +0100 (CET)
Date: Thu, 15 Feb 2024 12:51:39 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20240215115139.rq6resdfgqiezw4t@quack3>
References: <20231218143504.abj3h6vxtwlwsozx@quack3>
 <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3>
 <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3>
 <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3>
 <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 12-02-24 16:56:28, Amir Goldstein wrote:
> On Mon, Feb 12, 2024 at 2:01 PM Jan Kara <jack@suse.cz> wrote:
> > On Thu 08-02-24 21:21:13, Amir Goldstein wrote:
> > > On Thu, Feb 8, 2024 at 8:31 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Thu 08-02-24 16:04:29, Amir Goldstein wrote:
> > > > > > > On Mon 29-01-24 20:30:34, Amir Goldstein wrote:
> > > > > > > > On Mon, Dec 18, 2023 at 5:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > > > > In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
> > > > > > > > > to deny open of file during the short time that it's content is being
> > > > > > > > > punched out.
> > > > > > > > > It is quite complicated to explain, but I only used it for denying access,
> > > > > > > > > not to fill content and not to write anything to filesystem.
> > > > > > > > > It's worth noting that returning EBUSY in that case would be more meaningful
> > > > > > > > > to users.
> > > > > > > > >
> > > > > > > > > That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPEN_PERM,
> > > > > > > > > but mainly I do not have a proof that people will not need it.
> > > > > > > > >
> > > > > > > > > OTOH, I am a bit concerned that this will encourage developer to use
> > > > > > > > > FAN_OPEN_PERM as a trigger to filling file content and then we are back to
> > > > > > > > > deadlock risk zone.
> > > > > > > > >
> > > > > > > > > Not sure which way to go.
> > > > > > > > >
> > > > > > > > > Anyway, I think we agree that there is no reason to merge FAN_DENY_ERRNO
> > > > > > > > > before FAN_PRE_* events, so we can continue this discussion later when
> > > > > > > > > I post FAN_PRE_* patches - not for this cycle.
> > > > > > > >
> > > > > > > > I started to prepare the pre-content events patches for posting and got back
> > > > > > > > to this one as well.
> > > > > > > >
> > > > > > > > Since we had this discussion I have learned of another use case that
> > > > > > > > requires filling file content in FAN_OPEN_PERM hook, FAN_OPEN_EXEC_PERM
> > > > > > > > to be exact.
> > > > > > > >
> > > > > > > > The reason is that unless an executable content is filled at execve() time,
> > > > > > > > there is no other opportunity to fill its content without getting -ETXTBSY.
> > > > > > >
> > > > > > > Yes, I've been scratching my head over this usecase for a few days. I was
> > > > > > > thinking whether we could somehow fill in executable (and executed) files on
> > > > > > > access but it all seemed too hacky so I agree that we probably have to fill
> > > > > > > them in on open.
> > > > > > >
> > > > > >
> > > > > > Normally, I think there will not be a really huge executable(?)
> > > > > > If there were huge executables, they would have likely been broken down
> > > > > > into smaller loadable libraries which should allow more granular
> > > > > > content filling,
> > > > > > but I guess there will always be worst case exceptions.
> > > > > >
> > > > > > > > So to keep things more flexible, I decided to add -ETXTBSY to the
> > > > > > > > allowed errors with FAN_DENY_ERRNO() and to decided to allow
> > > > > > > > FAN_DENY_ERRNO() with all permission events.
> > > > > > > >
> > > > > > > > To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
> > > > > > > > added a limitation that FAN_DENY_ERRNO() is allowed only for
> > > > > > > > FAN_CLASS_PRE_CONTENT groups.
> > > > > > >
> > > > > > > I have no problem with adding -ETXTBSY to the set of allowed errors. That
> > > > > > > makes sense. Adding FAN_DENY_ERRNO() to all permission events in
> > > > > > > FAN_CLASS_PRE_CONTENT groups - OK,
> > > > > >
> > > > > > done that.
> > > > > >
> > > > > > I am still not very happy about FAN_OPEN_PERM being part of HSM
> > > > > > event family when I know that O_TRUCT and O_CREAT call this hook
> > > > > > with sb writers held.
> > > > > >
> > > > > > The irony, is that there is no chance that O_TRUNC will require filling
> > > > > > content, same if the file is actually being created by O_CREAT, so the
> > > > > > cases where sb writers is actually needed and the case where content
> > > > > > filling is needed do not overlap, but I cannot figure out how to get those
> > > > > > cases out of the HSM risk zone. Ideas?
> > > > > >
> > > > >
> > > > > Jan,
> > > > >
> > > > > I wanted to run an idea by you.
> > > > >
> > > > > I like your idea to start a clean slate with
> > > > > FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
> > > > > and it would be nice if we could restrict this HSM to use
> > > > > pre-content events, which is why I was not happy about allowing
> > > > > FAN_DENY_ERRNO() for the legacy FAN_OPEN*_PERM events,
> > > > > especially with the known deadlocks.
> > > > >
> > > > > Since we already know that we need to generate
> > > > > FAN_PRE_ACCESS(offset,length) for read-only mmap() and
> > > > > FAN_PRE_MODIFY(offset,length) for writable mmap(),
> > > > > we could treat uselib() and execve() the same way and generate
> > > > > FAN_PRE_ACCESS(0,i_size) as if the file was mmaped.
> > > >
> > > > BTW uselib() is deprecated and there is a patch queued to not generate
> > > > OPEN_EXEC events for it because it was causing problems (not the generation
> > > > of events itself but the FMODE_EXEC bit being set in uselib). So I don't
> > > > think we need to instrument uselib().
> > > >
> > >
> > > Great. The fewer the better :)
> > >
> > > BTW, for mmap, I was thinking of adding fsnotify_file_perm() next to
> > > call sites of security_mmap_file(), but I see that:
> > > 1. shmat() has security_mmap_file() - is it relevant?
> >
> > Well, this is effectively mmap(2) of a tmpfs file. So I don't think this is
> > particularly useful for HSM purposes but we should probably have it for
> > consistency?
> 
> OK.
> 
> Actually, I think there is a use case for tmpfs + HSM. HSM is about
> lazy populating of a local filesystem from a remote slower tier.
> The fast local tier could be persistent, but could just as well be tmpfs,
> for a temporary lazy local mirror.
> 
> This use case reminds overlayfs a bit, where the local tier is the upper fs,
> but in case of HSM, the "copy up" happens also on read.
> 
> I do want to limit HSM to "fully featured local fs", so we do not end up
> with crazy fs doing HSM. The very minimum should be decodable
> file handle support and unique fsid, but we could also think of more strict
> requirements(?). Anyway, tmpfs should meet all the "fully featured local fs"
> requirement.

Ok, makes sense.

> > > > > I've already pushed a POC to fan_pre_content branch [1].
> > > > > Only sanity tested that nothing else is broken.
> > > > > I still need to add the mmap hooks and test the new events.
> > > > >
> > > > > With this, HSM will have appropriate hooks to fill executable
> > > > > and library on first access and also fill arbitrary files on open
> > > > > including the knowledge if the file was opened for write.
> > > > >
> > > > > Thoughts?
> > > >
> > > > Yeah, I guess this looks sensible.
> > >
> > > Cool, so let's see, what is left to do for the plan of
> > > FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID?
> > >
> > > 1. event->fd is O_PATH mount_fd for open_by_handle_at()
> > > 2. open_by_handle_at() inherits FMODE_NONOTIFY from mount_fd
> > > 3. either implement the FAN_CLOSE_FD response flag (easy?) and/or
> > >     implement FAN_REPORT_EVENT_ID and new header format
> > >
> > > Anything else?
> > > Are you ok with 1 and 2?
> >
> > I'm not sure about 1) and 2) so I'm mostly thinking out loud now. AFAIU you
> > want to provide mount_fd only because of FMODE_NONOTIFY inheritance so 2)
> > is the key question. But if you provide mount_fd with FMODE_NONOTIFY and
> > have FMODE_NONOTIFY inheritance, then what's the difference to just allow
> > opens with FMODE_NONOTIFY from the start? I don't think restricting
> > FMODE_NONOTIFY to inheritance gives any additional strong security
> > guarantees?
> >
> 
> You are right.
> Just need to think of the right API.
> It is just very convenient to be getting the FMODE_NONOTIFY from
> fanotify, but let's think about it.
> 
> > I understand so far we didn't expose FMODE_NONOTIFY so that people cannot
> > bypass fanotify permission events. But now we need a sensible way to fill
> > in the filesystem without deadlocking on our own watches. Maybe exposing
> > FMODE_NONOTIFY as an open flag is too attractive for misuse so could be
> > somehow tie it to the HSM app? We were already discussing that we need to
> > somehow register the HSM app with the filesystem to avoid issues when the
> > app crashes or so. So maybe we could tie this registration to the ability
> > of bypassing generation of notification?
> >
> 
> Last time we discussed this the conclusion was an API of a group-less
> default mask, for example:
> 
> 1. fanotify_mark(FAN_GROUP_DEFAULT,
>                            FAN_MARK_ADD | FAN_MARK_MOUNT,
>                            FAN_PRE_ACCESS, AT_FDCWD, path);
> 2. this returns -EPERM for access until some group handles FAN_PRE_ACCESS
> 3. then HSM is started and subscribes to FAN_PRE_ACCESS
> 4. and then the mount is moved or bind mounted into a path exported to users

Yes, this was the process I was talking about.
 
> It is a simple solution that should be easy to implement.
> But it does not involve "register the HSM app with the filesystem",
> unless you mean that a process that opens an HSM group
> (FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
> be given FMODE_NONOTIFY files?

Two ideas: What you describe above seems like what the new mount API was
intended for? What if we introduced something like an "hsm" mount option
which would basically enable calling into pre-content event handlers
(for sb without this flag handlers wouldn't be called and you cannot place
pre-content marks on such sb). These handlers would return EACCESS unless
there's somebody handling events and returning something else.

You could then do:

fan_fd = fanotify_init()
ffd = fsopen()
fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
rootfd = fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
<now you can move the superblock into the mount hierarchy>

This would elegantly solve the "what if HSM handler dies" problem as well
as cleanly handle the setup. And we don't have to come up with a concept of
"default mask". Now we still have the problem how to fill in the filesystem
on pre-content event without deadlocking. As I was thinking about it the
most elegant solution would IMHO be if the HSM handler could have a private
mount flagged so that HSM is excluded from there (or it could place ignore
mark on this mount for HSM events). I think we've discarded similar ideas
in the past because this is problematic with directory pre-content events
because security hooks don't get the mountpoint. But what if we used
security_path_* hooks for directory pre-content events?

> There is one more crazy idea that I was pondering -
> what if we used the fanotify_fd as mount_fd arg to open_by_handle_at()?
> The framing is that it is not the filesystem, but fanotify which actually
> encoded the fsid+fid, so HSM could be asking fanotify to decode them.
> Technically, the group could keep a unique map from fsid -> sb, then
> fanotify group could decode an fanotify_event_info_fid buffer to a specific
> inode on a specific fs.
> Naturally, those decoded files would be FMODE_NONOTIFY.
> 
> Too crazy?

It sounds a bit complex and hooking into open_by_handle_at() code for this
sounds a bit hacky. But I'm not completely rejecting this possibility if we
don't find other options.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

