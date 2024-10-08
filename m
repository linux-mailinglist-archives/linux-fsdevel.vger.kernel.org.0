Return-Path: <linux-fsdevel+bounces-31270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D45993DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 05:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AFF1F24EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 03:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7266A33B;
	Tue,  8 Oct 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDqXVjw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D871DFD1;
	Tue,  8 Oct 2024 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359836; cv=none; b=dxUzTT3+PanprI4YLb7AmkvQseiWHu+/fp6jK2+mqq8jGdZO+7t2OpgK+BLdAOM4YbKvrWm46rtuKgD+AwHxJvGWinphRi8kLTsMQDRECBpd5pGK6qgB7qbeqIUdnC2MwhG32wurS4Ka7kpJ2N+YdqhWzjFxqgixytwA+o9kanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359836; c=relaxed/simple;
	bh=qsli9gtkK5ZTuY3q6/to/HXIW7x0JP9DsMQNb2xaElA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpwuB60SRkhnLKoaE4pplH9lPj5tmSx39aooUKD28HUp9iKe0arl1Ju3Sb8RlkcM7lYhlFBL65+BuTcWGa4UyotxVpvzpDgtCCVQx0jlzRRBL9SE+niV1XvaiXm2v3CZGPO7LZeyEttdZc4JznXCMZpMauDqQZXrelgD5ZgqGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDqXVjw/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so1015547a12.1;
        Mon, 07 Oct 2024 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728359833; x=1728964633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcUVJ/6+noJlpbJBmbf+eW3fpO34COUffJkJzgFbYIQ=;
        b=lDqXVjw/Do2J5L1vnn74G7hADkobwXiO4iWsHzlBO1Yixq/4wXvZWitTcTMO43OsMZ
         UCtGzkpdenf1qG7KP03RuMoNQeTAybvlj06X6jXGIMRIl3AvA2HqYFUTuBzNlJL8/XdE
         49/OsVnbIN1btKzCOhFkD4zaMVg+btSQOorVFF7dLZ0MTWAaazxwK2zKcd2dqQ30M452
         cY7hLjnLRLGj64yCreii4qz9S5ff3CQeumd2tsCRr0po8rAp/eDhEW8wfa/FaawgA+UI
         ECk+PShqwbxmyf3OoxTaRTAw47EJjnjxcbRTsKGn/eel4DctdwCHtL25gyrlY5P8139Q
         +GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728359833; x=1728964633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcUVJ/6+noJlpbJBmbf+eW3fpO34COUffJkJzgFbYIQ=;
        b=qMfy9Tl8XAX38QXF88Eh9l81XXIgDsl5pJ8atJyuj8s4hX8BD3gbfK0HXDrBx5B48o
         eo9ZZslTlvFhRQ4hCo7dOtvZGrGgeM9hLuWVkzIkKr8ZHtW08O8DUhDu0XUxUCCY4cIg
         x0UuR1pFJtr+FdroNgwCDvpQIAklN1XYv2jqWHUiDlAgsOkMVNAZKZKbKLZtCHNg4Yew
         mOpNuRA0BNtZ3DPenoo1m7uKmizA/gsF40Zn6FA2KKmHh3DAi2QWCucIp8YQsCOKtIjf
         u2wPMyI50GhS8nS2dpTNoYn9bxlcFe15kBf0U8r7spm9SklqCB94e1m57rU47YjTXX8W
         mWEg==
X-Forwarded-Encrypted: i=1; AJvYcCV33UYLbpY+1uzBDcpAm6PWFjI/iIlMyK04qoxWsFra0k/Ixo3qTQ5l60oTJUrMl4FooptIT2+j@vger.kernel.org, AJvYcCV6RHhZNjLhOk5DvpJTqicaWJZz6WUqiokSprvWxSUW2WtRDbbpfsh+Fktweg+CdeJoTtloO/62IE1a/25k@vger.kernel.org, AJvYcCWGKeJi1vzzrMNI6MkubKQjg8hU96D0tqHjNNnNN7QmDw63PiVviQfUWuLWs8xHJqGPVANYVGw/TlfAJr+a@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0zbv/uSpce9PkmcBsM6+5CogERZPB+tDBx32zz5PT7Jzmb2z
	etS6WE9SOd+0xUCrt4n+tPxCGxqCF3iL77NA9fgvG0JVXHGH9U+XCzs6VywOYDIxWLUXdafpKzh
	V7kFa9WTyt052YLq1LqkzWpkBLPU=
X-Google-Smtp-Source: AGHT+IHUCWKMeOgk9aCrQZXwpbznfoG6MZWaaIYljAfiq8IPEe4ATI7V9VVtNaK607XCDA65FJ/xODUhR6fjlmTuBt8=
X-Received: by 2002:a05:6402:13c8:b0:5c9:60a:5025 with SMTP id
 4fb4d7f45d1cf-5c9060a5142mr1632630a12.9.1728359833031; Mon, 07 Oct 2024
 20:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007130825.10326-1-xry111@xry111.site> <20241007130825.10326-3-xry111@xry111.site>
In-Reply-To: <20241007130825.10326-3-xry111@xry111.site>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 8 Oct 2024 05:57:00 +0200
Message-ID: <CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: Make sure {statx,fstatat}(..., AT_EMPTY_PATH |
 ..., NULL, ...) behave as (..., AT_EMPTY_PATH | ..., "", ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, Miao Wang <shankerwangmiao@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:08=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> We've supported {statx,fstatat}(real_fd, NULL, AT_EMPTY_PATH, ...) since
> Linux 6.11 for better performance.  However there are other cases, for
> example using AT_FDCWD as the fd or having AT_SYMLINK_NOFOLLOW in flags,
> not covered by the fast path.  While it may be impossible, too
> difficult, or not very beneficial to optimize these cases, we should
> still turn NULL into "" for them in the slow path to make the API easier
> to be documented and used.
>
> Fixes: 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  fs/stat.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/stat.c b/fs/stat.c
> index ed9d4fd8ba2c..5d1b51c23c62 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -337,8 +337,11 @@ int vfs_fstatat(int dfd, const char __user *filename=
,
>         flags &=3D ~AT_NO_AUTOMOUNT;
>         if (flags =3D=3D AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
>                 return vfs_fstat(dfd, stat);
> +       else if ((flags & AT_EMPTY_PATH) && !filename)
> +               name =3D getname_kernel("");
> +       else
> +               name =3D getname_flags(filename, getname_statx_lookup_fla=
gs(statx_flags));
>
> -       name =3D getname_flags(filename, getname_statx_lookup_flags(statx=
_flags));
>         ret =3D vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS=
);
>         putname(name);
>
> @@ -791,8 +794,11 @@ SYSCALL_DEFINE5(statx,
>         lflags =3D flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
>         if (lflags =3D=3D AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
>                 return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, b=
uffer);
> +       else if ((lflags & AT_EMPTY_PATH) && !filename)
> +               name =3D getname_kernel("");
> +       else
> +               name =3D getname_flags(filename, getname_statx_lookup_fla=
gs(flags));
>
> -       name =3D getname_flags(filename, getname_statx_lookup_flags(flags=
));
>         ret =3D do_statx(dfd, name, flags, mask, buffer);
>         putname(name);
>

I thought you are going to patch up the 2 callsites of
vfs_empty_path() or add the flags argument to said routine so that it
can do the branching internally.

Either way I don't think implementing AT_FDCWD + NULL + AT_EMPTY_PATH
with  getname_kernel("") is necessary.

--=20
Mateusz Guzik <mjguzik gmail.com>

