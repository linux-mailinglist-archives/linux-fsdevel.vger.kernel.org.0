Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF621E1821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 01:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgEYXIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 19:08:45 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:49658 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgEYXIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 19:08:45 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id C45A7D7DFED;
        Tue, 26 May 2020 09:07:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jdMCF-0000w3-1b; Tue, 26 May 2020 09:07:51 +1000
Date:   Tue, 26 May 2020 09:07:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] Large pages in the page cache
Message-ID: <20200525230751.GZ2005@dread.disaster.area>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200521224906.GU2005@dread.disaster.area>
 <20200522000411.GI28818@bombadil.infradead.org>
 <20200522025751.GX2005@dread.disaster.area>
 <20200522030553.GK28818@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522030553.GK28818@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=7-415B0cAAAA:8
        a=A0qFvS8_A0EZQLsPnN8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 08:05:53PM -0700, Matthew Wilcox wrote:
> On Fri, May 22, 2020 at 12:57:51PM +1000, Dave Chinner wrote:
> > On Thu, May 21, 2020 at 05:04:11PM -0700, Matthew Wilcox wrote:
> > > On Fri, May 22, 2020 at 08:49:06AM +1000, Dave Chinner wrote:
> > > > Ok, so the main issue I have with the filesystem/iomap side of
> > > > things is that it appears to be adding "transparent huge page"
> > > > awareness to the filesysetm code, not "large page support".
> > > > 
> > > > For people that aren't aware of the difference between the
> > > > transparent huge and and a normal compound page (e.g. I have no idea
> > > > what the difference is), this is likely to cause problems,
> > > > especially as you haven't explained at all in this description why
> > > > transparent huge pages are being used rather than bog standard
> > > > compound pages.
> > > 
> > > The primary reason to use a different name from compound_*
> > > is so that it can be compiled out for systems that don't enable
> > > CONFIG_TRANSPARENT_HUGEPAGE.  So THPs are compound pages, as they always
> > > have been, but for a filesystem, using thp_size() will compile to either
> > > page_size() or PAGE_SIZE depending on CONFIG_TRANSPARENT_HUGEPAGE.
> > 
> > Again, why is this dependent on THP? We can allocate compound pages
> > without using THP, so why only allow the page cache to use larger
> > pages when THP is configured?
> 
> We have too many CONFIG options.  My brain can't cope with adding
> CONFIG_LARGE_PAGES because then we might have neither THP nor LP, LP and
> not THP, THP and not LP or both THP and LP.  And of course HUGETLBFS,
> which has its own special set of issues that one has to think about when
> dealing with the page cache.

That sounds like something that should be fixed. :/

Really, I don't care about the historical mechanisms that people can
configure large pages with. If the mm subsystem does not have a
unified abstraction and API for working with large pages, then that
is the first problem that needs to be addressed before other
subsystems start trying to use large pages. 

i.e. a filesystem developer doesn't care how the mm subsystem is
allocating/managing large pages, we just want to be able to treat
large pages exactly the same way as we treat single pages. There
should be exactly zero difference between them at the API level.

> So, either large pages becomes part of the base kernel and you
> always get them, or there's a CONFIG option to enable them and it's
> CONFIG_TRANSPARENT_HUGEPAGE.  I chose the latter.

Please make the API part of the base kernel. Then you can hide all
these whacky mm level config options behind it so that code that
interacts with large pages just doesn't have to care about what type
of large page infrastructure the user has configured.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
