Return-Path: <linux-fsdevel+bounces-54750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E692CB0298D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 08:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD277B7C86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846221765E;
	Sat, 12 Jul 2025 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwWYICmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563783C3C
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752300837; cv=none; b=OLEQ4pD5dl6rl3YknRzmf2UFmY7KFm4OmgeQdi17f4HOrmizCwuEEB5lhx9n0b855xvavLnNx3Sl+bBPg4ZqjhQjD3wI19le9vTkAB/yaM/ktXa0E5LzGr+5NBTmsVLSblQsyWWVI/zncVkV5TEm/sloP0xwZwd4WE0zn2e+kQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752300837; c=relaxed/simple;
	bh=YduENKZei5JScoLHCxwa25/ga0IHSQA1z+w22w64TKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crmEnDWboAt/UdmBwlH/JZv8kY8AV5uj2GEL/iHqEkRpG7z+3LjNZmBLsS+4oiiiE73qU3yKVSOmXiBOoCTbyRyPSY7wPxOYT94hBSUZxsGgON8wb9NGwtIeODSt+pxVVidHuq1d5+W1I46ufdkO1HU4r8NhVpwS1dXI4qX9XaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwWYICmm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso19107495e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752300834; x=1752905634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT+FNau6KYFyTX0YAFuVxu3C/xDuBmClfjNXPu2/L94=;
        b=JwWYICmmNZLOlFgmmSwyw+w74Ud9CJ3mxQLsfzmQHtn3LOu5ciwwamgzUvcghCtFoJ
         qp8fBn8IuaFjI3myTblNMR//vZN9fB8NaJY4YUljGwEVLw+cvUVegW4pqArHVQxRWi3g
         0OxW35znJOwxT/ssxjcVTZIVo23HMW9Q4EcNjlx6oTCgImwimVZIZCY42k4UqHcjZQ5d
         AkEcgYdkDvPK+CFnEKyvHkHKw9hLr/U/bZlOTV0u1fYDJoCO0YZqX0552XARxNC7C2j6
         ThbXcCRdbsqXvctbkaxINo5YPA9VceAx/sdQOgoKkFlC/AtmeclfUttmFxAt7WDw7ImP
         EOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752300834; x=1752905634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT+FNau6KYFyTX0YAFuVxu3C/xDuBmClfjNXPu2/L94=;
        b=xN/hSc9c2Xqr6YeyGBTKbhf3IAoIQiD8OqnreZ+jirW5fUk7hmZcF2BEhw+JLLXJNF
         Zc3beDAjn265cvdJHYYNSVrdC0EFcHOBP3sPSAeNYHroE/X903SYSSo5MiD0MKdunORu
         ViZujkHVzCJCnBsw0qGltIjJvWDvzi8G5xu8I4ZlquGFuAb3QiiHZhkF3U4qiiaf5stO
         OHUNoHCbHEY/+lA8spUbYjL/wguRe6craM3tbj8lBnJ/ElYZ3tsDYt57p+krYaJcJyB/
         QCOk79165Abs6ArISmTsVYgaASootOCaANA3pvstZV3WqBXE+J/uF4lVKWbgCoicfk4S
         u6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6v4R6hB4miQDc7ahf6slRXPie2LVhQj5k0JkThDC0pZpkHqR3w8ZJV6z4IAQ90vLaGyfqtL37VSH+eTzX@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvTk0ruU3NEQdpsruf4HHD/LNT6GDwasq5hnqkeD15sVYtTZd
	R/1asaovEs2dGYfuB05b1G6O1PgqUm63UCg2h1Kxnh2wcCbCNnGS+cNB670/y+RSMWL4AbHpe86
	ev2zyMI+x2Z/UlssHP/wBThp01Kg/ukQ=
X-Gm-Gg: ASbGnct/4oH6eIM4tj8TQYuagBSxnY21w5gNuKWe1lpENN4e61yTW6Jh9JjZj17LzRl
	8Dqj7YkOfiX7+De15+SavnR9thuHiVOzcWcKsH1GHbz3youvPyfEOK5ulSjVoGz9E2LG/j28Jlu
	nMZMjMMUciA1U0u3JdEP3SJQ5CehFkJJk89yPx1benmQA+rfyYq5mx9Ny6u9UM8U86Oo5ZELnYW
	9DcQBI=
