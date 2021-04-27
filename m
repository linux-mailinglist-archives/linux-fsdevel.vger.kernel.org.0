Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAE36C9DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhD0Q6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbhD0Q6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:58:36 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489C8C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 09:57:52 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a9so2126061ilh.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfWvlXdic+4MOs0KOPuGPjE9kmD8XQr/sjmlrkTPLaI=;
        b=V8ZOgRJcn6Dtqzn/dNTeT1u9mccvCFMWItwlB2UU5IVebFRpf/CJ71oNx7sVg0gTxn
         D5QqGQXHstJUFYUStJ6czBmZ5CVbVKd68zvdjnQN0+nn6k8spWRQg3ZN7hButLBVmrkd
         P1MDMudaGLf3+9zuwY8ZNeRQKEyHpqW3V3aCC0uIRCK/1HCaAzUuTyKbou4oHr50bPfa
         YPzAtJHZwnrp7epFgbmMoOkqVtlH4iiovgBMyUhDoYOdMTUgzCSkjgSkc05mSJZLjATs
         GXnDvOYHzpyTJUrMKD0nW67S6wLNYpiHRMkDClN/cndD1/qRlKFgvyLf7CYSGi8lGL66
         jzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfWvlXdic+4MOs0KOPuGPjE9kmD8XQr/sjmlrkTPLaI=;
        b=oF2Lf7vDDxLUcmBXr3sa+rWrfZ3qR95pEa2rGHwzmmgAOINrFIXRGuS4dmdbyWkw8g
         F+Tg4so4IjluZUdb/LwkEgjXS6qGKZmIiMObpoP34NzXYBu5JP+ItNdpj2ZaP+psCHQo
         Bj4jg9v+G7XcOpcr6YHmdr4cCVslIjDYzCIHpmoRpRYuzljMQjJIWV6G8Bt7h/kTFoNR
         yWCtS6FShfdtlKQdBdbu2R4AKnhwpJ9QBFnx5I+jrHp2unwYL343fmnpbrb1UQlSOXDY
         bZQX4BK6/aCz+17nFqoB4vOcVt8QdKwbHbe2JmOqDXJzVH5lU0BkRFg+Y/Rvb7vGZwQe
         5D0w==
X-Gm-Message-State: AOAM5317MISeWqRgQYiHAdt/EM4JSRw1uOh26xYBym7lrQy3DOoHfJGl
        /FA2ngQyJIaFjEdvFFUUIjaCb7omoz3kDhuNnjMWcw==
X-Google-Smtp-Source: ABdhPJwGFKRq3YkbLr0YvaOXUWBlmiWFSZOzKAFBSpiZs1nWwxElMS0Tlq3jxLLjVUri2MfWpajIppi1lnvNcSqEz38=
X-Received: by 2002:a05:6e02:1d06:: with SMTP id i6mr19319768ila.165.1619542671555;
 Tue, 27 Apr 2021 09:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com> <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
 <20210427155414.GB6820@xz-x1>
In-Reply-To: <20210427155414.GB6820@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 27 Apr 2021 09:57:16 -0700
Message-ID: <CAJHvVciNrE_F0B0nu=Mib6LhcFhL8+qgO-yiKNsJuBjOMkn5+g@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

I'd prefer to keep them separate, as they are not tiny patches (they
are roughly +200/-150 each). And, they really are quite independent -
at least in the sense that I can reorder them via rebase with no
conflicts, and the code builds at each commit in either orientation. I
think this implies they're easier to review separately, rather than
squashed.

I don't have a strong feeling about the order. I slightly prefer
swapping them compared to this v4 series: first introduce minor
faults, then introduce CONTINUE.

Since Peter also has no strong opinion, and Hugh it sounds like you
prefer it the other way around, I'll swap them as we had in some
previous version of this series: first introduce minor faults, then
introduce CONTINUE.

On Tue, Apr 27, 2021 at 8:54 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 26, 2021 at 07:19:58PM -0700, Hugh Dickins wrote:
> > On Tue, 20 Apr 2021, Axel Rasmussen wrote:
> >
> > > With this change, userspace can resolve a minor fault within a
> > > shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
> > > match those for hugetlbfs - we look up the existing page in the page
> > > cache, and install a PTE for it.
> > >
> > > This commit introduces a new helper: mcopy_atomic_install_pte.
> > >
> > > Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
> > > shmem.c? The existing userfault implementation only relies on shmem.c
> > > for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
> > > fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
> > > shmem in one place, regardless of shared/private (to reduce code
> > > duplication).
> > >
> > > Why add a new mcopy_atomic_install_pte helper? A problem we have with
> > > continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
> > > *close* to what we want, but not exactly. We do want to setup the PTEs
> > > in a CONTINUE operation, but we don't want to e.g. allocate a new page,
> > > charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
> > > we have the problem stated above: shmem_mcopy_atomic_pte() and
> > > mcopy_atomic_pte() both handle one-half of the problem (shared /
> > > private) continue cares about. So, introduce mcontinue_atomic_pte(), to
> > > handle all of the shmem continue cases. Introduce the helper so it
> > > doesn't duplicate code with mcopy_atomic_pte().
> > >
> > > In a future commit, shmem_mcopy_atomic_pte() will also be modified to
> > > use this new helper. However, since this is a bigger refactor, it seems
> > > most clear to do it as a separate change.
> > >
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> >
> > If this "03/10" had been numbered 04/10, I would have said
> > Acked-by: Hugh Dickins <hughd@google.com>
> >
> > But I find this new ordering incomprehensible - I'm surprised that it
> > even builds this way around (if it does): this patch is so much about
> > what has been enabled in "04/10" (references to UFFDIO_CONTINUE shmem
> > VMAs etc).
> >
> > Does Peter still think this way round is better? If he does, then we
> > shall have to compromise by asking you just to squash the two together.
>
> Hi, Hugh, Axel,
>
> I have no strong opinion. To me, UFFDIO_CONTINUE can be introduced earlier like
> this. As long as we don't enable the feature (which is done in the next patch),
> no one will be able to call it, then it looks clean.  Merging them also looks
> good to me.
>
> Thanks,
>
> --
> Peter Xu
>
