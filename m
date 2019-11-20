Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC51103CA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 14:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfKTNzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 08:55:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:51716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbfKTNzT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:55:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D78BCAFA8;
        Wed, 20 Nov 2019 13:55:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3F5F71E484C; Wed, 20 Nov 2019 14:55:14 +0100 (CET)
Date:   Wed, 20 Nov 2019 14:55:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFCv3 3/4] ext4: start with shared iolock in case of DIO
 instead of excl. iolock
Message-ID: <20191120135514.GD9509@quack2.suse.cz>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-4-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120050024.11161-4-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-11-19 10:30:23, Ritesh Harjani wrote:
> Earlier there was no shared lock in DIO read path.
> But this patch (16c54688592ce: ext4: Allow parallel DIO reads)
> simplified some of the locking mechanism while still allowing
> for parallel DIO reads by adding shared lock in inode DIO
> read path.
> 
> But this created problem with mixed read/write workload.
> It is due to the fact that in DIO path, we first start with
> exclusive lock and only when we determine that it is a ovewrite
> IO, we downgrade the lock. This causes the problem, since
> with above patch we have shared locking in DIO reads.
> 
> So, this patch tries to fix this issue by starting with
> shared lock and then switching to exclusive lock only
> when required based on ext4_dio_write_checks().
> 
> Other than that, it also simplifies below cases:-
> 
> 1. Simplified ext4_unaligned_aio API to ext4_unaligned_io.
> Previous API was abused in the sense that it was not really checking
> for AIO anywhere also it used to check for extending writes.
> So this API was renamed and simplified to ext4_unaligned_io()
> which actully only checks if the IO is really unaligned.
> 
> Now, in case of unaligned direct IO, iomap_dio_rw needs to do
> zeroing of partial block and that will require serialization
> against other direct IOs in the same block. So we take a excl iolock
> for any unaligned DIO.
> In case of AIO we also need to wait for any outstanding IOs to
> complete so that conversion from unwritten to written is completed
> before anyone try to map the overlapping block. Hence we take
> excl iolock and also wait for inode_dio_wait() for unaligned DIO case.
> Please note since we are anyway taking an exclusive lock in unaligned IO,
> inode_dio_wait() becomes a no-op in case of non-AIO DIO.
> 
> 2. Added ext4_extending_io(). This checks if the IO is extending the file.
> 
> 3. Added ext4_dio_write_checks().
> In this we start with shared iolock and only switch to exclusive iolock
> if required. So in most cases with aligned, non-extening, dioread_nolock
> overwrites tries to write with a shared locking.
> If not, then we restart the operation in ext4_dio_write_checks(),
> after acquiring excl iolock.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/file.c | 191 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 142 insertions(+), 49 deletions(-)

Thanks for the patch! Some comments below...

> @@ -365,15 +383,110 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>  	.end_io = ext4_dio_write_end_io,
>  };
>  
> +/*
> + * The intention here is to start with shared lock acquired then see if any
> + * condition requires an exclusive inode lock. If yes, then we restart the
> + * whole operation by releasing the shared lock and acquiring exclusive lock.
> + *
> + * - For unaligned_io we never take shared lock as it may cause data corruption
> + *   when two unaligned IO tries to modify the same block e.g. while zeroing.
> + *
> + * - For extending writes case we don't take the shared lock, since it requires
> + *   updating inode i_disksize and/or orphan handling with exclusive lock.
> + *
> + * - shared locking will only be true mostly in case of overwrites with
> + *   dioread_nolock mode. Otherwise we will switch to excl. iolock mode.
> + */
> +static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
> +				 unsigned int *iolock, bool *unaligned_io,
> +				 bool *extend)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	loff_t offset = iocb->ki_pos;
> +	loff_t final_size;
> +	size_t count;
> +	ssize_t ret;
> +
> +restart:
> +	/* Fallback to buffered I/O if the inode does not support direct I/O. */
> +	if (!ext4_dio_supported(inode)) {
> +		ext4_iunlock(inode, *iolock);
> +		return ext4_buffered_write_iter(iocb, from);
> +	}

I don't think it is good to hide things like this fallback to buffered IO
in ext4_dio_write_checks(). Similarly with 'unaligned_io' and 'extend'
variables below. So I'd rather leave this in ext4_dio_write_iter() and just
move file_modified() from ext4_write_checks() since that seems to be the
only thing that cannot be always done with shared i_rwsem, can it?

> +
> +	ret = ext4_generic_write_checks(iocb, from);
> +	if (ret <= 0) {
> +		ext4_iunlock(inode, *iolock);
> +		return ret;
> +	}
> +
> +	/* Recalculate since offset & count may change above. */
> +	offset = iocb->ki_pos;
> +	count = iov_iter_count(from);
> +	final_size = offset + count;
> +
> +	if (ext4_unaligned_io(inode, from, offset))
> +		*unaligned_io = true;

