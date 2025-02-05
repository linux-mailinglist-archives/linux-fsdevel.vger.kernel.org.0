Return-Path: <linux-fsdevel+bounces-40942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4DA296BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B547A10C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE40B1DE4E1;
	Wed,  5 Feb 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t8WcFU/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6twokP9V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t8WcFU/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6twokP9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC91DB153
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774340; cv=none; b=SqAb51NbwMjxYGnKK6Ul59FrYWBjaVxTtT1fTSU0+4W2KKFybEMmbLz0d7wt3avrfjk/T+9laTH1qExeQsMocwBG/cIxEephJdw9tYLTZDL1THKuufyiOTbpRXRC0fgqBI6awMCKy+7jCImBjV+XpGD63fX9QUbh2kqXKzTpySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774340; c=relaxed/simple;
	bh=Ziat+6ZYcbk6kcsiUK+kuQHfqpWgM9pTjr7gEXr6H0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVEekRpnJ+JPY7de68YRAy7046lDriRIlJx7YPnlu1eZmJ2/VElFlhX9J2c+6uUCdkhO5zYIHZEdCLIzsPhQETrCLdevDL81f0P1udYg4iza19Ohq07igvarfiWtMS+C4WznWA54M2a/5QV28B8Zio4UAWqBgNHQHbpI/ILKZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t8WcFU/c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6twokP9V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t8WcFU/c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6twokP9V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DCBD1F7E0;
	Wed,  5 Feb 2025 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738774336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xjWyn71YHhBlfXbSoCQsOM+XhxUhkt65kyfcxZcrek=;
	b=t8WcFU/ckhaHbtSDuerYED4bVzxxSVQASJPTk3Vt/8ZRprKyXySTIABNn45IB8AMNlDw7M
	dmb/mdkwCOWlPCcX9iYwZfY2j6aEQSYFgWo5RmQm+mD9BXY630DGEItpKjEMMTF6VzCTG/
	rt0+HP5bCx8YdwnZHIfCHNIpEEji/gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738774336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xjWyn71YHhBlfXbSoCQsOM+XhxUhkt65kyfcxZcrek=;
	b=6twokP9Vz924/660rAucXqtf1y8AH765rCkF/j3CZKKxFlnWCK5SicmPZIRoUpP+3G6s4B
	lrL99Z25+275PGDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="t8WcFU/c";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6twokP9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738774336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xjWyn71YHhBlfXbSoCQsOM+XhxUhkt65kyfcxZcrek=;
	b=t8WcFU/ckhaHbtSDuerYED4bVzxxSVQASJPTk3Vt/8ZRprKyXySTIABNn45IB8AMNlDw7M
	dmb/mdkwCOWlPCcX9iYwZfY2j6aEQSYFgWo5RmQm+mD9BXY630DGEItpKjEMMTF6VzCTG/
	rt0+HP5bCx8YdwnZHIfCHNIpEEji/gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738774336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xjWyn71YHhBlfXbSoCQsOM+XhxUhkt65kyfcxZcrek=;
	b=6twokP9Vz924/660rAucXqtf1y8AH765rCkF/j3CZKKxFlnWCK5SicmPZIRoUpP+3G6s4B
	lrL99Z25+275PGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1742913694;
	Wed,  5 Feb 2025 16:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RNFjBUCXo2fgPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Feb 2025 16:52:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC21AA28E9; Wed,  5 Feb 2025 17:52:11 +0100 (CET)
Date: Wed, 5 Feb 2025 17:52:11 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Alex Williamson <alex.williamson@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fsnotify: use accessor to set FMODE_NONOTIFY_*
Message-ID: <er7avw4zv2oquqgcvu3gvjbvizkybkwkdlw5fxo4ncpnxvomws@vl7felvkkmlp>
References: <20250203223205.861346-1-amir73il@gmail.com>
 <20250203223205.861346-2-amir73il@gmail.com>
 <20250204-drehleiter-kehlkopf-ebfb51587558@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-drehleiter-kehlkopf-ebfb51587558@brauner>
