Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40783ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 23:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHFVMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 17:12:17 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50840 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726869AbfHFVMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:12:17 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BFB9F360F14;
        Wed,  7 Aug 2019 07:12:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hv6ja-000529-Mq; Wed, 07 Aug 2019 07:11:06 +1000
Date:   Wed, 7 Aug 2019 07:11:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/24] xfs: tail updates only need to occur when LSN
 changes
Message-ID: <20190806211106.GG7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-15-david@fromorbit.com>
 <20190805175325.GD14760@bfoster>
 <20190805232826.GZ7777@dread.disaster.area>
 <20190806053338.GD7777@dread.disaster.area>
 <20190806125321.GC2979@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806125321.GC2979@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=7LOOWS8BD3-zdqQ4NSgA:9
        a=0SBu78-PGVJL_xDw:21 a=18nxT3l6xtBxF0ub:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:53:21AM -0400, Brian Foster wrote:
> On Tue, Aug 06, 2019 at 03:33:38PM +1000, Dave Chinner wrote:
> > On Tue, Aug 06, 2019 at 09:28:26AM +1000, Dave Chinner wrote:
> > > On Mon, Aug 05, 2019 at 01:53:26PM -0400, Brian Foster wrote:
> > > > On Thu, Aug 01, 2019 at 12:17:42PM +1000, Dave Chinner wrote:
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > > We currently wake anything waiting on the log tail to move whenever
> > > > > the log item at the tail of the log is removed. Historically this
> > > > > was fine behaviour because there were very few items at any given
> > > > > LSN. But with delayed logging, there may be thousands of items at
> > > > > any given LSN, and we can't move the tail until they are all gone.
> > > > > 
> > > > > Hence if we are removing them in near tail-first order, we might be
> > > > > waking up processes waiting on the tail LSN to change (e.g. log
> > > > > space waiters) repeatedly without them being able to make progress.
> > > > > This also occurs with the new sync push waiters, and can result in
> > > > > thousands of spurious wakeups every second when under heavy direct
> > > > > reclaim pressure.
> > > > > 
> > > > > To fix this, check that the tail LSN has actually changed on the
> > > > > AIL before triggering wakeups. This will reduce the number of
> > > > > spurious wakeups when doing bulk AIL removal and make this code much
> > > > > more efficient.
> > > > > 
> > > > > XXX: occasionally get a temporary hang in xfs_ail_push_sync() with
> > > > > this change - log force from log worker gets things moving again.
> > > > > Only happens under extreme memory pressure - possibly push racing
> > > > > with a tail update on an empty log. Needs further investigation.
> > > > > 
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > > 
> > > > Ok, this addresses the wakeup granularity issue mentioned in the
> > > > previous patch. Note that I was kind of wondering why we wouldn't base
> > > > this on the l_tail_lsn update in xlog_assign_tail_lsn_locked() as
> > > > opposed to the current approach.
> > > 
> > > Because I didn't think of it? :)
> > > 
> > > There's so much other stuff in this patch set I didn't spend a
> > > lot of time thinking about other alternatives. this was a simple
> > > code transformation that did what I wanted, and I went on to burning
> > > brain cells on other more complex issues that needs to be solved...
> > > 
> > > > For example, xlog_assign_tail_lsn_locked() could simply check the
> > > > current min item against the current l_tail_lsn before it does the
> > > > assignment and use that to trigger tail change events. If we wanted to
> > > > also filter out the other wakeups (as this patch does) then we could
> > > > just pass a bool pointer or something that returns whether the tail
> > > > actually changed.
> > > 
> > > Yeah, I'll have a look at this - I might rework it as additional
> > > patches now the code is looking at decisions based on LSN rather
> > > than if the tail log item changed...
> > 
> > Ok, this is not worth the complexity. The wakeup code has to be able
> > to tell the difference between a changed tail lsn and an empty AIL
> > so that wakeups can be issued when the AIL is finally emptied.
> > Unmount (xfs_ail_push_all_sync()) relies on this, and
> > xlog_assign_tail_lsn_locked() hides the empty AIL from the caller
> > by returning log->l_last_sync_lsn to the caller.
> > 
> 
> Wouldn't either case just be a wakeup from xlog_assign_tail_lsn_locked()
> (which should probably be renamed if we took that approach)? It's called
> when we've removed the min item from the AIL and so potentially need to
> update the tail lsn. 

Not easily, because xlog_assign_tail_lsn_locked() is also used to
grab the current tail when we are formatting the log header during a
CIL checkpoint. We do not want to be doing wakeups there.

And, to tell the truth, I don't really want to screw with a function
that provides on-disk information for log recovery in this
series. That brings a whole new level of jeopardy to this patch set
I'd prefer to avoid....

> > Hence the wakeup code still has to check for an empty AIL if the
> > tail has changed if we use the return value of
> > xlog_assign_tail_lsn_locked() as the tail LSN. At which point, the
> > logic becomes somewhat convoluted, and it's far simpler to use
> > __xfs_ail_min_lsn as it returns when the log is empty.
> > 
> > So, nice idea, but it doesn't make the code simpler or easier to
> > understand....
> 
> It's not that big of a deal either way. BTW on another quick look, I
> think something like xfs_ail_update_tail(ailp, old_tail) is a bit more
> self-documenting that xfs_ail_delete_finish(ailp, old_lsn).

I had already renamed it to xfs_ail_update_finish() when I updated
the last patch to include the bulk update case.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
