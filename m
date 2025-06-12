Return-Path: <linux-fsdevel+bounces-51511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68F6AD7819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221A41641FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002429AAF4;
	Thu, 12 Jun 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8es107J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TEnmcgOo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8es107J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TEnmcgOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1422333D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745387; cv=none; b=sxxCbOU3SlGqxeJFCtYTs/QLrOwkIZJ6yXx1tna7fdHbtERC80HizkW27tcY14pZveVh5D45CHyDqouarwd4qKJg/Sh/84lW3PFoZPmWRh4DzG/8dgJWNa3qH41/35JwSNTRn8Ri1Zsf8F6ym+RXCD1pMwT9KuBMalHSLfAzm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745387; c=relaxed/simple;
	bh=7AP8fqRO4JJ8g1LZXRdJ1vokZpS4bKBvVAgN9s+xATo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbrt0nuQRG78SKabmms5wmgf8x7K+urYI7XxSUm5cmr8kmqeykN5fKSee/OoMX6bbTWIJB+p61W+pIkK9bGYAYFvA6yqxbc5r4kRuIbPto67bIfmOVNJvKBvHBQY3TLFM3XwTOId82VtK27jRSqdX3JfPR0WzK+JtXtJ33B11i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8es107J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TEnmcgOo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8es107J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TEnmcgOo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B7231F7E8;
	Thu, 12 Jun 2025 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749745382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PFZ+uLNMtP9yso1JZju5KkdQPKX8bCV/l3apoAnYl+A=;
	b=c8es107Jaiqk/6P4+3yNsA80g4jQ1Y49f+fLYRke6MwaDRyCPBc5K20pdqMJTakZFqfGwY
	89drO+p5RPHemFuKx32zUQWqG8pyyb11dTNfO2SejtzKUtAQS0GN5qLRUipjyufjJrSYcg
	U9jP3G9/IZlNcxH2XZ/H6VgOEoV4/7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749745382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PFZ+uLNMtP9yso1JZju5KkdQPKX8bCV/l3apoAnYl+A=;
	b=TEnmcgOo3GC9KFKIv7hKab8b410CzHwXcEkn0XfoU4R7rnC4T9HYvOP5vlmaEGqTFfVxJf
	HUZPUEqHqcH83DBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749745382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PFZ+uLNMtP9yso1JZju5KkdQPKX8bCV/l3apoAnYl+A=;
	b=c8es107Jaiqk/6P4+3yNsA80g4jQ1Y49f+fLYRke6MwaDRyCPBc5K20pdqMJTakZFqfGwY
	89drO+p5RPHemFuKx32zUQWqG8pyyb11dTNfO2SejtzKUtAQS0GN5qLRUipjyufjJrSYcg
	U9jP3G9/IZlNcxH2XZ/H6VgOEoV4/7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749745382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PFZ+uLNMtP9yso1JZju5KkdQPKX8bCV/l3apoAnYl+A=;
	b=TEnmcgOo3GC9KFKIv7hKab8b410CzHwXcEkn0XfoU4R7rnC4T9HYvOP5vlmaEGqTFfVxJf
	HUZPUEqHqcH83DBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F401132D8;
	Thu, 12 Jun 2025 16:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rPU1C+b+SmjSPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 16:23:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 823E3A09B0; Thu, 12 Jun 2025 18:23:01 +0200 (CEST)
Date: Thu, 12 Jun 2025 18:23:01 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
Message-ID: <3gvuqzzyhiz5is42h4rbvqx43q4axmo7ehubomijvbr5k25xgb@pwjvfuttjegk>
References: <87tt4u4p4h.fsf@igalia.com>
 <20250612094101.6003-1-luis@igalia.com>
 <ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
X-Spam-Level: 

On Thu 12-06-25 15:55:40, Mateusz Guzik wrote:
> On Thu, Jun 12, 2025 at 10:41:01AM +0100, Luis Henriques wrote:
> > The assert in function file_seek_cur_needs_f_lock() can be triggered very
> > easily because, as Jan Kara suggested, the file reference may get
> > incremented after checking it with fdget_pos().
> > 
> > Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
> > Signed-off-by: Luis Henriques <luis@igalia.com>
> > ---
> > Hi Christian,
> > 
> > It wasn't clear whether you'd be queueing this fix yourself.  Since I don't
> > see it on vfs.git, I decided to explicitly send the patch so that it doesn't
> > slip through the cracks.
> > 
> > Cheers,
> > -- 
> > Luis
> > 
> >  fs/file.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index 3a3146664cf3..075f07bdc977 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -1198,8 +1198,6 @@ bool file_seek_cur_needs_f_lock(struct file *file)
> >  	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
> >  		return false;
> >  
> > -	VFS_WARN_ON_ONCE((file_count(file) > 1) &&
> > -			 !mutex_is_locked(&file->f_pos_lock));
> >  	return true;
> >  }
> 
> fdget_pos() can only legally skip locking if it determines to be in
> position where nobody else can operate on the same file obj, meaning
> file_count(file) == 1 and it can't go up. Otherwise the lock is taken.
> 
> Or to put it differently, fdget_pos() NOT taking the lock and new refs
> showing up later is a bug.

I mostly agree and as I've checked again, this indeed seems to be the case
as fdget() will increment f_ref if file table is shared with another thread
and thus file_needs_f_pos_lock() returns true whenever there are more
threads sharing the file table or if the struct file is dupped to another
fd. That being said I find the assertion in file_seek_cur_needs_f_lock()
misplaced - it just doesn't make sense in that place to me.
 
> I don't believe anything of the sort is happening here.
> 
> Instead, overlayfs is playing games and *NOT* going through fdget_pos():
> 
> 	ovl_inode_lock(inode);
>         realfile = ovl_real_file(file);
> 	[..]
>         ret = vfs_llseek(realfile, offset, whence);
> 
> Given the custom inode locking around the call, it may be any other
> locking is unnecessary and the code happens to be correct despite the
> splat.

Right and good spotting. That's indeed more likely explanation than mine.
Actually custom locking around llseek isn't all that uncommon (mostly for
historical reasons AFAIK but that's another story).

> I think the safest way out with some future-proofing is to in fact *add*
> the locking in ovl_llseek() to shut up the assert -- personally I find
> it uneasy there is some underlying file obj flying around.

Well, if you grep for vfs_llseek(), you'll see there are much more calls to
it in the kernel than overlayfs. These callers outside of fs/read_write.c
are responsible for their locking. So I don't think keeping the assert in
file_seek_cur_needs_f_lock() makes any sense. If anything I'd be open to
putting it in fdput_pos() or something like that.

> Even if ultimately the assert has to go, the proposed commit message
> does not justify it.

I guess the commit message could be improved. Something like:

The assert in function file_seek_cur_needs_f_lock() can be triggered very
easily because there are many users of vfs_llseek() (such as overlayfs)
that do their custom locking around llseek instead of relying on
fdget_pos(). Just drop the overzealous assertion.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

