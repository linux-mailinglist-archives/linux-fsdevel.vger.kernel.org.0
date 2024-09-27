Return-Path: <linux-fsdevel+bounces-30294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7E988CDC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 01:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86893283332
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BD1B655E;
	Fri, 27 Sep 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFKk7Q7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F218754D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478518; cv=none; b=f5AYE4hoEkjVEYu67TlCS7VctGm7FqDCjmhtBmcVUQrk1CVJIEKe+vuYyVG0hjoSr2uRK1TjATJSZyC9blYbqPgV58lnRqrmFx7aEgCaT8IGgDlcxjJJtBg9VNR1wCZlCmcWtj6MfsaavJjg0JW3idMBlLIVylNP6ue+E0w+0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478518; c=relaxed/simple;
	bh=8ecqNjxNXTJke8Vuq3cO539K0qT0x6PYUdm2385tYeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoBEFUtbSdH362zCO8IE9j0PvO4oc8//cTBx4Zaaa5lGiVwS7UHSUi6+qrkN1DH/OKgcZWZonVFIdLdoGY1eXZnU0C6PQHfUJueo3hueMgEuVAH//LX9lVylC2zshs3jeEfZjgQ2JKUJkP0cx2419qIu68TAgmpQkBezxbsIQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFKk7Q7z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4585e25f42bso21705731cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727478516; x=1728083316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYh3/vS1rGM1ddYYsBLSAcCWWhx+jA4Rf0cWAiBNXEo=;
        b=NFKk7Q7zIZEoMkxXJWWMFT1TEdxtcL4VVWUUO97bAaPLtq258BCtBVU+A3YGRydven
         MZ18hSpufT5yx+Lyjhz03aj4xAqDY3xcJTW9VaswlIcxOrFBUAHOlRpY0gJACeQAwoZM
         5gkP2SSJWCS6yOBj4qVkx+j77KKbmvt2vC3CQiSI73CKg/QIFGPwSyB3tnCcoSJJ76n3
         B/qljZ9cHfX0nE1ukTnsS7fnZ58vkngsBpGndSMfSw+ebjtdjUUyVsN/DrhXqr26HyXp
         atJz2pX+MK61DaKLqYmr6TUO6EN0q3rdUqgX1m1is9eBp9QCC1MJMlgL55onaE6V4Fir
         q+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727478516; x=1728083316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYh3/vS1rGM1ddYYsBLSAcCWWhx+jA4Rf0cWAiBNXEo=;
        b=J9nLX751d7ByYHL2af6ZDwFcH/iUmc4t9CLt0X1mbkMKp2pg6b9GiwJ4KVJDK5bLDE
         CWiw+UiZSZK4vT0nGNn7fSAq1Unvu+7a64NWnodlMMDrtjynDK0/1Yx/r+4YkyN6Ivye
         OFwd8M2KSz/Efd0YwT/x1gDywKbkCHuhLpix+LQxQLomnC0RCP83NsmO1A/EIjVMYBXS
         FVuZOyOVc4k0Cci7508RVZ5jbIeZmTKwjZ2LzowASy9RMQr/jggCa2QAfzWU1LL1NCnV
         Jg5xWgvtBOvptxbankm5qX0uh3b98XxRyfT2L+Gpag64qCMgHUzEZJHNAaFUY6GAcY4R
         apaA==
X-Gm-Message-State: AOJu0Yx2BQL+xT4NfluNut793LPDbkbyCmJVFliNiXPmGZr4tmDfAqqr
	6fXt+rwGJR7Exiic671vEtO+wrmmrvZH1ratAnxkLU5/pLPyMydZYTfBjXHWD2U5OKioK3tirR3
	22gDd8pBjcUtYQWFWLZplG6SfYTk=
X-Google-Smtp-Source: AGHT+IHRVnWFn7h2fM43wLpeHBwbwXmJr3P/dIUmkDhQ8aaUjNP9ZFQY2HzRD+DvYXo/Ixk9K/Z+kLBGJ2Yk6VN6nIM=
X-Received: by 2002:a05:622a:15cf:b0:458:5161:e0ca with SMTP id
 d75a77b69052e-45c9f284d7emr69539371cf.41.1727478516018; Fri, 27 Sep 2024
 16:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <877bb686a99010b19778570591de923296626896.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <877bb686a99010b19778570591de923296626896.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 16:08:25 -0700
Message-ID: <CAJnrk1Ycs4AyckntkfzWqNHS=fkJQxRpqgNYOjEv0yABx6psVw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] fuse: convert fuse_notify_store to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> This function creates pages in an inode and copies data into them,
> update the function to use a folio instead of a page, and use the
> appropriate folio helpers.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 4c58113eb6a1..5b011c8fa9d6 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1654,24 +1654,28 @@ static int fuse_notify_store(struct fuse_conn *fc=
, unsigned int size,
>
>         num =3D outarg.size;
>         while (num) {
> +               struct folio *folio;
>                 struct page *page;
>                 unsigned int this_num;
>
> -               err =3D -ENOMEM;
> -               page =3D find_or_create_page(mapping, index,
> -                                          mapping_gfp_mask(mapping));
> -               if (!page)
> +               folio =3D __filemap_get_folio(mapping, index,
> +                                           FGP_LOCK|FGP_ACCESSED|FGP_CRE=
AT,
> +                                           mapping_gfp_mask(mapping));
> +               if (IS_ERR(folio)) {
> +                       err =3D PTR_ERR(folio);
>                         goto out_iput;
> -
> -               this_num =3D min_t(unsigned, num, PAGE_SIZE - offset);
> -               err =3D fuse_copy_page(cs, &page, offset, this_num, 0);
> -               if (!PageUptodate(page) && !err && offset =3D=3D 0 &&
> -                   (this_num =3D=3D PAGE_SIZE || file_size =3D=3D end)) =
{
> -                       zero_user_segment(page, this_num, PAGE_SIZE);
> -                       SetPageUptodate(page);
>                 }
> -               unlock_page(page);
> -               put_page(page);
> +
> +               page =3D &folio->page;
> +               this_num =3D min_t(unsigned, num, folio_size(folio) - off=
set);
> +               err =3D fuse_copy_page(cs, &page, offset, this_num, 0);
> +               if (!folio_test_uptodate(folio) && !err && offset =3D=3D =
0 &&
> +                   (this_num =3D=3D folio_size(folio) || file_size =3D=
=3D end)) {
> +                       folio_zero_range(folio, this_num, folio_size(foli=
o));
> +                       folio_mark_uptodate(folio);
> +               }
> +               folio_unlock(folio);
> +               folio_put(folio);
>
>                 if (err)
>                         goto out_iput;
> --
> 2.43.0
>
>

