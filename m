Return-Path: <linux-fsdevel+bounces-42499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F90A42DE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E0F175185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8BA265CAB;
	Mon, 24 Feb 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjmTz40l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774F24BC14;
	Mon, 24 Feb 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429164; cv=none; b=JBd18N9M/63D9glxvem+wFWblxEggksy2ouk2fwyYoAextj6BC3X/0gLBtamnKOFN4mhz/OWqhBNwrWw42QHZEvrouNrGbA3+4QKyjdYUDvJJJIB3fkzqdshErpOTfcFA2cEuDWViq0hvZUcBczmRmXYR7xTImLT+nQwG0qGtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429164; c=relaxed/simple;
	bh=zAxD/EPIg7VFvoaYHjkPnMQfoo8CDYDGm9IOOWs8bWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBpSuSE4eZsfePK84T0Ea/A+6PWOPScirhoXYFhTn49ABfh05bjXeEYO/yUpRpTITrzmi8T9RSo/ww6lU4lSaBHCbN7PooZ5r1Gv00bZgU2mYQX3VIwGT1RSc9EP6EVlMLXTXfqeYGldyIG/GwcGcfRDAjWPtTudd2wGD1bKJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjmTz40l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B0EC4CED6;
	Mon, 24 Feb 2025 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429164;
	bh=zAxD/EPIg7VFvoaYHjkPnMQfoo8CDYDGm9IOOWs8bWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjmTz40lIkyN8pddFyzoWjmbfMyzq/XWmjeXhYwtPbwj5afl6klZSF9FEZv0hozt6
	 rXp5YKJUkEdFmLplVrfgMEFEP1CoyhP6Vco+Lalq3dz91uUaMwf8JS7eIap8eNS04I
	 wZxORrKXeZkyEYqn5sxtRn2vLJw1Q+Sd5MmGJ32O8aUO2gY/v66O+Aq0jNsM218j0U
	 USEsqqhoAJRWu60IHXapnak06f7xZWs/htW7Hsk2zoNS/ADpFJX+UvHReCoOLSUVV5
	 dv+NNrjcN8hHTpfYaR+smoTHGU8ks/H1adRFWDY8NTVn9otuKJmYsKplXAfX7UTuGE
	 rNlEDfe7Hrz5Q==
Date: Mon, 24 Feb 2025 12:32:43 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 08/11] xfs: Add xfs_file_dio_write_atomic()
Message-ID: <20250224203243.GJ21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-9-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:16PM +0000, John Garry wrote:
> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
> 
> In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
> in CoW-based atomic write mode.
> 
> For CoW-based mode, ensure that we have no outstanding IOs which we
> may trample on.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks fine,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 258c82cbce12..9762fa503a41 100644
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
> +	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> +			&xfs_dio_write_ops, dio_flags, NULL, 0);
> +
> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
> +	    !(dio_flags & IOMAP_DIO_ATOMIC_COW)) {
> +		xfs_iunlock(ip, iolock);
> +		dio_flags = IOMAP_DIO_ATOMIC_COW | IOMAP_DIO_FORCE_WAIT;
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
> 

