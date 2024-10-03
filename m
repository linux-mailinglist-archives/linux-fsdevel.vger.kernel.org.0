Return-Path: <linux-fsdevel+bounces-30858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF698EE85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26B2B21D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237BC156C63;
	Thu,  3 Oct 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF/smIYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB87156885;
	Thu,  3 Oct 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956305; cv=none; b=mImGgSmCS+b3cUhE8zg9Jp4myRNpRmdECpahnf3q3Hzxc/s2WTq85DqOzgyvo+dAObTEQIdPTi38RlGepHY7sycljCLWQGVe+XOdemyL4X/BAKgwb6uVKsGSDychsxtzMWfr7/2bh646DRPQ+PO9m87SO6rxnkj9eTEIRsZM3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956305; c=relaxed/simple;
	bh=CE7nNG51C6FeTTZw/ZBE+xT/oR0uJD4QBMk9e4oDudI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQbA/KmgsEcltIp8PvEExztLL5DW8Xsy1PoJiHdvbsIPbmdY2Nh/ZNbvV3oewWZdNFRtnHvi14TUfw8K/Nhi4+VWZqDb9U4U6nEMKW6fKSRTNPCdLYeSl8LOxVu8S/28aqGVgt2UV1Nk0rbljWdSceyFx1qkOnU4cHqbFtbCfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF/smIYF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so17733741fa.1;
        Thu, 03 Oct 2024 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956302; x=1728561102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHoupr0/kc4L7oGrZ6tJxNRor5ARaNvDgSroHEc/yPw=;
        b=bF/smIYF+9ZxO4XxSW1uFEav83VsCLMETHhPN4GlgeoGydcSZ9lc9f80A4nbCVnt2U
         Yxi2DPWH+VTmMvQVPQgt1QEexHi7sb89KMIBFqus4vzQxL4QXP+KVJrHGtmT1gSSmytE
         P2nXtwhI7Zp4N9oweIKNOxYbRo0fJ2DkbyrqiPZ0MILUVB1zINpzs+zkt2IHAcUliPYF
         u+eQURnNPgTGZy1dlfu2sj54OrsawjMeZXMDBXSS9hxX/HOKO8EKgdxMyHDDwHi5fmQp
         vtSzi0v1lMwTfvAChCKslpsX9IEzFaNK2MuOY3tOnzT4zE5IsmPg7U+8LOUcM3jNssuA
         e8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956302; x=1728561102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHoupr0/kc4L7oGrZ6tJxNRor5ARaNvDgSroHEc/yPw=;
        b=E5gz2Mv2cdDQ78Rb6AOopVw+Szu492G/3oha9Mqj4GWfc2w3V1IVnqsWiDkOKYb+ON
         FyHpXW7qeR4p+1JTLqmMFPgQdMQTAflg+bRWwkSyUz5DwlNH37qmZiQ+HInFx1NQV6gS
         7hdxL5+tUOe8W5pinbY06RoczecaHyM2onNrYdB5R2+pTqAP/w4xBBx6C6YGYC5zdmrk
         qlKUNz6CTS1JtgjMPzbuVAQ7FcLoszB3WnM3a0yGnYE/4DO4quW77VoBvmO4j8PSuTrE
         weafuSlIzEh/cPp1Je27tBsKibAQVIp/8jUb1g/oKwg2rf0f0tBEeLa1TPDrJsQUzlnu
         8klQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgBd2TVWkPlLokAzBYILsy3ZnWa5LD8wp2KPxPQj1Fx0ghBx421qy9aOGZ78nMgDktRWwF/fw1IsT0Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Xbw9HSX4g1CNAIhub5gWrK1uEzk1MXcVqZVlLypHN2SxSy0x
	Wtymgtnsf1zLHdEvcO2Dtqfr645wroDv9LST+3L1nv7vh0T+1C7bkqh0CFT+0hQt0EN1cveYmSm
	mOu0KopBi2dm7aQgjfXkJC90eAtc=
