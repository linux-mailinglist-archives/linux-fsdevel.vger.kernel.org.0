Return-Path: <linux-fsdevel+bounces-66415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA8C1E5E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94C5934B757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 04:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE82F60CB;
	Thu, 30 Oct 2025 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NxB4BGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D6208961
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798941; cv=none; b=Rb04D2Lzqc+bk0sR56LtJRR3RIefAqctC5jSs2vWG9jH6B0qiUUjljs7/7PaTNkYn27rJw2XRlqIbCLoVtAMtwvh93dn14NBlWozx0auIVm2W4wTieYQ6E3kpvLx1iCa8FzDWCy0PYdPIwtFdOrNofDLyo7gYf8+6Z3dxy8hKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798941; c=relaxed/simple;
	bh=3grhviK8NzhGepSDu/62UDKwcEuYQ6YU4sYT7tqhkNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBrQY5BA4Y0afOtGWbG591kj2kfgtVJ1srChuwnGgbxCxtljtDi/h4FOgqP3NQrY8TZdP+/VXjRwyobtFK/RJz4RYGBUPDvbf1kIj6ei6xkZZFhzaMZ1M4u+HzsiX3rIDbivprDG4Z2hvEP0QctRC8/F5h3cMCVKJtKYNF+eluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NxB4BGA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso135811cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 21:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761798936; x=1762403736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7p5MBXVbiIkyou0h0j++mKUN2aZ5HCHJwUFRjJwF4A=;
        b=2NxB4BGA4U6ztPSkV1X0Gevtnfcn/3eKUR6MhoWDw0sEqkiLw1DX4FkqTS36eNec7D
         auv5VnnUglW+s4HAHojhD5j9axlPLLaFmP6ide0JQlaS1PZJ0PRZywELFkcgmMlj7S2X
         gubTPH83jJk4rtVXF+3QsoO9/Tncbp90aR5ti5u5lqandadazsJd6YMEoFONUpXQbnaa
         96tP/W7dc/7SIiTTxJMx1QCrTJ4YtCBc8sgT81YjGcdhofrjPiOrPYGX6VeY5nU8DcpV
         I1z10Mp4ZA6CBi+bd4fj1XsfTvn7F1M4b3JyQLhAHjzYeXWV81dqNitJQdgY+1/uFdnb
         Pd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798936; x=1762403736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7p5MBXVbiIkyou0h0j++mKUN2aZ5HCHJwUFRjJwF4A=;
        b=bzeJitsIvh1qMjVOxYP3dl4ZTQC9SGVl1Bgj4cIlAeE8c8R9uXWWNuCLc+P4luHqmz
         HdyR4L59DmA5F1FuoyWBbqZYvh4iktJlrIMGLO9nGdvSC99xz3+OF9GxUCTQwix0kj+w
         O8nXMPqLRrl/NsdBRRuveTXwRhpk4oiisQA/+KaEK6OnqiLQMleIEtAamfzKUQyAlo2W
         72fqksHOJkBHxb4WNLt++9Fg9TSk3Up3YWH4alVk6gqK+L8RxX/jNOGPJoLS1vGzFrx0
         xk5Ay9IMmMe9qy/0LEQOWFpW6225PYSlCEuc3cz+7YhvqZS4A38Gb4Y+CoFynBm1u74Y
         5Vvw==
X-Forwarded-Encrypted: i=1; AJvYcCXroPkYIzO+ryurbtCHrK1ZVBc69C0wl0kKot3JJM6lgJpuANbhTCPQWcl/7UU6DdJW2axYYY24t2RlnXri@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkcr3DYb1EmCnSwV43rSXCMCypyzEGCdtFj/aP51Wrw0kzfcKm
	T/t2pGkUg+AvVVUSbLBcik0KTY5/s1GRcMCt/TjZ/PINEa4KyQc3d+ES+J+pQBH9y2zeM4NQoWp
	wJkN7oA5Mk1ij8wGI+T5bX/muusJEO+aqw+seE7C7
