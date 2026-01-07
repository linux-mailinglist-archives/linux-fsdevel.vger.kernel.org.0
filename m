Return-Path: <linux-fsdevel+bounces-72566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F1CFB9EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 02:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 555233047FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 01:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5001DE89A;
	Wed,  7 Jan 2026 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3m3GpJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181615687D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750383; cv=none; b=rpRJyaA7dyyLxHOUz04vkOFZvMttRtLVr1YWojgG0NRBmjDWY9lPPbG8QwSLzi4WpwI3oaM0QKKnnB2ZghYR9qojhZLbqPQUwyORPwUQwlsBCdqzDxmE8VejMkLWyKNtfKkh+l4USerQTGQXKiI+jfCFsShDE2otMR/MzkdAY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750383; c=relaxed/simple;
	bh=DZ9Z3aYuUsZiBZV+yKZ07FElc1b7ZAx8CYgakRVVK0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mm0r4CjpBhtGedvsMPIHCwXzWuN73/ts3Nwf1Xy56YTrZ29VMKV5vcF6cyOQABw3/9uDfV+Dk4/JarfpMAvEuMtMu7aKe40XPx4b9S2oa/WA5NnJYmoyhjw+BCE+mo+phw9kvtqAyZ1vviaF9ik38BFMw4X/YoI3702Di77g7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3m3GpJG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda6a8cc12so16694881cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 17:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767750381; x=1768355181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5MnoG8VI3+vrh/92R3AOIUo0dA/WBNoOz+eG5v+Jy0=;
        b=P3m3GpJGLH8yV4xsKVwOnYr312nqxgwB2BOcvaCawYbC1clR0no+JeKeyeWbMFa+9A
         V8drYldlo3b260e9PTMI6LZt6FiDO3mfkgJD/EEIB+0JftGuCElZylXZnrYxOfDGucpc
         SD0MO4o4GBwPk0nz2u6pSXg0hfVNEvGYRoc9cuN+NW7xqahELWE2qVIavY2JZ6D8yFgF
         iWIPHiTBy6x4CCoGlDxziIPTu4CIYb2p+IDqm0MEPgUPCHWUlkMG+ZLUy4SB8OxTCbH0
         KSdyHElq/ywFIiF3Xc93wodR0CL10WFqr6bcSNxTZVgyRpuPgJQrh5O0ZSCYM46fgKz8
         iJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767750381; x=1768355181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5MnoG8VI3+vrh/92R3AOIUo0dA/WBNoOz+eG5v+Jy0=;
        b=QGticTh+Sf3Cdp44MDPDoacPMQ85udzPfTlfPpSatPRCIwwKz7QMNW1nfpC19PiOb2
         S+88hJMxAjfvhtXFeG61c41MDFBsICOtfBMLI3J/wkbDeeIgRiDmb53cmfQ+KhCKQRYO
         RoPMhNnLBjP8/Ze/BlgRMtf1kScgsNiJHF/ttNL3+ySuK968RcROrZINgoKpQBnTeXXG
         0nuJJbIm7Y50DpuwgPef189QXzjnXnUWDVGNIiwOUgwKaiX2/HYYDnTOpf6JD8X0i0fR
         NEVx0Ug1KSSon0zYDHAg2Ff+SJ5Pw1WVAlVLbLBCktpSNvcDDL9Q4iMMIw9vbXaYtN0e
         qYIg==
X-Forwarded-Encrypted: i=1; AJvYcCWAc/GD8q0xDiq8fFwbpGq9bUNH1HpPY9OAeDX10CayZ0ffWSB3qa+K/+QXVI9Uqa4RlW/vEW5Q9B6LiWwn@vger.kernel.org
X-Gm-Message-State: AOJu0YynUeJTHgmM1hkTnU7DLNnYHQnYwr/FiMQZB1ueA1QjVm11JENh
	OjbWc+2dyibaLP7sDrbVIafH69UlnGsVvmwQhTKZIYSgca+M2zccV29sjbjHcjD4LvaYpAOOv8w
	PzMJbpB7YqBFChmjZvEGIXQPoQMkvVwk5CdHx
X-Gm-Gg: AY/fxX5ISJaDsbA936QF3AV0DmOBuXOY72ci5vS12Lp+80clEYy2dM6i4nr11HhGItq
	JIhwpU1b9D+vR5X3eY2rAQ/I2z2Q7cs3agWWqbF0GfnkKdyKtEKgPeegaJgcvlvo/u/LdOELJgH
	QGjOvhPrzzvVxyZrWDIZLtMyuWbdPVgaLa6g9leH5gC89g7rRu3+RLQofsKPtgsGdbAEq5uEvC+
	UZm2i/HPH94HuzipaMivc37wDAgVmIRFSp/Da1VI9JwQVYErXgMTaaUrpQuVOyG/+pRA4Sn0hfL
	h+niBie1qVc=
