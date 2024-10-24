Return-Path: <linux-fsdevel+bounces-32725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D189AE5AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E38B2521E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6872C1DD0C1;
	Thu, 24 Oct 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUwy91ey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF91DAC81;
	Thu, 24 Oct 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775181; cv=none; b=hyUSP4FLmRYKBq1Atu52SVO6LUS/ywZaEWhOm+24W127mffqmA4QpjAe6VKV3z4AevAAoLA8bQ7YptrpXZ+uz0pHxUqAeek6RjEfIB8FgabfRjgcn2GRmoaYVvXxfP4vv4zp771yjOAbnXM+IOO14DMZGLK8/Yi4PI2/NhmA0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775181; c=relaxed/simple;
	bh=aIlKmQ9ihfSARIg+FYKEOZAZucVXvsiEVelFMuAtHng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I452ma5fAzfdodjnmb7MogtLSxYsMOUsGUZn6tZBjp6qnpbxlt+aXyoGFU7t7haMDhu7F0PL8jkqytXI/EnJCxEUREQJSTYZiS7jiVS1MotmOCixj/iztZo7jIR4MiWnOlndCNEfrkGny1WZZtmDSVcgTbEhtLJku/jZ1DE6h58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUwy91ey; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4609e784352so5615371cf.0;
        Thu, 24 Oct 2024 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729775179; x=1730379979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV440ACCLF9AlGZ+8I23qHeuAgKIxh1fOgjLQ6Jdp94=;
        b=IUwy91eyZGO0Tj3CZCx3bmDNUYyrq0ij/X3t6JKvTz/Zxr+IO5XcOnWp/bZwXR9ghQ
         U31TW+pTGiTUyZ5dHRBdNB1oLanpIE/sKZBn6exLRH8CtV6zv6Xm+h2gY1qb3BSP79qf
         0N2N46S+pdb/s3hKYiftYLRoSoQNo+Of7LBi2dU1aEoJFWyk6kcbJdwbHOPiZyaIr73D
         lgJgnMG66ms6trgkU+gRk5p6FEl1CuwlJsFizTMDtUo/vFULXouaiPdICXt+uQclnVAk
         jTb2YVk455NKpS4ySAnr1RnHDwj5/MCHE1kYoLpVKjKM3xbFB5vfbe+6++Tqa3NvwLAl
         TVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729775179; x=1730379979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV440ACCLF9AlGZ+8I23qHeuAgKIxh1fOgjLQ6Jdp94=;
        b=p1uhEjK6Qyv/Gf26bPrUC95khU15hLY6KcDfreUCpkid7Ib5+ip2d0CO7vpyax9qWn
         OPmdSNQh5WxJSmqzK4XG4FIw+7qFdW16zcl3EWB1+I5M9YBsjUcKIh1UnErfAeaYT5L7
         6YkkDkjsnhNf9jbmC0FU0xLI/LHH49lz6wDwJozBUDK0NTFJY3YN0o6snnHIUmw7m2bV
         6VDKdeQkdAfy9K/P3aIBTfjZDlII6N62csjRh83iYt5KVHPLge99MViM8gmLYbhodCl1
         G7H6qCIKzBafgP0LU5LZ9xZezjUcSGui7m4yb+NkTnMyFfyTloI6swKLFs9Phkkp5HWQ
         N+aw==
X-Forwarded-Encrypted: i=1; AJvYcCUawHG+xYB3s/m2spNLqv8q1bQObnn24V5uP5ieAEmPYiilYfVg7daFEbh5pIJnm+3t+IxCm6o8XCobmDI=@vger.kernel.org, AJvYcCVvUyJReoCIMrQ/xObR40vFDPNUZD9hU6ng6rRkmHb89IMnk+Og718q8qOp+yRzBG377A6oTCxqaleL@vger.kernel.org, AJvYcCWcptVhwct6vKbLJWHdd3bbT8BeNRP/5z7SBWXdknaY5UUVVV/4VKXiqlvpoOv1X70h4cTtpO8zeHX+WFxJQQ==@vger.kernel.org, AJvYcCXevy/KyyYGPVEOdYUIyrXzSzCosYMPaSNgjlKKB5YyFDQEHMm/uSEDiDdeOwzE9DoINRfj2vYR+LfheZBupw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNv2yLwNzuEW+G/p4lukqsVElr5AgM6wDzOjPgD/9voM1cSkCF
	RUFtPCT8Vk6HuV1SiQoAShj88zNt1QaelPczXQ5jqcKXtviLQZHjgfOU8IlODKFfiZg3EFBuC9c
	B2gLk3ws+9YQxUA90lwt0pnXqrFQ=
