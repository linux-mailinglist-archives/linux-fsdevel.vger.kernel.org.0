Return-Path: <linux-fsdevel+bounces-47538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6782A9FA4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24AD1A84C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDE3297A7C;
	Mon, 28 Apr 2025 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6JX74vw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3C297A5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871286; cv=none; b=Qv+aL7qjjlbYpoBN3xvacBLBoYaxiQkKd9DyGuhKvJP7lNpGIoG6JGwZeBiagUMPreOD8zoeV23UKsAR+nAEgdYsUkcvqMjScf/vY6wbH2g3D+ZcfGjeF5qPn3bFRNn02qiQKUhULijzpJKGB3OGSGvzar2M2J+TnsdPMBCn6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871286; c=relaxed/simple;
	bh=bxfY+Ioo9ZWQo5CfpHE0LzqrqASPOVNFyMvpTkPt2Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QHNtqaRhJ/Q8mChJpAbhVE/F0+6bkdVvQNvqZTkBBSQGeomufrqBej2ZV7XKsLh6RivZGRzNa3OaYHx9li0z39wxWQOsBBiJXwknFNuUNJ68tw+MSeCS9/FK1tfKEz8dk/SeW7rAv/Vnn0e3/o3/eeQiRmkD00DhExSLo4Bcz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6JX74vw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4774611d40bso66411cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745871283; x=1746476083; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S2govk0YTCyl2KstM3ifkgIwBCMVYbty/KI+EWa3eA=;
        b=M6JX74vwvOsiaajH75Tk3x3DUfXhsV7+0x9t4V344aBuDKlwYOZWkbzUNCgZYOsX5H
         rB1Ue4yIWPDhh763jd5+uztyjqcgSJlzLm3Bgcp4xTOnYzwYoSwgvCkiyKkc3DrUC/v2
         POJAV6qdi5uNszImCcaIqLNq8aOU7mOJWiwuidlFl3irESmii96HMLrzB/P9zbTBg7Dh
         62p5dQWNAAZ9oWoP4DhLbNWxjIJHZdmSx8ZOMiJUHn6/gzWi6Pq8+/0huLf5mHHNjf/l
         jkgv5ff5pLmylA2zxo+yXkhSXl1ajM28KSZBekG5udA+ZDw6SqM13sVMNbLMM7jJXkOc
         8OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871283; x=1746476083;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S2govk0YTCyl2KstM3ifkgIwBCMVYbty/KI+EWa3eA=;
        b=H1daXk7e58MmAAgmHcEBbEMEmdffQFXdtKQBnuXkQ68TUuT+JyoeUUqech32ChwDqD
         mCKLwzHQLWs4AbX+/EBvizdf45A9uzVqw4EtzSKhjBmTj1o/uez0zLUzRIfs3uh9f2qh
         TLBU8bjGpXex940TsBRfKGTirmXBKYUOkV4U6pWrAHMxoaAZnqEugdFoYROTTfS5Wx9Y
         WpyWmqVjqSyv9SEXIdO2uRalPOgoKf+4zyLY9+jba5Wd58Sk9nedLmronUV6UpXNuZAf
         M3OqsMgQ6ZVWGdnpKhkEOcdTHdQ+eKHSIcz+B9J4FXNBpBuWqIhtLON5ELlqgp7Z6aTa
         dcfA==
X-Forwarded-Encrypted: i=1; AJvYcCXRQwZtBFvW3rrylTU4vY9WShq+WzEkXzMMd+txq7xXE8xrVGMS1RtOI1VvHnT1gfbgdaE96xXV8vQ2Dt4/@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZ2OIcl4n2S8hWz1w/zD43KajLlS6lWXMgamFgJGg2DIESC2/
	QgSCaVRjULRnyMKDBKEQ5LWGlIir+9Ci9Kw/GuN1bHjmR74HpSV1hbOpKKiA5MIrYTBQPHP/MJe
	horWRJyKPQEQlo9FJnFTLBRlBam5iAvmqqfIos8uHFWDxHZe6GAG5l34=
