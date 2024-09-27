Return-Path: <linux-fsdevel+bounces-30291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B923F988CA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2811C20DD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2371B3B19;
	Fri, 27 Sep 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0mB9Xc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB42770D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477491; cv=none; b=CJufcQlu59s51Ns/ZLIbJQ+PsLr3wrohhvFijXmS0f4SKnchOtgCqeMzhpTuzstQF4O7LsGU+1Ft8Uw99ZSD+6WzRU99zVLt4rugD82KKhCySt6jxr1FeQZ0E3EWobY2GxICReXSto0DsybNJWSzM49nL0MCPLW4/yL7HnNmxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477491; c=relaxed/simple;
	bh=2e+ZKyvYwIF6jvHuPr7VhMHepU/5eeI3MoytdsJE0i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/rXJUx5gEFxCc4xWQLoCTf4OTOxwSppXE+BwajOGRCw1uv1iBxiRg5cagfY1v4lf9/g2QQy0jn95wRSR3CpfVojZMm6BbDA4juiPzX2fQmQ46oApeEwFuyOb9IT7/Pi7Om94ktQ3Kp8z1hLev7oWYjgB2v3OGomy0Txxs8f7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0mB9Xc1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4584a719ff5so18542461cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727477488; x=1728082288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q2QI7zvF/3yrFdzTBDowE352xabBGmJ6AxzfYeyDEs=;
        b=d0mB9Xc1abHZYw+UHmDZ3dJhtHb8j+fNK9aDN1xgU6UAtzY/A1wIpq62QRhcWkHSqg
         LGm5S4dnFiUwl1sGLxrOteeZRr1q7UL6GKo5QtNc9ufVneop+6XcRoq4KJqIYGPmP89q
         Sc9t7rwUylSK7MDo/ZrMqRGoxd/l0ReCz058SRFNW3U6WLZsUi4ZkVptuhVy5RI8os8Q
         e6dxisqkbnoGzDb+ASg6TNCPlHs6ls1abOHodhoEPzewKICh4phZFnrzvQiz30869PBw
         ZOYGaiC0TYQGlHhveVKTPtpyaL/8X+RW1jVgtBkV79km4myo6lk+kP67xUtE23CrriEi
         e6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727477488; x=1728082288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q2QI7zvF/3yrFdzTBDowE352xabBGmJ6AxzfYeyDEs=;
        b=USdxGUsK7mepvz/mVF4K4jFRm0EwNGDO0lFoJy6VlQtMUWzI0FsBHMU6fOUrOUvKw2
         qCcDNSd/mbhzuRsymHaBHVYW4lKXE7/YbMXTVk6ubjQ3F/AAagr8rf9zosGxBFEHmiMb
         wxP78zeJBh+4fNG4Hk9UoOkKMlYBODp7vcO15biZGdNkAdrRItI/iY49jg4019+3OJI4
         2uxoOYuOlXXOg2mQ9Yr0os8k6LqBcPLR0uqdH8kU+8Z8NrB17Zddt1X30434pErdXw0U
         u7MRFU9glCLP3m2o96/zs22NbwH+0Pxm5MGIfu1A0pcwDUlj34xI1cMOxTWm4lf4qm53
         1wtg==
X-Gm-Message-State: AOJu0YzCieSjP99K4I+mgFX4JMYFQuS7B4qkd9Sd/4Xcpz1B0B87CWJb
	oXOanxj0xcacdoFYeNCuR91J5GGMcBsSQtqE55RaUQYaw8LrJIo/jp47PtuUKcIotaSZ4Uk+cR6
	F5rUR4cvLAbeD1+cKnI0uwuMRYv4=
