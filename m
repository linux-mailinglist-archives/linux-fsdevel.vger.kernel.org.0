Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3C29AB90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 13:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750867AbgJ0MOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 08:14:51 -0400
Received: from casper.infradead.org ([90.155.50.34]:39428 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbgJ0MOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QsKMGecGq9Or2BsBvxuQRWoxGfvn0O5yuvLyglZO3vY=; b=hDle2mjA+YsHd4CAjzM6MZhiKX
        CkWha5NPOK4eTYVR8ucIlAt2qQd1zievHtI2Sm2ALPknCoGF3cpw0LFUIRXCe4+3d0OpNHlOSqWjh
        WCDHqRe/mzFVBPBtHG8kUCathxaBYPJsvgFEzia1U2c2WWc4zidevQVldDRJBVM5Atjvmbj538fV8
        mgpvCTWwpsqHh6jNg+3tMYeFs8IDzi6o9DUTWqUADWlt4jg58wyHFFIOBRLPwaQncctsHcRhyiWzN
        gJe040ZJT6Ax6nT2OvrSENn30ntLF7TFG3dRIvEGMXWffCaoddmxYGB7L9E4fkxQKdkrRo5+HwCZu
        YZLrgXSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXNsF-0008H6-NI; Tue, 27 Oct 2020 12:14:47 +0000
Date:   Tue, 27 Oct 2020 12:14:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201027121447.GV20115@casper.infradead.org>
References: <20201020014357.GW20115@casper.infradead.org>
 <20201020045928.GO7391@dread.disaster.area>
 <20201020112138.GZ20115@casper.infradead.org>
 <20201020211634.GQ7391@dread.disaster.area>
 <20201020225331.GE20115@casper.infradead.org>
 <20201021221435.GR7391@dread.disaster.area>
 <20201021230422.GP20115@casper.infradead.org>
 <20201027053126.GY7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027053126.GY7391@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:31:26PM +1100, Dave Chinner wrote:
> On Thu, Oct 22, 2020 at 12:04:22AM +0100, Matthew Wilcox wrote:
> > On Thu, Oct 22, 2020 at 09:14:35AM +1100, Dave Chinner wrote:
> > > On Tue, Oct 20, 2020 at 11:53:31PM +0100, Matthew Wilcox wrote:
> > > > True, we don't _have to_ split THP on holepunch/truncation/... but it's
> > > > a better implementation to free pages which cover blocks that no longer
> > > > have data associated with them.
> > > 
> > > "Better" is a very subjective measure. What numbers do you have
> > > to back that up?
> > 
> > None.  When we choose to use a THP, we're choosing to treat a chunk
> > of a file as a single unit for the purposes of tracking dirtiness,
> > age, membership of the workingset, etc.  We're trading off reduced
> > precision for reduced overhead; just like the CPU tracks dirtiness on
> > a cacheline basis instead of at byte level.
> > 
> > So at some level, we've making the assumption that this 128kB THP is
> > all one thingand it should be tracked together.  But the user has just
> > punched a hole in it.  I can think of no stronger signal to say "The
> > piece before this hole, the piece I just got rid of and the piece after
> > this are three separate pieces of the file".
> 
> There's a difference between the physical layout of the file and
> representing data efficiently in the page cache. Just because we can
> use a THP to represent a single extent doesn't mean we should always
> use that relationship, nor should we require that small
> manipulations of on-disk extent state require that page cache pages
> be split or gathered.
> 
> i.e. the whole point of the page cache is to decouple the physical
> layout of the file from the user access mechanisms for performance
> reasons, not tie them tightly together. I think that's the wrong
> approach to be taking here - truncate/holepunch do not imply that
> THPs need to be split unconditionally. Indeed, readahead doesn't
> care that a THP might be split across mulitple extents and require
> multiple bios to bring tha data into cache, so why should
> truncate/holepunch type operations require the THP to be split to
> reflect underlying disk layouts?

At the time we do readahead, we've inferred from the user's access
patterns that they're reading this file if not sequentially, then close
enough to sequentially that it makes sense to bring in more of the file.
On-media layout of the file is irrelevant, as you say.

Now the user has given us another hint about how they see the file.
A call to FALLOC_FL_PUNCH_HOLE is certainly an instruction to the
filesystem to change the layout, but it's also giving the page cache
information about how the file is being treated.  It tells us that
the portion of the file before the hole is different from the portion
of the file after the hole, and treating those two portions of the
file as being similar for the purposes of working set tracking is
going to lead to wrong decisions.

Let's take an example where an app uses 1kB fixed size records.  First it
does a linear scan (so readahead kicks in and we get all the way up to
allocating 256kB pages).  Then it decides some records are obsolete, so it
calls PUNCH_HOLE on the range 20kB to 27kB in the page, then PUNCH_HOLE
40kB-45kB and finally PUNCH_HOLE 150kB-160kB.  In my current scheme,
this splits the page into 4kB pages.  If the app then only operates on
the records after 160kB and before 20kB, the pages used to cache records
in the 24kB-40kB and 44kB-150kB ranges will naturally fall out of cache
and the memory will be used for other purposes.  With your scheme,
the 256kB page would be retained in cache as a single piece.

> > If I could split them into pieces that weren't single pages, I would.
> > Zi Yan has a patch to do just that, and I'm very much looking forward
> > to that being merged.  But saying "Oh, this is quite small, I'll keep
> > the rest of the THP together" is conceptually wrong.
> 
> Yet that's exactly what we do with block size < PAGE_SIZE
> configurations, so I fail to see why it's conceptually wrong for
> THPs to behave the same way and normal pages....

We don't have the ability to mmap files at smaller than PAGE_SIZE
granularity, so we can't do that.

> > I'm not saying that my patchset is the last word and there will be no
> > tweaking.  I'm saying I think it's good enough, an improvement on the
> > status quo, and it's better to merge it for 5.11 than to keep it out of
> > tree for another three months while we tinker with improving it.
> > 
> > Do you disagree?
> 
> In part. Concepts and algorithms need to be sound and agreed upon
> before we merge patches, and right now I disagree with the some of
> the basic assumptions about how THP and filesystem layout operations
> are being coupled. That part needs to be sorted before stuff gets
> merged...

They're not being coupled.  I'm using the information the user is
giving the kernel to make better decisions about what to cache.
