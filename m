Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B397B0149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 12:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjI0KHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjI0KHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:07:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F51410E
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 03:07:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c6193d6bb4so286625ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695809228; x=1696414028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1sms3m0q6TLkv39Fz9Q4qmOvbekvnpwGel5K6RYBQc=;
        b=at8uisa0YQ0hvncF516eoG4P5ngKKrkwrkwZ4a2vQXMKdJaAQEWvSHmFo/l1URlrPx
         hgQXkAuy1ytPQyGQ+9KJcfbxfcviRrQZJ83HOgfxvVTFtlHpzsHGjJFFntcjDCCeBT8W
         UzIRoQLmdhz80kOOBFsBzFQAcbryCo2bU0Fjt2E5Ql3lUYFhc4/j8OvDfk2MEduDn2r4
         HW0BGf1JPXF9XN+MKPfWdkYGmC1C4+7pSgauDfN13fn/PUJe51fLKPQISHVsXlaXk/Ft
         BX3sjsRrq9AGD4JZpJiAMPH4TJCqrglQ+Z4M8PJik8jCbroTMZOVswWZqR55qUlv+4V0
         wK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695809228; x=1696414028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1sms3m0q6TLkv39Fz9Q4qmOvbekvnpwGel5K6RYBQc=;
        b=lCwWtoEWzbNLx3R/JQOdnd0SwXCpcNXVTSAduEvIfqMy3t/9qfTGSdDCzaR9HXjO7E
         DSyu/ExyMQKbBHmjkTr2jk0h28SikPH8owmUJD/GWVpBZrQjbj/1zfU5BCQ8V7tFIWO3
         HxipoJtDTmiCWxVMsXV8kxaty4SSxVA2F6aLwbVuisQoDWcuDYCLD5kj5kfoT6DGiwaw
         EyjL09XmorceQTe1ajMGdD2RoU3WBX1m0VewJ+bJ3SmNagW03Ff9CwZcqKPMVp7Ctq3E
         19U+g0y7PWN6g0FsCLaWUBYAMcZz5tmGWY210IxQVkrIKOx5dHi3F1w9gs0q+EPUge/M
         Fcvw==
X-Gm-Message-State: AOJu0Yw1hyOc5P4nyuiSPTZsXXLTU5fP2tzA5lQ3tP4RYECIo17J1Mz6
        rs4OwAvvj/MQYi/yWb9mWNTPpUQG+c8L7crloyjl5A==
X-Google-Smtp-Source: AGHT+IFanxwa4yIU2V0wyf1ATfRK+p51m+xb0grLdzm8c9lTbvXMJ08UMOTQPeDLgoFL36VWCTONOa1jpRuoh7MZ4k8=
X-Received: by 2002:a17:902:ea04:b0:1c6:20ca:2cb8 with SMTP id
 s4-20020a170902ea0400b001c620ca2cb8mr458147plg.22.1695809227668; Wed, 27 Sep
 2023 03:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
In-Reply-To: <20230923013148.1390521-3-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Sep 2023 12:06:31 +0200
Message-ID: <CAG48ez11FdESrYYDLmtZEgZ7osDi-QDYpk+Z0p=qjpCks++7rg@mail.gmail.com>
Subject: potential new userfaultfd vs khugepaged conflict [was: Re: [PATCH v2
 2/3] userfaultfd: UFFDIO_REMAP uABI]
To:     Suren Baghdasaryan <surenb@google.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[moving Hugh into "To:" recipients as FYI for khugepaged interaction]

