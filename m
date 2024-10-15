Return-Path: <linux-fsdevel+bounces-31966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3B799E92E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A45284046
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5BE1F893F;
	Tue, 15 Oct 2024 12:12:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AEE1EF945;
	Tue, 15 Oct 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994342; cv=none; b=pTNwAnmK4OHo5mcmwBk6S8XPZFUaOrje4KOH2LxZIm8X99DWHr19DZADfU1fFn4Lm7L7BHi6gTZ6VSMWvJRhM0A03GKaL0ei539sosST+XQMrtl4bvYnxU7gZdDzFdKWmSRrKs9FMzikWMXWkEeQQL274c6ZpolOAj1EoBBscC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994342; c=relaxed/simple;
	bh=JVaN+276foz8D467uVisbk7ZPfas8KFjh0xX60dO7v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVdFpr2qXM1FPb7EKEL5FX9BpgRnta+nwpf756Ce2x/lQyEs8sIeTb8hxJHYXTRy0BShlh4P52ehWR/wg6aBoDGHGRUd2ywoPZQDO+KO5fOrwPYVxtH3BudCgNneBF+0Gy/LCEMBypqLr/5DtCYRnpVdb5+zAcVM2grhBfOpAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 29EBB227AAC; Tue, 15 Oct 2024 14:12:13 +0200 (CEST)
Date: Tue, 15 Oct 2024 14:12:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
	hch@lst.de, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v8 4/7] fs: iomap: Atomic write support
Message-ID: <20241015121212.GA32583@lst.de>
References: <20241015090142.3189518-1-john.g.garry@oracle.com> <20241015090142.3189518-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015090142.3189518-5-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 09:01:39AM +0000, John Garry wrote:
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
>  .../filesystems/iomap/operations.rst          | 11 ++++++
>  fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
>  fs/iomap/trace.h                              |  3 +-
>  include/linux/iomap.h                         |  1 +
>  4 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 8e6c721d2330..fb95e99ca1a0 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -513,6 +513,17 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>     if the mapping is unwritten and the filesystem cannot handle zeroing
>     the unaligned regions without exposing stale contents.
>  
> + * ``IOMAP_ATOMIC``: This write is being issued with torn-write
> +   protection. Only a single bio can be created for the write, and the
> +   write must not be split into multiple I/O requests, i.e. flag
> +   REQ_ATOMIC must be set.
> +   The file range to write must be aligned to satisfy the requirements
> +   of both the filesystem and the underlying block device's atomic
> +   commit capabilities.
> +   If filesystem metadata updates are required (e.g. unwritten extent
> +   conversion or copy on write), all updates for the entire file range
> +   must be committed atomically as well.
> +
>  Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
>  calling this function.
>  
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f637aa0706a3..c968a0e2a60b 100644
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

Nit: no need for the inner braces here.

> +		if (atomic && n != length) {
> +			/*
> +			 * This bio should have covered the complete length,
> +			 * which it doesn't, so error. We may need to zero out
> +			 * the tail (complete FS block), similar to when
> +			 * bio_iov_iter_get_pages() returns an error, above.
> +			 */
> +			ret = -EINVAL;

Do we want a WARN_ON_ONCE here because this is a condition that should be
impossible to hit?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

