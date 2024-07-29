Return-Path: <linux-fsdevel+bounces-24495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A634393FC13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5654B220A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD615F303;
	Mon, 29 Jul 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1zVMDH6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D31DA24
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273085; cv=none; b=KsFROFuOZOcky4GgpH/4MprsUqVdUKIV+gyFMR0hOUueubdCpgwlhYHEwzYB0wJlVaVfpiKb9I2QKW0/ocR/ofS1Tqt41kFDx08yaGE7eKHcYgr/Y7QiJ/i3/EMXwQZYEfUtpVqtbtn9eUKpcFXIqOdXXx15RG5Q+3QxnVyLSkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273085; c=relaxed/simple;
	bh=l828tAgrte0iqYNSm9oT8x9C/eDtUMM6mMKfl5rXCCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWopLBRujG3gYSUBFX0ssgO1+T/AythPDrJ75g6EiZHL3zXToyhgKEvG+cvy6r8EzlCaGbkXn7pDX8umWkfb/eyAXYvCW6RzqVfYssPk4wW9xSvw8ghCgx4Iwf+tUEvqEllLOq17MSrdc4kjVWBiZ4hoSXhM1v55Kd6yBKJERrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1zVMDH6C; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0857a11862so2410726276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722273082; x=1722877882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dMS7yEvZZzQhkdQHeMO6QxFXUOnUbdXQOQAO8EYUhUI=;
        b=1zVMDH6Car8qq4D7fs9x0KZH2rGqsjyffNvJApi9DyYNJG9Yk9NoOMli8KpVYGsQ/D
         ktBdvaacizHmRMS4/VUDg4s5CBJ8iLZUeoNTxBtl1frr2/NCqbSHaA+03lb1E+qxopmp
         m1Tq1ENzYjoBztPgioZUF2Rhxr0K9CU0ifi6EtmBCF3mmzII1BjoiLTNnRzKUjdIJQJC
         sSLbA+sFnwvwUwWHU31HtKXu7r0M3VDekTXqgjJii4VZy/KXVtFlMWe2aRNIR5ssrE8d
         HcMFd9w5YyrTodiRkoCzamMxDlgYelsqtkd52hkwlR7izWo4BhhYI69I5SAJRABkQwfe
         3n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722273082; x=1722877882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMS7yEvZZzQhkdQHeMO6QxFXUOnUbdXQOQAO8EYUhUI=;
        b=VG3ardpY3G739xe5yCuBPmon6PDaJzaNlx9o0Jg++sxqQl/kcxhOYvzyDe0gv/lsS0
         z/eQVGdyAt/9datEW2WWe4POjNgKG3E2A/+eeTfsxvCsfJ30oO70KzQmO4wvN+ad0Hh/
         oy29FGCkIHSEmIGf1AqCKKxOmKvjPeItsK/giGbKjyZSkK2Np4IskbDJzKroohUTQUqV
         sad7dOuVN0WLpa3tyYsOgLQZeDKj9czLMikdRvUd0pKvAiIyoBsbG2icaaMgMfTS55yu
         RCtdE9mMrvvxHb0tYKx1ytPjUMEEK4wOY+wgw+HlbCqzX/bh95EHyIAvrvooqMTIX0W8
         Fw1g==
X-Forwarded-Encrypted: i=1; AJvYcCWfITsJ++n+xhEllU6YESiNJ6ZB3bSGDrtJRfKWC0z/NvJFFXUXUjroCCdUsuAoGoN4GYjz3M1Jl/SUlSDSFw3maseS+P8edQg0cmFupQ==
X-Gm-Message-State: AOJu0Yz9hcpJFjm/8inVXHTdzHKS1OUqY1tpRDF7LJ5/XTanIf88S03i
	iJ/66Lhtxo4kOn/nfw43C6ZJJh58NN3oElHkdU9qNaoieBuqZrxO+OrUDfqWz8k=
X-Google-Smtp-Source: AGHT+IHjMOiPZuNl8UdysrQqkPtsRyf447tv/3tlTLTfiynNOCnB3mDZB0GgDC+XzmbGi5/nkWU3pg==
X-Received: by 2002:a0d:f3c2:0:b0:627:d23a:4505 with SMTP id 00721157ae682-67a053e06f5mr90947657b3.3.1722273082256;
        Mon, 29 Jul 2024 10:11:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67567a537f8sm21609957b3.56.2024.07.29.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:11:21 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:11:20 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240729171120.GB3596468@perftesting>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com>

