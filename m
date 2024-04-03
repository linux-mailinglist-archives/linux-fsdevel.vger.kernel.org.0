Return-Path: <linux-fsdevel+bounces-15997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C532689688B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC928A190
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E603B6BB33;
	Wed,  3 Apr 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzyxoLz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBC84A31
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132350; cv=none; b=UPQSBfnGTACtxJpL2Eb16JlUeXhLKo0V8w8ikd4zFqqqGvr2aI06rAyyY/3dSwavsqvfLcUf9KTx+sSpCEn0ELV4n5Ubc41rMe4zQzBAt0EB4HCtHZEvkD1aufQdveKIscz/iEOVIcA0ob3GdL7lYxWp2zvrYD9shKdGXnE3CaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132350; c=relaxed/simple;
	bh=znr4QTISNKKVzZQdM7HKOMwmopWwqISZJtcM56/+q3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDU+taciBkNsMcEYB4pnfZwHuWxsgM8/6u/3a9MMd1VWaBhVW4GpswZVeuivXAlDLFfaJsef09QOnscA5Bvv/vpm8aUohv+vTAZ8rDQ1urPJV46rlSIWjQ0mvnLHohmzSSg5eSMS8SeFP3JflqoWCunVR+V75o9II7sXSGNZIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzyxoLz3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69682bdf1d5so35739086d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712132347; x=1712737147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfYf3zrBKfoMhIb+Y2w2pJglvP8Z5oez0TgFQ0Zdokg=;
        b=LzyxoLz3ZlC8nEcUBOfPTqi0VzjxVEYFgAA/Bh/H2I3+asi8fayrLdbzqe9vhq130G
         3ToOg3ug0ZLRWN4f1ChQbui2gGLWReOWA31xq77QXop0m2TztQ9QYTFRSxypaC40igM/
         YIJ2ebdicqxEjiF78n0jHh0ys0AaZDFJjaleqqf6WbyuHa/+4ku3KlbGLyPDAu9QCvga
         H52Gg1FnwLI+R4RblST2wRuCrRx7wWYoOctyUVzvRzD81rSnv9MoDpsdjqanLrsjqkqf
         ZoGAFnidQqplnL2pXN/kq0sDmfV70+b1zzgt1XV8j0FPZ8NJ+esiS2ZCKk6rU4LFBCC8
         uwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712132347; x=1712737147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfYf3zrBKfoMhIb+Y2w2pJglvP8Z5oez0TgFQ0Zdokg=;
        b=W4/xMvyNvF5IBqO/bpPsExm0D38ViBkf+IUuu6fW41Xw6HT7TCMpBmBJ54vgAQFzqJ
         aAcnq7/xB/XvH6lm6sdjV+yeb3xGHXBioWLWLuSyeR0ym/UiQaFw529nvfiQfn+SZy68
         xq+9DvGV1z/GkNl9SGZJBKZByygNF6eh/WuSlqUKGgB8JLELpu5sXzw1CwSFZLEHEb6I
         W0jgyjfPC1gUIaTbKx6XYLHbeZtvmMJtoz5FyfhYq2mCMinvCl77ZXOgm46BOZQ7efNj
         2VstijBXdOWsXtwH8tP3RNLCJW0NGlZVu9Y1QJkXe3AEvamAMJ6WD8cyuF1oBF0kuHIK
         6I3A==
X-Forwarded-Encrypted: i=1; AJvYcCV+kKpw2JnRCSVBAY9Y5MHAV7o7hav1i+paLhkjE4hJKMI2pJ4V2v2INkYqvB0nVQ1PtDPE5vYi5ICpYIUD9Hri4m1YkYXX/qmROc7+tA==
X-Gm-Message-State: AOJu0YwL7+fWyXpIEpLW/zHBTJVu2xSNlQEzvhl1XDcqhY+mxjozGE25
	mgIpviHMb379qpdwOVFF3USZLsuazNpMSnm2+GLqSjSSigYpK/kCH136TDKrePb6LVa5HizXH1+
	apxDEOFjfgeBzsj2OJcGEEpvhCWo=
X-Google-Smtp-Source: AGHT+IEiMg6r6A6FpvHDS+655qDbaZ+h/Q0gxO3do5zC9N6/q7EEylq6MbSFqcTh2ERQfMNhEgqqgd34OiZAjenFjOk=
X-Received: by 2002:a0c:fc42:0:b0:699:1d84:1755 with SMTP id
 w2-20020a0cfc42000000b006991d841755mr3600487qvp.44.1712132347450; Wed, 03 Apr
 2024 01:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-10-amir73il@gmail.com>
 <c52a81b4-2e88-4a89-b2e5-fecbb3e3d03e@dorminy.me> <a939b9b5-fb66-42ea-9855-6c7275f17452@fastmail.fm>
