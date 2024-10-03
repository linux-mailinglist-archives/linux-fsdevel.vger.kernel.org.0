Return-Path: <linux-fsdevel+bounces-30857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963DA98EE7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B591C21028
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953C1552E7;
	Thu,  3 Oct 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxLCV5zg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31F153836;
	Thu,  3 Oct 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956193; cv=none; b=TeBaPbwRHxX3cHiM8n+nrh4uC7G23aCk6LX5Ru5ZuA32ts3AxfKg4uJkRrLbW9a6bTisOV6sBZ+ipn1meGFpfe87Nt/aArH7NviS1wmmP/dHzLfHHRnlIPpx8zgkz+8aKZDBiCvMTWt2E44a1snICcRUV57N10zLglPSY2f7pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956193; c=relaxed/simple;
	bh=cWKZw2cBp3f4tfcdV6S4xtK6XCCTH9DamWd2ZS8P55w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8Oh7wbJ/mj0m0KjNyGn8w6AnqiASJennnYQdNSSKuUBoDY+W2CBnJArhhu3TEgU44IhZaZFlKvSHExib3ooQW6PxhWZkCKIayxmqHKNJzxMRi9HPGadGESzFHqp5h1CG9ocZdYOCMTTT3zFXVr5W4u+6XxcVL2s3y91Jsxc/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxLCV5zg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fada911953so19016521fa.0;
        Thu, 03 Oct 2024 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956190; x=1728560990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwICm31kNP0qKM0y6cEGUpRme/ZgrRgUrsj2otKtYJk=;
        b=mxLCV5zg0oiLyOAArMB/LbXxajAjL9dFEzyq9heJhYZTbEtZ9ajcyzhumOei3WYhOb
         0hh7s1QAAMXku68sXiTOVbsBrrcBV59IxBhDNB2AhLCs7sFK0mSp+datFQTS1jn1zd4Q
         Y7cf/Nwam5N7ZRND+te2YheBKHZQuVPB66nGnPF6MS7fURbXM/Yn/WEtDvTvRZXf3ZGu
         YsayFSRcLT3L2R+I+b2a2V1I+hRxTXebJJtCqSsVSU47lg/wYtdIOcSokrhmcjLTnYhl
         IwKyPG1UhpPOg0mAlmeyz8hd66RPPeZAszfWVepksS8WJBQsY9sSLYOQ7956Eg6xuqz+
         Iaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956190; x=1728560990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwICm31kNP0qKM0y6cEGUpRme/ZgrRgUrsj2otKtYJk=;
        b=HNNgJZ+UKISmXD4cZxf8xGS0X/EIdUsMB7hb4V79NC/3omsSaVptxdsSk6ECl4804U
         3TBLKGalZA1rp16Eah/JkS3kIWTDKkBoQyBtT41YQ92lPg6w92eHMy+dMaVW26MnMBOP
         kv3zEFUX24yvh0CcSorT/BMaMoEidNKT6CckS4hshhtSkn4lK+PyOVJd1mQxcxLZ0JXG
         i8iVJpbuWPFTslUEsC8WcYg7LKquGknA/jhrEozOCXf++FoS1eYkcdhYanmR/k6GELgL
         gNeh9eHUYq9szIaYqRlGUW/56+GBsI/W+y/jnvSkd2j+rTTByqzqNe0lWrLgIEkvsY67
         PQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFQMUnA+9Z11DG3Wp5SacEnSNUAZIjsLxH/ryx/jibQCINoSVRzADjueYEohMOKZzkd44dylti831j3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhhfHbcLIU/K14pq1Cs7geT31DfsfLwZ1XsdhHxbJNKMzLgvi
	mrKCN9KxYHu/kiK6KtAbJsaGCYKnrRk1yjOpAv73lh2bRWn4ixEm9byaCoxwVpMvC3xxVQpuK9k
	exzzHXEF2trXkQRsq8VaahY3U+yg=
X-Google-Smtp-Source: AGHT+IHvQx3DskNP/CQF27jh+eYGOZiRhl6OQu14DwQcGQbSWmb//VzxxZ8ocDKnlcbcaLwwYeZq8S52HrQRpSZejL8=
X-Received: by 2002:a05:6512:3052:b0:530:ae99:c850 with SMTP id
 2adb3069b0e04-539a625e6f9mr1025534e87.1.1727956189835; Thu, 03 Oct 2024
 04:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002150036.1339475-1-willy@infradead.org> <20241002150036.1339475-5-willy@infradead.org>
In-Reply-To: <20241002150036.1339475-5-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 3 Oct 2024 20:49:33 +0900
Message-ID: <CAKFNMon0yfSPNcPG0h90DG=c9-anbri1pgZR6Qtc2a8kPG7+LQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] nilfs2: Convert metadata aops from writepage to writepages
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:00=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> By implementing ->writepages instead of ->writepage, we remove a
> layer of indirect function calls from the writeback path and the
> last use of struct page in nilfs2.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/mdt.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index ceb7dc0b5bad..4f4a935fcdc5 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -396,10 +396,9 @@ int nilfs_mdt_fetch_dirty(struct inode *inode)
>         return test_bit(NILFS_I_DIRTY, &ii->i_state);
>  }
>
> -static int
> -nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
> +static int nilfs_mdt_write_folio(struct folio *folio,
> +               struct writeback_control *wbc)
>  {
> -       struct folio *folio =3D page_folio(page);
>         struct inode *inode =3D folio->mapping->host;
>         struct super_block *sb;
>         int err =3D 0;
> @@ -432,11 +431,23 @@ nilfs_mdt_write_page(struct page *page, struct writ=
eback_control *wbc)
>         return err;
>  }
>
> +static int nilfs_mdt_writeback(struct address_space *mapping,
> +               struct writeback_control *wbc)
> +{
> +       struct folio *folio =3D NULL;
> +       int error;
> +

> +       while ((folio =3D writeback_iter(mapping, wbc, folio, &error)))
> +               nilfs_mdt_write_folio(folio, wbc);

In order to catch and return the error returned by
nilfs_mdt_write_folio, I think it's necessary to assign the return
value to the variable "error" in the loop as follows:

+       while ((folio =3D writeback_iter(mapping, wbc, folio, &error)))
+               error =3D nilfs_mdt_write_folio(folio, wbc);

> +
> +       return error;
> +}
>
>  static const struct address_space_operations def_mdt_aops =3D {
>         .dirty_folio            =3D block_dirty_folio,
>         .invalidate_folio       =3D block_invalidate_folio,
> -       .writepage              =3D nilfs_mdt_write_page,
> +       .writepages             =3D nilfs_mdt_writeback,

> +       .migrate_folio          =3D buffer_migrate_folio,
>  };

And, this also caused kernel panics with the fsstress command.  As
with patch 1/4, it was necessary to use buffer_migrate_folio_norefs
for migrate_folio:

+ .migrate_folio =3D buffer_migrate_folio_norefs,


Thanks,
Ryusuke Konishi


>
>  static const struct inode_operations def_mdt_iops;
> --
> 2.43.0
>

