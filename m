Return-Path: <linux-fsdevel+bounces-28694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE896D17B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013331F27727
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1D199EA8;
	Thu,  5 Sep 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0Zk+mpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D818FDB4;
	Thu,  5 Sep 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523681; cv=none; b=i3D+Ti1M7o8wfGS4AUcbE4ht76tVZjQOPEsae6cRAabWm+8HFjktksoLqFToxzuDYy0f+i8nxkt3ueKMzOn7ldZ+oVKkRHZLxwO8esTJyYzPCaatk8WBnVEwSTgZ4p2wjhRhNFgAzAKfINasjljfAw2bWrkDY6wgZ3fVnU3natU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523681; c=relaxed/simple;
	bh=raImueNqfWWkqLnLxEGY+/4FKgyLlGv/zGZT7NbbBAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZEgOJ1S4VyXhoYwdq/qsbxrM0lPtGVsFHHvvJSXl0TbWhcc4641ZolT86MEUlYZ11UMg4qpGLwdiEu/FUCVGvhzEhjZ9HzdX7LTbPEUMtMCB7yt+qhwx8Iejy4SOQYBnfjdfeZdJ/AeH1CT5qmySARch9LAIJGyYXM9Nh2DiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0Zk+mpe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a8130906faso34341585a.0;
        Thu, 05 Sep 2024 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725523678; x=1726128478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9evaM+/i7nGyrRogDxvgPy1n3dS/KfQS+d0VRsLRTo=;
        b=F0Zk+mpe9Bh0oVcS7S/ctBwrwfvdOLz6HFswTfo4e1IwFNU7hZkq3BxUMGJHcRgFc8
         DVV6oegF3cJN/h5O2ITgcFCoNu+Js0+ECSulWOhI0EIe5ToFuat9k08M1FcnzXEbyyJr
         LEl0xB9rkN5yGe1nxQMMQTTBBlsgObQOx+ls4rHzAOSgxVfZq4wgNvPq2NigyKXzM/d1
         LFtLL7Q1BbP7m6hV5XpAXXZmLlIK4ZNXdeuzLXtwcrx36nvcGIMRbE4c+L+BEmLmnCAS
         MUQ2CK+XTB/7O0soVR71t8RoH3oR7mSX5aRV4FkRzMFIwNqNYt6nNartZUI1FFm9gck1
         3hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523678; x=1726128478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9evaM+/i7nGyrRogDxvgPy1n3dS/KfQS+d0VRsLRTo=;
        b=MyPZdl9GJ7IJz5FQ0iYQZDUsm1nomsoI+5gtnjCuxD5rr88BuunJijXLhWMz5Fky6G
         YlTx6gbGStqiWy3zhbDp39J2kyDTxxHP9EsjHNfM3WeLxM4FIz2GAk1nR2lToa4qdWhA
         5kqJWLyMOxs2gwxWZqVuwUJuKQ8hEp09mXiMaJ0q+slrg+aRRgh7b+Cr770RLQinJujj
         cjxhhw4rngvnSu+WaEahYXmm/mrWAgnjqJ9l0C3d4wJD/jN3QOAMsMD1+j+Ij6FT2i35
         hqMnBPHz1L3qvu37LrcPkrHDuirErMg/5BqNv5DoRVFIPjp8qsKQ4V42+reKlIx0WK5C
         W4QA==
X-Forwarded-Encrypted: i=1; AJvYcCVXE5VMJusR0HgRK3bIASJx7EoK3XsyvDzozSZ8dBJZBN95DI8U0leGeleyUPA60LJ21bISoCx9LejrYrM=@vger.kernel.org, AJvYcCWj/pOsz+S6ZT4kOmp6W/MBmq6mVzvlmIj4srUCM7noOjP2rBvIOcxFGra3TAeNiOr9nZ1lcl9coHIRHm0ZgA==@vger.kernel.org, AJvYcCWop6l0lSYg5r6DtxvPVQkKJjH/7b1XXj+az3ygRkPWAUUGMTfr6ThqPvUZIDLJIDwmwBrqIwMiXrJRGkxMLQ==@vger.kernel.org, AJvYcCX4np6yiq0d1L/wtx+ntE+dWoH79Cw2glJP4cYxojqKUnl/EGDEZK2lKwLud+uwRgJTiQQtR2TKyR0z@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrD3IYgYrIUrixrmyFnVOP3u2tRYU53xWAIB439wVKQEs3Tj3
	FAEQF11VaQTAY4I4papfV1PmLFRQL41uY/ijuVC4z6E00+kP4Qne/wJKehmBH0fyzMfhcbcl9Tk
	dr+Eo0xsdus12Pj/hXaMLmYb+lDw=
