Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0D32C510
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbhCDATH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:07 -0500
Received: from verein.lst.de ([213.95.11.211]:36062 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1842936AbhCCKWp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EAEBC68D01; Wed,  3 Mar 2021 10:43:09 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:43:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v2 09/10] fs/xfs: Handle CoW for fsdax write() path
Message-ID: <20210303094309.GB15389@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <20210226002030.653855-10-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-10-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:20:29AM +0800, Shiyang Ruan wrote:
>  	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +		  IS_DAX(VFS_I(ip)) ?
> +		  &xfs_dax_write_iomap_ops : &xfs_buffered_write_iomap_ops);

Please add a xfs_zero_range helper that picks the right iomap_ops
instead of open coding this in a few places.

> +static int
> +xfs_dax_write_iomap_end(
> +	struct inode		*inode,
> +	loff_t			pos,
> +	loff_t			length,
> +	ssize_t			written,
> +	unsigned int		flags,
> +	struct iomap		*iomap)
> +{
> +	int			error = 0;
> +	xfs_inode_t		*ip = XFS_I(inode);
> +
> +	if (pos + written > i_size_read(inode)) {
> +		i_size_write(inode, pos + written);
> +		error = xfs_setfilesize(ip, pos, written);
> +	}
> +	if (xfs_is_cow_inode(ip))
> +		error = xfs_reflink_end_cow(ip, pos, written);
> +
> +	return error;

What is the advantage of the ioemap_end handler here?  It adds another
indirect funtion call to the fast path, so if we can avoid it, I'd
rather do that.

Also, shouldn't we cancel the COW rather than finishing it when setting
the file size fails?
