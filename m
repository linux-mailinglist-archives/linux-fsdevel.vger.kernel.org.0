Return-Path: <linux-fsdevel+bounces-45610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B539A79E17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5732D1893E2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB83241CA6;
	Thu,  3 Apr 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+eVwNuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6652417F8
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668727; cv=none; b=Ce0iQil0Z0uj4IMXHDw+KpAnGEg8QQlQtS26sn1N2xGwuVeZsK161HMKVnfhvN3Sma1wAbrALvgIbZk9vwGepHszkqI488N1scH/3sH7yoBNssUH8439TwuIry0xZIuHMkVdGwK5pRFW0ic6JFQCseEPkl986ETJ5tKsXKazhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668727; c=relaxed/simple;
	bh=gSLHv2L6jjrB0GwsmQpFBN0CROeUs1dmVNHWgLuNjLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/ODySeF3f1+AfS0yL+d81ikvsMfff4kP5uSaXyuElFlLWfP1Wu9nwjt15lc3pK4wY01gY8UYy+ZelwU68DdAjq+VS+ZJSaYxgwuYd93ZW0wwWSNNZvUnaMX0USv1T5mNeHfV9rwCG7uv3m+lNtYmWzp662a3yUcVa2Dxvf/FDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+eVwNuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76340C4CEE3;
	Thu,  3 Apr 2025 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743668727;
	bh=gSLHv2L6jjrB0GwsmQpFBN0CROeUs1dmVNHWgLuNjLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+eVwNuzPdaj4M3DAAppcrYQS7G8NcsDsrMPA0G68pUeBM6I438UIQjKHr/b4F+JQ
	 VZzVBf9afbuesynUthlRuIQKyWOHCAa8nE3wvtI5uj6yCM7/Y760ljKeYPgUafBgca
	 imNqXjCNaeyHVh6kjgdOqpGrZ552WJTUwRVXsUg8MPgqIXtp+CkAULCQe4EeMQuVAM
	 1Ab4CVTUssrjkRKKh5LDaS6uCFDsXlnrdHq/DZLwjeNBGNxLCOGKzD5oReI12pvtyg
	 k2D3m9EAC11CFcc57n2VDiUP3oHm7obUwSQt1Cs1mPahjJ64U6RWQFZNIIA/WmIyGM
	 NZFh+8+kSqOsA==
Date: Thu, 3 Apr 2025 10:25:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, Sargun Dhillon <sargun@meta.com>, 
	Alexey Spiridonov <lesha@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Reseting pending fanotify events
Message-ID: <20250403-video-halsband-9b9d0e0c95c3@brauner>
References: <BY1PR15MB61023E97919A597059EA473CC4AD2@BY1PR15MB6102.namprd15.prod.outlook.com>
 <CAOQ4uxihnLqagEX_PXA0pssQ=inPxSz-GDLcuJ9zs603LryKfw@mail.gmail.com>
 <6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr>

On Tue, Apr 01, 2025 at 06:28:11PM +0200, Jan Kara wrote:
> On Mon 31-03-25 21:08:51, Amir Goldstein wrote:
> > [CC Jan and Josef]
> 
> CCed fsdevel. Actually replying here because the quoting in Ibrahim's email
> got somehow broken which made it very hard to understand.
> 
> > I am keeping this discussion private because you did not post it to
> > the public list,
> > but if you can CC fsdevel in your reply that would be great, because it seems
> > like a question with interest to a wider audience.
> > 
> > On Mon, Mar 31, 2025 at 8:19 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> > >
> > > Hi Amir,
> > >
> > > We have been using fanotify to support lazily loading file contents.
> > > We are struggling with the problem that pending permission events cannot be recovered on daemon restart.
> > >
> > > We have a long-lived daemon that marks files with FAN_OPEN_PERM and populates their contents on access.
> > > It needs a reliable path for updates & crash recovery.
> > > The happy path for fanotify event processing is as follows:
> > >
> > > A notification is read from fanotify file descriptor
> > > File contents are populated
> > > We write back FAN_ALLOW to fanotify file descriptor, or DENY if content population failed.
> > >
> > > We would like to guarantee that all file accesses receive an ALLOW or DENY response, and no events are lost.
> > 
> > Makes sense.
> > 
> > > Unfortunately, today a filesystem client can hang (in D state)
> > > if the event-handler daemon crashes or restarts at the wrong time.
> > 
> > Can you provide exact stack traces for those cases?
> > 
> > I wonder how process gets to D state with commit fabf7f29b3e2
> > ("fanotify: Use interruptible wait when waiting for permission events")
> 
> So D state is expected when waiting for response. We are using
> TASK_UNINTERRUPTIBLE sleep (the above commit had to be effectively
> reverted). But we are also setting TASK_KILLABLE and TASK_FREEZABLE so that
> we don't block hibernation and tasks can be killed when fanotify listener
> misbehaves.
> 
> But what confuses me is the following: You have fanotify instance to which
> you've got fd from fanotify_init(). For any process to be hanging, this fd
> must be still held open by some process. Otherwise the fanotify instance
> gets destroyed and all processes are free to run (they get FAN_ALLOW reply
> if they were already waiting). So the fact that you see processes hanging
> when your fanotify listener crashes means that you have likely leaked the
> fd to some other process (lsof should be able to tell you which process has
> still handle to fanotify instance). And the kernel has no way to know this
> is not the process that will eventually read these events and reply...
> 
> > > In this case, any events that have been read but not yet responded to would be lost.
> > > Initially we considered handling this internally by saving the file descriptors for pending events,
> > > however this proved to be complex to do in a robust manner.
> > >
> > > A more robust solution is to add a kernel fanotify api which resets the fanotify pending event queue,
> > > thereby allowing us to recover pending events in the case of daemon restart.
> > > A strawman implementation of this approach is in
> > > https://github.com/torvalds/linux/compare/master...ibrahim-jirdeh:linux:fanotify-reset-pending,
> > > a new ioctl that resets `group->fanotify_data.access_list`.
> > > One other alternative we considered is directly exposing the pending event queue itself
> > > (https://github.com/torvalds/linux/commit/cd90ff006fa2732d28ff6bb5975ca5351ce009f1)
> > > to support monitoring pending events, but simply resetting the queue is likely sufficient for our use-case.
> > >
> > > What do you think of exposing this functionality in fanotify?
> > >
> > 
> > Ignoring the pending events for start, how do you deal with access to
> > non-populated files while the daemon is down?
> > 
> > We were throwing some idea about having a mount option (something
> > like a "moderate" mount) to determine the default response for specific
> > permission events (e.g. FAN_OPEN_PERM) in the case that there is
> > no listener watching this event.
> > 
> > If you have a filesystem which may contain non-populated files, you
> > mount it with as "moderated" mount and then access to all files is
> > denied until the daemon is running and also denied if daemon is down.
> > 
> > For restart, it might make sense to start a new daemon to start listening
> > to events before stopping the old daemon.
> > If the new daemon gets the events before the old daemon, things should
> > be able to transition smoothly.
> 
> I agree this would be a sensible protocol for updates. For unplanned crashes
> I agree we need something like the "moderated" mount option.

I hope you mean as a superblock option, not an actual mount option.
Because a per-mount option is not something I want us to do. We're not
giving a specific subsystem a way to alter per-mount behavior.

