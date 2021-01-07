Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6665B2ED3A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 16:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbhAGPic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 10:38:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:56780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbhAGPic (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:38:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1C9CAD5C;
        Thu,  7 Jan 2021 15:37:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8289A1E0872; Thu,  7 Jan 2021 16:37:49 +0100 (CET)
Date:   Thu, 7 Jan 2021 16:37:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: fallocate: avoid false positive on collision
 detection
Message-ID: <20210107153749.GH12990@quack2.suse.cz>
References: <45420b24124b5b91bc0a80a4abad2e06acb8c2b3.camel@redhat.com>
 <20210107124022.900172-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20210107124022.900172-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 07-01-21 14:40:22, Maxim Levitsky wrote:
> Align start and end on page boundaries before calling
> invalidate_inode_pages2_range.
> 
> This might allow us to miss a collision if the write and the discard were done
> to the same page and do overlap but it is still better than returning -EBUSY
> if those writes didn't overlap.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Thanks for getting back to this and I'm sorry I didn't get to this earlier
myself! I actually think the fix should be different as we discussed with
Darrick. Attached patch should fix the issue for you (I'll also post it
formally for inclusion).

								Honza

> ---
>  fs/block_dev.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e84b1928b94..97f0d16661b5 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1970,6 +1970,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	loff_t end = start + len - 1;
>  	loff_t isize;
>  	int error;
> +	pgoff_t invalidate_first_page, invalidate_last_page;
>  
>  	/* Fail if we don't recognize the flags. */
>  	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> @@ -2020,12 +2021,23 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  
>  	/*
>  	 * Invalidate again; if someone wandered in and dirtied a page,
> -	 * the caller will be given -EBUSY.  The third argument is
> -	 * inclusive, so the rounding here is safe.
> +	 * the caller will be given -EBUSY.
> +	 *
> +	 * If the start/end of the range is not page aligned, exclude the
> +	 * non aligned regions to avoid false positives.
>  	 */
> +	invalidate_first_page = DIV_ROUND_UP(start, PAGE_SIZE);
> +	invalidate_last_page = end >> PAGE_SHIFT;
> +
> +	if ((end + 1) & PAGE_MASK)
> +		invalidate_last_page--;
> +
> +	if (invalidate_last_page < invalidate_first_page)
> +		return 0;
> +
>  	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
> -					     start >> PAGE_SHIFT,
> -					     end >> PAGE_SHIFT);
> +					     invalidate_first_page,
> +					     invalidate_last_page);
>  }
>  
>  const struct file_operations def_blk_fops = {
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--O5XBE6gyVG5Rl6Rj
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-bdev-Do-not-return-EBUSY-if-bdev-discard-races-with-.patch"

From 36f751ac88420a6bda8a3c161986455629dc80d4 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 7 Jan 2021 16:26:52 +0100
Subject: [PATCH] bdev: Do not return EBUSY if bdev discard races with write

blkdev_fallocate() tries to detect whether a discard raced with an
overlapping write by calling invalidate_inode_pages2_range(). However
this check can give both false negatives (when writing using direct IO
or when writeback already writes out the written pagecache range) and
false positives (when write is not actually overlapping but ends in the
same page when blocksize < pagesize). This actually causes issues for
qemu which is getting confused by EBUSY errors.

Fix the problem by removing this conflicting write detection since it is
inherently racy and thus of little use anyway.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
CC: "Darrick J. Wong" <darrick.wong@oracle.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3e5b02f6606c..a97f43b49839 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1797,13 +1797,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		return error;
 
 	/*
-	 * Invalidate again; if someone wandered in and dirtied a page,
-	 * the caller will be given -EBUSY.  The third argument is
-	 * inclusive, so the rounding here is safe.
+	 * Invalidate the page cache again; if someone wandered in and dirtied
+	 * a page, we just discard it - userspace has no way of knowing whether
+	 * the write happened before or after discard completing...
 	 */
-	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
-					     start >> PAGE_SHIFT,
-					     end >> PAGE_SHIFT);
+	return truncate_bdev_range(bdev, file->f_mode, start, end);
 }
 
 const struct file_operations def_blk_fops = {
-- 
2.26.2


--O5XBE6gyVG5Rl6Rj--
