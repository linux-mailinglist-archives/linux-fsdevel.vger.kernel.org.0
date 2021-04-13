Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2406C35E60F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhDMSMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 14:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243810AbhDMSMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618337535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jyp6jh8T+sCDXl4adlhM7pZTyyIF+l/vtyYfobfKH7E=;
        b=Az/rXe0DHT2y0v+7nJiOjErCJCCS/xDlV3culGdG/O6UO0OKyswqgCJibmK7PtLfvJm9Cy
        5Bxe34Dv6RFIgXi2NlOFVdwjh1hQ3TIRnjFaSulfmI8kDopZJxq4IU8qNTPqFXFqVz7e7+
        eR/J3BLga17CRC9+ogXZWYX3oxwNJUU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-scW3LX57OkSBZJs85kAHQw-1; Tue, 13 Apr 2021 14:12:13 -0400
X-MC-Unique: scW3LX57OkSBZJs85kAHQw-1
Received: by mail-qt1-f200.google.com with SMTP id e6-20020ac85dc60000b029019d9cbbc077so244101qtx.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 11:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyp6jh8T+sCDXl4adlhM7pZTyyIF+l/vtyYfobfKH7E=;
        b=bmy+Sd+tbGQGFQehl5IHFN991LX/fvcckUZ0A/15LUQ1GlkSOw/3h3ZO0iVu/QW2Jn
         pE88sM6fdo54viCJnKzSCYSeAuDKPn47bcQ+Mo+3cQZG/e/W95do9A6W9g46NfXI4tTm
         E40kEU+jSricH0azuL/8oiod0M+zWxC3wAwiwXGYrCIpJgvbA6+/g7mblp+s58XDHMdW
         C2mArl97ivAgpthQHxEqXc02BtT/YKW5PHNqxDXD0Rk0c4e6jrtIZrVnLFjppU8rH8pc
         rSvfqVfEYf29AMVELsd/QiowT78IMs+NnMLEyfr1MXaHzNOgVFFC1y8laAZuK2TZxTp/
         NyTQ==
X-Gm-Message-State: AOAM531ecnLJ/wEo3rYNMfutoEo0N3d8F7KDYNekgmbDmt/wxnAmqJ+h
        6WiEC1lkiT7bbtPHUavyYrlG59crhuuNsZth93A4wEY57U83FSOKeMwkZWfdfq/EmsBNJFyYaIO
        mBmKxmXZUvyVhhnRys/3Zg4XlEQ==
X-Received: by 2002:a37:7ec6:: with SMTP id z189mr13740388qkc.295.1618337532452;
        Tue, 13 Apr 2021 11:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrybZjVnaoltKooNFbmo1kR2lUnevlvR+cUcoq7ZdeJnwd69eDOHqllwuYYX9vsUmyv8qvHg==
X-Received: by 2002:a37:7ec6:: with SMTP id z189mr13740351qkc.295.1618337532022;
        Tue, 13 Apr 2021 11:12:12 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id v65sm9847883qkc.125.2021.04.13.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:12:11 -0700 (PDT)
Date:   Tue, 13 Apr 2021 14:12:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
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
Subject: Re: [PATCH 4/9] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
Message-ID: <20210413181209.GB4440@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-5-axelrasmussen@google.com>
 <20210412231736.GA1002612@xz-x1>
 <CAJHvVcirn08ad64pTdxTRDRRXF16QnFwC-3GOT8bXMp2E2UYhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcirn08ad64pTdxTRDRRXF16QnFwC-3GOT8bXMp2E2UYhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 09:40:22PM -0700, Axel Rasmussen wrote:
