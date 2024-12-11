Return-Path: <linux-fsdevel+bounces-37113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C99EDC37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 00:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E9A281E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418D1F2C55;
	Wed, 11 Dec 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixMKd0LB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08417736;
	Wed, 11 Dec 2024 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960869; cv=none; b=DnL2TiCQt6jlwx38w0/ixhNIGWIbONBSDp09QWRr0CSATLohM1FXBMZrJq9+DmCLWWbdVGa+QGD4zmwk9oDz0Sj3GFwMfRK5Og8mZNFGyCVz3nwMW1j2Il/JIx9vUDnq8LGShvpPM8PAyOQ559SUTs8ytldf88V9yOnKnfTfl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960869; c=relaxed/simple;
	bh=0yiZ245LASEXA6c8jyY/oe2CUb8FtjgwJITkX3Mmvk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5EZYQnz4dBmWcti1OOFdtszTQ4/tyss+owe0Fe6IgKO/C3ETqQyHbwtPZWN/T4cUXcUGLIdrXFKfilDymL2SxqpzxnelWXokFopkCIOhpT/IND380ezibvfkybiGWUogpHZoPce+a140HXVo4AB2Ku2MlHLXms2TGPIU3Y/ZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixMKd0LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16724C4CED2;
	Wed, 11 Dec 2024 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733960869;
	bh=0yiZ245LASEXA6c8jyY/oe2CUb8FtjgwJITkX3Mmvk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixMKd0LB5E5pwQpW9Uyy11FDNLT05hYB2byVGDzcW5qCHyBWfQNQe37kdfeQtq1bD
	 sa2eIjIdzAYoNRJPEY5/XXagn+0fvmbyL04wShG/s+XvJKqpT5n7xbW7xlsg1InznT
	 V4theosTq8De/6wPEEWukGRVbZBGTK+QYb+ZkPLTIdD6Mz7hjZjddEefqAJs7DUcMN
	 O1CKNXGWyV+Xk0nTbog6YN7g46x1ckDBfrM4X5f5kBUWptpMyxDtLF8zdfWGWw4dp/
	 RcJnvIXz8YQdN40PCPoptWdCRVprI2HFLH96Q4wx8DxT/ixae3HdIjqqmvJzlpLIzZ
	 ZO6TZMp0V+9JA==
Date: Wed, 11 Dec 2024 15:47:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20241211234748.GB6678@frogsfrogsfrogs>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210125737.786928-3-john.g.garry@oracle.com>

On Tue, Dec 10, 2024 at 12:57:32PM +0000, John Garry wrote:
> For atomic writes support, it is required to only ever submit a single bio
> (for an atomic write).
> 
> Furthermore, currently the atomic write unit min and max limit is fixed at
> the FS block size.
> 
> For lifting the atomic write unit max limit, it may occur that an atomic
> write spans mixed unwritten and mapped extents. For this case, due to the
> iterative nature of iomap, multiple bios would be produced, which is
> intolerable.
> 
> Add a function to zero unwritten extents in a certain range, which may be
> used to ensure that unwritten extents are zeroed prior to issuing of an
> atomic write.

I still dislike this.  IMO block untorn writes _is_ a niche feature for
programs that perform IO in large blocks.  Any program that wants a
general "apply all these updates or none of them" interface should use
XFS_IOC_EXCHANGE_RANGE since it has no awu_max restrictions, can handle
discontiguous update ranges, doesn't require block alignment, etc.

Instead here we are adding a bunch of complexity, and not even all that
well:

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 76 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h |  3 ++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 23fdad16e6a8..18c888f0c11f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -805,6 +805,82 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
>  
> +static loff_t
> +iomap_dio_zero_unwritten_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> +{
> +	const struct iomap *iomap = &iter->iomap;
> +	loff_t length = iomap_length(iter);
> +	loff_t pos = iter->pos;
> +
> +	if (iomap->type == IOMAP_UNWRITTEN) {
> +		int ret;
> +
> +		dio->flags |= IOMAP_DIO_UNWRITTEN;
> +		ret = iomap_dio_zero(iter, dio, pos, length);

Shouldn't this be detecting the particular case that the mapping for the
kiocb is in mixed state and only zeroing in that case?  This just
targets every unwritten extent, even if the unwritten extent covered the
entire range that is being written.  It doesn't handle COW, it doesn't
handle holes, etc.

Also, can you make a version of blkdev_issue_zeroout that returns the
bio so the caller can issue them asynchronously instead of opencoding
the bio_alloc loop in iomap_dev_zero?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	dio->size += length;
> +
> +	return length;
> +}
> +
> +ssize_t
> +iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct iomap_dio *dio;
> +	ssize_t ret;
> +	struct iomap_iter iomi = {
> +		.inode		= inode,
> +		.pos		= iocb->ki_pos,
> +		.len		= iov_iter_count(iter),
> +		.flags		= IOMAP_WRITE,

IOMAP_WRITE | IOMAP_DIRECT, no?

--D

> +	};
> +
> +	dio = kzalloc(sizeof(*dio), GFP_KERNEL);
> +	if (!dio)
> +		return -ENOMEM;
> +
> +	dio->iocb = iocb;
> +	atomic_set(&dio->ref, 1);
> +	dio->i_size = i_size_read(inode);
> +	dio->dops = dops;
> +	dio->submit.waiter = current;
> +	dio->wait_for_completion = true;
> +
> +	inode_dio_begin(inode);
> +
> +	while ((ret = iomap_iter(&iomi, ops)) > 0)
> +		iomi.processed = iomap_dio_zero_unwritten_iter(&iomi, dio);
> +
> +	if (ret < 0)
> +		iomap_dio_set_error(dio, ret);
> +
> +	if (!atomic_dec_and_test(&dio->ref)) {
> +		for (;;) {
> +			set_current_state(TASK_UNINTERRUPTIBLE);
> +			if (!READ_ONCE(dio->submit.waiter))
> +				break;
> +
> +			blk_io_schedule();
> +		}
> +		__set_current_state(TASK_RUNNING);
> +	}
> +
> +	if (dops && dops->end_io)
> +		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
> +
> +	kfree(dio);
> +
> +	inode_dio_end(file_inode(iocb->ki_filp));
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iomap_dio_zero_unwritten);
> +
>  static int __init iomap_dio_init(void)
>  {
>  	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5675af6b740c..c2d44b9e446d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -440,6 +440,9 @@ ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> +ssize_t iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
> +
>  ssize_t iomap_dio_complete(struct iomap_dio *dio);
>  void iomap_dio_bio_end_io(struct bio *bio);
>  
> -- 
> 2.31.1
> 
> 

