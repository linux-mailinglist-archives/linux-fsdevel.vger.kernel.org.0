Return-Path: <linux-fsdevel+bounces-54386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF9AFF0E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03CA1C45A3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269723B626;
	Wed,  9 Jul 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0eLWdrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F8239E9F;
	Wed,  9 Jul 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085627; cv=none; b=PE7yM6YPwhxwHNxSnq1azuZlz5wglWl4YZUxvkTiUN29Mj21N9Wtgio+fE9TQm9LlzhmMrcfyEK3hxjuyrPSOYw3xlErJ4hJE+2fWkgXyinjtOU+h4388jLexbesUbyG1u6qOpn37/tYHCJBesHiXC6S2dCj8CCsZ1jOo7HBBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085627; c=relaxed/simple;
	bh=TkEtI4TBo+oLh+9EDnF1wp+1HPKjhz3UEa6azIGpx8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4URxisy5Rs08+FHRIDSGDDc5xKdzbNUEt9+KA851WyR0yaZTQ1LYt9MpRnGEu8W1il2mxCiMlix3SKcB6POPTUIzpAeZCF37J4v3bJCu3PeHUJfysLANmwcz5np6AYlb3SE5cudIw0wKVWAfrXbnukznIJvAwEZiUV0WHcuimY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0eLWdrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF20CC4CEF4;
	Wed,  9 Jul 2025 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752085626;
	bh=TkEtI4TBo+oLh+9EDnF1wp+1HPKjhz3UEa6azIGpx8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0eLWdrX2EjFSwq0YRgjpLMGmLYq9wZ/5E1px/SdSaCuRcpGJhnSpY8Av8ZaTHqnF
	 2uanjGMyhegxve7PCLAzmnAJEd4kQMd0IiqGJ9tI2Vj2UPsTM+oMXiK8QoCyhUwQl/
	 Dfonxy1bBUy7AsVN/OT/ASxMcZ0SViomyGzvHtmu8g/8m/Zx1/AVhjFdSle0slHTAt
	 +GwxwOSxKqU4/aW2UujOh/Hc3WHYx9pWBjMtxs1CMtHussLvrBzR5HN9Cfi9Qn4FXS
	 0XSYsbHW8a8Untd/Sgxnm68Px4swGCddzbFY3Hn/sNUyRnTBOCcbrpFWZJ4lYn5S2w
	 Q6Ge/2SbPzkYQ==
Date: Wed, 9 Jul 2025 11:27:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, ltp@lists.linux.it,
	dan.carpenter@linaro.org, benjamin.copeland@linaro.org,
	rbm@suse.com, Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <20250709182706.GF2672070@frogsfrogsfrogs>
References: <20250709181030.236190-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709181030.236190-1-arnd@kernel.org>

On Wed, Jul 09, 2025 at 08:10:14PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
> handling in the blockdev ioctl handler breaks all ioctls with
> _IOC_NR==2, as the new command is not added to the switch but only
> a few of the command bits are check.
> 
> Refine the check to also validate the direction/type/length bits,
> but still allow all supported sizes for future extensions.
> 
> Move the new command to the end of the function to avoid slowing
> down normal ioctl commands with the added branches.
> 
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
> Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> It seems that we have a lot of drivers with the same bug, as the
> large majority of all _IOC_NR() users in the kernel fail to also
> check the other bits of the ioctl command code. There are currently
> 55 files referencing _IOC_NR, and they all need to be manually
> checked for this problem.
> ---
>  block/ioctl.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9ad403733e19..5e5a422bd09f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -567,9 +567,6 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>  {
>  	unsigned int max_sectors;
>  
> -	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
> -		return blk_get_meta_cap(bdev, cmd, argp);
> -
>  	switch (cmd) {
>  	case BLKFLSBUF:
>  		return blkdev_flushbuf(bdev, cmd, arg);
> @@ -647,9 +644,16 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		return blkdev_pr_preempt(bdev, mode, argp, true);
>  	case IOC_PR_CLEAR:
>  		return blkdev_pr_clear(bdev, mode, argp);
> -	default:
> -		return -ENOIOCTLCMD;
>  	}
> +
> +	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
> +	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
> +	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&

I think this problem was introduced by brauner trying to persuade people
to perform size independent dispatch of ioctls:

       switch (_IOC_NR(cmd)) {
       case _IOC_NR(FS_IOC_FSGETXATTR):
               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_FSGETXATTR)))
                       return SOMETHING_SOMETHING;
               /* Only handle original size. */
               return ioctl_fsgetxattr(filp, argp);

https://lore.kernel.org/linux-xfs/20250515-bedarf-absagen-464773be3e72@brauner/

though we probably want a helper or something to encapsulate those three
comparisons to avoid the SOMETHING_SOMETHING part:

#define IOC_DISPATCH(c) \
	((c) & ~(_IOC(0, 0, 0, _IOC_SIZE(_IOC_SIZEMASK))))

	switch (IOC_DISPATCH(cmd)) {
	case IOC_DISPATCH(FS_IOC_FSGETXATTR):
		return ioctl_fsgetxattr(filp, cmd, argp);

Assuming that ioctl_fsgetxattr derives size from @cmd and rejects values
that it doesn't like.  Hrm?

> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))

blk_get_meta_cap already checks this.

--D

> +		return blk_get_meta_cap(bdev, cmd, argp);
> +
> +	return -ENOIOCTLCMD;
>  }
>  
>  /*
> -- 
> 2.39.5
> 

