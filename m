Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8B400198
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349488AbhICO6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhICO6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:58:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202BC061575;
        Fri,  3 Sep 2021 07:57:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a10so6018468qka.12;
        Fri, 03 Sep 2021 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zZZ87vz+C4ZG1Hl87mUuE3qkrU78d+Yyq+IOBIIOZx8=;
        b=mPztU7i+zjQ6o0IVLJTsGSi5DqnRPp4nS2m7r/OaOEQmwK7KPEO+Kcw9VA9JRhl9Ap
         vB6CYN3iPYv7kiulki49woN3h2mtE/0OhOALqdYnBCZD39z0TYBFABJJjQcpWPe2oNiF
         //chMvVB2LQkgs6Ge0uS7nhWHENEG1AzqwtjW4iF3c7R84OjvEJ642xG3CliHVWtGSQF
         nIqOeQK701kEZmBsUlpdH3lCVQWrPcb4hOu5D/NE2rt/DYHzQoXVBwJ0kXTPEhN7zpP5
         fhO2UqOvn/X8R5UkHm7tEysYG8ZulcqKrXFDnCxH2DGJcmLQPxXgDBkneNT4sLrMpnrL
         iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zZZ87vz+C4ZG1Hl87mUuE3qkrU78d+Yyq+IOBIIOZx8=;
        b=ABYDBVxt8EwCDBjuCQsbkBS9HWqrMZTkF5KZyTMMXeD9QIq70fCDGgKfjhfDAQ8Nvj
         ro7bfxOh4PHtI4FbWu7/jJ1+MvGovnvUPidiRDF6aV1vyGwl8iXI54slTFFKJbYk8/G6
         t2IAHcjal0aqmq4sQP/AtmatB3fT2ZtkvSTfGZO+X6TRdZl+rPpE+WPuUSFqLvNOs+Og
         wnFL8ce2QA3Cs5OuyjEtEmBG/YDQ2/s7RVDzwiRf+3Lz4KMAFciw2kdBIGzFYu6zR4un
         xC4PP86mQRS9foF4SqICxiEMXRSuUJ1hev+2gvxbJps725LK4BX5e3kSkDacQXuy91LT
         4GpA==
X-Gm-Message-State: AOAM5305wqbq/PXPD48/aBHvEmfREpNPsgebf7QOJwMaVRnwGlgJG0cT
        oiy+DZBSVunWzmjGridSe0MN1BHF00wOyeh5b3I=
X-Google-Smtp-Source: ABdhPJya3MW9SYu99by6AJvnWGomTIJpxGGxiaEezkkc/DxB/L0cwQit7tm7pIwIsRCcEVqrBxOxbWHmrGM7YzS6H+Q=
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr3864553qkp.388.1630681023513;
 Fri, 03 Sep 2021 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-4-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-4-agruenba@redhat.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 Sep 2021 15:56:27 +0100
