Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EDA365F9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhDTSoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhDTSoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:44:16 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB86C06138C
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 11:43:45 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r5so24704051ilb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKmdwef8NvpmmrAQ7mYZcx9GJzbbsHDuV6WIcarrWis=;
        b=XovCAIY0tLUPQt4UC6Ic21GdGt0n1X+eLaSd3lNkSwVf+1u+i6ZZLhWexxabjf3Jnj
         EQqmOWwDqiiJVAKqwIogmBe5SdHl19g94ChBFr117dDiGbyhAtvwuPdSYux0r2tBVefI
         Hm/vDaCnvKqyYYKlHdLRmcfT1zCJiEy/UNlt/JV4GRcJdwmDmrXLqyGhdNsgpTruIfu9
         ha2MMzC5MMAVbiZMwJAwGtNPkozGamXUFFWsnd4mxvAaX+2K+ZXnc/PNHJDz2EjgGwNs
         2fL+pQ2Ug8Z2SwRql4Sw4AJ6DyM7LMPDiBT9lAiouZiQ4FW5WsjW5cceFulJwG/YrEbP
         NBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKmdwef8NvpmmrAQ7mYZcx9GJzbbsHDuV6WIcarrWis=;
        b=nBbMScT3dFXflWiQr8n7+wGvfrZzH/zbUKonQzjltenwo5lqhgPvgmeAWnx8dTT5Pd
         0KoF8nZxT+48J4LOdx2U/72U9a0l3QTFkigC/V5OePS++U9VrrumWdj9XWfZkK/OsLBO
         eMDjCgfrRhdWFPFAzE3rT/6mN9rPwmsE2sZt7KhBJq2Ph0TBcOn3AN7KYPFsK/1OLvhG
         CEIu9cjSqrLSw+X+uGrkeb01aAZhzLOmiUWegWqzGFCXTUWm9mJ433MOMtuTWxEiL7VU
         2cUs+OHPtRKgjp2BnrYmJKsiz2ApVkxdngH1tmwZw5DJQgWPRLdrsX2tjOJkl1+V6NxX
         qyEQ==
X-Gm-Message-State: AOAM530T7RVYMfHuJViFgt8vg80xfGkdgFZX8MSLrjPLiohtg9HsmSwh
        lFDtY2j9R/VyziFixeC3al2G0VXF6uA49bUE3hEYOg==
X-Google-Smtp-Source: ABdhPJwcblTHChLirRlY5MfaJNxZFzYm2yu+MafO+vAOL0cPEAh7XqrjEUEoeolpoRqRpBC8WLa9S2V2Gdgq4ufuKws=
X-Received: by 2002:a05:6e02:1d06:: with SMTP id i6mr20526041ila.165.1618944224270;
 Tue, 20 Apr 2021 11:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-10-axelrasmussen@google.com> <alpine.LSU.2.11.2104161648020.25373@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2104161648020.25373@eggly.anvils>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 20 Apr 2021 11:43:06 -0700
Message-ID: <CAJHvVcgMGOsEfUQp=q_K7q+LmF8hqQv-C2_bX0Q_hyq_5iLFrQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] userfaultfd/shmem: modify shmem_mcopy_atomic_pte
 to use install_ptes
