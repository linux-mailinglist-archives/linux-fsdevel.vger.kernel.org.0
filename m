Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0956426ABA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgIOSRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIOSPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:15:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E1AC06178A;
        Tue, 15 Sep 2020 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXN7kFAR+gEpJNTnaqlhtCgmixCtDEYWogMlLi09BOM=; b=g3b3ifw6Kcqd0noxwqMen2vSMe
        GaeV+rwhGta+j00CbRGZ2ThYXW7YmoKrXYSxCWGN5xwbcs9+0r02yI6vTLiEtiDIZZgc2+MqYRH6C
        MIhkSnVLyMtoG6kPM0lt72jNvlIOvb8wKBeTp/x65OyrO3UvheGhvlhvHoyaSn+yqsUfpVV3CTseW
        r/+Zt9EBkx4Q9FSU0TlVr+roYq1e/CgCgLInKsHmRZuO4QX7Xlz6UhUNkICF8ycSi4Lxg6C01VJqg
        NZTH7buqYS/nojHG42M6l71Z25z7F9ahPsBvn+Hb9GKG/2welJsm4xllPkGvGvEQJG7g17xWDDfQi
        PFiEJIJA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIFUI-0004Cf-71; Tue, 15 Sep 2020 18:15:30 +0000
Date:   Tue, 15 Sep 2020 19:15:30 +0100
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
Message-ID: <20200915181530.GL5449@casper.infradead.org>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915143241.GH5449@casper.infradead.org>
 <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
 <20200915154213.GI5449@casper.infradead.org>
 <CAMZfGtVTjopGgFv4xCDcF1+iGeRva_ypH4EQWcDUFBdsfqhQbA@mail.gmail.com>
 <20200915173948.GK5449@casper.infradead.org>
 <CAMZfGtW3S8kGJwff6oH14QWPXKTuQEAGdYwcLRUZxuJ7q8s7sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW3S8kGJwff6oH14QWPXKTuQEAGdYwcLRUZxuJ7q8s7sA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:03:15AM +0800, Muchun Song wrote:
> On Wed, Sep 16, 2020 at 1:39 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Sep 16, 2020 at 01:32:46AM +0800, Muchun Song wrote:
> > > On Tue, Sep 15, 2020 at 11:42 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Tue, Sep 15, 2020 at 11:28:01PM +0800, Muchun Song wrote:
> > > > > On Tue, Sep 15, 2020 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> > > > > > > This patch series will free some vmemmap pages(struct page structures)
> > > > > > > associated with each hugetlbpage when preallocated to save memory.
> > > > > >
> > > > > > It would be lovely to be able to do this.  Unfortunately, it's completely
> > > > > > impossible right now.  Consider, for example, get_user_pages() called
> > > > > > on the fifth page of a hugetlb page.
> > > > >
> > > > > Can you elaborate on the problem? Thanks so much.
> > > >
> > > > OK, let's say you want to do a 2kB I/O to offset 0x5000 of a 2MB page
> > > > on a 4kB base page system.  Today, that results in a bio_vec containing
> > > > {head+5, 0, 0x800}.  Then we call page_to_phys() on that (head+5) struct
> > > > page to get the physical address of the I/O, and we turn it into a struct
> > > > scatterlist, which similarly has a reference to the page (head+5).
> > >
> > > As I know, in this case, the get_user_pages() will get a reference
> > > to the head page (head+0) before returning such that the hugetlb
> > > page can not be freed. Although get_user_pages() returns the
> > > page (head+5) and the scatterlist has a reference to the page
> > > (head+5), this patch series can handle this situation. I can not
> > > figure out where the problem is. What I missed? Thanks.
> >
> > You freed pages 4-511 from the vmemmap so they could be used for
> > something else.  Page 5 isn't there any more.  So if you return head+5,
> > then when we complete the I/O, we'll look for the compound_head() of
> > head+5 and we won't find head.
> 
> We do not free pages 4-511 from the vmemmap. Actually, we only
> free pages 128-511 from the vmemmap.
> 
> The 512 struct pages occupy 8 pages of physical memory. We only
> free 6 physical page frames to the buddy. But we will create a new
> mapping just like below. The virtual address of the freed pages will
> remap to the second page frame. So the second page frame is
> reused.

Oh!  I get what you're doing now.

For the vmemmap case, you free the last N-2 physical pages but map the
second physical page multiple times.  So for the 512 pages case, we
see pages:

abcdefgh | ijklmnop | ijklmnop | ijklmnop | ijklmnop | ijklmnop | ijklmnop ...

Huh.  I think that might work, except for PageHWPoison.  I'll go back
to your patch series and look at that some more.

