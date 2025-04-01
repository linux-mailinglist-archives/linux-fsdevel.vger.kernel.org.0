Return-Path: <linux-fsdevel+bounces-45414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C07DA77517
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 09:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724293A3AE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9641E835B;
	Tue,  1 Apr 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7DEBEBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B01E47A6;
	Tue,  1 Apr 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491840; cv=none; b=E3qa/vSCTlgj6sEI5sndjy0JAP2zV+bkE+kU7zpdTHaAL7BdNqm9bXb/N/Vr0UeAfBZXC6rB74ZiXFIENIC2R/4FZ4DdIMX1C30Ny3K+VdK604D8j7DOER6JRzOI+Rhzaye8b7CF8QCHm56Vpd5uS9XGhwfecn2MUht2TDfZP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491840; c=relaxed/simple;
	bh=yGVuOK8QsrbzJeHeZyfdHkem1uNLnG6KfYUZfHdCoG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxz3SrmZYixJspEefoFgKYvoKxMfuu3npjn9Iz1v8YIh00W0rjAi4fsC7uwrIi+UOPGOBvcetXyTJRVxiPQkNaj0QeQ8uZKukvk0MEWGuB8rp783Kbammp0ANm+vj0+ovtc7FjKyH57c10u+wQ0d3u4xkJqzVYIevJU9ugXQFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7DEBEBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8A2C4CEE8;
	Tue,  1 Apr 2025 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743491839;
	bh=yGVuOK8QsrbzJeHeZyfdHkem1uNLnG6KfYUZfHdCoG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7DEBEBh3oAtCdSwwszho06IfxX1ZpBRXC5zlUlXBKZFKeOhDBre8bA+ZZ1c2ddBC
	 H1BK6RQGj2Xd0hzjrS3LwxQ5PnF/XkEs1O89lq7MtqZ8Mux027RH2odhXsGtFa4mGx
	 Gs3zKhetuLRgetKrsEQEu8ZXmZhuuA+aZ+s4sV7KO+46J+OgsmchRxn6QPDxeOh+FR
	 RKIqeCbPzTS7JBXF3c9MT2VDrUblR2bj54usuPMZ+JK3xC7zyKN6RTKsfWD1WaGITO
	 0ghMzNrJtEdTRQSNLJb1A6H8wLaiQlZcKjUiwvHB56SpQsUF4BqlvODqbQ0CCXcPNX
	 UC383ZZOgMEuQ==
Date: Tue, 1 Apr 2025 09:17:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] xfs: replace kthread freezing with auto fs freezing
Message-ID: <20250401-baubeginn-ausdehnen-3a7387b756aa@brauner>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>
 <Z-s9KG-URzB9DwUb@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-s9KG-URzB9DwUb@dread.disaster.area>

On Tue, Apr 01, 2025 at 12:11:04PM +1100, Dave Chinner wrote:
> On Tue, Apr 01, 2025 at 02:32:48AM +0200, Christian Brauner wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > The kernel power management now supports allowing the VFS
> > to handle filesystem freezing freezes and thawing. Take advantage
> > of that and remove the kthread freezing. This is needed so that we
> > properly really stop IO in flight without races after userspace
> > has been frozen. Without this we rely on kthread freezing and
> > its semantics are loose and error prone.
> > 
> > The filesystem therefore is in charge of properly dealing with
> > quiescing of the filesystem through its callbacks if it thinks
> > it knows better than how the VFS handles it.
> > 
> .....
> 
> > diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> > index 0fcb1828e598..ad8183db0780 100644
> > --- a/fs/xfs/xfs_trans_ail.c
> > +++ b/fs/xfs/xfs_trans_ail.c
> > @@ -636,7 +636,6 @@ xfsaild(
> >  	unsigned int	noreclaim_flag;
> >  
> >  	noreclaim_flag = memalloc_noreclaim_save();
> > -	set_freezable();
> >  
> >  	while (1) {
> >  		/*
> > @@ -695,8 +694,6 @@ xfsaild(
> >  
> >  		__set_current_state(TASK_RUNNING);
> >  
> > -		try_to_freeze();
> > -
> >  		tout = xfsaild_push(ailp);
> >  	}
> >  
> 
> So what about the TASK_FREEZABLE flag that is set in this code
> before sleeping?
> 
> i.e. this code before we schedule():
> 
>                 if (tout && tout <= 20)
>                         set_current_state(TASK_KILLABLE|TASK_FREEZABLE);
>                 else
>                         set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
> 
> Shouldn't TASK_FREEZABLE go away, too?

Thanks for spotting! Yes, yesterday late at night I just took Luis
patches as they are and had only gotten around to testing btrfs. The
coccinelle scripts seemed to have missed those. I'll wait for comments
and will do another pass and send out v2.

> > diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
> > index c5136ea9bb1d..1875b6551ab0 100644
> > --- a/fs/xfs/xfs_zone_gc.c
> > +++ b/fs/xfs/xfs_zone_gc.c
> > @@ -993,7 +993,6 @@ xfs_zone_gc_handle_work(
> >  	}
> >  
> >  	__set_current_state(TASK_RUNNING);
> > -	try_to_freeze();
> >  
> >  	if (reset_list)
> >  		xfs_zone_gc_reset_zones(data, reset_list);
> > @@ -1041,7 +1040,6 @@ xfs_zoned_gcd(
> >  	unsigned int		nofs_flag;
> >  
> >  	nofs_flag = memalloc_nofs_save();
> > -	set_freezable();
> >  
> >  	for (;;) {
> >  		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
> 
> Same question here for this newly merged code, too...

I'm not sure if this is supposed to be a snipe or not but just in case
this is a hidden question: This isn't merged. Per the cover letter this
is in a work.* branch. Anything that is considered mergable is in
vfs-6.16.* branches. But since we're pre -rc1 even those branches are
not yet showing up in -next.

