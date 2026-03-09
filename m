Return-Path: <linux-fsdevel+bounces-79811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILqZIqz5rmnZKgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:47:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1168423D019
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02EF30B00F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3904B3B530D;
	Mon,  9 Mar 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdvBv4Vo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCC385501;
	Mon,  9 Mar 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074320; cv=none; b=Xwb8iLaFo7gjjmnMlr7REhmGIlDh9YaVe1WM1PmYaDl0r638p/T5bTIk4Iita11bpCHUTds9C9DgdZvyJqneMhMxOAaQPr8Xv1HHwTtlYAfaYPWOIpZY2alH4rBm61ByUDsRNDOpLrlpZ48o6XS+hcgzP3XvHYE0ZarUL99P67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074320; c=relaxed/simple;
	bh=Xby0f12Hc4bveWsyuVys3FKnpF0Og+7P3Rk/31Mz+uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzsJZPrHsgnAbmtez0uzQyjzOQy63GqtwZKVPtPdgZh6kpsLhQJxsZWeS63FUCjbu/NKESr5wBMFcdaevWA9dj6J4N/mSdQdJRuROn21AA9gjKzFfmmbv42pyCxiXTPjRZpRmBCwp+o4s4QAZLzplKjVoePEK28SYj819Xtkifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdvBv4Vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEF9C4CEF7;
	Mon,  9 Mar 2026 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773074320;
	bh=Xby0f12Hc4bveWsyuVys3FKnpF0Og+7P3Rk/31Mz+uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdvBv4VotuO5Ziw3fCh35TU1usUK6l2LaW1rUQB5l1mKaia7BmNNpEBLKRizkSYRd
	 NT8ntsVjxEeJIM3L0MHgAqex1hXmGs7uNCR720qG8jaDx1ZtWiZoWX4nm/m/4bYSot
	 DgEePDmFsUd6H5vUdLzqXCAHomAhJ5szD+wHvjTHLCuFVVkY7DCn9r9UM9a3z5P6Vs
	 AMNqHFgxVxzajLDExVpTD0MoQWW0dGrDW9pQ99YxwjlonMRNxTAv+OxQij1pp46ymM
	 0tFaH4k4Ge7VK6rveceORGSJaVB71SMD3j0vH8T8gHkALbQN6XwbZNdqL94I5CTOo5
	 ioDcz+lAzcjmQ==
Date: Mon, 9 Mar 2026 09:38:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: brauner@kernel.org, hch@lst.de, jack@suse.cz, cem@kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v2 3/5] xfs: implement write-stream management support
Message-ID: <20260309163839.GG6033@frogsfrogsfrogs>
References: <20260309052944.156054-1-joshi.k@samsung.com>
 <CGME20260309053432epcas5p48e0273c8829a735ed987d1a02fcccac4@epcas5p4.samsung.com>
 <20260309052944.156054-4-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309052944.156054-4-joshi.k@samsung.com>
X-Rspamd-Queue-Id: 1168423D019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79811-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 10:59:42AM +0530, Kanchan Joshi wrote:
> Implement support for FS_IOC_WRITE_STREAM ioctl.
> 
> For FS_WRITE_STREAM_OP_GET_MAX, available write streams are reported
> based on the capability of the underlying block device.
> For FS_WRITE_STREAM_OP_{SET/GET}, add a new i_write_stream field in xfs
> inode. This value is propagated to the iomap during block mapping.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  fs/xfs/xfs_icache.c |  1 +
>  fs/xfs/xfs_inode.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_inode.h  |  6 ++++++
>  fs/xfs/xfs_ioctl.c  | 34 +++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_iomap.c  |  1 +
>  5 files changed, 88 insertions(+)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index a7a09e7eec81..2ad8d02152f4 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -130,6 +130,7 @@ xfs_inode_alloc(
>  	spin_lock_init(&ip->i_ioend_lock);
>  	ip->i_next_unlinked = NULLAGINO;
>  	ip->i_prev_unlinked = 0;
> +	ip->i_write_stream = 0;
>  
>  	return ip;
>  }
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 50c0404f9064..9b88b2d1cf9a 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -47,6 +47,52 @@
>  
>  struct kmem_cache *xfs_inode_cache;
>  
> +int
> +xfs_inode_max_write_streams(
> +	struct xfs_inode	*ip)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct block_device	*bdev;
> +
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		bdev = mp->m_rtdev_targp ? mp->m_rtdev_targp->bt_bdev : NULL;