X-Google-Smtp-Source: AGHT+IGT0ZnsAleOm4aL5d5Q5yIAnHa19IgwgMoBTGzWQQOl42PVwEo+5PeTQsVVHA5jSvXiFwp5IzY3dRDthYI3eik=
X-Received: by 2002:a05:622a:8c8:b0:4ed:66bd:95ea with SMTP id
 d75a77b69052e-4ffb4931a71mr14873031cf.29.1767750380571; Tue, 06 Jan 2026
 17:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com> <20251223-fuse-compounds-upstream-v2-2-0f7b4451c85e@ddn.com>
In-Reply-To: <20251223-fuse-compounds-upstream-v2-2-0f7b4451c85e@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Jan 2026 17:46:09 -0800
X-Gm-Features: AQt7F2re1KoYOLl_DLqE3LlyAcgZ1kNAspFVi04QSMffEXl3A_Ae3THrJew_Y4c
Message-ID: <CAJnrk1bCenZHzPSrdjxzUMY4ekKhtAJ74Dg1QhUs77A1qEDu3A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] fuse: add an implementation of open+getattr
To: Horst Birthelmer <hbirthelmer@googlemail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 2:13=E2=80=AFPM Horst Birthelmer
<hbirthelmer@googlemail.com> wrote:
>
> The discussion about compound commands in fuse was
> started over an argument to add a new operation that
> will open a file and return its attributes in the same operation.
>
> Here is a demonstration of that use case with compound commands.
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/file.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  fs/fuse/fuse_i.h |   6 ++-
>  fs/fuse/inode.c  |   6 +++
>  fs/fuse/ioctl.c  |   2 +-
>  4 files changed, 121 insertions(+), 18 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..507b4c4ba257 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -126,8 +126,84 @@ static void fuse_file_put(struct fuse_file *ff, bool=
 sync)
