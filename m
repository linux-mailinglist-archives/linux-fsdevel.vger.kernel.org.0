Return-Path: <linux-fsdevel+bounces-30684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48CB98D40C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE99B21624
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BC1D0412;
	Wed,  2 Oct 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmw6BTEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12F1CFECE;
	Wed,  2 Oct 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874730; cv=none; b=tf0Ev9yKSBa9TThqGHrRjURpUMQPikMF4kRHVvRIn7LuIEuGWUjeFZ+CutseaBDRUqLpb8XNFgCYGQ3rRJDuHmE8xcUZzANa7jZdAGAwNBP9M17ySZ00S5NH5nayNEqIm5RIkhKJI8N2Y7eiVItEctYX52ZGFrDMyDPm1HgHiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874730; c=relaxed/simple;
	bh=Ym9UaLXM7C6E1WASDUKQvHvYozxylcLdgBglCTwiyKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiZ8hgSXdL7GDaj54bQ/fulzKMf7mR1daRCF6ezv3xrU5TkLZQcUn3KaLI8Ua3OWSiXRHiJjqN4A/OTMfmqskfSPjnoCgL8OxlL9juHzyGS1vLNAnl+K0wQXhiHbp4ep9Z3fkajwmv6sEUjoCCR3zE+hHvp+tOT5y+5nTylbaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmw6BTEn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53993c115cfso4291390e87.2;
        Wed, 02 Oct 2024 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727874727; x=1728479527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4y8jBTmqmaQ765rlbFTfYn8ZR3POR7YKLh+55wd/zQ=;
        b=Zmw6BTEncXENhwcqhIKIdyS/MBlWGVHWmAEe9nA3dd38tOhIWXv8MlgMntezSOpVVy
         5oIvWTp00u/BG28Ql6dwsRjI/K+NiVsiMWKyrG4cJkb38TFbUAF7p2DkGRlAP+tPI2sz
         1ahVyVDINp0sSrKKNn+qxdkqhBTmwsh86p+qMYc4wPWm2s4xf3lMSLIqq2lk3emkWKOe
         KjdFVEWcNnRbnIWEa36TVB6HWrMUQmjke76ISuXrFLP/xj36sQY8kOR8dnauyYDVljkS
         rCUg90XKB/1JRrHUqilF+X0zwz1gOPeUbRTevaT2HSE0jVc8VgXHIuGcEdQU4ffkJpo9
         2JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874727; x=1728479527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4y8jBTmqmaQ765rlbFTfYn8ZR3POR7YKLh+55wd/zQ=;
        b=JA9co8YOpxhDVUBLJkumGVr+xthMbDi6+4ozG9s8AtsVfPgsbS3MR350+Zfg3LrBXg
         9xadI5H7m57hHgm5iFUdrzmG4ZR68nUmTgu+mLVDwHv4seuz/+SikjW59+/laLjkMhUj
         9AMDsKoMO+5mU8y0V6zO6UTr85EZmCiyrHrESLcYSZhttW+NAPSWkZrozjr8tHUmyJrC
         qkZ1UEV7St677XldtrM94t7pXE81Ml0xnRVSSMxgpWgjTKfaat0HFANYwpMEts25aglh
         1QqJ/NJdHKbEUMn+mkSH1UVG/d3orq2SeWynYvQpCFzyYRxmqLrOQTKK5KXdFNSeAsBt
         cdsw==