To:     Hugh Dickins <hughd@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 5:34 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 12 Apr 2021, Axel Rasmussen wrote:
>
> > In a previous commit, we added the mcopy_atomic_install_ptes() helper.
> > This helper does the job of setting up PTEs for an existing page, to map
> > it into a given VMA. It deals with both the anon and shmem cases, as
> > well as the shared and private cases.
> >
> > In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> > handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> > directly, to reduce code duplication.
> >
> > This requires that we refactor shmem_mcopy_atomic-pte() a bit:
> >
> > Instead of doing accounting (shmem_recalc_inode() et al) part-way
> > through the PTE setup, do it beforehand. This frees up
> > mcopy_atomic_install_ptes() from having to care about this accounting,
> > but it does mean we need to clean it up if we get a failure afterwards
> > (shmem_uncharge()).
> >
> > We can *almost* use shmem_charge() to do this, reducing code
> > duplication. But, it does `inode->i_mapping->nrpages++`, which would
> > double-count since shmem_add_to_page_cache() also does this.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  include/linux/userfaultfd_k.h |  5 ++++
> >  mm/shmem.c                    | 52 +++++++----------------------------
> >  mm/userfaultfd.c              | 25 ++++++++---------
> >  3 files changed, 27 insertions(+), 55 deletions(-)
>
> Very nice, and it gets better.
>
> >
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 794d1538b8ba..3e20bfa9ef80 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
> >       MCOPY_ATOMIC_CONTINUE,
> >  };
> >
> > +extern int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>
> mcopy_atomic_install_pte throughout as before.
>
> > +                                  struct vm_area_struct *dst_vma,
> > +                                  unsigned long dst_addr, struct page *page,
> > +                                  bool newly_allocated, bool wp_copy);
> > +
> >  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> >                           unsigned long src_start, unsigned long len,
> >                           bool *mmap_changing, __u64 mode);
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 3f48cb5e8404..9b12298405a4 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2376,10 +2376,8 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       struct address_space *mapping = inode->i_mapping;
> >       gfp_t gfp = mapping_gfp_mask(mapping);
> >       pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> > -     spinlock_t *ptl;
> >       void *page_kaddr;
> >       struct page *page;
> > -     pte_t _dst_pte, *dst_pte;
> >       int ret;
> >       pgoff_t max_off;
> >
> > @@ -2389,8 +2387,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >
> >       if (!*pagep) {
> >               page = shmem_alloc_page(gfp, info, pgoff);
> > -             if (!page)
> > -                     goto out_unacct_blocks;
> > +             if (!page) {
> > +                     shmem_inode_unacct_blocks(inode, 1);
> > +                     goto out;
> > +             }
> >
> >               if (!zeropage) {        /* COPY */
> >                       page_kaddr = kmap_atomic(page);
> > @@ -2430,59 +2430,27 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       if (ret)
> >               goto out_release;
> >
> > -     _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > -     if (dst_vma->vm_flags & VM_WRITE)
> > -             _dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> > -     else {
> > -             /*
> > -              * We don't set the pte dirty if the vma has no
> > -              * VM_WRITE permission, so mark the page dirty or it
> > -              * could be freed from under us. We could do it
> > -              * unconditionally before unlock_page(), but doing it
> > -              * only if VM_WRITE is not set is faster.
> > -              */
> > -             set_page_dirty(page);
> > -     }
> > -
> > -     dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > -
> > -     ret = -EFAULT;
> > -     max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > -     if (unlikely(pgoff >= max_off))
> > -             goto out_release_unlock;
> > -
> > -     ret = -EEXIST;
> > -     if (!pte_none(*dst_pte))
> > -             goto out_release_unlock;
> > -
> > -     lru_cache_add(page);
> > -
> >       spin_lock_irq(&info->lock);
> >       info->alloced++;
> >       inode->i_blocks += BLOCKS_PER_PAGE;
> >       shmem_recalc_inode(inode);
> >       spin_unlock_irq(&info->lock);
> >
> > -     inc_mm_counter(dst_mm, mm_counter_file(page));
> > -     page_add_file_rmap(page, false);
> > -     set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > +     ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
> > +                                     page, true, false);
> > +     if (ret)
> > +             goto out_release_uncharge;
> >
> > -     /* No need to invalidate - it was non-present before */
> > -     update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > -     pte_unmap_unlock(dst_pte, ptl);
>
> In reviewing 4/9, I said to take out mcopy_atomic_install_pte()'s
> set_page_dirty().  Just call it here instead, before the unlock_page().
> You have an array of choices for how to write it:
>
>         if (!(dst_vma->vm_flags & VM_WRITE))
>                 set_page_dirty(page);
> or
>         if (!(dst_vma->vm_flags & VM_WRITE))
>                 SetPageDirty(page);
> or
>         set_page_dirty(page);
> or
>         SetPageDirty(page);
>
> Personally, I'd go for the last: this function has just modified the
> page, so it ought to mark it dirty: without second-guessing what
> mcopy_atomic_install_pte() might do to make that redundant in the
> VM_WRITE case. set_page_dirty() or SetPageDirty()? Some years ago
> I tended to favour the former for its preparatory PageDirty check;
> nowadays (on shmem) I favour the latter, to avoid the function call
> indirection which became more expensive with spectre+retpoline.

Now reaching this comment after looking through patch 4:

Ah, this makes sense. I agree this is clearer too, as it doesn't split
the concern across two files / functions.

>
> >       unlock_page(page);
> >       ret = 0;
> >  out:
> >       return ret;
> > -out_release_unlock:
> > -     pte_unmap_unlock(dst_pte, ptl);
> > -     ClearPageDirty(page);
> > +out_release_uncharge:
>
> Given how 4/9 was, this did still need the ClearPageDirty()
> before delete_from_page_cache(), to prevent a warning.
> But not needed here if SPD is done just before unlock_page().
>
> >       delete_from_page_cache(page);
> > +     shmem_uncharge(inode, 1);
> >  out_release:
> >       unlock_page(page);
> >       put_page(page);
> > -out_unacct_blocks:
> > -     shmem_inode_unacct_blocks(inode, 1);
> >       goto out;
> >  }
> >  #endif /* CONFIG_USERFAULTFD */
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 8df0438f5d6a..3f73ba0b99f0 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -51,18 +51,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> >  /*
> >   * Install PTEs, to map dst_addr (within dst_vma) to page.
> >   *
> > - * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> > - * whether or not dst_vma is VM_SHARED. It also handles the more general
> > - * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> > - * backed, or not).
> > - *
> > - * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> > - * shmem_mcopy_atomic_pte instead.
> > + * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both shmem
> > + * and anon, and for both shared and private VMAs.
> >   */
> > -static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > -                                  struct vm_area_struct *dst_vma,
> > -                                  unsigned long dst_addr, struct page *page,
> > -                                  bool newly_allocated, bool wp_copy)
> > +int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +                           struct vm_area_struct *dst_vma,
> > +                           unsigned long dst_addr, struct page *page,
> > +                           bool newly_allocated, bool wp_copy)
> >  {
> >       int ret;
> >       pte_t _dst_pte, *dst_pte;
> > @@ -116,8 +111,12 @@ static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >       else
> >               page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> >
> > -     if (newly_allocated)
> > -             lru_cache_add_inactive_or_unevictable(page, dst_vma);
> > +     if (newly_allocated) {
> > +             if (vma_is_shmem(dst_vma) && vm_shared)
> > +                     lru_cache_add(page);
> > +             else
> > +                     lru_cache_add_inactive_or_unevictable(page, dst_vma);
> > +     }
>
> This change is not required, you'll be glad to hear. Take a look at
> lru_cache_add_inactive_or_unevictable() in mm/swap.c: it's a wrapper
> to set PageMlocked and do associated accounting (if appropriate) before
> doing the lru_cache_add(page).  And, strictly speaking, should have been
> used in shmem_mcopy_atomic_pte() all along.
>
> I say "strictly speaking" because it would be exceptional to find a page
> needing Mlock there, and not an error to delay that Mlock until sometime
> later, before reclaim.  Worth a sentence in the commit message,
> but not worth a "Fixes:" tag.

This makes sense. I had considered doing this before, but took a brief
look at the functions and saw they were indeed different. But looking
more closely, you're right that the wrapper is only different if some
particular conditions are true, and so is fine to use in other cases.

>
> >
> >       set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> >
> > --
> > 2.31.1.295.g9ea45b61b8-goog
