Return-Path: <linux-fsdevel+bounces-28376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C3969F25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF721C23CFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2F7462;
	Tue,  3 Sep 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3qqQ6Jf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MLv8NlnV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dxQ83zer";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bd4P2F2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6B1CA69D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370696; cv=none; b=GcFwKr15VmydDRUFwXY7TAW+ITBqUAMACbB7oXcWLtRoXKv6iyDaBq3BL2NvzFRrEhyskT23YK9QkwP5sazMoRASh9xw0h2KXekgNfRETwVtF3Wan+rTtpVD4isBFtD4M/1wvGFcqzVGcf9TI2Fg+sOCBGh0JoB92IHe2PisWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370696; c=relaxed/simple;
	bh=rVIF6Cdw9Wk7eGIwWqfkrj1bTz0VY4hpVvKRybBtZ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siW3pi6UA4/5I5aO/Mrvqw59Z9cJdg4WGyY5DQQyT9fqnrbbiTyYBldF2nWU1tDjBzvG5An/2dRUZDylWxq7cwRMCvPNlKm7q7hZC20NtA0bw2BBAf3xBJUiAaAd0fBuDDAOwvZmojCsH8yKLIF8XU9Jrqh1bfcEDX65g4O9ZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3qqQ6Jf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MLv8NlnV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dxQ83zer; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bd4P2F2t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9040C1F37E;
	Tue,  3 Sep 2024 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cs9klBlLkQM2py7fLz90OnxAA0xqzYpvuHQCW/ra0vA=;
	b=O3qqQ6JfAOr7UEvt8wh/y6XRayUQdGg6HHEANCU35ExAbyVfQnpcfC6GSTMK5YaV+HciFm
	uqM44/LwPnorxXdBItDTqeidmnG8xG9uz6VdnDDT/hMMrk7tyCls7+y2SsNox2p81cP7Ru
	b3i9jq1qHyEY0Whv4N99SEKkYcePZ5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cs9klBlLkQM2py7fLz90OnxAA0xqzYpvuHQCW/ra0vA=;
	b=MLv8NlnVzQA1fKfUUh3wBMAcnqKkEGUtBHD6RZBd9QD1ggn+ZsPEwdRPq5WQM9vqdB5fY/
	KYbbtuTXHXu2JLCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dxQ83zer;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bd4P2F2t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cs9klBlLkQM2py7fLz90OnxAA0xqzYpvuHQCW/ra0vA=;
	b=dxQ83zergogGxtmY03/ssfRb6NlShX2t7Q364WtiS8EzCb0l4rfYnvDLUOI/iIQlXoy+Gz
	RKVTLFR76k+N/Irjbf2ewI3ZPpJXkT9ICIINannxXVhZpAgmt0ijdn9Xa0ZUo/YefKRwKU
	Fo626v+7s5MGJM5GH8IROT2RkY5IPSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cs9klBlLkQM2py7fLz90OnxAA0xqzYpvuHQCW/ra0vA=;
	b=bd4P2F2tXtE0ZqNSjJ4cnYgTink8bdrKB6MLTLSGDsFFbb5uJeMCWuwSqQ5zv6kxPcgQTD
	Zp9mZrQqwW+wJKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 823C813A52;
	Tue,  3 Sep 2024 13:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1DzKH0MR12aZSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:38:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4013BA096C; Tue,  3 Sep 2024 15:38:11 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:38:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 16/20] ufs: store cookie in private data
Message-ID: <20240903133811.njor6s7u2jg644px@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-16-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-16-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: 9040C1F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 30-08-24 15:04:57, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ufs/dir.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 61f25d3cf3f7..335f0ae529b4 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -435,7 +435,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  	unsigned long n = pos >> PAGE_SHIFT;
>  	unsigned long npages = dir_pages(inode);
>  	unsigned chunk_mask = ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
> -	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
> +	bool need_revalidate = !inode_eq_iversion(inode, *(u64 *)file->private_data);
>  	unsigned flags = UFS_SB(sb)->s_flags;
>  
>  	UFSD("BEGIN\n");
> @@ -462,7 +462,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
>  				ctx->pos = (n<<PAGE_SHIFT) + offset;
>  			}
> -			file->f_version = inode_query_iversion(inode);
> +			*(u64 *)file->private_data = inode_query_iversion(inode);
>  			need_revalidate = false;
>  		}
>  		de = (struct ufs_dir_entry *)(kaddr+offset);
> @@ -646,9 +646,31 @@ int ufs_empty_dir(struct inode * inode)
>  	return 0;
>  }
>  
> +static int ufs_dir_open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = kzalloc(sizeof(u64), GFP_KERNEL);
> +	if (!file->private_data)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static int ufs_dir_release(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
> +static loff_t ufs_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	return generic_llseek_cookie(file, offset, whence,
> +				     (u64 *)file->private_data);
> +}
> +
>  const struct file_operations ufs_dir_operations = {
> +	.open		= ufs_dir_open,
> +	.release	= ufs_dir_release,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= ufs_readdir,
>  	.fsync		= generic_file_fsync,
> -	.llseek		= generic_file_llseek,
> +	.llseek		= ufs_dir_llseek,
>  };
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

