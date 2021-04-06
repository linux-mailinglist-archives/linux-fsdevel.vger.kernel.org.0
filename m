Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD20355779
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbhDFPOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 11:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhDFPOh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0DD561363;
        Tue,  6 Apr 2021 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617722069;
        bh=6EwsObpnkQ5Dfea7gjpKREYGxQADGcmpX2jhvrqCVvk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RmKRdevffH/BmKSNQGh8I3FH7lztg+9RgJlXEMubNtq2LQkdqPgIeqiVpbeayXjli
         /xc6m1DPIBswndDuw4IpuYW+rmFX8Gmnzzz4yPefsAH4bidLENQzjFxrxJAlb+sEbp
         ci7sLQ9BOrfpLkOJSHCexaG187bddwVLzZPXL6VtaT+kfVnjk7SG3VGGOrS0GpNR18
         xJQC7fZqH4wECX+Aqv411LxhfSIDzc/Wu9YM2aj2oRvWvOBYkV2WgHHW2Pj+3a7cLE
         r80lUzz3K/EoqaLeXjfNG6yDImXu30o7KlQWWw8WZ2zLbcTlJMTaUk2g4qXImv6PQJ
         yTJl7LqN1KYaQ==
Message-ID: <fa4fa9fc7236ff4a5f582ead8df4fd12ce08057d.camel@kernel.org>
Subject: Re: [PATCH v6 00/27] Memory Folios
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Date:   Tue, 06 Apr 2021 11:14:27 -0400
In-Reply-To: <20210405193120.GL2531743@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
         <759cfbb63ca960b2893f2b879035c2a42c80462d.camel@kernel.org>
         <20210405193120.GL2531743@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-04-05 at 20:31 +0100, Matthew Wilcox wrote:
> On Mon, Apr 05, 2021 at 03:14:29PM -0400, Jeff Layton wrote:
> > On Wed, 2021-03-31 at 19:47 +0100, Matthew Wilcox (Oracle) wrote:
> > > Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> > > exist which show the benefits of a larger "page size".  As an example,
> > > an earlier iteration of this idea which used compound pages got a 7%
> > > performance boost when compiling the kernel using kernbench without any
> > > particular tuning.
> > > 
> > > Using compound pages or THPs exposes a serious weakness in our type
> > > system.  Functions are often unprepared for compound pages to be passed
> > > to them, and may only act on PAGE_SIZE chunks.  Even functions which are
> > > aware of compound pages may expect a head page, and do the wrong thing
> > > if passed a tail page.
> > > 
> > > There have been efforts to label function parameters as 'head' instead
> > > of 'page' to indicate that the function expects a head page, but this
> > > leaves us with runtime assertions instead of using the compiler to prove
> > > that nobody has mistakenly passed a tail page.  Calling a struct page
> > > 'head' is also inaccurate as they will work perfectly well on base pages.
> > > The term 'nottail' has not proven popular.
> > > 
> > > We also waste a lot of instructions ensuring that we're not looking at
> > > a tail page.  Almost every call to PageFoo() contains one or more hidden
> > > calls to compound_head().  This also happens for get_page(), put_page()
> > > and many more functions.  There does not appear to be a way to tell gcc
> > > that it can cache the result of compound_head(), nor is there a way to
> > > tell it that compound_head() is idempotent.
> > > 
> > > This series introduces the 'struct folio' as a replacement for
> > > head-or-base pages.  This initial set reduces the kernel size by
> > > approximately 5kB by removing conversions from tail pages to head pages.
> > > The real purpose of this series is adding infrastructure to enable
> > > further use of the folio.
> > > 
> > > The medium-term goal is to convert all filesystems and some device
> > > drivers to work in terms of folios.  This series contains a lot of
> > > explicit conversions, but it's important to realise it's removing a lot
> > > of implicit conversions in some relatively hot paths.  There will be very
> > > few conversions from folios when this work is completed; filesystems,
> > > the page cache, the LRU and so on will generally only deal with folios.
> > 
> > I too am a little concerned about the amount of churn this is likely to
> > cause, but this does seem like a fairly promising way forward for
> > actually using THPs in the pagecache. The set is fairly straightforward.
> > 
> > That said, there are few callers of these new functions in here. Is this
> > set enough to allow converting some subsystem to use folios? It might be
> > good to do that if possible, so we can get an idea of how much work
> > we're in for.
> 
> It isn't enough to start converting much.  There needs to be a second set
> of patches which add all the infrastructure for converting a filesystem.
> Then we can start working on the filesystems.  I have a start at that
> here:
> 
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio
> 
> I don't know if it's exactly how I'll arrange it for submission.  It might
> be better to convert all the filesystem implementations of readpage
> to work on a folio, and then the big bang conversion of ->readpage to
> ->read_folio will look much more mechanical.
> 
> But if I can't convince people that a folio approach is what we need,
> then I should stop working on it, and go back to fixing the endless
> stream of bugs that the thp-based approach surfaces.

Fair enough. I generally prefer to see some callers added at the same
time as new functions, but I understand that the scale of this patchset
makes that difficult. You can add this to the whole series. I don't see
any major show-stoppers here:

Acked-by: Jeff Layton <jlayton@kernel.org>

