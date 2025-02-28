Return-Path: <linux-fsdevel+bounces-42797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3DFA48DC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B545B7A1B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 01:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B83010C;
	Fri, 28 Feb 2025 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThNWJDX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB081C28E;
	Fri, 28 Feb 2025 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705554; cv=none; b=gGbwYV2GetSnoR4WCH2KTBXxkyXEovWSSEGHnATfetTI2kpzP1hKAm5Uzc3gFP37gsj7w6Xa5OgFsudp1e6HlQ052jlVymI4j8Cf0ei76hE4fRTo0w9O/MKQ2NULWkwnUMaf+F1X7IPZH68OgTnf4Nmqswi38yz49KKTqQ4Z0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705554; c=relaxed/simple;
	bh=LoI42HDvxyiwqxPalcDKi+mcTyMnoWXPNxOzXKcAVxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSTVoVtmL14gJe9s9AgV+ihUa1XwKP6hKEv/slupPLB0AyH+D4t1R90tVzLCv+O5Muh+fgI+JmZqNjp99TfkrNoJcNZ53SVLzWmUT6mOF13I34xLmisQWb0EWDzcHObUc1YQ19BIrBtCfTsXLbZA82X3zLv0CqmGAVT6wkfBSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThNWJDX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF1EC4CEE7;
	Fri, 28 Feb 2025 01:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705554;
	bh=LoI42HDvxyiwqxPalcDKi+mcTyMnoWXPNxOzXKcAVxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThNWJDX1AveUtuXK3qogQqAZbfIpB+SPhVPQyUwKfggFXXds2sS57/lo6rnJgc9ZG
	 s9urN2z1t+iLH/m26eSjpmfg/uovYSIAuvC1hCHUbgs1/1LWTAhGm0V/8pr5MH0QZc
	 bKNeoTpJZePNHK1M188jUvEAStJIyBkDXpy/HoDCuM8cO/86Degv7/atY4AijjymFo
	 p8cgM9ULwyNw52XDeproFKDEi+nlLq0SuNecFpJUC/fwKWx9X/s2Q2Wz5fckyXus/u
	 OiNv4yrtt+7iYamSQQTGpUnJq7i3OEjblB87pyKDJ0ZkAmwgB6ECN6rOwuvJ93te9s
	 HLeSthNb4FFig==
Date: Thu, 27 Feb 2025 17:19:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 09/12] xfs: Add xfs_file_dio_write_atomic()
Message-ID: <20250228011913.GD1124788@frogsfrogsfrogs>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180813.1553404-10-john.g.garry@oracle.com>

On Thu, Feb 27, 2025 at 06:08:10PM +0000, John Garry wrote:
> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
> 
> In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
> in CoW-based atomic write mode.
> 
> For CoW-based mode, ensure that we have no outstanding IOs which we
> may trample on.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 258c82cbce12..76ea59c638c3 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -619,6 +619,46 @@ xfs_file_dio_write_aligned(
>  	return ret;
>  }
>  
> +static noinline ssize_t
> +xfs_file_dio_write_atomic(
> +	struct xfs_inode	*ip,
> +	struct kiocb		*iocb,
> +	struct iov_iter		*from)
> +{
> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
> +	unsigned int		dio_flags = 0;
> +	ssize_t			ret;
> +
> +retry:
> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
> +	if (ret)
> +		return ret;
> +
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
> +		inode_dio_wait(VFS_I(ip));
> +
> +	trace_xfs_file_direct_write(iocb, from);
> +	ret = iomap_dio_rw(iocb, from, &xfs_atomic_write_iomap_ops,
> +			&xfs_dio_write_ops, dio_flags, NULL, 0);
> +
> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
> +	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
> +		xfs_iunlock(ip, iolock);
> +		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;

One last little nit here: if the filesystem doesn't have reflink, you
can't use copy on write as a fallback.

		/*
		 * The atomic write fallback uses out of place writes
		 * implemented with the COW code, so we must fail the
		 * atomic write if that is not supported.
		 */
		if (!xfs_has_reflink(ip->i_mount))
			return -EOPNOTSUPP;
		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;

You can retain my RVB if you add that.

--D

> +		iolock = XFS_IOLOCK_EXCL;
> +		goto retry;
> +	}
> +
> +out_unlock:
> +	if (iolock)
> +		xfs_iunlock(ip, iolock);
> +	return ret;
> +}
> +
>  /*
>   * Handle block unaligned direct I/O writes
>   *
> @@ -723,6 +763,8 @@ xfs_file_dio_write(
>  		return -EINVAL;
>  	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
>  		return xfs_file_dio_write_unaligned(ip, iocb, from);
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		return xfs_file_dio_write_atomic(ip, iocb, from);
>  	return xfs_file_dio_write_aligned(ip, iocb, from);
>  }
>  
> -- 
> 2.31.1
> 

