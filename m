Return-Path: <linux-fsdevel+bounces-32007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBFF99F146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CA81C224D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C11EB9E6;
	Tue, 15 Oct 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpisjxCW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5B147C91;
	Tue, 15 Oct 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006337; cv=none; b=nQTeprxkvRh//7DCD8f30R8KvR0yyWmxT7yWgo+5m15ZiunC6M20lUaVeAUMSlwuw+Zy1sleMr3lxu3l/istk4Nyafh2McBngSCbpefbdN2teQ4pHeCxw5SDBgRlP46R4tnM/d30qQ6OJ2dxOiVcUQpHe5eCOyZgjkE7g8JljF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006337; c=relaxed/simple;
	bh=LJRp7LRHPCcsrtzpew/M/0B91Q6N4ZaLH7nc1je2jSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt03Rp71XxxVtNl8aZlMkcmaHPXFvPj3r3FRHooxZtZr7iaxIPjGufqRy8dXYS6ZH4AFZ2w52//x4ikhxWTFhPkSAJ5/Q5jguzMoRzaH62ubgAuwSD8KLjDf+Ba32On7EurHez9T7+0HsG5ICYPo7c1MIaVY6qNaClZEZG9dkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpisjxCW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so3340092a12.1;
        Tue, 15 Oct 2024 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729006334; x=1729611134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlpK8L1G38JlthyKbyjBW1XIqaxPp2/1mEJOeuOwUvI=;
        b=YpisjxCWjByZ4Zh818XXc8aXU22J8oZdZ5SHStDy7BLlFRayhruyPlqY1ozb9C/cQR
         tGm/dMrFInJw+e21yCT18HJovLzqZUfsR3ZD2bmnY2hDI9lKiEBW/e1qBWom7p1xlXkn
         kaZSjI2pt3VPq68ddz45TgBM8ojPUsWk+3NFgNSiPqgvGTeK2+CYhQHCRCowfkPIe3aS
         dBQ+YCEfB9QL/Wn2JsxeLxPr1suALcQ5zCkNkZV/gauz2H3id9mhiPicmWeZvQxDlNes
         BaPJvhHHLqevm4Byus6aP+KONauWFrZLWUITZj2oRE5rS1NtbvLsC7+Up++3wRiiioTE
         qW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006334; x=1729611134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlpK8L1G38JlthyKbyjBW1XIqaxPp2/1mEJOeuOwUvI=;
        b=GLfnFCbA6ix3L6Uyys6pLcmC9uD6e5AEnNGlkK69KVtpgDfsCJfN/Tb311Uqk80LUN
         AaXx4t6yXf8gY73fkDSEQ4txBUHidZuvpiq7HqKVWS1CNeUaqYCZrEl7XtoPKC2PKxmX
         BVSRZf/qW8zCcdDkJnyyiOoEOGQigaqNElVqMWCGWye3ADscrieRcNMTLin3mwQK4f2B
         wVzJHKaYcBEZRhaIkEJJH0h6ue/HuSET9DtheVU+FmedlZoCwmj8ZtRGNxiUrjo26p8E
         Elv6hMtCMMDnWwgQ0EkxZVJQHzOPi4gUDkqbjIfUyFbxm0POLrQIM+xDaky7mMmDjuKC
         yhsA==
X-Forwarded-Encrypted: i=1; AJvYcCXqWm3tQD8cR3UK3n7JcvMhizg8wwZ2evualS449tO56AkhA3K4dxXIIOdqvA0PY4ocrdE6srk1TxswDeIc@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYZgCVKAI9y/swgMEOUTVidS6lfe9xQAruFh+pnJjOBzHcRsj
	6qjf0kZJyXTo73d2umgO5+5SNyFujMpAG9/Vk6FIk6xweFXTZtNwpE0zTN4ueR6tdPZO5TKcJ+l
	ILcxYLn2MQoYjE7XU6ydNY8ZiGG1DH7/6axE=
