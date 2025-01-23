Return-Path: <linux-fsdevel+bounces-39929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9CA1A29F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E865D16B9C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121420E028;
	Thu, 23 Jan 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdfq8NyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA920C46B;
	Thu, 23 Jan 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630634; cv=none; b=tnRow285yf63qzdqq/AHRTVnF76cLS0chBJr/h/+h/1daZ+4lg42TxUT7SWkMHR2340qJrrU9ennPowNMDy2NVqIqLN89b1oi8jhVNgqUxnoeYq5MT1q09KF8R9ztzQDl6zdJe7TNPIm0FxTUtToaJAvtUn4/UVq0gyXV0PW9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630634; c=relaxed/simple;
	bh=IbbfVA8bhzqO7I+ymWaD/VXIIvt/l6goTwGg97AfagA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmBKU9Lz2XwV+4BEBOVG4rYsiCIH4mccP04n5Elg2zcopHJDW9gGOYTDIse+cCv9xPY9+V4Yhkk80KScUaNN0WmeMdVRf6k7OBLER7Gguc0VAhfVTvq+ywM/l8AnvL4PnpwysFaSE+rvaawpbzLfNjPyTXMvQmju3tNgIVVQXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdfq8NyN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so143650766b.2;
        Thu, 23 Jan 2025 03:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737630629; x=1738235429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mt9hdCb8jWvSHMboYbl/obdxGlPSpYUEE+3X6CuCaQ=;
        b=Pdfq8NyN4Ddmak4H+ysO5f0aZtpmrDV2SKlhrGSy6idAldfn8LjSgCgIexOVvfWSGG
         9CdoTxVOe4JJvEg5b+pPJYIAsF9jNya1M1i4B9YwQi/aONPAxOdIOqnFbppF8SfkVyTU
         SBqG9Fh33hex9YIKwrMHAT6ydr3rJXI7AqLaRF8RyvKhTZNswmIhA9S2fQ2+8bAbR/J4
         ZFYEiK8BJ4Kwsor8CyFZP1Ti6m3Yj43tGeC3Fgq6oKJ34KZuPMwLsp13mN39et2IN7cO
         BK2QEBUmZawIm+fPuAwOjYvb/JV9u2vQzgfdrFXkzWVfBm1lgJUSxyCc2/mULe74pLVg
         8RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630629; x=1738235429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Mt9hdCb8jWvSHMboYbl/obdxGlPSpYUEE+3X6CuCaQ=;
        b=bL1sHdMiEmPAsFNKkWE+H/G5t+4Gt3QDUIAw6vCZtM3scH/Thmq3I2JfwLLBdSktgz
         5KncvGV3Jfnamjg2w5zQ2AH9aSImk8qdz8Viu1U8Z8Pw9ftPScAlSghxZYrc8u1EWeFt
         RxMTOYpJdlZIRazoRtUtz+vLH6XwXQ/cQCo04kk9zLF063uv9Ik0jWWfCA/D+rwkIJNY
         WUwc4UjylqxtE96ckOnVeo3KNgwwxOIYBEUlpqkTCQagUx0MDSDv6g9dXuQROGv7/BqK
         Y4GRwcC0YEb7HNfXcZUbx/S+aPsSngBa5hJE7HpvSL0awRjir+GlIZYqZ1GehWWXZWrX
         yP2A==
X-Forwarded-Encrypted: i=1; AJvYcCVy561kRV2O1a/wk1V4EMf6CxNYK7Cl9htkFOrcJlRb2jaLG943rJUYT7tAngP1BJzf9qo6C8q/JDdH2UePLA==@vger.kernel.org, AJvYcCWyPugN+gYTtzlRPPSko+avEzkT7z7FPhGOQZyKBg8oaYmCyeT8D1NfzZATYrTPQwdZc3totQl/qTQIeyk7@vger.kernel.org
X-Gm-Message-State: AOJu0YwuliFexUQvQ4Fe5WJP5K0PmnbT5wxBimpPyIC0F+C/2whygMlP
	h1vN5+ez2eRXq4GG2tDUax7i3dBnM82xqO8yPWpeJ0iM79syoXXeCyTOjkcuV0MMn4aZZ61nzyY
	yGEsosG7CKuaZWSLamm6KjsV3bHY=
X-Gm-Gg: ASbGncu4JVPlkvBlEbVn76F50/esgxOE1YLUO6kIkF+EG5Qqvbudpv+e8ZQpSQljX1D
	8zk8wFSrBCifFHnm/sUWFBZhoYaLddj79ip6+do5ISFurMdpbAeZxahA8OFq2MA==