X-Google-Smtp-Source: AGHT+IHgS7wTsmuuFp/PX8mZV+0yLBY6dEev9ROebj5A1TrG46APspmAxHwBqaYqis92+tBx08XKbpYOE9lu4mydTKI=
X-Received: by 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-454ec16cb2emr59220185e9.12.1752300833310; Fri, 11 Jul 2025
 23:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709221023.2252033-1-joannelkoong@gmail.com>
 <20250709221023.2252033-2-joannelkoong@gmail.com> <20250712044611.GI2672029@frogsfrogsfrogs>
In-Reply-To: <20250712044611.GI2672029@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Jul 2025 08:13:41 +0200
X-Gm-Features: Ac12FXy92dN0_kWB8HkzCD1ttKYkmxEsdRLYdIUZWpR4Ojnu-Y8VCz6Li6GSAfY
Message-ID: <CAOQ4uxitMfkWe3xvvbZPjCEppnqyMHzkQZc8xDamtSyFNiju4A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] fuse: use iomap for buffered writes
To: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	miklos@szeredi.hu, brauner@kernel.org, anuj20.g@samsung.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 6:46=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jul 09, 2025 at 03:10:19PM -0700, Joanne Koong wrote:
> > Have buffered writes go through iomap. This has two advantages:
> > * granular large folio synchronous reads
> > * granular large folio dirty tracking
> >
> > If for example there is a 1 MB large folio and a write issued at pos 1
> > to pos 1 MB - 2, only the head and tail pages will need to be read in
> > and marked uptodate instead of the entire folio needing to be read in.
> > Non-relevant trailing pages are also skipped (eg if for a 1 MB large
> > folio a write is issued at pos 1 to 4099, only the first two pages are
> > read in and the ones after that are skipped).
> >
> > iomap also has granular dirty tracking. This is useful in that when it
> > comes to writeback time, only the dirty portions of the large folio wil=
l
> > be written instead of having to write out the entire folio. For example
> > if there is a 1 MB large folio and only 2 bytes in it are dirty, only
> > the page for those dirty bytes get written out. Please note that
> > granular writeback is only done once fuse also uses iomap in writeback
> > (separate commit).
> >
> > .release_folio needs to be set to iomap_release_folio so that any
> > allocated iomap ifs structs get freed.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/Kconfig |   1 +
> >  fs/fuse/file.c  | 148 ++++++++++++++++++------------------------------
> >  2 files changed, 55 insertions(+), 94 deletions(-)
> >
> > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > index ca215a3cba3e..a774166264de 100644
> > --- a/fs/fuse/Kconfig
> > +++ b/fs/fuse/Kconfig
> > @@ -2,6 +2,7 @@
> >  config FUSE_FS
> >       tristate "FUSE (Filesystem in Userspace) support"
> >       select FS_POSIX_ACL
> > +     select FS_IOMAP
> >       help
> >         With FUSE it is possible to implement a fully functional filesy=
stem
> >         in a userspace program.
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 47006d0753f1..cadad61ef7df 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/filelock.h>
> >  #include <linux/splice.h>
> >  #include <linux/task_io_accounting_ops.h>
> > +#include <linux/iomap.h>
> >
> >  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
> >                         unsigned int open_flags, int opcode,
> > @@ -788,12 +789,16 @@ static void fuse_short_read(struct inode *inode, =
u64 attr_ver, size_t num_read,
> >       }
> >  }
> >
> > -static int fuse_do_readfolio(struct file *file, struct folio *folio)
> > +static int fuse_do_readfolio(struct file *file, struct folio *folio,
> > +                          size_t off, size_t len)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> >       struct fuse_mount *fm =3D get_fuse_mount(inode);
> > -     loff_t pos =3D folio_pos(folio);
> > -     struct fuse_folio_desc desc =3D { .length =3D folio_size(folio) }=
;
> > +     loff_t pos =3D folio_pos(folio) + off;
> > +     struct fuse_folio_desc desc =3D {
> > +             .offset =3D off,
> > +             .length =3D len,
> > +     };
> >       struct fuse_io_args ia =3D {
> >               .ap.args.page_zeroing =3D true,
> >               .ap.args.out_pages =3D true,
> > @@ -820,8 +825,6 @@ static int fuse_do_readfolio(struct file *file, str=
uct folio *folio)
> >       if (res < desc.length)
> >               fuse_short_read(inode, attr_ver, res, &ia.ap);
> >
> > -     folio_mark_uptodate(folio);
> > -
> >       return 0;
> >  }
> >
> > @@ -834,13 +837,26 @@ static int fuse_read_folio(struct file *file, str=
uct folio *folio)
> >       if (fuse_is_bad(inode))
> >               goto out;
> >
> > -     err =3D fuse_do_readfolio(file, folio);
> > +     err =3D fuse_do_readfolio(file, folio, 0, folio_size(folio));
> > +     if (!err)
> > +             folio_mark_uptodate(folio);
> > +
> >       fuse_invalidate_atime(inode);
> >   out:
> >       folio_unlock(folio);
> >       return err;
> >  }
> >
> > +static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
> > +                                    struct folio *folio, loff_t pos,
> > +                                    size_t len)
> > +{
> > +     struct file *file =3D iter->private;
> > +     size_t off =3D offset_in_folio(folio, pos);
> > +
> > +     return fuse_do_readfolio(file, folio, off, len);
> > +}
> > +
> >  static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args=
 *args,
