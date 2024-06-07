Return-Path: <linux-fsdevel+bounces-21137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D718FF892
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495C7B212B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D060323AD;
	Fri,  7 Jun 2024 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n37H05bj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415A7E9
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719296; cv=none; b=cMpVDAQ3GjzOL7I7n1gIq7f1Rq9bki8Vj2vq2JSvIcErMoRO1tiyFrJdIdpGiptPV68iMthmkaTUp2DtFfPSc9fIIy9fM5urXx9+AT3hHUlSGIuQGAw9NitsgzI17JpZGWThHSU5fcJTfiB7sThHJFiByKZfHxzr4F/uQ/Eq2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719296; c=relaxed/simple;
	bh=ELaO09jTIhdzgXvmdO2g4ynqTY+hfPvxTzC9Nf1ua1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUwHGVikw3MUVNwFTyxdZKE1gJOqhlUTQbuKtrjVeALgiDgjGtXjyItOO6FySwAAK/UY1lONZug1d39mZLeDmYBi1V/lcTv+NlbCjJQETn/ZrrmdqI1w/xK0qSx04PRprGDN6G2rRLJmDWxgeqrZ3Ak+hjs4YTzqXZE3t3pcePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n37H05bj; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so1665374276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 17:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717719293; x=1718324093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eF3WC0S/6RgLrCcIQVGlYiaYG+UbXjTsmyozrkqgz8=;
        b=n37H05bjQsoXP+fkV2I10fesDdEmCmZXQeI04FG+th9i6KEFqrSi4OhtxmjfXfPfg/
         +tJppMBRxPh7ppBd13F31agt9JOoTKA/TmaBjapF6WLfOkFWawYQKefY1yAUuSYP5pJP
         8MS+h33OjdccnvvR/Mmc2LxQF4eubnDJclJoVkSbj8EHviloV5sj/0PR2r8qOK+24GqE
         FeQrhBcxlJGD1AmT0/8iURP/pa77Kh68SRqT3GBmJcNud8TfPhU9osrykztmLTo9W7Cp
         AYJ0bnZSuY6I041mVjqeOhP+Mpvp9M5OMBxXAKG8DHk+Fkc9ZlGuliDFms74rExJ9/r0
         z4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717719293; x=1718324093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eF3WC0S/6RgLrCcIQVGlYiaYG+UbXjTsmyozrkqgz8=;
        b=r5fnUZNwU+7focOowni6x7951RhyQ1W7oJMUx9YwIs78KuDc6FDVEMtSR85rHDvMf7
         1JGVGx9JCLm1IohCat/dra6VhCj/iBE2aBJ8l/FE7wiK81ipRxV6M+PGtj6V7Rg8Ozxx
         A4jpfapQ5R1GAvp1gzW8usjUfbqn4Hi9JGtg6i1w8kHjS0kE6fnxhXguNE56QTN9AItW
         7lOi4CrwFaVXpeZ4r/iDvUGdfkvmoIRRiTZKs9+aNIDnXTfdvOGm6P7OhdsW1Q9bWBkV
         BFCwW77Gg2Z039JZDrjA/evZzy4d8hoc19r83YjK+2W/P9PbdCaihsw6/bj57R8svosB
         DLGA==
X-Forwarded-Encrypted: i=1; AJvYcCVkbNvk7zNp1jPj/C739+VrtYsgVA2Tdba0wcj8jmkgUwRBAV0a1zlOir8+AwNEjMDawdDWDmlaGbUVBGoGQK+B8/8LITJkikk1R51gPQ==
X-Gm-Message-State: AOJu0YychQXrrXz8E6BOnHenwtyNHSv3p8k4rG0e7ys6ruT3h62BWG7s
	l4dUAvpzm7MlXf2Ebu5cJJ8GRshvZ9zzXLnZEE3xzN7OeEvVEs8kHoC/evn75xd1HiVj8wj3jsf
	ZqPt8IKESQa5vsdH1uEzWVMVIp90hl16i/dyV
X-Google-Smtp-Source: AGHT+IEdhMX0D8OjtW6dAblDMt6aDio5sK4QaHdcTMdMHidp0Gqnq5XSOtYVRNrhNlpXIlzh8dUCogC6KyQhG1f6eKA=
X-Received: by 2002:a25:ef50:0:b0:df1:ce95:5490 with SMTP id
 3f1490d57ef6-dfaf65c6857mr944656276.18.1717719293250; Thu, 06 Jun 2024
 17:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com> <20240531163217.1584450-3-Liam.Howlett@oracle.com>
