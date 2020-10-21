Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12F295500
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507006AbgJUXE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 19:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507003AbgJUXE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:04:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6DBC0613CE;
        Wed, 21 Oct 2020 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TpsthbD3koAAJ+9i1h4tChG9Qdt7aV7hAviInSK0j8w=; b=msWwivM0eP4XcBH4werP4uWZ3K
        jfPUkLMw/LuNJevgVg0pz703Bd+YI6wtaRd7au/GBYYWIRNZqqTNHQDI8D2UJRo7I/l4TeM/pEgj8
        gf5atUXz0E6iEAdi1tQmgr0fIJxybe9d+6uY+vKk02a4B636XVcIHLHcMBBDD80qI/I+CIoV4AU8k
        e80Ok3IdnCQA33Xhvh53ZSteZ7uBMIjDxZUAtnpzVBDkRDusQDjlIfQ6+aQCIpD6KMYpPtWmakzG7
        OgqJ6BPPr6dS0/rYN32DNzgdXjM211rJVaLuPWkeT7DQ4G6xycfnjsKTevvOBfY7qB94vXsOSrMGs
        wPvGMEYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVN9a-0000Af-Bh; Wed, 21 Oct 2020 23:04:22 +0000
Date:   Thu, 22 Oct 2020 00:04:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201021230422.GP20115@casper.infradead.org>
References: <20201020014357.GW20115@casper.infradead.org>
 <20201020045928.GO7391@dread.disaster.area>
 <20201020112138.GZ20115@casper.infradead.org>
 <20201020211634.GQ7391@dread.disaster.area>
 <20201020225331.GE20115@casper.infradead.org>
 <20201021221435.GR7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021221435.GR7391@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 09:14:35AM +1100, Dave Chinner wrote:
> On Tue, Oct 20, 2020 at 11:53:31PM +0100, Matthew Wilcox wrote:
> > True, we don't _have to_ split THP on holepunch/truncation/... but it's
> > a better implementation to free pages which cover blocks that no longer
> > have data associated with them.
> 
> "Better" is a very subjective measure. What numbers do you have
> to back that up?

None.  When we choose to use a THP, we're choosing to treat a chunk
of a file as a single unit for the purposes of tracking dirtiness,
age, membership of the workingset, etc.  We're trading off reduced
precision for reduced overhead; just like the CPU tracks dirtiness on
a cacheline basis instead of at byte level.

So at some level, we've making the assumption that this 128kB THP is
all one thingand it should be tracked together.  But the user has just
punched a hole in it.  I can think of no stronger signal to say "The
piece before this hole, the piece I just got rid of and the piece after
this are three separate pieces of the file".

If I could split them into pieces that weren't single pages, I would.
Zi Yan has a patch to do just that, and I'm very much looking forward
to that being merged.  But saying "Oh, this is quite small, I'll keep
the rest of the THP together" is conceptually wrong.

> > Splitting the page instead of throwing it away makes sense once we can
> > transfer the Uptodate bits to each subpage.  If we don't have that,
> > it doesn't really matter which we do.
> 
> Sounds like more required functionality...

I'm not saying that my patchset is the last word and there will be no
tweaking.  I'm saying I think it's good enough, an improvement on the
status quo, and it's better to merge it for 5.11 than to keep it out of
tree for another three months while we tinker with improving it.

Do you disagree?
