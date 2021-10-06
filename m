Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7192342478D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhJFT4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 15:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhJFT4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633550064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xnVRUaB8vdHCAs3GIdbbJkvM/qgvDDY4/1PeZEPVaUU=;
        b=hYHuX3WeVb6Uhgji4Zf0OxnEVO+aP42vZaL/WBNj1vszmwac6JVqxJwGdLAOMcS79EP8GE
        ovDPFhyLhZf/G0Gk5hYiBg4WX4p4ebaAS+arXsl/S3zVBzhFCktWPZFYDnuQO0RULNDw1R
        HGO63pBEZm6cGWRnnoEOp4APQZv/y2c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-1KSRd7PBNgeY3VMOFwpziw-1; Wed, 06 Oct 2021 15:54:19 -0400
X-MC-Unique: 1KSRd7PBNgeY3VMOFwpziw-1
Received: by mail-qk1-f198.google.com with SMTP id x25-20020a05620a01f900b0045e1c4567ddso3044838qkn.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 12:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnVRUaB8vdHCAs3GIdbbJkvM/qgvDDY4/1PeZEPVaUU=;
        b=bqfeNyiSOlrWzJ+lOz548WM//EWav4CmXAji/Sy3iJZMKbe6nYOygi5xj1BgisXJTg
         4OAefNqOyXvhs51LelF5RZiV/sEWKt0N0kj62elWXEDmfM7K9zNpY41wPWxSUlVGif19
         ZEgYHnVdJfEQh4WmA29N0C7RtLb9GavZwmXbE19dQ9nv+aVY7Dp8HcEUx6nhywUdUth1
         m/26yiOD0p0xMr4ZkmQMH/DYqlcvaJdUpEfNrXusyZqZcv0cl30Twzx3IxGeHBJMwJe+
         qQJEzqiAB5ZCk6R3ygyqbaVmK/0c9Ma/60K3nUSOLMHJkQx8LDHCq6ABieLojiTgTF6z
         HDXw==
X-Gm-Message-State: AOAM532NHwdRGo6rOIckjHKJ4e62fnsZMQC5dHBiGijCdGHm5ga6NGsl
        RGYVUiJBg2fXzvgzsAKGey2OzU//slYkAGbyfMmZLmpMagbYW11fDGm3TTT/+vtcDpS9gwNTfJE
        n7A5PQ6BRchAIvtS3rG7r0Gd+mA==
X-Received: by 2002:ac8:7e87:: with SMTP id w7mr136152qtj.166.1633550058704;
        Wed, 06 Oct 2021 12:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxud61YtiV9SX04xSMvTTTcQStB2UjjRUVAnxjj7QxgycMhC+ivJ4xXmzGMmXrNEC//a6L0A==
X-Received: by 2002:ac8:7e87:: with SMTP id w7mr136117qtj.166.1633550058362;
        Wed, 06 Oct 2021 12:54:18 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id b13sm3355666qkh.134.2021.10.06.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:54:17 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:54:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YV3+6K3uupLit3aH@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
 <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
 <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:13:07PM -0700, Yang Shi wrote:
> On Mon, Oct 4, 2021 at 12:41 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Mon, Oct 04, 2021 at 11:17:29AM -0700, Yang Shi wrote:
> > > On Mon, Oct 4, 2021 at 7:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >
> > > > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > index dae481293b5d..2acc2b977f66 100644
> > > > > --- a/mm/filemap.c
> > > > > +++ b/mm/filemap.c
> > > > > @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > > >       }
> > > > >
> > > > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > -         if (!ret) {
> > > > > -                 /* The page is mapped successfully, reference consumed. */
> > > > > -                 unlock_page(page);
> > > > > -                 return true;
> > > > > -         }
> > > > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > +             if (!ret) {
> > > > > +                     /* The page is mapped successfully, reference consumed. */
> > > > > +                     unlock_page(page);
> > > > > +                     return true;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >       if (pmd_none(*vmf->pmd)) {
> > > >
> > > > Hm. Is it unrelated whitespace fix?
> > >
> > > It is a coding style clean up. I thought it may be overkilling to have
> > > a separate patch. Do you prefer separate one?
> >
> > Maybe. I tried to find what changed here. It's confusing.
> 
> Yeah, maybe. Anyway I will separate the real big fix and the cleanup
> into two patches. This may be helpful for backporting too.

Or maybe we just don't touch it until there's need for a functional change?  I
feel it a pity to lose the git blame info for reindent-only patches, but no
strong opinion, because I know many people don't think the same and I'm fine
with either ways.

Another side note: perhaps a comment above pageflags enum on PG_has_hwpoisoned
would be nice?  I saw that we've got a bunch of those already.

Thanks,

-- 
Peter Xu

