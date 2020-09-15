Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5EA26AB63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgIOSBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgIORkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:40:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583FAC06174A;
        Tue, 15 Sep 2020 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R6wtnhjzOsOiJ+klikAlQCnUOZdsHt22W63kKyTGmA4=; b=hRt4BX3Qa/pHh5niIZM8vSwTDW
        azS00Kn1oHngezR/Un12ACAP87cSOwa/z52k7SuaEGVNOMqCnfDTGPJISGtzjFogOcIMPGFaXL+nv
        Rm3SQRcS2XV2jY6eHefJgtKRIlB8uN+GWZ8tmlf2IhiqF+Ne8MrFYG4eX0T6SwNCtnkHksRJ0aVky
        a549EeQTQIfe1ToTtT6bJovd6V8Q36MkUGC8NC4qJAWUcfb3K6Z6qdxmhFfkSgk86VHPftms2wKur
        2i7VoJNs8IDwmNPqhS5WdsQyjo15s11Qw2lG6850wQMptmNv9PVt1Iu4uMVVHcRrE3X0mbilre/r3
        u95WBVqw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIEvk-0001oD-H5; Tue, 15 Sep 2020 17:39:48 +0000
Date:   Tue, 15 Sep 2020 18:39:48 +0100
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
Message-ID: <20200915173948.GK5449@casper.infradead.org>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915143241.GH5449@casper.infradead.org>
 <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
 <20200915154213.GI5449@casper.infradead.org>
 <CAMZfGtVTjopGgFv4xCDcF1+iGeRva_ypH4EQWcDUFBdsfqhQbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVTjopGgFv4xCDcF1+iGeRva_ypH4EQWcDUFBdsfqhQbA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:32:46AM +0800, Muchun Song wrote:
> On Tue, Sep 15, 2020 at 11:42 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Sep 15, 2020 at 11:28:01PM +0800, Muchun Song wrote:
> > > On Tue, Sep 15, 2020 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> > > > > This patch series will free some vmemmap pages(struct page structures)
> > > > > associated with each hugetlbpage when preallocated to save memory.
> > > >
> > > > It would be lovely to be able to do this.  Unfortunately, it's completely
> > > > impossible right now.  Consider, for example, get_user_pages() called
> > > > on the fifth page of a hugetlb page.
> > >
> > > Can you elaborate on the problem? Thanks so much.
> >
> > OK, let's say you want to do a 2kB I/O to offset 0x5000 of a 2MB page
> > on a 4kB base page system.  Today, that results in a bio_vec containing
> > {head+5, 0, 0x800}.  Then we call page_to_phys() on that (head+5) struct
> > page to get the physical address of the I/O, and we turn it into a struct
> > scatterlist, which similarly has a reference to the page (head+5).
> 
> As I know, in this case, the get_user_pages() will get a reference
> to the head page (head+0) before returning such that the hugetlb
> page can not be freed. Although get_user_pages() returns the
> page (head+5) and the scatterlist has a reference to the page
> (head+5), this patch series can handle this situation. I can not
> figure out where the problem is. What I missed? Thanks.

You freed pages 4-511 from the vmemmap so they could be used for
something else.  Page 5 isn't there any more.  So if you return head+5,
then when we complete the I/O, we'll look for the compound_head() of
head+5 and we won't find head.

