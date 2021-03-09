Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59D332F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 20:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCIT6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 14:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhCIT6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:58:03 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9211C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Mar 2021 11:58:03 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v14so13299618ilj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Mar 2021 11:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E3EULr6DvczRPFIruCZafwpzbVJHUineMzXORqlcchQ=;
        b=AmitSmdh/V2mw5Yx89HuI1Zq+N3q8QBASWKZCt0sbt3F5/6nVjBACQwMNjgBQym3Hf
         0B7dtbRdzAUR1hIDa7+DzHiCD3NV0/FPbPkLK4d1QLy8sBtfB9I88MZSKrVsDnU8fpoG
         5/FTWeqEB6uQp8dQanKUK5V452UeMcZRUDRSEgSg9bkQSaXcbub8grk58rsQ94TKtv5M
         fU1m99DEzED3Cq7im8oRtui5aN4cxAE21qZc8T8+nfu++Xu7WZCQpsmoz0tI3fEPoZgQ
         ekjBxXOtnnZwKk1bXqkLfpyLADqoy1BLnZEOGTZkpV+eTwR9kDCaDwGNvraPZlClZbcu
         7AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E3EULr6DvczRPFIruCZafwpzbVJHUineMzXORqlcchQ=;
        b=U1OU8eG3PBTy6BJ0FYMf3cy9QCldQDnMcOZoAPpOLwUYY9qnoVXCpn7Mk/gDoDHnMv
         PKeU5tn/G5jVXQdxZoeSHDQ093vizHE5ubRB6MurfwLKDaIjUBS0Em9hs2RJQMotRJSs
         EVK/m5VLamsF62cQIPzw5le+u/higym5aZX8ixyEENzYBOUIBjj8A6XL0eWUBc3QfLZH
         pgPPdHPDuRCb18BgzPV7W0CVkbzHWL+8bS1h7LV/i3FbG1BV0Bj+A5dFbk4r/LAisBHj
         s8WKcBJoPjtkyrmyTWUKHfvZn1OjVcDKBwWW1ioar2uU/tAnWe17gjyD8HU/QVXRv9S1
         hGQQ==
X-Gm-Message-State: AOAM530bTgvxirJX7kGBMSh+3iXaSbs/tFpv3VKAZNQpkAhuTAOqrZkU
        VYj26PH/C2jivE7UfEwQlxFVUmdbgS7GPdXxKj66Dg==
X-Google-Smtp-Source: ABdhPJxj7kBpd2DRoLvs8wrf2H+fISF4BDTMGksQYSZt+kpke54saNcwvy57UiJ0RI97BbmSKtvnnbDMHoyUqSk6Njk=
X-Received: by 2002:a05:6e02:194a:: with SMTP id x10mr26158846ilu.165.1615319882972;
 Tue, 09 Mar 2021 11:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20210302000133.272579-1-axelrasmussen@google.com>
 <20210302000133.272579-2-axelrasmussen@google.com> <04697A35-AEC7-43F1-8462-1CD39648544A@nvidia.com>
In-Reply-To: <04697A35-AEC7-43F1-8462-1CD39648544A@nvidia.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 9 Mar 2021 11:57:26 -0800
Message-ID: <CAJHvVcjjX8FEsdngUTH+0c3C17T0ud-FXj=GJf90R8hn8PKekA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] userfaultfd: support minor fault handling for shmem
To:     Zi Yan <ziy@nvidia.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 9, 2021 at 11:52 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 1 Mar 2021, at 19:01, Axel Rasmussen wrote:
>
> > Modify the userfaultfd register API to allow registering shmem VMAs in
> > minor mode. Modify the shmem mcopy implementation to support
> > UFFDIO_CONTINUE in order to resolve such faults.
> >
> > Combine the shmem mcopy handler functions into a single
> > shmem_mcopy_atomic_pte, which takes a mode parameter. This matches how
> > the hugetlbfs implementation is structured, and lets us remove a good
> > chunk of boilerplate.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c                 |  6 +--
> >  include/linux/shmem_fs.h         | 26 ++++-----
> >  include/uapi/linux/userfaultfd.h |  4 +-
> >  mm/memory.c                      |  8 +--
> >  mm/shmem.c                       | 92 +++++++++++++++-----------------
> >  mm/userfaultfd.c                 | 27 +++++-----
> >  6 files changed, 79 insertions(+), 84 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 14f92285d04f..9f3b8684cf3c 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_ar=
ea_struct *vma,
> >       }
> >
> >       if (vm_flags & VM_UFFD_MINOR) {
> > -             /* FIXME: Add minor fault interception for shmem. */
> > -             if (!is_vm_hugetlb_page(vma))
> > +             if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
> >                       return false;
> >       }
> >
> > @@ -1941,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx=
 *ctx,
