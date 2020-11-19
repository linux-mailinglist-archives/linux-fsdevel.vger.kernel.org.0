Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED17B2B8B7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 07:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKSGSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 01:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgKSGSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:18:02 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F30FC0617A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 22:18:01 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q28so3304957pgk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 22:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pQ2zj7Jlr1PXAZIscOwv68xrKkz77uBgfi3u8q3/iE=;
        b=SlQ9yXcPGWcqpNgsvUA5elpHwLWom+AQYZiYOdSgGaRs4scyCqq6tE/AKEJ5uZ5b81
         lF/hyH+57tlZdv2coRV+X45arqUqjkR0aAKl7EvCtUTrgZP+Uzms/5sBiY3pTURzH+NC
         6Jq2WJzC83rdSI2D2P+t4I2rC91XAWEmdYYGuaTMprvtZR9RngYuSZDfDBvCIalkaajC
         YNIP91xlct/SLzjaBBdRAp3jZjyj7Tb1pv7IN8kaOASxqS7Gh8Z/TBedIdlo1Q/pY6JQ
         cWKq1j2A4i2DOxMN3dAlM7OXOublT36ylMrsTYwjHxLJk5ZpCUi0cAvL165vdMl/2bDy
         oXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pQ2zj7Jlr1PXAZIscOwv68xrKkz77uBgfi3u8q3/iE=;
        b=as6MxB/QF6WvjFULLPNWPwO65h5pABAI3TQ1d5evxILsdsroQ8XCzOljycV30NJm7E
         GirK0VEc6OFq9XK+vCDV05z8ijQgP6leU4eN0f8wVVvjunNHVfFXx6CgXAbal91omaNu
         3KjJg6v+Wp3R9hlQTHNg/BWzF6dbwNR31+uqphYlN4AVuv1TQVoEn5p0oglryVUhQiSO
         0Q+a1B1IRdYoeTi70EwidLY22q/ji2okrCN1IO9PBs8/Ll6xZWEe30Squg7clOwuPPll
         ODqdDd8V6cf+jOFVj3Vc4D++OB8nAg4l+L5mo6TJHsDqgcaXWIN0L1HgO3ptkVxp2qsn
         D3cw==
X-Gm-Message-State: AOAM533twfW/x18jpdfTINCBbgZSuoAZM1zQu8t9hmo/JMG/4LL5C9Co
        GIdkuOJ0DKnDoxHnP7wPYCDWSoLYK+e/La/Ncj3Bkg==
X-Google-Smtp-Source: ABdhPJzMCPjAh/2kqnjwOxyzOIsWkWSrhvfMsYkNgJM3IRKRm7eO5+zvHPlxtMjOwCYAaHDaqSWr4Tkcrzo6Lbmbiss=
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr2853956pjb.229.1605766680507;
 Wed, 18 Nov 2020 22:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-6-songmuchun@bytedance.com> <20201117150604.GA15679@linux>
In-Reply-To: <20201117150604.GA15679@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 19 Nov 2020 14:17:21 +0800
Message-ID: <CAMZfGtW=Oyaoooow9_i+R1LkvGpcFoUjBxYzGqBZsOa-t-sFsg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
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

On Tue, Nov 17, 2020 at 11:06 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Fri, Nov 13, 2020 at 06:59:36PM +0800, Muchun Song wrote:
> > +#define page_huge_pte(page)          ((page)->pmd_huge_pte)
>
> Seems you do not need this one anymore.
>
> > +void vmemmap_pgtable_free(struct page *page)
> > +{
> > +     struct page *pte_page, *t_page;
> > +
> > +     list_for_each_entry_safe(pte_page, t_page, &page->lru, lru) {
> > +             list_del(&pte_page->lru);
> > +             pte_free_kernel(&init_mm, page_to_virt(pte_page));
> > +     }
> > +}
> > +
> > +int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> > +{
> > +     unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> > +
> > +     /* Store preallocated pages on huge page lru list */
> > +     INIT_LIST_HEAD(&page->lru);
> > +
> > +     while (nr--) {
> > +             pte_t *pte_p;
> > +
> > +             pte_p = pte_alloc_one_kernel(&init_mm);
> > +             if (!pte_p)
> > +                     goto out;
> > +             list_add(&virt_to_page(pte_p)->lru, &page->lru);
> > +     }
>
> Definetely this looks better and easier to handle.
> Btw, did you explore Matthew's hint about instead of allocating a new page,
> using one of the ones you are going to free to store the ptes?
> I am not sure whether it is feasible at all though.

Hi Oscar and Matthew,

I have started an investigation about this. Finally, I think that it
may not be feasible. If we use a vmemmap page frame as a
page table when we split the PMD table firstly, in this stage,
we need to set 512 pte entry to the vmemmap page frame. If
someone reads the tail struct page struct of the HugeTLB,
it can get the arbitrary value (I am not sure it actually exists,
maybe the memory compaction module can do this). So on
the safe side, I think that allocating a new page is a good
choice.

Thanks.

>
>
> > --- a/mm/hugetlb_vmemmap.h
> > +++ b/mm/hugetlb_vmemmap.h
> > @@ -9,12 +9,24 @@
> >  #ifndef _LINUX_HUGETLB_VMEMMAP_H
> >  #define _LINUX_HUGETLB_VMEMMAP_H
> >  #include <linux/hugetlb.h>
> > +#include <linux/mm.h>
>
> why do we need this here?
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
