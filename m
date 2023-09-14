Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2247A0F5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 22:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjINU6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjINU6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:58:06 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63D2698
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 13:58:02 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7e9d849bdfso1432896276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725081; x=1695329881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj/wwi/gKNbN0cRs9LFKNubTY2z7wAUN2NGVOlquC8U=;
        b=A+Q3fbHopYd8NbFZfl1uPmEJhUJLePjE0C/SfTIlk4nhTjlKnfFbL1LD2mr12W/DnW
         zaxTF1Ms/ride9KNuxujfLHabFqAra6YXfY1yJjPiNQCXKjfLmYFeidPqQwGNnSMBYlL
         UKprXcwFf5FQgKCcJIMO6AJgT9CqZKUYYTU0LQ0cdmY5gx1meFpumNDdyYtzKHkcVpi+
         yyfLkX91YQCQB/ZcKc6dzlJnaIPrCG6gXeBZgnu8L62bk0gYR9btY7KaudDBwi1AsStd
         PP/710N2TMT2jdtYgfZXAhw7W+gD6cqEnx4CSIOBqGYn0K9TfQnZ1rdY5Vst433hxual
         MyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725081; x=1695329881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj/wwi/gKNbN0cRs9LFKNubTY2z7wAUN2NGVOlquC8U=;
        b=R/Pqe60fpJrrUSuwCeK57lXZTKp0UQcu+37jS0wi2Yuxvr/yxkY6FIzKJvpjdHvHKj
         ebgWG7aHl+VwKAxSqoy3/Ug4fsVq/ictjeASft2BGYcmTErxa5yhr926vRwOA8hdNpiX
         ww7byuJGVLmeUU6GwRGj7bf/HT4bHLnoiQ7/Dq51OJTnjRn/HwAMb7TC4kFbO33GR65T
         7wnvZDDzmAFFqiofvGLuD11FszOfDC6jA25qHl6SxGnMpHjq5Rwdq7KISoaOIV05HahE
         NCcpltOyckbVGpme7h6uqeI0jbBRf9rmJAxgM5JwEvL75VCdZQJWHxHyPuDFvHE8VmL/
         U7Tg==
X-Gm-Message-State: AOJu0YzimuPG+6nuewc90gJEyPS347zC0tcRIrKq7el+4lbkTQNzP/pe
        HJYQblxCfiaokqbP4L0qcu5EKgrbv1xW/T3yuLmYJA==
X-Google-Smtp-Source: AGHT+IFb+DFusOfoudYZNLKEw+umy24emEPWGft1R8mDFEev9jc/QlrOTG+2wXyGehjQQBSFPjLlZZFHUyLD0QD6AS4=
X-Received: by 2002:a5b:5cb:0:b0:d81:504f:f886 with SMTP id
 w11-20020a5b05cb000000b00d81504ff886mr5824338ybp.13.1694725081214; Thu, 14
 Sep 2023 13:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <CAG48ez0gN_nC8NrMOeq44QmUDT27EpT0bFuNu1ReVKDBt3zy7Q@mail.gmail.com>
