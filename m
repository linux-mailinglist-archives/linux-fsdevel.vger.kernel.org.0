Return-Path: <linux-fsdevel+bounces-37227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88579EFCD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B976A16AF81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB3E1A83E3;
	Thu, 12 Dec 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRusMEO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2A25948B;
	Thu, 12 Dec 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033389; cv=none; b=vBxlaMDlP++hLriJuOeXBM0v0srq8UEbM8dFdlWLSg9DmVHyAhjtaDOxTwc3B++GVJ587x7ewK1k0L7qQCX0z50nUm2CHi61aXvf6ay1gzvuWpVqOxvC0UayE3kZGfUELc3UGXWcKxw5ALYXMjBewKC68/qpBVJuutfQZdYo+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033389; c=relaxed/simple;
	bh=tgKJbpCoK6/eQbsQ5Ua19JHLWiOfNw9QS0iWfqVJ7sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va+5a1qj876cqyzx8me3BecpNchE3otsGheXwyYc2A/aFDEs+wk4z2DFRt+1If9+veeEhs4hzF1hej7kkeD9RjTa05qYb+ncbHjZZJqD/fsFKhPB9aVDm81H+VpoQLPFc30PcUEMtaj8VhWSnPa/II3ziB74U5Bpwp/oqx9w7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRusMEO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD6DC4CECE;
	Thu, 12 Dec 2024 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734033385;
	bh=tgKJbpCoK6/eQbsQ5Ua19JHLWiOfNw9QS0iWfqVJ7sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRusMEO/V1WC8rvRni/ZQjprZ/4aEhI2uMyHqYi+0ivisg67HYy/0h1w3lQZe7IX3
	 8W79EOXx47M7AzeSJimAseJj/33hyHFtHn2EEMnzP0H1UaRQA0wsFhm9J+DXi8Jjbb
	 LG+tmaWWYRFlgoex3Or0hAw6FpQIHvEgp9GmFqQKnPTCaph87SktjWiZX+nCPO/4vr
	 nG3ZML2/4eT/b/zYEORf71AsbKWYcznhUhB4yBjZ3bXtVkAFpSTRTbTX2nyy+f0Dss
	 N9oWSdXvR5aQv/fT96jwDyGOfRQktBjbAMeoLOkatuJ3kRldYF4+DBRWUhxN2pk8Wt
	 kG/xB31IaGrVA==
Date: Thu, 12 Dec 2024 11:56:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/8] iomap: optionally use ioends for direct I/O
Message-ID: <20241212195624.GI6678@frogsfrogsfrogs>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085420.1380396-6-hch@lst.de>

On Wed, Dec 11, 2024 at 09:53:45AM +0100, Christoph Hellwig wrote:
> struct iomap_ioend currently tracks outstanding buffered writes and has
> some really nice code in core iomap and XFS to merge contiguous I/Os
> an defer them to userspace for completion in a very efficient way.
> 
> For zoned writes we'll also need a per-bio user context completion to
> record the written blocks, and the infrastructure for that would look
> basically like the ioend handling for buffered I/O.
> 
> So instead of reinventing the wheel, reuse the existing infrastructure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c |  3 +++
>  fs/iomap/direct-io.c   | 50 +++++++++++++++++++++++++++++++++++++++++-
>  fs/iomap/internal.h    |  7 ++++++
>  include/linux/iomap.h  |  4 +++-
>  4 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 fs/iomap/internal.h
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8125f758a99d..ceca9473a09c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -17,6 +17,7 @@
>  #include <linux/bio.h>
>  #include <linux/sched/signal.h>
>  #include <linux/migrate.h>
> +#include "internal.h"
>  #include "trace.h"
>  
>  #include "../internal.h"
> @@ -1582,6 +1583,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  
>  	if (!atomic_dec_and_test(&ioend->io_remaining))
>  		return 0;
> +	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
> +		return iomap_finish_ioend_direct(ioend);
>  	return iomap_finish_ioend_buffered(ioend);
>  }

