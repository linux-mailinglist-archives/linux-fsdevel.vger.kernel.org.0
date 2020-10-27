Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8262029A421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 06:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505873AbgJ0Fbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 01:31:32 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46182 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505870AbgJ0Fbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:31:31 -0400
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1C0923A936B;
        Tue, 27 Oct 2020 16:31:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kXHZu-004mIO-TP; Tue, 27 Oct 2020 16:31:26 +1100
Date:   Tue, 27 Oct 2020 16:31:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201027053126.GY7391@dread.disaster.area>
References: <20201020014357.GW20115@casper.infradead.org>
 <20201020045928.GO7391@dread.disaster.area>
 <20201020112138.GZ20115@casper.infradead.org>
 <20201020211634.GQ7391@dread.disaster.area>
 <20201020225331.GE20115@casper.infradead.org>
 <20201021221435.GR7391@dread.disaster.area>
 <20201021230422.GP20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021230422.GP20115@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=7-415B0cAAAA:8
        a=CvBOQ0YqrXvA0BptNmkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:04:22AM +0100, Matthew Wilcox wrote:
> On Thu, Oct 22, 2020 at 09:14:35AM +1100, Dave Chinner wrote:
> > On Tue, Oct 20, 2020 at 11:53:31PM +0100, Matthew Wilcox wrote:
> > > True, we don't _have to_ split THP on holepunch/truncation/... but it's
> > > a better implementation to free pages which cover blocks that no longer
> > > have data associated with them.
> > 
> > "Better" is a very subjective measure. What numbers do you have
> > to back that up?
> 
> None.  When we choose to use a THP, we're choosing to treat a chunk
> of a file as a single unit for the purposes of tracking dirtiness,
> age, membership of the workingset, etc.  We're trading off reduced
> precision for reduced overhead; just like the CPU tracks dirtiness on
> a cacheline basis instead of at byte level.
> 
> So at some level, we've making the assumption that this 128kB THP is
> all one thingand it should be tracked together.  But the user has just
> punched a hole in it.  I can think of no stronger signal to say "The
> piece before this hole, the piece I just got rid of and the piece after
> this are three separate pieces of the file".

There's a difference between the physical layout of the file and
representing data efficiently in the page cache. Just because we can
use a THP to represent a single extent doesn't mean we should always
use that relationship, nor should we require that small
manipulations of on-disk extent state require that page cache pages
be split or gathered.

i.e. the whole point of the page cache is to decouple the physical
layout of the file from the user access mechanisms for performance
reasons, not tie them tightly together. I think that's the wrong
approach to be taking here - truncate/holepunch do not imply that
THPs need to be split unconditionally. Indeed, readahead doesn't
care that a THP might be split across mulitple extents and require
multiple bios to bring tha data into cache, so why should
truncate/holepunch type operations require the THP to be split to
reflect underlying disk layouts?

> If I could split them into pieces that weren't single pages, I would.
> Zi Yan has a patch to do just that, and I'm very much looking forward
> to that being merged.  But saying "Oh, this is quite small, I'll keep
> the rest of the THP together" is conceptually wrong.

Yet that's exactly what we do with block size < PAGE_SIZE
configurations, so I fail to see why it's conceptually wrong for
THPs to behave the same way and normal pages....

> > > Splitting the page instead of throwing it away makes sense once we can
> > > transfer the Uptodate bits to each subpage.  If we don't have that,
> > > it doesn't really matter which we do.
> > 
> > Sounds like more required functionality...
> 
> I'm not saying that my patchset is the last word and there will be no
> tweaking.  I'm saying I think it's good enough, an improvement on the
> status quo, and it's better to merge it for 5.11 than to keep it out of
> tree for another three months while we tinker with improving it.
> 
> Do you disagree?

In part. Concepts and algorithms need to be sound and agreed upon
before we merge patches, and right now I disagree with the some of
the basic assumptions about how THP and filesystem layout operations
are being coupled. That part needs to be sorted before stuff gets
merged...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
