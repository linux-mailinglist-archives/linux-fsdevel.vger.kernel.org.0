Return-Path: <linux-fsdevel+bounces-34878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B29CDAEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438CBB255DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A518FC74;
	Fri, 15 Nov 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgTozD10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A6618D622;
	Fri, 15 Nov 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660678; cv=none; b=Hlekv/HrOB6qw3raZxsysPB+HZ22dx2VIvrETlvvmG3ulsp4LtEAykNGc0Js7aZn+5iiaMqwf2hfXraMmaHDEnGoL8p6aAVztY++Qs38yg+lMyB0oh9Slvs3Ae8fk4FIPfceeAbpoykav5XJT6A9ap901q49nfiQZM/cOstgvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660678; c=relaxed/simple;
	bh=IDDtktDLwP0qAgJC0D9PubIcErY5MwpxzPAS/SeEg7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhFUbE4YnHYD8c72I64bxRTEStGzohb+aKnOgjDYq2RVEIpoIxEjfC6cuCSOthiOG74llL9p6BjwYLXLTurvzfPe/HY4+wa7Etk36WshMRGYHRzuhzC0xQ3v3q6PvxI1pQbyxOYIdy7aGVQ1c2R+358XhMB6yeWpj3DQgAxK2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgTozD10; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa20c733e92so64281066b.0;
        Fri, 15 Nov 2024 00:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731660674; x=1732265474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQeS1B4d8WAUBiwGM9M4b/ckH0pDS9RfJAuzaYkRioI=;
        b=ZgTozD10T3GhBvCwVDpJiMFwta1SsSmPB7eP7LfrZr3RnIpY52Dkk0VSsFr9tdrFBY
         lakGPEn09MmJjeBWpCHjaApQRPVZHe1T00Jwh3mHDyEooHJLalUSVsFRBqg4TwdDh3f1
         lXq6CqewuVgRAsQKHH4f3XikKvGWiK7ZmBildE0oNJLfQHY1PmdxkpQEDN8PGScvCK94
         5kBm+WRVSvabBRYppRl38SqUv9S6N3cYu5XJqQ0vAiFCPZlTWkkSzrOv0fCJT+YTNreA
         H35M0kj9v6/j7xCbsKneADb/6q/0AaDPNRj5zOyZ64Kz0glzGhYCN1DeKN056mOioGlT
         7rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660674; x=1732265474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQeS1B4d8WAUBiwGM9M4b/ckH0pDS9RfJAuzaYkRioI=;
        b=LYQ34r9b84OlmdvXcTTIfR+zQeLWuQtTqvkyXi30XJQMz3CIeTgeUXua/IK6+nu1jZ
         4VXxG357wen656zDWPJTtDNPjZaaysq4ODn/hJiAwf5IIor57tFdcPE+A9gx5DP9YFZX
         mWINcCyJN0KO2rGXzhWRtqzDgRGw9UgKgEvGmvTwx+um4WwNhgOaS8/U8953CNta53qH
         Nl4go5iD8k0aLU2TWMnOfNYjGiLA3BTo+/yeIaE6lFb7kF9aud6x7HT51hPIYGpNpTBi
         FZamYbVUBDBripiQiaPtq3qpEMuN+PdGBz+mgFtaj78QAdhfz9RY+hLL+iRo+onJivhI
         2yYw==
X-Forwarded-Encrypted: i=1; AJvYcCWNrR3CDdRG+x3d8GcWIfJpo/bA75avaMRirlXNJ/D4KGnlFV432H8b52EtoZHHso3rkchE2nBUDlSe0Th7kg/g7To9XW+G@vger.kernel.org, AJvYcCXTftrou0nzAPg08ON6lK9UHifViiuMyZqNGXYNSx8zqh7/yOVZPeEnsV4NPDYFARCnoRlM6EcmyI75XG/e@vger.kernel.org, AJvYcCXpS2PfcZWhik01N3Zz9ZSg4VW+z568wYkFfE1XGonHgPqlgfyS0tyVg37ms/Cc68HkUvma3/qh3sdlswNM@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqEMSVW97U8yrZX3tT8/et67DWzV7oauuwkwLoIsusvE42sn3
	s7fiHq88BZGzwnVYlUT0o/laa+aUxIyTD4jJzNG+Ok9t1eLZphUULf38NT1NPJc2ps9wSxRuLIu
	+OUhun7dJlbRN2QfM/4BR0sUYycQ=
X-Google-Smtp-Source: AGHT+IGKfSTOg6x0Z08frLiT8lNJLV2fwoZT7W4fNbV7m3f4x+0eisTDSrwGEYppIv5w2GfL3RuWoHmSEOeT2BWwfF4=
X-Received: by 2002:a17:907:26cb:b0:a9a:3f9d:62f8 with SMTP id
 a640c23a62f3a-aa48341362cmr173901366b.19.1731660673989; Fri, 15 Nov 2024
 00:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-2-song@kernel.org>
