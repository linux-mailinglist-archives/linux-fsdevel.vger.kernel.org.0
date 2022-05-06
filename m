Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2063F51DE45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 19:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444153AbiEFRWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiEFRWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 13:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADC46A05E;
        Fri,  6 May 2022 10:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64FB460FDC;
        Fri,  6 May 2022 17:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B10C385A8;
        Fri,  6 May 2022 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651857498;
        bh=4A3TDnwzNIQkCmhTH+BgTcDKjujJElM+WvmnYFaEDpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6FlTBoQThBbVFOvAmPX1ajahfZPlYJr/8i65xDqxjxRY1mtff20RFr5yzse8tkcv
         oMqnUCjrtBUPclMjEo5/FpLT88SxlUSr3sbBqFlYK2R2Os3+YwyuQNuzjxMzPmS6UD
         W8GgYguEiV/BElWTv6xhRNtHOPJF3IOTE3QngzKCmhFoI5LnzpHifkxAQnWuLDNlXV
         a5FTyAW8isuBxG3DmSzscEMcosThLY34pxh9yNh7piItvzL8vdJGEcThUU1SsVuQtz
         4MlPEZooYvQbMeEkK18n/h0Fv/IkhbwxrDc3fKLa526BAqvtjtD0bAlQ4WC8SHij2x
         vMaWC9BscC0yw==
Date:   Fri, 6 May 2022 10:18:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] iomap: add per-iomap_iter private data
Message-ID: <20220506171818.GB27212@magnolia>
References: <20220505201115.937837-1-hch@lst.de>
 <20220505201115.937837-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505201115.937837-4-hch@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 03:11:11PM -0500, Christoph Hellwig wrote:
