Return-Path: <linux-fsdevel+bounces-46894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4DEA95F45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768653B947E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C523A982;
	Tue, 22 Apr 2025 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSY0K4SI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D76FB9;
	Tue, 22 Apr 2025 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306730; cv=none; b=MkPNu2erfp5zXhj7dcrZP+Nu43tL+ZZvKo9Op9/Zm92IbT7Ek9YcMKqYASeU6AyJJsZvG+dBshUjZzIMp90lEs9MRqWCjh+kytMqjP9EQ20DzNwSecT3nbPA4B5zw6J16whlUzhARxm5su3nNrRsS1NQX7Jd+sKvtWJIpbWM4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306730; c=relaxed/simple;
	bh=rQsJbOmcDtEhKQH7dgzzmbawJS4pLSBqfLHSlw5lvqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT+IajAPoFmpyuVPn5ohyw7ydZB7pGMzx+fcEEM1WywxhOD2SQBYq4I5pe5P5JoatvcrGzUnStuMid0tPC+1cQtrhoNocIQHu293qPKARXZKQEQ0HnIvX0UqrLjrRBedZwrSchU7I03eDdQ0xexFZJhbtjirdXATsDzn9FI84YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSY0K4SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9629FC4CEE9;
	Tue, 22 Apr 2025 07:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745306729;
	bh=rQsJbOmcDtEhKQH7dgzzmbawJS4pLSBqfLHSlw5lvqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSY0K4SIz3e1Skk3BzdXiorXuYljecjTCOncpoN2OlfEtrCKv/7oEq2E4HmsX6sYk
	 zRlA+pGVgRF3IhvGz++I0O5qJMlQsXe6zATGjWgq54bvawEQ2Zmcxm1iZ51D7FINmO
	 o+TpkYYq2AIFDosWQjtHO8Aud/Kr/rHccc4L8ncbXhDE6SIx+b8iaPwZxbROfIOsRO
	 eVxh9JJOamspT00GizUFQahXK8UY9MhCCgbYfZmFYT7lnXeQOCePur5LWkb15PR1/1
	 puwqEUrklJGhAklZbVsBllQJGyS1EHjLaOI8UMg1kSWOz9IcWZyQoUMO++eVGl6+9N
	 Hu+5eBqRUi6Bg==
Date: Tue, 22 Apr 2025 09:25:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: hch <hch@lst.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"djwong@kernel.org" <djwong@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422-auswies-feinschliff-b89c231316db@brauner>
References: <20250417064042.712140-1-hch@lst.de>
 <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
 <20250422055149.GB29356@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422055149.GB29356@lst.de>

On Tue, Apr 22, 2025 at 07:51:49AM +0200, hch wrote:
> On Tue, Apr 22, 2025 at 05:03:19AM +0000, Shinichiro Kawasaki wrote:
> > I ran blktests with the kernel v6.15-rc3, and found the test case md/001 hangs.
> > The hang is recreated in stable manner. I bisected and found this patch as the
> > commit 777d0961ff95 is the trigger. When I revert the commit from v6.15-rc3
> > kernel, the hang disappeared.
> > 
> > Actions for fix will be appreciated.
> > 
> > FYI, the kernel INFO messages recorded functions relevant to the trigger commit,
> > such as bdev_statx or vfs_getattr_nosec [1].
> 
> This should fix it:

Can you send this as a proper patch so I can pick it up, please?
It needs to go upstream.

> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 6a34179192c9..97d4c0ab1670 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1274,18 +1274,23 @@ void sync_bdevs(bool wait)
>   */
>  void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
>  {
> -	struct inode *backing_inode;
>  	struct block_device *bdev;
>  
> -	backing_inode = d_backing_inode(path->dentry);
> -
>  	/*
> -	 * Note that backing_inode is the inode of a block device node file,
> -	 * not the block device's internal inode.  Therefore it is *not* valid
> -	 * to use I_BDEV() here; the block device has to be looked up by i_rdev
> -	 * instead.
> +	 * Note that d_backing_inode() returnsthe inode of a block device node
> +	 * file, not the block device's internal inode.
> +	 *
> +	 * Therefore it is *not* valid to use I_BDEV() here; the block device
> +	 * has to be looked up by i_rdev instead.
> +	 *
> +	 * Only do this lookup if actually needed to avoid the performance
> +	 * overhead of the lookup, and to avoid injecting bdev lifetime issues
> +	 * into devtmpfs.
>  	 */
> -	bdev = blkdev_get_no_open(backing_inode->i_rdev);
> +	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
> +		return;
> +
> +	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
>  	if (!bdev)
>  		return;
>  

