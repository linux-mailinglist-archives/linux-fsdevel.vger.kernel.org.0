Return-Path: <linux-fsdevel+bounces-34493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318A39C6055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87860B3EB69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67C0213EF9;
	Tue, 12 Nov 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDBjI371"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5908213154
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432791; cv=none; b=AI9F+6xRXF6NKPlL6OCUyHOKBeX+44wbtVaEOrGNXblusv5UJgkD7rI1NwEpm9Ti/tTjuxtmDqQVqOX6WDO4PDQ0wf8Wxg+nA1o4fYGD6P84gKHa2N4D4O8uS+KXkWHG57kXyjSsW+nKsBGqBrJ0YKoM4Kmc/rLQuBcB/RINTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432791; c=relaxed/simple;
	bh=0N1ox3ARAgx/Tljy7al4EkiYd4btNXbyEcEeeRjhSvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRyHN6cqM9sT+XiHbWErqsAr9eJlVc2q1SJscHkJulMFa4PVeIjGpy9xTmIGXSZ0tBLUsemOUoQ6gjbR4qSKe5zbVOhWXv8wfuAkXvEvheizX3XM0TKLw6yGBqkMTB3sacLmznfkYIDIzmxsLSCMiwaO5kMy4zLwIrufjxaZ0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDBjI371; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460c316fc37so41728501cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731432788; x=1732037588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6YABSvT7YJE4sVGsYyHvMS4kX6Zzx4E+3eTyxRbT8s=;
        b=EDBjI371HiUjLI7Z2nC6Jf4GeHkNw720tnpjXZtdCuLyO7cLe+pZzSAlr8JGK/OLQL
         LDI9msLTEsbKuD/a3OLMonO2p80fBvOsPh/Z/ig22NBJTbadlzX1oxWq5FwBTIBWGVb7
         hScWA36/+zyg4aS+jygoSVdBo1L7ZoOf5U5HQ5nvz7Jpxah+fbv+uBK0SQtwa1SXKgYp
         ZzbpdfDyCFxnXMqz0URlaTNtx3Ck+QpTqgJkp0uAYcIIXLLEjntLBKn4x2aDp/qo7z5p
         z41/vYVCX56WVD3T/W1AQW9EbP2iiwIR16xKMUvbehqN5GZe3+DQkxmMD6Kyw6N3XBck
         hKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432788; x=1732037588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6YABSvT7YJE4sVGsYyHvMS4kX6Zzx4E+3eTyxRbT8s=;
        b=v4oEgpxeUIOAVgypCYW3lSUHE7mivFbuXFKgIRNDwNCiF+yLuffWw4QPU3l3laSFYc
         6Lngh3ruHAkdiWyahLPCz4BZaeb9WlmBUmmYuiieWQGD+shMloLU44qUFUg+YnSNBq5g
         Mi8sKcLdPDwUKZELO0FLquZhO7GhyTyuqLQm40q1Yh0racxX6vgT+hly9NGi96cZdq0k
         eSgKqpgFy6AQ49WDzevODK7koel5v/ICtdSclj2aDndafChs2EsvqFkOnmF4zybxATrh
         B2Z+LZiEASKejxUJCar17lZN0eQv3Hqq5J7z13orZgpCfzfKBbrOjd3K27nyPfud7+NZ
         Y2dA==
X-Forwarded-Encrypted: i=1; AJvYcCVeE2NuNNun3rmtI15F6H4qdjHF73myLXUeMnHNTRp5Bu1d2ocb3tZhjWsMVxiqZZJ6LgvHJifTL4+RK4G1@vger.kernel.org
X-Gm-Message-State: AOJu0YyxwcVnq2DG25rGit0NS6ze4Kw96RfKkIvNmJES6kjZHIADhtmK
	lhgaUcQS8NT5KHAkGUjThFoC4EmRmyw5WWFvkJcR1+hjQjZNvLV0Ji52kpoJYHTNvoIxI+QLMQD
	ROQVyQaSZLIVS6DXOvzO3YL8Qvrc=
