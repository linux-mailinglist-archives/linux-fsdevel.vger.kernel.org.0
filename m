Return-Path: <linux-fsdevel+bounces-32471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E999A6768
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4452B26EFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776641E907B;
	Mon, 21 Oct 2024 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0uHur+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8671D7E5B;
	Mon, 21 Oct 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511911; cv=none; b=du+vUPoxOGghpYlFHft0A+ceecLSxKvdHhFC5enr4tCq+EbPCLzIJiBMbipAET3sS8qBctWTgepfvhtmw9ySLdHOFrLILy2CQR5DmcrDTlTAOaj2NWBTtEPEuujp3RsyU7Thi8LmOBeU7l5h/eIb2m5KzgXygs6DfJx/fYAYKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511911; c=relaxed/simple;
	bh=rDG9f7QdosIxWNNYNs4zeB/s+VlwSPj+tICKx1+RHwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRQyj9PVowPrrRZj1dOHJgAPJ1ULxM/AsnH3iVgPzygZ4ANW9pg750KQWKO1smYX52CQ47dksPTnOL5Mx2Dc0YdyiwNkLp9t4X5hxkWNt7/eg5GeSuf5dlfRjoccdkTIYBp07+qrrFOcwhJkJDpKggei/dSPzN/mhn2wxMVZjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0uHur+D; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so1302249241.2;
        Mon, 21 Oct 2024 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729511908; x=1730116708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkGztVuQ5km9VuV6czaa8sQLJq2lHxn4Xzhy43svgtg=;
        b=d0uHur+DCK6dvwPjbsQJffIZ3z3cP9Jcmn7Bn1Ec4c4SZ95Vw3yEynlqhtK8zqRC6e
         LdbrrOC/zZ4vwY1GOVnNmh3JGXWLWjbhG5zxm13CHwZuAuVVM2uRs2YxeIcUw/L+bjm/
         F3O3JxwJSqa15zdtsMahTxOYZxz8amSI0xA4QItZkmE0a7dY7pxPDco2ttmmbAOIaKuq
         vJRMqkN0Ok43xRPobPCBGB0OmIuYvcTQlt/fKDmKbFhiKZ0AKcVeFNqfoVP0xLTImKBt
         TDktTs4/kq0w+5/9wUTHyblgvachmezIxGhYDIFA4bjeguFNt+YchdYwN0BrSVr/UKJ0
         Lukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729511908; x=1730116708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkGztVuQ5km9VuV6czaa8sQLJq2lHxn4Xzhy43svgtg=;
        b=NbBZQ22+9vW3PaEQwO0T7euQJ2w0EyLEA7bgGFg29Kk78tyKubEDhmUjGkQoSXFWfD
         1/Y64yV8WQLZ9xdSq02a/scQ4KgRiYxs/FIKovU+zPEuv05jmWaD0ptWOLd4Zgk7ox/9
         mWvB7+geeo9PY03yla7z0Hi8Rpn5CHpgz3fYJ/IbwMK+KJlL8zXqvBVV+zCMxTxcCIEh
         FMnyiyovredfPHdwoL1EglFucn4vn8irJKRPxBoIAbpVA5Gk6u6AuGIG7ZUjr7tVqjMs
         ps2DxfOiEuf1DdkYWPKZB0un2YdH4s3A09wUCC+5J17VS+elsMmeKTg08kjYIeBl7aRd
         b0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9fgY+rWAzUgsSBvDJwMc1w5PwpASV9Y1vHmyQnufb2N5/T81mUlvMlOqMVuMRgiUB2tpQqz09XWnyPJB@vger.kernel.org
X-Gm-Message-State: AOJu0YzklBv10ZKZmzCD6JUhDBX6UepqOaaKL4OMUx742B9JDuyvvq+l
	KlfgzFUdSMqqZHa2tYWK2HOLvh0Rl+lO1u222M62qACY1jwFHUIiO0SaCKKwRVdZgAB2FFsIZii
	IyJdyFE5TeU6f9Kbj8jeprei9/YSrOUnl+pw=
X-Google-Smtp-Source: AGHT+IFhQhDs10sVvqUOOKgoyXUFAzsaaL4Kd8WSas7FP+7B6BjtBmz7HANDSDfwppqCxSPa8a+G16A206qTuuodi/8=
X-Received: by 2002:a67:ffd2:0:b0:4a5:e5e5:f929 with SMTP id
 ada2fe7eead31-4a5e5e5fca8mr3631847137.13.1729511907930; Mon, 21 Oct 2024
 04:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021103340.260731-1-mszeredi@redhat.com>
