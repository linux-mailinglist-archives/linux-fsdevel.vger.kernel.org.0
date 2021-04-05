Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB5354727
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbhDETbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhDETbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 15:31:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723CFC061756;
        Mon,  5 Apr 2021 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9SOtYaB8J8ELKMq0M1tuMmaAg1MyhsZCJsmHDday9kQ=; b=FEj9ROtIshiEtAvBdohBD7kcWv
        nRYVdS2KhJ0FXYGdhwKjpk6One/ypCjkmuRXSg4uvk6SHi9BDvelqoRxmae6pmxutye1xGe1qM2Yi
        c4ql44HXFUTVHnmCZJmuQRtBrl8HjSrzqMGk7HI9mnYY3FdPseqiliBLHqzPbSWI2m6n9+i+zaUNP
        87JrxNKRJiTWzEV8BfXuz9MstUK5yJrd/8CfDPVjCb0eVrx+7ZBg8ozDLvCA33vyeFT+YneqiCFZg
        x34uhmHpqQneEVp38h+wysnFwQ6bWmk3prX7/fEIOW2CthpJmw9XWtCgxRjwkP8wUlZDaaKAb4ve8
        0IRm1RJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTUwS-00BnIa-8v; Mon, 05 Apr 2021 19:31:28 +0000
Date:   Mon, 5 Apr 2021 20:31:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210405193120.GL2531743@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <759cfbb63ca960b2893f2b879035c2a42c80462d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <759cfbb63ca960b2893f2b879035c2a42c80462d.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 05, 2021 at 03:14:29PM -0400, Jeff Layton wrote:
> On Wed, 2021-03-31 at 19:47 +0100, Matthew Wilcox (Oracle) wrote:
> > Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> > exist which show the benefits of a larger "page size".  As an example,
> > an earlier iteration of this idea which used compound pages got a 7%
> > performance boost when compiling the kernel using kernbench without any
> > particular tuning.
> > 
> > Using compound pages or THPs exposes a serious weakness in our type
> > system.  Functions are often unprepared for compound pages to be passed
> > to them, and may only act on PAGE_SIZE chunks.  Even functions which are
> > aware of compound pages may expect a head page, and do the wrong thing
> > if passed a tail page.
> > 
> > There have been efforts to label function parameters as 'head' instead
> > of 'page' to indicate that the function expects a head page, but this
> > leaves us with runtime assertions instead of using the compiler to prove
> > that nobody has mistakenly passed a tail page.  Calling a struct page
> > 'head' is also inaccurate as they will work perfectly well on base pages.
> > The term 'nottail' has not proven popular.
> > 
> > We also waste a lot of instructions ensuring that we're not looking at
> > a tail page.  Almost every call to PageFoo() contains one or more hidden
> > calls to compound_head().  This also happens for get_page(), put_page()
> > and many more functions.  There does not appear to be a way to tell gcc
> > that it can cache the result of compound_head(), nor is there a way to
> > tell it that compound_head() is idempotent.
> > 
> > This series introduces the 'struct folio' as a replacement for
> > head-or-base pages.  This initial set reduces the kernel size by
> > approximately 5kB by removing conversions from tail pages to head pages.
> > The real purpose of this series is adding infrastructure to enable
> > further use of the folio.
> > 
> > The medium-term goal is to convert all filesystems and some device
> > drivers to work in terms of folios.  This series contains a lot of
> > explicit conversions, but it's important to realise it's removing a lot
> > of implicit conversions in some relatively hot paths.  There will be very
> > few conversions from folios when this work is completed; filesystems,
> > the page cache, the LRU and so on will generally only deal with folios.
> 
> I too am a little concerned about the amount of churn this is likely to
> cause, but this does seem like a fairly promising way forward for
> actually using THPs in the pagecache. The set is fairly straightforward.
> 
> That said, there are few callers of these new functions in here. Is this
> set enough to allow converting some subsystem to use folios? It might be
> good to do that if possible, so we can get an idea of how much work
> we're in for.

It isn't enough to start converting much.  There needs to be a second set
of patches which add all the infrastructure for converting a filesystem.
Then we can start working on the filesystems.  I have a start at that
here:

https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

I don't know if it's exactly how I'll arrange it for submission.  It might
be better to convert all the filesystem implementations of readpage
to work on a folio, and then the big bang conversion of ->readpage to
->read_folio will look much more mechanical.

But if I can't convince people that a folio approach is what we need,
then I should stop working on it, and go back to fixing the endless
stream of bugs that the thp-based approach surfaces.
