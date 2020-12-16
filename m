Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB112DC1B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 14:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLPN6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 08:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPN6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:58:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3014C0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 05:57:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s21so16627223pfu.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 05:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NFYln1tQq7qRd53FFec7AJR736UPrWCWegNdBpKreM=;
        b=h3itCcTAanIF02P8vHFCLTU7a+J8XQTdKKylTJSMbH4TlDhD8tvSXYLMx83aIV/gP1
         GWlqP0rvuhNzRIchF1C7iCNIGioJFOboQPbV0CSxNE1iUav1kWAAaM7xxROFEfpOuguU
         Gn/EQecbr9eUQfaWVvxyVHGUyzBvGuJTg6r1/smVgh3aEbpOLG7Imbzp/CUDubL92Qll
         0O72vzma8nznU7W1+rVOpzo5Npi+Fj7z6EZpDPCDHtTsFCJxNktc5MWvXUtn70il/iHh
         XQ2ZSAG/7Sh2jWE6RfJp3W+JPbJLklo/172lKkxasBMOHXLEee2UKQt8wIDkg2Fo2k8A
         0fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NFYln1tQq7qRd53FFec7AJR736UPrWCWegNdBpKreM=;
        b=TrpeYL1x5mDq7qXtYzEzRpXSFjwRAbq9LPPe2n8ixOQ4LgGO9qYWVFQeYWb2pVIMRC
         PTaZ8L9kn/cuTId+Z2uZAhmaKVfN5f4hRk+SKSpfuHX/FjEzda8UPfmihu6LvECEN2RO
         X8hkDPbQtjlxpj1LodwTOyI42EpvuqWwkIn5ff/LhCdfXSBVIBxFVm10bWei0gUsejgD
         pC/Zd7mqe71BvOZpx9nv7UHpLrbcKbh/nE6agESGfKnk8GZutLK3gnS62yHN/EF0gFtU
         J2Xq8RvEgPFAtyk7krwulp00Y0JKJUBpDbtYorkz8LKkK80HGufNKGZzSl+z5LbYcd8n
         AHbQ==
X-Gm-Message-State: AOAM531clfwMmedztcBHOCLjiBZzUft1xssIz3OxuuCo1cxvXCKaJOi0
        v0Z12Xd9tribhgE6cFIhOnIXWWp3oNxSHHBRX984/A==
X-Google-Smtp-Source: ABdhPJzrI2SmuZDGD4lFuVbK3J5ap+2Z3rXF7FUlRnyx4P+kAVGPOBalOHu8fTh7tWhC5GwG9+DhfeSUOzynzWLTE4w=
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id
 b1-20020aa787010000b029019e0561d476mr1724030pfo.2.1608127043137; Wed, 16 Dec
 2020 05:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-10-songmuchun@bytedance.com> <20201216134354.GD29394@linux>
In-Reply-To: <20201216134354.GD29394@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Dec 2020 21:56:47 +0800
Message-ID: <CAMZfGtV2bYKPhyeR_pbckA6svs3qWpzmnhoeYkn=U1hw4Nwatg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 09/11] mm/hugetlb: Introduce
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

On Wed, Dec 16, 2020 at 9:44 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Dec 13, 2020 at 11:45:32PM +0800, Muchun Song wrote:
> > All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
> > field in the hstate to indicate how many vmemmap pages associated with
> > a HugeTLB page that we can free to buddy allocator. And initialize it
> "can be freed to buddy allocator"
>
> > in the hugetlb_vmemmap_init(). This patch is actual enablement of the
> > feature.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> With below nits addressed you can add:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>
> >  static int __init early_hugetlb_free_vmemmap_param(char *buf)
> >  {
> > +     /* We cannot optimize if a "struct page" crosses page boundaries. */
> > +     if (!is_power_of_2(sizeof(struct page)))
> > +             return 0;
> > +
>
> I wonder if we should report a warning in case someone wants to enable this
> feature and stuct page size it not power of 2.
> In case someone wonders why it does not work for him/her.
>
> > +void __init hugetlb_vmemmap_init(struct hstate *h)
> > +{
> > +     unsigned int nr_pages = pages_per_huge_page(h);
> > +     unsigned int vmemmap_pages;
> > +
> > +     if (!hugetlb_free_vmemmap_enabled)
> > +             return;
> > +
> > +     vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
> > +     /*
> > +      * The head page and the first tail page are not to be freed to buddy
> > +      * system, the others page will map to the first tail page. So there
> > +      * are the remaining pages that can be freed.
> "the other pages will map to the first tail page, so they can be freed."
> > +      *
> > +      * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
> > +      * on some architectures (e.g. aarch64). See Documentation/arm64/
> > +      * hugetlbpage.rst for more details.
> > +      */
> > +     if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
> > +             h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> > +
> > +     pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
> > +             h->name);
>
> Maybe specify this is hugetlb code:
>
> pr_info("%s: blabla", __func__, ...)
> or
> pr_info("hugetlb: blalala", ...);
>
> although I am not sure whether we need that at all, or maybe just use
> pr_debug().

The pr_info can tell the user whether the feature is enabled. From this
point of view, it makes sense. Right?

Thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