No need to recheck alignment here. That cannot change over time regardless
of locks we hold...

> +
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
> +	if (*iolock == EXT4_IOLOCK_SHARED &&
> +	    (!IS_NOSEC(inode) || *unaligned_io || *extend ||
> +	     !ext4_should_dioread_nolock(inode) ||
> +	     !ext4_overwrite_io(inode, offset, count))) {
> +		ext4_iunlock(inode, *iolock);
> +		*iolock = EXT4_IOLOCK_EXCL;
> +		ext4_ilock(inode, *iolock);
> +		goto restart;
> +	}
> +
> +	ret = file_modified(file);
> +	if (ret < 0) {
> +		ext4_iunlock(inode, *iolock);
> +		return ret;
> +	}
> +
> +	return count;
> +}
> +
>  static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	ssize_t ret;
> -	size_t count;
> -	loff_t offset;
>  	handle_t *handle;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> -	bool extend = false, overwrite = false, unaligned_aio = false;
> -	unsigned int iolock = EXT4_IOLOCK_EXCL;
> +	loff_t offset = iocb->ki_pos;
> +	size_t count = iov_iter_count(from);
> +	bool extend = false, unaligned_io = false;
> +	unsigned int iolock = EXT4_IOLOCK_SHARED;
> +
> +	/*
> +	 * We initially start with shared inode lock
> +	 * unless it is unaligned IO which needs
> +	 * exclusive lock anyways.
> +	 */
> +	if (ext4_unaligned_io(inode, from, offset)) {
> +		unaligned_io = true;
> +		iolock = EXT4_IOLOCK_EXCL;
> +	}
> +	/*
> +	 * Extending writes need exclusive lock.
> +	 */
> +	if (ext4_extending_io(inode, offset, count)) {
> +		extend = true;
> +		iolock = EXT4_IOLOCK_EXCL;
> +	}

You cannot read EXT4_I(inode)->i_disksize without some lock (either
inode->i_rwsem or EXT4_I(inode)->i_data_sem). So I'd just do here a quick
check with i_size here (probably don't set extend, but just make note to
start with exclusive i_rwsem) and later when we hold i_rwsem, we can do a
reliable check.

> +	if (iolock == EXT4_IOLOCK_SHARED && !ext4_should_dioread_nolock(inode))
> +		iolock = EXT4_IOLOCK_EXCL;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
>  		if (!ext4_ilock_nowait(inode, iolock))
> @@ -382,47 +495,28 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ext4_ilock(inode, iolock);
>  	}
>  
> -	if (!ext4_dio_supported(inode)) {
> -		ext4_iunlock(inode, iolock);
> -		/*
> -		 * Fallback to buffered I/O if the inode does not support
> -		 * direct I/O.
> -		 */
> -		return ext4_buffered_write_iter(iocb, from);
> -	}
> -
> -	ret = ext4_write_checks(iocb, from);
> -	if (ret <= 0) {
> -		ext4_iunlock(inode, iolock);
> +	ret = ext4_dio_write_checks(iocb, from, &iolock, &unaligned_io,
> +				    &extend);
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
> -	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
> -	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
> -		unaligned_aio = true;
> -		inode_dio_wait(inode);
> -	}
>  
>  	/*
> -	 * Determine whether the I/O will overwrite allocated and initialized
> -	 * blocks. If so, check to see whether it is possible to take the
> -	 * dioread_nolock path.
> +	 * Unaligned direct IO must be serialized among each other as zeroing
> +	 * of partial blocks of two competing unaligned IOs can result in data
> +	 * corruption.
> +	 *
> +	 * So we make sure we don't allow any unaligned IO in flight.
> +	 * For IOs where we need not wait (like unaligned non-AIO DIO),
> +	 * below inode_dio_wait() may anyway become a no-op, since we start
> +	 * with exclusive lock.
>  	 */
> -	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
> -	    ext4_should_dioread_nolock(inode)) {
> -		overwrite = true;
> -		ext4_ilock_demote(inode, iolock);
> -		iolock = EXT4_IOLOCK_SHARED;
> -	}
> +	if (unaligned_io)
> +		inode_dio_wait(inode);
>  
> -	if (offset + count > EXT4_I(inode)->i_disksize) {
> +	if (extend) {
>  		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>  		if (IS_ERR(handle)) {
>  			ret = PTR_ERR(handle);
> @@ -435,12 +529,11 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  		}
>  
> -		extend = true;
>  		ext4_journal_stop(handle);
>  	}
>  
>  	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
> -			   is_sync_kiocb(iocb) || unaligned_aio || extend);
> +			   is_sync_kiocb(iocb) || unaligned_io || extend);
>  
>  	if (extend)
>  		ret = ext4_handle_inode_extension(inode, offset, ret, count);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