> On Mon, Apr 12, 2021 at 4:17 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Apr 08, 2021 at 04:43:22PM -0700, Axel Rasmussen wrote:
> > > +/*
> > > + * Install PTEs, to map dst_addr (within dst_vma) to page.
> > > + *
> > > + * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> > > + * whether or not dst_vma is VM_SHARED. It also handles the more general
> > > + * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> > > + * backed, or not).
> > > + *
> > > + * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> > > + * shmem_mcopy_atomic_pte instead.
> > > + */
> > > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > > +                                  struct vm_area_struct *dst_vma,
> > > +                                  unsigned long dst_addr, struct page *page,
> > > +                                  bool newly_allocated, bool wp_copy)
> > > +{
> > > +     int ret;
> > > +     pte_t _dst_pte, *dst_pte;
> > > +     int writable;
> > > +     bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > > +     spinlock_t *ptl;
> > > +     struct inode *inode;
> > > +     pgoff_t offset, max_off;
> > > +
> > > +     _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > > +     writable = dst_vma->vm_flags & VM_WRITE;
> > > +     /* For private, non-anon we need CoW (don't write to page cache!) */
> > > +     if (!vma_is_anonymous(dst_vma) && !vm_shared)
> > > +             writable = 0;
> > > +
> > > +     if (writable || vma_is_anonymous(dst_vma))
> > > +             _dst_pte = pte_mkdirty(_dst_pte);
> > > +     if (writable) {
> > > +             if (wp_copy)
> > > +                     _dst_pte = pte_mkuffd_wp(_dst_pte);
> > > +             else
> > > +                     _dst_pte = pte_mkwrite(_dst_pte);
> > > +     } else if (vm_shared) {
> > > +             /*
> > > +              * Since we didn't pte_mkdirty(), mark the page dirty or it
> > > +              * could be freed from under us. We could do this
> > > +              * unconditionally, but doing it only if !writable is faster.
> > > +              */
> > > +             set_page_dirty(page);
> > > +     }
> > > +
> > > +     dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > > +
> > > +     if (vma_is_shmem(dst_vma)) {
> > > +             /* The shmem MAP_PRIVATE case requires checking the i_size */
> >
> > When you start to use this function in the last patch it'll be needed too even
> > if MAP_SHARED?
> >
> > How about directly state the reason of doing this ("serialize against truncate
> > with the PT lock") instead of commenting about "who will need it"?
> >
> > > +             inode = dst_vma->vm_file->f_inode;
> > > +             offset = linear_page_index(dst_vma, dst_addr);
> > > +             max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > > +             ret = -EFAULT;
> > > +             if (unlikely(offset >= max_off))
> > > +                     goto out_unlock;
> > > +     }
> >
> > [...]
> >
> > > +/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
> > > +static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> > > +                             pmd_t *dst_pmd,
> > > +                             struct vm_area_struct *dst_vma,
> > > +                             unsigned long dst_addr,
> > > +                             bool wp_copy)
> > > +{
> > > +     struct inode *inode = file_inode(dst_vma->vm_file);
> > > +     pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> > > +     struct page *page;
> > > +     int ret;
> > > +
> > > +     ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> >
> > SGP_READ looks right, as we don't want page allocation.  However I noticed
> > there's very slight difference when the page was just fallocated:
> >
> >         /* fallocated page? */
> >         if (page && !PageUptodate(page)) {
> >                 if (sgp != SGP_READ)
> >                         goto clear;

[1]

> >                 unlock_page(page);
> >                 put_page(page);
> >                 page = NULL;
> >                 hindex = index;
> >         }
> >
> > I think it won't happen for your case since the page should be uptodate already
> > (the other thread should check and modify the page before CONTINUE), but still
> > raise this up, since if the page was allocated it smells better to still
> > install the fallocated page (do we need to clear the page and SetUptodate)?
> 
> Sorry for the somewhat rambling thought process:
> 
> My first thought is, I don't really know what PageUptodate means for
> shmem pages. If I understand correctly, normally we say PageUptodate()
> if the in memory data is more recent or equivalent to the on-disk
> data. But, shmem pages are entirely in memory - they are file backed
> in name only, in some sense.
> 
> fallocate() does all sorts of things so the comment to me seems a bit
> ambiguous, but it seems the implication is that we're worried
> specifically about the case where the shmem page was recently
> allocated with fallocate(mode=0)? In that case, do we use
> !PageUptodate() to denote that the page has been allocated, but its
> contents are undefined?
> 
> I suppose that would make sense, as the action "goto clear;" generally
> memset()-s the page to zero it, and then calls SetPageUptodate().
> 
> Okay so let's say the following sequence of events happens:
> 
> 1. Userspace calls fallocate(mode=0) to allocate some shmem pages.
> 2. Another thread, via a UFFD-registered mapping, manages to trigger a
> minor fault on one such page, while we still have !PageUptodate().
> (I'm not 100% sure this can happen, but let's say it can.)
> 3. UFFD handler thread gets the minor fault event, and for whatever
> (buggy?) reason does nothing - it doesn't modify the page, it just
> calls CONTINUE.

[2]

> 
> I think if we get to this point, zeroing the page, returning it, and
> setting up the PTEs seems somewhat reasonable to me. I suppose
> alternatively we could notice that this happened and return an error
> to the caller? I'm hesitant to mess with the behavior of
> shmem_getpage_gfp() to make such a thing happen though. I do think if
> we're going to set up the PTEs instead of returning an error, we
> definitely do need to clear and SetPageUptodate() the page first.
> 
> In conclusion, I think this behavior is correct.

I agree with you (mostly :), but except one thing: you passed in SGP_READ, so
IMHO it won't do what you explained (see [1] above: "goto clear" is with "sgp
!= SGP_READ" only); instead of doing what you said, I think it'll reset page
pointer to NULL..  Then quickly in the latter block:

	if (page || sgp == SGP_READ)
		goto out;

So I think at last shmem_getpage_gfp(SGP_READ) will return NULL.

I do think I've got some confusion here regarding SGP_READ, since from the
comment in shmem_fs.h it says:

	SGP_READ,	/* don't exceed i_size, don't allocate page */

It's natural to think it as "return the fallocated page" in this case.  However
it seems not the case?  My gut feeling is the comment for SGP_READ needs a
touch up, so as to state that for newly fallocated (and not used) pages it'll
return NULL even if cache hit.

So I think you're right, for all cases this may be a trivial case.  However
I've got a lesson somewhere else that we should never overlook zero pages,
which is also related to this case - although fallocated page is still
!Uptodate so clear page happens even latter, however from userspace pov, the
user could assume it's a zero page even if the page is not accessed at all
(since any access will cause clear page).  Then the user program could avoid
modifying this page if it knows this page keeps to be zero page somehow (e.g.,
a zero page bitmap?). Then your example above [2] seems indeed a valid one
worth thinking, at least not fully paranoid.

-- 
Peter Xu