>         }
>  }
>
> +static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
> +                               int flags, int opcode,
> +                               struct fuse_file *ff,
> +                               struct fuse_attr_out *outattrp,
> +                               struct fuse_open_out *outopenp)
> +{
> +       struct fuse_compound_req *compound;
> +       struct fuse_args open_args =3D {}, getattr_args =3D {};
> +       struct fuse_open_in open_in =3D {};
> +       struct fuse_getattr_in getattr_in =3D {};
> +       int err;
> +
> +       /* Build compound request with flag to execute in the given order=
 */
> +       compound =3D fuse_compound_alloc(fm, 0);
> +       if (IS_ERR(compound))
> +               return PTR_ERR(compound);
> +
> +       /* Add OPEN */
> +       open_in.flags =3D flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> +       if (!fm->fc->atomic_o_trunc)
> +               open_in.flags &=3D ~O_TRUNC;
> +
> +       if (fm->fc->handle_killpriv_v2 &&
> +           (open_in.flags & O_TRUNC) && !capable(CAP_FSETID)) {
> +               open_in.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
> +       }
> +       open_args.opcode =3D opcode;
> +       open_args.nodeid =3D nodeid;
> +       open_args.in_numargs =3D 1;
> +       open_args.in_args[0].size =3D sizeof(open_in);
> +       open_args.in_args[0].value =3D &open_in;
> +       open_args.out_numargs =3D 1;
> +       open_args.out_args[0].size =3D sizeof(struct fuse_open_out);
> +       open_args.out_args[0].value =3D outopenp;
> +
> +       err =3D fuse_compound_add(compound, &open_args);
> +       if (err)
> +               goto out;
> +
> +       /* Add GETATTR */
> +       getattr_args.opcode =3D FUSE_GETATTR;
> +       getattr_args.nodeid =3D nodeid;
> +       getattr_args.in_numargs =3D 1;
> +       getattr_args.in_args[0].size =3D sizeof(getattr_in);
> +       getattr_args.in_args[0].value =3D &getattr_in;
> +       getattr_args.out_numargs =3D 1;
> +       getattr_args.out_args[0].size =3D sizeof(struct fuse_attr_out);
> +       getattr_args.out_args[0].value =3D outattrp;

I think things end up looking cleaner here (and above for the open
args) if the arg initialization logic gets abstracted into helper
functions, as fuse_do_getattr() and fuse_send_open() have pretty much
the exact same logic.

Thanks,
Joanne

> +
> +       err =3D fuse_compound_add(compound, &getattr_args);
> +       if (err)
> +               goto out;
> +
> +       err =3D fuse_compound_send(compound);
> +       if (err)
> +               goto out;
> +
> +       /* Check if the OPEN operation succeeded */
> +       err =3D fuse_compound_get_error(compound, 0);
> +       if (err)
> +               goto out;
> +
> +       /* Check if the GETATTR operation succeeded */
> +       err =3D fuse_compound_get_error(compound, 1);
> +       if (err)
> +               goto out;
> +
> +       ff->fh =3D outopenp->fh;
> +       ff->open_flags =3D outopenp->open_flags;
> +
> +out:
> +       fuse_compound_free(compound);
> +       return err;
> +}
> +
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> -                                unsigned int open_flags, bool isdir)
> +                               struct inode *inode,
> +                               unsigned int open_flags, bool isdir)
>  {
>         struct fuse_conn *fc =3D fm->fc;
>         struct fuse_file *ff;
> @@ -153,23 +229,41 @@ struct fuse_file *fuse_file_open(struct fuse_mount =
*fm, u64 nodeid,
>         if (open) {
>                 /* Store outarg for fuse_finish_open() */
>                 struct fuse_open_out *outargp =3D &ff->args->open_outarg;
> -               int err;
> +               int err =3D -ENOSYS;
> +
> +               if (inode && fc->compound_open_getattr) {
> +                       struct fuse_attr_out attr_outarg;
> +                       err =3D fuse_compound_open_getattr(fm, nodeid, op=
en_flags,
> +                                                       opcode, ff, &attr=
_outarg, outargp);
> +                       if (!err)
> +                               fuse_change_attributes(inode, &attr_outar=
g.attr, NULL,
> +                                                      ATTR_TIMEOUT(&attr=
_outarg),
> +                                                      fuse_get_attr_vers=
ion(fc));
> +               }
> +               if (err =3D=3D -ENOSYS) {
> +                       err =3D fuse_send_open(fm, nodeid, open_flags, op=
code, outargp);
>
> -               err =3D fuse_send_open(fm, nodeid, open_flags, opcode, ou=
targp);
> -               if (!err) {
> -                       ff->fh =3D outargp->fh;
> -                       ff->open_flags =3D outargp->open_flags;
> -               } else if (err !=3D -ENOSYS) {
> -                       fuse_file_free(ff);
> -                       return ERR_PTR(err);
> -               } else {
> -                       if (isdir) {
> +                       if (!err) {
> +                               ff->fh =3D outargp->fh;
> +                               ff->open_flags =3D outargp->open_flags;
> +                       }
> +               }
> +
> +               if (err) {
> +                       if (err !=3D -ENOSYS) {
> +                               /* err is not ENOSYS */
> +                               fuse_file_free(ff);
> +                               return ERR_PTR(err);
> +                       } else {
>                                 /* No release needed */
>                                 kfree(ff->args);
>                                 ff->args =3D NULL;
> -                               fc->no_opendir =3D 1;
> -                       } else {
> -                               fc->no_open =3D 1;
> +
> +                               /* we don't have open */
> +                               if (isdir)
> +                                       fc->no_opendir =3D 1;
> +                               else
> +                                       fc->no_open =3D 1;
>                         }
>                 }
>         }
> @@ -185,11 +279,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount =
*fm, u64 nodeid,
>  int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
>                  bool isdir)
>  {
> -       struct fuse_file *ff =3D fuse_file_open(fm, nodeid, file->f_flags=
, isdir);
> +       struct fuse_file *ff =3D fuse_file_open(fm, nodeid, file_inode(fi=
le), file->f_flags, isdir);
>
>         if (!IS_ERR(ff))
>                 file->private_data =3D ff;
> -
>         return PTR_ERR_OR_ZERO(ff);
>  }
>  EXPORT_SYMBOL_GPL(fuse_do_open);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 86253517f59b..98af019037c3 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -924,6 +924,9 @@ struct fuse_conn {
>         /* Use io_uring for communication */
>         unsigned int io_uring;
>
> +       /* Does the filesystem support compound operations? */
> +       unsigned int compound_open_getattr:1;
> +
>         /** Maximum stack depth for passthrough backing files */
>         int max_stack_depth;
>
> @@ -1557,7 +1560,8 @@ void fuse_file_io_release(struct fuse_file *ff, str=
uct inode *inode);
>
>  /* file.c */
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> -                                unsigned int open_flags, bool isdir);
> +                                                               struct in=
ode *inode,
> +                                                               unsigned =
int open_flags, bool isdir);
>  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
>                        unsigned int open_flags, fl_owner_t id, bool isdir=
);
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d66622..a5fd721be96d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -991,6 +991,12 @@ void fuse_conn_init(struct fuse_conn *fc, struct fus=
e_mount *fm,
>         fc->blocked =3D 0;
>         fc->initialized =3D 0;
>         fc->connected =3D 1;
> +
> +       /* pretend fuse server supports compound operations
> +        * until it tells us otherwise.
> +        */
> +       fc->compound_open_getattr =3D 1;
> +
>         atomic64_set(&fc->attr_version, 1);
>         atomic64_set(&fc->evict_ctr, 1);
>         get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index fdc175e93f74..07a02e47b2c3 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -494,7 +494,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(stru=
ct inode *inode)
>         if (!S_ISREG(inode->i_mode) && !isdir)
>                 return ERR_PTR(-ENOTTY);
>
> -       return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
> +       return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isd=
ir);
>  }
>
>  static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_fil=
e *ff)
>
> --
> 2.51.0
>
>

