Return-Path: <linux-fsdevel+bounces-73932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0737FD255DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3054300908C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A03ACF11;
	Thu, 15 Jan 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfeZzOnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E672EF662
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491130; cv=none; b=WsKi4DVE1V/+v+wIoKQOFd8XE5iwYdKAhOWfCo5h9sGvOMJiysmdT8DY4xRMWBardRPI+4KkIX0NApdkL3b1gsNfHdax8Bg40ke9TAN3Ahjjj1ZWkDC56VzACDNCSX+gcWEobIo7wfBDUIvdLJHli/yHmnikcIlyrW6ND+4qW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491130; c=relaxed/simple;
	bh=dsLrT5BajG7gUnQwuODliyK8tRgaLg+wyZOz74gPKhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzs1Jkb9W3K0RFViVF2jeiw/X8rTCM/anWOanYk5INk4ESEoUVo1Cc1SaeFklfT7B+FPcsXeV5105eb7sdFbfmLWooIg3yhrvoEOTGcda5bQuql7iiaNyOwalBdSgm+RluYburmFKzS8quw9/3xjaX2bTbAIRQ8XGCR50fMh/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfeZzOnM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so1610239a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768491127; x=1769095927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrYmZl7orkP4XgRJ45NN7psNd50wo7G/3/TLP5SjqwA=;
        b=VfeZzOnM5D4hyNdov0g8WCnxWGUibSkV4mG+KEdHQmNUvuRLf0bQGucMWU+82VH1Bd
         5QmDpeGKf/XJjTkEKR5G6ct8qBZmB1Ii9Y/WOxfUyZ8KrMYfbnzw8ZYpOm8eojtQRlNI
         Df2tlw/TJPr+i+kObiR2SfTWUJfRNmFhOzErgs238oSMvjbVREzyhekPbe8pSe3t60fI
         N/RyH4YERCeFwquGk7EBNjivcPPLTrnreiThVpx8+sqiRgX2sKjDeYgCQeJWQDx06vsz
         TV2dOKESLm/N6D5iFJUN1AfOji6joF8CJDqUSwIdP687oii6BV4E5DrXr9AyhOkk9QTb
         WGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491127; x=1769095927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PrYmZl7orkP4XgRJ45NN7psNd50wo7G/3/TLP5SjqwA=;
        b=FN5ryaHbf2wneitEn0GQX+5mW0B0NbPh/57T4tMZHziSR8EEOd7EFuB65yIJmSfv54
         h/BDkfdK6Jkpx/QzviXe2pl7THDeq5OOFEPRY61dVj+mUoTECVrHjJdIGRQHGK7nl8tw
         XmyfRt2BrO31j4TgdJTiirX6JynX3TbMky2mbZfp9iz4dd1ncL5J3tNh/al5LAf9CBaJ
         F//BeLE7xCEIQALPHmUWZqKwVH9SoBqJ/l7w4lTW2IKoaA94I7ljuxdInm1ezRav6PTB
         Vh+NloFZ+qeD9QDyzsSQrUZeXfInsK3wyyDA1LNytZvJucKs07gyugrrP8KnesDxYPs0
         snqA==
X-Forwarded-Encrypted: i=1; AJvYcCUWY7EmCEDUc89iNyn65j/JRx3Si1yQgcqZYx/eY4XMxjw+/5LYmgqv59x9WOSDgMH3hKP5ufilZ93N9hrK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+JZWGVvS9H+X4pwy4ORmBcptbTAL28Nj6jy45Nm7yBtJFbig
	UozTB/GmbhnR71qJay4WlPEVL3O5bu4ww9ceiJeFjSxj8IcQ8ZCRMEiBzTN4xx1L7taGOD1usaR
	MI9JNdGK7CWqs4ZrwGfIC7+XHvyar78c=
X-Gm-Gg: AY/fxX7EDTiQNhh7MzRF4XBHxllDJ1GidByZW9kS03Ztyi/xcd9tgWFl5CyR6TDlWNn
	qpgxv68Fdf+Zw2kjVhIct1yeAF5hgFPq7BWubKLqFsLSJxMSdrLRdhlxHfjLkNatweuc3Ilgw/7
	/W8eZD+49hmeRsZnBZj9HffCzX/BHVkXAMDihwa1kwnWli/+9N9y1pWLJwgEug3Mp0yss0DuY1a
	37sBP4rc3UZS6QGWmGgcjxdk9kfLp+mqGq6BrJbEzQw45y7x2n+sFI3N4XZXsD6nza3EGf5BsOe
	2VaDVHhBuCN9rWIZ1kYgehB939RU9jUhRBJBUs+E
