Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88809FCFFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKNU7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 15:59:17 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46010 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbfKNU7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:59:17 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 972823A19FB;
        Fri, 15 Nov 2019 07:59:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVMCu-0003MN-5U; Fri, 15 Nov 2019 07:59:12 +1100
Date:   Fri, 15 Nov 2019 07:59:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/28] mm: factor shrinker work calculations
Message-ID: <20191114205912.GD4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-12-david@fromorbit.com>
 <20191104152939.GB10665@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104152939.GB10665@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=XO7XY2mVLG3Fmeu3Gs4A:9
        a=FyWulrztHRHRZgDo:21 a=54HOyl8hHVm350sv:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:29:39AM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:46:01AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Start to clean up the shrinker code by factoring out the calculation
> > that determines how much work to do. This separates the calculation
> > from clamping and other adjustments that are done before the
> > shrinker work is run. Document the scan batch size calculation
> > better while we are there.
> > 
> > Also convert the calculation for the amount of work to be done to
> > use 64 bit logic so we don't have to keep jumping through hoops to
> > keep calculations within 32 bits on 32 bit systems.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> 
> I assume the kbuild warning thing will be fixed up...
> 
> >  mm/vmscan.c | 97 ++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 70 insertions(+), 27 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a215d71d9d4b..2d39ec37c04d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -459,13 +459,68 @@ EXPORT_SYMBOL(unregister_shrinker);
> >  
> >  #define SHRINK_BATCH 128
> >  
> > +/*
> > + * Calculate the number of new objects to scan this time around. Return
> > + * the work to be done. If there are freeable objects, return that number in
> > + * @freeable_objects.
> > + */
> > +static int64_t shrink_scan_count(struct shrink_control *shrinkctl,
> > +			    struct shrinker *shrinker, int priority,
> > +			    int64_t *freeable_objects)
> > +{
> > +	int64_t delta;
> > +	int64_t freeable;
> > +
> > +	freeable = shrinker->count_objects(shrinker, shrinkctl);
> > +	if (freeable == 0 || freeable == SHRINK_EMPTY)
> > +		return freeable;
> > +
> > +	if (shrinker->seeks) {
> > +		/*
> > +		 * shrinker->seeks is a measure of how much IO is required to
> > +		 * reinstantiate the object in memory. The default value is 2
> > +		 * which is typical for a cold inode requiring a directory read
> > +		 * and an inode read to re-instantiate.
> > +		 *
> > +		 * The scan batch size is defined by the shrinker priority, but
> > +		 * to be able to bias the reclaim we increase the default batch
> > +		 * size by 4. Hence we end up with a scan batch multipler that
> > +		 * scales like so:
> > +		 *
> > +		 * ->seeks	scan batch multiplier
> > +		 *    1		      4.00x
> > +		 *    2               2.00x
> > +		 *    3               1.33x
> > +		 *    4               1.00x
> > +		 *    8               0.50x
> > +		 *
> > +		 * IOWs, the more seeks it takes to pull the item into cache,
> > +		 * the smaller the reclaim scan batch. Hence we put more reclaim
> > +		 * pressure on caches that are fast to repopulate and to keep a
> > +		 * rough balance between caches that have different costs.
> > +		 */
> > +		delta = freeable >> (priority - 2);
> 
> Does anything prevent priority < 2 here?

Nope. I regularly see priority 1 here when the OOM killer is about
to strike. Doesn't appear to have caused any problems - the scan
counts have all come out correct (i.e. ends up as a >> 0) according
to the tracing, but I'll fix this up to avoid hitting this.

> 
> > -		delta = freeable >> priority;
> > -		delta *= 4;
> > -		do_div(delta, shrinker->seeks);
> > -	} else {
> > -		/*
> > -		 * These objects don't require any IO to create. Trim
> > -		 * them aggressively under memory pressure to keep
> > -		 * them from causing refetches in the IO caches.
> > -		 */
> > -		delta = freeable / 2;
> > -	}
> > -
> > -	total_scan += delta;
> > +	total_scan = nr + scan_count;
> >  	if (total_scan < 0) {
> >  		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
> >  		       shrinker->scan_objects, total_scan);
> > -		total_scan = freeable;
> > +		total_scan = scan_count;
> 
> Same question as before: why the change in assignment? freeable was the
> ->count_objects() return value, which is now stored in freeable_objects.

we don't want to try to free the entire cache on an 64-bit integer
overflow. scan_count is the work we calculated we need to do this
shrinker invocation, so if we overflow because of other factors then
we should just do the work we need to do in this scan.

> FWIW, the change seems to make sense in that it just factors out the
> deferred count, but it's not clear if it's intentional...

It was intentional.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
