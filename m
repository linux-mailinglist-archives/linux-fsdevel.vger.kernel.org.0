Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1040D32B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhIPGZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 02:25:20 -0400
Received: from verein.lst.de ([213.95.11.211]:38719 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234569AbhIPGZU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:25:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D143267357; Thu, 16 Sep 2021 08:23:57 +0200 (CEST)
Date:   Thu, 16 Sep 2021 08:23:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [PATCH v9 7/8] xfs: support CoW in fsdax mode
Message-ID: <20210916062357.GD13306@lst.de>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com> <20210915104501.4146910-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915104501.4146910-8-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 06:45:00PM +0800, Shiyang Ruan wrote:
> +static int
> +xfs_dax_write_iomap_end(
> +	struct inode 		*inode,
> +	loff_t 			pos,
> +	loff_t 			length,
> +	ssize_t 		written,
> +	unsigned 		flags,
> +	struct iomap 		*iomap)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	/*
> +	 * Usually we use @written to indicate whether the operation was
> +	 * successful.  But it is always positive or zero.  The CoW needs the
> +	 * actual error code from actor().  So, get it from
> +	 * iomap_iter->processed.
> +	 */
> +	const struct iomap_iter *iter =
> +				container_of(iomap, typeof(*iter), iomap);
> +
> +	if (!xfs_is_cow_inode(ip))
> +		return 0;
> +
> +	if (iter->processed <= 0) {
> +		xfs_reflink_cancel_cow_range(ip, pos, length, true);
> +		return 0;
> +	}
> +
> +	return xfs_reflink_end_cow(ip, pos, iter->processed);

Didn't we come to the conflusion last time that we don't actually
need to poke into the iomap_iter here as the written argument is equal
to iter->processed if it is > 0:

	if (iter->iomap.length && ops->iomap_end) {
		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
				iter->processed > 0 ? iter->processed : 0,
				iter->flags, &iter->iomap);
		..

So should be able to just do:

static int
xfs_dax_write_iomap_end(
	struct inode 		*inode,
	loff_t 			pos,
	loff_t 			length,
	ssize_t 		written,
	unsigned 		flags,
	struct iomap 		*iomap)
{
	struct xfs_inode	*ip = XFS_I(inode);

	if (!xfs_is_cow_inode(ip))
		return 0;

	if (!written) {
		xfs_reflink_cancel_cow_range(ip, pos, length, true);
		return 0;
	}

	return xfs_reflink_end_cow(ip, pos, written);
}
