Return-Path: <linux-fsdevel+bounces-36289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA03D9E0EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 23:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B25EB2370A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84231DF747;
	Mon,  2 Dec 2024 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Pc8JQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4526F30C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179039; cv=none; b=cIhzhVWFHFW0CPZyMvwTjwH5helHNKGxmxWgqbSZn3d0XJIUkEt3VANfhlpW3V+qf4QqXxscFWRDCOH4hdH2AqptMaB/jCbLWqS9fOwcc9HnUFAlCXccibsGWDgpg2JzJ61MMLZc7fL+a/Bj2HRDRNOUC9IsIrAOU/VQMLXuXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179039; c=relaxed/simple;
	bh=oidmmR+rZ9yAP4BFQ43cXd3TvMwhK8VQKdTpdvf6YBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N64qolMooTnD5fKot0136gXNIl08HFeKqE0Rzf7r19+RWZrfDwCyxpkhT/9rOAR2EuQJSHOS3151EKZT2mCMhD2rm7NIMizF0yquGtuBcypjpjQ9D1sC4hr16X2co/89n0ztkBpJNZztRu668Je7bgS1zPXUw9jlftwsmMEm9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0Pc8JQA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46677ef6920so37408281cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 14:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733179036; x=1733783836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHjZ1rFwTM8R3H2tojqc2DLHPO9yalUjvNZr0qPdgKs=;
        b=W0Pc8JQA20mEVpD0XJ6RD4/hMHKr2TZJ3yTNOV6OEVSxMAm2QbnRVHrAQBrjOa5Di5
         c3q8u1TAIE6/yARNpCGEKA8dinEs59CVUDN7eviHp7YUUzvGKnRM5IK/tT9CyjSDHjdq
         4c9zH9gTKdlnYEhr0+mtvzm3ZKCrKgYPj4xNLV6nimaaQeZkBWlCITpaacQPec+zs9DG
         Ok08C9eTE/JAzbbP8pB5tbTjmCxcRKMgFWq0r6gnlqoG1R8I7QX1Al9CwOqVYtONcIRW
         2Tu1yJGR9n48IcuhZuqFkmEjxUQXUhxkz2X+VTV7BwyzD8CgeOHfhSpSMH+sQz/A0upO
         QQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733179036; x=1733783836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHjZ1rFwTM8R3H2tojqc2DLHPO9yalUjvNZr0qPdgKs=;
        b=QNmv9ScUxQ+no43X6AKXg/N4LLcbvUFXswyHYD4YpNL6k/TJkA8jIviTockwiJZCob
         lqMFHwCWnQXGjvYjjq8VxY4pyDFeowrITsOpWvgyH1C0vZd5OiLZDdJkyzA6ZJNrG8qf
         fSPyHaRO4z7hA+siYwALM32bV3emU5lZ3Jf6eKIKAFINgBvjmOvkOUOig17ItNb0esfq
         Qg3PKXbxu9KFsLZEEKjODwzSfUYCSlhQ4DASzMgUklkb70K9P8bKozJ9kmNziObxu9OY
         carhTBSbyw5gXFKn0FbOLfopLyV1jxjd8wfCkh4QvVG2ENiTwLDcKZKRKBPcjW5LEU+K
         X1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXsf1dAzB86Mv2Qx6cny7lNd/eSgkby1kkh6mG+IpFqRo1YbateL/eWyhttIGy6gVJxQxUfDOjyjUjqWNxP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8R8WY6oZf9LtpFNpUc8EdOnRjbKq+CRitOp4gE7qRYaEKUnk0
	r96XRepJcl9c0/M5NaciJsNi3hh3O/FFCAEiJxCYE2rSRzzS2GLw61p5/okxsJWnZe8aG3AC/3b
	oarKUTZRcyrDSCwJIzg4qRvL6Ua0=
