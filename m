Return-Path: <linux-fsdevel+bounces-16448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF489DD4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3941C212F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB24F8B1;
	Tue,  9 Apr 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KvRY8cHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6B82D99
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674227; cv=none; b=OlO4dM06X1Alwt9SBvJHkyM9ni58D0mo6DWSAoZosRPJIIB1V6OCcF3tztskkYMcU/De+kM0wYua/oh5dLVqdQ9EHDjTx6CoV+YmHJACZ15aLvKGbeAkm4Cvu4wXT9eoOAaVyWSDaPsHBwR0Wzu463uR2HYsYlsKmco7i8ysyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674227; c=relaxed/simple;
	bh=i6kz3Q2dnYL0OW1aHnTfjYKIt9T0R/0xsI8bXOvteiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzoXyMNpF6HOsA+K5pCf9U6bKC7TrjXKLNww3Lk3P27v/uAvCsf8zaN6RxCVTItCku9uCEz7OUWeDvsoN7MaEu8OT3pRLbfUKM9cq9kFR9Kk+CxvH9FLHqnMnUYhNC3LLPYplywbCMqL6P13ypj1XiXM81c3pYVaMOZIDYxd94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KvRY8cHu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a519ef3054bso521350866b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712674222; x=1713279022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evULbkEmDkE2I68uywZgrm/PKi02rLv1h8SrHCCkGGA=;
        b=KvRY8cHuN2Enn6VTqDu9xsJMKUnF+wE8VBjjEhOPfJXXNEqqnJg3JT4zYFwpA5kYjI
         tza3feDNrY5OdgZqCWCYgN4CL0F3tq1ikleygt2zP+Z2arCEmJY5r68XnwlnSdKjae7b
         bMEbA6CBLgSWvvPKCftqm9wgU7PwWz1tmQxYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674222; x=1713279022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evULbkEmDkE2I68uywZgrm/PKi02rLv1h8SrHCCkGGA=;
        b=hDIe8Sodc+TqL0EL0pFrJZvTYBo07JIwkRfb05sXqpeHhrPI+cWfEBG10Z4ZW9Ewsx
         RjxUx38GgjQ1ViI64v143hJhsyqj+0UE71OgYgVe/R91jqYQ5FkqinrOv9+ji5wijJ/K
         ot1uNRhHyFTZquka73Hj+2OhED8JTOYsq380gtNH3oBTjCfCskv7TS4s/SBz1uCruGzX
         4BSLjoxl7CGkyTzYJ4CfJ4naMVU5kJzVm4sfHK5lCNGXUDy7eAKsb0a7Hh1Yd5Ub1sdx
         gJ/aK3A0UFdPH0f+FeKcdfYKIQPmxRtGTbKc2oX/Vc8a02yQPslvas2IyKR1tP6rSg0Q
         G3rA==
X-Gm-Message-State: AOJu0Yzlzy9OUN1LhyQolTWn9leonhmpw3F1vmk01wUELjfg8s/cs89v
	bV3s88KQJpqgunVRdgOJTh8+I8el5K7MiH/o/uybjqR/AzBBtAsYGb4SMDhtBk+EUsYuPkSeCz0
	CzbkGXY0cDM8gTR+PYa4tJ0OzWM9O/IwDleCu7Ti6FLuW944FUag=
X-Google-Smtp-Source: AGHT+IHc6LVv2T36wCeU0Ce+15D6rxumbeQhe6frfBp977Gr422jFSZNqO+H7kNZmfvIhKm0myPpuEe62RAzbyd8+iI=
X-Received: by 2002:a17:907:7e97:b0:a51:ab6a:fb96 with SMTP id
 qb23-20020a1709077e9700b00a51ab6afb96mr11699755ejc.45.1712674221736; Tue, 09
 Apr 2024 07:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com> <20240328205822.1007338-2-richardfung@google.com>
In-Reply-To: <20240328205822.1007338-2-richardfung@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Apr 2024 16:50:10 +0200
Message-ID: <CAJfpegvtUywhs8vse1rZ6E=hnxUS6uo_eii-oHDmWd0hb35jjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Add initial support for fs-verity
To: Richard Fung <richardfung@google.com>
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 at 21:58, Richard Fung <richardfung@google.com> wrote:
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

I'm not thrilled by having ioctl specific handling added to the
generic fuse ioctl code.

But more important is what  the fsverity folks think (CC's added).

Thanks,
Miklos

