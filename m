Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596BB3611FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhDOSTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhDOSTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F60C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:25 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e14so9648377ils.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u11fVQy6kjnMRElja77kseBc1mYwvTCWjt5Bt5mrtok=;
        b=GHTzamdY005X/OnRXBk0Vw+T+JdjzWzQqcx3zniyw/EQME2lhoY2Y59H+nzDrpdl8h
         8vzusYbKf278AnyTd8WCOwGkF3VdvVwfYlivQfgCnvYpJqwoTeD20jGd+8MtjBgzSiCZ
         H4gvvi/BVMPSoqMeCtiU7VZuSewPN21h+izvLjh5zfsllSERI5oScu7ZxizcwX3yqNVu
         VLpZOF6+VJ1cLT9naswy/21xnpZzuMLGrwYtU2XP9BGXpIT0KlF2Ky8I7ETp/Mm6avU+
         STZOfVEB8vTpZLv5dolU5CmBzaKxb0AeO7v9zjt6cRyxH91xVb+nFfJts9CvwjkxGKo9
         Yjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u11fVQy6kjnMRElja77kseBc1mYwvTCWjt5Bt5mrtok=;
        b=YeU5CTHItjAR05Laum4YqRlw4t/X5kzIxCqaA/kEKElwi1bdOz7s6jMOmQ9jZ0Zwke
         PSFAzRT2atR3SDAjBgHS+3T3wo8OMys144LpZit7PlNM5eWl667mCINZQ3IyjY6jhR8Y
         VKJii+PzKmAYfBR3FeoLd06RipIOB1NM8oz01Sl6RtFNx8wz8O9kBSrofccyqucpR3sZ
         qafOfDgIj+M4Tfhr9/n0TBbvbtk+Ef4MtnJR9JHbOg2cXiQj0Rery15tj9ACvV/qhj99
         Xmhj/bTJdBd2r62sSsKX3nqDEsfbPXSpqGZ/T4yniZVR3vTjV5jjGYAmiqkdbgWdRhQN
         ppfA==
X-Gm-Message-State: AOAM533RJF4bGxqv4ORFk2se9IkyNK1ZFxZp5ZK6PdIqzJcmZyrxe5vD
        V7DkgLRuCRllglS4WdyADyQurtMoMigZon6KqCAYhA==
X-Google-Smtp-Source: ABdhPJwB59HPRXr9BHRidgTeK1xp2kqrjl7Diw7oTDeEwnGmuL5iD1AyI0Au9dxO8g8jlmM6LFfx/OLx/pdcsvy/N6U=
X-Received: by 2002:a05:6e02:b24:: with SMTP id e4mr3922220ilu.30.1618510764626;
 Thu, 15 Apr 2021 11:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-5-axelrasmussen@google.com> <20210412231736.GA1002612@xz-x1>
 <CAJHvVcirn08ad64pTdxTRDRRXF16QnFwC-3GOT8bXMp2E2UYhg@mail.gmail.com> <20210413181209.GB4440@xz-x1>
In-Reply-To: <20210413181209.GB4440@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 15 Apr 2021 11:18:47 -0700
Message-ID: <CAJHvVcg0k0ht1kYTPDZp1_GCeXoV31BUAPofXEV-neQefX2_Jw@mail.gmail.com>
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

