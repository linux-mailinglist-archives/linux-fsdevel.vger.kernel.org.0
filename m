Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2B2B68B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgKQPa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgKQPa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:30:26 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2FC0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 07:30:25 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d17so8886432plr.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIvZeddIQ2d7OXVk2Uvs8VZdn+XX8s/0AnrjeK+3CsU=;
        b=bhwrJmc0GjcqgX8OVmcbGhlIi+xRPTfFufg6IrO2IlzzbU2Ro3Dn1DorKGtrkbUhEY
         HfnFy5EeLrIq4OJNeRGdwTMen1DVJO+eQ9C7cHlEv+AzRolv5nul5z0n+C2yOfDcXnEc
         /wLam43UU7fEiHh4i7hNQOZNJ5Q0tk3KYhHoLz7WhPJiv3X2623wQ0g8ZvVZ3VeE3sFF
         yPpUA+21czYfv1dFNgXKviqcQPaRVTpcydWad4DAdlQ2fQxVYFTbG0R+HRg13t9aqvCx
         92e93IxrRQspe2wBpWSCgI6jZi9VTzWlxzJ8zPyZPVjGAlxrtzGQWafIqKPs99SMpGxA
         bNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIvZeddIQ2d7OXVk2Uvs8VZdn+XX8s/0AnrjeK+3CsU=;
        b=XIwXc3WN2Tf5xppbHzWoM0cSXnLeAyGEI8d6V4pXLJiAC+dIDa/uFa+OABwZnk29n2
         RG1+BQAPhwhcJAHOBNuhH/d3nt04tzk+PGQq8Igycr7OSsKwEExXH8RKz+ARKBXTdLxq
         MqeFmLFtcnZS/767xsVSpa63LoA75lsuM96+zRiu4W+BeOBZEKMmZampbLDU304z6pf8
         3mb0vBl97C7sXuNJA0vCrjuqWV7q46lP9gomfIOG20hyV1jv6I8qw8QY2C+0W+81s5jR
         s9jdipDDWpBIHiTICMZ+arEnSIQ6xibF/+xQW+pNX1g4dIsrjKqMju3Lata2QfD2zff6
         fYhw==
X-Gm-Message-State: AOAM530ayEfhOyD2UwEEgMIUCoNoysicAhrWEFLgxYrYU9N6untBOK0X
        GDuTe6QsPvZ48FBskG+TNr7egsPc7jhC+vfsdghCmQ==
X-Google-Smtp-Source: ABdhPJwIhciLv1sUAGBmks9JTdZrzhMo5xSdPzoc5eR6bFAjo9blSdT+iwLKdn8nt0XnjcldUMgbZHy6/eG17MNR+nw=
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr5214598pjb.229.1605627024793;
 Tue, 17 Nov 2020 07:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-6-songmuchun@bytedance.com> <20201117150604.GA15679@linux>
In-Reply-To: <20201117150604.GA15679@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 17 Nov 2020 23:29:45 +0800
Message-ID: <CAMZfGtWPu2GKquUfNusVBD7LsiYSB6t6+ugoAcKRkpLeQd+bQQ@mail.gmail.com>
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

Yeah, I forgot to remove it. Thanks.

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

Oh, sorry for missing his reply. It is a good idea. I will start an
investigation.
Thanks for reminding me.

> I am not sure whether it is feasible at all though.
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

Yeah, also can remove:).


>
> --
> Oscar Salvador
> SUSE L3



--
Yours,
Muchun
