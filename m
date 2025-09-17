Return-Path: <linux-fsdevel+bounces-61862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D741FB7CEF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8891B26976
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3421255E;
	Wed, 17 Sep 2025 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPI/qnsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B91A9FAA
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077256; cv=none; b=Dm06uGfBO9ednHViS34UndNk/SISGQqgbPfJgAgjkjL7hWpEzG1IqxQNHZo9hkbpxreK7vu0wvgbrVvOIs7l8RK631+l0uLYAlXRXRRwOHbsy7PWQIsodTAVJP8DnSGGe8Znv4FQSOCaFvvn9LMrYylZIzUQWkcHTUfCC3w6FNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077256; c=relaxed/simple;
	bh=2/rTU5xclTKNWHdogrO+AjpWoY150/BnU882ACfvqX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgS7nQLdH5V12byYMUlnzvC7BJPWvYAcECkDJM6orbCwSVprALZ1SzQN2imxan3+sQ0kVzBvUU98PH/A47KhbOJhrKKE8DxmCBq4ERKNq2dlPZs8koIiiSEBJXdyniK+MhLVt5gjcSvGqHA1W30LSq4UQmchu70gdmdcX2KT7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPI/qnsB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f2b27a751so4225046a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 19:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758077252; x=1758682052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwQWtcGQeGto4du0Z8Z14eRKfyT32Vc71ndKim53hxg=;
        b=aPI/qnsBl7o7jRamcD4AJimbmLrRO/UH+zRKg60xUHv+7mWWMl1cp5tws+iLpcU9GF
         LfHOq+pdd8NO7oS7yntBvv7bcCK7n99w2uBqqmeQ9zmVWzEk2WYr0VyTz6jC9wqcBezK
         z4sr7DDdiPWWXUETbgDB6VT6l+8M6Lisx0rnLGQMh1v5cRg73jXcdTj/u8P+p1kY7yoY
         xXkvYVav3CZfkxGVY4kK3jjVSaiSV5CbXCl7/n7PwKIg5NysmxWJs7PWDijCSOEVBLaJ
         ZUKipDkhP5QAswKPMbV1pw3tWnuU5Y+cx3MoLQJ+LCwusPYBxbH+EScBAXfFs715qWU6
         Tn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077252; x=1758682052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwQWtcGQeGto4du0Z8Z14eRKfyT32Vc71ndKim53hxg=;
        b=uwsvPSilvDQA49K9KHl+SRUcBnhx+mR1dlMFffI+OQ7HdyyNsPq6CgevX0u45sRtLL
         ovrLoYTYXWHEINJgzqVIeU3zvO93kEBpa1kIp2JPXjBFUvOkPzlJMq/vDdrjEYxrVGlN
         coy7H5A+ixds6PkbbO0i1ID9ZyRMRil39JgAx9Az3rrvtGb2K0ZHZjvnOzEK3BsqLa/6
         aA0qHZcUPshTJdq3xABCDfU4DZFtJfdPkvAjYqlZYsYH8A8n6RK40gDcl9X7Ey663C1H
         fokAEcMZtwdpUHIPPewoCcLBXr8dPe+Svlik3ENVYD0K4Qte4I3qVVK/cF9hkyoCqHYd
         OaXw==
X-Forwarded-Encrypted: i=1; AJvYcCWNnawnrwgGYO2rjifRK/RZCyoQRAGuFfA2kAqZnZ4YpB81ORHJSKNGgCX/KenK2UkqIZI3ZLi5sBmi5MMT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4V88wVr1JkHqxIhNQmLvFKtTJP2vhBPVXmVAUHE+dFh7ni1/Z
	snagCE712fPw+oDphoX+PfS3sQZLlswT6kmTcxshLLwFnxIzM4A0+3nlELPF8BhMnM7TDwUGb66
	zQi8WmrNMQlEG3+bETg6JX0SgFDbR2XM=
X-Gm-Gg: ASbGncs4bzh//qr3Gwgx92bw7irJOwyLyalAD+M6D7bDcSpAr9t+yy23fi37jdx0lBY
	5TREm8GtK8zUcS5ahuPv9Nwb4GCRQf1tMPUCxcsDoJpPcBafMr0dKCERw80yIpXOJuaIlUUf36B
	ilk5/96726ZGwy1cowso/o4tIG9GVcqmuMyp+fWwiliahXEEqryVbvdGdH6RJpCsEyKY0aEPYqc
	xtVat6Qi6RtQvKn/iPtZb0ATI+nwk/UhBV1aIUjkw==
X-Google-Smtp-Source: AGHT+IE0vxBkeriZ3uj77PudbRFeBZFK49Qi07LM5S2VAC5NKXV1oM5x6YWaUb7BwV6N+VqYFpadwG6XptXi8bZ/zwU=
X-Received: by 2002:a05:6402:26c3:b0:62f:2afa:60e6 with SMTP id
 4fb4d7f45d1cf-62f83c3f396mr762886a12.7.1758077251843; Tue, 16 Sep 2025
 19:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs> <175798150773.382479.13993075040890328659.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150773.382479.13993075040890328659.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 17 Sep 2025 04:47:19 +0200
