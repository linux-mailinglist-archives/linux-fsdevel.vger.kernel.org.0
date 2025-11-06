Return-Path: <linux-fsdevel+bounces-67366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B743DC3D1D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581EE3A5452
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F4934F474;
	Thu,  6 Nov 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBMG/RVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0792E542A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455030; cv=none; b=Az1JmGYtZHxm0uklFokZi8PVYb66lQf7WfJre+sMUEt8kcJgcAELPvc+iPXbt596ErRku8bHbfEOIKx4eXi8d+a7Elwan8Wv22Lnm/MsUFKC4PQ8OP5KfhiKw//+oKAwL7Gd8ycwpWuOSiPwpkQunxOObPaT9hF2+ANGsti0OjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455030; c=relaxed/simple;
	bh=LX05HSaNor5rLAcJpbvEIhe/M5T8rjxwVfIWVRXLgtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4vHUu+0yCG+3o2KDzPwtPqmKucwNAosvniGYqBCuOeDjQ0+xHy+HPu2Hs/CtCanI9lzc0oI0PmxMvMfCs7Fu+FlIG7lV20I8HI+WhUAZZKMj3/Is/A13ML96T1ZmXzdZWJRb91xmBhXIVZT6oLcNV8OcHzDvsNJynKt4r/Wocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBMG/RVx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so1324803f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455027; x=1763059827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Efz25eKfuTYBZNfakEihvHVtSlYvik7xr2jyX6LRxw8=;
        b=aBMG/RVxPHfNg21lDtbjcjvFoYeCMJNdi3AnlKHcVwTCvmB/wlNnErPhAjHBaBwpdU
         Ss0THOww+0oRY6GLD689yaFWuihdIDlTcyA/ie4cGQOzN8KnEKCIn5Q3ESchYzS9JBmp
         rhN0k81PwPF7fsErbkNTV5E0k1tyNI4VlAqFDtWYpwxbQtr9lbJPU3zGa5cXINBAkZoy
         Or0cITQ3y9TZswnsUVe2CsVGVEO0U5s9YrCY/RAfcKu/DzcTE4vi3KtnRn26O9OfCnvM
         Nkzgecn0ne5Vzv5jpcK1koF7wMCozETkbtcmzR/dH2XFoymzvnNOqpN2o1kgV+m7ebcs
         D4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455027; x=1763059827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Efz25eKfuTYBZNfakEihvHVtSlYvik7xr2jyX6LRxw8=;
        b=dKCZzsBk+q4LcQ4sgsa6jxrJcJaF3AxxhE4/qdU/7nWAMQD9Dq9njpTPj3VZqvvc78
         N3avh/rqDzjp1V2UkN30m2bZAkMJG8NhxiJ36AIF0Xz9zJo+eykyQNylToFiNwvp/SNj
         lnXpaVzJMRKI6Y/332B345g7d42oC2MeMiFN7uHWB1pVQVnE2odc7yZbz83xMJZIcrAC
         R1Q5DvM3ZahgAXlT5LJNUmxfQx6cNpunPEyDrfMAiY2Yp0Ac7nEH78tmuM0wNlQxIlNM
         Fi3h0IFrOS2k7d+us4chdQSLRgnh517OgxLORDl0x0+uNWBpuO2+7ilsAjXQhBOsRzz7
         IBJg==
X-Forwarded-Encrypted: i=1; AJvYcCWnNj+2+t3Ct3NXo14JmLWpzzNalMrd4FnwevXiJyMWFP8PqZnSvNQAsrrfktDxn0AG4rdNPNL+Mn60xixP@vger.kernel.org
X-Gm-Message-State: AOJu0YyGA2rQsNHHG7y3ifu6XICFzSSacyFGz10HXHt2x1Osoh9B52i0
	3VhQdBT08w7zV+LamgWY9SgPPHIHyCcOZAWq1KWnBSfS49KquonRNjoQ7GoQ9XY20KTy4Wxz+cf
	u7mwp+o3O10HpW6axQ+gh6uwZcEjYqb8=
