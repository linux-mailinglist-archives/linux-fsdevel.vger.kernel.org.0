Return-Path: <linux-fsdevel+bounces-67363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64388C3D165
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 954CE4E4BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9099D32C305;
	Thu,  6 Nov 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNeRJ1iQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD10342173
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454230; cv=none; b=dfcxvjyP0jIRZu5iKJof+KUnyDTPQBvxBOFijwfhloCTLDtxIxU3On6FBSqKVr0d91D7nZCmmW1qxLCWzLoiPa4ZQ929k5L7xSnmVhlv1AodiHUY1yrJ5MlDVes1SxRH8vA/G9h9xC4YlLLcIRyU0sg3+W0JDkDVCh+A7nBY4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454230; c=relaxed/simple;
	bh=3Wnrg9DvAAWnkfTTFLvzjXzEBGBuRHncHGqgIDgq0HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR9yJO5z4K0fceeftjqTtLm914TN7QOpyTuZGChKU7uVGPCp2CzYVxU+7O4X9+vLGquevh0q+is/+wGa8ETm7CScpK1dHv++3uZet9pTx0swnfS3Z2dUHVF7nbXwczMm1xOOxsR0GvJNQKaQjVRZboCkuJBeXBtKKl2n87q10Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNeRJ1iQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640e9a53ff6so2429197a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762454225; x=1763059025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EJE8BczzSHdGxAw/zzsEkbZMcjp/94OHe+ZfYfftlc=;
        b=SNeRJ1iQo2a5uhPH1gmZ8UdkpW1k//Aj2+QiRGWBeIfbMzLKCOUjAa84G5QFPt47sS
         A58RJos5Su422W3Bv5wEzEM7kDOJ79868dMDxvtduXs9GYdKasmC1VHoXx1X4qHXzK2a
         e0Hyr2oWI3r7gnti1kgalMs2h4IC88Ei3mxGHo6JEk98cfGNCgcvG+lhF/Lafo5tfncU
         CXqYRTVoWrn+4ZENJjoqh742qMm0tCFFEpSZv/uh796VyMH4idU9IYL3xIi8cCxoVhSY
         DgFl8qlQX4XUN9ekzOuz467RNAFxgxvAnbveVMYrBs9U+UVVn3u4bYkAa2mhMVNxqLub
         GIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454225; x=1763059025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EJE8BczzSHdGxAw/zzsEkbZMcjp/94OHe+ZfYfftlc=;
        b=R55+21uNRXvtuiA1UiFQmJn7S+K3YP7+IPnQb2/9SylswY6cP/0Qj8ylCLiWUv7RQ/
         oosIYpvdTg+KiKAYbMlMiYm8NeSt5t83ixI8neHf+vHhrZbVw1/yKcpDxBzJ2/L+gOLt
         0HiNm7wLwMR9M4xnnl/is7MhQAICDB/uqE7BmAcFUgg3ObLaYmy39yNRqvyhmX3GeLQD
         Ip+fTGj2pn+d2wRnr0HeuXXxp1rFoB5moYwFlUs5V2qLHLizklzKbxeSynAHh1Y4+P2X
         RD5vsnqzvqnHs5Z5qpZv2yhp1aUp+8F4gif5z1LfXomrscwuFIDp2Xf5WLH89bDofRP+
         +l3w==
X-Forwarded-Encrypted: i=1; AJvYcCUzXIkTfO/Y9+OqG5i14foqJBSC5CkeJHbhV+9fDN8BOYwGqJHBXgOTnWtX1/4xyur9SygvxuI71k3ZhjKc@vger.kernel.org
X-Gm-Message-State: AOJu0YwSlLr0LwGDHTo9Z8c1ZsN9cclj1ow61eLIjPh/Dp9vTqYWu++i
	vqy58MTYIcIF6pTqrUYJscuuUtgT+0q1NHeCtCnDIFgXrvNCcbAI/XLtx/iAMEJrAmR3cLr2nXO
	oc2hW/ZReyCIRwYheUNQ9JvI8bQa6QB8=