X-Gm-Gg: ASbGncus4Baf7w5Jnhrjlg16nPxDoZTTmamlhiU6aaTGMguwaB9pAh1Xk2Ss1F5XfUN
	Y0faFybnUEBthVTrf5TbC44cvN5suWnNAfmozLxn8TC7Pfn+VH+Sc915NX9KjwdGe+RIq6RmuDi
	AK+jH5S9/DYkEjo6n1Oc2RKYosj1y3yIV2edu/OEVSQ8UcnW1LHL5t3Hqz6aiW14yT9I5GLCdRB
	9OmAw4G8fPMitpt0T0zQ6CPH8B/3+vP2pjt40tdTuHqbDQn4TIXV/MtBgkdQRQqBgX50Q==
X-Google-Smtp-Source: AGHT+IF1NWXnqQl2SyuyiBIcf9blyjA4VswiUlI25KGyv4hX6VC+UTqbvxsl0BdW2YgOgU9DPZO+oXCnbEVW5xaZUVE=
X-Received: by 2002:ac8:7d12:0:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4ed23f77a45mr2547151cf.0.1761798935984; Wed, 29 Oct 2025
 21:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com> <ec71238fd1f735ca6e4970ccdc0abfbb60967596.1761756437.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <ec71238fd1f735ca6e4970ccdc0abfbb60967596.1761756437.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 21:35:25 -0700
X-Gm-Features: AWmQ_bkSCQc-YXoEndGYlWcpx02uslGWP6aPRR4XSkgpBao9QBAAzOBkh4kHurc
Message-ID: <CAJuCfpEdFrPndQzF903zVQxFkyVdyXbFhxRT6YZd=j2MNgwUrA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: implement sticky, copy on fork VMA flags
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> It's useful to be able to force a VMA to be copied on fork outside of the
> parameters specified by vma_needs_copy(), which otherwise only copies pag=
e
> tables if:
>
> * The destination VMA has VM_UFFD_WP set
> * The mapping is a PFN or mixed map
> * The mapping is anonymous and forked in (i.e. vma->anon_vma is non-NULL)
>
> Setting this flag implies that the page tables mapping the VMA are such
> that simply re-faulting the VMA will not re-establish them in identical
> form.
>
> We introduce VM_COPY_ON_FORK to clearly identify which flags require this
> behaviour, which currently is only VM_MAYBE_GUARD.
>
> Any VMA flags which require this behaviour are inherently 'sticky', that
> is, should we merge two VMAs together, this implies that the newly merged
> VMA maps a range that requires page table copying on fork.
>
> In order to implement this we must both introduce the concept of a 'stick=
y'
> VMA flag and adjust the VMA merge logic accordingly, and also have VMA
> merge still successfully succeed should one VMA have the flag set and
> another not.

"successfully succeed" sounds weird. Just "succeed"?

>
> Note that we update the VMA expand logic to handle new VMA merging, as th=
is
> function is the one ultimately called by all instances of merging of new
> VMAs.
>
> This patch implements this, establishing VM_STICKY to contain all such
> flags and VM_IGNORE_MERGE for those flags which should be ignored when
> comparing adjacent VMA's flags for the purposes of merging.
>
> As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
> already had this behaviour, alongside VM_STICKY as sticky flags by
> implication must not disallow merge.
>
> We update the VMA userland tests to account for the changes and,
> furthermore, in order to assert that the functionality is workingly

s/workingly/working