On Tue, Apr 13, 2021 at 11:12 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 12, 2021 at 09:40:22PM -0700, Axel Rasmussen wrote:
> > On Mon, Apr 12, 2021 at 4:17 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Apr 08, 2021 at 04:43:22PM -0700, Axel Rasmussen wrote:
> > > > +/*
> > > > + * Install PTEs, to map dst_addr (within dst_vma) to page.
> > > > + *
> > > > + * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> > > > + * whether or not dst_vma is VM_SHARED. It also handles the more general
> > > > + * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> > > > + * backed, or not).
> > > > + *
> > > > + * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> > > > + * shmem_mcopy_atomic_pte instead.
> > > > + */
> > > > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > > > +                                  struct vm_area_struct *dst_vma,
> > > > +                                  unsigned long dst_addr, struct page *page,
> > > > +                                  bool newly_allocated, bool wp_copy)
> > > > +{
> > > > +     int ret;
> > > > +     pte_t _dst_pte, *dst_pte;
> > > > +     int writable;
> > > > +     bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > > > +     spinlock_t *ptl;
> > > > +     struct inode *inode;
> > > > +     pgoff_t offset, max_off;
> > > > +
> > > > +     _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > > > +     writable = dst_vma->vm_flags & VM_WRITE;
> > > > +     /* For private, non-anon we need CoW (don't write to page cache!) */
> > > > +     if (!vma_is_anonymous(dst_vma) && !vm_shared)
> > > > +             writable = 0;
> > > > +
> > > > +     if (writable || vma_is_anonymous(dst_vma))
> > > > +             _dst_pte = pte_mkdirty(_dst_pte);
> > > > +     if (writable) {
> > > > +             if (wp_copy)
> > > > +                     _dst_pte = pte_mkuffd_wp(_dst_pte);
> > > > +             else
> > > > +                     _dst_pte = pte_mkwrite(_dst_pte);
> > > > +     } else if (vm_shared) {
> > > > +             /*
> > > > +              * Since we didn't pte_mkdirty(), mark the page dirty or it
> > > > +              * could be freed from under us. We could do this
> > > > +              * unconditionally, but doing it only if !writable is faster.
> > > > +              */
> > > > +             set_page_dirty(page);
> > > > +     }
> > > > +
> > > > +     dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > > > +
> > > > +     if (vma_is_shmem(dst_vma)) {
> > > > +             /* The shmem MAP_PRIVATE case requires checking the i_size */
> > >
> > > When you start to use this function in the last patch it'll be needed too even
> > > if MAP_SHARED?
> > >
> > > How about directly state the reason of doing this ("serialize against truncate
> > > with the PT lock") instead of commenting about "who will need it"?
> > >
> > > > +             inode = dst_vma->vm_file->f_inode;
> > > > +             offset = linear_page_index(dst_vma, dst_addr);
> > > > +             max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > > > +             ret = -EFAULT;
> > > > +             if (unlikely(offset >= max_off))
> > > > +                     goto out_unlock;
> > > > +     }
> > >
> > > [...]
> > >
> > > > +/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
> > > > +static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> > > > +                             pmd_t *dst_pmd,
> > > > +                             struct vm_area_struct *dst_vma,
> > > > +                             unsigned long dst_addr,
> > > > +                             bool wp_copy)
> > > > +{
> > > > +     struct inode *inode = file_inode(dst_vma->vm_file);
> > > > +     pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> > > > +     struct page *page;
> > > > +     int ret;
> > > > +
> > > > +     ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> > >
> > > SGP_READ looks right, as we don't want page allocation.  However I noticed
> > > there's very slight difference when the page was just fallocated:
> > >
> > >         /* fallocated page? */
> > >         if (page && !PageUptodate(page)) {
> > >                 if (sgp != SGP_READ)
> > >                         goto clear;
>
> [1]
>
> > >                 unlock_page(page);
> > >                 put_page(page);
> > >                 page = NULL;
> > >                 hindex = index;
> > >         }
> > >
> > > I think it won't happen for your case since the page should be uptodate already
> > > (the other thread should check and modify the page before CONTINUE), but still
> > > raise this up, since if the page was allocated it smells better to still
> > > install the fallocated page (do we need to clear the page and SetUptodate)?
> >
> > Sorry for the somewhat rambling thought process:
> >
> > My first thought is, I don't really know what PageUptodate means for
> > shmem pages. If I understand correctly, normally we say PageUptodate()
> > if the in memory data is more recent or equivalent to the on-disk
> > data. But, shmem pages are entirely in memory - they are file backed
> > in name only, in some sense.
> >
> > fallocate() does all sorts of things so the comment to me seems a bit
> > ambiguous, but it seems the implication is that we're worried
> > specifically about the case where the shmem page was recently
> > allocated with fallocate(mode=0)? In that case, do we use
> > !PageUptodate() to denote that the page has been allocated, but its
> > contents are undefined?
> >
> > I suppose that would make sense, as the action "goto clear;" generally
> > memset()-s the page to zero it, and then calls SetPageUptodate().
> >
> > Okay so let's say the following sequence of events happens:
> >
> > 1. Userspace calls fallocate(mode=0) to allocate some shmem pages.
> > 2. Another thread, via a UFFD-registered mapping, manages to trigger a
> > minor fault on one such page, while we still have !PageUptodate().
> > (I'm not 100% sure this can happen, but let's say it can.)
> > 3. UFFD handler thread gets the minor fault event, and for whatever
> > (buggy?) reason does nothing - it doesn't modify the page, it just
> > calls CONTINUE.
>
> [2]
>
> >
> > I think if we get to this point, zeroing the page, returning it, and
> > setting up the PTEs seems somewhat reasonable to me. I suppose
> > alternatively we could notice that this happened and return an error
> > to the caller? I'm hesitant to mess with the behavior of
> > shmem_getpage_gfp() to make such a thing happen though. I do think if
> > we're going to set up the PTEs instead of returning an error, we
> > definitely do need to clear and SetPageUptodate() the page first.
> >
> > In conclusion, I think this behavior is correct.
>
> I agree with you (mostly :), but except one thing: you passed in SGP_READ, so
> IMHO it won't do what you explained (see [1] above: "goto clear" is with "sgp
> != SGP_READ" only); instead of doing what you said, I think it'll reset page
> pointer to NULL..  Then quickly in the latter block:
>
>         if (page || sgp == SGP_READ)
>                 goto out;
>
> So I think at last shmem_getpage_gfp(SGP_READ) will return NULL.

Ah, indeed, I mistakenly read that as "sgp != SGP_READ".

>
> I do think I've got some confusion here regarding SGP_READ, since from the
> comment in shmem_fs.h it says:
>
>         SGP_READ,       /* don't exceed i_size, don't allocate page */
>
> It's natural to think it as "return the fallocated page" in this case.  However
> it seems not the case?  My gut feeling is the comment for SGP_READ needs a
> touch up, so as to state that for newly fallocated (and not used) pages it'll
> return NULL even if cache hit.
>
> So I think you're right, for all cases this may be a trivial case.  However
> I've got a lesson somewhere else that we should never overlook zero pages,
> which is also related to this case - although fallocated page is still
> !Uptodate so clear page happens even latter, however from userspace pov, the
> user could assume it's a zero page even if the page is not accessed at all
> (since any access will cause clear page).  Then the user program could avoid
> modifying this page if it knows this page keeps to be zero page somehow (e.g.,
> a zero page bitmap?). Then your example above [2] seems indeed a valid one
> worth thinking, at least not fully paranoid.

I'm kind of left thinking along the same lines though.

Modifying shmem_getpage_gfp to behave differently in this case seems
likely to be a can of worms.

With the current behavior, at least it doesn't seem to be too
problematic - we're not going to hand userspace an unzeroed page or
anything. At worst, it's a bit of a rough edge userspace might hit.
The UFFD handler thread will just get an error when it tries to
CONTINUE, and could recover by e.g. writing to the page or something
and trying again.

I'm inclined to leave it as is, and maybe look into a way to file down
the rough edge in a future patch, as well as some of the other
cleanups we've discussed elsewhere. Objections?

>
> --
> Peter Xu
>
