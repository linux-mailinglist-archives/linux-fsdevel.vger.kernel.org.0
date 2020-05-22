Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79A51DDD8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 04:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEVC57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 22:57:59 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:58249 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgEVC57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 22:57:59 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 9E70FD59A09;
        Fri, 22 May 2020 12:57:55 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jbxsd-0002Cn-Gu; Fri, 22 May 2020 12:57:51 +1000
Date:   Fri, 22 May 2020 12:57:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] Large pages in the page cache
Message-ID: <20200522025751.GX2005@dread.disaster.area>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200521224906.GU2005@dread.disaster.area>
 <20200522000411.GI28818@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522000411.GI28818@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=7-415B0cAAAA:8
        a=Eun5lWKXtKsMZPUNUOgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 05:04:11PM -0700, Matthew Wilcox wrote:
> On Fri, May 22, 2020 at 08:49:06AM +1000, Dave Chinner wrote:
> > Ok, so the main issue I have with the filesystem/iomap side of
> > things is that it appears to be adding "transparent huge page"
> > awareness to the filesysetm code, not "large page support".
> > 
> > For people that aren't aware of the difference between the
> > transparent huge and and a normal compound page (e.g. I have no idea
> > what the difference is), this is likely to cause problems,
> > especially as you haven't explained at all in this description why
> > transparent huge pages are being used rather than bog standard
> > compound pages.
> 
> The primary reason to use a different name from compound_*
> is so that it can be compiled out for systems that don't enable
> CONFIG_TRANSPARENT_HUGEPAGE.  So THPs are compound pages, as they always
> have been, but for a filesystem, using thp_size() will compile to either
> page_size() or PAGE_SIZE depending on CONFIG_TRANSPARENT_HUGEPAGE.

Again, why is this dependent on THP? We can allocate compound pages
without using THP, so why only allow the page cache to use larger
pages when THP is configured?

i.e. I don't know why this is dependent on THP because you haven't
explained why this only works for THP and not just plain old
compound pages....

> Now, maybe thp_size() is the wrong name, but then you need to suggest
> a better name ;-)

First you need to explain why THP is requirement for large pages in
the page cache when most of the code changes I see only care if the
page is a compound page or not....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
