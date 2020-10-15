Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E620028F049
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgJOKlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 06:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgJOKlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:41:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB6C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 03:41:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id p15so2619666ljj.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTyqt8lOISm2/Q6Ius7a9+u5P1zHGu4C4oeKYhyirko=;
        b=c/k395T4C7fxLgITZtwwUbXRSIjkHzaQJRP8TMgAR6Jj6qMtNxe+F97Tva02YJUxvv
         JJoMXODkyqZ9ebU3RARGNIrHtxoUMems2m6bKdnCiHSJC+XEIJH4Y3mqccgV+jLH76ix
         k8i66t6C/vEZxyOfWWNnEfhbqcYg193NvBwU7vSmxCtlgsErdIA/caX5vp4c9WfDZdrm
         nnTQzw099M7PgyA6ZFbHiKfECUrBFS6iINzId/DgGgBIQqxpNxHvI+eizTalEZxBOFU3
         Fj4j8SivDRHeMtZpwVf9fS2ChjLzBFt/NNQnEoZdNl4EDKGUay4sVAMGfTRbP3fHOWQs
         cHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTyqt8lOISm2/Q6Ius7a9+u5P1zHGu4C4oeKYhyirko=;
        b=fxW+PnQv+P734q2dAkNKA/dSuZh+56uxEKRB6UiDNf6a8Q69Ac8IPnOb1P30RCKsKL
         qbZ6fn8KAXLyZMzXRjehMQSbhyFwJViiUIzb4d/lQ6FfOwmV7KgAuhjSpREwsmCNffce
         v4VAsSAOn+tU+XjqmWHj6XbAJcXmzR9vSgZhqWwBJIfHj8gpKz/xHnmMMvdHHJ9dTSlS
         KMnkCSZMTQI5N0b5tT5y2Sih/3oe6tp3oDLRbORzqId5oGaqeBSzaMFnqMw2wCe91lFK
         xlBTt+cjgLnkP6Of3bM321cBROZVGKHQZPKjLXpAU1G3kDCngPzLKbBCQyQyeJK9ZvZ1
         LiHg==
X-Gm-Message-State: AOAM533iITCw1Km5ZD8owap95wplcrjwyL5czYI7e3ofoXlpUNGo9PZd
        2vVullkEtIsTBaeB3xfZmRQ9ZA==
X-Google-Smtp-Source: ABdhPJzkDT7ggGHj39T9CC/2vjzS+9Qpwj2Yfr28KG/1oncAExd7A3xrsgWyO4OCEjvA+YcGJVD5yA==
X-Received: by 2002:a2e:8596:: with SMTP id b22mr941489lji.455.1602758494282;
        Thu, 15 Oct 2020 03:41:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r15sm896215lfn.65.2020.10.15.03.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 03:41:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A8B5F1023C1; Thu, 15 Oct 2020 13:41:39 +0300 (+03)
Date:   Thu, 15 Oct 2020 13:41:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
Message-ID: <20201015104139.ryllzhzdxevrjrbg@box>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <CAHk-=wicH=FaLOeum9_f7Vyyz9Fe4MWmELT7WKR_UbfY37yX-Q@mail.gmail.com>
 <20201014130555.kdbxyavqoyfnpos3@box>
 <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
 <20201014181509.GU20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014181509.GU20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 07:15:09PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 14, 2020 at 09:53:35AM -0700, Linus Torvalds wrote:
> > In particular, what I _think_ we could do is:
> > 
> >  - lock the page tables
> > 
> >  - check that the page isn't locked
> > 
> >  - increment the page mapcount (atomic and ordered)
> > 
> >  - check that the page still isn't locked
> > 
> >  - insert pte
> > 
> > without taking the page lock. And the reason that's safe is that *if*
> [...]
> > And they aren't necessarily a _lot_ more involved. In fact, I think we
> > may already hold the page table lock due to doing that
> > "pte_alloc_one_map()" thing over all of filemap_map_pages(). So I
> > think the only _real_ problem is that I think we increment the
> > page_mapcount() too late in alloc_set_pte().
> 
> I'm not entirely sure why we require the page lock to be held in
> page_add_file_rmap():
> 
>         } else {
>                 if (PageTransCompound(page) && page_mapping(page)) {
>                         VM_WARN_ON_ONCE(!PageLocked(page));
> 
>                         SetPageDoubleMap(compound_head(page));
>                         if (PageMlocked(page))
>                                 clear_page_mlock(compound_head(page));
>                 }
> 
> We have a reference to the page, so compound_head() isn't going
> to change.  SetPageDoubleMap() is atomic.  PageMlocked() is atomic.
> clear_page_mlock() does TestClearPageMlocked() as its first thing,
> so that's atomic too.  What am I missing?  (Kirill added it, so I
> assume he remembers ;-)

In general (with current scheme), we need page lock here to serialize
against try_to_unmap() and other rmap walkers.

For file THP, we also serialize against follow_trans_huge_pmd(FOLL_MLOCK).

-- 
 Kirill A. Shutemov
