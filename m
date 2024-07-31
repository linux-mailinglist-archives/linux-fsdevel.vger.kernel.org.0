Return-Path: <linux-fsdevel+bounces-24685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D94942FBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E991C21AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6D51B011A;
	Wed, 31 Jul 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AMtef6si"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AA1A7F73
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431416; cv=none; b=NR4XLxJh02Xhfq1BzlbXxpM7GYo4ivaCW4i1OnqA4ESohKJ9S3S5MGrrEdoux44d+mIQybHaWI6Vht69jVXdenNy8kbNyrd1iS6nPpOGUX8ChnkXaCYQHZlqAfkXTrPlFYszv6WuZhUd+dOvwcAK+32EYo3oFal5+9IVMslKASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431416; c=relaxed/simple;
	bh=qOWYRkzyDVwl+/nuQuBD0vO0aSZT6tHuPgwWZLOhpAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+ZW/f28DqZB/K756umG/QYsUhGWBf27Q/DhE2OoCjcwKZCkdIDWRnJOSWYFL+1trruayfK8ZZrX2FdWyyiV14piVaU+y1w3uQ7lLvdAatqg3sS6mYUT2LZ4ssd0uns0NXorDQSElnwcp0taGltZpyaUIOpQg71QB7wvwChlCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AMtef6si; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so67601931fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722431412; x=1723036212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYkuPJdSIuiWyS57EDnKZ9pwpCAKyUatguoyf2siBx8=;
        b=AMtef6siLfMX48evk3wWZ1oRggkH1MnCN89Nw5oRH8pA06krSnfIkw/4HPK2HwDdEe
         QRgwWQoiJbxggAR82Lkj06moytbhZMpZztYrLa6maxMD2i+K4iMUTpx9KVCe9+7Pp33G
         +XalGmkgxe6J3FExze0EGodjAkiRLyCjmmynJHbMTPIRF0UHi8AlcjYlnHLgr96JE6Tv
         9SvT0slPsgmgEtXGuOf37vNKziUtEQrdEIk7dpcwjGFVKjTsTTAXAlRQxEUVSahMFNDs
         a2SlQWgcpWJNv4CuPsZBywMWpk/2Fcn6CNE8ssVr5vR3NW6/2NYA1vV6npdgzb79Zj23
         wE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431412; x=1723036212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYkuPJdSIuiWyS57EDnKZ9pwpCAKyUatguoyf2siBx8=;
        b=Twaoji5BIzmtsno1DiGVOEZCV8yZa1sx0PUopUaebUrOwNfvGnIO35mOX6Tgvkwvi/
         iaiA/4ClnjlmEOSY6tO7k0PKDBVOyQUTnl9qW4rSnnWwFHO1O6bBj1ZCw5nzqGzJ2+MC
         UsgJq5+/HsflqLOew5Xnpl66DSBkOUiO67yw4+9tMVN+/O4zcpAZbHjiwcqlzNhAi9ki
         vVdjurKyeJ0ZH6E0YPXJ1eFo31p6mMBEqeRY0mP0jGLZFmwCnQ2J82PSnLRWT2RzSzwi
         pT6inLtduPCj4hrwmKW5nfsuEchbQc9FxGJsScQXeU5QA+akzwLD2Gpf5IhSAAEbtLsJ
         amlw==
X-Forwarded-Encrypted: i=1; AJvYcCUP6zyuXIUsn9QYHYeHyQJhzIwk9R1OhmQAQ3m8zqxXjUKBfUvQbejNAdLvkBKHisW5c+SPCfwLx7wkeZUKHTMZSbHdxVyPOOmDvj6Ncw==
X-Gm-Message-State: AOJu0Yz1grZVPeVC+vURPBWHb4Ix4n42hzyhOF7AyST8+7k9dqdu1Fko
	S9oS3XPVExGl+jAHBfexznefvAE1ccMAToYGWanCbqO+JCMFghZxmM6mH+jtotbYF9btHUtQmnM
	LH2unIxuB631C+X3A9zW/AXWLbKfDCfhxHcjU5Q==
