Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971312ACC16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgKJDuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbgKJDuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:50:04 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCBCC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:50:04 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so8997645pgl.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 19:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdSQFTCy7+/L4zU3ZF97r7YPRToNp4hA6tkIQzGJXC4=;
        b=WMhIYZjfgSz9EDKlHqkGyz5ZV3GJkxZM0EZDQpoCRpa/mt4FNfFVW3mWAbbQMR6ZAw
         DWUREB0rbwDM0KiLX/mk0a9c9EM6+OxWr7O60vMAwXWt5+ynoAbLx+15YIYnedvgQ5Ts
         eE5+GDhqy0f5IowDQ89RXMn8D04xZEqRLnz3EBHZrWdHeWuhOVIFDL4MRfrFPoRwpxtC
         IuKtCgye1t2z4hJZgWhl/bwhtbar9DHYCqe1V5qxtQuJD3ie02wcW1qHiNJO6HML+lF9
         dDm4LaRgiLYDsXDgWi1nlr++78hDvp1HLDxN5hhteB7YbiYTLTO+Yc2C5NmegLqhz4fS
         J+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdSQFTCy7+/L4zU3ZF97r7YPRToNp4hA6tkIQzGJXC4=;
        b=lWXNwf+sFw4llS2Ujm2+KBsIlrCepsblS6jaLadyRCt2wlvYhjE0wD+1Srg7RFnjBN
         6CpWNiPFlQLcZIdgoX7LqE3A6bcHdWbhwhWT2uiadW7Cg5EEgu3CQ/iG80zxwoEfX1iK
         b0iychWK/ZieB6DtL2qYihiqwSuEm251C1PZM8oezFLqFMkZN382Ylo72Skejko1UplM
         LOuMWj5qJVeMmc4ZT+H7LPEosM32yRtVyxykxk4vcNOJg4wScZ0LYsF+3VI60Han+/zt
         wkngtL0Ekw/RaEyqReOgDF8HqWe52PT5/Pf6FNBFhLvy1vqaqfiB9WP62/kmG1zs0wDi
         t6RQ==
X-Gm-Message-State: AOAM531BqfxJS8m8bWmc8mYAmsmL59ADU2wu7RhfxDHb59MJNUTbgJ0b
        0P5nwf82iZ461Mkh0tGXem2TnL7r94BFpQ6JHHPbRw==
X-Google-Smtp-Source: ABdhPJxY3cmAN4MQVkEwrkoDndbn+RE6xEypaDMyAAT/Ov5wENT8YyEsfl1X4Gz4eLu7JEuIJjkGpp2htO2uZlxHZAM=
X-Received: by 2002:a63:5804:: with SMTP id m4mr15125994pgb.31.1604980203620;
 Mon, 09 Nov 2020 19:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-6-songmuchun@bytedance.com> <20201109172144.GB17356@linux>
In-Reply-To: <20201109172144.GB17356@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 11:49:27 +0800
Message-ID: <CAMZfGtVm9buFPscDVn5F5nUE=Yq+y4NoL0ci74=hUyjaLAPQQg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable
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

On Tue, Nov 10, 2020 at 1:21 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Nov 08, 2020 at 10:10:57PM +0800, Muchun Song wrote:
> > +static inline unsigned int pgtable_pages_to_prealloc_per_hpage(struct hstate *h)
> > +{
> > +     unsigned long vmemmap_size = vmemmap_pages_size_per_hpage(h);
> > +
> > +     /*
> > +      * No need pre-allocate page tabels when there is no vmemmap pages
> > +      * to free.
>  s /tabels/tables/

Thanks.

>
> > +static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> > +{
> > +     int i;
> > +     pgtable_t pgtable;
> > +     unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> > +
> > +     if (!nr)
> > +             return 0;
> > +
> > +     vmemmap_pgtable_init(page);
> > +
> > +     for (i = 0; i < nr; i++) {
> > +             pte_t *pte_p;
> > +
> > +             pte_p = pte_alloc_one_kernel(&init_mm);
> > +             if (!pte_p)
> > +                     goto out;
> > +             vmemmap_pgtable_deposit(page, virt_to_page(pte_p));
> > +     }
> > +
> > +     return 0;
> > +out:
> > +     while (i-- && (pgtable = vmemmap_pgtable_withdraw(page)))
> > +             pte_free_kernel(&init_mm, page_to_virt(pgtable));
>
>         would not be enough to:
>
>         while (pgtable = vmemmap_pgtable_withdrag(page))
>                 pte_free_kernel(&init_mm, page_to_virt(pgtable));

The vmemmap_pgtable_withdraw can not return NULL. So we can not
drop the "i--".

>
> > +     return -ENOMEM;
> > +}
> > +
> > +static void vmemmap_pgtable_free(struct hstate *h, struct page *page)
> > +{
> > +     pgtable_t pgtable;
> > +     unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> > +
> > +     if (!nr)
> > +             return;
>
> We can get rid of "nr" and its check and keep only the check below, right?

Great, the check can go away.

> AFAICS, they go together, e.g: if page_huge_pte does not return null,
> it means that we preallocated a pagetable, and viceversa.
>
>
> > +
> > +     pgtable = page_huge_pte(page);
> > +     if (!pgtable)
> > +             return;
> > +
> > +     while (nr-- && (pgtable = vmemmap_pgtable_withdraw(page)))
> > +             pte_free_kernel(&init_mm, page_to_virt(pgtable));
>
>         Same as above, that "nr" can go?

Here "nr" can not go. Because the vmemmap_pgtable_withdraw can
not return NULL.

Thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
