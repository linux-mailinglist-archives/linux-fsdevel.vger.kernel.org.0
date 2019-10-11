Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED32D4B2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 01:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfJKXsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 19:48:47 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45374 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbfJKXsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:48:46 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id AB2E843E987;
        Sat, 12 Oct 2019 10:48:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJ4eI-0007vr-61; Sat, 12 Oct 2019 10:48:42 +1100
Date:   Sat, 12 Oct 2019 10:48:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 00/26] mm, xfs: non-blocking inode reclaim
Message-ID: <20191011234842.GQ16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191011190305.towurweq7gsah4vr@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011190305.towurweq7gsah4vr@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=IMRDL8WTpDAPNSytgmYA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 03:03:08PM -0400, Josef Bacik wrote:
> On Wed, Oct 09, 2019 at 02:20:58PM +1100, Dave Chinner wrote:
> > Hi folks,
> > 
> > This is the second version of the RFC I originally posted here:
> > 
> > https://lore.kernel.org/linux-xfs/20190801021752.4986-1-david@fromorbit.com/
> > 
> > The original description of the patchset is below, the issues and
> > approach to solving them has not changed. THere is some
> > restructuring of the patch set - the first few patches are all the
> > XFS fixes that can be merged regardless of the rest of the patchset,
> > but the non-blocking reclaim is somewhat dependent of them for
> > correct behaviour. The second set of patches are the shrinker
> > infrastructure changes needed for the shrinkers to feed back
> > reclaim progress to the main reclaim instructure and act on the
> > feedback. The last set of patches are the XFS changes needed to
> > convert inode reclaim over to a non-blocking, IO-less algorithm.
> 
> I looked through the MM patches and other than the congestion thing they look
> reasonable.  I think I can probably use this stuff to drop the use of the btree
> inode.  However I'm wondering if it would be a good idea to add an explicit
> backoff thing for heavy metadata dirty'ing operations.  Btrfs generates a lot
> more dirty metadata than most, partly why my attempt to deal with this was tied
> to using balance dirty pages since it already has all of the backoff logic.

That's an orthorgonal problem, I think. We still need the IO-less
reclaim in XFS regardless of how we throttle build up of dirty
metadata...

> Perhaps an explict balance_dirty_metadata() that we put after all
> metadata operations so we have a good way to throttle dirtiers
> when we aren't able to keep up?  Just a thought, based on my
> previous experiences trying to tackle this issue for btrfs, what
> you've done already may be enough to address these concerns.

The biggest issue is that different filesystems need different
mechanisms for throttling dirty metadata build-up. In ext4/XFS, the
amount of dirty metadata is bound by the log size, but that can
still be massively more metadata than the disk subsystem can handle
in a finite time.

IOWs, for XFS, the way to throttle dirty metadata buildup is to
limit the amount of log space we allow the filesystem to use when we
are able to throttle incoming transaction reservations. Nothing in
the VFS/mm subsystem can see any of this inside XFS, so I'm not
really sure how generic we could make a metadata dirtying throttle
implementation....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
