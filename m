Return-Path: <linux-fsdevel+bounces-62265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4016B8B8DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 00:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978821CC3C38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF23245022;
	Fri, 19 Sep 2025 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ics6AhMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56B2D249F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321425; cv=none; b=cIFP5X1h821vzggFObQGqoMvhmvYd7eByPS9u0XGwAUVljmkqiI9eGNSTKome9ulO0QdXrV5y2N1zXaKuiv81uYEzau4mEEJBsqIIGSOu2Aqp2qiDcCMNTUt16tQea24iZ9CkGWcVbwyMUMkt30MhEatRYYrZS75iGz21QS9+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321425; c=relaxed/simple;
	bh=uJ8m2NZX6JXnQKKA+zdGmOxS3OC4Ea4bmMr8x5ucnxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obQknuUC9Pmr05R0UELhvTDM2JBkrEFthrWqZH/8h3UiY0ip0jC64BqiprIX5OlmvP26WI55oV9lZom+pGpDnAcURN/tUUOOSiWcSyyYITUZ27WAlaiq9+DDqYUYaVDGAWw4qirqZUJ3XbAUnQAqDWQ++H6EhhHy3pVzoUtPOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ics6AhMx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so23510451cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758321423; x=1758926223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3O3+fGeiCoT/6/FJPjx7pd6Eokbtom126s5Fn+C9FQ=;
        b=Ics6AhMxw56RwzKD8hl98CcXt9LdyoVnQrdaAO8JEReiJMX6oqF8jgW+MKxIcAFOwv
         EQprWxdxZFXIThjI25S9INdHKk5loJCSC9icfDpExbA2UFImOgYxyKNG3dxgRZhjejPQ
         7lpTI56RyI/g43oFbzLet6VIdRGoeXXwrpLpVCYtJfqMo5884iUGkF83vcn8DHnkyPEF
         TTBkExQVaKwhoJoKK9J6lylaI5D+NgpWM0YGTBbcQxQq6WUgHiQGdbuVxb0X43rmlzt8
         qH6LccjEl3ClRWrk7ltVtN/g113LIwQ6RH4nj3Ssca+8cXOBrsy/1i4he2klRqgjpZXt
         VScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321423; x=1758926223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3O3+fGeiCoT/6/FJPjx7pd6Eokbtom126s5Fn+C9FQ=;
        b=hRVMOUAzQZw0APDpl5W0L5ehtUZZe8iFWItHxmyY7NVYpMYBhnQYmBjyhcMqOcWeGX
         IRpz/fKDi1AbEpGUsfAqu8bi5J4zeIS3iTBngEgSONRKj7Zg0OHH0VEotgBVgrzfE/FS
         Ccvx+kQXT2lmA+q8a/+CV9JhEJ3assTUIDL7EZy2TBD+Wro66h0fdFN+3s7YzZLNWgx4
         8XeCo58I2T3DiLzjWQYxtFtCQ4uJGg7zcycF1M897cKk8TglP9V3cq9VXeEwKzoDspHU
         UjFoCxXtdxVCKwr5cMvoTNBQhWUZyXJAlWFzSq89LM1Z0yAIjUb9/DWLEpAPfkXBnAsI
         kWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR+U14i9mr+3tCjk7jlLqXK6t96wySt8CHp9nuUWApSAr1y2Iei0b90s4cztydErju2+yKYIfbVzqZbD0v@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMhhLktAIM3WT/golI9HoRuX3d2Ly4VgCHPLGFNFiLWrT26fo
	x1TsemyY8SlmH/oi3xTwltIu09rUbNXcyczRPSOSZAUN4FJmWbQsiObVgLAD/DvhTTDaVWM2otd
	ezewwBTUv9vHfCX4a078kC+/aA2TXv+M=
X-Gm-Gg: ASbGncu8+pYk3u01CjVW7Lgs+YNb/nweiZcbKI3G1zzr2ObcwcZnISkL8hbdS16HD8X
	27wemGvvhO8CrT5YnVyUTNxv2fdR9pVhTmgFThoBnd7SGXnPch4+P3YngjGmgHUIm3hOxrU6eg4
	dowbDqW/pbK45b4hg9fx/VPsIG3u/ApOA2KKF21cSMQ4C3L9p0B52ooh1Lj5fQdTxp+/TAO6RyM
	huVftrKB4/rFPC9rTgD9o1vUR077Jd/IW2RnaGN
