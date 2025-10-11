Return-Path: <linux-fsdevel+bounces-63835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E3ABCF02D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 07:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FC43B9953
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 05:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB221255A;
	Sat, 11 Oct 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3cKBFZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6D3D6F
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760161250; cv=none; b=fI8XcK3Qu2VL7Mw2qKYEo7SpUyFTZhdwBz/+rOZRWOUck1uGviWZFSuo7HLLVFskioFAOJY771HM7YwXcl/QQ31xWsCubDltbsih1PniRfK1IRJ7Xp0pUUmljSBDCsfPoyuONCn1W0WEjt5kj/w64XFORN4wvXeDPS544vM6JTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760161250; c=relaxed/simple;
	bh=T/OaJx4B2ofWilBB1mLklxLkAldO5M4FQFGMkHFdTxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMQJFMhVW3ZfaE2hjy3P+OeP1iKw3KAAZj1Mf06PYLtmITBBUVcSry6tS0Tl8EO2yduvKXO9/anz0noQtMO73TikV+aFeJWiiy+NvwVFGxe31Zo+EQXTwJQpQJt6g8ULyzXWLkpSerVI9PlQjCIL8UG7IGKGQ15F3JtwQBnxliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3cKBFZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7C1C19422
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 05:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760161249;
	bh=T/OaJx4B2ofWilBB1mLklxLkAldO5M4FQFGMkHFdTxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e3cKBFZ07hVB1BlmhR+xPWewcZDpmINGh8tqggNfG1FNoEo8QAN3Cv9yp4HZd+ctU
	 vkdwRoE7CCyetGjNzkZnIrRBFBOW4j/0RceYNKlxpsal9oasToji+kdIy20ch1ubzY
	 /6sT77S0NPA5IzVJIuJte81EKelproUOCIMk7iTTWnenVY8Rnc30iznY5ihTEqCmcz
	 vCbtTjBd9Xr+Z8y0f/s+5h4mzBzMc3uqxWUwVQBNMnbS6A4L4B50qKvH/nA+C4+sEI
	 xWwHXSgl+dArQzaZ9JKbw3XoEyzfG5m0sviZC7ajGj2idCp68zx7mDXXdpHzXHoYa2
	 3dz9SryHzxy5g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso5233465a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 22:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWu/aJMctPLGYPhhazChurgGmW+bWQETihcIwUwHxcWVs9iNAfUktEh/XemDoWnpGp+VCY8J1nEaXXpygdX@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWnfqJWBhfGEdx0cxe8WA4PbdWhkmBrndz8R3xXM1vmFrHKzc
	6IHyUmQkjV/s9qd0hlm0g2xQ9ZLmcN8lrP40S0mypmVkIkyzQTxECWdYeDHsssV/eNVktcb7lzP
	wx+7gBI/TLKEyJU+4IjEVYLpJXjlrQSU=
X-Google-Smtp-Source: AGHT+IHGFXcBh1CoyxVP4/hzKESUFhziOwWatSeeN63Jf10cafnamrVulEc/CTbph30JLZDB0UYefY2NTdg+f+nHvRw=
X-Received: by 2002:a17:907:843:b0:b40:98b1:7457 with SMTP id
 a640c23a62f3a-b50ac5d0901mr1322157266b.47.1760161248247; Fri, 10 Oct 2025
 22:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010050329.796971-1-aha310510@gmail.com>
In-Reply-To: <20251010050329.796971-1-aha310510@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 11 Oct 2025 14:40:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_2VUniUHgstfATfdjDfLokqfjCGm+P=_72EPM2HEi0Ew@mail.gmail.com>
X-Gm-Features: AS18NWBP7_cWe4oXpv4egI6drs7CniIntrFvTm1Ghw2MALfSovJDtjjgW0l3WRY
Message-ID: <CAKYAXd_2VUniUHgstfATfdjDfLokqfjCGm+P=_72EPM2HEi0Ew@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Jeongjun Park <aha310510@gmail.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, pali@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 2:04=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
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
> lost, it should be modified to check if "i" and len are equal, rather tha=
n
> dereferencing p_cstring.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
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
>                 unilen++;
>         }
>
> -       if (p_cstring[i] !=3D '\0')
> +       if (i !=3D len)
>                 lossy |=3D NLS_NAME_OVERLEN;
As I said before, the core problem is passing an incorrect length in the io=
ctl
FS_IOC_SETFSLABEL call. While your change may fix the symptom,
it doesn't fix the root cause.
Furthermore, NLS_NAME_OVERLEN macro is unnecessary.
That will result in different errors when creating a file with trailing per=
iods
with utf8 and the other iocharset.
Please remove it and make the same error handling for maximum length
consistent with exfat_utf8_to_utf16().

>
>         *uniname =3D '\0';
> --

