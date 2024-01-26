Return-Path: <linux-fsdevel+bounces-9064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D683DCBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AEFB247D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A251CA8D;
	Fri, 26 Jan 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfcM1juL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E891C2A5;
	Fri, 26 Jan 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280658; cv=none; b=F0rEIpPdRVvjYIS4A/ZC/+nxBZsVjcMjuETmod7uwefeK7HC60lPKJL7B4qLCDENnY4ivpNvSYshoT/7KMH880y7j5fq1Jy3vUu089R8RT3sIhhR8256wUlOIaq1ReDLItdm9NDv5coM1vZ/sDXMBOOwE4ii3gP2k2lLTFAvGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280658; c=relaxed/simple;
	bh=mZggQAMt5w4u5uqa7pG20qzshBhYgUUvPobmKDHLKEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4ebYcAnMqO4RJzUPdd1TLGjTsE7SMaVbRjfMZEZsBjEvGMkLo4U9OZ72l+i4izCCUvmd3tPoYCoTqSiikGgqYYCctUuOHTPfFQyWLazAx5Og+vYvrvwc/1equZX6+ZPmqaseikjlcY6tAj5Fty3drUJq/5TvF2MJGUAGUuCZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfcM1juL; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783cd245ec0so39217085a.3;
        Fri, 26 Jan 2024 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706280655; x=1706885455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/1++r8v+pWoipgYyku3vmpCyA0Gff5YNQqLULNAGzs=;
        b=MfcM1juLHtrmiYVsD05HvnLPTCnE+SWqd0UTsvmRo/4XRE32DINmn9btk698dXdXbo
         wglgiVdUciIglL1uk8q02z2O6dlZzXV7FzqV2loZpNJqp9pn+S/h6IGy+gphvAN7fGtr
         NSUmvKO06Xwm7HUVMKlIvmz6D6khPBVOFoXeF6Ug5emoT1NYUxiJBaUZ2HiKbPQv+tzL
         86RZnNztcLJN8i9Nxg6h4vV4eTsVZ5vcCycnraEn3DUR9/a3Y8MzTOsKuRLCxTgatSZY
         5TWqkp9cyTXVhaRolsjzCYaG0obZCa28l5bu81qjped4wqY4GLA09DYDP4PBWizCXfaU
         7NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280655; x=1706885455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/1++r8v+pWoipgYyku3vmpCyA0Gff5YNQqLULNAGzs=;
        b=a3FELIKSCr59Q542LJQIlFNO71gG20MuST7Ppwa+5eVtcdk2GOpPgdeZ7vVStH+mV6
         Quro1csd3najJxuIEzmqg+Q89bFDWT/1UqbQDN+SS7hr5m4qf1ifn8vZfH0W4IQJP6CF
         w0S75fGZHsoLlX44Dwd3DlkEJJygYIVySv7y4gVlG+MIGr86+uUmzIQPYa73RkZs+Hmt
         DNq3mTml/Ylwtp7IQ/sbKHlPsOHn+3B+k+P4JyEH5USm9BSECiGZpLmhFRibud2Z5ICZ
         u95Q1a3B7V4cFGwae0MhaKaxoZ22BCEsjv0js3wALv4955YHGmrijNruPtnzCrmUgLl0
         HU1Q==
X-Gm-Message-State: AOJu0YzgzvZqKXyM1SazULTGCqdakNQzWzbPI63mr4zyg5/BbOkar5GH
	/o74YTBiKu40sfNm9gIHyNnimYbWM/mE7FjcZhIKaQ7f8ZbBwnuClhVJESch4KzbO93Z5QF0hua
	T8MpDqCNzLmCwfYmKx9cEVsN7y6Q=
X-Google-Smtp-Source: AGHT+IHqG5hPV121VyvqSLJuvMpWc8n3AhmTweSV27h0xeAidMXggDOPVqthD4Wl6Q6T7ZtzZM9wlN/+WfOxCbB9zB8=
X-Received: by 2002:ad4:5bcc:0:b0:680:f9a3:ce50 with SMTP id
 t12-20020ad45bcc000000b00680f9a3ce50mr1436445qvt.111.1706280655325; Fri, 26
 Jan 2024 06:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125235723.39507-1-vinicius.gomes@intel.com> <20240125235723.39507-5-vinicius.gomes@intel.com>