X-Google-Smtp-Source: AGHT+IHx4rsLel4teWhDpPyXDIgeyN206RmSB5Hvd4IxfNU9KoIxkuRzY3r3aEXldeULOweNfkpHt0/c4WD+7UiZOG4=
X-Received: by 2002:a17:907:9604:b0:ab3:47cc:a7dc with SMTP id
 a640c23a62f3a-ab38b12768emr2239412966b.22.1737630628633; Thu, 23 Jan 2025
 03:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123081804.550042-1-hanwen@engflow.com>
In-Reply-To: <20250123081804.550042-1-hanwen@engflow.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Jan 2025 12:10:16 +0100
X-Gm-Features: AWEUYZmMnApLiTaYxV7EG32QjzmhCblfgHxBx9MVRdtC030dbBcVD1UW0Y8AE6g
Message-ID: <CAOQ4uxgwJuZWQ9WgpmNL=fdsycwduOqXio5kEciD6TOWoMX8kw@mail.gmail.com>
Subject: Re: [PATCH] fs: support cross-type copy_file_range in overlayfs.
To: Han-Wen Nienhuys <hanwen@engflow.com>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dave Chinner <david@fromorbit.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:18=E2=80=AFAM Han-Wen Nienhuys <hanwen@engflow.co=
m> wrote:
>
> Introduces the FOP_CROSS_TYPE_COPYFILE flag, and implements it for
> overlayfs. This enables copy_file_range between an overlayfs mount and
> its constituent layers.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@engflow.com>
> ---

>
> Whoops, I should have sent a cover letter.

FYI, with a single patch, you can write the "cover letter" in the patch its=
elf
after the --- line, but with my suggestion below, you should probably split
this to one vfs patch to change copy_file_range() interface and another
patch to implement ovl_copy_file_range() support.

>
> I thought this could speed a lot of operations in docker/podman.

What sort of operations are we talking about?
The only relevant use case as far as I can tell is copying
from a shared lower fs directly into overlayfs, but why is this useful?
to which scenario?
Do you have an example of use cases for copy to another direction?

This should be included in the cover letter as well as performance
speed figures if the improvement is dubbed a performance improvement.

>
> This is my first time patching the kernel, so please be gentle.

ok :)

The change that you are proposing is not constrained to overlayfs.
The FOP_CROSS_TYPE_COPYFILE change is a vfs change,
so I added linux-fsdevel list to CC (please do so for follow up revisions
i.e. PATCH v2...).

Also added to CC the developers Dave Chinner and Darrick J. Wong
who were actively involved in shaping the copy_file_range()
vfs API to the way that it is right now.

> I don't really know what I'm doing, but it seems to work. I tested this
> manually using qemu; is there an official test suite where I could add
> a test?

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
See: README.overlay
Try ./check -overlay -g copy_range

and specifically:
$ git grep copy_file_range.*cross
tests/generic/565:# Exercise copy_file_range() across devices supported by =
some
tests/generic/565:# 5dae222a5ff0 vfs: allow copy_file_range to copy
across devices

tests/generic are not doing overlayfs specific operations and never have co=
de
that is aware of internals like $OVL_BASE_SCRATCH_MNT, they simply run
on top of whatever filesystems and on top of overlayfs with -overlayfs run =
flag.

For testing your change, you will need a tests/overlay specific copy_range =
test.
Let's talk about that if that becomes relevant.

More comments to the point inline

