Return-Path: <linux-fsdevel+bounces-49860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2EAC4325
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A811892C71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D8212B0C;
	Mon, 26 May 2025 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CR2yFrwP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rA6csdm0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CR2yFrwP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rA6csdm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF2187554
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748278063; cv=none; b=iGCO8MbaXwgmUuhg9FoMuHlFMI+j1LyI/viM4Mvxnuf0xQn56k/eQIRtLt/jDhyOZj4z7GYMvKj1tMJ1REBtH/Y5gwcA1l0DBYB/ddC6e8YqHLkbhOveYmMiGWC1mhEFw4d5R75DzQmlRZNSTVxlgnh0XkJ6TPHes+wmyvFa23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748278063; c=relaxed/simple;
	bh=fy8oSnaOu8lhMsAWRJ22nE28YnXiQk7iIrtz7pBQmBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGRBWzQrEatTcZASMeZguJC130z+LNxK8y8tFjorm37tO4OfpASJ67FGcjCO3ZWfrFVmJ15Ka145DvtAtO7iZqCUnKs/JPDlJh8Oy+neJUuyeQdsBwQH6tbtE+dWU7G18qW+3HY0WMZ3gKfvtyYxKnCT3qui8MPnfOIXbJjrZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CR2yFrwP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rA6csdm0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CR2yFrwP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rA6csdm0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6461FD5A;
	Mon, 26 May 2025 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748278060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IVetfcgHxBZ3iNICgIiotNVqlXUl9NqH4jmcGaCtt50=;
	b=CR2yFrwP0RQnkMR8r0/UBcrtpzjqfepizF2y/ir+GsHc4VhyYzeHSKlE69HDZbHBM2zqex
	KP0fsDQ6rlleU6/oaYz5o8UA6xeJjVFw7TcTUMDxbbf8uxy1qfz539ZOsjgU/CFOaH6KiY
	u/silOWyr80JRBIeq6HKyfHgfYFNXUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748278060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IVetfcgHxBZ3iNICgIiotNVqlXUl9NqH4jmcGaCtt50=;
	b=rA6csdm0YikkO57xbnBImz4E90JP96jIkqY/UzQ99Z3YPOLYsXQ4nDDzjzO7hsO8jP4XDy
	Pa79WEJ2qgC+csCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748278060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IVetfcgHxBZ3iNICgIiotNVqlXUl9NqH4jmcGaCtt50=;
	b=CR2yFrwP0RQnkMR8r0/UBcrtpzjqfepizF2y/ir+GsHc4VhyYzeHSKlE69HDZbHBM2zqex
	KP0fsDQ6rlleU6/oaYz5o8UA6xeJjVFw7TcTUMDxbbf8uxy1qfz539ZOsjgU/CFOaH6KiY
	u/silOWyr80JRBIeq6HKyfHgfYFNXUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748278060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IVetfcgHxBZ3iNICgIiotNVqlXUl9NqH4jmcGaCtt50=;
	b=rA6csdm0YikkO57xbnBImz4E90JP96jIkqY/UzQ99Z3YPOLYsXQ4nDDzjzO7hsO8jP4XDy
	Pa79WEJ2qgC+csCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEAF013964;
	Mon, 26 May 2025 16:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Xf/OSubNGggewAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 16:47:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B4961A09B7; Mon, 26 May 2025 18:47:38 +0200 (CEST)
Date: Mon, 26 May 2025 18:47:38 +0200
From: Jan Kara <jack@suse.cz>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <pehvvmy3vzimalic3isygd4d66j6tb6cnosoiu6xkgfjy3p3up@ikj4bhpmx4yt>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
 <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
 <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
 <xlbmnncnw6swdtf74nlbqkn57sxpt5f3bylpvhezdwgavx5h2r@boz7f5kg3x2q>
 <yo2mrodmg32xw3v3pezwreqtncamn2kvr5feae6jlzxajxzf6s@dclplmsehqct>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yo2mrodmg32xw3v3pezwreqtncamn2kvr5feae6jlzxajxzf6s@dclplmsehqct>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 26-05-25 23:12:20, Sergey Senozhatsky wrote:
> On (25/05/26 14:52), Jan Kara wrote:
> > > > We don't use exclusive waits with access_waitq so wake_up() and
> > > > wake_up_all() should do the same thing?
> > > 
> > > Oh, non-exclusive waiters, I see.  I totally missed that, thanks.
> > > 
> > > So... the problem is somewhere else then.  I'm currently looking
> > > at some crashes (across all LTS kernels) where group owner just
> > > gets stuck and then hung-task watchdog kicks in and panics the
> > > system.  Basically just a single backtrace in the kernel logs:
> > > 
> > >  schedule+0x534/0x2540
> > >  fsnotify_destroy_group+0xa7/0x150
> > >  fanotify_release+0x147/0x160
> > >  ____fput+0xe4/0x2a0
> > >  task_work_run+0x71/0xb0
> > >  do_exit+0x1ea/0x800
> > >  do_group_exit+0x81/0x90
> > >  get_signal+0x32d/0x4e0
> > > 
> > > My assumption was that it's this wait:
> > > 	wait_event(group->notification_waitq, !atomic_read(&group->user_waits));
> > 
> > Well, you're likely correct we are sleeping in this wait. But likely
> > there's some process that's indeed waiting for response to fanotify event
> > from userspace. Do you have a reproducer? Can you dump all blocked tasks
> > when this happens?
> 
> Unfortunately, no.  This happens on consumer devices, which are
> not available for any sort of debugging, due to various privacy
> protection reasons.  We only get anonymized kernel ramoops/dmesg
> on crashes.
> 
> So my only option is to add something to the kernel, then roll-out
> the patched kernel to the fleet and wait for new crash reports.  The
> problem is, all that I can think of sort of fixes the crash as far as
> the hung-task watchdog is concerned.  Let me think more about it.
> 
> Another silly question: what decrements group->user_waits in case of
> that race-condition?
> 
> ---
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 9dac7f6e72d2b..38b977fe37a71 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -945,8 +945,10 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
>                 fsid = fanotify_get_fsid(iter_info);
>                 /* Racing with mark destruction or creation? */
> -               if (!fsid.val[0] && !fsid.val[1])
> -                       return 0;
> +               if (!fsid.val[0] && !fsid.val[1]) {
> +                       ret = 0;
> +                       goto finish;
> +               }
>         }

This code is not present in current upstream kernel. This seems to have
been inadvertedly fixed by commit 30ad1938326b ("fanotify: allow "weak" fsid
when watching a single filesystem") which you likely don't have in your
kernel.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

