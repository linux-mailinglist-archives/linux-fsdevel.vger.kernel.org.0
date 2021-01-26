Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91653039C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391820AbhAZKDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 05:03:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:59574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391228AbhAZKC5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:02:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB9ACAF17;
        Tue, 26 Jan 2021 10:02:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 925081E1519; Tue, 26 Jan 2021 11:02:15 +0100 (CET)
Date:   Tue, 26 Jan 2021 11:02:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] bdev: Do not return EBUSY if bdev discard races with
 write
Message-ID: <20210126100215.GA10966@quack2.suse.cz>
References: <20210107154034.1490-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107154034.1490-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-01-21 16:40:34, Jan Kara wrote:
> blkdev_fallocate() tries to detect whether a discard raced with an
> overlapping write by calling invalidate_inode_pages2_range(). However
> this check can give both false negatives (when writing using direct IO
> or when writeback already writes out the written pagecache range) and
> false positives (when write is not actually overlapping but ends in the
> same page when blocksize < pagesize). This actually causes issues for
> qemu which is getting confused by EBUSY errors.
> 
> Fix the problem by removing this conflicting write detection since it is
> inherently racy and thus of little use anyway.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> CC: "Darrick J. Wong" <darrick.wong@oracle.com>
> Link: https://lore.kernel.org/qemu-devel/20201111153913.41840-1-mlevitsk@redhat.com
> Signed-off-by: Jan Kara <jack@suse.cz>

Jens, can you please pick up this patch? Thanks!

									Honza

> ---
>  fs/block_dev.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 3e5b02f6606c..a97f43b49839 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1797,13 +1797,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  		return error;
>  
>  	/*
> -	 * Invalidate again; if someone wandered in and dirtied a page,
> -	 * the caller will be given -EBUSY.  The third argument is
> -	 * inclusive, so the rounding here is safe.
> +	 * Invalidate the page cache again; if someone wandered in and dirtied
> +	 * a page, we just discard it - userspace has no way of knowing whether
> +	 * the write happened before or after discard completing...
>  	 */
> -	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
> -					     start >> PAGE_SHIFT,
> -					     end >> PAGE_SHIFT);
> +	return truncate_bdev_range(bdev, file->f_mode, start, end);
>  }
>  
>  const struct file_operations def_blk_fops = {
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
