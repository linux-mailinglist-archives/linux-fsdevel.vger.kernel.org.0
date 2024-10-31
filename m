Return-Path: <linux-fsdevel+bounces-33376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0FC9B85BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C914DB20DAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6681CCB5E;
	Thu, 31 Oct 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4b6COmu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13619DF4C;
	Thu, 31 Oct 2024 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411472; cv=none; b=AbXAMRigAaBeniBuzE0s2ucshlGieC+uDBGWTC4Vc+6ypp2N9ECJ8sE/4XCRoh1XK094x3EstFu04P5ALJrSxXkPaD9JKJZwTcAmw3/DB0IsjEMfhKe4czI3xe5Ysi5sRNXqSjxz1fDSz1emB6xpsxP9oVxx1HUBgeRaesbUqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411472; c=relaxed/simple;
	bh=XRdS29FevNlee9tclBH9K6FrEPkzbvUowqz/KE9+PwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAoLJkWHP2n0eeumDPBixH+NMFgq7OVvtkgMf8HxUdSKF+augPIpCs/yQZShvmLM8tQsY53ZdNPs6dkyjyBEegT9/Z6fYYPleSPYDzfsP+xZRKeJJVnHBe4xMoXuOxr+PFWT+GvI0kw+seeasCjafvBg5/dIFPgaRAMVIgYP4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4b6COmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6142DC4CECF;
	Thu, 31 Oct 2024 21:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730411472;
	bh=XRdS29FevNlee9tclBH9K6FrEPkzbvUowqz/KE9+PwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4b6COmub/Rx7OUcjnn6NBV9Lp3fKXec2wGlamyQ9phZhK2aK1BquIKl0cSWEwE6N
	 lii/GBkApfkS0ptLpSR4+6zOWhMA48TTFMTVM2ly9T+/i7P5bxEMMufYnxwrVugf4K
	 DTH6anFLzyfvZfmxRDpwW2UlYkWXEKezE8AWpikYQoB1I5XgLsIpS0771cHyw3P2Fp
	 FivLUMC8ILXKUKRAQTxrvAZ0Im8cA1b6vrS2z8XIwyVWVIQqE+zYkYv9M7eLa4zk44
	 /Uave/56IOfug9KsASCHYq/4er5iE32ZbzNFMvvmOyJgbGnzdXdMO2SHSeMlDoclx+
	 2Kf7gH4VKKzog==
Date: Thu, 31 Oct 2024 14:51:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ext4: Do not fallback to buffered-io for DIO
 atomic write
Message-ID: <20241031215111.GF21832@frogsfrogsfrogs>
References: <cover.1730286164.git.ritesh.list@gmail.com>
 <3c6f41ebed5ca2a669fb05ccc38e8530d0e3e220.1730286164.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6f41ebed5ca2a669fb05ccc38e8530d0e3e220.1730286164.git.ritesh.list@gmail.com>

On Wed, Oct 30, 2024 at 09:27:41PM +0530, Ritesh Harjani (IBM) wrote:
> atomic writes is currently only supported for single fsblock and only
> for direct-io. We should not return -ENOTBLK for atomic writes since we
> want the atomic write request to either complete fully or fail
> otherwise. We should not fallback to buffered-io in case of DIO atomic
> write requests.
> Let's also catch if this ever happens by adding some WARN_ON_ONCE before
> buffered-io handling for direct-io atomic writes.
> 
> More details of the discussion [1].
> 
> [1]: https://lore.kernel.org/linux-xfs/cover.1729825985.git.ritesh.list@gmail.com/T/#m9dbecc11bed713ed0d7a486432c56b105b555f04
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/file.c  |  7 +++++++
>  fs/ext4/inode.c | 14 +++++++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 8116bd78910b..61787a37e9d4 100644
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
> index fcdee27b9aa2..26b3c84d7f64 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3449,12 +3449,16 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
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
> +	 * For atomic writes we will simply fail the I/O request if we coudn't
> +	 * write anything. For non-atomic writes, any blocks that may have been
> +	 * allocated in preparation for the direct I/O will be reused during
> +	 * buffered I/O.
>  	 */
> -	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
> +	if (!(flags & IOMAP_ATOMIC) && (flags & (IOMAP_WRITE | IOMAP_DIRECT))

Huh.  The WRITE|DIRECT check doesn't look right to me, because the
expression returns true for any write or any directio.  I think that's
currently "ok" because ext4_iomap_end is only called for directio
writes, but this bugs me anyway.  For a directio write fallback, that
comparison really should be:

	(flags & (WRITE|DIRECT)) == (WRITE|DIRECT)

static inline bool
ext4_want_directio_fallback(unsigned flags, ssize_t written)
{
	/* must be a directio to fall back to buffered */
	if (flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
		    (IOMAP_WRITE | IOMAP_DIRECT)
		return false;

	/* atomic writes are all-or-nothing */
	if (flags & IOMAP_ATOMIC)
		return false;

	/* can only try again if we wrote nothing */
	return written == 0;
}

	if (ext4_want_directio_fallback(flags, written))
		return -ENOTBLK;

> +			&& written == 0)

Nit: put the '&&' operator on the previous line when there's a multiline
expression.

--D

>  		return -ENOTBLK;
>  
>  	return 0;
> -- 
> 2.46.0
> 
> 

