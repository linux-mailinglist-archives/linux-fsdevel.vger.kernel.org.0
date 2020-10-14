Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4628E61E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 20:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgJNSPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgJNSPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:15:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2DC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQvG5B57qQ8pitJx5xAsS25qRLEbRjXr/NwuIkkRph8=; b=ZqWQT4WOvQ0G8vZGdAd085nXrs
        793fmY3O7zgdfZle1c1NyuwoZu7RGnqlY4Z/8dpeMAOxPz9IhxWF9EzqaaRVjxs6N/VI5J831DfQY
        uTVWrGcNvvLfLbZfAosgrTXIZRbAS9NqXDF1Co6YnJV11pIWnA0bnezhDdnV5urq79X+nKOQj1Zxq
        vwVBT7xHTDA6HyJXLKP2k5iWbZ9XRxzDWRcS15m/RKYKQveTHUBqMnOc3m1CdgV2jkyM73yqSvRtM
        lK5ryRd8zQwYy+HY9tf1otRyew4C0b0CHgFCI/0vJq99zn6UriMxo55sAyMnAZeS6c80ZbXmm3Wxa
        ty+Vc4PA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSlIr-0007sy-UD; Wed, 14 Oct 2020 18:15:09 +0000
Date:   Wed, 14 Oct 2020 19:15:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
Message-ID: <20201014181509.GU20115@casper.infradead.org>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <CAHk-=wicH=FaLOeum9_f7Vyyz9Fe4MWmELT7WKR_UbfY37yX-Q@mail.gmail.com>
 <20201014130555.kdbxyavqoyfnpos3@box>
 <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:53:35AM -0700, Linus Torvalds wrote:
> In particular, what I _think_ we could do is:
> 
>  - lock the page tables
> 
>  - check that the page isn't locked
> 
>  - increment the page mapcount (atomic and ordered)
> 
>  - check that the page still isn't locked
> 
>  - insert pte
> 
> without taking the page lock. And the reason that's safe is that *if*
[...]
> And they aren't necessarily a _lot_ more involved. In fact, I think we
> may already hold the page table lock due to doing that
> "pte_alloc_one_map()" thing over all of filemap_map_pages(). So I
> think the only _real_ problem is that I think we increment the
> page_mapcount() too late in alloc_set_pte().

I'm not entirely sure why we require the page lock to be held in
page_add_file_rmap():

        } else {
                if (PageTransCompound(page) && page_mapping(page)) {
                        VM_WARN_ON_ONCE(!PageLocked(page));

                        SetPageDoubleMap(compound_head(page));
                        if (PageMlocked(page))
                                clear_page_mlock(compound_head(page));
                }

We have a reference to the page, so compound_head() isn't going
to change.  SetPageDoubleMap() is atomic.  PageMlocked() is atomic.
clear_page_mlock() does TestClearPageMlocked() as its first thing,
so that's atomic too.  What am I missing?  (Kirill added it, so I
assume he remembers ;-)
