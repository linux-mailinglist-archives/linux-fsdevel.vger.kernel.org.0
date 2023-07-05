Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7A748BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjGESYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjGESY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:24:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F41BE1
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 11:24:06 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703c900e3so3551901fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688581441; x=1691173441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbd7RAFaA95+R8mZ/AXjac9HJjeSJJgR1WpgUAM/AL0=;
        b=kVSIGzL352IB5Kbk25lgjcw5saC1YO10AdWs+QKyw4ELHQKHRM4XlZL1DbpD3H6jo9
         cA5dTyV0Ub2isd663QDGIqwAHCmo3doSf+C0aqGbmqcGhpyw29l9hI9YJMdlhkNj+9fU
         vpMafQ8UrtGim4HvTqImR9lpOCa3TXjC0rlH/ivRgJ8PkFxen/FIoQ0zqUNvl4c0r/dA
         wGuUonsPYyql5i5IeCZHImVbWAns84E+WyuSZnVjERgZLBtPSmuQt47kgDSjKUqF+aap
         kPlwgxgnXc0jV5S5Dgr/Rupgt+l9sFq1EzgISkmPrFtCnONkq9c6tedt1vg3Hw7DxTM5
         uXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581441; x=1691173441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbd7RAFaA95+R8mZ/AXjac9HJjeSJJgR1WpgUAM/AL0=;
        b=S/WNbQ+NPi1LXR73SFh0vwEENduvBGTTJow9TuAJrEw876033DX0L+m1kK2jLKoqvY
         zEAAD3SiiTWM6+nKVOFJvWIsXitd3swe73yx/0cWtHryWYvtBn6MH83V6e3fER+J8r+M
         qV182L2NQvC375CEXXiokb59Na3dZV6qfaLDSULPSNLvMQN+MA8lka/mreBoa5g1/IHQ
         XhOTBuAjfXMzOaHAKOnl2bOqadbHENg+iumHUOZmhpVfRmTg/jmAx25ivJfmmZNsD+w9
         ZUlAxAXBgnWCBhAUnMJB1eQreMmmibaRuMw6ou7ddiXxxx/zIv9TV21j7zUawabQuxjl
         okvA==
X-Gm-Message-State: ABy/qLYnPlTd5IMrD7AgPTLVPq2W+h/uufbgLzSxJwjncxIQZgRAXmUe
        XSZqOSjje/cgIYNQqQmm6YX8LipNsyOVNitW3saA2g==
X-Google-Smtp-Source: APBJJlEygUyErL6yJqO8bioc2L0eLzruugzCDJAI7Niw3GBLyD1hIJqcVX3vRU2ISDHjey093PUyZT/Id5A2ftxRTcc=
X-Received: by 2002:a2e:9610:0:b0:2b6:d8ea:6650 with SMTP id
 v16-20020a2e9610000000b002b6d8ea6650mr9647325ljh.27.1688581439764; Wed, 05
 Jul 2023 11:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com> <CACw3F53p8szcxv7PSOSqN6ps3hHmRD4VQor3pLd0Cqrn-p2Ajw@mail.gmail.com>
In-Reply-To: <CACw3F53p8szcxv7PSOSqN6ps3hHmRD4VQor3pLd0Cqrn-p2Ajw@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 5 Jul 2023 11:23:23 -0700
Message-ID: <CAJHvVcid5_W0AmfM1zUBmv_sPAHDqcROVAAf9HDK3iuxj4eXVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 5, 2023 at 11:18=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> On Thu, Jun 29, 2023 at 1:50=E2=80=AFPM Axel Rasmussen <axelrasmussen@goo=
gle.com> wrote:
> >
> > The basic idea here is to "simulate" memory poisoning for VMs. A VM
> > running on some host might encounter a memory error, after which some
> > page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> > once poisoned, pages can never become "un-poisoned". So, when we live
> > migrate the VM, we need to preserve the poisoned status of these pages.
> >
> > When live migrating, we try to get the guest running on its new host as
> > quickly as possible. So, we start it running before all memory has been
> > copied, and before we're certain which pages should be poisoned or not.
> >
> > So the basic way to use this new feature is:
> >
> > - On the new host, the guest's memory is registered with userfaultfd, i=
n
> >   either MISSING or MINOR mode (doesn't really matter for this purpose)=
.
> > - On any first access, we get a userfaultfd event. At this point we can
> >   communicate with the old host to find out if the page was poisoned.
> > - If so, we can respond with a UFFDIO_POISON - this places a swap marke=
r
> >   so any future accesses will SIGBUS. Because the pte is now "present",
> >   future accesses won't generate more userfaultfd events, they'll just
> >   SIGBUS directly.
> >
> > UFFDIO_POISON does not handle unmapping previously-present PTEs. This
>
> A minor suggestion, would UFFDIO_HWPOISON be better? so that readers
> won't be confused with CONFIG_PAGE_POISONING (a feature to fill the
> pages with poison patterns after free).

