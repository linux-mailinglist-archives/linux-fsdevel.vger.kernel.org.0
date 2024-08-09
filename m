Return-Path: <linux-fsdevel+bounces-25507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48994CEC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3561C22412
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739981922F5;
	Fri,  9 Aug 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3OXQZdt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE661922DD;
	Fri,  9 Aug 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199688; cv=none; b=J1mETrl/cgPcn/o9+3jB+pYvxatJB52vAa1Aiti+ucxiRSdSa4pzs50nFYSUmFxk0jxNnHw1FOV3ktjQKVzDfOYTzs5v75zkQokwmMe/ZFVK1snKOELMERpAzLaefT5jzZYC2v7ne+WvvdVvCXUUqyQ8oBVi9dFtK44rSUE+F7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199688; c=relaxed/simple;
	bh=1wgzFHAy5ZAm/MtvH67YFXkiLkUENjoMu00WdPC/oWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxsJRug9CE8thaSiXDcrAgd/II80LmW1h3DZTJ8ycM5Hfsb67e+41kbt9aOUQpqbBoGz7W+/EYBcwinxjZQKjgrKssChI0R6IAY7zXNa3wvDYufzSguL3ipcT10qt6bCIaWJM6MacdyfrzWrtI+myhxe/EibJ2vdrWtLdKupUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3OXQZdt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d0dc869bso116623785a.2;
        Fri, 09 Aug 2024 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723199686; x=1723804486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8Rt2uRteO3s/W93KxwWyA+7W/jfG/qdLIJu/l21pOI=;
        b=B3OXQZdt+38zEghIitqe/x9lYDtt06bGaR1apxZBN/lBtm1p2o0CcLnRWHjigjrqb5
         ms3q1jcIsbP42wgTc5bHw9MHPeJXTH+C7sXLy3nxjx22soO3sd9wrVIwo2q0kdhqRsc+
         svpL5wm+cwPuMI9CohGOGX3DbfOwW60KAzzxfW/0NEdGgQgJ7t3fMyqD3SEC1EwEdUxl
         3xXSratkBPQJKCTfNBAa1iiLPPJ8c2bpn/PNhmVwKKl2bMHRMl3Jec+k7Ghocaa2exsa
         cmX3yuoYE7VJZiRE9d4AebV+uOYfDe1+YFHFRcyiMvEqKj+afwcBLfj/l/RNRYCOMWhX
         dR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723199686; x=1723804486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8Rt2uRteO3s/W93KxwWyA+7W/jfG/qdLIJu/l21pOI=;
        b=GpkhwddUXNXeJI3/DK28bUi6FQRlTmACXkjBHVqJUDks8LU2ccIRvD7zfZ6DSnMGy1
         RgqhMIjwTF/afmMf7bW7op0SkqrYsC3GAWTFB3KjhWxsmwS0aLsb13W3lIYfhKCAAG84
         kA0RBz7cAm/FeB/g9TLcd5Ej0vU6J96FS0Nbbd1Gajj74wRnWcwufnL2RdQlnmtiu3+g
         jHWIuBNMT3G3iLmCbDVQjXRTPXRwf5Ynbq8U0sK66wWqfUd+fhmIiUlviMdFvdJtdyrN
         lqJeXFXkzLtU4HowBxU1fKiCcxz1he39jCNBqMlqVGila1Q2lDmoP5NYY//aNGYawvLA
         hEyw==
X-Forwarded-Encrypted: i=1; AJvYcCU1iMM4BUdKJn4zI+1GY1ksSKpbt4aBuiezBkzDP7yasV7WitM5AIlUOaCRZFT/B2iSJ7rwy6l1tCUUu/n0xN9HrSpp/H1FIGwVZteyjli5WIcCNyhUmt3u1gHhhgNFW+Qs7OlpUQ6Vr77/SYDp2ai2ZA82XozPzkcrHPjhb0zsteKp4RL9GZFJ
X-Gm-Message-State: AOJu0YyxOamNzTHnqsoIe4lQ03UW+urxTZqmQM8iIPsoY6JdnUOl2GhV
	7HCVVq0N1QDww43puWL8eNv+camAtk7Pfdm3l3U782LtozvuXetwJSXKYFTQlEfOG5RiOc0enSW
	dvZBOSg8vjcT4DhmLvGDOjIZj/4c=
