Return-Path: <linux-fsdevel+bounces-24507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF093FDE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55634283FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F4188CAF;
	Mon, 29 Jul 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL65FRhc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44D18786C
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279469; cv=none; b=L2r7sczrQfQsKGzqriMKgaNXpt4bbYhEV2S8PcPI7tgWi2vyV2r7LVHwQdrnYXd4X+gxvOnAIqz/4imr3LN/jcKyQ8nrLkZazWZcjUUmynb8TVSI8a8SxpEZ4jjpDDchXRAXAR04UQlrhQPT/yl6EqBbcDuw1Qjv5i9k68ehu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279469; c=relaxed/simple;
	bh=zbMZZSb8nNYKo8nWqrMvykxDrA3FeoSpLRj1Jzb9uc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7G4mxGMtuxh4fopgFcaDS3Lyh/tIHYz6kFeCJMpRDMqRxvcO0y+8Fvs/aceDQaxF30jN2bDdwlzFkODo1wRJTt7olnc6SlhzY8zW7rjoNJrJGVygBJgO8V7EkIpa9DvHbqFo6druHp6eVuAg0R4slMHmt7957FMa0flWebdmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL65FRhc; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d7a544e7so270519785a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722279466; x=1722884266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k6TD1jLDB39HUP0yHvZxwHXn6HKPVRSU/jw+jUK1jE=;
        b=nL65FRhcUiPdVzquprSi94twcs/b3XRPOsFdJVvWFeiy9hfH9H0H6AIddUANQ0isVC
         kXcfmgl8EFMLr8EEg0TidkhPQJyNxvR11UpZaKlHrYMaAcE1fy6/VAnXfG1oK2qnFTyL
         9zFk3621UpFBpdb7XCxLniEGCjqYQYbd4AoKm9L100b4lsANakLHYSjAV0piZhRVM8A1
         0Fm9o3x4fTBPuo9YCawIP+c76YmplFsFt5z0XXK8TpLF2gyl4MEMCTVOLGQzCUNK+lww
         FiUlrdRTqI6OFfeSRIIe/3+JpTqH6sSUbK78kS6Hy0NLlQzAJ0q9AP/s9M3HaGer0WWK
         Xucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722279466; x=1722884266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k6TD1jLDB39HUP0yHvZxwHXn6HKPVRSU/jw+jUK1jE=;
        b=FaLGzEf701qTPesGs6E89SnReOycKOi3m0c4dxk5SnRCnvWwnk9oFyey//yQQaeEG5
         opvTz8QDHzTFtMrfrk7+7KkEHQCZJaNYSyusarQAW0eX7kz7/xiqlAOSQX0LQZlfsbAY
         mbAu95FR2YVy0xzuVdDhYLsJtnS2hIZ5ot2pVFmrzxEIRCeyMreiPMSTHy0UP/aiwlNS
         1jeC/O8cVuNSruTd2yVOkiacNbWNxG4RF6xpTEXCkSLoi3oWj0mT73HnZbR349Qw9exj
         iLmo3eMde4KVUvmrMHQMLp0MXDqvgqDlTEE8hOctwuIZKjixr1PCHvvyOnAe8LY70k5J
         yY5w==
X-Forwarded-Encrypted: i=1; AJvYcCX0xUvNphTFrmZT1lOrSo/aMySYqEINSIqvAD1I0xzMQhmoZDsZwJ6HAbIawQhnVNar1qN4m9wsPfY8v6gSHa/EEXDyCZ/HTcjC1mxnTw==
X-Gm-Message-State: AOJu0YwAvY6BX8bpMCbknq1DPHxwmhxt9oUieUgspAs2GhW4OptYv08m
	lrSLDbdkQEyDm0CxQjEjEZlAkjF4dBnaWPUideETLZjksniofZ04CwdpdA1HNnaNiMCjYnSQ0SI
	7461F1cfYsVb0uSkAiuGm1B3Inio=
X-Google-Smtp-Source: AGHT+IFBHoHpz2PQr6p+2dxp3Zi2HhRr4uPBrYZFpLfXBn9Quza64DC/XoofznbU24zJoMNOxJf2EvDTtdC+RIAx1nM=
X-Received: by 2002:a05:620a:2807:b0:79c:b8c:8e2b with SMTP id
 af79cd13be357-7a1e522fabdmr1121788685a.3.1722279466411; Mon, 29 Jul 2024
 11:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com> <20240729171120.GB3596468@perftesting>
