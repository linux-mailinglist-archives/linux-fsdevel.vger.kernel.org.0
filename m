Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9E2D5A85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 13:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgLJM1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 07:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgLJM1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:27:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF54EC0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 04:27:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 11so3916474pfu.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 04:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRVH576RjUF7Hfh+GmVFJTHPtJJABCzK9jSLmoXeohM=;
        b=QGxx2uqjkZLjwdyE5TglOBgNyR7M/o3toVg0IHWs2Un4c798mQiWRI/NN0FMfX4/gg
         IJReYIcQ31zi26/7+syJfTE6ThijeQoZdGNcny52VUzZtPbGKiXISDRo3Ykuyf2ppOn8
         6xYGIrmC+9Q1+oERfykes5HcLNdSI3l772nN6zLhVPDRCvVXv+9i/BeTzF7zR8vb/AxC
         3JWAgmGWuNDJOT2d9hhfHKdfTBavQFlpTjzcV7qzNH3EgJ3QwGhm2wP6aFE5+PPqnnT+
         72IUhDliIa3zPo0K+5frDNU0xN5UolLIcgRimNQAVabHNmXiViBJ8dfiLQjFNntlUYSC
         08oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRVH576RjUF7Hfh+GmVFJTHPtJJABCzK9jSLmoXeohM=;
        b=Us5++UJo7FXfcXrE8Rod8VLEPaJ+zjugErrECyfXjGWBDMNhGmy5P75UAL5f34oExA
         H+RolyEgke1vEEMXl0Dyo+ewUa3fvDBff9ZzuUs4J9KdZsLmfer/mP/NOJnZ5D5wTSoA
         EPs2E7aH9nWS3Fo9JxzhCcuIpsVLMRuMQ6UEt+aj58GbVmpItMgKw9QI7EdCBChkVUEy
         Qdnc+kc0zm4UKaCeMP5JEXseo2oxN2gyENzQ/b2soJ0KS8w/TVJkyZnNatzeQG+BXvcv
         j59uBlN/s3wZ0RKsp3Oix5mCi05BRW2K3wy64l1RUwOauMC0ejH9Itnl5Ay4h1jPlpaz
         bSYg==
X-Gm-Message-State: AOAM530BSQH2oytH6NCENhvQbjAJtxPjI80fYvtj2Bj9o4SLXUdibUDI
        gxwbUhwkjyMQk7G+LJgmCy1v2xVyi7JjBJMN71EH1Q==
X-Google-Smtp-Source: ABdhPJzJSSCikK3jOM3ONA3u/M/J74mq1J/fc+RbtNlN/9xfSaOqDZ4guFg9UoAE15TqPlyox8rej6pMBOvdcG5TA5k=
X-Received: by 2002:a63:1203:: with SMTP id h3mr6352071pgl.273.1607603225499;
 Thu, 10 Dec 2020 04:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-10-songmuchun@bytedance.com> <20201210100454.GB3613@localhost.localdomain>
In-Reply-To: <20201210100454.GB3613@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 20:26:28 +0800
Message-ID: <CAMZfGtVks41ZXaUgPdLyNqVCRYTvSm5qAN9GM5e0vqJ9YV7NdA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 09/12] mm/hugetlb: Add a kernel
 parameter hugetlb_free_vmemmap
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

On Thu, Dec 10, 2020 at 7:41 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 11:55:23AM +0800, Muchun Song wrote:
> > +hugetlb_free_vmemmap
> > +     When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
> > +     unused vmemmap pages associated each HugeTLB page.
>                                       ^^^ with

Thanks.

>
> > -     if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> > +     if (is_hugetlb_free_vmemmap_enabled())
> > +             err = vmemmap_populate_basepages(start, end, node, NULL);
> > +     else if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> >               err = vmemmap_populate_basepages(start, end, node, NULL);
>
> Not sure if joining those in an OR makes se.se

Well, I can do it.

>
> >       else if (boot_cpu_has(X86_FEATURE_PSE))
> >               err = vmemmap_populate_hugepages(start, end, node, altmap);
> > @@ -1610,7 +1613,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
> >               }
> >               get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
> >
> > -             if (!boot_cpu_has(X86_FEATURE_PSE)) {
> > +             if (!boot_cpu_has(X86_FEATURE_PSE) ||
> > +                 is_hugetlb_free_vmemmap_enabled()) {
>
> I would add a variable at the beginning called "basepages_populated"
> that holds the result of those two conditions.
> I am not sure if it slightly improves the code as the conditions do
> not need to be rechecked, but the readibility a bit.

Agree. The condition does not need to be rechecked.
Will  do in the next version. Thanks.

>
> > +bool hugetlb_free_vmemmap_enabled;
> > +
> > +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     /* We cannot optimize if a "struct page" crosses page boundaries. */
>
> I think this comment belongs to the last patch.
>

Thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
