Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4F2ACFE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 07:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgKJGlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 01:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJGlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:41:31 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA0FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 22:41:31 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so9325339pgk.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Geg8ga216EfQWJODZoPB/tADPTu5Ty/TnxqtFN8Hj0=;
        b=MwT0BS1CEqMvujGC6+tdpVO9hRjWYfqyzXa6ua/F0hzskdgPD5LbnmQ9Det6MF1OP8
         3Ah419OYIy7M4n/+h7Kr9enfI3NdOx4+4yreJSxWloDJ1SlsKj3SBpDuoS2m8PFV/Ezy
         0I/HBFgQIJvBiWSU8Hq82ZEFd7Vs/EZi7HC9ryFvr+TNe1+Imc1AwS5cxrQvPZnzcAqT
         5YHYdHwbebCo3lSSK74CmEc32eY/zAsbFAtiHi0AIvmddVUExyGTykizT69I/d1MZHA7
         2lfk5lETJ2+N60GnQJNbk4IYmcJdMiIBh62dD12+GiBWrIiCDo4zO9WUxJxSgGuydFeg
         OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Geg8ga216EfQWJODZoPB/tADPTu5Ty/TnxqtFN8Hj0=;
        b=WCI/vDgoQqjuEMvAjfnpgKje3jPCEtEi9Px+UwnoWJhkFwHTGBeuL45KkYJ3EOLuJF
         6REdNRAAewwD0yxorZpB6z8PPqUjVvfZixCtqAK45yQ4pdWuxVB07H+qBXCPlOI8hG+j
         e43ZmpMOEfwaO4j32x8KCGnNP3v+P8UO3UW4WR9eDCTOJ4jfwyPWlB9EO7k39MFi8LBI
         sZS4Gz4MgFoiEiRSE3rN44JNLkwhVMzau4PeFy5DAqvxcCTfGDTORsPLgcSeZC01XaDt
         nZy8KzM5QjGPBFKX5dUuNt3Us3qlR4VCkJcbIKIL/JWGiSm0/ubZj+UNY8S4Ta11jCRN
         rxuw==
X-Gm-Message-State: AOAM531gMJi8bKbDHMRgKcJZBziKp9Hj6Nt9ItKuTciryE/tw7fvMEMA
        OK0RSiWQe8NC0SAsybDhjuhqYE7l1/3s+8BZ4tk1yQ==
X-Google-Smtp-Source: ABdhPJyKv0hduPw4n7bMCGrbf+Z7jY28oQybr8inCHTvwXZPj/t82bSlEumrVllRoDro/ckWIWNhgZ9mwbt/p6SnlS0=
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id
 s7-20020aa782870000b0290142250139ecmr16678994pfm.59.1604990490866; Mon, 09
 Nov 2020 22:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-10-songmuchun@bytedance.com> <20201109185138.GD17356@linux>
In-Reply-To: <20201109185138.GD17356@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 14:40:54 +0800
Message-ID: <CAMZfGtXpXoQ+zVi2Us__7ghSu_3U7+T3tx-EL+zfa=1Obn=55g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 09/21] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:51 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Nov 08, 2020 at 10:11:01PM +0800, Muchun Song wrote:
> > +static inline int freed_vmemmap_hpage(struct page *page)
> > +{
> > +     return atomic_read(&page->_mapcount) + 1;
> > +}
> > +
> > +static inline int freed_vmemmap_hpage_inc(struct page *page)
> > +{
> > +     return atomic_inc_return_relaxed(&page->_mapcount) + 1;
> > +}
> > +
> > +static inline int freed_vmemmap_hpage_dec(struct page *page)
> > +{
> > +     return atomic_dec_return_relaxed(&page->_mapcount) + 1;
> > +}
>
> Are these relaxed any different that the normal ones on x86_64?
> I got confused following the macros.

