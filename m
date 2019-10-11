Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4AFD4ADF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 01:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJKXUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 19:20:37 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33931 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbfJKXUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:20:37 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1835C36268A;
        Sat, 12 Oct 2019 10:20:33 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJ4D3-0007jx-0D; Sat, 12 Oct 2019 10:20:33 +1100
Date:   Sat, 12 Oct 2019 10:20:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 14/26] mm: back off direct reclaim on excessive shrinker
 deferral
Message-ID: <20191011232032.GN16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-15-david@fromorbit.com>
 <20191011162105.GU32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011162105.GU32665@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=JuDxSlhT3OO6blO4plAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:21:05AM -0700, Matthew Wilcox wrote:
> On Wed, Oct 09, 2019 at 02:21:12PM +1100, Dave Chinner wrote:
> > +			if ((reclaim_state->deferred_objects >
> > +					sc->nr_scanned - nr_scanned) &&
> > +			    (reclaim_state->deferred_objects >
> > +					reclaim_state->scanned_objects)) {
> > +				wait_iff_congested(BLK_RW_ASYNC, HZ/50);
> 
> Unfortunately, Jens broke wait_iff_congested() recently, and doesn't plan
> to fix it.  We need to come up with another way to estimate congestion.

I know, all the ways the block layer is broken are right there in
the cover letter at the end of the v1 patchset description from
more than 2 months ago.

When people work out how to fix congestion detection and backoff
again, this can be updated at the same time.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
