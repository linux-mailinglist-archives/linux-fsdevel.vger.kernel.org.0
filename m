Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4684A26B2B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgIOWvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgIOPmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:42:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A512AC06174A;
        Tue, 15 Sep 2020 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WN7EmustK264smc9o/ZcxMc3lY45Oy2Z1WSCl7q0HYI=; b=VfYtjtx1jnJJKJuezTF8Wv7kTN
        zlCLTChtVQU0w+WsT7rLfh1k2wodLScX6Ty6wgSNfOYM41VlJUAn5E0wT6w3EYNXslThrNba9rThI
        ZZYlnb/ssedTdlgEOS4zIFENEYo3MPuTBEYzuitMiaUUNlQvI8PPP3i71Jr9swVeUInovnUY1A3+D
        i9YvQoh3MHM1UQUAFk+8eqrpZNsibhZ1xrESnazNUrJOa5x5raC9ClX8jPIN5jBQoeOsGb2mozEQU
        UGb6nFqz8/ImJNG8M0JlrYbwuPmWsDtAe9YSvx7PZ4qGn6+rOiJaBJQMTzlI57oPsbsnca2pQWGfN
        gOlQ+fhg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kID5x-0002Vn-NM; Tue, 15 Sep 2020 15:42:13 +0000
Date:   Tue, 15 Sep 2020 16:42:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        David Rientjes <rientjes@google.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap
 pages of hugetlb page
Message-ID: <20200915154213.GI5449@casper.infradead.org>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915143241.GH5449@casper.infradead.org>
 <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:28:01PM +0800, Muchun Song wrote:
> On Tue, Sep 15, 2020 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> > > This patch series will free some vmemmap pages(struct page structures)
> > > associated with each hugetlbpage when preallocated to save memory.
> >
> > It would be lovely to be able to do this.  Unfortunately, it's completely
> > impossible right now.  Consider, for example, get_user_pages() called
> > on the fifth page of a hugetlb page.
> 
> Can you elaborate on the problem? Thanks so much.

OK, let's say you want to do a 2kB I/O to offset 0x5000 of a 2MB page
on a 4kB base page system.  Today, that results in a bio_vec containing
{head+5, 0, 0x800}.  Then we call page_to_phys() on that (head+5) struct
page to get the physical address of the I/O, and we turn it into a struct
scatterlist, which similarly has a reference to the page (head+5).

If you're returning page (head+1) from get_user_pages(), all the
calculations will be wrong and you'll do DMA to the wrong address.

What needs to happen is a conversion to get_user_bvecs().  That way we
can return a bvec which is {head, 0x5000, 0x800} and the calculations
will work.  So that's going to involve touching a lot of device drivers.
Christoph has a start on it here:
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gup-bvec

Overlapping with that is a desire to change the biovec so that it
only stores {phys_addr, length} rather than {page, offset, length}.
We're also going to have to rework the scatterlist so that it doesn't
carry a struct page either.
