Return-Path: <linux-fsdevel+bounces-28370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239D969EFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275031C22FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42761A7270;
	Tue,  3 Sep 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9J6B0aw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="np5v9vPm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9J6B0aw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="np5v9vPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806341CA6AF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370018; cv=none; b=gOzb65Y40Z2osuAbZMgpLMcKOhc6ZtK7LvztxNL4uu+4y3/G4pNGKtH5xHAZF5zkEDHlHd7JofnJeGaZ51nS5+7p+F5uvX4XzD4n94iixmxGak2tyeAoQBItG+amkrP1He9f90VPMIGFN2za0tvksz15bKaZpwTPYQBMt+rkpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370018; c=relaxed/simple;
	bh=wm1DDu8fSYVfZudNCBrFOjD12i38yrH1ajRUVr6DvYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq3Z+47HCd4Y0etW9Vhe25Rhs+1dBWvLNtWWVlZC2HFyizrR8QGE77PvT9xBP9wySLVdMPRP9e4m6Nons1+EjvMBQ4Vt2i/gS0c06LqKsisGRhBr0s0UFNvQNA/uA0qxfBte4/SQaEa+bF8HL0ijvilEHgmDEiSY85b9Rcp8MXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9J6B0aw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=np5v9vPm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9J6B0aw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=np5v9vPm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99E7C1F385;
	Tue,  3 Sep 2024 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aD+R6ECMuyl6qcNI165/k3hCY2Qq3I3Y2YL4rYmFz5I=;
	b=s9J6B0awV+1DkCnqHJfryoHqrTwQ8VFXTpltFuJWBcoFkCTq6zPaVlt3GH5vyqq7AkG+D4
	GLHRR2Y9RHnEkwlcBslUh8x7vxoNIgdHDMFkpGwq00xXorje5evykkpGTdbWYXwXy95HV8
	+qrj9StNTJg5O4AHGCuclAgZ18RPEtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aD+R6ECMuyl6qcNI165/k3hCY2Qq3I3Y2YL4rYmFz5I=;
	b=np5v9vPmyX1DcVrZcDEmidvp7l32ITfmND/WiGHbCGHLzNObh3LpEia6w+3wgnlAfDYymr
	gm1OZL6WEGUUbDDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s9J6B0aw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=np5v9vPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aD+R6ECMuyl6qcNI165/k3hCY2Qq3I3Y2YL4rYmFz5I=;
	b=s9J6B0awV+1DkCnqHJfryoHqrTwQ8VFXTpltFuJWBcoFkCTq6zPaVlt3GH5vyqq7AkG+D4
	GLHRR2Y9RHnEkwlcBslUh8x7vxoNIgdHDMFkpGwq00xXorje5evykkpGTdbWYXwXy95HV8
	+qrj9StNTJg5O4AHGCuclAgZ18RPEtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aD+R6ECMuyl6qcNI165/k3hCY2Qq3I3Y2YL4rYmFz5I=;
	b=np5v9vPmyX1DcVrZcDEmidvp7l32ITfmND/WiGHbCGHLzNObh3LpEia6w+3wgnlAfDYymr
	gm1OZL6WEGUUbDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F7AB13A52;
	Tue,  3 Sep 2024 13:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZsAZH54O12YYRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:26:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19E65A096C; Tue,  3 Sep 2024 15:26:39 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:26:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 09/20] affs: store cookie in private data
Message-ID: <20240903132639.o2gvza4tfuy7i5tb@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-9-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-9-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: 99E7C1F385
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:04:50, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/affs/dir.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/affs/dir.c b/fs/affs/dir.c
> index b2bf7016e1b3..bd40d5f08810 100644
> --- a/fs/affs/dir.c
> +++ b/fs/affs/dir.c
> @@ -17,13 +17,44 @@
>  #include <linux/iversion.h>
>  #include "affs.h"
>  
> +struct affs_dir_data {
> +	unsigned long ino;
> +	u64 cookie;
> +};
> +
>  static int affs_readdir(struct file *, struct dir_context *);
>  
> +static loff_t affs_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	struct affs_dir_data *data = file->private_data;
> +
> +	return generic_llseek_cookie(file, offset, whence, &data->cookie);
> +}
> +
> +static int affs_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct affs_dir_data	*data;
> +
> +	data = kzalloc(sizeof(struct affs_dir_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	file->private_data = data;
> +	return 0;
> +}
> +
> +static int affs_dir_release(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
>  const struct file_operations affs_dir_operations = {
> +	.open		= affs_dir_open,
>  	.read		= generic_read_dir,
> -	.llseek		= generic_file_llseek,
> +	.llseek		= affs_dir_llseek,
>  	.iterate_shared	= affs_readdir,
>  	.fsync		= affs_file_fsync,
> +	.release	= affs_dir_release,
>  };
>  
>  /*
> @@ -45,6 +76,7 @@ static int
>  affs_readdir(struct file *file, struct dir_context *ctx)
>  {
>  	struct inode		*inode = file_inode(file);
> +	struct affs_dir_data	*data = file->private_data;
>  	struct super_block	*sb = inode->i_sb;
>  	struct buffer_head	*dir_bh = NULL;
>  	struct buffer_head	*fh_bh = NULL;
> @@ -59,7 +91,7 @@ affs_readdir(struct file *file, struct dir_context *ctx)
>  	pr_debug("%s(ino=%lu,f_pos=%llx)\n", __func__, inode->i_ino, ctx->pos);
>  
>  	if (ctx->pos < 2) {
> -		file->private_data = (void *)0;
> +		data->ino = 0;
>  		if (!dir_emit_dots(file, ctx))
>  			return 0;
>  	}
> @@ -80,8 +112,8 @@ affs_readdir(struct file *file, struct dir_context *ctx)
>  	/* If the directory hasn't changed since the last call to readdir(),
>  	 * we can jump directly to where we left off.
>  	 */
> -	ino = (u32)(long)file->private_data;
> -	if (ino && inode_eq_iversion(inode, file->f_version)) {
> +	ino = data->ino;
> +	if (ino && inode_eq_iversion(inode, data->cookie)) {
>  		pr_debug("readdir() left off=%d\n", ino);
>  		goto inside;
>  	}
> @@ -131,8 +163,8 @@ affs_readdir(struct file *file, struct dir_context *ctx)
>  		} while (ino);
>  	}
>  done:
> -	file->f_version = inode_query_iversion(inode);
> -	file->private_data = (void *)(long)ino;
> +	data->cookie = inode_query_iversion(inode);
> +	data->ino = ino;
>  	affs_brelse(fh_bh);
>  
>  out_brelse_dir:
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

