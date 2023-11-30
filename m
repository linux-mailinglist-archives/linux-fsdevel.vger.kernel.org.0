Return-Path: <linux-fsdevel+bounces-4454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5497FF9BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0753E1C20C09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FA35A0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C3B1703
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:49:12 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88DCF21B5F;
	Thu, 30 Nov 2023 16:49:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 73D6B138E5;
	Thu, 30 Nov 2023 16:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qGY4HAa9aGWyGAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 16:49:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8A5BA06F9; Thu, 30 Nov 2023 17:49:09 +0100 (CET)
Date: Thu, 30 Nov 2023 17:49:09 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs: use do_splice_direct() for nfsd/ksmbd
 server-side-copy
Message-ID: <20231130164909.vqafeznxlyxbqsmh@quack3>
References: <20231130141624.3338942-1-amir73il@gmail.com>
 <20231130141624.3338942-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130141624.3338942-4-amir73il@gmail.com>
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [4.39 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 4.39
X-Rspamd-Queue-Id: 88DCF21B5F

On Thu 30-11-23 16:16:24, Amir Goldstein wrote:
> nfsd/ksmbd call vfs_copy_file_range() with flag COPY_FILE_SPLICE to
> perform kernel copy between two files on any two filesystems.
> 
> Splicing input file, while holding file_start_write() on the output file
> which is on a different sb, posses a risk for fanotify related deadlocks.
> 
> We only need to call splice_file_range() from within the context of
> ->copy_file_range() filesystem methods with file_start_write() held.
> 
> To avoid the possible deadlocks, always use do_splice_direct() instead of
> splice_file_range() for the kernel copy fallback in vfs_copy_file_range()
> without holding file_start_write().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0bc99f38e623..e0c2c1b5962b 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1421,6 +1421,10 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				size_t len, unsigned int flags)
>  {
> +	/* May only be called from within ->copy_file_range() methods */
> +	if (WARN_ON_ONCE(flags))
> +		return -EINVAL;
> +
>  	return splice_file_range(file_in, &pos_in, file_out, &pos_out,
>  				 min_t(size_t, len, MAX_RW_COUNT));
>  }
> @@ -1541,19 +1545,22 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  		ret = file_out->f_op->copy_file_range(file_in, pos_in,
>  						      file_out, pos_out,
>  						      len, flags);
> -		goto done;
> -	}
> -
> -	if (!splice && file_in->f_op->remap_file_range &&
> -	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
> +	} else if (!splice && file_in->f_op->remap_file_range &&
> +		   file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
>  		ret = file_in->f_op->remap_file_range(file_in, pos_in,
>  				file_out, pos_out,
>  				min_t(loff_t, MAX_RW_COUNT, len),
>  				REMAP_FILE_CAN_SHORTEN);
> -		if (ret > 0)
> -			goto done;
> +		/* fallback to splice */
> +		if (ret <= 0)
> +			splice = true;
>  	}
>  
> +	file_end_write(file_out);
> +
> +	if (!splice)
> +		goto done;
> +
>  	/*
>  	 * We can get here for same sb copy of filesystems that do not implement
>  	 * ->copy_file_range() in case filesystem does not support clone or in
> @@ -1565,11 +1572,16 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	 * and which filesystems do not, that will allow userspace tools to
>  	 * make consistent desicions w.r.t using copy_file_range().
>  	 *
> -	 * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE.
> +	 * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE
> +	 * for server-side-copy between any two sb.
> +	 *
> +	 * In any case, we call do_splice_direct() and not splice_file_range(),
> +	 * without file_start_write() held, to avoid possible deadlocks related
> +	 * to splicing from input file, while file_start_write() is held on
> +	 * the output file on a different sb.
>  	 */
> -	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -				      flags);
> -
> +	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> +			       min_t(size_t, len, MAX_RW_COUNT), 0);
>  done:
>  	if (ret > 0) {
>  		fsnotify_access(file_in);
> @@ -1581,8 +1593,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	inc_syscr(current);
>  	inc_syscw(current);
>  
> -	file_end_write(file_out);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL(vfs_copy_file_range);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

