Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A9114082
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 13:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfLEMFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 07:05:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:57222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbfLEMFb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:05:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 990FDB331;
        Thu,  5 Dec 2019 12:05:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 48E1C1E0B80; Thu,  5 Dec 2019 13:05:29 +0100 (CET)
Date:   Thu, 5 Dec 2019 13:05:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCHv4 3/3] ext4: Move to shared i_rwsem even without
 dioread_nolock mount opt
Message-ID: <20191205120529.GB32639@quack2.suse.cz>
References: <20191205064624.13419-1-riteshh@linux.ibm.com>
 <20191205064624.13419-4-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205064624.13419-4-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-12-19 12:16:24, Ritesh Harjani wrote:
> We were using shared locking only in case of dioread_nolock mount option in case
> of DIO overwrites. This mount condition is not needed anymore with current code,
> since:-
> 
> 1. No race between buffered writes & DIO overwrites. Since buffIO writes takes
> exclusive lock & DIO overwrites will take shared locking. Also DIO path will
> make sure to flush and wait for any dirty page cache data.
> 
> 2. No race between buffered reads & DIO overwrites, since there is no block
> allocation that is possible with DIO overwrites. So no stale data exposure
> should happen. Same is the case between DIO reads & DIO overwrites.
> 
> 3. Also other paths like truncate is protected, since we wait there for any DIO
> in flight to be over.
> 
> 4. In case of buffIO writes followed by DIO reads:- since here also we take
> exclusive lock in ext4_write_begin/end(). There is no risk of exposing any
> stale data in this case. Since after ext4_write_end, iomap_dio_rw() will flush &
> wait for any dirty page cache data to be written.

The case 4) doesn't seem to be relevant for this patch anymore? Otherwise
the patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/file.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index cbafaec9e4fc..682ed956eb02 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -392,8 +392,8 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   * - For extending writes case we don't take the shared lock, since it requires
>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>   *
> - * - shared locking will only be true mostly with overwrites in dioread_nolock
> - *   mode. Otherwise we will switch to exclusive i_rwsem lock.
> + * - shared locking will only be true mostly with overwrites. Otherwise we will
> + *   switch to exclusive i_rwsem lock.
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  				     bool *ilock_shared, bool *extend)
> @@ -415,14 +415,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  		*extend = true;
>  	/*
>  	 * Determine whether the IO operation will overwrite allocated
> -	 * and initialized blocks. If so, check to see whether it is
> -	 * possible to take the dioread_nolock path.
> -	 *
> +	 * and initialized blocks.
>  	 * We need exclusive i_rwsem for changing security info
>  	 * in file_modified().
>  	 */
>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
> -	     !ext4_should_dioread_nolock(inode) ||
>  	     !ext4_overwrite_io(inode, offset, count))) {
>  		inode_unlock_shared(inode);
>  		*ilock_shared = false;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