X-Gm-Features: AS18NWDUYbtitNYeuFq57r_Ad10v6wPSB1MDoNIk-ICKQT6c3y4r9XUdjs05xOQ
Message-ID: <CAOQ4uxigBL4pCDXjRYX0ftCMyQibRPuRJP7+KhC7Jr=yEM=DUw@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:27=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
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
> ---
>  fs/fuse/fuse_i.h          |   23 +++++++++--
>  include/uapi/linux/fuse.h |    8 +++-
>  fs/fuse/Kconfig           |    4 ++
>  fs/fuse/Makefile          |    3 +
>  fs/fuse/backing.c         |   95 ++++++++++++++++++++++++++++++++++-----=
------
>  fs/fuse/dev.c             |    4 +-
>  fs/fuse/inode.c           |    4 +-
>  fs/fuse/passthrough.c     |   37 +++++++++++++++++-
>  8 files changed, 144 insertions(+), 34 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 52db609e63eb54..4560687d619d76 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -96,10 +96,21 @@ struct fuse_submount_lookup {
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
> +};
> +
>  /** Container for data related to mapping to backing file */
>  struct fuse_backing {
>         struct file *file;
>         struct cred *cred;
> +       const struct fuse_backing_ops *ops;

Please argue why we need a mix of passthrough backing
files and iomap backing bdev on the same filesystem.

Same as my argument against passthrough/iomap on
same fuse_backing:
If you do not plan to test it, and nobody asked for it, please do
not allow it - it's bad for code test coverage.

I think at this point in time FUSE_PASSTHROUGH and
FUSE_IOMAP should be mutually exclusive and
fuse_backing_ops could be set at fc level.
If we want to move them for per fuse_backing later
we can always do that when the use cases and tests arrive.

Thanks,
Amir.

>
>         /** refcount */
>         refcount_t count;
> @@ -968,7 +979,7 @@ struct fuse_conn {
>         /* New writepages go into this bucket */
>         struct fuse_sync_bucket __rcu *curr_bucket;
>
> -#ifdef CONFIG_FUSE_PASSTHROUGH
> +#ifdef CONFIG_FUSE_BACKING
>         /** IDR for backing files ids */
>         struct idr backing_files_map;
>  #endif
> @@ -1571,10 +1582,12 @@ void fuse_file_release(struct inode *inode, struc=
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
> @@ -1631,6 +1644,10 @@ static inline struct file *fuse_file_passthrough(s=
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
> index 1d76d0332f46f6..31b80f93211b81 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1114,9 +1114,15 @@ struct fuse_notify_retrieve_in {
>         uint64_t        dummy4;
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
> index a774166264de69..9563fa5387a241 100644
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
> index 8ddd8f0b204ee5..36be6d715b111a 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -13,7 +13,8 @@ obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
>  fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
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
> index 4afda419dd1416..da0dff288396ed 100644
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
> @@ -69,32 +70,53 @@ static int fuse_backing_id_free(int id, void *p, void=
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
> @@ -102,14 +124,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct f=
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
> @@ -119,14 +135,15 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
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
> @@ -137,41 +154,71 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
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
> index e5aaf0c668bc11..281bc81f3b448b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2654,7 +2654,7 @@ static long fuse_dev_ioctl_backing_open(struct file=
 *file,
>         if (IS_ERR(fud))
>                 return PTR_ERR(fud);
>
> -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(&map, argp, sizeof(map)))
> @@ -2671,7 +2671,7 @@ static long fuse_dev_ioctl_backing_close(struct fil=
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
> index 14c35ce12b87d6..1e7298b2b89b58 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -995,7 +995,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>         fc->name_max =3D FUSE_NAME_LOW_MAX;
>         fc->timeout.req_timeout =3D 0;
>
> -       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (IS_ENABLED(CONFIG_FUSE_BACKING))
>                 fuse_backing_files_init(fc);
>
>         INIT_LIST_HEAD(&fc->mounts);
> @@ -1032,7 +1032,7 @@ void fuse_conn_put(struct fuse_conn *fc)
>                         WARN_ON(atomic_read(&bucket->count) !=3D 1);
>                         kfree(bucket);
>                 }
> -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +               if (IS_ENABLED(CONFIG_FUSE_BACKING))
>                         fuse_backing_files_free(fc);
>                 call_rcu(&fc->rcu, delayed_release);
>         }
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index e0b8d885bc81f3..9792d7b12a775b 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -164,7 +164,7 @@ struct fuse_backing *fuse_passthrough_open(struct fil=
e *file,
>                 goto out;
>
>         err =3D -ENOENT;
> -       fb =3D fuse_backing_lookup(fc, backing_id);
> +       fb =3D fuse_backing_lookup(fc, &fuse_passthrough_backing_ops, bac=
king_id);
>         if (!fb)
>                 goto out;
>
> @@ -197,3 +197,38 @@ void fuse_passthrough_release(struct fuse_file *ff, =
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
> +       .may_admin =3D fuse_passthrough_may_admin,
> +       .may_open =3D fuse_passthrough_may_open,
> +};
>
>