In-Reply-To: <20241021103340.260731-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 21 Oct 2024 13:58:16 +0200
Message-ID: <CAOQ4uxgUaKJXinPyEa0W=7+qK2fJx90G3qXO428G9D=AZuL2fQ@mail.gmail.com>
Subject: Re: [PATCH v2] backing-file: clean up the API
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:33=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
>  - Pass iocb to ctx->end_write() instead of file + pos
>
>  - Get rid of ctx->user_file, which is redundant most of the time
>
>  - Instead pass iocb to backing_file_splice_read and
>    backing_file_splice_write
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> v2:
>     Pass ioctb to backing_file_splice_{read|write}()
>
> Applies on fuse.git#for-next.

This looks good to me.
you may add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

However, this conflicts with ovl_real_file() changes on overlayfs-next
AND on the fixes in fuse.git#for-next, so we will need to collaborate.

Were you planning to send the fuse fixes for the 6.12 cycle?
If so, I could rebase overlayfs-next over 6.12-rcX after fuse fixes
are merged and then apply your patch to overlayfs-next and resolve conflict=
s.

Thanks,
Amir.


>
>  fs/backing-file.c            | 33 ++++++++++++++++-----------------
>  fs/fuse/passthrough.c        | 32 ++++++++++++++++++--------------
>  fs/overlayfs/file.c          | 22 +++++++++++++---------
>  include/linux/backing-file.h | 11 +++++------
>  4 files changed, 52 insertions(+), 46 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 09a9be945d45..a38737592ec7 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -80,7 +80,7 @@ struct backing_aio {
>         refcount_t ref;
>         struct kiocb *orig_iocb;
>         /* used for aio completion */
> -       void (*end_write)(struct file *, loff_t, ssize_t);
> +       void (*end_write)(struct kiocb *iocb, ssize_t);
>         struct work_struct work;
>         long res;
>  };
> @@ -108,10 +108,10 @@ static void backing_aio_cleanup(struct backing_aio =
*aio, long res)
>         struct kiocb *iocb =3D &aio->iocb;
>         struct kiocb *orig_iocb =3D aio->orig_iocb;
>
> +       orig_iocb->ki_pos =3D iocb->ki_pos;
>         if (aio->end_write)
> -               aio->end_write(orig_iocb->ki_filp, iocb->ki_pos, res);
> +               aio->end_write(orig_iocb, res);
>
> -       orig_iocb->ki_pos =3D iocb->ki_pos;
>         backing_aio_put(aio);
>  }
>
> @@ -200,7 +200,7 @@ ssize_t backing_file_read_iter(struct file *file, str=
uct iov_iter *iter,
>         revert_creds(old_cred);
>
>         if (ctx->accessed)
> -               ctx->accessed(ctx->user_file);
> +               ctx->accessed(iocb->ki_filp);
>
>         return ret;
>  }
> @@ -219,7 +219,7 @@ ssize_t backing_file_write_iter(struct file *file, st=
ruct iov_iter *iter,
>         if (!iov_iter_count(iter))
>                 return 0;
>
> -       ret =3D file_remove_privs(ctx->user_file);
> +       ret =3D file_remove_privs(iocb->ki_filp);
>         if (ret)
>                 return ret;
>
> @@ -239,7 +239,7 @@ ssize_t backing_file_write_iter(struct file *file, st=
ruct iov_iter *iter,
>
>                 ret =3D vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
>                 if (ctx->end_write)
> -                       ctx->end_write(ctx->user_file, iocb->ki_pos, ret)=
;
> +                       ctx->end_write(iocb, ret);
>         } else {
>                 struct backing_aio *aio;
>
> @@ -270,7 +270,7 @@ ssize_t backing_file_write_iter(struct file *file, st=
ruct iov_iter *iter,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_write_iter);
>
> -ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
> +ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
>                                  struct pipe_inode_info *pipe, size_t len=
,
>                                  unsigned int flags,
>                                  struct backing_file_ctx *ctx)
> @@ -282,19 +282,19 @@ ssize_t backing_file_splice_read(struct file *in, l=
off_t *ppos,
>                 return -EIO;
>
>         old_cred =3D override_creds(ctx->cred);
> -       ret =3D vfs_splice_read(in, ppos, pipe, len, flags);
> +       ret =3D vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
>         revert_creds(old_cred);
>
>         if (ctx->accessed)
> -               ctx->accessed(ctx->user_file);
> +               ctx->accessed(iocb->ki_filp);
>
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(backing_file_splice_read);
>
>  ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
> -                                 struct file *out, loff_t *ppos, size_t =
len,
> -                                 unsigned int flags,
> +                                 struct file *out, struct kiocb *iocb,
> +                                 size_t len, unsigned int flags,
>                                   struct backing_file_ctx *ctx)
>  {
>         const struct cred *old_cred;
> @@ -306,18 +306,18 @@ ssize_t backing_file_splice_write(struct pipe_inode=
_info *pipe,
>         if (!out->f_op->splice_write)
>                 return -EINVAL;
>
> -       ret =3D file_remove_privs(ctx->user_file);
> +       ret =3D file_remove_privs(iocb->ki_filp);
>         if (ret)
>                 return ret;
>
>         old_cred =3D override_creds(ctx->cred);
>         file_start_write(out);
> -       ret =3D out->f_op->splice_write(pipe, out, ppos, len, flags);
> +       ret =3D out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, fl=
ags);
>         file_end_write(out);
>         revert_creds(old_cred);
>
>         if (ctx->end_write)
> -               ctx->end_write(ctx->user_file, ppos ? *ppos : 0, ret);
> +               ctx->end_write(iocb, ret);
>
>         return ret;
>  }
> @@ -329,8 +329,7 @@ int backing_file_mmap(struct file *file, struct vm_ar=
ea_struct *vma,
>         const struct cred *old_cred;
>         int ret;
>
> -       if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
> -           WARN_ON_ONCE(ctx->user_file !=3D vma->vm_file))
> +       if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
>                 return -EIO;
>
>         if (!file->f_op->mmap)
> @@ -343,7 +342,7 @@ int backing_file_mmap(struct file *file, struct vm_ar=
ea_struct *vma,
>         revert_creds(old_cred);
>
>         if (ctx->accessed)
> -               ctx->accessed(ctx->user_file);
> +               ctx->accessed(vma->vm_file);
>
>         return ret;
>  }
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index bbac547dfcb3..607ef735ad4a 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -18,11 +18,11 @@ static void fuse_file_accessed(struct file *file)
>         fuse_invalidate_atime(inode);
>  }
>
> -static void fuse_passthrough_end_write(struct file *file, loff_t pos, ss=
ize_t ret)
> +static void fuse_passthrough_end_write(struct kiocb *iocb, ssize_t ret)
>  {
> -       struct inode *inode =3D file_inode(file);
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
>
> -       fuse_write_update_attr(inode, pos, ret);
> +       fuse_write_update_attr(inode, iocb->ki_pos, ret);
>  }
>
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *=
iter)
> @@ -34,7 +34,6 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, =
struct iov_iter *iter)
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D file,
>                 .accessed =3D fuse_file_accessed,
>         };
>
> @@ -62,7 +61,6 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D file,
>                 .end_write =3D fuse_passthrough_end_write,
>         };
>
> @@ -88,15 +86,20 @@ ssize_t fuse_passthrough_splice_read(struct file *in,=
 loff_t *ppos,
>         struct file *backing_file =3D fuse_file_passthrough(ff);
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D in,
>                 .accessed =3D fuse_file_accessed,
>         };
> +       struct kiocb iocb;
> +       ssize_t ret;
>
>         pr_debug("%s: backing_file=3D0x%p, pos=3D%lld, len=3D%zu, flags=
=3D0x%x\n", __func__,
> -                backing_file, ppos ? *ppos : 0, len, flags);
> +                backing_file, *ppos, len, flags);
>
> -       return backing_file_splice_read(backing_file, ppos, pipe, len, fl=
ags,
> -                                       &ctx);
> +       init_sync_kiocb(&iocb, in);
> +       iocb.ki_pos =3D *ppos;
> +       ret =3D backing_file_splice_read(backing_file, &iocb, pipe, len, =
flags, &ctx);
> +       *ppos =3D iocb.ki_pos;
> +
> +       return ret;
>  }
>
>  ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
> @@ -109,16 +112,18 @@ ssize_t fuse_passthrough_splice_write(struct pipe_i=
node_info *pipe,
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D out,
>                 .end_write =3D fuse_passthrough_end_write,
>         };
> +       struct kiocb iocb;
>
>         pr_debug("%s: backing_file=3D0x%p, pos=3D%lld, len=3D%zu, flags=
=3D0x%x\n", __func__,
> -                backing_file, ppos ? *ppos : 0, len, flags);
> +                backing_file, *ppos, len, flags);
>
>         inode_lock(inode);
> -       ret =3D backing_file_splice_write(pipe, backing_file, ppos, len, =
flags,
> -                                       &ctx);
> +       init_sync_kiocb(&iocb, out);
> +       iocb.ki_pos =3D *ppos;
> +       ret =3D backing_file_splice_write(pipe, backing_file, &iocb, len,=
 flags, &ctx);
