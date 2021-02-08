Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA2313790
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhBHP1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 10:27:37 -0500
Received: from verein.lst.de ([213.95.11.211]:41809 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233682AbhBHPZR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:25:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C0C868AFE; Mon,  8 Feb 2021 16:24:31 +0100 (CET)
Date:   Mon, 8 Feb 2021 16:24:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH 6/7] fs/xfs: Handle CoW for fsdax write() path
Message-ID: <20210208152430.GF12872@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-7-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-7-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -977,10 +977,14 @@ xfs_free_file_space(
>  	if (offset + len > XFS_ISIZE(ip))
>  		len = XFS_ISIZE(ip) - offset;
>  	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +		  IS_DAX(VFS_I(ip)) ?
> +		  &xfs_direct_write_iomap_ops : &xfs_buffered_write_iomap_ops);
>  	if (error)
>  		return error;
> +	if (xfs_is_reflink_inode(ip))
> +		xfs_reflink_end_cow(ip, offset, len);

Maybe we need to add (back) and xfs_zero_range helper that encapsulates
the details?

>  	trace_xfs_file_dax_write(ip, count, pos);
>  	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
> -	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
> -		i_size_write(inode, iocb->ki_pos);
> -		error = xfs_setfilesize(ip, pos, ret);
> +	if (ret > 0) {
> +		if (iocb->ki_pos > i_size_read(inode)) {
> +			i_size_write(inode, iocb->ki_pos);
> +			error = xfs_setfilesize(ip, pos, ret);
> +		}
> +		if (xfs_is_cow_inode(ip))
> +			xfs_reflink_end_cow(ip, pos, ret);

Nitpick, but I'd just goto out for ret <= 0 to reduce the indentation a
bit.

>  	}
>  out:
>  	xfs_iunlock(ip, iolock);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 7b9ff824e82d..d6d4cc0f084e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -765,13 +765,14 @@ xfs_direct_write_iomap_begin(
>  		goto out_unlock;
>  
>  	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
> +		bool need_convert = flags & IOMAP_DIRECT || IS_DAX(inode);
>  		error = -EAGAIN;
>  		if (flags & IOMAP_NOWAIT)
>  			goto out_unlock;
>  
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> -				&lockmode, flags & IOMAP_DIRECT);
> +				&lockmode, need_convert);

Why not:

		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
				&lockmode,
				(flags & IOMAP_DIRECT) || IS_DAX(inode));

?
