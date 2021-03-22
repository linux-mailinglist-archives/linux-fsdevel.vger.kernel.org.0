Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E603437AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCVDyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCVDye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:54:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80215C061574;
        Sun, 21 Mar 2021 20:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OLtU7Po7VDleXiwD97Raw3xEmeFq1dvrerQKytpuzyI=; b=j8ZYytoWWkgXlT3z1roEGsgEli
        X8fmlr/of840tbaO/jZpc2gZP06Ecym1Zhug/4i/qUs+3rDAEmRcT0cGCkwNliyn7MxBftcvmQ49D
        FcVsViHszMUACH5uW1YoCXUkwvX3xvzKuVsbjNA3HGeNgRIUPGKSWGWcqEWxyX9IpZrr3u96u6G3I
        HMaAsHz1MqkmoCm02b1TCdVMTin1nuzF8FxE2gu2+800xhcFZhkTSIhNkTRGDpe8wQ2KUzXP1wsss
        s5b2BFqqO4CmvreJskvLORGpSNR3uU0h4Ys9LqvKr0oVq76Gr6FvDYJpD/pk4AKy4mVDazyKykhMi
        qYKChQFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOBe1-007xJI-Kw; Mon, 22 Mar 2021 03:54:25 +0000
Date:   Mon, 22 Mar 2021 03:54:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Balbir Singh <bsingharora@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
Message-ID: <20210322035421.GF1719932@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-2-willy@infradead.org>
 <20210318235645.GB3346@balbir-desktop>
 <20210319012527.GX3420@casper.infradead.org>
 <1616381339.fjexi9aqhl.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616381339.fjexi9aqhl.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 12:52:40PM +1000, Nicholas Piggin wrote:
> Excerpts from Matthew Wilcox's message of March 19, 2021 11:25 am:
> > On Fri, Mar 19, 2021 at 10:56:45AM +1100, Balbir Singh wrote:
> >> On Fri, Mar 05, 2021 at 04:18:37AM +0000, Matthew Wilcox (Oracle) wrote:
> >> > A struct folio refers to an entire (possibly compound) page.  A function
> >> > which takes a struct folio argument declares that it will operate on the
> >> > entire compound page, not just PAGE_SIZE bytes.  In return, the caller
> >> > guarantees that the pointer it is passing does not point to a tail page.
> >> >
> >> 
> >> Is this a part of a larger use case or general cleanup/refactor where
> >> the split between page and folio simplify programming?
> > 
> > The goal here is to manage memory in larger chunks.  Pages are now too
> > small for just about every workload.  Even compiling the kernel sees a 7%
> > performance improvement just by doing readahead using relatively small
> > THPs (16k-256k).  You can see that work here:
> > https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/master
> 
> The 7% improvement comes from cache cold kbuild by improving IO
> patterns?
> 
> Just wondering what kind of readahead is enabled by this that can't
> be done with base page size.

I see my explanation earlier was confusing.  What I meant to say
was that the only way in that patch set to create larger pages was
at readahead time.  Writes were incapable of creating larger pages.
Once pages were in the page cache, they got managed at that granularity
unless they got split by a truncate/holepunch/io-error/...

I don't have good perf runs of kernbench to say exactly where we got the
benefit.  My assumption is that because we're managing an entire, say,
256kB page as a single unit on the LRU list, we benefit from lower LRU
lock contention.  There's also the benefit of batching, eg, allocating
a single 256kB page from the page allocator may well be more effective
than allocating 64 4kB pages.
