Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889E32FD8C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391894AbhATSs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390089AbhATSsR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:48:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C40E206FA;
        Wed, 20 Jan 2021 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168456;
        bh=uKH9o6h1e+z801UsuzTij2Y7mpQx/UJmcChVgkZfWnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nv9BKKChNeDxmg4bqcVy+4lB22JTCv4c7rFXxBDGa+3WNc4KTipKGs7yB8IZTOeg9
         1HwuaSaPUI5EfktqOJrLr85zI+sWHOI7JHu4+DZhv+hsE+ImMdgrvOka+j+QNXUlRF
         6+OLNwWCc96LX9NOXQGhqjRtmRDBKoZXqyHNE3GNYF/QItcv7UfwCOtrjFARV4Hjyu
         kPeAgu9NqDuUS/R6thbWkI8s51VL96TCMYLGM5RfR63Efqs38pC2qTK+g736A7FSki
         Bpr92Q3D+iKjClKQbxem2HslxAYM+9EhneF5kUJS72+gIVIb2TlXLqVbUnC0uWp1X3
         cVAa3YvCSSx/g==
Date:   Wed, 20 Jan 2021 10:47:35 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 10/11] iomap: add a IOMAP_DIO_UNALIGNED flag
Message-ID: <20210120184735.GK3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:15PM +0100, Christoph Hellwig wrote:
> Add a flag to signal an I/O that is not file system block aligned.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 7 +++++++
>  include/linux/iomap.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 32dbbf7dd4aadb..d93019ee4c9e3e 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -485,6 +485,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iomap_flags |= IOMAP_NOWAIT;
>  	}
>  
> +	if (dio_flags & IOMAP_DIO_UNALIGNED) {
> +		ret = -EAGAIN;
> +		if (pos >= dio->i_size)
> +			goto out_free_dio;
> +		iomap_flags |= IOMAP_UNALIGNED;
> +	}
> +
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
>  	if (ret)
>  		goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b322598dc10ec0..2fa94ec9583d0a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -122,6 +122,7 @@ struct iomap_page_ops {
>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_UNALIGNED		(1 << 6) /* do not allocate blocks */
>  
>  struct iomap_ops {
>  	/*
> @@ -262,6 +263,13 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_FORCE_WAIT	(1 << 0)
>  
> +/*
> + * Direct I/O that is not aligned to the file system block.  Do not allocate
> + * blocks and do not zero partial blocks, fall back to the caller by returning
> + * -EAGAIN instead.
> + */
> +#define IOMAP_DIO_UNALIGNED	(1 << 1)

The code changes look fine, but as for the name, I found it a little
confusing even after changing it to IOMAP_DIO_SUBBLOCK.

See my reply to patch 11 for more details.

--D

> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int flags);
> -- 
> 2.29.2
> 