In-Reply-To: <20240125235723.39507-5-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 16:50:44 +0200
Message-ID: <CAOQ4uxi7MtVZECGXo-30YWjSU5ZFZP0AQzgBXLyowdOmNUc5DA@mail.gmail.com>
Subject: Re: [RFC v2 4/4] fs: Optimize credentials reference count for backing
 file ops
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> For backing file operations, users are expected to pass credentials
> that will outlive the backing file common operations.
>
> Use the specialized guard statements to override/revert the
> credentials.
>

As I wrote before, I prefer to see this patch gets reviewed and merged
before the overlayfs large patch, so please reorder the series.

> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  fs/backing-file.c | 124 ++++++++++++++++++++++------------------------
>  1 file changed, 60 insertions(+), 64 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index a681f38d84d8..9874f09f860f 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -140,7 +140,7 @@ ssize_t backing_file_read_iter(struct file *file, str=
uct iov_iter *iter,
>                                struct backing_file_ctx *ctx)
>  {
>         struct backing_aio *aio =3D NULL;
> -       const struct cred *old_cred;
> +       const struct cred *old_cred =3D ctx->cred;
>         ssize_t ret;
>
>         if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
> @@ -153,29 +153,28 @@ ssize_t backing_file_read_iter(struct file *file, s=
truct iov_iter *iter,
>             !(file->f_mode & FMODE_CAN_ODIRECT))
>                 return -EINVAL;
>
> -       old_cred =3D override_creds(ctx->cred);
> -       if (is_sync_kiocb(iocb)) {
> -               rwf_t rwf =3D iocb_to_rw_flags(flags);
> +       scoped_guard(cred, old_cred) {

This reads very strage.

Also, I see that e.g. scoped_guard(spinlock_irqsave, ... hides the local va=
r
used for save/restore of flags inside the macro.

Perhaps you use the same technique for scoped_guard(cred, ..
loose the local old_cred variable in all those functions and then the
code will read:

scoped_guard(cred, ctx->cred) {

which is nicer IMO.

> +               if (is_sync_kiocb(iocb)) {
> +                       rwf_t rwf =3D iocb_to_rw_flags(flags);
>
> -               ret =3D vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
> -       } else {
> -               ret =3D -ENOMEM;
> -               aio =3D kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL)=
;
> -               if (!aio)
> -                       goto out;
> +                       ret =3D vfs_iter_read(file, iter, &iocb->ki_pos, =
rwf);
> +               } else {
> +                       ret =3D -ENOMEM;
> +                       aio =3D kmem_cache_zalloc(backing_aio_cachep, GFP=
_KERNEL);
> +                       if (!aio)
> +                               goto out;
>
> -               aio->orig_iocb =3D iocb;
> -               kiocb_clone(&aio->iocb, iocb, get_file(file));
> -               aio->iocb.ki_complete =3D backing_aio_rw_complete;
> -               refcount_set(&aio->ref, 2);
> -               ret =3D vfs_iocb_iter_read(file, &aio->iocb, iter);
> -               backing_aio_put(aio);
> -               if (ret !=3D -EIOCBQUEUED)
> -                       backing_aio_cleanup(aio, ret);
> +                       aio->orig_iocb =3D iocb;
> +                       kiocb_clone(&aio->iocb, iocb, get_file(file));
> +                       aio->iocb.ki_complete =3D backing_aio_rw_complete=
;
> +                       refcount_set(&aio->ref, 2);
> +                       ret =3D vfs_iocb_iter_read(file, &aio->iocb, iter=
);
> +                       backing_aio_put(aio);
> +                       if (ret !=3D -EIOCBQUEUED)
> +                               backing_aio_cleanup(aio, ret);
> +               }

if possible, I would rather avoid all this churn in functions that mostly
do work with the new cred, so either use guard(cred, ) directly or split a
helper that uses guard(cred, ) form the rest.

Thanks,
Amir.

