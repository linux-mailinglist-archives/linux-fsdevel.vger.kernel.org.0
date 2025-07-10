Return-Path: <linux-fsdevel+bounces-54443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74605AFFB8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619AA5886B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFAC28BA91;
	Thu, 10 Jul 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGf2wODU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3628935D;
	Thu, 10 Jul 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134456; cv=none; b=QGoARZRaW82BcUUC9FArHMYi8dylyEHit2pU4McqT1pkz3IUIn441FopxH/SPxR3CmXdVNTs7++5EhURDpGng42x2ZFjK3k17iBKX3tUHm8BjpGwe+rRaYwymHq/eZoG0iFnFx4JYT1o2440PUVq9cZhNcMFntECsKwbtUCypjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134456; c=relaxed/simple;
	bh=3kJXKGVy19HwRS0v8G4JAZbl9NgESNksh+wuchZQHok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlAvWiuhtQSd0N1woR7HG0yCb2r+iQswhmWYK23dtyVrLCb8T1q/RM1CWWhH7gCNgpjlfuxqJaZvpXIkG2khBjhTBuXUrGSZeC4W7kBevFLnHPx7maSkST40kSyntfh/ACTCzK+6fHeOnAEQ4xEXthGhhpQsqVEGF2lE6NJFq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGf2wODU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9BDC4CEE3;
	Thu, 10 Jul 2025 08:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134455;
	bh=3kJXKGVy19HwRS0v8G4JAZbl9NgESNksh+wuchZQHok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGf2wODUPZB/EEXI0mi84RwgS5MLrJXyRX17IKrUPTWEWDDQQ+nINLDhMYWR5/uoO
	 go2vPoVflCUWA3uyRgB11W5vOfq7RKfENtWfYwj6BiLnNLSlipSmfzLKVnPfl1eS/+
	 t+SfH91y5Qs4IbTW8SzuLoyyzuhnG/rXubMaQTSo1r6DphveXGcxcpXQ/NamJHBStM
	 3q06LyImZ559wXvkq7miclNeKMHLEciIx/esPs/ZueLMqe0q4lmJYaTLBnhchQjef7
	 dyvfBjs9ez5J/FKNxug3E7XivS1a+IMXqf2Mg6oyROilNFuRXi67c4C46GB4GTBQCC
	 jdAYHoKSrlkHw==
Date: Thu, 10 Jul 2025 10:00:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, ltp@lists.linux.it, dan.carpenter@linaro.org, 
	benjamin.copeland@linaro.org, rbm@suse.com, Arnd Bergmann <arnd@arndb.de>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
References: <20250709181030.236190-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Thanks!

> It seems that we have a lot of drivers with the same bug, as the
> large majority of all _IOC_NR() users in the kernel fail to also
> check the other bits of the ioctl command code. There are currently
> 55 files referencing _IOC_NR, and they all need to be manually
> checked for this problem.
> ---

The current documentation in Documentation/dev-tools/checkuapi.rst needs
updating too then.

I want this to work. So as a start we should have a common static inline
helper that encapsulates the barrage of checks.

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
> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))

This part is wrong as we handle larger sizes just fine via
copy_struct_{from,to}_user().

Arnd, objections to writing it as follows?:

diff --git a/block/ioctl.c b/block/ioctl.c
index 9ad403733e19..9887ec55f8ce 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -567,9 +567,6 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 {
        unsigned int max_sectors;

-       if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
-               return blk_get_meta_cap(bdev, cmd, argp);
-
        switch (cmd) {
        case BLKFLSBUF:
                return blkdev_flushbuf(bdev, cmd, arg);
@@ -647,9 +644,25 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
                return blkdev_pr_preempt(bdev, mode, argp, true);
        case IOC_PR_CLEAR:
                return blkdev_pr_clear(bdev, mode, argp);
-       default:
-               return -ENOIOCTLCMD;
        }
+
+       /* extensible ioctls */
+       switch (_IOC_NR(cmd)) {
+       case _IOC_NR(FS_IOC_GETLBMD_CAP):
+               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
+                       break;
+               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
+                       break;
+               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
+                       break;
+               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
+                       break;
+               if (_IOC_SIZE(cmd) > PAGE_SIZE)
+                       break;
+               return blk_get_meta_cap(bdev, cmd, argp);
+       }
+
+       return -ENOIOCTLCMD;
 }

 /*

And can I ask you to please take a look at fs/pidfs.c:pidfd_ioctl() and
fs/nsfs.c:ns_ioctl()?


