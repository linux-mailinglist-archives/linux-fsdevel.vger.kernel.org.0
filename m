Return-Path: <linux-fsdevel+bounces-47549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A94DA9FDC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 01:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A01A87CA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4D214237;
	Mon, 28 Apr 2025 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxntzCnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F93211C
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883083; cv=none; b=TFL9SIQFbI/epgICbEla2Qa6ZIkql6OlQLSpMgG1YAHXqtqPLA5U2FynKxS/JpwnSXBLpNz6jUl+2FfvjL/Q87KZgRD8obmzCwq+NEGgrb8eXlz0GdyJj4AuRRCYTciJoMfnsIT/iMrZNeJtLJZh2Ss4EyKI3BI8kOhUtlXaL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883083; c=relaxed/simple;
	bh=hivJJdNSuYC7mCccnoqPbjdgxYkz4LlEJFiA0SuUfJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bpXTa7K5ssq9CJSDdqDeJ9c/lS8Zkce95VoYcIrhhZ+p3mFKnHyPrIeiAq4Z079VWdGYO5B0GzQGCu6y334Y8T3+74HzyLZctItFslw5V1qguHfG2Ez4MSgyssFdCH089x18m3ibkT+kJ1g/1Y8USy9jURgdtpeLdWVl3esXtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxntzCnd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47e9fea29easo32201cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745883078; x=1746487878; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcYkHq3j2F3qtaXjRAwMQfG11dqlXUytxmFErxv2ZvA=;
        b=oxntzCndhYDvOO9yfcByArv2PTha+lTRCHpTW2yPbZOV/XUjeVbPFgsUeduGS0nZ3L
         Z61YBhZntjIUucjw5g8tQbrbIdoDNW6NN822bxUHgTPZJ4UImUBkqIFifmhDT88ysTZR
         2VjMEWi+Kd2RXK9ZMB9p75sSWlobfTMoYqtYWOPL0L9mYSatqRYlfYG5gdWQUQmjVhWw
         gTLvE4yxeOdEVvSz8/cRm+lV1PTMWv17VufVRQrr/m30JKzNBwZD+JWnTbB3YVoVtfnd
         zpRUzeaWycmgIUduNp9ENhgRQEepRZMZEShrbdJTJtruVo8paSTA2jsVRXGhcu5b8FBK
         NGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745883078; x=1746487878;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcYkHq3j2F3qtaXjRAwMQfG11dqlXUytxmFErxv2ZvA=;
        b=RvnHPxgUqMJx+NHMQu6RJA7tfN4YJYtzOtyqyl42yfzH32WMUXxOTruxU8dWAg/F70
         P36Hy6ykSOo/jARl2Q8B16SmtwUjFxfL0BDkMCJoamj8aKQuGKQuKC/79b20xXATHiyh
         f0jH0rch7MHhjK6chUZsy3Ai5lC1FZsSN9a6eA0R++FD46JFL+Fnuxkac+tC2dGnjx1H
         O8mM2mIJIB+JA2wnsieB58387UKnSuwChZj+DNFZyREEeC509/IMZ0b3LR+VdxDZzhPm
         pcZ4Bfh93D44Z/dUVkS5cLxnwPQjeMyv3gN2j5SVtwb900AxQWZDP6yeg98AjXug/Qnn
         z85A==
X-Forwarded-Encrypted: i=1; AJvYcCUR9rQkScCkJau5AYyEQGHuXJbeLk6IzNKuDjdbG8gK0+T5uRFvW4sxYMV3tJ9AO5hje15V/P2u20JAeQIp@vger.kernel.org
X-Gm-Message-State: AOJu0YwWoeUFBjhceJxxU8vx27nWM2HIwNSuN4Nx1yC2/TEexslhq/WL
	fEAjF5T1sMnihrR3NDCyBP47zoDLEKqvWHs10FQ3V18rOZpvqGd9FZwv6dvn6QpoRPPffR+lnXU
	Zus+/D3xb+eJy2OaNWdg7Gfp510fTLTSesH6i
