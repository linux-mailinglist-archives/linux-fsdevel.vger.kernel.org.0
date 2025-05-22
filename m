Return-Path: <linux-fsdevel+bounces-49689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B72AC115C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9492D1B63691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B317A2FC;
	Thu, 22 May 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH0T8RoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF05258;
	Thu, 22 May 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932389; cv=none; b=dFeLbHVlGe4evQOXbDnxCfuOB2DMfYglKo90pb27GgvvGpIORiooO6S/v0irJoX5SYgEfxjWMXjzvmgZcK/vUmBIh6heMfWaY5N6GZZFX831Qm0deIYJ4Uvw8fIbC3Q9v1iUKs4poXJfqk5h48+77lCNrFIbTHxkkK4qlYDGoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932389; c=relaxed/simple;
	bh=9WIM53xHFbn91XSM3kBMHqKBUEaV0jkI1IUinPPau1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhkuDe8F1gWaaLvqkyGHT7Aa1c2vV6c3NQH8ObubmZIT5XtMl9POiIEdHIDRociYMzqC+7v8P+3WpQySGU0zH2O4VtGOVQ9A/iC4X7zQ5inoNcGz6R/Q0+db1yJ4qUUEMeZ+zjkbAmEtzlYrjv4dFToU4jMDDv7P0ZRieNzR9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH0T8RoI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d51dso5656771a12.2;
        Thu, 22 May 2025 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932386; x=1748537186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NOv+tletS6BN7F7MJZbRiZdAO9GghyVHeaSCjiq+js=;
        b=iH0T8RoIhyH/0kraOn4+HUBWRFwdm7f9dGj0ykKW/qe0SZq1f61qRY0UEt3MPOsvF3
         j8G9ZMP0zIREp7pSDWSgxTlGCTVblm6AZX3ueQUvlnfGHaawmHANlbwwBlxXDVJAseEw
         nSxJHuWkiev494h5K2q9i8Y0T+wjdoRex3mVLuFWZ0QFY+q8F9HAS97egP1GwxQP1PWn
         4PccyHPPP/u5qe2B+OZkqyIbjDcVBcBIjM55v3NsvNBNzcUAeVNHqqi626lJ3Tlnfp1B
         g7RCv2KWsPvJbfAQo+cvOVZeN2sVZT1konfaD9CyVvSQvEP4p8yKiidU3TI5EaEbt43B
         /TCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932386; x=1748537186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NOv+tletS6BN7F7MJZbRiZdAO9GghyVHeaSCjiq+js=;
        b=aRqg8j3RLkAnbqqf5LILyBxokgsoAGT2BENPjWxfG/MbSo8WpYluHEaT1Wi2nSinUF
         WkERuLCANqsFENFJaFnQeMWNRFnAuvuOUEVo8nQfHcHbc7Y+vN3SzcBFO8GiiUQAuYZ0
         dKQroOIZkXH2LQKm3mt3FxeMXn6DD6tnrH/QKnK5Ri54T/WWc2f3OhpFBo9/o5fK0inF
         Fypbm9A9It1j6VklvSInRSik4gZNSEZNxy+Joekb9w5pQEm7YlGUl8upyPjQj6/Q/j0D
         OtFD04Jt7YMXB18JQGUmu80T+U+pSkw8aoGR3A9ml5Jq9pFA841c8pB5EDpYjL/iuqpY
         iyzA==
X-Forwarded-Encrypted: i=1; AJvYcCXBD49kus6pjVtxYv2JFYEzQIKMNOSgh2WDLtlxkDAsBEf3Xa68ZNYkTXh7Dp9GlaI9Wxd6iIu3qWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBCRcvIRGrRGuzfYenha4F1R3OjE9YO0+Srw9GHDf1kliu0Sk
	PKFLY7LvkLcSGkrlHAjl/fFUxi8ds/64Rt4BuKtzwiKuYa64Ax2wnr5KDKkLsBP7+ZYafJ8my+3
	+GKzSCqQLVR+oItaIZIcstdybDFiquJk=
