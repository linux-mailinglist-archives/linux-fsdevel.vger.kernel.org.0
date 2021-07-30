Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC623DC08E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhG3V5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhG3V4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:56:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C297C0617B1;
        Fri, 30 Jul 2021 14:56:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h9so3843894ejs.4;
        Fri, 30 Jul 2021 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4PGd/pIyrnd9ii9aiOJADxaPJbcRb7d0IRplRSuPHpo=;
        b=dbaq5a2220DjhsTlYvCWntQ0BOusszu2je5PRR9jRZn5fZr+yRsq23Oa62wfeoIgiX
         Fz5/2M0u+Hu5AMRBjkD4ZV1W95rTTfNhUVND6/lluArC29Yqb7QEGcSrc3KagfeIM6oJ
         k3zCQuQf1nOTrxLhHdW8d2w5j+9FjH+S27jAl3+Q77cWknD7Cxx9zLkzX9O93er/gvsI
         hA669WgZ7j9U72hd61edjgaa4l+mDW/DWhmzYj+1sHdQvWmrMVQKPNazh5zku+/Pkiit
         X8k+U4p2k9vndTdP3/2XCSuAH1+28A5g28+K7Rfo+fQZRElS7BmEGzbG7Qzbg+HoPfWO
         G01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PGd/pIyrnd9ii9aiOJADxaPJbcRb7d0IRplRSuPHpo=;
        b=Jo8oynNMzvfr+Steyz47cX67difILIa9KuLSHibEtYfppfRDebOSsgsn4pJVd4DGjq
         VK/6drw7s6EQfB1GTkfnUUFtqGVHsN7QXmjiYPJdoOt0/W2FZ8MrT9SajuBKgZ00XNx+
         c9KAQTaH2VIujFckV06zLubd5j3BZn+w9Go+L3aCZuPpGyR2z/Rlq2jLf9m3EXDkTn9p
         Mjibwvl3KbDYgmFZiWJN2cPqChOVjqLeruxaCt5aKL9vsAjlYms6Y1QEJ/YlZmaLfA+Y
         KF8JvPO7H0ilYsIxogjLl7XaOUDncBtzeiSwfyl//9cGpnTaUVa2cUiL/0X1SB8lxsaz
         WJIw==
X-Gm-Message-State: AOAM533eX41KLQzD9uN67K8vbpPRcdJgCsTzljZo3Y0jnuymVozmEIDj
        NTfHdEXjDrBiIb/zdkHjTyPMbYAvzWKMtUshdPE=
X-Google-Smtp-Source: ABdhPJyXE4pPHAFxm/nipCJwTtYmXsOWVqwYGGw8YUN64nEt4hQdURUPR1ed3ZyGCzMBkcpUubQ0BaCwxY+e9DYCLMc=
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr4774953eje.161.1627682184064;
 Fri, 30 Jul 2021 14:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <b44e3619-712e-90af-89d2-e4ba654c5110@google.com>
In-Reply-To: <b44e3619-712e-90af-89d2-e4ba654c5110@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Jul 2021 14:56:12 -0700
Message-ID: <CAHbLzko5oU_1X=M1LFr=4hNDvs0BF0UY+_8e0RHMhUqspMHV3Q@mail.gmail.com>
Subject: Re: [PATCH 04/16] huge tmpfs: revert shmem's use of transhuge_vma_enabled()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:36 AM Hugh Dickins <hughd@google.com> wrote:
>
> 5.14 commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
> checking in transparent_hugepage_enabled()") added transhuge_vma_enabled()
> as a wrapper for two very different checks: shmem_huge_enabled() prefers
> to show those two checks explicitly, as before.

Basically I have no objection to separating them again. But IMHO they
seem not very different. Or just makes things easier for the following
patches?

>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/shmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ce3ccaac54d6..c6fa6f4f2db8 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4003,7 +4003,8 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>         loff_t i_size;
>         pgoff_t off;
>
> -       if (!transhuge_vma_enabled(vma, vma->vm_flags))
> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>                 return false;
>         if (shmem_huge == SHMEM_HUGE_FORCE)
>                 return true;
> --
> 2.26.2
>
