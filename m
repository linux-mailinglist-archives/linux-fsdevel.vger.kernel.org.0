Return-Path: <linux-fsdevel+bounces-58574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA25B2EF7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A6056330A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248172E8DE8;
	Thu, 21 Aug 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWYz0Uwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEC27B352
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760925; cv=none; b=DZvw8z/QjeWO1Cyon/yldIl9CAE6NwQk4Pzp2A9bwNwfYhWsgI3uf2siXZYsm8UpUuaMkth6IIR2nHuho2Gde+2t39c7dyh/f/LKx8RuHQRmzOCv2rXeFc03B9kNGdA23dKiWiP0W2cXenEh2CpXZXMW8vMi1Ru2UQYgc8XZGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760925; c=relaxed/simple;
	bh=6EU3OMfO5RrKAvgQMCnzUM2vTRy+Ivk/likmuLwdrQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k85Ev1AZZzEDiwJu3etdt2qkrpOKK06LJD2k4dCo3d/l0F3EztUIVaMn2WIAa5YYaSjklcdx/P9DfMYTVAiLv78OLEVJWhnsQAmu0UxZN9RdeklxppPV3bLUQJMYUrTN4vDc93NCD7zttcBtkSCPBIkrO9TMIULttEpoIbD3VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWYz0Uwo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b73bef3so1274293a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755760922; x=1756365722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TM59zyPuo2tjlxiY1TBIU0YXDSOfTKqmMPKP1skhd/s=;
        b=MWYz0UwoyPeG8Nmc9W417WH27dLaOMnb4ckxeAYBOiNGz8fECDGiyFCXAKpa1LXyzI
         Gle8hC1ZMctqTEjKiTEr/fupRKGBkQnvbwBxFiHsIAsu9WCh22ums6eLn0hjgkxmoRAQ
         Te2h157Ax6GaUThhw0c0+GASl3sQyn0X2stopJb9gCapS0Q5D268hJcRTve8696vVWh4
         0MM52CEPqwneq+IujSjzXuBsR9fQK11tbeZktdF93Ataq+Ob3jkOHyn7bkWUyOL8t0L2
         Kl5XYxYcn6mpC6zj9l3Z7I1FsVf3FDxvEhuX4nbi+Tdd7Oz54BPlNguqurwXdT5HS7X9
         he5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755760922; x=1756365722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM59zyPuo2tjlxiY1TBIU0YXDSOfTKqmMPKP1skhd/s=;
        b=OwFI0c/vkT/UXGIGx+LjjwIWO49Bz9/ujfO9aNWCtlpuZYr1sj4T/mxEzyaq7ziQDS
         Vq1cyh1yZWKJhDOcyl5FMjabju4ifFpQxfl69+B2Kjfok5yuf4KJ+Wb/ZwcTx/PwO28I
         pB5heYeVzboS7Nb0Zp14kZGVw/u5EvEm11i8kJRsLIvVqBTu5gPJdvRpKExY3FXOM223
         Ol0OQwlaFfBf6AlqO3rRCtdvnHsGGWj5PR3Dn6GXdJyyc6vqlfKvtn/ZdzZFsLFmy8qU
         XF1VYBASXgr+aQmT4KqnTDaVo6abKNAKtxF/zNjEhZKfYA/SKN9BlKHZtzBGL1ila1vy
         13ng==
X-Forwarded-Encrypted: i=1; AJvYcCVoljjWi1pkItJiZTQ0JnkJAw4x6y5GNMxYMbDyu+vREfAqe7aYTMFVHY0yW93zK5njNKlh4PRmfRIo678Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtzZqIJ3cgI1M5aosTMeJ0tD0W/sh5EL3w2T96sU669U2OY2d
	9V13C8iks9IdkP8sT+xJTk6H+iRrMSKg9EJVBtXLFwNfHL9wykpY8u3Sy8ngrit211n/uIYBLtz
	eIoBTmASz/G97gijTjV3DIFmsogtwULo=
X-Gm-Gg: ASbGncsUkzlNKm8BTZUy38RuKv05IxRMOdYuF8OCBGMKkaWj+tWy5KK64R+mwiO46I2
	YhnuFdRZxPoa/RQT3QMg1P1sY4PlDPcSzWFrI7WG5fa//qlvJMhEEPWW4mz1hR++V6WHz9qUs4h
	TuVtoO3WLJVMHBjmQzz0QNSRQv8v4n23JxYQdszqUTjQwfhs2i1Vyyo/zuGzciD4hW27wgEDaxR
	JC5Ag8=
