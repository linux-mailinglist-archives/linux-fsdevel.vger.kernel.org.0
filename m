Return-Path: <linux-fsdevel+bounces-24279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45893C972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 22:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612891C2199B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E4770E9;
	Thu, 25 Jul 2024 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McEKGKyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056674C7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938788; cv=none; b=phs039VFQUmMlRJuM2n5AH54yYK3sYj0ZKeKvAtU2+CA4SPTftDNiXbvfYGz3E4B30TFVH6DeT26ilnk2rQ0DbLLqWN/IvsLbHYm0/rLYOwqmoZOzsJ6I0y3Uxtm2ts1f64vFhEC6XyI29gx42w2gVkXcJxbjVIkgZglZju55Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938788; c=relaxed/simple;
	bh=dBbpzYckczz63nyusUMGdKP7KTeiJ4/Foh2/XX2OhFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzHFcqJAZmZSwHHerFExgaXAtJkgMj8fY2emIRvMx8BHnvxwK+Cp1LNQuOkY5pht/aWCfFFLH6EXVc98JaLRUMsMMZNq3M+2eNxNlzTiOeM57nbmo+47tnAsSyOmsqMY8ZC8S3lMbxv1m91UKkihMIArnsfjI42yK58o6qk7Rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McEKGKyF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b796667348so12246096d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721938786; x=1722543586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ2wM9sYEaasMhgdyOM6yWdoVjzif+U/STFPA2HM+Nw=;
        b=McEKGKyF8YfgH13y56LsbKWsabqkxsWukoI9erqEti5gRxO2wO4Xv+1cvgBklt3Qhb
         vhQB458xUw/xT41iDfFsR42WrmUbuFFV/ze42eePV38alhDIC2J6H5jMDX/4jUt6ZMqW
         ps0JHAMzAJI1WUOmm9qxoZTA5AFneqBJPkCbRkX+Qw6Psfcev60TJtesw5IuJ8QlzKTk
         pb/6m+39djQccbjZYtQs6mUBOiLcC12AZf6lPUI1I2IDdC3v+86Oea7dHcnDN0DXFL9G
         JYzf3/8E9U/KWNALWscgHTWL4sEHTnRToAM3IHCFlkYEfQxOKOwu6+81PMThKtahAwp+
         u7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938786; x=1722543586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ2wM9sYEaasMhgdyOM6yWdoVjzif+U/STFPA2HM+Nw=;
        b=L73i79I+yP4eFW4pRjazT9/LIZdgic9/p1w844ueWBB7bVkaREjeU4qevGyulHgpn/
         oyEW7Pl+P9XuPQZpicaxFB6P2ooDjxEU8RvJJ/E38o0W01pHOLjvDiA0Va71E1b7Th2d
         08dDE2VPAD1bI1czk/uxIp21aGGQzWkllQX8w/lKgEpevVytbD6CZnQeIBoF4kr/rw99
         8+iQJ2uviOm0KqGZTjDMtWwSZb31MuxQ50F24izdcuawLFq2+rRTAe2C02t4C5pZeIM5
         o1y19GOB6j8eLkiVrbMfiHnMZ/Zq+fmmeO2oVv9B+Wuo5E270Px5MumOk6mzVb9yDVUM
         qLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVernskCVzopsEVKXgMXf9N5rDpblqkMFOmFl6eyy8z7Zd0Z+88Ap/19JCf3lrFjCtF5Kukqjiiz/rkkfYJzR3pYA8zibdz/MHC9Qlyg==
X-Gm-Message-State: AOJu0YxBqx0HQuU25fmqX9lNL70i35yOsPeQBHmy3Sn3d+WDYT/wwNGN
	/2qh8plybz1i8yU+dInN9PkLwBbV95jN2xqB2dQLGS4J79Z2NZOGz49uhLK4TL2askSu/k3NfFK
	N8FrOWKiHWSubWskl7czaApfpSqk=
X-Google-Smtp-Source: AGHT+IHO8ytX9VQTm4DZF6DSv9DZb4bJHzQ+JSQ+a+ITpqWLLV6MxnTgNetdRrDnT6WCKyOZNlNKL0EdfxC/JE8ASiM=
X-Received: by 2002:a0c:facb:0:b0:6b5:2062:dd5c with SMTP id
 6a1803df08f44-6b99129ed1dmr124587066d6.8.1721938785798; Thu, 25 Jul 2024
 13:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
In-Reply-To: <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Jul 2024 23:19:33 +0300
Message-ID: <CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:20=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> on the faulting method.
>
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill in the file content on first read access.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/notify/fsnotify.c             | 13 +++++++++
>  include/linux/fsnotify_backend.h | 14 +++++++++
>  mm/filemap.c                     | 50 ++++++++++++++++++++++++++++----
>  3 files changed, 71 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 1ca4a8da7f29..435232d46b4f 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -28,6 +28,19 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
>         fsnotify_clear_marks_by_mount(mnt);
>  }
>
> +bool fsnotify_file_has_content_watches(struct file *file)

