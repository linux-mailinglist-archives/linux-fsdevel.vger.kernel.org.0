Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407E04266F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbhJHJh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJHJh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:37:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A5C061755
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 02:35:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z11so28360310lfj.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CAh8hwek0Nfg/c4XJ7agugoBthkVWd2136o2c/3om9k=;
        b=XG4XQgVjSvBsGjnPeBnoIafycROzklPNLhZyuYEQ8wcIqoaCgaGUi2IgVwwrrOaTWn
         Vt7a3T3QMV6JtwTb0FXwJZTnlIX0w3BUfVK7/K/HZR1cFpin8z/sXIzAVIw5ucRhiiOS
         xrNB0A8EPyYDuXyu82mkQ8954QbXXS4cjGApCE11Gk2InR0QAPbRe618E9kvQtRZMRJg
         hcQXzEF1i6qHo3urVnF5kgKSItR0CMXvdgHComAS3TIjkdsn5npdKqfnrvGcaGrk0V5W
         C38cKrrkGqpmJOubZuXfSr/jUrWZVtaX7ZdnPtha9mUSlhLmQvwGoWBtfRLsvkWZxZUa
         CWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAh8hwek0Nfg/c4XJ7agugoBthkVWd2136o2c/3om9k=;
        b=B73w/2fbEo+yuxlbmBDnFYJn1Xi3LfA2jnztLqXzhPnC+qVD6iS4MSI4SGEabgpkUZ
         lQcNY09mlDwV8GgPplh9X9uOsYjkL7OxyvGLr+tYF3TYqdZ1X7Ht6GJItasyc039wurz
         eLKFafQnif5NlCWPEXlWwzyD99C9MZV0k0mbkZFHfdcCD8uQYzW59WPqJrL1FyAHHqQX
         gKRhRZ33VLehy2CyFXkQ6KiQGtc3AdgKxCtcxyVViF5bwdKcG1KV/SjvFtGN3ujXd+2+
         wtnHuvYgVv8DE6ZocaB++1+uWOACfTbxDW0E1RYI17qSlE5Ucms7W7xgwc/U0uk6Kpo3
         O/Og==
X-Gm-Message-State: AOAM533jdpF9AKosOXqz8d2Xy45fdaCkU+WL3duDB+P8sjQHqi33/nHa
        Y8xfoEV5HWyydBjc8vt8iJgf6A==
X-Google-Smtp-Source: ABdhPJwLGW8HXwRiYAQ+xuUjNu/jgdX5nEDrRJfqm2RowJ0ATycMGwZzWVZQomTc/2Iw6KRYCEZhNg==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr9838363lfe.442.1633685731071;
        Fri, 08 Oct 2021 02:35:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s18sm195895lfs.294.2021.10.08.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:35:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A0B051030F5; Fri,  8 Oct 2021 12:35:29 +0300 (+03)
Date:   Fri, 8 Oct 2021 12:35:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
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
Message-ID: <20211008093529.sb54gnlbhuiy6klr@box.shutemov.name>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
 <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
 <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
 <YV3+6K3uupLit3aH@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV3+6K3uupLit3aH@t490s>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:54:16PM -0400, Peter Xu wrote:
> On Mon, Oct 04, 2021 at 01:13:07PM -0700, Yang Shi wrote:
> > On Mon, Oct 4, 2021 at 12:41 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Mon, Oct 04, 2021 at 11:17:29AM -0700, Yang Shi wrote:
> > > > On Mon, Oct 4, 2021 at 7:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > >
> > > > > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > > index dae481293b5d..2acc2b977f66 100644
> > > > > > --- a/mm/filemap.c
> > > > > > +++ b/mm/filemap.c
> > > > > > @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > > > >       }
> > > > > >
> > > > > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > > > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > > -         if (!ret) {
> > > > > > -                 /* The page is mapped successfully, reference consumed. */
> > > > > > -                 unlock_page(page);
> > > > > > -                 return true;
> > > > > > -         }
> > > > > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > > +             if (!ret) {
> > > > > > +                     /* The page is mapped successfully, reference consumed. */
> > > > > > +                     unlock_page(page);
> > > > > > +                     return true;
> > > > > > +             }
> > > > > >       }
> > > > > >
> > > > > >       if (pmd_none(*vmf->pmd)) {
> > > > >
> > > > > Hm. Is it unrelated whitespace fix?
> > > >
> > > > It is a coding style clean up. I thought it may be overkilling to have
> > > > a separate patch. Do you prefer separate one?
> > >
> > > Maybe. I tried to find what changed here. It's confusing.
> > 
> > Yeah, maybe. Anyway I will separate the real big fix and the cleanup
> > into two patches. This may be helpful for backporting too.
> 
> Or maybe we just don't touch it until there's need for a functional change?  I
> feel it a pity to lose the git blame info for reindent-only patches,

JFYI, git blame -w ignores whitespace changes :P

-- 
 Kirill A. Shutemov