On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
>
> This implements the uABI of UFFDIO_REMAP.
>
> Notably one mode bitflag is also forwarded (and in turn known) by the
> lowlevel remap_pages method.
>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
[...]
> +/*
> + * The mmap_lock for reading is held by the caller. Just move the page
> + * from src_pmd to dst_pmd if possible, and return true if succeeded
> + * in moving the page.
> + */
> +static int remap_pages_pte(struct mm_struct *dst_mm,
> +                          struct mm_struct *src_mm,
> +                          pmd_t *dst_pmd,
> +                          pmd_t *src_pmd,
> +                          struct vm_area_struct *dst_vma,
> +                          struct vm_area_struct *src_vma,
> +                          unsigned long dst_addr,
> +                          unsigned long src_addr,
> +                          __u64 mode)
> +{
> +       swp_entry_t entry;
> +       pte_t orig_src_pte, orig_dst_pte;
> +       spinlock_t *src_ptl, *dst_ptl;
> +       pte_t *src_pte =3D NULL;
> +       pte_t *dst_pte =3D NULL;
> +
> +       struct folio *src_folio =3D NULL;
> +       struct anon_vma *src_anon_vma =3D NULL;
> +       struct mmu_notifier_range range;
> +       int err =3D 0;
> +
> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm,
> +                               src_addr, src_addr + PAGE_SIZE);
> +       mmu_notifier_invalidate_range_start(&range);
> +retry:
> +       dst_pte =3D pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &dst=
_ptl);
> +
> +       /* If an huge pmd materialized from under us fail */
> +       if (unlikely(!dst_pte)) {
> +               err =3D -EFAULT;
> +               goto out;
> +       }
> +
> +       src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, src_addr, &src=
_ptl);
> +
> +       /*
> +        * We held the mmap_lock for reading so MADV_DONTNEED
> +        * can zap transparent huge pages under us, or the
> +        * transparent huge page fault can establish new
> +        * transparent huge pages under us.
> +        */
> +       if (unlikely(!src_pte)) {
> +               err =3D -EFAULT;
> +               goto out;
> +       }
> +
> +       BUG_ON(pmd_none(*dst_pmd));
> +       BUG_ON(pmd_none(*src_pmd));
> +       BUG_ON(pmd_trans_huge(*dst_pmd));
> +       BUG_ON(pmd_trans_huge(*src_pmd));

This works for now, but note that Hugh Dickins has recently been
reworking khugepaged such that PTE-based mappings can be collapsed
into transhuge mappings under the mmap lock held in *read mode*;
holders of the mmap lock in read mode can only synchronize against
this by taking the right page table spinlock and rechecking the pmd
value. This is only the case for file-based mappings so far, not for
anonymous private VMAs; and this code only operates on anonymous
private VMAs so far, so it works out.

But if either Hugh further reworks khugepaged such that anonymous VMAs
can be collapsed under the mmap lock in read mode, or you expand this
code to work on file-backed VMAs, then it will become possible to hit
these BUG_ON() calls. I'm not sure what the plans for khugepaged going
forward are, but the number of edgecases everyone has to keep in mind
would go down if you changed this function to deal gracefully with
page tables disappearing under you.

In the newest version of mm/pgtable-generic.c, above
__pte_offset_map_lock(), there is a big comment block explaining the
current rules for page table access; in particular, regarding the
helper pte_offset_map_nolock() that you're using:

 * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_ma=
p();
 * but when successful, it also outputs a pointer to the spinlock in ptlp -=
 as
 * pte_offset_map_lock() does, but in this case without locking it.  This h=
elps
 * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that t=
ime
 * act on a changed *pmd: pte_offset_map_nolock() provides the correct spin=
lock
 * pointer for the page table that it returns.  In principle, the caller sh=
ould
 * recheck *pmd once the lock is taken; in practice, no callsite needs that=
 -
 * either the mmap_lock for write, or pte_same() check on contents, is enou=
gh.

If this becomes hittable in the future, I think you will need to
recheck *pmd, at least for dst_pte, to avoid copying PTEs into a
detached page table.

