Return-Path: <linux-fsdevel+bounces-24717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7D7943F11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA8F1C20E19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7CD1DF67A;
	Thu,  1 Aug 2024 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsTjT4KL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E491DF670;
	Thu,  1 Aug 2024 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472547; cv=none; b=Wbu1W1fr9vUu158aX7qDcHN4QJfn0OHxTv5WQ1+xu2WoVC9MOs/CYxd+zpKdhhlDsrt3vgC2yLiLv3jZVeuIatK+T5ekIjmlOu9RDXqXx71l5ffHfJanK+YDOVDCO3MsRjptt+rcWgnHToKH+RvKa/b6NSu13+LjWkVPP7yFyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472547; c=relaxed/simple;
	bh=jt2M6uKlVM+6D9K08NlH1Z0lyga8uYkwNRpGb5zPdYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKoS6hND4DIs+WMmIN7fhdas6I28tdVrxsaH04OI9qmJ+7oVO/nsY6D/pJJKrTbb9LnvaycRZEiccKdfUDowJ4U9QnxgsiPbry2Nyut+6Ji9q4D7m4I4NYmq4hZfEz+UQIqHO3gFiOc8YatgUkhfVqkGjAhwUqYMsSleShT3eMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsTjT4KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000E0C116B1;
	Thu,  1 Aug 2024 00:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472546;
	bh=jt2M6uKlVM+6D9K08NlH1Z0lyga8uYkwNRpGb5zPdYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsTjT4KLOri/dPK+jcxFdX0lJ4rd6GimJhHyURvpow3NXHc+2MlyzsVIBLBY7pNyf
	 zZozU2xv50qCbNv+9rK/iLY8xi/oYIsBXYem/KKWu11px5wyeC5Fp+ce7sTgHjq4pi
	 8Dv3tQt0ckokEhMj9KuPIr3mT4XRoj4L/skfiMs9TZTVs2r4XSRiC1U3x79ASJLq7S
	 ea+0PHBZdm8RYog4Iwz1IZsSuGUzfXElYwcy7/5Ht2gTbLPJgSCKS32nVYzt+TcrYY
	 BpVtwyzI+opzkM2vfAv0wNdXg16KF5MaxUVdtdOP/AgA/LIYcz5Y+aFvpsP70A10aN
	 BzNNDkZweot5A==
Date: Wed, 31 Jul 2024 17:35:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Richard Fung <richardfung@google.com>,
	Eric Biggers <ebiggers@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] fuse: fs-verity: aoid out-of-range comparison
Message-ID: <20240801003544.GA468777@thelio-3990X>
References: <20240730142802.1082627-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730142802.1082627-1-arnd@kernel.org>

On Tue, Jul 30, 2024 at 04:27:52PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang points out that comparing the 16-bit size of the digest against
> SIZE_MAX is not a helpful comparison:
> 
> fs/fuse/ioctl.c:130:18: error: result of comparison of constant 18446744073709551611 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
>             ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This either means tha tthe check can be removed entirely, or that the
> intended comparison was for the 16-bit range. Assuming the latter was
> intended, compare against U16_MAX instead.

Presumably this check was added because of the addition in the
assignment to iov_len, which is size_t, but I don't see how that
expression could realistically overflow? It seems like this whole check
could just be removed?

> Fixes: 9fe2a036a23c ("fuse: Add initial support for fs-verity")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/fuse/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index 572ce8a82ceb..5711d86c549d 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -127,7 +127,7 @@ static int fuse_setup_measure_verity(unsigned long arg, struct iovec *iov)
>  	if (copy_from_user(&digest_size, &uarg->digest_size, sizeof(digest_size)))
>  		return -EFAULT;
>  
> -	if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
> +	if (digest_size > U16_MAX - sizeof(struct fsverity_digest))
>  		return -EINVAL;
>  
>  	iov->iov_len = sizeof(struct fsverity_digest) + digest_size;
> -- 
> 2.39.2
> 

