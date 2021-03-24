Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16333347FBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 18:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhCXRq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbhCXRp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:45:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7ABC0613DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 10:45:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bf3so28645729edb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGg9bkmQmUrJEoYO//o+38WT2vp4tDvJ1YauvHLK3w0=;
        b=FvQlkmFH+tOQEZcfLr3Wsp0O5iLofV5GNtUxR5JyPoM5RLG5vHO0fVqWiayt+ShEiq
         6fOcX+/MeA/YjC57p8CPqmLsGiGYJLmRra8KGCVinVIoroyCsik+dyIWDBQTzm+1KveI
         3phrbMjz/WSkCRSI41RGGf+W0S888ZEPvbBpYLoK3GfRyXt5qIb2rnZx9IzUiipPH6jt
         zozhTgF1kG6BbfK756qY10AQSO1h33cgsHI0KI8CSfl3kX3LQVP7SGifZKvRhMAeV4d9
         n+fPrenlEA+w78JYAcQjAowrJAfquHk2wnR7aqBvBIpXV+h1NRlYakr+HiETBpvDrqwm
         drfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGg9bkmQmUrJEoYO//o+38WT2vp4tDvJ1YauvHLK3w0=;
        b=V7sykKb3KOSbCAbRFR0ZfyPEMfDSAnk6RfK1I22DezOGq+ZSuv8xN73ThdEklwRTID
         ffdJzZPDj+s3hE9j3/IFrwNE1xb2bzg/cGvt37MxjIBMi0d1FGWCl34dbuU6s6m+ymle
         8E4jP7W8ez/f/nqpnM3exT8KPiA4+CzZ9vMMhYDReUNehbdCibfQ84foFsiYRx5aafGP
         Z0XbNC+zondYR7rTufqgER3EpJWfWsTTG+0HTaihPXmt1NNKjKz3usUVp6y+d6n73aO9
         RV4tUTpWI3DsKyb2Ojj1nAUta5YbZnhySKB4OoqqPSEYTBSx9Lxt406zPCR7P448o8a2
         LnQw==
X-Gm-Message-State: AOAM530191lk87Lv3aiMrOl7NJbwNyMlXkwXqnR8O1aK1Y1ch3bcbGxO
        d+0EP6cfcL2rP+8hdbdf/S9vezgKGFH/vNfouYnMLQ==
X-Google-Smtp-Source: ABdhPJzYwYdMUsSiaziQc4bOwaRP/eIf8tsvN1+MbwfleMPszchzvYZawTUvBNwx7NAPJcu1DDlQkg6IjQ7Aaw/eheI=
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr4696265edv.300.1616607953325;
 Wed, 24 Mar 2021 10:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
In-Reply-To: <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 10:45:42 -0700
Message-ID: <CAPcyv4jidaz=33oWFMB_aBPtYDLe-AA_NP-k_pfGADVt=w5Vng@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 3:02 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/18/21 4:08 AM, Dan Williams wrote:
> > Now that device-dax and filesystem-dax are guaranteed to unmap all user
> > mappings of devmap / DAX pages before tearing down the 'struct page'
> > array, get_user_pages_fast() can rely on its traditional synchronization
> > method "validate_pte(); get_page(); revalidate_pte()" to catch races with
> > device shutdown. Specifically the unmap guarantee ensures that gup-fast
> > either succeeds in taking a page reference (lock-less), or it detects a
> > need to fall back to the slow path where the device presence can be
> > revalidated with locks held.
>
> [...]
>
> > @@ -2087,21 +2078,26 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >  #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
> >
> >  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > +
> >  static int __gup_device_huge(unsigned long pfn, unsigned long addr,
> >                            unsigned long end, unsigned int flags,
> >                            struct page **pages, int *nr)
> >  {
> >       int nr_start = *nr;
> > -     struct dev_pagemap *pgmap = NULL;
> >
> >       do {
> > -             struct page *page = pfn_to_page(pfn);
> > +             struct page *page;
> > +
> > +             /*
> > +              * Typically pfn_to_page() on a devmap pfn is not safe
> > +              * without holding a live reference on the hosting
> > +              * pgmap. In the gup-fast path it is safe because any
> > +              * races will be resolved by either gup-fast taking a
> > +              * reference or the shutdown path unmapping the pte to
> > +              * trigger gup-fast to fall back to the slow path.
> > +              */
> > +             page = pfn_to_page(pfn);
> >
> > -             pgmap = get_dev_pagemap(pfn, pgmap);
> > -             if (unlikely(!pgmap)) {
> > -                     undo_dev_pagemap(nr, nr_start, flags, pages);
> > -                     return 0;
> > -             }
> >               SetPageReferenced(page);
> >               pages[*nr] = page;
> >               if (unlikely(!try_grab_page(page, flags))) {
>
> So for allowing FOLL_LONGTERM[0] would it be OK if we used page->pgmap after
> try_grab_page() for checking pgmap type to see if we are in a device-dax
> longterm pin?

So, there is an effort to add a new pte bit p{m,u}d_special to disable
gup-fast for huge pages [1]. I'd like to investigate whether we could
use devmap + special as an encoding for "no longterm" and never
consult the pgmap in the gup-fast path.

[1]: https://lore.kernel.org/linux-mm/a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org/
