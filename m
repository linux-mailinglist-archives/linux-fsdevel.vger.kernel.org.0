Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD67488EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjGEQKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjGEQKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:10:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61D1700
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 09:09:56 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so553901cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688573395; x=1691165395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9eD1PyqMaLf5qiavjTSj3MRHpQLnFdP9rxejIP5Syk=;
        b=sdCo4yHCXw7BOvjN4U6tzU7aJ0KgQdQ0d4EZBo968zVitR4STXsJvsf+obc+5kujxs
         2fAvSyh/JR9KgnTaALSdCjMIF6Yfosky71lp7HCkUdvzs9S5Rg+eMq49jHy2q8ASOdcz
         wRuIXv2SEetL1oabbL3+oiKMQOeWxWcA2NEmrEaCQoCY6g/+rhxF6wld6b5AthvqLeBg
         SKkhV5J1vON8phSJM2vk/k+VHeO79eZ9oigdVU6EEhTNOMXlzJztci6I4eagRtgFFn/t
         H9/7MND2ySj1XGcQnNfS5Ibn9ZMiuKjYol8zvvUeZU3QjUAwpEavsg+hyAs5UaedSJmy
         lidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688573395; x=1691165395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9eD1PyqMaLf5qiavjTSj3MRHpQLnFdP9rxejIP5Syk=;
        b=grCt9NU+TwSA7HszVL3ErFkYN66pueRhTxLhEF3YCDBfi7L1HAVtBrQ61Ro6mSrmeD
         0BA79aQPR+JpF9qmFfb8+W3yHAQ1ppF9ha/F9D2zac2z9aWcjKrzU0iV9atstsfwtciA
         EseaY5+M1nhc5mdeDiBl7YYRfSaM7kTxfPT8aHmMJKqJLTsnJz6G9Z/5y6ivyASmVxN4
         VQyGr204JCLpKyI+mvuvbgunSVqdK0XFa3MCIxgZxK8xDO3u9yEO3QuJLQs32mBobF1U
         VKW8byVpEDrwHr2Y7xteGV+NxhYiwTBXvLH8VlX7F3Yu0GHXawgNI99MgKN23WpbI4I1
         FzHQ==
X-Gm-Message-State: ABy/qLZr0UDGZqrNLz8Vc89Lb31I3WrsKr5ONmDczc8S2h8L4vAtNNPu
        uilCmiZKN/A3nIxtigxad4r0IFVGqqiFzigDct4G5Q==
X-Google-Smtp-Source: APBJJlGehiO90js+BIISF6nmw+Sxe+6sqjNkNenWPWeRszBPqkwjb66GGYXPLEAY3HNszBcmWNoqxDlhD5hE1HQ+i28=
X-Received: by 2002:ac8:5fd3:0:b0:3f9:ab2c:88b9 with SMTP id
 k19-20020ac85fd3000000b003f9ab2c88b9mr110993qta.25.1688573395349; Wed, 05 Jul
 2023 09:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com> <ZKSDLogLASaZgKCP@x1n>
