Return-Path: <linux-fsdevel+bounces-29600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F9F97B520
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3463C2821BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758618BC17;
	Tue, 17 Sep 2024 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpOgcbr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1434CE5;
	Tue, 17 Sep 2024 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608268; cv=none; b=nTXtFtykEaSLrsvXa9LdYYY46+6pd9NfKEc1zsNvqTLZ8Ro8MZwkWj2cbc/BCtLfCnBkUsYAUgy0ykjCCqcLEupYMgNQ3JNlLT5jT9fH8BOWCOcvi+o9IQHF3GFzLXXtCp4fWi8yHbMDKcdmhY6oHUiLp7l1244zEU/eoV2djsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608268; c=relaxed/simple;
	bh=XB356tuhb8WcK5oGmhNFmnCjnK51SM0uq6FcoCCopic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv2UaxnacGdMl3P+10OpEuRVmSU6XyRVJYHBAwthD1Ys0GSumVCXfz91Wp4lhvg0V7BbOuqwq7FkBCvyp0zOLfTZBQUZ7UD0TDKx+ZqXvhTcGUU9SyJP6II3i98KwyJURJ1l/75okicBglymehjfFo+RpmTYgK8ZTOMXB4X3D0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpOgcbr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B9DC4CEC5;
	Tue, 17 Sep 2024 21:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726608267;
	bh=XB356tuhb8WcK5oGmhNFmnCjnK51SM0uq6FcoCCopic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpOgcbr4xnWIHQ7LQX7bKRUaNb2WZd9IQzYdlRkSNosomn5O5uAN7qdvRwWK9azg8
	 fsVu9M+C68KM2fniLUfKC0MRRyGQCcOtygrmgoQ4+5XVrfqa3bDIoJ7SA6lvubaaql
	 Es/4YC84HSUQIfzVkD3NeLJ/FjCzlSblcFxjmHGsM6VnMvWnSsZaE1NU/SQO6OqSL8
	 K1mnVCLcCEfpzNnusaTrBzjEhe/5m22/JfcYHRdQKvOKTdNvM/pVVocOZSWiHXgcxB
	 uGB9Z9VNAvZzvkf5NiTBAJmR22fBM3XLsXlWbN+Gce/v6XsMCIbAsKnhLzCkEz2N1B
	 mqwWbolWHz/kQ==
Date: Tue, 17 Sep 2024 14:24:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
Message-ID: <20240917212427.GD182177@frogsfrogsfrogs>
References: <20240910043949.3481298-1-hch@lst.de>
 <20240910043949.3481298-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910043949.3481298-8-hch@lst.de>

On Tue, Sep 10, 2024 at 07:39:09AM +0300, Christoph Hellwig wrote:
> xfs_file_write_zero_eof is the only caller of xfs_zero_range that does
> not take XFS_MMAPLOCK_EXCL (aka the invalidate lock).  Currently that
> is acrually the right thing, as an error in the iomap zeroing code will

     actually

> also take the invalidate_lock to clean up, but to fix that deadlock we
> need a consistent locking pattern first.
> 
> The only extra thing that XFS_MMAPLOCK_EXCL will lock out are read
> pagefaults, which isn't really needed here, but also not actively
> harmful.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c  | 8 +++++++-
>  fs/xfs/xfs_iomap.c | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a30fda1985e6af..37dc26f51ace65 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -357,6 +357,7 @@ xfs_file_write_zero_eof(
>  {
>  	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
>  	loff_t			isize;
> +	int			error;
>  
>  	/*
>  	 * We need to serialise against EOF updates that occur in IO completions
> @@ -404,7 +405,12 @@ xfs_file_write_zero_eof(
>  	}
>  
>  	trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
> -	return xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
> +
> +	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> +	error = xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
> +	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);

Ah, ok, so we're taking the invalidate_lock so that we can't have page
faults that might add folios (or dirty existing ones) in the mapping.
We're the only ones who can access the page cache, and we're doing that
so that we can zero the folios between the old EOF and the start of the
write region.

Is that right?  Then
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +
> +	return error;
>  }
>  
>  /*
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 1e11f48814c0d0..3c98d82c0ad0dc 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1435,6 +1435,8 @@ xfs_zero_range(
>  {
>  	struct inode		*inode = VFS_I(ip);
>  
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
> +
>  	if (IS_DAX(inode))
>  		return dax_zero_range(inode, pos, len, did_zero,
>  				      &xfs_dax_write_iomap_ops);
> -- 
> 2.45.2
> 
> 