> >                              int err)
> >  {
> > @@ -1374,6 +1390,24 @@ static void fuse_dio_unlock(struct kiocb *iocb, =
bool exclusive)
> >       }
> >  }
> >
> > +static const struct iomap_write_ops fuse_iomap_write_ops =3D {
> > +     .read_folio_range =3D fuse_iomap_read_folio_range,
> > +};
> > +
> > +static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t=
 length,
> > +                         unsigned int flags, struct iomap *iomap,
> > +                         struct iomap *srcmap)
> > +{
> > +     iomap->type =3D IOMAP_MAPPED;
> > +     iomap->length =3D length;
> > +     iomap->offset =3D offset;
> > +     return 0;
> > +}
> > +
> > +static const struct iomap_ops fuse_iomap_ops =3D {
> > +     .iomap_begin    =3D fuse_iomap_begin,
> > +};
> > +
> >  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_it=
er *from)
> >  {
> >       struct file *file =3D iocb->ki_filp;
> > @@ -1383,6 +1417,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb=
 *iocb, struct iov_iter *from)
> >       struct inode *inode =3D mapping->host;
> >       ssize_t err, count;
> >       struct fuse_conn *fc =3D get_fuse_conn(inode);
> > +     bool writeback =3D false;
> >
> >       if (fc->writeback_cache) {
> >               /* Update size (EOF optimization) and mode (SUID clearing=
) */
> > @@ -1391,16 +1426,11 @@ static ssize_t fuse_cache_write_iter(struct kio=
cb *iocb, struct iov_iter *from)
> >               if (err)
> >                       return err;
> >
> > -             if (fc->handle_killpriv_v2 &&
> > -                 setattr_should_drop_suidgid(idmap,
> > -                                             file_inode(file))) {
> > -                     goto writethrough;
> > -             }
> > -
> > -             return generic_file_write_iter(iocb, from);
> > +             if (!fc->handle_killpriv_v2 ||
> > +                 !setattr_should_drop_suidgid(idmap, file_inode(file))=
)
> > +                     writeback =3D true;
> >       }
> >
> > -writethrough:
> >       inode_lock(inode);
> >
> >       err =3D count =3D generic_write_checks(iocb, from);
> > @@ -1419,6 +1449,15 @@ static ssize_t fuse_cache_write_iter(struct kioc=
b *iocb, struct iov_iter *from)
> >                       goto out;
> >               written =3D direct_write_fallback(iocb, from, written,
> >                               fuse_perform_write(iocb, from));
>
> Random unrelatd question: does anyone know why fuse handles IOCB_DIRECT
> in its fuse_cache_{read,write}_iter functions and /also/ sets
> ->direct_IO?  I thought filesystems only did one or the other, not both.
>

I think it has to do with the difference in handling async aio and sync aio
and the difference between user requested O_DIRECT and server
requested FOPEN_DIRECT_IO.

I think Bernd had some patches to further unify the related code.

Thanks,
Amir.

