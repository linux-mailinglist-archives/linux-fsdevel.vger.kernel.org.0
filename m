Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E883143D206
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 22:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhJ0UDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhJ0UDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:03:49 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B752AC061767
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 13:01:23 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i65so9338928ybb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tw/T5Er7O1AmNvh5VxucQPnf7ZRCSnnBv8ms8NdLnzc=;
        b=m/yQ0pD9VISrL7vMkkEfzcdSBqCP3+Itb2GAAMA7HW6L7cEjIrwiS4wkVQtb4n3Ta0
         kXgMz3KkhSFaW1eLw1pn6R4UjMYbD7B0F8zP45RE4fH9SETYsJAPs6XiVNabM2UrsqEH
         ADqZ9l/s819KKP/gSyBkQlO8NnPts6z94i3foTMEan0G0N3fMVkG8L3bQpZ3iJlPCLwV
         qNke4+9mnGU7HYc+TiBZA2VYTCb1pOEdt+bwzMj0rwaaLF0oIs5Ruao78SYzll+ywLb/
         RxnKwx3T0r9S2XgUfLqbg9hTECEX6YHLvoeASlQm1WUN42Bvvcw6zm6/mH5L89MnLgsy
         Fr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tw/T5Er7O1AmNvh5VxucQPnf7ZRCSnnBv8ms8NdLnzc=;
        b=lK5jrXBD5CrhudyfyP5BC1hPzU8bNHbN714l2QanUDhhOvnguIDKMGtT4AFceV0twg
         yPXi18x/74OwzUbkJ8NG+3QvQAdiInMo6EyNj2qJ6w2BEq1AcUvsBRndsp8BO5RZnGp8
         2yJUNbQPqVA1WvuHn/iKrAxhhzc/o9oyyNKr7VXUVXMnutZnETF0YWnEADBTerNHoBLm
         07zSQwzkJFmIFQOP9u3gMmBTDNgElgn0PNHVhtWa2D9OP625/KhAy4NZ8w8Jwx0s4ie7
         OiegdrOMEODz8uKsGUOTnl8M7KXcUhJVw2K9gEtx4hq9KKrJ6P0OX/N4GM6ukYIco9hI
         KLZQ==
X-Gm-Message-State: AOAM533tJnOKWtADpw+2epX0Rx4bBKrinnAgkjs4HWCqwNjy3LC66Mwh
        VVkJwxZaIL5lV/OZtL/1smAq46XbjDxn4LbcLKP4nw==
X-Google-Smtp-Source: ABdhPJxlYGIFWgJCG8szRoW9YG40FpO0hkmbZ41eR839whDOQ/X8PiRamqPgBCDFU+v1goRGRNu55zWkc8p26vMiknU=
X-Received: by 2002:a25:c5c5:: with SMTP id v188mr21302988ybe.34.1635364882551;
 Wed, 27 Oct 2021 13:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211019215511.3771969-1-surenb@google.com> <20211019215511.3771969-2-surenb@google.com>
 <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com>
In-Reply-To: <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Oct 2021 13:01:11 -0700
Message-ID: <CAJuCfpE-fR+M_funJ4Kd+gMK9q0QHyOUD7YK0ES6En4y7E1tjg@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] mm: add a field to store names for private
 anonymous memory