> Allow the file system to keep state for all iterations.  For now only
> wire it up for direct I/O as there is an immediate need for it there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/btrfs/inode.c      | 2 +-
>  fs/erofs/data.c       | 2 +-
>  fs/ext4/file.c        | 4 ++--
>  fs/f2fs/file.c        | 4 ++--
>  fs/gfs2/file.c        | 4 ++--
>  fs/iomap/direct-io.c  | 8 +++++---
>  fs/xfs/xfs_file.c     | 6 +++---
>  fs/zonefs/super.c     | 4 ++--
>  include/linux/iomap.h | 5 +++--
>  9 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cdf96a2472821..88e617e9bf5df 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8168,7 +8168,7 @@ ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		size_t done_before)
>  {
>  	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> -			   IOMAP_DIO_PARTIAL, done_before);
> +			   IOMAP_DIO_PARTIAL, NULL, done_before);
>  }
>  
>  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 780db1e5f4b72..91c11d5bb9990 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -385,7 +385,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  		if (!err)
>  			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> -					    NULL, 0, 0);
> +					    NULL, 0, NULL, 0);
>  		if (err < 0)
>  			return err;
>  	}
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6feb07e3e1eb5..109d07629f81f 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -76,7 +76,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		return generic_file_read_iter(iocb, to);
>  	}
>  
> -	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, 0);
> +	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, NULL, 0);
>  	inode_unlock_shared(inode);
>  
>  	file_accessed(iocb->ki_filp);
> @@ -565,7 +565,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
> -			   0);
> +			   NULL, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5b89af0f27f05..04bc8709314bf 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4309,7 +4309,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	 */
>  	inc_page_count(sbi, F2FS_DIO_READ);
>  	dio = __iomap_dio_rw(iocb, to, &f2fs_iomap_ops,
> -			     &f2fs_iomap_dio_read_ops, 0, 0);
> +			     &f2fs_iomap_dio_read_ops, 0, NULL, 0);
>  	if (IS_ERR_OR_NULL(dio)) {
>  		ret = PTR_ERR_OR_ZERO(dio);
>  		if (ret != -EIOCBQUEUED)
> @@ -4527,7 +4527,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  	if (pos + count > inode->i_size)
>  		dio_flags |= IOMAP_DIO_FORCE_WAIT;
>  	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
> -			     &f2fs_iomap_dio_write_ops, dio_flags, 0);
> +			     &f2fs_iomap_dio_write_ops, dio_flags, NULL, 0);
>  	if (IS_ERR_OR_NULL(dio)) {
>  		ret = PTR_ERR_OR_ZERO(dio);
>  		if (ret == -ENOTBLK)
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 48f01323c37c1..76307a90bf81f 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -839,7 +839,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
>  	pagefault_disable();
>  	to->nofault = true;
>  	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
> -			   IOMAP_DIO_PARTIAL, written);
> +			   IOMAP_DIO_PARTIAL, NULL, written);
>  	to->nofault = false;
>  	pagefault_enable();
>  	if (ret > 0)
> @@ -906,7 +906,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
>  
>  	from->nofault = true;
>  	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
> -			   IOMAP_DIO_PARTIAL, read);
> +			   IOMAP_DIO_PARTIAL, NULL, read);
>  	from->nofault = false;
>  
>  	if (ret == -ENOTBLK)
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 15929690d89e3..145b2668478d0 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -484,7 +484,7 @@ static loff_t iomap_dio_iter(const struct iomap_iter *iter,
>  struct iomap_dio *
>  __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags, size_t done_before)
> +		unsigned int dio_flags, void *private, size_t done_before)
>  {
>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -493,6 +493,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		.pos		= iocb->ki_pos,
>  		.len		= iov_iter_count(iter),
>  		.flags		= IOMAP_DIRECT,
> +		.private	= private,
>  	};
>  	loff_t end = iomi.pos + iomi.len - 1, ret = 0;
>  	bool wait_for_completion =
> @@ -684,11 +685,12 @@ EXPORT_SYMBOL_GPL(__iomap_dio_rw);
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags, size_t done_before)
> +		unsigned int dio_flags, void *private, size_t done_before)
>  {
>  	struct iomap_dio *dio;
>  
> -	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, done_before);
> +	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
> +			     done_before);
>  	if (IS_ERR_OR_NULL(dio))
>  		return PTR_ERR_OR_ZERO(dio);
>  	return iomap_dio_complete(dio);
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5bddb1e9e0b3e..85c412107a100 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -225,7 +225,7 @@ xfs_file_dio_read(
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
>  		return ret;
> -	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, 0);
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -534,7 +534,7 @@ xfs_file_dio_write_aligned(
>  	}
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops, 0, 0);
> +			   &xfs_dio_write_ops, 0, NULL, 0);
>  out_unlock:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> @@ -612,7 +612,7 @@ xfs_file_dio_write_unaligned(
>  
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops, flags, 0);
> +			   &xfs_dio_write_ops, flags, NULL, 0);
>  
>  	/*
>  	 * Retry unaligned I/O with exclusive blocking semantics if the DIO
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index e20e7c8414896..777fe626c2b38 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -861,7 +861,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>  		ret = zonefs_file_dio_append(iocb, from);
>  	else
>  		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
> -				   &zonefs_write_dio_ops, 0, 0);
> +				   &zonefs_write_dio_ops, 0, NULL, 0);
>  	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
>  	    (ret > 0 || ret == -EIOCBQUEUED)) {
>  		if (ret > 0)
> @@ -996,7 +996,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		}
>  		file_accessed(iocb->ki_filp);
>  		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
> -				   &zonefs_read_dio_ops, 0, 0);
> +				   &zonefs_read_dio_ops, 0, NULL, 0);
>  	} else {
>  		ret = generic_file_read_iter(iocb, to);
>  		if (ret == -EIO)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 526c9e7f2eaf8..ea72fa58c06c3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -188,6 +188,7 @@ struct iomap_iter {
>  	unsigned flags;
>  	struct iomap iomap;
>  	struct iomap srcmap;
> +	void *private;
>  };
>  
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
> @@ -354,10 +355,10 @@ struct iomap_dio_ops {
>  
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags, size_t done_before);
> +		unsigned int dio_flags, void *private, size_t done_before);
>  struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags, size_t done_before);
> +		unsigned int dio_flags, void *private, size_t done_before);
>  ssize_t iomap_dio_complete(struct iomap_dio *dio);
>  void iomap_dio_bio_end_io(struct bio *bio);
>  
> -- 
> 2.30.2
> 
