Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13E48953F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 10:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiAJJbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 04:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbiAJJaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:30:39 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B3C06175D;
        Mon, 10 Jan 2022 01:30:39 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f8so10629845pgf.8;
        Mon, 10 Jan 2022 01:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxO/8OuuzNR7eAf6IsgCq5fEtto/kobpAG04hHqPo08=;
        b=nf/2LAaUFsu7lPTzEiAvsOr9is2lxLZ8pyVoAYpAfDZIc0ANGrxVT7rysPnRhj5NeR
         2aHYuzXf9Rvq54UyCLLy9pyOt2AubFHNIJjl/drNZvL24p3/OdsBI9NEIkUL+gCI6sFe
         QuK0jc8LiufJ2AyPp0Zc4R7HOq9PZoFtiqnujVjzj7IjYpP/+NBTVR1vepeCVBBo+/0s
         fYMhRiFIpg53DKqRhAnA/A6s2xmlDG2cu26ZBF7TwZV7diCjqeHC4c9V5IPUXLCwmxRL
         iuN39F664SnQp8Kr0bdT8N/N7GS9A6AgfWicwAjMbsV0PLSKdZc0zHs9aYTFtVgI6Bla
         SdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxO/8OuuzNR7eAf6IsgCq5fEtto/kobpAG04hHqPo08=;
        b=aDDVMBLOI+RedkWBYQ8i3kMyv/bZZ+dsFc86AWMoMEcaMVrnXZoPOA2QLFODx/CBPv
         77nf+mTV6G+t4JUe1GjUTYh/zkJbdtWgQFlSi4HEYM2SHWZAd2mUS5WNu4tSuX9w8ihN
         nXTBOoPOXHbgotImnCnvsngBbkXdh5BkpvBAY+lyLhY0CrnrqTlWm3VDM9BS0hcyhaNV
         K3juwxGRr7Xk1xdgvFSJEo7UkFYeSoqWvV6WUKsyP8jlE65B+TI5NaeSccGDp7G0T/8x
         nU9ho6anKpMurL3Dz9dgeO+uCn2T6SaBOp3MndiZQsOvmYQ1Zbpxyf6OetaREIU5mpGp
         hw1w==
X-Gm-Message-State: AOAM530aXKopMZIpN06X0ugQsmux7cQgENUuEvFNCR7Ysg/P92zfZJPW
        Ed0gmAuvqFFQ49ql/cvVa1r7caYqHvlqKkcjhlw=
X-Google-Smtp-Source: ABdhPJxOtheUd0dFkFcpmwhGW3MMVd/CG47IT8aulC8XANK8sGoRQ0THeQgVJY1qXF2MVqkTQWjnMzhU5BwppuZG2NU=
X-Received: by 2002:aa7:8f06:0:b0:4be:3e7f:cbe1 with SMTP id
 x6-20020aa78f06000000b004be3e7fcbe1mr4319032pfr.73.1641807038692; Mon, 10 Jan
 2022 01:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20220109130515.140092-1-sxwjean@me.com> <20220109130515.140092-2-sxwjean@me.com>
 <93865d07-1cc6-8cad-c14a-7fcded63e954@redhat.com>
In-Reply-To: <93865d07-1cc6-8cad-c14a-7fcded63e954@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 10 Jan 2022 17:30:12 +0800
Message-ID: <CAEVVKH-oUtcmXutS4jQa06ZX4q8S7dKaTmvFzHWyUFgB-agbew@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memremap.c: Add pfn_to_devmap_page() to get page
 in ZONE_DEVICE
To:     David Hildenbrand <david@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Mon, Jan 10, 2022 at 4:16 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.01.22 14:05, sxwjean@me.com wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > when requesting page information by /proc/kpage*, the pages in ZONE_DEVICE
> > were missed. We need a function to help on this.
> >
> > The pfn_to_devmap_page() function like pfn_to_online_page(), but only
> > concerns the pages in ZONE_DEVICE.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >  include/linux/memremap.h |  8 ++++++++
> >  mm/memremap.c            | 42 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > index c0e9d35889e8..621723e9c4a5 100644
> > --- a/include/linux/memremap.h
> > +++ b/include/linux/memremap.h
> > @@ -137,6 +137,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
> >  void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
> >  struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
> >               struct dev_pagemap *pgmap);
> > +struct page *pfn_to_devmap_page(unsigned long pfn,
> > +             struct dev_pagemap **pgmap);
> >  bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
> >
> >  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
> > @@ -166,6 +168,12 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
> >       return NULL;
> >  }
> >
> > +static inline struct page *pfn_to_devmap_page(unsigned long pfn,
> > +             struct dev_pagemap **pgmap)
> > +{
> > +     return NULL;
> > +}
> > +
> >  static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
> >  {
> >       return false;
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index 5a66a71ab591..072dbe6ab81c 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -494,6 +494,48 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
> >  }
> >  EXPORT_SYMBOL_GPL(get_dev_pagemap);
> >
> > +/**
> > + * pfn_to_devmap_page - get page pointer which belongs to dev_pagemap by @pfn
> > + * @pfn: page frame number to lookup page_map
> > + * @pgmap: to save pgmap address which is for putting reference
> > + *
> > + * If @pgmap is non-NULL, then pfn is on ZONE_DEVICE and return page pointer.
> > + */
> > +struct page *pfn_to_devmap_page(unsigned long pfn, struct dev_pagemap **pgmap)
> > +{
> > +     unsigned long nr = pfn_to_section_nr(pfn);
> > +     struct mem_section *ms;
> > +     struct page *page = NULL;
> > +
> > +     if (nr >= NR_MEM_SECTIONS)
> > +             return NULL;
> > +
> > +     if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
> > +             return NULL;
> > +
> > +     ms = __nr_to_section(nr);
> > +     if (!valid_section(ms))
> > +             return NULL;
> > +     if (!pfn_section_valid(ms, pfn))
> > +             return NULL;
> > +
> > +     /*
> > +      * Two types of sections may include valid pfns:
> > +      * - The pfns of section belong to ZONE_DEVICE and ZONE_{NORMAL,MOVABLE}
> > +      *   at the same time.
> > +      * - All pfns in one section are offline but valid.
> > +      */
> > +     if (!online_device_section(ms) && online_section(ms))
> > +             return NULL;
> > +
> > +     *pgmap = get_dev_pagemap(pfn, NULL);
> > +     if (*pgmap)
> > +             page = pfn_to_page(pfn);
> > +
> > +     return page;
> > +}
> > +EXPORT_SYMBOL_GPL(pfn_to_devmap_page);
>
> Is this complexity really required?
>
> Take a look at mm/memory-failure.c
>
> p = pfn_to_online_page(pfn);
> if (!p) {
>         if (pfn_valid(pfn)) {
>                 pgmap = get_dev_pagemap(pfn, NULL);
>                 if (pgmap)
>                         // success
>                 // error
>         }
>         // error
> }

Yes, this method is much simpler than mine. Will do this in v2.

>
>
> Also, why do we need the export?

Ah, no strong reason. Will remove that in v2.

Would you mind adding "Suggested-by" for this patch?

Thank you for your time.

Regards,
Xiongwei
