Return-Path: <linux-fsdevel+bounces-48469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBEAAF893
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9221C1B66221
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772CC21D58C;
	Thu,  8 May 2025 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBdinCr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71D1C3F02;
	Thu,  8 May 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702981; cv=none; b=TMFWjONOEcHMjJzuv0q/RV6os4oj9vUX0J80GWLQqcRXCZtumkY5VvfWwQlWn+yn0cbVcsOecoTWix9D9dsDE8xkQeIct3Clzp1e6Nz+On5gBKulD931X9Xca+eZja5eMkKYCvGSa2DOuHC6qCztA9S5rY2zbtWUxqkYne3haAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702981; c=relaxed/simple;
	bh=qHPZEf1BABwg33hK/H5sLpnwQy9S4/PdrwuimLcLRbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krjw3cmLI9o1GB2xt+DieWp/mPDylBXz1Y1eJazFgBomBHWhraOmKc/pZQy2fYQC9TGJIiFOm65/LIXvR9KlYxlMlMhEMoeA9IXEqRxLCwMTtHXSXL9seAhlKuKUUkWN6aMSIMGFT6FICrMI22yKyQh00aziRNz2iKRfUKNYSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBdinCr8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acae7e7587dso127614666b.2;
        Thu, 08 May 2025 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746702978; x=1747307778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHy/08ZrTMLJJo7caDd6Rp3zvnS4C0NC5s4YyqeCMcI=;
        b=eBdinCr8C/rq30SJm2lkBUeafEbd/d9Yg8k/mP20JV6nGeX7LmN7svr3QMsikKoQ5p
         XrJFG4XtkXrhFNy1zft3GqcyzV0tggpULJYNxwK9FP3b4SR8cPE8CVAMkHTM7gH/RaUF
         urd/uin5yyCS82+zZ4X51qcROqt732IOH0bbgBJUs5vo/W4uFxtybfpR7C8r78w3y6yF
         yJ0tc8HRsQiPO7I3undnqhiBEfvAhFLtuo6N5Og1acirEZovWrqVukGKn2SWEozg6B2o
         JyJ8Acy3K9dvynRmjo8fbf3QbV8OQzoIKvvxxMuwTLlZkYAIXkVZl5dG1QSv50p+RMx8
         jUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746702978; x=1747307778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHy/08ZrTMLJJo7caDd6Rp3zvnS4C0NC5s4YyqeCMcI=;
        b=bQYqjNzd+AzY1y3Tuc6NURmTpJGRBAYTx5cADalxyOHaZggdJjZwjKj1IK61mb625u
         9kRdPMpbscUSnqhDG+JxUQbZnGbqQ+61L/3JSApVT2OJmJllK4k5z1Hpf2m9hPYm68K1
         2ZJSYsRWsS7xKs//l/5OQHOxEjwA/LzHRffUel9i+1dqPxRph30Wd9NjuWb7Fdzy9dXu
         DjEbifWCt1/Ff6HAnq9z9OPH2rLAaDbHGgxRPzYNlwoWsti0b4ZsBpOIIy9/rEkNLdcy
         RUnecPwGuAWW0ZNhwJfFRHcsmyc+/mJPrUdYpWncmoLeEhZr+/xHY7Lh9UpswUt95w64
         7nGw==
X-Forwarded-Encrypted: i=1; AJvYcCVE8YndImTkejsmM71qLzA4NffnilGiuY47NU0Kl6ovK2ZlNbrv3JMl7F5n8xBQKjNxczU/9NLRfu/JGJFp@vger.kernel.org, AJvYcCVgNA6NEExoRCYK6WL52ZcyAbmSgSoBgwrU4Uhbr+2vHiCQJNttmh80Dt1nysbVQ2ttMSJYt8Hh2DXiGccp@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVj88kLuJhXUyTcrJ4s0TBqxkpW7YEfWTcSa1FKKEuMmTPMJz
	nnunHHumEhU0UFJ/NIqU7nHw/20BHalungUkDD5wRiB8w2uZJmHd6KzbFQAxW94x5uEU1ud6Xb7
	OHWD9ndW4LOdAhAeGOrNXuCA796Y=
X-Gm-Gg: ASbGncszz31A5kuE7phN5httv3MAypcKhkkpuTPx2CKoqNzB5ckjjYgH/kgohzsTEhE
	PfQ9h8PiPdDbBpgJo1jRUz1mmiDway0Hp6EJmLx/E+X479ZuarX0PLWLb895ZqCdT3j+jv7emRc
	LF880yCH/68otWOgMUVxEiWA==