In-Reply-To: <20240531163217.1584450-3-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 6 Jun 2024 17:14:40 -0700
Message-ID: <CAJuCfpFDW-=35GyRikn3-yZPPrKx_aFbaJj-yFqGut4dJfCsdw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] mm/mmap: Split do_vmi_align_munmap() into a
 gather and complete operation
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
> Split the munmap function into a gathering of vmas and a cleanup of the
> gathered vmas.  This is necessary for the later patches in the series.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

The refactoring looks correct but it's quite painful to verify all the
pieces. Not sure if it could have been refactored in more gradual
steps...

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/mmap.c | 143 ++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 101 insertions(+), 42 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 31d464e6a656..fad40d604c64 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2340,6 +2340,7 @@ static inline void remove_mt(struct mm_struct *mm, =
struct ma_state *mas)
>
>                 if (vma->vm_flags & VM_ACCOUNT)
>                         nr_accounted +=3D nrpages;
> +

nit: here and below a couple of unnecessary empty lines.

>                 vm_stat_account(mm, vma->vm_flags, -nrpages);
>                 remove_vma(vma, false);
>         }
> @@ -2545,33 +2546,45 @@ struct vm_area_struct *vma_merge_extend(struct vm=
a_iterator *vmi,
>                          vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  }
>
> +
> +static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> +{
> +       struct vm_area_struct *vma;
> +       int limit;
> +
> +       limit =3D mas_detach->index;
> +       mas_set(mas_detach, 0);
> +       /* Re-attach any detached VMAs */
> +       mas_for_each(mas_detach, vma, limit)
> +               vma_mark_detached(vma, false);
> +
> +       __mt_destroy(mas_detach->tree);
> +}
> +
>  /*
> - * do_vmi_align_munmap() - munmap the aligned region from @start to @end=
.
> + * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple t=
ree
> + * for removal at a later date.  Handles splitting first and last if nec=
essary
> + * and marking the vmas as isolated.
> + *
>   * @vmi: The vma iterator
>   * @vma: The starting vm_area_struct
>   * @mm: The mm_struct
>   * @start: The aligned start address to munmap.
>   * @end: The aligned end address to munmap.
>   * @uf: The userfaultfd list_head
> - * @unlock: Set to true to drop the mmap_lock.  unlocking only happens o=
n
> - * success.
> + * @mas_detach: The maple state tracking the detached tree
>   *
> - * Return: 0 on success and drops the lock if so directed, error and lea=
ves the
> - * lock held otherwise.
> + * Return: 0 on success
>   */
>  static int
> -do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
> +vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
>                     struct mm_struct *mm, unsigned long start,
> -                   unsigned long end, struct list_head *uf, bool unlock)
> +                   unsigned long end, struct list_head *uf,
> +                   struct ma_state *mas_detach, unsigned long *locked_vm=
)
>  {
> -       struct vm_area_struct *prev, *next =3D NULL;
> -       struct maple_tree mt_detach;
> -       int count =3D 0;
> +       struct vm_area_struct *next =3D NULL;
>         int error =3D -ENOMEM;
> -       unsigned long locked_vm =3D 0;
> -       MA_STATE(mas_detach, &mt_detach, 0, 0);
> -       mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK=
_MASK);
> -       mt_on_stack(mt_detach);
> +       int count =3D 0;
>
>         /*
>          * If we need to split any vma, do it now to save pain later.
> @@ -2610,15 +2623,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
>                                 goto end_split_failed;
>                 }
>                 vma_start_write(next);
> -               mas_set(&mas_detach, count);
> -               error =3D mas_store_gfp(&mas_detach, next, GFP_KERNEL);
> +               mas_set(mas_detach, count++);
> +               if (next->vm_flags & VM_LOCKED)
> +                       *locked_vm +=3D vma_pages(next);
> +
> +               error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
>                 if (error)
>                         goto munmap_gather_failed;
>                 vma_mark_detached(next, true);
> -               if (next->vm_flags & VM_LOCKED)
> -                       locked_vm +=3D vma_pages(next);
> -
> -               count++;
>                 if (unlikely(uf)) {
>                         /*
>                          * If userfaultfd_unmap_prep returns an error the=
 vmas
> @@ -2643,7 +2655,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>         /* Make sure no VMAs are about to be lost. */
>         {
> -               MA_STATE(test, &mt_detach, 0, 0);
> +               MA_STATE(test, mas_detach->tree, 0, 0);
>                 struct vm_area_struct *vma_mas, *vma_test;
>                 int test_count =3D 0;
>
> @@ -2663,13 +2675,29 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
>         while (vma_iter_addr(vmi) > start)
>                 vma_iter_prev_range(vmi);
>
> -       error =3D vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
> -       if (error)
> -               goto clear_tree_failed;
> +       return 0;
>
> -       /* Point of no return */
> -       mm->locked_vm -=3D locked_vm;
> +userfaultfd_error:
> +munmap_gather_failed:
> +end_split_failed:
> +       abort_munmap_vmas(mas_detach);
> +start_split_failed:
> +map_count_exceeded:
> +       return error;
> +}
> +
> +static void
> +vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct=
 *vma,