> >       /* report all available features and ioctls to userland */
> >       uffdio_api.features =3D UFFD_API_FEATURES;
> >  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> > -     uffdio_api.features &=3D ~UFFD_FEATURE_MINOR_HUGETLBFS;
> > +     uffdio_api.features &=3D
> > +             ~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM=
);
> >  #endif
> >       uffdio_api.ioctls =3D UFFD_API_IOCTLS;
> >       ret =3D -EFAULT;
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index d82b6f396588..f0919c3722e7 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/percpu_counter.h>
> >  #include <linux/xattr.h>
> >  #include <linux/fs_parser.h>
> > +#include <linux/userfaultfd_k.h>
> >
> >  /* inode in-kernel data */
> >
> > @@ -122,21 +123,16 @@ static inline bool shmem_file(struct file *file)
> >  extern bool shmem_charge(struct inode *inode, long pages);
> >  extern void shmem_uncharge(struct inode *inode, long pages);
> >
> > +#ifdef CONFIG_USERFAULTFD
> >  #ifdef CONFIG_SHMEM
> > -extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst=
_pmd,
> > -                               struct vm_area_struct *dst_vma,
> > -                               unsigned long dst_addr,
> > -                               unsigned long src_addr,
> > -                               struct page **pagep);
> > -extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> > -                                 pmd_t *dst_pmd,
> > -                                 struct vm_area_struct *dst_vma,
> > -                                 unsigned long dst_addr);
> > -#else
> > -#define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
> > -                            src_addr, pagep)        ({ BUG(); 0; })
> > -#define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
> > -                              dst_addr)      ({ BUG(); 0; })
> > -#endif
> > +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +                        struct vm_area_struct *dst_vma,
> > +                        unsigned long dst_addr, unsigned long src_addr=
,
> > +                        enum mcopy_atomic_mode mode, struct page **pag=
ep);
> > +#else /* !CONFIG_SHMEM */
> > +#define shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
> > +                            src_addr, mode, pagep)        ({ BUG(); 0;=
 })
