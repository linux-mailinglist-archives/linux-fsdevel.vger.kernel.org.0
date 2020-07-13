Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375AC21D5B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgGMMU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 08:20:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbgGMMU4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:20:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45B73B1E2;
        Mon, 13 Jul 2020 12:20:56 +0000 (UTC)
Date:   Mon, 13 Jul 2020 07:20:50 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: fall back to buffered writes for invalidation
 failures
Message-ID: <20200713122050.okus7qlampk5ysyb@fiona>
References: <20200713074633.875946-1-hch@lst.de>
 <20200713074633.875946-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713074633.875946-3-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  9:46 13/07, Christoph Hellwig wrote:
> Failing to invalid the page cache means data in incoherent, which is
> a very bad state for the system.  Always fall back to buffered I/O
> through the page cache if we can't invalidate mappings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks. This will help btrfs. The current next tree contains the iomap
changes I recomended and would need to be reverted in order to
incorporate this. Once this is in the next tree I will (re)format the
btrfs iomap dio patches.

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/ext4/file.c       |  2 ++
>  fs/gfs2/file.c       |  3 ++-
>  fs/iomap/direct-io.c | 13 ++++++++-----
>  fs/iomap/trace.h     |  1 +
>  fs/xfs/xfs_file.c    |  4 ++--
>  fs/zonefs/super.c    |  7 +++++--
>  6 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c4c..0da6c2a2c32c1e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -544,6 +544,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   is_sync_kiocb(iocb) || unaligned_io || extend);
> +	if (ret == -EREMCHG)
> +		ret = 0;
>  
>  	if (extend)
>  		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index fe305e4bfd3734..c7907d40c61d17 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -814,7 +814,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
>  			   is_sync_kiocb(iocb));
> -
> +	if (ret == -EREMCHG)
> +		ret = 0;
>  out:
>  	gfs2_glock_dq(&gh);
>  out_uninit:
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 190967e87b69e4..62626235cdbe8d 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -10,6 +10,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include "trace.h"
>  
>  #include "../internal.h"
>  
> @@ -478,13 +479,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iov_iter_rw(iter) == WRITE) {
>  		/*
>  		 * Try to invalidate cache pages for the range we are writing.
> -		 * If this invalidation fails, tough, the write will still work,
> -		 * but racing two incompatible write paths is a pretty crazy
> -		 * thing to do, so we don't support it 100%.
> +		 * If this invalidation fails, let the caller fall back to
> +		 * buffered I/O.
>  		 */
>  		if (invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> -				end >> PAGE_SHIFT))
> -			dio_warn_stale_pagecache(iocb->ki_filp);
> +				end >> PAGE_SHIFT)) {
> +			trace_iomap_dio_invalidate_fail(inode, pos, count);
> +			ret = -EREMCHG;
> +			goto out_free_dio;
> +		}
>  
>  		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
>  			ret = sb_init_dio_done_wq(inode->i_sb);
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 5693a39d52fb63..fdc7ae388476f5 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -74,6 +74,7 @@ DEFINE_EVENT(iomap_range_class, name,	\
>  DEFINE_RANGE_EVENT(iomap_writepage);
>  DEFINE_RANGE_EVENT(iomap_releasepage);
>  DEFINE_RANGE_EVENT(iomap_invalidatepage);
> +DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
>  
>  #define IOMAP_TYPE_STRINGS \
>  	{ IOMAP_HOLE,		"HOLE" }, \
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 00db81eac80d6c..551cca39fa3ba6 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -553,8 +553,8 @@ xfs_file_dio_aio_write(
>  	xfs_iunlock(ip, iolock);
>  
>  	/*
> -	 * No fallback to buffered IO on errors for XFS, direct IO will either
> -	 * complete fully or fail.
> +	 * No partial fallback to buffered IO on errors for XFS, direct IO will
> +	 * either complete fully or fail.
>  	 */
>  	ASSERT(ret < 0 || ret == count);
>  	return ret;
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 07bc42d62673ce..793850454b752f 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -786,8 +786,11 @@ static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (iocb->ki_pos >= ZONEFS_I(inode)->i_max_size)
>  		return -EFBIG;
>  
> -	if (iocb->ki_flags & IOCB_DIRECT)
> -		return zonefs_file_dio_write(iocb, from);
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		ret = zonefs_file_dio_write(iocb, from);
> +		if (ret != -EREMCHG)
> +			return ret;
> +	}
>  
>  	return zonefs_file_buffered_write(iocb, from);
>  }
> -- 
> 2.26.2
> 

-- 
Goldwyn