X-Gm-Gg: ASbGncvnDka46pbmtKiZNkwSPr+yaiCZotF3/6CcVKR3Y099e64XH/iIwDDLEOHV5FL
	HLzbJ6nNWhZfg21OZfHQKLsiaZNAoQuJnK7E1/hGAhq49UfzYHdPfZBUinG1Swbe+Hap8JuhEJb
	e6YsYl574QFUvQGuPV9mVkdYO/0Za0Do4kTGN6CSJC7hav5Fyowhrjpcc0idELOsOO6kKytIHtt
	WtkOdWgagXTqb3vmVp2SAmR9bC3lRuaC8wnE8U6ZygKYdZlAhWNVe05Yrpem29F2vcIy7eLNhPB
	xlYYtAOM78RDq1owjysfH16fJeJ/yg==
X-Google-Smtp-Source: AGHT+IFEVsK45J/C8LYLNqMj5xFjLzt31l4NVNj3Tknh1nCoh2MPbnhuLE1vD7oLLCq01ar/VZk4qlXQDF6NSntv+DU=
X-Received: by 2002:a05:6000:3110:b0:429:f088:7fb with SMTP id
 ffacd0b85a97d-42a95755e11mr614324f8f.7.1762455026487; Thu, 06 Nov 2025
 10:50:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810437.1424854.11837235220839490843.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810437.1424854.11837235220839490843.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 19:50:15 +0100
X-Gm-Features: AWmQ_bnmOMulIR-TRTfeders8dENoF1rFOJgOKmpjs5WgRV6afMRnZbvLuCNETQ
Message-ID: <CAOQ4uxgeZQYEY8WsthebjV9f4qZd+nWJnCGWog6D1=wu+MFpSQ@mail.gmail.com>
Subject: Re: [PATCH 04/31] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com, 
	neal@gompa.dev, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:56=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Enable the use of the backing file open/close ioctls so that fuse