Uhh if this is a realtime inode then there had better be an
m_rtdev_targp to dereference.

Also... this is xfs_inode_buftarg().

> +	else
> +		bdev = mp->m_ddev_targp->bt_bdev;
> +
> +	if (!bdev)
> +		return 0;
> +
> +	return bdev_max_write_streams(bdev);
> +}
> +
> +uint8_t
> +xfs_inode_get_write_stream(
> +	struct xfs_inode	*ip)
> +{
> +	uint8_t		stream_id;
> +
> +	xfs_ilock(ip, XFS_ILOCK_SHARED);
> +	stream_id = ip->i_write_stream;
> +	xfs_iunlock(ip, XFS_ILOCK_SHARED);
> +
> +	return stream_id;
> +}
> +
> +int
> +xfs_inode_set_write_stream(
> +	struct xfs_inode	*ip,
> +	uint8_t			stream_id)
> +{
> +	if (stream_id > xfs_inode_max_write_streams(ip))

Inodes can change devices, so this needs to go under the ILOCK.

> +		return -EINVAL;
> +
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	ip->i_write_stream =  stream_id;
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +
> +	return 0;
> +}
> +
>  /*
>   * These two are wrapper routines around the xfs_ilock() routine used to
>   * centralize some grungy code.  They are used in places that wish to lock the
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index bd6d33557194..9f6cab729924 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -38,6 +38,9 @@ typedef struct xfs_inode {
>  	struct xfs_ifork	i_df;		/* data fork */
>  	struct xfs_ifork	i_af;		/* attribute fork */
>  
> +	/* Write stream information */
> +	uint8_t			i_write_stream;

I'm confused, bdev_max_write_streams returns an unsigned short, but this
is a uint8_t field.  How are we supposed to deal with truncation issues?

--D

> +
>  	/* Transaction and locking information. */
>  	struct xfs_inode_log_item *i_itemp;	/* logging information */
>  	struct rw_semaphore	i_lock;		/* inode lock */
> @@ -676,4 +679,7 @@ int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
>  		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
>  		struct xfs_dquot **pdqpp);
>  
> +int xfs_inode_max_write_streams(struct xfs_inode *ip);
> +uint8_t xfs_inode_get_write_stream(struct xfs_inode *ip);
> +int xfs_inode_set_write_stream(struct xfs_inode *ip, uint8_t stream_id);
>  #endif	/* __XFS_INODE_H__ */
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index facffdc8dca8..091d6a8b5f57 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1160,6 +1160,38 @@ xfs_ioctl_fs_counts(
>  	return 0;
>  }
>  
> +static int
> +xfs_ioc_write_stream(
> +	struct file		*filp,
> +	void __user		*arg)
> +{
> +	struct inode		*inode = file_inode(filp);
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct fs_write_stream	ws = { };
> +
> +	if (copy_from_user(&ws, arg, sizeof(ws)))
> +		return -EFAULT;
> +
> +	switch (ws.op_flags) {
> +	case FS_WRITE_STREAM_OP_GET_MAX:
> +		ws.max_streams = xfs_inode_max_write_streams(ip);
> +		goto copy_out;
> +	case FS_WRITE_STREAM_OP_GET:
> +		ws.stream_id = xfs_inode_get_write_stream(ip);
> +		goto copy_out;
> +	case FS_WRITE_STREAM_OP_SET:
> +		return xfs_inode_set_write_stream(ip, ws.stream_id);
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +
> +copy_out:
> +	if (copy_to_user(arg, &ws, sizeof(ws)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>  /*
>   * These long-unused ioctls were removed from the official ioctl API in 5.17,
>   * but retain these definitions so that we can log warnings about them.
> @@ -1425,6 +1457,8 @@ xfs_file_ioctl(
>  		return xfs_ioc_health_monitor(filp, arg);
>  	case XFS_IOC_VERIFY_MEDIA:
>  		return xfs_ioc_verify_media(filp, arg);
> +	case FS_IOC_WRITE_STREAM:
> +		return xfs_ioc_write_stream(filp, arg);
>  
>  	default:
>  		return -ENOTTY;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index be86d43044df..7988c9e16635 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -148,6 +148,7 @@ xfs_bmbt_to_iomap(
>  	else
>  		iomap->bdev = target->bt_bdev;
>  	iomap->flags = iomap_flags;
> +	iomap->write_stream = ip->i_write_stream;
>  
>  	/*
>  	 * If the inode is dirty for datasync purposes, let iomap know so it
> -- 
> 2.25.1
> 
> 

