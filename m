Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7634217B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhJDTnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhJDTnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:43:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B2C061749
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Oct 2021 12:41:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y15so10645990lfk.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=clBM85hi2nPrpIuibtB0vVd5Js3XVtOHksauv+P+ctM=;
        b=jxWcVtu7TrORgQIl/RjTXyV44/DNSX+LYMplQe5tOJXv5wPsnsmfEI6MBhCr6G4YPj
         lkOaeEFTh3O6AUHOO+AaTqHWccA1gBhKQ921YOG+8OqTJfP5GNGFHi17axgjiMLjkO9t
         TemZEJb9tLOdRRmottrTRpfj6tFYg6DMMqRDyE653ZubnUXesJJcWumEGUmwJQ5sEfPe
         H3i5oXMHaIcr/skshvDUMb46nEkahgBvMC/yOOVDoCGyPQNe4Dx/BfuJgMi6+IRfb5k7
         42rOrvykgOksgmJADkx24ud4uWiqRiSx5gIuTviMr9S1A712132jLhM9ZOAz/XMRv8Sr
         3u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=clBM85hi2nPrpIuibtB0vVd5Js3XVtOHksauv+P+ctM=;
        b=o5GPJXIxQcYDjVdRAAcH5xzTEHXD02JxyDO1BnBBE4boREPNOrVSzkoQdeTa9jKwHX
         I7cpqdkvnbZUIF+ySLL+Y4VI076PPF05N8GLrvPbOQwWT0GACgvGkSY7kxe5f+n84lAN
         p6cg89aZCCH0m45jKFwVfhQ/OU6OJ6h1NPBUlrjE7y+vu4aBqv12HLMQdpVf6GC4/0bT
         aGlqqA1X/HtVTQz9BIVFlCG9cqhJSPmr/IUiTK2UvGC1nBFbOGwPfOp+NA6XIao99NDx
         +cz2DeneLFcRL5Mrlq/eSQw/8AVagzNUdoXeLUeHnck4xfUDsvwNLjJQ6t0guy+IVREZ
         6OCw==
X-Gm-Message-State: AOAM533RoHNJl20tvXdQBk2l2WLnqP5eZZ8sFT8QqsLuED4upDcRuHM/
        VrfRuE8kFG3kvvLvqPsAahMGQw==
X-Google-Smtp-Source: ABdhPJy6FFdpfcesD4CmE1jQWn9C+4NfmErQ+iT1GUlXb9+KNEm6EVpow6mqZqYOo6iKAgmMhDVISA==
X-Received: by 2002:a2e:a596:: with SMTP id m22mr18807866ljp.262.1633376492387;
        Mon, 04 Oct 2021 12:41:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b15sm1685339lfp.221.2021.10.04.12.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:41:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ECF9410306D; Mon,  4 Oct 2021 22:41:30 +0300 (+03)
Date:   Mon, 4 Oct 2021 22:41:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
 <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:17:29AM -0700, Yang Shi wrote:
> On Mon, Oct 4, 2021 at 7:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index dae481293b5d..2acc2b977f66 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > >       }
> > >
> > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > -         if (!ret) {
> > > -                 /* The page is mapped successfully, reference consumed. */
> > > -                 unlock_page(page);
> > > -                 return true;
> > > -         }
> > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > +             if (!ret) {
> > > +                     /* The page is mapped successfully, reference consumed. */
> > > +                     unlock_page(page);
> > > +                     return true;
> > > +             }
> > >       }
> > >
> > >       if (pmd_none(*vmf->pmd)) {
> >
> > Hm. Is it unrelated whitespace fix?
> 
> It is a coding style clean up. I thought it may be overkilling to have
> a separate patch. Do you prefer separate one?

Maybe. I tried to find what changed here. It's confusing.

-- 
 Kirill A. Shutemov
