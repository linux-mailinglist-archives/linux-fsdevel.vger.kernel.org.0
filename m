Return-Path: <linux-fsdevel+bounces-42490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13950A42D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C853617A616
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D205215F45;
	Mon, 24 Feb 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/pUZjY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030E136327;
	Mon, 24 Feb 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427153; cv=none; b=P2u/ygedKdWh+YjD+Q/tewG/VLJT2dOk5wYu+m9coAIRQzxegXNsf1JxkBMOSAB3OOONol+E2n6h1K5X8nLJAZGVG1U3zgp6F8Pm4KPB5i/Hxx4JQY+ecv3D3KTe5ZtJNPEJ/uZbp0pC594Hj505zd2n0U4nsXBywHGC137XREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427153; c=relaxed/simple;
	bh=W6g23xuIssALMbH2xgrfWTmhUTBR2YOv3qZN/bNUQ44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biH86SJrimCvjEwlOlq4/sEsYLFRNFr5qDGBDK54UQ64/X8HdKKpmj2WePV4Pg2CDX8CmslWDoaZx5MLqaLTjg8GpMMPztFPXGe47na+RCD8ZmFQwKS3hnIlGCPfRlVqcXiOadkmgv5PzsoFGZ4yMsccEjM5Gfd7Fmr86cTCbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/pUZjY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF325C4CED6;
	Mon, 24 Feb 2025 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427152;
	bh=W6g23xuIssALMbH2xgrfWTmhUTBR2YOv3qZN/bNUQ44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/pUZjY/fzMZiEQTtv7utDJgkg28SOgJfShAk1J4ilhBAoA7I1UIR5FdXUHIco9yJ
	 9UL46T9QaTxKTMpdug43NR1GqXyEiim3snnXMCgqobTH6O6BvBa1MGxfBlHfs7yUnC
	 FZf7Eg6o0/eAcKX3H/xosl41oIfM4y9qdVpD5m3ZwoZKHKWMOmWBBniZqPonAPGWuY
	 yZKnzZ3juTC90xzqW59LITd31omUCzhfU8AlA1y1U9Ab+F1U3qp2HShcLKhsVYkztV
	 /ENS/AXQOnDaILwsCfHK0R+arIkWu4IEJ7x0A2bKkr7UDNUcEcFQaQjpSWQxXhANeJ
	 UgwX/WfqxqpIA==
Date: Mon, 24 Feb 2025 11:59:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 04/11] iomap: Support CoW-based atomic writes
Message-ID: <20250224195912.GC21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-5-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:12PM +0000, John Garry wrote:
> Currently atomic write support requires dedicated HW support. This imposes
> a restriction on the filesystem that disk blocks need to be aligned and
> contiguously mapped to FS blocks to issue atomic writes.
> 
> XFS has no method to guarantee FS block alignment for regular non-RT files.
> As such, atomic writes are currently limited to 1x FS block there.
> 
> To allow deal with the scenario that we are issuing an atomic write over
> misaligned or discontiguous data blocks larger atomic writes - and raise
> the atomic write limit - support a CoW-based software emulated atomic
> write mode.
> 
> For this special mode, the FS will reserve blocks for that data to be
> written and then atomically map that data in once the data has been
> committed to disk.
> 
> It is the responsibility of the FS to detect discontiguous atomic writes
> and switch to IOMAP_DIO_ATOMIC_COW mode and retry the write.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/filesystems/iomap/operations.rst | 15 +++++++++++++--
>  fs/iomap/direct-io.c                           |  4 +++-
>  include/linux/iomap.h                          |  6 ++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 82bfe0e8c08e..d30dddc94ef7 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -525,8 +525,19 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>     conversion or copy on write), all updates for the entire file range
>     must be committed atomically as well.
>     Only one space mapping is allowed per untorn write.
> -   Untorn writes must be aligned to, and must not be longer than, a
> -   single file block.
> +   Untorn writes may be longer than a single file block. In all cases,
> +   the mapping start disk block must have at least the same alignment as
> +   the write offset.
> +
> + * ``IOMAP_ATOMIC_COW``: This write is being issued with torn-write
> +   protection based on CoW support.

I think using "COW" here results in a misnamed flag.  Consider:

"IOMAP_ATOMIC_SW: This write is being issued with torn-write protection
via a software fallback provided by the filesystem."

iomap itself doesn't care *how* the filesystem guarantees that the
direct write isn't torn, right?  The fs' io completion handler has to
ensure that the mapping update(s) are either applied fully or discarded
fully.

In theory if you had a bunch of physical space mapped to the same
file but with different unwritten states, you could gang together all
the unwritten extent conversions in a single transaction, which would
provide the necessary tearing prevention without the out of place write.
Nobody does that right now, but I think that's the only option for ext4.

--D

> +   All the length, alignment, and single bio restrictions which apply
> +   to IOMAP_ATOMIC_HW do not apply here.
> +   CoW-based atomic writes are intended as a fallback for when
> +   HW-based atomic writes may not be issued, e.g. the range covered in
> +   the atomic write covers multiple extents.
> +   All filesystem metadata updates for the entire file range must be
> +   committed atomically as well.
>  
>  Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
>  calling this function.
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f87c4277e738..076338397daa 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -644,7 +644,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iomi.flags |= IOMAP_OVERWRITE_ONLY;
>  		}
>  
> -		if (iocb->ki_flags & IOCB_ATOMIC)
> +		if (dio_flags & IOMAP_DIO_ATOMIC_COW)
> +			iomi.flags |= IOMAP_ATOMIC_COW;
> +		else if (iocb->ki_flags & IOCB_ATOMIC)
>  			iomi.flags |= IOMAP_ATOMIC_HW;
>  
>  		/* for data sync or sync, we need sync completion processing */
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e7aa05503763..1b961895678a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -183,6 +183,7 @@ struct iomap_folio_ops {
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
>  #define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
> +#define IOMAP_ATOMIC_COW	(1 << 10)/* CoW-based torn-write protection */
>  
>  struct iomap_ops {
>  	/*
> @@ -434,6 +435,11 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> +/*
> + * Use CoW-based software emulated torn-write protection.
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

