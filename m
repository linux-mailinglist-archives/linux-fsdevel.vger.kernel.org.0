Return-Path: <linux-fsdevel+bounces-40676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F3A2667B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573B918855E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207320FAAB;
	Mon,  3 Feb 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igc8Bw2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E001F92A;
	Mon,  3 Feb 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621290; cv=none; b=q9GCw4H0ifsjdGv3bg1dybzocwPXz9UHKOiVommC/rtPzCTQnNGIzigdt6iZHI28gmKiDxRs8GpyviJjjSvR0QlfB0dLc56vBeOrsDcPkUfgKSg/UsoKeRzRWbvNXGYo7s0VtvyA5LGbORPTw67XoeeOpy1r6iirKLd6cnfVHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621290; c=relaxed/simple;
	bh=0/WdMPG3Q5y37B+FjuOwLhmCuUv2SLKBGo6xPe9NpSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS+3D/6w4T3KC6dPuZ0qDtcZvrvMeQvkIg7s7FNCgd1wYk+kH0JCS/a5Z1NEoW5zxouH2ykA+XS/qP0Ym8pafKXHXzpzqgbQfH0KN+fNXzmIJ0vrxXK4brJ94mxNv6J4AIpVcJWWjST1ooDlb7n4rLjFd3aFxMpnDtZ3irCrJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igc8Bw2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73D2C4CED2;
	Mon,  3 Feb 2025 22:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621289;
	bh=0/WdMPG3Q5y37B+FjuOwLhmCuUv2SLKBGo6xPe9NpSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Igc8Bw2k5x6FfbtYVvON01V9zpa05f5SsQaS41QBhdNuaSqRBByK+/nJjk0fUx8AT
	 7dKiLq3t4hfqegPo6hTxlad8RAtK4NtsYoO6RyRVmNKOGa2/7dY+GQ9U860Uhn9dz3
	 xKxdOjkpK6OlwOacpaRue9dS6WxAZMii4MqieXb3f696meb6+ud+1lgvLyZEU9dbE1
	 4wFVvtCU9P4GNO0Ibsv91oa20O82i/gOFiBayBREG/dH8ODXgbCD4ielfEPIGYuPLa
	 HhmDhBbVnVRHYcxXHq+XFZDnlZm3zVo+iB5hPdm2iy5ywK59zdNY39mJq2y+ZJALko
	 W+yx9lAWgZDcA==
Date: Mon, 3 Feb 2025 14:21:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/7] xfs: support T10 protection information
Message-ID: <20250203222129.GC134507@frogsfrogsfrogs>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203094322.1809766-7-hch@lst.de>

On Mon, Feb 03, 2025 at 10:43:10AM +0100, Christoph Hellwig wrote:
> Add support for generating / verifying protection information in the
> file system.  This is done by hooking into the bio submission in
> iomap and then using the generic PI helpers.  Compared to just using
> the block layer auto PI this extends the protection envelope and also
> prepares for eventually passing through PI from userspace at least
> for direct I/O.
> 
> Right now this is still pretty hacky, e.g. the single PI buffer can
> get pretty gigantic and has no mempool backing it.  The deferring of
> I/O completions is done unconditionally instead only when needed,
> and we assume the device can actually handle these huge segments.
> The latter should be fixed by doing proper splitting based on metadata
> limits in the block layer, but the rest needs to be addressed here.

