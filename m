Return-Path: <linux-fsdevel+bounces-45464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56062A7807A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736C716E8E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F0E1F0999;
	Tue,  1 Apr 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZbNLVAH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5cqpsem";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZbNLVAH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5cqpsem"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AE1C860D
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524900; cv=none; b=Qs/TmD5DzABv9cOkZnxV62/WApZOfgZWbSuZTdhfDd9wV1T2gUfFXkYxtGsfeFkh/MMqVTOyQf7h49jCJvFK4IMVKwJMZPF3vd/+xRv02drUMalfEbtyDE5Lu57lVZggpVSO7LcmMv3y8TYF8lc4x180bZzA85HZYkw1WVVYJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524900; c=relaxed/simple;
	bh=CKYm0K2P3+6ykGgvAiYAydVtKHtnC76mvqosnOhELv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIEqlD7hGPb4QN3+X/ApxyDbYvzxHnP0GiF3tfkdeEUyccdbdM2hJWIrfdlN46FVS48FNrPr7eO5I34TTa10IiyYz39Ewr/5RS0ch28yRkTF5yVva2yHvllP6p0RaYylBDNEvyUKO1pNMV3cIXVZy/IicfW+Iwrt8STeCOy5fOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZbNLVAH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5cqpsem; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZbNLVAH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5cqpsem; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9365C1F38E;
	Tue,  1 Apr 2025 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743524896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/juDNwoFEMg0+fWK1VyGJlgykhrdui72/tKNmE9vqw=;
	b=SZbNLVAH1IjlYmrtzEzh/7dRJ/+M3wE2Q9xBsYSBOjkhtwi4tlEHhPZQkDR7fVoVwFpK4F
	0YIl7AJapIeFB+eMSGa373DyVnTnHiS1yX2TE4H87gxPc+jE9kqEeJqJhKQiJf5QGaJOOt
	S7ff8QUQ9ra6cLQxIGRIZ5T++Kvfau0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743524896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/juDNwoFEMg0+fWK1VyGJlgykhrdui72/tKNmE9vqw=;
	b=V5cqpsemmLkp8XaBaPRj7bZ0gFikaZ58kN1tVLciqu5z7CUX1M4SlDRWSj4IiLg4nIDoA+
	3q11KtTRUT1HQDBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743524896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/juDNwoFEMg0+fWK1VyGJlgykhrdui72/tKNmE9vqw=;
	b=SZbNLVAH1IjlYmrtzEzh/7dRJ/+M3wE2Q9xBsYSBOjkhtwi4tlEHhPZQkDR7fVoVwFpK4F
	0YIl7AJapIeFB+eMSGa373DyVnTnHiS1yX2TE4H87gxPc+jE9kqEeJqJhKQiJf5QGaJOOt
	S7ff8QUQ9ra6cLQxIGRIZ5T++Kvfau0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743524896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/juDNwoFEMg0+fWK1VyGJlgykhrdui72/tKNmE9vqw=;
	b=V5cqpsemmLkp8XaBaPRj7bZ0gFikaZ58kN1tVLciqu5z7CUX1M4SlDRWSj4IiLg4nIDoA+
	3q11KtTRUT1HQDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75555138A5;
	Tue,  1 Apr 2025 16:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f0SeHCAU7GfsDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Apr 2025 16:28:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C405A07E6; Tue,  1 Apr 2025 18:28:11 +0200 (CEST)
Date: Tue, 1 Apr 2025 18:28:11 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	Sargun Dhillon <sargun@meta.com>, Alexey Spiridonov <lesha@meta.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Reseting pending fanotify events
Message-ID: <6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr>
References: <BY1PR15MB61023E97919A597059EA473CC4AD2@BY1PR15MB6102.namprd15.prod.outlook.com>
 <CAOQ4uxihnLqagEX_PXA0pssQ=inPxSz-GDLcuJ9zs603LryKfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxihnLqagEX_PXA0pssQ=inPxSz-GDLcuJ9zs603LryKfw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 31-03-25 21:08:51, Amir Goldstein wrote:
> [CC Jan and Josef]