> correctly, update the new VMA and existing VMA merging logic to consider
> every permutation of the flag being set/not set in all VMAs being
> considered for merge.
>
> As a result of this change, VMAs with guard ranges will now not have thei=
r
> merge behaviour impacted by doing so and can be freely merged with other
> VMAs without VM_MAYBE_GUARD set.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h               | 32 ++++++++++++
>  mm/memory.c                      |  3 +-
>  mm/vma.c                         | 22 ++++----
>  tools/testing/vma/vma.c          | 89 ++++++++++++++++++++++++++++----
>  tools/testing/vma/vma_internal.h | 32 ++++++++++++
>  5 files changed, 156 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f963afa1b9de..a8811ba57150 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -522,6 +522,38 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>  #define VM_FLAGS_CLEAR (ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
>
> +/* Flags which should result in page tables being copied on fork. */
> +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> +
> +/*
> + * Flags which should be 'sticky' on merge - that is, flags which, when =
one VMA
> + * possesses it but the other does not, the merged VMA should nonetheles=
s have
> + * applied to it:
> + *
> + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that =
contains
> + *                   metadata which should be unconditionally propagated=
 upon
> + *                   fork. When merging two VMAs, we encapsulate this ra=
nge in
> + *                   the merged VMA, so the flag should be 'sticky' as a=
 result.

It's probably worth noting that after a split, we do not remove
"sticky" flags even if the VMA acquired them as a result of a previous
merge.

> + */
> +#define VM_STICKY VM_COPY_ON_FORK
> +
> +/*
> + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessin=
g one
> + * of these flags and the other not does not preclude a merge.
> + *
> + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the f=
lags but
> + *                dirty bit -- the caller should mark merged VMA as dirt=
y. If
> + *                dirty bit won't be excluded from comparison, we increa=
se
> + *                pressure on the memory system forcing the kernel to ge=
nerate
> + *                new VMAs when old one could be extended instead.
> + *
> + *    VM_STICKY - If one VMA has flags which most be 'sticky', that is o=
nes

s/most/must ?

> + *                which should propagate to all VMAs, but the other does=
 not,
> + *                the merge should still proceed with the merge logic ap=
plying
> + *                sticky flags to the final VMA.
> + */
> +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> +
>  /*
>   * mapping from the currently active vm_flags protection bits (the
>   * low four bits) to a page protection mask..
> diff --git a/mm/memory.c b/mm/memory.c
> index a2c79ee43d68..9528133e5147 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1478,8 +1478,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, stru=
ct vm_area_struct *src_vma)
>         if (src_vma->anon_vma)
>                 return true;
>
> -       /* Guard regions have momdified page tables that require copying.=
 */
