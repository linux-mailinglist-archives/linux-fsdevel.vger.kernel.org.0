Return-Path: <linux-fsdevel+bounces-36542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F89E58CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78EE2864A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6421A44B;
	Thu,  5 Dec 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6M/a8ym";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IEmGGgre";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6M/a8ym";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IEmGGgre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D91B0F22;
	Thu,  5 Dec 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410010; cv=none; b=EqXbfrTEcQAM3Rxhi9Di21dIdJeNO7gFWwy/cGjHn/doqZsaZlKSPRrqfGYU1VO4wreT+INsZEOLF0R8Li97CVCq2YKbKPO5WrZBKmjqz1JKGXtavEyGySBSD4Yk8Z6YU/WZ9ODT7Mpf8IDW/nJBci1k+hB5ZzUp/s/vOH+yn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410010; c=relaxed/simple;
	bh=7/gyP7hOadanIjh7Pi5fa0OyGQnE7z/f+zPKtRz7f58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnqI+EG5dYU0mPQMkSqqtvWrdR6HStuqq09SG0r2Rl6qn+yxvjnP4UCKHNyPilpdhrlV67XETNoCH5TQYKu8g9FMXTERESLdQ+0321CeXA7yGQKh+1Xg9rIbIa7X3glDasj65t0y5c7mnMao83Vc0ivGLg9Va0zxIzQWuv/hJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A6M/a8ym; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IEmGGgre; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A6M/a8ym; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IEmGGgre; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54C3D1F38C;
	Thu,  5 Dec 2024 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733410006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIWc2YAYdMe+kXlIH9u8pQ2JNxlUGW/w70KQcKVvdco=;
	b=A6M/a8ymwuV+4gt/bH8osHYVlljrS72aPfBmZ0V6TY5SKEXrqRDC7hQcpw/I0dq/Dc3bVT
	8tV0N/QJPpKOdeHuA0xgSNr7p/bCWZRWSK13WDh+P2QWv7dvfxxefGQFVuf766N0BXnUwg
	HQqWkuv+egS94C28vl3c8uQcZOKAoVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733410006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIWc2YAYdMe+kXlIH9u8pQ2JNxlUGW/w70KQcKVvdco=;
	b=IEmGGgrexX9/XxlMlfx0OtB+j3OzPG9mMPBKkWK4kYI3fY5tRZ0+jD1ASUSLAYgc3nQMB7
	+2clvuD/oN5sDgAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="A6M/a8ym";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IEmGGgre
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733410006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIWc2YAYdMe+kXlIH9u8pQ2JNxlUGW/w70KQcKVvdco=;
	b=A6M/a8ymwuV+4gt/bH8osHYVlljrS72aPfBmZ0V6TY5SKEXrqRDC7hQcpw/I0dq/Dc3bVT
	8tV0N/QJPpKOdeHuA0xgSNr7p/bCWZRWSK13WDh+P2QWv7dvfxxefGQFVuf766N0BXnUwg
	HQqWkuv+egS94C28vl3c8uQcZOKAoVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733410006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIWc2YAYdMe+kXlIH9u8pQ2JNxlUGW/w70KQcKVvdco=;
	b=IEmGGgrexX9/XxlMlfx0OtB+j3OzPG9mMPBKkWK4kYI3fY5tRZ0+jD1ASUSLAYgc3nQMB7
	+2clvuD/oN5sDgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48E1D132EB;
	Thu,  5 Dec 2024 14:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDfCEda8UWcJYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Dec 2024 14:46:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E43CAA08CF; Thu,  5 Dec 2024 15:46:45 +0100 (CET)
Date: Thu, 5 Dec 2024 15:46:45 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paulmck@kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, edumazet@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <20241205144645.bv2q6nqua66sql3j@quack3>
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205120332.1578562-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 54C3D1F38C
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 05-12-24 13:03:32, Mateusz Guzik wrote:
> See the added commentary for reasoning.
> 
> ->resize_in_progress handling is moved inside of expand_fdtable() for
> clarity.
> 
> Whacks an actual fence on arm64.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Hum, I don't think this works. What could happen now is:

CPU1					CPU2
expand_fdtable()			fd_install()
  files->resize_in_progress = true;
  ...
  if (atomic_read(&files->count) > 1)
    synchronize_rcu();
  ...
  rcu_assign_pointer(files->fdt, new_fdt);
  if (cur_fdt != &files->fdtab)
          call_rcu(&cur_fdt->rcu, free_fdtable_rcu);

					rcu_read_lock_sched()

					fdt = rcu_dereference_sched(files->fdt);
					/* Fetched old FD table - without
					 * smp_rmb() the read was reordered */
  rcu_assign_pointer(files->fdt, new_fdt);
  /*
   * Publish everything before we unset ->resize_in_progress, see above
   * for an explanation.
   */
  smp_wmb();
