Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC862ACB3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 03:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgKJCmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 21:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbgKJCmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:42:37 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B3C0613D4
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 18:42:37 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f18so4375902pgi.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 18:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hq04zVLRq/Oo2lQxylxZrXiKhYhzc6TfqjzZNoQvjuk=;
        b=ua6CPMSivTkkMuhvjWiNRV2yogS0EvNQ/UC0Pjr/Rn5HdVis2pUSXYfVeL9vf1oxGT
         hCNvfo5Pw164JaLBYdyTMn1I9vyMaw4CPDyGyAAQQEmu/3yS7Cl6BXwukr/Oa/jpVg9f
         xhB6NeRSUW88dI30uqJwvQecdGD9os2f37RZrOP4CyYParHPpPokLNqLROUP1qzRpHRW
         4Xz8hpE/LNMIS/HQqYUbDPSdHz1qHlN5p2bGS/YrOUZ6cg67gUs+3EKEhbwgT8oVzbU8
         ObNl0hMOtWmdMLMkZLRkQVtNMbVPLUqFFhotzABsvrZyXICxjp4vW8Sa6WBblNtpCDzE
         Y8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq04zVLRq/Oo2lQxylxZrXiKhYhzc6TfqjzZNoQvjuk=;
        b=J3ICakXhbafri6CaeSDGHJhNIAIY7GaM2aed3BTc+eZCistQmcf/HvRwCELuHnmAKF
         6wQKWEOn+WR9zgI8KwHzVnTi/SrHRCtBuQlmx92y4fQVnM8Y25lUnPSfS8ve/mDoC3u8
         WTeDRQ7V7W0/cIk4a6c9kYhB5sT3j4FgWlb6ikZiuLIMVYpGX8meZYBubXyo4fyL4FsP
         PFNGXPKVDwcVVqZPDPjs1CnAu557bHim/feZYVi7TIV8IIYvznA8W1u8Ei25ijmI0Aub
         97Z4lg8e7aDYFzWLISFxmOR3BEaHbjkDJFdRo3N2EeemvP4kn9bfV9tZYHPuIeMWoQuB
         kyCQ==
X-Gm-Message-State: AOAM533ZUvBw9KjirhNrXKbZol+GtDY+XqAQ1spLlVjcACVt0x0ttwk3
        bcY2fUjgngRoXXcD1Vu6nFryvGcmNOYnt90imMtNoA==
X-Google-Smtp-Source: ABdhPJyrTFLtNejVARR0imvWvzZUIFnztiWYySVLVHRuSDfEWqoJITi1D9tdjXQtR+JXPvE8VQ2dZhviAg5bSaDPVbg=
X-Received: by 2002:a17:90a:4749:: with SMTP id y9mr2531336pjg.229.1604976156656;
 Mon, 09 Nov 2020 18:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-5-songmuchun@bytedance.com> <20201109164825.GA17356@linux>
In-Reply-To: <20201109164825.GA17356@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 10:42:00 +0800
Message-ID: <CAMZfGtWxNV874j9io_xcsVm+C6_shrZCw=W9ugJzxrnBpXb_Mw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 04/21] mm/hugetlb: Introduce
 nr_free_vmemmap_pages in the struct hstate
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

On Tue, Nov 10, 2020 at 12:48 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Nov 08, 2020 at 10:10:56PM +0800, Muchun Song wrote:
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +/*
> > + * There are 512 struct page structs(8 pages) associated with each 2MB
> > + * hugetlb page. For tail pages, the value of compound_dtor is the same.
> I gess you meant "For tail pages, the value of compound_head ...", right?

Yeah, Thanks.

>
> > + * So we can reuse first page of tail page structs. We map the virtual
> > + * addresses of the remaining 6 pages of tail page structs to the first
> > + * tail page struct, and then free these 6 pages. Therefore, we need to
> > + * reserve at least 2 pages as vmemmap areas.
> > + */
> > +#define RESERVE_VMEMMAP_NR   2U
> > +
> > +static void __init hugetlb_vmemmap_init(struct hstate *h)
> > +{
> > +     unsigned int order = huge_page_order(h);
> > +     unsigned int vmemmap_pages;
> > +
> > +     vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
> > +     /*
> > +      * The head page and the first tail page not free to buddy system,
>
> "The head page and the first tail page are not to be freed to..." better?

Yeah, sorry for my poor English :).

>
>
> > +      * the others page will map to the first tail page. So there are
> > +      * (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
>                                                       ^^^
>                                                       that
>
> > +     else
> > +             h->nr_free_vmemmap_pages = 0;
>
> I would specify that this is not expected to happen.
> (At least I could not come up with a real scenario unless the system is
> corrupted)
> So, I would drop a brief comment pointing out that it is only a safety
> net.

I will add a comment to point out this.

>
>
> Unrelated to this patch but related in general, I am not sure about Mike but
> would it be cleaner to move all the vmemmap functions to hugetlb_vmemmap.c?
> hugetlb code is quite tricky, so I am not sure about stuffing more code
> in there.
>

I also think that you are right, moving all the vmemmap functions to
hugetlb_vmemmap.c may make the code cleaner.

Hi Mike, what's your opinion?

Thanks.

> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
