Return-Path: <linux-fsdevel+bounces-63575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B90ABC385C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 08:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27814189C966
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 06:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD74A06;
	Wed,  8 Oct 2025 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcKv5YBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF802EB87E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759906581; cv=none; b=jYG+CtbudSKkg7IXTdz2k9t5i5DJo+jx8Wj8EgqEoFiHHtDWXVPndBAZtJkgNiWfe8iFhPzHzng8b1aDVaE90FwqjO5GZ1oLspsqS3jw76fEJMo5TIVNGLTI83x77R1+rw0IZ1901jVjtBrOnuZdkyARR1kLXIB+eNy8/WeivWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759906581; c=relaxed/simple;
	bh=sYmJtnPIK7dPcICS0RFXNpoom+Swr58wH6UXsXIXIV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFVOYrqBwmEiICKmkPQcdpqsbgoERRRwAZBast1czW0Bn3GyT6tfQyemOsb57fXbwGibs4IdhQ9nQ3d5EvCG1cqTcn6iXVv3ebMoVrLOYBrTkmmWUIWMbEfV7tuHbY4ZwnqxXv51FEwNN7eoty+xyb0B8eGwI+CWNfeUUgyaHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcKv5YBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9720CC19421
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 06:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759906580;
	bh=sYmJtnPIK7dPcICS0RFXNpoom+Swr58wH6UXsXIXIV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UcKv5YBeoFquORtVxTbExHBg04mlDxbkyFgTu0Kkyk+UIXUK5pdynkdr7bu1/N3tg
	 9FJfbfPGddeLp/70ObY/f4vp1XqyzdOwynz5GFzSekp9UgfBsQ6vLZ5jAavtZpW7qW
	 5VoG5z1tjGF8RUCbESzj1aMaW7zV1LOoiwTU3uHevVtN+D0OtWCPDyN+5eE65h++6m
	 1fKcsTqtmj7y0IRwgIp6nefif3ai+/kad9+gu9CaQLVsJLHw96whgb0YsqpanUZCFp
	 BxvIN0fsAVrGVrE62EodTErjU+EXTG77j+zi5lIkvO4nF4lNBg1PXkkQN4U9j1kBEs
	 y8dFN6JkEL8Fg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6398ff5fbd3so6475948a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 23:56:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKkWmhnCrC4tOGGNz6ImDpKOGXwtSvwpZW6On+RbBaP5JNweWiXEVa6F0/jUhVgz836WLgtY6zj13XrtyL@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9bmBrv4pTyWu001VgUwotKF5sOdkQW5cTf5dG69QsuFU6WIv
	3jPaXguRV4hAK5zh5rbKoUqtQY/B/ExY+7SV0AtSNy0lv7ahGbAoNczXc86RAZl2whDzyWMzXiX
	CeeCK6HaZfWUzmolZBuBl31Jf/XNph+o=
X-Google-Smtp-Source: AGHT+IFss3JE8O+RIRAqixQEEDjegTvXXRCXuS71Xh1IU/NNvYrzdMjNqKL6UI8w0f4U4/7eQlaw3rawLE3rTOZMF0I=
X-Received: by 2002:a17:906:c105:b0:b3e:907c:9e26 with SMTP id
 a640c23a62f3a-b50ac5cfaf7mr239322766b.59.1759906579179; Tue, 07 Oct 2025
 23:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006114507.371788-1-aha310510@gmail.com>
In-Reply-To: <20251006114507.371788-1-aha310510@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 8 Oct 2025 15:56:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
X-Gm-Features: AS18NWBt4-ax8frC1iEO2ZNytLZMzrWDiVOFF6Qdq15mYbUfbImMgl-fSvih7Ro
Message-ID: <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Jeongjun Park <aha310510@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, viro@zeniv.linux.org.uk, 
	pali@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 8:45=E2=80=AFPM Jeongjun Park <aha310510@gmail.com> =
wrote:
>
Hi Jeongjun,
> After the loop that converts characters to ucs2 ends, the variable i
> may be greater than or equal to len. However, when checking whether the
> last byte of p_cstring is NULL, the variable i is used as is, resulting
> in an out-of-bounds read if i >=3D len.
>
> Therefore, to prevent this, we need to modify the function to check
> whether i is less than len, and if i is greater than or equal to len,
> to check p_cstring[len - 1] byte.
I think we need to pass FSLABEL_MAX - 1 to exfat_nls_to_utf16, not FSLABEL_=
MAX.
Can you check it and update the patch?
Thanks.
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
> index 8243d94ceaf4..a52f3494eb20 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
>                 unilen++;
>         }
>
> -       if (p_cstring[i] !=3D '\0')
> +       if (p_cstring[min(i, len - 1)] !=3D '\0')
>                 lossy |=3D NLS_NAME_OVERLEN;
>
>         *uniname =3D '\0';
> --

