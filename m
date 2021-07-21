Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5453D1A72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 01:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGUWuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 18:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhGUWuU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:50:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7736121F;
        Wed, 21 Jul 2021 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626910256;
        bh=VMOgEl7XFLHAT/9MyUGH631UPK2nLrJgvCVfTC76OXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avyfBZd+m2fsiaqVE7LhlJdjZdPSMSSlFazuZF0elabwpN7xyAp35Xyrgyf74TXuM
         Hpx2hEe7va9UoGiICUmIpKg2RrJf6sFlGjgs0IkxbzMKSv/MeryAzJd/d3wqzXCq//
         Urxn/91473LXpqbWJV5pj+eFAO7+Ju3G8znaQgIeAftceXIwqKWBOfjoCYZwMmbnn+
         JNdnRG1oV+NYjJNZo0cyqCzBe5/iK8cY/dODQ98Egm2uZo01iTdJv7LiUCkOly1FYQ
         lDtIUJ2JTTC6Y7etJYMgLmgqh10B2zpPuBXX6Snr/uQ//FZoD3o/FmDRLL+5pxxACK
         bvt+tbO6ZaaWg==
Date:   Wed, 21 Jul 2021 16:30:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] iomap: Convert from atomic_t to refcount_t on
 iomap_dio->ref
Message-ID: <20210721233056.GC8639@magnolia>
References: <1626683544-64155-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626683544-64155-1-git-send-email-xiyuyang19@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 04:32:24PM +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  fs/iomap/direct-io.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..d1393579a954 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (c) 2016-2018 Christoph Hellwig.
>   */
> +#include <linux/refcount.h>
>  #include <linux/module.h>
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> @@ -28,7 +29,7 @@ struct iomap_dio {
>  	const struct iomap_dio_ops *dops;
>  	loff_t			i_size;
>  	loff_t			size;
> -	atomic_t		ref;
> +	refcount_t		ref;
>  	unsigned		flags;
>  	int			error;
>  	bool			wait_for_completion;
> @@ -62,7 +63,7 @@ EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
>  static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>  		struct bio *bio, loff_t pos)
>  {
> -	atomic_inc(&dio->ref);
> +	refcount_inc(&dio->ref);

Seems all right to me, though I wonder if any of the more
performance-minded people have comments about the overhead of refcount_t
vs. atomic_t?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  	if (dio->iocb->ki_flags & IOCB_HIPRI)
>  		bio_set_polled(bio, dio->iocb);
> @@ -158,7 +159,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  	if (bio->bi_status)
>  		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
>  
> -	if (atomic_dec_and_test(&dio->ref)) {
> +	if (refcount_dec_and_test(&dio->ref)) {
>  		if (dio->wait_for_completion) {
>  			struct task_struct *waiter = dio->submit.waiter;
>  			WRITE_ONCE(dio->submit.waiter, NULL);
> @@ -471,7 +472,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		return ERR_PTR(-ENOMEM);
>  
>  	dio->iocb = iocb;
> -	atomic_set(&dio->ref, 1);
> +	refcount_set(&dio->ref, 1);
>  	dio->size = 0;
>  	dio->i_size = i_size_read(inode);
>  	dio->dops = dops;
> @@ -611,7 +612,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	 *	after we got woken by the I/O completion handler.
>  	 */
>  	dio->wait_for_completion = wait_for_completion;
> -	if (!atomic_dec_and_test(&dio->ref)) {
> +	if (!refcount_dec_and_test(&dio->ref)) {
>  		if (!wait_for_completion)
>  			return ERR_PTR(-EIOCBQUEUED);
>  
> -- 
> 2.7.4
> 
