Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE10642183B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhJDUPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 16:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhJDUPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:15:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59429C061745;
        Mon,  4 Oct 2021 13:13:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj4so70041046edb.5;
        Mon, 04 Oct 2021 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9q0PfcjN4ZcxtERnpGgFCs55vRjNc3NnENgrVFHH7xs=;
        b=ZMMgpWZHQ0vHntjuBhO97brNLUon0w94MU7wkJLo89LWplC8RTnsjCZTGqxLYVFcVx
         WyHzRnWOSnqQjfgJx8aFEqhpnIABplxdnaAf1yuuUWpuuviirPR5Ds3GzDKW+taK5PsG
         kR7QeQV1M8PBDTFXKIOil9RO4xHcVNgVMujLkprdkn+Ey95cNp/93RAGiJTxUe4BDCo0
         qZ+FOba7wwfZyi8ooguFvEazfDrzN9GnP+87yDjugEBWHOcC/UJzl4K3utiLs0jr2EFt
         lc9WSuF0Yt4Z9CjRq7P3CDwewMxYDEW3Nm/f6w4xdZBjmBNCK1fumwPZsxrt6UWDM6NR
         SAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9q0PfcjN4ZcxtERnpGgFCs55vRjNc3NnENgrVFHH7xs=;
        b=DEYUZTGQr9lH9Q4bjT8SuSc4TsLD8Mwb9V4vpUVeCpsPOKhXiR5enG8rj7p+nMAFXk
         4NcITMpttwiAzoTwAQUXNjCyUbwRiT+F9PKVoeOUpwZx2tTcTL5XuQQ2k933jkQSmH74
         sEHHoIK2KcQ25+x/nP7q47CKwdfYeij44r7ad2GSytp9KA9H03wLBzrPYYT+VY62FR+D
         zBoWRP70tvCM6T09R1nq0wZW6RUN3qcegOnXXCMZbLaAKfRhv5iuSMGEY86TMiUApLnS
         FtgpRBfXmVdWwgxtcDWanqVMpP2+IZOpo4f/GX1ZzyWlHW5H47fa8kY2z/xZBoVKGl5S
         /Z6A==
X-Gm-Message-State: AOAM532KSwRJiHL6jemAHDq3Nptfi/G0lmROj/Gd85GiM/nAItAa9Odh
        fpa+KlH44FqSfT+rg4XYXaPUkDSpQw44u0Ij8B0=
X-Google-Smtp-Source: ABdhPJwfnU85LXVfxLQzchmKGmou6ZhKaAOxYoJNmvfOc6u6tutvah//4ik6xntkhMkxLUgJakl9GQMsDtCaGGJys/A=
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr18574634ejc.537.1633378398991;
 Mon, 04 Oct 2021 13:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name> <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
In-Reply-To: <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 4 Oct 2021 13:13:07 -0700
Message-ID: <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 4, 2021 at 12:41 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Oct 04, 2021 at 11:17:29AM -0700, Yang Shi wrote:
> > On Mon, Oct 4, 2021 at 7:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index dae481293b5d..2acc2b977f66 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > >       }
> > > >
> > > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > > -         if (!ret) {
> > > > -                 /* The page is mapped successfully, reference consumed. */
> > > > -                 unlock_page(page);
> > > > -                 return true;
> > > > -         }
> > > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > > +             if (!ret) {
> > > > +                     /* The page is mapped successfully, reference consumed. */
> > > > +                     unlock_page(page);
> > > > +                     return true;
> > > > +             }
> > > >       }
> > > >
> > > >       if (pmd_none(*vmf->pmd)) {
> > >
> > > Hm. Is it unrelated whitespace fix?
> >
> > It is a coding style clean up. I thought it may be overkilling to have
> > a separate patch. Do you prefer separate one?
>
> Maybe. I tried to find what changed here. It's confusing.

Yeah, maybe. Anyway I will separate the real big fix and the cleanup
into two patches. This may be helpful for backporting too.

>
> --
>  Kirill A. Shutemov
