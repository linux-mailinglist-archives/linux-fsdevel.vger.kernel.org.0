Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A610529ED43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 14:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgJ2Nmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 09:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgJ2Nmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:42:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72481C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 06:42:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w1so2835096wrm.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sP4gGJw9r+NchdLRSOmNItoBGxNPh2amTUBIn7g1jk=;
        b=u91kGQbepRwV6CBnVlOo0b3Ay7d1EQjInWPDaaj4wkoOWUdXCTegxWaE3ozKnEknUB
         +eYQOPliDFDGe80DJ/8LITnX6yLVfq8u7VFgkdgLmvf80pGeEyBiRuILrAkce9CwKmMP
         ZSY6JlkFzTNHrTvnmYu/d643GMWgnWY7jCLoUDvXYUapiXviuOdxZR81vsfu5y57B6Z0
         8UkMQ/wNdD/r963I3Kh+77LgbrWItHBm+eBdbeFb6184nZ8LBMH/92yDE7rli3UzGcCz
         zx8zJLy44lTPIJ465U32VxI9n9tPWlXzfTJBOB8Bxsq9UAgyvcuWLj6du6M2jyOr8FLD
         36uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sP4gGJw9r+NchdLRSOmNItoBGxNPh2amTUBIn7g1jk=;
        b=EGxYRY8JYOpOY1a8/XCH65DjLyRhp/VF0Aek93HKFHYEeZRJDQkrTOLhjUKSdpdb9y
         0ZgJitSvKzGVG6HVm9Dd18kAxjIAlxCAgGmKrePHVIp+JT9vZFqrBPrfY0oGy+Zp3qi4
         g1K1zmVfnIjOUAheuEOVPM9TV2unDNdVIHOPYYDYMbqCcdUg7yPSrCLhjwIGwN+UDzIR
         mCCtrhkNZiXXkLVHDbvDx1E2ut79r+vR84kUdZQEBN9gH8vSNXoWCHOVl9mw5fuL1uu9
         SSkzStOU1Ds/XktYHW5BLWjfH8yQfbMXrEMIaurG1NIbGaSI5GfozhYOB+T4HWZrskCG
         abaQ==
X-Gm-Message-State: AOAM532k2HUATdUwV4ZfYyPCnFDD3FbP/VB0RuhP9wJFOnHJA+sxNcUp
        CLHTp84IcUfVCBL1ys0AM6mU5+OsCujgkq4oQxJ+0g==
X-Google-Smtp-Source: ABdhPJxlhKZ1GF2ca/c147WlPJkNLJQNEKvj7ya7bC4/MHkljcImyn5PVlyfBmI32r9hjW/QIf8ThBed7ik1ZNmL2wA=
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr5870417wrw.398.1603978944137;
 Thu, 29 Oct 2020 06:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-5-songmuchun@bytedance.com> <20201029132621.GA2842@linux>
In-Reply-To: <20201029132621.GA2842@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Oct 2020 21:41:46 +0800
Message-ID: <CAMZfGtWr94M0_MgBYzMX=OmHx+1s9VWCGLGzVMU38Cp-bmBk5g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 04/19] mm/hugetlb: Introduce
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 9:26 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Oct 26, 2020 at 10:50:59PM +0800, Muchun Song wrote:
> > If the size of hugetlb page is 2MB, we need 512 struct page structures
> > (8 pages) to be associated with it. As far as I know, we only use the
> > first 4 struct page structures.
>
> As Mike pointed out, better describe what those "4" mean.

Yeah, thanks.

>
> > For tail pages, the value of compound_dtor is the same. So we can reuse
>
> I might be missing something, but HUGETLB_PAGE_DTOR is only set on the
> first tail, right?

Sorry for confusion. Here I mean the `compound_head` is the same.

>
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +#define RESERVE_VMEMMAP_NR   2U
>
> Although you can get that from the changelog, maybe a brief comment explaining
> why RESERVE_VMEMMAP_NR == 2.
> > +
> > +static inline unsigned int nr_free_vmemmap(struct hstate *h)
> > +{
> > +     return h->nr_free_vmemmap_pages;
> > +}
>
> Better add this in the patch that is used?

OK, I will do it. thanks.

>
> > +     if (vmemmap_pages > RESERVE_VMEMMAP_NR)
> > +             h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> > +     else
> > +             h->nr_free_vmemmap_pages = 0;
>
> Can we really have an scenario where we end up with vmemmap_pages < RESERVE_VMEMMAP_NR?

I think that this is impossible. On the safe side, I do this comparison.
Do you think we should remove this comparison? Is that right?

>
> > +
> > +     pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
> > +             h->nr_free_vmemmap_pages, h->name);
>
> I do not think this is useful unless debugging situations, so I would either
> scratch that or make it pr_debug.

Thanks for your suggestions.

>
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
