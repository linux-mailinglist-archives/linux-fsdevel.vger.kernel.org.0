Return-Path: <linux-fsdevel+bounces-37875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C139F8335
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03873167312
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF31A2543;
	Thu, 19 Dec 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAU2rBQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610E199234;
	Thu, 19 Dec 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632704; cv=none; b=Ie9tmRHPVb094gn9w380mECtN002J1AyBBSt4FsoD2X0maAO50BRF4nff6xaK3kXWqiX43389R7GttfVUt+T+A5bKTAZamKIFNVgXkJ2Rwpdh6Ij1/RyQ1NUsOknC4n9Kc0WSMcupKfOmkp8CUvYVpSck1WWVU5rhmnD40pYsjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632704; c=relaxed/simple;
	bh=cSanTKt62rqGi/IZOQ8JMMuNjFa8akWmwVC0XeRNE/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA+Uzz12S8dWZAA+0+pIrMIWMvVkMMVMtkQcagAZV5BVTMR2WDTZmNat7DXXziIG+bfXJrYigseV5hj3CTtwFDmAz93Wcet+CPqC+gJKUTgbpnjzV0UA38GryyDWsRYR+1OlP4wCpQBupyGI7DI2iTEJ7u9DvWfAJVaVGFvQOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAU2rBQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887B3C4CECE;
	Thu, 19 Dec 2024 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734632703;
	bh=cSanTKt62rqGi/IZOQ8JMMuNjFa8akWmwVC0XeRNE/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAU2rBQRNNVHQKc+sLrIDAK7YHEaZEiKjiL49oRN5gSopvsdepd6XY687T8hvOE/u
	 vJfZ3BkPzCICB27sekILF0deSjmHI9n44xrGKCQCgCrPbOqyrp/8h3wZc18IqWlXsh
	 /lL2hiX7muVKZQwwW4nuJsFFCG/mlUaPUnvK4QvGv0EuSwjMDbMErH/IdFs8xiD13M
	 ayorHH8+E0UGUKBbCL1Vw8D/FDhhC0GBbaE22J6Nu5ziEHqsmijhBuzmSzbpLzShan
	 ic/CkYDoRo+LLknzh+JkVhlkdqWW6fR3kQbo4loSTigL4HPIHaYZ6M2mGgmByFg636
	 wUCR/mw5IGEsg==
Date: Thu, 19 Dec 2024 10:25:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/10] iomap: optionally use ioends for direct I/O
Message-ID: <20241219182503.GG6156@frogsfrogsfrogs>
References: <20241219173954.22546-1-hch@lst.de>
 <20241219173954.22546-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173954.22546-8-hch@lst.de>

On Thu, Dec 19, 2024 at 05:39:12PM +0000, Christoph Hellwig wrote:
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
>  fs/iomap/direct-io.c  | 49 +++++++++++++++++++++++++++++++++++++++++--
>  fs/iomap/internal.h   |  1 +
>  fs/iomap/ioend.c      |  2 ++
>  include/linux/iomap.h |  4 +++-
>  4 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ed658eb09a1a..dd521f4edf55 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2010 Red Hat, Inc.
> - * Copyright (c) 2016-2021 Christoph Hellwig.
> + * Copyright (c) 2016-2024 Christoph Hellwig.
>   */
>  #include <linux/module.h>
>  #include <linux/compiler.h>
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
> @@ -119,7 +121,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	 * ->end_io() when necessary, otherwise a racing buffer read would cache
>  	 * zeros from unwritten extents.
>  	 */
> -	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE))
> +	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE) &&
> +	    !(dio->flags & IOMAP_DIO_NO_INVALIDATE))
>  		kiocb_invalidate_post_direct_write(iocb, dio->size);
>  
>  	inode_dio_end(file_inode(iocb->ki_filp));
> @@ -221,6 +224,7 @@ static void iomap_dio_done(struct iomap_dio *dio)
>  	}
>  }
>  
> +
>  void iomap_dio_bio_end_io(struct bio *bio)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
> @@ -241,6 +245,47 @@ void iomap_dio_bio_end_io(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
>  
> +u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
> +{
> +	struct iomap_dio *dio = ioend->io_bio.bi_private;
> +	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
> +	u32 vec_count = ioend->io_bio.bi_vcnt;
> +
> +	if (ioend->io_error)
> +		iomap_dio_set_error(dio, ioend->io_error);
> +
> +	if (atomic_dec_and_test(&dio->ref)) {
> +		/*
> +		 * Try to avoid another context switch for the completion given
> +		 * that we are already called from the ioend completion
> +		 * workqueue, but never invalidate pages from this thread to
> +		 * avoid deadlocks with buffered I/O completions.  Tough luck if
> +		 * yoy hit the tiny race with someone dirtying the range now

                   you

> +		 * betweem this check and the actual completion.

                   between

With those fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +		 */
> +		if (!dio->iocb->ki_filp->f_mapping->nrpages) {
> +			dio->flags |= IOMAP_DIO_INLINE_COMP;
> +			dio->flags |= IOMAP_DIO_NO_INVALIDATE;
> +		}
> +		dio->flags &= ~IOMAP_DIO_CALLER_COMP;
> +		iomap_dio_done(dio);
> +	}
> +
> +	if (should_dirty) {
> +		bio_check_pages_dirty(&ioend->io_bio);
> +	} else {
> +		bio_release_pages(&ioend->io_bio, false);
> +		bio_put(&ioend->io_bio);
> +	}
> +
> +	/*
> +	 * Return the number of bvecs completed as even direct I/O completions
> +	 * do significant per-folio work and we'll still want to give up the
> +	 * CPU after a lot of completions.
> +	 */
> +	return vec_count;
> +}
> +
>  static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  		loff_t pos, unsigned len)
>  {
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index 36d5c56e073e..f6992a3bf66a 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -5,5 +5,6 @@
>  #define IOEND_BATCH_SIZE	4096
>  
>  u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
> +u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>  
>  #endif /* _IOMAP_INTERNAL_H */
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index b4f6dd9e319a..158fa685d81f 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -41,6 +41,8 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  
>  	if (!atomic_dec_and_test(&ioend->io_remaining))
>  		return 0;
> +	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
> +		return iomap_finish_ioend_direct(ioend);
>  	return iomap_finish_ioend_buffered(ioend);
>  }
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0d221fbe0eb3..1ef4c44fa36f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -343,13 +343,15 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>  #define IOMAP_IOEND_UNWRITTEN		(1U << 1)
>  /* don't merge into previous ioend */
>  #define IOMAP_IOEND_BOUNDARY		(1U << 2)
> +/* is direct I/O */
> +#define IOMAP_IOEND_DIRECT		(1U << 3)
>  
>  /*
>   * Flags that if set on either ioend prevent the merge of two ioends.
>   * (IOMAP_IOEND_BOUNDARY also prevents merged, but only one-way)
>   */
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

