Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE65972206
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 00:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392327AbfGWWLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 18:11:49 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:49837 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731838AbfGWWLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:11:49 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E2B522AA6CE;
        Wed, 24 Jul 2019 08:11:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hq2zU-0003lk-Ea; Wed, 24 Jul 2019 08:10:36 +1000
Date:   Wed, 24 Jul 2019 08:10:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: annotate refault stalls from IO submission
Message-ID: <20190723221036.GY7777@dread.disaster.area>
References: <20190722201337.19180-1-hannes@cmpxchg.org>
 <20190723000226.GV7777@dread.disaster.area>
 <20190723190438.GA22541@cmpxchg.org>
 <2d80cfdb-f5e0-54f1-29a3-a05dee5b94eb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d80cfdb-f5e0-54f1-29a3-a05dee5b94eb@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=RvhrQjGMwq6Bl1CCUxgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:34:50PM -0600, Jens Axboe wrote:
> On 7/23/19 1:04 PM, Johannes Weiner wrote:
> > CCing Jens for bio layer stuff
> > 
> > On Tue, Jul 23, 2019 at 10:02:26AM +1000, Dave Chinner wrote:
> >> Even better: If this memstall and "refault" check is needed to
> >> account for bio submission blocking, then page cache iteration is
> >> the wrong place to be doing this check. It should be done entirely
> >> in the bio code when adding pages to the bio because we'll only ever
> >> be doing page cache read IO on page cache misses. i.e. this isn't
> >> dependent on adding a new page to the LRU or not - if we add a new
> >> page then we are going to be doing IO and so this does not require
> >> magic pixie dust at the page cache iteration level
> > 
> > That could work. I had it at the page cache level because that's
> > logically where the refault occurs. But PG_workingset encodes
> > everything we need from the page cache layer and is available where
> > the actual stall occurs, so we should be able to push it down.
> > 
> >> e.g. bio_add_page_memstall() can do the working set check and then
> >> set a flag on the bio to say it contains a memstall page. Then on
> >> submission of the bio the memstall condition can be cleared.
> > 
> > A separate bio_add_page_memstall() would have all the problems you
> > pointed out with the original patch: it's magic, people will get it
> > wrong, and it'll be hard to verify and notice regressions.
> > 
> > How about just doing it in __bio_add_page()? PG_workingset is not
> > overloaded - when we see it set, we can generally and unconditionally
> > flag the bio as containing userspace workingset pages.
> > 
> > At submission time, in conjunction with the IO direction, we can
> > clearly tell whether we are reloading userspace workingset data,
> > i.e. stalling on memory.
> > 
> > This?
> 
> Not vehemently opposed to it, even if it sucks having to test page flags
> in the hot path.

That's kinda why I suggested the bio_add_page_memstall() variant for
the page cache read IO paths where this check would be required.

Not fussed either way, this is much cleaner and easier to maintain
IMO....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
