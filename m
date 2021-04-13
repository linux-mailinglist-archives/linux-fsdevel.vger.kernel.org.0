Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2186D35D68B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhDMElU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 00:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhDMElT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 00:41:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CC5C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 21:41:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s16so10524090iog.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx8fq9RMVJeYgjbVUnNNsjq4NPDKlddkrDot/R9W3U0=;
        b=qKzEmUjCHxF9v7Gk82y4AynFWSLYAJC6SJRUorlaJEsI9Xns8UJNnx8nRAVPggQx0s
         LWJzTdXinMJNElG07Ww6Bnew9ELqWfMsI6yYw3jmvxBi5cXn2u2EMnnr9aZsXkwP6mTZ
         gaRf9nEztlW+Cn3CNcpGrJ9+gDcMngs9Nng8vE4gCYcpyqqhqI3V7U28TkEo9FmwJFwc
         jktzgI39xnAJx6LnHhRef1VUg9LKH28vrRXbzDYq1lnlVfxFGHaTaKlFx2Ah0D1uih1n
         c7zD8YQ/ssMJ61nT9aM1ExgPBPmLRWtwpTGBl1pxSvDXa96TffWdKP483bmZZ7+Bc1sT
         vXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx8fq9RMVJeYgjbVUnNNsjq4NPDKlddkrDot/R9W3U0=;
        b=nmcT6L4oN3Oin5WWbrXobbeiX9jUKD3uzskA9vWpMzRpD72F90TVdEg6/CgG8nIFaz
         wM0obRYFqaqFktksaUcJfbiVbClii46M16aiuXtvPjTgazIH6KvjE2WJGJTrkCoe+JLd
         /DtvDJLQN97km5/sfGX6oNQ2x2Ln8N6d+o4v8lC2ssVm/7P8xv1C0H5yh75wUtwjdW3i
         zXyQOPXT6JxDBz9USAN38rARvn3+XPdoDJEyM4fzhAuIyv009rLNq3p640AaD+hZllcE
         XOJ7pOIo7EsUil9pnRgvjRd6NeRJDaRAdg55T0dJqBRCJx7wV2BK7dWtirlNIpk5g5tN
         gFFg==
X-Gm-Message-State: AOAM5312AAeyx6DLfPIKLtONzYUl842ZyKUwAqeR0rHReVWy62q1w2Ar
        p+s5Y9t6kNrQp4DWWOFq+59SMpS3SXqj2NBObRL32w==
X-Google-Smtp-Source: ABdhPJwXI/HKUS1nvH+kTJZ0qN/bCT+G1Iz1obFXECV6bQgKoKWtAB2XGAaDRQDS+bHpG6sbHn3DJbPfx/d0Y/AwLxo=
X-Received: by 2002:a05:6602:2dce:: with SMTP id l14mr6765893iow.23.1618288859391;
 Mon, 12 Apr 2021 21:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-5-axelrasmussen@google.com> <20210412231736.GA1002612@xz-x1>
In-Reply-To: <20210412231736.GA1002612@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 12 Apr 2021 21:40:22 -0700
Message-ID: <CAJHvVcirn08ad64pTdxTRDRRXF16QnFwC-3GOT8bXMp2E2UYhg@mail.gmail.com>
Subject: Re: [PATCH 4/9] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
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

