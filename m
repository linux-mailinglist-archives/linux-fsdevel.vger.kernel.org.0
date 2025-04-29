Return-Path: <linux-fsdevel+bounces-47605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC2AA1000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2F3ACA5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844121CA1F;
	Tue, 29 Apr 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xswc4706"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FA15ECD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939109; cv=none; b=TRK1LaC1bra4wb8BEJUe0RXjACLz57s7YA7ADaAVwdI8URcJWoX5ITscZHZ3TiPwY05C2gCweHjZ++rD48Q0nMvuaX7/mvpkzw1EedeR+q36Aqs3baMb5CoZdNSJ1qqWFeaFrJXO6jp5l9HR/9pBqM9hjHTicN+GsumNME0ae5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939109; c=relaxed/simple;
	bh=V9jISFRsDnTmJar3UM8jrF85o24luU/gMCpoQG9OoRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti41vOKCvs+qgGq2SwgvPzaZKPhgE1aJyHwW8LCEikEcOttBjb0mTe+JggiiJGCDQUeuLy+gQ3OsVvNIRuKMX2GUg8i7/xMgAKAAhwX5QA9Nr9Hw1MXcfvMHowyLJjjEb2qif06h5W2MeZ7aVRdY/KJZCde544rTip1HWqPWE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xswc4706; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47e9fea29easo22801cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745939106; x=1746543906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5PLplhwbVQl4631wuVKHedXp4g1kB8+Ot5uuPMeXQU=;
        b=Xswc4706lrNyW3u/MDUW1RWRwb2dOz6kKsR66NlyDfnebbzlN6+lP0i9ltk14RNTsV
         SB+4lP7xZ1bosnbS65Ca9S86sWqPhz5vrusY6f5JJOMtRMlezKh803vnlD8VBjftGYdV
         P2C4jpPoTxZXz8ZlnScqzHGMUrQ6XW4CODMrjWJTwgw+vnJrE8tA9TsgiJ3bUEpyRWDx
         3fcIsmCf3Y9eEZEPva8u2GeEGQ1KrREsySEVAZJaIdS+kNsgtqANaU8aIn1vyfw9se9F
         0PCcvY1NdQkwpGMKIisZFZdFqcHocyZg2gPWOUxaEznHtf47UouemsNrRTQrxjX4utD9
         l3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745939106; x=1746543906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5PLplhwbVQl4631wuVKHedXp4g1kB8+Ot5uuPMeXQU=;
        b=F4WMmK5lk7HNTmZO8EE+unUaCdH2M5Wc5DthsDu9stvn2VkT4lAYmyC6glEtVTK6cJ
         UOVayp8JSQ0ycfXDp4bnG+myDrmmP6HbposrEVxvqAZXA4JGTbcf7gQnAmfD+mnO6DXH
         w9//Q/hWnYjAdpddzuz4ZBdJIZFJkHREYIxX48c6Qk1AbdTfv2T97L+lFCDwb3EiIbGK
         L1YKxXNWez8xl1e18LV2xliIiOd1viqSnWse4BF2fN6Zj8Mk+gfqBoJOxdBlIanVN/Kl
         YaryhVHFIe/apJ4cQFX34sftN+YoKdvJmlam9kSwleDsSDe0glB0LLpVqNLlr4BNKZQ4
         +4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXE7haL8Q1p3cK/VWW/hb6pibvn/i0LKVzHQ8tWCFp4ija/uPWT7FDOejNKSAfnhjaW9mLijiAM/Q6xuCqw@vger.kernel.org
X-Gm-Message-State: AOJu0YwU1qez+BXgLdw3dX7e7PLJwTQYLuNsR8VBcuIveVR79h+Hd7nP
	6aea3BgsB2xvnYTtTxXDPADVf8+p2kEqfX81ykLFmp2baKkmohBKR83yGD0H5PNrFCsJclrts1P
	GgNb0gSf8GpPSqFeuy7eKny+80/rl9vKsJY+u
