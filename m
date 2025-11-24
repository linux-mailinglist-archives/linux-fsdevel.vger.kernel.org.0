Return-Path: <linux-fsdevel+bounces-69701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC8C81D94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D76A14E7A2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC506314B61;
	Mon, 24 Nov 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c42vCgSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7D316919
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004447; cv=none; b=sPYJ7GBY9GKAyru6PcI727dVBFHGPoAh5lyc7+l7OKhuSjGOcEetuI+TZ3HMGp/CBYLrxzAQfigLa65bYT926b5fk43MDwZC++3MrfNZ7G/UKcu3Kf7zke/DCF+/59uxUbKxLRrj8JzQCm/Fl1IqfoelC/FRfoRJhDkzCZrov1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004447; c=relaxed/simple;
	bh=kwtR3HBF8HXq4LY88zkbdt5fv0yNTtExIL1nhiJO9C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9Vk/I9I+7YS445i6H6F31Spe/UItr8ff57zZk8VQPWj8j+VwKvwhfBVAkWR22UJJ9qs3V9IqSXByQ8VJxygVBgYQb2y1L3HGXfqUmJbTnAGutS2naX5Cyf5uLSa/VitSMORTl9jZT8t7QtLUL7Hrj0eoWWcKt/FPKu+vlsDQbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c42vCgSv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b736ffc531fso650897766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764004444; x=1764609244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+znq8WL2qpUGQNzayOWtcUD9IppdNIag4e3rlUFDDg=;
        b=c42vCgSvE2BGZi7Gh8r42em+ekiuzrBKd27+K2C/SXviX495T9lGkweu6fye4NO0rD
         mhj6cfLgE33pfO0xCvEphBF05Z58lJ0T6912py7uKQuFdqphEEr4XsjT/e9S4gNSkJTG
         0TZqlr8NTUngk8IvkNs7W5UzIhuEfcVqdJOxsxrtt4Jt1mC5Ngw0oxK4zE+REGbgsCg4
         WArsV/GtaJV3tpDnDqo1+cQr9AFrNWOnwn9MRfHExnK327aVVh3oV9lQgixpKY0sQkAE
         crkTDj2wmwfb5iitO1ICyut7iZKUgFH1uzdHlxfmQ5wcEgAaG5k21GS2sMA/Sjh1GWqo
         7bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764004444; x=1764609244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+znq8WL2qpUGQNzayOWtcUD9IppdNIag4e3rlUFDDg=;
        b=fSt/gp3xnMHEoMBRKWpD+V2h5SQMoI/i5RhP5h5riR0UmnnrGM5JfqRV63eQaK9id2
         U/oEnRRnIxLOV1f3vI6NrN8nijK4guDeKN5pB/uqocpEsPGIYJEynW2ZYrlMnuN+gI58
         uz/HuKbx8YwdwpSFpCnf2mVa3l0C/o34710/Xw5Tg+EQqwh1dmznccbixGc0JGRHlCHk
         kETUC0npj7DsBN5GCMADrG9DLi0goTCSKOPuAFQBkDgiRL4QvP+1fZcYgOz5Ukj2vHrT
         jyvjlGn8OyN78r6YaAZYynbiVj44JWz0yciijWJAA/OXtxHNomfvdUuXLNUQT6P6bGEk
         /JfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbpDeh9gbFysWNVJqPsJGFn9FeWb3RCQj9C/E8zQX0KQvk6HAdLbB3830Z7kmIFEp/gIt9A6OXY3TawmI1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywadl0il7T08z8WEKg+AGLQxu5XlGK+VFOV6kMZzkcvgF4BkTSX
	Cx9o8oSLy2Rl1TtNYOHwb8q47lCQh1lMxlMfwj8ph/E2liBSLj+H4TwvNIKqJWnCbALpBwK8PlV
	dqUCkqfGoxOo8fQKono7oWsHLySQYiaY=
X-Gm-Gg: ASbGnctu7C61D5Jz28QpuCTtHX5DOeMfy3MUNFjmqTsDxsZtlWn9j7Ez7GTpHbz0S3F
	63dtCaeumVlabElVwOFuXCnr5GNJKrm7zNHqM4tgzQgrtNNh+XYI0TdLIwJuU6mYQQFrdyri3Py
	uJMi6UGLb116Cmg/CWCVoLr/WpPhgemiLUCa7MOADWDIjaOBPPD3kdIrtlVB/nwbHCSD8bmyw78
	eeWWdRiipVNvzDcYgP0it8sL7tZtSsVQahJUSQv0gReQtFdeIr5RPMlqLoOT0A+Lw9FPSws+ALl
	LyDeGbBCfw4ctdCT6l73YEYRHP1bkQ==
X-Google-Smtp-Source: AGHT+IFPNuHfNVgBIHiqVsKpbCEHpOqFz+FDk62TIk4p62EMYh+x4z1DEfzgdRrG4tmeNrvgZysAd4ofGMbgd86NYts=
X-Received: by 2002:a17:907:2d91:b0:b73:5507:8be0 with SMTP id
 a640c23a62f3a-b7671547b9emr1370345166b.14.1764004443539; Mon, 24 Nov 2025
 09:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org> <20251123-work-fd-prepare-v4-8-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-8-b6efa1706cfd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Nov 2025 18:13:52 +0100
