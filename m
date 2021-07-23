Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE53D360E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhGWHYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 03:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhGWHYa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 543C660EBD;
        Fri, 23 Jul 2021 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627027504;
        bh=/W9QIIEUNToeuX48XLcyNEVSSAu2I80C1zls/gY1dBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNxfeqQ/Z1CyZGlgBKytzW1O7c41Mk2W0b0ycup+6dDps26z9sWm0uko9E6x/1zKg
         x3jLijYwkcPNCqshg+xEiFWrPeU2MynG/pcMksRajMdzRovi6ypPlWMLgIXbIzWWsJ
         OmUMvVH8gUQaQr8ivtfGKpaVJ+Jh/9kqw4IFk+uf1zet0U0uKDzmFNnAkJHpYAb7WE
         YTUSdDrQSb5zUBRRWy+3GgQpUo+3Zc93PCAB+NoNIs5EnR6pofOYGVMfkHyrsAmmfQ
         KLyI2lfktDYg0arl1Vw5uu9oX0z9fCZ520lDOjd2vE9HHtXS3FJ3i+pSaAUruaAmEk
         5vrANOMfnQNmA==
Date:   Fri, 23 Jul 2021 01:05:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 6/9] f2fs: implement iomap operations
Message-ID: <YPp4LjpH3DgFQbdP@sol.localdomain>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-7-ebiggers@kernel.org>
 <YPU+3inGclUtcSpJ@infradead.org>
 <YPog4SDY3nNC78sK@sol.localdomain>
 <YPpM09DLTB28obqQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPpM09DLTB28obqQ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 23, 2021 at 06:00:03AM +0100, Christoph Hellwig wrote:
> On Thu, Jul 22, 2021 at 06:52:33PM -0700, Eric Biggers wrote:
> > I am trying to do this, but unfortunately I don't see a way to make it work
> > correctly in all cases.
> > 
> > The main problem is that when iomap_dio_rw() returns an error (other than
> > -EIOCBQUEUED), there is no way to know whether ->end_io() has been called or
> > not.  This is because iomap_dio_rw() can fail either early, before "starting"
> > the I/O (in which case ->end_io() won't have been called), or later, after
> > "starting" the I/O (in which case ->end_io() will have been called).  Note that
> > this can't be worked around by checking whether the iov_iter has been advanced
> > or not, since a failure could occur between "starting" the I/O and the iov_iter
> > being advanced for the first time.
> > 
> > Would you be receptive to adding a ->begin_io() callback to struct iomap_dio_ops
> > in order to allow filesystems to maintain counters like this?
> 
> I think we can triviall fix this by using the slightly lower level
> __iomap_dio_rw API.  Incremental patch to my previous one below:
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4fed90cc1462..11844bd0cb7a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4243,6 +4243,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	const loff_t pos = iocb->ki_pos;
>  	const size_t count = iov_iter_count(to);
> +	struct iomap_dio *dio;
>  	ssize_t ret;
>  
>  	if (count == 0)
> @@ -4260,8 +4261,13 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	}
>  
>  	inc_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
> -	ret = iomap_dio_rw(iocb, to, &f2fs_iomap_ops, &f2fs_iomap_dio_ops, 0);
> -
> +	dio = __iomap_dio_rw(iocb, to, &f2fs_iomap_ops, &f2fs_iomap_dio_ops, 0);
> +	if (IS_ERR_OR_NULL(dio)) {
> +		dec_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
> +		ret = PTR_ERR_OR_ZERO(dio);
> +	} else {
> +		ret = iomap_dio_complete(dio);
> +	}
>  	up_read(&fi->i_gc_rwsem[READ]);
>  
>  	file_accessed(file);
> @@ -4271,8 +4277,6 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	else if (ret == -EIOCBQUEUED)
>  		f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_READ_IO,
>  				   count - iov_iter_count(to));
> -	else
> -		dec_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
>  out:
>  	trace_f2fs_direct_IO_exit(inode, pos, count, READ, ret);
>  	return ret;

I wouldn't call it trivial, but yes that seems to work (after fixing it to
handle EIOCBQUEUED correctly).  Take a look at the v2 I've sent out.  Thanks!

- Eric