X-Google-Smtp-Source: AGHT+IEIz8fnfbns+VURqZ8Fl6RXgEBHOkqEMI4OdzbZoLgol68YL2Busr8J0hKYCSW/XqtN8XJgmuR8iMUv5K38FlE=
X-Received: by 2002:ac8:5b8d:0:b0:460:39be:10a8 with SMTP id
 d75a77b69052e-461146d6ef7mr65129111cf.32.1729775178536; Thu, 24 Oct 2024
 06:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <4b235bf62c99f1f1196edc9da4258167314dc3c3.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <4b235bf62c99f1f1196edc9da4258167314dc3c3.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Oct 2024 15:06:07 +0200
Message-ID: <CAOQ4uxgxCHmKLhFHMiD39SWw7evZmfkG9dkyk2X=qQc+zXjn-w@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on open depending on
> file open mode.  The pre-content event will be generated in addition to
> FS_OPEN_PERM, but without sb_writers held and after file was truncated
> in case file was opened with O_CREAT and/or O_TRUNC.
>
> The event will have a range info of (0..0) to provide an opportunity
> to fill entire file content on open.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namei.c               |  9 +++++++++
>  include/linux/fsnotify.h | 10 +++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 3a4c40e12f78..c16487e3742d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3735,6 +3735,15 @@ static int do_open(struct nameidata *nd,
>         }
>         if (do_truncate)
>                 mnt_drop_write(nd->path.mnt);
> +
> +       /*
> +        * This permission hook is different than fsnotify_open_perm() ho=
ok.
> +        * This is a pre-content hook that is called without sb_writers h=
eld
> +        * and after the file was truncated.
> +        */
> +       if (!error)
> +               error =3D fsnotify_file_perm(file, MAY_OPEN);
> +

Josef,

Please change that for v6 to:

                   error =3D fsnotify_file_area_perm(file, MAY_OPEN,
&file->f_pos, 0);

...

>         return error;
>  }
>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 7600a0c045ba..fb3837b8de4c 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -168,6 +168,10 @@ static inline int fsnotify_file_area_perm(struct fil=
e *file, int perm_mask,
>                 fsnotify_mask =3D FS_PRE_MODIFY;
>         else if (perm_mask & (MAY_READ | MAY_ACCESS))
>                 fsnotify_mask =3D FS_PRE_ACCESS;
> +       else if (perm_mask & MAY_OPEN && file->f_mode & FMODE_WRITER)
> +               fsnotify_mask =3D FS_PRE_MODIFY;
> +       else if (perm_mask & MAY_OPEN)
> +               fsnotify_mask =3D FS_PRE_ACCESS;
>         else
>                 return 0;
>
> @@ -176,10 +180,14 @@ static inline int fsnotify_file_area_perm(struct fi=
le *file, int perm_mask,
>
>  /*
>   * fsnotify_file_perm - permission hook before file access
> + *
> + * Called from read()/write() with perm_mask MAY_READ/MAY_WRITE.
> + * Called from open() with MAY_OPEN without sb_writers held and after th=
e file
> + * was truncated. Note that this is a different event from fsnotify_open=
_perm().
>   */
>  static inline int fsnotify_file_perm(struct file *file, int perm_mask)
>  {
> -       return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
> +       return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
>  }

... and drop this change, because this change will make readdir()
start reporting odd file ranges and HSM won't be able to tell the
difference between an opendir() and a readdir().

And I will send an extra patch for reporting an event with
range [size..size] for truncate(size).

Thanks,
Amir.

