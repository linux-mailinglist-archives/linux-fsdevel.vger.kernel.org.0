Return-Path: <linux-fsdevel+bounces-37873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A509F832E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20EC1886F35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2611A0B12;
	Thu, 19 Dec 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZo03Cbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5E194C96;
	Thu, 19 Dec 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632564; cv=none; b=eefl1G44C64LInWwr//NOZKC2ox6Bz0txDvmDVe+rqv6OUIHaouZI1fDFbxlgHSSMsG+N9AwGH41KENDAZ7+hrsjahRGyNidfaQa/B0OQsabWEbIaqae1ApXdmuPNbT/b2hST+j2+aUexH8XItyI5EUr0ZM8pQBlzAkjlepfdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632564; c=relaxed/simple;
	bh=JqcCM+tsghZ55JoJ7xkxJYp9XuSqguovT/WgLsUZ9j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8Qs+xLvmWdZZI6jV/IdFHWeEQkmdUI4NED9TxWeGtL9dYhZBePZJQz1vaEvvWsoDwFVZkAjOPkM4u5nWXCjcCjdQXWWpFFpJYhAqvlhHrsVTlegD/z9Wp/JjynU6o9kANAEv/YCFp8a/3/+6oVHBAwjEqQ9M1z5MbmJufOpEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZo03Cbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589F4C4CECE;
	Thu, 19 Dec 2024 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734632564;
	bh=JqcCM+tsghZ55JoJ7xkxJYp9XuSqguovT/WgLsUZ9j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZo03CbqGrK1/EQ5DDdk8ZbtlSCRe5N4gqCwyeszqGq3Gc/O0C9h3EChY6cbKjzwY
	 KVZC+ZvLwc1g9nG0LkRrwabvzFDoObuBTGGV93aXRM6RPqj6pgP30J8Y18h8Qbrhdb
	 BaakOhOzLCBEYSP9Q3TeTGUz/g7QkDZ7BeKrcchklh+sWqhS6TQvh7P0/M5QsP80Pu
	 3dvvq5UFen9389g1vlNM7Xe4it35HQLU3+D9L2TUHFqltzNXmgjUIa4p1edIfnMKmz
	 i9zZkixrZHx4jhqiFvmh70BC+FPLHldK1mxlfyz8SmNamkHc45hqYhrk8wlROIQT0A
	 v4ykxZ9kHk2bQ==
Date: Thu, 19 Dec 2024 10:22:43 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/10] iomap: factor out a iomap_dio_done helper
Message-ID: <20241219182243.GF6156@frogsfrogsfrogs>
References: <20241219173954.22546-1-hch@lst.de>
 <20241219173954.22546-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173954.22546-7-hch@lst.de>

On Thu, Dec 19, 2024 at 05:39:11PM +0000, Christoph Hellwig wrote:
> Split out the struct iomap-dio level final completion from
> iomap_dio_bio_end_io into a helper to clean up the code and make it
> reusable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 76 ++++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 641649a04614..ed658eb09a1a 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -165,43 +165,31 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
>  	cmpxchg(&dio->error, 0, ret);
>  }
>  
> -void iomap_dio_bio_end_io(struct bio *bio)
> +/*
> + * Called when dio->ref reaches zero from and I/O completion.

                                             an I/O completion

This hoist looks fine to me, so with that fixed:
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> + */
> +static void iomap_dio_done(struct iomap_dio *dio)
>  {
> -	struct iomap_dio *dio = bio->bi_private;
> -	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
>  	struct kiocb *iocb = dio->iocb;
>  
> -	if (bio->bi_status)
> -		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
> -	if (!atomic_dec_and_test(&dio->ref))
> -		goto release_bio;
> -
> -	/*
> -	 * Synchronous dio, task itself will handle any completion work
> -	 * that needs after IO. All we need to do is wake the task.
> -	 */
>  	if (dio->wait_for_completion) {
> +		/*
> +		 * Synchronous I/O, task itself will handle any completion work
> +		 * that needs after IO. All we need to do is wake the task.
> +		 */
>  		struct task_struct *waiter = dio->submit.waiter;
>  
>  		WRITE_ONCE(dio->submit.waiter, NULL);
>  		blk_wake_io_task(waiter);
> -		goto release_bio;
> -	}
> -
> -	/*
> -	 * Flagged with IOMAP_DIO_INLINE_COMP, we can complete it inline
> -	 */
> -	if (dio->flags & IOMAP_DIO_INLINE_COMP) {
> +	} else if (dio->flags & IOMAP_DIO_INLINE_COMP) {
>  		WRITE_ONCE(iocb->private, NULL);
>  		iomap_dio_complete_work(&dio->aio.work);
> -		goto release_bio;
> -	}
> -
> -	/*
> -	 * If this dio is flagged with IOMAP_DIO_CALLER_COMP, then schedule
> -	 * our completion that way to avoid an async punt to a workqueue.
> -	 */
> -	if (dio->flags & IOMAP_DIO_CALLER_COMP) {
> +	} else if (dio->flags & IOMAP_DIO_CALLER_COMP) {
> +		/*
> +		 * If this dio is flagged with IOMAP_DIO_CALLER_COMP, then
> +		 * schedule our completion that way to avoid an async punt to a
> +		 * workqueue.
> +		 */
>  		/* only polled IO cares about private cleared */
>  		iocb->private = dio;
>  		iocb->dio_complete = iomap_dio_deferred_complete;
> @@ -219,19 +207,31 @@ void iomap_dio_bio_end_io(struct bio *bio)
>  		 * issuer.
>  		 */
>  		iocb->ki_complete(iocb, 0);
> -		goto release_bio;
> +	} else {
> +		struct inode *inode = file_inode(iocb->ki_filp);
> +
> +		/*
> +		 * Async DIO completion that requires filesystem level
> +		 * completion work gets punted to a work queue to complete as
> +		 * the operation may require more IO to be issued to finalise
> +		 * filesystem metadata changes or guarantee data integrity.
> +		 */
> +		INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> +		queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
>  	}
> +}
> +
> +void iomap_dio_bio_end_io(struct bio *bio)
> +{
> +	struct iomap_dio *dio = bio->bi_private;
> +	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
> +
> +	if (bio->bi_status)
> +		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
> +
> +	if (atomic_dec_and_test(&dio->ref))
> +		iomap_dio_done(dio);
>  
> -	/*
> -	 * Async DIO completion that requires filesystem level completion work
> -	 * gets punted to a work queue to complete as the operation may require
> -	 * more IO to be issued to finalise filesystem metadata changes or
> -	 * guarantee data integrity.
> -	 */
> -	INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> -	queue_work(file_inode(iocb->ki_filp)->i_sb->s_dio_done_wq,
> -			&dio->aio.work);
> -release_bio:
>  	if (should_dirty) {
>  		bio_check_pages_dirty(bio);
>  	} else {
> -- 
> 2.45.2
> 
> 