CCed fsdevel. Actually replying here because the quoting in Ibrahim's email
got somehow broken which made it very hard to understand.

> I am keeping this discussion private because you did not post it to
> the public list,
> but if you can CC fsdevel in your reply that would be great, because it seems
> like a question with interest to a wider audience.
> 
> On Mon, Mar 31, 2025 at 8:19 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> >
> > Hi Amir,
> >
> > We have been using fanotify to support lazily loading file contents.
> > We are struggling with the problem that pending permission events cannot be recovered on daemon restart.
> >
> > We have a long-lived daemon that marks files with FAN_OPEN_PERM and populates their contents on access.
> > It needs a reliable path for updates & crash recovery.
> > The happy path for fanotify event processing is as follows:
> >
> > A notification is read from fanotify file descriptor
> > File contents are populated
> > We write back FAN_ALLOW to fanotify file descriptor, or DENY if content population failed.
> >
> > We would like to guarantee that all file accesses receive an ALLOW or DENY response, and no events are lost.
> 
> Makes sense.
> 
> > Unfortunately, today a filesystem client can hang (in D state)
> > if the event-handler daemon crashes or restarts at the wrong time.
> 
> Can you provide exact stack traces for those cases?
> 
> I wonder how process gets to D state with commit fabf7f29b3e2
> ("fanotify: Use interruptible wait when waiting for permission events")

So D state is expected when waiting for response. We are using
TASK_UNINTERRUPTIBLE sleep (the above commit had to be effectively
reverted). But we are also setting TASK_KILLABLE and TASK_FREEZABLE so that
we don't block hibernation and tasks can be killed when fanotify listener
misbehaves.

But what confuses me is the following: You have fanotify instance to which
you've got fd from fanotify_init(). For any process to be hanging, this fd
must be still held open by some process. Otherwise the fanotify instance
gets destroyed and all processes are free to run (they get FAN_ALLOW reply
if they were already waiting). So the fact that you see processes hanging
when your fanotify listener crashes means that you have likely leaked the
fd to some other process (lsof should be able to tell you which process has
still handle to fanotify instance). And the kernel has no way to know this
is not the process that will eventually read these events and reply...

> > In this case, any events that have been read but not yet responded to would be lost.
> > Initially we considered handling this internally by saving the file descriptors for pending events,
> > however this proved to be complex to do in a robust manner.
> >
> > A more robust solution is to add a kernel fanotify api which resets the fanotify pending event queue,
> > thereby allowing us to recover pending events in the case of daemon restart.
> > A strawman implementation of this approach is in
> > https://github.com/torvalds/linux/compare/master...ibrahim-jirdeh:linux:fanotify-reset-pending,
> > a new ioctl that resets `group->fanotify_data.access_list`.
> > One other alternative we considered is directly exposing the pending event queue itself
> > (https://github.com/torvalds/linux/commit/cd90ff006fa2732d28ff6bb5975ca5351ce009f1)
> > to support monitoring pending events, but simply resetting the queue is likely sufficient for our use-case.
> >
> > What do you think of exposing this functionality in fanotify?
> >
> 
> Ignoring the pending events for start, how do you deal with access to
> non-populated files while the daemon is down?
> 
> We were throwing some idea about having a mount option (something
> like a "moderate" mount) to determine the default response for specific
> permission events (e.g. FAN_OPEN_PERM) in the case that there is
> no listener watching this event.
> 
> If you have a filesystem which may contain non-populated files, you
> mount it with as "moderated" mount and then access to all files is
> denied until the daemon is running and also denied if daemon is down.
> 
> For restart, it might make sense to start a new daemon to start listening
> to events before stopping the old daemon.
> If the new daemon gets the events before the old daemon, things should
> be able to transition smoothly.

I agree this would be a sensible protocol for updates. For unplanned crashes
I agree we need something like the "moderated" mount option.

> Of course, if an old daemon can shutdown and leave processes in
> uninterruptible sleep, that is a critical bug that needs to be fixed
> regardless of the handover problem.

If the fanotify fd got closed and the instance shutdown, this would be
indeed a serious bug (likely UAF issue). But so far I rather suspect the fd
is just in some fd table somewhere...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

