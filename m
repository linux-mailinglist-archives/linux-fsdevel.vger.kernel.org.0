Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C8F103D50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbfKTOdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 09:33:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:45242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729591AbfKTOdD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:33:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84FFBBF50;
        Wed, 20 Nov 2019 14:33:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 808061E484C; Wed, 20 Nov 2019 15:32:57 +0100 (CET)
Date:   Wed, 20 Nov 2019 15:32:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFCv3 4/4] ext4: Move to shared iolock even without
 dioread_nolock mount opt
Message-ID: <20191120143257.GE9509@quack2.suse.cz>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-5-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120050024.11161-5-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-11-19 10:30:24, Ritesh Harjani wrote:
> We were using shared locking only in case of dioread_nolock
> mount option in case of DIO overwrites. This mount condition
> is not needed anymore with current code, since:-
> 
> 1. No race between buffered writes & DIO overwrites.
> Since buffIO writes takes exclusive locks & DIO overwrites
> will take share locking. Also DIO path will make sure
> to flush and wait for any dirty page cache data.
> 
> 2. No race between buffered reads & DIO overwrites, since there
> is no block allocation that is possible with DIO overwrites.
> So no stale data exposure should happen. Same is the case
> between DIO reads & DIO overwrites.
> 
> 3. Also other paths like truncate is protected,
> since we wait there for any DIO in flight to be over.
> 
> 4. In case of buffIO writes followed by DIO reads:
> Since here also we take exclusive locks in ext4_write_begin/end().
> There is no risk of exposing any stale data in this case.
> Since after ext4_write_end, iomap_dio_rw() will wait to flush &
> wait for any dirty page cache data.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

There's one more case to consider here as I mentioned in [1]. There can be
mmap write instantiating dirty page and then someone starting writeback
against that page while DIO read is running still theoretically leading to
stale data exposure. Now this patch does not have influence on that race
but:

1) We need to close the race mentioned above. Maybe we could do that by
proactively allocating unwritten blocks for a page being faulted when there
is direct IO running against the file - the one who fills holes through
mmap write while direct IO is running on the file deserves to suffer the
performance penalty...

2) After this patch there's no point in having dioread_nolock at all so we
can just make that mount option no-op and drop all the precautions from the
buffered IO path connected with dioread_nolock.

[1] https://lore.kernel.org/linux-ext4/20190925092339.GB23277@quack2.suse.cz

								Honza

> ---
>  fs/ext4/file.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 18cbf9fa52c6..b97efc89cd63 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -383,6 +383,17 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>  	.end_io = ext4_dio_write_end_io,
>  };
>  
> +static bool ext4_dio_should_shared_lock(struct inode *inode)
> +{
> +	if (!S_ISREG(inode->i_mode))

This cannot happen for DIO so no point in checking here.

> +		return false;
> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))

Why this?

> +		return false;
> +	if (ext4_should_journal_data(inode))

We don't do DIO when journalling data so no point in checking here
(dio_supported() already checked this).

								Honza
> +		return false;
> +	return true;
> +}
> +
>  /*
>   * The intention here is to start with shared lock acquired then see if any
>   * condition requires an exclusive inode lock. If yes, then we restart the
> @@ -394,8 +405,8 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   * - For extending writes case we don't take the shared lock, since it requires
>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>   *
> - * - shared locking will only be true mostly in case of overwrites with
> - *   dioread_nolock mode. Otherwise we will switch to excl. iolock mode.
> + * - shared locking will only be true mostly in case of overwrites.
> + *   Otherwise we will switch to excl. iolock mode.
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  				 unsigned int *iolock, bool *unaligned_io,
> @@ -433,15 +444,14 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  		*extend = true;
>  	/*
>  	 * Determine whether the IO operation will overwrite allocated
> -	 * and initialized blocks. If so, check to see whether it is
> -	 * possible to take the dioread_nolock path.
> +	 * and initialized blocks.
>  	 *
>  	 * We need exclusive i_rwsem for changing security info
>  	 * in file_modified().
>  	 */
>  	if (*iolock == EXT4_IOLOCK_SHARED &&
>  	    (!IS_NOSEC(inode) || *unaligned_io || *extend ||
> -	     !ext4_should_dioread_nolock(inode) ||
> +	     !ext4_dio_should_shared_lock(inode) ||
>  	     !ext4_overwrite_io(inode, offset, count))) {
>  		ext4_iunlock(inode, *iolock);
>  		*iolock = EXT4_IOLOCK_EXCL;
> @@ -485,7 +495,10 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iolock = EXT4_IOLOCK_EXCL;
>  	}
>  
> -	if (iolock == EXT4_IOLOCK_SHARED && !ext4_should_dioread_nolock(inode))
> +	/*
> +	 * Check if we should continue with shared iolock
> +	 */
> +	if (iolock == EXT4_IOLOCK_SHARED && !ext4_dio_should_shared_lock(inode))
>  		iolock = EXT4_IOLOCK_EXCL;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
