Return-Path: <linux-fsdevel+bounces-9691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C18446F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D45B27162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717012FF92;
	Wed, 31 Jan 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jB2QIOd0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+/x0c7F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jB2QIOd0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+/x0c7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E632137C2B;
	Wed, 31 Jan 2024 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724987; cv=none; b=KH3J4Toy7aBvGu6Yve3sMScr1ZiGXFguPuNvfzcPbKZisqxzUxhcCycYSlDtWTCx/siuCIF5p7Ga2pcgT/jZB/68TJWqgjGeY9WgPu0G1YyTXf0GdBLL+DzcxWJGKG7r/VMfOP9pSfpM1Htr41cLeEpk/G6xn4wutRSZQjWF4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724987; c=relaxed/simple;
	bh=jehbr3jenFN2wWI6x7bwcRUBG9d0+jc42U1sqxw1JVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnVASjLv2tSeGoQqr2z67yyRqhKkuYO8RilZs++caD/TwKT7fl5eqteOgQ0WLfkJ08tb5khcbaq1paa4CIKYeLW8+Stn3U0uWKn1ThIT6I3ek4yd9qeximuGIuVuto0NJ2ogIdXbyfl1dCWRJULP3coYQhVPgbuY63Og2WsYNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jB2QIOd0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+/x0c7F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jB2QIOd0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+/x0c7F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1560F1FB95;
	Wed, 31 Jan 2024 18:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64ACI/Pe49voTU3inbe7uTeiWo+qZ1usr4y0w0A0M+c=;
	b=jB2QIOd0NKiKNtgZyCTGmbWymxi5PPJIyTBj+2Uh3aohkxc04isiiEHQmAcfOzaYeo5K/5
	cbsH9jtu09me64SbqTjH519FRT4E3orBHQrMI6o/CDGosiSJ1AJk7Gfpl4fh7y3hENVo7p
	VosbxVP7DiCwKq+cJbSmjshZBl0oCAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64ACI/Pe49voTU3inbe7uTeiWo+qZ1usr4y0w0A0M+c=;
	b=1+/x0c7FILWnaKZxbVcz4H2eYIVfvIV04wGpYMfbPrCcWwd1WNyjv1hCRj8OZaRudC9fkZ
	W1auJesPMXYABoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64ACI/Pe49voTU3inbe7uTeiWo+qZ1usr4y0w0A0M+c=;
	b=jB2QIOd0NKiKNtgZyCTGmbWymxi5PPJIyTBj+2Uh3aohkxc04isiiEHQmAcfOzaYeo5K/5
	cbsH9jtu09me64SbqTjH519FRT4E3orBHQrMI6o/CDGosiSJ1AJk7Gfpl4fh7y3hENVo7p
	VosbxVP7DiCwKq+cJbSmjshZBl0oCAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64ACI/Pe49voTU3inbe7uTeiWo+qZ1usr4y0w0A0M+c=;
	b=1+/x0c7FILWnaKZxbVcz4H2eYIVfvIV04wGpYMfbPrCcWwd1WNyjv1hCRj8OZaRudC9fkZ
	W1auJesPMXYABoBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 04BF7139D9;
	Wed, 31 Jan 2024 18:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uTwnAXiOumVeJAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:16:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86D02A0809; Wed, 31 Jan 2024 19:16:23 +0100 (CET)
Date: Wed, 31 Jan 2024 19:16:23 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 05/34] swap: port block device usage to file
Message-ID: <20240131181623.q5vn5imtdmuvzqgr@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-5-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-5-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jB2QIOd0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="1+/x0c7F"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 1560F1FB95
X-Spam-Flag: NO

On Tue 23-01-24 14:26:22, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/swap.h |  2 +-
>  mm/swapfile.c        | 22 +++++++++++-----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00ddad261..e5b82bc05e60 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -298,7 +298,7 @@ struct swap_info_struct {
>  	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
>  	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
>  	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
> -	struct bdev_handle *bdev_handle;/* open handle of the bdev */
> +	struct file *bdev_file;		/* open handle of the bdev */
>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>  	struct file *swap_file;		/* seldom referenced */
>  	unsigned int old_block_size;	/* seldom referenced */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f..73edd6fed6a2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2532,10 +2532,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	exit_swap_address_space(p->type);
>  
>  	inode = mapping->host;
> -	if (p->bdev_handle) {
> +	if (p->bdev_file) {
>  		set_blocksize(p->bdev, old_block_size);
> -		bdev_release(p->bdev_handle);
> -		p->bdev_handle = NULL;
> +		fput(p->bdev_file);
> +		p->bdev_file = NULL;
>  	}
>  
>  	inode_lock(inode);
> @@ -2765,14 +2765,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  	int error;
>  
>  	if (S_ISBLK(inode->i_mode)) {
> -		p->bdev_handle = bdev_open_by_dev(inode->i_rdev,
> +		p->bdev_file = bdev_file_open_by_dev(inode->i_rdev,
>  				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
> -		if (IS_ERR(p->bdev_handle)) {
> -			error = PTR_ERR(p->bdev_handle);
> -			p->bdev_handle = NULL;
> +		if (IS_ERR(p->bdev_file)) {
> +			error = PTR_ERR(p->bdev_file);
> +			p->bdev_file = NULL;
>  			return error;
>  		}
> -		p->bdev = p->bdev_handle->bdev;
> +		p->bdev = file_bdev(p->bdev_file);
>  		p->old_block_size = block_size(p->bdev);
>  		error = set_blocksize(p->bdev, PAGE_SIZE);
>  		if (error < 0)
> @@ -3208,10 +3208,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	p->percpu_cluster = NULL;
>  	free_percpu(p->cluster_next_cpu);
>  	p->cluster_next_cpu = NULL;
> -	if (p->bdev_handle) {
> +	if (p->bdev_file) {
>  		set_blocksize(p->bdev, p->old_block_size);
> -		bdev_release(p->bdev_handle);
> -		p->bdev_handle = NULL;
> +		fput(p->bdev_file);
> +		p->bdev_file = NULL;
>  	}
>  	inode = NULL;
>  	destroy_swap_extents(p);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

