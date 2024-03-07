Return-Path: <linux-fsdevel+bounces-13942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD0D875A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5871C216BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8713E7CD;
	Thu,  7 Mar 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJkNDBBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959013DB99;
	Thu,  7 Mar 2024 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849687; cv=none; b=WCpqszj4EYhC1gDghD8DZMDvCVckdhqT6d+QXQy18YMDqcU617lNGy2wPC3Tk+sw2pAL+TvzcrZJsR8QeRFKyT9ADT19O+R67aJ3mjlEyVmEP22dHUXxt8Qx83z1Q8FrmMvvXHh1C4aTFwmzifmt4/qTWg1HYJlv2IwbTnAAKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849687; c=relaxed/simple;
	bh=79d/orbSPQS+vRTKitvJwyBTYD4CD17ZgOE1udY8kQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTGthcy+lIJA5hU6CfRxmncgBbe4+yc9vcXhfAA1zAotkFQC/MWrnn7+VKB54dusu/RKhXEt703ktCRzLalpMjaKDTejX5xih3OC/1DYWhJUqK78gyPdE/NvCBMkr+iLOEKiK0PxK17phauYMoQ478MO6UK775kE8WM4yohlwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJkNDBBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404D6C433F1;
	Thu,  7 Mar 2024 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849686;
	bh=79d/orbSPQS+vRTKitvJwyBTYD4CD17ZgOE1udY8kQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJkNDBBmWcBVcAmz2Fd8osysOtrrx3nvtWXhLncAuiXXgvYhWG1+EDDivPgkDCNSG
	 a3BnHxcPg2XYkuDEUfRxRgQlVHMebfpbGtxSTwlqr+Mz49geGsQrca+n1hddfw6Jyg
	 /uIR+01M+6H1djHmvbzqQdrMxjcUBxR+Li8cmYJhgyS1wybY8H6rtVjmLE6HMialQk
	 cZl9NjlpVSgTi9HuZXxXx193lwHcq1L4kdSDgsApGDf+HkEUA1W75Yo/9ADG97/nt4
	 S77KrLfejVcUhB3Y9NA3ce7xQcU8uk6LE30hdone3IdSBa+QGTjSjemwi0Ia8/M+OD
	 QYw2gqG939+Mw==
Date: Thu, 7 Mar 2024 14:14:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 23/24] xfs: add fs-verity ioctls
Message-ID: <20240307221445.GY1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-25-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-25-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:46PM +0100, Andrey Albershteyn wrote:
> Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
> tree pages) and obtain file's digest.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_ioctl.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index ab61d7d552fb..4763d20c05ff 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -43,6 +43,7 @@
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/fileattr.h>
> +#include <linux/fsverity.h>
>  
>  /*
>   * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
> @@ -2174,6 +2175,22 @@ xfs_file_ioctl(
>  		return error;
>  	}
>  
> +	case FS_IOC_ENABLE_VERITY:
> +		if (!xfs_has_verity(mp))
> +			return -EOPNOTSUPP;
> +		return fsverity_ioctl_enable(filp, (const void __user *)arg);

Isn't @arg already declared as a (void __user *) ?

--D

> +
> +	case FS_IOC_MEASURE_VERITY:
> +		if (!xfs_has_verity(mp))
> +			return -EOPNOTSUPP;
> +		return fsverity_ioctl_measure(filp, (void __user *)arg);
> +
> +	case FS_IOC_READ_VERITY_METADATA:
> +		if (!xfs_has_verity(mp))
> +			return -EOPNOTSUPP;
> +		return fsverity_ioctl_read_metadata(filp,
> +						    (const void __user *)arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> -- 
> 2.42.0
> 
> 

