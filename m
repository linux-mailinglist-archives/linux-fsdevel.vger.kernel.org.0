Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D631A57B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 20:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhBLTe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 14:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhBLTe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:34:58 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA08C0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 11:34:18 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id q9so257029ilo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLZPNYnA3AyiBztsXKbg7RI/5esV5yRJCEOdm8wwCX8=;
        b=wRRRmV59U2npYIEnXk/btZHw9YaT7dYbRUcFWvK9W319z+se8VRdCewgiNJ9LtEt6L
         a6juf1qi8a7hT97M95DhT/SJ/zuEQ9IlvAdBDoh92TbyknlpgDo3oDi8iyxpx8aZNOMg
         Zh7JVsf3uTnEU9xRt1r+SwbXEZn9GbuZD2D9zwCyBdC4wQd40q3IN4aLp8rDb05H654+
         kHTQcbgraSuQhymzaErH5ZYuyOwodGbAj00OfZYJl2ClpMYPshQALp5ZeXzNf6OsOh6N
         xKn2IewT6v9MifTnBLn+kU5+b7o+JM7IcYgBtdcTuYKGkXeWQaujrGx4UMQRpjqjqQlr
         hXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLZPNYnA3AyiBztsXKbg7RI/5esV5yRJCEOdm8wwCX8=;
        b=PbnyMaY7qz1dcEhcQ7VuoGF9n0CT9J1GnfqeUjz4EqCCpd+AyYL4bfjit9kLBCV64p
         51qs8qFrDSavpHqWP/BRmXQjcsibvcCnWjnnPVG4qIMZwizA/RTRXC+WC2hPcynRQsaY
         PmWyiSY1R/4QoSBA+amOx/3BkJZVt+RZqOBo9eLm22454w11NHqzsoIeb2oVHswT4gQ4
         v6HyvPEK+9IjM37R5HCoumiZJRberukBtOk5YhgbO7hIbEyOt66PDuDecbIYgdfYyfg5
         mxCPgpMsdS47ZxL6/8g8O7YAkG9FGuh4AgGZpCtDbzCAZELCRT328G2yCJLGpnLhxXsa
         wxXg==
X-Gm-Message-State: AOAM532DjOwy9hdTYTkQkkto2DjIjBbPbToxF4OuvkWvaUbS/xMBYZs8
        C0rw8c85jyE/k+H1wBh7jsHglSIu5IDXBxY1J1HgDw==
X-Google-Smtp-Source: ABdhPJzUOZHK+nJxYDrNFxI4JSdUt9lx51FEfV/DFOi0Mx5l6BAKCb1h8pfc3n/nrhrc2JnvEvbOI5fQ2Wulw9S9XOM=
X-Received: by 2002:a05:6e02:194a:: with SMTP id x10mr3628193ilu.165.1613158457152;
 Fri, 12 Feb 2021 11:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com> <efb3173f-811c-5792-a193-6476905ecdb2@oracle.com>
In-Reply-To: <efb3173f-811c-5792-a193-6476905ecdb2@oracle.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 12 Feb 2021 11:33:39 -0800
Message-ID: <CAJHvVci7RQkASZ4wo6xpG-PjFnGPg7vkgNALBNmw++RjQULEnQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] userfaultfd: add minor fault registration mode
To:     Mike Kravetz <mike.kravetz@oracle.com>
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
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:18 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/10/21 1:21 PM, Axel Rasmussen wrote:
> > This feature allows userspace to intercept "minor" faults. By "minor"
> > faults, I mean the following situation:
> >
> > Let there exist two mappings (i.e., VMAs) to the same page(s). One of
> > the mappings is registered with userfaultfd (in minor mode), and the
> > other is not. Via the non-UFFD mapping, the underlying pages have
> > already been allocated & filled with some contents. The UFFD mapping
> > has not yet been faulted in; when it is touched for the first time,
> > this results in what I'm calling a "minor" fault. As a concrete
> > example, when working with hugetlbfs, we have huge_pte_none(), but
> > find_lock_page() finds an existing page.
>
> Do we want to intercept the fault if it is for a private mapping that
> will COW the page in the page cache?  I think 'yes' but just want to
> confirm.  The code added to hugetlb_no_page will intercept these COW
> accesses.

I can at least say this is intentional, although I admit I don't have
a precise use case in mind for the UFFD mapping being private. I
suppose it's something like, the UFFD poll thread is supposed to
(maybe) update the page contents, *before* I CoW it, and then once
it's been CoW-ed I don't want that poll thread to be able to see
whatever changes I've made?

Unless there's some different use case for this, I believe this is the
behavior we want.

>
> <snip>
>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index e41b77cf6cc2..f150b10981a8 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4366,6 +4366,38 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >                               VM_FAULT_SET_HINDEX(hstate_index(h));
> >                       goto backout_unlocked;
> >               }
> > +
> > +             /* Check for page in userfault range. */
> > +             if (userfaultfd_minor(vma)) {
> > +                     u32 hash;
> > +                     struct vm_fault vmf = {
> > +                             .vma = vma,
> > +                             .address = haddr,
> > +                             .flags = flags,
> > +                             /*
> > +                              * Hard to debug if it ends up being used by a
> > +                              * callee that assumes something about the
> > +                              * other uninitialized fields... same as in
> > +                              * memory.c
> > +                              */
> > +                     };
> > +
> > +                     unlock_page(page);
> > +
> > +                     /*
> > +                      * hugetlb_fault_mutex and i_mmap_rwsem must be dropped
> > +                      * before handling userfault.  Reacquire after handling
> > +                      * fault to make calling code simpler.
> > +                      */
> > +
> > +                     hash = hugetlb_fault_mutex_hash(mapping, idx);
> > +                     mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                     i_mmap_unlock_read(mapping);
>
> After dropping all the locks, we only hold a reference to the page in the
> page cache.  I 'think' someone else could hole punch the page and remove it
> from the cache.  IIUC, state changing while processing uffd faults is something
> that users need to deal with?  Just need to make sure there are no assumptions
> in the kernel code.

Yeah, this seems possible. What I'd expect to happen in that case is
something like:

1. hugetlb_no_page() calls into handle_userfault().
2. Someone hole punches the page, removing it from the page cache.
3. The UFFD poll thread gets the fault event, and issues a
UFFDIO_CONTINUE. (Say we instead were going to write an update, and
*then* UFFDIO_CONTINUE: I think the hole punch by another thread could
also happen between those two events.)
4. This calls down into hugetlb_mcopy_atomic_pte, where we try to
find_lock_page(). This returns NULL, so we bail with -EFAULT.
5. Userspace detects and deals with this error - maybe by writing to
the non-UFFD mapping, thereby putting a page back in the page cache,
or by issuing a UFFDIO_COPY or such?

Which, as far as I can see is fine? But, I am by no means an expert
yet so please correct me if this seems problematic. :)

>
> > +                     ret = handle_userfault(&vmf, VM_UFFD_MINOR);
> > +                     i_mmap_lock_read(mapping);
> > +                     mutex_lock(&hugetlb_fault_mutex_table[hash]);
> > +                     goto out;
> > +             }
> >       }
> >
> >       /*
> >
>
> --
> Mike Kravetz
