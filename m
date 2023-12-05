Return-Path: <linux-fsdevel+bounces-4836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D254F804A30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B96B20A7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3912E53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMwnuQx3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF96AC0;
	Tue,  5 Dec 2023 05:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72309C433C8;
	Tue,  5 Dec 2023 05:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701752635;
	bh=vtT7bl38gEnsHRMN1TYd7JwRxYZi5DGpaZuoozZO+sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMwnuQx3DuHJ2n0XbyecJgWaVT+ffZzpdibX17Cizq4eiDErdba2QcbGggt1mVbfL
	 2UhnNBxMaOUuI4U/yjf0BLjJlfGdWne7aq3+nsbH+dTE/PcLzjBopquCGXd2NKUTXf
	 VZX1PbpS2rXz2M53QqHs8URv1UP9OTjuh1kc72Auj8M9xjpYe+XA7vss74+mLTRwjH
	 k0/DvUvWZ0t3hpQQ0IMdvveA9H8WtFU5j7k9jlWyMZjbdzrFzktWDMSQTnDAMUz22V
	 2w1Buh1n9kE2n5xtsE8i3XUsUFMl0g/NPYdHYxYvlczkWLuXweErS26NSAZuIoweaS
	 lacWzi/LlP5Rg==
Date: Mon, 4 Dec 2023 21:03:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v4 06/46] fscrypt: expose fscrypt_nokey_name
Message-ID: <20231205050353.GH1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <5e180dc6cef80ab6997d5f4827ac1583123a5074.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e180dc6cef80ab6997d5f4827ac1583123a5074.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:03PM -0500, Josef Bacik wrote:
> -/*
> - * Decoded size of max-size no-key name, i.e. a name that was abbreviated using
> + * Decoded size of max-size nokey name, i.e. a name that was abbreviated using
>   * the strong hash and thus includes the 'sha256' field.  This isn't simply
>   * sizeof(struct fscrypt_nokey_name), as the padding at the end isn't included.
>   */

The above change seems accidental?  Note that while the C identifiers use
"nokey", in text I've been writing it as "no-key".

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 5f5efb472fc9..f57601b40e18 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -17,6 +17,7 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/blk-crypto.h>
> +#include <crypto/sha2.h>
>  #include <uapi/linux/fscrypt.h>
>  
>  /*
> @@ -56,6 +57,42 @@ struct fscrypt_name {
>  #define fname_name(p)		((p)->disk_name.name)
>  #define fname_len(p)		((p)->disk_name.len)
>  
[...]
> +struct fscrypt_nokey_name {
> +	u32 dirhash[2];
> +	u8 bytes[149];
> +	u8 sha256[SHA256_DIGEST_SIZE];
> +}; /* 189 bytes => 252 bytes base64url-encoded, which is <= NAME_MAX (255) */

I'd be tempted to just change SHA256_DIGEST_SIZE to 32, which would avoid
needing to include crypto/sha2.h.  The size is effectively hardcoded anyway, via
the 'u8 bytes[149];' field.  And it's not like SHA-256 will stop being 256 bits.

- Eric