nit: has_pre_content_watches...

> +{
> +       struct inode *inode =3D file_inode(file);
> +       struct super_block *sb =3D inode->i_sb;
> +       struct mount *mnt =3D real_mount(file->f_path.mnt);
> +       u32 mask =3D inode->i_fsnotify_mask;
> +
> +       mask |=3D mnt->mnt_fsnotify_mask;
> +       mask |=3D sb->s_fsnotify_mask;
> +
> +       return !!(mask & FSNOTIFY_PRE_CONTENT_EVENTS);

This can use the fsnotify_object_watched() helper, and it will need
the READ_ONCE() that are just being added to avoid data races.

> +}
> +
>  /**
>   * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched in=
odes.
>   * @sb: superblock being unmounted.
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 36c3d18cc40a..6983fbf096b8 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fsnoti=
fy_event *event)
>         INIT_LIST_HEAD(&event->list);
>  }
>
> +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> +bool fsnotify_file_has_content_watches(struct file *file);
> +#else
> +static inline bool fsnotify_file_has_content_watches(struct file *file)
> +{
> +       return false;
> +}
> +#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
> +
>  #else
>
>  static inline int fsnotify(__u32 mask, const void *data, int data_type,
> @@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
>  static inline void fsnotify_unmount_inodes(struct super_block *sb)
>  {}
>
> +static inline bool fsnotify_file_has_content_watches(struct file *file)
> +{
> +       return false;
> +}
> +
>  #endif /* CONFIG_FSNOTIFY */
>
>  #endif /* __KERNEL __ */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ca8c8d889eef..cc9d7885bbe3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -46,6 +46,7 @@
>  #include <linux/pipe_fs_i.h>
>  #include <linux/splice.h>
>  #include <linux/rcupdate_wait.h>
> +#include <linux/fsnotify.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
> @@ -3112,13 +3113,13 @@ static int lock_folio_maybe_drop_mmap(struct vm_f=
ault *vmf, struct folio *folio,
>   * that.  If we didn't pin a file then we return NULL.  The file that is
>   * returned needs to be fput()'ed when we're done with it.
>   */
> -static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> +static struct file *do_sync_mmap_readahead(struct vm_fault *vmf,
> +                                          struct file *fpin)
>  {
>         struct file *file =3D vmf->vma->vm_file;
>         struct file_ra_state *ra =3D &file->f_ra;
>         struct address_space *mapping =3D file->f_mapping;
>         DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> -       struct file *fpin =3D NULL;
>         unsigned long vm_flags =3D vmf->vma->vm_flags;
>         unsigned int mmap_miss;
>
> @@ -3182,12 +3183,12 @@ static struct file *do_sync_mmap_readahead(struct=
 vm_fault *vmf)
>   * was pinned if we have to drop the mmap_lock in order to do IO.
>   */
>  static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
> -                                           struct folio *folio)
> +                                           struct folio *folio,
> +                                           struct file *fpin)
>  {

If I am reading correctly, iomap (i.e. xfs) write shared memory fault
does not reach this code?

Do we care about writable shared memory faults use case for HSM?
It does not sound very relevant to HSM, but we cannot just ignore it..

>         struct file *file =3D vmf->vma->vm_file;
>         struct file_ra_state *ra =3D &file->f_ra;
>         DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
> -       struct file *fpin =3D NULL;
>         unsigned int mmap_miss;
>
>         /* If we don't want any read-ahead, don't bother */
> @@ -3287,6 +3288,35 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>         if (unlikely(index >=3D max_idx))
>                 return VM_FAULT_SIGBUS;
>
> +       /*
> +        * If we have pre-content watchers then we need to generate event=
s on
> +        * page fault so that we can populate any data before the fault.
> +        *
> +        * We only do this on the first pass through, otherwise the popul=
ating
> +        * application could potentially deadlock on the mmap lock if it =
tries
> +        * to populate it with mmap.
> +        */
> +       if (fault_flag_allow_retry_first(vmf->flags) &&
> +           fsnotify_file_has_content_watches(file)) {
> +               int mask =3D (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE =
: MAY_READ;
> +               loff_t pos =3D vmf->pgoff << PAGE_SHIFT;
> +
> +               fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
> +
> +               /*
> +                * We can only emit the event if we did actually release =
the
> +                * mmap lock.
> +                */
> +               if (fpin) {
> +                       error =3D fsnotify_file_area_perm(fpin, mask, &po=
s,
> +                                                       PAGE_SIZE);

This is going to also emit a FAN_ACCESS_PERM event.
Heritage of the fact that read() has to emit FAN_ACCESS_PERM
for backward compat and a design decision to emit both
FAN_ACCESS_PERM and FAN_PRE_ACCESS to avoid carrying the
API baggage of the legacy FAN_ACCESS_PERM to pre-content events.

Suggestion as workaround - use MAY_ACCESS instead of MAY_READ
here and emit FAN_PRE_ACCESS with MAY_READ | MAY_ACCESS.

Thank you for pushing my patches through!
Amir.

