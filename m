Return-Path: <linux-fsdevel+bounces-34799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999E9C8D7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93321F22F7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118913D531;
	Thu, 14 Nov 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qzCjYVvh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0wd5stp0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z2wk7+RR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6IyzxITT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A7A95C;
	Thu, 14 Nov 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596496; cv=none; b=EToHNzmEaZUetAT3Lw4YUC/2mTWZ4qaXUh94D/QYJs5HXBEVAKKzLJSN9vX8KOGNYXiD6fiMrJgTWD5stKSCG2krgEvQxFjquTAF3KcYZP5MhrRbTYDKiLCRQ1FR0Eo0qHhYVu1SIQ8GaF7rkaK+VMVNdEKo8KsJHEsYqpn7kq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596496; c=relaxed/simple;
	bh=87NzupB6ncCHIVmqDwoLcrZ9g2TeR6v1AYQ5bTk7byU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDrjXOzU5OyL/oF4qIwzJpR17Naw47hmkjy7fpITG5Zz4Fumqp6xZ3sBad4HKtJUb5uJRBHh5ZZMjvrKkw6FTMjWE9mGP/L83lJQQCn/3nyczwiQposfxn3Y/Yu6FOlfOzye8jo7gspPxxxCKM7fhH4SLwuRVWM02L7aM/J53dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qzCjYVvh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0wd5stp0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z2wk7+RR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6IyzxITT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBB0A1F38F;
	Thu, 14 Nov 2024 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731596492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOkgEKZwGt7e3JeGaWOfoWvvbqGAC0Wgb9QpxyCmJ5Q=;
	b=qzCjYVvhu+QfKL50FEb8/3whUikamdA5FGUZ2QboApYNf6agssDJRK/PU+GfEvDPZ1wqcJ
	IZtvqoGSAa8tLuJAuvsj2+oTnFcbZ0/8ytWhad5oGQXW3dC0b2Bv14o32nBA/1OJ/90KCf
	Ik7VQRZqvd3DHLUyjGnQ57JD7aQdJ2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731596492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOkgEKZwGt7e3JeGaWOfoWvvbqGAC0Wgb9QpxyCmJ5Q=;
	b=0wd5stp0gMvsKH7Mk24JfNc4I3q0c2B+kTZqarrMyz0EfR+c4vdF64U91GOyscEhEodDer
	WcgfTknV/W0/9HDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z2wk7+RR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6IyzxITT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731596491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOkgEKZwGt7e3JeGaWOfoWvvbqGAC0Wgb9QpxyCmJ5Q=;
	b=z2wk7+RRZRVFCtTzgrFxgGXmn5UGzMMKXDooO5Rxj6Smjgw19vXHCxLSlRfDvgHOD8H3Uu
	K9NT70/mhgxSA4lOC/xETXXK6Hz2ORiGJwpva7oeSS6k1QVFVssxP8nfvknhYiDaLdGVSn
	8etHSDR2xuzoanMqswo3cWKt4xEr1Vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731596491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOkgEKZwGt7e3JeGaWOfoWvvbqGAC0Wgb9QpxyCmJ5Q=;
	b=6IyzxITTU0qTKg5sEMi+esXkqmnPw5iy9nXqCbZNZDGttOWIoUitYww86SDmHNfg5S2g9G
	4euMM4xqUXylbvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCC9113721;
	Thu, 14 Nov 2024 15:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OCoTLssQNmdXfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Nov 2024 15:01:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45680A0962; Thu, 14 Nov 2024 16:01:27 +0100 (CET)
Date: Thu, 14 Nov 2024 16:01:27 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission
 events
Message-ID: <20241114150127.clibtrycjd3ke5ld@quack3>
References: <cover.1731433903.git.josef@toxicpanda.com>
 <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
 <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
 <CAOQ4uxjeWrJtcgsC0YEmjdMPBOOpfz=zQ9VuG=z-Sc6WYNJOjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjeWrJtcgsC0YEmjdMPBOOpfz=zQ9VuG=z-Sc6WYNJOjQ@mail.gmail.com>
