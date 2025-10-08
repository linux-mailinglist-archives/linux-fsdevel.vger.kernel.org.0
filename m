Return-Path: <linux-fsdevel+bounces-63577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D867BC3F26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 10:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 960C23514FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584282F361E;
	Wed,  8 Oct 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7m4j1ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B62F3C23
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913580; cv=none; b=I9MJP8H9baUM3hNypfFrYS+XrkvYEgCorHmgK6eMxwxdMBB3IeSmRgErit+J8qYn1FGK4PbTKtH7QNGbn1wd4voyrnVpjj8K/rE5KeTITnnv2uS6ewczyxR1GSWFX8/LIng5DzztbJyQX6RxfxDKeMc9VUD0ZrRGFBk71/pMxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913580; c=relaxed/simple;
	bh=AYlPlEYnalDPu3mU+G9COpLgD9gYXaXXBqfIzZI0NhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjUBWidnpHZ3oZYHpyzHidIspfH/F7sLHLZTteAEg0xEYT/JP58Q5k+wCHxqHb4sRnaCEuvMynVWd64MQm67aOR7NuvCoeoj/hkTG0sQhV3VMy93NQtkT5n/F+BKdzfw3gX9t+b4SlTnEGac+oVbhN5T31fyOU6IsllJ64d1ddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7m4j1ko; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f8986so70083515ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759913578; x=1760518378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JRe+Ysw3ed28Q5I6fD0FZJYvYHKIT6y/Zbw+MVV2NU=;
        b=X7m4j1ko+GpgLoWu+E+qXVENFgOVjCRRloSPKiko6o29gjI+idBHM/4+NvTbmMKc4S
         wrFJXQH9CUiYZvRRlTyolb+oCtzCgDKGB7S+9C9WLiAbT7D7eaebtGfECTSV1MPosw/x
         2eMtxarrphPZdU7R3Dc8+laGMb1KIcYliI6dprrV3QeP6GBrCSieQPFgBL0oqTGwI/ub
         7FciQBAG9qJf8ldOY8p4XfO+AvwUmE5IF39m+qW+D8/xnES9N6x5udqZu//0b/iF1p9k
         8ryrlxJ0kRVxGRokOTkH+zjIO8cedVeApFs6zGM4eGB3Pwjj6tWILyMMEbR3DKCNd9mD
         ZT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913578; x=1760518378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JRe+Ysw3ed28Q5I6fD0FZJYvYHKIT6y/Zbw+MVV2NU=;
        b=XxJjjdB67Z7ek3ryryIbfT6NWZg7WMMBp7lkrRXF4NDHL7el4TETijbRcq+0tP5IyU
         oTmh1CaPVk4WDp27xqXEif5yJJWKrUGDhaDfjzyvVKbZsJNL4SVOH/Rq1T6VugeFYar4
         3nkks0yMSth1k5AjJdnck0xyzts4N29LblojJSFQ8KgD7etXqjt6qH4+eCmgbNpwNF3J
         iSUQmvxAibxZOTeSJbzaJZr2KN7NSuuGrD3M7bVsuB2jR7QH0hoWwH9N2l0T5eESQsL0
         A5qh6QlJ9J7X37TqO/0MZJGj1KId85MkuHvWD7JHnA5iP+YWH1e4P8OoEEIbh0cBIjlg
         Pm1A==
X-Forwarded-Encrypted: i=1; AJvYcCUUoCGtxTroeDiNWu9Pj8zgruMcQRUY8O+i4NCv53o4WpuXEydrByZt8c0lF3v1G+150vTJ+8QRG0zD71LC@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMLco3oGXVdAsAOB0HENrXIn/dXTHooVcz0xfASKFLN+R6UPu
	szqAOqqSGZINVBgm6UQTRVpGbxdtDWuyTza8Edr5mugDrVBAQfOT3DzpF7vFZXSZbK0xREvetru
	gaEm/ThojlKHLSRYPt1MF6IxyhnIXFgU=
X-Gm-Gg: ASbGncsfEAoP/JQ5Jyw3qaJPE0mpEOaW07d2+/7rLPZ1RdZe0bPbU3UPr6Yi6kgLhuK
	Iu9x0ozwmUFE9XmE4nyyLOaCSPc/GUIx0GT+MOMtAANEviEjUfsG7KrkL2zGrC2exgZR0XP/PDZ
	t6PULMHUJWCzeDPmyl1E4bFiPFmxvvUVdxwbkyO+v2XTSc3VeX76aOtrcqDNSRHyYlK+Uj38Ql6
	wWdZgK0g/gNU77RUteDOo+qymmb5J2W2m/ZNrH6MffV
X-Google-Smtp-Source: AGHT+IFKCMDzVKeMBL64zSYDRpRFM0H2rB7wq31qh9YFT8+du8n/p0Y5R8iH/2zbH4uxiGTK7bY6Wyb/b/TqjnRgSmI=
X-Received: by 2002:a17:902:f607:b0:25c:7434:1c03 with SMTP id
 d9443c01a7336-290273568e4mr34433325ad.10.1759913578515; Wed, 08 Oct 2025
 01:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006114507.371788-1-aha310510@gmail.com> <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
In-Reply-To: <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 8 Oct 2025 17:52:47 +0900
X-Gm-Features: AS18NWC61Zud4JgwiWJjoS2O6q9aZLnXpBR98-miFbKRgAfyGTqcKi4hwMhR8L4
Message-ID: <CAO9qdTHx-EYBeo1mfgVzcwQT5M6iwtVsBZTjAEVQugcfTsVtjA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, viro@zeniv.linux.org.uk, 
	pali@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> On Mon, Oct 6, 2025 at 8:45=E2=80=AFPM Jeongjun Park <aha310510@gmail.com=
> wrote:
> >
> Hi Jeongjun,
> > After the loop that converts characters to ucs2 ends, the variable i
> > may be greater than or equal to len. However, when checking whether the
> > last byte of p_cstring is NULL, the variable i is used as is, resulting
> > in an out-of-bounds read if i >=3D len.
> >
> > Therefore, to prevent this, we need to modify the function to check
> > whether i is less than len, and if i is greater than or equal to len,
> > to check p_cstring[len - 1] byte.
> I think we need to pass FSLABEL_MAX - 1 to exfat_nls_to_utf16, not FSLABE=
L_MAX.
> Can you check it and update the patch?

If the only reason to change len to FSLABEL_MAX - 1 is to prevent
out-of-bounds, this isn't a very appropriate solution.

Because the return value of exfat_convert_char_to_ucs2() can be greater
than 1, even if len is set to FSLABEL_MAX - 1, i may still be FSLABEL_MAX
when the loop ends. Therefore, checking the last byte of p_cstring with
the min() function is essential to ensure out-of-bounds prevention.

> Thanks.
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
> > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  fs/exfat/nls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> > index 8243d94ceaf4..a52f3494eb20 100644
> > --- a/fs/exfat/nls.c
> > +++ b/fs/exfat/nls.c
> > @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb=
,
> >                 unilen++;
> >         }
> >
> > -       if (p_cstring[i] !=3D '\0')
> > +       if (p_cstring[min(i, len - 1)] !=3D '\0')
> >                 lossy |=3D NLS_NAME_OVERLEN;
> >
> >         *uniname =3D '\0';
> > --

Regards,
Jeongjun Park