Seems reasonable to me modulo the XXX parts. :)

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/Makefile        |  1 +
>  fs/xfs/xfs_aops.c      | 29 +++++++++++++++--
>  fs/xfs/xfs_aops.h      |  1 +
>  fs/xfs/xfs_data_csum.c | 73 ++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_data_csum.h |  7 ++++
>  fs/xfs/xfs_file.c      | 27 +++++++++++++++-
>  fs/xfs/xfs_inode.h     |  6 ++--
>  7 files changed, 136 insertions(+), 8 deletions(-)
>  create mode 100644 fs/xfs/xfs_data_csum.c
>  create mode 100644 fs/xfs/xfs_data_csum.h
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 7afa51e41427..aa8749d640e7 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -73,6 +73,7 @@ xfs-y				+= xfs_aops.o \
>  				   xfs_bmap_util.o \
>  				   xfs_bio_io.o \
>  				   xfs_buf.o \
> +				   xfs_data_csum.o \
>  				   xfs_dahash_test.o \
>  				   xfs_dir2_readdir.o \
>  				   xfs_discard.o \
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 3e42a684cce1..291f5d4dbce6 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -19,6 +19,7 @@
>  #include "xfs_reflink.h"
>  #include "xfs_errortag.h"
>  #include "xfs_error.h"
> +#include "xfs_data_csum.h"
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -122,6 +123,11 @@ xfs_end_ioend(
>  		goto done;
>  	}
>  
> +	if (bio_op(&ioend->io_bio) == REQ_OP_READ) {
> +		error = xfs_data_csum_verify(ioend);
> +		goto done;
> +	}
> +
>  	/*
>  	 * Success: commit the COW or unwritten blocks if needed.
>  	 */
> @@ -175,7 +181,7 @@ xfs_end_io(
>  	}
>  }
>  
> -STATIC void
> +void
>  xfs_end_bio(
>  	struct bio		*bio)
>  {
> @@ -417,6 +423,8 @@ xfs_submit_ioend(
>  
>  	memalloc_nofs_restore(nofs_flag);
>  
> +	xfs_data_csum_generate(&ioend->io_bio);
> +
>  	/* send ioends that might require a transaction to the completion wq */
>  	if (xfs_ioend_is_append(ioend) ||
>  	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
> @@ -517,19 +525,34 @@ xfs_vm_bmap(
>  	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
>  }
>  
> +static void xfs_buffered_read_submit_io(struct inode *inode,
> +		struct bio *bio, loff_t file_offset)
> +{
> +	xfs_data_csum_alloc(bio);
> +	iomap_init_ioend(inode, bio, file_offset, 0);
> +	bio->bi_end_io = xfs_end_bio;
> +	submit_bio(bio);
> +}
> +
> +static const struct iomap_read_folio_ops xfs_iomap_read_ops = {
> +	.bio_set	= &iomap_ioend_bioset,
> +	.submit_io	= xfs_buffered_read_submit_io,
> +};
> +
>  STATIC int
>  xfs_vm_read_folio(
>  	struct file		*unused,
>  	struct folio		*folio)
>  {
> -	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
> +	return iomap_read_folio(folio, &xfs_read_iomap_ops,
> +			&xfs_iomap_read_ops);
>  }
>  
>  STATIC void
>  xfs_vm_readahead(
>  	struct readahead_control	*rac)
>  {
> -	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
> +	iomap_readahead(rac, &xfs_read_iomap_ops, &xfs_iomap_read_ops);
>  }
>  
>  static int
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index e0bd68419764..efed1ab59dbf 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -10,5 +10,6 @@ extern const struct address_space_operations xfs_address_space_operations;
>  extern const struct address_space_operations xfs_dax_aops;
>  
>  int	xfs_setfilesize(struct xfs_inode *ip, xfs_off_t offset, size_t size);
> +void	xfs_end_bio(struct bio *bio);
>  
>  #endif /* __XFS_AOPS_H__ */
> diff --git a/fs/xfs/xfs_data_csum.c b/fs/xfs/xfs_data_csum.c
> new file mode 100644
> index 000000000000..d9d3620654b1
> --- /dev/null
> +++ b/fs/xfs/xfs_data_csum.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022-2025 Christoph Hellwig.
> + */
> +#include "xfs.h"
> +#include "xfs_format.h"
> +#include "xfs_shared.h"
> +#include "xfs_trans_resv.h"
> +#include "xfs_mount.h"
> +#include "xfs_inode.h"
> +#include "xfs_cksum.h"
> +#include "xfs_data_csum.h"
> +#include <linux/iomap.h>
> +#include <linux/blk-integrity.h>
> +#include <linux/bio-integrity.h>
> +
> +void *
> +xfs_data_csum_alloc(
> +	struct bio		*bio)
> +{
> +	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +	struct bio_integrity_payload *bip;
> +	unsigned int		buf_size;
> +	void			*buf;
> +
> +	if (!bi)
> +		return NULL;
> +
> +	buf_size = bio_integrity_bytes(bi, bio_sectors(bio));
> +	/* XXX: this needs proper mempools */
> +	/* XXX: needs (partial) zeroing if tuple_size > csum_size */
> +	buf = kmalloc(buf_size, GFP_NOFS | __GFP_NOFAIL);
> +	bip = bio_integrity_alloc(bio, GFP_NOFS | __GFP_NOFAIL, 1);
> +	if (!bio_integrity_add_page(bio, virt_to_page(buf), buf_size,
> +			offset_in_page(buf)))
> +		WARN_ON_ONCE(1);
> +
> +	if (bi->csum_type) {
> +		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
> +			bip->bip_flags |= BIP_IP_CHECKSUM;
> +		bip->bip_flags |= BIP_CHECK_GUARD;
> +	}
> +	if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +		bip->bip_flags |= BIP_CHECK_REFTAG;
> +	bip_set_seed(bip, bio->bi_iter.bi_sector);
> +
> +	return buf;
> +}
> +
> +void
> +xfs_data_csum_generate(
> +	struct bio		*bio)
> +{
> +	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +
> +	if (!bi || !bi->csum_type)
> +		return;
> +
> +	xfs_data_csum_alloc(bio);
> +	blk_integrity_generate(bio);
> +}
> +
> +int
> +xfs_data_csum_verify(
> +	struct iomap_ioend	*ioend)
> +{
> +	struct bio		*bio = &ioend->io_bio;
> +	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +
> +	if (!bi || !bi->csum_type)
> +		return 0;
> +	return blk_integrity_verify_all(bio, ioend->io_sector);
> +}
> diff --git a/fs/xfs/xfs_data_csum.h b/fs/xfs/xfs_data_csum.h
> new file mode 100644
> index 000000000000..f32215e8f46c
> --- /dev/null
> +++ b/fs/xfs/xfs_data_csum.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +struct iomap_ioend;
> +
> +void *xfs_data_csum_alloc(struct bio *bio);
> +void xfs_data_csum_generate(struct bio *bio);
> +int xfs_data_csum_verify(struct iomap_ioend *ioend);
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index f7a7d89c345e..0d64c54017f0 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -25,6 +25,8 @@
>  #include "xfs_iomap.h"
>  #include "xfs_reflink.h"
>  #include "xfs_file.h"
> +#include "xfs_data_csum.h"
> +#include "xfs_aops.h"
>  
>  #include <linux/dax.h>
>  #include <linux/falloc.h>
> @@ -227,6 +229,20 @@ xfs_ilock_iocb_for_write(
>  	return 0;
>  }
>  
> +static void xfs_dio_read_submit_io(const struct iomap_iter *iter,
> +		struct bio *bio, loff_t file_offset)
> +{
> +	xfs_data_csum_alloc(bio);
> +	iomap_init_ioend(iter->inode, bio, file_offset, IOMAP_IOEND_DIRECT);
> +	bio->bi_end_io = xfs_end_bio;
> +	submit_bio(bio);
> +}
> +
> +static const struct iomap_dio_ops xfs_dio_read_ops = {
> +	.bio_set	= &iomap_ioend_bioset,
> +	.submit_io	= xfs_dio_read_submit_io,
> +};
> +
>  STATIC ssize_t
>  xfs_file_dio_read(
>  	struct kiocb		*iocb,
> @@ -245,7 +261,8 @@ xfs_file_dio_read(
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
>  		return ret;
> -	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, &xfs_dio_read_ops, 0,
> +			NULL, 0);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -578,8 +595,16 @@ xfs_dio_write_end_io(
>  	return error;
>  }
>  
> +static void xfs_dio_write_submit_io(const struct iomap_iter *iter,
> +		struct bio *bio, loff_t file_offset)
> +{
> +	xfs_data_csum_generate(bio);
> +	submit_bio(bio);
> +}
> +
>  static const struct iomap_dio_ops xfs_dio_write_ops = {
>  	.end_io		= xfs_dio_write_end_io,
> +	.submit_io	= xfs_dio_write_submit_io,
>  };
>  
>  /*
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index c08093a65352..ff346bbe454c 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -609,10 +609,8 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
>  
>  static inline void xfs_update_stable_writes(struct xfs_inode *ip)
>  {
> -	if (bdev_stable_writes(xfs_inode_buftarg(ip)->bt_bdev))
> -		mapping_set_stable_writes(VFS_I(ip)->i_mapping);
> -	else
> -		mapping_clear_stable_writes(VFS_I(ip)->i_mapping);
> +	/* XXX: unconditional for now */
> +	mapping_set_stable_writes(VFS_I(ip)->i_mapping);
>  }
>  
>  /*
> -- 
> 2.45.2
> 
> 

