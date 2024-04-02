Return-Path: <linux-fsdevel+bounces-15903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26F895976
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB9E1C2134A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309E14AD2C;
	Tue,  2 Apr 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="br5uV8dU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E41474BF
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074609; cv=none; b=plFqbLrhG0oJVDYQoYeoZ+mFAXfq9mDl6oxUxdHybyJguM9Bt6ondEVDPrsl55Tyi5vUM4fmWvSzi1TVBvMkkMqYTJ3eABWzhtmRDCHBbLWK7qWG2IiT6g9wm0a/ZoBez5pSqGLbjf54Gc7ZazsVsdvZ9BS4jsv1kCiUr3LExJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074609; c=relaxed/simple;
	bh=nAl93uv/5uj7oxx+hXRGC9+Q3e50P5wahWzCo69a05U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqC32rhFObhxshv739ll6Azy0PN6f53Nh4w5VrinVQsJORVSSwQjOGK8h1BKTFppkMx9HgGkQewGhJJleUADYwB80qFzWpR/2MOgj6nTFNemMvStA03alGoPMJwBOPJPehwXlG5+Q2obiISLU8TVfwZ9aRkA/+1C3JpDW0ZdLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=br5uV8dU; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e695b7391dso2700309a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712074607; x=1712679407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naGIgty6bjc6KT8YaYY9w2NDO1KfyUxzvH79lEUBsIw=;
        b=br5uV8dUbb8EoorA0IOrYnEAINLAFD0g/JZGpLX/2C0fPrmqqaECaoyXV/TtXlsYRd
         XIIApb+jaybpF58PwADIJEisFtCrhGeAZXLbZ7Nb2fNtznkNAxDN8wh24u458foUQS+9
         Ps1sUoz6eiAPDTkBIhgwyieYikWMB8ykolf9tPiirbnBUKCViTM8uAPBuv0MO1DDjE/C
         xJ+d2GhdptVcPpAnBnflSZX3hU+a5ha8GWW39BacVC+0Aq7V+CgPv5UOojKdmDppD2A0
         Cozy5HHX4TXpLkoPZGdI6Ix+NCLtHoH1/MYW8g01IEET9g//SShkG984sWDbJdh8jasO
         5tQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712074607; x=1712679407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naGIgty6bjc6KT8YaYY9w2NDO1KfyUxzvH79lEUBsIw=;
        b=RJfqB/KM46rIx3nOJHhhtj2UV5+5dggA3p7K0ybML+RSVThG5z3MSd6R7RLbykvrKF
         XDvln7gfnoKT3qJH/he1aIzUDpIEx5anjGdefRicERhgcmwxiSSKT/sCuZPJ47wSNGek
         5d54TK0LKvpkFYrjd07KjnlvswMb7x3HFuQKMdco4E26sda0aUpcGGmXNEmcPX6qNDfb
         jAcaN0CMM3tCfR+vOIc1x/XoIkWOQsmWQlUQy3dGkZlvfVpsku9wtYlecwYVMy8vXiXw
         pfc/rWJjO4jgjPJRhCi8B6KtgD7QIpTp1uaE0LjGaZkJCI0aSncl3HCALCQBxzWMwXcU
         Idwg==
X-Gm-Message-State: AOJu0Yy1bvZStGb5smrPltUa6vVDptQXKq1/Qrxr3GZeHmMkaAdKkk7N
	r+9zMC/010rH7Wj93YEnhLmLJTkSMOYQ5/NtrksurHU6JHpKiQ99jSM/Gco/DTzT7lzxcsUSsDI
	hSTZMo8hoUzysGTs/mZVjr+FAtJODHIZaF3ev
X-Google-Smtp-Source: AGHT+IFXnPojVVrN2u68kudL0LvM2kKk7aE87BxPyfzTonCkdK1X41dE/Y7nIku5vV8nGhd5WeFZpC3M9yO5AEwce5k=
X-Received: by 2002:a05:6830:1515:b0:6e6:c3f3:a9a9 with SMTP id
 k21-20020a056830151500b006e6c3f3a9a9mr134185otp.11.1712074607313; Tue, 02 Apr
 2024 09:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com> <20240328205822.1007338-2-richardfung@google.com>