X-Google-Smtp-Source: AGHT+IE6k6jkC8soHuhF1UAvmWBUGOJEeJmvZcTjFrXx9tN32I5U8WvEF79pt2abgUumNMCCZykVhqG90c2xr7MI1JQ=
X-Received: by 2002:a05:620a:3954:b0:7a2:317:a845 with SMTP id
 af79cd13be357-7a4c1781a52mr112774385a.2.1723199685925; Fri, 09 Aug 2024
 03:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723144881.git.josef@toxicpanda.com> <b8c3f0d9ed6d23f9a636919e28293cdbbe22e0db.1723144881.git.josef@toxicpanda.com>
In-Reply-To: <b8c3f0d9ed6d23f9a636919e28293cdbbe22e0db.1723144881.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Aug 2024 12:34:34 +0200
Message-ID: <CAOQ4uxivX+mxfpOUTAsxHVoCGb9YHdi-qHswN9O4EJ53sKUVfw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] fsnotify: generate pre-content permission event
 on page fault
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:28=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> on the faulting method.
>
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill in the file content on first read access.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/linux/mm.h |  2 +
>  mm/filemap.c       | 97 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 92 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ab3d78116043..c33f3b7f7261 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3503,6 +3503,8 @@ extern vm_fault_t filemap_fault(struct vm_fault *vm=
f);
>  extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>                 pgoff_t start_pgoff, pgoff_t end_pgoff);
>  extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
> +extern vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf=
,
> +                                                   struct file **fpin);
>
>  extern unsigned long stack_guard_gap;
>  /* Generic expand stack which grows the stack according to GROWS{UP,DOWN=
} */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8b1684b62177..3d232166b051 100644
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
> @@ -3190,12 +3191,12 @@ static struct file *do_sync_mmap_readahead(struct=
 vm_fault *vmf)
