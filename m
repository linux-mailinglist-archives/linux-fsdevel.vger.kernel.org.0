Return-Path: <linux-fsdevel+bounces-27378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727A960F22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F571F24282
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F21C8FDC;
	Tue, 27 Aug 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGtFWehd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA341C5792;
	Tue, 27 Aug 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770503; cv=none; b=Ti1/kyZCaZfQU/40VTZhQr78TVtp2PgW5FAXWadCMK9Y1+f+4rEz3YaNCCx8GRc/OfraMbAWiElGmALY5X9tWPZdhp1dyWZuKxiOnVVJ8mdd8/OQkwMUw4BrLndS7NrahRl63kEnam2bZSTBXx9kQJg9oPh7FnsHRXCJIAML5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770503; c=relaxed/simple;
	bh=vj2+uX4DyJ0X9AMUJ15fS1HOXBIX9BaNH5KrRvHAu/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyP7pQtCpTZz6w6aNNXGl0RMRnW8jd0ZxiaKljIyuZ2QHl04BdSUdoIwpacwh3txjGHd5cEUaQLDdvBG9Pj2N1m1H4zyWhmh5YGPAIhzmcOQbYK/pV1CdaQdGoMNOHeuyMqoAZfzGpFGHwqXxfHiBss0oKuytqLhmt+umhx6mkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGtFWehd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E225DC4E68F;
	Tue, 27 Aug 2024 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770503;
	bh=vj2+uX4DyJ0X9AMUJ15fS1HOXBIX9BaNH5KrRvHAu/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGtFWehd0bTpb75y/zS5e/LmeuBMzOVYKNzaCAsDKitMuRLwNVLEAt25mBRWrVGsM
	 W8dhQav+624/E0F9V5jNvGsHADmHXHvYFGmEluXyqPvNhTAtwsk7Kq67xW5iYEudFx
	 HFSAmeFRSvecEbCBrmXM+W55YADafc2pU4Jvx62hBlgNyTLrA0bAb2cp3YGNYrVi/y
	 KBXaqkjAYoMjAuG7krhZkXahXkjjOFwrMQa5164XsM9IP2U7EdhNaIEhhs0lhK61s/
	 yqFhyIuw+5/saH+J+LwETZouClWe1j8nsbPXhyTNDNa3uHWJQdzo3IvkMxB4zOkP19
	 HlwukIekMFF5A==
