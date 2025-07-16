Return-Path: <linux-fsdevel+bounces-55148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C093B07560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821DC5651B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A132F4A1D;
	Wed, 16 Jul 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaHD5jIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287982F3C22;
	Wed, 16 Jul 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668105; cv=none; b=PB6pqSkDz/s+tThm2EF+5exesGd41ZmfjRkCHX8q2vz1dq255lkkUHP83zJWiOnFuILg+X8Ii21aciIMnU1RRGgfaoHwGQ92wEz1sjyFW6kyfs8vCcezp5p8JZ8ia/RS6GdQ/lZh5IDrrmCleKuF1V+hfXdHTc6mvzAc6Xv8ix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668105; c=relaxed/simple;
	bh=KbBrDHqiDQtCVrbZzqrhoey5wwMlExuDhP5y2Dzl73E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdqwKWiudjjxlc4DIaeDgYpsNTxP84/NbVOVwGX0NjG1A0vrrzjZbM0ZT1qzxesoqouKbyMlw1yldD/ZNvVY9bCSJy/Yextuguer0OecwtssbKFjkyCHlU+QqXx3cS5WtftyfKjv0+vMBY1IJX8rDa5BgQYliKIaeNJhK5LwTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaHD5jIo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0de1c378fso1054220766b.3;
        Wed, 16 Jul 2025 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752668102; x=1753272902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR8h2fMhG9BUfYZdatsspYEnRyZK5yFDqt8jlFQC/Yk=;
        b=ZaHD5jIo0EzFeBphNKj8Pndur49EFLlMQzEfG9HtKm1837a0/EyQdmRMCuh8n0HqOy
         MSmnoWNIDxJskssjUiL0dooGu9eeh9XnsEEzhPq6m8IBKMlZYHtOFQU4nYAufHEmBRsT
         1sAJ6g7MHk6PZu56HSxfMHgaK0jgBV5oEt3oL0H+t7oxqf5XyX6OaZzl/nWQQT925Tow
         1y0saCTWadUuEJTHSKpEXw8uP1O9g6oTfDuYovlY6mQxmrRQGF+8vbPh/5eX5n3G9eAq
         2hin8yIT2DJLOEWFwow8bz93cSIqWydtyVc4O3JPdufhQ/u375TZvVizT6OR91NCigRV
         f/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752668102; x=1753272902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cR8h2fMhG9BUfYZdatsspYEnRyZK5yFDqt8jlFQC/Yk=;
        b=QJi1mGJLJOsCzlUEgaMijPrcxwcsH5iZokYiayHaJtbmGfE1pq1PHREmT4v23OFvk3
         3a619qs8hyEnGB+GrJ+rDPg19wsQ5Fvbw4physO1YV7IuaCJ3AoiuA6FZhdvy6nmi+sD
         P2FYunq5k78tEmOFsh0zh8aAvUk99o5koaHZ46vFPmTri921JkNXjinXWd90RMesy26h
         WBLtEbIQK0Iz5AzKySSEP09kbFhhSBsd/o19gFlHla/vUL20wpcIZR5hxSqgSZ7uxmcG
         YOOyIPpfscQF4U0HArxPlmt5D1K8Tmvl83dyY8GB58mjsLnsiWg4RV5XxZowD9ieU0D9
         yqyg==
X-Forwarded-Encrypted: i=1; AJvYcCUxsJ+fLjn5TU0UkwuymkXhTly5zcNTm9ySbTHeST3gxHhL97IQq6XjymF0FEWhuv6g2VKuKCmnd+IjbXdY@vger.kernel.org, AJvYcCVkrCW9JYmtNs/8YBcSRyxvsaogQYxivY7qsVMqNH2JkUthiC3OuGgjZeV6MrPU9aDD9W2tUhp1HBsA0vwb@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwheqfC5URkEjwZEMuPGI1ZJ+BQozH/ZY3QIi+G9bKIV9JCn6
	0QYfMgTdVT2fASAGoQzo8tFWq3cFgQ46uTYlRhW6b0Cx6Ur/HymUwWO9MDJqoLOAEi2WCrE+HZs
	uzWAlGQVEwK4Jgwdc+hQ/GdS/SgR0ThQ6Yn3qt30=
