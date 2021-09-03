Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016EC40055C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351307AbhICSzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350591AbhICSzb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:55:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6EEA61051;
        Fri,  3 Sep 2021 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630695270;
        bh=k0qqhjIBTc+gyB6NzqxwhhFn9y/tnKZkCVBCXngFTi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRnrrB2Jph7uelGBkGR4cg8QVuct3/B8w1s6Z0i9VbiI/DtTVFnp+DrP1Xub+jM70
         lmogrtDA/ZqdzzOc+e2aXU9GM0i/HCLA6VN2gnpIlzRLP1JMg9aDZ+aHd15ySB2lHH
         fyPyxnLYOm+h1GW7euhDaleRRE9GTNOF1Nov7nbC60eUJHOn0bFAwH0OFQKNiJHiJX
         mBM+xvs8AA8K3HtMs5yrVF5MNu/LlNNa+VD9UOWY+eGQPhDTsi5MEDW08a8uVTrD7V
         tgQOmK41k0WgmvOpPT8nPUZaHHULhWTOKci1vhBpn9R7LZGpM0l4jgxNqd6kr3UWsL
         WYOYmAKFZW7hw==
Date:   Fri, 3 Sep 2021 11:54:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 15/19] iomap: Support partial direct I/O on user copy
 failures
Message-ID: <20210903185430.GE9892@magnolia>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-16-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-16-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:22PM +0200, Andreas Gruenbacher wrote:
> In iomap_dio_rw, when iomap_apply returns an -EFAULT error and the
> IOMAP_DIO_PARTIAL flag is set, complete the request synchronously and
> return a partial result.  This allows the caller to deal with the page
> fault and retry the remainder of the request.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Pretty straightforward.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c  | 6 ++++++
>  include/linux/iomap.h | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 8054f5d6c273..ba88fe51b77a 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -561,6 +561,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
>  				iomap_dio_actor);
>  		if (ret <= 0) {
> +			if (ret == -EFAULT && dio->size &&
> +			    (dio_flags & IOMAP_DIO_PARTIAL)) {
> +				wait_for_completion = true;
> +				ret = 0;
> +			}
> +
>  			/* magic error code to fall back to buffered I/O */
>  			if (ret == -ENOTBLK) {
>  				wait_for_completion = true;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 479c1da3e221..bcae4814b8e3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -267,6 +267,13 @@ struct iomap_dio_ops {
>    */
>  #define IOMAP_DIO_OVERWRITE_ONLY	(1 << 1)
>  
> +/*
> + * When a page fault occurs, return a partial synchronous result and allow
> + * the caller to retry the rest of the operation after dealing with the page
> + * fault.
> + */
> +#define IOMAP_DIO_PARTIAL		(1 << 2)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags);
> -- 
> 2.26.3
> 
