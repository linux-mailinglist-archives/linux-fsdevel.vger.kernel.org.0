Return-Path: <linux-fsdevel+bounces-40976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9959A29A74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2799188549B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F820D4E5;
	Wed,  5 Feb 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSSj5ll/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B2DF5C;
	Wed,  5 Feb 2025 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785343; cv=none; b=b8Oq1sqFWvSeFW2yQx9JEPqt2Qj8HjlLJ9OeVdRr57J7cLwrmswxA4qkUK6UUJQzb+AYfyWKkD3lIxmoI4moS1YbAXxcKBvgpXbD4S+q+x9lnUiDxxgB//1aQ2N0TTzTY8zYfQaEf6jppM5uoTWF3qLVCdEhwCowI2koQaEEqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785343; c=relaxed/simple;
	bh=kG/h0+m1+OjNoroCZYMAeFweCfK+4hMAFzYCEDJwTXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0Coc9FaZKSOpRY8Gh7grJmzs4A0+rWFqsmYpSHx5MvmgveZpJxTg3ripyzdU3zQ36YIY0L7HoncfgU6zI7AKZ9qZQp//IlsguYnlnBvrP4YIH2Vuj8lhA61ErTC5mh3BsIJIZ/xuAcBeAYwLAb4zIe+9jm4x8YXtGw7tSIKn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSSj5ll/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C554C4CED1;
	Wed,  5 Feb 2025 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785341;
	bh=kG/h0+m1+OjNoroCZYMAeFweCfK+4hMAFzYCEDJwTXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSSj5ll/PmcDAQxQS7yjzmTRadHRcOn8cqxs2fex+8UtgWvv5JFn9zW/SRDeoHnvx
	 l8TU0DoOMVnB2OKlONnriQceH6Gh77VkcwVe7hKQD4pcCkCDxhz2Eli7YOG6QzIKN6
	 xfAqMDX0+KGCG0c9tboomMyh+eXxOlP+MyXSUw4sGwwrx5/d2uOWV43HKnLfQ3cOpt
	 ybXlzDCh45LUghM7OHGBhKxTU1jy9DMMWRaUwL9BOWQowzBNFtMOQvOcWfBUck7KW/
	 k4gdkyBBj8OrbvR/ZQO0ON6hZPyjuY7gqVffp3FnmtWCJ7eVod11UqkAkKKJuw0ga6
	 sIcFIzq01d6FA==
Date: Wed, 5 Feb 2025 11:55:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 07/10] xfs: Add xfs_file_dio_write_atomic()
Message-ID: <20250205195540.GY21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204120127.2396727-8-john.g.garry@oracle.com>

On Tue, Feb 04, 2025 at 12:01:24PM +0000, John Garry wrote:
> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
> 
> In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
> in CoW-based atomic write mode.
> 
> In the CoW-based atomic write mode, first unshare blocks so that we don't
> have a cow fork for the data in the range which we are writing.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index fd05b66aea3f..12af5cdc3094 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -619,6 +619,55 @@ xfs_file_dio_write_aligned(
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
> +	bool			use_cow = false;
> +	unsigned int		dio_flags;
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
> +	if (use_cow) {
> +		ret = xfs_reflink_unshare(ip, iocb->ki_pos,
> +			iov_iter_count(from));

Nit: continuation lines should be indented two tabs:

		ret = xfs_reflink_unshare(ip, iocb->ki_pos,
				iov_iter_count(from));

> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +	trace_xfs_file_direct_write(iocb, from);
> +	if (use_cow)
> +		dio_flags = IOMAP_DIO_ATOMIC_COW;
> +	else
> +		dio_flags = 0;

I also think you could eliminate use_cow by initializing dio_flags to
zero at the top, OR'ing in IOMAP_DIO_ATOMIC_COW in the retry clause
below, and using (dio_flags & IOMAP_DIO_ATOMIC_COW) to determine if you
should call unshare above.

Note: This serializes all the software untorn direct writes.  I think
a more performant solution would allocate the cow staging blocks ondisk,
attach them to the directio ioend context, and alter ->iomap_begin and
the ioend remap to use the attached blocks, but that's a lot more
surgery.

--D

> +
> +	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> +			&xfs_dio_write_ops, dio_flags, NULL, 0);
> +
> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) && !use_cow) {
> +		xfs_iunlock(ip, iolock);
> +		iolock = XFS_IOLOCK_EXCL;
> +		use_cow = true;
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
> @@ -723,6 +772,8 @@ xfs_file_dio_write(
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
> 

