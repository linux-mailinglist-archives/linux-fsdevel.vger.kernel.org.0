Return-Path: <linux-fsdevel+bounces-43827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62769A5E2B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 18:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0923A6BB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C5257AEC;
	Wed, 12 Mar 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSPN1kFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819E257AC9;
	Wed, 12 Mar 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800076; cv=none; b=kWlIzuKvd5iMwYR1CqY+Z5qREi/pOEZoeqOLWqFEVTQX2ieJ+cwyhZPOC6tzkMEi6LzKhJgpqFumW8JrwE3pG/qC1bpc3fAwDvLEThFAmsfn+CqEQdGx5XuMVA3gW6CmVIjv+mgbPL2eSxZjUWPu6NsA3dw7C6ggf2KXYE925dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800076; c=relaxed/simple;
	bh=ezMQJDDH5pZGdCgBouyFM/QwN7NNld6MDFPteWYa7us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLB+GlIBW6OZnDnqllbuwNlYUBgboPk3kvHkNM3LEfRQ6U+NwaFc4tXXzCt3096ednXJbjuR1K6uYrh9f5C6UDJ50+0iUN2V1izvdMo2FpYYF0LguEpQaCbX+vm5gPRijbXfQ92DvnksNnBfEd3CnK7RX4lUNE0Qtc+P8lHGhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSPN1kFI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso8965593a12.2;
        Wed, 12 Mar 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741800073; x=1742404873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2jxprZq6/TlXm3X2dWej9t/G/kOGcm/J/rsTCWSbuc=;
        b=cSPN1kFITvuitElohoEdUbo7SHs+3p3+EcRrPhUsaP11Z1BsZLIKda5b7+c1924kWN
         JM1wLZdmuG4B+HjrIM6dgKiWgSBQrmh53K5WQ2T6ucAGpyIIxEji6i11NJ7FSObVEL0/
         c5Lh+9ybpZ0i3YOoeVV12GG8+TrZnPvI5zs56EULiLgJO+P+WHlTEtGAMh5+/xIeefkq
         WODpz+G+dVT3YkCOL9LzXAHHaV6Ojt5SoWTkq1g7+pqWuICbNaI7pt/5FWs/0Te0pTXA
         /AoxhbLXmgAPuF5sUoKhLIkNadE8ynf4aoFN10jtF+2mWIOH4Oga+LdyykFQA1DJWFIp
         6r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800073; x=1742404873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2jxprZq6/TlXm3X2dWej9t/G/kOGcm/J/rsTCWSbuc=;
        b=Qp3v9nqw2mHZ3ui2eEgIpabxH0UrNf+P9LI2Rq9phS0qyfqnVkdS64CI1C5MADSj42
         bubfRnOsCFaInJfwfTJMoIPkH0Kvon6VJOK3gOBRzjgJI697Y77iAhK2Pq3LT+Ndv5bz
         /MjdO7FDEXs/xfNoi01c2+EIgfgMytNdHyLH86zXedsdmdVa+6I9hjHv78t8PLpucBZE
         TEnWK/cvKaVoRRuvklOWzvC8kO8id3mmKubshd5dvi/3UJMvfeJJLN2Z+biInpJbZbKR
         VNT2TvIDHl20MVgc4nWkNE3jPDGAwrVAzq8iR+hphEsFa+2X8EBUuT40vr2YPsf+YIOx
         OUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4/vet71xpcXt5SZwpBmlUj49uOEYrAQCzt/MHJeMtanRHK0mjfunhVNb9nGCiyF84ENCPqs36Ue81yBXG@vger.kernel.org, AJvYcCXE1Neg7nqPRjeT3Kd/c25zNjdRm8XiSq+Qoolv7zDMDq0AedZuq514R16mYBnoQlyDeve8o2NIl/4rBK/i@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/pxLnGg/9Rcd2bXJEiIHsIkqv9dU7wMbELRgInz6g7DIhUb6
	+1XaJX8YpqHz10jLUdkcCvOnvzBLFRDNo2yPwrTgEXEeRdKCOE6tOXRcacvzaK+SQeT1s4yy/yw
	zEsA6IiYazLVEgCvjejy2VUzmoa8=