X-Gm-Gg: ASbGncthW7tAQJ9gp54AoTTla8hn5XwoCB214dlDNvv6d19xeprH4oDxJRlffg8Owgj
	56RP1fiomH7KS79ZcCl5Hyy8YoaQczrWogSKqjVPuLT7x4iiG94SVqrBrA2C2KcqtQ0HqdmAzFN
	ZXtsgi8FkK5HUhs4aMpy2IqFDbfG6q+QeKHhhOfY+kXdx01IS18lCvWnS9qsJaBWXCOvsUACELs
	pefYWhnAxPV3sn1HIDQkbBE98rE9xqGqFYTIPpSBLa7yEQy2qoZsXU6aJs2NWkqPA34D+4eqHFU
	f6s6XJzwvuHkfLGXWrY=
X-Google-Smtp-Source: AGHT+IFaR7YPLJszGOznVpddfPAvOBytrkD85TufNdWn86A9TGBf2k7wgRvx/SjNoe6TMoNoSgPHOd5H+i1bq1ix/zA=
X-Received: by 2002:a05:6402:2114:b0:63b:f0b3:76cf with SMTP id
 4fb4d7f45d1cf-6413f07f3f6mr436725a12.2.1762454225031; Thu, 06 Nov 2025
 10:37:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs> <176169809828.1424693.658681539435984766.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809828.1424693.658681539435984766.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 19:36:53 +0100
X-Gm-Features: AWmQ_bk9benqkg2ZFiZ6Avxx-WFuHY1oNU_3_7qCMAtyI8FAg8slVSgQ0RkljRI
Message-ID: <CAOQ4uxgW4=6KRuR6Qh3uMQyxtdRPLwAXZ8VY4yuduzTVqz7+dA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com, 
	neal@gompa.dev, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:44=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> In preparation for iomap, move the passthrough-specific validation code
