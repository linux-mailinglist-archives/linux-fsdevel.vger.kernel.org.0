Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F71E7FF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE2OQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 10:16:02 -0400
Received: from verein.lst.de ([213.95.11.211]:33237 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgE2OQB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 10:16:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0963868B02; Fri, 29 May 2020 16:15:56 +0200 (CEST)
Date:   Fri, 29 May 2020 16:15:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, sth@linux.ibm.com,
        viro@zeniv.linux.org.uk, clm@fb.com, jaegeuk@kernel.org,
        hch@infradead.org, mark@fasheh.com, dhowells@redhat.com,
        balbi@kernel.org, damien.lemoal@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, deepa.kernel@gmail.com
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Message-ID: <20200529141555.GA3249@lst.de>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529141100.37519-1-pilgrimtao@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  	ns->size = i_size_read(ns->bdev->bd_inode);
> -	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +	ns->blksize_shift = ilog2(bdev_logical_block_size(ns->bdev));

This should just be:

	ns->blksize_shift = ns->bdev->bd_inode->i_blkbits;

> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 777734d1b4e5..55adb134451b 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -228,7 +228,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
>  	 */
>  	if (fdata->start_unit == 0) {
>  		struct block_device *bdev = bdget_disk(block->gdp, 0);
> -		bdev->bd_inode->i_blkbits = blksize_bits(fdata->blksize);
> +		bdev->bd_inode->i_blkbits = ilog2(fdata->blksize);

This also needs to set bdev->bd_block_size, so this probably warrants
a separate fix that be backported.  It might be nice to split out
a helper that sets bd_block_size and bd_inode->i_blkbits together
so that such a use is more obvious.

>  	} else if (inode->i_bdev) {
>  		blksize = bdev_logical_block_size(inode->i_bdev);
> -		blkbits = blksize_bits(blksize);
> +		blkbits = ilog2(blksize);

This can just use inode->i_bdev->bd_inode->i_blkbits.

> diff --git a/fs/buffer.c b/fs/buffer.c
> index fc8831c392d7..fa92e0afe349 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -907,7 +907,7 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
>  	loff_t sz = i_size_read(bdev->bd_inode);
>  
>  	if (sz) {
> -		unsigned int sizebits = blksize_bits(size);
> +		unsigned int sizebits = ilog2(size);

bdev->bd_inode->i_blkbits.

> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 1543b5af400e..7ea2cd3effcc 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1148,7 +1148,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  
>  	if (align & blocksize_mask) {
>  		if (bdev)
> -			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +			blkbits = ilog2(bdev_logical_block_size(bdev));

bdev->bd_inode->i_blkbits.

> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cb05f71cf850..b896da27942a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3458,7 +3458,7 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
>  
>  	if (align & blocksize_mask) {
>  		if (bdev)
> -			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +			blkbits = ilog2(bdev_logical_block_size(bdev));

bdev->bd_inode->i_blkbits.

>  		blocksize_mask = (1 << blkbits) - 1;
>  		if (align & blocksize_mask)
>  			return -EINVAL;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ec7b78e6feca..2a807657d544 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -203,7 +203,7 @@ static loff_t
>  iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		struct iomap_dio *dio, struct iomap *iomap)
>  {
> -	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> +	unsigned int blkbits = ilog2(bdev_logical_block_size(iomap->bdev));

iomap->bdev->bd_inode->i_blkbits.