>   * was pinned if we have to drop the mmap_lock in order to do IO.
>   */
>  static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
> -                                           struct folio *folio)
> +                                           struct folio *folio,
> +                                           struct file *fpin)
>  {
>         struct file *file =3D vmf->vma->vm_file;
>         struct file_ra_state *ra =3D &file->f_ra;
>         DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
> -       struct file *fpin =3D NULL;
>         unsigned int mmap_miss;
>
>         /* See comment in do_sync_mmap_readahead. */
> @@ -3260,6 +3261,72 @@ static vm_fault_t filemap_fault_recheck_pte_none(s=
truct vm_fault *vmf)
>         return ret;
>  }
>
> +/**
> + * filemap_maybe_emit_fsnotify_event - maybe emit a pre-content event.
> + * @vmf:       struct vm_fault containing details of the fault.
> + * @fpin:      pointer to the struct file pointer that may be pinned.
> + *
> + * If we have pre-content watches on this file we will need to emit an e=
vent for
> + * this range.  We will handle dropping the lock and emitting the event.
> + *
> + * If FAULT_FLAG_RETRY_NOWAIT is set then we'll return VM_FAULT_RETRY.
> + *
> + * If no event was emitted then *fpin will be NULL and we will return 0.
> + *
> + * If any error occurred we will return VM_FAULT_SIGBUS, *fpin could sti=
ll be
> + * set and will need to have fput() called on it.
> + *
> + * If we emitted the event then we will return 0 and *fpin will be set, =
this
> + * must have fput() called on it, and the caller must call VM_FAULT_RETR=
Y after
> + * any other operations it does in order to re-fault the page and make s=
ure the
> + * appropriate locking is maintained.
> + *
> + * Return: the appropriate vm_fault_t return code, 0 on success.
> + */
> +vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf,
> +                                            struct file **fpin)
> +{
> +       struct file *file =3D vmf->vma->vm_file;
> +       loff_t pos =3D vmf->pgoff << PAGE_SHIFT;
> +       int mask =3D (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_RE=
AD;

You missed my comment about using MAY_ACCESS here
and alter fsnotify hook, so legacy FAN_ACCESS_PERM event
won't be generated from page fault.

Thanks,
Amir.

> +       int ret;
> +
> +       /*
> +        * We already did this and now we're retrying with everything loc=
ked,
> +        * don't emit the event and continue.
> +        */
> +       if (vmf->flags & FAULT_FLAG_TRIED)
> +               return 0;
> +
> +       /* No watches, return NULL. */
> +       if (!fsnotify_file_has_pre_content_watches(file))
> +               return 0;
> +
> +       /* We are NOWAIT, we can't wait, just return EAGAIN. */
> +       if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> +               return VM_FAULT_RETRY;
> +
> +       /*
> +        * If this fails then we're not allowed to drop the fault lock, r=
eturn a
> +        * SIGBUS so we don't errantly populate pagecache with bogus data=
 for
> +        * this file.
> +        */
> +       *fpin =3D maybe_unlock_mmap_for_io(vmf, *fpin);
> +       if (*fpin =3D=3D NULL)
> +               return VM_FAULT_SIGBUS | VM_FAULT_RETRY;
> +
> +       /*
> +        * We can't fput(*fpin) at this point because we could have been =
passed
> +        * in fpin from a previous call.
> +        */
> +       ret =3D fsnotify_file_area_perm(*fpin, mask, &pos, PAGE_SIZE);
> +       if (ret)
> +               return VM_FAULT_SIGBUS;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(filemap_maybe_emit_fsnotify_event);
> +
>  /**
>   * filemap_fault - read in file data for page fault handling
>   * @vmf:       struct vm_fault containing details of the fault
> @@ -3299,6 +3366,19 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>         if (unlikely(index >=3D max_idx))
>                 return VM_FAULT_SIGBUS;
>
> +       /*
> +        * If we have pre-content watchers then we need to generate event=
s on
> +        * page fault so that we can populate any data before the fault.
> +        */
> +       ret =3D filemap_maybe_emit_fsnotify_event(vmf, &fpin);
> +       if (unlikely(ret)) {
> +               if (fpin) {
> +                       fput(fpin);
> +                       ret |=3D VM_FAULT_RETRY;
> +               }
> +               return ret;
> +       }
> +
>         /*
>          * Do we have something in the page cache already?
>          */
> @@ -3309,21 +3389,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>                  * the lock.
>                  */
>                 if (!(vmf->flags & FAULT_FLAG_TRIED))
> -                       fpin =3D do_async_mmap_readahead(vmf, folio);
> +                       fpin =3D do_async_mmap_readahead(vmf, folio, fpin=
);
>                 if (unlikely(!folio_test_uptodate(folio))) {
>                         filemap_invalidate_lock_shared(mapping);
>                         mapping_locked =3D true;
>                 }
>         } else {
>                 ret =3D filemap_fault_recheck_pte_none(vmf);
> -               if (unlikely(ret))
> +               if (unlikely(ret)) {
> +                       if (fpin)
> +                               goto out_retry;
>                         return ret;
> +               }
>
>                 /* No page in the page cache at all */
>                 count_vm_event(PGMAJFAULT);
>                 count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>                 ret =3D VM_FAULT_MAJOR;
> -               fpin =3D do_sync_mmap_readahead(vmf);
> +               fpin =3D do_sync_mmap_readahead(vmf, fpin);
>  retry_find:
>                 /*
>                  * See comment in filemap_create_folio() why we need
> --
> 2.43.0
>

