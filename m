Return-Path: <linux-fsdevel+bounces-42794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C867FA48DAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5904C16E74A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 01:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375361E4B2;
	Fri, 28 Feb 2025 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHJdtDvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E917741;
	Fri, 28 Feb 2025 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704901; cv=none; b=tVeSYvH0F5LT9hu9R20L16Bt6Rhak/eEoDP5KG59C7i1rwPFwa69mAdS/asTRxavSoSsYVnKmXwIJtGcim4VwmA9irn3aGMAYAe5tSQ6fhI75mK/f5V6Fz/H+woYj/jWIlNBGD1AMQXxt/J2YKIjOnlGj/qOFzyCvdcyt32zaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704901; c=relaxed/simple;
	bh=r204P3/o5tj0rdMt2fYtelvoijFFzJ47ze5idBCOS9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pad3YVKRT1uOuDIolKbd0RXVrxmaiBZZjDj8jFalb3wmewOriGZX+QjJPPORq+GGXyNiNm5F7RRb4PVyrxMIzgJgdIbEGGkh3rlr7YvIQ5WfCdl3fqjv/w2TCYyZ/H7fIRMc0SseqNEKkuQSpadiTbpBXVXV/Duvfx9vC84anTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHJdtDvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46B3C4CEDD;
	Fri, 28 Feb 2025 01:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740704900;
	bh=r204P3/o5tj0rdMt2fYtelvoijFFzJ47ze5idBCOS9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHJdtDvmzOr7jxlj+heg4PLyT24i+BDwsC1VHcEYHWDKQnK4ahjgWkduJe0Abp8dT
	 LZO722W1Ks8lWVZbWua5cGKv9b9D3hq7pe9RBHoPRM+hCDAVmyoYJG2Pg8dFUuM48i
	 Lk4aOPH3tXcSWn2mzbhtsbCl7GBhpcNwMaae0b0r2kuLOuYWy6aYjP+T+VHwKEMV1R
	 H8zSJjAfRVEYKfm1ly1rizwIV2z9x7jf6QAyyzjxqLNjj7tS8iFRn1Ei3vbMWju5oq
	 shIpwAIEyfTUuj3Zug4VpzjQliSNAhckxSfSZqWc+yZOL070XsnvvAmiaWWnYuSzmj
	 sVjqD0W1RDaHg==
Date: Thu, 27 Feb 2025 17:08:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/12] iomap: Support SW-based atomic writes
Message-ID: <20250228010820.GB1124788@frogsfrogsfrogs>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180813.1553404-6-john.g.garry@oracle.com>

On Thu, Feb 27, 2025 at 06:08:06PM +0000, John Garry wrote:
> Currently atomic write support requires dedicated HW support. This imposes
> a restriction on the filesystem that disk blocks need to be aligned and
> contiguously mapped to FS blocks to issue atomic writes.
> 
> XFS has no method to guarantee FS block alignment for regular,
> non-RT files. As such, atomic writes are currently limited to 1x FS block
> there.
> 
> To deal with the scenario that we are issuing an atomic write over
> misaligned or discontiguous data blocks - and raise the atomic write size
> limit - support a SW-based software emulated atomic write mode. For XFS,
> this SW-based atomic writes would use CoW support to issue emulated untorn
> writes.
> 
> It is the responsibility of the FS to detect discontiguous atomic writes
> and switch to IOMAP_DIO_ATOMIC_SW mode and retry the write. Indeed,
> SW-based atomic writes could be used always when the mounted bdev does
> not support HW offload, but this strategy is not initially expected to be
> used.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good now, thank you.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/iomap/operations.rst | 16 ++++++++++++++--
>  fs/iomap/direct-io.c                           |  4 +++-
>  include/linux/iomap.h                          |  6 ++++++
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 82bfe0e8c08e..b9757fe46641 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -525,8 +525,20 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>     conversion or copy on write), all updates for the entire file range
>     must be committed atomically as well.
>     Only one space mapping is allowed per untorn write.
> -   Untorn writes must be aligned to, and must not be longer than, a
> -   single file block.
> +   Untorn writes may be longer than a single file block. In all cases,
> +   the mapping start disk block must have at least the same alignment as
> +   the write offset.
> +
> + * ``IOMAP_ATOMIC_SW``: This write is being issued with torn-write
> +   protection via a software mechanism provided by the filesystem.
> +   All the disk block alignment and single bio restrictions which apply
> +   to IOMAP_ATOMIC_HW do not apply here.
> +   SW-based untorn writes would typically be used as a fallback when
> +   HW-based untorn writes may not be issued, e.g. the range of the write
> +   covers multiple extents, meaning that it is not possible to issue
> +   a single bio.
> +   All filesystem metadata updates for the entire file range must be
> +   committed atomically as well.
>  
>  Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
>  calling this function.
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f87c4277e738..575bb69db00e 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -644,7 +644,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iomi.flags |= IOMAP_OVERWRITE_ONLY;
>  		}
>  
> -		if (iocb->ki_flags & IOCB_ATOMIC)
> +		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
> +			iomi.flags |= IOMAP_ATOMIC_SW;
> +		else if (iocb->ki_flags & IOCB_ATOMIC)
>  			iomi.flags |= IOMAP_ATOMIC_HW;
>  
>  		/* for data sync or sync, we need sync completion processing */
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e7aa05503763..4fa716241c46 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -183,6 +183,7 @@ struct iomap_folio_ops {
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
>  #define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
> +#define IOMAP_ATOMIC_SW		(1 << 10)/* SW-based torn-write protection */
>  
>  struct iomap_ops {
>  	/*
> @@ -434,6 +435,11 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> +/*
> + * Use software-based torn-write protection.
> + */
> +#define IOMAP_DIO_ATOMIC_SW		(1 << 3)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.31.1
> 

