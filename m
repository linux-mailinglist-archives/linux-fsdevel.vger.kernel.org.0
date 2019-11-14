Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E540FD026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 22:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKNVLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 16:11:55 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33970 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbfKNVLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:11:54 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 37AD943EA9F;
        Fri, 15 Nov 2019 08:11:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVMP8-0003Oh-7P; Fri, 15 Nov 2019 08:11:50 +1100
Date:   Fri, 15 Nov 2019 08:11:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/28] shrinker: defer work only to kswapd
Message-ID: <20191114211150.GE4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-13-david@fromorbit.com>
 <20191104152954.GC10665@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104152954.GC10665@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=5X_tDGEKKelVXH1UxT4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:29:54AM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:46:02AM +1100, Dave Chinner wrote:
> > @@ -601,10 +605,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	 * scanning at high prio and therefore should try to reclaim as much as
> >  	 * possible.
> >  	 */
> > -	while (total_scan >= batch_size ||
> > -	       total_scan >= freeable_objects) {
> > +	while (scan_count >= batch_size ||
> > +	       scan_count >= freeable_objects) {
> >  		unsigned long ret;
> > -		unsigned long nr_to_scan = min(batch_size, total_scan);
> > +		unsigned long nr_to_scan = min_t(long, batch_size, scan_count);
> >  
> >  		shrinkctl->nr_to_scan = nr_to_scan;
> >  		shrinkctl->nr_scanned = nr_to_scan;
> > @@ -614,29 +618,29 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  		freed += ret;
> >  
> >  		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
> > -		total_scan -= shrinkctl->nr_scanned;
> > -		scanned += shrinkctl->nr_scanned;
> > +		scan_count -= shrinkctl->nr_scanned;
> > +		scanned_objects += shrinkctl->nr_scanned;
> >  
> >  		cond_resched();
> >  	}
> > -
> >  done:
> > -	if (next_deferred >= scanned)
> > -		next_deferred -= scanned;
> > +	if (deferred_count)
> > +		next_deferred = deferred_count - scanned_objects;
> >  	else
> > -		next_deferred = 0;
> > +		next_deferred = scan_count;
> 
> Hmm.. so if there was no deferred count on this cycle, we set
> next_deferred to whatever is left from scan_count and add that back into
> the shrinker struct below. If there was a pending deferred count on this
> cycle, we subtract what we scanned from that and add that value back.
> But what happens to the remaining scan_count in the latter case? Is it
> lost, or am I missing something?

if deferred_count is not zero, then it is kswapd that is running. It
does the deferred work, and if it doesn't make progress then adding
it's scan count to the deferred work doesn't matter. That's because
it will come back with an increased priority in a short while and
try to scan more of the deferred count plus it's larger scan count.

IOWs, if we defer kswapd unused scan count, we effectively increase
the pressure as the priority goes up, potentially making the
deferred count increase out of control. i.e. kswapd can make
progress and free items, but the result is that it increased the
deferred scan count rather than reducing it. This leads to excessive
reclaim of the slab caches and kswapd can trash the caches long
after the memory pressure has gone away...

> For example, suppose we start this cycle with a large scan_count and
> ->scan_objects() returned SHRINK_STOP before doing much work. In that
> scenario, it looks like whether ->nr_deferred is 0 or not is the only
> thing that determines whether we defer the entire remaining scan_count
> or just what is left from the previous ->nr_deferred. The existing code
> appears to consistently factor in what is left from the current scan
> with the previous deferred count. Hm?

If kswapd doesn't have any deferred work, then it's largely no
different in behaviour to direct reclaim. If it has no deferred
work, then the shrinker is not getting stopped early in direct
reclaim, so it's unlikely that kswapd is going to get stopped early,
either....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