I was a bit wary of using "HWPOISON" because this is more like
"simulated" poisoning, not "real" hardware poisoning. :/

But, maybe folks feel that distinction is less important than the one
you've raised here Jiaqi. I don't have the strongest opinion.

>
> > isn't needed, because during live migration we want to intercept
> > all accesses with userfaultfd (not just writes, so WP mode isn't useful
> > for this). So whether minor or missing mode is being used (or both), th=
e
> > PTE won't be present in any case, so handling that case isn't needed.
> >
> > Why return VM_FAULT_HWPOISON instead of VM_FAULT_SIGBUS when one of
> > these markers is encountered? For "normal" userspace programs there
> > isn't a big difference, both yield a SIGBUS. The difference for KVM is
> > key though: VM_FAULT_HWPOISON will result in an MCE being injected into
> > the guest (which is the behavior we want). With VM_FAULT_SIGBUS, the
> > hypervisor would need to catch the SIGBUS and deal with the MCE
> > injection itself.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c                 | 63 ++++++++++++++++++++++++++++++++
> >  include/linux/swapops.h          |  3 +-
> >  include/linux/userfaultfd_k.h    |  4 ++
> >  include/uapi/linux/userfaultfd.h | 25 +++++++++++--
> >  mm/memory.c                      |  4 ++
> >  mm/userfaultfd.c                 | 62 ++++++++++++++++++++++++++++++-
> >  6 files changed, 156 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 7cecd49e078b..c26a883399c9 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1965,6 +1965,66 @@ static int userfaultfd_continue(struct userfault=
fd_ctx *ctx, unsigned long arg)
> >         return ret;
> >  }
> >
> > +static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsi=
gned long arg)
> > +{
> > +       __s64 ret;
> > +       struct uffdio_poison uffdio_poison;
> > +       struct uffdio_poison __user *user_uffdio_poison;
> > +       struct userfaultfd_wake_range range;
> > +
> > +       user_uffdio_poison =3D (struct uffdio_poison __user *)arg;
> > +
> > +       ret =3D -EAGAIN;
> > +       if (atomic_read(&ctx->mmap_changing))
> > +               goto out;
> > +
> > +       ret =3D -EFAULT;
> > +       if (copy_from_user(&uffdio_poison, user_uffdio_poison,
> > +                          /* don't copy the output fields */
> > +                          sizeof(uffdio_poison) - (sizeof(__s64))))
> > +               goto out;
> > +
> > +       ret =3D validate_range(ctx->mm, uffdio_poison.range.start,
> > +                            uffdio_poison.range.len);
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret =3D -EINVAL;
> > +       /* double check for wraparound just in case. */
> > +       if (uffdio_poison.range.start + uffdio_poison.range.len <=3D
> > +           uffdio_poison.range.start) {
> > +               goto out;
> > +       }
> > +       if (uffdio_poison.mode & ~UFFDIO_POISON_MODE_DONTWAKE)
> > +               goto out;
> > +
> > +       if (mmget_not_zero(ctx->mm)) {
> > +               ret =3D mfill_atomic_poison(ctx->mm, uffdio_poison.rang=
e.start,
> > +                                         uffdio_poison.range.len,
> > +                                         &ctx->mmap_changing, 0);
> > +               mmput(ctx->mm);
> > +       } else {
> > +               return -ESRCH;
> > +       }
> > +
> > +       if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
> > +               return -EFAULT;
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       /* len =3D=3D 0 would wake all */
> > +       BUG_ON(!ret);
> > +       range.len =3D ret;
> > +       if (!(uffdio_poison.mode & UFFDIO_POISON_MODE_DONTWAKE)) {
> > +               range.start =3D uffdio_poison.range.start;
> > +               wake_userfault(ctx, &range);
> > +       }
> > +       ret =3D range.len =3D=3D uffdio_poison.range.len ? 0 : -EAGAIN;
> > +
> > +out:
> > +       return ret;
> > +}
> > +
> >  static inline unsigned int uffd_ctx_features(__u64 user_features)
> >  {
> >         /*
> > @@ -2066,6 +2126,9 @@ static long userfaultfd_ioctl(struct file *file, =
unsigned cmd,
> >         case UFFDIO_CONTINUE:
> >                 ret =3D userfaultfd_continue(ctx, arg);
> >                 break;
> > +       case UFFDIO_POISON:
> > +               ret =3D userfaultfd_poison(ctx, arg);
> > +               break;
> >         }
> >         return ret;
> >  }
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index 4c932cb45e0b..8259fee32421 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
> >
> >  #define  PTE_MARKER_UFFD_WP                    BIT(0)
> >  #define  PTE_MARKER_SWAPIN_ERROR               BIT(1)
> > -#define  PTE_MARKER_MASK                       (BIT(2) - 1)
> > +#define  PTE_MARKER_UFFD_POISON                        BIT(2)
> > +#define  PTE_MARKER_MASK                       (BIT(3) - 1)
> >
> >  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> >  {
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_=
k.h
> > index ac7b0c96d351..ac8c6854097c 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -46,6 +46,7 @@ enum mfill_atomic_mode {
> >         MFILL_ATOMIC_COPY,
> >         MFILL_ATOMIC_ZEROPAGE,
> >         MFILL_ATOMIC_CONTINUE,
> > +       MFILL_ATOMIC_POISON,
> >         NR_MFILL_ATOMIC_MODES,
> >  };
> >
> > @@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct=
 *dst_mm,
> >  extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigne=
d long dst_start,
> >                                      unsigned long len, atomic_t *mmap_=
changing,
> >                                      uffd_flags_t flags);
> > +extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned =
long start,
> > +                                  unsigned long len, atomic_t *mmap_ch=
anging,
> > +                                  uffd_flags_t flags);
> >  extern int mwriteprotect_range(struct mm_struct *dst_mm,
> >                                unsigned long start, unsigned long len,
> >                                bool enable_wp, atomic_t *mmap_changing)=
;
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/user=
faultfd.h
> > index 66dd4cd277bd..62151706c5a3 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -39,7 +39,8 @@
> >                            UFFD_FEATURE_MINOR_SHMEM |           \
> >                            UFFD_FEATURE_EXACT_ADDRESS |         \
> >                            UFFD_FEATURE_WP_HUGETLBFS_SHMEM |    \
> > -                          UFFD_FEATURE_WP_UNPOPULATED)
> > +                          UFFD_FEATURE_WP_UNPOPULATED |        \
> > +                          UFFD_FEATURE_POISON)
> >  #define UFFD_API_IOCTLS                                \
> >         ((__u64)1 << _UFFDIO_REGISTER |         \
> >          (__u64)1 << _UFFDIO_UNREGISTER |       \
> > @@ -49,12 +50,14 @@
> >          (__u64)1 << _UFFDIO_COPY |             \
> >          (__u64)1 << _UFFDIO_ZEROPAGE |         \
> >          (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> > -        (__u64)1 << _UFFDIO_CONTINUE)
> > +        (__u64)1 << _UFFDIO_CONTINUE |         \
> > +        (__u64)1 << _UFFDIO_POISON)
> >  #define UFFD_API_RANGE_IOCTLS_BASIC            \
> >         ((__u64)1 << _UFFDIO_WAKE |             \
> >          (__u64)1 << _UFFDIO_COPY |             \
> > +        (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> >          (__u64)1 << _UFFDIO_CONTINUE |         \
> > -        (__u64)1 << _UFFDIO_WRITEPROTECT)
> > +        (__u64)1 << _UFFDIO_POISON)
> >
> >  /*
> >   * Valid ioctl command number range with this API is from 0x00 to
> > @@ -71,6 +74,7 @@
> >  #define _UFFDIO_ZEROPAGE               (0x04)
> >  #define _UFFDIO_WRITEPROTECT           (0x06)
> >  #define _UFFDIO_CONTINUE               (0x07)
> > +#define _UFFDIO_POISON                 (0x08)
> >  #define _UFFDIO_API                    (0x3F)
> >
> >  /* userfaultfd ioctl ids */
> > @@ -91,6 +95,8 @@
> >                                       struct uffdio_writeprotect)
> >  #define UFFDIO_CONTINUE                _IOWR(UFFDIO, _UFFDIO_CONTINUE,=
 \