X-Gm-Gg: ASbGncu3/yXjpN3EmEiHtebXyzs9tWpK/Gh0amiNOBmRBCCJKDu0HZp2EDaR+ydJpFH
	9ogsGl9B4s4+RjVFgtCdq66MHgOSfMcVtDQdzBWMNJxA2mGR2M7mSF/gAnVh3rIMVguBcqkZebT
	zy+il0j7hNp+gpytzlwjL0Qx4+t5l8xOQyrYd5AXfcLEJOmPvNf2FH
X-Google-Smtp-Source: AGHT+IEzSMqjc1/18Wz/pPdGccuyiVdsR8DABhYiDqN/Ln4JV426FgJZ6Mqifg77mRF92RTUgexpZZdjoMdUIr4ZQJs=
X-Received: by 2002:a05:622a:1822:b0:47e:ad75:c1a7 with SMTP id
 d75a77b69052e-4885f13f423mr5052021cf.18.1745939105583; Tue, 29 Apr 2025
 08:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com> <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 08:04:54 -0700
X-Gm-Features: ATxdqUEMcerW_3uWJwn4lQfEsTD17ws6ZJlPqKtqq4plPelctubE11sl__I-rMI
Message-ID: <CAJuCfpG2o3ZrLvBh0PgOKJajGb=KDHPb29PtNRatmeSzXgTRvw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 8:31=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Right now these are performed in kernel/fork.c which is odd and a violati=
on
> of separation of concerns, as well as preventing us from integrating this
> and related logic into userland VMA testing going forward, and perhaps mo=
re
> importantly - enabling us to, in a subsequent commit, make VMA
> allocation/freeing a purely internal mm operation.
>
> There is a fly in the ointment - nommu - mmap.c is not compiled if
> CONFIG_MMU not set, and neither is vma.c.
>
> To square the circle, let's add a new file - vma_init.c. This will be
> compiled for both CONFIG_MMU and nommu builds, and will also form part of
> the VMA userland testing.
>
> This allows us to de-duplicate code, while maintaining separation of
> concerns and the ability for us to userland test this logic.
>
> Update the VMA userland tests accordingly, additionally adding a
> detach_free_vma() helper function to correctly detach VMAs before freeing
> them in test code, as this change was triggering the assert for this.

Great! We are getting closer to parity between tests and the kernel code.

>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  MAINTAINERS                      |   1 +
>  kernel/fork.c                    |  88 -------------------
>  mm/Makefile                      |   2 +-
>  mm/mmap.c                        |   3 +-
>  mm/nommu.c                       |   4 +-
>  mm/vma.h                         |   7 ++
>  mm/vma_init.c                    | 101 ++++++++++++++++++++++
>  tools/testing/vma/Makefile       |   2 +-
>  tools/testing/vma/vma.c          |  26 ++++--
>  tools/testing/vma/vma_internal.h | 143 +++++++++++++++++++++++++------
>  10 files changed, 251 insertions(+), 126 deletions(-)
>  create mode 100644 mm/vma_init.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ee1c22e6e36..d274e6802ba5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15656,6 +15656,7 @@ F:      mm/mseal.c
>  F:     mm/vma.c
>  F:     mm/vma.h
>  F:     mm/vma_exec.c
> +F:     mm/vma_init.c
>  F:     mm/vma_internal.h
>  F:     tools/testing/selftests/mm/merge.c
>  F:     tools/testing/vma/
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ac9f9267a473..9e4616dacd82 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -431,88 +431,9 @@ struct kmem_cache *files_cachep;
>  /* SLAB cache for fs_struct structures (tsk->fs) */
>  struct kmem_cache *fs_cachep;
>
> -/* SLAB cache for vm_area_struct structures */
> -static struct kmem_cache *vm_area_cachep;
> -
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;

Maybe at some point we will be able to move mm_cachep out of here as well?

