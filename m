Return-Path: <linux-fsdevel+bounces-63613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3566BC62B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662733B1259
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1771A2E9EAA;
	Wed,  8 Oct 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyzIJDLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890914A0B5;
	Wed,  8 Oct 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759945180; cv=none; b=oVt6OIGQi+o6pTJOQWArkrBPeCbWG2tDXIQnCjBPQ76U9ZsHBdWm3deCVS46Axuf05oczBoiCWBI5Qi8vOoxlkLS9pkGZoD2bZz4H4nnvEnWuo2Fx4jueyXHpeC+Ujqi0sx+UKWjDx0H58dt4u/39be31w8QqmcTPeyfppAHUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759945180; c=relaxed/simple;
	bh=Esnl8ZWaEibgnNlQ6fecomOh+EHOtGe0pfO29l4m024=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z59EjsOJQ2UpyRawxU3ZN+LlTYnGIMB+NJ9qHnEzAsRyd8D2qbP2RtxLNgk8B3AKWfvKiNl21CEnNRYWwjfDbpus5IqHGyRxW9Vy6aX0RiTsoeGSpP8NYf1mbH3Pt8org+6JxYul+SxPQqnPUKWEYPkQY049v9nd3r2NLflev+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyzIJDLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49A9C4CEE7;
	Wed,  8 Oct 2025 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759945179;
	bh=Esnl8ZWaEibgnNlQ6fecomOh+EHOtGe0pfO29l4m024=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyzIJDLPt0VllgsHyLX8SnQyb8ZHWFsuRLKc1Ug1/LKSapbCZKTwDdpfdJSJ6ltgD
	 toY9+I7/+fQK5UOQDtlCCMUZw+uq6w7LeM0q4yfc2Gy0PNdCCFXWJkjEhhVTGMhDC5
	 G7byUV2rwMWtREYV3E6/HsW/oqVpzkF86p+9iUQMf2czAkR5BCM/vggGlFt5SB1wR/
	 IXeOtXCZlYoU18V4dcoioUEmRr4/7oGFqW6k6V4vWhC3Z6AX+7+aZYp54b2pHqNYwB
	 H/T+j2IBT0OVhaCVHmU7eYagzsSIL/GsLRytPrJsGNciJ5hMjGxh81Zbmi4JrCpMGy
	 tWKHp5Eb4NJAQ==
Received: by pali.im (Postfix)
	id 306A1680; Wed,  8 Oct 2025 19:39:35 +0200 (CEST)
Date: Wed, 8 Oct 2025 19:39:35 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Message-ID: <20251008173935.4skifawm57zqpsai@pali>
References: <20251006114507.371788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006114507.371788-1-aha310510@gmail.com>
User-Agent: NeoMutt/20180716

Hello!

On Monday 06 October 2025 20:45:07 Jeongjun Park wrote:
> After the loop that converts characters to ucs2 ends, the variable i 
> may be greater than or equal to len.

It is really possible to have "i" greater than len? Because I do not see
from the code how such thing could happen.

I see only a case when i is equal to len (which is also overflow).

My understanding:
while-loop condition ensures that i cannot be greater than len and i is
increased by exfat_convert_char_to_ucs2() function which has upper bound
of "len-i". So value of i can be increased maximally by (len-i) which
could lead to maximal value of i to be just "len".

> However, when checking whether the
> last byte of p_cstring is NULL, the variable i is used as is, resulting
> in an out-of-bounds read if i >= len.
> 
> Therefore, to prevent this, we need to modify the function to check
> whether i is less than len, and if i is greater than or equal to len,
> to check p_cstring[len - 1] byte.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
> Fixes: 370e812b3ec1 ("exfat: add nls operations")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  fs/exfat/nls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index 8243d94ceaf4..a52f3494eb20 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
>  		unilen++;
>  	}
>  
> -	if (p_cstring[i] != '\0')
> +	if (p_cstring[min(i, len - 1)] != '\0')

What about "if (i < len)" condition instead?

The p_cstring is the nul term string and my understanding is that the
"p_cstring[i] != '\0'" is checking that i is at position of strlen()+1.
So should not be "if (i < len)" the same check without need to
dereference the p_cstring?

>  		lossy |= NLS_NAME_OVERLEN;
>  
>  	*uniname = '\0';
> --

