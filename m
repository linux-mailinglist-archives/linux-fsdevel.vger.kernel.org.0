Return-Path: <linux-fsdevel+bounces-10466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F13F84B6E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B645D288B43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733013172E;
	Tue,  6 Feb 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E7+byQ/S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+L2PyURB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E7+byQ/S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+L2PyURB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0B130E46
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227432; cv=none; b=ofA2Hw/2Fv0kmgLZ1tn/TmzEa36/cd1N+GIt+9JExeed1+cY3Chm453AvXayMI3EqWq6GOfO1vPYWnYWEBjeZ9phtu9Gq+ycFpYb8g+dgkUQLDIMWcKPgz80R8ksL7EBNcEXDE6dexgGe+EJzke/KSSqKdYIOJenkExgSe5cQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227432; c=relaxed/simple;
	bh=nzjL7zRZhdr172M4l7mBNyjHgF+Zwgl1xM/hpG1rAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE2H1m4pU3xTVIhF1UQJj2YxzmPIDKegVjYXOa3B07ZWqQYUfCZF34v4ZPtk3mhD+KPfn2NYZy+wY9JLQL/xt2Fzc9NogvQmdKxg0hl6aUvpqSF69y4O8a3Eyc0sddX4Izm7uDMRkH58sPSQiYyajoLGKkXIobuUITTWWKm/u5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E7+byQ/S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+L2PyURB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E7+byQ/S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+L2PyURB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 092701F8C3;
	Tue,  6 Feb 2024 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ix2jMXinGf3zXg6UX0L/iqnDxkA/4UmY82KZikfXlII=;
	b=E7+byQ/ShnZfXlpC/A9eEDU1htsjSQBA0LK5QlmxLwiuUiI0pfnlgRQWsPV+0pENd5BO7x
	KFFTC0maT5ui7XR9UisPd7ixT5Go4v2H4Fse94MA1JE/NAxzi0+tx+M5C7I0EMuyz6Yvtq
	fjkKDVK48ANuIZlcUTqx0TSp70Rploc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ix2jMXinGf3zXg6UX0L/iqnDxkA/4UmY82KZikfXlII=;
	b=+L2PyURB443PI/4OFwvCuO2XfPMh8UEU51x2bgbqy5YBeElfUIITHyN4O+LJr9Z/nV3vF8
	B72+oTZ1+3S0DcBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ix2jMXinGf3zXg6UX0L/iqnDxkA/4UmY82KZikfXlII=;
	b=E7+byQ/ShnZfXlpC/A9eEDU1htsjSQBA0LK5QlmxLwiuUiI0pfnlgRQWsPV+0pENd5BO7x
	KFFTC0maT5ui7XR9UisPd7ixT5Go4v2H4Fse94MA1JE/NAxzi0+tx+M5C7I0EMuyz6Yvtq
	fjkKDVK48ANuIZlcUTqx0TSp70Rploc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ix2jMXinGf3zXg6UX0L/iqnDxkA/4UmY82KZikfXlII=;
	b=+L2PyURB443PI/4OFwvCuO2XfPMh8UEU51x2bgbqy5YBeElfUIITHyN4O+LJr9Z/nV3vF8
	B72+oTZ1+3S0DcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0CB8132DD;
	Tue,  6 Feb 2024 13:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BLDFOiQ5wmUNRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Feb 2024 13:50:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98F01A0809; Tue,  6 Feb 2024 14:50:28 +0100 (CET)
Date: Tue, 6 Feb 2024 14:50:28 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sargun Dhillon <sargun@sargun.me>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	Sweet Tea Dorminy <thesweettea@meta.com>, Jan Kara <jack@suse.cz>
Subject: Re: Fanotify: concurrent work and handling files being executed
Message-ID: <20240206135028.q56y6stckqnfwlbg@quack3>
References: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
 <CAOQ4uxgPY_6oKZFmWitJ-FTuV1YUWHMcNqppiCiMMk46aURMUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgPY_6oKZFmWitJ-FTuV1YUWHMcNqppiCiMMk46aURMUA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 06-02-24 09:44:29, Amir Goldstein wrote:
