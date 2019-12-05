Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9D11407A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 13:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfLEMDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 07:03:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:55080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729165AbfLEMDN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:03:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA5A3AD17;
        Thu,  5 Dec 2019 12:03:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 974D71E0B80; Thu,  5 Dec 2019 13:03:07 +0100 (CET)
Date:   Thu, 5 Dec 2019 13:03:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCHv4 2/3] ext4: Start with shared i_rwsem in case of DIO
 instead of exclusive
Message-ID: <20191205120307.GA32639@quack2.suse.cz>
References: <20191205064624.13419-1-riteshh@linux.ibm.com>
 <20191205064624.13419-3-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205064624.13419-3-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-12-19 12:16:23, Ritesh Harjani wrote:
> Earlier there was no shared lock in DIO read path. But this patch
> (16c54688592ce: ext4: Allow parallel DIO reads)
> simplified some of the locking mechanism while still allowing for parallel DIO
> reads by adding shared lock in inode DIO read path.
> 
> But this created problem with mixed read/write workload. It is due to the fact
> that in DIO path, we first start with exclusive lock and only when we determine
> that it is a ovewrite IO, we downgrade the lock. This causes the problem, since
> we still have shared locking in DIO reads.
> 
> So, this patch tries to fix this issue by starting with shared lock and then
> switching to exclusive lock only when required based on ext4_dio_write_checks().
> 
> Other than that, it also simplifies below cases:-
> 
> 1. Simplified ext4_unaligned_aio API to ext4_unaligned_io. Previous API was
> abused in the sense that it was not really checking for AIO anywhere also it
> used to check for extending writes. So this API was renamed and simplified to
> ext4_unaligned_io() which actully only checks if the IO is really unaligned.
> 
> Now, in case of unaligned direct IO, iomap_dio_rw needs to do zeroing of partial
> block and that will require serialization against other direct IOs in the same
> block. So we take a exclusive inode lock for any unaligned DIO. In case of AIO
> we also need to wait for any outstanding IOs to complete so that conversion from
> unwritten to written is completed before anyone try to map the overlapping block.
> Hence we take exclusive inode lock and also wait for inode_dio_wait() for
> unaligned DIO case. Please note since we are anyway taking an exclusive lock in
> unaligned IO, inode_dio_wait() becomes a no-op in case of non-AIO DIO.
> 
> 2. Added ext4_extending_io(). This checks if the IO is extending the file.
> 
> 3. Added ext4_dio_write_checks(). In this we start with shared inode lock and
> only switch to exclusive lock if required. So in most cases with aligned,
> non-extending, dioread_nolock & overwrites, it tries to write with a shared
> lock. If not, then we restart the operation in ext4_dio_write_checks(), after
> acquiring exclusive lock.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Cool, the patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Two small nits below:

> -static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> +static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
> +					 struct iov_iter *from)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	ssize_t ret;
> @@ -228,11 +235,21 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  		iov_iter_truncate(from, sbi->s_bitmap_maxbytes - iocb->ki_pos);
>  	}
>  
> +	return iov_iter_count(from);
> +}

You return iov_iter_count() from ext4_generic_write_checks()...

> +static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
> +				     bool *ilock_shared, bool *extend)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	loff_t offset;
> +	size_t count;
> +	ssize_t ret;
> +
> +restart:
> +	ret = ext4_generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out;
> +
> +	offset = iocb->ki_pos;
> +	count = iov_iter_count(from);

But you don't use the returned count here and just call iov_iter_count()
again (which is cheap anyway but still it's strange).

> +	if (ext4_extending_io(inode, offset, count))
> +		*extend = true;
> +	/*
> +	 * Determine whether the IO operation will overwrite allocated
> +	 * and initialized blocks. If so, check to see whether it is
> +	 * possible to take the dioread_nolock path.
> +	 *
> +	 * We need exclusive i_rwsem for changing security info
> +	 * in file_modified().
> +	 */
> +	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
> +	     !ext4_should_dioread_nolock(inode) ||
> +	     !ext4_overwrite_io(inode, offset, count))) {
> +		inode_unlock_shared(inode);
> +		*ilock_shared = false;
> +		inode_lock(inode);
> +		goto restart;
> +	}
> +
> +	ret = file_modified(file);
> +	if (ret < 0)
> +		goto out;
> +
> +	return count;

And then you return count from ext4_dio_write_checks() here...

> -	ret = ext4_write_checks(iocb, from);
> -	if (ret <= 0) {
> -		inode_unlock(inode);
> +	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
> +	if (ret <= 0)
>  		return ret;
> -	}
>  
> -	/*
> -	 * Unaligned asynchronous direct I/O must be serialized among each
> -	 * other as the zeroing of partial blocks of two competing unaligned
> -	 * asynchronous direct I/O writes can result in data corruption.
> -	 */
>  	offset = iocb->ki_pos;
>  	count = iov_iter_count(from);

And then again just don't use the value here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
