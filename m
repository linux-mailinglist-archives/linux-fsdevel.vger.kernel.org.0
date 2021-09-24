Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F1416ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhIXJ1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 05:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245027AbhIXJ1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:27:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC3C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 02:26:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z24so38397503lfu.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQHMLuz9imzYljMNKyIhF91ZYs0BCNyD8xwIGKNkN7U=;
        b=K6VGYySSbJ8LF7c4NCbJWG3xW2uOQkA+fi1nij+7WCJZ5DXce/cWIiKDSobNVPOlpv
         GXaKdf250/IfcZU9AO+GqCzOsAWxjYlzdCvP8vJA3tLMEQmgMscb7Mu4B6okvRBa3Iyf
         UQm4D9/fDmcylpB/VmQSBhH4njbHN06MllBoK1jYapKkG4fUvcedsirkaO8jn2m9x261
         8ZNJ9wSe2tlCIslyOt2EGYVkmGazplzCTpc2B9Ltkou0A9gtPIiVqfz2Lb/fg/atwJ3B
         dK8Byy4CyjyxEN3IKjsKtDobAy1B0J/BQ279v4POxX55PQPxK6qMPMoLyu0xGuwPjint
         dmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQHMLuz9imzYljMNKyIhF91ZYs0BCNyD8xwIGKNkN7U=;
        b=uARg3sbxcKl+YxbJEdmBonr8R7uwOV5pSIOUiuvW0y/yXGDo6eWPOc0+DMqX2XwZRH
         df4vKAWVuYw9TOoDPsHw7sbw+V9xBf1aR0hcM7+SdxG6qy1S0AdveA7C/CS8STu56Hxb
         pdyGhxhzUQxTIlGHffhQMg1MTCOmGdLe5b+26c1D3nFzLUhI85v3rYPNNBwa/sWW6YpQ
         55jOouiFN2nrFfLw/GdIEXvvuIssjs1Qlf3eHLWGYw4MK05OGekO/G3+oEAhHOA+gKQv
         UojtWVze4O6tBbqHvxeMI6hQM1oZp3cvutnJyifSpXM5VhwS7HuTULppzfPJP2L3xiae
         h9Qg==
X-Gm-Message-State: AOAM530MVp5uyK8HOu101Gcg1mDGyFzMe7UUgX6F7ob9iTdaqu3PcUMb
        o5NsNLymqXLMDRTi/yCo0NnCbw==
X-Google-Smtp-Source: ABdhPJz/C8Dz5zH1BzBPiet4Qs8ElsusgdiOSm2BdOw4HF+3vvM7N/tNKcDNnWnGMSNC0txZK6w6Qw==
X-Received: by 2002:a05:651c:2109:: with SMTP id a9mr2287794ljq.166.1632475579601;
        Fri, 24 Sep 2021 02:26:19 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s10sm696114lfc.28.2021.09.24.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:26:18 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7C221103068; Fri, 24 Sep 2021 12:26:21 +0300 (+03)
Date:   Fri, 24 Sep 2021 12:26:21 +0300
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
Subject: Re: [v2 PATCH 1/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <20210924092621.kbg4byfidfzgjk3g@box>
References: <20210923032830.314328-1-shy828301@gmail.com>
 <20210923032830.314328-2-shy828301@gmail.com>
 <20210923143901.mdc6rejuh7hmr5vh@box.shutemov.name>
 <CAHbLzkqb-6a7c=C8WF0G0X2yCey=t7OoL-oW2Y0CpM0MpgJbBg@mail.gmail.com>
 <CAHbLzkr5YkpuFpnZguDb46naLc3MXw0DmjkttbGU4Nmm=yX8gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkr5YkpuFpnZguDb46naLc3MXw0DmjkttbGU4Nmm=yX8gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 01:39:49PM -0700, Yang Shi wrote:
> On Thu, Sep 23, 2021 at 10:15 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Thu, Sep 23, 2021 at 7:39 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 08:28:26PM -0700, Yang Shi wrote:
> > > > When handling shmem page fault the THP with corrupted subpage could be PMD
> > > > mapped if certain conditions are satisfied.  But kernel is supposed to
> > > > send SIGBUS when trying to map hwpoisoned page.
> > > >
> > > > There are two paths which may do PMD map: fault around and regular fault.
> > > >
> > > > Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> > > > the thing was even worse in fault around path.  The THP could be PMD mapped as
> > > > long as the VMA fits regardless what subpage is accessed and corrupted.  After
> > > > this commit as long as head page is not corrupted the THP could be PMD mapped.
> > > >
> > > > In the regulat fault path the THP could be PMD mapped as long as the corrupted
> > >
> > > s/regulat/regular/
> > >
> > > > page is not accessed and the VMA fits.
> > > >
> > > > This loophole could be fixed by iterating every subpage to check if any
> > > > of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> > > >
> > > > So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> > > > indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> > > > is found hwpoisoned by memory failure and cleared when the THP is freed or
> > > > split.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > >
> > > ...
> > >
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index dae481293b5d..740b7afe159a 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -3195,12 +3195,14 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
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
> > > > +             if (ret == VM_FAULT_FALLBACK)
> > > > +                     goto out;
> > >
> > > Hm.. What? I don't get it. Who will establish page table in the pmd then?
> >
> > Aha, yeah. It should jump to the below PMD populate section. Will fix
> > it in the next version.
> >
> > >
> > > > +             if (!ret) {
> > > > +                     /* The page is mapped successfully, reference consumed. */
> > > > +                     unlock_page(page);
> > > > +                     return true;
> > > > +             }
> > > >       }
> > > >
> > > >       if (pmd_none(*vmf->pmd)) {
> > > > @@ -3220,6 +3222,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > >               return true;
> > > >       }
> > > >
> > > > +out:
> > > >       return false;
> > > >  }
> > > >
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 5e9ef0fc261e..0574b1613714 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2426,6 +2426,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > >       /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> > > >       lruvec = lock_page_lruvec(head);
> > > >
> > > > +     ClearPageHasHWPoisoned(head);
> > > > +
> > >
> > > Do we serialize the new flag with lock_page() or what? I mean what
> > > prevents the flag being set again after this point, but before
> > > ClearPageCompound()?
> >
> > No, not in this patch. But I think we could use refcount. THP split
> > would freeze refcount and the split is guaranteed to succeed after
> > that point, so refcount can be checked in memory failure. The
> > SetPageHasHWPoisoned() call could be moved to __get_hwpoison_page()
> > when get_unless_page_zero() bumps the refcount successfully. If the
> > refcount is zero it means the THP is under split or being freed, we
> > don't care about these two cases.
> 
> Setting the flag in __get_hwpoison_page() would make this patch depend
> on patch #3. However, this patch probably will be backported to older
> versions. To ease the backport, I'd like to have the refcount check in
> the same place where THP is checked. So, something like "if
> (PageTransHuge(hpage) && page_count(hpage) != 0)".
> 
> Then the call to set the flag could be moved to __get_hwpoison_page()
> in the following patch (after patch #3). Does this sound good to you?

Could you show the code I'm not sure I follow. page_count(hpage) check
looks racy to me. What if split happens just after the check?

-- 
 Kirill A. Shutemov