> On Tue, Feb 6, 2024 at 1:24 AM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > One of the issues we've hit recently while using fanotify in an HSM is
> > racing with files that are opened for execution.
> >
> > There is a race that can result in ETXTBUSY.
> > Pid 1: You have a file marked with FAN_OPEN_EXEC_PERM.
> > Pid 2: execve(file_by_path)
> > Pid 1: gets notification, with file.fd
> > Pid 2: blocked, waiting for notification to resolve
> > Pid 1: Does work with FD (populates the file)
> > Pid 1: writes FAN_ALLOW to the fanotify file descriptor allowing the event.
> > Pid 2: continues, and falls through to deny_write_access (and fails)
> > Pid 1: closes fd

Right, this is kind of nasty.

> > Pid 1 can close the FD before responding, but this can result in a
> > race if fanotify is being handled in a multi-threaded
> > manner.

Yep.

> > I.e. if there are two threads operating on the same fanotify group,
> > and an event's FD has been closed, that can be reused
> > by another event. This is largely not a problem because the
> > outstanding events are added in a FIFO manner to the outstanding
> > event list, and as long as the earlier event is closed and responded
> > to without interruption, it should be okay, but it's difficult
> > to guarantee that this happens, unless event responses are serialized
> > in some fashion, with strict ordering between
> > responses.

Yes, essentially you must make sure you will not read any new events from
the notification queue between fd close & writing of the response. Frankly,
I find this as quite ugly and asking for trouble (subtle bugs down the
line).

> > There are a couple of ways I see around this:
> > 1. Have a flag in the fanotify response that's like FAN_CLOSE_FD,
> > where fanotify_write closes the fd when
> > it processes the response.
> 
> That seems doable and useful.
> 
> > 2. Make the response identifier separate from the FD. This can either
> > be an IDR / xarray, or a 64-bit always
> > incrementing number. The benefit of using an xarray is that responses
> > can than be handled in O(1) speed
> > whereas the current implementation is O(n) in relationship to the
> > number of outstanding events.
> 
> The number of outstanding permission events is usually limited
> by the number of events that are handled concurrently.
> 
> I think that a 64-bit event id is a worthy addition to a well designed
> notifications API. I am pretty sure that both Windows and MacOS
> filesystem notification events have a 64-bit event id.

I agree that having 64-bit id in an event and just increment it with each
event would be simple and fine way to identify events. This could then be
used to match responses to events when we would be reporting permission
events for FID groups as I outlined in my email yesterday [1].

> If we ever implement filesystem support for persistent change
> notification journals (as in Windows), those ids would be essential.

How do you want to use it for persistent change journal? I'm mostly asking
because currently I expect the number to start from 0 for each fsnotify
group created but if you'd like to persist somewhere the event id, this
would not be ideal?

> > This can be implemented by adding an additional piece of response
> > metadata, and then that becomes the
> > key vs. fd on response.
> > ---
> >
> > An aside, ETXTBUSY / i_writecount is a real bummer. We want to be able
> > to populate file content lazily,
> > and I realize there are many steps between removing the write lock,
> > and being able to do this, but given
> > that you can achieve this with FUSE, NFS, EROFS / cachefilesd, it
> > feels somewhat arbitrary to continue
> > to have this in place for executable files only.
> 
> I think there are way too many security models built around this
> behavior to be able to change it for the common case.
> 
> However, I will note that technically, the filesystem does not
> need to require a file open for write to fill its content as long as the
> file content is written directly to disk and as long as page cache
> is not populated in that region and invalidate_lock is held.

I was thinking about this as well and as you say, technically there is no
problem with this - just bypass writer the checks when opening the file -
but I think it just gives userspace too much rope to hang itself on. So if
we are going to support something like this it will require very careful
API design and wider consensus among VFS people this is something we are
willing to support.

> Requiring FMODE_WRITE for btrfs_ioctl_encoded_write()
> may make sense, but it is not a must.
> A more fine grained page cache protection approach is also
> an option, a bit like (or exactly like) exported pNFS layouts.
> 
> IOW, you could potentially implement lazy filling of executable
> content with specific file systems that support an out of band
> file filling API, but then we would also need notifications for
> page faults, so let's leave that for the far future.

That's another good point that currently we don't generate fsnotify events
on page faults. For lazy filling of executables this is basically must-have
functionality and I'd say that even for lazy filling of other files,
handling notifications on page faults will come up sooner rather than
later. So this is probably the thing we'll have to handle first.

								Honza

[1] https://lore.kernel.org/all/20240205182718.lvtgfsxcd6htbqyy@quack3
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

