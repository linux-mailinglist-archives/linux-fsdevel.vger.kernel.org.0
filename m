Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736D30E263
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 19:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhBCSVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 13:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhBCSVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:21:38 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F8C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 10:20:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d6so138364ilo.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t15/2iQDwVaTBOunEsPSucc/nRrzJFxeeAfzfc0DJNE=;
        b=wOW8ILuVngAUBSdPy/ecmjBNJOfiMVtVA9nyDK8/THmrxZvlGUv/rVjlZsCQpAin3H
         +28x+whbEIs/N5KX70/rzYdBxSHXSgc7EECh63rgsTZZaT/2P89+yBaEGZEqhWUeNCdE
         rEuYf8O+4OksgXgQjVngIY7ZvfK3bo7M8VP5hcEuEhfKfnaZdLJNCmPBkv4MRvE08aTX
         9MAftkVyMN+16pvN8SUua7qKGEwKZkmQHOX3H6aGTVqxTu4jnOk/g6I6jNOcHkrq5VEa
         a0q1sUmYU+v/8wywE82tZx9VBkVGaJC3KUN4NLRUb2v1ER98XP/oFSveycRGmbQnchEi
         GPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t15/2iQDwVaTBOunEsPSucc/nRrzJFxeeAfzfc0DJNE=;
        b=oFYQAhwKsexS4+I69v7uJgKSKbcMOZK5gKYT63vdCi0gE39+liXK+HvFrOaF8oy0Xl
         vTctfAKg9J1UH68DOXdBFhwSiDcBVtMqvXCF3cyZBPnZ/ZrFqtQFxFM1K0TfVXnvR7hC
         TycalztVtE8L88wW7fwY2x43GfLqAYOh6EOR0J1e7TCbskM5ROxHUQMxZ4LoDSNaJYZh
         4oQzO611GjZifGeVyt1v1fCgePCP2mWMo5CDc3NfK20U5WswuYjZhy+mSemN3UuckHjm
         mEESZMBM8Hx1Tj1pyk+lQyg21al+MImI6hT3y1ycEMmNe6e/8+2xAP+yCpHJdPJR6ycS
         EFfw==
X-Gm-Message-State: AOAM532rNyHNCIJeVSJN5XCO4XV40Tv2rXR8JKp011Zq9JxTPRNA41s8
        EZbtVXLv/jELB89I9Y7qjkCTKqXaqh0crhSe/6h2DA==
X-Google-Smtp-Source: ABdhPJwlFItdhRlFkSlxPRvvmGgnRhMv5qySj2o0FluBkMhPuLOsQ5+2Asugr+9haQYOMzj1LN0n2dIbGV9moq6orGc=
X-Received: by 2002:a05:6e02:1c8d:: with SMTP id w13mr3621359ill.301.1612376458087;
 Wed, 03 Feb 2021 10:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-6-axelrasmussen@google.com> <20210201183159.GF260413@xz-x1>
 <20210202171515.GF6468@xz-x1>
