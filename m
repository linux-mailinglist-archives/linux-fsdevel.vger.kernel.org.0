Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA12EE64D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 20:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbhAGTky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 14:40:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48712 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbhAGTky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:40:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107JZ6lT174101;
        Thu, 7 Jan 2021 19:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LNJbKrWaWEblA9qjEZRO03X8KeGfewiv+BLS48OCm1M=;
 b=fRAF6CtUU3Co3Z0mjA/cJLQOX5tP5533CqXGignssWs+PTvgnPh/jppehtGim0aBG30K
 uWxe+OVa2n19hyN+oIyGrAZgTWbP1jgDoFN6uuKjgI1fxWqTzDBYTazpH4J5z97cjeWe
 H+ybyx4FUxFOBqfLYaa6a+rDLQ9bi1fQLW2iFnXhsLlmFirrsYVXjdl7nV9+RiLxFw4G
 ez7aJppd2Lg3gjpGSYnbnTx19DXfcrRjZVkrOoHbQiyhv8++2YsfrDB5qlTqCtRyWgUL
 p9vZsWci0DMPh2Mo2tjCQvkQZ0q0VZKeg3A5ZFfJtWHborYXKdPH3nHpPGtVBA8IzL33 zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35wepme0v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Jan 2021 19:40:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107JZR12062820;
        Thu, 7 Jan 2021 19:40:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35w3g37qw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jan 2021 19:40:07 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 107Je6uR007791;
        Thu, 7 Jan 2021 19:40:06 GMT
Received: from localhost (/10.159.138.126)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 19:40:06 +0000
Date:   Thu, 7 Jan 2021 11:40:05 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Maxim Levitsky <mlevitsk@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bdev: Do not return EBUSY if bdev discard races with
 write
Message-ID: <20210107194005.GD6911@magnolia>
References: <20210107154034.1490-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107154034.1490-1-jack@suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070114
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 04:40:34PM +0100, Jan Kara wrote:
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

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

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
