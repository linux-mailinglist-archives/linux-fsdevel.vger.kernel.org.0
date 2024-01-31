Return-Path: <linux-fsdevel+bounces-9693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAAF8446FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B12926F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42E130E58;
	Wed, 31 Jan 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4lRaEWw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oITydzZY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4lRaEWw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oITydzZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81A12FF73;
	Wed, 31 Jan 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725194; cv=none; b=Q+vilayNa6hgPmK9P9UG3hhTzCn6jbazDSPG2hcHocS4pfGQ1hj4tDzBn5v7vxTwSYvXWPAReMKsch/tonW7RTEE8cg0sInwWs0dmR5P0o0bEf1zrbzb0tzOci7XeyYn5/ZXkul32vYBXJWbyaEOaybG7JM1l+woy7sdGX97uqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725194; c=relaxed/simple;
	bh=7xapjJjU1EYM99WCHMRdVegfNCSsmL3PaqXaVFihv9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/aQ5ROVB2JipyggQghA1yJ6ScAV+4CRZqK5AVpIgL2syVfRNjgXi/DxmigeUALGrc5eaJrI8U04EcuJVGatRFnrrHNXn1cAd+QsDi+BG3rLefBA31JR7KXC8KSijl99hISXTvsfJ3FbY1dvVyW/GocEOewhyuveWiii/l9Hw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4lRaEWw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oITydzZY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4lRaEWw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oITydzZY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0498221EF2;
	Wed, 31 Jan 2024 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nukceQt6qmChO7tld0/K+McErg5OVoeAbBhR+AellYI=;
	b=h4lRaEWwSWyu/ZmdavImjwyFztMx9TPu2mEUhD8iqtcFw3BuVOIjv8NG35VSnoRnxezmFM
	v+j+3xrJ9Ffl8e/JlZQ77QaAVmOVeGQWXxpFSgdklXRKC/dAIPgCZll0ny55hsyRSIFgrd
	B2RytTj4Z/pr7UJX7wmoN4j85y9ypSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nukceQt6qmChO7tld0/K+McErg5OVoeAbBhR+AellYI=;
	b=oITydzZYVWzoxcnhRzq2bzis09bjw7+ncm4tr60+a0JHm86JgAYqKl2WNWSmu/QdO+/l7P
	O5gJkVmbn+Lf/KAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nukceQt6qmChO7tld0/K+McErg5OVoeAbBhR+AellYI=;
	b=h4lRaEWwSWyu/ZmdavImjwyFztMx9TPu2mEUhD8iqtcFw3BuVOIjv8NG35VSnoRnxezmFM
	v+j+3xrJ9Ffl8e/JlZQ77QaAVmOVeGQWXxpFSgdklXRKC/dAIPgCZll0ny55hsyRSIFgrd
	B2RytTj4Z/pr7UJX7wmoN4j85y9ypSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nukceQt6qmChO7tld0/K+McErg5OVoeAbBhR+AellYI=;
	b=oITydzZYVWzoxcnhRzq2bzis09bjw7+ncm4tr60+a0JHm86JgAYqKl2WNWSmu/QdO+/l7P
	O5gJkVmbn+Lf/KAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EC075139D9;
	Wed, 31 Jan 2024 18:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0g2bOUaPumUaJQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:19:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A0E3A0809; Wed, 31 Jan 2024 19:19:46 +0100 (CET)