X-Received: by 2002:a05:6402:1e8c:b0:64b:946a:4a3a with SMTP id
 4fb4d7f45d1cf-653ec46b48dmr5243493a12.31.1768491126985; Thu, 15 Jan 2026
 07:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115072032.402-1-luochunsheng@ustc.edu> <20260115072032.402-3-luochunsheng@ustc.edu>
 <aWjnHvP5jsafQeag@amir-ThinkPad-T480> <a0ccfa28-4107-46ed-af79-faf55c004da0@ustc.edu>
In-Reply-To: <a0ccfa28-4107-46ed-af79-faf55c004da0@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 16:31:55 +0100
X-Gm-Features: AZwV_QgGK2o4U_5-2hsCjgmCtBSmtpWeifVgl2T2JRfHVj2Bv6ZbGlS04XpnRkA
Message-ID: <CAOQ4uxhOuBXT3tgoLxjh6efAwiOLg=oDxsyivLLMXCrSamSuEA@mail.gmail.com>
Subject: Re: [RFC 2/2] fuse: Add new flag to reuse the backing file of fuse_inode
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paullawrence@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:35=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
>
>
> On 1/15/26 9:09 PM, Amir Goldstein wrote:
> > Hi Chunsheng,
> >
> > Please CC me for future fuse passthrough patch sets.
> >
> Ok.
>
> > On Thu, Jan 15, 2026 at 03:20:31PM +0800, Chunsheng Luo wrote:
> >> To simplify crash recovery and reduce performance impact, backing_ids
> >> are not persisted across daemon restarts. However, this creates a
> >> problem: when the daemon restarts and a process opens the same FUSE
> >> file, a new backing_id may be allocated for the same backing file. If
> >> the inode already has a cached backing file from before the restart,
> >> subsequent open requests with the new backing_id will fail in
> >> fuse_inode_uncached_io_start() due to fb mismatch, even though both
> >> IDs reference the identical underlying file.
> >
> > I don't think that your proposal makes this guaranty.
> >
>
> Yes, this proposal does not apply to all situations.
>
> >>
> >> Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag to address this
> >> issue. When set, the kernel reuses the backing file already cached in
> >> the inode.
> >>
> >> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> >> ---
> >>   fs/fuse/iomode.c          |  2 +-
> >>   fs/fuse/passthrough.c     | 11 +++++++++++
> >>   include/uapi/linux/fuse.h |  2 ++
> >>   3 files changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> >> index 3728933188f3..b200bb248598 100644
> >> --- a/fs/fuse/iomode.c
> >> +++ b/fs/fuse/iomode.c
> >> @@ -163,7 +163,7 @@ static void fuse_file_uncached_io_release(struct f=
use_file *ff,
> >>    */
> >>   #define FOPEN_PASSTHROUGH_MASK \
> >>      (FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRIT=
ES | \
> >> -     FOPEN_NOFLUSH)
> >> +     FOPEN_NOFLUSH | FOPEN_PASSTHROUGH_INODE_CACHE)
> >>
> >>   static int fuse_file_passthrough_open(struct inode *inode, struct fi=
le *file)
> >>   {
> >> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> >> index 72de97c03d0e..fde4ac0c5737 100644
> >> --- a/fs/fuse/passthrough.c
> >> +++ b/fs/fuse/passthrough.c
> >> @@ -147,16 +147,26 @@ ssize_t fuse_passthrough_mmap(struct file *file,=
 struct vm_area_struct *vma)
> >>   /*
> >>    * Setup passthrough to a backing file.
> >>    *
> >> + * If fuse inode backing is provided and FOPEN_PASSTHROUGH_INODE_CACH=
E flag
> >> + * is set, try to reuse it first before looking up backing_id.
> >> + *
> >>    * Returns an fb object with elevated refcount to be stored in fuse =
inode.
> >>    */
> >>   struct fuse_backing *fuse_passthrough_open(struct file *file, int ba=
cking_id)
> >>   {
> >>      struct fuse_file *ff =3D file->private_data;
> >>      struct fuse_conn *fc =3D ff->fm->fc;
> >> +    struct fuse_inode *fi =3D get_fuse_inode(file->f_inode);
> >>      struct fuse_backing *fb =3D NULL;
> >>      struct file *backing_file;
> >>      int err;
> >>
> >> +    if (ff->open_flags & FOPEN_PASSTHROUGH_INODE_CACHE) {
> >> +            fb =3D fuse_backing_get(fuse_inode_backing(fi));
> >> +            if (fb)
> >> +                    goto do_open;
> >> +    }
> >> +
> >
> > Maybe an explicit FOPEN_PASSTHROUGH_INODE_CACHE flag is a good idea,
> > but just FYI, I intentionally reserved backing_id 0 for this purpose.
> > For example, for setting up the backing id on lookup [1] and then
> > open does not need to specify the backing_id.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250804173228.1990317-1-paul=
lawrence@google.com/
> >
>
> This is a great idea. However, we need to consider the lifecycle
> management of the backing file associated with a FUSE inode.
> Specifically, will the same backing_idbe retained for the entire
> lifetime of the FUSE inode until it is deleted?

It's not a good fit for servers that want to change the backing file
(like re-download). For these servers we have the existing file
open-to-close life cycle.

>
> Additionally, since each backing_idcorresponds to an open file
> descriptor (fd) for the backing file, if a fuse_inode holds onto a
> backing_id indefinitely without a suitable release mechanism, could this
> accumulation of file descriptors cause the process to exceed its open
> files limit?
>

There is no such accumulation.
fuse_inode refers to a single fuse_backing object.
fuse_file refers to a single fuse_backing object.
It can be the same (refcounted) object.

> > But what you are proposing is a little bit odd API IMO:
> > "Use this backing_id with this backing file, unless you find another
> >   backing file so use that one instead" - this sounds a bit awkward to =
me.
> >
> > I think it would be saner and simpler to relax the check in
> > fuse_inode_uncached_io_start() to check that old and new fuse_backing
> > objects refer to the same backing inode:
> >
> > diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> > index 3728933188f30..c6070c361d855 100644
> > --- a/fs/fuse/iomode.c
> > +++ b/fs/fuse/iomode.c
> > @@ -88,9 +88,9 @@ int fuse_inode_uncached_io_start(struct fuse_inode *f=
i, struct fuse_backing *fb)
> >       int err =3D 0;
> >
> >       spin_lock(&fi->lock);
> > -     /* deny conflicting backing files on same fuse inode */
> > +     /* deny conflicting backing inodes on same fuse inode */
> >       oldfb =3D fuse_inode_backing(fi);
> > -     if (fb && oldfb && oldfb !=3D fb) {
> > +     if (fb && oldfb && file_inode(oldfb->file) !=3D file_inode(fb->fi=
le)) {
> >               err =3D -EBUSY;
> >               goto unlock;
> >       }
> > --
> >
> > I don't think that this requires opt-in flag.
> >
> > Thanks,
> > Amir.
>
> I agree that modifying the condition to `file_inode(oldfb->file) !=3D
> file_inode(fb->file)` is a reasonable fix, and it does address the first
> scenario I described.
>
> However, it doesn't fully resolve the second scenario: in a read-only
> FUSE filesystem, the backing file itself might be cleaned up and
> re-downloaded (resulting in a new inode with identical content). In this
> case, reusing the cached fuse_inode's fb after a daemon restart still be
> safe, but the inode comparison would incorrectly reject it. Is there a
> more robust approach for handling this scenario?
>

There is a reason we added the restriction against associating
fuse file to different backing inodes.

mmap and reads from different files to the same inode need to be
cache coherent.

IOW, we intentionally do not support this setup without server restart
there is no reason for us to allow that after server restarts because
the consequense will be the same.

It does not sound like a good idea for the server to cleanup files
that are currently opened via fuse passthrough - is that something
that happens intentionally? after server restarts?

You could try to take a write lease to check if the file is currently
open for read/write to avoid cleanup in this case?

Thanks,
Amir.

