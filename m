Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A002FF3CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhAUTHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbhAUTHU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:07:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A56023A1C;
        Thu, 21 Jan 2021 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611255336;
        bh=+DrtLBHO7amWTEFFTg5kzH26MSXx3tdxRE/GkKFbq9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPWVGu5M7LsAQooXzVq9fFvuxwNYhFDiNV8CsSqnP1ZQglY+UcLwVZIbVY/WuwAlw
         OgUgRWwKVyKpkyKCckqwmchAJUlWgEQ/+bU71mBGMIJ/jQfMvej1m2eXpiN583Rfby
         zXZjX0SHmOhCf4mWn3fIuAijWie9fgjHnhuWyzhg/2Do97QcOuMZieotOKCc1BD5u6
         zCRHhE87rLawAauGhjLMqSEVOJ9gpqErBCuExtVGfbozLQSfZRYh4bEFc3cMAU93WR
         lo9on7fsuriHrXJd97tgQ10b4+vwRkdRtWPPpRGxllPweuHqXoYvRUCUhUJN8zbD/O
         C2gEbNTr7Vvrg==
Date:   Thu, 21 Jan 2021 10:55:35 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 10/11] iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag
Message-ID: <20210121185535.GD1282159@magnolia>
References: <20210121085906.322712-1-hch@lst.de>
 <20210121085906.322712-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121085906.322712-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:59:05AM +0100, Christoph Hellwig wrote:
> Add a flag to signal an only pure overwrites are allowed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 7 +++++++
>  include/linux/iomap.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 947343730e2c93..65d32364345d22 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -485,6 +485,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iomap_flags |= IOMAP_NOWAIT;
>  	}
>  
> +	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
> +		ret = -EAGAIN;
> +		if (pos >= dio->i_size || pos + count > dio->i_size)
> +			goto out_free_dio;
> +		iomap_flags |= IOMAP_OVERWRITE_ONLY;
> +	}
> +
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
>  	if (ret)
>  		goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index be4e1e1e01e801..cfa20afd7d5b87 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -122,6 +122,7 @@ struct iomap_page_ops {
>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_OVERWRITE_ONLY	(1 << 6) /* purely overwrites allowed */

"only pure overwrites allowed" ?

With that fixed,

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  struct iomap_ops {
>  	/*
> @@ -262,6 +263,13 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_FORCE_WAIT	(1 << 0)
>  
> +/*
> + * Do not allocate blocks or zero partial blocks, but instead fall back to
> + * the caller by returning -EAGAIN.  Used to optimize direct I/O writes that
> + * are not aligned to the file system block size.
> +  */
> +#define IOMAP_DIO_OVERWRITE_ONLY	(1 << 1)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags);
> -- 
> 2.29.2
> 
