Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D43DF9D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhHDC5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 22:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhHDC5Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A95560F46;
        Wed,  4 Aug 2021 02:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628045833;
        bh=lnQilC4UM17zCwYD5b03vi9DCTZzWAKF25Z2CjkYw6M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kf9s4nnBfuAQVMf+v2osuwky4bc4uG/GLyJY6JwIE4eSjfIrtdq1MU/pcaFxJY83S
         cLrdRMhn6PjbsPwvpb3+GXqcNtIUU48YpoyQ+ujK9bGZJMpWkNRyJBXaaVtTfw4V5G
         vx/sPx5mml23je2qzALAFQFUWzXy+1Pn8B7s4FdfDxhvBPO6682wD68rm800vMhgjX
         Ij3O/kg40zwacJ3KtXo6Dd+w9V5b2Dx/SD/7Zggz4Dd9LZUn59T2F4/mifNIeXaoC6
         zykD73AXRBIkVDNQm0nU02BdTm66L1xKI9rvBNaEkGsn8juee3/Havvo1xkykGJjXB
         esl/qu9Op/Mjw==
Subject: Re: [PATCH v2 1/3] erofs: iomap support for non-tailpacking DIO
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Tao Ma <boyu.mt@taobao.com>
References: <20210730194625.93856-1-hsiangkao@linux.alibaba.com>
 <20210730194625.93856-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e79e3261-e582-e848-b550-c0c3163d9af4@kernel.org>
Date:   Wed, 4 Aug 2021 10:57:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730194625.93856-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/31 3:46, Gao Xiang wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Add iomap support for non-tailpacking uncompressed data in order to
> support DIO and DAX.
> 
> Direct I/O is useful in certain scenarios for uncompressed files.
> For example, double pagecache can be avoid by direct I/O when
> loop device is used for uncompressed files containing upper layer
> compressed filesystem.
> 
> This adds iomap DIO support for non-tailpacking cases first and
> tail-packing inline files are handled in the follow-up patch.
> 
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/Kconfig    |   1 +
>   fs/erofs/data.c     | 102 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/inode.c    |   5 ++-
>   fs/erofs/internal.h |   1 +
>   4 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 906af0c1998c..14b747026742 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -3,6 +3,7 @@
>   config EROFS_FS
>   	tristate "EROFS filesystem support"
>   	depends on BLOCK
> +	select FS_IOMAP
>   	select LIBCRC32C
>   	help
>   	  EROFS (Enhanced Read-Only File System) is a lightweight
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 3787a5fb0a42..1f97151a9f90 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -5,6 +5,7 @@
>    */
>   #include "internal.h"
>   #include <linux/prefetch.h>
> +#include <linux/iomap.h>
>   
>   #include <trace/events/erofs.h>
>   
> @@ -308,9 +309,110 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>   	return 0;
>   }
>   
> +static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	int ret;
> +	struct erofs_map_blocks map;
> +
> +	map.m_la = offset;
> +	map.m_llen = length;
> +
> +	ret = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (ret < 0)
> +		return ret;
> +
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->offset = map.m_la;
> +	iomap->length = map.m_llen;
> +	iomap->flags = 0;
> +
> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		iomap->type = IOMAP_HOLE;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		if (!iomap->length)
> +			iomap->length = length;

This only happens for the case offset exceeds isize?

> +		return 0;
> +	}
> +
> +	/* that shouldn't happen for now */
> +	if (map.m_flags & EROFS_MAP_META) {
> +		DBG_BUGON(1);
> +		return -ENOTBLK;
> +	}
> +	iomap->type = IOMAP_MAPPED;
> +	iomap->addr = map.m_pa;
> +	return 0;
> +}
> +
> +const struct iomap_ops erofs_iomap_ops = {
> +	.iomap_begin = erofs_iomap_begin,
> +};
> +
> +static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	loff_t align = iocb->ki_pos | iov_iter_count(to) |
> +		iov_iter_alignment(to);
> +	struct block_device *bdev = inode->i_sb->s_bdev;
> +	unsigned int blksize_mask;
> +
> +	if (bdev)
> +		blksize_mask = (1 << ilog2(bdev_logical_block_size(bdev))) - 1;
> +	else
> +		blksize_mask = (1 << inode->i_blkbits) - 1;
> +
> +	if (align & blksize_mask)
> +		return -EINVAL;
> +
> +	/*
> +	 * Temporarily fall back tail-packing inline to buffered I/O instead
> +	 * since tail-packing inline support relies on an iomap core update.
> +	 */
> +	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE &&
> +	    iocb->ki_pos + iov_iter_count(to) >
> +			rounddown(inode->i_size, EROFS_BLKSIZ))
> +		return 1;
> +	return 0;
> +}
> +
> +static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	/* no need taking (shared) inode lock since it's a ro filesystem */
> +	if (!iov_iter_count(to))
> +		return 0;
> +
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		int err = erofs_prepare_dio(iocb, to);
> +
> +		if (!err)
> +			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> +					    NULL, 0);
> +		if (err < 0)
> +			return err;
> +		/*
> +		 * Fallback to buffered I/O if the operation being performed on
> +		 * the inode is not supported by direct I/O. The IOCB_DIRECT
> +		 * flag needs to be cleared here in order to ensure that the
> +		 * direct I/O path within generic_file_read_iter() is not
> +		 * taken.
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +	}
> +	return generic_file_read_iter(iocb, to);

It looks it's fine to call filemap_read() directly since above codes have
covered DIO case, then we don't need to change iocb->ki_flags flag, it's
minor though.

> +}
> +
>   /* for uncompressed (aligned) files and raw access for other files */
>   const struct address_space_operations erofs_raw_access_aops = {
>   	.readpage = erofs_raw_access_readpage,
>   	.readahead = erofs_raw_access_readahead,
>   	.bmap = erofs_bmap,
> +	.direct_IO = noop_direct_IO,
> +};
> +
> +const struct file_operations erofs_file_fops = {
> +	.llseek		= generic_file_llseek,
> +	.read_iter	= erofs_file_read_iter,
> +	.mmap		= generic_file_readonly_mmap,
> +	.splice_read	= generic_file_splice_read,
>   };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index aa8a0d770ba3..00edb7562fea 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -247,7 +247,10 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
>   	switch (inode->i_mode & S_IFMT) {
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
> -		inode->i_fop = &generic_ro_fops;
> +		if (!erofs_inode_is_data_compressed(vi->datalayout))
> +			inode->i_fop = &erofs_file_fops;
> +		else
> +			inode->i_fop = &generic_ro_fops;

if (erofs_inode_is_data_compressed(vi->datalayout))
	inode->i_fop = &generic_ro_fops;
else
	inode->i_fop = &erofs_file_fops;

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks

>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 543c2ff97d30..2669c785d548 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -371,6 +371,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
>   /* data.c */
> +extern const struct file_operations erofs_file_fops;
>   struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
>   
>   /* inode.c */
> 