out:
  files->resize_in_progress = false;
					if (unlikely(files->resize_in_progress)) {
					  - false
					rcu_assign_pointer(fdt->fd[fd], file);
					  - store in the old table - boom.

								Honza

> diff --git a/fs/file.c b/fs/file.c
> index 019fb9acf91b..d065a24980da 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -233,28 +233,54 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
>  	__acquires(files->file_lock)
>  {
>  	struct fdtable *new_fdt, *cur_fdt;
> +	int err = 0;
>  
> +	BUG_ON(files->resize_in_progress);
> +	files->resize_in_progress = true;
>  	spin_unlock(&files->file_lock);
>  	new_fdt = alloc_fdtable(nr + 1);
>  
> -	/* make sure all fd_install() have seen resize_in_progress
> -	 * or have finished their rcu_read_lock_sched() section.
> +	/*
> +	 * Synchronize against the lockless fd_install().
> +	 *
> +	 * All work in that routine is enclosed with RCU sched section.
> +	 *
> +	 * We published ->resize_in_progress = true with the unlock above,
> +	 * which makes new arrivals bail to locked operation.
> +	 *
> +	 * Now we only need to wait for CPUs which did not observe the flag to
> +	 * leave and make sure their store to the fd table got published.
> +	 *
> +	 * We do it with synchronize_rcu(), which both waits for all sections to
> +	 * finish (taking care of the first part) and guarantees all CPUs issued a
> +	 * full fence (taking care of the second part).
> +	 *
> +	 * Note we know there is nobody to wait for if we are dealing with a
> +	 * single-threaded process.
>  	 */
>  	if (atomic_read(&files->count) > 1)
>  		synchronize_rcu();
>  
>  	spin_lock(&files->file_lock);
> -	if (IS_ERR(new_fdt))
> -		return PTR_ERR(new_fdt);
> +	if (IS_ERR(new_fdt)) {
> +		err = PTR_ERR(new_fdt);
> +		goto out;
> +	}
>  	cur_fdt = files_fdtable(files);
>  	BUG_ON(nr < cur_fdt->max_fds);
>  	copy_fdtable(new_fdt, cur_fdt);
>  	rcu_assign_pointer(files->fdt, new_fdt);
>  	if (cur_fdt != &files->fdtab)
>  		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
> -	/* coupled with smp_rmb() in fd_install() */
> +
> +	/*
> +	 * Publish everything before we unset ->resize_in_progress, see above
> +	 * for an explanation.
> +	 */
>  	smp_wmb();
> -	return 0;
> +out:
> +	files->resize_in_progress = false;
> +	return err;
>  }
>  
>  /*
> @@ -290,9 +316,7 @@ static int expand_files(struct files_struct *files, unsigned int nr)
>  		return -EMFILE;
>  
>  	/* All good, so we try */
> -	files->resize_in_progress = true;
>  	error = expand_fdtable(files, nr);
> -	files->resize_in_progress = false;
>  
>  	wake_up_all(&files->resize_wait);
>  	return error;
> @@ -629,13 +653,18 @@ EXPORT_SYMBOL(put_unused_fd);
>  
>  void fd_install(unsigned int fd, struct file *file)
>  {
> -	struct files_struct *files = current->files;
> +	struct files_struct *files;
>  	struct fdtable *fdt;
>  
>  	if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
>  		return;
>  
> +	/*
> +	 * Synchronized with expand_fdtable(), see that routine for an
> +	 * explanation.
> +	 */
>  	rcu_read_lock_sched();
> +	files = READ_ONCE(current->files);
>  
>  	if (unlikely(files->resize_in_progress)) {
>  		rcu_read_unlock_sched();
> @@ -646,8 +675,7 @@ void fd_install(unsigned int fd, struct file *file)
>  		spin_unlock(&files->file_lock);
>  		return;
>  	}
> -	/* coupled with smp_wmb() in expand_fdtable() */
> -	smp_rmb();
> +
>  	fdt = rcu_dereference_sched(files->fdt);
>  	BUG_ON(fdt->fd[fd] != NULL);
>  	rcu_assign_pointer(fdt->fd[fd], file);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

