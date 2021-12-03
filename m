Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA595467A43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 16:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381768AbhLCPc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 10:32:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352686AbhLCPc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638545373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZK0syLLqjpq6njv36WRrKUspASDFOkpbYPR5Q5+s6I=;
        b=VaOY6ZdnrJUghBjn2kKDQZDgFxUv70WwWU5F/iA5Oiac8/28gik6Jtp+Df2U63TtAl5h7c
        gSOIxD+T4m1l2J8kDJZrOYYNQjxkPQF+/al66SEubIwN252k51s6Lsnv7al0dJteHjY0/h
        dS7JxVEqVRqGd/RtgbOjv4aXtPDhejg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-mbuvDNz3NYykGUUd8N-f1g-1; Fri, 03 Dec 2021 10:29:31 -0500
X-MC-Unique: mbuvDNz3NYykGUUd8N-f1g-1
Received: by mail-wr1-f72.google.com with SMTP id k8-20020a5d5248000000b001763e7c9ce5so717535wrc.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Dec 2021 07:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZK0syLLqjpq6njv36WRrKUspASDFOkpbYPR5Q5+s6I=;
        b=mc5qJQXWIBUwbrU8WU4Q3+dRp9FjpVgIQM8yUo5Y3ZZ3euZ7TK+LaaP1fHlARsni/E
         L01NrP+6kU64CjIRlhcy67RfLsqndzDroLkCGbcYB/fJqkLdajEpptLyQZHgcugJ4OCl
         Pd/AxhYyFb97dbtW/A35YXxhNFcMTqiTJGPcI4H8qBMWdcTdoW0LuMCGWYjo78x8uh17
         AwuBrnhNKr7YiMGW7CN3Mz5Id/6ZCqcRFwR565EiVFfjYhvlVxIwxUoQpo8nVa3Gm4bR
         WezRDqr8EFH+2xIoqDZEPZ9lVcPEqEkU8gt6gPcT9lN6hofxNDZpqNvx/F37ZAMAknuq
         19AA==
X-Gm-Message-State: AOAM530VUuz0xU2n9GyCONPARxBimRylqzOzEdc3VAblEP4QVJ2dWgW9
        PCPhJC3Pyggp1fdGaVPwiFATBfXi6xXpH8TiikalmPgWkgAntEU121YZkuXL1bp4LzviUQtmLV0
        2kBL7OVnjK5uc+ZnYv4Yo56XOfd9Ot/a40JXP/cGtow==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr22761256wry.407.1638545370705;
        Fri, 03 Dec 2021 07:29:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzf+rd8AQbcRoQ9qoprsu7E4RnUUhZf2ON01ZcT6SMxdUoaQyB9fbO1vLlf46sthspy91qP8csNPtRCEW2vbF8=
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr22761212wry.407.1638545370404;
 Fri, 03 Dec 2021 07:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
In-Reply-To: <20211201193750.2097885-1-catalin.marinas@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Dec 2021 16:29:18 +0100
Message-ID: <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Avoid live-lock in fault-in+uaccess loops with
 sub-page faults
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Catalin,

On Wed, Dec 1, 2021 at 8:38 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi,
>
> Following the discussions on the first series,
>
> https://lore.kernel.org/r/20211124192024.2408218-1-catalin.marinas@arm.com
>
> this new patchset aims to generalise the sub-page probing and introduce
> a minimum size to the fault_in_*() functions. I called this 'v2' but I
> can rebase it on top of v1 and keep v1 as a btrfs live-lock
> back-portable fix.

that's what I was actually expecting, an updated patch series that
changes the btrfs code to keep track of the user-copy fault address,
the corresponding changes to the fault_in functions to call the
appropriate arch functions, and the arch functions that probe far
enough from the fault address to prevent deadlocks. In this step, how
far the arch functions need to probe depends on the fault windows of
the user-copy functions.

A next step (as a patch series on top) would be to make sure direct
I/O also takes sub-page faults into account. That seems to require
probing the entire address range before the actual copying. A concern
I have about this is time-of-check versus time-of-use: what if
sub-page faults are added after the probing but before the copying?
Other than that, an approach like adding min_size parameters might
work except that maybe we can find a better name. Also, in order not
to make things even more messy, the fault_in functions should probably
continue to report how much of the address range they've failed to
fault in. Callers can then check for themselves whether the function
could fault in min_size bytes or not.