X-Google-Smtp-Source: AGHT+IHWQvxkAk9J4PgdqySQm/TRIxJdbaJkIs2XbDQx5JYH/WsCKYtGeQrei4+rJpAYXXWVlZS2x1/ooQEaV6zafXQ=
X-Received: by 2002:a05:622a:5507:b0:4b5:e8e0:4f93 with SMTP id
 d75a77b69052e-4c0718f6543mr55734631cf.54.1758321422899; Fri, 19 Sep 2025
 15:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs> <175798151288.382724.14189484118371001092.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151288.382724.14189484118371001092.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 15:36:52 -0700
X-Gm-Features: AS18NWCO71nVFhYakayYK0yIAhj-E3b2dx_XnAizS9jPLGzxwTNx6Ok68GwG8No
Message-ID: <CAJnrk1YtGcWj_0MOxS6atL_vrUjk09MzQhFt40yf32Rq12k0qw@mail.gmail.com>
Subject: Re: [PATCH 01/28] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 5:28=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Implement functions to enable upcalling of iomap_begin and iomap_end to
> userspace fuse servers.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   35 ++++
>  fs/fuse/iomap_priv.h      |   36 ++++
>  include/uapi/linux/fuse.h |   90 +++++++++
>  fs/fuse/Kconfig           |   32 +++
>  fs/fuse/Makefile          |    1
>  fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c           |    9 +
>  7 files changed, 636 insertions(+), 1 deletion(-)
>  create mode 100644 fs/fuse/iomap_priv.h
>  create mode 100644 fs/fuse/file_iomap.c
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 4560687d619d76..f0d408a6e12c32 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -923,6 +923,9 @@ struct fuse_conn {
>         /* Is synchronous FUSE_INIT allowed? */
>         unsigned int sync_init:1;
>
> +       /* Enable fs/iomap for file operations */
> +       unsigned int iomap:1;
> +
>         /* Use io_uring for communication */
>         unsigned int io_uring;
>
> @@ -1047,6 +1050,11 @@ static inline struct fuse_mount *get_fuse_mount_su=
per(struct super_block *sb)
>         return sb->s_fs_info;
>  }
>
> +static inline const struct fuse_mount *get_fuse_mount_super_c(const stru=
ct super_block *sb)
> +{
> +       return sb->s_fs_info;
> +}
> +
>  static inline struct fuse_conn *get_fuse_conn_super(struct super_block *=
sb)
>  {
>         return get_fuse_mount_super(sb)->fc;
> @@ -1057,16 +1065,31 @@ static inline struct fuse_mount *get_fuse_mount(s=
truct inode *inode)
>         return get_fuse_mount_super(inode->i_sb);
>  }
>
> +static inline const struct fuse_mount *get_fuse_mount_c(const struct ino=
de *inode)
> +{
> +       return get_fuse_mount_super_c(inode->i_sb);
> +}
> +
>  static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
>  {
>         return get_fuse_mount_super(inode->i_sb)->fc;
>  }
>
> +static inline const struct fuse_conn *get_fuse_conn_c(const struct inode=
 *inode)
> +{
> +       return get_fuse_mount_super_c(inode->i_sb)->fc;
> +}
> +
>  static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
>  {
>         return container_of(inode, struct fuse_inode, inode);
>  }
>
> +static inline const struct fuse_inode *get_fuse_inode_c(const struct ino=
de *inode)
> +{
> +       return container_of(inode, struct fuse_inode, inode);
> +}

Do we need these new set of helpers? AFAICT it does two things: a)
guarantee constness of the arg passed in b) guarantee constness of the
pointer returned

But it seems like for a) we could get that by modifying the existing
functions to take in a const arg, eg

-static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
+static inline struct fuse_inode *get_fuse_inode(const struct inode *inode)
 {
      return container_of(inode, struct fuse_inode, inode);
 }

and for b) it seems to me like the caller enforces the constness of
the pointer returned whether the actual function returns a const
pointer or not,

eg
const struct fuse_inode *fi =3D get_fuse_inode{_c}(inode);

Maybe I'm missing something here but it seems to me like we don't need
these new helpers?