> servers can register block devices for use with iomap.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  fs/fuse/fuse_i.h          |    5 ++
>  include/uapi/linux/fuse.h |    3 +
>  fs/fuse/Kconfig           |    1
>  fs/fuse/backing.c         |   12 +++++
>  fs/fuse/file_iomap.c      |  101 +++++++++++++++++++++++++++++++++++++++=
++----
>  fs/fuse/trace.c           |    1
>  6 files changed, 113 insertions(+), 10 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 61fb65f3604d61..274de907257d94 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -97,12 +97,14 @@ struct fuse_submount_lookup {
>  };
>
>  struct fuse_conn;
> +struct fuse_backing;
>
>  /** Operations for subsystems that want to use a backing file */
>  struct fuse_backing_ops {
>         int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
>         int (*may_open)(struct fuse_conn *fc, struct file *file);
>         int (*may_close)(struct fuse_conn *fc, struct file *file);
> +       int (*post_open)(struct fuse_conn *fc, struct fuse_backing *fb);
>         unsigned int type;
>         int id_start;
>         int id_end;
> @@ -112,6 +114,7 @@ struct fuse_backing_ops {
>  struct fuse_backing {
>         struct file *file;
>         struct cred *cred;
> +       struct block_device *bdev;
>         const struct fuse_backing_ops *ops;
>
>         /** refcount */
> @@ -1706,6 +1709,8 @@ static inline bool fuse_has_iomap(const struct inod=
e *inode)
>  {
>         return get_fuse_conn(inode)->iomap;
>  }
> +
> +extern const struct fuse_backing_ops fuse_iomap_backing_ops;
>  #else
>  # define fuse_iomap_enabled(...)               (false)
>  # define fuse_has_iomap(...)                   (false)
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 7d709cf12b41a7..e571f8ceecbfad 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1136,7 +1136,8 @@ struct fuse_notify_prune_out {
>
>  #define FUSE_BACKING_TYPE_MASK         (0xFF)
>  #define FUSE_BACKING_TYPE_PASSTHROUGH  (0)
> -#define FUSE_BACKING_MAX_TYPE          (FUSE_BACKING_TYPE_PASSTHROUGH)
> +#define FUSE_BACKING_TYPE_IOMAP                (1)
> +#define FUSE_BACKING_MAX_TYPE          (FUSE_BACKING_TYPE_IOMAP)
>
>  #define FUSE_BACKING_FLAGS_ALL         (FUSE_BACKING_TYPE_MASK)
>
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index bb867afe6e867c..52803c533f47f9 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -75,6 +75,7 @@ config FUSE_IOMAP
>         depends on FUSE_FS
>         depends on BLOCK
>         select FS_IOMAP
> +       select FUSE_BACKING
>         help
>           Enable fuse servers to operate the regular file I/O path throug=
h
>           the fs-iomap library in the kernel.  This enables higher perfor=
mance
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index b83a3c1b2dff7a..7786f6e5fd02f2 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -90,6 +90,10 @@ fuse_backing_ops_from_map(const struct fuse_backing_ma=
p *map)
>  #ifdef CONFIG_FUSE_PASSTHROUGH
>         case FUSE_BACKING_TYPE_PASSTHROUGH:
>                 return &fuse_passthrough_backing_ops;
> +#endif
> +#ifdef CONFIG_FUSE_IOMAP
> +       case FUSE_BACKING_TYPE_IOMAP:
> +               return &fuse_iomap_backing_ops;
>  #endif
>         default:
>                 break;
> @@ -138,8 +142,16 @@ int fuse_backing_open(struct fuse_conn *fc, struct f=
use_backing_map *map)
>         fb->file =3D file;
>         fb->cred =3D prepare_creds();
>         fb->ops =3D ops;
> +       fb->bdev =3D NULL;
>         refcount_set(&fb->count, 1);
>
> +       res =3D ops->post_open ? ops->post_open(fc, fb) : 0;
> +       if (res) {
> +               fuse_backing_free(fb);
> +               fb =3D NULL;
> +               goto out;
> +       }
> +
>         res =3D fuse_backing_id_alloc(fc, fb);
>         if (res < 0) {
>                 fuse_backing_free(fb);
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index b6fc70068c5542..e4fea3bdc0c2ce 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -319,10 +319,6 @@ static inline bool fuse_iomap_check_mapping(const st=
ruct inode *inode,
>                 return false;
>         }
>
> -       /* XXX: we don't support devices yet */
> -       if (BAD_DATA(map->dev !=3D FUSE_IOMAP_DEV_NULL))
> -               return false;
> -
>         /* No overflows in the device range, if supplied */
>         if (map->addr !=3D FUSE_IOMAP_NULL_ADDR &&
>             BAD_DATA(check_add_overflow(map->addr, map->length, &end)))
> @@ -334,6 +330,7 @@ static inline bool fuse_iomap_check_mapping(const str=
uct inode *inode,
>  /* Convert a mapping from the server into something the kernel can use *=
/
>  static inline void fuse_iomap_from_server(struct inode *inode,
>                                           struct iomap *iomap,
> +                                         const struct fuse_backing *fb,
>                                           const struct fuse_iomap_io *fma=
p)
>  {
>         iomap->addr =3D fmap->addr;
> @@ -341,7 +338,9 @@ static inline void fuse_iomap_from_server(struct inod=
e *inode,
>         iomap->length =3D fmap->length;
>         iomap->type =3D fuse_iomap_type_from_server(fmap->type);
>         iomap->flags =3D fuse_iomap_flags_from_server(fmap->flags);
> -       iomap->bdev =3D inode->i_sb->s_bdev; /* XXX */
> +
> +       iomap->bdev =3D fb ? fb->bdev : NULL;
> +       iomap->dax_dev =3D NULL;
>  }
>
>  /* Convert a mapping from the kernel into something the server can use *=
/
> @@ -392,6 +391,27 @@ static inline bool fuse_is_iomap_file_write(unsigned=
 int opflags)
>         return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
>  }
>
> +static inline struct fuse_backing *
> +fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *ma=
p)
> +{
> +       struct fuse_backing *ret =3D NULL;
> +
> +       if (map->dev !=3D FUSE_IOMAP_DEV_NULL && map->dev < INT_MAX)
> +               ret =3D fuse_backing_lookup(fc, &fuse_iomap_backing_ops,
> +                                         map->dev);
> +
> +       switch (map->type) {
> +       case FUSE_IOMAP_TYPE_MAPPED:
> +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> +               /* Mappings backed by space must have a device/addr */
> +               if (BAD_DATA(ret =3D=3D NULL))
> +                       return ERR_PTR(-EFSCORRUPTED);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t coun=
t,
>                             unsigned opflags, struct iomap *iomap,
>                             struct iomap *srcmap)
> @@ -405,6 +425,8 @@ static int fuse_iomap_begin(struct inode *inode, loff=
_t pos, loff_t count,
>         };
>         struct fuse_iomap_begin_out outarg =3D { };
>         struct fuse_mount *fm =3D get_fuse_mount(inode);
> +       struct fuse_backing *read_dev =3D NULL;
> +       struct fuse_backing *write_dev =3D NULL;
>         FUSE_ARGS(args);
>         int err;
>
> @@ -431,24 +453,44 @@ static int fuse_iomap_begin(struct inode *inode, lo=
ff_t pos, loff_t count,
>         if (err)
>                 return err;
>
> +       read_dev =3D fuse_iomap_find_dev(fm->fc, &outarg.read);
> +       if (IS_ERR(read_dev))
> +               return PTR_ERR(read_dev);
> +
>         if (fuse_is_iomap_file_write(opflags) &&
>             outarg.write.type !=3D FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
> +               /* open the write device */
> +               write_dev =3D fuse_iomap_find_dev(fm->fc, &outarg.write);
> +               if (IS_ERR(write_dev)) {
> +                       err =3D PTR_ERR(write_dev);
> +                       goto out_read_dev;
> +               }
> +
>                 /*
>                  * For an out of place write, we must supply the write ma=
pping
>                  * via @iomap, and the read mapping via @srcmap.
>                  */
> -               fuse_iomap_from_server(inode, iomap, &outarg.write);
> -               fuse_iomap_from_server(inode, srcmap, &outarg.read);
> +               fuse_iomap_from_server(inode, iomap, write_dev, &outarg.w=
rite);
> +               fuse_iomap_from_server(inode, srcmap, read_dev, &outarg.r=
ead);
>         } else {
>                 /*
>                  * For everything else (reads, reporting, and pure overwr=
ites),
>                  * we can return the sole mapping through @iomap and leav=
e
>                  * @srcmap unchanged from its default (HOLE).
>                  */
> -               fuse_iomap_from_server(inode, iomap, &outarg.read);
> +               fuse_iomap_from_server(inode, iomap, read_dev, &outarg.re=
ad);
>         }
>
> -       return 0;
> +       /*
> +        * XXX: if we ever want to support closing devices, we need a way=
 to
> +        * track the fuse_backing refcount all the way through bio endios=
.
> +        * For now we put the refcount here because you can't remove an i=
omap
> +        * device until unmount time.
> +        */
> +       fuse_backing_put(write_dev);
> +out_read_dev:
> +       fuse_backing_put(read_dev);
> +       return err;
>  }
>
>  /* Decide if we send FUSE_IOMAP_END to the fuse server */
> @@ -523,3 +565,44 @@ const struct iomap_ops fuse_iomap_ops =3D {
>         .iomap_begin            =3D fuse_iomap_begin,
>         .iomap_end              =3D fuse_iomap_end,
>  };
> +
> +static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags=
)
> +{
> +       if (!fc->iomap)
> +               return -EPERM;
> +
> +       if (flags)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int fuse_iomap_may_open(struct fuse_conn *fc, struct file *file)
> +{
> +       if (!S_ISBLK(file_inode(file)->i_mode))
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static int fuse_iomap_post_open(struct fuse_conn *fc, struct fuse_backin=
g *fb)
> +{
> +       fb->bdev =3D I_BDEV(fb->file->f_mapping->host);
> +       return 0;
> +}
> +
> +static int fuse_iomap_may_close(struct fuse_conn *fc, struct file *file)
> +{
> +       /* We only support closing iomap block devices at unmount */
> +       return -EBUSY;
> +}
> +
> +const struct fuse_backing_ops fuse_iomap_backing_ops =3D {
> +       .type =3D FUSE_BACKING_TYPE_IOMAP,
> +       .id_start =3D 1,
> +       .id_end =3D 1025,         /* maximum 1024 block devices */
> +       .may_admin =3D fuse_iomap_may_admin,
> +       .may_open =3D fuse_iomap_may_open,
> +       .may_close =3D fuse_iomap_may_close,
> +       .post_open =3D fuse_iomap_post_open,
> +};
> diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
> index 93bd72efc98cd0..68d2eecb8559a5 100644
> --- a/fs/fuse/trace.c
> +++ b/fs/fuse/trace.c
> @@ -6,6 +6,7 @@
>  #include "dev_uring_i.h"
>  #include "fuse_i.h"
>  #include "fuse_dev_i.h"
> +#include "iomap_i.h"
>
>  #include <linux/pagemap.h>
>
>
>

