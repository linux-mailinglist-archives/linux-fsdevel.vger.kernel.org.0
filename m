Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3D538A8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 06:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243807AbiEaEYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 00:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiEaEYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 00:24:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64BD76297;
        Mon, 30 May 2022 21:24:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v19so8541188edd.4;
        Mon, 30 May 2022 21:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtShy+gXTM5c8a8846yJ1mSpmrTSFyjIFJTOvdhy/28=;
        b=d10fl/mP42dBnwzHZoDPefbOmO6etVC+VFrYUXy8o8yi0+bFA5bhcoZ8MRAvLHrBsK
         Ksg1c0QfsqTYfOqA3H4rYcX6L/kXdzHOcbcmT5DMz4b8FrpBht45C5FjrGHC0jL+ncPG
         0aBV8XN5o5SgdxzyqNaVnxQ9mI88BmRoOWukvo5Mbu0ckoG7zM7uKA3nKrvY4fiXZjTc
         oc+rINAavcU4V1cvggi5bkl32PtaFpsiFIc/ph//lZ9xFLvjOSahoXyDWGbzn+xEjDKs
         gFFD+KZCshw7oF+IviBmmB1hfviV7fw+FpE6j+4l1hCZ3UOmzyDXMY7RYanLi1nwrzEx
         ukmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtShy+gXTM5c8a8846yJ1mSpmrTSFyjIFJTOvdhy/28=;
        b=LWnqs9uHFrsOFqXPIBRRaFUId4fMqAYuqVhZsFAxKSGPKMHhstSHUHb4DLeJmHWKoJ
         IZj1aT3o+BFBxKFcPsVF55Bo7epTdNxja8BbbCxXnG7mwc3rIuEPBtWrCUlnHLPze8mM
         QCBvgAAfI7t/4zkKq9EEUQY9Q7XKjYkOrRL3mTHovIq5ZIuMFK3SFz0GmTJnSKBjyn7t
         2nQ/GioGWgQSirOns1AGYnO5kSOEZS0MYNq0H+8qeoYn6ozVNl2fet2rAn3d+5028fLT
         jYyU0vabzw2MTL/0Vl/LBL13/V6KCXw9J6jH0l7YQfAErgJuqv8ECvTSYVKdbXM0Ep7B
         vm2Q==
X-Gm-Message-State: AOAM530aoF20CciLsKhM2W93HSDAbux1Bf/mY2m+LmuXNnkxS0vtAR0i
        o+xTq0txM/jejSiixAGEB9YQxSkQYDQ3B/fgheE=
X-Google-Smtp-Source: ABdhPJxUw1H24/IiUtEPt2Lrr22rCtH+K5j1vOTiDssFpx9RkbrsLCLy5A67Y38ltiSDIoWfdztNPqA7dtoKmMpvSbY=
X-Received: by 2002:a05:6402:b09:b0:42d:bd80:11ac with SMTP id
 bm9-20020a0564020b0900b0042dbd8011acmr14464509edb.244.1653971091286; Mon, 30
 May 2022 21:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649370874.git.khalid.aziz@oracle.com> <f96de8e7757aabc8e38af8aacbce4c144133d42d.1649370874.git.khalid.aziz@oracle.com>
In-Reply-To: <f96de8e7757aabc8e38af8aacbce4c144133d42d.1649370874.git.khalid.aziz@oracle.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 31 May 2022 16:24:40 +1200
Message-ID: <CAGsJ_4xC0sB0x2orOcKgx4p0fa5Y0bR9qeviq1_Q7VmhMk2d6A@mail.gmail.com>
Subject: Re: [PATCH v1 09/14] mm/mshare: Do not free PTEs for mshare'd PTEs
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        Peter Collingbourne <pcc@google.com>,
        Mike Rapoport <rppt@kernel.org>, sieberf@amazon.com,
        sjpark@amazon.de, Suren Baghdasaryan <surenb@google.com>,
        tst@schoebel-theuer.de, Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> mshare'd PTEs should not be removed when a task exits. These PTEs
> are removed when the last task sharing the PTEs exits. Add a check
> for shared PTEs and skip them.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  mm/memory.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index c77c0d643ea8..e7c5bc6f8836 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -419,16 +419,25 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                 } else {
>                         /*
>                          * Optimization: gather nearby vmas into one call down
> +                        * as long as they all belong to the same mm (that
> +                        * may not be the case if a vma is part of mshare'd
> +                        * range
>                          */
>                         while (next && next->vm_start <= vma->vm_end + PMD_SIZE
> -                              && !is_vm_hugetlb_page(next)) {
> +                              && !is_vm_hugetlb_page(next)
> +                              && vma->vm_mm == tlb->mm) {
>                                 vma = next;
>                                 next = vma->vm_next;
>                                 unlink_anon_vmas(vma);
>                                 unlink_file_vma(vma);
>                         }
> -                       free_pgd_range(tlb, addr, vma->vm_end,
> -                               floor, next ? next->vm_start : ceiling);
> +                       /*
> +                        * Free pgd only if pgd is not allocated for an
> +                        * mshare'd range
> +                        */
> +                       if (vma->vm_mm == tlb->mm)
> +                               free_pgd_range(tlb, addr, vma->vm_end,
> +                                       floor, next ? next->vm_start : ceiling);
>                 }
>                 vma = next;
>         }
> @@ -1551,6 +1560,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>         pgd_t *pgd;
>         unsigned long next;
>
> +       /*
> +        * If this is an mshare'd page, do not unmap it since it might
> +        * still be in use.
> +        */
> +       if (vma->vm_mm != tlb->mm)
> +               return;
> +

expect unmap, have you ever tested reverse mapping in vmscan, especially
folio_referenced()? are all vmas in those processes sharing page table still
in the rmap of the shared page?
without shared PTE, if 1000 processes share one page, we are reading 1000
PTEs, with it, are we reading just one? or are we reading the same PTE
1000 times? Have you tested it?

>         BUG_ON(addr >= end);
>         tlb_start_vma(tlb, vma);
>         pgd = pgd_offset(vma->vm_mm, addr);
> --
> 2.32.0
>

Thanks
Barry
