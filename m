Return-Path: <linux-fsdevel+bounces-3585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341C7F6B3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DF61C20C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6BA611A;
	Fri, 24 Nov 2023 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p4zgPMgp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yAPONbwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (unknown [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64353101
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:19:34 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFF471FDB0;
	Thu, 23 Nov 2023 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700757357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=452ZiCWI+V1NFW8rf/obABSrRk7vsm/2AzYgaZkUcPY=;
	b=p4zgPMgpvSkj2Aw6EK++ir8s1BVqiHfB2ic2Q7FUUHXiPoxYly5bWTBs4FHxHfT84kyR3z
	vyDCNPYcAAUwya4kuTB52izSm2+1AruhP/UV2stELUU7730/ud17O97bUyKvRrDEncEowM
	tOceKVssRILp8zGQh7e+9efH0N7aihE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700757357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=452ZiCWI+V1NFW8rf/obABSrRk7vsm/2AzYgaZkUcPY=;
	b=yAPONbwYSb4V8tlxjwb71Del9nl4qRJxQZUDyfHIhMYI6vCiJp2P6qtmQPrDH8qnsF5CNB
	zhICDZ0VJH19q0AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BC5CC13A82;
	Thu, 23 Nov 2023 16:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rS6uLW1/X2WwHAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:35:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DCA78A07D9; Thu, 23 Nov 2023 17:35:56 +0100 (CET)
Date: Thu, 23 Nov 2023 17:35:56 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 03/16] splice: move permission hook out of
 splice_direct_to_actor()
Message-ID: <20231123163556.3cal6j2w4wd2ybbv@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-4-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.60
X-Spam-Level: 
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed 22-11-23 14:27:02, Amir Goldstein wrote:
> vfs_splice_read() has a permission hook inside rw_verify_area() and
> it is called from do_splice_direct() -> splice_direct_to_actor().
> 
> The callers of do_splice_direct() (e.g. vfs_copy_file_range()) already
> call rw_verify_area() for the entire range, but the other caller of
> splice_direct_to_actor() (nfsd) does not.
> 
> Add the rw_verify_area() checks in nfsd_splice_read() and use a
> variant of vfs_splice_read() without rw_verify_area() check in
> splice_direct_to_actor() to avoid the redundant rw_verify_area() checks.
> 
> This is needed for fanotify "pre content" events.
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfsd/vfs.c |  5 ++++-
>  fs/splice.c   | 58 +++++++++++++++++++++++++++++++--------------------
>  2 files changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index fbbea7498f02..5d704461e3b4 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1046,7 +1046,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	ssize_t host_err;
>  
>  	trace_nfsd_read_splice(rqstp, fhp, offset, *count);
> -	host_err = splice_direct_to_actor(file, &sd, nfsd_direct_splice_actor);
> +	host_err = rw_verify_area(READ, file, &offset, *count);
> +	if (!host_err)
> +		host_err = splice_direct_to_actor(file, &sd,
> +						  nfsd_direct_splice_actor);
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> diff --git a/fs/splice.c b/fs/splice.c
> index 6e917db6f49a..6fc2c27e9520 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -944,27 +944,15 @@ static void do_splice_eof(struct splice_desc *sd)
>  		sd->splice_eof(sd);
>  }
>  
> -/**
> - * vfs_splice_read - Read data from a file and splice it into a pipe
> - * @in:		File to splice from
> - * @ppos:	Input file offset
> - * @pipe:	Pipe to splice to
> - * @len:	Number of bytes to splice
> - * @flags:	Splice modifier flags (SPLICE_F_*)
> - *
> - * Splice the requested amount of data from the input file to the pipe.  This
> - * is synchronous as the caller must hold the pipe lock across the entire
> - * operation.
> - *
> - * If successful, it returns the amount of data spliced, 0 if it hit the EOF or
> - * a hole and a negative error code otherwise.
> +/*
> + * Callers already called rw_verify_area() on the entire range.
> + * No need to call it for sub ranges.
>   */
> -long vfs_splice_read(struct file *in, loff_t *ppos,
> -		     struct pipe_inode_info *pipe, size_t len,
> -		     unsigned int flags)
> +static long do_splice_read(struct file *in, loff_t *ppos,
> +			   struct pipe_inode_info *pipe, size_t len,
> +			   unsigned int flags)
>  {
>  	unsigned int p_space;
> -	int ret;
>  
>  	if (unlikely(!(in->f_mode & FMODE_READ)))
>  		return -EBADF;
> @@ -975,10 +963,6 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
>  	p_space = pipe->max_usage - pipe_occupancy(pipe->head, pipe->tail);
>  	len = min_t(size_t, len, p_space << PAGE_SHIFT);
>  
> -	ret = rw_verify_area(READ, in, ppos, len);
> -	if (unlikely(ret < 0))
> -		return ret;
> -
>  	if (unlikely(len > MAX_RW_COUNT))
>  		len = MAX_RW_COUNT;
>  
> @@ -992,6 +976,34 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
>  		return copy_splice_read(in, ppos, pipe, len, flags);
>  	return in->f_op->splice_read(in, ppos, pipe, len, flags);
>  }
> +
> +/**
> + * vfs_splice_read - Read data from a file and splice it into a pipe
> + * @in:		File to splice from
> + * @ppos:	Input file offset
> + * @pipe:	Pipe to splice to
> + * @len:	Number of bytes to splice
> + * @flags:	Splice modifier flags (SPLICE_F_*)
> + *
> + * Splice the requested amount of data from the input file to the pipe.  This
> + * is synchronous as the caller must hold the pipe lock across the entire
> + * operation.
> + *
> + * If successful, it returns the amount of data spliced, 0 if it hit the EOF or
> + * a hole and a negative error code otherwise.
> + */
> +long vfs_splice_read(struct file *in, loff_t *ppos,
> +		     struct pipe_inode_info *pipe, size_t len,
> +		     unsigned int flags)
> +{
> +	int ret;
> +
> +	ret = rw_verify_area(READ, in, ppos, len);
> +	if (unlikely(ret < 0))
> +		return ret;
> +
> +	return do_splice_read(in, ppos, pipe, len, flags);
> +}
>  EXPORT_SYMBOL_GPL(vfs_splice_read);
>  
>  /**
> @@ -1066,7 +1078,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
>  		size_t read_len;
>  		loff_t pos = sd->pos, prev_pos = pos;
>  
> -		ret = vfs_splice_read(in, &pos, pipe, len, flags);
> +		ret = do_splice_read(in, &pos, pipe, len, flags);
>  		if (unlikely(ret <= 0))
>  			goto read_failure;
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