In-Reply-To: <a939b9b5-fb66-42ea-9855-6c7275f17452@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Apr 2024 11:18:56 +0300
Message-ID: <CAOQ4uxgVmG6QGVHEO1u-F3XC_1_sCkP=ekfEZtgeSpsrTkX21w@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] fuse: auto-invalidate inode attributes in
 passthrough mode
To: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:18=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 4/2/24 22:13, Sweet Tea Dorminy wrote:
> >
> >
> > On 2/6/24 09:24, Amir Goldstein wrote:
> >> After passthrough read/write, we invalidate a/c/mtime/size attributes
> >> if the backing inode attributes differ from FUSE inode attributes.
> >>
> >> Do the same in fuse_getattr() and after detach of backing inode, so th=
at
> >> passthrough mmap read/write changes to a/c/mtime/size attribute of the
> >> backing inode will be propagated to the FUSE inode.
> >>
> >> The rules of invalidating a/c/mtime/size attributes with writeback cac=
he
> >> are more complicated, so for now, writeback cache and passthrough cann=
ot
> >> be enabled on the same filesystem.
> >>
> >> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >> ---
> >>   fs/fuse/dir.c         |  4 ++++
> >>   fs/fuse/fuse_i.h      |  2 ++
> >>   fs/fuse/inode.c       |  4 ++++
> >>   fs/fuse/iomode.c      |  5 +++-
> >>   fs/fuse/passthrough.c | 55 ++++++++++++++++++++++++++++++++++++-----=
--
> >>   5 files changed, 61 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> >> index 95330c2ca3d8..7f9d002b8f23 100644
> >> --- a/fs/fuse/dir.c
> >> +++ b/fs/fuse/dir.c
> >> @@ -2118,6 +2118,10 @@ static int fuse_getattr(struct mnt_idmap *idmap=
,
> >>           return -EACCES;
> >>       }
> >>   +    /* Maybe update/invalidate attributes from backing inode */
> >> +    if (fuse_inode_backing(get_fuse_inode(inode)))
> >> +        fuse_backing_update_attr_mask(inode, request_mask);
> >> +
> >>       return fuse_update_get_attr(inode, NULL, stat, request_mask,
> >> flags);
> >>   }
> >>   diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >> index 98f878a52af1..4b011d31012f 100644
> >> --- a/fs/fuse/fuse_i.h
> >> +++ b/fs/fuse/fuse_i.h
> >> @@ -1456,6 +1456,8 @@ void fuse_backing_files_init(struct fuse_conn *f=
c);
> >>   void fuse_backing_files_free(struct fuse_conn *fc);
> >>   int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map
> >> *map);
> >>   int fuse_backing_close(struct fuse_conn *fc, int backing_id);
> >> +void fuse_backing_update_attr(struct inode *inode, struct
> >> fuse_backing *fb);
> >> +void fuse_backing_update_attr_mask(struct inode *inode, u32
> >> request_mask);
> >>     struct fuse_backing *fuse_passthrough_open(struct file *file,
> >>                          struct inode *inode,
> >> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >> index c26a84439934..c68f005b6e86 100644
> >> --- a/fs/fuse/inode.c
> >> +++ b/fs/fuse/inode.c
> >> @@ -1302,9 +1302,13 @@ static void process_init_reply(struct
> >> fuse_mount *fm, struct fuse_args *args,
> >>                * on a stacked fs (e.g. overlayfs) themselves and with
> >>                * max_stack_depth =3D=3D 1, FUSE fs can be stacked as t=
he
> >>                * underlying fs of a stacked fs (e.g. overlayfs).
> >> +             *
> >> +             * For now, writeback cache and passthrough cannot be
> >> +             * enabled on the same filesystem.
> >>                */
> >>               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
> >>                   (flags & FUSE_PASSTHROUGH) &&
> >> +                !fc->writeback_cache &&
> >>                   arg->max_stack_depth > 0 &&
> >>                   arg->max_stack_depth <=3D FILESYSTEM_MAX_STACK_DEPTH=
) {
> >>                   fc->passthrough =3D 1;
> >> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> >> index c545058a01e1..96eb311fe7bd 100644
> >> --- a/fs/fuse/iomode.c
> >> +++ b/fs/fuse/iomode.c
> >> @@ -157,8 +157,11 @@ void fuse_file_uncached_io_end(struct inode *inod=
e)
> >>       spin_unlock(&fi->lock);
> >>       if (!uncached_io)
> >>           wake_up(&fi->direct_io_waitq);
> >> -    if (oldfb)
> >> +    if (oldfb) {
> >> +        /* Maybe update attributes after detaching backing inode */
> >> +        fuse_backing_update_attr(inode, oldfb);
> >>           fuse_backing_put(oldfb);
> >> +    }
> >>   }
> >>     /*
> >> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> >> index 260e76fc72d5..c1bb80a6e536 100644
> >> --- a/fs/fuse/passthrough.c
> >> +++ b/fs/fuse/passthrough.c
> >> @@ -11,11 +11,8 @@
> >>   #include <linux/backing-file.h>
> >>   #include <linux/splice.h>
> >>   -static void fuse_file_accessed(struct file *file)
> >> +static void fuse_backing_accessed(struct inode *inode, struct
> >> fuse_backing *fb)
> >>   {
> >> -    struct inode *inode =3D file_inode(file);
> >> -    struct fuse_inode *fi =3D get_fuse_inode(inode);
> >> -    struct fuse_backing *fb =3D fuse_inode_backing(fi);
> >>       struct inode *backing_inode =3D file_inode(fb->file);
> >>       struct timespec64 atime =3D inode_get_atime(inode);
> >>       struct timespec64 batime =3D inode_get_atime(backing_inode);
> >> @@ -25,11 +22,8 @@ static void fuse_file_accessed(struct file *file)
> >>           fuse_invalidate_atime(inode);
> >>   }
> >>   -static void fuse_file_modified(struct file *file)
> >> +static void fuse_backing_modified(struct inode *inode, struct
> >> fuse_backing *fb)
> >>   {
> >> -    struct inode *inode =3D file_inode(file);
> >> -    struct fuse_inode *fi =3D get_fuse_inode(inode);
> >> -    struct fuse_backing *fb =3D fuse_inode_backing(fi);
> >>       struct inode *backing_inode =3D file_inode(fb->file);
> >>       struct timespec64 ctime =3D inode_get_ctime(inode);
> >>       struct timespec64 mtime =3D inode_get_mtime(inode);
> >> @@ -42,6 +36,51 @@ static void fuse_file_modified(struct file *file)
> >>           fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> >>   }
> >>   +/* Called from fuse_file_uncached_io_end() after detach of backing
> >> inode */
> >> +void fuse_backing_update_attr(struct inode *inode, struct
> >> fuse_backing *fb)
> >> +{
> >> +    fuse_backing_modified(inode, fb);
> >> +    fuse_backing_accessed(inode, fb);
> >> +}
> >> +
> >> +/* Called from fuse_getattr() - may race with detach of backing inode=
 */
> >> +void fuse_backing_update_attr_mask(struct inode *inode, u32
> >> request_mask)
> >> +{
> >> +    struct fuse_inode *fi =3D get_fuse_inode(inode);
> >> +    struct fuse_backing *fb;
> >> +
> >> +    rcu_read_lock();
> >> +    fb =3D fuse_backing_get(fuse_inode_backing(fi));
> >> +    rcu_read_unlock();
> >> +    if (!fb)
> >> +        return;
> >> +
> >> +    if (request_mask & FUSE_STATX_MODSIZE)
> >> +        fuse_backing_modified(inode, fb);
> >> +    if (request_mask & STATX_ATIME)
> >> +        fuse_backing_accessed(inode, fb);
> >> +
> >> +    fuse_backing_put(fb);
> >> +}
> >> +
> >> +static void fuse_file_accessed(struct file *file)
> >> +{
> >> +    struct inode *inode =3D file_inode(file);
> >> +    struct fuse_inode *fi =3D get_fuse_inode(inode);
> >> +    struct fuse_backing *fb =3D fuse_inode_backing(fi);
> >> +
> >> +    fuse_backing_accessed(inode, fb);
> >> +}
> >> +
> >> +static void fuse_file_modified(struct file *file)
> >> +{
> >> +    struct inode *inode =3D file_inode(file);
> >> +    struct fuse_inode *fi =3D get_fuse_inode(inode);
> >> +    struct fuse_backing *fb =3D fuse_inode_backing(fi);
> >> +
> >> +    fuse_backing_modified(inode, fb);
> >> +}
> >> +
> >>   ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct
> >> iov_iter *iter)
> >>   {
> >>       struct file *file =3D iocb->ki_filp;
> >
> > I noticed this patch doesn't seem to have made it into 6.9 like the res=
t
> > of these passthrough patches -- may I ask why it didn't make it? I thin=
k
> > it still makes sense but I might be missing some change between what's
> > in 6.9 and this version of the patches.
> >
> > Thanks!
> >
> > Sweet Tea
>
> See here please
> https://lore.kernel.org/all/CAOQ4uxj8Az6VEZ-Ky5gs33gc0N9hjv4XqL6XC_kc+vsV=
paBCOg@mail.gmail.com/
>
>

FWIW, I intend to take a swing at getattr() passthrough "as soon as I can".

Sweet Tea,

Can you please explain the workload where you find that this patch is neede=
d?
Is your workload using mmap writes? requires a long attribute cache timeout=
?
Does your workload involve mixing passthrough IO and direct/cached IO
on the same inode at different times or by different open fd's?

I would like to know, so I can tell you if getattr() passthrough design is
going to help your use case.

For example, my current getattr() passthrough design (in my head)
will not allow opening the inode in cached IO mode from lookup time
until evict/forget, unlike the current read/write passthrough, which is
from first open to last close.

Thanks,
Amir.

