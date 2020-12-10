Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A352D60AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392044AbgLJP6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 10:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391797AbgLJP6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:58:38 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:57:58 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so4591611pge.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fnon7sDzka34R7LgC0De8tPIdaalVEeRV2dY0iPqfl8=;
        b=GgNwNSHdatu+tNWPwIJEz9GCAzeb56lDlxA8kMpi4aHDozUFZ5Sv3Lw+uEOWSVGtjT
         wI1Zn7rPAUosJLJx34F3dHvx8+ImP9VzS/i2vOXMsaD5sXMwTDygmfDuZhPeTcj7N3Js
         q9zMVql+zspvvDxtgweapTbN1vy/kjQ3CVgAq2dP4x0Pnr2rKswaR+rvKlUNjFwFjKke
         s/gM3raMy1TMT/t+GDJj7x4RRZKOtqPMsX39apcdidkcGjXIj4EFwSauxx4/FB3vyDsv
         4une5ur5AR6djKj+qUUGozr5Nfi2yvWNNUcR6tG4Xe5nRbhd+oZGFJK9H5aDHPqkcwJk
         hYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fnon7sDzka34R7LgC0De8tPIdaalVEeRV2dY0iPqfl8=;
        b=Mr1zOpj//h3qQcv3ZyoFESSOCV3OnCx3P5bRnxtnKOCHWWD6gcem9XM0v+fEvkwUEL
         NZWmquK6CpdYeqH3ZtsMqtjLdPjHuXYB6ecHofrW0CSn2LK1pIcnkWUKoDNOVRhksA6p
         nBRKxMHVm+fEhqDJO3GytGXI8wiSeLDnaMhqA5o3EFM4AWdRITvEUid43tesa98EFT6U
         rNaPzcKH10ezzYNTok3ZNUqK4ScFAPKbsNIf/qWHyckal/M5YPsWZmiw84dw90v6GX4N
         U3rwnxrZWv9gly9ohojWSeXowim4VtH9Zh14CupjGOSnUO9R2S/yT3r4f7X36x7Y1tQ/
         qbKQ==
X-Gm-Message-State: AOAM531RSX0kzHCL1g6uqaMaK51n8+JKgYGfdFYEFgpI9fs+c1Xh3Jbx
        +8Htvkwo09n9SGRi7lzbsrNWiyEiC5jF4/0Ov/H98A==
X-Google-Smtp-Source: ABdhPJzqiQKGJsmus7zKhdtqlGPdLVV43tunbznKDaEHRk/DlgkMGu/McZ++C6DuhMpQ2zRSMZzvRSssSYYMEE1rsgQ=
X-Received: by 2002:a63:cd14:: with SMTP id i20mr7217766pgg.31.1607615877450;
 Thu, 10 Dec 2020 07:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-5-songmuchun@bytedance.com> <20201210144256.GB8538@localhost.localdomain>
In-Reply-To: <20201210144256.GB8538@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 23:57:21 +0800
Message-ID: <CAMZfGtWs06zRQ5qXV3bNmWh1kptDAe8eyKKzGHsLMhVaoLUp7A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 04/12] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 10:43 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 11:55:18AM +0800, Muchun Song wrote:
> > The free_vmemmap_pages_per_hpage() which indicate that how many vmemmap
> > pages associated with a HugeTLB page that can be freed to the buddy
> > allocator just returns zero now, because all infrastructure is not
> > ready. Once all the infrastructure is ready, we will rework this
> > function to support the feature.
>
> I would reword the above to:
>
> "free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
>  pages associated with a HugeTLB page can be freed, returns zero for
>  now, which means the feature is disabled.
>  We will enable it once all the infrastructure is there."

Thanks for your suggestion.

>
>  Or something along those lines.
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Overall this looks good to me, and it has seen a considerable
> simplification, which is good.
> Some nits/questions below:
>
>
> > +#define vmemmap_hpage_addr_end(addr, end)                             \
> > +({                                                                    \
> > +     unsigned long __boundary;                                        \
> > +     __boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK; \
> > +     (__boundary - 1 < (end) - 1) ? __boundary : (end);               \
> > +})
>
> Maybe add a little comment explaining what are you trying to get here.

OK. Will do.

>
> > +/*
> > + * Walk a vmemmap address to the pmd it maps.
> > + */
> > +static pmd_t *vmemmap_to_pmd(unsigned long addr)
> > +{
> > +     pgd_t *pgd;
> > +     p4d_t *p4d;
> > +     pud_t *pud;
> > +     pmd_t *pmd;
> > +
> > +     pgd = pgd_offset_k(addr);
> > +     if (pgd_none(*pgd))
> > +             return NULL;
> > +
> > +     p4d = p4d_offset(pgd, addr);
> > +     if (p4d_none(*p4d))
> > +             return NULL;
> > +
> > +     pud = pud_offset(p4d, addr);
> > +     if (pud_none(*pud))
> > +             return NULL;
> > +
> > +     pmd = pmd_offset(pud, addr);
> > +     if (pmd_none(*pmd))
> > +             return NULL;
> > +
> > +     return pmd;
> > +}
>
> I saw that some people suggested to put all the non-hugetlb vmemmap
> functions under sparsemem-vmemmap.c, which makes some sense if some
> feature is going to re-use this code somehow. (I am not sure if the
> recent patches that take advantage of this feature for ZONE_DEVICE needs
> something like this).
>
> I do not have a strong opinion on this though.

Yeah, I also thought about this. I prefer moving the common code to
the sparsemem-vmemmap.c. If more people agree with this, I can do
this in the next version. :)

>
> > +static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
> > +                                 unsigned long start, unsigned long end,
> > +                                 struct list_head *vmemmap_pages)
> > +{
> > +     /*
> > +      * Make the tail pages are mapped with read-only to catch
> > +      * illegal write operation to the tail pages.
> > +      */
> > +     pgprot_t pgprot = PAGE_KERNEL_RO;
> > +     pte_t entry = mk_pte(reuse, pgprot);
> > +     unsigned long addr;
> > +
> > +     for (addr = start; addr < end; addr += PAGE_SIZE, pte++) {
> > +             struct page *page;
> > +
> > +             VM_BUG_ON(pte_none(*pte));
>
> If it is none, page will be NULL and we will crash in the list_add
> below?

Yeah, I think that here should be a BUG_ON.

>
> > +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> > +                             struct list_head *vmemmap_pages)
> > +{
> > +     pmd_t *pmd;
> > +     unsigned long next, addr = start;
> > +     struct page *reuse = NULL;
> > +
> > +     VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> > +     VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> > +     VM_BUG_ON((start >> PUD_SHIFT) != (end >> PUD_SHIFT));
> This last VM_BUG_ON, is to see if both fall under the same PUD table?

Right.

>
> > +
> > +     pmd = vmemmap_to_pmd(addr);
> > +     BUG_ON(!pmd);
>
> Which is the criteria you followed to make this BUG_ON and VM_BUG_ON
> in the check from vmemmap_reuse_pte_range?

Indeed, I am somewhat confused. Should be unified. I should use
BUG_ON here and in vmemmap_reuse_pte_range.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
