Return-Path: <linux-fsdevel+bounces-66598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9151BC25D34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB8F04F2EDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316082C234F;
	Fri, 31 Oct 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffMRckRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17527B331;
	Fri, 31 Oct 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924248; cv=none; b=CHg20VGybE23da+/6Bw84KUPlChWPgt2cOosfI7AMC7x5cBgmFxMeQdD9/LERN8Nsg7jl6G+/yhYMZn326xs2MQqA8teJBeFIZgnntpf0ORjRIT7MeYtSHvRNrjutxq5e57QiLCRzkuDxDW2kw0yYQwPlrcyfE8xuVwiCB6gZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924248; c=relaxed/simple;
	bh=o8OYUkrvrAalen5EIlWZ1kI7gpobmbgMMZ6EzFvJDRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kciZhT9qj7zQBtSmTfC6hbdFsYQybaDrHkZDMbLP4ki0JT5XJWAF8dBX0w0ROj/E6pE8htqhS6HNXMxPJEKEB8rtG1dTHvGkuchi8FffDDER0fPtc26xZRGsen/j08guo0PlLxJLMTkEgGoMqrBY9LKM55R/I8NcpD5AabnowgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffMRckRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABD2C4CEE7;
	Fri, 31 Oct 2025 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924246;
	bh=o8OYUkrvrAalen5EIlWZ1kI7gpobmbgMMZ6EzFvJDRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffMRckRHHzSd6Mz9AKNUK4KDfJbYa60u8pLWMTZYzkBeQfmkN4XXxysEo0AZGnFJt
	 DW7rNj/sW7lzf7cwEqJqggpVbLdU12LKD4uOinI9eMuxseQopN2qMD0XnEWeOOZkkQ
	 WNolDOXMhT+2cxzImiA9ISqQpVKTWCAsbzaonPs8TYCz27S2jp/KBpR+mgCEeySyrN
	 AOFUdNAMZmFf3X01V1gxE0p05fTdNktvU7ihJFyjRL98Q0GR3Hly3wzlPVPvZl3iMS
	 yzyxgd5v2kAKqzEkapt9xGlqTIv4D04qh1hKdsN3hhNunkUe9I1ZYx1f2O5R5phrT+
	 YjGpfvDryjNig==
Date: Fri, 31 Oct 2025 08:24:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <20251031152406.GO6174@frogsfrogsfrogs>
References: <20251031131045.1613229-1-hch@lst.de>
 <20251031131045.1613229-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031131045.1613229-2-hch@lst.de>

On Fri, Oct 31, 2025 at 02:10:26PM +0100, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Btrfs requires all of its bios to be fs block aligned, normally it's
> totally fine but with the incoming block size larger than page size
> (bs > ps) support, the requirement is no longer met for direct IOs.
> 
> Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
> requiring alignment to be bdev_logical_block_size().
> 
> In the real world that value is either 512 or 4K, on 4K page sized
> systems it means bio_iov_iter_get_pages() can break the bio at any page
> boundary, breaking btrfs' requirement for bs > ps cases.
> 
> To address this problem, introduce a new public iomap dio flag,
> IOMAP_DIO_FSBLOCK_ALIGNED.
> 
> When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
> inherit that new flag, and iomap_dio_bio_iter() will take fs block size
> into the calculation of the alignment, and pass the alignment to
> bio_iov_iter_get_pages(), respecting the fs block size requirement.
> 
> The initial user of this flag will be btrfs, which needs to calculate the
> checksum for direct read and thus requires the biovec to be fs block
> aligned for the incoming bs > ps support.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> [hch: also align pos/len, incorporate the trace flags from Darrick]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c  | 17 +++++++++++++++--
>  fs/iomap/trace.h      |  7 ++++---
>  include/linux/iomap.h |  8 ++++++++
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 5d5d63efbd57..13def8418659 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -336,8 +336,18 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	int nr_pages, ret = 0;
>  	u64 copied = 0;
>  	size_t orig_count;
> +	unsigned int alignment;
>  
> -	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
> +	/*
> +	 * File systems that write out of place and always allocate new blocks
> +	 * need each bio to be block aligned as that's the unit of allocation.
> +	 */
> +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> +		alignment = fs_block_size;
> +	else
> +		alignment = bdev_logical_block_size(iomap->bdev);
> +
> +	if ((pos | length) & (alignment - 1))
>  		return -EINVAL;
>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
> @@ -434,7 +444,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
> -				bdev_logical_block_size(iomap->bdev) - 1);
> +					     alignment - 1);
>  		if (unlikely(ret)) {
>  			/*
>  			 * We have to stop part way through an IO. We must fall
> @@ -639,6 +649,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> +	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> +		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
> +
>  	if (iov_iter_rw(iter) == READ) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index a61c1dae4742..532787277b16 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -122,9 +122,10 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
>  
>  
>  #define IOMAP_DIO_STRINGS \
> -	{IOMAP_DIO_FORCE_WAIT,	"DIO_FORCE_WAIT" }, \
> -	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
> -	{IOMAP_DIO_PARTIAL,	"DIO_PARTIAL" }
> +	{IOMAP_DIO_FORCE_WAIT,		"DIO_FORCE_WAIT" }, \
> +	{IOMAP_DIO_OVERWRITE_ONLY,	"DIO_OVERWRITE_ONLY" }, \
> +	{IOMAP_DIO_PARTIAL,		"DIO_PARTIAL" }, \
> +	{IOMAP_DIO_FSBLOCK_ALIGNED,	"DIO_FSBLOCK_ALIGNED" }
>  
>  DECLARE_EVENT_CLASS(iomap_class,
>  	TP_PROTO(struct inode *inode, struct iomap *iomap),
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 73dceabc21c8..4da13fe24ce8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -518,6 +518,14 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> +/*
> + * Ensure each bio is aligned to fs block size.
> + *
> + * For filesystems which need to calculate/verify the checksum of each fs
> + * block. Otherwise they may not be able to handle unaligned bios.
> + */
> +#define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.47.3
> 
> 

