Return-Path: <linux-fsdevel+bounces-33478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F69B9399
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 15:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AE41F2236D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAC81AAE05;
	Fri,  1 Nov 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlU4bueS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C61A256C;
	Fri,  1 Nov 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472405; cv=none; b=ebTddsy3AAynLOKGqL41/dhZc5zKRG5I452LWutegaodeYkMkAh/4slrrZRX/ooBSlKrwcw7Mn1JMEXum3aBL4QB52EpeX5z9Zu+XS5sBEWiPg15n5Qv3yZZ56rQgTZ2sIr/iLNpB/9dA1HEkysVQEIiRi7spFauRNZXi/nQlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472405; c=relaxed/simple;
	bh=HwxmMVzLvMkz6Iea0esLVCOgt5DfZzfLpkKFluqPk6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhfPccChCqo+rhhCkXae6Fo3zj7kW3lFr5j+wk+oN4GrppDQjQHeCoClySmD8RRvTSx2S0afr5htyoB1VtbiOlGR9g/FuN2M+vI5lwUr4/l5d919lyEuDbXvxCr3BSZxsM1FNlaj8CMKMZmi40JeTIzl/X81P61i9tugb61BuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlU4bueS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2C6C4CECD;
	Fri,  1 Nov 2024 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730472405;
	bh=HwxmMVzLvMkz6Iea0esLVCOgt5DfZzfLpkKFluqPk6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlU4bueSqUtO5V+hbz8vO0YzJl4hNnccmNnFi89FPVCl8a+1lACDLOp/Eix3MhKSB
	 UZJFR80381Q2bRmM91JBI3GGUSxH92CpZ10lEqSMkl/JrU1G3hW3Hq42mzNt1SnV+2
	 1JA2g+FF8/6lh04uvXW/26CNve07w26yk7EgjnUyB4XDkVGArSsafHuptjFAt+7Vz9
	 XZxqL97vekLm6oh9COsFdMbu506fGmjQ2GWqnHOn2oQwPcm0ab1ywtqJjTVqFqaf7P
	 yu7yn/Ers6d5rlJwnXzY75xq1lyapblTxBPhbm+D78y2xNvjOPLfCoR97I7WNzp2Pi
	 Cugpsn5MaBZlg==
Date: Fri, 1 Nov 2024 07:46:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ext4: Do not fallback to buffered-io for DIO
 atomic write
Message-ID: <20241101144644.GF2386201@frogsfrogsfrogs>
References: <cover.1730437365.git.ritesh.list@gmail.com>
 <78fb5c40dde4847dc32af09e668a6f81fa251137.1730437365.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fb5c40dde4847dc32af09e668a6f81fa251137.1730437365.git.ritesh.list@gmail.com>

On Fri, Nov 01, 2024 at 12:20:54PM +0530, Ritesh Harjani (IBM) wrote:
> atomic writes is currently only supported for single fsblock and only
> for direct-io. We should not return -ENOTBLK for atomic writes since we
> want the atomic write request to either complete fully or fail
> otherwise. Hence, we should never fallback to buffered-io in case of
> DIO atomic write requests.
> Let's also catch if this ever happens by adding some WARN_ON_ONCE before
> buffered-io handling for direct-io atomic writes. More details of the
> discussion [1].
> 
> While at it let's add an inline helper ext4_want_directio_fallback() which
> simplifies the logic checks and inherently fixes condition on when to return
> -ENOTBLK which otherwise was always returning true for any write or directio in
> ext4_iomap_end(). It was ok since ext4 only supports direct-io via iomap.
> 
> [1]: https://lore.kernel.org/linux-xfs/cover.1729825985.git.ritesh.list@gmail.com/T/#m9dbecc11bed713ed0d7a486432c56b105b555f04
> Suggested-by: Darrick J. Wong <djwong@kernel.org> # inline helper

Looks good to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/file.c  |  7 +++++++
>  fs/ext4/inode.c | 27 ++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 96d936f5584b..a7de03e47db0 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -599,6 +599,13 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ssize_t err;
>  		loff_t endbyte;
> 
> +		/*
> +		 * There is no support for atomic writes on buffered-io yet,
> +		 * we should never fallback to buffered-io for DIO atomic
> +		 * writes.
> +		 */
> +		WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC);
> +
>  		offset = iocb->ki_pos;
>  		err = ext4_buffered_write_iter(iocb, from);
>  		if (err < 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3e827cfa762e..5b9eeb74ce47 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3444,17 +3444,34 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>  	return ret;
>  }
> 
> +static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> +{
> +	/* must be a directio to fall back to buffered */
> +	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> +		    (IOMAP_WRITE | IOMAP_DIRECT))
> +		return false;
> +
> +	/* atomic writes are all-or-nothing */
> +	if (flags & IOMAP_ATOMIC)
> +		return false;
> +
> +	/* can only try again if we wrote nothing */
> +	return written == 0;
> +}
> +
>  static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>  			  ssize_t written, unsigned flags, struct iomap *iomap)
>  {
>  	/*
>  	 * Check to see whether an error occurred while writing out the data to
> -	 * the allocated blocks. If so, return the magic error code so that we
> -	 * fallback to buffered I/O and attempt to complete the remainder of
> -	 * the I/O. Any blocks that may have been allocated in preparation for
> -	 * the direct I/O will be reused during buffered I/O.
> +	 * the allocated blocks. If so, return the magic error code for
> +	 * non-atomic write so that we fallback to buffered I/O and attempt to
> +	 * complete the remainder of the I/O.
> +	 * For non-atomic writes, any blocks that may have been
> +	 * allocated in preparation for the direct I/O will be reused during
> +	 * buffered I/O. For atomic write, we never fallback to buffered-io.
>  	 */
> -	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
> +	if (ext4_want_directio_fallback(flags, written))
>  		return -ENOTBLK;
> 
>  	return 0;
> --
> 2.46.0
> 
> 