> +       spin_lock(dst_ptl);
> +       orig_dst_pte =3D *dst_pte;
> +       spin_unlock(dst_ptl);
> +       if (!pte_none(orig_dst_pte)) {
> +               err =3D -EEXIST;
> +               goto out;
> +       }
> +
> +       spin_lock(src_ptl);
> +       orig_src_pte =3D *src_pte;
> +       spin_unlock(src_ptl);
> +       if (pte_none(orig_src_pte)) {
> +               if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES))
> +                       err =3D -ENOENT;
> +               else /* nothing to do to remap a hole */
> +                       err =3D 0;
> +               goto out;
> +       }
> +
> +       if (pte_present(orig_src_pte)) {
> +               /*
> +                * Pin and lock both source folio and anon_vma. Since we =
are in
> +                * RCU read section, we can't block, so on contention hav=
e to
> +                * unmap the ptes, obtain the lock and retry.
> +                */
> +               if (!src_folio) {
> +                       struct folio *folio;
> +
> +                       /*
> +                        * Pin the page while holding the lock to be sure=
 the
> +                        * page isn't freed under us
> +                        */
> +                       spin_lock(src_ptl);
> +                       if (!pte_same(orig_src_pte, *src_pte)) {
> +                               spin_unlock(src_ptl);
> +                               err =3D -EAGAIN;
> +                               goto out;
> +                       }
> +
> +                       folio =3D vm_normal_folio(src_vma, src_addr, orig=
_src_pte);
> +                       if (!folio || !folio_test_anon(folio) ||
> +                           folio_test_large(folio) ||
> +                           folio_estimated_sharers(folio) !=3D 1) {
> +                               spin_unlock(src_ptl);
> +                               err =3D -EBUSY;
> +                               goto out;
> +                       }
> +
> +                       folio_get(folio);
> +                       src_folio =3D folio;
> +                       spin_unlock(src_ptl);
> +
> +                       /* block all concurrent rmap walks */
> +                       if (!folio_trylock(src_folio)) {
> +                               pte_unmap(&orig_src_pte);
> +                               pte_unmap(&orig_dst_pte);
> +                               src_pte =3D dst_pte =3D NULL;
> +                               /* now we can block and wait */
> +                               folio_lock(src_folio);
> +                               goto retry;
> +                       }
> +               }
> +
> +               if (!src_anon_vma) {
> +                       /*
> +                        * folio_referenced walks the anon_vma chain
> +                        * without the folio lock. Serialize against it w=
ith
> +                        * the anon_vma lock, the folio lock is not enoug=
h.
> +                        */
> +                       src_anon_vma =3D folio_get_anon_vma(src_folio);
> +                       if (!src_anon_vma) {
> +                               /* page was unmapped from under us */
> +                               err =3D -EAGAIN;
> +                               goto out;
> +                       }
> +                       if (!anon_vma_trylock_write(src_anon_vma)) {
> +                               pte_unmap(&orig_src_pte);
> +                               pte_unmap(&orig_dst_pte);
> +                               src_pte =3D dst_pte =3D NULL;
> +                               /* now we can block and wait */
> +                               anon_vma_lock_write(src_anon_vma);
> +                               goto retry;
> +                       }
> +               }
> +
> +               err =3D remap_anon_pte(dst_mm, src_mm,  dst_vma, src_vma,
> +                                    dst_addr, src_addr, dst_pte, src_pte=
,
> +                                    orig_dst_pte, orig_src_pte,
> +                                    dst_ptl, src_ptl, src_folio);
> +       } else {
> +               entry =3D pte_to_swp_entry(orig_src_pte);
> +               if (non_swap_entry(entry)) {
> +                       if (is_migration_entry(entry)) {
> +                               pte_unmap(&orig_src_pte);
> +                               pte_unmap(&orig_dst_pte);
> +                               src_pte =3D dst_pte =3D NULL;
> +                               migration_entry_wait(src_mm, src_pmd,
> +                                                    src_addr);
> +                               err =3D -EAGAIN;
> +                       } else
> +                               err =3D -EFAULT;
> +                       goto out;
> +               }
> +
> +               err =3D remap_swap_pte(dst_mm, src_mm, dst_addr, src_addr=
,
> +                                    dst_pte, src_pte,
> +                                    orig_dst_pte, orig_src_pte,
> +                                    dst_ptl, src_ptl);
> +       }
> +
> +out:
> +       if (src_anon_vma) {
> +               anon_vma_unlock_write(src_anon_vma);
> +               put_anon_vma(src_anon_vma);
> +       }
> +       if (src_folio) {
> +               folio_unlock(src_folio);
> +               folio_put(src_folio);
> +       }
> +       if (dst_pte)
> +               pte_unmap(dst_pte);
> +       if (src_pte)
> +               pte_unmap(src_pte);
> +       mmu_notifier_invalidate_range_end(&range);
> +
> +       return err;
> +}
