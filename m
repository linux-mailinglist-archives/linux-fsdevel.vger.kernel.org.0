Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6802FD8C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbhATSsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392020AbhATSrV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:47:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7D01233EA;
        Wed, 20 Jan 2021 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168400;
        bh=0L+9Z7TxhvnO24tvSrUyiMec+6BmfJQQX8l3ljHDSkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RACTKIL7Qe/jw++fUDPKipGugQslCpVPSKhsveCoL89BONLWS90JfVejnM7yHspRj
         H4ToyRbMBbTN35EU0mxRR7jz8sB3g/XnPLlp+XoG9I4wjVja5OJNWYxGLNwqfxbFOO
         E6DtzOasBS8vbw5+wfGoXv9cYc+Amrmr88Ok2OwtGi6lHdM7BNSTJ0KMnc/kd8F65B
         XRzzAhDqp4tttwj+zsaQ6TJsaMv31mZluD/Ij8zPc+WuZjZii20tOvR0EAtDJuHWXg
         opHOLz6ocAdCWohsCE6oq+LHqgyVsjUu4BlmQ6NeCTt2Hk7OsgDotFptY2pzc7nWNL
         Oyz7drUhiHTEA==
Date:   Wed, 20 Jan 2021 10:46:40 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 08/11] iomap: rename the flags variable in __iomap_dio_rw
Message-ID: <20210120184640.GJ3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:13PM +0100, Christoph Hellwig wrote:
> Rename flags to iomap_flags to make the usage a little more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Pretty straightforward...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 933f234d5becd0..604103ab76f9c5 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -427,7 +427,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	size_t count = iov_iter_count(iter);
>  	loff_t pos = iocb->ki_pos;
>  	loff_t end = iocb->ki_pos + count - 1, ret = 0;
> -	unsigned int flags = IOMAP_DIRECT;
> +	unsigned int iomap_flags = IOMAP_DIRECT;
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  
> @@ -461,7 +461,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		if (iter_is_iovec(iter))
>  			dio->flags |= IOMAP_DIO_DIRTY;
>  	} else {
> -		flags |= IOMAP_WRITE;
> +		iomap_flags |= IOMAP_WRITE;
>  		dio->flags |= IOMAP_DIO_WRITE;
>  
>  		/* for data sync or sync, we need sync completion processing */
> @@ -483,7 +483,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			ret = -EAGAIN;
>  			goto out_free_dio;
>  		}
> -		flags |= IOMAP_NOWAIT;
> +		iomap_flags |= IOMAP_NOWAIT;
>  	}
>  
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
> @@ -514,7 +514,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	blk_start_plug(&plug);
>  	do {
> -		ret = iomap_apply(inode, pos, count, flags, ops, dio,
> +		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
>  				iomap_dio_actor);
>  		if (ret <= 0) {
>  			/* magic error code to fall back to buffered I/O */
> -- 
> 2.29.2
> 
