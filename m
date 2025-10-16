Return-Path: <linux-fsdevel+bounces-64385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B14BE4EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 19:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23B34F000B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6182F20E032;
	Thu, 16 Oct 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xadaoygt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014E156230
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636904; cv=none; b=PyS7IMgqaF8Vr422jlkQO8Lz0hptnXSJV8BcJlMppCZe0UhRCj5LTtG+o/p4wewEvnIi/dA2Eb/jri98vkdEEf7HQWcL7mVsftZ3wEL+J2SvVCzx2aQepvbOdnxYUI6YtwBWxXxRWO3Bmgz0AqzkTcs3Bhbywm22LmhWAg43YUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636904; c=relaxed/simple;
	bh=7upAvWAt7gsAcm2AFBEOggupz5hjDzY6TflmLT+s1YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFB5f24CS3T9G9PgBE5tgmZ1SJw5Iyy8CGkbdB2V0L0AubYJ4dQJ9Jprv6pwts+bkh8rgHj5uS7UXwFKBwqo1n8VRJ1Mtm6qHzeQYrKJcKUjs8vDLQZZYf3sb6auoI7cAdE1TUKcVNE6NMZ8I9nm+HmyU7fjCm5NN6uK0PdZm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xadaoygt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B26C4CEF1;
	Thu, 16 Oct 2025 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760636904;
	bh=7upAvWAt7gsAcm2AFBEOggupz5hjDzY6TflmLT+s1YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XadaoygtKiosyJ31sUn/HNKMNTA2Ong0Iay0fm/a9g23Jm7Dgp25lqSxcZxRmR7xY
	 YjUWpPDIN2637atLt6h46Vq9HiicxIygpZI3V3lUXWtYiMXPSV2O41pOjNKScNeNBL
	 hXnlVzVa2RtQxysO6XVqiuTBvPfXHYuAk4+sZYnMTRwlkvc3J59tpAh4ayqe1hd7O+
	 bBHpCjAMV1Z4/2p2hCFv82wZsbLhCFEukaHCQCePJvw9ngH1Nawb113sFefnf5RN+R
	 RzM/tcO/tIYvtOWJOO7e2UBfRlsfNY25RrsSeLg1d4tYA6meK7jRYE68zbFpzB/gP1
	 vLl+lBMnwctYg==
Date: Thu, 16 Oct 2025 10:46:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Richard Fung <richardfung@google.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix digest size check in
 fuse_setup_measure_verity()
Message-ID: <20251016174651.GA1575@sol>
References: <20251016062247.54855-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016062247.54855-1-dmantipov@yandex.ru>

On Thu, Oct 16, 2025 at 09:22:47AM +0300, Dmitry Antipov wrote:
> Wnen compiling with clang 21.1.3 and W=1, I've noticed the following:
> 
> fs/fuse/ioctl.c:132:18: warning: result of comparison of constant
> 18446744073709551611 with expression of type '__u16' (aka 'unsigned
> short') is always false [-Wtautological-constant-out-of-range-compare]
>   132 |         if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
>       |             ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Since the actually supported alorithms are SHA256 and SHA512, this is
> better to be replaced with the check against FS_VERITY_MAX_DIGEST_SIZE,
> which is now equal to SHA512_DIGEST_SIZE and may be adjusted if even
> stronger algorithms will be added someday. Compile tested only.
> 
> Fixes: 9fe2a036a23c ("fuse: Add initial support for fs-verity")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/fuse/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index fdc175e93f74..03056e6afeb3 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -129,7 +129,7 @@ static int fuse_setup_measure_verity(unsigned long arg, struct iovec *iov)
>  	if (copy_from_user(&digest_size, &uarg->digest_size, sizeof(digest_size)))
>  		return -EFAULT;
>  
> -	if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
> +	if (digest_size > FS_VERITY_MAX_DIGEST_SIZE)
>  		return -EINVAL;

This breaks any userspace program that passes a digest_size greater than
64 bytes.  It's the size of an output buffer, not an input buffer.  So
it may be larger than the current max digest size.

Just delete the tautological comparison if it's causing a warning.

- Eric