> >                                       struct uffdio_continue)
> > +#define UFFDIO_POISON          _IOWR(UFFDIO, _UFFDIO_POISON, \
> > +                                     struct uffdio_poison)
> >
> >  /* read() structure */
> >  struct uffd_msg {
> > @@ -225,6 +231,7 @@ struct uffdio_api {
> >  #define UFFD_FEATURE_EXACT_ADDRESS             (1<<11)
> >  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM                (1<<12)
> >  #define UFFD_FEATURE_WP_UNPOPULATED            (1<<13)
> > +#define UFFD_FEATURE_POISON                    (1<<14)
> >         __u64 features;
> >
> >         __u64 ioctls;
> > @@ -321,6 +328,18 @@ struct uffdio_continue {
> >         __s64 mapped;
> >  };
> >
> > +struct uffdio_poison {
> > +       struct uffdio_range range;
> > +#define UFFDIO_POISON_MODE_DONTWAKE            ((__u64)1<<0)
> > +       __u64 mode;
> > +
> > +       /*
> > +        * Fields below here are written by the ioctl and must be at th=
e end:
> > +        * the copy_from_user will not read past here.
> > +        */
> > +       __s64 updated;
> > +};
> > +
> >  /*
> >   * Flags for the userfaultfd(2) system call itself.
> >   */
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d8a9a770b1f1..7fbda39e060d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3692,6 +3692,10 @@ static vm_fault_t handle_pte_marker(struct vm_fa=
ult *vmf)
> >         if (WARN_ON_ONCE(!marker))
> >                 return VM_FAULT_SIGBUS;
> >
> > +       /* Poison emulation explicitly requested for this PTE. */
> > +       if (marker & PTE_MARKER_UFFD_POISON)
> > +               return VM_FAULT_HWPOISON;
> > +
> >         /* Higher priority than uffd-wp when data corrupted */
> >         if (marker & PTE_MARKER_SWAPIN_ERROR)
> >                 return VM_FAULT_SIGBUS;
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index a2bf37ee276d..87b62ca1e09e 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -286,6 +286,51 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pm=
d,
> >         goto out;
> >  }
> >
> > +/* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
> > +static int mfill_atomic_pte_poison(pmd_t *dst_pmd,
> > +                                  struct vm_area_struct *dst_vma,
> > +                                  unsigned long dst_addr,
> > +                                  uffd_flags_t flags)
> > +{
> > +       int ret;
> > +       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > +       pte_t _dst_pte, *dst_pte;
> > +       spinlock_t *ptl;
> > +
> > +       _dst_pte =3D make_pte_marker(PTE_MARKER_UFFD_POISON);
> > +       dst_pte =3D pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl=
);
> > +
> > +       if (vma_is_shmem(dst_vma)) {
> > +               struct inode *inode;
> > +               pgoff_t offset, max_off;
> > +
> > +               /* serialize against truncate with the page table lock =
*/
> > +               inode =3D dst_vma->vm_file->f_inode;
> > +               offset =3D linear_page_index(dst_vma, dst_addr);
> > +               max_off =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE)=
;
> > +               ret =3D -EFAULT;
> > +               if (unlikely(offset >=3D max_off))
> > +                       goto out_unlock;
> > +       }
> > +
> > +       ret =3D -EEXIST;
> > +       /*
> > +        * For now, we don't handle unmapping pages, so only support fi=
lling in
> > +        * none PTEs, or replacing PTE markers.
> > +        */
> > +       if (!pte_none_mostly(*dst_pte))
> > +               goto out_unlock;
> > +
> > +       set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > +
> > +       /* No need to invalidate - it was non-present before */
> > +       update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > +       ret =3D 0;
> > +out_unlock:
> > +       pte_unmap_unlock(dst_pte, ptl);
> > +       return ret;
> > +}
> > +
> >  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address=
)
> >  {
> >         pgd_t *pgd;
> > @@ -336,8 +381,12 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >          * supported by hugetlb.  A PMD_SIZE huge pages may exist as us=
ed
> >          * by THP.  Since we can not reliably insert a zero page, this
> >          * feature is not supported.
> > +        *
> > +        * PTE marker handling for hugetlb is a bit special, so for now
> > +        * UFFDIO_POISON is not supported.
> >          */
> > -       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > +       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
> > +           uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> >                 mmap_read_unlock(dst_mm);
> >                 return -EINVAL;
> >         }
> > @@ -481,6 +530,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd=
_t *dst_pmd,
> >         if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
> >                 return mfill_atomic_pte_continue(dst_pmd, dst_vma,
> >                                                  dst_addr, flags);
> > +       } else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> > +               return mfill_atomic_pte_poison(dst_pmd, dst_vma,
> > +                                              dst_addr, flags);
> >         }
> >
> >         /*
> > @@ -702,6 +754,14 @@ ssize_t mfill_atomic_continue(struct mm_struct *ds=
t_mm, unsigned long start,
> >                             uffd_flags_set_mode(flags, MFILL_ATOMIC_CON=
TINUE));
> >  }
> >
> > +ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long st=
art,
> > +                           unsigned long len, atomic_t *mmap_changing,
> > +                           uffd_flags_t flags)
> > +{
> > +       return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> > +                           uffd_flags_set_mode(flags, MFILL_ATOMIC_POI=
SON));
> > +}
> > +
> >  long uffd_wp_range(struct vm_area_struct *dst_vma,
> >                    unsigned long start, unsigned long len, bool enable_=
wp)
> >  {
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
