Return-Path: <linux-fsdevel+bounces-36917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708C9EAFBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4BA291544
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D52080F8;
	Tue, 10 Dec 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxMiDObz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4b1A4urR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxMiDObz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4b1A4urR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D719F438;
	Tue, 10 Dec 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829634; cv=none; b=gSHf1oZx3qy7m0KD1oCMYyDDkGBc1cgldn6jqBLhXv2CtjSZ7PP7OhSGAh9M1gPRlAMPRAnScbsll19xmSjWas3XekgryUdL9jpmd0OR5tZq+rIXwa7YG2IcV7Z5Cy3gEC+zY3d1do2PynsucjUDorDkTLHLNaZlTslQkmYjwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829634; c=relaxed/simple;
	bh=+z/KsLFu7PrjAeAEdLbyHbcD2Zw1gv1HrEONZLUO/cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCSr8xiueUz/rxeToFNaB3p9gPzZjFDV/dzC4WTFlqHPFg4tiSyX6AX3lu/A51dvJH89XP8qduJlTOCegdLS0wk2MPWFZ9U7YyogweZ1hquYxci2oOap/BJ4ZbaakOL1mnQlRwpecg1j0KBKsYu5lD5ocJ86mLrDUMidcc3G9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lxMiDObz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4b1A4urR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lxMiDObz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4b1A4urR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CCE821169;
	Tue, 10 Dec 2024 11:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733829630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIYdd1xilEItOpeyjB9DIhvgYLJ1k/6/oDli3Wzspc=;
	b=lxMiDObz/akn552DWKSmNgmdCvP87NzFjjKc/sQJZaGV8bTE5FWKJ/mO25nsnkvFWi8pJH
	xKL9QxDySFXJJbyGK67YRBUlbUeJL+jNRukK214YlXjYOPo1ZCD0WFMG9GMGKSYLari2z+
	kXAHThlAE72rwR8jpF8sWSFl69Qhj7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733829630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIYdd1xilEItOpeyjB9DIhvgYLJ1k/6/oDli3Wzspc=;
	b=4b1A4urRXXpm1KHmAbttwD3PnWozrLLeK2MhPrMFixz1XVtO1iYp9YMs9FFMVAKS47AzuW
	g3h5DCHlj0dephAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733829630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIYdd1xilEItOpeyjB9DIhvgYLJ1k/6/oDli3Wzspc=;
	b=lxMiDObz/akn552DWKSmNgmdCvP87NzFjjKc/sQJZaGV8bTE5FWKJ/mO25nsnkvFWi8pJH
	xKL9QxDySFXJJbyGK67YRBUlbUeJL+jNRukK214YlXjYOPo1ZCD0WFMG9GMGKSYLari2z+
	kXAHThlAE72rwR8jpF8sWSFl69Qhj7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733829630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIYdd1xilEItOpeyjB9DIhvgYLJ1k/6/oDli3Wzspc=;
	b=4b1A4urRXXpm1KHmAbttwD3PnWozrLLeK2MhPrMFixz1XVtO1iYp9YMs9FFMVAKS47AzuW
	g3h5DCHlj0dephAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F556138D2;
	Tue, 10 Dec 2024 11:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PMAiG/4jWGfGVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Dec 2024 11:20:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3222CA0B0D; Tue, 10 Dec 2024 12:20:26 +0100 (CET)
Date: Tue, 10 Dec 2024 12:20:26 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Bert Karwatzki <spasswolf@web.de>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: commit 0790303ec869 leads to cpu stall without
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
Message-ID: <20241210112026.7v74ig2rrmceam5o@quack3>
References: <20241208152520.3559-1-spasswolf@web.de>
 <20241209121104.j6zttbqod3sh3qhr@quack3>
 <20241209122648.dpptugrol4p6ikmm@quack3>
 <CAOQ4uxgVNGmLqURdO0wf3vo=K-a2C--ZLKFzXw-22PJdkBjEdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgVNGmLqURdO0wf3vo=K-a2C--ZLKFzXw-22PJdkBjEdA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,web.de,toxicpanda.com,vger.kernel.org,fb.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 09-12-24 17:23:24, Amir Goldstein wrote:
> On Mon, Dec 9, 2024 at 1:26 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 09-12-24 13:11:04, Jan Kara wrote:
> > > > Then I took a closer look at the function called in the problematic code
> > > > and noticed that fsnotify_file_area_perm(), is a NOOP when
> > > > CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set (which was the case in my
> > > > .config). This also explains why this was not found before, as
> > > > distributional .config file have this option enabled.  Setting the option
> > > > to y solves the issue, too
> > >
> > > Well, I agree with you on all the points but the real question is, how come
> > > the test FMODE_FSNOTIFY_HSM(file->f_mode) was true on our kernel when you
> > > clearly don't run HSM software, even more so with
> > > CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled. That's the real cause of this
> > > problem. Something fishy is going on here... checking...
> > >
> > > Ah, because I've botched out file_set_fsnotify_mode() in case
> > > CONFIG_FANOTIFY_ACCESS_PERMISSIONS is disabled. This should fix the
> > > problem:
> > >
> > > index 1a9ef8f6784d..778a88fcfddc 100644
> > > --- a/include/linux/fsnotify.h
> > > +++ b/include/linux/fsnotify.h
> > > @@ -215,6 +215,7 @@ static inline int fsnotify_open_perm(struct file *file)
> > >  #else
> > >  static inline void file_set_fsnotify_mode(struct file *file)
> > >  {
> > > +       file->f_mode |= FMODE_NONOTIFY_PERM;
> > >  }
> > >
> > > I'm going to test this with CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled and
> > > push out a fixed version. Thanks again for the report and analysis!
> >
> > So this was not enough, What we need is:
> > index 1a9ef8f6784d..778a88fcfddc 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -215,6 +215,10 @@ static inline int fsnotify_open_perm(struct file *file)
> >  #else
> >  static inline void file_set_fsnotify_mode(struct file *file)
> >  {
> > +       /* Is it a file opened by fanotify? */
> > +       if (FMODE_FSNOTIFY_NONE(file->f_mode))
> > +               return;
> > +       file->f_mode |= FMODE_NONOTIFY_PERM;
> >  }
> >
> > This passes testing for me so I've pushed it out and the next linux-next
> > build should have this fix.
> 
> This fix is not obvious to the code reviewer (especially when that is
> reviewer Linus...)
> Perhaps it would be safer and less hidden to do:
> 
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -211,11 +211,16 @@ typedef int (dio_iodone_t)(struct kiocb *iocb,
> loff_t offset,
> 
>  #define FMODE_FSNOTIFY_NONE(mode) \
>         ((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
> +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
>  #define FMODE_FSNOTIFY_PERM(mode) \
>         ((mode & FMODE_FSNOTIFY_MASK) == 0 || \
>          (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
>  #define FMODE_FSNOTIFY_HSM(mode) \
>         ((mode & FMODE_FSNOTIFY_MASK) == 0)
> +#else
> +#define FMODE_FSNOTIFY_PERM(mode)      0
> +#define FMODE_FSNOTIFY_HSM(mode)       0
> +#endif

I agree this is a nicer way to achieve the same. Updated, tested & pushed
out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