> +       *ppos =3D iocb.ki_pos;
>         inode_unlock(inode);
>
>         return ret;
> @@ -130,7 +135,6 @@ ssize_t fuse_passthrough_mmap(struct file *file, stru=
ct vm_area_struct *vma)
>         struct file *backing_file =3D fuse_file_passthrough(ff);
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D file,
>                 .accessed =3D fuse_file_accessed,
>         };
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 4444c78e2e0c..12c4d502ff91 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -231,9 +231,9 @@ static void ovl_file_modified(struct file *file)
>         ovl_copyattr(file_inode(file));
>  }
>
> -static void ovl_file_end_write(struct file *file, loff_t pos, ssize_t re=
t)
> +static void ovl_file_end_write(struct kiocb *iocb, ssize_t ret)
>  {
> -       ovl_file_modified(file);
> +       ovl_file_modified(iocb->ki_filp);
>  }
>
>  static void ovl_file_accessed(struct file *file)
> @@ -271,7 +271,6 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, stru=
ct iov_iter *iter)
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(file_inode(file)->i_sb),
> -               .user_file =3D file,
>                 .accessed =3D ovl_file_accessed,
>         };
>
> @@ -298,7 +297,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, str=
uct iov_iter *iter)
>         int ifl =3D iocb->ki_flags;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(inode->i_sb),
> -               .user_file =3D file,
>                 .end_write =3D ovl_file_end_write,
>         };
>
> @@ -338,15 +336,18 @@ static ssize_t ovl_splice_read(struct file *in, lof=
f_t *ppos,
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(file_inode(in)->i_sb),
> -               .user_file =3D in,
>                 .accessed =3D ovl_file_accessed,
>         };
> +       struct kiocb iocb;
>
>         ret =3D ovl_real_fdget(in, &real);
>         if (ret)
>                 return ret;
>
> -       ret =3D backing_file_splice_read(fd_file(real), ppos, pipe, len, =
flags, &ctx);
> +       init_sync_kiocb(&iocb, in);
> +       iocb.ki_pos =3D *ppos;
> +       ret =3D backing_file_splice_read(fd_file(real), &iocb, pipe, len,=
 flags, &ctx);