Date: Tue, 27 Aug 2024 07:55:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: sort out the fallocate mode vs flag mess
Message-ID: <20240827145502.GP865349@frogsfrogsfrogs>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-4-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:47AM +0200, Christoph Hellwig wrote:
> The fallocate system call takes a mode argument, but that argument
> contains a wild mix of exclusive modes and an optional flags.
> 
> Replace FALLOC_FL_SUPPORTED_MASK with FALLOC_FL_MODE_MASK, which excludes
> the optional flag bit, so that we can use switch statement on the value
> to easily enumerate the cases while getting the check for duplicate modes
> for free.
> 
> To make this (and in the future the file system implementations) more
> readable also add a symbolic name for the 0 mode used to allocate blocks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For a brief moment I wondered if it were possible to set more than one
mode bit but it looks like none of the implementations support that kind
of wackiness (e.g. COLLAPSE|INSERT_RANGE for magicks!) so we're good:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/open.c                   | 51 ++++++++++++++++++-------------------
>  include/linux/falloc.h      | 18 ++++++++-----
>  include/uapi/linux/falloc.h |  1 +
>  3 files changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 22adbef7ecc2a6..daf1b55ca8180b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -252,40 +252,39 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	if (offset < 0 || len <= 0)
>  		return -EINVAL;
>  
> -	/* Return error if mode is not supported */
> -	if (mode & ~FALLOC_FL_SUPPORTED_MASK)
> +	if (mode & ~(FALLOC_FL_MODE_MASK | FALLOC_FL_KEEP_SIZE))
>  		return -EOPNOTSUPP;
>  
> -	/* Punch hole and zero range are mutually exclusive */
> -	if ((mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) ==
> -	    (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
> -		return -EOPNOTSUPP;
> -
> -	/* Punch hole must have keep size set */
> -	if ((mode & FALLOC_FL_PUNCH_HOLE) &&
> -	    !(mode & FALLOC_FL_KEEP_SIZE))
> +	/*
> +	 * Modes are exclusive, even if that is not obvious from the encoding
> +	 * as bit masks and the mix with the flag in the same namespace.
> +	 *
> +	 * To make things even more complicated, FALLOC_FL_ALLOCATE_RANGE is
> +	 * encoded as no bit set.
> +	 */
> +	switch (mode & FALLOC_FL_MODE_MASK) {
> +	case FALLOC_FL_ALLOCATE_RANGE:
> +	case FALLOC_FL_UNSHARE_RANGE:
> +	case FALLOC_FL_ZERO_RANGE:
> +		break;
> +	case FALLOC_FL_PUNCH_HOLE:
> +		if (!(mode & FALLOC_FL_KEEP_SIZE))
> +			return -EOPNOTSUPP;
> +		break;
> +	case FALLOC_FL_COLLAPSE_RANGE:
> +	case FALLOC_FL_INSERT_RANGE:
> +		if (mode & FALLOC_FL_KEEP_SIZE)
> +			return -EOPNOTSUPP;
> +		break;
> +	default:
>  		return -EOPNOTSUPP;
> -
> -	/* Collapse range should only be used exclusively. */
> -	if ((mode & FALLOC_FL_COLLAPSE_RANGE) &&
> -	    (mode & ~FALLOC_FL_COLLAPSE_RANGE))
> -		return -EINVAL;
> -
> -	/* Insert range should only be used exclusively. */
> -	if ((mode & FALLOC_FL_INSERT_RANGE) &&
> -	    (mode & ~FALLOC_FL_INSERT_RANGE))
> -		return -EINVAL;
> -
> -	/* Unshare range should only be used with allocate mode. */
> -	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
> -	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
> -		return -EINVAL;
> +	}
>  
>  	if (!(file->f_mode & FMODE_WRITE))
>  		return -EBADF;
>  
>  	/*
> -	 * We can only allow pure fallocate on append only files
> +	 * On append-only files only space preallocation is supported.
>  	 */
>  	if ((mode & ~FALLOC_FL_KEEP_SIZE) && IS_APPEND(inode))
>  		return -EPERM;
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b167579..3f49f3df6af5fb 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -25,12 +25,18 @@ struct space_resv {
>  #define FS_IOC_UNRESVSP64	_IOW('X', 43, struct space_resv)
>  #define FS_IOC_ZERO_RANGE	_IOW('X', 57, struct space_resv)
>  
> -#define	FALLOC_FL_SUPPORTED_MASK	(FALLOC_FL_KEEP_SIZE |		\
> -					 FALLOC_FL_PUNCH_HOLE |		\
> -					 FALLOC_FL_COLLAPSE_RANGE |	\
> -					 FALLOC_FL_ZERO_RANGE |		\
> -					 FALLOC_FL_INSERT_RANGE |	\
> -					 FALLOC_FL_UNSHARE_RANGE)
> +/*
> + * Mask of all supported fallocate modes.  Only one can be set at a time.
> + *
> + * In addition to the mode bit, the mode argument can also encode flags.
> + * FALLOC_FL_KEEP_SIZE is the only supported flag so far.
> + */
> +#define FALLOC_FL_MODE_MASK	(FALLOC_FL_ALLOCATE_RANGE |	\
> +				 FALLOC_FL_PUNCH_HOLE |		\
> +				 FALLOC_FL_COLLAPSE_RANGE |	\
> +				 FALLOC_FL_ZERO_RANGE |		\
> +				 FALLOC_FL_INSERT_RANGE |	\
> +				 FALLOC_FL_UNSHARE_RANGE)
>  
>  /* on ia32 l_start is on a 32-bit boundary */
>  #if defined(CONFIG_X86_64)
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6cdf..5810371ed72bbd 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -2,6 +2,7 @@
>  #ifndef _UAPI_FALLOC_H_
>  #define _UAPI_FALLOC_H_
>  
> +#define FALLOC_FL_ALLOCATE_RANGE 0x00 /* allocate range */
>  #define FALLOC_FL_KEEP_SIZE	0x01 /* default is extend size */
>  #define FALLOC_FL_PUNCH_HOLE	0x02 /* de-allocates range */
>  #define FALLOC_FL_NO_HIDE_STALE	0x04 /* reserved codepoint */
> -- 
> 2.43.0
> 
> 