X-Gm-Features: AWmQ_bkqduT6Y7O_m3-A5rnH7VB04uX-R_b-FRsQe8sGggMHVVLiygkk3Y0uUgA
Message-ID: <CAOQ4uxh7JmqacNTsLrSCSdgktpZ00eddtQKe-biGah5qhQZBqQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/47] fanotify: convert fanotify_init() to FD_PREPARE()
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 5:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/notify/fanotify/fanotify_user.c | 60 ++++++++++++++------------------=
------
>  1 file changed, 22 insertions(+), 38 deletions(-)
>

Love the diffstat!
Love the end result!

Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 1dadda82cae5..be0a96ad4316 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1597,16 +1597,20 @@ static struct hlist_head *fanotify_alloc_merge_ha=
sh(void)
>         return hash;
>  }
>
> +DEFINE_CLASS(fsnotify_group,
> +             struct fsnotify_group *,
> +             if (_T) fsnotify_destroy_group(_T),
> +             fsnotify_alloc_group(ops, flags),
> +             const struct fsnotify_ops *ops, int flags)
> +
>  /* fanotify syscalls */
>  SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_=
f_flags)
>  {
>         struct user_namespace *user_ns =3D current_user_ns();
> -       struct fsnotify_group *group;
>         int f_flags, fd;
>         unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
>         unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
>         unsigned int internal_flags =3D 0;
> -       struct file *file;
>
>         pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
>                  __func__, flags, event_f_flags);
> @@ -1690,36 +1694,29 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>         if (flags & FAN_NONBLOCK)
>                 f_flags |=3D O_NONBLOCK;
>
> -       /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release=
 */
> -       group =3D fsnotify_alloc_group(&fanotify_fsnotify_ops,
> +       CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
>                                      FSNOTIFY_GROUP_USER);
> -       if (IS_ERR(group)) {
> +       /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release=
 */
> +       if (IS_ERR(group))
>                 return PTR_ERR(group);
> -       }
>
>         /* Enforce groups limits per user in all containing user ns */
>         group->fanotify_data.ucounts =3D inc_ucount(user_ns, current_euid=
(),
>                                                   UCOUNT_FANOTIFY_GROUPS)=
;
> -       if (!group->fanotify_data.ucounts) {
> -               fd =3D -EMFILE;
> -               goto out_destroy_group;
> -       }
> +       if (!group->fanotify_data.ucounts)
> +               return -EMFILE;
>
>         group->fanotify_data.flags =3D flags | internal_flags;
>         group->memcg =3D get_mem_cgroup_from_mm(current->mm);
>         group->user_ns =3D get_user_ns(user_ns);
>
>         group->fanotify_data.merge_hash =3D fanotify_alloc_merge_hash();
> -       if (!group->fanotify_data.merge_hash) {
> -               fd =3D -ENOMEM;
> -               goto out_destroy_group;
> -       }
> +       if (!group->fanotify_data.merge_hash)
> +               return -ENOMEM;
>
>         group->overflow_event =3D fanotify_alloc_overflow_event();
> -       if (unlikely(!group->overflow_event)) {
> -               fd =3D -ENOMEM;
> -               goto out_destroy_group;
> -       }
> +       if (unlikely(!group->overflow_event))
> +               return -ENOMEM;
>
>         if (force_o_largefile())
>                 event_f_flags |=3D O_LARGEFILE;
> @@ -1738,8 +1735,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>                 group->priority =3D FSNOTIFY_PRIO_PRE_CONTENT;
>                 break;
>         default:
> -               fd =3D -EINVAL;
> -               goto out_destroy_group;
> +               return -EINVAL;
>         }
>
>         BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
> @@ -1750,27 +1746,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>         }
>
>         if (flags & FAN_ENABLE_AUDIT) {
> -               fd =3D -EPERM;
>                 if (!capable(CAP_AUDIT_WRITE))
> -                       goto out_destroy_group;
> -       }
> -
> -       fd =3D get_unused_fd_flags(f_flags);
> -       if (fd < 0)
> -               goto out_destroy_group;
> -
> -       file =3D anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, g=
roup,
> -                                       f_flags, FMODE_NONOTIFY);
> -       if (IS_ERR(file)) {
> -               put_unused_fd(fd);
> -               fd =3D PTR_ERR(file);
> -               goto out_destroy_group;
> +                       return -EPERM;
>         }
> -       fd_install(fd, file);
> -       return fd;
>
> -out_destroy_group:
> -       fsnotify_destroy_group(group);
> +       fd =3D FD_ADD(f_flags,
> +                   anon_inode_getfile_fmode("[fanotify]", &fanotify_fops=
,
> +                                            group, f_flags, FMODE_NONOTI=
FY));
> +       if (fd >=3D 0)
> +               retain_and_null_ptr(group);
>         return fd;
>  }
>
>
> --
> 2.47.3
>

