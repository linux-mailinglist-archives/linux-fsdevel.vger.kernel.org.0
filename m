Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B487ECA5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 22:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfKAVko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 17:40:44 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43735 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbfKAVko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:40:44 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DBCB03A0834;
        Sat,  2 Nov 2019 08:40:40 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQeeu-0006bm-DO; Sat, 02 Nov 2019 08:40:40 +1100
Date:   Sat, 2 Nov 2019 08:40:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/28] xfs: Throttle commits on delayed background CIL
 push
Message-ID: <20191101214040.GX4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-3-david@fromorbit.com>
 <20191101120426.GC59146@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101120426.GC59146@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=0MiyBbjkrBVIBRQmzFcA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 08:04:26AM -0400, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:45:52AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > In certain situations the background CIL push can be indefinitely
> > delayed. While we have workarounds from the obvious cases now, it
> > doesn't solve the underlying issue. This issue is that there is no
> > upper limit on the CIL where we will either force or wait for
> > a background push to start, hence allowing the CIL to grow without
> > bound until it consumes all log space.
> > 
> > To fix this, add a new wait queue to the CIL which allows background
> > pushes to wait for the CIL context to be switched out. This happens
> > when the push starts, so it will allow us to block incoming
> > transaction commit completion until the push has started. This will
> > only affect processes that are running modifications, and only when
> > the CIL threshold has been significantly overrun.
> > 
> > This has no apparent impact on performance, and doesn't even trigger
> > until over 45 million inodes had been created in a 16-way fsmark
> > test on a 2GB log. That was limiting at 64MB of log space used, so
> > the active CIL size is only about 3% of the total log in that case.
> > The concurrent removal of those files did not trigger the background
> > sleep at all.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > ---
> 
> I don't recall posting an R-b tag for this one...

Argh, sorry. I must have screwed up transcribing them from the
mailing list.

> That said, I think my only outstanding feedback (side discussion aside)
> was the code factoring in xlog_cil_push_background().

I'll go back and look at that, 'cause clearly I was looking at the
wrong patch when I screwed up the rvb tag...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
