Return-Path: <linux-fsdevel+bounces-17310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D38AB41C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 19:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12C71F2313E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E981386CC;
	Fri, 19 Apr 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxP1rISy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AC130AC8;
	Fri, 19 Apr 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546313; cv=none; b=dpbYSoVZS9fZXmn3f6Dk+uvMZZH9aYNHExTw93kBU35rbdD7PL/O9pXow4p0WcfOMry4PNlE+f9haNL5TpmdTfiuLmIai5VBY8tlsHWDLMpz3qJGDnx3qVrk7FC6+Sv2V9WTM8wQDpwkjEeraHHVTa35koCqbJQA922zyB933hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546313; c=relaxed/simple;
	bh=+ZKb78YZ/qFCFnbEsmfuq1mGqLqipgbAODAVHINlwTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRFF7av0HVm/FXst1VlH1jJunR0rxIDMqpeMJJ4R9UWFebKIgGf1T/2Fy33aFYU239AuFZqDVpPqu2J18NqdLH5fdmnbSNJ4bIHPitlu41rZDKV/T2SaKQbFpoysqmo1nv/mliqGv6KjpnYljx3XH+sYn9r/RpKNsJ3rJiOTo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxP1rISy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43FCC072AA;
	Fri, 19 Apr 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713546313;
	bh=+ZKb78YZ/qFCFnbEsmfuq1mGqLqipgbAODAVHINlwTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxP1rISyy1aIIsNTbwRnWW4eR/+iMvxce6AlrqBog+3Ozyzj9kYkL8BCQU97Q1xfR
	 jWhcrPiDuD5tsIuSt7fBJa+omLa+HrhgNENuY/lX2noeGu5YZ7gkcSmzLoyoMourJz
	 2m2feTRqapplbjRpNELpijUMAvoAGQQ4Bim1BYOXOHfIrR6lSbYujHXju5M+W6W3r3
	 mY5ff6EDWvVbHFQDi/bktg+6dHbqmgXF9f6rv7IS4IAr6KLCnk0KHEIVWRQHFM3leJ
	 2PjhfHQnV1FebsbMYwd12hKlEGcf7iIYtoQCfZ/C5sFovHArY3angLyA/0tzx5Ptby
	 SydF+muKE2LLA==
Date: Fri, 19 Apr 2024 10:05:11 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Richard Fung <richardfung@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ynaffit@google.com
Subject: Re: [PATCH v2] fuse: Add initial support for fs-verity
Message-ID: <20240419170511.GB1131@sol.localdomain>
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240416001639.359059-1-richardfung@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416001639.359059-1-richardfung@google.com>

Hi,

On Tue, Apr 16, 2024 at 12:16:39AM +0000, Richard Fung wrote:
> This adds support for the FS_IOC_ENABLE_VERITY and FS_IOC_MEASURE_VERITY
> ioctls. The FS_IOC_READ_VERITY_METADATA is missing but from the
> documentation, "This is a fairly specialized use case, and most fs-verity
> users won’t need this ioctl."
> 
> Signed-off-by: Richard Fung <richardfung@google.com>
> ---
>  fs/fuse/ioctl.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index 726640fa439e..01638784972a 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -8,6 +8,7 @@
>  #include <linux/uio.h>
>  #include <linux/compat.h>
>  #include <linux/fileattr.h>
> +#include <linux/fsverity.h>
>  
>  static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
>  			       struct fuse_ioctl_out *outarg)
> @@ -118,6 +119,63 @@ static int fuse_copy_ioctl_iovec(struct fuse_conn *fc, struct iovec *dst,
>  }
>  
>  
> +/* For fs-verity, determine iov lengths from input */
> +static long fuse_setup_verity_ioctl(unsigned int cmd, unsigned long arg,
> +				    struct iovec *iov, unsigned int *in_iovs)
> +{
> +	switch (cmd) {
> +	case FS_IOC_MEASURE_VERITY: {
> +		__u16 digest_size;
> +		struct fsverity_digest __user *uarg =
> +				(struct fsverity_digest __user *)arg;
> +
> +		if (copy_from_user(&digest_size, &uarg->digest_size,
> +				sizeof(digest_size)))
> +			return -EFAULT;
> +
> +		if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
> +			return -EINVAL;
> +
> +		iov->iov_len = sizeof(struct fsverity_digest) + digest_size;
> +		break;
> +	}
> +	case FS_IOC_ENABLE_VERITY: {
> +		struct fsverity_enable_arg enable;
> +		struct fsverity_enable_arg __user *uarg =
> +				(struct fsverity_enable_arg __user *)arg;
> +		const __u32 max_buffer_len = FUSE_MAX_MAX_PAGES * PAGE_SIZE;
> +
> +		if (copy_from_user(&enable, uarg, sizeof(enable)))
> +			return -EFAULT;
> +
> +		if (enable.salt_size > max_buffer_len ||
> +				enable.sig_size > max_buffer_len)
> +			return -ENOMEM;
> +
> +		if (enable.salt_size > 0) {
> +			iov++;
> +			(*in_iovs)++;
> +
> +			iov->iov_base = u64_to_user_ptr(enable.salt_ptr);
> +			iov->iov_len = enable.salt_size;
> +		}
> +
> +		if (enable.sig_size > 0) {
> +			iov++;
> +			(*in_iovs)++;
> +
> +			iov->iov_base = u64_to_user_ptr(enable.sig_ptr);
> +			iov->iov_len = enable.sig_size;
> +		}
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +
>  /*
>   * For ioctls, there is no generic way to determine how much memory
>   * needs to be read and/or written.  Furthermore, ioctls are allowed
> @@ -227,6 +285,12 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>  			out_iov = iov;
>  			out_iovs = 1;
>  		}
> +
> +		if (cmd == FS_IOC_MEASURE_VERITY || cmd == FS_IOC_ENABLE_VERITY) {
> +			err = fuse_setup_verity_ioctl(cmd, arg, iov, &in_iovs);
> +			if (err)
> +				goto out;
> +		}

This looks like it passes on the correct buffers for these two ioctls, so if the
FUSE developers agree that this works and is secure, consider this acked:

Acked-by: Eric Biggers <ebiggers@google.com>

It's a bit awkward that the ioctl number is checked twice, though.  Maybe rename
the new function to fuse_setup_special_ioctl() and call it unconditionally?

- Eric