X-Forwarded-Encrypted: i=1; AJvYcCU45KG3icLQ6RK9HoiQ26gaou4xu/h9gFaT5+p7G3d846U5ZRcKDLnbYEKUOBw2rPtOPMhaaB6uQX8X@vger.kernel.org, AJvYcCVBn/g8KXcz2JkRMnFBtE0UBEJWC8ox2HYgu54GTHGsLefViudCKvFn+VyM4Vo9uAiSiTGsjABMfcvw7nlSeQ==@vger.kernel.org, AJvYcCVhYOO9ltN4IXNm5mxyg6lyngior6wpinVP3LNduR1Re0u3LPMTWvoiBEns8S0m8AR2zFonyqeQ47NLf2U=@vger.kernel.org, AJvYcCWXf8y2a25+EyeLN7haM2mxTL42ZeFkQzJnzyykWUmfOGpBo/0azeFrzbSVCVrUG9U4MnZEpRSBQOXaTmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/18Y1OtzCuJDkNHjAP4hkpVUuCSFlDTcDgspJ/uukuJ6pmBZ
	ky43A2ctMWFpjFgQVmFS0mvAlyqrZNB/XJYU4W947q4v8V3wX7KCKMsiRzpwLH1by66d8KRE5Dw
	sInIpe69mXom5TX/J/7MMWjfbC8s7K6Z2
X-Google-Smtp-Source: AGHT+IEOPzA+vTRDEoKgqlR/0QvjfCjz/hNyhuloe/dk3pCc6OsTIHbciHg7uHGZcLFyaYtf4p7q54Ugf5w8aF5NOvg=
X-Received: by 2002:a05:6512:e96:b0:533:711:35be with SMTP id
 2adb3069b0e04-539a06834aamr1720320e87.26.1727874726884; Wed, 02 Oct 2024
 06:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002040111.1023018-1-willy@infradead.org> <20241002040111.1023018-3-willy@infradead.org>
In-Reply-To: <20241002040111.1023018-3-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 2 Oct 2024 22:11:50 +0900
Message-ID: <CAKFNMomcfjrm7UaaoByu6Sg-ssRQPAA1gntssLR_ycRS9hyt3g@mail.gmail.com>
Subject: Re: [PATCH 2/6] nilfs2: Convert nilfs_copy_buffer() to use folios
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 1:02=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> Use folio APIs instead of page APIs.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/page.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index 9c0b7cddeaae..16bb82cdbc07 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -98,16 +98,16 @@ void nilfs_forget_buffer(struct buffer_head *bh)
>   */
>  void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
>  {
> -       void *kaddr0, *kaddr1;
> +       void *saddr, *daddr;
>         unsigned long bits;
> -       struct page *spage =3D sbh->b_page, *dpage =3D dbh->b_page;
> +       struct folio *sfolio =3D sbh->b_folio, *dfolio =3D dbh->b_folio;
>         struct buffer_head *bh;
>
> -       kaddr0 =3D kmap_local_page(spage);
> -       kaddr1 =3D kmap_local_page(dpage);
> -       memcpy(kaddr1 + bh_offset(dbh), kaddr0 + bh_offset(sbh), sbh->b_s=
ize);
> -       kunmap_local(kaddr1);
> -       kunmap_local(kaddr0);
> +       saddr =3D kmap_local_folio(sfolio, bh_offset(sbh));
> +       daddr =3D kmap_local_folio(dfolio, bh_offset(dbh));
> +       memcpy(daddr, saddr, sbh->b_size);
> +       kunmap_local(daddr);
> +       kunmap_local(saddr);
>
>         dbh->b_state =3D sbh->b_state & NILFS_BUFFER_INHERENT_BITS;
>         dbh->b_blocknr =3D sbh->b_blocknr;
> @@ -121,13 +121,13 @@ void nilfs_copy_buffer(struct buffer_head *dbh, str=
uct buffer_head *sbh)
>                 unlock_buffer(bh);
>         }
>         if (bits & BIT(BH_Uptodate))
> -               SetPageUptodate(dpage);
> +               folio_mark_uptodate(dfolio);
>         else
> -               ClearPageUptodate(dpage);
> +               folio_clear_uptodate(dfolio);
>         if (bits & BIT(BH_Mapped))
> -               SetPageMappedToDisk(dpage);
> +               folio_set_mappedtodisk(dfolio);
>         else
> -               ClearPageMappedToDisk(dpage);
> +               folio_clear_mappedtodisk(dfolio);
>  }
>
>  /**
> --
> 2.43.0

I understand the change.  Also, thank you for converting this function
to be folio-based.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

