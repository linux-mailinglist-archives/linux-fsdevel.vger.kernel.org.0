Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111AD7B0AE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjI0RMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 13:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjI0RMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:12:44 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99CF3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 10:12:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d8198ca891fso13018853276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695834760; x=1696439560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvUAki+h0o6OBk2tbEzSZshv+nhr9s6eBcOiPnVYGzk=;
        b=bo83+kMzqIaSqihKOY4THVhrNC+iZpK90381706S55xSwbHw45FFUIn51Wg3gbAxOQ
         bzda+pqtxGakqjMvlqThV8Ufa9Qsz/xUzh6rMPlC+u6ebjQkuIyluMUKBS0Sd6Z5ChpL
         +Mmw5Z/wXHuqSYLbXyvYIisoyjR2LXskMKvJzAN2eb5uio9irDRPBhpNxYaHO6Vo9IqR
         DodNUULil17yAxBD/lTFdStEtsBeks1QP5B+nPNGriB6ijar3jLq8EGjx+jTh52Z/aw6
         2iily+uK63CiZDebzivojKmd125Q5n4rAe3csnuTEAdCcEgwsw6EYtzujuiDDbGWLocw
         b/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834760; x=1696439560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvUAki+h0o6OBk2tbEzSZshv+nhr9s6eBcOiPnVYGzk=;
        b=o+Kz2lLuSy3EIX2dicyhT3BzvF1rdRFcRC82YB5O316p8zpTt7lG6g2NkwJtI9Gsu8
         CusuEjC+lz21dDsFTmsQ557JW0nWSXFjSy7dny2KKwiXjAyAWiUKUmBfaFSLZy6+c3RX
         tWeDENkEjMHDv7i8alWrD5F3aGTG0fX4IIHE1nmSmiO5++6KlQJKnXFZE5Goooehwva4
         Kz8ESCR2uWR2WelRYxHm3F9+VorIPAjBoAJpE4n6i8bs78OOu1wsou+wLZY8/DE11/zp
         Nzyjjb9GTVZ08slfin8vVWO9ZlfBVZ233nqMmSqLJJf/bjEOUHG0VhIVITRlnY537nmi
         EBBQ==
X-Gm-Message-State: AOJu0YzWNNdxn5gIC0UxSMU/EyA6ZPuTfGfyHFynSAcc0XP0078QTAbx
        09jOTj+KdhG1rUcZEDLlMiEXNqM0YFrJbQmK+Wd+xA==
X-Google-Smtp-Source: AGHT+IGusg+pz3SyKBvFMux72qCFiV8POf7w4/mSCv+hhQ1tzbJGLxBY6WVWDQ1aP4eo9wuYiU9oJLvakvRs8U6BLB8=
X-Received: by 2002:a25:cacd:0:b0:d81:c10d:7e1a with SMTP id
 a196-20020a25cacd000000b00d81c10d7e1amr2776442ybg.58.1695834760324; Wed, 27
 Sep 2023 10:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez11FdESrYYDLmtZEgZ7osDi-QDYpk+Z0p=qjpCks++7rg@mail.gmail.com>
In-Reply-To: <CAG48ez11FdESrYYDLmtZEgZ7osDi-QDYpk+Z0p=qjpCks++7rg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Sep 2023 10:12:28 -0700
Message-ID: <CAJuCfpG1sjJdEoxtYFk9-r_5kutss_C3breJVFz99efsKKXzqg@mail.gmail.com>
Subject: Re: potential new userfaultfd vs khugepaged conflict [was: Re: [PATCH
 v2 2/3] userfaultfd: UFFDIO_REMAP uABI]
