Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9337B410E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhITBGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 21:06:18 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:33268 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbhITBGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 21:06:18 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id AE8CB98D5;
        Mon, 20 Sep 2021 11:04:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mS7jj-00ETf4-GT; Mon, 20 Sep 2021 11:04:47 +1000
Date:   Mon, 20 Sep 2021 11:04:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210920010447.GU2361455@dread.disaster.area>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210918010440.GK1756565@dread.disaster.area>
 <YUVwZpTEuqhITGaJ@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUVwZpTEuqhITGaJ@moria.home.lan>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=St-ALpV-QOArFpp15CwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 12:51:50AM -0400, Kent Overstreet wrote:
> On Sat, Sep 18, 2021 at 11:04:40AM +1000, Dave Chinner wrote:
> > As for long term, everything in the page cache API needs to
> > transition to byte offsets and byte counts instead of units of
> > PAGE_SIZE and page->index. That's a more complex transition, but
> > AFAIA that's part of the future work Willy is intended to do with
> > folios and the folio API. Once we get away from accounting and
> > tracking everything as units of struct page, all the public facing
> > APIs that use those units can go away.
> 
> Probably 95% of the places we use page->index and page->mapping aren't necessary
> because we've already got that information from the context we're in and
> removing them would be a useful cleanup

*nod*

> - if we've already got that from context
> (e.g. we're looking up the page in the page cache, via i_pageS) eliminating the
> page->index or page->mapping use means we're getting rid of a data dependency so
> it's good for performance - but more importantly, those (much fewer) places in
> the code where we actually _do_ need page->index and page->mapping are really
> important places to be able to find because they're interesting boundaries
> between different components in the VM.

*nod*

This is where infrastructure like like write_cache_pages() is
problematic.  It's not actually a component of the VM - it's core
page cache/filesystem API functionality - but the implementation is
determined by the fact there is no clear abstraction between the
page cache and the VM and so while the filesysetm side of the API is
byte-ranged based, the VM side is struct page based and so the
impedence mismatch has to be handled in the page cache
implementation.

Folios are definitely pointing out issues like this whilst, IMO,
demonstrating that an abstraction like folios are also a necessary
first step to address the problems they make obvious...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