Message-ID: <CAL3q7H7PdBTuK28tN=3fGUyTP9wJU8Ydrq35YtNsfA_3xRQhzQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/19] gup: Turn fault_in_pages_{readable,writeable}
 into fault_in_{readable,writeable}
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 5:52 PM Andreas Gruenbacher <agruenba@redhat.com> w=
rote:
>
> Turn fault_in_pages_{readable,writeable} into versions that return the
> number of bytes not faulted in (similar to copy_to_user) instead of
> returning a non-zero value when any of the requested pages couldn't be
> faulted in.  This supports the existing users that require all pages to
> be faulted in as well as new users that are happy if any pages can be
> faulted in at all.
>
> Neither of these functions is entirely trivial and it doesn't seem
> useful to inline them, so move them to mm/gup.c.
>
> Rename the functions to fault_in_{readable,writeable} to make sure that
> this change doesn't silently break things.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  arch/powerpc/kernel/kvm.c           |  3 +-
>  arch/powerpc/kernel/signal_32.c     |  4 +-
>  arch/powerpc/kernel/signal_64.c     |  2 +-
>  arch/x86/kernel/fpu/signal.c        |  7 ++-
>  drivers/gpu/drm/armada/armada_gem.c |  7 ++-
>  fs/btrfs/ioctl.c                    |  5 +-
>  include/linux/pagemap.h             | 57 ++---------------------
>  lib/iov_iter.c                      | 10 ++--
>  mm/filemap.c                        |  2 +-
>  mm/gup.c                            | 72 +++++++++++++++++++++++++++++
>  10 files changed, 93 insertions(+), 76 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index d89cf802d9aa..6568823cf306 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -669,7 +669,8 @@ static void __init kvm_use_magic_page(void)
>         on_each_cpu(kvm_map_magic_page, &features, 1);
>
>         /* Quick self-test to see if the mapping works */
> -       if (fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(=
u32))) {
> +       if (fault_in_readable((const char __user *)KVM_MAGIC_PAGE,
> +                             sizeof(u32))) {
>                 kvm_patching_worked =3D false;
>                 return;
>         }
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal=
_32.c
> index 0608581967f0..38c3eae40c14 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1048,7 +1048,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user=
 *, old_ctx,
>         if (new_ctx =3D=3D NULL)
>                 return 0;
>         if (!access_ok(new_ctx, ctx_size) ||
> -           fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
> +           fault_in_readable((char __user *)new_ctx, ctx_size))
>                 return -EFAULT;
>
>         /*
> @@ -1237,7 +1237,7 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext _=
_user *, ctx,
>  #endif
>
>         if (!access_ok(ctx, sizeof(*ctx)) ||
> -           fault_in_pages_readable((u8 __user *)ctx, sizeof(*ctx)))
> +           fault_in_readable((char __user *)ctx, sizeof(*ctx)))
>                 return -EFAULT;
>
>         /*
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 1831bba0582e..9f471b4a11e3 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -688,7 +688,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *=
, old_ctx,
>         if (new_ctx =3D=3D NULL)
>                 return 0;
>         if (!access_ok(new_ctx, ctx_size) ||
> -           fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
> +           fault_in_readable((char __user *)new_ctx, ctx_size))
>                 return -EFAULT;
>
>         /*
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 445c57c9c539..ba6bdec81603 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -205,7 +205,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void _=
_user *buf_fx, int size)
>         fpregs_unlock();
>
>         if (ret) {
> -               if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_siz=
e))
> +               if (!fault_in_writeable(buf_fx, fpu_user_xstate_size))
>                         goto retry;
>                 return -EFAULT;
>         }
> @@ -278,10 +278,9 @@ static int restore_fpregs_from_user(void __user *buf=
, u64 xrestore,
>                 if (ret !=3D -EFAULT)
>                         return -EINVAL;
>
> -               ret =3D fault_in_pages_readable(buf, size);
> -               if (!ret)
> +               if (!fault_in_readable(buf, size))
>                         goto retry;
> -               return ret;
> +               return -EFAULT;
>         }
>
>         /*
> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada=
/armada_gem.c
> index 21909642ee4c..8fbb25913327 100644
> --- a/drivers/gpu/drm/armada/armada_gem.c
> +++ b/drivers/gpu/drm/armada/armada_gem.c
> @@ -336,7 +336,7 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, v=
oid *data,
>         struct drm_armada_gem_pwrite *args =3D data;
>         struct armada_gem_object *dobj;
>         char __user *ptr;
> -       int ret;
> +       int ret =3D 0;
>
>         DRM_DEBUG_DRIVER("handle %u off %u size %u ptr 0x%llx\n",
>                 args->handle, args->offset, args->size, args->ptr);
> @@ -349,9 +349,8 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, v=
oid *data,
>         if (!access_ok(ptr, args->size))
>                 return -EFAULT;
>
> -       ret =3D fault_in_pages_readable(ptr, args->size);
> -       if (ret)
> -               return ret;
> +       if (fault_in_readable(ptr, args->size))
> +               return -EFAULT;
>
>         dobj =3D armada_gem_object_lookup(file, args->handle);
>         if (dobj =3D=3D NULL)
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ba98e08a029..9233ecc31e2e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2244,9 +2244,8 @@ static noinline int search_ioctl(struct inode *inod=
e,
>         key.offset =3D sk->min_offset;
>
>         while (1) {
> -               ret =3D fault_in_pages_writeable(ubuf + sk_offset,
> -                                              *buf_size - sk_offset);
> -               if (ret)
> +               ret =3D -EFAULT;
> +               if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_o=
ffset))
>                         break;
>
>                 ret =3D btrfs_search_forward(root, &key, path, sk->min_tr=
ansid);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ed02aa522263..7c9edc9694d9 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -734,61 +734,10 @@ int wait_on_page_private_2_killable(struct page *pa=
ge);
>  extern void add_page_wait_queue(struct page *page, wait_queue_entry_t *w=
aiter);
>
>  /*
> - * Fault everything in given userspace address range in.
> + * Fault in userspace address range.
>   */
> -static inline int fault_in_pages_writeable(char __user *uaddr, int size)
> -{
> -       char __user *end =3D uaddr + size - 1;
> -
> -       if (unlikely(size =3D=3D 0))
> -               return 0;
> -
> -       if (unlikely(uaddr > end))
> -               return -EFAULT;
> -       /*
> -        * Writing zeroes into userspace here is OK, because we know that=
 if
> -        * the zero gets there, we'll be overwriting it.
> -        */
> -       do {
> -               if (unlikely(__put_user(0, uaddr) !=3D 0))
> -                       return -EFAULT;
> -               uaddr +=3D PAGE_SIZE;
> -       } while (uaddr <=3D end);
> -
> -       /* Check whether the range spilled into the next page. */
> -       if (((unsigned long)uaddr & PAGE_MASK) =3D=3D
> -                       ((unsigned long)end & PAGE_MASK))
> -               return __put_user(0, end);
> -
> -       return 0;
> -}
> -
> -static inline int fault_in_pages_readable(const char __user *uaddr, int =
size)
> -{
> -       volatile char c;
> -       const char __user *end =3D uaddr + size - 1;
> -
> -       if (unlikely(size =3D=3D 0))
> -               return 0;
> -
> -       if (unlikely(uaddr > end))
> -               return -EFAULT;
> -
> -       do {
> -               if (unlikely(__get_user(c, uaddr) !=3D 0))
> -                       return -EFAULT;
> -               uaddr +=3D PAGE_SIZE;
> -       } while (uaddr <=3D end);
> -
> -       /* Check whether the range spilled into the next page. */
> -       if (((unsigned long)uaddr & PAGE_MASK) =3D=3D
> -                       ((unsigned long)end & PAGE_MASK)) {
> -               return __get_user(c, end);
> -       }
> -
> -       (void)c;
> -       return 0;
> -}
> +size_t fault_in_writeable(char __user *uaddr, size_t size);
> +size_t fault_in_readable(const char __user *uaddr, size_t size);
>
>  int add_to_page_cache_locked(struct page *page, struct address_space *ma=
pping,
>                                 pgoff_t index, gfp_t gfp_mask);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 25dfc48536d7..069cedd9d7b4 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -191,7 +191,7 @@ static size_t copy_page_to_iter_iovec(struct page *pa=
ge, size_t offset, size_t b
>         buf =3D iov->iov_base + skip;
>         copy =3D min(bytes, iov->iov_len - skip);
>
> -       if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_pages_writeable(buf, =
copy)) {
> +       if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_writeable(buf, copy))=
 {
>                 kaddr =3D kmap_atomic(page);
>                 from =3D kaddr + offset;
>
> @@ -275,7 +275,7 @@ static size_t copy_page_from_iter_iovec(struct page *=
page, size_t offset, size_t
>         buf =3D iov->iov_base + skip;
>         copy =3D min(bytes, iov->iov_len - skip);
>
> -       if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_pages_readable(buf, c=
opy)) {
> +       if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_readable(buf, copy)) =
{
>                 kaddr =3D kmap_atomic(page);
>                 to =3D kaddr + offset;
>
> @@ -446,13 +446,11 @@ int iov_iter_fault_in_readable(const struct iov_ite=
r *i, size_t bytes)
>                         bytes =3D i->count;
>                 for (p =3D i->iov, skip =3D i->iov_offset; bytes; p++, sk=
ip =3D 0) {
>                         size_t len =3D min(bytes, p->iov_len - skip);
> -                       int err;
>
>                         if (unlikely(!len))
>                                 continue;
> -                       err =3D fault_in_pages_readable(p->iov_base + ski=
p, len);
> -                       if (unlikely(err))
> -                               return err;
> +                       if (fault_in_readable(p->iov_base + skip, len))
> +                               return -EFAULT;
>                         bytes -=3D len;
>                 }
>         }
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d1458ecf2f51..4dec3bc7752e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -88,7 +88,7 @@
>   *    ->lock_page              (access_process_vm)
>   *
>   *  ->i_mutex                  (generic_perform_write)
> - *    ->mmap_lock              (fault_in_pages_readable->do_page_fault)
> + *    ->mmap_lock              (fault_in_readable->do_page_fault)
>   *
>   *  bdi->wb.list_lock
>   *    sb_lock                  (fs/fs-writeback.c)
> diff --git a/mm/gup.c b/mm/gup.c
> index b94717977d17..0cf47955e5a1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1672,6 +1672,78 @@ static long __get_user_pages_locked(struct mm_stru=
ct *mm, unsigned long start,
>  }
>  #endif /* !CONFIG_MMU */
>
> +/**
> + * fault_in_writeable - fault in userspace address range for writing
> + * @uaddr: start of address range
> + * @size: size of address range
> + *
> + * Returns the number of bytes not faulted in (like copy_to_user() and
> + * copy_from_user()).
> + */
> +size_t fault_in_writeable(char __user *uaddr, size_t size)
> +{
> +       char __user *start =3D uaddr, *end;
> +
> +       if (unlikely(size =3D=3D 0))
> +               return 0;
> +       if (!PAGE_ALIGNED(uaddr)) {
> +               if (unlikely(__put_user(0, uaddr) !=3D 0))
> +                       return size;
> +               uaddr =3D (char __user *)PAGE_ALIGN((unsigned long)uaddr)=
;
> +       }
> +       end =3D (char __user *)PAGE_ALIGN((unsigned long)start + size);
> +       if (unlikely(end < start))
> +               end =3D NULL;
> +       while (uaddr !=3D end) {
> +               if (unlikely(__put_user(0, uaddr) !=3D 0))
> +                       goto out;
> +               uaddr +=3D PAGE_SIZE;

Won't we loop endlessly or corrupt some unwanted page when 'end' was
set to NULL?

> +       }
> +
> +out:
> +       if (size > uaddr - start)
> +               return size - (uaddr - start);
> +       return 0;
> +}
> +EXPORT_SYMBOL(fault_in_writeable);
> +
> +/**
> + * fault_in_readable - fault in userspace address range for reading
> + * @uaddr: start of user address range
> + * @size: size of user address range
> + *
> + * Returns the number of bytes not faulted in (like copy_to_user() and
> + * copy_from_user()).
> + */
> +size_t fault_in_readable(const char __user *uaddr, size_t size)
> +{
> +       const char __user *start =3D uaddr, *end;
> +       volatile char c;
> +
> +       if (unlikely(size =3D=3D 0))
> +               return 0;
> +       if (!PAGE_ALIGNED(uaddr)) {
> +               if (unlikely(__get_user(c, uaddr) !=3D 0))
> +                       return size;
> +               uaddr =3D (const char __user *)PAGE_ALIGN((unsigned long)=
uaddr);
> +       }
> +       end =3D (const char __user *)PAGE_ALIGN((unsigned long)start + si=
ze);
> +       if (unlikely(end < start))
> +               end =3D NULL;
> +       while (uaddr !=3D end) {

Same kind of issue here, when 'end' was set to NULL?

Thanks.

> +               if (unlikely(__get_user(c, uaddr) !=3D 0))
> +                       goto out;
> +               uaddr +=3D PAGE_SIZE;
> +       }
> +
> +out:
> +       (void)c;
> +       if (size > uaddr - start)
> +               return size - (uaddr - start);
> +       return 0;
> +}
> +EXPORT_SYMBOL(fault_in_readable);
> +
>  /**
>   * get_dump_page() - pin user page in memory while writing it to core du=
mp
>   * @addr: user address
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