X-Rspamd-Queue-Id: 2DCBD1F7E0
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,redhat.com,linux-foundation.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 04-02-25 11:43:11, Christian Brauner wrote:
> On Mon, Feb 03, 2025 at 11:32:03PM +0100, Amir Goldstein wrote:
> > The FMODE_NONOTIFY_* bits are a 2-bits mode.  Open coding manipulation
> > of those bits is risky.  Use an accessor file_set_fsnotify_mode() to
> > set the mode.
> > 
> > Rename file_set_fsnotify_mode() => file_set_fsnotify_mode_from_watchers()
> > to make way for the simple accessor name.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  drivers/tty/pty.c        |  2 +-
> >  fs/notify/fsnotify.c     | 18 ++++++++++++------
> >  fs/open.c                |  7 ++++---
> >  include/linux/fs.h       |  9 ++++++++-
> >  include/linux/fsnotify.h |  4 ++--
> >  5 files changed, 27 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> > index df08f13052ff4..8bb1a01fef2a1 100644
> > --- a/drivers/tty/pty.c
> > +++ b/drivers/tty/pty.c
> > @@ -798,7 +798,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
> >  	nonseekable_open(inode, filp);
> >  
> >  	/* We refuse fsnotify events on ptmx, since it's a shared resource */
> > -	filp->f_mode |= FMODE_NONOTIFY;
> > +	file_set_fsnotify_mode(filp, FMODE_NONOTIFY);
> >  
> >  	retval = tty_alloc_file(filp);
> >  	if (retval)
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 8ee495a58d0ad..77a1521335a10 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -648,7 +648,7 @@ EXPORT_SYMBOL_GPL(fsnotify);
> >   * Later, fsnotify permission hooks do not check if there are permission event
> >   * watches, but that there were permission event watches at open time.
> >   */
> > -void file_set_fsnotify_mode(struct file *file)
> > +void file_set_fsnotify_mode_from_watchers(struct file *file)
> >  {
> >  	struct dentry *dentry = file->f_path.dentry, *parent;
> >  	struct super_block *sb = dentry->d_sb;
> > @@ -665,7 +665,7 @@ void file_set_fsnotify_mode(struct file *file)
> >  	 */
> >  	if (likely(!fsnotify_sb_has_priority_watchers(sb,
> >  						FSNOTIFY_PRIO_CONTENT))) {
> > -		file->f_mode |= FMODE_NONOTIFY_PERM;
> > +		file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
> >  		return;
> >  	}
> >  
> > @@ -676,7 +676,7 @@ void file_set_fsnotify_mode(struct file *file)
> >  	if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
> >  	    likely(!fsnotify_sb_has_priority_watchers(sb,
> >  						FSNOTIFY_PRIO_PRE_CONTENT))) {
> > -		file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> > +		file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
> >  		return;
> >  	}
> >  
> > @@ -686,19 +686,25 @@ void file_set_fsnotify_mode(struct file *file)
> >  	 */
> >  	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
> >  	if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
> > -				     FSNOTIFY_PRE_CONTENT_EVENTS)))
> > +				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
> > +		/* Enable pre-content events */
> > +		file_set_fsnotify_mode(file, 0);
> >  		return;
> > +	}
> >  
> >  	/* Is parent watching for pre-content events on this file? */
> >  	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
> >  		parent = dget_parent(dentry);
> >  		p_mask = fsnotify_inode_watches_children(d_inode(parent));
> >  		dput(parent);
> > -		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)
> > +		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
> > +			/* Enable pre-content events */
> > +			file_set_fsnotify_mode(file, 0);
> >  			return;
> > +		}
> >  	}
> >  	/* Nobody watching for pre-content events from this file */
> > -	file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> > +	file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
> >  }
> >  #endif
> >  
> > diff --git a/fs/open.c b/fs/open.c
> > index 932e5a6de63bb..3fcbfff8aede8 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -905,7 +905,8 @@ static int do_dentry_open(struct file *f,
> >  	f->f_sb_err = file_sample_sb_err(f);
> >  
> >  	if (unlikely(f->f_flags & O_PATH)) {
> > -		f->f_mode = FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
> > +		f->f_mode = FMODE_PATH | FMODE_OPENED;
> > +		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> >  		f->f_op = &empty_fops;
> >  		return 0;
> >  	}
> > @@ -938,7 +939,7 @@ static int do_dentry_open(struct file *f,
> >  	 * If FMODE_NONOTIFY was already set for an fanotify fd, this doesn't
> >  	 * change anything.
> >  	 */
> > -	file_set_fsnotify_mode(f);
> > +	file_set_fsnotify_mode_from_watchers(f);
> >  	error = fsnotify_open_perm(f);
> >  	if (error)
> >  		goto cleanup_all;
> > @@ -1122,7 +1123,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
> >  	if (!IS_ERR(f)) {
> >  		int error;
> >  
> > -		f->f_mode |= FMODE_NONOTIFY;
> > +		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> >  		error = vfs_open(path, f);
> >  		if (error) {
> >  			fput(f);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index be3ad155ec9f7..e73d9b998780d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -206,6 +206,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> >   * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
> >   * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
> >   */
> > +#define FMODE_NONOTIFY_HSM \
> > +	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
> 
> After this patch series this define is used exactly twice and it's
> currently identical to FMODE_FSNOTIFY_HSM. I suggest to remove it and
> simply pass FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the two places it's
> used. I can do this myself though so if Jan doesn't have other comments
> don't bother resending.

I don't care that much but overall I tend to agree that a helper for two
very localized uses is not too helpful. Either with or without
FMODE_NONOTIFY_HSM feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

