Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD282FBB26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 16:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbhASP1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 10:27:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391376AbhASPYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611069794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9RbCrtn53b3CeRcYuUYD71valu6+pdVw5hOh6A/cdY=;
        b=JjnkpaflbmLyUpLDPJGEiH1McEZh7ysZG+PgMkKp10zxROomz0/fvoj24AOndU+ps5xPSn
        S8m/T09bHs/8ToaEHk6UPLI8j1kuuZVv1L7cNFcXwo4twoFfmscrqI6awSJEHfg0vLJ0HY
        X72BRDwlDV7wVFjVex4NVglnS9NvZQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-dAQpbTE1M5-C2zr5tN0rxg-1; Tue, 19 Jan 2021 10:23:12 -0500
X-MC-Unique: dAQpbTE1M5-C2zr5tN0rxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2E0B800D53;
        Tue, 19 Jan 2021 15:23:10 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CB8819CA8;
        Tue, 19 Jan 2021 15:23:10 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:23:08 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 03/11] xfs: cleanup the read/write helper naming
Message-ID: <20210119152308.GC1646807@bfoster>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-4-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:08PM +0100, Christoph Hellwig wrote:
> Drop a few pointless aio_ prefixes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_file.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index fb4e6f2852bb8b..ae7313ccaa11ed 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -215,7 +215,7 @@ xfs_ilock_iocb(
>  }
>  
>  STATIC ssize_t
> -xfs_file_dio_aio_read(
> +xfs_file_dio_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> @@ -265,7 +265,7 @@ xfs_file_dax_read(
>  }
>  
>  STATIC ssize_t
> -xfs_file_buffered_aio_read(
> +xfs_file_buffered_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> @@ -300,9 +300,9 @@ xfs_file_read_iter(
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
>  	else if (iocb->ki_flags & IOCB_DIRECT)
> -		ret = xfs_file_dio_aio_read(iocb, to);
> +		ret = xfs_file_dio_read(iocb, to);
>  	else
> -		ret = xfs_file_buffered_aio_read(iocb, to);
> +		ret = xfs_file_buffered_read(iocb, to);
>  
>  	if (ret > 0)
>  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> @@ -317,7 +317,7 @@ xfs_file_read_iter(
>   * if called for a direct write beyond i_size.
>   */
>  STATIC ssize_t
> -xfs_file_aio_write_checks(
> +xfs_file_write_checks(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from,
>  	int			*iolock)
> @@ -502,7 +502,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
>  };
>  
>  /*
> - * xfs_file_dio_aio_write - handle direct IO writes
> + * xfs_file_dio_write - handle direct IO writes
>   *
>   * Lock the inode appropriately to prepare for and issue a direct IO write.
>   * By separating it from the buffered write path we remove all the tricky to
> @@ -527,7 +527,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
>   * negative return values.
>   */
>  STATIC ssize_t
> -xfs_file_dio_aio_write(
> +xfs_file_dio_write(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from)
>  {
> @@ -549,7 +549,7 @@ xfs_file_dio_aio_write(
>  	/*
>  	 * Don't take the exclusive iolock here unless the I/O is unaligned to
>  	 * the file system block size.  We don't need to consider the EOF
> -	 * extension case here because xfs_file_aio_write_checks() will relock
> +	 * extension case here because xfs_file_write_checks() will relock
>  	 * the inode as necessary for EOF zeroing cases and fill out the new
>  	 * inode size as appropriate.
>  	 */
> @@ -580,7 +580,7 @@ xfs_file_dio_aio_write(
>  		xfs_ilock(ip, iolock);
>  	}
>  
> -	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>  	if (ret)
>  		goto out;
>  	count = iov_iter_count(from);
> @@ -590,7 +590,7 @@ xfs_file_dio_aio_write(
>  	 * in-flight at the same time or we risk data corruption. Wait for all
>  	 * other IO to drain before we submit. If the IO is aligned, demote the
>  	 * iolock if we had to take the exclusive lock in
> -	 * xfs_file_aio_write_checks() for other reasons.
> +	 * xfs_file_write_checks() for other reasons.
>  	 */
>  	if (unaligned_io) {
>  		inode_dio_wait(inode);
> @@ -634,7 +634,7 @@ xfs_file_dax_write(
>  	ret = xfs_ilock_iocb(iocb, iolock);
>  	if (ret)
>  		return ret;
> -	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>  	if (ret)
>  		goto out;
>  
> @@ -663,7 +663,7 @@ xfs_file_dax_write(
>  }
>  
>  STATIC ssize_t
> -xfs_file_buffered_aio_write(
> +xfs_file_buffered_write(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from)
>  {
> @@ -682,7 +682,7 @@ xfs_file_buffered_aio_write(
>  	iolock = XFS_IOLOCK_EXCL;
>  	xfs_ilock(ip, iolock);
>  
> -	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>  	if (ret)
>  		goto out;
>  
> @@ -769,12 +769,12 @@ xfs_file_write_iter(
>  		 * CoW.  In all other directio scenarios we do not
>  		 * allow an operation to fall back to buffered mode.
>  		 */
> -		ret = xfs_file_dio_aio_write(iocb, from);
> +		ret = xfs_file_dio_write(iocb, from);
>  		if (ret != -ENOTBLK)
>  			return ret;
>  	}
>  
> -	return xfs_file_buffered_aio_write(iocb, from);
> +	return xfs_file_buffered_write(iocb, from);
>  }
>  
>  static void
> -- 
> 2.29.2
> 

