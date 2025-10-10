Return-Path: <linux-fsdevel+bounces-63793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61FBCDEC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF865406E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB572FBE01;
	Fri, 10 Oct 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmR8skwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A200266595;
	Fri, 10 Oct 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112603; cv=none; b=gombBVSLSrZc87DWJcUayd+mqfrZr3FaT+BYaIQJ2dA0/4g235/gRCV48XAPB2EXHErTAkaBQ08og48wb8aFoJlsmGH18eMjTrkrJOFI3rSqEW9OR51wMltWgh4S+EtTfcOwZRdbOGzzArFcYksOyINDirZrrQG6Qwd8I1uPVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112603; c=relaxed/simple;
	bh=+467sjpUtpAmcgw6EnqNC3wdtS05FziNpH2+A71inkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIerS6nW6R7i0mBMjlYxdVqTKTAANdZt31LXkd0hanRE1RPwfOvPd1GisRA+BKpO66iFH57VunpxnsBf/dKfPz74813JfJgjVCGc4aBjLLflK7BfWd1oXDF1eWHCNCbAaLEflAk7jiJWc4rjBJWnaya04BrUyFmpyotVoVMhuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmR8skwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E642AC4CEF1;
	Fri, 10 Oct 2025 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760112603;
	bh=+467sjpUtpAmcgw6EnqNC3wdtS05FziNpH2+A71inkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmR8skwCG7R2zTgZH9aa+HccRKyvsbjD5ByIRUy0hRIDWpCACjve8dKSAq1/Z4TBM
	 wuN2bLDC1kzzBZBPHZ/HJZTUpybdOP1pz+0OCx1JkNwa0QZcscF9mxRvslUlEFBVdu
	 9kPF4UaaN0HjVXBqth2lR2UBILE+FRWj7V5MziR6zBOKNk888bB5JARjQ0ZoOdj8sy
	 5ju3YwB3TpXWhVQCmYS4RCo1fz92uV/Gp1i4Jk/RHS1imMWxgX/+RHACnBKhCT+CFk
	 D87sZCKWCUbtsQy8wFLxbm8HTVTra142I86CUXEEHceUGTl9UmXMnTAw1it+qx0QZ2
	 bB6X+/rV1ATgA==
Received: by pali.im (Postfix)
	id AA2B0723; Fri, 10 Oct 2025 18:09:58 +0200 (CEST)
Date: Fri, 10 Oct 2025 18:09:58 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Message-ID: <20251010160958.acejjdmr5a4ca752@pali>
References: <20251010050329.796971-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251010050329.796971-1-aha310510@gmail.com>
User-Agent: NeoMutt/20180716

On Friday 10 October 2025 14:03:29 Jeongjun Park wrote:
> In exfat_nls_to_ucs2(), if there is no NLS loss and the char-to-ucs2
> conversion is successfully completed, the variable "i" will have the same
> value as len. 
> 
> However, exfat_nls_to_ucs2() checks p_cstring[i] to determine whether nls
> is lost immediately after the while loop ends, so if len is FSLABEL_MAX,
> "i" will also be FSLABEL_MAX immediately after the while loop ends,
> resulting in an out-of-bounds read of 1 byte from the p_cstring stack
> memory.
> 
> Therefore, to prevent this and properly determine whether nls has been
> lost, it should be modified to check if "i" and len are equal, rather than
> dereferencing p_cstring.
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
> index 8243d94ceaf4..de06abe426d7 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
>  		unilen++;
>  	}
>  
> -	if (p_cstring[i] != '\0')
> +	if (i != len)
>  		lossy |= NLS_NAME_OVERLEN;
>  
>  	*uniname = '\0';
> --

Looks good for me,

Reviewed-by: Pali Rohár <pali@kernel.org>

