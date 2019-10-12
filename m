Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588B3D4F88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfJLMIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 08:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27953 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbfJLMIi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 08:08:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74F582BFDD;
        Sat, 12 Oct 2019 12:08:38 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D666F5D6C8;
        Sat, 12 Oct 2019 12:08:37 +0000 (UTC)
Date:   Sat, 12 Oct 2019 08:08:36 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/26] xfs: synchronous AIL pushing
Message-ID: <20191012120836.GB3307@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-17-david@fromorbit.com>
 <20191011101825.GA29171@infradead.org>
 <20191011152945.GH61257@bfoster>
 <20191011232716.GO16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011232716.GO16973@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 12 Oct 2019 12:08:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 12, 2019 at 10:27:16AM +1100, Dave Chinner wrote:
> On Fri, Oct 11, 2019 at 11:29:45AM -0400, Brian Foster wrote:
> > On Fri, Oct 11, 2019 at 03:18:25AM -0700, Christoph Hellwig wrote:
> > > On Wed, Oct 09, 2019 at 02:21:14PM +1100, Dave Chinner wrote:
> > > > Factor the common AIL deletion code that does all the wakeups into a
> > > > helper so we only have one copy of this somewhat tricky code to
> > > > interface with all the wakeups necessary when the LSN of the log
> > > > tail changes.
> > > > 
> > > > xfs_ail_push_sync() is temporary infrastructure to facilitate
> > > > non-blocking, IO-less inode reclaim throttling that allows further
> > > > structural changes to be made. Once those structural changes are
> > > > made, the need for this function goes away and it is removed,
> > > > leaving us with only the xfs_ail_update_finish() factoring when this
> > > > is all done.
> > > 
> > > The xfs_ail_update_finish work here is in an earlier patch, so the
> > > changelog will need some updates.
> > > 
> > > > +	spin_lock(&ailp->ail_lock);
> > > > +	while ((lip = xfs_ail_min(ailp)) != NULL) {
> > > > +		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> > > > +		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> > > > +		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
> > 
> > Wasn't this supposed to change to < 0? The rfc series had that logic,
> > but it changed from <= to < later in the wrong patch.
> 
> I probably forgot because this code gets removed at the end of the
> series. Hence I haven't cared about exact correctness of neatness
> as it's just temporary scaffolding to keep stuff from breaking
> horribly as the changeover to non-blocking algorithms is done.
> 
> It works well enough that I can't break it as it stands - I've
> tested each patch individually with both load and fstests, and so
> this code as it stands doesn't introduce any bisect landmines - it
> prevents a bunch of problems in OOM conditions by retaining the
> blocking behaviour of reclaim until we no longer need it...
> 

Ok, I guess I forgot that this was temporary. FWIW, I think it's worth
fixing the small things like this comparison and the couple things
Christoph points out, if nothing else to facilitate review. Disregard
the larger refactoring feedback..

Brian

> > > > +			break;
> > > > +		/* XXX: cmpxchg? */
> > > > +		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> > > > +			xfs_trans_ail_copy_lsn(ailp, &ailp->ail_target, &threshold_lsn);
> > > 
> > > This code looks broken on 32-bit given that xfs_trans_ail_copy_lsn takes
> > > the ail_lock there.  Just replacing the xfs_trans_ail_copy_lsn call with
> > > a direct assignment would fix that, no need for cmpxchg either as far
> > > as I can tell (and it would fix that too long line as well).
> 
> Oh, right. I'll fix that.
> 
> > > still looks odd, I think this should simply be an if. 
> > > 
> > > > +		wake_up_process(ailp->ail_task);
> > > > +		spin_unlock(&ailp->ail_lock);
> > > 
> > > xfsaild will take ail_lock pretty quickly.  I think we should drop
> > > the lock before waking it.
> > 
> > Can't we replace this whole thing with something that repurposes
> > xfs_ail_push_all_sync()? That only requires some tweaks to the existing
> > function and the new _push_all_sync() wrapper ends up looking something
> > like:
> > 
> > 	while ((threshold_lsn = xfs_ail_max_lsn(ailp)) != 0)
> > 		xfs_ail_push_sync(ailp, threshold_lsn);
> > 
> > There's an extra lock cycle, but that's still only on tail updates. That
> > doesn't seem unreasonable to me for the usage of _push_all_sync().
> 
> The whole thing goes away, so there is zero point in trying to
> optimise or perfect this code. It's temporary code, treat it as
> such.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