>
> -struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> -{
> -       struct vm_area_struct *vma;
> -
> -       vma =3D kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> -       if (!vma)
> -               return NULL;
> -
> -       vma_init(vma, mm);
> -
> -       return vma;
> -}
> -
> -static void vm_area_init_from(const struct vm_area_struct *src,
> -                             struct vm_area_struct *dest)
> -{
> -       dest->vm_mm =3D src->vm_mm;
> -       dest->vm_ops =3D src->vm_ops;
> -       dest->vm_start =3D src->vm_start;
> -       dest->vm_end =3D src->vm_end;
> -       dest->anon_vma =3D src->anon_vma;
> -       dest->vm_pgoff =3D src->vm_pgoff;
> -       dest->vm_file =3D src->vm_file;
> -       dest->vm_private_data =3D src->vm_private_data;
> -       vm_flags_init(dest, src->vm_flags);
> -       memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> -              sizeof(dest->vm_page_prot));
> -       /*
> -        * src->shared.rb may be modified concurrently when called from
> -        * dup_mmap(), but the clone will reinitialize it.
> -        */
> -       data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared=
)));
> -       memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> -              sizeof(dest->vm_userfaultfd_ctx));
> -#ifdef CONFIG_ANON_VMA_NAME
> -       dest->anon_name =3D src->anon_name;
> -#endif
> -#ifdef CONFIG_SWAP
> -       memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> -              sizeof(dest->swap_readahead_info));
> -#endif
> -#ifndef CONFIG_MMU
> -       dest->vm_region =3D src->vm_region;
> -#endif
> -#ifdef CONFIG_NUMA
> -       dest->vm_policy =3D src->vm_policy;
> -#endif
> -}
> -
> -struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> -{
> -       struct vm_area_struct *new =3D kmem_cache_alloc(vm_area_cachep, G=
FP_KERNEL);
> -
> -       if (!new)
> -               return NULL;
> -
> -       ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
> -       ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
> -       vm_area_init_from(orig, new);
> -       vma_lock_init(new, true);
> -       INIT_LIST_HEAD(&new->anon_vma_chain);
> -       vma_numab_state_init(new);
> -       dup_anon_vma_name(orig, new);
> -
> -       return new;
> -}
> -
> -void vm_area_free(struct vm_area_struct *vma)
> -{
> -       /* The vma should be detached while being destroyed. */
> -       vma_assert_detached(vma);
> -       vma_numab_state_free(vma);
> -       free_anon_vma_name(vma);
> -       kmem_cache_free(vm_area_cachep, vma);
> -}
> -
>  static void account_kernel_stack(struct task_struct *tsk, int account)
>  {
>         if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> @@ -3033,11 +2954,6 @@ void __init mm_cache_init(void)
>
>  void __init proc_caches_init(void)
>  {
> -       struct kmem_cache_args args =3D {
> -               .use_freeptr_offset =3D true,
> -               .freeptr_offset =3D offsetof(struct vm_area_struct, vm_fr=
eeptr),
> -       };
> -
>         sighand_cachep =3D kmem_cache_create("sighand_cache",
>                         sizeof(struct sighand_struct), 0,
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RC=
U|
> @@ -3054,10 +2970,6 @@ void __init proc_caches_init(void)
>                         sizeof(struct fs_struct), 0,
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>                         NULL);
> -       vm_area_cachep =3D kmem_cache_create("vm_area_struct",
> -                       sizeof(struct vm_area_struct), &args,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RC=
U|
> -                       SLAB_ACCOUNT);
>         mmap_init();
>         nsproxy_cache_init();
>  }
> diff --git a/mm/Makefile b/mm/Makefile
> index 15a901bb431a..690ddcf7d9a1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -55,7 +55,7 @@ obj-y                 :=3D filemap.o mempool.o oom_kill=
.o fadvise.o \
>                            mm_init.o percpu.o slab_common.o \
>                            compaction.o show_mem.o \
>                            interval_tree.o list_lru.o workingset.o \
> -                          debug.o gup.o mmap_lock.o $(mmu-y)
> +                          debug.o gup.o mmap_lock.o vma_init.o $(mmu-y)
>
>  # Give 'page_alloc' its own module-parameter namespace
>  page-alloc-y :=3D page_alloc.o
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5259df031e15..81dd962a1cfc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1554,7 +1554,7 @@ static const struct ctl_table mmap_table[] =3D {
>  #endif /* CONFIG_SYSCTL */
>
>  /*
> - * initialise the percpu counter for VM
> + * initialise the percpu counter for VM, initialise VMA state.
>   */
>  void __init mmap_init(void)
>  {
> @@ -1565,6 +1565,7 @@ void __init mmap_init(void)
>  #ifdef CONFIG_SYSCTL
>         register_sysctl_init("vm", mmap_table);
>  #endif
> +       vma_state_init();
>  }
>
>  /*
> diff --git a/mm/nommu.c b/mm/nommu.c
> index a142fc258d39..0bf4849b8204 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -399,7 +399,8 @@ static const struct ctl_table nommu_table[] =3D {
>  };
>
>  /*
> - * initialise the percpu counter for VM and region record slabs
> + * initialise the percpu counter for VM and region record slabs, initial=
ise VMA
> + * state.
>   */
>  void __init mmap_init(void)
>  {
> @@ -409,6 +410,7 @@ void __init mmap_init(void)
>         VM_BUG_ON(ret);
>         vm_region_jar =3D KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
>         register_sysctl_init("vm", nommu_table);
> +       vma_state_init();
>  }
>
>  /*
> diff --git a/mm/vma.h b/mm/vma.h
> index 94307a2e4ab6..4a1e1768ca46 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -548,8 +548,15 @@ int expand_downwards(struct vm_area_struct *vma, uns=
igned long address);
>
>  int __vm_munmap(unsigned long start, size_t len, bool unlock);
>
> +
>  int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma);
>
> +/* vma_init.h, shared between CONFIG_MMU and nommu. */
> +void __init vma_state_init(void);
> +struct vm_area_struct *vm_area_alloc(struct mm_struct *mm);
> +struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig);
> +void vm_area_free(struct vm_area_struct *vma);
> +
>  /* vma_exec.h */
>  #ifdef CONFIG_MMU
>  int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **=
vmap,
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> new file mode 100644
> index 000000000000..967ca8517986
> --- /dev/null
> +++ b/mm/vma_init.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Functions for initialisaing, allocating, freeing and duplicating VMAs=
. Shared
> + * between CONFIG_MMU and non-CONFIG_MMU kernel configurations.
> + */
> +
> +#include "vma_internal.h"
> +#include "vma.h"
> +
> +/* SLAB cache for vm_area_struct structures */
> +static struct kmem_cache *vm_area_cachep;
> +
> +void __init vma_state_init(void)
> +{
> +       struct kmem_cache_args args =3D {
> +               .use_freeptr_offset =3D true,
> +               .freeptr_offset =3D offsetof(struct vm_area_struct, vm_fr=
eeptr),
> +       };
> +
> +       vm_area_cachep =3D kmem_cache_create("vm_area_struct",
> +                       sizeof(struct vm_area_struct), &args,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RC=
U|
> +                       SLAB_ACCOUNT);
> +}
> +
> +struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> +{
> +       struct vm_area_struct *vma;
> +
> +       vma =3D kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> +       if (!vma)
> +               return NULL;
> +
> +       vma_init(vma, mm);
> +
> +       return vma;
> +}
> +
> +static void vm_area_init_from(const struct vm_area_struct *src,
> +                             struct vm_area_struct *dest)
> +{
> +       dest->vm_mm =3D src->vm_mm;
> +       dest->vm_ops =3D src->vm_ops;
> +       dest->vm_start =3D src->vm_start;
> +       dest->vm_end =3D src->vm_end;
> +       dest->anon_vma =3D src->anon_vma;
> +       dest->vm_pgoff =3D src->vm_pgoff;
> +       dest->vm_file =3D src->vm_file;
> +       dest->vm_private_data =3D src->vm_private_data;
> +       vm_flags_init(dest, src->vm_flags);
> +       memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> +              sizeof(dest->vm_page_prot));
> +       /*
> +        * src->shared.rb may be modified concurrently when called from
> +        * dup_mmap(), but the clone will reinitialize it.
> +        */
> +       data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared=
)));
> +       memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> +              sizeof(dest->vm_userfaultfd_ctx));
> +#ifdef CONFIG_ANON_VMA_NAME
> +       dest->anon_name =3D src->anon_name;
> +#endif
> +#ifdef CONFIG_SWAP
> +       memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> +              sizeof(dest->swap_readahead_info));
> +#endif
> +#ifndef CONFIG_MMU
> +       dest->vm_region =3D src->vm_region;
> +#endif
> +#ifdef CONFIG_NUMA
> +       dest->vm_policy =3D src->vm_policy;
> +#endif
> +}
> +
> +struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> +{
> +       struct vm_area_struct *new =3D kmem_cache_alloc(vm_area_cachep, G=
FP_KERNEL);
> +
> +       if (!new)
> +               return NULL;
> +
> +       ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
> +       ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
> +       vm_area_init_from(orig, new);
> +       vma_lock_init(new, true);
> +       INIT_LIST_HEAD(&new->anon_vma_chain);
> +       vma_numab_state_init(new);
> +       dup_anon_vma_name(orig, new);
> +
> +       return new;
> +}
> +
> +void vm_area_free(struct vm_area_struct *vma)
> +{
> +       /* The vma should be detached while being destroyed. */
> +       vma_assert_detached(vma);
> +       vma_numab_state_free(vma);
> +       free_anon_vma_name(vma);
> +       kmem_cache_free(vm_area_cachep, vma);
> +}
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index 624040fcf193..66f3831a668f 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -9,7 +9,7 @@ include ../shared/shared.mk
>  OFILES =3D $(SHARED_OFILES) vma.o maple-shim.o
>  TARGETS =3D vma
>
> -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c ../=
../../mm/vma.h
> +vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../=
../../mm/vma_exec.c ../../../mm/vma.h
>
>  vma:   $(OFILES)
>         $(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 5832ae5d797d..2be7597a2ac2 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -28,6 +28,7 @@ unsigned long stack_guard_gap =3D 256UL<<PAGE_SHIFT;
>   * Directly import the VMA implementation here. Our vma_internal.h wrapp=
er
>   * provides userland-equivalent functionality for everything vma.c uses.
>   */
> +#include "../../../mm/vma_init.c"
>  #include "../../../mm/vma_exec.c"
>  #include "../../../mm/vma.c"
>
> @@ -91,6 +92,12 @@ static int attach_vma(struct mm_struct *mm, struct vm_=
area_struct *vma)
>         return res;
>  }
>
> +static void detach_free_vma(struct vm_area_struct *vma)

