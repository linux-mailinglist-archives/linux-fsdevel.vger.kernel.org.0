Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4B2EF945
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 21:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbhAHUd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 15:33:27 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:53169 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729251AbhAHUd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:33:27 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id EFAD17655CD;
        Sat,  9 Jan 2021 07:32:43 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kxyR7-004R24-RS; Sat, 09 Jan 2021 07:32:41 +1100
Date:   Sat, 9 Jan 2021 07:32:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210108203241.GI331610@dread.disaster.area>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210106225201.GF331610@dread.disaster.area>
 <20210106234009.b6gbzl7bjm2evxj6@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106234009.b6gbzl7bjm2evxj6@alap3.anarazel.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=wut9VHP1pO6yiD9O2Z4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:40:09PM -0800, Andres Freund wrote:
> Hi,
> 
> On 2021-01-07 09:52:01 +1100, Dave Chinner wrote:
> > On Tue, Dec 29, 2020 at 10:28:19PM -0800, Andres Freund wrote:
> > > Which brings me to $subject:
> > > 
> > > Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
> > > doesn't convert extents into unwritten extents, but instead uses
> > > blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
> > > myself, but ...
> > 
> > We have explicit requests from users (think initialising large VM
> > images) that FALLOC_FL_ZERO_RANGE must never fall back to writing
> > zeroes manually.
> 
> That behaviour makes a lot of sense for quite a few use cases - I wasn't
> trying to make it sound like it should not be available. Nor that
> FALLOC_FL_ZERO_RANGE should behave differently.
> 
> 
> > IOWs, while you might want FALLOC_FL_ZERO_RANGE to explicitly write
> > zeros, we have users who explicitly don't want it to do this.
> 
> Right - which is why I was asking for a variant of FALLOC_FL_ZERO_RANGE
> (jokingly named FALLOC_FL_ZERO_RANGE_BUT_REALLY in the subject), rather
> than changing the behaviour.
> 
> 
> > Perhaps we should add want FALLOC_FL_CONVERT_RANGE, which tells the
> > filesystem to convert an unwritten range of zeros to a written range
> > by manually writing zeros. i.e. you do FALLOC_FL_ZERO_RANGE to zero
> > the range and fill holes using metadata manipulation, followed by
> > FALLOC_FL_WRITE_RANGE to then convert the "metadata zeros" to real
> > written zeros.
> 
> Yep, something like that would do the trick. Perhaps
> FALLOC_FL_MATERIALIZE_RANGE?

[ FWIW, I really dislike the "RANGE" part of fallocate flag names.
It's redundant (fallocate always operates on a range!) and just
makes names unnecessarily longer. ]

I used "convert range" as the name explicitly because it has
specific meaning for extent space manipulation. i.e. we "convert"
extents from one state to another. "write range" is also has
explicit meaning, in that it will convert extents from unwritten to
written data.

In comparison, "materialise" is something undefined, and could be
easily thought to take something ephemeral (such as a hole) and turn
it into something real (an allocated extent). We wouldn't want this
operation to allocate space, so I think "materialise" is just too
much magic to encoding into an API for an explicit, well defined
state change.

We also have people asking for ZERO_RANGE to just flip existing
extents from written to unwritten (rather than the punch/preallocate
we do now). This is also a "convert" operation, just in the other
direction (from data to zeros rather than from zeros to data).

The observation I'm making here is that these "convert" oeprations
will both makes SEEK_HOLE/SEEK_DATA behave differently for the
underlying data. preallocated space is considered a HOLE, written
zeros are considered DATA. So we do expose the ability to check that
a "convert" operation has actually changed the state of the
underlying extents in either direction...

CONVERT_TO_DATA/CONVERT_TO_ZERO as an operational pair whose
behaviour is visible and easily testable via SEEK_HOLE/SEEK_DATA
makes a lot more sense to me. Also defining them to fail fast if
unwritten extents are not supported by the filesystem (i.e. they
should -never- physically write anything) would also allow
applications to fall back to ZERO_RANGE on filesystems that don't
support unwritten extents to explicitly write zeros if
CONVERT_TO_ZERO fails....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