X-Google-Smtp-Source: AGHT+IE5iRiwacWuy+it774IcJd+yVYcLmmbg44YfmWoXeo4tXTEGigABQl6iNAldqcycALF4TfnMMYRt9iz+MxuuSE=
X-Received: by 2002:a17:906:6a1c:b0:ac8:1efc:bf66 with SMTP id
 a640c23a62f3a-ad1fe9e193fmr248607866b.50.1746702977921; Thu, 08 May 2025
 04:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com> <20250508-fusectl-backing-files-v2-3-62f564e76984@uniontech.com>
In-Reply-To: <20250508-fusectl-backing-files-v2-3-62f564e76984@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 13:16:06 +0200
X-Gm-Features: ATxdqUHobzdPAB4vfHNaXFCPdLE8-_rBBCR1bqqm4mpF3bqgsCFgK3jkD3czuSs
Message-ID: <CAOQ4uxgkg0uOuAWO2wOPNkMmD9wqd5wMX+gTfCT-zVHBC8CkZg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: fuse: add more information to fdinfo
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:54=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
>
> This commit add fuse connection device id and backing_id, if any, to
> fdinfo of opened fuse files.
>
> Related discussions can be found at links below.
>
> Link: https://lore.kernel.org/all/CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_=
KvP6ZOe2KVBw@mail.gmail.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
> 1. I wonder if we should display fuse connection device id here.
>
> 2. I don't think using idr_for_each_entry is a good idea. But I failed
>    to find another way to get backing_id of fuse_backing effectively.

Indeed.
The thing is that a fuse file could have passthough to backing file
without that backing file having a backing id at all.

1. server maps backing file to backing id N
2. server associates opened file F to backing file N
3. server unmaps backing id N, so now the backing file is "anonymous"

The backing file remains referenced by the kernel until file F is released.

> ---
>  fs/fuse/file.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 754378dd9f7159f20fde6376962d45c4c706b868..5cfb806aa5cd22c57814168eb=
33de77c6f213da0 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -8,6 +8,8 @@
>
>  #include "fuse_i.h"
>
> +#include "linux/idr.h"
> +#include "linux/rcupdate.h"
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> @@ -3392,6 +3394,35 @@ static ssize_t fuse_copy_file_range(struct file *s=
rc_file, loff_t src_off,
>         return ret;
>  }
>
> +static void fuse_file_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +       struct fuse_file *ff =3D f->private_data;
> +       struct fuse_conn *fc =3D ff->fm->fc;
> +       struct fuse_inode *fi =3D get_fuse_inode(file_inode(f));
> +
> +       seq_printf(m, "fuse_conn:\t%u\n", fc->dev);
> +

Let's follow pattern of fanotify_fdinfo() and add some useful information:

seq_printf(m, "fuse conn:%u open_flags:%u\n", fc->dev, ff->open_flags);

> +#ifdef CONFIG_FUSE_PASSTHROUGH
> +       struct fuse_backing *fb;
> +       struct fuse_backing *backing;
> +       int backing_id;

I did not know that it is allowed to define local vars in the middle
of a function in kernel code.
anyway, you shouldn't have to use ifdef here.
compiler will optimize away code inside:
if (fuse_file_passthrough(ff)) {

When CONFIG_FUSE_PASSTHROUGH is not defined.

> +
> +       if (ff->open_flags & FOPEN_PASSTHROUGH) {
> +               fb =3D fuse_inode_backing(fi);
> +               if (fb) {
> +                       rcu_read_lock();
> +                       idr_for_each_entry(&fc->backing_files_map, backin=
g, backing_id) {
> +                               if (backing =3D=3D fb) {
> +                                       seq_printf(m, "fuse_backing_id:\t=
%d\n", backing_id);
> +                                       break;
> +                               }
> +                       }
> +                       rcu_read_unlock();

We cannot display backing_id here, but we can print the fuse_file_passthrou=
gh()
file path and we already have a reference to that file, so no need for
any locks/RCU,
so this should work:

   struct fuse_file *ff =3D f->private_data;
   struct fuse_conn *fc =3D ff->fm->fc;
   struct file *backing_file =3D fuse_file_passthrough(ff);

   seq_printf(m, "fuse conn:%u open_flags:%u\n", fc->dev, ff->open_flags);
   if (backing_file) {
       seq_puts(seq, "fuse backing_file: ");
       seq_file_path(seq, fb->file, " \t\n\\");
       seq_puts(seq, "\n");
    }

We want a separate line for backing_file because:
1. There may be multiple backing files per fuse file is the future
(see famfs patches)
2. In that case, there will likely be file range mapping information
printed in this line

Thanks,
Amir.