A PTE table can contain 64 HugeTLB(2MB) page's struct page structures.
So I use the freed_vmemmap_hpage to indicate how many HugeTLB pages
that it's vmemmap pages are already freed to buddy.

Once vmemmap pages of a HugeTLB page are freed, we call the
freed_vmemmap_hpage_inc, when freeing a HugeTLB to the buddy,
we should call freed_vmemmap_hpage_dec.

If the freed_vmemmap_hpage hit zero when free HugeTLB, we try to merge
the PTE table to PMD(now only support gigantic pages). This can refer to

  [PATCH v3 19/21] mm/hugetlb: Merge pte to huge pmd only for gigantic

Thanks.

>
> > +static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
> > +                                      unsigned long start,
> > +                                      unsigned int nr_free,
> > +                                      struct list_head *free_pages)
> > +{
> > +     /* Make the tail pages are mapped read-only. */
> > +     pgprot_t pgprot = PAGE_KERNEL_RO;
> > +     pte_t entry = mk_pte(reuse, pgprot);
> > +     unsigned long addr;
> > +     unsigned long end = start + (nr_free << PAGE_SHIFT);
>
> See below.
>
> > +static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
> > +                                      unsigned long addr,
> > +                                      struct list_head *free_pages)
> > +{
> > +     unsigned long next;
> > +     unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
> > +     unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
> > +     struct page *reuse = NULL;
> > +
> > +     addr = start;
> > +     do {
> > +             unsigned int nr_pages;
> > +             pte_t *ptep;
> > +
> > +             ptep = pte_offset_kernel(pmd, addr);
> > +             if (!reuse)
> > +                     reuse = pte_page(ptep[-1]);
>
> Can we define a proper name for that instead of -1?
>
> e.g: TAIL_PAGE_REUSE or something like that.

OK, will do.

>
> > +
> > +             next = vmemmap_hpage_addr_end(addr, end);
> > +             nr_pages = (next - addr) >> PAGE_SHIFT;
> > +             __free_huge_page_pte_vmemmap(reuse, ptep, addr, nr_pages,
> > +                                          free_pages);
>
> Why not passing next instead of nr_pages? I think it makes more sense.
> As a bonus we can kill the variable.

Good catch. We can pass next instead of nr_pages. Thanks.


>
> > +static void split_vmemmap_huge_page(struct hstate *h, struct page *head,
> > +                                 pmd_t *pmd)
> > +{
> > +     pgtable_t pgtable;
> > +     unsigned long start = (unsigned long)head & VMEMMAP_HPAGE_MASK;
> > +     unsigned long addr = start;
> > +     unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> > +
> > +     while (nr-- && (pgtable = vmemmap_pgtable_withdraw(head))) {
>
> The same with previous patches, I would scrap "nr" and its use.
>
> > +             VM_BUG_ON(freed_vmemmap_hpage(pgtable));
>
> I guess here we want to check whether we already call free_huge_page_vmemmap
> on this range?
> For this to have happened, the locking should have failed, right?

Only the first HugeTLB page should split the PMD to PTE. The other 63
HugeTLB pages
do not need to split. Here I want to make sure we are the first.

>
> > +static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > +{
> > +     pmd_t *pmd;
> > +     spinlock_t *ptl;
> > +     LIST_HEAD(free_pages);
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return;
> > +
> > +     pmd = vmemmap_to_pmd(head);
> > +     ptl = vmemmap_pmd_lock(pmd);
> > +     if (vmemmap_pmd_huge(pmd)) {
> > +             VM_BUG_ON(!pgtable_pages_to_prealloc_per_hpage(h));
>
> I think that checking for free_vmemmap_pages_per_hpage is enough.
> In the end, pgtable_pages_to_prealloc_per_hpage uses free_vmemmap_pages_per_hpage.

The free_vmemmap_pages_per_hpage is not enough. See the comments above.

Thanks.

>
>
> --
> Oscar Salvador
> SUSE L3



--
Yours,
Muchun
