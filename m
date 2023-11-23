Return-Path: <linux-fsdevel+bounces-3591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701FD7F6B54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD3AB20ECE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABAF4404;
	Fri, 24 Nov 2023 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YFYunEb+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfD1hGy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2B1BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:21:40 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84E6221AC6;
	Thu, 23 Nov 2023 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700759639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPy8QowslBncJ/fqwfv631jp+SVvrXILxtvwP9PI+Ic=;
	b=YFYunEb+cn3RQ7I4otvtMP4eYarQu41h9qf3aDJ0n0ruPD5xTM2+FaZkaE+ut5ABNd8RAS
	l65nu3bxtrvKmir7yYB/Fs/3GoUSPG8G4l+iyEZ1LWmQ0/G6xNGDzB8q172dcHOkMExwaw
	DobJJv9/iLSOhMGAScffoio6ozdZDV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700759639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPy8QowslBncJ/fqwfv631jp+SVvrXILxtvwP9PI+Ic=;
	b=QfD1hGy0j0F8PyDTMMwvGnAaYITFVACl/oIP5v0q14g0LGibe8Qu6xo2BBvIYeC3nCqj5n
	o2OkFNUIprte3lAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DEE4132F8;
	Thu, 23 Nov 2023 17:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yNTJGleIX2UJKAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 17:13:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 707CBA07D9; Thu, 23 Nov 2023 18:13:58 +0100 (CET)
Date: Thu, 23 Nov 2023 18:13:58 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/16] fs: move permission hook out of do_iter_read()
Message-ID: <20231123171358.yfbo6zcnovyf2vd5@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-13-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-13-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 4.41
X-Spamd-Result: default: False [4.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.52)[0.839];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.00)[95.07%]

On Wed 22-11-23 14:27:11, Amir Goldstein wrote:
> We recently moved fsnotify hook, rw_verify_area() and other checks from
> do_iter_write() out to its two callers.
> 
> for consistency, do the same thing for do_iter_read() - move the
  ^^^ For

> rw_verify_area() checks and fsnotify hook to the callers vfs_iter_read()
> and vfs_readv().
> 
> This aligns those vfs helpers with the pattern used in vfs_read() and
> vfs_iocb_iter_read() and the vfs write helpers, where all the checks are
> in the vfs helpers and the do_* or call_* helpers do the work.
> 
> This is needed for fanotify "pre content" events.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Also one nit below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +/*
> + * Low-level helpers don't perform rw sanity checks.
> + * The caller is responsible for that.
> + */
>  static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
> -		loff_t *pos, rwf_t flags)
> +			    loff_t *pos, rwf_t flags)
> +{
> +	if (file->f_op->read_iter)
> +		return do_iter_readv_writev(file, iter, pos, READ, flags);
> +
> +	return do_loop_readv_writev(file, iter, pos, READ, flags);
> +}

Similarly as with do_iter_write() I don't think there's much point in this
helper when there's actually only one real user, the other one can just
call do_iter_readv_writev().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