On Thu, Jul 25, 2024 at 11:19:33PM +0300, Amir Goldstein wrote:
> On Thu, Jul 25, 2024 at 9:20 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> > on the faulting method.
> >
> > This pre-content event is meant to be used by hierarchical storage
> > managers that want to fill in the file content on first read access.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/notify/fsnotify.c             | 13 +++++++++
> >  include/linux/fsnotify_backend.h | 14 +++++++++
> >  mm/filemap.c                     | 50 ++++++++++++++++++++++++++++----
> >  3 files changed, 71 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 1ca4a8da7f29..435232d46b4f 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -28,6 +28,19 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
> >         fsnotify_clear_marks_by_mount(mnt);
> >  }
> >
> > +bool fsnotify_file_has_content_watches(struct file *file)
> 
> nit: has_pre_content_watches...
> 
> > +{
> > +       struct inode *inode = file_inode(file);
> > +       struct super_block *sb = inode->i_sb;
> > +       struct mount *mnt = real_mount(file->f_path.mnt);
> > +       u32 mask = inode->i_fsnotify_mask;
> > +
> > +       mask |= mnt->mnt_fsnotify_mask;
> > +       mask |= sb->s_fsnotify_mask;
> > +
> > +       return !!(mask & FSNOTIFY_PRE_CONTENT_EVENTS);
> 
> This can use the fsnotify_object_watched() helper, and it will need
> the READ_ONCE() that are just being added to avoid data races.
> 
> > +}
> > +
> >  /**
> >   * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
> >   * @sb: superblock being unmounted.
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> > index 36c3d18cc40a..6983fbf096b8 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
> >         INIT_LIST_HEAD(&event->list);
> >  }
> >
> > +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> > +bool fsnotify_file_has_content_watches(struct file *file);
> > +#else
> > +static inline bool fsnotify_file_has_content_watches(struct file *file)
> > +{
> > +       return false;
> > +}
> > +#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
> > +
> >  #else
> >
> >  static inline int fsnotify(__u32 mask, const void *data, int data_type,
> > @@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
> >  static inline void fsnotify_unmount_inodes(struct super_block *sb)
> >  {}
> >
> > +static inline bool fsnotify_file_has_content_watches(struct file *file)
> > +{
> > +       return false;
> > +}
> > +
> >  #endif /* CONFIG_FSNOTIFY */
> >
> >  #endif /* __KERNEL __ */
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index ca8c8d889eef..cc9d7885bbe3 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -46,6 +46,7 @@
> >  #include <linux/pipe_fs_i.h>
> >  #include <linux/splice.h>
> >  #include <linux/rcupdate_wait.h>
> > +#include <linux/fsnotify.h>
> >  #include <asm/pgalloc.h>
> >  #include <asm/tlbflush.h>
> >  #include "internal.h"
> > @@ -3112,13 +3113,13 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
> >   * that.  If we didn't pin a file then we return NULL.  The file that is
> >   * returned needs to be fput()'ed when we're done with it.
> >   */
> > -static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> > +static struct file *do_sync_mmap_readahead(struct vm_fault *vmf,
> > +                                          struct file *fpin)
> >  {
> >         struct file *file = vmf->vma->vm_file;
> >         struct file_ra_state *ra = &file->f_ra;
> >         struct address_space *mapping = file->f_mapping;
> >         DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> > -       struct file *fpin = NULL;
> >         unsigned long vm_flags = vmf->vma->vm_flags;
> >         unsigned int mmap_miss;
> >
> > @@ -3182,12 +3183,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >   * was pinned if we have to drop the mmap_lock in order to do IO.
> >   */
> >  static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
> > -                                           struct folio *folio)
> > +                                           struct folio *folio,
> > +                                           struct file *fpin)
> >  {
> 
> If I am reading correctly, iomap (i.e. xfs) write shared memory fault
> does not reach this code?
> 
> Do we care about writable shared memory faults use case for HSM?
> It does not sound very relevant to HSM, but we cannot just ignore it..
> 

Sorry I realized I went off to try and solve this problem and never responded to
you.  I'm addressing the other comments, but this one is a little tricky.

We're kind of stuck between a rock and a hard place with this.  I had originally
put this before the ->fault() callback, but purposefully moved it into
filemap_fault() because I want to be able to drop the mmap lock while we're
waiting for a response from the HSM.

The reason to do this is because there are things that take the mmap lock for
simple things outside of the process, like /proc/$PID/smaps and other related
things, and this can cause high priority tasks to block behind possibly low
priority IO, creating a priority inversion.

Now, I'm not sure how widespread of a problem this is anymore, I know there's
been work done to the kernel and tools to avoid this style of problem.  I'm ok
with a "try it and see" approach, but I don't love that.

However I think putting fsnotify hooks into XFS itself for this particular path
is a good choice either.  What do you think?  Just move it to before ->fault(),
leave the mmap lock in place, and be done with it?  Thanks,

Josef