I'm a little surprised that more of the iomap_ioend* functions didn't
end up in ioend.c.

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b521eb15759e..b5466361cafe 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -12,6 +12,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include "internal.h"
>  #include "trace.h"
>  
>  #include "../internal.h"
> @@ -20,6 +21,7 @@
>   * Private flags for iomap_dio, must not overlap with the public ones in
>   * iomap.h:
>   */
> +#define IOMAP_DIO_NO_INVALIDATE	(1U << 25)
>  #define IOMAP_DIO_CALLER_COMP	(1U << 26)
>  #define IOMAP_DIO_INLINE_COMP	(1U << 27)
>  #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
> @@ -117,7 +119,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	 * ->end_io() when necessary, otherwise a racing buffer read would cache
>  	 * zeros from unwritten extents.
>  	 */
> -	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE))
> +	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE) &&
> +	    !(dio->flags & IOMAP_DIO_NO_INVALIDATE))
>  		kiocb_invalidate_post_direct_write(iocb, dio->size);
>  
>  	inode_dio_end(file_inode(iocb->ki_filp));
> @@ -163,6 +166,51 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
>  	cmpxchg(&dio->error, 0, ret);
>  }
>  
> +u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
> +{
> +	struct iomap_dio *dio = ioend->io_bio.bi_private;
> +	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
> +	struct kiocb *iocb = dio->iocb;
> +	u32 vec_count = ioend->io_bio.bi_vcnt;
> +
> +	if (ioend->io_error)
> +		iomap_dio_set_error(dio, ioend->io_error);
> +
> +	if (atomic_dec_and_test(&dio->ref)) {
> +		struct inode *inode = file_inode(iocb->ki_filp);
> +
> +		if (dio->wait_for_completion) {
> +			struct task_struct *waiter = dio->submit.waiter;
> +
> +			WRITE_ONCE(dio->submit.waiter, NULL);
> +			blk_wake_io_task(waiter);
> +		} else if (!inode->i_mapping->nrpages) {
> +			WRITE_ONCE(iocb->private, NULL);
> +
> +			/*
> +			 * We must never invalidate pages from this thread to
> +			 * avoid deadlocks with buffered I/O completions.
> +			 * Tough luck if you hit the tiny race with someone
> +			 * dirtying the range now.

What happens, exactly?  Does that mean that the dirty pagecache always
survives?

--D

> +			 */
> +			dio->flags |= IOMAP_DIO_NO_INVALIDATE;
> +			iomap_dio_complete_work(&dio->aio.work);
> +		} else {
> +			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> +			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> +		}
> +	}
> +
> +	if (should_dirty) {
> +		bio_check_pages_dirty(&ioend->io_bio);
> +	} else {
> +		bio_release_pages(&ioend->io_bio, false);
> +		bio_put(&ioend->io_bio);
> +	}
> +
> +	return vec_count;
> +}
> +
>  void iomap_dio_bio_end_io(struct bio *bio)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> new file mode 100644
> index 000000000000..20cccfc3bb13
> --- /dev/null
> +++ b/fs/iomap/internal.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _IOMAP_INTERNAL_H
> +#define _IOMAP_INTERNAL_H 1
> +
> +u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
> +
> +#endif /* _IOMAP_INTERNAL_H */
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index eaa8cb9083eb..f6943c80e5fd 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -343,9 +343,11 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>  #define IOMAP_IOEND_UNWRITTEN		(1U << 1)
>  /* don't merge into previous ioend */
>  #define IOMAP_IOEND_BOUNDARY		(1U << 2)
> +/* is direct I/O */
> +#define IOMAP_IOEND_DIRECT		(1U << 3)
>  
>  #define IOMAP_IOEND_NOMERGE_FLAGS \
> -	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)
> +	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
>  
>  /*
>   * Structure for writeback I/O completions.
> -- 
> 2.45.2
> 
> 

