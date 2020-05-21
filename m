Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B651DDA82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgEUWtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 18:49:11 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59461 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730690AbgEUWtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 18:49:11 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 480C282078A;
        Fri, 22 May 2020 08:49:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jbtzu-0000hq-Ta; Fri, 22 May 2020 08:49:06 +1000
Date:   Fri, 22 May 2020 08:49:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] Large pages in the page cache
Message-ID: <20200521224906.GU2005@dread.disaster.area>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=2DAmyFJ7tbF1Kr5hZtcA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:20AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This patch set does not pass xfstests.  Test at your own risk.  It is
> based on the readahead rewrite which is in Andrew's tree.  I've fixed a
> lot of issues in the last two weeks, but generic/013 will still crash it.
> 
> The primary idea here is that a large part of the overhead in dealing
> with individual pages is that there's just so darned many of them.
> We would be better off dealing with fewer, larger pages, even if they
> don't get to be the size necessary for the CPU to use a larger TLB entry.

Ok, so the main issue I have with the filesystem/iomap side of
things is that it appears to be adding "transparent huge page"
awareness to the filesysetm code, not "large page support".

For people that aren't aware of the difference between the
transparent huge and and a normal compound page (e.g. I have no idea
what the difference is), this is likely to cause problems,
especially as you haven't explained at all in this description why
transparent huge pages are being used rather than bog standard
compound pages.

And, really, why should iomap or the filesystems care if the large
page is a THP or just a high order compound page? The interface
for operating on these things at the page cache level should be the
same. We already have page_size() and friends for operating on
high order compound pages, yet the iomap stuff has this new
thp_size() function instead of just using page_size(). THis is going
to lead to confusion and future bugs when people who don't know the
difference use the wrong page size function in their filesystem
code.

So, really, the "large page" API presented to the filesystems via
the page cache needs to be unified. Having to use compound_*() in
some places, thp_* in others, then page_* and Page*, not to mention
hpage_* just so that we can correctly support "large pages" is a
total non-starter.

Hence I'd suggest that this patch set needs to start by "hiding" all
the differences between different types of pages behind a unified,
consistent API, then it can introduce large page support into code
outside the mm/ infrastructure via that unified API. I don't care
what that API looks like so long as it is clear, consistenti, well
documented and means filesystem developers don't need to know
anything about how the page (large or not) is managed by the mm
subsystem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