Date: Wed, 31 Jan 2024 19:19:46 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 07/34] xfs: port block device access to files
Message-ID: <20240131181946.zgiagq55ym4yjp5w@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-7-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-7-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h4lRaEWw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oITydzZY
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0498221EF2
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:24, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xfs/xfs_buf.c   | 10 +++++-----
>  fs/xfs/xfs_buf.h   |  4 ++--
>  fs/xfs/xfs_super.c | 43 +++++++++++++++++++++----------------------
>  3 files changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 8e5bd50d29fe..01b41fabbe3c 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1951,7 +1951,7 @@ xfs_free_buftarg(
>  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  	/* the main block device is closed by kill_block_super */
>  	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
> -		bdev_release(btp->bt_bdev_handle);
> +		fput(btp->bt_bdev_file);
>  
>  	kmem_free(btp);
>  }
> @@ -1994,7 +1994,7 @@ xfs_setsize_buftarg_early(
>  struct xfs_buftarg *
>  xfs_alloc_buftarg(
>  	struct xfs_mount	*mp,
> -	struct bdev_handle	*bdev_handle)
> +	struct file		*bdev_file)
>  {
>  	xfs_buftarg_t		*btp;
>  	const struct dax_holder_operations *ops = NULL;
> @@ -2005,9 +2005,9 @@ xfs_alloc_buftarg(
>  	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
>  
>  	btp->bt_mount = mp;
> -	btp->bt_bdev_handle = bdev_handle;
> -	btp->bt_dev = bdev_handle->bdev->bd_dev;
> -	btp->bt_bdev = bdev_handle->bdev;
> +	btp->bt_bdev_file = bdev_file;
> +	btp->bt_bdev = file_bdev(bdev_file);
> +	btp->bt_dev = btp->bt_bdev->bd_dev;
>  	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>  					    mp, ops);
>  
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index b470de08a46c..304e858d04fb 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -98,7 +98,7 @@ typedef unsigned int xfs_buf_flags_t;
>   */
>  typedef struct xfs_buftarg {
>  	dev_t			bt_dev;
> -	struct bdev_handle	*bt_bdev_handle;
> +	struct file		*bt_bdev_file;
>  	struct block_device	*bt_bdev;
>  	struct dax_device	*bt_daxdev;
>  	u64			bt_dax_part_off;
> @@ -366,7 +366,7 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
>   *	Handling of buftargs.
>   */
>  struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
> -		struct bdev_handle *bdev_handle);
> +		struct file *bdev_file);
>  extern void xfs_free_buftarg(struct xfs_buftarg *);
>  extern void xfs_buftarg_wait(struct xfs_buftarg *);
>  extern void xfs_buftarg_drain(struct xfs_buftarg *);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e5ac0e59ede9..4a076c464177 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -362,16 +362,16 @@ STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
>  	const char		*name,
> -	struct bdev_handle	**handlep)
> +	struct file		**bdev_filep)
>  {
>  	int			error = 0;
>  
> -	*handlep = bdev_open_by_path(name,
> +	*bdev_filep = bdev_file_open_by_path(name,
>  		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
>  		mp->m_super, &fs_holder_ops);
> -	if (IS_ERR(*handlep)) {
> -		error = PTR_ERR(*handlep);
> -		*handlep = NULL;
> +	if (IS_ERR(*bdev_filep)) {
> +		error = PTR_ERR(*bdev_filep);
> +		*bdev_filep = NULL;
>  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
>  	}
>  
> @@ -436,26 +436,25 @@ xfs_open_devices(
>  {
>  	struct super_block	*sb = mp->m_super;
>  	struct block_device	*ddev = sb->s_bdev;
> -	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
> +	struct file		*logdev_file = NULL, *rtdev_file = NULL;
>  	int			error;
>  
>  	/*
>  	 * Open real time and log devices - order is important.
>  	 */
>  	if (mp->m_logname) {
> -		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
> +		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_file);
>  		if (error)
>  			return error;
>  	}
>  
>  	if (mp->m_rtname) {
> -		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
> +		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_file);
>  		if (error)
>  			goto out_close_logdev;
>  
> -		if (rtdev_handle->bdev == ddev ||
> -		    (logdev_handle &&
> -		     rtdev_handle->bdev == logdev_handle->bdev)) {
> +		if (file_bdev(rtdev_file) == ddev ||
> +		    (logdev_file && file_bdev(rtdev_file) == file_bdev(logdev_file))) {
>  			xfs_warn(mp,
>  	"Cannot mount filesystem with identical rtdev and ddev/logdev.");
>  			error = -EINVAL;
> @@ -467,25 +466,25 @@ xfs_open_devices(
>  	 * Setup xfs_mount buffer target pointers
>  	 */
>  	error = -ENOMEM;
> -	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb_bdev_handle(sb));
> +	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_file);
>  	if (!mp->m_ddev_targp)
>  		goto out_close_rtdev;
>  
> -	if (rtdev_handle) {
> -		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_handle);
> +	if (rtdev_file) {
> +		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_file);
>  		if (!mp->m_rtdev_targp)
>  			goto out_free_ddev_targ;
>  	}
>  
> -	if (logdev_handle && logdev_handle->bdev != ddev) {
> -		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_handle);
> +	if (logdev_file && file_bdev(logdev_file) != ddev) {
> +		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
>  		if (!mp->m_logdev_targp)
>  			goto out_free_rtdev_targ;
>  	} else {
>  		mp->m_logdev_targp = mp->m_ddev_targp;
>  		/* Handle won't be used, drop it */
> -		if (logdev_handle)
> -			bdev_release(logdev_handle);
> +		if (logdev_file)
> +			fput(logdev_file);
>  	}
>  
>  	return 0;
> @@ -496,11 +495,11 @@ xfs_open_devices(
>   out_free_ddev_targ:
>  	xfs_free_buftarg(mp->m_ddev_targp);
>   out_close_rtdev:
> -	 if (rtdev_handle)
> -		bdev_release(rtdev_handle);
> +	 if (rtdev_file)
> +		fput(rtdev_file);
>   out_close_logdev:
> -	if (logdev_handle)
> -		bdev_release(logdev_handle);
> +	if (logdev_file)
> +		fput(logdev_file);
>  	return error;
>  }
>  
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

