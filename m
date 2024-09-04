Return-Path: <linux-fsdevel+bounces-28558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D318796BFD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629EE1F263B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0F1D172F;
	Wed,  4 Sep 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9w+78zS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AHTTQKHO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9w+78zS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AHTTQKHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FCDDCD
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459387; cv=none; b=IZQ0aQhUaYRfhdCKAVtCk4cqHwvQcKh8SiCWsj1L3QKktH6wQ9Qxx28UxxL2UjToytRIWq5WNj8ebw55BgC+S8h74E14veXrR92xdEmm8FXpzIsabu8waLBAi2xb7sfZmDxFZHfDu+pGRppt1LvOiyoKKr7eNIyfHJF8ja5nbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459387; c=relaxed/simple;
	bh=9IbZjSCWdSyP7Kwg+TgW6rvPtNKXqjBBlhfXcnJDh30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhaAa0mAa9z3TnUX17y8O7GxnhD1o2iqto9l717I4bpyfdXm2eK6RNKS6L4/tXEPXM8p3yb6zAqwec6yt3PknIyZT0VLW8c1bdLzUmCA3SiSYq56b76RSiXJB4UviIi3t/nnuQ0tgJBIdPM4MVruOUFsGIt6mO9hNe8Q1b8ceAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9w+78zS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AHTTQKHO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9w+78zS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AHTTQKHO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26EE11F7C5;
	Wed,  4 Sep 2024 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725459383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JI1ehp02H0MrekQgFjLXwVjpSzEt8fpzsbKPgLBw8MQ=;
	b=i9w+78zSTP0uKgLCr5PHR+sALweZJ9RM0UwridSVuhYCpHWkOq/zSnPGT1Ac8SZ+65MSN0
	oNxhh2y2+E2iozV2m50rsBwPQp2JjL3NruhiZw4MrOyxmX/zUjzKv5Cr2i7jyxUlXFjz/6
	AwNwv3SAQk/BriS/x8t76+t6SYQ8FBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725459383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JI1ehp02H0MrekQgFjLXwVjpSzEt8fpzsbKPgLBw8MQ=;
	b=AHTTQKHOv8pN2wuJZppfwa26/1lBmbPW11QYNa9SFeAMNLSYdXsmLe5kRWyv5ZueHdEU9J
	g8JHFXrc87ZGTlBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i9w+78zS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AHTTQKHO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725459383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JI1ehp02H0MrekQgFjLXwVjpSzEt8fpzsbKPgLBw8MQ=;
	b=i9w+78zSTP0uKgLCr5PHR+sALweZJ9RM0UwridSVuhYCpHWkOq/zSnPGT1Ac8SZ+65MSN0
	oNxhh2y2+E2iozV2m50rsBwPQp2JjL3NruhiZw4MrOyxmX/zUjzKv5Cr2i7jyxUlXFjz/6
	AwNwv3SAQk/BriS/x8t76+t6SYQ8FBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725459383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JI1ehp02H0MrekQgFjLXwVjpSzEt8fpzsbKPgLBw8MQ=;
	b=AHTTQKHOv8pN2wuJZppfwa26/1lBmbPW11QYNa9SFeAMNLSYdXsmLe5kRWyv5ZueHdEU9J
	g8JHFXrc87ZGTlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEFA8139D2;
	Wed,  4 Sep 2024 14:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CTRvNrZr2GYBcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 14:16:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75FAEA0968; Wed,  4 Sep 2024 16:16:07 +0200 (CEST)
Date: Wed, 4 Sep 2024 16:16:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 14/20] proc: store cookie in private data
Message-ID: <20240904141607.747jkil4poyynpxz@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>
 <20240903-zierpflanzen-rohkost-aabf97c6a049@brauner>
 <20240903133548.yr4py524sozrkmq4@quack3>
 <20240903-biografie-antik-5d931826566d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-biografie-antik-5d931826566d@brauner>
X-Rspamd-Queue-Id: 26EE11F7C5
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 03-09-24 16:00:56, Christian Brauner wrote:
> On Tue, Sep 03, 2024 at 03:35:48PM GMT, Jan Kara wrote:
> > On Tue 03-09-24 13:34:30, Christian Brauner wrote:
> > > On Fri, Aug 30, 2024 at 03:04:55PM GMT, Christian Brauner wrote:
> > > > Store the cookie to detect concurrent seeks on directories in
> > > > file->private_data.
> > > > 
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  fs/proc/base.c | 18 ++++++++++++------
> > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index 72a1acd03675..8a8aab6b9801 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -3870,12 +3870,12 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> > > >  	if (!dir_emit_dots(file, ctx))
> > > >  		return 0;
> > > >  
> > > > -	/* f_version caches the tgid value that the last readdir call couldn't
> > > > -	 * return. lseek aka telldir automagically resets f_version to 0.
> > > > +	/* We cache the tgid value that the last readdir call couldn't
> > > > +	 * return and lseek resets it to 0.
> > > >  	 */
> > > >  	ns = proc_pid_ns(inode->i_sb);
> > > > -	tid = (int)file->f_version;
> > > > -	file->f_version = 0;
> > > > +	tid = (int)(intptr_t)file->private_data;
> > > > +	file->private_data = NULL;
> > > >  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
> > > >  	     task;
> > > >  	     task = next_tid(task), ctx->pos++) {
> > > > @@ -3890,7 +3890,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> > > >  				proc_task_instantiate, task, NULL)) {
> > > >  			/* returning this tgid failed, save it as the first
> > > >  			 * pid for the next readir call */
> > > > -			file->f_version = (u64)tid;
> > > > +			file->private_data = (void *)(intptr_t)tid;
> > > >  			put_task_struct(task);
> > > >  			break;
> > > >  		}
> > > > @@ -3915,6 +3915,12 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> > > > +{
> > > > +	return generic_llseek_cookie(file, offset, whence,
> > > > +				     (u64 *)(uintptr_t)&file->private_data);
> > > 
> > > Btw, this is fixed in-tree (I did send out an unfixed version):
> > > 
> > > static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> > > {
> > > 	u64 cookie = 1;
> > > 	loff_t off;
> > > 
> > > 	off = generic_llseek_cookie(file, offset, whence, &cookie);
> > > 	if (!cookie)
> > > 		file->private_data = NULL; /* serialized by f_pos_lock */
> > > 	return off;
> > > }
> > 
> > Ah, midair collision :). This looks better just why don't you store the
> > cookie unconditionally in file->private_data? This way proc_dir_llseek()
> > makes assumptions about how generic_llseek_cookie() uses the cookie which
> > unnecessarily spreads internal VFS knowledge into filesystems...
> 
> I tried to avoid an allocation for procfs (I assume that's what you're
> getting at). That's basically all.

Yes, I just meant I'd find it safer to have:

static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
{
	u64 cookie = (u64)file->private_data;
	loff_t off;

	off = generic_llseek_cookie(file, offset, whence, &cookie);
	file->private_data = (void *)cookie; /* serialized by f_pos_lock */
	return off;
}

So that we don't presume what generic_llseek_cookie() can do with the
cookie.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