X-Gm-Gg: ASbGncs+SDm+9Ph5jCy03Su3ZBreeUac0EZNEcAmGfcD6G2MOFrWt4WEDutbP7ukWVx
	57jdFWlbxbDcLvAgVU2+aLWZ27yhqt5VWwuK42YFZfbvvZam+dfl/dryluJXxajGcAQq3XZ3gve
	Uwro7yVPJ85E6ETCZGVZCmBlA6iOlA41Ji
X-Google-Smtp-Source: AGHT+IFWvuczrOs6ObFssX+WN/GPap41eWtet6TiJ1FgV5HKMnl6Q9qPjWONdzCxOYiJcM7qz/ASPDPEiikjgJxv314=
X-Received: by 2002:a17:907:3f85:b0:ad1:766a:9441 with SMTP id
 a640c23a62f3a-ad52d49b428mr2241559866b.23.1747932385795; Thu, 22 May 2025
 09:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs> <174787195651.1483178.3420885441625089259.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195651.1483178.3420885441625089259.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 May 2025 18:46:14 +0200
X-Gm-Features: AX0GCFukZUENVCQWI5L-HHHcQyykTnj_SjM9vzgEYA6-nNYJGTA4JaWjngNgK8M
Message-ID: <CAOQ4uxiZTTEOs4HYD0vGi3XtihyDiQbDFXBCuGKoJyFPQv_+Lw@mail.gmail.com>
Subject: Re: [PATCH 04/11] fuse: add a notification to add new iomap devices
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com, 
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:03=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Add a new notification so that fuse servers can add extra block devices
> to use with iomap.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   19 +++++++
>  fs/fuse/fuse_trace.h      |   36 ++++++++++++++
>  include/uapi/linux/fuse.h |    8 +++
>  fs/fuse/dev.c             |   23 +++++++++
>  fs/fuse/file_iomap.c      |  119 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  fs/fuse/inode.c           |    9 +++
>  6 files changed, 211 insertions(+), 3 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index aa51f25856697d..4eb75ed90db300 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -619,6 +619,12 @@ struct fuse_sync_bucket {
>         struct rcu_head rcu;
>  };
>
> +struct fuse_iomap {
> +       /* array of file objects that reference block devices for iomap *=
/
> +       struct file **files;
> +       unsigned int nr_files;
> +};
> +
>  /**
>   * A Fuse connection.
>   *
> @@ -970,6 +976,10 @@ struct fuse_conn {
>         struct fuse_ring *ring;
>  #endif
>
> +#ifdef CONFIG_FUSE_IOMAP
> +       struct fuse_iomap iomap_conn;
> +#endif
> +
>         /** Only used if the connection opts into request timeouts */
>         struct {
>                 /* Worker for checking if any requests have timed out */
> @@ -1610,9 +1620,18 @@ static inline bool fuse_has_iomap(const struct ino=
de *inode)
>  {
>         return get_fuse_conn_c(inode)->iomap;
>  }
> +
> +void fuse_iomap_init_reply(struct fuse_mount *fm);
> +void fuse_iomap_conn_put(struct fuse_conn *fc);
> +
> +int fuse_iomap_add_device(struct fuse_conn *fc,
> +                         const struct fuse_iomap_add_device_out *outarg)=
;
>  #else
>  # define fuse_iomap_enabled(...)               (false)
>  # define fuse_has_iomap(...)                   (false)
> +# define fuse_iomap_init_reply(...)            ((void)0)
> +# define fuse_iomap_conn_put(...)              ((void)0)
> +# define fuse_iomap_add_device(...)            (-ENOSYS)
>  #endif
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index f9a316c9788e06..e1a2e491d2581a 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -380,6 +380,42 @@ TRACE_EVENT(fuse_iomap_end_error,
>                   __entry->pos, __entry->count, __entry->written,
>                   __entry->error)
>  );
> +
> +TRACE_EVENT(fuse_iomap_dev_class,
> +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
> +                const struct file *file),
> +
> +       TP_ARGS(fc, idx, file),
> +
> +       TP_STRUCT__entry(
> +               __field(dev_t,          connection)
> +               __field(unsigned int,   idx)
> +               __field(dev_t,          bdev)
> +       ),
> +
> +       TP_fast_assign(
> +               struct inode *inode =3D file_inode(file);
> +
> +               __entry->connection     =3D       fc->dev;
> +               __entry->idx            =3D       idx;
> +               if (S_ISBLK(inode->i_mode)) {
> +                       __entry->bdev   =3D       inode->i_rdev;
> +               } else
> +                       __entry->bdev   =3D       0;
> +       ),
> +
> +       TP_printk("connection %u idx %u dev %u:%u",
> +                 __entry->connection,
> +                 __entry->idx,
> +                 MAJOR(__entry->bdev), MINOR(__entry->bdev))
> +);
> +#define DEFINE_FUSE_IOMAP_DEV_EVENT(name)              \
> +DEFINE_EVENT(fuse_iomap_dev_class, name,               \
> +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
> +                const struct file *file), \
> +       TP_ARGS(fc, idx, file))
> +DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_add_dev);
> +DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_remove_dev);
>  #endif /* CONFIG_FUSE_IOMAP */
>
>  #endif /* _TRACE_FUSE_H */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index ce6c9960f2418f..ea8992e980a015 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -236,6 +236,7 @@
>   *  7.44
>   *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
>   *    SEEK_{DATA,HOLE} support
> + *  - add FUSE_NOTIFY_ADD_IOMAP_DEVICE for multi-device filesystems
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -681,6 +682,7 @@ enum fuse_notify_code {
>         FUSE_NOTIFY_RETRIEVE =3D 5,
>         FUSE_NOTIFY_DELETE =3D 6,
>         FUSE_NOTIFY_RESEND =3D 7,
> +       FUSE_NOTIFY_ADD_IOMAP_DEVICE =3D 8,
>         FUSE_NOTIFY_CODE_MAX,
>  };
>
> @@ -1371,4 +1373,10 @@ struct fuse_iomap_end_in {
>         uint32_t map_dev;       /* device cookie * */
>  };
>
> +struct fuse_iomap_add_device_out {
> +       int32_t fd;             /* fd of the open device to add */
> +       uint32_t reserved;      /* must be zero */
> +       uint32_t *map_dev;      /* location to receive device cookie */
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6dcbaa218b7a16..9d7064ec170cf6 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1824,6 +1824,26 @@ static int fuse_notify_store(struct fuse_conn *fc,=
 unsigned int size,
>         return err;
>  }
>
> +static int fuse_notify_add_iomap_device(struct fuse_conn *fc, unsigned i=
nt size,
> +                                       struct fuse_copy_state *cs)
> +{
> +       struct fuse_iomap_add_device_out outarg;
> +       int err =3D -EINVAL;
> +
> +       if (size !=3D sizeof(outarg))
> +               goto err;
> +
> +       err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
> +       if (err)
> +               goto err;
> +       fuse_copy_finish(cs);
> +
> +       return fuse_iomap_add_device(fc, &outarg);
> +err:
> +       fuse_copy_finish(cs);
> +       return err;
> +}
> +
>  struct fuse_retrieve_args {
>         struct fuse_args_pages ap;
>         struct fuse_notify_retrieve_in inarg;
> @@ -2049,6 +2069,9 @@ static int fuse_notify(struct fuse_conn *fc, enum f=
use_notify_code code,
>         case FUSE_NOTIFY_RESEND:
>                 return fuse_notify_resend(fc);
>
> +       case FUSE_NOTIFY_ADD_IOMAP_DEVICE:
> +               return fuse_notify_add_iomap_device(fc, size, cs);
> +
>         default:
>                 fuse_copy_finish(cs);
>                 return -EINVAL;
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index dfa0c309803113..faefd29a273bf3 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -142,6 +142,26 @@ static inline int fuse_iomap_validate(const struct f=
use_iomap_begin_out *outarg,
>         return 0;
>  }
>
> +static inline struct block_device *fuse_iomap_bdev(struct fuse_mount *fm=
,
> +                                                  unsigned int idx)
> +{
> +       struct fuse_conn *fc =3D fm->fc;
> +       struct file *file =3D NULL;
> +
> +       spin_lock(&fc->lock);
> +       if (idx < fc->iomap_conn.nr_files)
> +               file =3D fc->iomap_conn.files[idx];
> +       spin_unlock(&fc->lock);
> +
> +       if (!file)
> +               return NULL;
> +
> +       if (!S_ISBLK(file_inode(file)->i_mode))
> +               return NULL;
> +
> +       return I_BDEV(file->f_mapping->host);
> +}
> +
>  static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t coun=
t,
>                             unsigned opflags, struct iomap *iomap,
>                             struct iomap *srcmap)
> @@ -155,6 +175,7 @@ static int fuse_iomap_begin(struct inode *inode, loff=
_t pos, loff_t count,
>         };
>         struct fuse_iomap_begin_out outarg =3D { };
>         struct fuse_mount *fm =3D get_fuse_mount(inode);
> +       struct block_device *read_bdev;
>         FUSE_ARGS(args);
>         int err;
>
> @@ -181,8 +202,18 @@ static int fuse_iomap_begin(struct inode *inode, lof=
f_t pos, loff_t count,
>         if (err)
>                 return err;
>
> +       read_bdev =3D fuse_iomap_bdev(fm, outarg.read_dev);
> +       if (!read_bdev)
> +               return -ENODEV;
> +
>         if ((opflags & IOMAP_WRITE) &&
>             outarg.write_type !=3D FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
> +               struct block_device *write_bdev =3D
> +                       fuse_iomap_bdev(fm, outarg.write_dev);
> +
> +               if (!write_bdev)
> +                       return -ENODEV;
> +
>                 /*
>                  * For an out of place write, we must supply the write ma=
pping
>                  * via @iomap, and the read mapping via @srcmap.
> @@ -192,14 +223,14 @@ static int fuse_iomap_begin(struct inode *inode, lo=
ff_t pos, loff_t count,
>                 iomap->length =3D outarg.length;
>                 iomap->type =3D outarg.write_type;
>                 iomap->flags =3D outarg.write_flags;
> -               iomap->bdev =3D inode->i_sb->s_bdev;
> +               iomap->bdev =3D write_bdev;
>
>                 srcmap->addr =3D outarg.read_addr;
>                 srcmap->offset =3D outarg.offset;
>                 srcmap->length =3D outarg.length;
>                 srcmap->type =3D outarg.read_type;
>                 srcmap->flags =3D outarg.read_flags;
> -               srcmap->bdev =3D inode->i_sb->s_bdev;
> +               srcmap->bdev =3D read_bdev;
>         } else {
>                 /*
>                  * For everything else (reads, reporting, and pure overwr=
ites),
> @@ -211,7 +242,7 @@ static int fuse_iomap_begin(struct inode *inode, loff=
_t pos, loff_t count,
>                 iomap->length =3D outarg.length;
>                 iomap->type =3D outarg.read_type;
>                 iomap->flags =3D outarg.read_flags;
> -               iomap->bdev =3D inode->i_sb->s_bdev;
> +               iomap->bdev =3D read_bdev;
>         }
>
>         return 0;
> @@ -278,3 +309,85 @@ const struct iomap_ops fuse_iomap_ops =3D {
>         .iomap_begin            =3D fuse_iomap_begin,
>         .iomap_end              =3D fuse_iomap_end,
>  };
> +
> +void fuse_iomap_conn_put(struct fuse_conn *fc)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < fc->iomap_conn.nr_files; i++) {
> +               struct file *file =3D fc->iomap_conn.files[i];
> +
> +               trace_fuse_iomap_remove_dev(fc, i, file);
> +
> +               fc->iomap_conn.files[i] =3D NULL;
> +               fput(file);
> +       }
> +
> +       kfree(fc->iomap_conn.files);
> +       fc->iomap_conn.nr_files =3D 0;
> +}
> +
> +/* Add a bdev to the fuse connection, returns the index or a negative er=
rno */
> +static int __fuse_iomap_add_device(struct fuse_conn *fc, struct file *fi=
le)
> +{
> +       struct file **new_files;
> +       int ret;
> +
> +       if (fc->iomap_conn.nr_files >=3D PAGE_SIZE / sizeof(unsigned int)=
)
> +               return -EMFILE;
> +
> +       new_files =3D krealloc_array(fc->iomap_conn.files,
> +                                  fc->iomap_conn.nr_files + 1,
> +                                  sizeof(struct file *),
> +                                  GFP_KERNEL | __GFP_ZERO);
> +       if (!new_files)
> +               return -ENOMEM;
> +
> +       spin_lock(&fc->lock);
> +       fc->iomap_conn.files =3D new_files;
> +       fc->iomap_conn.files[fc->iomap_conn.nr_files] =3D get_file(file);
> +       ret =3D fc->iomap_conn.nr_files++;
> +       spin_unlock(&fc->lock);
> +
> +       trace_fuse_iomap_add_dev(fc, ret, file);
> +
> +       return ret;
> +}
> +
> +void fuse_iomap_init_reply(struct fuse_mount *fm)
> +{
> +       struct fuse_conn *fc =3D fm->fc;
> +       struct super_block *sb =3D fm->sb;
> +
> +       if (sb->s_bdev)
> +               __fuse_iomap_add_device(fc, sb->s_bdev_file);
> +}
> +
> +int fuse_iomap_add_device(struct fuse_conn *fc,
> +                         const struct fuse_iomap_add_device_out *outarg)
> +{
> +       struct file *file;
> +       int ret;
> +
> +       if (!fc->iomap)
> +               return -EINVAL;
> +
> +       if (outarg->reserved)
> +               return -EINVAL;
> +
> +       CLASS(fd, somefd)(outarg->fd);
> +       if (fd_empty(somefd))
> +               return -EBADF;
> +       file =3D fd_file(somefd);
> +
> +       if (!S_ISBLK(file_inode(file)->i_mode))
> +               return -ENODEV;
> +
> +       down_read(&fc->killsb);
> +       ret =3D __fuse_iomap_add_device(fc, file);
> +       up_read(&fc->killsb);
> +       if (ret < 0)
> +               return ret;
> +
> +       return put_user(ret, outarg->map_dev);
> +}

This very much reminds of FUSE_DEV_IOC_BACKING_OPEN
that gives kernel an fd to remember for later file operations.

FUSE_DEV_IOC_BACKING_OPEN was implemented as an ioctl
because of security concerns of passing an fd to the kernel via write().

Speaking of security concerns, we need to consider if this requires some
privileges to allow setting up direct access to blockdev.

But also, apart from the fact that those are block device fds,
what does iomap_conn.files[] differ from fc->backing_files_map?

Miklos had envisioned this (backing blockdev) use case as one of the
private cases of fuse passthrough.

Instead of identity mapping to backing file created at open time
it's extent mapping to backing blockdev created at data access time.

I am not saying that you need to reuse anything from fuse passthrough
code, because the use cases probably do not overlap, but hopefully,
you can avoid falling into the same pits that we have already managed to av=
oid.

Thanks,
Amir.

