Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4882AD408
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 11:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJKrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 05:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJKrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:47:45 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B3C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 02:47:45 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so9789152pgg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 02:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Toc/1e3XZP6E3Q/GS14/EKWrJmH5Dil0O7B9AgVB8fQ=;
        b=xIqtmtgc4HMmDQO5cYNvT9oenNFNyBm4de07RNrCAmKL8NA+vkKWnUbTECqmYwJPbj
         /5FguZIa4jebLRz+my6Vov85DE2kLM8TIvUACojHoUCrNs636FkjcUejZtgkY2NxCcxN
         zC2RNDRLhy6ZAsouPM4Pq7Fk4HBxloDh1pkE/9uKEj6B6O/6if/W77dKY+mqAaffupRk
         M+lqp3qgD2QoMasQUEhfk/x2Hw7Qk+i2eKwrYFP+FEIetLn5CyGbAsM3+fxQPmEYKz/n
         qtUCNwd1JruN3PvyiKRJ9dJD89ldVlGc7dFWOvJd1GBJsyNJ5e5Si1fkw3+s3A0Ncm9G
         jqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Toc/1e3XZP6E3Q/GS14/EKWrJmH5Dil0O7B9AgVB8fQ=;
        b=G4Plbm5V/hRRu/kwQaszz3rxiGG2jF+uAiSbNb6fuUTl3YRkKCZ8SZGcyGfNou9Chq
         3tfy1YOAjxElOvYBJp+rJCnRGugkE4lhE7NNwBnBvLp+dF2XI/iBWUSnZXwQdq3D6wfC
         10s1PgGmosxIVG9B8OYx8jDeTffAX0MQm7eDJUBrI6eEjjM6x91keydyKJkKra8hRZOr
         MNeV+SOklubI/Ec/2no8g9ZFGhhKtcm3z/uLEQPhFlorcCyBCu0jWsTYO8XMr+jQpLVt
         Sk0IfP5ZUAqvcGKlQ1CqZK26MS/bPrKOhVrf/Wc6nZjdbdQgWCuAZKzhkkZJhq77EGvd
         Q2cg==
X-Gm-Message-State: AOAM532EQto9LvW1AKgkd8iWDXGCtWyKv7dhW4Q03Skh3j1hh/Ubtsr8
        V+2tszgS8NKKVUGKgSjUbiMaknFCERmOJSHdGhroFg==
X-Google-Smtp-Source: ABdhPJx9kEy0Q3xDZ+PnVrlGbMTy6IdowDw+7yOHeSag6XbBXToDQ8IysFZVAeKrB0UhrKWsZW0NnmBu0qOPbrRJtN8=
X-Received: by 2002:a63:7408:: with SMTP id p8mr16100765pgc.273.1605005264696;
 Tue, 10 Nov 2020 02:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-10-songmuchun@bytedance.com> <20201109185138.GD17356@linux>
 <CAMZfGtXpXoQ+zVi2Us__7ghSu_3U7+T3tx-EL+zfa=1Obn=55g@mail.gmail.com> <20201110094830.GA25373@linux>
In-Reply-To: <20201110094830.GA25373@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 18:47:08 +0800
Message-ID: <CAMZfGtW0nwhdgwUwwq5SXgEAk3+6cyDfM5n28UerVuAxatwj4g@mail.gmail.com>
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

On Tue, Nov 10, 2020 at 5:48 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Nov 10, 2020 at 02:40:54PM +0800, Muchun Song wrote:
> > Only the first HugeTLB page should split the PMD to PTE. The other 63
> > HugeTLB pages
> > do not need to split. Here I want to make sure we are the first.
>
> I think terminology is loosing me here.
>
> Say you allocate a 2MB HugeTLB page at ffffea0004100000.
>
> The vmemmap range that the represents this is ffffea0004000000 - ffffea0004200000.
> That is a 2MB chunk PMD-mapped.
> So, in order to free some of those vmemmap pages, we need to break down
> that area, remapping it to PTE-based.
> I know what you mean, but we are not really splitting hugetlg pages, but
> the memmap range they are represented with.

Yeah, you are right. We are splitting the vmemmap instead of hugetlb.
Sorry for the confusion.

>
> About:
>
> "Only the first HugeTLB page should split the PMD to PTE. The other 63
> HugeTLB pages
> do not need to split. Here I want to make sure we are the first."
>
> That only refers to gigantic pages, right?

Yeah, now it only refers to gigantic pages. Originally, I also wanted to merge
vmemmap PTE to PMD for normal 2MB HugeTLB pages. So I introduced
those macros(e.g. freed_vmemmap_hpage). For 2MB HugeTLB pages, I
haven't found an elegant solution. Hopefully, when you or someone have
read all of the patch series, we can come up with an elegant solution to
merge PTE.

Thanks.

>
> > > > +static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > +{
> > > > +     pmd_t *pmd;
> > > > +     spinlock_t *ptl;
> > > > +     LIST_HEAD(free_pages);
> > > > +
> > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > +             return;
> > > > +
> > > > +     pmd = vmemmap_to_pmd(head);
> > > > +     ptl = vmemmap_pmd_lock(pmd);
> > > > +     if (vmemmap_pmd_huge(pmd)) {
> > > > +             VM_BUG_ON(!pgtable_pages_to_prealloc_per_hpage(h));
> > >
> > > I think that checking for free_vmemmap_pages_per_hpage is enough.
> > > In the end, pgtable_pages_to_prealloc_per_hpage uses free_vmemmap_pages_per_hpage.
> >
> > The free_vmemmap_pages_per_hpage is not enough. See the comments above.
>
> My comment was about the VM_BUG_ON.

Sorry, yeah, we can drop it. Thanks.

>
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