> +               struct mm_struct *mm, unsigned long start,
> +               unsigned long end, bool unlock, struct ma_state *mas_deta=
ch,
> +               unsigned long locked_vm)
> +{
> +       struct vm_area_struct *prev, *next;
> +       int count;
> +
> +       count =3D mas_detach->index + 1;
>         mm->map_count -=3D count;
> +       mm->locked_vm -=3D locked_vm;
>         if (unlock)
>                 mmap_write_downgrade(mm);
>
> @@ -2682,30 +2710,61 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
>          * We can free page tables without write-locking mmap_lock becaus=
e VMAs
>          * were isolated before we downgraded mmap_lock.
>          */
> -       mas_set(&mas_detach, 1);
> -       unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
> +       mas_set(mas_detach, 1);
> +       unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
>                      !unlock);
>         /* Statistics and freeing VMAs */
> -       mas_set(&mas_detach, 0);
> -       remove_mt(mm, &mas_detach);
> +       mas_set(mas_detach, 0);
> +       remove_mt(mm, mas_detach);
>         validate_mm(mm);
>         if (unlock)
>                 mmap_read_unlock(mm);
>
> -       __mt_destroy(&mt_detach);
> -       return 0;
> +       __mt_destroy(mas_detach->tree);
> +}
>
> -clear_tree_failed:
> -userfaultfd_error:
> -munmap_gather_failed:
> -end_split_failed:
> -       mas_set(&mas_detach, 0);
> -       mas_for_each(&mas_detach, next, end)
> -               vma_mark_detached(next, false);
> +/*
> + * do_vmi_align_munmap() - munmap the aligned region from @start to @end=
.
> + * @vmi: The vma iterator
> + * @vma: The starting vm_area_struct
> + * @mm: The mm_struct
> + * @start: The aligned start address to munmap.
> + * @end: The aligned end address to munmap.
> + * @uf: The userfaultfd list_head
> + * @unlock: Set to true to drop the mmap_lock.  unlocking only happens o=
n
> + * success.
> + *
> + * Return: 0 on success and drops the lock if so directed, error and lea=
ves the
> + * lock held otherwise.
> + */
> +static int
> +do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
> +                   struct mm_struct *mm, unsigned long start,
> +                   unsigned long end, struct list_head *uf, bool unlock)
> +{
> +       struct maple_tree mt_detach;
> +       MA_STATE(mas_detach, &mt_detach, 0, 0);
> +       mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK=
_MASK);
> +       mt_on_stack(mt_detach);
> +       int error;
> +       unsigned long locked_vm =3D 0;
>
> -       __mt_destroy(&mt_detach);
> -start_split_failed:
> -map_count_exceeded:
> +       error =3D vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
> +                                      &mas_detach, &locked_vm);
> +       if (error)
> +               goto gather_failed;
> +
> +       error =3D vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
> +       if (error)
> +               goto clear_area_failed;
> +
> +       vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_d=
etach,
> +                                locked_vm);
> +       return 0;
> +
> +clear_area_failed:
> +       abort_munmap_vmas(&mas_detach);
> +gather_failed:
>         validate_mm(mm);
>         return error;
>  }
> --
> 2.43.0
>