X-Google-Smtp-Source: AGHT+IGBs/g+m3Otpa+rdUI61sVHcscXnBCiBenEjVRMRwZF2mQ3Vhx02yzGSTT46LQnR47GYbSqv7bCtJDf0Bz9oy8=
X-Received: by 2002:ac8:57c2:0:b0:460:aa51:8411 with SMTP id
 d75a77b69052e-46309366226mr274375771cf.24.1731432788551; Tue, 12 Nov 2024
 09:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109001258.2216604-1-joannelkoong@gmail.com> <20241109001258.2216604-5-joannelkoong@gmail.com>
In-Reply-To: <20241109001258.2216604-5-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Nov 2024 09:32:57 -0800
Message-ID: <CAJnrk1Zx6TpXgKfKX=uio-GpN9CDL4GxdnmLcjkWHyHfWsTxqg@mail.gmail.com>
Subject: Re: [PATCH 04/12] fuse: support large folios for non-writeback writes
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, willy@infradead.org, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:13=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> Add support for folios larger than one page size for non-writeback

I'll change this naming from "non-writeback" to "writethrough"

> writes.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a89fdc55a40b..6ee23ab9b7f2 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1146,19 +1146,15 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
>         num =3D min(num, max_pages << PAGE_SHIFT);
>
>         ap->args.in_pages =3D true;
> -       ap->descs[0].offset =3D offset;
>
>         while (num) {
>                 size_t tmp;
>                 struct folio *folio;
>                 pgoff_t index =3D pos >> PAGE_SHIFT;
> -               unsigned int bytes =3D min(PAGE_SIZE - offset, num);
> -
> - again:
> -               err =3D -EFAULT;
> -               if (fault_in_iov_iter_readable(ii, bytes))
> -                       break;
> +               unsigned int bytes;
> +               unsigned int folio_offset;
>
> +       again:
>                 folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBE=
GIN,
>                                             mapping_gfp_mask(mapping));

This __filemap_get_folio() call (and the one in fuse_write_begin() as
well) needs to also set the order on the fgf flag to enable large
folios, else all folios returned will be order 0.

I'll fix this in v2.

>                 if (IS_ERR(folio)) {
> @@ -1166,10 +1162,20 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
>                         break;
>                 }
>
> +               folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> +               bytes =3D min(folio_size(folio) - folio_offset, num);
> +
> +               err =3D -EFAULT;
> +               if (fault_in_iov_iter_readable(ii, bytes)) {
> +                       folio_unlock(folio);
> +                       folio_put(folio);
> +                       break;
> +               }
> +
>                 if (mapping_writably_mapped(mapping))
>                         flush_dcache_folio(folio);
>
> -               tmp =3D copy_folio_from_iter_atomic(folio, offset, bytes,=
 ii);
> +               tmp =3D copy_folio_from_iter_atomic(folio, folio_offset, =
bytes, ii);
>                 flush_dcache_folio(folio);
>
>                 if (!tmp) {
> @@ -1180,6 +1186,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>
>                 err =3D 0;
>                 ap->folios[ap->num_folios] =3D folio;
> +               ap->descs[ap->num_folios].offset =3D folio_offset;
>                 ap->descs[ap->num_folios].length =3D tmp;
>                 ap->num_folios++;
>
> @@ -1187,11 +1194,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
>                 pos +=3D tmp;
>                 num -=3D tmp;
>                 offset +=3D tmp;
> -               if (offset =3D=3D PAGE_SIZE)
> +               if (offset =3D=3D folio_size(folio))
>                         offset =3D 0;
>
> -               /* If we copied full page, mark it uptodate */
> -               if (tmp =3D=3D PAGE_SIZE)
> +               /* If we copied full folio, mark it uptodate */
> +               if (tmp =3D=3D folio_size(folio))
>                         folio_mark_uptodate(folio);
>
>                 if (folio_test_uptodate(folio)) {
> --
> 2.43.5
>

