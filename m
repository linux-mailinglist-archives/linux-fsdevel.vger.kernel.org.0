Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257DA3E041E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhHDPZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 11:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238992AbhHDPZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628090710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYL7WTiLrXdvlISyfYPUBkceFpd6GfwZ8nIKez1uy+s=;
        b=R+NxC904N4zQVE5D/OLKCAI58BCtx1Gmfmi0qrTqNKaldiiEATCIKDTYqpPWmRvVHol7bs
        GRUno08YnRee1a6ein3TpklJSC+CeVs1jDy1CsjSrnN2ZS0XXwiKlYg6EzuIjLKgjSHPCo
        3dqbe/AtcQyLQg3sA996ISbaKaKBiJQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-7wx7GOFNNimqCPmGy9FVWw-1; Wed, 04 Aug 2021 11:25:07 -0400
X-MC-Unique: 7wx7GOFNNimqCPmGy9FVWw-1
Received: by mail-wr1-f69.google.com with SMTP id l7-20020a5d48070000b0290153b1557952so943344wrq.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 08:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYL7WTiLrXdvlISyfYPUBkceFpd6GfwZ8nIKez1uy+s=;
        b=Qrresm7PTt1ngQbIYw1UJPOn8tfkgSZ8ggO0NbFZVkJpgdeuPH87UuXUp6zTQZolAM
         k75PCaCKykLnY0kUh2u1VQUaZmGx3Ia4h8OmldYFIxXDlSkyd5LWu78VULwCDHpn0n29
         EkHDrT6RQo3sMdLONkURR0jdZRhEJ4mBXH3KK2ioEkfnmk3Zb9WmxlCzyctIn/N1kflS
         TXzAeWLmGN+3ktSREoWZOH7zFp2GhGN/O62nQkKHCmsmhFqIQWbFzPFvPh2r6X8/jkXx
         RV7AUZ/YlD1OClwiD8UAGFEZ1Qmy4g1dXY3F6kgwdOKLHhKRaNQtSi6pdBVi75HyhuZu
         sv2g==
X-Gm-Message-State: AOAM531lm/jr/k+ijmnREAan8gYJPBZxJZr0gF0KKVaSpmOKxrNJDLVk
        aWip3QYKsxgN2rGwCMZiT5L1u6T/Ve/kVQ9aBakcGRewlCAm3Pjww/d1w5MXPwco3J7dE1oQ4jV
        Xhq6+9uYulv3gCH2hyVo8xXXg+5jZfKKu/vXsQPG+gw==
X-Received: by 2002:a05:600c:5108:: with SMTP id o8mr146213wms.97.1628090706475;
        Wed, 04 Aug 2021 08:25:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGPp6F/pqnoLzgNlPa34lpo9Fxz5ei5sfxO6QxFSlOC9E6qS0pKNJg4a4S7jUPOSWKzwWMmB1rxcCP3pTCg+4=
X-Received: by 2002:a05:600c:5108:: with SMTP id o8mr146202wms.97.1628090706302;
 Wed, 04 Aug 2021 08:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com> <20210803191818.993968-6-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-6-agruenba@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 4 Aug 2021 17:24:55 +0200