X-Google-Smtp-Source: AGHT+IH1V7cjY3UVK2E999mAtRxtZnv2ifLJeXP6Pbb6prHkryHmT1Xk5RpQhKkwMl11HK2Cz/GJl+Mgv/3CUTLzcQ0=
X-Received: by 2002:a05:6214:5902:b0:6bf:7c44:f7b4 with SMTP id
 6a1803df08f44-6c3556d2f6cmr218344006d6.31.1725523678325; Thu, 05 Sep 2024
 01:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <f5dd14c65fe3911706be652833f179465188fe08.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <f5dd14c65fe3911706be652833f179465188fe08.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:07:46 +0200
Message-ID: <CAOQ4uxjBFWLh7eDbeygiy_PsA4bks2z+ak1wQsn=Rp0s82vqSA@mail.gmail.com>
Subject: Re: [PATCH v5 10/18] fs: add a flag to indicate the fs supports
 pre-content events
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> The pre-content events require some extra thinking, especially around
> page faults.  In order to make sure we don't advertise a feature working
> that doesn't actually work, add a flag to allow file systems to opt-in
> to this behavior.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Better squash this patch to FAN_PRE_ACCESS patch, so it will
not be allowed to mark with FAN_PRE_ACCESS on unsupported fs
mid series.

OR - move this patch before the FAN_PRE_ACCESS patch and pre-define
FANOTIFY_PRE_CONTENT_EVENTS to 0.

Apart from that, you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/notify/fanotify/fanotify_user.c | 2 ++
>  include/linux/fs.h                 | 1 +
>  include/linux/fsnotify.h           | 4 ++++
>  3 files changed, 7 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 53eee8af34a0..936e9f9e0cbc 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1736,6 +1736,8 @@ static int fanotify_events_supported(struct fsnotif=
y_group *group,
>
>         /* Pre-content events are only supported on regular files and dir=
s */
>         if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +               if (!(path->mnt->mnt_sb->s_type->fs_flags & FS_ALLOW_HSM)=
)
> +                       return -EINVAL;
>                 if (!is_dir && !d_is_reg(path->dentry))
>                         return -EINVAL;
>                 if (is_dir && mask & FAN_PRE_MODIFY)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..5708e91d3625 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2494,6 +2494,7 @@ struct file_system_type {
>  #define FS_USERNS_MOUNT                8       /* Can be mounted by user=
ns root */
>  #define FS_DISALLOW_NOTIFY_PERM        16      /* Disable fanotify permi=
ssion events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle =
vfs idmappings. */
> +#define FS_ALLOW_HSM           64      /* FS can handle fanotify pre-con=
tent events. */
>  #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move() during=
 rename() internally. */
>         int (*init_fs_context)(struct fs_context *);
>         const struct fs_parameter_spec *parameters;
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 9d001d328619..27992b548f0c 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -179,6 +179,10 @@ static inline int fsnotify_file_area_perm(struct fil=
e *file, int perm_mask,
>         if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode))
>                 return 0;
>
> +       /* The fs doesn't support pre-content events. */
> +       if (!(inode->i_sb->s_type->fs_flags & FS_ALLOW_HSM))
> +               return 0;
> +
>         if (perm_mask & MAY_WRITE)
>                 fsnotify_mask =3D FS_PRE_MODIFY;
>         else if (perm_mask & (MAY_READ | MAY_ACCESS))
> --
> 2.43.0
>