> The fault_in_*() API improvements would be a new
> series. Anyway, I'd first like to know whether this is heading in the
> right direction and whether it's worth adding min_size to all
> fault_in_*() (more below).
>
> v2 adds a 'min_size' argument to all fault_in_*() functions with current
> callers passing 0 (or we could make it 1). A probe_subpage_*() call is
> made for the min_size range, though with all 0 this wouldn't have any
> effect. The only difference is btrfs search_ioctl() in the last patch
> which passes a non-zero min_size to avoid the live-lock (functionally
> that's the same as the v1 series).

In the btrfs case, the copying will already trigger sub-page faults;
we only need to make sure that the next fault-in attempt happens at
the fault address. (And that the fault_in functions take the user-copy
fuzz into account, which we also need for byte granularity copying
anyway.) Otherwise, we're creating the same time-of-check versus
time-of-use disparity as for direct-IO here, unnecessarily.

> In terms of sub-page probing, I don't think with the current kernel
> anything other than search_ioctl() matters. The buffered file I/O can
> already cope with current fault_in_*() + copy_*_user() loops (the
> uaccess makes progress). Direct I/O either goes via GUP + kernel mapping
> access (and memcpy() can't fault) or, if the user buffer is not PAGE
> aligned, it may fall back to buffered I/O. So we really only care about
> fault_in_writeable(), as in v1.

Yes from a regression point of view, but note that direct I/O still
circumvents the sub-page fault checking, which seems to defeat the
whole point.

> Linus suggested that we could use the min_size to request a minimum
> guaranteed probed size (in most cases this would be 1) and put a cap on
> the faulted-in size, say two pages. All the fault_in_iov_iter_*()
> callers will need to check the actual quantity returned by fault_in_*()
> rather than bail out on non-zero but Andreas has a patch already (though
> I think there are a few cases in btrfs etc.):
>
> https://lore.kernel.org/r/20211123151812.361624-1-agruenba@redhat.com
>
> With these callers fixed, we could add something like the diff below.
> But, again, min_size doesn't actually have any current use in the kernel
> other than fault_in_writeable() and search_ioctl().

We're trying pretty hard to handle large I/O requests efficiently at
the filesystem level. A small, static upper limit in the fault-in
functions has the potential to ruin those efforts. So I'm not a fan of
that.

> Thanks for having a look. Suggestions welcomed.
>
> ------------------8<-------------------------------
> diff --git a/mm/gup.c b/mm/gup.c
> index 7fa69b0fb859..3aa88aa8ce9d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1658,6 +1658,8 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
>  }
>  #endif /* !CONFIG_MMU */
>
> +#define MAX_FAULT_IN_SIZE      (2 * PAGE_SIZE)
> +
>  /**
>   * fault_in_writeable - fault in userspace address range for writing
>   * @uaddr: start of address range
> @@ -1671,6 +1673,7 @@ size_t fault_in_writeable(char __user *uaddr, size_t size, size_t min_size)
>  {
>         char __user *start = uaddr, *end;
>         size_t faulted_in = size;
> +       size_t max_size = max_t(size_t, MAX_FAULT_IN_SIZE, min_size);
>
>         if (unlikely(size == 0))
>                 return 0;
> @@ -1679,7 +1682,7 @@ size_t fault_in_writeable(char __user *uaddr, size_t size, size_t min_size)
>                         return size;
>                 uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
>         }
> -       end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
> +       end = (char __user *)PAGE_ALIGN((unsigned long)start + max_size);
>         if (unlikely(end < start))
>                 end = NULL;
>         while (uaddr != end) {
> @@ -1726,9 +1729,10 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size,
>         struct vm_area_struct *vma = NULL;
>         int locked = 0;
>         size_t faulted_in = size;
> +       size_t max_size = max_t(size_t, MAX_FAULT_IN_SIZE, min_size);
>
>         nstart = start & PAGE_MASK;
> -       end = PAGE_ALIGN(start + size);
> +       end = PAGE_ALIGN(start + max_size);
>         if (end < nstart)
>                 end = 0;
>         for (; nstart != end; nstart = nend) {
> @@ -1759,7 +1763,7 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size,
>         if (locked)
>                 mmap_read_unlock(mm);
>         if (nstart != end)
> -               faulted_in = min_t(size_t, nstart - start, size);
> +               faulted_in = min_t(size_t, nstart - start, max_size);
>         if (faulted_in < min_size ||
>             (min_size && probe_subpage_safe_writeable(uaddr, min_size)))
>                 return size;
> @@ -1782,6 +1786,7 @@ size_t fault_in_readable(const char __user *uaddr, size_t size,
>         const char __user *start = uaddr, *end;
>         volatile char c;
>         size_t faulted_in = size;
> +       size_t max_size = max_t(size_t, MAX_FAULT_IN_SIZE, min_size);
>
>         if (unlikely(size == 0))
>                 return 0;
> @@ -1790,7 +1795,7 @@ size_t fault_in_readable(const char __user *uaddr, size_t size,
>                         return size;
>                 uaddr = (const char __user *)PAGE_ALIGN((unsigned long)uaddr);
>         }
> -       end = (const char __user *)PAGE_ALIGN((unsigned long)start + size);
> +       end = (const char __user *)PAGE_ALIGN((unsigned long)start + max_size);
>         if (unlikely(end < start))
>                 end = NULL;
>         while (uaddr != end) {
> ------------------8<-------------------------------
>
> Catalin Marinas (4):
>   mm: Introduce a 'min_size' argument to fault_in_*()
>   mm: Probe for sub-page faults in fault_in_*()
>   arm64: Add support for user sub-page fault probing
>   btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page
>     faults
>
>  arch/Kconfig                        |  7 ++++
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/uaccess.h    | 59 +++++++++++++++++++++++++++++
>  arch/powerpc/kernel/kvm.c           |  2 +-
>  arch/powerpc/kernel/signal_32.c     |  4 +-
>  arch/powerpc/kernel/signal_64.c     |  2 +-
>  arch/x86/kernel/fpu/signal.c        |  2 +-
>  drivers/gpu/drm/armada/armada_gem.c |  2 +-
>  fs/btrfs/file.c                     |  6 +--
>  fs/btrfs/ioctl.c                    |  7 +++-
>  fs/f2fs/file.c                      |  2 +-
>  fs/fuse/file.c                      |  2 +-
>  fs/gfs2/file.c                      |  8 ++--
>  fs/iomap/buffered-io.c              |  2 +-
>  fs/ntfs/file.c                      |  2 +-
>  fs/ntfs3/file.c                     |  2 +-
>  include/linux/pagemap.h             |  8 ++--
>  include/linux/uaccess.h             | 53 ++++++++++++++++++++++++++
>  include/linux/uio.h                 |  6 ++-
>  lib/iov_iter.c                      | 28 +++++++++++---
>  mm/filemap.c                        |  2 +-
>  mm/gup.c                            | 37 +++++++++++++-----
>  22 files changed, 203 insertions(+), 41 deletions(-)
>

Thanks,
Andreas