In-Reply-To: <20210202171515.GF6468@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 3 Feb 2021 10:20:21 -0800
Message-ID: <CAJHvVciLfEkeYDNcbAnjnyKGMVuHBHSgxUEFuQpnAhTAy0yTug@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] userfaultfd: add minor fault registration mode
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 2, 2021 at 9:15 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Feb 01, 2021 at 01:31:59PM -0500, Peter Xu wrote:
> > On Thu, Jan 28, 2021 at 02:48:15PM -0800, Axel Rasmussen wrote:
> > > This feature allows userspace to intercept "minor" faults. By "minor"
> > > faults, I mean the following situation:
> > >
> > > Let there exist two mappings (i.e., VMAs) to the same page(s) (shared
> > > memory). One of the mappings is registered with userfaultfd (in minor
> > > mode), and the other is not. Via the non-UFFD mapping, the underlying
> > > pages have already been allocated & filled with some contents. The UFFD
> > > mapping has not yet been faulted in; when it is touched for the first
> > > time, this results in what I'm calling a "minor" fault. As a concrete
> > > example, when working with hugetlbfs, we have huge_pte_none(), but
> > > find_lock_page() finds an existing page.
> > >
> > > This commit adds the new registration mode, and sets the relevant flag
> > > on the VMAs being registered. In the hugetlb fault path, if we find
> > > that we have huge_pte_none(), but find_lock_page() does indeed find an
> > > existing page, then we have a "minor" fault, and if the VMA has the
> > > userfaultfd registration flag, we call into userfaultfd to handle it.
> >
> > When re-read, now I'm thinking whether we should restrict the minor fault
> > scenario with shared mappings always, assuming there's one mapping with uffd
> > and the other one without, while the non-uffd can modify the data before an
> > UFFDIO_CONTINUE kicking the uffd process.
> >
> > To me, it's really more about page cache and that's all..
> >
> > So I'm wondering whether below would be simpler and actually clearer on
> > defining minor faults, comparing to the above whole two paragraphs.  For
> > example, the scemantics do not actually need two mappings:
> >
> >     For shared memory, userfaultfd missing fault used to only report the event
> >     if the page cache does not exist for the current fault process.  Here we
> >     define userfaultfd minor fault as the case where the missing page fault
> >     does have a backing page cache (so only the pgtable entry is missing).
> >
> > It should not affect most of your code, but only one below [1].
>
> OK it could be slightly more than that...
>
> E.g. we'd need to make UFFDIO_COPY to not install the write bit if it's
> UFFDIO_CONTINUE and if it's private mappings. In hugetlb_mcopy_atomic_pte() now
> we apply the write bit unconditionally:
>
>         _dst_pte = make_huge_pte(dst_vma, page, dst_vma->vm_flags & VM_WRITE);
>
> That'll need a touch-up otherwise.
>
> It's just the change seems still very small so I'd slightly prefer to support
> it all.  However I don't want to make your series complicated and blocking it,
> so please feel free to still make it shared memory if that's your preference.
> The worst case is if someone would like to enable this (if with a valid user
> scenario) we'd export a new uffd feature flag.
>
> >
> > [...]
> >
> > > @@ -1302,9 +1301,26 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
> > >                                  unsigned long vm_flags)
> > >  {
> > >     /* FIXME: add WP support to hugetlbfs and shmem */
> > > -   return vma_is_anonymous(vma) ||
> > > -           ((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
> > > -            !(vm_flags & VM_UFFD_WP));
> > > +   if (vm_flags & VM_UFFD_WP) {
> > > +           if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
> > > +                   return false;
> > > +   }
> > > +
> > > +   if (vm_flags & VM_UFFD_MINOR) {
> > > +           /*
> > > +            * The use case for minor registration (intercepting minor
> > > +            * faults) is to handle the case where a page is present, but
> > > +            * needs to be modified before it can be used. This requires
> > > +            * two mappings: one with UFFD registration, and one without.
> > > +            * So, it only makes sense to do this with shared memory.
> > > +            */
> > > +           /* FIXME: Add minor fault interception for shmem. */
> > > +           if (!(is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SHARED)))
> > > +                   return false;
> >
> > [1]
> >
> > So here we also restrict the mapping be shared.  My above comment on the commit
> > message is also another way to ask whether we could also allow it to happen
> > with non-shared mappings as long as there's a page cache.  If so, we could drop
> > the VM_SHARED check here.  It won't affect your existing use case for sure, it
> > just gives more possibility that maybe it could also be used on non-shared
> > mappings due to some reason in the future.
> >
> > What do you think?

Agreed, I don't see any reason why it can't work. The only requirement
for it to be useful is, the UFFD-registered area needs to be able to
"see" writes from the non-UFFD-registered area. Whether or not the
UFFD-registered half is shared or not doesn't affect this.

I'll include this change (and the VM_WRITE touchup described above) in a v4.

> >
> > The rest looks good to me.
> >
> > Thanks,
> >
> > --
> > Peter Xu
>
> --
> Peter Xu
>
