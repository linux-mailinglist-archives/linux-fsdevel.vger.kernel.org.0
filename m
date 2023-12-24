Return-Path: <linux-fsdevel+bounces-6865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4381D8D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 12:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F491F21736
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277423D1;
	Sun, 24 Dec 2023 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svp+VAIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BD23AA
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67ab16c38caso24097426d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703416558; x=1704021358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN0BXi9BH0IFTJfhfrwV1fjS7FnRZxqISyub1gCpLFU=;
        b=Svp+VAIRWsqmEPg5OQSPubWwTYe+Q8OrFoo8zxanuc1JoLQIJIGyF76KwOz+VwsaoT
         6LJUrQ2hcVXzb7NXAdkETW37k9U/SwtZaUbIvPjoEdguRHHiqwC8Oh63xTnZimAP2su6
         ndcKV8Lzq8x9WB5fff4z7U+sH4L5wM/+sCGOFrUpm0xVnhH+RUMvO1iR0n5X5PCPtJLy
         MhtbFdtfb7hMae9u9XomJvRhkqznAHIHj1YNqfp7gmTBQqFJfisV0VOC8159EqeXnP7H
         7KpmkZ4/eKpCqEa1eckn9GEnFD6T51zt+HTDvYhy1jPSUE6F58Y+/JBUhRmCpKR5hjCJ
         348w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703416558; x=1704021358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN0BXi9BH0IFTJfhfrwV1fjS7FnRZxqISyub1gCpLFU=;
        b=YYtqxRQVYIo9q9hYXAKaPHKR+kVSsFnm/wgAqqgtMe8zLzpSMxBpP44XX7iHlYsRgt
         amh6tRcIYfezvWG+m9INSxwowrA2FUM3IYTk/1lpXjZUN5ENOi+JM6uRPITSwLpqw0Zn
         n9shGBCz/VCwFDlEdF9bO+h332nVDi2Ey0eOCOF66UXo1gttZr+USvzid92Ilg2fOANt
         Apt8dQcdCz5RhEiwyAD8bFYIeNS4CWVQnDXPusICAZiuOCFf75pJRj8xuR8JfGBxqdH3
         XcxwShEtd2C11aUHd62QTDoDTEMU9KjnxBojg+pMU+wj370+xVLstFEuUwmrEh7xhSSX
         3rOQ==
X-Gm-Message-State: AOJu0YyQsE4CH0ILd2Xuj2zmJyZa7b8k524WqnXwU0cf613u5A0nR/Zo
	HLHNh0Y1m0ckyWc3AedkcLUztgOyIV/6cKS7mw0=
X-Google-Smtp-Source: AGHT+IH2eyckjGyBbluR3tYEIlOy2L6+uJUC4sRkQc8T7hFV78xsqm8w+t79jj8g9vex0XgFHAhWp9rhZTYJPDbA2eE=
X-Received: by 2002:a05:6214:2d0f:b0:67f:92db:39d4 with SMTP id
 mz15-20020a0562142d0f00b0067f92db39d4mr4277184qvb.81.1703416558164; Sun, 24
 Dec 2023 03:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224104914.49316-1-bschubert@ddn.com> <20231224104914.49316-4-bschubert@ddn.com>
In-Reply-To: <20231224104914.49316-4-bschubert@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Dec 2023 13:15:47 +0200
Message-ID: <CAOQ4uxhLDFjA1prAJ4gdqCeCr7kUJCbx4juXdANKbYzVzdAJDg@mail.gmail.com>
Subject: Re: [PATCH 3/4] fuse: Add fuse_dio_lock/unlock helper functions
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	miklos@szeredi.hu, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 12:49=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> So far this is just a helper to remove complex locking
> logic out of fuse_direct_write_iter. Especially needed
> by the next patch in the series to that adds the fuse inode
> cache IO mode and adds in even more locking complexity.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/file.c | 61 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 546254aaab19f..abc93415ec7e3 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1337,6 +1337,37 @@ static bool fuse_dio_wr_exclusive_lock(struct kioc=
b *iocb, struct iov_iter *from
>         return false;
>  }
>
> +static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
> +                         bool *exclusive)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +
> +       *exclusive =3D fuse_dio_wr_exclusive_lock(iocb, from);
> +       if (*exclusive) {
> +               inode_lock(inode);
> +       } else {
> +               inode_lock_shared(inode);
> +               /*
> +                * Previous check was without inode lock and might have r=
aced,
> +                * check again.
> +                */
> +               if (fuse_io_past_eof(iocb, from)) {
> +                       inode_unlock_shared(inode);
> +                       inode_lock(inode);
> +                       *exclusive =3D true;
> +               }
> +       }
> +}
> +
> +static void fuse_dio_unlock(struct inode *inode, bool exclusive)
> +{
> +       if (exclusive) {
> +               inode_unlock(inode);
> +       } else {
> +               inode_unlock_shared(inode);
> +       }
> +}
> +
>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
>  {
>         struct file *file =3D iocb->ki_filp;
> @@ -1601,30 +1632,9 @@ static ssize_t fuse_direct_write_iter(struct kiocb=
 *iocb, struct iov_iter *from)
>         struct inode *inode =3D file_inode(iocb->ki_filp);
>         struct fuse_io_priv io =3D FUSE_IO_PRIV_SYNC(iocb);
>         ssize_t res;
> -       bool exclusive_lock =3D fuse_dio_wr_exclusive_lock(iocb, from);
> -
> -       /*
> -        * Take exclusive lock if
> -        * - Parallel direct writes are disabled - a user space decision
> -        * - Parallel direct writes are enabled and i_size is being exten=
ded.
> -        * - Shared mmap on direct_io file is supported (FUSE_DIRECT_IO_A=
LLOW_MMAP).
> -        *   This might not be needed at all, but needs further investiga=
tion.
> -        */
> -       if (exclusive_lock)
> -               inode_lock(inode);
> -       else {
> -               inode_lock_shared(inode);
> -
> -               /*
> -                * Previous check was without any lock and might have rac=
ed.
> -                */
> -               if (fuse_dio_wr_exclusive_lock(iocb, from)) {
> -                       inode_unlock_shared(inode);
> -                       inode_lock(inode);
> -                       exclusive_lock =3D true;
> -               }
> -       }
> +       bool exclusive;
>
> +       fuse_dio_lock(iocb, from, &exclusive);
>         res =3D generic_write_checks(iocb, from);
>         if (res > 0) {
>                 if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT)=
 {
> @@ -1635,10 +1645,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb=
 *iocb, struct iov_iter *from)
>                         fuse_write_update_attr(inode, iocb->ki_pos, res);
>                 }
>         }
> -       if (exclusive_lock)
> -               inode_unlock(inode);
> -       else
> -               inode_unlock_shared(inode);
> +       fuse_dio_unlock(inode, exclusive);
>
>         return res;
>  }
> --
> 2.40.1
>