> +
> diff --git a/fs/fuse/iomap_priv.h b/fs/fuse/iomap_priv.h

btw, i think the general convention is to use "_i.h" suffixing for
private internal files, eg fuse_i.h, fuse_dev_i.h, dev_uring_i.h

> new file mode 100644
> index 00000000000000..243d92cb625095
> --- /dev/null
> +++ b/fs/fuse/iomap_priv.h
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> + * Author: Darrick J. Wong <djwong@kernel.org>
> + */
> +#ifndef _FS_FUSE_IOMAP_PRIV_H
> +#define _FS_FUSE_IOMAP_PRIV_H
> +
...
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 31b80f93211b81..3634cbe602cd9c 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -235,6 +235,9 @@
>   *
>   *  7.44
>   *  - add FUSE_NOTIFY_INC_EPOCH
> + *
> + *  7.99

Just curious, where did you get the .99 from?

> + *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operat=
ions
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -270,7 +273,7 @@
>  #define FUSE_KERNEL_VERSION 7
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 9563fa5387a241..67dfe300bf2e07 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -69,6 +69,38 @@ config FUSE_PASSTHROUGH
> +config FUSE_IOMAP_DEBUG
> +       bool "Debug FUSE file IO over iomap"
> +       default n
> +       depends on FUSE_IOMAP
> +       help
> +         Enable debugging assertions for the fuse iomap code paths and l=
ogging
> +         of bad iomap file mapping data being sent to the kernel.
> +

I wonder if we should have a general FUSE_DEBUG that this would fall
under instead of creating one that's iomap_debug specific

>  config FUSE_IO_URING
>         bool "FUSE communication over io-uring"
>         default y
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 46041228e5be2c..27be39317701d6 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -18,5 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
>  fuse-$(CONFIG_FUSE_BACKING) +=3D backing.o
>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
> +fuse-$(CONFIG_FUSE_IOMAP) +=3D file_iomap.o
>
>  virtiofs-y :=3D virtio_fs.o
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> new file mode 100644
> index 00000000000000..dda757768d3ea6
> --- /dev/null
> +++ b/fs/fuse/file_iomap.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> + * Author: Darrick J. Wong <djwong@kernel.org>
> + */
> +#include <linux/iomap.h>
> +#include "fuse_i.h"
> +#include "fuse_trace.h"
> +#include "iomap_priv.h"
> +
> +/* Validate FUSE_IOMAP_TYPE_* */
> +static inline bool fuse_iomap_check_type(uint16_t fuse_type)
> +{
> +       switch (fuse_type) {
> +       case FUSE_IOMAP_TYPE_HOLE:
> +       case FUSE_IOMAP_TYPE_DELALLOC:
> +       case FUSE_IOMAP_TYPE_MAPPED:
> +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> +       case FUSE_IOMAP_TYPE_INLINE:
> +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> +               return true;
> +       }
> +
> +       return false;
> +}

Maybe faster to check by using a bitmask instead?


> +
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 1e7298b2b89b58..32f4b7c9a20a8a 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1448,6 +1448,13 @@ static void process_init_reply(struct fuse_mount *=
fm, struct fuse_args *args,
>
>                         if (flags & FUSE_REQUEST_TIMEOUT)
>                                 timeout =3D arg->request_timeout;
> +
> +                       if ((flags & FUSE_IOMAP) && fuse_iomap_enabled())=
 {
> +                               fc->local_fs =3D 1;
> +                               fc->iomap =3D 1;
> +                               printk(KERN_WARNING
> + "fuse: EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
> +                       }

pr_warn() seems to be the convention elsewhere in the fuse code


Thanks,
Joanne
>                 } else {
>                         ra_pages =3D fc->max_read / PAGE_SIZE;
>                         fc->no_lock =3D 1;
> @@ -1516,6 +1523,8 @@ static struct fuse_init_args *fuse_new_init(struct =
fuse_mount *fm)
>          */
>         if (fuse_uring_enabled())
>                 flags |=3D FUSE_OVER_IO_URING;
> +       if (fuse_iomap_enabled())
> +               flags |=3D FUSE_IOMAP;
>
>         ia->in.flags =3D flags;
>         ia->in.flags2 =3D flags >> 32;
>