X-Google-Smtp-Source: AGHT+IGQpY303XxEqOQ/bacZLKkyfAaGZB10dyypbECrdl5KesyhJBV10e5GhVy5CHllXVyMfE9trDz8kOjJNCY/U1Y=
X-Received: by 2002:a2e:bcc1:0:b0:2f0:2026:3f71 with SMTP id
 38308e7fff4ca-2faea1db590mr10315201fa.8.1727956301420; Thu, 03 Oct 2024
 04:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002150036.1339475-1-willy@infradead.org> <20241002150036.1339475-3-willy@infradead.org>
In-Reply-To: <20241002150036.1339475-3-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 3 Oct 2024 20:51:25 +0900
Message-ID: <CAKFNMonadkY_0Je86FRy81VGKaa6yw+bH_zCfhOmYFbiCNhi+Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] nilfs2: Convert nilfs_page_count_clean_buffers() to
 take a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:00=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> Both callers have a folio, so pass it in and use it directly.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/dir.c   | 2 +-
>  fs/nilfs2/inode.c | 2 +-
>  fs/nilfs2/page.c  | 4 ++--
>  fs/nilfs2/page.h  | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> index fe5b1a30c509..b1ad4062bbab 100644
> --- a/fs/nilfs2/dir.c
> +++ b/fs/nilfs2/dir.c
> @@ -95,7 +95,7 @@ static void nilfs_commit_chunk(struct folio *folio,
>         unsigned int nr_dirty;
>         int err;
>
> -       nr_dirty =3D nilfs_page_count_clean_buffers(&folio->page, from, t=
o);
> +       nr_dirty =3D nilfs_page_count_clean_buffers(folio, from, to);
>         copied =3D block_write_end(NULL, mapping, pos, len, len, folio, N=
ULL);
>         if (pos + copied > dir->i_size)
>                 i_size_write(dir, pos + copied);
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index f1b47b655672..005dfd1f8fec 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -242,7 +242,7 @@ static int nilfs_write_end(struct file *file, struct =
address_space *mapping,
>         unsigned int nr_dirty;
>         int err;
>
> -       nr_dirty =3D nilfs_page_count_clean_buffers(&folio->page, start,
> +       nr_dirty =3D nilfs_page_count_clean_buffers(folio, start,
>                                                   start + copied);
>         copied =3D generic_write_end(file, mapping, pos, len, copied, fol=
io,
>                                    fsdata);
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index 16bb82cdbc07..ebd395dd131b 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -419,14 +419,14 @@ void nilfs_clear_folio_dirty(struct folio *folio)
>         __nilfs_clear_folio_dirty(folio);
>  }
>
> -unsigned int nilfs_page_count_clean_buffers(struct page *page,
> +unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
>                                             unsigned int from, unsigned i=
nt to)
>  {
>         unsigned int block_start, block_end;
>         struct buffer_head *bh, *head;
>         unsigned int nc =3D 0;
>
> -       for (bh =3D head =3D page_buffers(page), block_start =3D 0;
> +       for (bh =3D head =3D folio_buffers(folio), block_start =3D 0;
>              bh !=3D head || !block_start;
>              block_start =3D block_end, bh =3D bh->b_this_page) {
>                 block_end =3D block_start + bh->b_size;
> diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
> index 64521a03a19e..b6d9301f16ae 100644
> --- a/fs/nilfs2/page.h
> +++ b/fs/nilfs2/page.h
> @@ -43,8 +43,8 @@ int nilfs_copy_dirty_pages(struct address_space *, stru=
ct address_space *);
>  void nilfs_copy_back_pages(struct address_space *, struct address_space =
*);
>  void nilfs_clear_folio_dirty(struct folio *folio);
>  void nilfs_clear_dirty_pages(struct address_space *mapping);
> -unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
> -                                           unsigned int);
> +unsigned int nilfs_page_count_clean_buffers(struct folio *,
> +               unsigned int from, unsigned int to);

This gives the following checkpatch warning:

WARNING: function definition argument 'struct folio *' should also
have an identifier name
#75: FILE: fs/nilfs2/page.h:46:
+unsigned int nilfs_page_count_clean_buffers(struct folio *,

It would be appreciated if you could include the argument name in the
declaration of nilfs_page_count_clean_buffer after replacement.

Everything else seems fine.

Thanks,
Ryusuke Konishi

>  unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
>                                             sector_t start_blk,
>                                             sector_t *blkoff);
> --
> 2.43.0
>