>  fs/overlayfs/file.c | 60 ++++++++++++++++++++++++++++++---------------
>  fs/read_write.c     | 15 ++++++++----
>  include/linux/fs.h  |  4 +++
>  3 files changed, 54 insertions(+), 25 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 969b458100fe..97b394737251 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -536,6 +536,9 @@ static int ovl_fadvise(struct file *file, loff_t offs=
et, loff_t len, int advice)
>         return ret;
>  }
>
> +static ssize_t ovl_copy_file_range(struct file *file_in, loff_t pos_in,
> +                                  struct file *file_out, loff_t pos_out,
> +                                  size_t len, unsigned int flags);
>  enum ovl_copyop {
>         OVL_COPY,
>         OVL_CLONE,
> @@ -547,30 +550,42 @@ static loff_t ovl_copyfile(struct file *file_in, lo=
ff_t pos_in,
>                             loff_t len, unsigned int flags, enum ovl_copy=
op op)
>  {
>         struct inode *inode_out =3D file_inode(file_out);
> -       struct file *realfile_in, *realfile_out;
> +       struct file *realfile_in =3D file_in;
> +       struct file *realfile_out =3D file_out;
>         const struct cred *old_cred;
>         loff_t ret;
> +       bool in_overlay =3D file_in->f_op->copy_file_range =3D=3D &ovl_co=
py_file_range;
> +       bool out_overlay =3D file_out->f_op->copy_file_range =3D=3D &ovl_=
copy_file_range;

I prefer if we did not add the support for copying out of overlayfs
unless there is a *very* good reason to do so and then
out_overlay is not needed and all the conditions below not needed.
It is always true, because of how ->copy_file_range() is called (see below)

The only case that you could improve is copy from a file in the sb of upper=
 fs
to the overlayfs sb. Anything else should return -EXDEV.

Note that cross-sb copy_file_range() supported by cifs_copy_file_range()
and nfs4_copy_file_range() is quite close to what you are trying to do here
I will propose below a way to unify those cases.


>
> -       inode_lock(inode_out);
> -       if (op !=3D OVL_DEDUPE) {
> -               /* Update mode */
> -               ovl_copyattr(inode_out);
> -               ret =3D file_remove_privs(file_out);
> -               if (ret)
> -                       goto out_unlock;
> +       if (WARN_ON_ONCE(!in_overlay && !out_overlay))
> +               return -EXDEV;
> +
> +       if (in_overlay) {
> +               realfile_in =3D ovl_real_file(file_in);
> +               ret =3D PTR_ERR(realfile_in);
> +               if (IS_ERR(realfile_in))
> +                       return ret;
>         }
>
> -       realfile_out =3D ovl_real_file(file_out);
> -       ret =3D PTR_ERR(realfile_out);
> -       if (IS_ERR(realfile_out))
> -               goto out_unlock;
> +       if (out_overlay) {
> +               inode_lock(inode_out);
>
> -       realfile_in =3D ovl_real_file(file_in);
> -       ret =3D PTR_ERR(realfile_in);
> -       if (IS_ERR(realfile_in))
> -               goto out_unlock;
> +               if (op !=3D OVL_DEDUPE) {
> +                       /* Update mode */
> +                       ovl_copyattr(inode_out);
> +                       ret =3D file_remove_privs(file_out);
> +                       if (ret)
> +                               goto out_unlock;
> +               }
> +
> +               realfile_out =3D ovl_real_file(file_out);
> +               ret =3D PTR_ERR(realfile_out);
> +               if (IS_ERR(realfile_out))
> +                       goto out_unlock;
> +
> +               old_cred =3D ovl_override_creds(file_inode(file_out)->i_s=
b);
> +       }
>
> -       old_cred =3D ovl_override_creds(file_inode(file_out)->i_sb);
>         switch (op) {
>         case OVL_COPY:
>                 ret =3D vfs_copy_file_range(realfile_in, pos_in,
> @@ -588,13 +603,16 @@ static loff_t ovl_copyfile(struct file *file_in, lo=
ff_t pos_in,
>                                                 flags);
>                 break;
>         }
> -       ovl_revert_creds(old_cred);
>
>         /* Update size */
> -       ovl_file_modified(file_out);
> +       if (out_overlay) {
> +               ovl_file_modified(file_out);
> +               ovl_revert_creds(old_cred);
> +       }
>
>  out_unlock:
> -       inode_unlock(inode_out);
> +       if (out_overlay)
> +               inode_unlock(inode_out);
>
>         return ret;
>  }
> @@ -654,6 +672,8 @@ static int ovl_flush(struct file *file, fl_owner_t id=
)
>  }
>
>  const struct file_operations ovl_file_operations =3D {
> +       .fop_flags      =3D FOP_CROSS_TYPE_COPYFILE,
> +

I suggest instead FOP_CROSS_SB_COPYFILE and set it
also for nfs4_file_operations (CONFIG_NFS_V4_2) and for
all the cifs_file_ops flavors.

cross-sb-copy is a private case of cross-fstype-copy

nfs4_copy_file_range() already verifies that the source is
from the same fstype with wrong comment that should be fixed:

@@ -143,7 +143,7 @@ static ssize_t __nfs4_copy_file_range(struct file
*file_in, loff_t pos_in,
        ssize_t ret;
        bool sync =3D false;

-       /* Only offload copy if superblock is the same */
+       /* Only offload copy if source is also nfs42 */
        if (file_in->f_op !=3D &nfs4_file_operations)
                return -EXDEV;

For cifs, you'd need to add an explicit check:

@@ -1382,6 +1382,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,

        cifs_dbg(FYI, "copychunk range\n");

+       /* Only offload copy if source is also cifs */
+       if (src_file->f_op->copy_file_range !=3D cifs_copy_file_range)
+               return -EXDEV;
+

and then...

>         .open           =3D ovl_open,
>         .release        =3D ovl_release,
>         .llseek         =3D ovl_llseek,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index a6133241dfb8..93618441a02d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1489,7 +1489,7 @@ static int generic_copy_file_checks(struct file *fi=
le_in, loff_t pos_in,
>          * We allow some filesystems to handle cross sb copy, but passing
>          * a file of the wrong filesystem type to filesystem driver can r=
esult
>          * in an attempt to dereference the wrong type of ->private_data,=
 so
> -        * avoid doing that until we really have a good reason.
> +        * avoid doing unless FOP_CROSS_TYPE_COPYFILE is set.
>          *
>          * nfs and cifs define several different file_system_type structu=
res
>          * and several different sets of file_operations, but they all en=
d up
> @@ -1497,6 +1497,9 @@ static int generic_copy_file_checks(struct file *fi=
le_in, loff_t pos_in,
>          */
>         if (flags & COPY_FILE_SPLICE) {
>                 /* cross sb splice is allowed */
> +       } else if (file_in->f_op->fop_flags & FOP_CROSS_TYPE_COPYFILE ||
> +                  file_out->f_op->fop_flags & FOP_CROSS_TYPE_COPYFILE) {
> +               /* file system understands how to cross FS types */
>         } else if (file_out->f_op->copy_file_range) {
>                 if (file_in->f_op->copy_file_range !=3D
>                     file_out->f_op->copy_file_range)

This becomes something like:

@@ -1477,6 +1477,8 @@ static int generic_copy_file_checks(struct file
*file_in, loff_t pos_in,
 {
        struct inode *inode_in =3D file_inode(file_in);
        struct inode *inode_out =3D file_inode(file_out);
+       bool samesb =3D file_inode(file_in)->i_sb =3D=3D file_inode(file_ou=
t)->i_sb;
+       bool allow_cross_sb =3D file_out->f_op->fop_flags & FOP_CROSS_SB_CO=
PYFILE;
        uint64_t count =3D *req_count;
        loff_t size_in;
        int ret;
@@ -1489,19 +1491,14 @@ static int generic_copy_file_checks(struct
file *file_in, loff_t pos_in,
         * We allow some filesystems to handle cross sb copy, but passing
         * a file of the wrong filesystem type to filesystem driver can res=
ult
         * in an attempt to dereference the wrong type of ->private_data, s=
o
-        * avoid doing that until we really have a good reason.
-        *
-        * nfs and cifs define several different file_system_type structure=
s
-        * and several different sets of file_operations, but they all end =
up
-        * using the same ->copy_file_range() function pointer.
+        * avoid doing that unless a filesystem declares cross sb copy supp=
ort.
         */
        if (flags & COPY_FILE_SPLICE) {
                /* cross sb splice is allowed */
        } else if (file_out->f_op->copy_file_range) {
-               if (file_in->f_op->copy_file_range !=3D
-                   file_out->f_op->copy_file_range)
+               if (!samesb && !allow_cross_sb)
                        return -EXDEV;
-       } else if (file_inode(file_in)->i_sb !=3D file_inode(file_out)->i_s=
b) {
+       } else if (!samesb) {
                return -EXDEV;
        }

and stops relying on the heuristic
"cifs define several different file_system_type structures
 and several different sets of file_operations, but they all end up
 using the same ->copy_file_range() function pointer"

> @@ -1576,10 +1579,12 @@ ssize_t vfs_copy_file_range(struct file *file_in,=
 loff_t pos_in,
>          * same sb using clone, but for filesystems where both clone and =
copy
>          * are supported (e.g. nfs,cifs), we only call the copy method.
>          */
> -       if (!splice && file_out->f_op->copy_file_range) {
> -               ret =3D file_out->f_op->copy_file_range(file_in, pos_in,
> -                                                     file_out, pos_out,
> -                                                     len, flags);
> +       if (!splice && (file_in->f_op->copy_file_range || file_out->f_op-=
>copy_file_range)) {
> +               ret =3D  (file_in->f_op->copy_file_range ?
> +                       file_in->f_op->copy_file_range :
> +                       file_out->f_op->copy_file_range)(file_in, pos_in,
> +                                                        file_out, pos_ou=
t,
> +                                                        len, flags);

I prefer not to do that unless there is a *very* good reason.
copy from another sb source is less risky IMO.

Thanks,
Amir.