> -       if (src_vma->vm_flags & VM_MAYBE_GUARD)
> +       if (src_vma->vm_flags & VM_COPY_ON_FORK)
>                 return true;
>
>         /*
> diff --git a/mm/vma.c b/mm/vma.c
> index 919d1fc63a52..50a6909c4be3 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_s=
truct *vmg, bool merge_nex
>
>         if (!mpol_equal(vmg->policy, vma_policy(vma)))
>                 return false;
> -       /*
> -        * VM_SOFTDIRTY should not prevent from VMA merging, if we
> -        * match the flags but dirty bit -- the caller should mark
> -        * merged VMA as dirty. If dirty bit won't be excluded from
> -        * comparison, we increase pressure on the memory system forcing
> -        * the kernel to generate new VMAs when old one could be
> -        * extended instead.
> -        */
> -       if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
> +       if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
>                 return false;
>         if (vma->vm_file !=3D vmg->file)
>                 return false;
> @@ -809,6 +801,7 @@ static bool can_merge_remove_vma(struct vm_area_struc=
t *vma)
>  static __must_check struct vm_area_struct *vma_merge_existing_range(
>                 struct vma_merge_struct *vmg)
>  {
> +       vm_flags_t sticky_flags =3D vmg->vm_flags & VM_STICKY;
>         struct vm_area_struct *middle =3D vmg->middle;
>         struct vm_area_struct *prev =3D vmg->prev;
>         struct vm_area_struct *next;
> @@ -901,11 +894,13 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
>         if (merge_right) {
>                 vma_start_write(next);
>                 vmg->target =3D next;
> +               sticky_flags |=3D (next->vm_flags & VM_STICKY);
>         }
>
>         if (merge_left) {
>                 vma_start_write(prev);
>                 vmg->target =3D prev;
> +               sticky_flags |=3D (prev->vm_flags & VM_STICKY);
>         }
>
>         if (merge_both) {
> @@ -975,6 +970,7 @@ static __must_check struct vm_area_struct *vma_merge_=
existing_range(
>         if (err || commit_merge(vmg))
>                 goto abort;
>
> +       vm_flags_set(vmg->target, sticky_flags);
>         khugepaged_enter_vma(vmg->target, vmg->vm_flags);
>         vmg->state =3D VMA_MERGE_SUCCESS;
>         return vmg->target;
> @@ -1125,6 +1121,10 @@ int vma_expand(struct vma_merge_struct *vmg)
>         bool remove_next =3D false;
>         struct vm_area_struct *target =3D vmg->target;
>         struct vm_area_struct *next =3D vmg->next;
> +       vm_flags_t sticky_flags;
> +
> +       sticky_flags =3D vmg->vm_flags & VM_STICKY;
> +       sticky_flags |=3D target->vm_flags & VM_STICKY;
>
>         VM_WARN_ON_VMG(!target, vmg);
>
> @@ -1134,6 +1134,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>         if (next && (target !=3D next) && (vmg->end =3D=3D next->vm_end))=
 {
>                 int ret;
>
> +               sticky_flags |=3D next->vm_flags & VM_STICKY;
>                 remove_next =3D true;
>                 /* This should already have been checked by this point. *=
/
>                 VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
> @@ -1160,6 +1161,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>         if (commit_merge(vmg))
>                 goto nomem;
>
> +       vm_flags_set(target, sticky_flags);
>         return 0;
>
>  nomem:
> @@ -1903,7 +1905,7 @@ static int anon_vma_compatible(struct vm_area_struc=
t *a, struct vm_area_struct *
>         return a->vm_end =3D=3D b->vm_start &&
>                 mpol_equal(vma_policy(a), vma_policy(b)) &&
>                 a->vm_file =3D=3D b->vm_file &&
> -               !((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SO=
FTDIRTY)) &&
> +               !((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IG=
NORE_MERGE)) &&
>                 b->vm_pgoff =3D=3D a->vm_pgoff + ((b->vm_start - a->vm_st=
art) >> PAGE_SHIFT);
>  }
>
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 656e1c75b711..ee9d3547c421 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c

I prefer tests in a separate patch, but that might just be me. Feel
free to ignore.

> @@ -48,6 +48,8 @@ static struct anon_vma dummy_anon_vma;
>  #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) =3D=3D (_val2))
>  #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) !=3D (_val2))
>
> +#define IS_SET(_val, _flags) ((_val & _flags) =3D=3D _flags)
> +
>  static struct task_struct __current;
>
>  struct task_struct *get_current(void)
> @@ -441,7 +443,7 @@ static bool test_simple_shrink(void)
>         return true;
>  }
>
> -static bool test_merge_new(void)
> +static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is=
_sticky, bool c_is_sticky)
>  {
>         vm_flags_t vm_flags =3D VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYW=
RITE;
>         struct mm_struct mm =3D {};
> @@ -469,23 +471,32 @@ static bool test_merge_new(void)
>         struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
>         bool merged;
>
> +       if (is_sticky)
> +               vm_flags |=3D VM_STICKY;
> +
>         /*
>          * 0123456789abc
>          * AA B       CC
>          */
>         vma_a =3D alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
>         ASSERT_NE(vma_a, NULL);
> +       if (a_is_sticky)
> +               vm_flags_set(vma_a, VM_STICKY);
>         /* We give each VMA a single avc so we can test anon_vma duplicat=
ion. */
>         INIT_LIST_HEAD(&vma_a->anon_vma_chain);
>         list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain=
);
>
>         vma_b =3D alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
>         ASSERT_NE(vma_b, NULL);
> +       if (b_is_sticky)
> +               vm_flags_set(vma_b, VM_STICKY);
>         INIT_LIST_HEAD(&vma_b->anon_vma_chain);
>         list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain=
);
>
>         vma_c =3D alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
>         ASSERT_NE(vma_c, NULL);
> +       if (c_is_sticky)
> +               vm_flags_set(vma_c, VM_STICKY);
>         INIT_LIST_HEAD(&vma_c->anon_vma_chain);
>         list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain=
);
>
> @@ -520,6 +531,8 @@ static bool test_merge_new(void)
>         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_EQ(mm.map_count, 3);
> +       if (is_sticky || a_is_sticky || b_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
>
>         /*
>          * Merge to PREVIOUS VMA.
> @@ -537,6 +550,8 @@ static bool test_merge_new(void)
>         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_EQ(mm.map_count, 3);
> +       if (is_sticky || a_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
>
>         /*
>          * Merge to NEXT VMA.
> @@ -556,6 +571,8 @@ static bool test_merge_new(void)
>         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_EQ(mm.map_count, 3);
> +       if (is_sticky) /* D uses is_sticky. */
> +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
>
>         /*
>          * Merge BOTH sides.
> @@ -574,6 +591,8 @@ static bool test_merge_new(void)
>         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_EQ(mm.map_count, 2);
> +       if (is_sticky || a_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
>
>         /*
>          * Merge to NEXT VMA.
> @@ -592,6 +611,8 @@ static bool test_merge_new(void)
>         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_EQ(mm.map_count, 2);
> +       if (is_sticky || c_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
>
>         /*
>          * Merge BOTH sides.
> @@ -609,6 +630,8 @@ static bool test_merge_new(void)
>         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_EQ(mm.map_count, 1);
> +       if (is_sticky || a_is_sticky || c_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
>
>         /*
>          * Final state.
> @@ -637,6 +660,20 @@ static bool test_merge_new(void)
>         return true;
>  }
>
> +static bool test_merge_new(void)
> +{
> +       int i, j, k, l;
> +
> +       /* Generate every possible permutation of sticky flags. */
> +       for (i =3D 0; i < 2; i++)
> +               for (j =3D 0; j < 2; j++)
> +                       for (k =3D 0; k < 2; k++)
> +                               for (l =3D 0; l < 2; l++)
> +                                       ASSERT_TRUE(__test_merge_new(i, j=
, k, l));
> +
> +       return true;
> +}
> +
>  static bool test_vma_merge_special_flags(void)
>  {
>         vm_flags_t vm_flags =3D VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYW=
RITE;
> @@ -973,9 +1010,11 @@ static bool test_vma_merge_new_with_close(void)
>         return true;
>  }
>
> -static bool test_merge_existing(void)
> +static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_st=
icky, bool next_is_sticky)
>  {
>         vm_flags_t vm_flags =3D VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYW=
RITE;
> +       vm_flags_t prev_flags =3D vm_flags;
> +       vm_flags_t next_flags =3D vm_flags;
>         struct mm_struct mm =3D {};
>         VMA_ITERATOR(vmi, &mm, 0);
>         struct vm_area_struct *vma, *vma_prev, *vma_next;
> @@ -988,6 +1027,13 @@ static bool test_merge_existing(void)
>         };
>         struct anon_vma_chain avc =3D {};
>
> +       if (prev_is_sticky)
> +               prev_flags |=3D VM_STICKY;
> +       if (middle_is_sticky)
> +               vm_flags |=3D VM_STICKY;
> +       if (next_is_sticky)
> +               next_flags |=3D VM_STICKY;
> +
>         /*
>          * Merge right case - partial span.
>          *
> @@ -1000,7 +1046,7 @@ static bool test_merge_existing(void)
>          */
>         vma =3D alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
>         vma->vm_ops =3D &vm_ops; /* This should have no impact. */
> -       vma_next =3D alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags)=
;
> +       vma_next =3D alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flag=
s);
>         vma_next->vm_ops =3D &vm_ops; /* This should have no impact. */
>         vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_=
anon_vma);
>         vmg.middle =3D vma;
> @@ -1018,6 +1064,8 @@ static bool test_merge_existing(void)
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_TRUE(vma_write_started(vma_next));
>         ASSERT_EQ(mm.map_count, 2);
> +       if (middle_is_sticky || next_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
>
>         /* Clear down and reset. */
>         ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> @@ -1033,7 +1081,7 @@ static bool test_merge_existing(void)
>          *   NNNNNNN
>          */
>         vma =3D alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
> -       vma_next =3D alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags)=
;
> +       vma_next =3D alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flag=
s);
>         vma_next->vm_ops =3D &vm_ops; /* This should have no impact. */
>         vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_=
anon_vma);
>         vmg.middle =3D vma;
> @@ -1046,6 +1094,8 @@ static bool test_merge_existing(void)
>         ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma_next));
>         ASSERT_EQ(mm.map_count, 1);
> +       if (middle_is_sticky || next_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
>
>         /* Clear down and reset. We should have deleted vma. */
>         ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> @@ -1060,7 +1110,7 @@ static bool test_merge_existing(void)
>          * 0123456789
>          * PPPPPPV
>          */
> -       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> +       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
>         vma_prev->vm_ops =3D &vm_ops; /* This should have no impact. */
>         vma =3D alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
>         vma->vm_ops =3D &vm_ops; /* This should have no impact. */
> @@ -1080,6 +1130,8 @@ static bool test_merge_existing(void)
>         ASSERT_TRUE(vma_write_started(vma_prev));
>         ASSERT_TRUE(vma_write_started(vma));
>         ASSERT_EQ(mm.map_count, 2);
> +       if (prev_is_sticky || middle_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
>
>         /* Clear down and reset. */
>         ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> @@ -1094,7 +1146,7 @@ static bool test_merge_existing(void)
>          * 0123456789
>          * PPPPPPP
>          */
> -       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> +       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
>         vma_prev->vm_ops =3D &vm_ops; /* This should have no impact. */
>         vma =3D alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
>         vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_=
anon_vma);
> @@ -1109,6 +1161,8 @@ static bool test_merge_existing(void)
>         ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma_prev));
>         ASSERT_EQ(mm.map_count, 1);
> +       if (prev_is_sticky || middle_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
>
>         /* Clear down and reset. We should have deleted vma. */
>         ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> @@ -1123,10 +1177,10 @@ static bool test_merge_existing(void)
>          * 0123456789
>          * PPPPPPPPPP
>          */
> -       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> +       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
>         vma_prev->vm_ops =3D &vm_ops; /* This should have no impact. */
>         vma =3D alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
> -       vma_next =3D alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags)=
;
> +       vma_next =3D alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, next_flag=
s);
>         vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_=
anon_vma);
>         vmg.prev =3D vma_prev;
>         vmg.middle =3D vma;
> @@ -1139,6 +1193,8 @@ static bool test_merge_existing(void)
>         ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
>         ASSERT_TRUE(vma_write_started(vma_prev));
>         ASSERT_EQ(mm.map_count, 1);
> +       if (prev_is_sticky || middle_is_sticky || next_is_sticky)
> +               ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
>
>         /* Clear down and reset. We should have deleted prev and next. */
>         ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> @@ -1158,9 +1214,9 @@ static bool test_merge_existing(void)
>          * PPPVVVVVNNN
>          */
>
> -       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> +       vma_prev =3D alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
>         vma =3D alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
> -       vma_next =3D alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags)=
;
> +       vma_next =3D alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, next_flag=
s);
>
>         vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
>         vmg.prev =3D vma;
> @@ -1203,6 +1259,19 @@ static bool test_merge_existing(void)
>         return true;
>  }
>
> +static bool test_merge_existing(void)
> +{
> +       int i, j, k;
> +
> +       /* Generate every possible permutation of sticky flags. */
> +       for (i =3D 0; i < 2; i++)
> +               for (j =3D 0; j < 2; j++)
> +                       for (k =3D 0; k < 2; k++)
> +                               ASSERT_TRUE(__test_merge_existing(i, j, k=
));
> +
> +       return true;
> +}
> +
>  static bool test_anon_vma_non_mergeable(void)
>  {
>         vm_flags_t vm_flags =3D VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYW=
RITE;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index e40c93edc5a7..3d9cb3a9411a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -117,6 +117,38 @@ extern unsigned long dac_mmap_min_addr;
>  #define VM_SEALED      VM_NONE
>  #endif
>
> +/* Flags which should result in page tables being copied on fork. */
> +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> +
> +/*
> + * Flags which should be 'sticky' on merge - that is, flags which, when =
one VMA
> + * possesses it but the other does not, the merged VMA should nonetheles=
s have
> + * applied to it:
> + *
> + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that =
contains
> + *                   metadata which should be unconditionally propagated=
 upon
> + *                   fork. When merging two VMAs, we encapsulate this ra=
nge in
> + *                   the merged VMA, so the flag should be 'sticky' as a=
 result.
> + */
> +#define VM_STICKY VM_COPY_ON_FORK
> +
> +/*
> + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessin=
g one
> + * of these flags and the other not does not preclude a merge.
> + *
> + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the f=
lags but
> + *                dirty bit -- the caller should mark merged VMA as dirt=
y. If
> + *                dirty bit won't be excluded from comparison, we increa=
se
> + *                pressure on the memory system forcing the kernel to ge=
nerate
> + *                new VMAs when old one could be extended instead.
> + *
> + *    VM_STICKY - If one VMA has flags which must be 'sticky', that is o=
nes
> + *                which should propagate to all VMAs, but the other does=
 not,
> + *                the merge should still proceed with the merge logic ap=
plying
> + *                sticky flags to the final VMA.
> + */
> +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> +
>  #define FIRST_USER_ADDRESS     0UL
>  #define USER_PGTABLES_CEILING  0UL
>
> --
> 2.51.0
>