In case you respin another version, I think this change related to
detach_free_vma() would better be done in a separate patch. But I'm
totally fine with the way it is now, so don't respin just for that.

> +{
> +       vma_mark_detached(vma);
> +       vm_area_free(vma);
> +}
> +
>  /* Helper function to allocate a VMA and link it to the tree. */
>  static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>                                                  unsigned long start,
> @@ -104,7 +111,7 @@ static struct vm_area_struct *alloc_and_link_vma(stru=
ct mm_struct *mm,
>                 return NULL;
>
>         if (attach_vma(mm, vma)) {
> -               vm_area_free(vma);
> +               detach_free_vma(vma);
>                 return NULL;
>         }
>
> @@ -249,7 +256,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vm=
a_iterator *vmi)
>
>         vma_iter_set(vmi, 0);
>         for_each_vma(*vmi, vma) {
> -               vm_area_free(vma);
> +               detach_free_vma(vma);
>                 count++;
>         }
>
> @@ -319,7 +326,7 @@ static bool test_simple_merge(void)
>         ASSERT_EQ(vma->vm_pgoff, 0);
>         ASSERT_EQ(vma->vm_flags, flags);
>
> -       vm_area_free(vma);
> +       detach_free_vma(vma);
>         mtree_destroy(&mm.mm_mt);
>
>         return true;
> @@ -361,7 +368,7 @@ static bool test_simple_modify(void)
>         ASSERT_EQ(vma->vm_end, 0x1000);
>         ASSERT_EQ(vma->vm_pgoff, 0);
>
> -       vm_area_free(vma);
> +       detach_free_vma(vma);
>         vma_iter_clear(&vmi);
>
>         vma =3D vma_next(&vmi);
> @@ -370,7 +377,7 @@ static bool test_simple_modify(void)
>         ASSERT_EQ(vma->vm_end, 0x2000);
>         ASSERT_EQ(vma->vm_pgoff, 1);
>
> -       vm_area_free(vma);
> +       detach_free_vma(vma);
>         vma_iter_clear(&vmi);
>
>         vma =3D vma_next(&vmi);
> @@ -379,7 +386,7 @@ static bool test_simple_modify(void)
>         ASSERT_EQ(vma->vm_end, 0x3000);
>         ASSERT_EQ(vma->vm_pgoff, 2);
>
> -       vm_area_free(vma);
> +       detach_free_vma(vma);
>         mtree_destroy(&mm.mm_mt);
>
>         return true;
> @@ -407,7 +414,7 @@ static bool test_simple_expand(void)
>         ASSERT_EQ(vma->vm_end, 0x3000);
>         ASSERT_EQ(vma->vm_pgoff, 0);
>
> -       vm_area_free(vma);
> +       detach_free_vma(vma);
>         mtree_destroy(&mm.mm_mt);
>
>         return true;
> @@ -428,7 +435,7 @@ static bool test_simple_shrink(void)
>         ASSERT_EQ(vma->vm_end, 0x1000);
>         ASSERT_EQ(vma->vm_pgoff, 0);
>
> -       vm_area_free(vma);
> +       detach_free_vma(vma);
>         mtree_destroy(&mm.mm_mt);
>
>         return true;
> @@ -619,7 +626,7 @@ static bool test_merge_new(void)
>                 ASSERT_EQ(vma->vm_pgoff, 0);
>                 ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>
> -               vm_area_free(vma);
> +               detach_free_vma(vma);
>                 count++;
>         }
>
> @@ -1668,6 +1675,7 @@ int main(void)
>         int num_tests =3D 0, num_fail =3D 0;
>
>         maple_tree_init();
> +       vma_state_init();
>
>  #define TEST(name)                                                     \
>         do {                                                            \
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 32e990313158..198abe66de5a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -155,6 +155,10 @@ typedef __bitwise unsigned int vm_fault_t;
>   */
>  #define pr_warn_once pr_err
>
> +#define data_race(expr) expr
> +
> +#define ASSERT_EXCLUSIVE_WRITER(x)
> +
>  struct kref {
>         refcount_t refcount;
>  };
> @@ -255,6 +259,8 @@ struct file {
>
>  #define VMA_LOCK_OFFSET        0x40000000
>
> +typedef struct { unsigned long v; } freeptr_t;
> +
>  struct vm_area_struct {
>         /* The first cache line has the info for VMA tree walking. */
>
> @@ -264,9 +270,7 @@ struct vm_area_struct {
>                         unsigned long vm_start;
>                         unsigned long vm_end;
>                 };
> -#ifdef CONFIG_PER_VMA_LOCK
> -               struct rcu_head vm_rcu; /* Used for deferred freeing. */
> -#endif
> +               freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY=
_RCU */

Oops, I must have missed this when adding SLAB_TYPESAFE_BY_RCU to the
vm_area_struct cache. Thanks for fixing it!

>         };
>
>         struct mm_struct *vm_mm;        /* The address space we belong to=
. */
> @@ -463,6 +467,65 @@ struct pagetable_move_control {
>                 .len_in =3D len_,                                        =
 \
>         }
>
> +struct kmem_cache_args {
> +       /**
> +        * @align: The required alignment for the objects.
> +        *
> +        * %0 means no specific alignment is requested.
> +        */
> +       unsigned int align;
> +       /**
> +        * @useroffset: Usercopy region offset.
> +        *
> +        * %0 is a valid offset, when @usersize is non-%0
> +        */
> +       unsigned int useroffset;
> +       /**
> +        * @usersize: Usercopy region size.
> +        *
> +        * %0 means no usercopy region is specified.
> +        */
> +       unsigned int usersize;
> +       /**
> +        * @freeptr_offset: Custom offset for the free pointer
> +        * in &SLAB_TYPESAFE_BY_RCU caches
> +        *
> +        * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
> +        * outside of the object. This might cause the object to grow in =
size.
> +        * Cache creators that have a reason to avoid this can specify a =
custom
> +        * free pointer offset in their struct where the free pointer wil=
l be
> +        * placed.
> +        *
> +        * Note that placing the free pointer inside the object requires =
the
> +        * caller to ensure that no fields are invalidated that are requi=
red to
> +        * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
> +        * details).
> +        *
> +        * Using %0 as a value for @freeptr_offset is valid. If @freeptr_=
offset
> +        * is specified, %use_freeptr_offset must be set %true.
> +        *
> +        * Note that @ctor currently isn't supported with custom free poi=
nters
> +        * as a @ctor requires an external free pointer.
> +        */
> +       unsigned int freeptr_offset;
> +       /**
> +        * @use_freeptr_offset: Whether a @freeptr_offset is used.
> +        */
> +       bool use_freeptr_offset;
> +       /**
> +        * @ctor: A constructor for the objects.
> +        *
> +        * The constructor is invoked for each object in a newly allocate=
d slab
> +        * page. It is the cache user's responsibility to free object in =
the
> +        * same state as after calling the constructor, or deal appropria=
tely
> +        * with any differences between a freshly constructed and a reall=
ocated
> +        * object.
> +        *
> +        * %NULL means no constructor.
> +        */
> +       void (*ctor)(void *);
> +};
> +
>  static inline void vma_iter_invalidate(struct vma_iterator *vmi)
>  {
>         mas_pause(&vmi->mas);
> @@ -547,31 +610,38 @@ static inline void vma_init(struct vm_area_struct *=
vma, struct mm_struct *mm)
>         vma->vm_lock_seq =3D UINT_MAX;
>  }
>
> -static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> -{
> -       struct vm_area_struct *vma =3D calloc(1, sizeof(struct vm_area_st=
ruct));
> +struct kmem_cache {
> +       const char *name;
> +       size_t object_size;
> +       struct kmem_cache_args *args;
> +};
>
> -       if (!vma)
> -               return NULL;
> +static inline struct kmem_cache *__kmem_cache_create(const char *name,
> +                                                    size_t object_size,
> +                                                    struct kmem_cache_ar=
gs *args)
> +{
> +       struct kmem_cache *ret =3D malloc(sizeof(struct kmem_cache));
>
> -       vma_init(vma, mm);
> +       ret->name =3D name;
> +       ret->object_size =3D object_size;
> +       ret->args =3D args;
>
> -       return vma;
> +       return ret;
>  }
>
> -static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *=
orig)
> -{
> -       struct vm_area_struct *new =3D calloc(1, sizeof(struct vm_area_st=
ruct));
> +#define kmem_cache_create(__name, __object_size, __args, ...)           =
\
> +       __kmem_cache_create((__name), (__object_size), (__args))
>
> -       if (!new)
> -               return NULL;
> +static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflag=
s)
> +{
> +       (void)gfpflags;
>
> -       memcpy(new, orig, sizeof(*new));
> -       refcount_set(&new->vm_refcnt, 0);
> -       new->vm_lock_seq =3D UINT_MAX;
> -       INIT_LIST_HEAD(&new->anon_vma_chain);
> +       return calloc(s->object_size, 1);
> +}
>
> -       return new;
> +static inline void kmem_cache_free(struct kmem_cache *s, void *x)
> +{
> +       free(x);
>  }
>
>  /*
> @@ -738,11 +808,6 @@ static inline void mpol_put(struct mempolicy *)
>  {
>  }
>
> -static inline void vm_area_free(struct vm_area_struct *vma)
> -{
> -       free(vma);
> -}
> -
>  static inline void lru_add_drain(void)
>  {
>  }
> @@ -1312,4 +1377,32 @@ static inline void ksm_exit(struct mm_struct *mm)
>         (void)mm;
>  }
>
> +static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_=
refcnt)
> +{
> +       (void)vma;
> +       (void)reset_refcnt;
> +}
> +
> +static inline void vma_numab_state_init(struct vm_area_struct *vma)
> +{
> +       (void)vma;
> +}
> +
> +static inline void vma_numab_state_free(struct vm_area_struct *vma)
> +{
> +       (void)vma;
> +}
> +
> +static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
> +                                    struct vm_area_struct *new_vma)
> +{
> +       (void)orig_vma;
> +       (void)new_vma;
> +}
> +
> +static inline void free_anon_vma_name(struct vm_area_struct *vma)
> +{
> +       (void)vma;
> +}
> +
>  #endif /* __MM_VMA_INTERNAL_H */
> --
> 2.49.0
>

