Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5316D64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEGWEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 18:04:54 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51602 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbfEGWEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 18:04:54 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0A508105F850;
        Wed,  8 May 2019 08:04:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hO8Cg-0004uQ-1H; Wed, 08 May 2019 08:04:50 +1000
Date:   Wed, 8 May 2019 08:04:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
Message-ID: <20190507220449.GP1454@dread.disaster.area>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=cBRT43P-7hDb3wOkE_MA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
> 
> (repost without the html spam, sorry!)
> 
> Last week at LSF/MM, I suggested we can provide a tool or test suite to test
> discard performance.
> 
> Put in the most positive light, it will be useful for drive vendors to use
> to qualify their offerings before sending them out to the world. For
> customers that care, they can use the same set of tests to help during
> selection to weed out any real issues.
> 
> Also, community users can run the same tools of course and share the
> results.

My big question here is this:

- is "discard" even relevant for future devices?

i.e. before we start saying "we want discard to not suck", perhaps
we should list all the specific uses we ahve for discard, what we
expect to occur, and whether we have better interfaces than
"discard" to acheive that thing.

Indeed, we have fallocate() on block devices now, which means we
have a well defined block device space management API for clearing
and removing allocated block device space. i.e.:

	FALLOC_FL_ZERO_RANGE: Future reads from the range must
	return zero and future writes to the range must not return
	ENOSPC. (i.e. must remain allocated space, can physically
	write zeros to acheive this)

	FALLOC_FL_PUNCH_HOLE: Free the backing store and guarantee
	future reads from the range return zeroes. Future writes to
	the range may return ENOSPC. This operation fails if the
	underlying device cannot do this operation without
	physically writing zeroes.

	FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE: run a
	discard on the range and provide no guarantees about the
	result. It may or may not do anything, and a subsequent read
	could return anything at all.

IMO, trying to "optimise discard" is completely the wrong direction
to take. We should be getting rid of "discard" and it's interfaces
operations - deprecate the ioctls, fix all other kernel callers of
blkdev_issue_discard() to call blkdev_fallocate() and ensure that
drive vendors understand that they need to make FALLOC_FL_ZERO_RANGE
and FALLOC_FL_PUNCH_HOLE work, and that FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_NO_HIDE_STALE is deprecated (like discard) and will be
going away.

So, can we just deprecate blkdev_issue_discard and all the
interfaces that lead to it as a first step?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