To:     Jann Horn <jannh@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        Brian Geffon <bgeffon@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 3:07=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> [moving Hugh into "To:" recipients as FYI for khugepaged interaction]
>
> On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > This implements the uABI of UFFDIO_REMAP.
> >
> > Notably one mode bitflag is also forwarded (and in turn known) by the
> > lowlevel remap_pages method.
> >
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> [...]
> > +/*
> > + * The mmap_lock for reading is held by the caller. Just move the page
> > + * from src_pmd to dst_pmd if possible, and return true if succeeded
> > + * in moving the page.
> > + */
> > +static int remap_pages_pte(struct mm_struct *dst_mm,
> > +                          struct mm_struct *src_mm,
> > +                          pmd_t *dst_pmd,
> > +                          pmd_t *src_pmd,
> > +                          struct vm_area_struct *dst_vma,
> > +                          struct vm_area_struct *src_vma,
> > +                          unsigned long dst_addr,
> > +                          unsigned long src_addr,
> > +                          __u64 mode)
> > +{
> > +       swp_entry_t entry;
> > +       pte_t orig_src_pte, orig_dst_pte;
> > +       spinlock_t *src_ptl, *dst_ptl;
> > +       pte_t *src_pte =3D NULL;
> > +       pte_t *dst_pte =3D NULL;
> > +
> > +       struct folio *src_folio =3D NULL;
> > +       struct anon_vma *src_anon_vma =3D NULL;
> > +       struct mmu_notifier_range range;
> > +       int err =3D 0;
> > +
> > +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm,
> > +                               src_addr, src_addr + PAGE_SIZE);
> > +       mmu_notifier_invalidate_range_start(&range);
> > +retry:
> > +       dst_pte =3D pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &d=
st_ptl);
> > +
> > +       /* If an huge pmd materialized from under us fail */
> > +       if (unlikely(!dst_pte)) {
> > +               err =3D -EFAULT;
> > +               goto out;
> > +       }
> > +
> > +       src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, src_addr, &s=
rc_ptl);
> > +
> > +       /*
> > +        * We held the mmap_lock for reading so MADV_DONTNEED
> > +        * can zap transparent huge pages under us, or the
> > +        * transparent huge page fault can establish new
> > +        * transparent huge pages under us.
> > +        */
> > +       if (unlikely(!src_pte)) {
> > +               err =3D -EFAULT;
> > +               goto out;
> > +       }
> > +
> > +       BUG_ON(pmd_none(*dst_pmd));
> > +       BUG_ON(pmd_none(*src_pmd));
> > +       BUG_ON(pmd_trans_huge(*dst_pmd));
> > +       BUG_ON(pmd_trans_huge(*src_pmd));
>
> This works for now, but note that Hugh Dickins has recently been
> reworking khugepaged such that PTE-based mappings can be collapsed
> into transhuge mappings under the mmap lock held in *read mode*;
> holders of the mmap lock in read mode can only synchronize against
> this by taking the right page table spinlock and rechecking the pmd
> value. This is only the case for file-based mappings so far, not for
> anonymous private VMAs; and this code only operates on anonymous
> private VMAs so far, so it works out.
>
> But if either Hugh further reworks khugepaged such that anonymous VMAs
> can be collapsed under the mmap lock in read mode, or you expand this
> code to work on file-backed VMAs, then it will become possible to hit
> these BUG_ON() calls. I'm not sure what the plans for khugepaged going
> forward are, but the number of edgecases everyone has to keep in mind
> would go down if you changed this function to deal gracefully with
> page tables disappearing under you.
>
> In the newest version of mm/pgtable-generic.c, above
> __pte_offset_map_lock(), there is a big comment block explaining the
> current rules for page table access; in particular, regarding the
> helper pte_offset_map_nolock() that you're using:
>
>  * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_=
map();
>  * but when successful, it also outputs a pointer to the spinlock in ptlp=
 - as
>  * pte_offset_map_lock() does, but in this case without locking it.  This=
 helps
>  * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that=
 time
>  * act on a changed *pmd: pte_offset_map_nolock() provides the correct sp=
inlock
>  * pointer for the page table that it returns.  In principle, the caller =
should
>  * recheck *pmd once the lock is taken; in practice, no callsite needs th=
at -
>  * either the mmap_lock for write, or pte_same() check on contents, is en=
ough.
>
> If this becomes hittable in the future, I think you will need to
> recheck *pmd, at least for dst_pte, to avoid copying PTEs into a
> detached page table.

Thanks for the warning, Jann. It sounds to me it would be better to
add this pmd check now even though it's not hittable. Does that sound
good to everyone?

