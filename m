Return-Path: <linux-fsdevel+bounces-30859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A398EE90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6610283864
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676EC15573B;
	Thu,  3 Oct 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps3M+oYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BA153BE4;
	Thu,  3 Oct 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956496; cv=none; b=K2xsWZn63i52V5Wi87XlATZGpyZAs9ezdf002PXTV5boLT/ufiJK9Dn5p82ePztfWEc0emGCcUfobol6ANgIxq4tOiw5NhyA2xXxtNjgy0xltVNz+GSpjskaAxnPzCb087FXSFCUfpCZ8UxzrI8EehrQpf7yUG04obGn3o9aLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956496; c=relaxed/simple;
	bh=P8eNBDWVtzOMU2dzORz7tnQpI5eec8Q+7oxATEblvAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boukKuL5ufoGk88iqg3qpvK0syyIHrcJwggFlzKF9q243cxjs3ML1BJ4YpozAwaRrgfOBnZ4i+mNGYQ/xVJubLhYbl4DCPb/ofdp1ver/SUAcnHrn7gttT8bZGdY0XGztwHvIFEoAi8PyhUuvM9cK2e9dlmBY/2gLWFiArWCHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps3M+oYL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53994aadb66so820822e87.2;
        Thu, 03 Oct 2024 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956493; x=1728561293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxy0+phAIfClp/v+IJA18wQYVoxZOy+Eb6ccP7IJ4Tc=;
        b=Ps3M+oYLVVEitH/7piLVW/jHJ5U6OXF1w7iqnbuct4yD0gvEu8JLo/a++1I+cK9t9u
         XiDXGc3sfmppeAHH0s3UwEs6TngMMtHeSaYRzl92hKvj2xyNvfRCPYXIRpK3T/BvA+18
         B8grt4WRxsJFFJMl6VIAjC+uu0IXHOG/C0eJua2FGOCmnLmkfQNdCDmit5QVM7DvsvZN
         cUDC2g9xIeZbh//VfTCgeB+z2J6r7UJLdpf2ejDTUsnu93NKDgiiRmqqMvXYlgHVtrsx
         v7C4wggZSnSElp0c+b9/8JWrxDHyaEfF5ItXRWA53pGJurA5RjRWEgZG4p7Amiwci5Yt
         gC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956493; x=1728561293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxy0+phAIfClp/v+IJA18wQYVoxZOy+Eb6ccP7IJ4Tc=;
        b=uYBe0PmOBTkZHSBcZgHzxRCNY61UcYajfzEkc7BOXR8r9+hAs8mKpCF0pXa+VvZJ3L
         2X8WI3BOhikfspsrPxHjDRXypzi2e/yeYVNvkfRQDuAGPNERHTB7sw0s8ltSaoAP0uof
         Xdr+cczkUna+AtuMcIwjIs0WkgVMSByqQlLkTai9MpTjKX81Kkw1aj/CN0HGKAc/wAMO
         nkxnqfzDSmeFwvYBvqZpOT2HgIDmWBZ1IgxVQ1363sRFgg+DCwV7P4UEFRHwl0d0J+7v
         XqzjQ9lm2WDrztiFipmj1xwjUk8t84rI2rKfzE7l2e6ma4Y3iUmjZZoTmnFHEi0gtG2l
         gerQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfHg0jwAzLoGWaaVlWf5OEXQ3VZ7gcXlx2oUQlCB0eitwX00/xMaztFE+4KrrMcr19KhG7jEsviWWK3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyexDoJZGeikvj7c6MhbOYpAQ8iK/rZoAma2x6OmB0BleIPRhBm
	BIUWBwzMLde2tBlpx2yWP1bTgKP4HRhZhnZQ0M7qe9k3LQQqbeuTCQs+dTxqr457w+SOa9S+qWW
	8bcgfjAPZC0YkN9Z9ncn7mKTa368=
X-Google-Smtp-Source: AGHT+IG6uqZJZUHD3+1xov5WaxdgGADThoaRSsOjeqB5KCIq0WCGL4WkZtMvonVRG7U3Ly71QQbsHD7vyV+vP5WqI78=
X-Received: by 2002:a05:6512:158e:b0:539:8847:d7e9 with SMTP id
 2adb3069b0e04-539a0683412mr3846830e87.35.1727956493063; Thu, 03 Oct 2024
 04:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002150036.1339475-1-willy@infradead.org> <20241002150036.1339475-4-willy@infradead.org>
In-Reply-To: <20241002150036.1339475-4-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 3 Oct 2024 20:54:36 +0900
Message-ID: <CAKFNMokLUW16GJQNT3q9BPMUEbwPDvj6MKc=qCO4ZbUmGjo4Ww@mail.gmail.com>
Subject: Re: [PATCH 3/4] nilfs2: Convert nilfs_recovery_copy_block() to take a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:00=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> Use memcpy_to_folio() instead of open-coding it, and use offset_in_folio(=
)
> in case anybody wants to use nilfs2 on a device with large blocks.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/recovery.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
> index 21d81097a89f..1c665a32f002 100644
> --- a/fs/nilfs2/recovery.c
> +++ b/fs/nilfs2/recovery.c
> @@ -481,19 +481,16 @@ static int nilfs_prepare_segment_for_recovery(struc=
t the_nilfs *nilfs,
>
>  static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
>                                      struct nilfs_recovery_block *rb,
> -                                    loff_t pos, struct page *page)
> +                                    loff_t pos, struct folio *folio)
>  {
>         struct buffer_head *bh_org;
> -       size_t from =3D pos & ~PAGE_MASK;
> -       void *kaddr;
> +       size_t from =3D offset_in_folio(folio, pos);
>
>         bh_org =3D __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksi=
ze);
>         if (unlikely(!bh_org))
>                 return -EIO;
>
> -       kaddr =3D kmap_local_page(page);
> -       memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
> -       kunmap_local(kaddr);
> +       memcpy_to_folio(folio, from, bh_org->b_data, bh_org->b_size);
>         brelse(bh_org);
>         return 0;
>  }
> @@ -531,7 +528,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilf=
s *nilfs,
>                         goto failed_inode;
>                 }
>
> -               err =3D nilfs_recovery_copy_block(nilfs, rb, pos, &folio-=
>page);
> +               err =3D nilfs_recovery_copy_block(nilfs, rb, pos, folio);
>                 if (unlikely(err))
>                         goto failed_page;
>
> --
> 2.43.0
>

This patch looks good to me.

One small thing: with this conversion, there is no reference to the
page structure in nilfs_recover_dsync_blocks, so how about changing
the jump label "failed_page" to "failed_folio"?
This will reduce noise when searching for "page" with grep.

Thanks,
Ryusuke Konishi

