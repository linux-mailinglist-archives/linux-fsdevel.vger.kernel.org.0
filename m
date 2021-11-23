Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D870545AE7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhKWVdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKWVdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:33:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0427C061574;
        Tue, 23 Nov 2021 13:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iO3HnBWsJ/NLxaA52RztLHbEXc3qbezCQwSQjG1Zx/M=; b=qsGcdrrxcb86GaRuvr7c46R+V0
        Hc5/2hIoSps0xhhYrfmKeFMhNzRqW7Ge8YfRF5IukxnfV44DLP0fHjKE+CeOV3q2OvGJ2vnpAUKYY
        kHH4rL8+6ecd9BzzhNnmu5pr3P9lOsXeu/1JufgGtIVGK+AYtu82BYq5I1s4kXB6LRmwSN14SGChX
        InHnHV4Nm/vBl6Yca6+UGx1xM8K2hmYlCRopgX9PKQah0rZbDg5WlmVue67SJEu9qNaDlAZQHw9Xg
        uJmRkr8vb7Qtu3szPc48E3Gbz0KFwcdLQSj/LrxgwA5ZuOj6etsXlwkJEMhZ7yETeZSMN7XTkChOY
        tY+cwS5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpdN0-00GUOj-7Q; Tue, 23 Nov 2021 21:30:30 +0000
Date:   Tue, 23 Nov 2021 21:30:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Message-ID: <YZ1ddl3FA43NijmX@casper.infradead.org>
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YZ1USY+zB1PP24Z1@casper.infradead.org>
 <CAHS8izOhi45RqCACGGXYyB8UAmMo-85TyuNX8Myzdh81xOkBTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izOhi45RqCACGGXYyB8UAmMo-85TyuNX8Myzdh81xOkBTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:10:37PM -0800, Mina Almasry wrote:
> On Tue, Nov 23, 2021 at 12:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> > > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > > address is currently mapped by a transparent huge page or not.  Example
> > > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > > mount for example), for a performance critical region of memory.  The
> > > userspace may want to query whether the kernel is actually backing this
> > > memory by hugepages or not.
> >
> > So you want this bit to be clear if the memory is backed by a hugetlb
> > page?
> >
> 
> Yes I believe so. I do not see value in telling the userspace that the
> virt address is backed by a hugetlb page, since if the memory is
> mapped by MAP_HUGETLB or is backed by a hugetlb file then the memory
> is backed by hugetlb pages and there is no vagueness from the kernel
> here.
> 
> Additionally hugetlb interfaces are more size based rather than PMD or
> not. arm64 for example supports 64K, 2MB, 32MB and 1G 'huge' pages and
> it's an implementation detail that those sizes are mapped CONTIG PTE,
> PMD, CONITG PMD, and PUD respectively, and the specific mapping
> mechanism is typically not exposed to the userspace and might not be
> stable. Assuming pagemap_hugetlb_range() == PMD_MAPPED would not
> technically be correct.

What I've been trying to communicate over the N reviews of this
patch series is that *the same thing is about to happen to THPs*.
Only more so.  THPs are going to be of arbitrary power-of-two size, not
necessarily sizes supported by the hardware.  That means that we need to
be extremely precise about what we mean by "is this a THP?"  Do we just
mean "This is a compound page?"  Do we mean "this is mapped by a PMD?"
Or do we mean something else?  And I feel like I haven't been able to
get that information out of you.