Message-ID: <CAHc6FU7YLUivXXa00dX1=DC1XaYLnh_j3QDvYcRoAji14WAyAQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] iov_iter: Introduce fault_in_iov_iter_writeable
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 3, 2021 at 9:18 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> Introduce a new fault_in_iov_iter_writeable helper for safely faulting in an
> iterator for writing.  Uses get_user_pages() to fault in the pages without
> actually writing to them, which would be destructive.
>
> We'll use fault_in_iov_iter_writeable in gfs2 once we've determined that the
> iterator passed to .read_iter isn't in memory.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  include/linux/pagemap.h |  1 +
>  include/linux/uio.h     |  1 +
>  lib/iov_iter.c          | 41 +++++++++++++++++++++++++++
>  mm/gup.c                | 61 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 104 insertions(+)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 7c9edc9694d9..a629807edb8c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -737,6 +737,7 @@ extern void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter);
>   * Fault in userspace address range.
>   */
>  size_t fault_in_writeable(char __user *uaddr, size_t size);
> +size_t fault_in_safe_writeable(const char __user *uaddr, size_t size);
>  size_t fault_in_readable(const char __user *uaddr, size_t size);
>
>  int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 12d30246c2e9..ffa431aeb067 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -120,6 +120,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
>  void iov_iter_advance(struct iov_iter *i, size_t bytes);
>  void iov_iter_revert(struct iov_iter *i, size_t bytes);
>  size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
> +size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t bytes);
>  size_t iov_iter_single_seg_count(const struct iov_iter *i);
>  size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
>                          struct iov_iter *i);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index c0fa1618561c..4ffc76801eaa 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -471,6 +471,47 @@ size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
>  }
>  EXPORT_SYMBOL(fault_in_iov_iter_readable);
>
> +/*
> + * fault_in_iov_iter_writeable - fault in iov iterator for writing
> + * @i: iterator
> + * @size: maximum length
> + *
> + * Faults in the iterator using get_user_pages(), i.e., without triggering
> + * hardware page faults.  This is primarily useful when we know that some or
> + * all of the pages in @i aren't in memory.
> + *
> + * Returns the number of bytes faulted in, or 0 if no bytes could be faulted in
> + * (i.e., because the address is invalid).
> + *
> + * Always returns the number of avaliable bytes for non-user space iterators.
> + */
> +size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
> +{
> +       if (size > i->count)
> +               size = i->count;
> +
> +       if (iter_is_iovec(i)) {
> +               const struct iovec *p;
> +               size_t bytes = size;
> +               size_t skip;
> +
> +               for (p = i->iov, skip = i->iov_offset; bytes; p++, skip = 0) {
> +                       size_t len = min(bytes, p->iov_len - skip);
> +                       size_t ret;
> +
> +                       if (unlikely(!len))
> +                               continue;
> +                       ret = fault_in_safe_writeable(p->iov_base + skip, len);
> +                       bytes -= ret;
> +                       if (ret != len)
> +                               break;
> +               }
> +               return size - bytes;
> +       }
> +       return size;
> +}
> +EXPORT_SYMBOL(fault_in_iov_iter_writeable);
> +
>  void iov_iter_init(struct iov_iter *i, unsigned int direction,
>                         const struct iovec *iov, unsigned long nr_segs,
>                         size_t count)
> diff --git a/mm/gup.c b/mm/gup.c
> index d04984d5d93c..7218e27c2481 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1694,6 +1694,67 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
>  }
>  EXPORT_SYMBOL(fault_in_writeable);
>
> +/**
> + * fault_in_safe_writeable - fault in an address range for writing
> + * @uaddr: start of address range
> + * @size: length of address range
> + *
> + * Faults in an address range using get_user_pages, i.e., without triggering
> + * hardware page faults.  This is primarily useful when we know that some or
> + * all of the pages in the address range aren't in memory.
> + *
> + * Other than fault_in_writeable(), this function is non-destructive.
> + *
> + * Note that we don't pin or otherwise hold the pages referenced that we fault
> + * in.  There's no guarantee that they'll stay in memory for any duration of
> + * time.
> + *
> + * Returns the number of bytes faulted in from @uaddr.
> + */
> +size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
> +{
> +       unsigned long start = (unsigned long)uaddr;
> +       unsigned long end, nstart, nend;
> +       struct mm_struct *mm = current->mm;
> +       struct vm_area_struct *vma = NULL;
> +       int locked = 0;
> +
> +       /* FIXME: Protect against overflow! */
> +
> +       end = PAGE_ALIGN(start + size);
> +       for (nstart = start & PAGE_MASK; nstart < end; nstart = nend) {
> +               unsigned long nr_pages;
> +               long ret;
> +
> +               if (!locked) {
> +                       locked = 1;
> +                       mmap_read_lock(mm);
> +                       vma = find_vma(mm, nstart);
> +               } else if (nstart >= vma->vm_end)
> +                       vma = vma->vm_next;
> +               if (!vma || vma->vm_start >= end)
> +                       break;
> +               nend = min(end, vma->vm_end);
> +               if (vma->vm_flags & (VM_IO | VM_PFNMAP))
> +                       continue;

Shouldn't we disallow read()ing into those kinds of vmas? If we skip
over them here and then the actual write results in -EFAULT, we'll end
up in a loop.

> +               if (nstart < vma->vm_start)
> +                       nstart = vma->vm_start;

Likewise, shouldn't we fail for memory ranges not covered by a vma?

> +               nr_pages = (nend - nstart) / PAGE_SIZE;
> +               ret = __get_user_pages_locked(mm, nstart, nr_pages,
> +                                             NULL, NULL, &locked,
> +                                             FOLL_TOUCH | FOLL_WRITE);
> +               if (ret <= 0)
> +                       break;
> +               nend = nstart + ret * PAGE_SIZE;
> +       }
> +       if (locked)
> +               mmap_read_unlock(mm);
> +       if (nstart > start)
> +               return min(nstart - start, size);
> +       return 0;
> +}
> +EXPORT_SYMBOL(fault_in_safe_writeable);
> +
>  size_t fault_in_readable(const char __user *uaddr, size_t size)
>  {
>         const char __user *start = uaddr, *end;
> --
> 2.26.3
>

Thanks,
Andreas