On Mon, Apr 12, 2021 at 4:17 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Apr 08, 2021 at 04:43:22PM -0700, Axel Rasmussen wrote:
> > +/*
> > + * Install PTEs, to map dst_addr (within dst_vma) to page.
> > + *
> > + * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> > + * whether or not dst_vma is VM_SHARED. It also handles the more general
> > + * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> > + * backed, or not).
> > + *
> > + * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> > + * shmem_mcopy_atomic_pte instead.
> > + */
> > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +                                  struct vm_area_struct *dst_vma,
> > +                                  unsigned long dst_addr, struct page *page,
> > +                                  bool newly_allocated, bool wp_copy)
> > +{
> > +     int ret;
> > +     pte_t _dst_pte, *dst_pte;
> > +     int writable;
> > +     bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > +     spinlock_t *ptl;
> > +     struct inode *inode;
> > +     pgoff_t offset, max_off;
> > +
> > +     _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > +     writable = dst_vma->vm_flags & VM_WRITE;
> > +     /* For private, non-anon we need CoW (don't write to page cache!) */
> > +     if (!vma_is_anonymous(dst_vma) && !vm_shared)
> > +             writable = 0;
> > +
> > +     if (writable || vma_is_anonymous(dst_vma))
> > +             _dst_pte = pte_mkdirty(_dst_pte);
> > +     if (writable) {
> > +             if (wp_copy)
> > +                     _dst_pte = pte_mkuffd_wp(_dst_pte);
> > +             else
> > +                     _dst_pte = pte_mkwrite(_dst_pte);
> > +     } else if (vm_shared) {
> > +             /*
> > +              * Since we didn't pte_mkdirty(), mark the page dirty or it
> > +              * could be freed from under us. We could do this
> > +              * unconditionally, but doing it only if !writable is faster.
> > +              */
> > +             set_page_dirty(page);
> > +     }
> > +
> > +     dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > +
> > +     if (vma_is_shmem(dst_vma)) {
> > +             /* The shmem MAP_PRIVATE case requires checking the i_size */
>
> When you start to use this function in the last patch it'll be needed too even
> if MAP_SHARED?
>
> How about directly state the reason of doing this ("serialize against truncate
> with the PT lock") instead of commenting about "who will need it"?
>
> > +             inode = dst_vma->vm_file->f_inode;
> > +             offset = linear_page_index(dst_vma, dst_addr);
> > +             max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > +             ret = -EFAULT;
> > +             if (unlikely(offset >= max_off))
> > +                     goto out_unlock;
> > +     }
>
> [...]
>
> > +/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
> > +static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> > +                             pmd_t *dst_pmd,
> > +                             struct vm_area_struct *dst_vma,
> > +                             unsigned long dst_addr,
> > +                             bool wp_copy)
> > +{
> > +     struct inode *inode = file_inode(dst_vma->vm_file);
> > +     pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> > +     struct page *page;
> > +     int ret;
> > +
> > +     ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
>
> SGP_READ looks right, as we don't want page allocation.  However I noticed
> there's very slight difference when the page was just fallocated:
>
>         /* fallocated page? */
>         if (page && !PageUptodate(page)) {
>                 if (sgp != SGP_READ)
>                         goto clear;
>                 unlock_page(page);
>                 put_page(page);
>                 page = NULL;
>                 hindex = index;
>         }
>
> I think it won't happen for your case since the page should be uptodate already
> (the other thread should check and modify the page before CONTINUE), but still
> raise this up, since if the page was allocated it smells better to still
> install the fallocated page (do we need to clear the page and SetUptodate)?

Sorry for the somewhat rambling thought process:

My first thought is, I don't really know what PageUptodate means for
shmem pages. If I understand correctly, normally we say PageUptodate()
if the in memory data is more recent or equivalent to the on-disk
data. But, shmem pages are entirely in memory - they are file backed
in name only, in some sense.

fallocate() does all sorts of things so the comment to me seems a bit
ambiguous, but it seems the implication is that we're worried
specifically about the case where the shmem page was recently
allocated with fallocate(mode=0)? In that case, do we use
!PageUptodate() to denote that the page has been allocated, but its
contents are undefined?

I suppose that would make sense, as the action "goto clear;" generally
memset()-s the page to zero it, and then calls SetPageUptodate().

Okay so let's say the following sequence of events happens:

1. Userspace calls fallocate(mode=0) to allocate some shmem pages.
2. Another thread, via a UFFD-registered mapping, manages to trigger a
minor fault on one such page, while we still have !PageUptodate().
(I'm not 100% sure this can happen, but let's say it can.)
3. UFFD handler thread gets the minor fault event, and for whatever
(buggy?) reason does nothing - it doesn't modify the page, it just
calls CONTINUE.

I think if we get to this point, zeroing the page, returning it, and
setting up the PTEs seems somewhat reasonable to me. I suppose
alternatively we could notice that this happened and return an error
to the caller? I'm hesitant to mess with the behavior of
shmem_getpage_gfp() to make such a thing happen though. I do think if
we're going to set up the PTEs instead of returning an error, we
definitely do need to clear and SetPageUptodate() the page first.

In conclusion, I think this behavior is correct.

>
> --
> Peter Xu
>