X-Google-Smtp-Source: AGHT+IGiwoX2Vxd+HCpYTKes0m6LGo3yXxu+dKolJEVSlM78vRGaarEEGZVpBU9Gi5+Qcg2rIqi7fsN8RUclqQLI3gk=
X-Received: by 2002:a05:622a:4e98:b0:45b:5e8e:3440 with SMTP id
 d75a77b69052e-45c9f2c7a9dmr61433501cf.60.1727477488526; Fri, 27 Sep 2024
 15:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <0fe4cfc0e7d290e539abc215501ebebf658fd2b2.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <0fe4cfc0e7d290e539abc215501ebebf658fd2b2.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 15:51:17 -0700
Message-ID: <CAJnrk1bGJWHOLZr3iFkY8Xkccg-0jEvvEKJ7Rb+om+YN06Trsg@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] fuse: convert fuse_do_readpage to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:54=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Now that the buffered write path is using folios, convert
> fuse_do_readpage() to take a folio instead of a page, update it to use
> the appropriate folio helpers, and update the callers to pass in the
> folio directly instead of a page.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/file.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2af9ec67a8e7..8a4621939d3b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -858,12 +858,13 @@ static void fuse_short_read(struct inode *inode, u6=
4 attr_ver, size_t num_read,
>         }
>  }
>
> -static int fuse_do_readpage(struct file *file, struct page *page)
> +static int fuse_do_readpage(struct file *file, struct folio *folio)

Should we also rename this to fuse_do_readfolio instead of fuse_do_readpage=
?

>  {
> -       struct inode *inode =3D page->mapping->host;
> +       struct inode *inode =3D folio->mapping->host;
>         struct fuse_mount *fm =3D get_fuse_mount(inode);
> -       loff_t pos =3D page_offset(page);
> +       loff_t pos =3D folio_pos(folio);
>         struct fuse_page_desc desc =3D { .length =3D PAGE_SIZE };
> +       struct page *page =3D &folio->page;
>         struct fuse_io_args ia =3D {
>                 .ap.args.page_zeroing =3D true,
>                 .ap.args.out_pages =3D true,
> @@ -875,11 +876,10 @@ static int fuse_do_readpage(struct file *file, stru=
ct page *page)
>         u64 attr_ver;
>
>         /*
> -        * Page writeback can extend beyond the lifetime of the
> -        * page-cache page, so make sure we read a properly synced
> -        * page.
> +        * Folio writeback can extend beyond the lifetime of the
> +        * folio, so make sure we read a properly synced folio.

Is this comment true that folio writeback can extend beyond the
lifetime of the folio? Or is it that folio writeback can extend beyond
the lifetime of the folio in the page cache?

>          */
> -       fuse_wait_on_page_writeback(inode, page->index);
> +       fuse_wait_on_folio_writeback(inode, folio);
>
>         attr_ver =3D fuse_get_attr_version(fm->fc);
>
> @@ -897,25 +897,24 @@ static int fuse_do_readpage(struct file *file, stru=
ct page *page)
>         if (res < desc.length)
>                 fuse_short_read(inode, attr_ver, res, &ia.ap);
>
> -       SetPageUptodate(page);
> +       folio_mark_uptodate(folio);
>
>         return 0;
>  }
>
>  static int fuse_read_folio(struct file *file, struct folio *folio)
>  {
> -       struct page *page =3D &folio->page;
> -       struct inode *inode =3D page->mapping->host;
> +       struct inode *inode =3D folio->mapping->host;
>         int err;
>
>         err =3D -EIO;
>         if (fuse_is_bad(inode))
>                 goto out;
>
> -       err =3D fuse_do_readpage(file, page);
> +       err =3D fuse_do_readpage(file, folio);
>         fuse_invalidate_atime(inode);
>   out:
> -       unlock_page(page);
> +       folio_unlock(folio);
>         return err;
>  }
>
> @@ -2444,7 +2443,7 @@ static int fuse_write_begin(struct file *file, stru=
ct address_space *mapping,
>                         folio_zero_segment(folio, 0, off);
>                 goto success;
>         }
> -       err =3D fuse_do_readpage(file, &folio->page);
> +       err =3D fuse_do_readpage(file, folio);
>         if (err)
>                 goto cleanup;
>  success:
> --
> 2.43.0
>
>