X-Gm-Gg: ASbGncvq7f6hczgZS+QWSuOkM++wbxJxTOutmm2jdXTP4LYPUAX9ENpGhlTveDzj1Yc
	1SFSZyUSXMXHQmchJ+SuM0565+e+WLQjim7zSncOYvS2jfBseNianA/EMIFcVJ6v1RT1kgFL5Vk
	oh+Igiy2/H4YL94zL/cuxq
X-Google-Smtp-Source: AGHT+IESI645f2qHrcanEzoqJYbRkEi/qXg20FUnpK+Mrmj56B6+m7fdLzaHim/GJodJsJa9F9OUIIFtZEKaj9hH10U=
X-Received: by 2002:a05:622a:1487:b0:486:8711:19af with SMTP id
 d75a77b69052e-48855985193mr976651cf.0.1745871282558; Mon, 28 Apr 2025
 13:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
 <p7nijnmkjljnevxdizul2iczzk33pk7o6rjahzm6wceldfpaom@jdj7o4zszgex>
In-Reply-To: <p7nijnmkjljnevxdizul2iczzk33pk7o6rjahzm6wceldfpaom@jdj7o4zszgex>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Apr 2025 13:14:31 -0700
X-Gm-Features: ATxdqUEvLSPpzrB5CbS4RjadJagAjogPm_l6Zq1i9YQssAsWOKs-X7DJhKk_xvM
Message-ID: <CAJuCfpHomWFOGhwBH8e+14ayKMf8VGKapLP1QBbZ_fumMPN1Eg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm VMA functionality
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:20=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> > There is functionality that overlaps the exec and memory mapping
> > subsystems. While it properly belongs in mm, it is important that exec
> > maintainers maintain oversight of this functionality correctly.
> >
> > We can establish both goals by adding a new mm/vma_exec.c file which
> > contains these 'glue' functions, and have fs/exec.c import them.
> >
> > As a part of this change, to ensure that proper oversight is achieved, =
add
> > the file to both the MEMORY MAPPING and EXEC & BINFMT API, ELF sections=
.
> >
> > scripts/get_maintainer.pl can correctly handle files in multiple entrie=
s
> > and this neatly handles the cross-over.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  MAINTAINERS                      |  2 +
> >  fs/exec.c                        |  3 ++
> >  include/linux/mm.h               |  1 -
> >  mm/Makefile                      |  2 +-
> >  mm/mmap.c                        | 83 ----------------------------
> >  mm/vma.h                         |  5 ++
> >  mm/vma_exec.c                    | 92 ++++++++++++++++++++++++++++++++
> >  tools/testing/vma/Makefile       |  2 +-
> >  tools/testing/vma/vma.c          |  1 +
> >  tools/testing/vma/vma_internal.h | 40 ++++++++++++++
> >  10 files changed, 145 insertions(+), 86 deletions(-)
> >  create mode 100644 mm/vma_exec.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f5ee0390cdee..1ee1c22e6e36 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8830,6 +8830,7 @@ F:      include/linux/elf.h
> >  F:   include/uapi/linux/auxvec.h
> >  F:   include/uapi/linux/binfmts.h
> >  F:   include/uapi/linux/elf.h
> > +F:   mm/vma_exec.c
> >  F:   tools/testing/selftests/exec/
> >  N:   asm/elf.h
> >  N:   binfmt
> > @@ -15654,6 +15655,7 @@ F:    mm/mremap.c
> >  F:   mm/mseal.c
> >  F:   mm/vma.c
> >  F:   mm/vma.h
> > +F:   mm/vma_exec.c
> >  F:   mm/vma_internal.h
> >  F:   tools/testing/selftests/mm/merge.c
> >  F:   tools/testing/vma/
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 8e4ea5f1e64c..477bc3f2e966 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -78,6 +78,9 @@
> >
> >  #include <trace/events/sched.h>
> >
> > +/* For vma exec functions. */
> > +#include "../mm/internal.h"
> > +
> >  static int bprm_creds_from_file(struct linux_binprm *bprm);
> >
> >  int suid_dumpable =3D 0;
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 21dd110b6655..4fc361df9ad7 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3223,7 +3223,6 @@ void anon_vma_interval_tree_verify(struct anon_vm=
a_chain *node);
> >  extern int __vm_enough_memory(struct mm_struct *mm, long pages, int ca=
p_sys_admin);
> >  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct =
*);
> >  extern void exit_mmap(struct mm_struct *);
> > -int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)=
;
> >  bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_=
struct *vma,
> >                                unsigned long addr, bool write);
> >
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 9d7e5b5bb694..15a901bb431a 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -37,7 +37,7 @@ mmu-y                       :=3D nommu.o
> >  mmu-$(CONFIG_MMU)    :=3D highmem.o memory.o mincore.o \
> >                          mlock.o mmap.o mmu_gather.o mprotect.o mremap.=
o \
> >                          msync.o page_vma_mapped.o pagewalk.o \
> > -                        pgtable-generic.o rmap.o vmalloc.o vma.o
> > +                        pgtable-generic.o rmap.o vmalloc.o vma.o vma_e=
xec.o
> >
> >
> >  ifdef CONFIG_CROSS_MEMORY_ATTACH
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index bd210aaf7ebd..1794bf6f4dc0 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1717,89 +1717,6 @@ static int __meminit init_reserve_notifier(void)
> >  }
> >  subsys_initcall(init_reserve_notifier);
> >
> > -/*
> > - * Relocate a VMA downwards by shift bytes. There cannot be any VMAs b=
etween
> > - * this VMA and its relocated range, which will now reside at [vma->vm=
_start -
> > - * shift, vma->vm_end - shift).
> > - *
> > - * This function is almost certainly NOT what you want for anything ot=
her than
> > - * early executable temporary stack relocation.
> > - */
> > -int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > -{
> > -     /*
> > -      * The process proceeds as follows:
> > -      *
> > -      * 1) Use shift to calculate the new vma endpoints.
> > -      * 2) Extend vma to cover both the old and new ranges.  This ensu=
res the
> > -      *    arguments passed to subsequent functions are consistent.
> > -      * 3) Move vma's page tables to the new range.
> > -      * 4) Free up any cleared pgd range.
> > -      * 5) Shrink the vma to cover only the new range.
> > -      */
> > -
> > -     struct mm_struct *mm =3D vma->vm_mm;
> > -     unsigned long old_start =3D vma->vm_start;
> > -     unsigned long old_end =3D vma->vm_end;
> > -     unsigned long length =3D old_end - old_start;
> > -     unsigned long new_start =3D old_start - shift;
> > -     unsigned long new_end =3D old_end - shift;
> > -     VMA_ITERATOR(vmi, mm, new_start);
> > -     VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
> > -     struct vm_area_struct *next;
> > -     struct mmu_gather tlb;
> > -     PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> > -
> > -     BUG_ON(new_start > new_end);
> > -
> > -     /*
> > -      * ensure there are no vmas between where we want to go
> > -      * and where we are
> > -      */
> > -     if (vma !=3D vma_next(&vmi))
> > -             return -EFAULT;
> > -
> > -     vma_iter_prev_range(&vmi);
> > -     /*
> > -      * cover the whole range: [new_start, old_end)
> > -      */
> > -     vmg.middle =3D vma;
> > -     if (vma_expand(&vmg))
> > -             return -ENOMEM;
> > -
> > -     /*
> > -      * move the page tables downwards, on failure we rely on
> > -      * process cleanup to remove whatever mess we made.
> > -      */
> > -     pmc.for_stack =3D true;
> > -     if (length !=3D move_page_tables(&pmc))
> > -             return -ENOMEM;
> > -
> > -     tlb_gather_mmu(&tlb, mm);
> > -     next =3D vma_next(&vmi);
> > -     if (new_end > old_start) {
> > -             /*
> > -              * when the old and new regions overlap clear from new_en=
d.
> > -              */
> > -             free_pgd_range(&tlb, new_end, old_end, new_end,
> > -                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > -     } else {
> > -             /*
> > -              * otherwise, clean from old_start; this is done to not t=
ouch
> > -              * the address space in [new_end, old_start) some archite=
ctures
> > -              * have constraints on va-space that make this illegal (I=
A64) -
> > -              * for the others its just a little faster.
> > -              */
> > -             free_pgd_range(&tlb, old_start, old_end, new_end,
> > -                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > -     }
> > -     tlb_finish_mmu(&tlb);
> > -
> > -     vma_prev(&vmi);
> > -     /* Shrink the vma to just the new range */
> > -     return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > -}
> > -
> >  #ifdef CONFIG_MMU
> >  /*
> >   * Obtain a read lock on mm->mmap_lock, if the specified address is be=
low the
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 149926e8a6d1..1ce3e18f01b7 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -548,4 +548,9 @@ int expand_downwards(struct vm_area_struct *vma, un=
signed long address);
> >
> >  int __vm_munmap(unsigned long start, size_t len, bool unlock);
> >
> > +/* vma_exec.h */

nit: Did you mean vma_exec.c ?

> > +#ifdef CONFIG_MMU
> > +int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)=
;
> > +#endif
> > +
> >  #endif       /* __MM_VMA_H */
> > diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> > new file mode 100644
> > index 000000000000..6736ae37f748
> > --- /dev/null
> > +++ b/mm/vma_exec.c
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Functions explicitly implemented for exec functionality which howev=
er are
> > + * explicitly VMA-only logic.
> > + */
> > +
> > +#include "vma_internal.h"
> > +#include "vma.h"
> > +
> > +/*
> > + * Relocate a VMA downwards by shift bytes. There cannot be any VMAs b=
etween
> > + * this VMA and its relocated range, which will now reside at [vma->vm=
_start -
> > + * shift, vma->vm_end - shift).
> > + *
> > + * This function is almost certainly NOT what you want for anything ot=
her than
> > + * early executable temporary stack relocation.
> > + */
> > +int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > +{
> > +     /*
> > +      * The process proceeds as follows:
> > +      *
> > +      * 1) Use shift to calculate the new vma endpoints.
> > +      * 2) Extend vma to cover both the old and new ranges.  This ensu=
res the
> > +      *    arguments passed to subsequent functions are consistent.
> > +      * 3) Move vma's page tables to the new range.
> > +      * 4) Free up any cleared pgd range.
> > +      * 5) Shrink the vma to cover only the new range.
> > +      */
> > +
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     unsigned long old_start =3D vma->vm_start;
> > +     unsigned long old_end =3D vma->vm_end;
> > +     unsigned long length =3D old_end - old_start;
> > +     unsigned long new_start =3D old_start - shift;
> > +     unsigned long new_end =3D old_end - shift;
> > +     VMA_ITERATOR(vmi, mm, new_start);
> > +     VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
> > +     struct vm_area_struct *next;
> > +     struct mmu_gather tlb;
> > +     PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> > +
> > +     BUG_ON(new_start > new_end);
> > +
> > +     /*
> > +      * ensure there are no vmas between where we want to go
> > +      * and where we are
> > +      */
> > +     if (vma !=3D vma_next(&vmi))
> > +             return -EFAULT;
> > +
> > +     vma_iter_prev_range(&vmi);
> > +     /*
> > +      * cover the whole range: [new_start, old_end)
> > +      */
> > +     vmg.middle =3D vma;
> > +     if (vma_expand(&vmg))
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * move the page tables downwards, on failure we rely on
> > +      * process cleanup to remove whatever mess we made.
> > +      */
> > +     pmc.for_stack =3D true;
> > +     if (length !=3D move_page_tables(&pmc))
> > +             return -ENOMEM;
> > +
> > +     tlb_gather_mmu(&tlb, mm);
> > +     next =3D vma_next(&vmi);
> > +     if (new_end > old_start) {
> > +             /*
> > +              * when the old and new regions overlap clear from new_en=
d.
> > +              */
> > +             free_pgd_range(&tlb, new_end, old_end, new_end,
> > +                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > +     } else {
> > +             /*
> > +              * otherwise, clean from old_start; this is done to not t=
ouch
> > +              * the address space in [new_end, old_start) some archite=
ctures
> > +              * have constraints on va-space that make this illegal (I=
A64) -
> > +              * for the others its just a little faster.
> > +              */
> > +             free_pgd_range(&tlb, old_start, old_end, new_end,
> > +                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > +     }
> > +     tlb_finish_mmu(&tlb);
> > +
> > +     vma_prev(&vmi);
> > +     /* Shrink the vma to just the new range */
> > +     return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > +}
> > diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> > index 860fd2311dcc..624040fcf193 100644
> > --- a/tools/testing/vma/Makefile
> > +++ b/tools/testing/vma/Makefile
> > @@ -9,7 +9,7 @@ include ../shared/shared.mk
> >  OFILES =3D $(SHARED_OFILES) vma.o maple-shim.o
> >  TARGETS =3D vma
> >
> > -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
> > +vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c .=
./../../mm/vma.h
> >
> >  vma: $(OFILES)
> >       $(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > index 7cfd6e31db10..5832ae5d797d 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/vma.c
> > @@ -28,6 +28,7 @@ unsigned long stack_guard_gap =3D 256UL<<PAGE_SHIFT;
> >   * Directly import the VMA implementation here. Our vma_internal.h wra=
pper
> >   * provides userland-equivalent functionality for everything vma.c use=
s.
> >   */
> > +#include "../../../mm/vma_exec.c"
> >  #include "../../../mm/vma.c"
> >
> >  const struct vm_operations_struct vma_dummy_vm_ops;
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_i=
nternal.h
> > index 572ab2cea763..0df19ca0000a 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -421,6 +421,28 @@ struct vm_unmapped_area_info {
> >       unsigned long start_gap;
> >  };
> >
> > +struct pagetable_move_control {
> > +     struct vm_area_struct *old; /* Source VMA. */
> > +     struct vm_area_struct *new; /* Destination VMA. */
> > +     unsigned long old_addr; /* Address from which the move begins. */
> > +     unsigned long old_end; /* Exclusive address at which old range en=
ds. */
> > +     unsigned long new_addr; /* Address to move page tables to. */
> > +     unsigned long len_in; /* Bytes to remap specified by user. */
> > +
> > +     bool need_rmap_locks; /* Do rmap locks need to be taken? */
> > +     bool for_stack; /* Is this an early temp stack being moved? */
> > +};
> > +
> > +#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_) \
> > +     struct pagetable_move_control name =3D {                         =
 \
> > +             .old =3D old_,                                           =
 \
> > +             .new =3D new_,                                           =
 \
> > +             .old_addr =3D old_addr_,                                 =
 \
> > +             .old_end =3D (old_addr_) + (len_),                       =
 \
> > +             .new_addr =3D new_addr_,                                 =
 \
> > +             .len_in =3D len_,                                        =
 \
> > +     }
> > +
> >  static inline void vma_iter_invalidate(struct vma_iterator *vmi)
> >  {
> >       mas_pause(&vmi->mas);
> > @@ -1240,4 +1262,22 @@ static inline int mapping_map_writable(struct ad=
dress_space *mapping)
> >       return 0;
> >  }
> >
> > +static inline unsigned long move_page_tables(struct pagetable_move_con=
trol *pmc)
> > +{
> > +     (void)pmc;
> > +
> > +     return 0;
> > +}
> > +
> > +static inline void free_pgd_range(struct mmu_gather *tlb,
> > +                     unsigned long addr, unsigned long end,
> > +                     unsigned long floor, unsigned long ceiling)
> > +{
> > +     (void)tlb;
> > +     (void)addr;
> > +     (void)end;
> > +     (void)floor;
> > +     (void)ceiling;
> > +}
> > +
> >  #endif       /* __MM_VMA_INTERNAL_H */
> > --
> > 2.49.0
> >

