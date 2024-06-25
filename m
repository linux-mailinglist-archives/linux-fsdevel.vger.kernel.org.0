Return-Path: <linux-fsdevel+bounces-22353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1D9168D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023EB1F2319E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223615ADBB;
	Tue, 25 Jun 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+c+rnjF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bK/P1zsA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+c+rnjF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bK/P1zsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667211E4BF;
	Tue, 25 Jun 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322239; cv=none; b=CucFcEyFG2QKkdWQQSjF/h1KWu173pHMWyxe8NSurSR0uHma46kWwdjdyk5nOadViSD2+lYnPgCOUDJmy2X82beKRcxLK9iMNcRmHfTEtjX1vpO4dnbf/URbiN/fJxOkaDIUKIeqK4BhsSX0bwIf7B+mLNtRxQ2/SKayuA6pOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322239; c=relaxed/simple;
	bh=JhzjXgKifu5/D/SKFpApR3mOJjj8LGEoCdENPo+xmCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9SAw0tzU87bnkZwZXNLZmgHSQku1yghdxUgqcFf90Iy7xFmUwc7O0WtSqKfJdvXls9+fqavZ3DbwmoEkMVpEVKG8345hNiFlp5DSGTFHT3SD+bxhp9vF2Ldqr57LbX/5wJqWdrkjflmyiYPGBd47D2+wXmWIVPz0oPRU5xtv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+c+rnjF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bK/P1zsA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+c+rnjF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bK/P1zsA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CA9D21A4F;
	Tue, 25 Jun 2024 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719322235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of4oMpIBerQ3izREzdCQfoHy6/sqMBDaWKJerWvYlbU=;
	b=m+c+rnjFq3PVOve8WmerFuB0FI6bnxtB3JnGPbqNO8VrZ3BHoXEjjTNDgglDoti5ajnNnq
	Wr3L97LZmG9e5fByE381uDYd5DtG5VRiqEflsAHQFKdVnAepJzM8VIqCmt2XfKx+MDTSeO
	hGmz/nSDv9JMZVQ1QWwds4RxqxX5Umk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719322235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of4oMpIBerQ3izREzdCQfoHy6/sqMBDaWKJerWvYlbU=;
	b=bK/P1zsAVzS4UyR1m/4z23cthsd9sfKj4M/9ksOP49BVKykHvPWF6+pFgMHhyMae5Eilq3
	z2kMVrVfd8RYjyBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m+c+rnjF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="bK/P1zsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719322235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of4oMpIBerQ3izREzdCQfoHy6/sqMBDaWKJerWvYlbU=;
	b=m+c+rnjFq3PVOve8WmerFuB0FI6bnxtB3JnGPbqNO8VrZ3BHoXEjjTNDgglDoti5ajnNnq
	Wr3L97LZmG9e5fByE381uDYd5DtG5VRiqEflsAHQFKdVnAepJzM8VIqCmt2XfKx+MDTSeO
	hGmz/nSDv9JMZVQ1QWwds4RxqxX5Umk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719322235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of4oMpIBerQ3izREzdCQfoHy6/sqMBDaWKJerWvYlbU=;
	b=bK/P1zsAVzS4UyR1m/4z23cthsd9sfKj4M/9ksOP49BVKykHvPWF6+pFgMHhyMae5Eilq3
	z2kMVrVfd8RYjyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70C0B13A9A;
	Tue, 25 Jun 2024 13:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /smCG3vGemYzGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 13:30:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E12FA08A4; Tue, 25 Jun 2024 15:30:31 +0200 (CEST)
Date: Tue, 25 Jun 2024 15:30:31 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Yu Ma <yu.ma@intel.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 3/3] fs/file.c: remove sanity_check from alloc_fd()
Message-ID: <20240625133031.jjew3uevvrgwgviw@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-4-yu.ma@intel.com>
 <20240625120834.rhkm3p5by5jfc3bw@quack3>
 <CAGudoHGYQwigyQSqm97zyUafxaOCo0VoHZmcYzF1KtqmX=npUg@mail.gmail.com>
 <CAGudoHH4ixO6n2BgMGx7EEYvLS2Agb8WBz_RM55HjCWBQ5tMLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHH4ixO6n2BgMGx7EEYvLS2Agb8WBz_RM55HjCWBQ5tMLg@mail.gmail.com>
X-Rspamd-Queue-Id: 7CA9D21A4F
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 25-06-24 15:11:23, Mateusz Guzik wrote:
> On Tue, Jun 25, 2024 at 3:09 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 2:08 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 22-06-24 11:49:04, Yu Ma wrote:
> > > > alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> > > > allocated fd is NULL. Remove this sanity check since it can be assured by
> > > > exisitng zero initilization and NULL set when recycling fd.
> > >   ^^^ existing  ^^^ initialization
> > >
> > > Well, since this is a sanity check, it is expected it never hits. Yet
> > > searching the web shows it has hit a few times in the past :). So would
> > > wrapping this with unlikely() give a similar performance gain while keeping
> > > debugability? If unlikely() does not help, I agree we can remove this since
> > > fd_install() actually has the same check:
> > >
> > > BUG_ON(fdt->fd[fd] != NULL);
> > >
> > > and there we need the cacheline anyway so performance impact is minimal.
> > > Now, this condition in alloc_fd() is nice that it does not take the kernel
> > > down so perhaps we could change the BUG_ON to WARN() dumping similar kind
> > > of info as alloc_fd()?
> > >
> >
> > Christian suggested just removing it.
> >
> > To my understanding the problem is not the branch per se, but the the
> > cacheline bounce of the fd array induced by reading the status.
> >
> > Note the thing also nullifies the pointer, kind of defeating the
> > BUG_ON in fd_install.
> >
> > I'm guessing it's not going to hurt to branch on it after releasing
> > the lock and forego nullifying, more or less:
> > diff --git a/fs/file.c b/fs/file.c
> > index a3b72aa64f11..d22b867db246 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -524,11 +524,11 @@ static int alloc_fd(unsigned start, unsigned
> > end, unsigned flags)
> >          */
> >         error = -EMFILE;
> >         if (fd >= end)
> > -               goto out;
> > +               goto out_locked;
> >
> >         error = expand_files(files, fd);
> >         if (error < 0)
> > -               goto out;
> > +               goto out_locked;
> >
> >         /*
> >          * If we needed to expand the fs array we
> > @@ -546,15 +546,15 @@ static int alloc_fd(unsigned start, unsigned
> > end, unsigned flags)
> >         else
> >                 __clear_close_on_exec(fd, fdt);
> >         error = fd;
> > -#if 1
> > -       /* Sanity check */
> > -       if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
> > +       spin_unlock(&files->file_lock);
> > +
> > +       if (unlikely(rcu_access_pointer(fdt->fd[fd]) != NULL)) {
> >                 printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> > -               rcu_assign_pointer(fdt->fd[fd], NULL);
> >         }
> > -#endif
> 
> Now that I sent it it is of course not safe to deref without
> protection from either rcu or the lock, so this would have to be
> wrapped with rcu_read_lock, which makes it even less appealing.
> 
> Whacking the thing as in the submitted patch seems like the best way
> forward here. :)

Yeah, as I wrote, I'm fine removing it, in particular if Christian is of
the same opinion. I was more musing about whether we should make the check
in fd_install() less aggressive since it is now more likely to trigger...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