> +       *ppos =3D iocb.ki_pos;
>         fdput(real);
>
>         return ret;
> @@ -368,9 +369,9 @@ static ssize_t ovl_splice_write(struct pipe_inode_inf=
o *pipe, struct file *out,
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(inode->i_sb),
> -               .user_file =3D out,
>                 .end_write =3D ovl_file_end_write,
>         };
> +       struct kiocb iocb;
>
>         inode_lock(inode);
>         /* Update mode */
> @@ -380,9 +381,13 @@ static ssize_t ovl_splice_write(struct pipe_inode_in=
fo *pipe, struct file *out,
>         if (ret)
>                 goto out_unlock;
>
> -       ret =3D backing_file_splice_write(pipe, fd_file(real), ppos, len,=
 flags, &ctx);
> +       init_sync_kiocb(&iocb, out);
> +       iocb.ki_pos =3D *ppos;
> +       ret =3D backing_file_splice_write(pipe, fd_file(real), &iocb, len=
, flags, &ctx);
> +       *ppos =3D iocb.ki_pos;
>         fdput(real);
>
> +
>  out_unlock:
>         inode_unlock(inode);
>
> @@ -420,7 +425,6 @@ static int ovl_mmap(struct file *file, struct vm_area=
_struct *vma)
>         struct file *realfile =3D file->private_data;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(file_inode(file)->i_sb),
> -               .user_file =3D file,
>                 .accessed =3D ovl_file_accessed,
>         };
>
> diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
> index 2eed0ffb5e8f..1476a6ed1bfd 100644
> --- a/include/linux/backing-file.h
> +++ b/include/linux/backing-file.h
> @@ -14,9 +14,8 @@
>
>  struct backing_file_ctx {
>         const struct cred *cred;
> -       struct file *user_file;
> -       void (*accessed)(struct file *);
> -       void (*end_write)(struct file *, loff_t, ssize_t);
> +       void (*accessed)(struct file *file);
> +       void (*end_write)(struct kiocb *iocb, ssize_t);
>  };
>
>  struct file *backing_file_open(const struct path *user_path, int flags,
> @@ -31,13 +30,13 @@ ssize_t backing_file_read_iter(struct file *file, str=
uct iov_iter *iter,
>  ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter=
,
>                                 struct kiocb *iocb, int flags,
>                                 struct backing_file_ctx *ctx);
> -ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
> +ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
>                                  struct pipe_inode_info *pipe, size_t len=
,
>                                  unsigned int flags,
>                                  struct backing_file_ctx *ctx);
>  ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
> -                                 struct file *out, loff_t *ppos, size_t =
len,
> -                                 unsigned int flags,
> +                                 struct file *out, struct kiocb *iocb,
> +                                 size_t len, unsigned int flags,
>                                   struct backing_file_ctx *ctx);
>  int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
>                       struct backing_file_ctx *ctx);
> --
> 2.47.0
>