X-Google-Smtp-Source: AGHT+IEORhWt7WjI/pPvMF9pIqJLdTcwwhtsGwoRHNfvqKlao57oW5fOU1gYgBEctGRv6YzjE4SuRuPZYLo/jWVBrNg=
X-Received: by 2002:a17:907:7ea0:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a99e3b700b8mr1208005366b.27.1729006333377; Tue, 15 Oct 2024
 08:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015133141.70632-1-mszeredi@redhat.com>
In-Reply-To: <20241015133141.70632-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 Oct 2024 17:31:59 +0200
Message-ID: <CAOQ4uxh-3H4QkTEihujFgz53ajeArWH9u_yj4kaWByVJAGmgrw@mail.gmail.com>
Subject: Re: [RFC PATCH] backing-file: clean up the API
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 3:31=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
>  - Pass iocb to ctx->end_write() instead of file + pos
>
>  - Get rid of ctx->user_file, which is redundant most of the time
>
>  - Instead pass user_file explicitly to backing_file_splice_read and
>    backing_file_splice_write
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> This applies on top of "fs: pass offset and result to backing_file
> end_write() callback"

For the sake of people who did not see the above:
https://lore.kernel.org/linux-fsdevel/20241014192759.863031-2-amir73il@gmai=
l.com/

If this cleanup is acceptable then perhaps squash it with the above commit?