X-Google-Smtp-Source: AGHT+IHYzI6UeOxG8Lh9z7kN3U5Ewa+j2P1dOM/QIvzHWdNS2VTnh5ahOE3JlF1qSyM0SphR6/egi0b/VCzn3ozvhb4=
X-Received: by 2002:a05:6402:13cf:b0:618:682f:14d0 with SMTP id
 4fb4d7f45d1cf-61bf872830dmr1225498a12.21.1755760921383; Thu, 21 Aug 2025
 00:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs> <175573709201.17510.5887930789458651774.stgit@frogsfrogsfrogs>
In-Reply-To: <175573709201.17510.5887930789458651774.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Aug 2025 09:21:49 +0200
X-Gm-Features: Ac12FXyOiPnoiMNy__MT6E5TvaXSDkjJoD6lQ5EMaHMTUwq8EWWdY2rqCjQHASk
Message-ID: <CAOQ4uxi_aUvi5o=uLTonKViu3P-wZg_K8vs9m2DMSzOiDpA19w@mail.gmail.com>
Subject: Re: [PATCH 04/23] fuse: move the backing file idr and code into a new
 source file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> iomap support for fuse is also going to want the ability to attach
> backing files to a fuse filesystem.  Move the fuse_backing code into a
> separate file so that both can use it.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Are you going to make FUSE_IOMAP depend on FUSE_PASSTHROUGH later on?
I can't think of a reason why not.

Thanks,
Amir.

