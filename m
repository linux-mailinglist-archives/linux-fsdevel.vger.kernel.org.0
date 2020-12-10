Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3212D5A94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 13:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgLJMdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 07:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLJMdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:33:23 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED2C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 04:32:43 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so4067654pgi.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 04:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2j9oJVLdw2ETVRjvlsUKZFYNsqLIEckkbStxyUbG4c=;
        b=Cf6GkzyVICZ2r+cphcXwh9MH72pN7NwUnmwu484SPDfOCSkIX7b16iRZS+XGbb0J9V
         ogHDXhnYLhGBT0lXSBZjMp/7JnxpPxncVqbvvGDSe2Yt7XZPb2/XdTar+rZ9E2dmC9gS
         fQH4+CLKK5F3vRAi+ixzmAIpBewwZZwKxPJom1P5o15wG7DUVUire3Az2R1rppKXtouM
         GO8fBMD+6tkECDO2+6w4HSxn705fER+7axAKl50N1I9U/c55lRj8rxuNS49h74n9EQiK
         KSQGY4SiMnuQb5zYN2yW3RKKa8RykPQTPPDWNy/ULPShCy1tFlsEejugZK4buXEFHUjh
         PReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2j9oJVLdw2ETVRjvlsUKZFYNsqLIEckkbStxyUbG4c=;
        b=rb7mq+ytd02L+BMBffdOecmLcEjzJdmvYfnDitYGOOYwi9VIpc8GUyR4HSJODnl6yf
         Fzd8Cd2nCE/9n0LD+8GAGLCH2IBLi4a5vveiGQbSf3EOXCyxFOYRsUna3TO3CPy8Dlci
         69FeYkjMiGGkZwnekdpn1EhMdGMCPGurIU8hEhFHneBbjSDfG9/30R9P5ydbO/Cdxt4c
         j0vP2rcnROQcqikWUKQaiIb2WUmsea8+wtXbi+ElphDVdGA7w+Ru4wYP8hvd3iT6vrQu
         49OddOoGygGrzNbjjtVMlfi3mM3wiuQ7xh7LN3nWtCUNY2p9LrAu/jVQqAsv5Lp9XNJa
         6RoA==
X-Gm-Message-State: AOAM530GsT5/ZYSqUT+G8Vs4qaJe1hdWPm6tstX6jLAT+6EprgxQ3z60
        ZOJ99jZl1Bm8rjSmBfL0Mk2B3Vrw4X/vTnboleSV6Q==
X-Google-Smtp-Source: ABdhPJzruP2FzeZRwPR6zyDb+MGWrPcKVuHVSHRiDqmTukJKyZeQtXXgwD7GQB8j4xgwJLtaqxztDYOUwhGdTqMth70=
X-Received: by 2002:aa7:8105:0:b029:18e:c8d9:2c24 with SMTP id
 b5-20020aa781050000b029018ec8d92c24mr6569040pfi.49.1607603562910; Thu, 10 Dec
 2020 04:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-11-songmuchun@bytedance.com> <20201210101526.GA4525@localhost.localdomain>
In-Reply-To: <20201210101526.GA4525@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 20:32:06 +0800
Message-ID: <CAMZfGtWEE3rCBxXVb9bE_siByOuii19NVq1-Y2+EKe0-OSb2vg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 10/12] mm/hugetlb: Introduce
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

On Thu, Dec 10, 2020 at 7:40 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 11:55:24AM +0800, Muchun Song wrote:
> > +void __init hugetlb_vmemmap_init(struct hstate *h)
> > +{
> > +     unsigned int nr_pages = pages_per_huge_page(h);
> > +     unsigned int vmemmap_pages;
> > +
> > +     /* We cannot optimize if a "struct page" crosses page boundaries. */
> > +     if (!is_power_of_2(sizeof(struct page)))
> > +             return;
> > +
> > +     if (!hugetlb_free_vmemmap_enabled)
> > +             return;
>
> I think it would make sense to squash the last patch and this one.
> As per the last patch, if "struct page" is not power of 2,
> early_hugetlb_free_vmemmap_param() does not set
> hugetlb_free_vmemmap_enabled, so the "!is_power_of_2" check from above
> would become useless here.
> We know that in order for hugetlb_free_vmemmap_enabled to become true,
> the is_power_of_2 must have succeed early on when calling the early_
> function.

Yeah, you are right. But if is_power_of_2 returns false. The compiler
can optimize this function to null. If we remove the check, it prevents
the compiler from optimizing the code of hugetlb_vmemmap_init().
So I think leaving it here makes sense. Right?

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