In-Reply-To: <20241114084345.1564165-2-song@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Nov 2024 09:51:02 +0100
Message-ID: <CAOQ4uxjFpsOLipPN5tXgBG4SsLJEFpndnmoc67Nr7z66QTuHnQ@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 1/7] fanotify: Introduce fanotify
 fastpath handler
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:44=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> fanotify fastpath handler enables handling fanotify events within the
> kernel, and thus saves a trip to the user space. fanotify fastpath handle=
r
> can be useful in many use cases. For example, if a user is only intereste=
d
> in events for some files in side a directory, a fastpath handler can be
> used to filter out irrelevant events.
>
> fanotify fastpath handler is attached to fsnotify_group. At most one
> fastpath handler can be attached to a fsnotify_group. The attach/detach
> of fastpath handlers are controlled by two new ioctls on the fanotify fds=
:
> FAN_IOC_ADD_FP and FAN_IOC_DEL_FP.
>
> fanotify fastpath handler is packaged in a kernel module. In the future,
> it is also possible to package fastpath handler in a BPF program. Since
> loading modules requires CAP_SYS_ADMIN, _loading_ fanotify fastpath
> handler in kernel modules is limited to CAP_SYS_ADMIN. However,
> non-SYS_CAP_ADMIN users can _attach_ fastpath handler loaded by sys admin
> to their fanotify fds. To make fanotify fastpath handler more useful
> for non-CAP_SYS_ADMIN users, a fastpath handler can take arguments at
> attach time.
>
> sysfs entry /sys/kernel/fanotify_fastpath is added to help users know
> which fastpath handlers are available. At the moment, files are added for
> each fastpath handler: flags, desc, and init_args.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/notify/fanotify/Kconfig             |  13 ++
>  fs/notify/fanotify/Makefile            |   1 +
>  fs/notify/fanotify/fanotify.c          |  29 +++
>  fs/notify/fanotify/fanotify_fastpath.c | 282 +++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify_user.c     |   7 +
>  include/linux/fanotify.h               | 131 ++++++++++++
>  include/linux/fsnotify_backend.h       |   4 +
>  include/uapi/linux/fanotify.h          |  25 +++
>  8 files changed, 492 insertions(+)
>  create mode 100644 fs/notify/fanotify/fanotify_fastpath.c
>
> diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
> index 0e36aaf379b7..74677d3699a3 100644
> --- a/fs/notify/fanotify/Kconfig
> +++ b/fs/notify/fanotify/Kconfig
> @@ -24,3 +24,16 @@ config FANOTIFY_ACCESS_PERMISSIONS
>            hierarchical storage management systems.
>
>            If unsure, say N.
> +
> +config FANOTIFY_FASTPATH
> +       bool "fanotify fastpath handler"
> +       depends on FANOTIFY
> +       default y
> +       help
> +          Say Y here if you want to use fanotify in kernel fastpath hand=
ler.
> +          The fastpath handler can be implemented in a kernel module or =
a
> +          BPF program. The fastpath handler can speed up fanotify in man=
y
> +          use cases. For example, when the listener is only interested i=
n
> +          a subset of events.
> +
> +          If unsure, say Y.
> \ No newline at end of file
> diff --git a/fs/notify/fanotify/Makefile b/fs/notify/fanotify/Makefile
> index 25ef222915e5..543cb7aa08fc 100644
> --- a/fs/notify/fanotify/Makefile
> +++ b/fs/notify/fanotify/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_FANOTIFY)         +=3D fanotify.o fanotify_user.o
> +obj-$(CONFIG_FANOTIFY_FASTPATH)        +=3D fanotify_fastpath.o
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 224bccaab4cc..b395b628a58b 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -18,6 +18,8 @@
>
>  #include "fanotify.h"
>
> +extern struct srcu_struct fsnotify_mark_srcu;
> +
>  static bool fanotify_path_equal(const struct path *p1, const struct path=
 *p2)
>  {
>         return p1->mnt =3D=3D p2->mnt && p1->dentry =3D=3D p2->dentry;
> @@ -888,6 +890,7 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         struct fsnotify_event *fsn_event;
>         __kernel_fsid_t fsid =3D {};
>         u32 match_mask =3D 0;
> +       struct fanotify_fastpath_hook *fp_hook __maybe_unused;
>
>         BUILD_BUG_ON(FAN_ACCESS !=3D FS_ACCESS);
>         BUILD_BUG_ON(FAN_MODIFY !=3D FS_MODIFY);
> @@ -933,6 +936,27 @@ static int fanotify_handle_event(struct fsnotify_gro=
up *group, u32 mask,
>         if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
>                 fsid =3D fanotify_get_fsid(iter_info);
>
> +#ifdef CONFIG_FANOTIFY_FASTPATH
> +       fp_hook =3D srcu_dereference(group->fanotify_data.fp_hook, &fsnot=
ify_mark_srcu);
> +       if (fp_hook) {
> +               struct fanotify_fastpath_event fp_event =3D {
> +                       .mask =3D mask,
> +                       .data =3D data,
> +                       .data_type =3D data_type,
> +                       .dir =3D dir,
> +                       .file_name =3D file_name,
> +                       .fsid =3D &fsid,
> +                       .match_mask =3D match_mask,
> +               };
> +
> +               ret =3D fp_hook->ops->fp_handler(group, fp_hook, &fp_even=
t);
> +               if (ret =3D=3D FAN_FP_RET_SKIP_EVENT) {
> +                       ret =3D 0;
> +                       goto finish;
> +               }
> +       }
> +#endif
> +

To me it makes sense that the fastpath module could also return a negative
(deny) result for permission events.

Is there a specific reason that you did not handle this or just didn't thin=
k
of this option?

Thanks,
Amir.

