Return-Path: <linux-fsdevel+bounces-28374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8541969F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D892BB21B6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04C4A3E;
	Tue,  3 Sep 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIEKiLfw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xv2Oc6aE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIEKiLfw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xv2Oc6aE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF8817
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370560; cv=none; b=WCh0jroc3/3noCaW53KcfGtUt1haIzN2J3ceqFtjSMVbXilaE39t5gGp0mvlRNcuQJQeWPckt6GhFsj+HVBdqEnccaL33TZ+Zn5BGEx8veGdurW3DptGLygycqdf//v+Tgqdq+dBYTAqP+93LLh3ePf5K3qCUTcsXxwc/eKX6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370560; c=relaxed/simple;
	bh=2LrckQixl/atkN9WCnI+1MCfwkVMe+KfXlQGEAeAH/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTU8zszxJj8wOTnNuESaUXdaIokh5uj/BKv5MnoMfxzW8Vak8QBj5oOlJoQsJYEmrxRFYRpuh4lgglTSV6B3DyJkTn9usABjB/yLwRf3pc8ZlQmOebkkKnRiTZm3z/Xr9Uho2DfAW+kKRSWo3GDR96gwNFO/uwCc7jdDN3B6gB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIEKiLfw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xv2Oc6aE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIEKiLfw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xv2Oc6aE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C1B621A43;
	Tue,  3 Sep 2024 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKHgBwrrWuuZVvAYylfnWyZfOLj8U7a+ZpB76ZBX1ow=;
	b=yIEKiLfwTs9Vk6cS4YL13yHzAzCeXdsdlKjQ8yHDtjERqhre+XchU5gcXk5Vz2fAlQrwSJ
	Oz6ORa/utSzVOJtHKMobm+8roKQcg4rJuElQ0MJNjuomf8u82RLuq8eYqC4WMS6FIk9T9h
	Hi0zH7EmJrxldeIIRUk8eOpugm0REqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKHgBwrrWuuZVvAYylfnWyZfOLj8U7a+ZpB76ZBX1ow=;
	b=Xv2Oc6aEByVkA3tH2WL7QhhkOKGejBY+8L/DDP0T3xURjqdY9ANxTC6kBTyy7tvuLhvSZC
	/GGNyePfjj0fkQDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKHgBwrrWuuZVvAYylfnWyZfOLj8U7a+ZpB76ZBX1ow=;
	b=yIEKiLfwTs9Vk6cS4YL13yHzAzCeXdsdlKjQ8yHDtjERqhre+XchU5gcXk5Vz2fAlQrwSJ
	Oz6ORa/utSzVOJtHKMobm+8roKQcg4rJuElQ0MJNjuomf8u82RLuq8eYqC4WMS6FIk9T9h
	Hi0zH7EmJrxldeIIRUk8eOpugm0REqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKHgBwrrWuuZVvAYylfnWyZfOLj8U7a+ZpB76ZBX1ow=;
	b=Xv2Oc6aEByVkA3tH2WL7QhhkOKGejBY+8L/DDP0T3xURjqdY9ANxTC6kBTyy7tvuLhvSZC
	/GGNyePfjj0fkQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A41F13A52;
	Tue,  3 Sep 2024 13:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOBnBr0Q12b9SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:35:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C927A096C; Tue,  3 Sep 2024 15:35:48 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:35:48 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 14/20] proc: store cookie in private data
Message-ID: <20240903133548.yr4py524sozrkmq4@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>
 <20240903-zierpflanzen-rohkost-aabf97c6a049@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-zierpflanzen-rohkost-aabf97c6a049@brauner>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 03-09-24 13:34:30, Christian Brauner wrote:
> On Fri, Aug 30, 2024 at 03:04:55PM GMT, Christian Brauner wrote:
> > Store the cookie to detect concurrent seeks on directories in
> > file->private_data.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/proc/base.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 72a1acd03675..8a8aab6b9801 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3870,12 +3870,12 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> >  	if (!dir_emit_dots(file, ctx))
> >  		return 0;
> >  
> > -	/* f_version caches the tgid value that the last readdir call couldn't
> > -	 * return. lseek aka telldir automagically resets f_version to 0.
> > +	/* We cache the tgid value that the last readdir call couldn't
> > +	 * return and lseek resets it to 0.
> >  	 */
> >  	ns = proc_pid_ns(inode->i_sb);
> > -	tid = (int)file->f_version;
> > -	file->f_version = 0;
> > +	tid = (int)(intptr_t)file->private_data;
> > +	file->private_data = NULL;
> >  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
> >  	     task;
> >  	     task = next_tid(task), ctx->pos++) {
> > @@ -3890,7 +3890,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> >  				proc_task_instantiate, task, NULL)) {
> >  			/* returning this tgid failed, save it as the first
> >  			 * pid for the next readir call */
> > -			file->f_version = (u64)tid;
> > +			file->private_data = (void *)(intptr_t)tid;
> >  			put_task_struct(task);
> >  			break;
> >  		}
> > @@ -3915,6 +3915,12 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
> >  	return 0;
> >  }
> >  
> > +static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> > +{
> > +	return generic_llseek_cookie(file, offset, whence,
> > +				     (u64 *)(uintptr_t)&file->private_data);
> 
> Btw, this is fixed in-tree (I did send out an unfixed version):
> 
> static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> {
> 	u64 cookie = 1;
> 	loff_t off;
> 
> 	off = generic_llseek_cookie(file, offset, whence, &cookie);
> 	if (!cookie)
> 		file->private_data = NULL; /* serialized by f_pos_lock */
> 	return off;
> }

Ah, midair collision :). This looks better just why don't you store the
cookie unconditionally in file->private_data? This way proc_dir_llseek()
makes assumptions about how generic_llseek_cookie() uses the cookie which
unnecessarily spreads internal VFS knowledge into filesystems...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

