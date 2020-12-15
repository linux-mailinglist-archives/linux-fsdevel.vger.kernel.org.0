Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85E52DB666
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 23:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgLOWRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 17:17:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgLOWRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:17:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFM9ewR162755;
        Tue, 15 Dec 2020 22:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WEPukmZK/xBeBbyNkC4SRC4dtu16K8HyoQIKM2HTFuk=;
 b=yflCkxeCAPS1vYxlTMwohCIRyctDzL73dCDUkGkSNMnPtFJlvfu7/bbza4g1qHlgtGHW
 FEJhzm0Tp1b4LgAhssiVH3HFGP4YyQ/zQl6mCXYBtQ1NdYD9mecL81dmufMi9XwkbEX7
 KARc0xJNQvYrKKbDpExeuTHDD/1HUGkEKYw2EdlIhNBiRVdVLnni6M3w3fndwdPnzcRk
 DXFxcfJUOPgmjbFam315qio3hNSOLTiWUvh2wjxpdKWOdkBCVLu/2U0I9qgaAd01viwy
 1jWDVYdjTg+jffLA94tHNdRvRNptue36KWxfeMhYWWtlf7Jk7AWCdWLXKxuSwMCd7PuW 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35ckcbd98e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 22:16:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFMBBkS192573;
        Tue, 15 Dec 2020 22:14:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35d7enmxxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 22:14:10 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BFME120018162;
        Tue, 15 Dec 2020 22:14:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 14:14:01 -0800
Date:   Tue, 15 Dec 2020 14:13:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@infradead.org, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/2] btrfs: Make btrfs_direct_write atomic with respect
 to inode_lock
Message-ID: <20201215221359.GA6911@magnolia>
References: <cover.1608053602.git.rgoldwyn@suse.com>
 <49ff9bfb8ef20e7a9c6e26fd54bc9f4508c9ccb4.1608053602.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ff9bfb8ef20e7a9c6e26fd54bc9f4508c9ccb4.1608053602.git.rgoldwyn@suse.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:06:36PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_direct_write() fallsback to buffered write in case btrfs is not
> able to perform or complete a direct I/O. During the fallback
> inode lock is unlocked and relocked. This does not guarantee the
> atomicity of the entire write since the lock can be acquired by another
> write between unlock and relock.
> 
> __btrfs_buffered_write() is used to perform the direct fallback write,
> which performs the write without acquiring the lock or checks.

Er... can you grab the inode lock before deciding which of the IO
path(s) you're going to take?  Then you'd always have an atomic write
even if fallback happens.

(Also vaguely wondering why this needs even more slicing and dicing of
the iomap directio functions...)

--D

> 
> fa54fc76db94 ("btrfs: push inode locking and unlocking into buffered/direct write")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/file.c | 69 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0e41459b8de6..9fc768b951f1 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1638,11 +1638,11 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
>  	return 0;
>  }
>  
> -static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
> +static noinline ssize_t __btrfs_buffered_write(struct kiocb *iocb,
>  					       struct iov_iter *i)
>  {
>  	struct file *file = iocb->ki_filp;
> -	loff_t pos;
> +	loff_t pos = iocb->ki_pos;
>  	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct page **pages = NULL;
> @@ -1656,24 +1656,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  	bool only_release_metadata = false;
>  	bool force_page_uptodate = false;
>  	loff_t old_isize = i_size_read(inode);
> -	unsigned int ilock_flags = 0;
> -
> -	if (iocb->ki_flags & IOCB_NOWAIT)
> -		ilock_flags |= BTRFS_ILOCK_TRY;
> -
> -	ret = btrfs_inode_lock(inode, ilock_flags);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = generic_write_checks(iocb, i);
> -	if (ret <= 0)
> -		goto out;
>  
> -	ret = btrfs_write_check(iocb, i, ret);
> -	if (ret < 0)
> -		goto out;
> +	lockdep_assert_held(&inode->i_rwsem);
>  
> -	pos = iocb->ki_pos;
>  	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
>  			PAGE_SIZE / (sizeof(struct page *)));
>  	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
> @@ -1877,10 +1862,37 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		iocb->ki_pos += num_written;
>  	}
>  out:
> -	btrfs_inode_unlock(inode, ilock_flags);
>  	return num_written ? num_written : ret;
>  }
>  
> +static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
> +					       struct iov_iter *i)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	unsigned int ilock_flags = 0;
> +	ssize_t ret;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		ilock_flags |= BTRFS_ILOCK_TRY;
> +
> +	ret = btrfs_inode_lock(inode, ilock_flags);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = generic_write_checks(iocb, i);
> +	if (ret <= 0)
> +		goto out;
> +
> +	ret = btrfs_write_check(iocb, i, ret);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __btrfs_buffered_write(iocb, i);
> +out:
> +	btrfs_inode_unlock(inode, ilock_flags);
> +	return ret;
> +}
> +
>  static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
>  			       const struct iov_iter *iter, loff_t offset)
>  {
> @@ -1927,10 +1939,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	}
>  
>  	err = btrfs_write_check(iocb, from, err);
> -	if (err < 0) {
> -		btrfs_inode_unlock(inode, ilock_flags);
> +	if (err < 0)
>  		goto out;
> -	}
>  
>  	pos = iocb->ki_pos;
>  	/*
> @@ -1944,22 +1954,19 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  		goto relock;
>  	}
>  
> -	if (check_direct_IO(fs_info, from, pos)) {
> -		btrfs_inode_unlock(inode, ilock_flags);
> +	if (check_direct_IO(fs_info, from, pos))
>  		goto buffered;
> -	}
>  
>  	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
>  			     &btrfs_dio_ops, is_sync_kiocb(iocb));
>  
> -	btrfs_inode_unlock(inode, ilock_flags);
> -
>  	if (IS_ERR_OR_NULL(dio)) {
>  		err = PTR_ERR_OR_ZERO(dio);
>  		if (err < 0 && err != -ENOTBLK)
>  			goto out;
>  	} else {
> -		written = iomap_dio_complete(dio);
> +		written = __iomap_dio_complete(dio);
> +		kfree(dio);
>  	}
>  
>  	if (written < 0 || !iov_iter_count(from)) {
> @@ -1969,7 +1976,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  buffered:
>  	pos = iocb->ki_pos;
> -	written_buffered = btrfs_buffered_write(iocb, from);
> +	written_buffered = __btrfs_buffered_write(iocb, from);
>  	if (written_buffered < 0) {
>  		err = written_buffered;
>  		goto out;
> @@ -1990,6 +1997,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
>  				 endbyte >> PAGE_SHIFT);
>  out:
> +	btrfs_inode_unlock(inode, ilock_flags);
> +	if (written > 0)
> +		generic_write_sync(iocb, written);
> +
>  	return written ? written : err;
>  }
>  
> -- 
> 2.29.2
> 