X-Google-Smtp-Source: AGHT+IHKcOV9wKShkfmLiSx1hYNBYicde2HtogJnbPz604l6H6tsmXYvAT6vxtE3bkgaGkKlzsEKNOuycuR8EwRgdI0=
X-Received: by 2002:a2e:95d0:0:b0:2ef:2dac:9076 with SMTP id
 38308e7fff4ca-2f12ecd2742mr94369741fa.11.1722431412153; Wed, 31 Jul 2024
 06:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731043835.1828697-1-yangerkun@huawei.com>
 <20240731115134.tkiklyu72lwnhbxg@quack3> <57de6354-f53d-d106-aed8-9dff3e88efa6@huaweicloud.com>
In-Reply-To: <57de6354-f53d-d106-aed8-9dff3e88efa6@huaweicloud.com>
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 31 Jul 2024 14:10:00 +0100
Message-ID: <CAKisOQEn-2Rr4O-gKVtpab1p5iyHVUXeR0fChkrBvGb02FTC3w@mail.gmail.com>
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
To: yangerkun <yangerkun@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>, hch@infradead.org, 
	chuck.lever@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	hughd@google.com, zlang@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:51=E2=80=AFPM yangerkun <yangerkun@huaweicloud.co=
m> wrote:
>
> Hi!
>
> =E5=9C=A8 2024/7/31 19:51, Jan Kara =E5=86=99=E9=81=93:
> > On Wed 31-07-24 12:38:35, yangerkun wrote:
> >> After we switch tmpfs dir operations from simple_dir_operations to
> >> simple_offset_dir_operations, every rename happened will fill new dent=
ry
> >> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> >> key starting with octx->newx_offset, and then set newx_offset equals t=
o
> >> free key + 1. This will lead to infinite readdir combine with rename
> >> happened at the same time, which fail generic/736 in xfstests(detail s=
how
> >> as below).
> >>
> >> 1. create 5000 files(1 2 3...) under one dir
> >> 2. call readdir(man 3 readdir) once, and get one entry
> >> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> >> 4. loop 2~3, until readdir return nothing or we loop too many
> >>     times(tmpfs break test with the second condition)
> >>
> >> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infini=
te
> >> directory reads") to fix it, record the last_index when we open dir, a=
nd
> >> do not emit the entry which index >=3D last_index. The file->private_d=
ata
> >> now used in offset dir can use directly to do this, and we also update
> >> the last_index when we llseek the dir file.
> >
> > The patch looks good! Just I'm not sure about the llseek part. As far a=
s I
> > understand it was added due to this sentence in the standard:
> >
> > "If a file is removed from or added to the directory after the most rec=
ent
> > call to opendir() or rewinddir(), whether a subsequent call to readdir(=
)
> > returns an entry for that file is unspecified."
> >
> > So if the offset used in offset_dir_llseek() is 0, then we should updat=
e
> > last_index. But otherwise I'd leave it alone because IMHO it would do m=
ore
> > harm than good.
>
> IIUC, what you means is that we should only reset the private_data to
> new last_index when we call rewinddir(which will call lseek to set
> offset of dir file to 0)?
>
> Yeah, I prefer the logic you describle! Besides, we may also change
> btrfs that do the same(e60aa5da14d0 ("btrfs: refresh dir last index
> during a rewinddir(3) call")). Filipe, how do you think?

What problem does it solve?
The standard doesn't forbid it, and I can't see anything wrong with it.

>
> Thanks,
> Erkun.
>
> >                                                               Honza
> >
> >>
> >> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> >> Signed-off-by: yangerkun <yangerkun@huawei.com>
> >> ---
> >>   fs/libfs.c | 34 +++++++++++++++++++++++-----------
> >>   1 file changed, 23 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/fs/libfs.c b/fs/libfs.c
> >> index 8aa34870449f..38b306738c00 100644
> >> --- a/fs/libfs.c
> >> +++ b/fs/libfs.c
> >> @@ -450,6 +450,14 @@ void simple_offset_destroy(struct offset_ctx *oct=
x)
> >>      mtree_destroy(&octx->mt);
> >>   }
> >>
> >> +static int offset_dir_open(struct inode *inode, struct file *file)
> >> +{
> >> +    struct offset_ctx *ctx =3D inode->i_op->get_offset_ctx(inode);
> >> +
> >> +    file->private_data =3D (void *)ctx->next_offset;
> >> +    return 0;
> >> +}
> >> +
> >>   /**
> >>    * offset_dir_llseek - Advance the read position of a directory desc=
riptor
> >>    * @file: an open directory whose position is to be updated
> >> @@ -463,6 +471,9 @@ void simple_offset_destroy(struct offset_ctx *octx=
)
> >>    */
> >>   static loff_t offset_dir_llseek(struct file *file, loff_t offset, in=
t whence)
> >>   {
> >> +    struct inode *inode =3D file->f_inode;
> >> +    struct offset_ctx *ctx =3D inode->i_op->get_offset_ctx(inode);
> >> +
> >>      switch (whence) {
> >>      case SEEK_CUR:
> >>              offset +=3D file->f_pos;
> >> @@ -476,7 +487,7 @@ static loff_t offset_dir_llseek(struct file *file,=
 loff_t offset, int whence)
> >>      }
> >>
> >>      /* In this case, ->private_data is protected by f_pos_lock */
> >> -    file->private_data =3D NULL;
> >> +    file->private_data =3D (void *)ctx->next_offset;
> >>      return vfs_setpos(file, offset, LONG_MAX);
> >>   }
> >>
> >> @@ -507,7 +518,7 @@ static bool offset_dir_emit(struct dir_context *ct=
x, struct dentry *dentry)
> >>                        inode->i_ino, fs_umode_to_dtype(inode->i_mode))=
;
> >>   }
> >>
> >> -static void *offset_iterate_dir(struct inode *inode, struct dir_conte=
xt *ctx)
> >> +static void offset_iterate_dir(struct inode *inode, struct dir_contex=
t *ctx, long last_index)
> >>   {
> >>      struct offset_ctx *octx =3D inode->i_op->get_offset_ctx(inode);
> >>      struct dentry *dentry;
> >> @@ -515,17 +526,21 @@ static void *offset_iterate_dir(struct inode *in=
ode, struct dir_context *ctx)
> >>      while (true) {
> >>              dentry =3D offset_find_next(octx, ctx->pos);
> >>              if (!dentry)
> >> -                    return ERR_PTR(-ENOENT);
> >> +                    return;
> >> +
> >> +            if (dentry2offset(dentry) >=3D last_index) {
> >> +                    dput(dentry);
> >> +                    return;
> >> +            }
> >>
> >>              if (!offset_dir_emit(ctx, dentry)) {
> >>                      dput(dentry);
> >> -                    break;
> >> +                    return;
> >>              }
> >>
> >>              ctx->pos =3D dentry2offset(dentry) + 1;
> >>              dput(dentry);
> >>      }
> >> -    return NULL;
> >>   }
> >>
> >>   /**
> >> @@ -552,22 +567,19 @@ static void *offset_iterate_dir(struct inode *in=
ode, struct dir_context *ctx)
> >>   static int offset_readdir(struct file *file, struct dir_context *ctx=
)
> >>   {
> >>      struct dentry *dir =3D file->f_path.dentry;
> >> +    long last_index =3D (long)file->private_data;
> >>
> >>      lockdep_assert_held(&d_inode(dir)->i_rwsem);
> >>
> >>      if (!dir_emit_dots(file, ctx))
> >>              return 0;
> >>
> >> -    /* In this case, ->private_data is protected by f_pos_lock */
> >> -    if (ctx->pos =3D=3D DIR_OFFSET_MIN)
> >> -            file->private_data =3D NULL;
> >> -    else if (file->private_data =3D=3D ERR_PTR(-ENOENT))
> >> -            return 0;
> >> -    file->private_data =3D offset_iterate_dir(d_inode(dir), ctx);
> >> +    offset_iterate_dir(d_inode(dir), ctx, last_index);
> >>      return 0;
> >>   }
> >>
> >>   const struct file_operations simple_offset_dir_operations =3D {
> >> +    .open           =3D offset_dir_open,
> >>      .llseek         =3D offset_dir_llseek,
> >>      .iterate_shared =3D offset_readdir,
> >>      .read           =3D generic_read_dir,
> >> --
> >> 2.39.2
> >>
>

