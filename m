Return-Path: <linux-fsdevel+bounces-53906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FC9AF8C94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA03587C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548B285CBC;
	Fri,  4 Jul 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPMQykqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBE328B1E;
	Fri,  4 Jul 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618679; cv=none; b=N7gkmVq50yWpEx1B3V8aRU5l1CWk/ZbC5SuYcJ1R5g1hNDlb7jwDxAd2i3zg42wnDg1pZHgg1L8RBSA8drnWBkLPGuFispugY1CB9KQXb5IGd9mOBpXfa+z6kH3/RyzSSA7e0YWSQL6XwCetiGfUkwQjERPFgS5gI/O5P+M/Wh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618679; c=relaxed/simple;
	bh=ubkxPX2FW+GZUe3/04Eh7dd0rWb/KcE745/jPL04D+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lpdm+y+N5nSPlh0DZcvByOhBMwRGfpobiteHJss14hPwXXxGxQhWw+dftq7C7aH/f6qILma2+LA0sorKXwbCenXvLkO6uTAvhVQQZWNpd8TGAqr9qETDAhsIBAnfklcOStK31yMNYJoUCWgAhK/azgI78yRpACgE3htOMy6/pLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPMQykqK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so1196644a12.2;
        Fri, 04 Jul 2025 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751618675; x=1752223475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLxVD++bObx7XIGt1aHIikLchHPfaB8ug5wDwTwQnEE=;
        b=iPMQykqKQDzJ/qyqwf8UXnEM+QAeQ/FMxrsswA+vRKzBE8LDpCvdyLO5n41ee9nsXI
         EcN1jLK69K30zD01Hymxd88y+3th6KBcZaBaGAAs2Nu5OihJCKQuxq8qR6T6VYDcp7ma
         SvXNp/cbZNe2XR0fTV6SlfNYgiLM0eLeQBI7SiMqQtH8WZC4soJLvqiNt4r4SEDJMWE5
         xhGpWYHMOky90jBejawKzd+VJTkP1XD6D2/5690GX4/zDVQU1Dc6ovzKgdsCwBubqkB0
         QxlQbhzPmOMFE9r8UFcIci1dKEduETdglQ/aIXDxjH+/hBww1AtZS+pgLLp6QlAKBAeH
         eTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618675; x=1752223475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLxVD++bObx7XIGt1aHIikLchHPfaB8ug5wDwTwQnEE=;
        b=m1j99wHQCJZ9R2cswD6C6lpXV27uYeidgBgqnS7AtXp5POnuFMyetGy2vbhC+DsfkH
         vHF+pFz93d/f9ZzEFUbSe35ZvLBa172Ia0YGqJ1b1B0f9skjgXU3vQxIRcNv8BZffXAX
         pzG1MvUWbWRph0+fCXzI9uzTjfvwVas5/f0qlhnLUAkl+0iHwau5Nk+fiQIMle0CV20e
         2saAjFqLz1Hzh5wG3JT1VeW4NdKJV0c5UmPMfumUQ6DJPKKsJ/kTujKWJHM7hBruzhdj
         G82O2vMWvnwJ5LM3tEUTyDaEY39Ilg9iucoEMGB0uaCDesnsKJ1kQP2ZfBP06dU2hZ4s
         qC9w==
X-Forwarded-Encrypted: i=1; AJvYcCUJc2MI22hgReNm4MAS8eZ7YRazNsna6aV68eSvcUzQ3O1GrH4DQTyGQJAxPYO9SGDu1MCIWzJIfis=@vger.kernel.org, AJvYcCVz99qTlXDClG5P9+8XFVtEP4HvfvqS1CryeEpobOhTeuvSug3nRxv/ruDP5VEXtlBSyOQ/1iw38voFMNLdPQ==@vger.kernel.org, AJvYcCWdzH0VOmHblQDyvz+N+KripNDLuED22kjZQTNrJB41X7I5IIsohMBT6alrD57S5cHjCzIlZWTnwTJZLlsO@vger.kernel.org, AJvYcCXW4EfoZbkYkc8Kz+ZJOM6wreIEwJ3p0NUUYfhvT15l+/6fv0h4qtf0GnX8aA7pr9Oas2ifYDNs0tgK@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJTJflQl3gdga1WBxskRDxtM/7BT+MVfgv6uF2ghy9quM6EhJ
	yt78mjV1jS5QtcRHVOtaNZPPRNhitEyk3pvGE+/9NVJf0brmUnCL2QGTlbiXs9IsXubioWIcrYx
	8RKJsn36j5HtBKE6kDb/DmBqp7+wboQc=
X-Gm-Gg: ASbGncu9u47uoOhlybqaw+P67KaOlN/7u3jY++7dI92NiimhXUvSmFKpSK0o549QgVu
	5Xo9/rPw7sK0aq3S3RclLzVO4EEiqe6a/tlu9OPNx9B81RFELs+XF3E+f75W52hZ58yaHlqkd3W
	CVfC3piEKFFm5Qn8yNCGqsfyOb/XeiB6NpfoNXRpapPfw=
X-Google-Smtp-Source: AGHT+IFBDaP8zQxWcQljULEFa6GosLHM1Fr9HgBZPyfuh3qYvt0YaniWVIKCyvoHhchZrszWhCvhEz6VfcNnf1wh2wI=
X-Received: by 2002:a17:907:7290:b0:ae3:64ec:5eb0 with SMTP id
 a640c23a62f3a-ae3fbc2896bmr136387066b.11.1751618674841; Fri, 04 Jul 2025
 01:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-10-john@groves.net>
