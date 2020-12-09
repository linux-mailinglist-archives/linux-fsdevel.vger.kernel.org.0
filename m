Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5E2D3F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgLIKEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgLIKEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:04:20 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609AC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 02:03:39 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id j13so634354pjz.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 02:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4gIWYaJaNZduh4JA7eIlOxCXtQORUEEZY9m5DkEeWg=;
        b=l9npCqtiWi6nm8WXc9Qci3HNqajeaFHfw3ao8fKDtkmuOfyiKaVSaitH/E/JRbjrv4
         0n8xsbdnhhNokdQjHGXGu0H2xPThEITAaW8TfUEeSBwjn/7s4evUip6C2wAgVLLtQOFg
         L9v1HvMHHIK16p7/ePp2Zmv8Uc6RmNXdkslycCkxclPEBFF2DESf8spil2nEvkQ+FLBZ
         tNGk8NMaxD/LOlx381vwi9mrf07041UpOHZFzOY82UlsVLDMJGGjJNoOkZ9Do1Asz4qp
         r/h0GnWLRyTMvuaqqWZtPFKTZB++54sOygrU2zP6ESM4PVaCFZOuk+DFxp65rH7FZXSL
         AvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4gIWYaJaNZduh4JA7eIlOxCXtQORUEEZY9m5DkEeWg=;
        b=fAQnkfxTi2UL2Z+H1u8Z4m5gYL6N9gArCbSl0W25KNiY2rzDjkPnFsjtN8OkADmgRq
         Y1GXM/j0DVpjfwDahwUNh6hO1doEiAYYch93xmvIjjlgzeBET1egNLCE8NzEYNuXazoY
         eWmH0GmTnUF5o/7tNDELscaWzuyFsnT6DuuJqBPx+dYhG0i5ikW9/fagnBA/Q17EZSbw
         +VLaTiw45/mLoeZTX4/TgIHdKmoTLON2PyM0anGza/sRucuNCHQFSiePHojMGHnha2DR
         NsodrkBGtp1V02feqOnoPhdvzAGYVtaMicbR4pWwS1z5/UupgDf8e2IgzmMtYtvb0MG+
         XpBQ==
X-Gm-Message-State: AOAM532hb3LC3eXyLquMI8IWBmqLzLIwAfECQ6XTF53GhVa0IRIMhXzp
        Nac/aFlL53YMIxrlvgaYYZKJRYI/AirxXiybZ6QPSw==
X-Google-Smtp-Source: ABdhPJwLeHxukD6MEvUiceVVZUfrPocdn+tRQUO6LQUONC5Tz16TBKz/PD0oEJKhT4wgjGrX/3qsMLMUQcocS3f1/hc=
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id
 j8-20020a17090276c8b02900d9d6c3357dmr1336707plt.34.1607508219309; Wed, 09 Dec
 2020 02:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-7-songmuchun@bytedance.com> <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
In-Reply-To: <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 18:03:02 +0800
Message-ID: <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 06/15] mm/hugetlb: Disable freeing
 vmemmap if struct page size is not power of two
To:     David Hildenbrand <david@redhat.com>
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
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 5:57 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.11.20 16:18, Muchun Song wrote:
> > We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
> > when the size of struct page is a power of two.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb_vmemmap.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 51152e258f39..ad8fc61ea273 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >       unsigned int nr_pages = pages_per_huge_page(h);
> >       unsigned int vmemmap_pages;
> >
> > +     if (!is_power_of_2(sizeof(struct page))) {
> > +             pr_info("disable freeing vmemmap pages for %s\n", h->name);
>
> I'd just drop that pr_info(). Users are able to observe that it's
> working (below), so they are able to identify that it's not working as well.

The below is just a pr_debug. Do you suggest converting it to pr_info?

>
> > +             return;
> > +     }
> > +
> >       vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
> >       /*
> >        * The head page and the first tail page are not to be freed to buddy
> >
>
> Please squash this patch into the enabling patch and add a comment
> instead, like
>
> /* We cannot optimize if a "struct page" crosses page boundaries. */
>

Will do. Thanks.

> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