In-Reply-To: <20240729171120.GB3596468@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jul 2024 21:57:34 +0300
Message-ID: <CAOQ4uxjjBiPkg9uxyW12Xd+GZ7t3aP1m9Ayzr8WzqryfqK1x3g@mail.gmail.com>
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
To: Josef Bacik <josef@toxicpanda.com>, jack@suse.cz
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:11=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Thu, Jul 25, 2024 at 11:19:33PM +0300, Amir Goldstein wrote:
> > On Thu, Jul 25, 2024 at 9:20=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depend=
ing
> > > on the faulting method.
> > >
> > > This pre-content event is meant to be used by hierarchical storage
> > > managers that want to fill in the file content on first read access.
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/notify/fsnotify.c             | 13 +++++++++
> > >  include/linux/fsnotify_backend.h | 14 +++++++++
> > >  mm/filemap.c                     | 50 ++++++++++++++++++++++++++++--=
--
> > >  3 files changed, 71 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > index 1ca4a8da7f29..435232d46b4f 100644
> > > --- a/fs/notify/fsnotify.c
> > > +++ b/fs/notify/fsnotify.c
> > > @@ -28,6 +28,19 @@ void __fsnotify_vfsmount_delete(struct vfsmount *m=
nt)
> > >         fsnotify_clear_marks_by_mount(mnt);
> > >  }
> > >
> > > +bool fsnotify_file_has_content_watches(struct file *file)
> >
> > nit: has_pre_content_watches...
> >
> > > +{
> > > +       struct inode *inode =3D file_inode(file);
> > > +       struct super_block *sb =3D inode->i_sb;
> > > +       struct mount *mnt =3D real_mount(file->f_path.mnt);
> > > +       u32 mask =3D inode->i_fsnotify_mask;
> > > +
> > > +       mask |=3D mnt->mnt_fsnotify_mask;
> > > +       mask |=3D sb->s_fsnotify_mask;
> > > +
> > > +       return !!(mask & FSNOTIFY_PRE_CONTENT_EVENTS);
> >
> > This can use the fsnotify_object_watched() helper, and it will need
> > the READ_ONCE() that are just being added to avoid data races.
> >
> > > +}
> > > +
> > >  /**
> > >   * fsnotify_unmount_inodes - an sb is unmounting.  handle any watche=
d inodes.
> > >   * @sb: superblock being unmounted.
> > > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotif=
y_backend.h
> > > index 36c3d18cc40a..6983fbf096b8 100644
> > > --- a/include/linux/fsnotify_backend.h
> > > +++ b/include/linux/fsnotify_backend.h
> > > @@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fs=
notify_event *event)
> > >         INIT_LIST_HEAD(&event->list);
> > >  }
> > >
> > > +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> > > +bool fsnotify_file_has_content_watches(struct file *file);
> > > +#else
> > > +static inline bool fsnotify_file_has_content_watches(struct file *fi=
le)
> > > +{
> > > +       return false;
> > > +}
> > > +#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
> > > +
> > >  #else
> > >
> > >  static inline int fsnotify(__u32 mask, const void *data, int data_ty=
pe,
> > > @@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
> > >  static inline void fsnotify_unmount_inodes(struct super_block *sb)
> > >  {}
> > >
> > > +static inline bool fsnotify_file_has_content_watches(struct file *fi=
le)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > >  #endif /* CONFIG_FSNOTIFY */
> > >
> > >  #endif /* __KERNEL __ */
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index ca8c8d889eef..cc9d7885bbe3 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -46,6 +46,7 @@
> > >  #include <linux/pipe_fs_i.h>
> > >  #include <linux/splice.h>
> > >  #include <linux/rcupdate_wait.h>
> > > +#include <linux/fsnotify.h>
> > >  #include <asm/pgalloc.h>
> > >  #include <asm/tlbflush.h>
> > >  #include "internal.h"
> > > @@ -3112,13 +3113,13 @@ static int lock_folio_maybe_drop_mmap(struct =
vm_fault *vmf, struct folio *folio,
> > >   * that.  If we didn't pin a file then we return NULL.  The file tha=
t is
> > >   * returned needs to be fput()'ed when we're done with it.
> > >   */
> > > -static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> > > +static struct file *do_sync_mmap_readahead(struct vm_fault *vmf,
> > > +                                          struct file *fpin)
> > >  {
> > >         struct file *file =3D vmf->vma->vm_file;
> > >         struct file_ra_state *ra =3D &file->f_ra;
> > >         struct address_space *mapping =3D file->f_mapping;
> > >         DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> > > -       struct file *fpin =3D NULL;
> > >         unsigned long vm_flags =3D vmf->vma->vm_flags;
> > >         unsigned int mmap_miss;
> > >
> > > @@ -3182,12 +3183,12 @@ static struct file *do_sync_mmap_readahead(st=
ruct vm_fault *vmf)
> > >   * was pinned if we have to drop the mmap_lock in order to do IO.
> > >   */
> > >  static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
> > > -                                           struct folio *folio)
> > > +                                           struct folio *folio,
> > > +                                           struct file *fpin)
> > >  {
> >
> > If I am reading correctly, iomap (i.e. xfs) write shared memory fault
> > does not reach this code?
> >
> > Do we care about writable shared memory faults use case for HSM?
> > It does not sound very relevant to HSM, but we cannot just ignore it..
> >
>
> Sorry I realized I went off to try and solve this problem and never respo=
nded to
> you.  I'm addressing the other comments, but this one is a little tricky.
>
> We're kind of stuck between a rock and a hard place with this.  I had ori=
ginally
> put this before the ->fault() callback, but purposefully moved it into
> filemap_fault() because I want to be able to drop the mmap lock while we'=
re
> waiting for a response from the HSM.
>
> The reason to do this is because there are things that take the mmap lock=
 for
> simple things outside of the process, like /proc/$PID/smaps and other rel=
ated
> things, and this can cause high priority tasks to block behind possibly l=
ow
> priority IO, creating a priority inversion.
>
> Now, I'm not sure how widespread of a problem this is anymore, I know the=
re's
> been work done to the kernel and tools to avoid this style of problem.  I=
'm ok
> with a "try it and see" approach, but I don't love that.
>

I defer this question to Jan.

> However I think putting fsnotify hooks into XFS itself for this particula=
r path
> is a good choice either.

I think you meant "not a good choice" and I agree -
it is not only xfs, but could be any fs that will be converted to iomap
Other fs have ->fault !=3D filemap_fault, even if they do end up calling
filemap_fault, IOW, there is no API guarantee that they will.

> What do you think?  Just move it to before ->fault(),
> leave the mmap lock in place, and be done with it?

If Jan blesses the hook called with mmap lock, then yeh,
putting the hook in the most generic "vfs" code would be
the best choice for maintenance.

Thanks,
Amir.