>
> > +       spin_lock(dst_ptl);
> > +       orig_dst_pte =3D *dst_pte;
> > +       spin_unlock(dst_ptl);
> > +       if (!pte_none(orig_dst_pte)) {
> > +               err =3D -EEXIST;
> > +               goto out;
> > +       }
> > +
> > +       spin_lock(src_ptl);
> > +       orig_src_pte =3D *src_pte;
> > +       spin_unlock(src_ptl);
> > +       if (pte_none(orig_src_pte)) {
> > +               if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES))
> > +                       err =3D -ENOENT;
> > +               else /* nothing to do to remap a hole */
> > +                       err =3D 0;
> > +               goto out;
> > +       }
> > +
> > +       if (pte_present(orig_src_pte)) {
> > +               /*
> > +                * Pin and lock both source folio and anon_vma. Since w=
e are in
> > +                * RCU read section, we can't block, so on contention h=
ave to
> > +                * unmap the ptes, obtain the lock and retry.
> > +                */
> > +               if (!src_folio) {
> > +                       struct folio *folio;
> > +
> > +                       /*
> > +                        * Pin the page while holding the lock to be su=
re the
> > +                        * page isn't freed under us
> > +                        */
> > +                       spin_lock(src_ptl);
> > +                       if (!pte_same(orig_src_pte, *src_pte)) {
> > +                               spin_unlock(src_ptl);
> > +                               err =3D -EAGAIN;
> > +                               goto out;
> > +                       }
> > +
> > +                       folio =3D vm_normal_folio(src_vma, src_addr, or=
ig_src_pte);
> > +                       if (!folio || !folio_test_anon(folio) ||
> > +                           folio_test_large(folio) ||
> > +                           folio_estimated_sharers(folio) !=3D 1) {
> > +                               spin_unlock(src_ptl);
> > +                               err =3D -EBUSY;
> > +                               goto out;
> > +                       }
> > +
> > +                       folio_get(folio);
> > +                       src_folio =3D folio;
> > +                       spin_unlock(src_ptl);
> > +
> > +                       /* block all concurrent rmap walks */
> > +                       if (!folio_trylock(src_folio)) {
> > +                               pte_unmap(&orig_src_pte);
> > +                               pte_unmap(&orig_dst_pte);
> > +                               src_pte =3D dst_pte =3D NULL;
> > +                               /* now we can block and wait */
> > +                               folio_lock(src_folio);
> > +                               goto retry;
> > +                       }
> > +               }
> > +
> > +               if (!src_anon_vma) {
> > +                       /*
> > +                        * folio_referenced walks the anon_vma chain
> > +                        * without the folio lock. Serialize against it=
 with
> > +                        * the anon_vma lock, the folio lock is not eno=
ugh.
> > +                        */
> > +                       src_anon_vma =3D folio_get_anon_vma(src_folio);
> > +                       if (!src_anon_vma) {
> > +                               /* page was unmapped from under us */
> > +                               err =3D -EAGAIN;
> > +                               goto out;
> > +                       }
> > +                       if (!anon_vma_trylock_write(src_anon_vma)) {
> > +                               pte_unmap(&orig_src_pte);
> > +                               pte_unmap(&orig_dst_pte);
> > +                               src_pte =3D dst_pte =3D NULL;
> > +                               /* now we can block and wait */
> > +                               anon_vma_lock_write(src_anon_vma);
> > +                               goto retry;
> > +                       }
> > +               }
> > +
> > +               err =3D remap_anon_pte(dst_mm, src_mm,  dst_vma, src_vm=
a,
> > +                                    dst_addr, src_addr, dst_pte, src_p=
te,
> > +                                    orig_dst_pte, orig_src_pte,
> > +                                    dst_ptl, src_ptl, src_folio);
> > +       } else {
> > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > +               if (non_swap_entry(entry)) {
> > +                       if (is_migration_entry(entry)) {
> > +                               pte_unmap(&orig_src_pte);
> > +                               pte_unmap(&orig_dst_pte);
> > +                               src_pte =3D dst_pte =3D NULL;
> > +                               migration_entry_wait(src_mm, src_pmd,
> > +                                                    src_addr);
> > +                               err =3D -EAGAIN;
> > +                       } else
> > +                               err =3D -EFAULT;
> > +                       goto out;
> > +               }
> > +
> > +               err =3D remap_swap_pte(dst_mm, src_mm, dst_addr, src_ad=
dr,
> > +                                    dst_pte, src_pte,
> > +                                    orig_dst_pte, orig_src_pte,
> > +                                    dst_ptl, src_ptl);
> > +       }
> > +
> > +out:
> > +       if (src_anon_vma) {
> > +               anon_vma_unlock_write(src_anon_vma);
> > +               put_anon_vma(src_anon_vma);
> > +       }
> > +       if (src_folio) {
> > +               folio_unlock(src_folio);
> > +               folio_put(src_folio);
> > +       }
> > +       if (dst_pte)
> > +               pte_unmap(dst_pte);
> > +       if (src_pte)
> > +               pte_unmap(src_pte);
> > +       mmu_notifier_invalidate_range_end(&range);
> > +
> > +       return err;
> > +}
