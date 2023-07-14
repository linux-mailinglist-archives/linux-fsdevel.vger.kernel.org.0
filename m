Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A2752FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjGNDEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGNDEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:04:50 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475242698
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:04:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1329781276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689303884; x=1691895884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4BF5nL1hHerQt4XXkZr14C1Ft2qyucggxOLcgG/mUE=;
        b=er6f9xnGJ2N0qzlavJE7C8fXy0dDvCJIhFU9ZDb6LeyXGIiBwWFjrgUF9waRAMHLUD
         Vst9Hmnuhmj+GCUAbysAnoawRb/3DKTXo38GfLYjm70NzKHKxnUaNZ6o3FW7eBCZLZfO
         S8PUAUbU1aBPRxWOhSxPigUFYDuqPh2xUVnHSS7AtXGGDA9KZw+G1k30WpArGVn4LkqC
         IlIi5MyLf/lvWZnmSDrtKLxYs5OYoU+R+vC9NuKxZSrvipU8/qHupPGmY9OK0vBJyLQv
         e9LTMSOJTGT8l3/L7efxA/y8rIFBGs2Po1DDtBlJxmzNyjAuh3UTa3ZE3O00moOUX53N
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689303884; x=1691895884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4BF5nL1hHerQt4XXkZr14C1Ft2qyucggxOLcgG/mUE=;
        b=jksWiIsF+DOtuUyn4yw81C2gaTIzdNP8pvoUJH3vexQTV/J37fMZV/Ec96epsG2cgx
         KbFtcws6qBPub2ZF9WSVmDCNhBZx4R0IezkFzLDuauJ5kJB6KQYB2y+nAiGd0vT0YIOm
         PisA59W5/cnT2fXfOYlK4ra8zbfYCsr/Mqc4cp85WkyfwSHdXPQmEYgwsIsAevK5mRA1
         KESPgbYyma5yDM+i+k1swYrTRd+XQrdcwxspdcU05LVBPhDlYtcc46TsH5SeA8xPzhjl
         RFSoApyewdm5lj6/2Us4meXuUAi6OJrORCTgKc6Dg0zwU9s0BhjLg4yLSCd+SgkoAML2
         Zfbw==
X-Gm-Message-State: ABy/qLZfLseggU7obxHj3CHj7R7ohjb0wkq8uVCXtkSHfJt5/DbFo3Fp
        TenAe9jt8O2cysWC4j3O4dexME2RGxcga5nh6ACHHQ==
X-Google-Smtp-Source: APBJJlHEUo2Sn8En4kIzeIj2RFma+K5JyjK7OTmVvujsN42wdttyWHvEBiqedgRa4i59pb4h0DT40FytdkqdZ61/pek=
X-Received: by 2002:a25:3491:0:b0:c85:d8b6:c21d with SMTP id
 b139-20020a253491000000b00c85d8b6c21dmr2775730yba.31.1689303884251; Thu, 13
 Jul 2023 20:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-4-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-4-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:04:33 -0700
Message-ID: <CAJuCfpHVwDty=qFfqALjb4ZovvKsEjuuvOBMXEYrCd-Jw8k7Qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] mm: Move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:20=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Handle a little more of the page fault path outside the mmap sem.
> The hugetlb path doesn't need to check whether the VMA is anonymous;
> the VM_HUGETLB flag is only set on hugetlbfs VMAs.  There should be no
> performance change from the previous commit; this is simply a step to
> ease bisection of any problems.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/hugetlb.c |  6 ++++++
>  mm/memory.c  | 18 +++++++++---------
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e4a28ce0667f..109e1ff92bc8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6063,6 +6063,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, str=
uct vm_area_struct *vma,
>         int need_wait_lock =3D 0;
>         unsigned long haddr =3D address & huge_page_mask(h);
>
> +       /* TODO: Handle faults under the VMA lock */
> +       if (flags & FAULT_FLAG_VMA_LOCK) {
> +               vma_end_read(vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         /*
>          * Serialize hugepage allocation and instantiation, so that we do=
n't
>          * get spurious allocation failures if two CPUs race to instantia=
te
> diff --git a/mm/memory.c b/mm/memory.c
> index f2dcc695f54e..6eda5c5f2069 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4998,10 +4998,10 @@ static vm_fault_t handle_pte_fault(struct vm_faul=
t *vmf)
>  }
>
>  /*
> - * By the time we get here, we already hold the mm semaphore
> - *
> - * The mmap_lock may have been released depending on flags and our
> - * return value.  See filemap_fault() and __folio_lock_or_retry().
> + * On entry, we hold either the VMA lock or the mmap_lock
> + * (FAULT_FLAG_VMA_LOCK tells you which).  If VM_FAULT_RETRY is set in
> + * the result, the mmap_lock is not held on exit.  See filemap_fault()
> + * and __folio_lock_or_retry().
>   */
>  static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>                 unsigned long address, unsigned int flags)
> @@ -5020,6 +5020,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area=
_struct *vma,
>         p4d_t *p4d;
>         vm_fault_t ret;
>
> +       if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
> +               vma_end_read(vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         pgd =3D pgd_offset(mm, address);
>         p4d =3D p4d_alloc(mm, pgd, address);
>         if (!p4d)
> @@ -5247,11 +5252,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *=
vma, unsigned long address,
>                 goto out;
>         }
>
> -       if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
> -               vma_end_read(vma);
> -               return VM_FAULT_RETRY;
> -       }
> -
>         /*
>          * Enable the memcg OOM handling for faults triggered in user
>          * space.  Kernel faults are handled more gracefully.
> --
> 2.39.2
>