> back to passthrough.c and create a new Kconfig item for conditional
> compilation of backing.c.  In the next patch, iomap will share the
> backing structures.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/fuse_i.h          |   25 ++++++++++-
>  include/uapi/linux/fuse.h |    8 +++-
>  fs/fuse/Kconfig           |    4 ++
>  fs/fuse/Makefile          |    3 +
>  fs/fuse/backing.c         |   98 ++++++++++++++++++++++++++++++++++-----=
------
>  fs/fuse/dev.c             |    4 +-
>  fs/fuse/inode.c           |    4 +-
>  fs/fuse/passthrough.c     |   38 +++++++++++++++++
>  8 files changed, 149 insertions(+), 35 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 1316c3853f68dc..7c7d255d817f1e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -96,10 +96,23 @@ struct fuse_submount_lookup {
>         struct fuse_forget_link *forget;
>  };
>
> +struct fuse_conn;
> +
> +/** Operations for subsystems that want to use a backing file */
> +struct fuse_backing_ops {
> +       int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
> +       int (*may_open)(struct fuse_conn *fc, struct file *file);
> +       int (*may_close)(struct fuse_conn *fc, struct file *file);
> +       unsigned int type;
> +       int id_start;
> +       int id_end;
> +};
> +
>  /** Container for data related to mapping to backing file */
>  struct fuse_backing {
>         struct file *file;
>         struct cred *cred;
> +       const struct fuse_backing_ops *ops;
>
>         /** refcount */
>         refcount_t count;
> @@ -972,7 +985,7 @@ struct fuse_conn {
>         /* New writepages go into this bucket */
>         struct fuse_sync_bucket __rcu *curr_bucket;
>
> -#ifdef CONFIG_FUSE_PASSTHROUGH
> +#ifdef CONFIG_FUSE_BACKING
>         /** IDR for backing files ids */
>         struct idr backing_files_map;
>  #endif
> @@ -1588,10 +1601,12 @@ void fuse_file_release(struct inode *inode, struc=
t fuse_file *ff,
>                        unsigned int open_flags, fl_owner_t id, bool isdir=
);
>
>  /* backing.c */
> -#ifdef CONFIG_FUSE_PASSTHROUGH
> +#ifdef CONFIG_FUSE_BACKING
>  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
>  void fuse_backing_put(struct fuse_backing *fb);
> -struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id);
> +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
> +                                        const struct fuse_backing_ops *o=
ps,
> +                                        int backing_id);
>  #else
>
>  static inline struct fuse_backing *fuse_backing_get(struct fuse_backing =
*fb)
> @@ -1646,6 +1661,10 @@ static inline struct file *fuse_file_passthrough(s=
truct fuse_file *ff)
>  #endif
>  }
>
> +#ifdef CONFIG_FUSE_PASSTHROUGH
> +extern const struct fuse_backing_ops fuse_passthrough_backing_ops;
> +#endif
> +
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *=
iter);
>  ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter =
*iter);
>  ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12bd..18713cfaf09171 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1126,9 +1126,15 @@ struct fuse_notify_prune_out {
>         uint64_t        spare;
>  };
>
> +#define FUSE_BACKING_TYPE_MASK         (0xFF)
> +#define FUSE_BACKING_TYPE_PASSTHROUGH  (0)
> +#define FUSE_BACKING_MAX_TYPE          (FUSE_BACKING_TYPE_PASSTHROUGH)
> +
> +#define FUSE_BACKING_FLAGS_ALL         (FUSE_BACKING_TYPE_MASK)
> +
>  struct fuse_backing_map {
>         int32_t         fd;
> -       uint32_t        flags;
> +       uint32_t        flags; /* FUSE_BACKING_* */
>         uint64_t        padding;
>  };
>
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 3a4ae632c94aa8..290d1c09e0b924 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -59,12 +59,16 @@ config FUSE_PASSTHROUGH
>         default y
>         depends on FUSE_FS
>         select FS_STACK
> +       select FUSE_BACKING
>         help
>           This allows bypassing FUSE server by mapping specific FUSE oper=
ations
>           to be performed directly on a backing file.
>
>           If you want to allow passthrough operations, answer Y.
>
> +config FUSE_BACKING
> +       bool
> +
>  config FUSE_IO_URING
>         bool "FUSE communication over io-uring"
>         default y
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 22ad9538dfc4b8..46041228e5be2c 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -14,7 +14,8 @@ fuse-y :=3D trace.o     # put trace.o first so we see f=
trace errors sooner
>  fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o
>  fuse-y +=3D iomode.o
>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> -fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
> +fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> +fuse-$(CONFIG_FUSE_BACKING) +=3D backing.o
>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
>
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 4afda419dd1416..f5efbffd0f456b 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include "fuse_i.h"
> +#include "fuse_trace.h"
>
>  #include <linux/file.h>
>
> @@ -44,7 +45,8 @@ static int fuse_backing_id_alloc(struct fuse_conn *fc, =
struct fuse_backing *fb)
>         idr_preload(GFP_KERNEL);
>         spin_lock(&fc->lock);
>         /* FIXME: xarray might be space inefficient */
> -       id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATO=
MIC);
> +       id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, fb->ops->id_s=
tart,
> +                             fb->ops->id_end, GFP_ATOMIC);
>         spin_unlock(&fc->lock);
>         idr_preload_end();
>
> @@ -69,32 +71,53 @@ static int fuse_backing_id_free(int id, void *p, void=
 *data)