In-Reply-To: <CAG48ez0gN_nC8NrMOeq44QmUDT27EpT0bFuNu1ReVKDBt3zy7Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 13:57:49 -0700
Message-ID: <CAJuCfpEf4MpbQS7+m2_PZboY=PAWzCckwawX=u55KUC70Lb-Vg@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 12:28=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
>
> On Thu, Sep 14, 2023 at 5:26=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > This implements the uABI of UFFDIO_REMAP.
> >
> > Notably one mode bitflag is also forwarded (and in turn known) by the
> > lowlevel remap_pages method.
> >
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/userfaultfd.c                 |  49 +++
> >  include/linux/rmap.h             |   5 +
> >  include/linux/userfaultfd_k.h    |  17 +
> >  include/uapi/linux/userfaultfd.h |  22 ++
> >  mm/huge_memory.c                 | 118 +++++++
> >  mm/khugepaged.c                  |   3 +
> >  mm/userfaultfd.c                 | 586 +++++++++++++++++++++++++++++++
> >  7 files changed, 800 insertions(+)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 56eaae9dac1a..7bf64e7541c1 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -2027,6 +2027,52 @@ static inline unsigned int uffd_ctx_features(__u=
64 user_features)
> >         return (unsigned int)user_features | UFFD_FEATURE_INITIALIZED;
> >  }
> >
> > +static int userfaultfd_remap(struct userfaultfd_ctx *ctx,
> > +                            unsigned long arg)
> > +{
> > +       __s64 ret;
> > +       struct uffdio_remap uffdio_remap;
> > +       struct uffdio_remap __user *user_uffdio_remap;
> > +       struct userfaultfd_wake_range range;
> > +
> > +       user_uffdio_remap =3D (struct uffdio_remap __user *) arg;
> > +
> > +       ret =3D -EFAULT;
> > +       if (copy_from_user(&uffdio_remap, user_uffdio_remap,
> > +                          /* don't copy "remap" last field */
> > +                          sizeof(uffdio_remap)-sizeof(__s64)))
> > +               goto out;
> > +
> > +       ret =3D validate_range(ctx->mm, uffdio_remap.dst, uffdio_remap.=
len);
> > +       if (ret)
> > +               goto out;
> > +       ret =3D validate_range(current->mm, uffdio_remap.src, uffdio_re=
map.len);
> > +       if (ret)
> > +               goto out;
> > +       ret =3D -EINVAL;
> > +       if (uffdio_remap.mode & ~(UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES|
> > +                                 UFFDIO_REMAP_MODE_DONTWAKE))
> > +               goto out;
>
> Do you not need mmget_not_zero(ctx->mm) to make sure the MM can't be
> concurrently torn down while remap_pages() is running, similar to what
> the other userfaultfd ioctl handlers do?
>
> > +       ret =3D remap_pages(ctx->mm, current->mm,
> > +                         uffdio_remap.dst, uffdio_remap.src,
> > +                         uffdio_remap.len, uffdio_remap.mode);
> > +       if (unlikely(put_user(ret, &user_uffdio_remap->remap)))
> > +               return -EFAULT;
> > +       if (ret < 0)
> > +               goto out;
> > +       /* len =3D=3D 0 would wake all */
> > +       BUG_ON(!ret);
> > +       range.len =3D ret;
> > +       if (!(uffdio_remap.mode & UFFDIO_REMAP_MODE_DONTWAKE)) {
> > +               range.start =3D uffdio_remap.dst;
> > +               wake_userfault(ctx, &range);
> > +       }
> > +       ret =3D range.len =3D=3D uffdio_remap.len ? 0 : -EAGAIN;
> > +out:
> > +       return ret;
> > +}
> [...]
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 064fbd90822b..c7a9880a1f6a 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1932,6 +1932,124 @@ int change_huge_pmd(struct mmu_gather *tlb, str=
uct vm_area_struct *vma,
> >         return ret;
> >  }
> >
> > +#ifdef CONFIG_USERFAULTFD
> > +/*
> > + * The PT lock for src_pmd and the mmap_lock for reading are held by
> > + * the caller, but it must return after releasing the
> > + * page_table_lock. We're guaranteed the src_pmd is a pmd_trans_huge
> > + * until the PT lock of the src_pmd is released. Just move the page
> > + * from src_pmd to dst_pmd if possible. Return zero if succeeded in
> > + * moving the page, -EAGAIN if it needs to be repeated by the caller,
> > + * or other errors in case of failure.
> > + */
> > +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> > +                        struct mm_struct *src_mm,
> > +                        pmd_t *dst_pmd, pmd_t *src_pmd,
> > +                        pmd_t dst_pmdval,
> > +                        struct vm_area_struct *dst_vma,
> > +                        struct vm_area_struct *src_vma,
> > +                        unsigned long dst_addr,
> > +                        unsigned long src_addr)
> > +{
> > +       pmd_t _dst_pmd, src_pmdval;
> > +       struct page *src_page;
> > +       struct anon_vma *src_anon_vma, *dst_anon_vma;
> > +       spinlock_t *src_ptl, *dst_ptl;
> > +       pgtable_t pgtable;
> > +       struct mmu_notifier_range range;
> > +
> > +       src_pmdval =3D *src_pmd;
> > +       src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> > +
> > +       BUG_ON(!pmd_trans_huge(src_pmdval));
> > +       BUG_ON(!pmd_none(dst_pmdval));
>
> Why can we assert that pmd_none(dst_pmdval) is true here? Can we not
> have concurrent faults (or userfaultfd operations) populating that
> PMD?
>
> > +       BUG_ON(!spin_is_locked(src_ptl));
> > +       mmap_assert_locked(src_mm);
> > +       mmap_assert_locked(dst_mm);
> > +       BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> > +       BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> > +
> > +       src_page =3D pmd_page(src_pmdval);
> > +       BUG_ON(!PageHead(src_page));
> > +       BUG_ON(!PageAnon(src_page));
> > +       if (unlikely(page_mapcount(src_page) !=3D 1)) {
> > +               spin_unlock(src_ptl);
> > +               return -EBUSY;
> > +       }
> > +
> > +       get_page(src_page);
> > +       spin_unlock(src_ptl);
> > +
> > +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, sr=
c_addr,
> > +                               src_addr + HPAGE_PMD_SIZE);
> > +       mmu_notifier_invalidate_range_start(&range);
> > +
> > +       /* block all concurrent rmap walks */
> > +       lock_page(src_page);
> > +
> > +       /*
> > +        * split_huge_page walks the anon_vma chain without the page
> > +        * lock. Serialize against it with the anon_vma lock, the page
> > +        * lock is not enough.
> > +        */
> > +       src_anon_vma =3D folio_get_anon_vma(page_folio(src_page));
> > +       if (!src_anon_vma) {
> > +               unlock_page(src_page);
> > +               put_page(src_page);
> > +               mmu_notifier_invalidate_range_end(&range);
> > +               return -EAGAIN;
> > +       }
> > +       anon_vma_lock_write(src_anon_vma);
> > +
> > +       dst_ptl =3D pmd_lockptr(dst_mm, dst_pmd);
> > +       double_pt_lock(src_ptl, dst_ptl);
> > +       if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
> > +                    !pmd_same(*dst_pmd, dst_pmdval) ||
> > +                    page_mapcount(src_page) !=3D 1)) {
> > +               double_pt_unlock(src_ptl, dst_ptl);
> > +               anon_vma_unlock_write(src_anon_vma);
> > +               put_anon_vma(src_anon_vma);
> > +               unlock_page(src_page);
> > +               put_page(src_page);
> > +               mmu_notifier_invalidate_range_end(&range);
> > +               return -EAGAIN;
> > +       }
> > +
> > +       BUG_ON(!PageHead(src_page));
> > +       BUG_ON(!PageAnon(src_page));
> > +       /* the PT lock is enough to keep the page pinned now */
> > +       put_page(src_page);
> > +
> > +       dst_anon_vma =3D (void *) dst_vma->anon_vma + PAGE_MAPPING_ANON=
;
> > +       WRITE_ONCE(src_page->mapping, (struct address_space *) dst_anon=
_vma);
> > +       WRITE_ONCE(src_page->index, linear_page_index(dst_vma, dst_addr=
));
> > +
> > +       if (!pmd_same(pmdp_huge_clear_flush(src_vma, src_addr, src_pmd)=
,
> > +                     src_pmdval))
> > +               BUG_ON(1);
>
> I'm not sure we can assert that the PMDs are exactly equal; the CPU
> might have changed the A/D bits under us?
>
> > +       _dst_pmd =3D mk_huge_pmd(src_page, dst_vma->vm_page_prot);
> > +       _dst_pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
> > +       set_pmd_at(dst_mm, dst_addr, dst_pmd, _dst_pmd);
> > +
> > +       pgtable =3D pgtable_trans_huge_withdraw(src_mm, src_pmd);
> > +       pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
>
> Are we allowed to move page tables between mm_structs on all
> architectures? The first example I found that looks a bit dodgy,
> looking through various architectures' pte_alloc_one(), is s390's
> page_table_alloc() which looks like page tables are tied to per-MM
> lists sometimes.
> If that's not allowed, we might have to allocate a new deposit table
> and free the old one or something like that.
>
> > +       if (dst_mm !=3D src_mm) {
> > +               add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> > +               add_mm_counter(src_mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > +       }
> > +       double_pt_unlock(src_ptl, dst_ptl);
> > +
> > +       anon_vma_unlock_write(src_anon_vma);
> > +       put_anon_vma(src_anon_vma);
> > +
> > +       /* unblock rmap walks */
> > +       unlock_page(src_page);
> > +
> > +       mmu_notifier_invalidate_range_end(&range);
> > +       return 0;
> > +}
> > +#endif /* CONFIG_USERFAULTFD */
> > +
> >  /*
> >   * Returns page table lock pointer if a given pmd maps a thp, NULL oth=
erwise.
> >   *
> [...]
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 96d9eae5c7cc..0cca60dfa8f8 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> [...]
> > +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm=
,
> > +                   unsigned long dst_start, unsigned long src_start,
> > +                   unsigned long len, __u64 mode)
> > +{
> [...]
> > +
> > +       if (pgprot_val(src_vma->vm_page_prot) !=3D
> > +           pgprot_val(dst_vma->vm_page_prot))
> > +               goto out;
>
> Does this check intentionally allow moving pages from a
> PROT_READ|PROT_WRITE anonymous private VMA into a PROT_READ anonymous
> private VMA (on architectures like x86 and arm64 where CoW memory has
> the same protection flags as read-only memory), but forbid moving them
> from a PROT_READ|PROT_EXEC VMA into a PROT_READ VMA? I think this
> check needs at least a comment to explain what's going on here.
>
> > +       /* only allow remapping if both are mlocked or both aren't */
> > +       if ((src_vma->vm_flags & VM_LOCKED) ^ (dst_vma->vm_flags & VM_L=
OCKED))
> > +               goto out;
> > +
> > +       /*
> > +        * Be strict and only allow remap_pages if either the src or
> > +        * dst range is registered in the userfaultfd to prevent
> > +        * userland errors going unnoticed. As far as the VM
> > +        * consistency is concerned, it would be perfectly safe to
> > +        * remove this check, but there's no useful usage for
> > +        * remap_pages ouside of userfaultfd registered ranges. This
> > +        * is after all why it is an ioctl belonging to the
> > +        * userfaultfd and not a syscall.
> > +        *
> > +        * Allow both vmas to be registered in the userfaultfd, just
> > +        * in case somebody finds a way to make such a case useful.
> > +        * Normally only one of the two vmas would be registered in
> > +        * the userfaultfd.
> > +        */
> > +       if (!dst_vma->vm_userfaultfd_ctx.ctx &&
> > +           !src_vma->vm_userfaultfd_ctx.ctx)
> > +               goto out;
> > +
> > +       /*
> > +        * FIXME: only allow remapping across anonymous vmas,
> > +        * tmpfs should be added.
> > +        */
> > +       if (src_vma->vm_ops || dst_vma->vm_ops)
> > +               goto out;
>
> I don't think it's okay to check for anonymous VMAs by checking
> ->vm_ops. There are some weird drivers whose ->mmap helpers don't set
> ->vm_ops and instead just shove all the necessary PTEs into the VMA
> right on ->mmap, so I think they end up with ->vm_ops=3D=3DNULL. For
> example, kcov_mmap() looks that way. I'm not sure how common this is.
>
> Though, uuuuuh, I guess if that's true, the existing
> vma_is_anonymous() is broken, since that also just checks ->vm_ops?
> I'm not sure what the consequences of that would be... Either way,
> vma_is_anonymous() might be the better way to check for anonymous VMAs
> here, and someone should figure out whether vma_is_anonymous() needs
> to be fixed.
>
> > +       /*
> > +        * Ensure the dst_vma has a anon_vma or this page
> > +        * would get a NULL anon_vma when moved in the
> > +        * dst_vma.
> > +        */
> > +       err =3D -ENOMEM;
> > +       if (unlikely(anon_vma_prepare(dst_vma)))
> > +               goto out;
> > +
> > +       for (src_addr =3D src_start, dst_addr =3D dst_start;
> > +            src_addr < src_start + len;) {
> > +               spinlock_t *ptl;
> > +               pmd_t dst_pmdval;
> > +
> > +               BUG_ON(dst_addr >=3D dst_start + len);
> > +               src_pmd =3D mm_find_pmd(src_mm, src_addr);
>
> (this would blow up pretty badly if we could have transparent huge PUD
> in the region but I think that's limited to file VMAs so it's fine as
> it currently is)
>
> > +               if (unlikely(!src_pmd)) {
> > +                       if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES)=
) {
> > +                               err =3D -ENOENT;
> > +                               break;
> > +                       }
> > +                       src_pmd =3D mm_alloc_pmd(src_mm, src_addr);
> > +                       if (unlikely(!src_pmd)) {
> > +                               err =3D -ENOMEM;
> > +                               break;
> > +                       }
> > +               }
> > +               dst_pmd =3D mm_alloc_pmd(dst_mm, dst_addr);
> > +               if (unlikely(!dst_pmd)) {
> > +                       err =3D -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > +               /*
> > +                * If the dst_pmd is mapped as THP don't
> > +                * override it and just be strict.
> > +                */
> > +               if (unlikely(pmd_trans_huge(dst_pmdval))) {
> > +                       err =3D -EEXIST;
> > +                       break;
> > +               }
>
> This check is racy because the dst_pmd can still change at this point,
> from previously pointing to a zeroed PMD to now pointing to a
> hugepage, right? And we rely on remap_pages_pte() and
> remap_pages_huge_pmd() to recheck for that?
> If yes, maybe add a comment noting this and explaining why we want this c=
heck.
>
> > +               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > +               if (ptl) {
> > +                       /*
> > +                        * Check if we can move the pmd without
> > +                        * splitting it. First check the address
> > +                        * alignment to be the same in src/dst.  These
> > +                        * checks don't actually need the PT lock but
> > +                        * it's good to do it here to optimize this
> > +                        * block away at build time if
> > +                        * CONFIG_TRANSPARENT_HUGEPAGE is not set.
> > +                        */
> > +                       if (thp_aligned =3D=3D -1)
> > +                               thp_aligned =3D ((src_addr & ~HPAGE_PMD=
_MASK) =3D=3D
> > +                                              (dst_addr & ~HPAGE_PMD_M=
ASK));
> > +                       if (!thp_aligned || (src_addr & ~HPAGE_PMD_MASK=
) ||
>
> This seems overly complicated, the only case when you can move a huge
> PMD is if both addresses are hugepage-aligned and you have enough
> length for one hugepage:
>
> (src_addr & ~HPAGE_PMD_MASK) =3D=3D 0 && (dst_addr & ~HPAGE_PMD_MASK) =3D=
=3D 0
> && (src_start + len - src_addr >=3D HPAGE_PMD_SIZE).
>
> > +                           !pmd_none(dst_pmdval) ||
> > +                           src_start + len - src_addr < HPAGE_PMD_SIZE=
) {
> > +                               spin_unlock(ptl);
> > +                               /* Fall through */
> > +                               split_huge_pmd(src_vma, src_pmd, src_ad=
dr);
> > +                       } else {
> > +                               err =3D remap_pages_huge_pmd(dst_mm,
> > +                                                          src_mm,
> > +                                                          dst_pmd,
> > +                                                          src_pmd,
> > +                                                          dst_pmdval,
> > +                                                          dst_vma,
> > +                                                          src_vma,
> > +                                                          dst_addr,
> > +                                                          src_addr);
> > +                               cond_resched();
> > +
> > +                               if (!err) {
> > +                                       dst_addr +=3D HPAGE_PMD_SIZE;
> > +                                       src_addr +=3D HPAGE_PMD_SIZE;
> > +                                       moved +=3D HPAGE_PMD_SIZE;
> > +                               }
> > +
> > +                               if ((!err || err =3D=3D -EAGAIN) &&
> > +                                   fatal_signal_pending(current))
> > +                                       err =3D -EINTR;
> > +
> > +                               if (err && err !=3D -EAGAIN)
> > +                                       break;
> > +
> > +                               continue;
> > +                       }
> > +               }
> > +
> > +               if (pmd_none(*src_pmd)) {
> > +                       if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES)=
) {
> > +                               err =3D -ENOENT;
> > +                               break;
> > +                       }
> > +                       if (unlikely(__pte_alloc(src_mm, src_pmd))) {
> > +                               err =3D -ENOMEM;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (unlikely(pmd_none(dst_pmdval)) &&
> > +                   unlikely(__pte_alloc(dst_mm, dst_pmd))) {
>
> Maybe just use pte_alloc() here?
>
> > +                       err =3D -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               err =3D remap_pages_pte(dst_mm, src_mm,
> > +                                     dst_pmd, src_pmd,
> > +                                     dst_vma, src_vma,
> > +                                     dst_addr, src_addr,
> > +                                     mode);
> > +
> > +               cond_resched();
> > +
> > +               if (!err) {
> > +                       dst_addr +=3D PAGE_SIZE;
> > +                       src_addr +=3D PAGE_SIZE;
> > +                       moved +=3D PAGE_SIZE;
> > +               }
> > +
> > +               if ((!err || err =3D=3D -EAGAIN) &&
> > +                   fatal_signal_pending(current))
> > +                       err =3D -EINTR;
> > +
> > +               if (err && err !=3D -EAGAIN)
> > +                       break;
> > +       }
> > +
> > +out:
> > +       mmap_read_unlock(dst_mm);
> > +       if (dst_mm !=3D src_mm)
> > +               mmap_read_unlock(src_mm);
> > +       BUG_ON(moved < 0);
> > +       BUG_ON(err > 0);
> > +       BUG_ON(!moved && !err);
> > +       return moved ? moved : err;
> > +}
>
> Maybe you could try whether this function would look simpler with a
> shape roughly like:
>
> for (src_addr =3D ...; src_addr < ...;) {
>   unsigned long step_size;
>
>   if (hugepage case) {
>     if (have to split) {
>       split it;
>       continue;
>     }
>     step_size =3D HPAGE_PMD_SIZE;
>     ...
>   } else {
>     ... 4k case ...
>     step_size =3D PAGE_SIZE;
>   }
>   ...
>   cond_resched();
>   if (!err) {
>     dst_addr +=3D step_size;
>     src_addr +=3D step_size;
>     moved +=3D step_size;
>   }
>   ...
> }

I'll need some time to gather the answers to all your questions and
will reply once I have them ready.
Thanks for reviewing, Jann!
