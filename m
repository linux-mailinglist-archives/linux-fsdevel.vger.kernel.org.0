Return-Path: <linux-fsdevel+bounces-21209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A169006CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06112289924
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C219197A9D;
	Fri,  7 Jun 2024 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psKzANeL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06D1953AA
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771140; cv=none; b=Xs3evRm0SWzJg5j0TtYOi5RMY32FnfZ08DCcNSPAqwJ96t+JlPDBrSxvmmb1eRG4GgzU2nh4zD4TUEEaxk+4OaXEM7gjqsqu857+MEBPOswerE/QVrDP+7ECDhSqTEQPDP1SQldKis7eKipijFAAg54m77BgMg6TMVITmtBxGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771140; c=relaxed/simple;
	bh=5uMP2yOX8Hn91NChX5+SWL/0/u80xBnr2yDTHvhvw3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDU8pj8rBjQ5XrsIOmI/sw6gl86gyECYLEhC3VvC/3T0MEpII5UEqMjYdM6H9LLR2QbLtGiE01/j1AWuLQDGsL6s+8LeoqjLtBK//NaGAydg0V/h3anopqzKLm0LzqrMWfaZjQVrGcETH0kvEzJDQSsHi66hubmkW7172p6omOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psKzANeL; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a0849f8e5so22967857b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2024 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717771137; x=1718375937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPY3kEn9dtxckyYDxTCJfVvE65ZOGNBoardFeiSOUO4=;
        b=psKzANeLDOyD5rU34LNNu5jhCJ5T3El1GmG6elV0ba1MhXBGHZPsnDS/t3wHK/HI0B
         /lzKOWjZ4LuzgA1QIJ7Ot8KB9LvRWhTYZim2IC3rNg3/NkqE3Nge/2VWP2MCQjMaaXYg
         BW1NPBu8OMQXPDv9y3lzbhg/oHbKUUJRDxhUB6JgWGBmxWtXbmb526X7LXd04rZjwuQn
         JZDCxVwL2mfP6sUf+quSp/Xjj/Kq06HhXCyR/YnOdrpmRulmSYnHyl1P2RPAtVz9tiBa
         jz+EG4ZOKTjVfn5MbopWSzIM1ffIbeF5dEkiuDYejdBpsJ/pCVowgZSfj4lD/s2ynuvJ
         52qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717771137; x=1718375937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPY3kEn9dtxckyYDxTCJfVvE65ZOGNBoardFeiSOUO4=;
        b=rSRIKDDQ1lwM9qqnq2plryKJGKgfOCk/dkNtNuFoBG9gGl+3aUioM57H6D7wWKlh7J
         xS54KnjwU6uFu1df1Dsmu4Izxqs19fHAIJTgXR4XZXQgk/nhaNCn9ZqE26g1RC+Tj7B2
         1oiiQNrKiCVHScDHo1koFOPYI2V7JHbd1+BZklgPqYeNU4bkjdo/7TeXa6Jq3UAfiWvp
         hRl4A3k2ZN96lXwP7WQ46hdUWznGUpf6cElSEpNI/HUDy3PA3bx5pJHmv9ONSlkFdPaQ
         FbYG4gJN0RFxN5iTuuj3vbciVgQQ2ifAU/Xbl/1dO3FfaC674iGmRHkNr8qtIgcEz+si
         tp1w==
X-Forwarded-Encrypted: i=1; AJvYcCV4fEnW9V7deL5b5avvHuj6bd2w5a6lDiTRE8+0VS/T0tNXd05wkM3p5IjsyOh2BFTX7xZ9cjt35sqvh85w82CVnArUaDJE65WVx36j9g==
X-Gm-Message-State: AOJu0Yw98SVAannq4niVyQOPy7LVb355a3CDXWM83iPncpb2Pg9WOv5i
	m+BGktkMNWlO4Im0WNFrLL1V+7Z3AwBTcJYypo2iGp9ziSaojJQCNKwHXls/4a0EKPX7dRn1/3P
	wa9JCQqm0ny2xWoG6EM9QSwmXUtZyuFsL+y/o
