Return-Path: <linux-fsdevel+bounces-28371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE97969F01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B6DB21BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5341A7270;
	Tue,  3 Sep 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UKIeebtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="877IFc6t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UKIeebtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="877IFc6t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62311CA6AF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370076; cv=none; b=Q5WUrnTLM5lvQRAKRUKQnh+H1EBcbMxUzEe5HIOWXnc3hFuoLzmhsCMelFx/b9OwRljOnIgvTeQEMdzdNF18KRutR8fAkbwTTJ751t8y/8U2RGlG/ESaCvUfc3xLlDd1lxZ3sL0lOc+svIxe144vr/ifU9pwychSfhpHy+mQvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370076; c=relaxed/simple;
	bh=0uvae2z2Mti71q/e2gYwI4AUqfUTb+ebiUj0Gbs5Nnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp07fr7tXAuEwHi6fLtyxGd8t5nJujM/9JZIJVEGHgc8ZDZiIS2/HDul3MROJ3ZPDDPK4ChMXSgAmAC4bvvL6Jn8ylKyX5ppAynDXiPTtED1dK7OZcamnoVwYTR7lg6EAXMJ772rj2DJdxkGJ1b/dvTtJPgQsV/TCnGwGa8vP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UKIeebtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=877IFc6t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UKIeebtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=877IFc6t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8C831F37C;
	Tue,  3 Sep 2024 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLwdUqHOTLyAzBe1KpIaRsmQVOJ0YsatdzKNzOwlQx0=;
	b=UKIeebtNgL0P2axIp/KaZCq9L2u6E84aS0x6zv2fwM8/0o8fixFYEOxs7ELjVQpkpPYcTS
	To+gs5br6fcKdCOSxfXOeHZNwLi0Afz7LBogroKIgPWv5l9vgkzmXuEOjaMkc5axaMRaUh
	gA1v/H51a6czbV/YrAFRBo6hPOibhC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLwdUqHOTLyAzBe1KpIaRsmQVOJ0YsatdzKNzOwlQx0=;
	b=877IFc6tJ6dNevV1tQM34KilKf+FvrcxVm4hsJHgr6Au/yg4pQUOid6Bz2xOFlxWvAddRx
	6LQaAntyFntHf7Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLwdUqHOTLyAzBe1KpIaRsmQVOJ0YsatdzKNzOwlQx0=;
	b=UKIeebtNgL0P2axIp/KaZCq9L2u6E84aS0x6zv2fwM8/0o8fixFYEOxs7ELjVQpkpPYcTS
	To+gs5br6fcKdCOSxfXOeHZNwLi0Afz7LBogroKIgPWv5l9vgkzmXuEOjaMkc5axaMRaUh
	gA1v/H51a6czbV/YrAFRBo6hPOibhC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLwdUqHOTLyAzBe1KpIaRsmQVOJ0YsatdzKNzOwlQx0=;
	b=877IFc6tJ6dNevV1tQM34KilKf+FvrcxVm4hsJHgr6Au/yg4pQUOid6Bz2xOFlxWvAddRx
	6LQaAntyFntHf7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C671F13A52;
	Tue,  3 Sep 2024 13:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sdFuMNgO12ZXRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:27:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D649A096C; Tue,  3 Sep 2024 15:27:52 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:27:52 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 13/20] ocfs2: store cookie in private data
Message-ID: <20240903132752.kk36rwbvlfq47b4u@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-13-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-13-6d3e4816aa7b@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:04:54, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/dir.c  |  3 ++-
>  fs/ocfs2/file.c | 11 +++++++++--
>  fs/ocfs2/file.h |  1 +
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index f0beb173dbba..ccef3f42b333 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -1932,6 +1932,7 @@ int ocfs2_readdir(struct file *file, struct dir_context *ctx)
>  {
>  	int error = 0;
>  	struct inode *inode = file_inode(file);
> +	struct ocfs2_file_private *fp = file->private_data;
>  	int lock_level = 0;
>  
>  	trace_ocfs2_readdir((unsigned long long)OCFS2_I(inode)->ip_blkno);
> @@ -1952,7 +1953,7 @@ int ocfs2_readdir(struct file *file, struct dir_context *ctx)
>  		goto bail_nolock;
>  	}
>  
> -	error = ocfs2_dir_foreach_blk(inode, &file->f_version, ctx, false);
> +	error = ocfs2_dir_foreach_blk(inode, &fp->cookie, ctx, false);
>  
>  	ocfs2_inode_unlock(inode, lock_level);
>  	if (error)
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index ccc57038a977..115ab2172820 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2750,6 +2750,13 @@ static loff_t ocfs2_remap_file_range(struct file *file_in, loff_t pos_in,
>  	return remapped > 0 ? remapped : ret;
>  }
>  
> +static loff_t ocfs2_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	struct ocfs2_file_private *fp = file->private_data;
> +
> +	return generic_llseek_cookie(file, offset, whence, &fp->cookie);
> +}
> +
>  const struct inode_operations ocfs2_file_iops = {
>  	.setattr	= ocfs2_setattr,
>  	.getattr	= ocfs2_getattr,
> @@ -2797,7 +2804,7 @@ const struct file_operations ocfs2_fops = {
>  
>  WRAP_DIR_ITER(ocfs2_readdir) // FIXME!
>  const struct file_operations ocfs2_dops = {
> -	.llseek		= generic_file_llseek,
> +	.llseek		= ocfs2_dir_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= shared_ocfs2_readdir,
>  	.fsync		= ocfs2_sync_file,
> @@ -2843,7 +2850,7 @@ const struct file_operations ocfs2_fops_no_plocks = {
>  };
>  
>  const struct file_operations ocfs2_dops_no_plocks = {
> -	.llseek		= generic_file_llseek,
> +	.llseek		= ocfs2_dir_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= shared_ocfs2_readdir,
>  	.fsync		= ocfs2_sync_file,
> diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
> index 8e53e4ac1120..41e65e45a9f3 100644
> --- a/fs/ocfs2/file.h
> +++ b/fs/ocfs2/file.h
> @@ -20,6 +20,7 @@ struct ocfs2_alloc_context;
>  enum ocfs2_alloc_restarted;
>  
>  struct ocfs2_file_private {
> +	u64			cookie;
>  	struct file		*fp_file;
>  	struct mutex		fp_mutex;
>  	struct ocfs2_lock_res	fp_flock;
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