To:     Alexey Alexandrov <aalexand@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:35 AM Alexey Alexandrov <aalexand@google.com> wr=
ote:
>
> > On Oct 19, 2021, at 2:55 PM, Suren Baghdasaryan <surenb@google.com> wro=
te:
> >
> > From: Colin Cross <ccross@google.com>
> >
> > In many userspace applications, and especially in VM based applications
> > like Android uses heavily, there are multiple different allocators in u=
se.
> > At a minimum there is libc malloc and the stack, and in many cases ther=
e
> > are libc malloc, the stack, direct syscalls to mmap anonymous memory, a=
nd
> > multiple VM heaps (one for small objects, one for big objects, etc.).
> > Each of these layers usually has its own tools to inspect its usage;
> > malloc by compiling a debug version, the VM through heap inspection too=
ls,
> > and for direct syscalls there is usually no way to track them.
> >
> > On Android we heavily use a set of tools that use an extended version o=
f
> > the logic covered in Documentation/vm/pagemap.txt to walk all pages map=
ped
> > in userspace and slice their usage by process, shared (COW) vs.  unique
> > mappings, backing, etc.  This can account for real physical memory usag=
e
> > even in cases like fork without exec (which Android uses heavily to sha=
re
> > as many private COW pages as possible between processes), Kernel SamePa=
ge
> > Merging, and clean zero pages.  It produces a measurement of the pages
> > that only exist in that process (USS, for unique), and a measurement of
> > the physical memory usage of that process with the cost of shared pages
> > being evenly split between processes that share them (PSS).
> >
> > If all anonymous memory is indistinguishable then figuring out the real
> > physical memory usage (PSS) of each heap requires either a pagemap walk=
ing
> > tool that can understand the heap debugging of every layer, or for ever=
y
> > layer's heap debugging tools to implement the pagemap walking logic, in
> > which case it is hard to get a consistent view of memory across the who=
le
> > system.
> >
> > Tracking the information in userspace leads to all sorts of problems.
> > It either needs to be stored inside the process, which means every
> > process has to have an API to export its current heap information upon
> > request, or it has to be stored externally in a filesystem that
> > somebody needs to clean up on crashes.  It needs to be readable while
> > the process is still running, so it has to have some sort of
> > synchronization with every layer of userspace.  Efficiently tracking
> > the ranges requires reimplementing something like the kernel vma
> > trees, and linking to it from every layer of userspace.  It requires
> > more memory, more syscalls, more runtime cost, and more complexity to
> > separately track regions that the kernel is already tracking.
> >
> > This patch adds a field to /proc/pid/maps and /proc/pid/smaps to show a
> > userspace-provided name for anonymous vmas.  The names of named anonymo=
us
> > vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name>].
> >
> > Userspace can set the name for a region of memory by calling
> > prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)name=
);
> > Setting the name to NULL clears it. The name length limit is 80 bytes
> > including NUL-terminator and is checked to contain only printable ascii
> > characters (including space), except '[',']','\','$' and '`'. Ascii
> > strings are being used to have a descriptive identifiers for vmas, whic=
h
> > can be understood by the users reading /proc/pid/maps or /proc/pid/smap=
s.
> > Names can be standardized for a given system and they can include some
> > variable parts such as the name of the allocator or a library, tid of
> > the thread using it, etc.
> >
> > The name is stored in a pointer in the shared union in vm_area_struct
> > that points to a null terminated string. Anonymous vmas with the same
> > name (equivalent strings) and are otherwise mergeable will be merged.
> > The name pointers are not shared between vmas even if they contain the
> > same name. The name pointer is stored in a union with fields that are
> > only used on file-backed mappings, so it does not increase memory usage=
.
> >
> > CONFIG_ANON_VMA_NAME kernel configuration is introduced to enable this
> > feature. It keeps the feature disabled by default to prevent any
> > additional memory overhead and to avoid confusing procfs parsers on
> > systems which are not ready to support named anonymous vmas.
> >
> > The patch is based on the original patch developed by Colin Cross, more
> > specifically on its latest version [1] posted upstream by Sumit Semwal.
> > It used a userspace pointer to store vma names. In that design, name
> > pointers could be shared between vmas. However during the last upstream=
ing
> > attempt, Kees Cook raised concerns [2] about this approach and suggeste=
d
> > to copy the name into kernel memory space, perform validity checks [3]
> > and store as a string referenced from vm_area_struct.
> > One big concern is about fork() performance which would need to strdup
> > anonymous vma names. Dave Hansen suggested experimenting with worst-cas=
e
> > scenario of forking a process with 64k vmas having longest possible nam=
es
> > [4]. I ran this experiment on an ARM64 Android device and recorded a
> > worst-case regression of almost 40% when forking such a process. This
> > regression is addressed in the followup patch which replaces the pointe=
r
> > to a name with a refcounted structure that allows sharing the name poin=
ter
> > between vmas of the same name. Instead of duplicating the string during
> > fork() or when splitting a vma it increments the refcount.
> >
> > [1] https://lore.kernel.org/linux-mm/20200901161459.11772-4-sumit.semwa=
l@linaro.org/
> > [2] https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescook/
> > [3] https://lore.kernel.org/linux-mm/202009031022.3834F692@keescook/
> > [4] https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d6a8e=
95@intel.com/
> >
> > Changes for prctl(2) manual page (in the options section):
> >
> > PR_SET_VMA
> >       Sets an attribute specified in arg2 for virtual memory areas
> >       starting from the address specified in arg3 and spanning the
> >       size specified  in arg4. arg5 specifies the value of the attribut=
e
> >       to be set. Note that assigning an attribute to a virtual memory
> >       area might prevent it from being merged with adjacent virtual
> >       memory areas due to the difference in that attribute's value.
> >
> >       Currently, arg2 must be one of:
> >
> >       PR_SET_VMA_ANON_NAME
> >               Set a name for anonymous virtual memory areas. arg5 shoul=
d
> >               be a pointer to a null-terminated string containing the
> >               name. The name length including null byte cannot exceed
> >               80 bytes. If arg5 is NULL, the name of the appropriate
> >               anonymous virtual memory areas will be reset. The name
> >               can contain only printable ascii characters (including
> >                space), except '[',']','\','$' and '`'.
> >
> >                This feature is available only if the kernel is built wi=
th
> >                the CONFIG_ANON_VMA_NAME option enabled.
>
> For what it=E2=80=99s worth, it=E2=80=99s definitely interesting to see t=
his going upstream.
> In particular, we would use it for high-level grouping of the data in
> production profiling when proper symbolization is not available:
>
> * JVM could associate a name with the memory regions it uses for the JIT
>   code so that Linux perf data are associated with a high level name like
>   "Java JIT" even if the proper Java JIT profiling is not enabled.
> * Similar for other JIT engines like v8 - they could annotate the memory
>   regions they manage and use as well.
> * Traditional memory allocators like tcmalloc can use this as well so
>   that the associated name is used in data access profiling via Linux per=
f.

Hi Alexey,
Thanks for providing your feedback! Nice to hear that this can be
useful outside of Android.