X-Gm-Gg: ASbGncvrcCTYHbYuXIHFcYehA1nnHboBpmJtAEUNiqLhUGIZrbu8yawmnbKjkk2IreI
	W79LZCCN06gcHBTBBayIRhPzFHqlU3mYteOO+us5zq4BD/SpuV5je0440lkIRw/gONdo+FFt1HN
	+74U8zvb4KcRV+8vbRR4hJxhS4jgvEDIs=
X-Google-Smtp-Source: AGHT+IGdzui/r6+AKII6O9xA+IdFvn5VRyjmpgIeXeHoD8o5xBCCKwyUmLCqTlyTOT6zf6tAdRMTkyBWLTLm/uhfkxk=
X-Received: by 2002:a05:622a:453:b0:486:c718:1578 with SMTP id
 d75a77b69052e-4885f13f418mr1783741cf.22.1745883078151; Mon, 28 Apr 2025
 16:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
 <gd3dcjrc47stimsmpcln3s6tu7vrhmccu5mej3jmfhsbp32hg7@5ffby6k5rcfp>
In-Reply-To: <gd3dcjrc47stimsmpcln3s6tu7vrhmccu5mej3jmfhsbp32hg7@5ffby6k5rcfp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Apr 2025 16:31:07 -0700
X-Gm-Features: ATxdqUEaoJAAqWYGFwAmXdRfWVotqyD0Yj7Ng6zcKMRKXHlEEdELj5fXjr3M2-Q
Message-ID: <CAJuCfpGOLgMTTToug4kcGCw29dQJjWQ0OXU8Mpfoo_3NEPUZng@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: move dup_mmap() to mm
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:13=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> > This is a key step in our being able to abstract and isolate VMA alloca=
tion
> > and destruction logic.
> >
> > This function is the last one where vm_area_free() and vm_area_dup() ar=
e
> > directly referenced outside of mmap, so having this in mm allows us to
> > isolate these.
> >
> > We do the same for the nommu version which is substantially simpler.
> >
> > We place the declaration for dup_mmap() in mm/internal.h and have
> > kernel/fork.c import this in order to prevent improper use of this
> > functionality elsewhere in the kernel.
> >
> > While we're here, we remove the useless #ifdef CONFIG_MMU check around
> > mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
> > CONFIG_MMU is set.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Suggested-by: Pedro Falcato <pfalcato@suse.de>
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  kernel/fork.c | 189 ++------------------------------------------------
> >  mm/internal.h |   2 +
> >  mm/mmap.c     | 181 +++++++++++++++++++++++++++++++++++++++++++++--
> >  mm/nommu.c    |   8 +++
> >  4 files changed, 189 insertions(+), 191 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 168681fc4b25..ac9f9267a473 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -112,6 +112,9 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> >
> > +/* For dup_mmap(). */
> > +#include "../mm/internal.h"
> > +
> >  #include <trace/events/sched.h>
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -589,7 +592,7 @@ void free_task(struct task_struct *tsk)
> >  }
> >  EXPORT_SYMBOL(free_task);
> >
> > -static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *ol=
dmm)
> > +void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
> >  {
> >       struct file *exe_file;
> >
> > @@ -604,183 +607,6 @@ static void dup_mm_exe_file(struct mm_struct *mm,=
 struct mm_struct *oldmm)
> >  }
> >
> >  #ifdef CONFIG_MMU
> > -static __latent_entropy int dup_mmap(struct mm_struct *mm,
> > -                                     struct mm_struct *oldmm)
> > -{
> > -     struct vm_area_struct *mpnt, *tmp;
> > -     int retval;
> > -     unsigned long charge =3D 0;
> > -     LIST_HEAD(uf);
> > -     VMA_ITERATOR(vmi, mm, 0);
> > -
> > -     if (mmap_write_lock_killable(oldmm))
> > -             return -EINTR;
> > -     flush_cache_dup_mm(oldmm);
> > -     uprobe_dup_mmap(oldmm, mm);
> > -     /*
> > -      * Not linked in yet - no deadlock potential:
> > -      */
> > -     mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
> > -
> > -     /* No ordering required: file already has been exposed. */
> > -     dup_mm_exe_file(mm, oldmm);
> > -
> > -     mm->total_vm =3D oldmm->total_vm;
> > -     mm->data_vm =3D oldmm->data_vm;
> > -     mm->exec_vm =3D oldmm->exec_vm;
> > -     mm->stack_vm =3D oldmm->stack_vm;
> > -
> > -     /* Use __mt_dup() to efficiently build an identical maple tree. *=
/
> > -     retval =3D __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> > -     if (unlikely(retval))
> > -             goto out;
> > -
> > -     mt_clear_in_rcu(vmi.mas.tree);
> > -     for_each_vma(vmi, mpnt) {
> > -             struct file *file;
> > -
> > -             vma_start_write(mpnt);
> > -             if (mpnt->vm_flags & VM_DONTCOPY) {
> > -                     retval =3D vma_iter_clear_gfp(&vmi, mpnt->vm_star=
t,
> > -                                                 mpnt->vm_end, GFP_KER=
NEL);
> > -                     if (retval)
> > -                             goto loop_out;
> > -
> > -                     vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mp=
nt));
> > -                     continue;
> > -             }
> > -             charge =3D 0;
> > -             /*
> > -              * Don't duplicate many vmas if we've been oom-killed (fo=
r
> > -              * example)
> > -              */
> > -             if (fatal_signal_pending(current)) {
> > -                     retval =3D -EINTR;
> > -                     goto loop_out;
> > -             }
> > -             if (mpnt->vm_flags & VM_ACCOUNT) {
> > -                     unsigned long len =3D vma_pages(mpnt);
> > -
> > -                     if (security_vm_enough_memory_mm(oldmm, len)) /* =
sic */
> > -                             goto fail_nomem;
> > -                     charge =3D len;
> > -             }
> > -             tmp =3D vm_area_dup(mpnt);
> > -             if (!tmp)
> > -                     goto fail_nomem;
> > -
> > -             /* track_pfn_copy() will later take care of copying inter=
nal state. */
> > -             if (unlikely(tmp->vm_flags & VM_PFNMAP))
> > -                     untrack_pfn_clear(tmp);
> > -
> > -             retval =3D vma_dup_policy(mpnt, tmp);
> > -             if (retval)
> > -                     goto fail_nomem_policy;
> > -             tmp->vm_mm =3D mm;
> > -             retval =3D dup_userfaultfd(tmp, &uf);
> > -             if (retval)
> > -                     goto fail_nomem_anon_vma_fork;
> > -             if (tmp->vm_flags & VM_WIPEONFORK) {
> > -                     /*
> > -                      * VM_WIPEONFORK gets a clean slate in the child.
> > -                      * Don't prepare anon_vma until fault since we do=
n't
> > -                      * copy page for current vma.
> > -                      */
> > -                     tmp->anon_vma =3D NULL;
> > -             } else if (anon_vma_fork(tmp, mpnt))
> > -                     goto fail_nomem_anon_vma_fork;
> > -             vm_flags_clear(tmp, VM_LOCKED_MASK);
> > -             /*
> > -              * Copy/update hugetlb private vma information.
> > -              */
> > -             if (is_vm_hugetlb_page(tmp))
> > -                     hugetlb_dup_vma_private(tmp);
> > -
> > -             /*
> > -              * Link the vma into the MT. After using __mt_dup(), memo=
ry
> > -              * allocation is not necessary here, so it cannot fail.
> > -              */
> > -             vma_iter_bulk_store(&vmi, tmp);
> > -
> > -             mm->map_count++;
> > -
> > -             if (tmp->vm_ops && tmp->vm_ops->open)
> > -                     tmp->vm_ops->open(tmp);
> > -
> > -             file =3D tmp->vm_file;
> > -             if (file) {
> > -                     struct address_space *mapping =3D file->f_mapping=
;
> > -
> > -                     get_file(file);
> > -                     i_mmap_lock_write(mapping);
> > -                     if (vma_is_shared_maywrite(tmp))
> > -                             mapping_allow_writable(mapping);
> > -                     flush_dcache_mmap_lock(mapping);
> > -                     /* insert tmp into the share list, just after mpn=
t */
> > -                     vma_interval_tree_insert_after(tmp, mpnt,
> > -                                     &mapping->i_mmap);
> > -                     flush_dcache_mmap_unlock(mapping);
> > -                     i_mmap_unlock_write(mapping);
> > -             }
> > -
> > -             if (!(tmp->vm_flags & VM_WIPEONFORK))
> > -                     retval =3D copy_page_range(tmp, mpnt);
> > -
> > -             if (retval) {
> > -                     mpnt =3D vma_next(&vmi);
> > -                     goto loop_out;
> > -             }
> > -     }
> > -     /* a new mm has just been created */
> > -     retval =3D arch_dup_mmap(oldmm, mm);
> > -loop_out:
> > -     vma_iter_free(&vmi);
> > -     if (!retval) {
> > -             mt_set_in_rcu(vmi.mas.tree);
> > -             ksm_fork(mm, oldmm);
> > -             khugepaged_fork(mm, oldmm);
> > -     } else {
> > -
> > -             /*
> > -              * The entire maple tree has already been duplicated. If =
the
> > -              * mmap duplication fails, mark the failure point with
> > -              * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encou=
ntered,
> > -              * stop releasing VMAs that have not been duplicated afte=
r this
> > -              * point.
> > -              */
> > -             if (mpnt) {
> > -                     mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_=
end - 1);
> > -                     mas_store(&vmi.mas, XA_ZERO_ENTRY);
> > -                     /* Avoid OOM iterating a broken tree */
> > -                     set_bit(MMF_OOM_SKIP, &mm->flags);
> > -             }
> > -             /*
> > -              * The mm_struct is going to exit, but the locks will be =
dropped
> > -              * first.  Set the mm_struct as unstable is advisable as =
it is
> > -              * not fully initialised.
> > -              */
> > -             set_bit(MMF_UNSTABLE, &mm->flags);
> > -     }
> > -out:
> > -     mmap_write_unlock(mm);
> > -     flush_tlb_mm(oldmm);
> > -     mmap_write_unlock(oldmm);
> > -     if (!retval)
> > -             dup_userfaultfd_complete(&uf);
> > -     else
> > -             dup_userfaultfd_fail(&uf);
> > -     return retval;
> > -
> > -fail_nomem_anon_vma_fork:
> > -     mpol_put(vma_policy(tmp));
> > -fail_nomem_policy:
> > -     vm_area_free(tmp);
> > -fail_nomem:
> > -     retval =3D -ENOMEM;
> > -     vm_unacct_memory(charge);
> > -     goto loop_out;
> > -}
> > -
> >  static inline int mm_alloc_pgd(struct mm_struct *mm)
> >  {
> >       mm->pgd =3D pgd_alloc(mm);
> > @@ -794,13 +620,6 @@ static inline void mm_free_pgd(struct mm_struct *m=
m)
> >       pgd_free(mm, mm->pgd);
> >  }
> >  #else
> > -static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> > -{
> > -     mmap_write_lock(oldmm);
> > -     dup_mm_exe_file(mm, oldmm);
> > -     mmap_write_unlock(oldmm);
> > -     return 0;
> > -}
> >  #define mm_alloc_pgd(mm)     (0)
> >  #define mm_free_pgd(mm)
> >  #endif /* CONFIG_MMU */
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 40464f755092..b3e011976f74 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1631,5 +1631,7 @@ static inline bool reclaim_pt_is_enabled(unsigned=
 long start, unsigned long end,
> >  }
> >  #endif /* CONFIG_PT_RECLAIM */
> >
> > +void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
> > +int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
> >
> >  #endif       /* __MM_INTERNAL_H */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 9e09eac0021c..5259df031e15 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1675,7 +1675,6 @@ static int __meminit init_reserve_notifier(void)
> >  }
> >  subsys_initcall(init_reserve_notifier);
> >
> > -#ifdef CONFIG_MMU
> >  /*
> >   * Obtain a read lock on mm->mmap_lock, if the specified address is be=
low the
> >   * start of the VMA, the intent is to perform a write, and it is a
> > @@ -1719,10 +1718,180 @@ bool mmap_read_lock_maybe_expand(struct mm_str=
uct *mm,
> >       mmap_write_downgrade(mm);
> >       return true;
> >  }
> > -#else
> > -bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_=
struct *vma,
> > -                              unsigned long addr, bool write)
> > +
> > +__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *=
oldmm)
> >  {
> > -     return false;
> > +     struct vm_area_struct *mpnt, *tmp;
> > +     int retval;
> > +     unsigned long charge =3D 0;
> > +     LIST_HEAD(uf);
> > +     VMA_ITERATOR(vmi, mm, 0);
> > +
> > +     if (mmap_write_lock_killable(oldmm))
> > +             return -EINTR;
> > +     flush_cache_dup_mm(oldmm);
> > +     uprobe_dup_mmap(oldmm, mm);
> > +     /*
> > +      * Not linked in yet - no deadlock potential:
> > +      */
> > +     mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
> > +
> > +     /* No ordering required: file already has been exposed. */
> > +     dup_mm_exe_file(mm, oldmm);
> > +
> > +     mm->total_vm =3D oldmm->total_vm;
> > +     mm->data_vm =3D oldmm->data_vm;
> > +     mm->exec_vm =3D oldmm->exec_vm;
> > +     mm->stack_vm =3D oldmm->stack_vm;
> > +
> > +     /* Use __mt_dup() to efficiently build an identical maple tree. *=
/
> > +     retval =3D __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> > +     if (unlikely(retval))
> > +             goto out;
> > +
> > +     mt_clear_in_rcu(vmi.mas.tree);
> > +     for_each_vma(vmi, mpnt) {
> > +             struct file *file;
> > +
> > +             vma_start_write(mpnt);
> > +             if (mpnt->vm_flags & VM_DONTCOPY) {
> > +                     retval =3D vma_iter_clear_gfp(&vmi, mpnt->vm_star=
t,
> > +                                                 mpnt->vm_end, GFP_KER=
NEL);
> > +                     if (retval)
> > +                             goto loop_out;
> > +
> > +                     vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mp=
nt));
> > +                     continue;
> > +             }
> > +             charge =3D 0;
> > +             /*
> > +              * Don't duplicate many vmas if we've been oom-killed (fo=
r
> > +              * example)
> > +              */
> > +             if (fatal_signal_pending(current)) {
> > +                     retval =3D -EINTR;
> > +                     goto loop_out;
> > +             }
> > +             if (mpnt->vm_flags & VM_ACCOUNT) {
> > +                     unsigned long len =3D vma_pages(mpnt);
> > +
> > +                     if (security_vm_enough_memory_mm(oldmm, len)) /* =
sic */
> > +                             goto fail_nomem;
> > +                     charge =3D len;
> > +             }
> > +
> > +             tmp =3D vm_area_dup(mpnt);
> > +             if (!tmp)
> > +                     goto fail_nomem;
> > +
> > +             /* track_pfn_copy() will later take care of copying inter=
nal state. */
> > +             if (unlikely(tmp->vm_flags & VM_PFNMAP))
> > +                     untrack_pfn_clear(tmp);
> > +
> > +             retval =3D vma_dup_policy(mpnt, tmp);
> > +             if (retval)
> > +                     goto fail_nomem_policy;
> > +             tmp->vm_mm =3D mm;
> > +             retval =3D dup_userfaultfd(tmp, &uf);
> > +             if (retval)
> > +                     goto fail_nomem_anon_vma_fork;
> > +             if (tmp->vm_flags & VM_WIPEONFORK) {
> > +                     /*
> > +                      * VM_WIPEONFORK gets a clean slate in the child.
> > +                      * Don't prepare anon_vma until fault since we do=
n't
> > +                      * copy page for current vma.
> > +                      */
> > +                     tmp->anon_vma =3D NULL;
> > +             } else if (anon_vma_fork(tmp, mpnt))
> > +                     goto fail_nomem_anon_vma_fork;
> > +             vm_flags_clear(tmp, VM_LOCKED_MASK);
> > +             /*
> > +              * Copy/update hugetlb private vma information.
> > +              */
> > +             if (is_vm_hugetlb_page(tmp))
> > +                     hugetlb_dup_vma_private(tmp);
> > +
> > +             /*
> > +              * Link the vma into the MT. After using __mt_dup(), memo=
ry
> > +              * allocation is not necessary here, so it cannot fail.
> > +              */
> > +             vma_iter_bulk_store(&vmi, tmp);
> > +
> > +             mm->map_count++;
> > +
> > +             if (tmp->vm_ops && tmp->vm_ops->open)
> > +                     tmp->vm_ops->open(tmp);
> > +
> > +             file =3D tmp->vm_file;
> > +             if (file) {
> > +                     struct address_space *mapping =3D file->f_mapping=
;
> > +
> > +                     get_file(file);
> > +                     i_mmap_lock_write(mapping);
> > +                     if (vma_is_shared_maywrite(tmp))
> > +                             mapping_allow_writable(mapping);
> > +                     flush_dcache_mmap_lock(mapping);
> > +                     /* insert tmp into the share list, just after mpn=
t */
> > +                     vma_interval_tree_insert_after(tmp, mpnt,
> > +                                     &mapping->i_mmap);
> > +                     flush_dcache_mmap_unlock(mapping);
> > +                     i_mmap_unlock_write(mapping);
> > +             }
> > +
> > +             if (!(tmp->vm_flags & VM_WIPEONFORK))
> > +                     retval =3D copy_page_range(tmp, mpnt);
> > +
> > +             if (retval) {
> > +                     mpnt =3D vma_next(&vmi);
> > +                     goto loop_out;
> > +             }
> > +     }
> > +     /* a new mm has just been created */
> > +     retval =3D arch_dup_mmap(oldmm, mm);
> > +loop_out:
> > +     vma_iter_free(&vmi);
> > +     if (!retval) {
> > +             mt_set_in_rcu(vmi.mas.tree);
> > +             ksm_fork(mm, oldmm);
> > +             khugepaged_fork(mm, oldmm);
> > +     } else {
> > +
> > +             /*
> > +              * The entire maple tree has already been duplicated. If =
the
> > +              * mmap duplication fails, mark the failure point with
> > +              * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encou=
ntered,
> > +              * stop releasing VMAs that have not been duplicated afte=
r this
> > +              * point.
> > +              */
> > +             if (mpnt) {
> > +                     mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_=
end - 1);
> > +                     mas_store(&vmi.mas, XA_ZERO_ENTRY);
> > +                     /* Avoid OOM iterating a broken tree */
> > +                     set_bit(MMF_OOM_SKIP, &mm->flags);
> > +             }
> > +             /*
> > +              * The mm_struct is going to exit, but the locks will be =
dropped
> > +              * first.  Set the mm_struct as unstable is advisable as =
it is
> > +              * not fully initialised.
> > +              */
> > +             set_bit(MMF_UNSTABLE, &mm->flags);
> > +     }
> > +out:
> > +     mmap_write_unlock(mm);
> > +     flush_tlb_mm(oldmm);
> > +     mmap_write_unlock(oldmm);
> > +     if (!retval)
> > +             dup_userfaultfd_complete(&uf);
> > +     else
> > +             dup_userfaultfd_fail(&uf);
> > +     return retval;
> > +
> > +fail_nomem_anon_vma_fork:
> > +     mpol_put(vma_policy(tmp));
> > +fail_nomem_policy:
> > +     vm_area_free(tmp);
> > +fail_nomem:
> > +     retval =3D -ENOMEM;
> > +     vm_unacct_memory(charge);
> > +     goto loop_out;
> >  }
> > -#endif
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 2b4d304c6445..a142fc258d39 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -1874,3 +1874,11 @@ static int __meminit init_admin_reserve(void)
> >       return 0;
> >  }
> >  subsys_initcall(init_admin_reserve);
> > +
> > +int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> > +{
> > +     mmap_write_lock(oldmm);
> > +     dup_mm_exe_file(mm, oldmm);
> > +     mmap_write_unlock(oldmm);
> > +     return 0;
> > +}
> > --
> > 2.49.0
> >