X-Gm-Gg: ASbGncsFjKPaIzXOxt3l29UFKTXyEJQT/zLZHWqmhQ78dPn5ykrNj9WrLQSusm7pVI0
	03HOimpu0bhtKUU60HIlJ0g1ScMsxJiyiPtV5EpzqeYCSIj8=
X-Google-Smtp-Source: AGHT+IE20Vsvdf+Eo52cE24loXi1a+5FmFW9zYljvyElNgP4fMxGtgyu05eJf7d5W3L9LxpVsSzs3IUilyRW7N1u6pQ=
X-Received: by 2002:a05:622a:2ca:b0:461:7262:4153 with SMTP id
 d75a77b69052e-466c1b2360fmr378699541cf.10.1733179036515; Mon, 02 Dec 2024
 14:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-fix-fuse_get_user_pages-v1-1-8b5cccaf5bbe@ddn.com>
In-Reply-To: <20241202-fix-fuse_get_user_pages-v1-1-8b5cccaf5bbe@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Dec 2024 14:37:05 -0800
Message-ID: <CAJnrk1ZYq1JX9V1_EZm9ZQHLi+Hz7GPKRO_rbDM36+mWX+GUgQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Set *nbytesp=0 in fuse_get_user_pages on allocation failure
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	Nihar Chaithanya <niharchaithanya@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, 
	syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:10=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
> In fuse_get_user_pages(), set *nbytesp to 0 when struct page **pages
> allocation fails. This prevents the caller (fuse_direct_io) from making
> incorrect assumptions that could lead to NULL pointer dereferences
> when processing the request reply.
>
> Previously, *nbytesp was left unmodified on allocation failure, which
> could cause issues if the caller assumed pages had been added to
> ap->descs[] when they hadn't.
>
> Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D87b8e6ed25dbc41759f7
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Nice catch! I totally missed that just returning err isn't enough.
Thanks for fixing!!

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev.c  | 3 +++
>  fs/fuse/file.c | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d14ea339aa6c8da63d0ac44fc8885..2b506493d235e171336f737ba=
7a380fe16c9f825 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -803,6 +803,9 @@ static int fuse_copy_do(struct fuse_copy_state *cs, v=
oid **val, unsigned *size)
>                 void *pgaddr =3D kmap_local_page(cs->pg);
>                 void *buf =3D pgaddr + cs->offset;
>
> +               if (WARN_ON_ONCE(!*val))
> +                       return -EIO;

We should never run into this case so it makes sense to me to also not
have this line in (to reduce visual clutter in the code) or to just
have this be WARN_ON_ONCE(!*val);

> +
>                 if (cs->write)
>                         memcpy(buf, *val, ncpy);
>                 else
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc98705e0d895bc798aa4d9df080c3c..a8960a2908014250a81e1651d=
8a611b6936848e2 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1539,10 +1539,11 @@ static int fuse_get_user_pages(struct fuse_args_p=
ages *ap, struct iov_iter *ii,
>          * manually extract pages using iov_iter_extract_pages() and then
>          * copy that to a folios array.
>          */
> +       ret =3D -ENOMEM;
>         struct page **pages =3D kzalloc(max_pages * sizeof(struct page *)=
,
>                                       GFP_KERNEL);
>         if (!pages)
> -               return -ENOMEM;
> +               goto out;
>
>         while (nbytes < *nbytesp && nr_pages < max_pages) {
>                 unsigned nfolios, i;
> @@ -1584,6 +1585,7 @@ static int fuse_get_user_pages(struct fuse_args_pag=
es *ap, struct iov_iter *ii,
>         else
>                 ap->args.out_pages =3D true;
>
> +out:
>         *nbytesp =3D nbytes;
>
>         return ret < 0 ? ret : 0;
>
> ---
> base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
> change-id: 20241202-fix-fuse_get_user_pages-6a920cb04184
>
> Best regards,
> --
> Bernd Schubert <bschubert@ddn.com>
>

