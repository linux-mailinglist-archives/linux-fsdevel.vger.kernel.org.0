Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4434F512
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 01:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhC3XbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhC3Xav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:30:51 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B0C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 16:30:50 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id c17so15611251ilj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o671+X957x3ohIb8lZy+lC6mbupaAR79VW4I7NvzAKM=;
        b=q3+rZbXz4Tlokww2KCM+zuxWcJwwrl95Q65TPi93mxksx1cxTwhxtRQthFoKlW/aaE
         xYID/mh8kTYSBSFSfeMbQi09UlsGYuv8sTi/J70kP03kPtupVHpt9VM/2P9gZqtyP8Mv
         BkqWQSDaOHMyIQHFlG5WOBGaB6HIzl/+hJoq3s8i1M+lLfy/3H7DnwEUm82xCg/zAUNA
         jg7s43cR2owsrmQgLifKwSvKOxA9Aac0QfDYalUL1M0kAly1px5zGaIeprVHZmph+p9s
         VD6+cGjT+xJe4apJ1QbLt4mEgkKKQJ15CYKhdnnztORfoWmXVvrLogqWQow8RAfchHEl
         8j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o671+X957x3ohIb8lZy+lC6mbupaAR79VW4I7NvzAKM=;
        b=EO/ZkCoLNISEAnGVZRfhCYhCqGcSpnEyBvqy4qiCSbV5o0EzyqNdqxjfgKH5qoiPIu
         aAYla//v5FrCfHlRcOY59eIw4lpo9M+dYY4crzTodTU0Bmw/KvJ5mRXeKv7tc/QVTlJn
         VvxGGwWZes4osZoUxRsP4aY/UiRq6pz1AX769P3lX93Z1TvpcQXMpBFv0ASOwE2/UHtB
         Eicnd9P7ki87TJPQjXKTRf6AUKNJ+G/ZfM24wPkAFwPXCY1DNbZONRKeJKpR30RRuuCB
         LyfqlLNt2DG4P9n8L7WMG6VqGy2A/JrAu/j1fKoLafCRrjTVof/3kaja5bVxKqb3qMps
         7BxQ==
X-Gm-Message-State: AOAM53273n8DpIXtg0RPh1ayFcltoy6uS1xJ3wNK0QTS8wfmRsVn4Flh
        9O8zN0aVklHVct/QGC62+qiveBAw9Cqy4/aLcdeALQ==
X-Google-Smtp-Source: ABdhPJzmBW6GzmEVr5Cuj8rTTicENZCXn7A7uW/m9mCcv0pU4T0pZyDhXHJKXWKktFLUDdPAX+wHrIkVeNo8GZEDhXY=
X-Received: by 2002:a05:6e02:ee3:: with SMTP id j3mr520900ilk.85.1617147049699;
 Tue, 30 Mar 2021 16:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210329234131.304999-1-axelrasmussen@google.com> <20210330205519.GK429942@xz-x1>
