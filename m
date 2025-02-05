Return-Path: <linux-fsdevel+bounces-40978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC3A29AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EB716981A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF921E08D;
	Wed,  5 Feb 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhUgC0eU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361821CA1C;
	Wed,  5 Feb 2025 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786268; cv=none; b=kt+/OYHI5qn6hqPwFOcX3RtwWtgp/FI3zn3Y9puZJ6PtPQT4pAuFx/8gp562u/7k+fjbUfG9EvyU7hcqtlz30ORtBBsp8CeaaN6jCU5HHngY4F67CPr9h5hvkHg+EP3WqeByJDAwydTvuDyNq3cyeBeJqRGawQSdK5KK29gZm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786268; c=relaxed/simple;
	bh=06oElT4HZCrzpcyqk3Vc2Si6LDfhgg6xp2cCEicnK8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMhHiAOXmFrLU3McNFC4wYJpbMUJxN88c2YSaRYoY0xgw2ZJBA2pgmXFphF2G5fkraqNdI8zavO4Avnm1ZMrhMRTzv7AHcKpS1SnXC6Hfu/cEvILWo+picZeHQ++jw3b3QiTcwfqjC7h29bKWSdjfLfw0lMJiQ1LXdXZwI9o0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhUgC0eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F39C4CEDD;
	Wed,  5 Feb 2025 20:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738786268;
	bh=06oElT4HZCrzpcyqk3Vc2Si6LDfhgg6xp2cCEicnK8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhUgC0eUVyLZrbGBiolCp9SnkGtk5rmvNaMmoAQc+u8bYFcg6GnlldNLpAe8UfL2L
	 jBNPkauWtRNS/sPJZKsI0ra0JmgmWUsdk2fcLm6/fMQv9IJdnHHpZOUjLSyELf52DM
	 WISRui6RkzU5WQNjqzbev+b/Wm6ZXg841dqcEgErZqgxEnHj97dUqtfUq0BLPqSOkS
	 aC306CFBB8MDKdVdThPPJOekEDCg2ZzP8O9gkzswHcyBiFiIDqK+Xz5yj4FihpIVTQ
	 BQksmrTftE+19R3wf2HhCFdmv8G5Cf6EiC3piC4MWGmE74Xwx+zD5E8GABClUj5Mpk
	 3oLTqom5uXjOA==
Date: Wed, 5 Feb 2025 12:11:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 03/10] iomap: Support CoW-based atomic writes
Message-ID: <20250205201107.GA21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204120127.2396727-4-john.g.garry@oracle.com>

On Tue, Feb 04, 2025 at 12:01:20PM +0000, John Garry wrote:
> Currently atomic write support requires dedicated HW support. This imposes
> a restriction on the filesystem that disk blocks need to be aligned and
> contiguously mapped to FS blocks to issue atomic writes.
> 
> XFS has no method to guarantee FS block alignment. As such, atomic writes
> are currently limited to 1x FS block there.
> 
> To allow deal with the scenario that we are issuing an atomic write over
> misaligned or discontiguous data blocks larger atomic writes - and raise
> the atomic write limit - support a CoW-based software emulated atomic
> write mode.
> 
> For this special mode, the FS will reserve blocks for that data to be
> written and then atomically map that data in once the data has been
> commited to disk.
> 
> It is the responsibility of the FS to detect discontiguous atomic writes
> and switch to IOMAP_DIO_ATOMIC_COW mode and retry the write.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 23 ++++++++++++++++-------
>  include/linux/iomap.h |  9 +++++++++
>  2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 3dd883dd77d2..e63b5096bcd8 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   * clearing the WRITE_THROUGH flag in the dio request.
>   */
>  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua, bool atomic)
> +		const struct iomap *iomap, bool use_fua, bool atomic_bio)
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> @@ -283,7 +283,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  		opflags |= REQ_FUA;
>  	else
>  		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> -	if (atomic)
> +	if (atomic_bio)
>  		opflags |= REQ_ATOMIC;
>  
>  	return opflags;
> @@ -301,13 +301,19 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
>  	bool need_zeroout = false;
> +	bool atomic_bio = false;
>  	bool use_fua = false;
>  	int nr_pages, ret = 0;
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if (atomic && length != iter->len)
> -		return -EINVAL;
> +	if (atomic) {
> +		if (!(iomap->flags & IOMAP_F_ATOMIC_COW)) {
> +			if (length != iter->len)
> +				return -EINVAL;
> +			atomic_bio = true;
> +		}
> +	}
>  
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> @@ -318,7 +324,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		need_zeroout = true;
>  	}
>  
> -	if (iomap->flags & IOMAP_F_SHARED)
> +	if (iomap->flags & (IOMAP_F_SHARED | IOMAP_F_ATOMIC_COW))
>  		dio->flags |= IOMAP_DIO_COW;
>  
>  	if (iomap->flags & IOMAP_F_NEW) {
> @@ -383,7 +389,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  			goto out;
>  	}
>  
> -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
> +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_bio);
>  
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
> @@ -416,7 +422,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		}
>  
>  		n = bio->bi_iter.bi_size;
> -		if (WARN_ON_ONCE(atomic && n != length)) {
> +		if (WARN_ON_ONCE(atomic_bio && n != length)) {
>  			/*
>  			 * This bio should have covered the complete length,
>  			 * which it doesn't, so error. We may need to zero out
> @@ -639,6 +645,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
>  			dio->flags |= IOMAP_DIO_CALLER_COMP;
>  
> +		if (dio_flags & IOMAP_DIO_ATOMIC_COW)
> +			iomi.flags |= IOMAP_ATOMIC_COW;
> +
>  		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
>  			ret = -EAGAIN;
>  			if (iomi.pos >= dio->i_size ||
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 75bf54e76f3b..0a0b6798f517 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -56,6 +56,8 @@ struct vm_fault;
>   *
>   * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
>   * never be merged with the mapping before it.
> + *
> + * IOMAP_F_ATOMIC_COW indicates that we require atomic CoW end IO handling.

It more indicates that the filesystem is using copy on write to handle
an untorn write, and will provide the ioend support necessary to commit
the remapping atomically, right?

>   */
>  #define IOMAP_F_NEW		(1U << 0)
>  #define IOMAP_F_DIRTY		(1U << 1)
> @@ -68,6 +70,7 @@ struct vm_fault;
>  #endif /* CONFIG_BUFFER_HEAD */
>  #define IOMAP_F_XATTR		(1U << 5)
>  #define IOMAP_F_BOUNDARY	(1U << 6)
> +#define IOMAP_F_ATOMIC_COW	(1U << 7)
>  
>  /*
>   * Flags set by the core iomap code during operations:
> @@ -183,6 +186,7 @@ struct iomap_folio_ops {
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
>  #define IOMAP_ATOMIC		(1 << 9)
> +#define IOMAP_ATOMIC_COW	(1 << 10)

What does IOMAP_ATOMIC_COW do?  There's no description for it (or for
IOMAP_ATOMIC).  Can you have IOMAP_ATOMIC and IOMAP_ATOMIC_COW both set?
Or are they mutually exclusive?

I'm guessing from the code that ATOMIC_COW requires ATOMIC to be set,
but I wonder why because there's no documentation update in the header
files or in Documentation/filesystems/iomap/.

--D

>  struct iomap_ops {
>  	/*
> @@ -434,6 +438,11 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> +/*
> + * Use CoW-based software emulated atomic write.
> + */
> +#define IOMAP_DIO_ATOMIC_COW		(1 << 3)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.31.1
> 
> 