> > +#endif /* CONFIG_SHMEM */
> > +#endif /* CONFIG_USERFAULTFD */
> >
> >  #endif
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/user=
faultfd.h
> > index bafbeb1a2624..47d9790d863d 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -31,7 +31,8 @@
> >                          UFFD_FEATURE_MISSING_SHMEM |         \
> >                          UFFD_FEATURE_SIGBUS |                \
> >                          UFFD_FEATURE_THREAD_ID |             \
> > -                        UFFD_FEATURE_MINOR_HUGETLBFS)
> > +                        UFFD_FEATURE_MINOR_HUGETLBFS |       \
> > +                        UFFD_FEATURE_MINOR_SHMEM)
> >  #define UFFD_API_IOCTLS                              \
> >       ((__u64)1 << _UFFDIO_REGISTER |         \
> >        (__u64)1 << _UFFDIO_UNREGISTER |       \
> > @@ -196,6 +197,7 @@ struct uffdio_api {
> >  #define UFFD_FEATURE_SIGBUS                  (1<<7)
> >  #define UFFD_FEATURE_THREAD_ID                       (1<<8)
> >  #define UFFD_FEATURE_MINOR_HUGETLBFS         (1<<9)
> > +#define UFFD_FEATURE_MINOR_SHMEM             (1<<10)
> >       __u64 features;
> >
> >       __u64 ioctls;
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c8e357627318..a1e5ff55027e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3929,9 +3929,11 @@ static vm_fault_t do_read_fault(struct vm_fault =
*vmf)
> >        * something).
> >        */
> >       if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > =
1) {
> > -             ret =3D do_fault_around(vmf);
> > -             if (ret)
> > -                     return ret;
> > +             if (likely(!userfaultfd_minor(vmf->vma))) {
> > +                     ret =3D do_fault_around(vmf);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> >       }
> >
> >       ret =3D __do_fault(vmf);
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b2db4ed0fbc7..6f81259fabb3 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -77,7 +77,6 @@ static struct vfsmount *shm_mnt;
> >  #include <linux/syscalls.h>
> >  #include <linux/fcntl.h>
> >  #include <uapi/linux/memfd.h>
> > -#include <linux/userfaultfd_k.h>
> >  #include <linux/rmap.h>
> >  #include <linux/uuid.h>
> >
> > @@ -1785,8 +1784,8 @@ static int shmem_swapin_page(struct inode *inode,=
 pgoff_t index,
> >   * vm. If we swap it in we mark it dirty since we also free the swap
> >   * entry since a page cannot live in both the swap and page cache.
> >   *
> > - * vmf and fault_type are only supplied by shmem_fault:
> > - * otherwise they are NULL.
> > + * vma, vmf, and fault_type are only supplied by shmem_fault: otherwis=
e they
> > + * are NULL.
> >   */
> >  static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >       struct page **pagep, enum sgp_type sgp, gfp_t gfp,
> > @@ -1830,6 +1829,12 @@ static int shmem_getpage_gfp(struct inode *inode=
, pgoff_t index,
> >               return error;
> >       }
> >
> > +     if (page && vma && userfaultfd_minor(vma)) {
> > +             unlock_page(page);
> > +             *fault_type =3D handle_userfault(vmf, VM_UFFD_MINOR);
> > +             return 0;
> > +     }
> > +
> >       if (page)
> >               hindex =3D page->index;
> >       if (page && sgp =3D=3D SGP_WRITE)
> > @@ -2354,14 +2359,12 @@ static struct inode *shmem_get_inode(struct sup=
er_block *sb, const struct inode
> >       return inode;
> >  }
> >
> > -static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> > -                               pmd_t *dst_pmd,
> > -                               struct vm_area_struct *dst_vma,
> > -                               unsigned long dst_addr,
> > -                               unsigned long src_addr,
> > -                               bool zeropage,
> > -                               struct page **pagep)
> > +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +                        struct vm_area_struct *dst_vma,
> > +                        unsigned long dst_addr, unsigned long src_addr=
,
> > +                        enum mcopy_atomic_mode mode, struct page **pag=
ep)
> >  {
> > +     bool is_continue =3D (mode =3D=3D MCOPY_ATOMIC_CONTINUE);
> >       struct inode *inode =3D file_inode(dst_vma->vm_file);
> >       struct shmem_inode_info *info =3D SHMEM_I(inode);
> >       struct address_space *mapping =3D inode->i_mapping;
> > @@ -2378,12 +2381,17 @@ static int shmem_mfill_atomic_pte(struct mm_str=
uct *dst_mm,
> >       if (!shmem_inode_acct_block(inode, 1))
> >               goto out;
> >
> > -     if (!*pagep) {
> > +     if (is_continue) {
> > +             ret =3D -EFAULT;
> > +             page =3D find_lock_page(mapping, pgoff);
> > +             if (!page)
> > +                     goto out_unacct_blocks;
> > +     } else if (!*pagep) {
> >               page =3D shmem_alloc_page(gfp, info, pgoff);
> >               if (!page)
> >                       goto out_unacct_blocks;
> >
> > -             if (!zeropage) {        /* mcopy_atomic */
> > +             if (mode =3D=3D MCOPY_ATOMIC_NORMAL) {      /* mcopy_atom=
ic */
> >                       page_kaddr =3D kmap_atomic(page);
> >                       ret =3D copy_from_user(page_kaddr,
> >                                            (const void __user *)src_add=
r,
>
> Hi Axel,
>
> shmem_mcopy_atomic_pte is not guarded by CONFIG_USERFAULTFD, thus it is
> causing compilation errors due to the use of enum mcopy_atomic_mode mode,
> when CONFIG_USERFAULTFD is not set.

Ah, my apologies, I guarded it in the header but forgot to do so in
shmem.c. I'll send an updated patch today.

>
>
> =E2=80=94
> Best Regards,
> Yan Zi