X-Rspamd-Queue-Id: CBB0A1F38F
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 13-11-24 19:49:31, Amir Goldstein wrote:
> From 7a2cd74654a53684d545b96c57c9091e420b3add Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Tue, 12 Nov 2024 13:46:08 +0100
> Subject: [PATCH] fsnotify: opt-in for permission events at file open time
> 
> Legacy inotify/fanotify listeners can add watches for events on inode,
> parent or mount and expect to get events (e.g. FS_MODIFY) on files that
> were already open at the time of setting up the watches.
> 
> fanotify permission events are typically used by Anti-malware sofware,
> that is watching the entire mount and it is not common to have more that
> one Anti-malware engine installed on a system.
> 
> To reduce the overhead of the fsnotify_file_perm() hooks on every file
> access, relax the semantics of the legacy FAN_ACCESS_PERM event to generate
> events only if there were *any* permission event listeners on the
> filesystem at the time that the file was opened.
> 
> The new semantic is implemented by extending the FMODE_NONOTIFY bit into
> two FMODE_NONOTIFY_* bits, that are used to store a mode for which of the
> events types to report.
> 
> This is going to apply to the new fanotify pre-content events in order
> to reduce the cost of the new pre-content event vfs hooks.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Couple of notes below.

> diff --git a/fs/open.c b/fs/open.c
> index 226aca8c7909..194c2c8d8cd4 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -901,7 +901,7 @@ static int do_dentry_open(struct file *f,
>  	f->f_sb_err = file_sample_sb_err(f);
>  
>  	if (unlikely(f->f_flags & O_PATH)) {
> -		f->f_mode = FMODE_PATH | FMODE_OPENED;
> +		f->f_mode = FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
>  		f->f_op = &empty_fops;
>  		return 0;
>  	}
> @@ -929,6 +929,12 @@ static int do_dentry_open(struct file *f,
>  	if (error)
>  		goto cleanup_all;
>  
> +	/*
> +	 * Set FMODE_NONOTIFY_* bits according to existing permission watches.
> +	 * If FMODE_NONOTIFY was already set for an fanotify fd, this doesn't
> +	 * change anything.
> +	 */
> +	f->f_mode |= fsnotify_file_mode(f);

Maybe it would be obvious to do this like:

	file_set_fsnotify_mode(f);

Because currently this depends on the details of how exactly FMODE_NONOTIFY
is encoded.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 70359dd669ff..dd583ce7dba8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -173,13 +173,14 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  
>  #define	FMODE_NOREUSE		((__force fmode_t)(1 << 23))
>  
> -/* FMODE_* bit 24 */
> -
>  /* File is embedded in backing_file object */
> -#define FMODE_BACKING		((__force fmode_t)(1 << 25))
> +#define FMODE_BACKING		((__force fmode_t)(1 << 24))
> +
> +/* File shouldn't generate fanotify pre-content events */
> +#define FMODE_NONOTIFY_HSM	((__force fmode_t)(1 << 25))
>  
> -/* File was opened by fanotify and shouldn't generate fanotify events */
> -#define FMODE_NONOTIFY		((__force fmode_t)(1 << 26))
> +/* File shouldn't generate fanotify permission events */
> +#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))
>  
>  /* File is capable of returning -EAGAIN if I/O will block */
>  #define FMODE_NOWAIT		((__force fmode_t)(1 << 27))
> @@ -190,6 +191,21 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File does not contribute to nr_files count */
>  #define FMODE_NOACCOUNT		((__force fmode_t)(1 << 29))
>  
> +/*
> + * The two FMODE_NONOTIFY_ bits used together have a special meaning of
> + * not reporting any events at all including non-permission events.
> + * These are the possible values of FMODE_NOTIFY(f->f_mode) and their meaning:
> + *
> + * FMODE_NONOTIFY_HSM - suppress only pre-content events.
> + * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
> + * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
> + */
> +#define FMODE_NONOTIFY_MASK \
> +	(FMODE_NONOTIFY_HSM | FMODE_NONOTIFY_PERM)
> +#define FMODE_NONOTIFY FMODE_NONOTIFY_MASK
> +#define FMODE_NOTIFY(mode) \
> +	((mode) & FMODE_NONOTIFY_MASK)

This looks a bit error-prone to me (FMODE_NONOTIFY looks like another FMODE
flag but in fact it is not which is an invitation for subtle bugs) and the
tests below which are sometimes done as (FMODE_NOTIFY(mode) == xxx) and
sometimes as (file->f_mode & xxx) are inconsistent and confusing (unless you
understand what's happening under the hood).

So how about defining macros like FMODE_FSNOTIFY_NORMAL(),
FMODE_FSNOTIFY_CONTENT() and FMODE_FSNOTIFY_PRE_CONTENT() which evaluate to
true if we should be sending normal/content/pre-content events to the file.
With appropriate comments this should make things more obvious.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