>
>  fs/backing-file.c            | 37 ++++++++++++++++++++----------------
>  fs/fuse/passthrough.c        | 21 +++++++-------------
>  fs/overlayfs/file.c          | 14 +++++---------
>  include/linux/backing-file.h |  9 ++++-----
>  4 files changed, 37 insertions(+), 44 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 09a9be945d45..98f4486cfca9 100644
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
> +ssize_t backing_file_splice_read(struct file *in, struct file *user_in, =
loff_t *ppos,
>                                  struct pipe_inode_info *pipe, size_t len=
,
>                                  unsigned int flags,
>                                  struct backing_file_ctx *ctx)
> @@ -286,15 +286,15 @@ ssize_t backing_file_splice_read(struct file *in, l=
off_t *ppos,
>         revert_creds(old_cred);
>
>         if (ctx->accessed)
> -               ctx->accessed(ctx->user_file);
> +               ctx->accessed(user_in);
>
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(backing_file_splice_read);
>
>  ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
> -                                 struct file *out, loff_t *ppos, size_t =
len,
> -                                 unsigned int flags,
> +                                 struct file *out, struct file *user_out=
, loff_t *ppos,
> +                                 size_t len, unsigned int flags,
>                                   struct backing_file_ctx *ctx)
>  {
>         const struct cred *old_cred;
> @@ -306,7 +306,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_i=
nfo *pipe,
>         if (!out->f_op->splice_write)
>                 return -EINVAL;
>
> -       ret =3D file_remove_privs(ctx->user_file);
> +       ret =3D file_remove_privs(user_out);
>         if (ret)
>                 return ret;
>
> @@ -316,8 +316,14 @@ ssize_t backing_file_splice_write(struct pipe_inode_=
info *pipe,
>         file_end_write(out);
>         revert_creds(old_cred);
>
> -       if (ctx->end_write)
> -               ctx->end_write(ctx->user_file, ppos ? *ppos : 0, ret);
> +       if (ctx->end_write) {
> +               struct kiocb iocb;
> +
> +               init_sync_kiocb(&iocb, out);
> +               iocb.ki_pos =3D *ppos;
> +
> +               ctx->end_write(&iocb, ret);
> +       }
>
>         return ret;
>  }
> @@ -329,8 +335,7 @@ int backing_file_mmap(struct file *file, struct vm_ar=
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
> @@ -343,7 +348,7 @@ int backing_file_mmap(struct file *file, struct vm_ar=
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
> index bbac547dfcb3..5c502394a208 100644
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
> @@ -88,15 +86,13 @@ ssize_t fuse_passthrough_splice_read(struct file *in,=
 loff_t *ppos,
>         struct file *backing_file =3D fuse_file_passthrough(ff);
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D in,
>                 .accessed =3D fuse_file_accessed,
>         };
>
>         pr_debug("%s: backing_file=3D0x%p, pos=3D%lld, len=3D%zu, flags=
=3D0x%x\n", __func__,
> -                backing_file, ppos ? *ppos : 0, len, flags);
> +                backing_file, *ppos, len, flags);
>
> -       return backing_file_splice_read(backing_file, ppos, pipe, len, fl=
ags,
> -                                       &ctx);
> +       return backing_file_splice_read(backing_file, in, ppos, pipe, len=
, flags, &ctx);
>  }
>
>  ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
> @@ -109,16 +105,14 @@ ssize_t fuse_passthrough_splice_write(struct pipe_i=
node_info *pipe,
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D out,
>                 .end_write =3D fuse_passthrough_end_write,
>         };
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
> +       ret =3D backing_file_splice_write(pipe, backing_file, out, ppos, =
len, flags, &ctx);
>         inode_unlock(inode);
>
>         return ret;
> @@ -130,7 +124,6 @@ ssize_t fuse_passthrough_mmap(struct file *file, stru=
ct vm_area_struct *vma)
>         struct file *backing_file =3D fuse_file_passthrough(ff);
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ff->cred,
> -               .user_file =3D file,
>                 .accessed =3D fuse_file_accessed,
>         };
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 24a36d61bb0c..1debab93e3d6 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -231,9 +231,9 @@ static void ovl_file_modified(struct file *file)
>         ovl_copyattr(file_inode(file));
>  }
>
> -static void ovl_file_end_write(struct file *file, loff_t, ssize_t)
> +static void ovl_file_end_write(struct kiocb *iocb, ssize_t)
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
> @@ -338,7 +336,6 @@ static ssize_t ovl_splice_read(struct file *in, loff_=
t *ppos,
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(file_inode(in)->i_sb),
> -               .user_file =3D in,
>                 .accessed =3D ovl_file_accessed,
>         };
>
> @@ -346,7 +343,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_=
t *ppos,
>         if (ret)
>                 return ret;
>
> -       ret =3D backing_file_splice_read(fd_file(real), ppos, pipe, len, =
flags, &ctx);
> +       ret =3D backing_file_splice_read(fd_file(real), in, ppos, pipe, l=
en, flags, &ctx);
>         fdput(real);
>
>         return ret;
> @@ -368,7 +365,6 @@ static ssize_t ovl_splice_write(struct pipe_inode_inf=
o *pipe, struct file *out,
>         ssize_t ret;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(inode->i_sb),
> -               .user_file =3D out,
>                 .end_write =3D ovl_file_end_write,
>         };
>
> @@ -380,9 +376,10 @@ static ssize_t ovl_splice_write(struct pipe_inode_in=
fo *pipe, struct file *out,
>         if (ret)
>                 goto out_unlock;
>
> -       ret =3D backing_file_splice_write(pipe, fd_file(real), ppos, len,=
 flags, &ctx);
> +       ret =3D backing_file_splice_write(pipe, fd_file(real), out, ppos,=
 len, flags, &ctx);
>         fdput(real);
>
> +
>  out_unlock:
>         inode_unlock(inode);
>
> @@ -420,7 +417,6 @@ static int ovl_mmap(struct file *file, struct vm_area=
_struct *vma)
>         struct file *realfile =3D file->private_data;
>         struct backing_file_ctx ctx =3D {
>                 .cred =3D ovl_creds(file_inode(file)->i_sb),
> -               .user_file =3D file,
>                 .accessed =3D ovl_file_accessed,
>         };
>
> diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
> index 2eed0ffb5e8f..7db9f77281ca 100644
> --- a/include/linux/backing-file.h
> +++ b/include/linux/backing-file.h
> @@ -14,9 +14,8 @@
>
>  struct backing_file_ctx {
>         const struct cred *cred;
> -       struct file *user_file;
>         void (*accessed)(struct file *);
> -       void (*end_write)(struct file *, loff_t, ssize_t);
> +       void (*end_write)(struct kiocb *iocb, ssize_t);
>  };

This seems wrong to me, that the callback gets an iocb
that was not initialized by the caller of backing_file_*().
It seems better if the callback would get the backing_file_ctx.
We could copy the pos to this ctx if you think this is better.

OTOH, ->user_file pretty much belongs to backing_file_ctx,
even if only used in the io callbacks.

Thanks,
Amir.

