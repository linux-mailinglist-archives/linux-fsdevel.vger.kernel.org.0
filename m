Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6491F3CA3AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhGORSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhGORSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:18:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA08C06175F;
        Thu, 15 Jul 2021 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GFDHONlvPqRbyByNjuaBzwGs2142b4swUJyvK7OfAiQ=; b=rWvP9lxYarf7TISkJdsj4Sazvi
        WaPlUqL638WVf7m64/Wju/JXlQeG1/CYdGPqaiuNz1cLjcZvJatca2EJBATe+n+/HmQFZpka31RHc
        1TTqA83FyVoOQVMp6JQmCK3H60huUFX5CSKuH6+kWzWw34nwc4XSEwWYs05ZKgDWTxCUqmy/eMePN
        /3lJzlYa/2k1wvnzgCh3VhHcWwwRDQ9W5J8QfqLOMGQ9wj26lDK2QgrGQvkq9rgKl88YNwgH2P2dT
        yaTGEuaSaeU4FtYpFEchBoWN4vLd2JqA5a4a3DwRuXhvi5a6keaSbetdQnm7Qrbr5jO0uOHMy/e7a
        eShLMozA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m44wV-003YjQ-0A; Thu, 15 Jul 2021 17:14:49 +0000
Date:   Thu, 15 Jul 2021 18:14:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YPBs+hcxo31JanPM@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPBal2dhY+Rv3APB@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPBal2dhY+Rv3APB@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:56:07AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Jul 15, 2021 at 04:34:46AM +0100, Matthew Wilcox (Oracle) wrote:
> > Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> > benefit from a larger "page size".  As an example, an earlier iteration
> > of this idea which used compound pages (and wasn't particularly tuned)
> > got a 7% performance boost when compiling the kernel.
> > 
> > Using compound pages or THPs exposes a weakness of our type system.
> > Functions are often unprepared for compound pages to be passed to them,
> > and may only act on PAGE_SIZE chunks.  Even functions which are aware of
> > compound pages may expect a head page, and do the wrong thing if passed
> > a tail page.
> > 
> > We also waste a lot of instructions ensuring that we're not looking at
> > a tail page.  Almost every call to PageFoo() contains one or more hidden
> > calls to compound_head().  This also happens for get_page(), put_page()
> > and many more functions.
> > 
> > This patch series uses a new type, the struct folio, to manage memory.
> > It converts enough of the page cache, iomap and XFS to use folios instead
> > of pages, and then adds support for multi-page folios.  It passes xfstests
> > (running on XFS) with no regressions compared to v5.14-rc1.
> 
> Hey Willy,
> 
> I must confess I've lost the thread of the plot in terms of how you
> hope to get the Memory folio work merged upstream.  There are some
> partial patch sets that just have the mm core, and then there were
> some larger patchsets include some in the past which as I recall,
> would touch ext4 (but which isn't in this set).
> 
> I was wondering if you could perhaps post a roadmap for how this patch
> set might be broken up, and which subsections you were hoping to
> target for the upcoming merge window versus the following merge
> windows.

Hi Ted!  Great questions.  This particular incarnation of the
patch set is the one Linus asked for -- show the performance win
of using compound pages in the page cache.  I think of this patchset
as having six parts:

1-32: core; introduce struct folio, get/put, flags
33-50: memcg
51-89: page cache, part 1
90-107: block + iomap
108-124: page cache, part 2
125-138: actually use compound pages in the page cache

I'm hoping to get the first three parts (patches 1-89) into the
next merge window.  That gets us to the point where filesystems
can start to use folios themselves (ie it does the initial Amdahl
step and then everything else can happen in parallel)

> Also I assume that for file systems that aren't converted to use
> Folios, there won't be any performance regressions --- is that
> correct?  Or is that something we need to watch for?  Put another way,
> if we don't land all of the memory folio patches before the end of the
> calendar year, and we cut an LTS release with some file systems
> converted and some file systems not yet converted, are there any
> potential problems in that eventuality?

I suppose I can't guarantee that there will be no performance
regressions as a result (eg 5899593f51e6 was a regression that
was seen as a result of some of the prep work for folios), but
I do not anticipate any for unconverted filesystems.  There might
be a tiny performance penalty for supporting arbitrary-order pages
instead of just orders 0 and 9, but I haven't seen anything to
suggest it's noticable.  I would expect to see a tiny performance
win from removing all the compound_head() calls in the VFS core.

I have a proposal in to Plumbers filesystem track where I intend to
go over all the ways I'm going to want filesystems to change to take
advantage of folios.  I think that will be a good venue to discuss how
to handle buffer_head based filesystems in a multi-page folio world.

I wouldn't expect anything to have to change before the end of the year.
I only have four patches in my extended tree which touch ext4, and
they're all in the context of making treewide changes to all
filesystems:
 - Converting ->set_page_dirty to ->dirty_folio,
 - Converting ->invalidatepage to ->invalidate_folio,
 - Converting ->readpage to ->read_folio,
 - Changing readahead_page() to readahead_folio()

None of those patches are in great shape at this point, and I wouldn't ask
anyone to review them.  I am anticipating that some filesystems will never
be converted to multi-page folios (although all filesystems should be
converted to single-page folios so we can remove the folio compat code).
