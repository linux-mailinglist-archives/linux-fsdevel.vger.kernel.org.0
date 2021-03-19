Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1E341215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 02:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhCSB0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 21:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhCSBZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:25:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED5C06174A;
        Thu, 18 Mar 2021 18:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=epBGpvSKb5BDsLBUPy9iK8A8YY2xiMLqJ0JDHh+J84k=; b=XW4/4ZnjAQWR2NFfKClgD4ZoY2
        PJuV2K+Y/67OJuM7CtWJFtFESWrV+JySdZFUEhNiM9v3CB7NbORoUpKrqC0U+vn56u+Kkwbt9nkwh
        aizAHFmrE6htQAFPOc6PR7x1V7yjZ0yTkiZwxSfihm42sLR1saFEXmCGIYyUimzLx39yz8BPsQfmC
        VUNpuRAguPJDAeISfRleO2cZ1mJmd3Wa999ryMFw40fMOFlPnIeo+TmhCh6NiNw+3u/sNghoUfDDM
        FeaVq4f+rABkPUkse9K1LezlIo9yz9YMn7dXgruKU6kv20P4Vamt9MmVcSFhHl2hEg6GeTQD4vGgo
        aTyR5bQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lN3tH-003k0x-JB; Fri, 19 Mar 2021 01:25:30 +0000
Date:   Fri, 19 Mar 2021 01:25:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
Message-ID: <20210319012527.GX3420@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-2-willy@infradead.org>
 <20210318235645.GB3346@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318235645.GB3346@balbir-desktop>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:56:45AM +1100, Balbir Singh wrote:
> On Fri, Mar 05, 2021 at 04:18:37AM +0000, Matthew Wilcox (Oracle) wrote:
> > A struct folio refers to an entire (possibly compound) page.  A function
> > which takes a struct folio argument declares that it will operate on the
> > entire compound page, not just PAGE_SIZE bytes.  In return, the caller
> > guarantees that the pointer it is passing does not point to a tail page.
> >
> 
> Is this a part of a larger use case or general cleanup/refactor where
> the split between page and folio simplify programming?

The goal here is to manage memory in larger chunks.  Pages are now too
small for just about every workload.  Even compiling the kernel sees a 7%
performance improvement just by doing readahead using relatively small
THPs (16k-256k).  You can see that work here:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/master

I think Kirill, Hugh and others have done a fantastic job stretching
the page struct to work in shmem, but we really need a different type
to avoid people writing code that _looks_ right but is actually buggy.
So I'm starting again, this time with the folio metaphor.
