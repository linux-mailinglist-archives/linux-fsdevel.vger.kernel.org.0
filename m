Return-Path: <linux-fsdevel+bounces-46901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48BFA960C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B7F17967E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375FC1EBA07;
	Tue, 22 Apr 2025 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5/yO5lm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5E2F3E;
	Tue, 22 Apr 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309753; cv=none; b=Qc3ywW8omqn6fUhHc7VDe9xd2AGjWE14pRWmGdcK4OY8TeDKq/fde1xIHA0nnQ5RQzPbwyjRcWPjOJvJnwVQCN0Z/bxtSjKYJl3HKKocWPp97uVxRF6SlVUv6SU9TJRstTPSyd8QaXCo7DK7GbjPbCveJHJfzWWTE18oFlun8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309753; c=relaxed/simple;
	bh=ly/S3vGiyt4p19c1V/A+YbeYTEbIH4jV0pHO+LqIk/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odP6IOTpbyNUkekhc5DbZE+jbo0FOYuLRYe9Biv9khfBw1+ilmIgx81RI4c5o/OP14oLsjvWotLbPQ/ldGZ48vTBm2dnKlPgQJ958JD4AS/BJhhbGd6ZW0IzEJ1YTAwXSD3+nGCSKRzNrVL6X3TOVR3LX31CgDRMM+vUXsBH/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5/yO5lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE657C4CEE9;
	Tue, 22 Apr 2025 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745309753;
	bh=ly/S3vGiyt4p19c1V/A+YbeYTEbIH4jV0pHO+LqIk/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5/yO5lmXtMKDjG8aOCEO4Cf+7/Re9bp9A0Ovh22niJ04fFiJSybzjT5SsHv5z5jR
	 wmcuQyR204/bVBv7cyUjVZGHPmM3kYS97MZG4LALk2BuXTQtIhhsJqK3voGNjmdv1b
	 HTdJxCBthg3IPaADPQnCw+Og3RVRanxgAJeORHZjOfcxmFrcIakBcVHvg2aDSxoa5F
	 +pDX/xqX/JtuTNRnw40kgfy3OLPkSztLIs+yiVNMd1vmqHwUkWnrTrOOKQfOY0h+7r
	 6bNd44XtaaGkNfx8B3LOHPVADGQImfaxHnCT/4fvYx+XfTXqwVhPY6PUkRoJnd7jJc
	 VJFB94zd6n0+A==
Date: Tue, 22 Apr 2025 10:15:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: hch <hch@lst.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"djwong@kernel.org" <djwong@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422-angepackt-reisen-bc24fbec2702@brauner>
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

This leaks the block device reference if blkdev_get_no_open() succeeds.

> +
> +	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
>  	if (!bdev)
>  		return;
>  

