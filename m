Return-Path: <linux-fsdevel+bounces-3580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB98F7F6B36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE361C20B7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402B23CF;
	Fri, 24 Nov 2023 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f6owK/fp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KFtcfRqo"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 20:18:30 PST
Received: from smtp-out2.suse.de (unknown [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37F1BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:18:29 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE0141FE1B;
	Thu, 23 Nov 2023 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700759299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+28FxGgiLkKyXRTt/xu9lFDYld+Ve8ocMcw9SVYksbY=;
	b=f6owK/fpVRrl25TVnM1XT+R9RS9NV0oCzCRbJqLi7/RHVcqVtoLaAv6oa2QWVZpa2+XZzC
	ceVvIOrV/rrmRvUYupVLjMA8R7ad2XAtr4uTYuUcZ9596ddcc/2YmpjZcG+KqC3ygWvP4/
	7UJHxnsxoziW9dqNAr7JPRQZnhnzSwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700759299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+28FxGgiLkKyXRTt/xu9lFDYld+Ve8ocMcw9SVYksbY=;
	b=KFtcfRqokpySbxFUt72GNp+6UwE/HqyzkED90xdpr9FOFZUJa2cQd3RAESYR+6tgGErj3f
	gupt0iqE8vU51WDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 974B813A82;
	Thu, 23 Nov 2023 17:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yNroJAOHX2VnJgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 17:08:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04DEDA07D9; Thu, 23 Nov 2023 18:08:14 +0100 (CET)
Date: Thu, 23 Nov 2023 18:08:14 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 11/16] fs: move permission hook out of do_iter_write()
Message-ID: <20231123170814.nvw5jflqzbwcbnaj@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-12-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-12-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.40
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,toxicpanda.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[31.60%]

On Wed 22-11-23 14:27:10, Amir Goldstein wrote:
> In many of the vfs helpers, the rw_verity_area() checks are called before
					^^ verify

> taking sb_start_write(), making them "start-write-safe".
> do_iter_write() is an exception to this rule.
> 
> do_iter_write() has two callers - vfs_iter_write() and vfs_writev().
> Move rw_verify_area() and other checks from do_iter_write() out to
> its callers to make them "start-write-safe".
> 
> Move also the fsnotify_modify() hook to align with similar pattern
> used in vfs_write() and other vfs helpers.
> 
> This is needed for fanotify "pre content" events.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just one more nit below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


> diff --git a/fs/read_write.c b/fs/read_write.c
> index 87ca50f16a23..6c40468efe19 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -852,28 +852,10 @@ EXPORT_SYMBOL(vfs_iter_read);
>  static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
>  			     loff_t *pos, rwf_t flags)
>  {
> -	size_t tot_len;
> -	ssize_t ret = 0;
> -
> -	if (!(file->f_mode & FMODE_WRITE))
> -		return -EBADF;
> -	if (!(file->f_mode & FMODE_CAN_WRITE))
> -		return -EINVAL;
> -
> -	tot_len = iov_iter_count(iter);
> -	if (!tot_len)
> -		return 0;
> -	ret = rw_verify_area(WRITE, file, pos, tot_len);
> -	if (ret < 0)
> -		return ret;
> -
>  	if (file->f_op->write_iter)
> -		ret = do_iter_readv_writev(file, iter, pos, WRITE, flags);
> -	else
> -		ret = do_loop_readv_writev(file, iter, pos, WRITE, flags);
> -	if (ret > 0)
> -		fsnotify_modify(file);
> -	return ret;
> +		return do_iter_readv_writev(file, iter, pos, WRITE, flags);
> +
> +	return do_loop_readv_writev(file, iter, pos, WRITE, flags);
>  }

Since do_iter_write() is now trivial and has only two callers, one of which
has made sure file->f_op->write_iter != NULL, can we perhaps just fold this 
into the callers? One less wrapper in the maze...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