In-Reply-To: <20240328205822.1007338-2-richardfung@google.com>
From: Richard Fung <richardfung@google.com>
Date: Tue, 2 Apr 2024 09:16:08 -0700
Message-ID: <CAGndiTNYvGLcGkhE7dPXdSzoBM551KPDXN4gKu=swGQT0H7bUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Add initial support for fs-verity
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Tiffany Yang <ynaffit@google.com>, 
	fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Realized I should have added fuse-devel@

Could you please have a look?

On Thu, Mar 28, 2024 at 1:58=E2=80=AFPM Richard Fung <richardfung@google.co=
m> wrote:
>
> This adds support for the FS_IOC_ENABLE_VERITY and FS_IOC_MEASURE_VERITY
> ioctls. The FS_IOC_READ_VERITY_METADATA is missing but from the
> documentation, "This is a fairly specialized use case, and most fs-verity
> users won=E2=80=99t need this ioctl."
>
> Signed-off-by: Richard Fung <richardfung@google.com>
> ---
>  fs/fuse/ioctl.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index 726640fa439e..a0e86c3de48f 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -8,6 +8,7 @@
>  #include <linux/uio.h>
>  #include <linux/compat.h>
>  #include <linux/fileattr.h>
> +#include <linux/fsverity.h>
>
>  static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *=
args,
>                                struct fuse_ioctl_out *outarg)
> @@ -227,6 +228,57 @@ long fuse_do_ioctl(struct file *file, unsigned int c=
md, unsigned long arg,
>                         out_iov =3D iov;
>                         out_iovs =3D 1;
>                 }
> +
> +               /* For fs-verity, determine iov lengths from input */
> +               switch (cmd) {
> +               case FS_IOC_MEASURE_VERITY: {
> +                       __u16 digest_size;
> +                       struct fsverity_digest __user *uarg =3D
> +               (struct fsverity_digest __user *)arg;
> +
> +                       if (copy_from_user(&digest_size, &uarg->digest_si=
ze,
> +                                                sizeof(digest_size)))
> +                               return -EFAULT;
> +
> +                       if (digest_size > SIZE_MAX - sizeof(struct fsveri=
ty_digest))
> +                               return -EINVAL;
> +
> +                       iov->iov_len =3D sizeof(struct fsverity_digest) +=
 digest_size;
> +                       break;
> +               }
> +               case FS_IOC_ENABLE_VERITY: {
> +                       struct fsverity_enable_arg enable;
> +                       struct fsverity_enable_arg __user *uarg =3D
> +               (struct fsverity_enable_arg __user *)arg;
> +                       const __u32 max_buffer_len =3D FUSE_MAX_MAX_PAGES=
 * PAGE_SIZE;
> +
> +                       if (copy_from_user(&enable, uarg, sizeof(enable))=
)
> +                               return -EFAULT;
> +
> +                       if (enable.salt_size > max_buffer_len ||
> +               enable.sig_size > max_buffer_len)
> +                               return -ENOMEM;
> +
> +                       if (enable.salt_size > 0) {
> +                               iov++;
> +                               in_iovs++;
> +
> +                               iov->iov_base =3D u64_to_user_ptr(enable.=
salt_ptr);
> +                               iov->iov_len =3D enable.salt_size;
> +                       }
> +
> +                       if (enable.sig_size > 0) {
> +                               iov++;
> +                               in_iovs++;
> +
> +                               iov->iov_base =3D u64_to_user_ptr(enable.=
sig_ptr);
> +                               iov->iov_len =3D enable.sig_size;
> +                       }
> +                       break;
> +               }
> +               default:
> +                       break;
> +               }
>         }
>
>   retry:
> --
> 2.44.0.478.gd926399ef9-goog
>