> ---
>  fs/fuse/fuse_i.h      |   47 ++++++++-----
>  fs/fuse/Makefile      |    2 -
>  fs/fuse/backing.c     |  174 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/passthrough.c |  158 -------------------------------------------=
-
>  4 files changed, 203 insertions(+), 178 deletions(-)
>  create mode 100644 fs/fuse/backing.c
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 2cd9f4cdc6a7ef..2be2cbdf060536 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1535,29 +1535,11 @@ struct fuse_file *fuse_file_open(struct fuse_moun=
t *fm, u64 nodeid,
>  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
>                        unsigned int open_flags, fl_owner_t id, bool isdir=
);
>
> -/* passthrough.c */
> -static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode =
*fi)
> -{
> -#ifdef CONFIG_FUSE_PASSTHROUGH
> -       return READ_ONCE(fi->fb);
> -#else
> -       return NULL;
> -#endif
> -}
> -
> -static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_in=
ode *fi,
> -                                                         struct fuse_bac=
king *fb)
> -{
> -#ifdef CONFIG_FUSE_PASSTHROUGH
> -       return xchg(&fi->fb, fb);
> -#else
> -       return NULL;
> -#endif
> -}
> -
> +/* backing.c */
>  #ifdef CONFIG_FUSE_PASSTHROUGH
>  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
>  void fuse_backing_put(struct fuse_backing *fb);
> +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id);
>  #else
>
>  static inline struct fuse_backing *fuse_backing_get(struct fuse_backing =
*fb)
> @@ -1568,6 +1550,11 @@ static inline struct fuse_backing *fuse_backing_ge=
t(struct fuse_backing *fb)
>  static inline void fuse_backing_put(struct fuse_backing *fb)
>  {
>  }
> +static inline struct fuse_backing *fuse_backing_lookup(struct fuse_conn =
*fc,
> +                                                      int backing_id)
> +{
> +       return NULL;
> +}
>  #endif
>
>  void fuse_backing_files_init(struct fuse_conn *fc);
> @@ -1575,6 +1562,26 @@ void fuse_backing_files_free(struct fuse_conn *fc)=
;
>  int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
);
>  int fuse_backing_close(struct fuse_conn *fc, int backing_id);
>
> +/* passthrough.c */
> +static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode =
*fi)
> +{
> +#ifdef CONFIG_FUSE_PASSTHROUGH
> +       return READ_ONCE(fi->fb);
> +#else
> +       return NULL;
> +#endif
> +}
> +
> +static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_in=
ode *fi,
> +                                                         struct fuse_bac=
king *fb)
> +{
> +#ifdef CONFIG_FUSE_PASSTHROUGH
> +       return xchg(&fi->fb, fb);
> +#else
> +       return NULL;
> +#endif
> +}
> +
>  struct fuse_backing *fuse_passthrough_open(struct file *file,
>                                            struct inode *inode,
>                                            int backing_id);
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 70709a7a3f9523..c79f786d0c90c3 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -14,7 +14,7 @@ fuse-y :=3D trace.o     # put trace.o first so we see f=
trace errors sooner
>  fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o
>  fuse-y +=3D iomode.o
>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> -fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> +fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
>  fuse-$(CONFIG_FUSE_IOMAP) +=3D file_iomap.o
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> new file mode 100644
> index 00000000000000..ddb23b7400fc72
> --- /dev/null
> +++ b/fs/fuse/backing.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FUSE passthrough to backing file.
> + *
> + * Copyright (c) 2023 CTERA Networks.
> + */
> +
> +#include "fuse_i.h"
> +
> +#include <linux/file.h>
> +
> +struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
> +{
> +       if (fb && refcount_inc_not_zero(&fb->count))
> +               return fb;
> +       return NULL;
> +}
> +
> +static void fuse_backing_free(struct fuse_backing *fb)
> +{
> +       pr_debug("%s: fb=3D0x%p\n", __func__, fb);
> +
> +       if (fb->file)
> +               fput(fb->file);
> +       put_cred(fb->cred);
> +       kfree_rcu(fb, rcu);
> +}
> +
> +void fuse_backing_put(struct fuse_backing *fb)
> +{
> +       if (fb && refcount_dec_and_test(&fb->count))
> +               fuse_backing_free(fb);
> +}
> +
> +void fuse_backing_files_init(struct fuse_conn *fc)
> +{
> +       idr_init(&fc->backing_files_map);
> +}
> +
> +static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backi=
ng *fb)
> +{
> +       int id;
> +
> +       idr_preload(GFP_KERNEL);
> +       spin_lock(&fc->lock);
> +       /* FIXME: xarray might be space inefficient */
> +       id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATO=
MIC);
> +       spin_unlock(&fc->lock);
> +       idr_preload_end();
> +
> +       WARN_ON_ONCE(id =3D=3D 0);
> +       return id;
> +}
> +
> +static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
> +                                                  int id)
> +{
> +       struct fuse_backing *fb;
> +
> +       spin_lock(&fc->lock);
> +       fb =3D idr_remove(&fc->backing_files_map, id);
> +       spin_unlock(&fc->lock);
> +
> +       return fb;
> +}
> +
> +static int fuse_backing_id_free(int id, void *p, void *data)
> +{
> +       struct fuse_backing *fb =3D p;
> +
> +       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> +       fuse_backing_free(fb);
> +       return 0;
> +}
> +
> +void fuse_backing_files_free(struct fuse_conn *fc)
> +{
> +       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> +       idr_destroy(&fc->backing_files_map);
> +}
> +
> +int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
> +{
> +       struct file *file;
> +       struct super_block *backing_sb;
> +       struct fuse_backing *fb =3D NULL;
> +       int res;
> +
> +       pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
> +
> +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> +       res =3D -EPERM;
> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +               goto out;
> +
> +       res =3D -EINVAL;
> +       if (map->flags || map->padding)
> +               goto out;
> +
> +       file =3D fget_raw(map->fd);
> +       res =3D -EBADF;
> +       if (!file)
> +               goto out;
> +
> +       backing_sb =3D file_inode(file)->i_sb;
> +       res =3D -ELOOP;
> +       if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> +               goto out_fput;
> +
> +       fb =3D kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
> +       res =3D -ENOMEM;
> +       if (!fb)
> +               goto out_fput;
> +
> +       fb->file =3D file;
> +       fb->cred =3D prepare_creds();
> +       refcount_set(&fb->count, 1);
> +
> +       res =3D fuse_backing_id_alloc(fc, fb);
> +       if (res < 0) {
> +               fuse_backing_free(fb);
> +               fb =3D NULL;
> +       }
> +
> +out:
> +       pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
> +
> +       return res;
> +
> +out_fput:
> +       fput(file);
> +       goto out;
> +}
> +
> +int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> +{
> +       struct fuse_backing *fb =3D NULL;
> +       int err;
> +
> +       pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
> +
> +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> +       err =3D -EPERM;
> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +               goto out;
> +
> +       err =3D -EINVAL;
> +       if (backing_id <=3D 0)
> +               goto out;
> +
> +       err =3D -ENOENT;
> +       fb =3D fuse_backing_id_remove(fc, backing_id);
> +       if (!fb)
> +               goto out;
> +
> +       fuse_backing_put(fb);
> +       err =3D 0;
> +out:
> +       pr_debug("%s: fb=3D0x%p, err=3D%i\n", __func__, fb, err);
> +
> +       return err;
> +}
> +
> +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id)
> +{
> +       struct fuse_backing *fb;
> +
> +       rcu_read_lock();
> +       fb =3D idr_find(&fc->backing_files_map, backing_id);
> +       fb =3D fuse_backing_get(fb);
> +       rcu_read_unlock();
> +
> +       return fb;
> +}
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 607ef735ad4ab3..e0b8d885bc81f3 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -144,158 +144,6 @@ ssize_t fuse_passthrough_mmap(struct file *file, st=
ruct vm_area_struct *vma)
>         return backing_file_mmap(backing_file, vma, &ctx);
>  }
>
> -struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
> -{
> -       if (fb && refcount_inc_not_zero(&fb->count))
> -               return fb;
> -       return NULL;
> -}
> -
> -static void fuse_backing_free(struct fuse_backing *fb)
> -{
> -       pr_debug("%s: fb=3D0x%p\n", __func__, fb);
> -
> -       if (fb->file)
> -               fput(fb->file);
> -       put_cred(fb->cred);
> -       kfree_rcu(fb, rcu);
> -}
> -
> -void fuse_backing_put(struct fuse_backing *fb)
> -{
> -       if (fb && refcount_dec_and_test(&fb->count))
> -               fuse_backing_free(fb);
> -}
> -
> -void fuse_backing_files_init(struct fuse_conn *fc)
> -{
> -       idr_init(&fc->backing_files_map);
> -}
> -
> -static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backi=
ng *fb)
> -{
> -       int id;
> -
> -       idr_preload(GFP_KERNEL);
> -       spin_lock(&fc->lock);
> -       /* FIXME: xarray might be space inefficient */
> -       id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATO=
MIC);
> -       spin_unlock(&fc->lock);
> -       idr_preload_end();
> -
> -       WARN_ON_ONCE(id =3D=3D 0);
> -       return id;
> -}
> -
> -static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
> -                                                  int id)
> -{
> -       struct fuse_backing *fb;
> -
> -       spin_lock(&fc->lock);
> -       fb =3D idr_remove(&fc->backing_files_map, id);
> -       spin_unlock(&fc->lock);
> -
> -       return fb;
> -}
> -
> -static int fuse_backing_id_free(int id, void *p, void *data)
> -{
> -       struct fuse_backing *fb =3D p;
> -
> -       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> -       fuse_backing_free(fb);
> -       return 0;
> -}
> -
> -void fuse_backing_files_free(struct fuse_conn *fc)
> -{
> -       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> -       idr_destroy(&fc->backing_files_map);
> -}
> -
> -int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
> -{
> -       struct file *file;
> -       struct super_block *backing_sb;
> -       struct fuse_backing *fb =3D NULL;
> -       int res;
> -
> -       pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
> -
> -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> -       res =3D -EPERM;
> -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> -               goto out;
> -
> -       res =3D -EINVAL;
> -       if (map->flags || map->padding)
> -               goto out;
> -
> -       file =3D fget_raw(map->fd);
> -       res =3D -EBADF;
> -       if (!file)
> -               goto out;
> -
> -       backing_sb =3D file_inode(file)->i_sb;
> -       res =3D -ELOOP;
> -       if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> -               goto out_fput;
> -
> -       fb =3D kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
> -       res =3D -ENOMEM;
> -       if (!fb)
> -               goto out_fput;
> -
> -       fb->file =3D file;
> -       fb->cred =3D prepare_creds();
> -       refcount_set(&fb->count, 1);
> -
> -       res =3D fuse_backing_id_alloc(fc, fb);
> -       if (res < 0) {
> -               fuse_backing_free(fb);
> -               fb =3D NULL;
> -       }
> -
> -out:
> -       pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
> -
> -       return res;
> -
> -out_fput:
> -       fput(file);
> -       goto out;
> -}
> -
> -int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> -{
> -       struct fuse_backing *fb =3D NULL;
> -       int err;
> -
> -       pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
> -
> -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> -       err =3D -EPERM;
> -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> -               goto out;
> -
> -       err =3D -EINVAL;
> -       if (backing_id <=3D 0)
> -               goto out;
> -
> -       err =3D -ENOENT;
> -       fb =3D fuse_backing_id_remove(fc, backing_id);
> -       if (!fb)
> -               goto out;
> -
> -       fuse_backing_put(fb);
> -       err =3D 0;
> -out:
> -       pr_debug("%s: fb=3D0x%p, err=3D%i\n", __func__, fb, err);
> -
> -       return err;
> -}
> -
>  /*
>   * Setup passthrough to a backing file.
>   *
> @@ -315,12 +163,8 @@ struct fuse_backing *fuse_passthrough_open(struct fi=
le *file,
>         if (backing_id <=3D 0)
>                 goto out;
>
> -       rcu_read_lock();
> -       fb =3D idr_find(&fc->backing_files_map, backing_id);
> -       fb =3D fuse_backing_get(fb);
> -       rcu_read_unlock();
> -
>         err =3D -ENOENT;
> +       fb =3D fuse_backing_lookup(fc, backing_id);
>         if (!fb)
>                 goto out;
>
>
>