X-Google-Smtp-Source: AGHT+IF9IGu66PpUZhf3pesqD1C7cZCpvg6vwgT7dOW1Z95P6GM8MHILMIrHEn4UXDxfXFqf7IuVk6prvEibZoqUPs8=
X-Received: by 2002:a25:84c7:0:b0:dfa:b64b:48a5 with SMTP id
 3f1490d57ef6-dfaf663bf34mr2482386276.19.1717771136602; Fri, 07 Jun 2024
 07:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com> <20240531163217.1584450-4-Liam.Howlett@oracle.com>
In-Reply-To: <20240531163217.1584450-4-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 7 Jun 2024 07:38:45 -0700
Message-ID: <CAJuCfpGxN6Py8zi9CveO+1xRaXd9+=sBFBjNPCjq=0wEmiHZ7A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] mm/mmap: Introduce vma_munmap_struct for use in
 munmap operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	sidhartha.kumar@oracle.com, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Use a structure to pass along all the necessary information and counters
> involved in removing vmas from the mm_struct.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/internal.h |  16 ++++++
>  mm/mmap.c     | 133 +++++++++++++++++++++++++++++---------------------
>  2 files changed, 94 insertions(+), 55 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index b2c75b12014e..6ebf77853d68 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1428,6 +1428,22 @@ struct vma_prepare {
>         struct vm_area_struct *remove2;
>  };
>
> +/*
> + * vma munmap operation
> + */
> +struct vma_munmap_struct {
> +       struct vma_iterator *vmi;
> +       struct mm_struct *mm;
> +       struct vm_area_struct *vma;     /* The first vma to munmap */
> +       struct list_head *uf;           /* Userfaultfd list_head */
> +       unsigned long start;            /* Aligned start addr */
> +       unsigned long end;              /* Aligned end addr */
> +       int vma_count;                  /* Number of vmas that will be re=
moved */
> +       unsigned long nr_pages;         /* Number of pages being removed =
*/
> +       unsigned long locked_vm;        /* Number of locked pages */
> +       bool unlock;                    /* Unlock after the munmap */
> +};
> +
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
>                                 unsigned long zone, int nid);
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index fad40d604c64..57f2383245ea 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -459,6 +459,31 @@ static inline void init_vma_prep(struct vma_prepare =
*vp,
>         init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
>  }
>
> +/*
> + * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> + * @vms: The vma munmap struct
> + * @vmi: The vma iterator
> + * @vma: The first vm_area_struct to munmap
> + * @start: The aligned start address to munmap
> + * @end: The aligned end address to munmap
> + * @uf: The userfaultfd list_head
> + * @unlock: Unlock after the operation.  Only unlocked on success
> + */
> +static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> +               struct vma_iterator *vmi, struct vm_area_struct *vma,
> +               unsigned long start, unsigned long end, struct list_head =
*uf,
> +               bool unlock)
> +{
> +       vms->vmi =3D vmi;
> +       vms->vma =3D vma;
> +       vms->mm =3D vma->vm_mm;
> +       vms->start =3D start;
> +       vms->end =3D end;
> +       vms->unlock =3D unlock;
> +       vms->uf =3D uf;
> +       vms->vma_count =3D 0;
> +       vms->nr_pages =3D vms->locked_vm =3D 0;
> +}
>
>  /*
>   * vma_prepare() - Helper function for handling locking VMAs prior to al=
tering
> @@ -2340,7 +2365,6 @@ static inline void remove_mt(struct mm_struct *mm, =
struct ma_state *mas)
>
>                 if (vma->vm_flags & VM_ACCOUNT)
>                         nr_accounted +=3D nrpages;
> -
>                 vm_stat_account(mm, vma->vm_flags, -nrpages);
>                 remove_vma(vma, false);
>         }
> @@ -2562,29 +2586,20 @@ static inline void abort_munmap_vmas(struct ma_st=
ate *mas_detach)
>  }
>
>  /*
> - * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple t=
ree
> + * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple t=
ree
>   * for removal at a later date.  Handles splitting first and last if nec=
essary
>   * and marking the vmas as isolated.
>   *
> - * @vmi: The vma iterator
> - * @vma: The starting vm_area_struct
> - * @mm: The mm_struct
> - * @start: The aligned start address to munmap.
> - * @end: The aligned end address to munmap.
> - * @uf: The userfaultfd list_head
> + * @vms: The vma munmap struct
>   * @mas_detach: The maple state tracking the detached tree
>   *
>   * Return: 0 on success
>   */
> -static int
> -vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
> -                   struct mm_struct *mm, unsigned long start,
> -                   unsigned long end, struct list_head *uf,
> -                   struct ma_state *mas_detach, unsigned long *locked_vm=
)
> +static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> +               struct ma_state *mas_detach)
>  {
>         struct vm_area_struct *next =3D NULL;
>         int error =3D -ENOMEM;
> -       int count =3D 0;
>
>         /*
>          * If we need to split any vma, do it now to save pain later.
> @@ -2595,17 +2610,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
>          */
>
>         /* Does it split the first one? */
> -       if (start > vma->vm_start) {
> +       if (vms->start > vms->vma->vm_start) {
>
>                 /*
>                  * Make sure that map_count on return from munmap() will
>                  * not exceed its limit; but let map_count go just above
>                  * its limit temporarily, to help free resources as expec=
ted.
>                  */
> -               if (end < vma->vm_end && mm->map_count >=3D sysctl_max_ma=
p_count)
> +               if (vms->end < vms->vma->vm_end &&
> +                   vms->mm->map_count >=3D sysctl_max_map_count)
>                         goto map_count_exceeded;
>
> -               error =3D __split_vma(vmi, vma, start, 1);
> +               error =3D __split_vma(vms->vmi, vms->vma, vms->start, 1);
>                 if (error)
>                         goto start_split_failed;
>         }
> @@ -2614,24 +2630,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
>          * Detach a range of VMAs from the mm. Using next as a temp varia=
ble as
>          * it is always overwritten.
>          */
> -       next =3D vma;
> +       next =3D vms->vma;
>         do {
>                 /* Does it split the end? */
> -               if (next->vm_end > end) {
> -                       error =3D __split_vma(vmi, next, end, 0);
> +               if (next->vm_end > vms->end) {
> +                       error =3D __split_vma(vms->vmi, next, vms->end, 0=
);
>                         if (error)
>                                 goto end_split_failed;
>                 }
>                 vma_start_write(next);
> -               mas_set(mas_detach, count++);
> +               mas_set(mas_detach, vms->vma_count++);
>                 if (next->vm_flags & VM_LOCKED)
> -                       *locked_vm +=3D vma_pages(next);
> +                       vms->locked_vm +=3D vma_pages(next);
>
>                 error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
>                 if (error)
>                         goto munmap_gather_failed;
>                 vma_mark_detached(next, true);
> -               if (unlikely(uf)) {
> +               if (unlikely(vms->uf)) {
>                         /*
>                          * If userfaultfd_unmap_prep returns an error the=
 vmas
>                          * will remain split, but userland will get a
> @@ -2641,16 +2657,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
>                          * split, despite we could. This is unlikely enou=
gh
>                          * failure that it's not worth optimizing it for.
>                          */
> -                       error =3D userfaultfd_unmap_prep(next, start, end=
, uf);
> +                       error =3D userfaultfd_unmap_prep(next, vms->start=
,
> +                                                      vms->end, vms->uf)=
;
>
>                         if (error)
>                                 goto userfaultfd_error;
>                 }
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> -               BUG_ON(next->vm_start < start);
> -               BUG_ON(next->vm_start > end);
> +               BUG_ON(next->vm_start < vms->start);
> +               BUG_ON(next->vm_start > vms->end);
>  #endif
> -       } for_each_vma_range(*vmi, next, end);
> +       } for_each_vma_range(*(vms->vmi), next, vms->end);
>
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>         /* Make sure no VMAs are about to be lost. */
> @@ -2659,21 +2676,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
>                 struct vm_area_struct *vma_mas, *vma_test;
>                 int test_count =3D 0;
>
> -               vma_iter_set(vmi, start);
> +               vma_iter_set(vms->vmi, vms->start);
>                 rcu_read_lock();
> -               vma_test =3D mas_find(&test, count - 1);
> -               for_each_vma_range(*vmi, vma_mas, end) {
> +               vma_test =3D mas_find(&test, vms->vma_count - 1);
> +               for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
>                         BUG_ON(vma_mas !=3D vma_test);
>                         test_count++;
> -                       vma_test =3D mas_next(&test, count - 1);
> +                       vma_test =3D mas_next(&test, vms->vma_count - 1);
>                 }
>                 rcu_read_unlock();
> -               BUG_ON(count !=3D test_count);
> +               BUG_ON(vms->vma_count !=3D test_count);
>         }
>  #endif
>
> -       while (vma_iter_addr(vmi) > start)
> -               vma_iter_prev_range(vmi);
> +       while (vma_iter_addr(vms->vmi) > vms->start)
> +               vma_iter_prev_range(vms->vmi);
>
>         return 0;
>
> @@ -2686,38 +2703,44 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
>         return error;
>  }
>
> -static void
> -vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct=
 *vma,
> -               struct mm_struct *mm, unsigned long start,
> -               unsigned long end, bool unlock, struct ma_state *mas_deta=
ch,
> -               unsigned long locked_vm)
> +/*
> + * vmi_complete_munmap_vmas() - Update mm counters, unlock if directed, =
and free
> + * all VMA resources.
> + *
> + * do_vmi_align_munmap() - munmap the aligned region from @start to @end=
.
> + * @vms: The vma munmap struct
> + * @mas_detach: The maple state of the detached vmas
> + *
> + */
> +static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> +               struct ma_state *mas_detach)
>  {
>         struct vm_area_struct *prev, *next;
> -       int count;
> +       struct mm_struct *mm;
>
> -       count =3D mas_detach->index + 1;
> -       mm->map_count -=3D count;
> -       mm->locked_vm -=3D locked_vm;
> -       if (unlock)
> +       mm =3D vms->mm;
> +       mm->map_count -=3D vms->vma_count;
> +       mm->locked_vm -=3D vms->locked_vm;
> +       if (vms->unlock)
>                 mmap_write_downgrade(mm);
>
> -       prev =3D vma_iter_prev_range(vmi);
> -       next =3D vma_next(vmi);
> +       prev =3D vma_iter_prev_range(vms->vmi);
> +       next =3D vma_next(vms->vmi);
>         if (next)
> -               vma_iter_prev_range(vmi);
> +               vma_iter_prev_range(vms->vmi);
>
>         /*
>          * We can free page tables without write-locking mmap_lock becaus=
e VMAs
>          * were isolated before we downgraded mmap_lock.
>          */
>         mas_set(mas_detach, 1);
> -       unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
> -                    !unlock);
> +       unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vm=
s->end,
> +                    vms->vma_count, !vms->unlock);
>         /* Statistics and freeing VMAs */
>         mas_set(mas_detach, 0);
>         remove_mt(mm, mas_detach);
>         validate_mm(mm);
> -       if (unlock)
> +       if (vms->unlock)
>                 mmap_read_unlock(mm);
>
>         __mt_destroy(mas_detach->tree);
> @@ -2746,11 +2769,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
>         MA_STATE(mas_detach, &mt_detach, 0, 0);
>         mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK=
_MASK);
>         mt_on_stack(mt_detach);
> +       struct vma_munmap_struct vms;
>         int error;
> -       unsigned long locked_vm =3D 0;
>
> -       error =3D vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
> -                                      &mas_detach, &locked_vm);
> +       init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
> +
> +       error =3D vms_gather_munmap_vmas(&vms, &mas_detach);
>         if (error)
>                 goto gather_failed;
>
> @@ -2758,8 +2782,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
>         if (error)
>                 goto clear_area_failed;
>
> -       vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_d=
etach,
> -                                locked_vm);
> +       vms_complete_munmap_vmas(&vms, &mas_detach);
>         return 0;
>
>  clear_area_failed:
> --
> 2.43.0
>

