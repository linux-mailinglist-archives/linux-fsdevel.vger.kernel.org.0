Return-Path: <linux-fsdevel+bounces-30385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2D98A93F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92499B230AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE4B19309C;
	Mon, 30 Sep 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjU1I9+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071919047D;
	Mon, 30 Sep 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711721; cv=none; b=Miy/ksDTnr65zTUkh0ARmYa+fEIS451Dl8Bt8gpq8NWpu5F8nDJymXwjXBAOs7Ajn8IyymrzS0MyMTbjrmsGFF22pbOmeqY1AhpalIbeq6kb3iTYhxtLBa8u+hZExDfdfE67KsYSOcVFveO3LqqM38FstxanHvlMiPOfbwcbG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711721; c=relaxed/simple;
	bh=mGAviq9lJYc+MOYHPo9IYVaqS8V8iDe5erw2ZUSak64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtq47mFUJZMQbPAoa6zu0IqfK79wwqOlQVGdUjVzjfb6NwXkrJO8vggLqepx+GZft4AGFgUSdbENp3JHpgrYEAMLrup/b1NiuVRIDCPl6gNNJDDeEDeXEnE4eT2edsFZVtBVuGi9VthLNK59suad5ufjK8Kx0mnaM+omciQ8/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjU1I9+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D2C4CECF;
	Mon, 30 Sep 2024 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727711721;
	bh=mGAviq9lJYc+MOYHPo9IYVaqS8V8iDe5erw2ZUSak64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjU1I9+imGGtceFBhpenmYqvQS2L/9hPWauneuIJgQfsnjOjtkwUVyTFZKXfG+4iU
	 RioNMEoAhqTahTr0r+L6IvxycMaMdOcCitg+luYAlB6KHd76i4UWKCyTy/AhxSW7xk
	 PX2oFrNmRDfr43HjN+4UpNQmqWeTlzGiH+N9zDuitT55fEWIIcvATPwISM1hk6MOKk
	 rbFnf1g9fbY8njk18tvGTmGdSOm8dwdq4DRpnU784KOftV5LJVvogXe5qDkXvQNGHF
	 3KxVKlddILW5JQwPiVIGdsVOdwmBh1C5RVsOWUKu94+0pOjEYvG13wxqxDh21Lil2m
	 my2ISbfCA80nQ==
Date: Mon, 30 Sep 2024 08:55:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 3/7] fs: iomap: Atomic write support
Message-ID: <20240930155520.GM21853@frogsfrogsfrogs>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930125438.2501050-4-john.g.garry@oracle.com>

On Mon, Sep 30, 2024 at 12:54:34PM +0000, John Garry wrote:
> Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
> flag set.
> 
> Initially FSes (XFS) should only support writing a single FS block
> atomically.
> 
> As with any atomic write, we should produce a single bio which covers the
> complete write length.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> Maybe we should also enforce that a mapping is in written state, as it
> avoids issues later with forcealign and writing mappings which cover
> multiple extents in different written/unwritten state.
> 
>  fs/iomap/direct-io.c  | 26 +++++++++++++++++++++++---
>  fs/iomap/trace.h      |  3 ++-
>  include/linux/iomap.h |  1 +
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f637aa0706a3..9401c05cd2c0 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   * clearing the WRITE_THROUGH flag in the dio request.
>   */
>  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua)
> +		const struct iomap *iomap, bool use_fua, bool atomic)
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> @@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  		opflags |= REQ_FUA;
>  	else
>  		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> +	if (atomic)
> +		opflags |= REQ_ATOMIC;
>  
>  	return opflags;
>  }
> @@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> -	loff_t length = iomap_length(iter);
> +	const loff_t length = iomap_length(iter);
> +	bool atomic = iter->flags & IOMAP_ATOMIC;
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
> @@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> +	if (atomic && (length != fs_block_size))
> +		return -EINVAL;
> +
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
> @@ -382,7 +388,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	 * can set up the page vector appropriately for a ZONE_APPEND
>  	 * operation.
>  	 */
> -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
> +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
>  
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
> @@ -415,6 +421,17 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		}
>  
>  		n = bio->bi_iter.bi_size;
> +		if (atomic && n != length) {
> +			/*
> +			 * This bio should have covered the complete length,
> +			 * which it doesn't, so error. We may need to zero out
> +			 * the tail (complete FS block), similar to when
> +			 * bio_iov_iter_get_pages() returns an error, above.
> +			 */
> +			ret = -EINVAL;
> +			bio_put(bio);
> +			goto zero_tail;
> +		}
>  		if (dio->flags & IOMAP_DIO_WRITE) {
>  			task_io_account_write(n);
>  		} else {
> @@ -598,6 +615,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		iomi.flags |= IOMAP_ATOMIC;
> +
>  	if (iov_iter_rw(iter) == READ) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 0a991c4ce87d..4118a42cdab0 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_REPORT,		"REPORT" }, \
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
> -	{ IOMAP_NOWAIT,		"NOWAIT" }
> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> +	{ IOMAP_ATOMIC,		"ATOMIC" }
>  
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4ad12a3c8bae..c7644bdcfca3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -178,6 +178,7 @@ struct iomap_folio_ops {
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> +#define IOMAP_ATOMIC		(1 << 9)

This new flag needs a documentation update.  What do you think of this?

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 8e6c721d23301..279db993be7fa 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,6 +513,16 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
+ * ``IOMAP_ATOMIC``: This write must be persisted in its entirety or
+   not at all.
+   The write must not be split into multiple I/O requests.
+   The file range to write must be aligned to satisfy the requirements
+   of both the filesystem and the underlying block device's atomic
+   commit capabilities.
+   If filesystem metadata updates are required (e.g. unwritten extent
+   conversion or copy on write), all updates for the entire file range
+   must be committed atomically as well.
+
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
 
--D

>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.31.1
> 
> 

