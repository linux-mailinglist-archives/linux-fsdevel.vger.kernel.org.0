Return-Path: <linux-fsdevel+bounces-30560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A598C3FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B161C22E08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC761CBE8F;
	Tue,  1 Oct 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+bwlNsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06C1CBE88
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801706; cv=none; b=J3gJmRJcw2Vc/9LDwMGbwmZKktwPZVBjloq+DrxzXmEdHZp6e6Ky+8NaSnxUlLxomctysN83VwKZXp8B3luNzG2jY0J70JDz92mo+8vwuv6ynXMy14Sn8S/yJjbY5Tkg1xdsTJG4zJS3e3fekpjF/IOBT+xkDQTN3yqtH/uFcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801706; c=relaxed/simple;
	bh=iGHIiBCUYQpkLZ1TbfaT2CoTaGNlnT0NmtMyOVTbHlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHv4GPKvIvGw7RW0NVnfFvzu8ema/uiYIP4qqIyxyWzbVE1EiKJIS1+BWJKF6LNwDOHooNQiG+PIsYOKdOi8oixLosRUeab8ddDKsNAWZEZ9Jvd6KAqJ+9qswVatKjFYR/+Gtumtf+D6E2jALZJNWCz4RuyP4x7TT4lsNXI1RWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+bwlNsi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4585e250f9dso37749981cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801703; x=1728406503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjfIESfHvULL2/5i36gcoICqh7qWfWzJ8YzC/qU52n0=;
        b=D+bwlNsilaLN6ngGQVQ+lr9BbDmWld4cMxzMuCbjKpGZwzOjPYsIbmVpSnA+zwjoKp
         RywnKaLXPkkVD9MoPl5LtHrmsawQkKK3MyGIKXG5hknjrVPp5sN1AL5ob0YWI9f1yu33
         W10ZiYZckEeFj4Cqy8jDThaOhScFSGO8/ZzclRCVaOMJeJ71m1JOyBMnbi2wREg8QNH5
         5xS0Om/V1GUFN+R71PbT82M+GwGp2UKAReVODEmJMEFiIAuj8pPoLpAh5xHPUxgi5yYe
         56CK05TWZzIGk/QrU7mT6eNVsej5Or6SdQq/6PcJFWFdzz4M1MZ30IBdCoyRIWigN4LA
         kWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801703; x=1728406503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjfIESfHvULL2/5i36gcoICqh7qWfWzJ8YzC/qU52n0=;
        b=JmL1aaSFr5T3P+psQJNdUnnbjIiGSiNYIIWMnqBUPOWrE8BQd+kaSe3S7ahq1rz9us
         D84wHYOHy6WkU+6u51JzvMp27/8XEB4dqBES06LX2SggUymmPT05zrkoinZlp+X+BBIJ
         vEwHV+44gHuNHxySGWFAhr76mlPyrgkJD/JubK6p6Hip7odJgb2PkbBoSWq9soHIpwEc
         9eT/g/DyhlQnq3EXMYOuHlvfjLh/ctnHSSlIdNw6xIRy5yKC4uIsGyAL29rSLA8fMB8s
         6nVmVvcTxvLeceHU6/VolmU1Bdo6jFeqENax2IWGGmpnBDA5cq9X5oBqZG/MR5JWoUAO
         CyKg==
X-Gm-Message-State: AOJu0YzhQIFxsu5cYioYIZLLK7eRx5hw1BXGULQJNkcua0c70q0pKquA
	hXkl0LFVMpA9YtFGuWlDxaZCM78HnHk4BFMSO/1j3N3bI0iXXK7jV6d45Zku4yFXDzZsWdsVEj0
	fnbJTd7WXBOBwADrG0Go3BsHyrX9jP/dXd8A=
X-Google-Smtp-Source: AGHT+IH+cJTf59ryHTSgZ0RTp4+spcHscIs6yzGttTkNaL+YgYOZs27eKtG+gQA5SijpuGfS34hvX/vtz87kFIn2tvI=
X-Received: by 2002:a05:622a:1ba4:b0:453:7533:a64f with SMTP id
 d75a77b69052e-45d804b2c9dmr3319901cf.21.1727801703098; Tue, 01 Oct 2024
 09:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727703714.git.josef@toxicpanda.com> <17ca5aafb5c9591d28553c8af42551c8bc23a9ef.1727703714.git.josef@toxicpanda.com>
In-Reply-To: <17ca5aafb5c9591d28553c8af42551c8bc23a9ef.1727703714.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 1 Oct 2024 09:54:51 -0700
Message-ID: <CAJnrk1bmyxJqsYwSWBdRX8P29cLi_R+6cb0ZDnzHEMj4vG-FyA@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] fuse: convert fuse_do_readpage to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:46=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Now that the buffered write path is using folios, convert
> fuse_do_readpage() to take a folio instead of a page, update it to use
> the appropriate folio helpers, and update the callers to pass in the
> folio directly instead of a page.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/file.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2af9ec67a8e7..45667c40de7a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -858,12 +858,13 @@ static void fuse_short_read(struct inode *inode, u6=
4 attr_ver, size_t num_read,
>         }
>  }
>
> -static int fuse_do_readpage(struct file *file, struct page *page)
> +static int fuse_do_readfolio(struct file *file, struct folio *folio)
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
> @@ -875,11 +876,11 @@ static int fuse_do_readpage(struct file *file, stru=
ct page *page)
>         u64 attr_ver;
>
>         /*
> -        * Page writeback can extend beyond the lifetime of the
> -        * page-cache page, so make sure we read a properly synced
> -        * page.
> +        * With the temporary pages that are used to complete writeback, =
we can
> +        * have writeback that extends beyond the lifetime of the folio. =
 So
> +        * make sure we read a properly synced folio.
>          */
> -       fuse_wait_on_page_writeback(inode, page->index);
> +       fuse_wait_on_folio_writeback(inode, folio);
>
>         attr_ver =3D fuse_get_attr_version(fm->fc);
>
> @@ -897,25 +898,24 @@ static int fuse_do_readpage(struct file *file, stru=
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
> +       err =3D fuse_do_readfolio(file, folio);
>         fuse_invalidate_atime(inode);
>   out:
> -       unlock_page(page);
> +       folio_unlock(folio);
>         return err;
>  }
>
> @@ -2444,7 +2444,7 @@ static int fuse_write_begin(struct file *file, stru=
ct address_space *mapping,
>                         folio_zero_segment(folio, 0, off);
>                 goto success;
>         }
> -       err =3D fuse_do_readpage(file, &folio->page);
> +       err =3D fuse_do_readfolio(file, folio);

I'm on top of Miklos' for-next tree but I'm seeing this patch unable
to apply cleanly. On the top of the tree, I see the original line as:

err =3D fuse_do_readpage(file, page);

Is there another patch/patchset this stack is based on top of?


Thanks,
Joanne

>         if (err)
>                 goto cleanup;
>  success:
> --
> 2.43.0
>
>

