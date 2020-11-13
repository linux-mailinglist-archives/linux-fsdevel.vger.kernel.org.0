Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC62B1515
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 05:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgKMETD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 23:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgKMETC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:19:02 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050AC0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 20:18:44 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so6073796pgk.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 20:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoQQYCm0CUI1d3dFcipn72mQMnKWNV7T/6zPt9SRkDM=;
        b=JhMbe0h76w8OnmRD67vqzsLImyr/I+HBgst0M3grAdYQtypY39XAU7r1pxUDVxoHup
         rNbWOcyhrPRBREEmks6mN/NkjP8fGXt64xtL1zSbxhNmYBkvc/iz7LGKO2d4OrB16A/Q
         2qn1pHpPryKku+WNUODMpAhN8C3PfKnY7jkO4/tLK5VzHlSNgYhgaOJeDc4LeQ7Zr8Q2
         xCSLxo/B2vYAEi3ZROc0DOVNjxy3qRrAJN2WqRPmdSTcehQVwo+FxCTCGW1QV3aWpKEs
         9JQl1UaUYhs8kBwcs6Dc5i0BqtQ3ADo0627YIDhwYdM4COkTnxrnw2Ouog98fxLWS6D9
         Tsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoQQYCm0CUI1d3dFcipn72mQMnKWNV7T/6zPt9SRkDM=;
        b=MYyxGYXdw2eA8hrdseeYQa13idCdOj734eB7MPbF4LwE3hmSXOtdbzJXPwvCwCk9wC
         V7AD7KzZQ6lwszvFpbZTr1Smyckd3D+TmGqe30Pfbn37YPVjfXKW0yznPrecpsn6vcSv
         NNITrBn8a332R2pYwJFrFjZPHJ4qXgDMvoBAC3oYDjz8vuDW4qdry32xvA0GO3xKJrHQ
         ibgrTyVAjfcp5jIFGkjDb2xf4B8Fl7fp2po/XAuOhldnY0eZjXAiy5sHA6T6ZPfbvRIb
         3kfi9FC8MY3bqLwUkSw224BLTgwudBIBDyox8PHcxonvuKfEkUY2qiERT8dtkX6mjUnC
         Vfdg==
X-Gm-Message-State: AOAM531NpptOTXgCcn2meh+1sSx5gkfmlY5tErGVkCpFNRfmCynlia3l
        4ZvWQc4dICvh28IBPISLgXt7U9931fxTuynYLZR1aw==
X-Google-Smtp-Source: ABdhPJysNzFyG8GxRiZ3O2K/cMctulLuiEkBVF1gU2Xhkrh896y5T/IU+i9GQI8nyGwtxr5CK1N0HtfbnW7JNorvmB4=
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr709269pjb.229.1605241124066;
 Thu, 12 Nov 2020 20:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-6-songmuchun@bytedance.com> <9dc62874-379f-b126-94a7-5bd477529407@oracle.com>
 <CAMZfGtV+_vP66N1WagwNfxs4r3QGwnrYoR60yimwutTs=awXag@mail.gmail.com> <b7c16e3f-d906-1a11-dbd5-dc4199d70821@oracle.com>
In-Reply-To: <b7c16e3f-d906-1a11-dbd5-dc4199d70821@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 13 Nov 2020 12:18:07 +0800
Message-ID: <CAMZfGtUXus9gRsCbtV-+HmvWNY==oQxP+L3bzwmpTCZZ725Ynw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 8:38 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/10/20 7:41 PM, Muchun Song wrote:
> > On Wed, Nov 11, 2020 at 8:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 11/8/20 6:10 AM, Muchun Song wrote:
> >> I am reading the code incorrectly it does not appear page->lru (of the huge
> >> page) is being used for this purpose.  Is that correct?
> >>
> >> If it is correct, would using page->lru of the huge page make this code
> >> simpler?  I am just missing the reason why you are using
> >> page_huge_pte(page)->lru
> >
> > For 1GB HugeTLB pages, we should pre-allocate more than one page
> > table. So I use a linked list. The page_huge_pte(page) is the list head.
> > Because the page->lru shares storage with page->pmd_huge_pte.
>
> Sorry, but I do not understand the statement page->lru shares storage with
> page->pmd_huge_pte.  Are you saying they are both in head struct page of
> the huge page?
>
> Here is what I was suggesting.  If we just use page->lru for the list
> then vmemmap_pgtable_prealloc() could be coded like the following:
>
> static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> {
>         struct page *pte_page, *t_page;
>         unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
>
>         if (!nr)
>                 return 0;
>
>         /* Store preallocated pages on huge page lru list */
>         INIT_LIST_HEAD(&page->lru);
>
>         while (nr--) {
>                 pte_t *pte_p;
>
>                 pte_p = pte_alloc_one_kernel(&init_mm);
>                 if (!pte_p)
>                         goto out;
>                 list_add(&virt_to_page(pte_p)->lru, &page->lru);
>         }
>
>         return 0;
> out:
>         list_for_each_entry_safe(pte_page, t_page, &page->lru, lru)
>                 pte_free_kernel(&init_mm, page_to_virt(pte_page));
>         return -ENOMEM;
> }
>
> By doing this we could eliminate the routines,
> vmemmap_pgtable_init()
> vmemmap_pgtable_deposit()
> vmemmap_pgtable_withdraw()
> and simply use the list manipulation routines.

Now I know what you mean. Yeah, just use page->lru can make code
simply. Thanks for your suggestions.

>
> To me, that looks simpler than the proposed code in this patch.
> --
> Mike Kravetz



-- 
Yours,
Muchun