X-Gm-Gg: ASbGncs+7RT5Q0P6zBXk/MvOefBANLc6QceXD/TEZkdOF2a8ap15IQa/JJ8MYeAOwIU
	Mql7h6tvmHR9Lunn3AydOCiKTY/tIyQEUyMnrA4KW4PRHX9iggn/UAg7J3/K+50JOPRUi0muuTo
	5CD1E+B0AsVjxYkO/CRCK/wtGPDFGqnHNCOgf4afKadHrjNovllKu4LRHjh4Jn94Yo+wdlb3v6C
	7m7B05zHT2afMaFvw==
X-Google-Smtp-Source: AGHT+IGbet2lbO5KdpcrYMZrevggCg3D0Bor3B5FqL/ND/3ZJpewezIT1sF28idXwRRDbrJjVYQQ9imlck+ExZ/AqDc=
X-Received: by 2002:a17:907:d508:b0:add:ed3a:e792 with SMTP id
 a640c23a62f3a-ae9ce11c674mr234189666b.47.1752668101742; Wed, 16 Jul 2025
 05:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716121036.250841-1-hanqi@vivo.com>
In-Reply-To: <20250716121036.250841-1-hanqi@vivo.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 14:14:49 +0200
X-Gm-Features: Ac12FXyx1EY3DXykdx1ZI6gCo8c-h1FVsXs9FpR9pQXdKP7oitEdOvKXpm2fnpg
Message-ID: <CAOQ4uxi5gwzkEYqpd+Bb825jwWME_AE0BNykZcownSz6OZjFWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: modification of FUSE passthrough call sequence
To: Qi Han <hanqi@vivo.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulei.rjpt@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:49=E2=80=AFPM Qi Han <hanqi@vivo.com> wrote:
>
> Hi, Amir

Hi Qi,

> In the commit [1], performing read/write operations with DIRECT_IO on
> a FUSE file path does not trigger FUSE passthrough. I am unclear about
> the reason behind this behavior. Is it possible to modify the call
> sequence to support passthrough for files opened with DIRECT_IO?

Are you talking about files opened by user with O_DIRECT or
files open by server with FOPEN_DIRECT_IO?

Those are two different things.
IIRC, O_DIRECT to a backing passthrough file should be possible.

> Thank you!
>
> [1]
> https://lore.kernel.org/all/20240206142453.1906268-7-amir73il@gmail.com/
>
> Reported-by: Lei Liu <liulei.rjpt@vivo.com>
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>  fs/fuse/file.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2ddfb3bb6483..689f9ee938f1 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1711,11 +1711,11 @@ static ssize_t fuse_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>         if (FUSE_IS_DAX(inode))
>                 return fuse_dax_read_iter(iocb, to);
>
> -       /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> -       if (ff->open_flags & FOPEN_DIRECT_IO)
> -               return fuse_direct_read_iter(iocb, to);
> -       else if (fuse_file_passthrough(ff))
> +
> +       if (fuse_file_passthrough(ff))
>                 return fuse_passthrough_read_iter(iocb, to);
> +       else if (ff->open_flags & FOPEN_DIRECT_IO)
> +               return fuse_direct_read_iter(iocb, to);
>         else
>                 return fuse_cache_read_iter(iocb, to);
>  }
> @@ -1732,11 +1732,10 @@ static ssize_t fuse_file_write_iter(struct kiocb =
*iocb, struct iov_iter *from)
>         if (FUSE_IS_DAX(inode))
>                 return fuse_dax_write_iter(iocb, from);
>
> -       /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> -       if (ff->open_flags & FOPEN_DIRECT_IO)
> -               return fuse_direct_write_iter(iocb, from);
> -       else if (fuse_file_passthrough(ff))
> +       if (fuse_file_passthrough(ff))
>                 return fuse_passthrough_write_iter(iocb, from);
> +       else if (ff->open_flags & FOPEN_DIRECT_IO)
> +               return fuse_direct_write_iter(iocb, from);
>         else
>                 return fuse_cache_write_iter(iocb, from);
>  }
> --

When server requests to open a file with FOPEN_DIRECT_IO,
it affects how FUSE_READ/FUSE_WRITE requests are made.

When server requests to open a file with FOPEN_PASSTHROUGH,
it means that FUSE_READ/FUSE_WRITE requests are not to be
expected at all, so these two options are somewhat conflicting.

Therefore, I do not know what you aim to achieve by your patch.

However, please note this comment in iomode.c:
 * A combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO
   means that read/write
 * operations go directly to the server, but mmap is done on the backing fi=
le.

So this is a special mode that the server can request in order to do
passthrough mmap but still send FUSE_READ/FUSE_WRITE requests
to the server.

What is your use case? What are you trying to achieve that is not
currently possible?

Thanks,
Amir.