>         struct fuse_backing *fb =3D p;
>
>         WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> +
>         fuse_backing_free(fb);
>         return 0;
>  }
>
>  void fuse_backing_files_free(struct fuse_conn *fc)
>  {
> -       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> +       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
>         idr_destroy(&fc->backing_files_map);
>  }
>
> +static inline const struct fuse_backing_ops *
> +fuse_backing_ops_from_map(const struct fuse_backing_map *map)
> +{
> +       switch (map->flags & FUSE_BACKING_TYPE_MASK) {
> +#ifdef CONFIG_FUSE_PASSTHROUGH
> +       case FUSE_BACKING_TYPE_PASSTHROUGH:
> +               return &fuse_passthrough_backing_ops;
> +#endif
> +       default:
> +               break;
> +       }
> +
> +       return NULL;
> +}
> +
>  int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
>  {
>         struct file *file;
> -       struct super_block *backing_sb;
>         struct fuse_backing *fb =3D NULL;
> +       const struct fuse_backing_ops *ops =3D fuse_backing_ops_from_map(=
map);
> +       uint32_t op_flags =3D map->flags & ~FUSE_BACKING_TYPE_MASK;
>         int res;
>
>         pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
>
> -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> -       res =3D -EPERM;
> -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +       res =3D -EOPNOTSUPP;
> +       if (!ops)
> +               goto out;
> +       WARN_ON(ops->type !=3D (map->flags & FUSE_BACKING_TYPE_MASK));
> +
> +       res =3D ops->may_admin ? ops->may_admin(fc, op_flags) : 0;
> +       if (res)
>                 goto out;
>
>         res =3D -EINVAL;
> -       if (map->flags || map->padding)
> +       if (map->padding)
>                 goto out;
>
>         file =3D fget_raw(map->fd);
> @@ -102,14 +125,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct f=
use_backing_map *map)
>         if (!file)
>                 goto out;
>
> -       /* read/write/splice/mmap passthrough only relevant for regular f=
iles */
> -       res =3D d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
> -       if (!d_is_reg(file->f_path.dentry))
> -               goto out_fput;
> -
> -       backing_sb =3D file_inode(file)->i_sb;
> -       res =3D -ELOOP;
> -       if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> +       res =3D ops->may_open ? ops->may_open(fc, file) : 0;
> +       if (res)
>                 goto out_fput;
>
>         fb =3D kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
> @@ -119,14 +136,15 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>
>         fb->file =3D file;
>         fb->cred =3D prepare_creds();
> +       fb->ops =3D ops;
>         refcount_set(&fb->count, 1);
>
>         res =3D fuse_backing_id_alloc(fc, fb);
>         if (res < 0) {
>                 fuse_backing_free(fb);
>                 fb =3D NULL;
> +               goto out;
>         }
> -
>  out:
>         pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
>
> @@ -137,41 +155,71 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>         goto out;
>  }
>
> +static struct fuse_backing *__fuse_backing_lookup(struct fuse_conn *fc,
> +                                                 int backing_id)
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
> +
>  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>  {
> -       struct fuse_backing *fb =3D NULL;
> +       struct fuse_backing *fb, *test_fb;
> +       const struct fuse_backing_ops *ops;
>         int err;
>
>         pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
>
> -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> -       err =3D -EPERM;
> -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> -               goto out;
> -
>         err =3D -EINVAL;
>         if (backing_id <=3D 0)
>                 goto out;
>
>         err =3D -ENOENT;
> -       fb =3D fuse_backing_id_remove(fc, backing_id);
> +       fb =3D __fuse_backing_lookup(fc, backing_id);
>         if (!fb)
>                 goto out;
> +       ops =3D fb->ops;
>
> -       fuse_backing_put(fb);
> +       err =3D ops->may_admin ? ops->may_admin(fc, 0) : 0;
> +       if (err)
> +               goto out_fb;
> +
> +       err =3D ops->may_close ? ops->may_close(fc, fb->file) : 0;
> +       if (err)
> +               goto out_fb;
> +
> +       err =3D -ENOENT;
> +       test_fb =3D fuse_backing_id_remove(fc, backing_id);
> +       if (!test_fb)
> +               goto out_fb;
> +
> +       WARN_ON(fb !=3D test_fb);
>         err =3D 0;
> +       fuse_backing_put(test_fb);
> +out_fb:
> +       fuse_backing_put(fb);
>  out:
>         pr_debug("%s: fb=3D0x%p, err=3D%i\n", __func__, fb, err);
>
>         return err;
>  }
>
> -struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id)
> +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
> +                                        const struct fuse_backing_ops *o=
ps,
> +                                        int backing_id)
>  {
>         struct fuse_backing *fb;
>
>         rcu_read_lock();
>         fb =3D idr_find(&fc->backing_files_map, backing_id);
> +       if (fb && fb->ops !=3D ops)
> +               fb =3D NULL;
>         fb =3D fuse_backing_get(fb);
>         rcu_read_unlock();
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index ecc0a5304c59d1..12cc673df99151 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2662,7 +2662,7 @@ static long fuse_dev_ioctl_backing_open(struct file=
 *file,
>         if (IS_ERR(fud))
>                 return PTR_ERR(fud);
>
> -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(&map, argp, sizeof(map)))
> @@ -2679,7 +2679,7 @@ static long fuse_dev_ioctl_backing_close(struct fil=
e *file, __u32 __user *argp)
>         if (IS_ERR(fud))
>                 return PTR_ERR(fud);
>
> -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
>                 return -EOPNOTSUPP;
>
>         if (get_user(backing_id, argp))
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 76e5b7f5c980c2..0cac7164afa298 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1004,7 +1004,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fu=
se_mount *fm,
>         fc->name_max =3D FUSE_NAME_LOW_MAX;
>         fc->timeout.req_timeout =3D 0;
>
> -       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (IS_ENABLED(CONFIG_FUSE_BACKING))
>                 fuse_backing_files_init(fc);
>
>         INIT_LIST_HEAD(&fc->mounts);
> @@ -1041,7 +1041,7 @@ void fuse_conn_put(struct fuse_conn *fc)
>                         WARN_ON(atomic_read(&bucket->count) !=3D 1);
>                         kfree(bucket);
>                 }
> -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +               if (IS_ENABLED(CONFIG_FUSE_BACKING))
>                         fuse_backing_files_free(fc);
>                 call_rcu(&fc->rcu, delayed_release);
>         }
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 72de97c03d0eeb..e1619bffb5d125 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -162,7 +162,7 @@ struct fuse_backing *fuse_passthrough_open(struct fil=
e *file, int backing_id)
>                 goto out;
>
>         err =3D -ENOENT;
> -       fb =3D fuse_backing_lookup(fc, backing_id);
> +       fb =3D fuse_backing_lookup(fc, &fuse_passthrough_backing_ops, bac=
king_id);
>         if (!fb)
>                 goto out;
>
> @@ -195,3 +195,39 @@ void fuse_passthrough_release(struct fuse_file *ff, =
struct fuse_backing *fb)
>         put_cred(ff->cred);
>         ff->cred =3D NULL;
>  }
> +
> +static int fuse_passthrough_may_admin(struct fuse_conn *fc, unsigned int=
 flags)
> +{
> +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       if (flags)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int fuse_passthrough_may_open(struct fuse_conn *fc, struct file *=
file)
> +{
> +       struct super_block *backing_sb;
> +       int res;
> +
> +       /* read/write/splice/mmap passthrough only relevant for regular f=
iles */
> +       res =3D d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
> +       if (!d_is_reg(file->f_path.dentry))
> +               return res;
> +
> +       backing_sb =3D file_inode(file)->i_sb;
> +       if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> +               return -ELOOP;
> +
> +       return 0;
> +}
> +
> +const struct fuse_backing_ops fuse_passthrough_backing_ops =3D {
> +       .type =3D FUSE_BACKING_TYPE_PASSTHROUGH,
> +       .id_start =3D 1,
> +       .may_admin =3D fuse_passthrough_may_admin,
> +       .may_open =3D fuse_passthrough_may_open,
> +};
>
>