In-Reply-To: <20210330205519.GK429942@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 30 Mar 2021 16:30:13 -0700
Message-ID: <CAJHvVcikF9MJepyvf6riVKZEUxQvV1QMdoQoN5Kirs0TLcn-Dg@mail.gmail.com>
Subject: Re: [PATCH v3] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE behavior
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 1:55 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 29, 2021 at 04:41:31PM -0700, Axel Rasmussen wrote:
> > Previously, we shared too much of the code with COPY and ZEROPAGE, so we
> > manipulated things in various invalid ways:
> >
> > - Previously, we unconditionally called shmem_inode_acct_block. In the
> >   continue case, we're looking up an existing page which would have been
> >   accounted for properly when it was allocated. So doing it twice
> >   results in double-counting, and eventually leaking.
> >
> > - Previously, we made the pte writable whenever the VMA was writable.
> >   However, for continue, consider this case:
> >
> >   1. A tmpfs file was created
> >   2. The non-UFFD-registered side mmap()-s with MAP_SHARED
> >   3. The UFFD-registered side mmap()-s with MAP_PRIVATE
> >
> >   In this case, even though the UFFD-registered VMA may be writable, we
> >   still want CoW behavior. So, check for this case and don't make the
> >   pte writable.
> >
> > - The initial pgoff / max_off check isn't necessary, so we can skip past
> >   it. The second one seems likely to be unnecessary too, but keep it
> >   just in case. Modify both checks to use pgoff, as offset is equivalent
> >   and not needed.
> >
> > - Previously, we unconditionally called ClearPageDirty() in the error
> >   path. In the continue case though, since this is an existing page, it
> >   might have already been dirty before we started touching it. It's very
> >   problematic to clear the bit incorrectly, but not a problem to leave
> >   it - so, just omit the ClearPageDirty() entirely.
> >
> > - Previously, we unconditionally removed the page from the page cache in
> >   the error path. But in the continue case, we didn't add it - it was
> >   already there because the page is present in some second
> >   (non-UFFD-registered) mapping. So, removing it is invalid.
> >
> > Because the error handling issues are easy to exercise in the selftest,
> > make a small modification there to do so.
> >
> > Finally, refactor shmem_mcopy_atomic_pte a bit. By this point, we've
> > added a lot of "if (!is_continue)"-s everywhere. It's cleaner to just
> > check for that mode first thing, and then "goto" down to where the parts
> > we actually want are. This leaves the code in between cleaner.
> >
> > Changes since v2:
> > - Drop the ClearPageDirty() entirely, instead of trying to remember the
> >   old value.
> > - Modify both pgoff / max_off checks to use pgoff. It's equivalent to
> >   offset, but offset wasn't initialized until the first check (which
> >   we're skipping).
> > - Keep the second pgoff / max_off check in the continue case.
> >
> > Changes since v1:
> > - Refactor to skip ahead with goto, instead of adding several more
> >   "if (!is_continue)".
> > - Fix unconditional ClearPageDirty().
> > - Don't pte_mkwrite() when is_continue && !VM_SHARED.
> >
> > Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  mm/shmem.c                               | 60 +++++++++++++-----------
> >  tools/testing/selftests/vm/userfaultfd.c | 12 +++++
> >  2 files changed, 44 insertions(+), 28 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index d2e0e81b7d2e..fbcce850a16e 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2377,18 +2377,22 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >       struct page *page;
> >       pte_t _dst_pte, *dst_pte;
> >       int ret;
> > -     pgoff_t offset, max_off;
> > -
> > -     ret = -ENOMEM;
> > -     if (!shmem_inode_acct_block(inode, 1))
> > -             goto out;
> > +     pgoff_t max_off;
> > +     int writable;
>
> Nit: can be bool.
>
> [...]
>
> > +install_ptes:
> >       _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > -     if (dst_vma->vm_flags & VM_WRITE)
> > +     /* For CONTINUE on a non-shared VMA, don't pte_mkwrite for CoW. */
> > +     writable = is_continue && !(dst_vma->vm_flags & VM_SHARED)
> > +             ? 0
> > +             : dst_vma->vm_flags & VM_WRITE;
>
> Nit: this code is slightly hard to read..  I'd slightly prefer "if
> (is_continue)...".  But more below.
>
> > +     if (writable)
> >               _dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> >       else {
> >               /*
> > @@ -2455,7 +2458,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >
> >       ret = -EFAULT;
> >       max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > -     if (unlikely(offset >= max_off))
> > +     if (unlikely(pgoff >= max_off))
> >               goto out_release_unlock;
> >
> >       ret = -EEXIST;
> > @@ -2485,13 +2488,14 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >       return ret;
> >  out_release_unlock:
> >       pte_unmap_unlock(dst_pte, ptl);
> > -     ClearPageDirty(page);
> > -     delete_from_page_cache(page);
> > +     if (!is_continue)
> > +             delete_from_page_cache(page);
> >  out_release:
> >       unlock_page(page);
> >       put_page(page);
> >  out_unacct_blocks:
> > -     shmem_inode_unacct_blocks(inode, 1);
> > +     if (!is_continue)
> > +             shmem_inode_unacct_blocks(inode, 1);
>
> If you see we still have tons of "if (!is_continue)".  Those are the places
> error prone.. even if not in this patch, could be in the patch when this
> function got changed again.
>
> Sorry to say this a bit late: how about introduce a helper to install the pte?

No worries. :)

> Pesudo code:
>
> int shmem_install_uffd_pte(..., bool writable)
> {
>         ...
>         _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
>         if (dst_vma->vm_flags & VM_WRITE)
>                 _dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
>         else
>                 set_page_dirty(page);
>
>         dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
>         if (!pte_none(*dst_pte)) {
>                 pte_unmap_unlock(dst_pte, ptl);
>                 return -EEXIST;
>         }
>
>         inc_mm_counter(dst_mm, mm_counter_file(page));
>         page_add_file_rmap(page, false);
>         set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
>
>         /* No need to invalidate - it was non-present before */
>         update_mmu_cache(dst_vma, dst_addr, dst_pte);
>         pte_unmap_unlock(dst_pte, ptl);
>         return 0;
> }
>
> Then at the entry of shmem_mcopy_atomic_pte():
>
>         if (is_continue) {
>                 page = find_lock_page(mapping, pgoff);
>                 if (!page)
>                     return -EFAULT;
>                 ret = shmem_install_uffd_pte(...,
>                         is_continue && !(dst_vma->vm_flags & VM_SHARED));
>                 unlock_page(page);
>                 if (ret)
>                     put_page(page);
>                 return ret;
>         }
>
> Do you think this would be cleaner?

Yes, a refactor like that is promising. It's hard to say for certain
without actually looking at the result - I'll spend some time tomorrow
on a few options, and send along the cleanest version I come up with.

Thanks for all the feedback and advice on this feature, Peter!

>
> --
> Peter Xu
>