In-Reply-To: <ZKSDLogLASaZgKCP@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 5 Jul 2023 09:09:19 -0700
Message-ID: <CADrL8HXp-P44VxTXdJMkzSgPC8r_b0T21_cuPCTNy6Ub2PFBKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 4, 2023 at 1:38=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jun 29, 2023 at 01:50:35PM -0700, Axel Rasmussen wrote:
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
>
> Maybe have a cover letter for the next version?
>
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
> >       return ret;
> >  }
> >
> > +static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsi=
gned long arg)
> > +{
> > +     __s64 ret;
> > +     struct uffdio_poison uffdio_poison;
> > +     struct uffdio_poison __user *user_uffdio_poison;
> > +     struct userfaultfd_wake_range range;
> > +
> > +     user_uffdio_poison =3D (struct uffdio_poison __user *)arg;
> > +
> > +     ret =3D -EAGAIN;
> > +     if (atomic_read(&ctx->mmap_changing))
> > +             goto out;
> > +
> > +     ret =3D -EFAULT;
> > +     if (copy_from_user(&uffdio_poison, user_uffdio_poison,
> > +                        /* don't copy the output fields */
> > +                        sizeof(uffdio_poison) - (sizeof(__s64))))
> > +             goto out;
> > +
> > +     ret =3D validate_range(ctx->mm, uffdio_poison.range.start,
> > +                          uffdio_poison.range.len);
> > +     if (ret)
> > +             goto out;
> > +
> > +     ret =3D -EINVAL;
> > +     /* double check for wraparound just in case. */
> > +     if (uffdio_poison.range.start + uffdio_poison.range.len <=3D
> > +         uffdio_poison.range.start) {
>
> Brackets not needed here.
>
> > +             goto out;
> > +     }
> > +     if (uffdio_poison.mode & ~UFFDIO_POISON_MODE_DONTWAKE)
> > +             goto out;
> > +
> > +     if (mmget_not_zero(ctx->mm)) {
> > +             ret =3D mfill_atomic_poison(ctx->mm, uffdio_poison.range.=
start,
> > +                                       uffdio_poison.range.len,
> > +                                       &ctx->mmap_changing, 0);
> > +             mmput(ctx->mm);
> > +     } else {
> > +             return -ESRCH;
> > +     }
> > +
> > +     if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
> > +             return -EFAULT;
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     /* len =3D=3D 0 would wake all */
> > +     BUG_ON(!ret);
> > +     range.len =3D ret;
> > +     if (!(uffdio_poison.mode & UFFDIO_POISON_MODE_DONTWAKE)) {
> > +             range.start =3D uffdio_poison.range.start;
> > +             wake_userfault(ctx, &range);
> > +     }
> > +     ret =3D range.len =3D=3D uffdio_poison.range.len ? 0 : -EAGAIN;
> > +
> > +out:
> > +     return ret;
> > +}
> > +
> >  static inline unsigned int uffd_ctx_features(__u64 user_features)
> >  {
> >       /*
> > @@ -2066,6 +2126,9 @@ static long userfaultfd_ioctl(struct file *file, =
unsigned cmd,
> >       case UFFDIO_CONTINUE:
> >               ret =3D userfaultfd_continue(ctx, arg);
> >               break;
> > +     case UFFDIO_POISON:
> > +             ret =3D userfaultfd_poison(ctx, arg);
> > +             break;
> >       }
> >       return ret;
> >  }
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index 4c932cb45e0b..8259fee32421 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
> >
> >  #define  PTE_MARKER_UFFD_WP                  BIT(0)
> >  #define  PTE_MARKER_SWAPIN_ERROR             BIT(1)
> > -#define  PTE_MARKER_MASK                     (BIT(2) - 1)
> > +#define  PTE_MARKER_UFFD_POISON                      BIT(2)
>
> One more tab.
>
> Though I remembered the last time we discussed IIRC we plan to rename
> SWAPIN_ERROR and reuse it, could you explain why a new bit is still neede=
d?
>
> I think I commented this but I'll do it again: IIUC any existing host
> swapin errors for guest pages should be reported as MCE too, afaict,
> happened in kvm context.

I think swapin errors are treated differently than poison. Swapin
errors get VM_FAULT_SIGBUS, and poison gets VM_FAULT_HWPOISON, so
UFFDIO_POISON should also get VM_FAULT_HWPOISON (so that's what Axel
has implemented). And I think that needs a separate PTE marker.

>
> > +#define  PTE_MARKER_MASK                     (BIT(3) - 1)
> >
> >  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> >  {
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_=
k.h
> > index ac7b0c96d351..ac8c6854097c 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -46,6 +46,7 @@ enum mfill_atomic_mode {
> >       MFILL_ATOMIC_COPY,
> >       MFILL_ATOMIC_ZEROPAGE,
> >       MFILL_ATOMIC_CONTINUE,
> > +     MFILL_ATOMIC_POISON,
> >       NR_MFILL_ATOMIC_MODES,
> >  };
> >
> > @@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct=
 *dst_mm,
> >  extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigne=
d long dst_start,
> >                                    unsigned long len, atomic_t *mmap_ch=
anging,
> >                                    uffd_flags_t flags);
> > +extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned =
long start,
> > +                                unsigned long len, atomic_t *mmap_chan=
ging,
> > +                                uffd_flags_t flags);
> >  extern int mwriteprotect_range(struct mm_struct *dst_mm,
> >                              unsigned long start, unsigned long len,
> >                              bool enable_wp, atomic_t *mmap_changing);
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/user=
faultfd.h
> > index 66dd4cd277bd..62151706c5a3 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -39,7 +39,8 @@
> >                          UFFD_FEATURE_MINOR_SHMEM |           \
> >                          UFFD_FEATURE_EXACT_ADDRESS |         \
> >                          UFFD_FEATURE_WP_HUGETLBFS_SHMEM |    \
> > -                        UFFD_FEATURE_WP_UNPOPULATED)
> > +                        UFFD_FEATURE_WP_UNPOPULATED |        \
> > +                        UFFD_FEATURE_POISON)
> >  #define UFFD_API_IOCTLS                              \
> >       ((__u64)1 << _UFFDIO_REGISTER |         \
> >        (__u64)1 << _UFFDIO_UNREGISTER |       \
> > @@ -49,12 +50,14 @@
> >        (__u64)1 << _UFFDIO_COPY |             \
> >        (__u64)1 << _UFFDIO_ZEROPAGE |         \
> >        (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> > -      (__u64)1 << _UFFDIO_CONTINUE)
> > +      (__u64)1 << _UFFDIO_CONTINUE |         \
> > +      (__u64)1 << _UFFDIO_POISON)
> >  #define UFFD_API_RANGE_IOCTLS_BASIC          \
> >       ((__u64)1 << _UFFDIO_WAKE |             \
> >        (__u64)1 << _UFFDIO_COPY |             \
> > +      (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> >        (__u64)1 << _UFFDIO_CONTINUE |         \
> > -      (__u64)1 << _UFFDIO_WRITEPROTECT)
> > +      (__u64)1 << _UFFDIO_POISON)
>
> May not be a large deal, but it's still better to declare the feature &
> ioctls after all things implemented.  Maybe make these few lines
> (UFFD_API*, and the new feature bit) as the last patch to enable the
> feature?

I agree. Another option would be to have a separate feature for
UFFDIO_POISON for hugetlb, but I don't think we should do that. :)

>
> >
> >  /*
> >   * Valid ioctl command number range with this API is from 0x00 to
> > @@ -71,6 +74,7 @@
> >  #define _UFFDIO_ZEROPAGE             (0x04)
> >  #define _UFFDIO_WRITEPROTECT         (0x06)
> >  #define _UFFDIO_CONTINUE             (0x07)
> > +#define _UFFDIO_POISON                       (0x08)
> >  #define _UFFDIO_API                  (0x3F)
> >
> >  /* userfaultfd ioctl ids */
> > @@ -91,6 +95,8 @@
> >                                     struct uffdio_writeprotect)
> >  #define UFFDIO_CONTINUE              _IOWR(UFFDIO, _UFFDIO_CONTINUE, \
> >                                     struct uffdio_continue)
> > +#define UFFDIO_POISON                _IOWR(UFFDIO, _UFFDIO_POISON, \
> > +                                   struct uffdio_poison)
> >
> >  /* read() structure */
> >  struct uffd_msg {
> > @@ -225,6 +231,7 @@ struct uffdio_api {
> >  #define UFFD_FEATURE_EXACT_ADDRESS           (1<<11)
> >  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM              (1<<12)
> >  #define UFFD_FEATURE_WP_UNPOPULATED          (1<<13)
> > +#define UFFD_FEATURE_POISON                  (1<<14)
> >       __u64 features;
> >
> >       __u64 ioctls;
> > @@ -321,6 +328,18 @@ struct uffdio_continue {
> >       __s64 mapped;
> >  };
> >
> > +struct uffdio_poison {
> > +     struct uffdio_range range;
> > +#define UFFDIO_POISON_MODE_DONTWAKE          ((__u64)1<<0)
> > +     __u64 mode;
> > +
> > +     /*
> > +      * Fields below here are written by the ioctl and must be at the =
end:
> > +      * the copy_from_user will not read past here.
> > +      */
> > +     __s64 updated;
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
> >       if (WARN_ON_ONCE(!marker))
> >               return VM_FAULT_SIGBUS;
> >
> > +     /* Poison emulation explicitly requested for this PTE. */
> > +     if (marker & PTE_MARKER_UFFD_POISON)
> > +             return VM_FAULT_HWPOISON;
> > +
> >       /* Higher priority than uffd-wp when data corrupted */
> >       if (marker & PTE_MARKER_SWAPIN_ERROR)
> >               return VM_FAULT_SIGBUS;
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index a2bf37ee276d..87b62ca1e09e 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -286,6 +286,51 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pm=
d,
> >       goto out;
> >  }
> >
> > +/* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
> > +static int mfill_atomic_pte_poison(pmd_t *dst_pmd,
> > +                                struct vm_area_struct *dst_vma,
> > +                                unsigned long dst_addr,
> > +                                uffd_flags_t flags)
> > +{
> > +     int ret;
> > +     struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > +     pte_t _dst_pte, *dst_pte;
> > +     spinlock_t *ptl;
> > +
> > +     _dst_pte =3D make_pte_marker(PTE_MARKER_UFFD_POISON);
> > +     dst_pte =3D pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > +
> > +     if (vma_is_shmem(dst_vma)) {
> > +             struct inode *inode;
> > +             pgoff_t offset, max_off;
> > +
> > +             /* serialize against truncate with the page table lock */
> > +             inode =3D dst_vma->vm_file->f_inode;
> > +             offset =3D linear_page_index(dst_vma, dst_addr);
> > +             max_off =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > +             ret =3D -EFAULT;
> > +             if (unlikely(offset >=3D max_off))
> > +                     goto out_unlock;
> > +     }
>
> Maybe good chance to have a mfill_file_over_size() helper?  Other potenti=
al
> users are mfill_atomic_pte_zeropage() and mfill_atomic_install_pte().
>
> > +
> > +     ret =3D -EEXIST;
> > +     /*
> > +      * For now, we don't handle unmapping pages, so only support fill=
ing in
> > +      * none PTEs, or replacing PTE markers.
> > +      */
> > +     if (!pte_none_mostly(*dst_pte))
> > +             goto out_unlock;
> > +
> > +     set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > +
> > +     /* No need to invalidate - it was non-present before */
> > +     update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > +     ret =3D 0;
> > +out_unlock:
> > +     pte_unmap_unlock(dst_pte, ptl);
> > +     return ret;
> > +}
> > +
> >  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address=
)
> >  {
> >       pgd_t *pgd;
> > @@ -336,8 +381,12 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >        * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
> >        * by THP.  Since we can not reliably insert a zero page, this
> >        * feature is not supported.
> > +      *
> > +      * PTE marker handling for hugetlb is a bit special, so for now
> > +      * UFFDIO_POISON is not supported.
> >        */
> > -     if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > +     if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
> > +         uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> >               mmap_read_unlock(dst_mm);
> >               return -EINVAL;
> >       }
> > @@ -481,6 +530,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd=
_t *dst_pmd,
> >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
> >               return mfill_atomic_pte_continue(dst_pmd, dst_vma,
> >                                                dst_addr, flags);
> > +     } else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> > +             return mfill_atomic_pte_poison(dst_pmd, dst_vma,
> > +                                            dst_addr, flags);
> >       }
> >
> >       /*
> > @@ -702,6 +754,14 @@ ssize_t mfill_atomic_continue(struct mm_struct *ds=
t_mm, unsigned long start,
> >                           uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTI=
NUE));
> >  }
> >
> > +ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long st=
art,
> > +                         unsigned long len, atomic_t *mmap_changing,
> > +                         uffd_flags_t flags)
> > +{
> > +     return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> > +                         uffd_flags_set_mode(flags, MFILL_ATOMIC_POISO=
N));
> > +}
> > +
> >  long uffd_wp_range(struct vm_area_struct *dst_vma,
> >                  unsigned long start, unsigned long len, bool enable_wp=
)
> >  {
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
>
> --
> Peter Xu
>