In-Reply-To: <20250703185032.46568-10-john@groves.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Jul 2025 10:44:23 +0200
X-Gm-Features: Ac12FXxwSwxI5T6ujv-byO1091sUsmVe0O4bcF4RyE_aZllEPVlxUcLQOg0w034
Message-ID: <CAOQ4uxgqMOL4aRnpm02Q7V8_T1vtgHHxe+QnoLANhS_Vr2-VRw@mail.gmail.com>
Subject: Re: [RFC V2 09/18] famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:51=E2=80=AFPM John Groves <John@groves.net> wrote:
>
> Virtio_fs now needs to determine if an inode is DAX && not famfs.
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/dir.c    |  2 +-
>  fs/fuse/file.c   | 13 ++++++++-----
>  fs/fuse/fuse_i.h |  6 +++++-
>  fs/fuse/inode.c  |  2 +-
>  fs/fuse/iomode.c |  2 +-
>  5 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 8f699c67561f..ad8cdf7b864a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1939,7 +1939,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct=
 dentry *dentry,
>                 is_truncate =3D true;
>         }
>
> -       if (FUSE_IS_DAX(inode) && is_truncate) {
> +       if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
>                 filemap_invalidate_lock(mapping);
>                 fault_blocked =3D true;
>                 err =3D fuse_dax_break_layouts(inode, 0, -1);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 754378dd9f71..93b82660f0c8 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -239,7 +239,7 @@ static int fuse_open(struct inode *inode, struct file=
 *file)
>         int err;
>         bool is_truncate =3D (file->f_flags & O_TRUNC) && fc->atomic_o_tr=
unc;
>         bool is_wb_truncate =3D is_truncate && fc->writeback_cache;
> -       bool dax_truncate =3D is_truncate && FUSE_IS_DAX(inode);
> +       bool dax_truncate =3D is_truncate && FUSE_IS_VIRTIO_DAX(fi);
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
> @@ -1770,11 +1770,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>         struct file *file =3D iocb->ki_filp;
>         struct fuse_file *ff =3D file->private_data;
>         struct inode *inode =3D file_inode(file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> -       if (FUSE_IS_DAX(inode))
> +       if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_read_iter(iocb, to);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> @@ -1791,11 +1792,12 @@ static ssize_t fuse_file_write_iter(struct kiocb =
*iocb, struct iov_iter *from)
>         struct file *file =3D iocb->ki_filp;
>         struct fuse_file *ff =3D file->private_data;
>         struct inode *inode =3D file_inode(file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> -       if (FUSE_IS_DAX(inode))
> +       if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_write_iter(iocb, from);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> @@ -2627,10 +2629,11 @@ static int fuse_file_mmap(struct file *file, stru=
ct vm_area_struct *vma)
>         struct fuse_file *ff =3D file->private_data;
>         struct fuse_conn *fc =3D ff->fm->fc;
>         struct inode *inode =3D file_inode(file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>         int rc;
>
>         /* DAX mmap is superior to direct_io mmap */
> -       if (FUSE_IS_DAX(inode))
> +       if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_mmap(file, vma);
>
>         /*
> @@ -3191,7 +3194,7 @@ static long fuse_file_fallocate(struct file *file, =
int mode, loff_t offset,
>                 .mode =3D mode
>         };
>         int err;
> -       bool block_faults =3D FUSE_IS_DAX(inode) &&
> +       bool block_faults =3D FUSE_IS_VIRTIO_DAX(fi) &&
>                 (!(mode & FALLOC_FL_KEEP_SIZE) ||
>                  (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 2086dac7243b..9d87ac48d724 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1426,7 +1426,11 @@ void fuse_free_conn(struct fuse_conn *fc);
>
>  /* dax.c */
>
> -#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode)=
)
> +/* This macro is used by virtio_fs, but now it also needs to filter for
> + * "not famfs"
> + */
> +#define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)    \
> +                                       && IS_DAX(&fuse_inode->inode))

I think we should take this opportunity to make it
static inline fuse_is_virtio_dax()

and because some of the call site really do want to know if this is dax
should also leave a helper

static inline fuse_is_dax()

...

>
>  ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150..29147657a99f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -164,7 +164,7 @@ static void fuse_evict_inode(struct inode *inode)
>         if (inode->i_sb->s_flags & SB_ACTIVE) {
>                 struct fuse_conn *fc =3D get_fuse_conn(inode);
>
> -               if (FUSE_IS_DAX(inode))
> +               if (FUSE_IS_VIRTIO_DAX(fi))
>                         fuse_dax_inode_cleanup(inode);
>                 if (fi->nlookup) {
>                         fuse_queue_forget(fc, fi->forget, fi->nodeid,
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index c99e285f3183..aec4aecb5d79 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -204,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode=
 *inode)
>          * io modes are not relevant with DAX and with server that does n=
ot
>          * implement open.
>          */
> -       if (FUSE_IS_DAX(inode) || !ff->args)
> +       if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
>                 return 0;
>

... Like here, later in your patch set you add explicit check for
!fuse_famfs_file()

If you make this into if (fuse_is_dax(fi)
it will be easier and nicer in the end.

Thanks,
Amir.