X-Gm-Gg: ASbGnct7qbVWGMCooPv1jL7vJxOREJHGQsNaMymEvS1nackZfMs03q49nlqAXq4fSqk
	lOo4VKPD7sJeB7quBI3PUMLzn15MTbZzMmWJ6BiC430LNKbOf90nQGyNf12Atiw3WgsThlVgTMA
	3auOjg01A1YCWHQ2ZLQOP3gLEFsQ==
X-Google-Smtp-Source: AGHT+IGZKCdNaD46bQEQD4yCZY4m8lNuqNL5dctzGNqdvjioAt8O+CuBxKkpjPkJkDlAD+Y1hwqnOUC0RthR/bQa2T8=
X-Received: by 2002:a05:6402:520c:b0:5e4:d402:5c20 with SMTP id
 4fb4d7f45d1cf-5e5e2115ccbmr31219131a12.0.1741800073124; Wed, 12 Mar 2025
 10:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312161941.1261615-1-mjguzik@gmail.com>
In-Reply-To: <20250312161941.1261615-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 12 Mar 2025 18:21:01 +0100
X-Gm-Features: AQ5f1JqIj1j0OFKelg4MBgowbjL56dyWWVXAOq0PAbFCx7yHBpgNlLd3p-OTPro
Message-ID: <CAGudoHFH70YpLYXnhJq4MDtjJ6FiY59Xn-D_kTB9xsE2UTJD_g@mail.gmail.com>
Subject: Re: [PATCH] fs: use debug-only asserts around fd allocation and install
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 5:19=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> This also restores the check which got removed in 52732bb9abc9ee5b
> ("fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()")
> for performance reasons -- they no longer apply with a debug-only
> variant.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> I have about 0 opinion whether this should be BUG or WARN, the code was
> already inconsistent on this front. If you want the latter, I'll have 0
> complaints if you just sed it and commit as yours.
>
> This reminded me to sort out that litmus test for smp_rmb, hopefully
> soon(tm) as it is now nagging me.
>
>  fs/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index 6c159ede55f1..09460ec74ef8 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -582,6 +582,7 @@ static int alloc_fd(unsigned start, unsigned end, uns=
igned flags)
>
>         __set_open_fd(fd, fdt, flags & O_CLOEXEC);
>         error =3D fd;
> +       VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) !=3D NULL);
>

when restoring this check i dutifully copy-pasted the original. I only
now mentally registered it uses a rcu primitive to do the load, while
the others do a plain load. arguably the former is closer to being
correct and it definitely does not hurt

so this line should replace the other 2 lines below. i can send a v2
to that effect, but given the triviality of the edit, perhaps you will
be happy to sort it out

>  out:
>         spin_unlock(&files->file_lock);
> @@ -647,7 +648,7 @@ void fd_install(unsigned int fd, struct file *file)
>                 rcu_read_unlock_sched();
>                 spin_lock(&files->file_lock);
>                 fdt =3D files_fdtable(files);
> -               WARN_ON(fdt->fd[fd] !=3D NULL);
> +               VFS_BUG_ON(fdt->fd[fd] !=3D NULL);
>                 rcu_assign_pointer(fdt->fd[fd], file);
>                 spin_unlock(&files->file_lock);
>                 return;
> @@ -655,7 +656,7 @@ void fd_install(unsigned int fd, struct file *file)
>         /* coupled with smp_wmb() in expand_fdtable() */
>         smp_rmb();
>         fdt =3D rcu_dereference_sched(files->fdt);
> -       BUG_ON(fdt->fd[fd] !=3D NULL);
> +       VFS_BUG_ON(fdt->fd[fd] !=3D NULL);
>         rcu_assign_pointer(fdt->fd[fd], file);
>         rcu_read_unlock_sched();
>  }
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

