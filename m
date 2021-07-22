Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E13D2DE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 22:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhGVUHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 16:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhGVUHG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 16:07:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91D0D60EB1;
        Thu, 22 Jul 2021 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626986860;
        bh=pGvSxhiZEcY6+C/PtZZ5RKkHCoa/6474xXrVF/SSIaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTgSRXnsorFhgbBoMCRPRhM17JtAYMGrnr6PfWEHNoLEDJO777AEnnUNWWsV4uoPU
         QnMsSKfvSAGC+M7yVLKh24qK1h971BeJkKxZ2I/GB08KyDsP9bkIyyLVw2/H3Srxx1
         xknZMzsqn1ne/+9Csnnx98kormcCuIjD5/qwfkjPGy9B15IOC68Jzylfi2JrpVTaiZ
         MWeM5gS8bTNhVLeNma2tO8QIemSoSxr1uZsYw4xvAArjIvE5GUSwtVZ+tnd5SSozX2
         KhlFe33iaGHzWhbXLswxRYbzBzDU/omlWHs57+zDYtJA87m/IqfjtpWcT30ghvgrf0
         zgZYM3aYMwyYA==
Date:   Thu, 22 Jul 2021 13:47:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 6/9] f2fs: implement iomap operations
Message-ID: <YPnZa5dFVP7vtB9q@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-7-ebiggers@kernel.org>
 <YPU+3inGclUtcSpJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPU+3inGclUtcSpJ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/19, Christoph Hellwig wrote:
> On Fri, Jul 16, 2021 at 09:39:16AM -0500, Eric Biggers wrote:
> > +static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
> > +				    struct bio *bio, loff_t file_offset)
> > +{
> > +	struct f2fs_private_dio *dio;
> > +	bool write = (bio_op(bio) == REQ_OP_WRITE);
> > +
> > +	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> > +			sizeof(struct f2fs_private_dio), GFP_NOFS);
> > +	if (!dio)
> > +		goto out;
> > +
> > +	dio->inode = inode;
> > +	dio->orig_end_io = bio->bi_end_io;
> > +	dio->orig_private = bio->bi_private;
> > +	dio->write = write;
> > +
> > +	bio->bi_end_io = f2fs_dio_end_io;
> > +	bio->bi_private = dio;
> > +
> > +	inc_page_count(F2FS_I_SB(inode),
> > +			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> > +
> > +	return submit_bio(bio);
> 
> I don't think there is any need for this mess.  The F2FS_DIO_WRITE /
> F2FS_DIO_READ counts are only used to check if there is any inflight
> I/O at all.  So instead we can increment them once before calling
> iomap_dio_rw, and decrement them in ->end_io or for a failure/noop
> exit from iomap_dio_rw.  Untested patch below.  Note that all this
> would be much simpler to review if the last three patches were folded
> into a single one.

Eric, wdyt?

I've merged v1 to v5, including Christoph's comment in v2.

> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 4fbf28f5aaab..9f9cc49fbe94 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3369,50 +3369,6 @@ static int f2fs_write_end(struct file *file,
>  	return copied;
>  }
>  
> -static void f2fs_dio_end_io(struct bio *bio)
> -{
> -	struct f2fs_private_dio *dio = bio->bi_private;
> -
> -	dec_page_count(F2FS_I_SB(dio->inode),
> -			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> -
> -	bio->bi_private = dio->orig_private;
> -	bio->bi_end_io = dio->orig_end_io;
> -
> -	kfree(dio);
> -
> -	bio_endio(bio);
> -}
> -
> -static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
> -				    struct bio *bio, loff_t file_offset)
> -{
> -	struct f2fs_private_dio *dio;
> -	bool write = (bio_op(bio) == REQ_OP_WRITE);
> -
> -	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> -			sizeof(struct f2fs_private_dio), GFP_NOFS);
> -	if (!dio)
> -		goto out;
> -
> -	dio->inode = inode;
> -	dio->orig_end_io = bio->bi_end_io;
> -	dio->orig_private = bio->bi_private;
> -	dio->write = write;
> -
> -	bio->bi_end_io = f2fs_dio_end_io;
> -	bio->bi_private = dio;
> -
> -	inc_page_count(F2FS_I_SB(inode),
> -			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> -
> -	return submit_bio(bio);
> -out:
> -	bio->bi_status = BLK_STS_IOERR;
> -	bio_endio(bio);
> -	return BLK_QC_T_NONE;
> -}
> -
>  void f2fs_invalidate_page(struct page *page, unsigned int offset,
>  							unsigned int length)
>  {
> @@ -4006,6 +3962,18 @@ const struct iomap_ops f2fs_iomap_ops = {
>  	.iomap_begin	= f2fs_iomap_begin,
>  };
>  
> +static int f2fs_dio_end_io(struct kiocb *iocb, ssize_t size, int error,
> +		unsigned flags)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(iocb->ki_filp));
> +
> +	if (iocb->ki_flags & IOCB_WRITE)
> +		dec_page_count(sbi, F2FS_DIO_WRITE);
> +	else
> +		dec_page_count(sbi, F2FS_DIO_READ);
> +	return 0;
> +}
> +
>  const struct iomap_dio_ops f2fs_iomap_dio_ops = {
> -	.submit_io	= f2fs_dio_submit_bio,
> +	.end_io		= f2fs_dio_end_io,
>  };
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 6dbbac05a15c..abd521dc504a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1750,13 +1750,6 @@ struct f2fs_sb_info {
>  #endif
>  };
>  
> -struct f2fs_private_dio {
> -	struct inode *inode;
> -	void *orig_private;
> -	bio_end_io_t *orig_end_io;
> -	bool write;
> -};
> -
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  #define f2fs_show_injection_info(sbi, type)					\
>  	printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",	\
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6b8eac6b25d4..4fed90cc1462 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4259,6 +4259,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		down_read(&fi->i_gc_rwsem[READ]);
>  	}
>  
> +	inc_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
>  	ret = iomap_dio_rw(iocb, to, &f2fs_iomap_ops, &f2fs_iomap_dio_ops, 0);
>  
>  	up_read(&fi->i_gc_rwsem[READ]);
> @@ -4270,6 +4271,8 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	else if (ret == -EIOCBQUEUED)
>  		f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_READ_IO,
>  				   count - iov_iter_count(to));
> +	else
> +		dec_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
>  out:
>  	trace_f2fs_direct_IO_exit(inode, pos, count, READ, ret);
>  	return ret;
> @@ -4446,6 +4449,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  
>  	if (pos + count > inode->i_size)
>  		dio_flags |= IOMAP_DIO_FORCE_WAIT;
> +	inc_page_count(F2FS_I_SB(inode), F2FS_DIO_WRITE);
>  	ret = iomap_dio_rw(iocb, from, &f2fs_iomap_ops, &f2fs_iomap_dio_ops,
>  			   dio_flags);
>  	if (ret == -ENOTBLK)
> @@ -4459,6 +4463,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  
>  	up_read(&fi->i_gc_rwsem[WRITE]);
>  
> +	if (ret <= 0 && ret != -EIOCBQUEUED)
> +		dec_page_count(F2FS_I_SB(inode), F2FS_DIO_WRITE);
> +
>  	if (ret < 0) {
>  		if (ret == -EIOCBQUEUED)
>  			f2fs_update_iostat(sbi, APP_DIRECT_IO,
